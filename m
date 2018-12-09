Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A0B20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A0B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLIGw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:52:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38992 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeLIGw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:52:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2C67D2073D; Sun,  9 Dec 2018 07:52:56 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id EFBC620618;
        Sun,  9 Dec 2018 07:52:55 +0100 (CET)
Date:   Sun, 9 Dec 2018 07:52:56 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     <linux-mtd@lists.infradead.org>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard.weinberger@gmail.com>
Subject: Re: [PATCH] jffs2: fix invocations of dbg_xattr() for dead
 jffs2_xattr_ref
Message-ID: <20181209075256.43ca759f@bbrezillon>
In-Reply-To: <20181020110753.98407-1-houtao1@huawei.com>
References: <20181020110753.98407-1-houtao1@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2018 19:07:53 +0800
Hou Tao <houtao1@huawei.com> wrote:

> When jffs2_xattr_ref is dead, xref->ic or xref->xd will be invalid
> because these fields will be reused as xref->ino or xref->xid,
> so access xref->ic->ino or xref->xd->xid will lead to Oops.
> 
> Fix the problem by checking whether or not it is a dead xref.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/jffs2/xattr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> index 3d40fe02b003..0c4c7891556d 100644
> --- a/fs/jffs2/xattr.c
> +++ b/fs/jffs2/xattr.c
> @@ -550,7 +550,8 @@ static int save_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
>  	ref->xseqno = xseqno;
>  	jffs2_add_physical_node_ref(c, phys_ofs | REF_PRISTINE, PAD(sizeof(rr)), (void *)ref);
>  
> -	dbg_xattr("success on saving xref (ino=%u, xid=%u)\n", ref->ic->ino, ref->xd->xid);
> +	dbg_xattr("success on saving xref (ino=%u, xid=%u)\n",
> +			je32_to_cpu(rr.ino), je32_to_cpu(rr.xid));

Nit: align the second line on the open parens (same applies to the
other chunk).

Sorry, I can't comment on the actual change. I'll let Richard look
at it.

>  
>  	return 0;
>  }
> @@ -1329,7 +1330,11 @@ int jffs2_garbage_collect_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_
>  	rc = save_xattr_ref(c, ref);
>  	if (!rc)
>  		dbg_xattr("xref (ino=%u, xid=%u) GC'ed from %#08x to %08x\n",
> -			  ref->ic->ino, ref->xd->xid, old_ofs, ref_offset(ref->node));
> +				is_xattr_ref_dead(ref) ?
> +					ref->ino : ref->ic->ino,
> +				is_xattr_ref_dead(ref) ?
> +					ref->xid : ref->xd->xid,
> +				old_ofs, ref_offset(ref->node));
>   out:
>  	if (!rc)
>  		jffs2_mark_node_obsolete(c, raw);

