Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01367C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905A92175F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905A92175F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeHRTYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:24:13 -0400
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:49750 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726219AbeHRTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:24:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CE5F018224D76;
        Sat, 18 Aug 2018 16:15:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hand84_8b4e0ddda1458
X-Filterd-Recvd-Size: 2817
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Aug 2018 16:15:57 +0000 (UTC)
Message-ID: <14b562e7acdb37158190e14045fe276e9899422e.camel@perches.com>
Subject: Re: [PATCHv2] ide: Use NULL to compare with pointer-typed value
 rather than 0
From:   Joe Perches <joe@perches.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 18 Aug 2018 09:15:55 -0700
In-Reply-To: <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
References: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
         <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-18 at 18:53 +0300, Sergei Shtylyov wrote:
> On 08/18/2018 09:16 AM, zhong jiang wrote:
> 
> > We should use NULL to compare with pointer-typed value rather than
> > 0. The issue is detected with the help of Coccinelle.
> 
>    Your description stopped to match the patch in v2.
>    Actually, this X ==  NULL to !x preference is largely spocific to netdev...
> Although, IDE maintainer is the same now person. :-)  
>  
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > ---
> >  drivers/ide/pmac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> > index c5b902b..ca36a97 100644
> > --- a/drivers/ide/pmac.c
> > +++ b/drivers/ide/pmac.c
> > @@ -1682,7 +1682,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
> >  	/* We won't need pci_dev if we switch to generic consistent
> >  	 * DMA routines ...
> >  	 */
> > -	if (dev == NULL || pmif->dma_regs == 0)
> > +	if (!dev || !pmif->dma_regs)
> >  		return -ENODEV;
> >  	/*
> >  	 * Allocate space for the DBDMA commands.
> 
> MBR, Sergei

Perhaps discourage trivial changes to this old subsystem.

checkpatch could bleat something if a patch was submitted for ide
if the IDE MAINTAINERS entry was marked obsolete.
---
diff --git a/MAINTAINERS b/MAINTAINERS
index e9336962d0f2..3c4992cf5249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6933,7 +6933,7 @@ M:	"David S. Miller" <davem@davemloft.net>
 L:	linux-ide@vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-ide/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git
-S:	Maintained
+S:	Maintained / Obsolete (prefer LIBATA)
 F:	Documentation/ide/
 F:	drivers/ide/
 F:	include/linux/ide.h

