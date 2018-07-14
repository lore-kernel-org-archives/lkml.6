Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B151DECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9012089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moVx00wR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9012089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbeGNSQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:16:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40004 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeGNSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:16:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so12073052wma.5;
        Sat, 14 Jul 2018 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=nJ07e3EU6D3iJDu1OpVCnrcSdkBWfTEuq7+hx58QrGk=;
        b=moVx00wRnLZi0BHC8Hk/3MlXIIvQCYWb+OGj72rSsftI/WSqe04QW+X2+FkU4PmszL
         rhgveJQeig7+Zvule0a3Lm/wIlL7zGS49yDkQ+zeEZ4SckczYvp6OVii1LXrCAlvuJIq
         lznAZecS5avDP+2MK/3XYsFqYEffKfPCQd3io0Ge/0+N3LAs4ZcHqVUtW6hrF0osPGUi
         qdUBqAPUFn+zqhpr3LMRADGR/z3a1PnMYWQvGyFlpYGlUii3YjUUvtb7rOiqXHv+KMxx
         NJnat1ql8GpG6Uz3fVnaq1uTzISimKdHlPMXhF9U4KKd3iOJqVt7fvK0JhcOKMqwfyVB
         viLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=nJ07e3EU6D3iJDu1OpVCnrcSdkBWfTEuq7+hx58QrGk=;
        b=Zv8qM8CLIich+LujESU/G3YJLjlWkIwvAwvYGWM6cl60/aj/TDCik2NSY4fTTE4GW6
         YOEhq8RowLp5mmCxbZx8OtNvDiPxbyRg3F/7RdwjnffEj2MFnbnNoawDrwMgRfg/87nd
         QHdjgB0Alhz/qL9RsA6cG++RtjQhkzIknylmqTKEDKOmSVnH0i4z3Wh/NlyyhGMafJrL
         qkLABl/CwR4a1Id2NhQpvQ4oH96cMoQA8JVUnton9WcjjZLRK/zZ5q6KdJk+z+OwVObT
         U9K/6qwSFldzaEt5tGVCs3RLQE5pSLDkeij/DGL9yyKON2r9uEquQ2IYmgGEwzfhkIvZ
         F4oQ==
X-Gm-Message-State: AOUpUlHLUGTQtzLDt8CfW0GlkJoBf7lLFz7Mw/37Eigd3mx6vNSlximD
        25bMxKT79Sp5UGNc7erx0t8Tew==
X-Google-Smtp-Source: AAOMgpcXcFlkUsiBuc1b7hwQPAmNO9ZrdSL3zisYbvd55m7b2kzwyqiVsIeyaURs/x23B53zLnsfeA==
X-Received: by 2002:a1c:5cd:: with SMTP id 196-v6mr6766229wmf.114.1531590997615;
        Sat, 14 Jul 2018 10:56:37 -0700 (PDT)
Received: from dvbdev.wuest.de (ip-176-199-111-147.hsi06.unitymediagroup.de. [176.199.111.147])
        by smtp.gmail.com with ESMTPSA id z5-v6sm36694027wrv.2.2018.07.14.10.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 10:56:36 -0700 (PDT)
From:   Daniel Scheller <d.scheller.oss@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mark ddbridge, stv0910, stv6111 and mxl5xx orphan
Date:   Sat, 14 Jul 2018 19:56:34 +0200
Message-Id: <20180714175634.29827-1-d.scheller.oss@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Scheller <d.scheller@gmx.net>

I'm definitely not interested to try to maintain drivers in a subsystem/
tree anymore where the subsystem maintainer prefers to have changes
bitrot for months, rejects patches for idiotic reasons and, ontop, simply
ignores emails (lots of) with ie. questions to any requested changes, or
questions in general.

I'd happily continue taking care of these drivers (it's fun and I surely
have time for this, albeit everything being hobbyist, volunteer and
unpaid work). Though recalling all the latest actions and the fact that
the initial series that got the ball rolling at all being ignored for
over four(!) months, I'm now out of this business. This is not about
"getting work done".

Signed-off-by: Daniel Scheller <d.scheller@gmx.net>
---
 MAINTAINERS | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bbd9b9b3d74f..658a677554d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8830,11 +8830,10 @@ F:	drivers/media/dvb-frontends/cxd2880/*
 F:	drivers/media/spi/cxd2880*
 
 MEDIA DRIVERS FOR DIGITAL DEVICES PCIE DEVICES
-M:	Daniel Scheller <d.scheller.oss@gmail.com>
 L:	linux-media@vger.kernel.org
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-S:	Maintained
+S:	Orphan
 F:	drivers/media/pci/ddbridge/*
 
 MEDIA DRIVERS FOR FREESCALE IMX
@@ -8879,11 +8878,10 @@ S:	Supported
 F:	drivers/media/dvb-frontends/lnbh25*
 
 MEDIA DRIVERS FOR MXL5XX TUNER DEMODULATORS
-M:	Daniel Scheller <d.scheller.oss@gmail.com>
 L:	linux-media@vger.kernel.org
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-S:	Maintained
+S:	Orphan
 F:	drivers/media/dvb-frontends/mxl5xx*
 
 MEDIA DRIVERS FOR NETUP PCI UNIVERSAL DVB devices
@@ -8954,19 +8952,17 @@ F:	Documentation/devicetree/bindings/media/renesas,vsp1.txt
 F:	drivers/media/platform/vsp1/
 
 MEDIA DRIVERS FOR ST STV0910 DEMODULATOR ICs
-M:	Daniel Scheller <d.scheller.oss@gmail.com>
 L:	linux-media@vger.kernel.org
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-S:	Maintained
+S:	Orphan
 F:	drivers/media/dvb-frontends/stv0910*
 
 MEDIA DRIVERS FOR ST STV6111 TUNER ICs
-M:	Daniel Scheller <d.scheller.oss@gmail.com>
 L:	linux-media@vger.kernel.org
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-S:	Maintained
+S:	Orphan
 F:	drivers/media/dvb-frontends/stv6111*
 
 MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
-- 
2.16.4

