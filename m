Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228BEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41D02098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41D02098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeJPTjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:39:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44008 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPTjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:39:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C67A0207BF; Tue, 16 Oct 2018 13:49:42 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 75982206A1;
        Tue, 16 Oct 2018 13:49:32 +0200 (CEST)
Date:   Tue, 16 Oct 2018 13:49:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, stable@kernel.org
Subject: Re: [PATCH] jffs2: free jffs2_sb_info through jffs2_kill_sb()
Message-ID: <20181016134933.0504707f@bbrezillon>
In-Reply-To: <9bb38d45-41c7-9f16-bf6b-d21ba6617f1c@huawei.com>
References: <20181006090935.41714-1-houtao1@huawei.com>
        <6401cb90-a1fe-afd5-c302-ddae40876736@huawei.com>
        <CAFLxGvw+=gfrm3SH4Hu9bt0sa6s+X=3cCjkDLvWusqhHH10yEQ@mail.gmail.com>
        <9bb38d45-41c7-9f16-bf6b-d21ba6617f1c@huawei.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 18:26:34 +0800
Hou Tao <houtao1@huawei.com> wrote:

> On 2018/10/16 14:41, Richard Weinberger wrote:
> > On Tue, Oct 16, 2018 at 7:53 AM Hou Tao <houtao1@huawei.com> wrote:  
> >>
> >> ping ?
> >>
> >> On 2018/10/6 17:09, Hou Tao wrote:  
> >>> When an invalid mount option is passed to jffs2, jffs2_parse_options()
> >>> will fail and jffs2_sb_info will be freed, but then jffs2_sb_info will
> >>> be used (use-after-free) and freeed (double-free) in jffs2_kill_sb().
> >>>
> >>> Fix it by removing the buggy invocation of kfree() when getting invalid
> >>> mount options.
> >>>
> >>> Cc: stable@kernel.org
> >>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>> ---
> >>>  fs/jffs2/super.c | 4 +---
> >>>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> >>> index 87bdf0f4cba1..902a7dd10e5c 100644
> >>> --- a/fs/jffs2/super.c
> >>> +++ b/fs/jffs2/super.c
> >>> @@ -285,10 +285,8 @@ static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
> >>>       sb->s_fs_info = c;
> >>>
> >>>       ret = jffs2_parse_options(c, data);
> >>> -     if (ret) {
> >>> -             kfree(c);
> >>> +     if (ret)
> >>>               return -EINVAL;
> >>> -     }  
> > 
> > Reviewed-by: Richard Weinberger <richard@nod.at>
> > 
> > We can carry this via the MTD tree.  
> Thanks for that.

Applied after adding

Fixes: 92abc475d8de ("jffs2: implement mount option parsing and compression overriding")

> 
> Regards,
> Tao
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

