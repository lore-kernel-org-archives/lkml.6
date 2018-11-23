Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E4AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E712F206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E712F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394740AbeKWXoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:44:03 -0500
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:51414 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731971AbeKWXoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:44:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 28A56100E86C5;
        Fri, 23 Nov 2018 12:59:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ducks30_90cacefbc5557
X-Filterd-Recvd-Size: 2822
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Nov 2018 12:59:54 +0000 (UTC)
Message-ID: <43e95b184b836a9e94a6f7dd09bd9c124c89ebef.camel@perches.com>
Subject: Re: [PATCH] hfs: do not free node before using
From:   Joe Perches <joe@perches.com>
To:     Pan Bian <bianpan2016@163.com>,
        "Ernesto A." =?ISO-8859-1?Q?Fern=E1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Nov 2018 04:59:53 -0800
In-Reply-To: <1542963889-128825-1-git-send-email-bianpan2016@163.com>
References: <1542963889-128825-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 17:04 +0800, Pan Bian wrote:
> The function hfs_bmap_free frees node via hfs_bnode_put(node). However,
> it then reads node->this when dumping error message on an error path,
> which may result in a use-after-free bug. This patch frees node only
> when it is never used.
> 
> Fixes: d614267329f("hfs/hfsplus: convert printks to pr_<level>")

Hi.

While this may indeed be a defect, and the "/* panic */" comment
may be unwarranted, this isn't really a fix of a printk conversion.

This dereference goes back to 2004, the printk(KERN_CRIT to pr_crit(
conversion did not introduce it.

So this patch is only a possible use after free fix.

From a full history git tree:
(similar to https://archive.org/details/git-history-of-linux)

commit a1185ffa2fc491e23f3107a39f66ee703d102153
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed Feb 25 16:17:36 2004 -0800

    [PATCH] HFS rewrite
    
    From: Roman Zippel <zippel@linux-m68k.org>
    
    This is a complete rewrite of the HFS driver, it gets rid of a all the
    special conversion options, which belong in user space.  The driver uses now
    a btree support very similiar to HFS+, so that both could be merged at some
    point.
    
    Thanks to Ethan Benson <erbenson@alaska.net> for a number of patches to make
    the driver more compliant with the spec and Christoph Hellwig <hch@lst.de>
    for fixing up the documentation.

> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
[]
> @@ -338,13 +338,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
>  
>  		nidx -= len * 8;
>  		i = node->next;
> -		hfs_bnode_put(node);
>  		if (!i) {
>  			/* panic */;
>  			pr_crit("unable to free bnode %u. bmap not found!\n",
>  				node->this);
> +			hfs_bnode_put(node);
>  			return;
>  		}
> +		hfs_bnode_put(node);
>  		node = hfs_bnode_find(tree, i);
>  		if (IS_ERR(node))
>  			return;

