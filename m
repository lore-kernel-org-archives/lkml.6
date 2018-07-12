Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED0AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC262146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvtBacOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC262146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeGLESh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:18:37 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46848 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeGLESg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:18:36 -0400
Received: by mail-qt0-f194.google.com with SMTP id d4-v6so7547472qtn.13;
        Wed, 11 Jul 2018 21:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNkTkgCQGwaRWHwSYhiv6kv+rs/VwVKSGBLCuRmN3Mg=;
        b=CvtBacOA4VQoU2/qUHybpf2XhGOexUpOsjL207KrOW/nLav4rSr7a+KSixRFcAGymI
         5qlhmRZO3CyCuyhqwaBTKafEgRkW9+dtpklVDBJ99BiHKppmXqlb7+5QC4Zf57hvTs6g
         j88QW3zAgDklYmtOsoWeTc1sNSH34PfTZ7nZE5qFYp0ETmW4JV6EhdRZR4w6Lb+5X6TW
         brkT26a2K5NBc+m8IFRMPq985Qs1LWdf28McBX91neXmYFSCn8bBHJ8oGckp+FwEIzjE
         DRyYVK2vAp2Q/Q4c6Yg2gs7cG7KFjJc8RosbnGa7OQHVG4Qs8TuaAYNJE1zvIoDE4mUh
         MWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNkTkgCQGwaRWHwSYhiv6kv+rs/VwVKSGBLCuRmN3Mg=;
        b=D5xF5gzyaEdVzIc2szK6k6PeK8WMArFWS5bq8UaIreMZL/JzEPBA8MWY98okD1ZLxJ
         nRSACM4UyKldTeaLAtecMaQGyzJz+wsBi24erNyOVKC3o47wRMK50aYXqe9le7k68Qng
         5rU57Qt6pOLuN0dhGFFHhqQOiyKMqSH5WnxE4xgTOGDtPqZUYvKCuXQ8k9maU8Hi/HCt
         6/MkJnAST+aCFHIdbdMZsQYwdVBiVBOxhUB1z5BPTcHDVRiyRt2j+OsNIuM0GHHmxgAC
         gZlvfyJNbRyT3TGXc2mO6adqQ1vdgXjgH4DvaE36hbjJf1TDNVd6NX9/jIBlePh+EdvM
         etBw==
X-Gm-Message-State: AOUpUlG7Cx8MrDb4ZUmXJ71E0iYMYaMg50i+Iitag1u7bgKCBf9l6Bog
        L8MBPvMzmM0xp265PJP9Tms=
X-Google-Smtp-Source: AAOMgpdg3KHv4oQzwF2hj2ilFxM26Ogy1D6HncWrB1+Pc0MDBbHsIjbQN74SrlRmFFZtwtEkYbCqUQ==
X-Received: by 2002:ac8:489:: with SMTP id s9-v6mr469217qtg.173.1531368656260;
        Wed, 11 Jul 2018 21:10:56 -0700 (PDT)
Received: from localhost.localdomain (186-106-119-105.baf.movistar.cl. [186.106.119.105])
        by smtp.gmail.com with ESMTPSA id m51-v6sm7260115qtc.85.2018.07.11.21.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 21:10:55 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v3 4/6] dt-bindings: xilinx: zynq: Sort entries alphabetically
Date:   Thu, 12 Jul 2018 00:10:22 -0400
Message-Id: <20180712041024.20583-5-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort additional compatible strings (boards) alphabetically
by their manufacturer and model number

This will help when finding a board because they
will be grouped by their manufacturer

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 Documentation/devicetree/bindings/arm/xilinx.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 4f1759b2bea7..a8e70a794d2e 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -8,6 +8,9 @@ Required root node properties:
 
 Additional compatible strings:
 
+- Digilent Zybo Z7 board
+  "digilent,zynq-zybo-z7"
+
 - Xilinx CC108 internal board
   "xlnx,zynq-cc108"
 
@@ -17,9 +20,6 @@ Additional compatible strings:
   "xlnx,zynq-zc770-xm012"
   "xlnx,zynq-zc770-xm013"
 
-- Digilent Zybo Z7 board
-  "digilent,zynq-zybo-z7"
-
 ---------------------------------------------------------------
 
 Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
-- 
2.18.0

