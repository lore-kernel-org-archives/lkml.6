Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32349C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1F3222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="T3/RPyjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbfBPQhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:37:18 -0500
Received: from mx01-sz.bfs.de ([194.94.69.67]:54614 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfBPQhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:37:18 -0500
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Feb 2019 11:37:17 EST
Received: from mail-sz.bfs.de (mail-sz.bfs.de [10.129.18.200])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id EAEEC20220;
        Sat, 16 Feb 2019 17:27:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1550334436; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=52Vr9Ib4sZvBTqQZj11GVHfKS/ReAgbvCGdiNIlXtMk=;
        b=T3/RPyjvf3eRIAeMzSvWVEY/zxrs0kZRpDDwLU10oRMhYq/ZjQsDVXXGSsaMZzKbRdz7up
        w7JVIfNgrh+VtZdCIhfXnUoycrNzPzCceSbb1EYHqdW+4OukvLkgN6hacmc5azcgxsRbHG
        2n8Pq/PjvX+KRRom7dQrn6PeYEldgQ7BGeCkUS7oX83OV4tVKqFbSPX7qmeoxY1abTLsKG
        SqvoKywco7fQMfH7JOGtftWp8acXvCMCPiBCRR+Z2SI9duG0NBVmogwOzI0ZOh6gpSLfBR
        wr8Wi6GTHxmTjfhKXpY0h4ZR20hL6tE+0uBNgQgk9UKkvciJGivY6jtfkjrnCA==
Received: from null (ox-groupware01-sz.bfs.de [10.129.18.42])
        by mail-sz.bfs.de (Postfix) with ESMTPS id BC3807F504;
        Sat, 16 Feb 2019 17:27:16 +0100 (CET)
Date:   Sat, 16 Feb 2019 17:27:16 +0100 (CET)
From:   Walter Harms <wharms@bfs.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Jianyun Li <jyli@marvell.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1596625925.142066.1550334436646@ox-groupware.bfs.de>
Subject:  Re: [PATCH] scsi: mvumi: fix 32 bit shift of a 32 bit unsigned int
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev44
X-Originating-Client: com.openexchange.ox.gui.dhtml
Authentication-Results: mx01-sz.bfs.de
X-Spamd-Result: default: False [-2.10 / 7.00];
         ARC_NA(0.00)[];
         FAKE_REPLY(1.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         HAS_X_PRIO_THREE(0.00)[3];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.02.2019 15:44, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently m_sg->baseaddr_h (a 32 bit unsigned int) is being shifted by a
> total of 32 bits; this always produces a 0 result.  Fix this by casting
> it to a dma_addr_t (a 64 bit unsigned int) before performing the shift.
> 
> Detected by CoverityScan, CID#147270 ("Operands don't affect result")
> 
> Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/mvumi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> index 36f64205ecfa..d3582accfd09 100644
> --- a/drivers/scsi/mvumi.c
> +++ b/drivers/scsi/mvumi.c
> @@ -313,7 +313,7 @@ static void mvumi_delete_internal_cmd(struct mvumi_hba
> *mhba,
>  			sgd_getsz(mhba, m_sg, size);
>  
>  			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
> -				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
> +				(((dma_addr_t) m_sg->baseaddr_h << 16) << 16);
>  
>  			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
>  								phy_addr);

i would suggest to try a version with less casts to make it more readable
like this untested suggestion:

phy_addr =(m_sg->baseaddr_h << 16)| m_sg->baseaddr_l;
phy_addr <<= 16;


just my 2 cents,
re,
 wh
