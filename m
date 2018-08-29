Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04280C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49F420867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49F420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeH2Sfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:35:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57529 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeH2Sfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:35:50 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fv1cA-0000LE-Ik; Wed, 29 Aug 2018 16:38:34 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fv1cA-0007GV-3B; Wed, 29 Aug 2018 16:38:34 +0200
Date:   Wed, 29 Aug 2018 16:38:34 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/25] ubifs: Add authentication nodes to journal
Message-ID: <20180829143834.wwojzrwmpadxqiqk@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
 <20180704124137.13396-15-s.hauer@pengutronix.de>
 <1901352.nUraZMrBkh@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1901352.nUraZMrBkh@blindfold>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:54:29 up 77 days, 23:03, 60 users,  load average: 0.03, 0.11,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:48:26PM +0200, Richard Weinberger wrote:
> Am Mittwoch, 4. Juli 2018, 14:41:26 CEST schrieb Sascha Hauer:
> > Nodes that are written to flash can only be authenticated through the
> > index after the next commit. When a journal replay is necessary the
> > nodes are not yet referenced by the index and thus can't be
> > authenticated.
> > 
> > This patch overcomes this situation by creating a hash over all nodes
> > beginning from the commit start node over the reference node(s) and
> > the buds themselves. From
> > time to time we insert authentication nodes. Authentication nodes
> > contain a HMAC from the current hash state, so that they can be
> > used to authenticate a journal replay up to the point where the
> > authentication node is. The hash is continued afterwards
> > so that theoretically we would only have to check the HMAC of
> > the last authentication node we find.
> > 
> > Overall we get this picture:
> > 
> > ,,,,,,,,
> > ,......,...........................................
> > ,. CS  ,               hash1.----.           hash2.----.
> > ,.  |  ,                    .    |hmac            .    |hmac
> > ,.  v  ,                    .    v                .    v
> > ,.REF#0,-> bud -> bud -> bud.-> auth -> bud -> bud.-> auth ...
> > ,..|...,...........................................
> > ,  |   ,
> > ,  |   ,,,,,,,,,,,,,,,
> > .  |            hash3,----.
> > ,  |                 ,    |hmac
> > ,  v                 ,    v
> > , REF#1 -> bud -> bud,-> auth ...
> > ,,,|,,,,,,,,,,,,,,,,,,
> >    v
> >   REF#2 -> ...
> >    |
> >    V
> >   ...
> > 
> > Note how hash3 covers CS, REF#0 and REF#1 so that it is not possible to
> > exchange or skip any reference nodes. Unlike the picture suggests the
> > auth nodes themselves are not hashed.
> > 
> > With this it is possible for an offline attacker to cut each journal
> > head or to drop the last reference node(s), but not to skip any journal
> > heads or to reorder any operations.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  fs/ubifs/gc.c      |   3 +-
> >  fs/ubifs/journal.c | 110 ++++++++++++++++++++++++++++++++++++++-------
> >  fs/ubifs/log.c     |  17 +++++++
> >  fs/ubifs/replay.c  |   2 +
> >  fs/ubifs/super.c   |  10 +++++
> >  fs/ubifs/ubifs.h   |   8 ++++
> >  6 files changed, 134 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> > index 55b35bc33c31..4fde75623a3f 100644
> > --- a/fs/ubifs/journal.c
> > +++ b/fs/ubifs/journal.c
> > @@ -228,6 +228,32 @@ static int reserve_space(struct ubifs_info *c, int jhead, int len)
> >  	return err;
> >  }
> >  
> > +static void ubifs_hash_nodes(struct ubifs_info *c, void *node,
> > +			     int len, struct shash_desc *hash)
> > +{
> > +	int auth_node_size = ubifs_auth_node_sz(c);
> > +
> > +	while (1) {
> > +		const struct ubifs_ch *ch = node;
> > +		int nodelen = le32_to_cpu(ch->len);
> > +
> > +		ubifs_assert(len >= auth_node_size);
> > +
> > +		if (len == auth_node_size)
> > +			break;
> > +
> > +		ubifs_assert(len > nodelen);
> > +		ubifs_assert(ch->magic == cpu_to_le32(UBIFS_NODE_MAGIC));
> 
> A malformed UBIFS image can trigger that assert, right?
> Please handle this without ubifs_assert() and abort with an error.
> ubifs_assert() does not stop execution by default.

In this function we iterate over the nodes we previously created in
memory. It is called with the same buffer write_head() is called with.

If this assertion triggers then we either failed creating a good buffer
containing all nodes or we failed iterating over it for some reason.
Either way it is an UBIFS internal error, not a malformed image.

> 
> > +		ubifs_shash_update(c, hash, (void *)node, nodelen);
> > +
> > +		node += ALIGN(nodelen, 8);
> > +		len -= ALIGN(nodelen, 8);
> > +	}
> > +
> > +	ubifs_prepare_auth_node(c, node, hash);
> > +}
> > +
> > @@ -603,6 +634,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
> >  	}
> >  	release_head(c, BASEHD);
> >  	kfree(dent);
> > +	ubifs_add_dirt(c, lnum, ubifs_auth_node_sz(c));
> 
> You have to account it immediately because while a commit you have no longer
> a reference to them?
> Upon replay you should have since you scan LEBs anyway.

What do you mean here? Is that a suggestion to change something?

> 
> An shouldn't this only get called when the file system is authenticated?
> AFAICT ubifs_add_dirt(c, lnum, 0) is not a no-op.

Right. I changed it to use the ubifs_add_auth_dirt() helper that you
suggested below.

> 
> >  	if (deletion) {
> >  		if (nm->hash)
> > @@ -677,8 +709,9 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
> >  			 const union ubifs_key *key, const void *buf, int len)
> >  {
> >  	struct ubifs_data_node *data;
> > -	int err, lnum, offs, compr_type, out_len, compr_len;
> > +	int err, lnum, offs, compr_type, out_len, compr_len, auth_len;
> >  	int dlen = COMPRESSED_DATA_NODE_BUF_SZ, allocated = 1;
> > +	int aligned_dlen;
> >  	struct ubifs_inode *ui = ubifs_inode(inode);
> >  	bool encrypted = ubifs_crypt_is_encrypted(inode);
> >  	u8 hash[UBIFS_MAX_HASH_LEN];
> > @@ -690,7 +723,9 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
> >  	if (encrypted)
> >  		dlen += UBIFS_CIPHER_BLOCK_SIZE;
> >  
> > -	data = kmalloc(dlen, GFP_NOFS | __GFP_NOWARN);
> > +	auth_len = ubifs_auth_node_sz(c);
> > +
> > +	data = kmalloc(dlen + auth_len, GFP_NOFS | __GFP_NOWARN);
> >  	if (!data) {
> >  		/*
> >  		 * Fall-back to the write reserve buffer. Note, we might be
> > @@ -729,15 +764,16 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
> >  	}
> >  
> >  	dlen = UBIFS_DATA_NODE_SZ + out_len;
> > +	aligned_dlen = ALIGN(dlen, 8);
> >  	data->compr_type = cpu_to_le16(compr_type);
> >  
> >  	/* Make reservation before allocating sequence numbers */
> > -	err = make_reservation(c, DATAHD, dlen);
> > +	err = make_reservation(c, DATAHD, aligned_dlen + auth_len);
> 
> Okay, now I understand the ALIGN(), ubifs nodes need to be aligned
> at an 8 border. Makes sense, _but_ you change this also for the non-authenticated
> case.

I assumed that make_reservation would align len anyway. I can't find the
place that led me to that assumption anymore and even if this is true
it's probably safer to just stick to the original len for the
non-authenticated case, so I'll change this and other places to use
the non aligned len.

BTW could you have a look at ubifs_jnl_change_xattr()? Unlike other
function in this file it explicitly calls make_reservation() with the
length of the last node aligned. Do you have an idea why?

> 
> >  	if (err)
> >  		goto out_free;
> >  
> >  	ubifs_prepare_node(c, data, dlen, 0);
> > -	err = write_head(c, DATAHD, data, dlen, &lnum, &offs, 0);
> > +	err = write_head(c, DATAHD, data, aligned_dlen + auth_len, &lnum, &offs, 0);
> >  	if (err)
> >  		goto out_release;
> >  
> > @@ -1198,6 +1252,9 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
> >  	}
> >  	release_head(c, BASEHD);
> >  
> > +	if (ubifs_authenticated(c))
> > +		ubifs_add_dirt(c, lnum, ubifs_auth_node_sz(c));
> 
> This is always the same pattern. How about adding a helper function?
> ubifs_add_auth_dirt()?

Yes, sounds good.

> > @@ -1511,12 +1580,14 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
> >  	hlen = host_ui->data_len + UBIFS_INO_NODE_SZ;
> >  	len = aligned_xlen + UBIFS_INO_NODE_SZ + ALIGN(hlen, 8);
> >  
> > -	xent = kzalloc(len, GFP_NOFS);
> > +	tlen = len + ubifs_auth_node_sz(c);
> 
> xlen, hlen, len, tlen, oh my.. ;-)
> What does the "t" stand for?
> Sorry, I'm very bad at naming things.

I must have thought of something like total_len. I could change it to
write_len if that sounds better to you.

> > @@ -1617,10 +1692,12 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
> >  	ubifs_assert(mutex_is_locked(&host_ui->ui_mutex));
> >  
> >  	len1 = UBIFS_INO_NODE_SZ + host_ui->data_len;
> > -	len2 = UBIFS_INO_NODE_SZ + ubifs_inode(inode)->data_len;
> > +	len2 = UBIFS_INO_NODE_SZ + ui->data_len;
> 
> Why do we need this change, seems unrelated?

Some leftover from earlier versions. Will drop.

> > @@ -377,6 +384,11 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
> >  	cs->cmt_no = cpu_to_le64(c->cmt_no);
> >  	ubifs_prepare_node(c, cs, UBIFS_CS_NODE_SZ, 0);
> >  
> > +	if (c->authenticated) {
> 
> ubifs_authenticated(c)?

Yes.

> 
> > +		crypto_shash_init(c->log_hash);
> > +		crypto_shash_update(c->log_hash, (void *)cs, UBIFS_CS_NODE_SZ);
> > +	}
> > +
> >  	/*
> >  	 * Note, we do not lock 'c->log_mutex' because this is the commit start
> >  	 * phase and we are exclusively using the log. And we do not lock
> > @@ -402,6 +414,10 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
> >  
> >  		ubifs_prepare_node(c, ref, UBIFS_REF_NODE_SZ, 0);
> >  		len += UBIFS_REF_NODE_SZ;
> > +
> > +		ubifs_shash_update(c, c->log_hash, (void *)ref,
> 
> Why the void * cast?
> (Applies to multiple calls to ubifs_shash_update)

I think I used crypto_shash_update directly in ealier versions which
takes a u8 * and thus needs a cast. Now it can be removed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
