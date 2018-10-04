Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A97C2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbtwD4IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A97C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJDVXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:23:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46895 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJDVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:23:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so8715707edg.13;
        Thu, 04 Oct 2018 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RlGjeXvjSkgA9ZE6YC/H1m5aigBd7dElYUI6fpZSv/8=;
        b=rbtwD4IBzCggWgsSr3+/FDqo1Bc2X2gVB/N+PSogg/hjrWNlZrYeznab0lS2YHhELz
         WUpv3c/i8ndzSoCGzaOh8PzL5wdAlnIsuXlvlKyhwJ32dtzAI5BS/OL9vdFQxIsY27Cf
         lLAltxre+aSH3+36AO5SF/upSC0AjViIKukKVlTt40Oxg8rKjjl9fHcYT02rxmuKub3N
         Z1ZySNUHLF+9auNHUz6qXTayqId/hb5XtvWJzV2POK+GR3YDByAUyZ2DXxP63JQH40Qv
         WBpep2S1UAz9RtGW1SE4pERXINMPlmTiU+c/EelV8t+O2m+m5GiwHAOFf22ZubfxI0SD
         e3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RlGjeXvjSkgA9ZE6YC/H1m5aigBd7dElYUI6fpZSv/8=;
        b=Gf4A4o0LYo6mIuV0CxMQ0hjjQJVzrEA6RlgLEUR0oH/z7qKFZ3fNw9AbqI+tzY+tD7
         kGdGzvoTdkF54ct5z28DieHykw6cWD0AlWo6iLdAjQA6UWYl+WJ0JpB9b1VTjuY41XWu
         a2Qu54HefPPp+nTd1i14qzZmZA0n8LyX8Pcc8eDTjgVJ992Y6S3G3rHK3pCMrUVNy4uk
         jsm6sR5wwpIr1YettxrPlc4JQqoi3lVHO8UFyenTD2AfA8Q6U1TeC08+H3kU0b+c3GzN
         VrhVZaTa9GyvdjJic5PwpTmNP5pBkf1TmjvClVc0bsdXSfcxSSkXgjGa+T8RygODvwIb
         8lsQ==
X-Gm-Message-State: ABuFfohVrfj/OgfXlbQfdmmtzLk+zrbg3QBWzDGChlJ1HwKr/ysJJEgh
        MNHGjqQ4QBrTo573maebPpI=
X-Google-Smtp-Source: ACcGV63ScYQDLmo5mhPN58Q0WiSThhY7s8ka1mDaedQl3d8tXHrBYYOqR4DMWz4s5gYLlZXt/cqdGQ==
X-Received: by 2002:aa7:c60d:: with SMTP id h13-v6mr3853914edq.9.1538663385535;
        Thu, 04 Oct 2018 07:29:45 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id j15-v6sm892228ejy.3.2018.10.04.07.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 07:29:43 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v10 09/10] dt-binding: mtd: Document gpio-addr-flash
Date:   Thu,  4 Oct 2018 16:29:41 +0200
Message-Id: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for gpio-addr-flash. This binding allow creating
flash devices that are paged using GPIOs.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index 232fa12e90ef..7df0dcaccb7d 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -29,6 +29,8 @@ file systems on embedded devices.
  - use-advanced-sector-protection: boolean to enable support for the
    advanced sector protection (Spansion: PPB - Persistent Protection
    Bits) locking.
+ - addr-gpios : (optional) List of GPIO descriptors that will be used to
+   address the MSBs address lines. The order goes from LSB to MSB.
 
 For JEDEC compatible devices, the following additional properties
 are defined:
-- 
2.19.0

