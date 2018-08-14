Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7C9C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EB521745
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EB521745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeHNETx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:19:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbeHNETx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:19:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 030A8D7B52DCA;
        Tue, 14 Aug 2018 09:35:00 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 14 Aug 2018
 09:34:58 +0800
Subject: Re: [V9fs-developer] [PATCH 1/2] 9p: rename p9_free_req() function
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <asmadeus@codewreck.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <20180811144254.23665-1-tomasbortoli@gmail.com>
CC:     Dominique Martinet <dominique.martinet@cea.fr>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <davem@davemloft.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B72319A.7060800@huawei.com>
Date:   Tue, 14 Aug 2018 09:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180811144254.23665-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On 2018/8/11 22:42, Tomas Bortoli wrote:
> In sight of the next patch to add a refcount in p9_req_t, rename
> the p9_free_req() function in p9_release_req().
> 
> In the next patch the actual kfree will be moved to another function.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Acked-by: Jun Piao <piaojun@huawei.com>
> ---
>  net/9p/client.c | 100 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 6c57ab1294d7..7942c0bfcc5b 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -344,13 +344,13 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
>  EXPORT_SYMBOL(p9_tag_lookup);
>  
>  /**
> - * p9_free_req - Free a request.
> + * p9_tag_remove - Remove a tag.
>   * @c: Client session.
> - * @r: Request to free.
> + * @r: Request of reference.
>   *
>   * Context: Any context.
>   */
> -static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
> +static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>  {
>  	unsigned long flags;
>  	u16 tag = r->tc.tag;
> @@ -379,7 +379,7 @@ static void p9_tag_cleanup(struct p9_client *c)
>  	rcu_read_lock();
>  	idr_for_each_entry(&c->reqs, req, id) {
>  		pr_info("Tag %d still in use\n", id);
> -		p9_free_req(c, req);
> +		p9_tag_remove(c, req);
>  	}
>  	rcu_read_unlock();
>  }
> @@ -647,7 +647,7 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
>  		if (c->trans_mod->cancelled)
>  			c->trans_mod->cancelled(c, oldreq);
>  
> -	p9_free_req(c, req);
> +	p9_tag_remove(c, req);
>  	return 0;
>  }
>  
> @@ -681,7 +681,7 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>  	trace_9p_client_req(c, type, req->tc.tag);
>  	return req;
>  reterr:
> -	p9_free_req(c, req);
> +	p9_tag_remove(c, req);
>  	return ERR_PTR(err);
>  }
>  
> @@ -691,7 +691,7 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>   * @type: type of request
>   * @fmt: protocol format string (see protocol.c)
>   *
> - * Returns request structure (which client must free using p9_free_req)
> + * Returns request structure (which client must free using p9_tag_remove)
>   */
>  
>  static struct p9_req_t *
> @@ -767,7 +767,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  	if (!err)
>  		return req;
>  reterr:
> -	p9_free_req(c, req);
> +	p9_tag_remove(c, req);
>  	return ERR_PTR(safe_errno(err));
>  }
>  
> @@ -782,7 +782,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>   * @hdrlen: reader header size, This is the size of response protocol data
>   * @fmt: protocol format string (see protocol.c)
>   *
> - * Returns request structure (which client must free using p9_free_req)
> + * Returns request structure (which client must free using p9_tag_remove)
>   */
>  static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  					 struct iov_iter *uidata,
> @@ -849,7 +849,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  	if (!err)
>  		return req;
>  reterr:
> -	p9_free_req(c, req);
> +	p9_tag_remove(c, req);
>  	return ERR_PTR(safe_errno(err));
>  }
>  
> @@ -952,7 +952,7 @@ static int p9_client_version(struct p9_client *c)
>  
>  error:
>  	kfree(version);
> -	p9_free_req(c, req);
> +	p9_tag_remove(c, req);
>  
>  	return err;
>  }
> @@ -1094,7 +1094,7 @@ struct p9_fid *p9_client_attach(struct p9_client *clnt, struct p9_fid *afid,
>  	err = p9pdu_readf(&req->rc, clnt->proto_version, "Q", &qid);
>  	if (err) {
>  		trace_9p_protocol_dump(clnt, &req->rc);
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  		goto error;
>  	}
>  
> @@ -1103,7 +1103,7 @@ struct p9_fid *p9_client_attach(struct p9_client *clnt, struct p9_fid *afid,
>  
>  	memmove(&fid->qid, &qid, sizeof(struct p9_qid));
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return fid;
>  
>  error:
> @@ -1151,10 +1151,10 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
>  	err = p9pdu_readf(&req->rc, clnt->proto_version, "R", &nwqids, &wqids);
>  	if (err) {
>  		trace_9p_protocol_dump(clnt, &req->rc);
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  		goto clunk_fid;
>  	}
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RWALK nwqid %d:\n", nwqids);
>  
> @@ -1229,7 +1229,7 @@ int p9_client_open(struct p9_fid *fid, int mode)
>  	fid->iounit = iounit;
>  
>  free_and_error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1274,7 +1274,7 @@ int p9_client_create_dotl(struct p9_fid *ofid, const char *name, u32 flags, u32
>  	ofid->iounit = iounit;
>  
>  free_and_error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1319,7 +1319,7 @@ int p9_client_fcreate(struct p9_fid *fid, const char *name, u32 perm, int mode,
>  	fid->iounit = iounit;
>  
>  free_and_error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1353,7 +1353,7 @@ int p9_client_symlink(struct p9_fid *dfid, const char *name,
>  			qid->type, (unsigned long long)qid->path, qid->version);
>  
>  free_and_error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1373,7 +1373,7 @@ int p9_client_link(struct p9_fid *dfid, struct p9_fid *oldfid, const char *newna
>  		return PTR_ERR(req);
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RLINK\n");
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return 0;
>  }
>  EXPORT_SYMBOL(p9_client_link);
> @@ -1397,7 +1397,7 @@ int p9_client_fsync(struct p9_fid *fid, int datasync)
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RFSYNC fid %d\n", fid->fid);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  
>  error:
>  	return err;
> @@ -1432,7 +1432,7 @@ int p9_client_clunk(struct p9_fid *fid)
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RCLUNK fid %d\n", fid->fid);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	/*
>  	 * Fid is not valid even after a failed clunk
> @@ -1466,7 +1466,7 @@ int p9_client_remove(struct p9_fid *fid)
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RREMOVE fid %d\n", fid->fid);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	if (err == -ERESTARTSYS)
>  		p9_client_clunk(fid);
> @@ -1493,7 +1493,7 @@ int p9_client_unlinkat(struct p9_fid *dfid, const char *name, int flags)
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RUNLINKAT fid %d %s\n", dfid->fid, name);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1545,7 +1545,7 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
>  				   "D", &count, &dataptr);
>  		if (*err) {
>  			trace_9p_protocol_dump(clnt, &req->rc);
> -			p9_free_req(clnt, req);
> +			p9_tag_remove(clnt, req);
>  			break;
>  		}
>  		if (rsize < count) {
> @@ -1555,7 +1555,7 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
>  
>  		p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", count);
>  		if (!count) {
> -			p9_free_req(clnt, req);
> +			p9_tag_remove(clnt, req);
>  			break;
>  		}
>  
> @@ -1565,7 +1565,7 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
>  			offset += n;
>  			if (n != count) {
>  				*err = -EFAULT;
> -				p9_free_req(clnt, req);
> +				p9_tag_remove(clnt, req);
>  				break;
>  			}
>  		} else {
> @@ -1573,7 +1573,7 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
>  			total += count;
>  			offset += count;
>  		}
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  	}
>  	return total;
>  }
> @@ -1617,7 +1617,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  		*err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &count);
>  		if (*err) {
>  			trace_9p_protocol_dump(clnt, &req->rc);
> -			p9_free_req(clnt, req);
> +			p9_tag_remove(clnt, req);
>  			break;
>  		}
>  		if (rsize < count) {
> @@ -1627,7 +1627,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
>  
>  		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", count);
>  
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  		iov_iter_advance(from, count);
>  		total += count;
>  		offset += count;
> @@ -1661,7 +1661,7 @@ struct p9_wstat *p9_client_stat(struct p9_fid *fid)
>  	err = p9pdu_readf(&req->rc, clnt->proto_version, "wS", &ignored, ret);
>  	if (err) {
>  		trace_9p_protocol_dump(clnt, &req->rc);
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  		goto error;
>  	}
>  
> @@ -1678,7 +1678,7 @@ struct p9_wstat *p9_client_stat(struct p9_fid *fid)
>  		from_kgid(&init_user_ns, ret->n_gid),
>  		from_kuid(&init_user_ns, ret->n_muid));
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return ret;
>  
>  error:
> @@ -1714,7 +1714,7 @@ struct p9_stat_dotl *p9_client_getattr_dotl(struct p9_fid *fid,
>  	err = p9pdu_readf(&req->rc, clnt->proto_version, "A", ret);
>  	if (err) {
>  		trace_9p_protocol_dump(clnt, &req->rc);
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  		goto error;
>  	}
>  
> @@ -1739,7 +1739,7 @@ struct p9_stat_dotl *p9_client_getattr_dotl(struct p9_fid *fid,
>  		ret->st_ctime_nsec, ret->st_btime_sec, ret->st_btime_nsec,
>  		ret->st_gen, ret->st_data_version);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return ret;
>  
>  error:
> @@ -1808,7 +1808,7 @@ int p9_client_wstat(struct p9_fid *fid, struct p9_wstat *wst)
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RWSTAT fid %d\n", fid->fid);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1840,7 +1840,7 @@ int p9_client_setattr(struct p9_fid *fid, struct p9_iattr_dotl *p9attr)
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RSETATTR fid %d\n", fid->fid);
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1868,7 +1868,7 @@ int p9_client_statfs(struct p9_fid *fid, struct p9_rstatfs *sb)
>  			  &sb->files, &sb->ffree, &sb->fsid, &sb->namelen);
>  	if (err) {
>  		trace_9p_protocol_dump(clnt, &req->rc);
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  		goto error;
>  	}
>  
> @@ -1879,7 +1879,7 @@ int p9_client_statfs(struct p9_fid *fid, struct p9_rstatfs *sb)
>  		sb->blocks, sb->bfree, sb->bavail, sb->files,  sb->ffree,
>  		sb->fsid, (long int)sb->namelen);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1907,7 +1907,7 @@ int p9_client_rename(struct p9_fid *fid,
>  
>  	p9_debug(P9_DEBUG_9P, "<<< RRENAME fid %d\n", fid->fid);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1937,7 +1937,7 @@ int p9_client_renameat(struct p9_fid *olddirfid, const char *old_name,
>  	p9_debug(P9_DEBUG_9P, "<<< RRENAMEAT newdirfid %d new name %s\n",
>  		   newdirfid->fid, new_name);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -1974,10 +1974,10 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
>  	err = p9pdu_readf(&req->rc, clnt->proto_version, "q", attr_size);
>  	if (err) {
>  		trace_9p_protocol_dump(clnt, &req->rc);
> -		p9_free_req(clnt, req);
> +		p9_tag_remove(clnt, req);
>  		goto clunk_fid;
>  	}
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	p9_debug(P9_DEBUG_9P, "<<<  RXATTRWALK fid %d size %llu\n",
>  		attr_fid->fid, *attr_size);
>  	return attr_fid;
> @@ -2011,7 +2011,7 @@ int p9_client_xattrcreate(struct p9_fid *fid, const char *name,
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RXATTRCREATE fid %d\n", fid->fid);
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -2074,11 +2074,11 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
>  	if (non_zc)
>  		memmove(data, dataptr, count);
>  
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return count;
>  
>  free_and_error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  error:
>  	return err;
>  }
> @@ -2109,7 +2109,7 @@ int p9_client_mknod_dotl(struct p9_fid *fid, const char *name, int mode,
>  				(unsigned long long)qid->path, qid->version);
>  
>  error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return err;
>  
>  }
> @@ -2140,7 +2140,7 @@ int p9_client_mkdir_dotl(struct p9_fid *fid, const char *name, int mode,
>  				(unsigned long long)qid->path, qid->version);
>  
>  error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return err;
>  
>  }
> @@ -2173,7 +2173,7 @@ int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status)
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RLOCK status %i\n", *status);
>  error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return err;
>  
>  }
> @@ -2208,7 +2208,7 @@ int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *glock)
>  		"proc_id %d client_id %s\n", glock->type, glock->start,
>  		glock->length, glock->proc_id, glock->client_id);
>  error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return err;
>  }
>  EXPORT_SYMBOL(p9_client_getlock_dotl);
> @@ -2234,7 +2234,7 @@ int p9_client_readlink(struct p9_fid *fid, char **target)
>  	}
>  	p9_debug(P9_DEBUG_9P, "<<< RREADLINK target %s\n", *target);
>  error:
> -	p9_free_req(clnt, req);
> +	p9_tag_remove(clnt, req);
>  	return err;
>  }
>  EXPORT_SYMBOL(p9_client_readlink);
> 
