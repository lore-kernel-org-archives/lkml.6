Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A36C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0757A208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0757A208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeH0XY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:24:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35030 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0XY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:24:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7BB5E606D4A7;
        Mon, 27 Aug 2018 21:36:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gf_BJpxcY10y; Mon, 27 Aug 2018 21:36:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 218CC603B65A;
        Mon, 27 Aug 2018 21:36:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gRHXXDNsQnws; Mon, 27 Aug 2018 21:36:57 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C0BB8603B659;
        Mon, 27 Aug 2018 21:36:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] ubifs: authentication: Add hashes to index nodes
Date:   Mon, 27 Aug 2018 21:36:56 +0200
Message-ID: <2092924.iTNEbfF25J@blindfold>
In-Reply-To: <20180704124137.13396-14-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <20180704124137.13396-14-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Juli 2018, 14:41:25 CEST schrieb Sascha Hauer:
> With this patch the hashes over the index nodes stored in the tree node
> cache are written to flash and are checked when read back from flash.
> The hash of the root index node is stored in the master node.
> 
> During journal replay the hashes are regenerated from the read nodes
> and stored in the tree node cache. This means the nodes must previously
> be authenticated by other means. This is done in a later patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/master.c     |  3 +++
>  fs/ubifs/misc.h       |  5 +++--
>  fs/ubifs/replay.c     | 29 ++++++++++++++++++-----------
>  fs/ubifs/tnc.c        | 13 +++++++++++++
>  fs/ubifs/tnc_commit.c | 26 ++++++++++++++++++++++++++
>  fs/ubifs/tnc_misc.c   | 16 +++++++++++++++-
>  fs/ubifs/ubifs.h      |  4 ++++
>  7 files changed, 82 insertions(+), 14 deletions(-)
> 

[...]

> diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
> index a47fced47823..a00809d4fe6f 100644
> --- a/fs/ubifs/tnc.c
> +++ b/fs/ubifs/tnc.c
> @@ -488,6 +488,12 @@ static int try_read_node(const struct ubifs_info *c, void *buf, int type,
>  	if (crc != node_crc)
>  		return 0;
>  
> +	err = ubifs_node_check_hash(c, buf, zbr->hash);
> +	if (err) {
> +		ubifs_err(c, "hash mismatch on node at LEB %d:%d", lnum, offs);
> +		return 0;
> +	}

Hmm, I think a global "hash is bad" handler would be nice to have.
That way we always report in the same way.

Maybe also a new file system specific ioctl to query whether a hash
failure was noticed.

>  	return 1;
>  }
>  
> @@ -1713,6 +1719,13 @@ static int validate_data_node(struct ubifs_info *c, void *buf,
>  		goto out;
>  	}
>  
> +	err = ubifs_node_check_hash(c, buf, zbr->hash);
> +	if (err) {
> +		ubifs_err(c, "hash mismatch on node at LEB %d:%d",
> +			  zbr->lnum, zbr->offs);
> +		return err;
> +	}
> +
>  	len = le32_to_cpu(ch->len);
>  	if (len != zbr->len) {
>  		ubifs_err(c, "bad node length %d, expected %d", len, zbr->len);
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index a9df94ad46a3..3ad78d538885 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -38,6 +38,7 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
>  			 struct ubifs_znode *znode, int lnum, int offs, int len)
>  {
>  	struct ubifs_znode *zp;
> +	u8 hash[UBIFS_MAX_HASH_LEN];
>  	int i, err;
>  
>  	/* Make index node */
> @@ -62,6 +63,7 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
>  		}
>  	}
>  	ubifs_prepare_node(c, idx, len, 0);
> +	ubifs_node_calc_hash(c, idx, hash);
>  
>  	znode->lnum = lnum;
>  	znode->offs = offs;
> @@ -78,10 +80,12 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
>  		zbr->lnum = lnum;
>  		zbr->offs = offs;
>  		zbr->len = len;
> +		ubifs_copy_hash(c, hash, zbr->hash);
>  	} else {
>  		c->zroot.lnum = lnum;
>  		c->zroot.offs = offs;
>  		c->zroot.len = len;
> +		ubifs_copy_hash(c, hash, c->zroot.hash);
>  	}
>  	c->calc_idx_sz += ALIGN(len, 8);
>  
> @@ -647,6 +651,8 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>  			znode->cnext = c->cnext;
>  			break;
>  		}
> +		znode->cparent = znode->parent;
> +		znode->ciip = znode->iip;
>  		znode->cnext = cnext;
>  		znode = cnext;
>  		cnt += 1;
> @@ -840,6 +846,8 @@ static int write_index(struct ubifs_info *c)
>  	}
>  
>  	while (1) {
> +		u8 hash[UBIFS_MAX_HASH_LEN];
> +
>  		cond_resched();
>  
>  		znode = cnext;
> @@ -857,6 +865,7 @@ static int write_index(struct ubifs_info *c)
>  			br->lnum = cpu_to_le32(zbr->lnum);
>  			br->offs = cpu_to_le32(zbr->offs);
>  			br->len = cpu_to_le32(zbr->len);
> +			ubifs_copy_hash(c, zbr->hash, ubifs_branch_hash(c, br));
>  			if (!zbr->lnum || !zbr->len) {
>  				ubifs_err(c, "bad ref in znode");
>  				ubifs_dump_znode(c, znode);
> @@ -868,6 +877,23 @@ static int write_index(struct ubifs_info *c)
>  		}
>  		len = ubifs_idx_node_sz(c, znode->child_cnt);
>  		ubifs_prepare_node(c, idx, len, 0);
> +		ubifs_node_calc_hash(c, idx, hash);
> +
> +		mutex_lock(&c->tnc_mutex);

This lock looks correct too me.
Just in case, you did test with lockdep enabled? :-)



