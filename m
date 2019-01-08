Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3535F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e0vvQH5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAHMw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:52:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53706 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:52:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so4034859wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 04:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0F4k4YtVOnMFo5jh8Gnlg0kYbmRjxVoumr7jiM5rHqI=;
        b=e0vvQH5rBGL9wdtGa6CX6FX0PiHKYqSFsB2gPVDMdafpp3kNWqnMmIrzImOF8kvQvb
         3lRaoMIxgcGd4Bhob0XP1P3lYOshXbea/F9o3nPPTqxBKZNv9Am5yOO873kv8cdgMUPl
         g9LWeoNpFqYrwxQ4+XKOumbIS9mqV8IzlAXXFZEIvJhkQ1eBEEDHqHf/jjeRFjoYmQTk
         625ky33Lb4X5A87OOGTUZK1ra1xdEeyYrw1EjdjeJ3/V1tQDrfvlRguuZGbTzkoojTYk
         MD3nVtFamo5LU/b63dDE7U98Gl4KqJEJRDVJsYYOBFenryAoxjrNdrn5vxwoxjHNawuT
         i7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0F4k4YtVOnMFo5jh8Gnlg0kYbmRjxVoumr7jiM5rHqI=;
        b=pkcqDL/bTD01zJvesU6cdpaWM3bV2OGVs0GCki/CInkq1LpgjzeY5piUXMFZa5I+uq
         N7MUM0U3EH6NNXAOJeOqF4JfaysMJGZXmGlakk63TE44NO1tzCHMi53XE9bKlo1KtvhN
         /hunE0Wc20BGdcNGNyVmJRnAXH162HGAZPABzxMZbUOR6pKzVllUcugk1OnXHwTS0WbZ
         S6glDgWwL348BL/bla/bQBLw3YfkXuWLx8mi2a3bSIUIKdyXLkBQbmU1XGV7qjWURGnZ
         ag85GUlOlbeqRzBzNsnIMvIuROMMwrNvyCHpj0dvbhAYfA4E3TT3hwZ2nDOIwSqN01sN
         6c2g==
X-Gm-Message-State: AJcUukduytepZNokN51NNTacBIHckm40mGOxgPhSHyiOmPuYe0jCutf9
        MFxqTqbYn4KWABtzOjH1n7lh7A==
X-Google-Smtp-Source: ALg8bN5yVh6pLVRUMaEv2IIrJnAVglcZ6pj1YNfX8iW6u0vavGa46yMZerCKWD8CFs4JPbv/ALzQJg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr1772220wmf.117.1546951976580;
        Tue, 08 Jan 2019 04:52:56 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 67sm81044121wra.37.2019.01.08.04.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Jan 2019 04:52:55 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     benh@kernel.crashing.org, mark.rutland@arm.com, mpe@ellerman.id.au,
        paulus@samba.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] powerpc: build virtex dtb
Date:   Tue,  8 Jan 2019 12:52:50 +0000
Message-Id: <1546951970-29079-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to test the virtex440-ml507 qemu machine and found that the dtb
for it was not builded.
All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
COMPILE_TEST.

This patchs adds build of virtex dtbs depending on
CONFIG_XILINX_VIRTEX440_GENERIC_BOARD option.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/powerpc/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..cae14fca682e 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -4,3 +4,5 @@ subdir-y += fsl
 
 dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb
+dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml510.dtb
-- 
2.19.2

