Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAB2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CBB26F70
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg5Jgkf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CBB26F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeF1FnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:43:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33568 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeF1Fm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:42:27 -0400
Received: by mail-qt0-f195.google.com with SMTP id l10-v6so3752388qtj.0;
        Wed, 27 Jun 2018 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/0oIdAJQ82SZA2/ZXbGDApWGaDEx6FEtMVbCz04/l0=;
        b=rg5Jgkf8TWb5/uFj4e7to7NBErwlBuCIoZxv2cWVuIVdJr4pCoS4uWjkcFdHQgOlpO
         u5RC7acnRH1NXwsExldV9ZDmDet6MWDQoAmCjOe0/Bf7qAoVwqsZs/ACa/hoULBsJjQu
         HS6u/EizrRoebRZP+nBNcXU09fHGoh0HSpcNvdEbJCJ0O21AEtWBTv59hwMZVmXoHP+X
         GGbhFYLRafuURzHp7yH+0ykfLm4wJaTp7tGLhRInPkwMabtShkLl4rwQdLjgh+UnmrgJ
         WCk6REVygKHduZUOHmxjB0vMHRyQr73sQQsJEN+lnuQY2r/Rtyz+9g7i/MgQMShuYsOs
         f0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J/0oIdAJQ82SZA2/ZXbGDApWGaDEx6FEtMVbCz04/l0=;
        b=t/klSqNX6WEuV11N5fBufunAgFgziPHWo+1hOB9tOdQX3GA1MMul0KgcU2P0xvvQHQ
         GNM09+jctknRl+aKI2E4PxHipEhEC26jwlbU8b0dMCjL4NaAohoGzdRGyBzJEZ3JHOjW
         z2tEqU8othBkn7ZQquDIhAebAivZILn1Q/wtHTGazbkFROeXLDHRZCiyYiCaUBXdR7hV
         vfd+x3qDWEC+yxHClJaj5G1PVQAYOfVaTZq7P0L6/iTGpIfLGlZxMhXaf9W/EIXZo06b
         tNXhZe0nUfZ4CwnW0k1xRZSI1ao3FNpYEMJ/+7eKsYi4Pccko1W/0YS6maZ42zt7Aqdj
         35Ag==
X-Gm-Message-State: APt69E0GmYgsGBtodii4Y487ezB57zMn7w/VvEIf2pLPHhQOa0CNtwgA
        repfLFv15iyD7wOcEGEtXFE=
X-Google-Smtp-Source: AAOMgpdk3iOW/AtiBHzmteHr83mLZjCXdXg01zHJLk4GkHv+VYto86pg946RoHBPhKjDfLh3bB90Fg==
X-Received: by 2002:ac8:2fc2:: with SMTP id m2-v6mr8048923qta.273.1530164546887;
        Wed, 27 Jun 2018 22:42:26 -0700 (PDT)
Received: from localhost.localdomain (186-106-135-170.baf.movistar.cl. [186.106.135.170])
        by smtp.gmail.com with ESMTPSA id u40-v6sm3410281qth.24.2018.06.27.22.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:42:26 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [RFC PATCH 2/5] dt-bindings: xilinx: Add missing zynq boards
Date:   Thu, 28 Jun 2018 01:42:02 -0400
Message-Id: <20180628054205.17737-3-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628054205.17737-1-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings were missing when adding the device-tree files
Also, improve description of existing boards

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 .../devicetree/bindings/arm/xilinx.txt        | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index b9043bc35..f1e911058 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -8,15 +8,33 @@ Required root node properties:
 
 Additional compatible strings:
 
-- Xilinx internal board cc108
+- Xilinx CC108 board
   "xlnx,zynq-cc108"
 
-- Xilinx internal board zc770 with different FMC cards
+- Avnet MicroZed board
+  "avnet,zynq-microzed"
+
+- Adapteva Parallella board
+  "adapteva,parallella"
+
+- Xilinx ZC702 board
+  "xlnx,zynq-zc702"
+
+- Xilinx ZC706 board
+  "xlnx,zynq-zc706"
+
+- Xilinx ZC770 board, with different FMC cards
   "xlnx,zynq-zc770-xm010"
   "xlnx,zynq-zc770-xm011"
   "xlnx,zynq-zc770-xm012"
   "xlnx,zynq-zc770-xm013"
 
+- Avnet ZedBoard board
+  "avnet,zynq-zed"
+
+- Digilent Zybo board
+  "digilent,zynq-zybo"
+
 - Digilent Zybo Z7 board
   "digilent,zynq-zybo-z7"
 
-- 
2.18.0

