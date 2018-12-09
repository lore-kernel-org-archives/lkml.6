Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C04C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1872081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRouTrVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1872081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLINyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 08:54:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLINyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 08:54:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so7880755wrt.13;
        Sun, 09 Dec 2018 05:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
        b=MRouTrVj72aJHi/oL5sJu3n78v8HyQ4+bSXQ8+nlkavs3lkOMnCAERi4yMuiPEUjq+
         tFg5gYZ71B+VdAjQl9a47qwL4ecjryE+iITLoGIKJQ11WaIBm4rrucVl62RQvr8xK3bZ
         wL/152r8VN4PwvaSQMwqef8UKdp6+xKLfsPzPYJLZnOnonCYvl0/FrVeSUV4Aq9775SS
         pklLzJ4xQFuotaXAmq5XrXrShZeAjZPiH5ygtGeL8NtpJCeDTAB5fCTd5m/oSLlvBjWz
         abDZKWtJj312UcykC1fLQ1CKwcklpJw2B4pPUGCVQUDOUISdrCdAjRsriUwru9aGsCGE
         Io5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
        b=aW0iU6kLuSus5mQTHvlhFVI+JT5BrFwF7wb5zktQswSt3WrSkSsIK07qNY9fXGJ9jv
         py33djFCy/pkW4rdXtuwESs4Bh3W1R1Uu0p4qlNs6RjHG0pxJ9lSmBNOoO9jZ6NWt9L4
         i9MqeEHYxitjYBCm7k959VBPJbE1GHyswgxlrizy1IJHVNVtxhiitQAojz1QMuRw2z4i
         7Ba+DytoGyjCitpMQFNzGmIzBdoxPP1IHNbzWycCXJ399YRBb88AG5OzB4UzV9TIxMlE
         jGEe1NrZopl7+l7/fZJvJJfBHO4E5g/Qx0J0bM5hPbPnV5bRIIPcxJ99ZkPseZgC261T
         AaBA==
X-Gm-Message-State: AA+aEWabnRGelLBL4mDF/AHA1OB8E13s9QFlHiQu59fGU+jjl6i7bzig
        mPEYB0Idu6PK+SkJvESy4dQ=
X-Google-Smtp-Source: AFSGD/U1f13BFk1GmH1h5GH9qXtgedLUaXOPbXGP/73LQNrgQT/8Uc8bRSqrXCkjn/Yo7Nxfevm9hQ==
X-Received: by 2002:a5d:524b:: with SMTP id p11mr6700257wrv.147.1544363669513;
        Sun, 09 Dec 2018 05:54:29 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (dgv239.neoplus.adsl.tpnet.pl. [83.23.177.239])
        by smtp.gmail.com with ESMTPSA id k128sm12271795wmd.37.2018.12.09.05.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 05:54:29 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH 5/5] spi: stm32: add description about STM32F4 bindings
Date:   Sun,  9 Dec 2018 14:53:56 +0100
Message-Id: <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add description that STM32F4 can be used in compatible property.
Master Inter-Data Idleness optional property cannot be used in STM32F4.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 1b3fa2c1..d82755c 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,9 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32h7-spi".
+- compatible: Should be one of:
+  "st,stm32h7-spi"
+  "st,stm32f4-spi"
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -30,8 +32,9 @@ Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
 
 Optional properties:
-- st,spi-midi-ns: (Master Inter-Data Idleness) minimum time delay in
-		  nanoseconds inserted between two consecutive data frames.
+- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
+		  delay in nanoseconds inserted between two consecutive data
+		  frames.
 
 
 Example:
-- 
2.7.4

