Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8373C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E43A21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdxt6muw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E43A21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJDBgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:36:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45286 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDBgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:36:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so1939203pgd.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZNQkOrvyLD7AmYLJ3W6Lo0dOyHE00dWE1uplTm/sduE=;
        b=cdxt6muwQlZSd2m7ZqjoV5dhtun3Qj6YRBLe2LngrTe9NECBtKE5PoGoLgqmI01Hgv
         vwDSjUG8HO4bstgvDy1ldZsIyQ3bRLDYHbchvuVN8dvmC5RRqHosM1gzpad0LCOZXJIW
         9jsb39PhrWLf4cKsK/MxgtaQByFNQwQ/ncQVkiztxYBtq75rDQRyMz2nk4n8cbc40h4n
         D17H4boBCEjjPfjKhHaT+wwnl3JO95j8ShJCm0ZSPD8XL+oWuX7ZgNwhugISlWS2Y7EH
         ZgEyGXL56PI8TM4NVCwwJIq2kkrNCdm5eJRj8L8eWGOLL4TjsgUzSSAKp/scixLBP2P+
         WGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ZNQkOrvyLD7AmYLJ3W6Lo0dOyHE00dWE1uplTm/sduE=;
        b=Zo180B1d1U4qcRR0HscaRUNtZPSTeh6WF8iIaDfMH2awB2iOO8eWw9layxM8YZLEXq
         ZDs+SYs1BGT8DSNBV9FPwL2K1mByYXYxeOndHQY1Bq7Lim0T41aQUQUFRDzAYItxGUDH
         3jM3koSZJqcgs8HLQbeYhTT823acHw2GYIzsM7zI5itNknBGeQvFXK2GcLwuknIetE3+
         IF8uIaz19h9jSDPoMu0WOfV7KbePyHULHdE8+je3G8Uvk2WD1ESWr2p+BoNHejgTRq/O
         E73bDlt+b5dPofMNN3xAOOV9NdJ6P+WSSTBYWoWizhd1SAY+cLKIP465Igo4mbXRDEbW
         fvlw==
X-Gm-Message-State: ABuFfoh/yQQ2jA1XUua0cQkeUsZmc66Fup9m6/ogaTHwSTT0NPpgC1dX
        M3s+8GXLh5w+CSB157wFp0I=
X-Google-Smtp-Source: ACcGV63pzzsiaVnHKs57dmQs+usE96oWBFSJAPNKueVN3EtBr0ggkwc9Y5SczrWAP6zhOhQ3fR/OVQ==
X-Received: by 2002:a65:5b07:: with SMTP id y7-v6mr2550278pgq.125.1538592407930;
        Wed, 03 Oct 2018 11:46:47 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3719323pfb.151.2018.10.03.11.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:46:46 -0700 (PDT)
Date:   Wed, 3 Oct 2018 11:46:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-direct: always allow dma mask <= physiscal memory
 size
Message-ID: <20181003184645.GA25639@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:31:58AM +0200, Christoph Hellwig wrote:
> This way an architecture with less than 4G of RAM can support dma_mask
> smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
> case on powerpc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

This patch causes widespread boot failures on mips and x86_64.

Common denominators:

ahci 0002:01:00.0: 32-bit DMA enable failed
ahci: probe of 0002:01:00.0 failed with error -5

sym0: No suitable DMA available
sym0: giving up ...

pcnet32 0000:00:0b.0: enabling device (0000 -> 0003)
pcnet32: architecture does not support 32bit PCI busmaster DMA
pcnet32: probe of 0000:00:0b.0 failed with error -5

There may be others; I didn't check all the logs.

Sample bisect log is attached (from mips64). Bisect on x86_64 points to
the same patch as culprit.

Guenter

---
# bad: [8f84a21675f06c8aea55148ce37a618c6fe52a0b] Add linux-next specific files for 20181003
# good: [17b57b1883c1285f3d0dc2266e8f79286a7bef38] Linux 4.19-rc6
git bisect start 'HEAD' 'v4.19-rc6'
# bad: [ab92e1776a64d9894166e771faaaeecff890ec6e] Merge remote-tracking branch 'crypto/master'
git bisect bad ab92e1776a64d9894166e771faaaeecff890ec6e
# bad: [c850e425cfa466e5ce1d59dd3aad73ae4fd52ba9] Merge remote-tracking branch 'xfs/for-next'
git bisect bad c850e425cfa466e5ce1d59dd3aad73ae4fd52ba9
# good: [56fc7d0094442afc18b5106b8df7c59a3c36869d] arm-soc: document merges
git bisect good 56fc7d0094442afc18b5106b8df7c59a3c36869d
# bad: [4a83c1f489745f8e520a0686235f3a95b9374aab] Merge remote-tracking branch 'arm64/for-next/core'
git bisect bad 4a83c1f489745f8e520a0686235f3a95b9374aab
# bad: [6de4dcae0d1577efb3a551c7933945da033e9717] Merge remote-tracking branch 'dma-mapping/for-next'
git bisect bad 6de4dcae0d1577efb3a551c7933945da033e9717
# good: [ce41c6b97f00e24bb23412e17eb0d992a97ffb48] Merge remote-tracking branch 'net/master'
git bisect good ce41c6b97f00e24bb23412e17eb0d992a97ffb48
# good: [06f60b8cb4f884ae0c37b8f7095e021a7531cb87] Merge remote-tracking branch 'scsi-fixes/fixes'
git bisect good 06f60b8cb4f884ae0c37b8f7095e021a7531cb87
# good: [f9d39ce558b1455f8f91387d7238eb837735e325] Merge remote-tracking branch 'leaks/leaks-next'
git bisect good f9d39ce558b1455f8f91387d7238eb837735e325
# good: [f3ecc0ff0457eae93503792c6fc35921fa8a6204] dma-mapping: move the dma_coherent flag to struct device
git bisect good f3ecc0ff0457eae93503792c6fc35921fa8a6204
# good: [c6d4381220a0087ce19dbf6984d92c451bd6b364] dma-mapping: make the get_required_mask method available unconditionally
git bisect good c6d4381220a0087ce19dbf6984d92c451bd6b364
# good: [b4ebe6063204da58e48600b810a97c29ae9e5d12] dma-direct: implement complete bus_dma_mask handling
git bisect good b4ebe6063204da58e48600b810a97c29ae9e5d12
# bad: [6db37ad7c27bda2f62d1ef6ad0496e359c562c1a] dma-mapping: move dma_default_get_required_mask under ifdef
git bisect bad 6db37ad7c27bda2f62d1ef6ad0496e359c562c1a
# bad: [9d7a224b463e1cf1178570b57b6497240fd79bc3] dma-direct: always allow dma mask <= physiscal memory size
git bisect bad 9d7a224b463e1cf1178570b57b6497240fd79bc3
# first bad commit: [9d7a224b463e1cf1178570b57b6497240fd79bc3] dma-direct: always allow dma mask <= physiscal memory size
