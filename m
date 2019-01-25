Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BEC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87029218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MQHU+TxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfAYHJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:09:24 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:48923 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfAYHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:09:24 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0P79686005418;
        Fri, 25 Jan 2019 16:09:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0P79686005418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548400150;
        bh=Vpn6bjURzAVS1rpEMtJUUe+enwqt45OopaWYKJnvavg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQHU+TxIv4+a+PFQXAx/U8YFlpzc983Q1mO8xetF1ENicMLFvTRGj5A84sKjfb7o4
         DslC9k8hGY1RjVcTM3qxvM5za9eyTJ/w6XIDIYbBEcyYtCvb11EN0RYLFpKhp3T5QB
         fNYD3lNEoiQflLz+fCXlU4LoMTUEPsxVqdFOBz1w4igO+g4MDRya73nHwKbAdM1m3P
         rXDXt+6KhZgxvBG156IRFVQAP/6A6qhv44g3nX7Eb/eYeVCANLM5zdocx9U8P3GXQ3
         g9zkyc9Rk9sHBoJ9XPRJwuBxXczncPiy+bahuHR+kIRbMtWWRcEXcb0nNWxrR2+bzf
         gLjqYahSutU9w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: prefix header search paths with $(srctree)/
Date:   Fri, 25 Jan 2019 16:09:04 +0900
Message-Id: <1548400144-22513-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548400144-22513-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548400144-22513-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/scsi/cxgbi/Makefile  | 2 +-
 drivers/scsi/pcmcia/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxgbi/Makefile b/drivers/scsi/cxgbi/Makefile
index a73781a..f78c9cc 100644
--- a/drivers/scsi/cxgbi/Makefile
+++ b/drivers/scsi/cxgbi/Makefile
@@ -1,4 +1,4 @@
-ccflags-y += -Idrivers/net/ethernet/chelsio/libcxgb
+ccflags-y += -I $(srctree)/drivers/net/ethernet/chelsio/libcxgb
 
 obj-$(CONFIG_SCSI_CXGB3_ISCSI)	+= libcxgbi.o cxgb3i/
 obj-$(CONFIG_SCSI_CXGB4_ISCSI)	+= libcxgbi.o cxgb4i/
diff --git a/drivers/scsi/pcmcia/Makefile b/drivers/scsi/pcmcia/Makefile
index faa87a4..a5a24dd 100644
--- a/drivers/scsi/pcmcia/Makefile
+++ b/drivers/scsi/pcmcia/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-ccflags-y		:= -Idrivers/scsi
+ccflags-y		:= -I $(srctree)/drivers/scsi
 
 # 16-bit client drivers
 obj-$(CONFIG_PCMCIA_QLOGIC)	+= qlogic_cs.o
-- 
2.7.4

