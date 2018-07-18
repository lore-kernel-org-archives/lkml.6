Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC34ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBD32075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBD32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeGRNYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:24:35 -0400
Received: from nautica.notk.org ([91.121.71.147]:43786 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbeGRNYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:24:35 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 38765C009; Wed, 18 Jul 2018 14:46:47 +0200 (CEST)
Date:   Wed, 18 Jul 2018 14:46:32 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kurz <groug@kaod.org>, v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] 9p: Use a slab for allocating requests
Message-ID: <20180718124632.GA16256@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-6-willy@infradead.org>
 <20180718100554.GA21781@nautica>
 <20180718114913.GA4949@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718114913.GA4949@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Wed, Jul 18, 2018:
> I must admit to having not looked at the fcall aspect of this.  kmalloc
> is implemented in terms of slab, so it's not going to be much slower than
> using a dedicatd slab (a few instructions to figure out which slab cache
> to use).

Yeah, kmalloc-8, kmalloc-16 etc. This is fast and efficient if the
requested amount is a power of two as you said below.


> What would help is splitting the p9_fcall struct from the alloc_size.
> kmalloc is pretty effective at allocating power-of-two sized structures,
> and 8k + 32 bytes is approximately the worst case scenario.  I'd do this
> by embedding the p9_fcall into the p9_req_t and only allocating the
> msize, like this:

Good idea, I'll include something like this in my benchmarks.

I'm still worried about big allocs for bigger rdma msizes (we've had our
share of troubles with mellanox allocating some big 256k queue pairs and
failing pretty often on very memory-fragmented servers, so now that's
fixed I'd rather avoid reproducing the same kind of pattern if
possible...), but the root of the problem is that it's a scam to call
that rdma when the protocol only allows send/recv operations... I guess
this could finally be motivation to work on a v2 allowing for zero-copy
and some scatter-gather lists to allow using fragmented memory.

Thanks for the fast reply as usual.

> (I only converted client.c to the new embedded fcall way; all the
> transports also need massaging)
> 
> Regardless of whether any of the other patches go in, this patch is
> worth having; it's really wasting slab allocator memory.

The other patchs don't have anything wrong, but I agree I'd want to keep
this as well unless the numbers are really horrible.
Still needs checking, though!

> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index a4dc42c53d18..4b4ac1362ad5 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -95,8 +95,8 @@ struct p9_req_t {
>  	int status;
>  	int t_err;
>  	wait_queue_head_t wq;
> -	struct p9_fcall *tc;
> -	struct p9_fcall *rc;
> +	struct p9_fcall tc;
> +	struct p9_fcall rc;
>  	void *aux;
>  	struct list_head req_list;
>  };
> diff --git a/net/9p/client.c b/net/9p/client.c
> index ecf5dd269f4c..058dfbebdaa2 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -230,15 +230,13 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>  	return ret;
>  }
>  
> -static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
> +static int p9_fcall_alloc(struct p9_fcall *fc, int alloc_msize)
>  {
> -	struct p9_fcall *fc;
> -	fc = kmalloc(sizeof(struct p9_fcall) + alloc_msize, GFP_NOFS);
> -	if (!fc)
> -		return NULL;
> +	fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> +	if (!fc->sdata)
> +		return -ENOMEM;
>  	fc->capacity = alloc_msize;
> -	fc->sdata = (char *) fc + sizeof(struct p9_fcall);
> -	return fc;
> +	return 0;
>  }
>  
>  static struct kmem_cache *p9_req_cache;
> @@ -262,13 +260,13 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	if (!req)
>  		return NULL;
>  
> -	req->tc = p9_fcall_alloc(alloc_msize);
> -	req->rc = p9_fcall_alloc(alloc_msize);
> -	if (!req->tc || !req->rc)
> +	if (p9_fcall_alloc(&req->tc, alloc_msize))
> +		goto free;
> +	if (p9_fcall_alloc(&req->rc, alloc_msize))
>  		goto free;
>  
> -	p9pdu_reset(req->tc);
> -	p9pdu_reset(req->rc);
> +	p9pdu_reset(&req->tc);
> +	p9pdu_reset(&req->rc);
>  	req->status = REQ_STATUS_ALLOC;
>  	init_waitqueue_head(&req->wq);
>  	INIT_LIST_HEAD(&req->req_list);
> @@ -280,7 +278,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  				GFP_NOWAIT);
>  	else
>  		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
> -	req->tc->tag = tag;
> +	req->tc.tag = tag;
>  	spin_unlock_irq(&c->lock);
>  	idr_preload_end();
>  	if (tag < 0)
> @@ -289,8 +287,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	return req;
>  
>  free:
> -	kfree(req->tc);
> -	kfree(req->rc);
> +	kfree(req->tc.sdata);
> +	kfree(req->rc.sdata);
>  	kmem_cache_free(p9_req_cache, req);
>  	return ERR_PTR(-ENOMEM);
>  }
> @@ -329,14 +327,14 @@ EXPORT_SYMBOL(p9_tag_lookup);
>  static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
>  {
>  	unsigned long flags;
> -	u16 tag = r->tc->tag;
> +	u16 tag = r->tc.tag;
>  
>  	p9_debug(P9_DEBUG_MUX, "clnt %p req %p tag: %d\n", c, r, tag);
>  	spin_lock_irqsave(&c->lock, flags);
>  	idr_remove(&c->reqs, tag);
>  	spin_unlock_irqrestore(&c->lock, flags);
> -	kfree(r->tc);
> -	kfree(r->rc);
> +	kfree(r->tc.sdata);
> +	kfree(r->rc.sdata);
>  	kmem_cache_free(p9_req_cache, r);
>  }
>  
> @@ -368,7 +366,7 @@ static void p9_tag_cleanup(struct p9_client *c)
>   */
>  void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>  {
> -	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc->tag);
> +	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc.tag);
>  
>  	/*
>  	 * This barrier is needed to make sure any change made to req before
> @@ -378,7 +376,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>  	req->status = status;
>  
>  	wake_up(&req->wq);
> -	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc->tag);
> +	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
>  }
>  EXPORT_SYMBOL(p9_client_cb);
>  
> @@ -448,12 +446,12 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  	int err;
>  	int ecode;
>  
> -	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
> +	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
>  	/*
>  	 * dump the response from server
>  	 * This should be after check errors which poplulate pdu_fcall.
>  	 */
> -	trace_9p_protocol_dump(c, req->rc);
> +	trace_9p_protocol_dump(c, &req->rc);
>  	if (err) {
>  		p9_debug(P9_DEBUG_ERROR, "couldn't parse header %d\n", err);
>  		return err;
> @@ -463,7 +461,7 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  
>  	if (!p9_is_proto_dotl(c)) {
>  		char *ename;
> -		err = p9pdu_readf(req->rc, c->proto_version, "s?d",
> +		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
>  				  &ename, &ecode);
>  		if (err)
>  			goto out_err;
> @@ -479,7 +477,7 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  		}
>  		kfree(ename);
>  	} else {
> -		err = p9pdu_readf(req->rc, c->proto_version, "d", &ecode);
> +		err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
>  		err = -ecode;
>  
>  		p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
> @@ -513,12 +511,12 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
>  	int8_t type;
>  	char *ename = NULL;
>  
> -	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
> +	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
>  	/*
>  	 * dump the response from server
>  	 * This should be after parse_header which poplulate pdu_fcall.
>  	 */
> -	trace_9p_protocol_dump(c, req->rc);
> +	trace_9p_protocol_dump(c, &req->rc);
>  	if (err) {
>  		p9_debug(P9_DEBUG_ERROR, "couldn't parse header %d\n", err);
>  		return err;
> @@ -533,13 +531,13 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
>  		/* 7 = header size for RERROR; */
>  		int inline_len = in_hdrlen - 7;
>  
> -		len =  req->rc->size - req->rc->offset;
> +		len = req->rc.size - req->rc.offset;
>  		if (len > (P9_ZC_HDR_SZ - 7)) {
>  			err = -EFAULT;
>  			goto out_err;
>  		}
>  
> -		ename = &req->rc->sdata[req->rc->offset];
> +		ename = &req->rc.sdata[req->rc.offset];
>  		if (len > inline_len) {
>  			/* We have error in external buffer */
>  			if (!copy_from_iter_full(ename + inline_len,
> @@ -549,7 +547,7 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
>  			}
>  		}
>  		ename = NULL;
> -		err = p9pdu_readf(req->rc, c->proto_version, "s?d",
> +		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
>  				  &ename, &ecode);
>  		if (err)
>  			goto out_err;
> @@ -565,7 +563,7 @@ static int p9_check_zc_errors(struct p9_client *c, struct p9_req_t *req,
>  		}
>  		kfree(ename);
>  	} else {
> -		err = p9pdu_readf(req->rc, c->proto_version, "d", &ecode);
> +		err = p9pdu_readf(&req->rc, c->proto_version, "d", &ecode);
>  		err = -ecode;
>  
>  		p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
> @@ -598,7 +596,7 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
>  	int16_t oldtag;
>  	int err;
>  
> -	err = p9_parse_header(oldreq->tc, NULL, NULL, &oldtag, 1);
> +	err = p9_parse_header(&oldreq->tc, NULL, NULL, &oldtag, 1);
>  	if (err)
>  		return err;
>  
> @@ -642,12 +640,12 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>  		return req;
>  
>  	/* marshall the data */
> -	p9pdu_prepare(req->tc, req->tc->tag, type);
> -	err = p9pdu_vwritef(req->tc, c->proto_version, fmt, ap);
> +	p9pdu_prepare(&req->tc, req->tc.tag, type);
> +	err = p9pdu_vwritef(&req->tc, c->proto_version, fmt, ap);
>  	if (err)
>  		goto reterr;
> -	p9pdu_finalize(c, req->tc);
> -	trace_9p_client_req(c, type, req->tc->tag);
> +	p9pdu_finalize(c, &req->tc);
> +	trace_9p_client_req(c, type, req->tc.tag);
>  	return req;
>  reterr:
>  	p9_free_req(c, req);
> @@ -732,7 +730,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  		goto reterr;
>  
>  	err = p9_check_errors(c, req);
> -	trace_9p_client_res(c, type, req->rc->tag, err);
> +	trace_9p_client_res(c, type, req->rc.tag, err);
>  	if (!err)
>  		return req;
>  reterr:
> @@ -814,7 +812,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  		goto reterr;
>  
>  	err = p9_check_zc_errors(c, req, uidata, in_hdrlen);
> -	trace_9p_client_res(c, type, req->rc->tag, err);
> +	trace_9p_client_res(c, type, req->rc.tag, err);
>  	if (!err)
>  		return req;
>  reterr:
> @@ -897,10 +895,10 @@ static int p9_client_version(struct p9_client *c)
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	err = p9pdu_readf(req->rc, c->proto_version, "ds", &msize, &version);
> +	err = p9pdu_readf(&req->rc, c->proto_version, "ds", &msize, &version);
>  	if (err) {
>  		p9_debug(P9_DEBUG_9P, "version error %d\n", err);
> -		trace_9p_protocol_dump(c, req->rc);
> +		trace_9p_protocol_dump(c, &req->rc);
>  		goto error;
>  	}
>  
> @@ -1049,9 +1047,9 @@ struct p9_fid *p9_client_attach(struct p9_client *clnt, struct p9_fid *afid,
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", &qid);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", &qid);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_free_req(clnt, req);
>  		goto error;
>  	}
> @@ -1106,9 +1104,9 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "R", &nwqids, &wqids);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "R", &nwqids, &wqids);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_free_req(clnt, req);
>  		goto clunk_fid;
>  	}
> @@ -1173,9 +1171,9 @@ int p9_client_open(struct p9_fid *fid, int mode)
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "Qd", &qid, &iounit);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "Qd", &qid, &iounit);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto free_and_error;
>  	}
>  
> @@ -1217,9 +1215,9 @@ int p9_client_create_dotl(struct p9_fid *ofid, const char *name, u32 flags, u32
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "Qd", qid, &iounit);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "Qd", qid, &iounit);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto free_and_error;
>  	}
>  
> @@ -1262,9 +1260,9 @@ int p9_client_fcreate(struct p9_fid *fid, const char *name, u32 perm, int mode,
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "Qd", &qid, &iounit);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "Qd", &qid, &iounit);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto free_and_error;
>  	}
>  
> @@ -1301,9 +1299,9 @@ int p9_client_symlink(struct p9_fid *dfid, const char *name,
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", qid);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", qid);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto free_and_error;
>  	}
>  
> @@ -1499,10 +1497,10 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
>  			break;
>  		}
>  
> -		*err = p9pdu_readf(req->rc, clnt->proto_version,
> +		*err = p9pdu_readf(&req->rc, clnt->proto_version,
>  				   "D", &count, &dataptr);
>  		if (*err) {
> -			trace_9p_protocol_dump(clnt, req->rc);
> +			trace_9p_protocol_dump(clnt, &req->rc);
>  			p9_free_req(clnt, req);
>  			break;
>  		}
> @@ -1572,9 +1570,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  			break;
>  		}
>  
> -		*err = p9pdu_readf(req->rc, clnt->proto_version, "d", &count);
> +		*err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &count);
>  		if (*err) {
> -			trace_9p_protocol_dump(clnt, req->rc);
> +			trace_9p_protocol_dump(clnt, &req->rc);
>  			p9_free_req(clnt, req);
>  			break;
>  		}
> @@ -1616,9 +1614,9 @@ struct p9_wstat *p9_client_stat(struct p9_fid *fid)
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "wS", &ignored, ret);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "wS", &ignored, ret);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_free_req(clnt, req);
>  		goto error;
>  	}
> @@ -1669,9 +1667,9 @@ struct p9_stat_dotl *p9_client_getattr_dotl(struct p9_fid *fid,
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "A", ret);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "A", ret);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_free_req(clnt, req);
>  		goto error;
>  	}
> @@ -1821,11 +1819,11 @@ int p9_client_statfs(struct p9_fid *fid, struct p9_rstatfs *sb)
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "ddqqqqqqd", &sb->type,
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "ddqqqqqqd", &sb->type,
>  		&sb->bsize, &sb->blocks, &sb->bfree, &sb->bavail,
>  		&sb->files, &sb->ffree, &sb->fsid, &sb->namelen);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_free_req(clnt, req);
>  		goto error;
>  	}
> @@ -1929,9 +1927,9 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
>  		err = PTR_ERR(req);
>  		goto error;
>  	}
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "q", attr_size);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "q", attr_size);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_free_req(clnt, req);
>  		goto clunk_fid;
>  	}
> @@ -2017,9 +2015,9 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
>  		goto error;
>  	}
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "D", &count, &dataptr);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "D", &count, &dataptr);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto free_and_error;
>  	}
>  	if (rsize < count) {
> @@ -2058,9 +2056,9 @@ int p9_client_mknod_dotl(struct p9_fid *fid, const char *name, int mode,
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", qid);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", qid);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RMKNOD qid %x.%llx.%x\n", qid->type,
> @@ -2089,9 +2087,9 @@ int p9_client_mkdir_dotl(struct p9_fid *fid, const char *name, int mode,
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "Q", qid);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", qid);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RMKDIR qid %x.%llx.%x\n", qid->type,
> @@ -2124,9 +2122,9 @@ int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status)
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "b", status);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "b", status);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RLOCK status %i\n", *status);
> @@ -2155,11 +2153,11 @@ int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *glock)
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "bqqds", &glock->type,
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "bqqds", &glock->type,
>  			&glock->start, &glock->length, &glock->proc_id,
>  			&glock->client_id);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RGETLOCK type %i start %lld length %lld "
> @@ -2185,9 +2183,9 @@ int p9_client_readlink(struct p9_fid *fid, char **target)
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	err = p9pdu_readf(req->rc, clnt->proto_version, "s", target);
> +	err = p9pdu_readf(&req->rc, clnt->proto_version, "s", target);
>  	if (err) {
> -		trace_9p_protocol_dump(clnt, req->rc);
> +		trace_9p_protocol_dump(clnt, &req->rc);
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RREADLINK target %s\n", *target);

-- 
Dominique
