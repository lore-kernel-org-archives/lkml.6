Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D0EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E21721A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AaE1TiC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E21721A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbeHFTYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:24:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbeHFTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XoT6Gt/bhdCsgWM5hGFIwiDMcKEIRgtWaEv+1nMFoOo=; b=AaE1TiC0yNz+qOmLHz7BNKOH7E
        BOry97PVzq5JACxwh+DvsvzL2+gxcE2oL0FeDCEF0bqmyJYCxhp3dHYN+dOPKj5q8V8VeuzBuyyM7
        HLTP2IVR3uSVrcIWrWvkRLRGlJtjyT9xrFJO3j518r01pOWNBwvy7pIPk75t0YiC0vOJK6hKa3uGK
        2941x0D5abXffwDnNqQKlBnLPPf5+iERiW5Upv03j4pv+kE3Sg5drLoLyDKduHZVOoVAlUoMrViQg
        35OyX3Twq3JR/GFD3amgyTLB/xkd5nKVcFNc7xurfR3i8FSLz6aIySAlhZsTpx7QhFLpMUhZj7FAL
        3CPZAC9g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmj4y-0002iO-8B; Mon, 06 Aug 2018 17:14:00 +0000
To:     linux-scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, target-devel@vger.kernel.org
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] target: fix tcm_loop build errors when SCSI=m
Message-ID: <5b7b9c12-d202-ab0c-9598-267468bf10ad@infradead.org>
Date:   Mon, 6 Aug 2018 10:13:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_SCSI=m and CONFIG_LOOPBACK_TARGET=y
by making LOOPBACK_TARGET depend on SCSI.

drivers/target/loopback/tcm_loop.o: In function `tcm_loop_port_link':
tcm_loop.c:(.text+0x445): undefined reference to `scsi_add_device'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_driver_remove':
tcm_loop.c:(.text+0x55c): undefined reference to `scsi_remove_host'
tcm_loop.c:(.text+0x564): undefined reference to `scsi_host_put'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_submission_work':
tcm_loop.c:(.text+0x7c4): undefined reference to `scmd_printk'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_driver_probe':
tcm_loop.c:(.text+0x7fb): undefined reference to `scsi_host_alloc'
tcm_loop.c:(.text+0x85b): undefined reference to `scsi_add_host_with_dma'
tcm_loop.c:(.text+0x896): undefined reference to `scsi_host_put'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_port_unlink':
tcm_loop.c:(.text+0x962): undefined reference to `scsi_device_lookup'
tcm_loop.c:(.text+0x972): undefined reference to `scsi_remove_device'
tcm_loop.c:(.text+0x97a): undefined reference to `scsi_device_put'
drivers/target/loopback/tcm_loop.o:(.data+0x210): undefined reference to `scsi_change_queue_depth'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: linux-scsi@vger.kernel.org
Cc: target-devel@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/target/loopback/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180806.orig/drivers/target/loopback/Kconfig
+++ linux-next-20180806/drivers/target/loopback/Kconfig
@@ -1,5 +1,6 @@
 config LOOPBACK_TARGET
 	tristate "TCM Virtual SAS target and Linux/SCSI LDD fabric loopback module"
+	depends on SCSI
 	help
 	  Say Y here to enable the TCM Virtual SAS target and Linux/SCSI LLD
 	  fabric loopback module.


