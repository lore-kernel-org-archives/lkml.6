Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D4DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B1820824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L2h/gIm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B1820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeKXMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:41:06 -0500
Received: from m12-13.163.com ([220.181.12.13]:58618 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbeKXMlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Mia71
        0GVrkzIa0+UQuBOddn+CcnraMEfxnPJ31GICwg=; b=L2h/gIm+dr74pezFFWqeR
        JRV1UuUTdpoEx2mBiIbLgKiQ+TmmkEIQY74gzvWBtcpwY7BygWVGrKKireEUT9D2
        Jdxgn1jkbiLcX8Uy7sorYz4kiekHsk8Z3e7CWNN9kHbQmvt6LZzMiQDXttee30Px
        UTgv+kEPgJJMnMSbvsrP0A=
Received: from bp (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowAAnZcpOr_hbiqcSBg--.18944S2;
        Sat, 24 Nov 2018 09:54:22 +0800 (CST)
Date:   Sat, 24 Nov 2018 09:54:23 +0800
From:   PanBian <bianpan2016@163.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Joe Perches <joe@perches.com>,
        Ernesto =?iso-8859-1?Q?A=2E_Fern=E1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfs: do not free node before using
Message-ID: <20181124015423.GB23256@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1542963889-128825-1-git-send-email-bianpan2016@163.com>
 <1543020709.12764.3.camel@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543020709.12764.3.camel@dubeyko.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DcCowAAnZcpOr_hbiqcSBg--.18944S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1DGF47Xw1DXF4DKw45ZFb_yoW8Wr17pr
        yxCF42kF4DZ34IkrnavF1Fg34vyw4xJrs0kws5Cr1xZ3Z8Xr97Wr18KryY93W5ZrW8Z3yj
        qrs8G3sxWrsxZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jNjjgUUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzw4JclaD0ZEAlgAAs5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 04:51:49PM -0800, Viacheslav Dubeyko wrote:
> On Fri, 2018-11-23 at 17:04 +0800, Pan Bian wrote:
> > The function hfs_bmap_free frees node via hfs_bnode_put(node).
> > However,
> > it then reads node->this when dumping error message on an error path,
> > which may result in a use-after-free bug. This patch frees node only
> > when it is never used.
> > 
> > Fixes: d614267329f("hfs/hfsplus: convert printks to pr_<level>")
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> >  fs/hfs/btree.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> > index 98b96ff..19017d2 100644
> > --- a/fs/hfs/btree.c
> > +++ b/fs/hfs/btree.c
> > @@ -338,13 +338,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
> >  
> >  		nidx -= len * 8;
> >  		i = node->next;
> > -		hfs_bnode_put(node);
> >  		if (!i) {
> >  			/* panic */;
> >  			pr_crit("unable to free bnode %u. bmap not
> > found!\n",
> >  				node->this);
> 
> 
> What's about simply to store node->this into the local variable in the
> beginning of the cycle? In this case, it is possible to use the node ID
> in the pr_crit() and to use the hfs_bnode_put(node) in the same place
> without to use it twice. What do you think?

Of course, it is a solution. But I think doing like that does not really
simplify the code, as we have to declare an extra local variable, and
assign node->this to it...

Best,
Pan

> 
> Thanks,
> Vyacheslav Dubeyko.
> 
> 
> > +			hfs_bnode_put(node);
> >  			return;
> >  		}
> > +		hfs_bnode_put(node);
> >  		node = hfs_bnode_find(tree, i);
> >  		if (IS_ERR(node))
> >  			return;

