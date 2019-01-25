Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9856C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B78218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pCOpj7QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAYHJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:09:41 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49398 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfAYHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:09:40 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0P79685005418;
        Fri, 25 Jan 2019 16:09:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0P79685005418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548400149;
        bh=WRJv1jJ47KBMznet3o5QY0xF48L7ExBwayWhvperHXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCOpj7QU2RPJ6WtncXSvWLMZ7HSyPD4llCORnpgfS9JvOkOv0A5hgd02rgcODAeTu
         BjNGZpVgEwAM5Qbu1OB1mUCM5+W+z7999KORNAd/YOcUgRC+mlG9CfgvuaFZulPXcW
         XQa9NAHlR0ai2KWNxvVYTqztvOFCz6UuqudequCu3SY71QJD1KvGoDCeBfkLec4/MU
         MwRcf7f5a+tHKeG0mCJFGsMW1bSGsT655VqRAGcRp6Jcsvcy8qp7zMMyC0BmUjn+DI
         jLQzxjvOXXHpZt7ROOqVS3iPG/M2c1mAorKeS7gMWhAjYd2c5RPmJbaDvf40GDf6yh
         26NBrMpI1UDMg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Don Brace <don.brace@microsemi.com>,
        esc.storagedev@microsemi.com, Hannes Reinecke <hare@suse.com>,
        linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH 1/2] scsi: remove unneeded header search paths
Date:   Fri, 25 Jan 2019 16:09:03 +0900
Message-Id: <1548400144-22513-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548400144-22513-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548400144-22513-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was able to build without these extra header search paths.

Especially, the header search path -I. in kernel Makefiles is always
suspicious; it allows the compiler to search for headers in the top
of $(srctree), where obviously no header file exists.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/scsi/aacraid/Makefile  | 2 --
 drivers/scsi/aic7xxx/Makefile  | 1 -
 drivers/scsi/smartpqi/Makefile | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/scsi/aacraid/Makefile b/drivers/scsi/aacraid/Makefile
index 1bd9fd1..3893b95 100644
--- a/drivers/scsi/aacraid/Makefile
+++ b/drivers/scsi/aacraid/Makefile
@@ -4,5 +4,3 @@ obj-$(CONFIG_SCSI_AACRAID) := aacraid.o
 
 aacraid-objs	:= linit.o aachba.o commctrl.o comminit.o commsup.o \
 		   dpcsup.o rx.o sa.o rkt.o nark.o src.o
-
-ccflags-y	:= -Idrivers/scsi
diff --git a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
index c15be25..e0188ec 100644
--- a/drivers/scsi/aic7xxx/Makefile
+++ b/drivers/scsi/aic7xxx/Makefile
@@ -34,7 +34,6 @@ aic79xx-y					+= aic79xx_osm.o	\
 						   aic79xx_proc.o	\
 						   aic79xx_osm_pci.o
 
-ccflags-y += -Idrivers/scsi
 ifdef WARNINGS_BECOME_ERRORS
 ccflags-y += -Werror
 endif
diff --git a/drivers/scsi/smartpqi/Makefile b/drivers/scsi/smartpqi/Makefile
index e6b7799..a03a6ed 100644
--- a/drivers/scsi/smartpqi/Makefile
+++ b/drivers/scsi/smartpqi/Makefile
@@ -1,3 +1,2 @@
-ccflags-y += -I.
 obj-$(CONFIG_SCSI_SMARTPQI) += smartpqi.o
 smartpqi-objs := smartpqi_init.o smartpqi_sis.o smartpqi_sas_transport.o
-- 
2.7.4

