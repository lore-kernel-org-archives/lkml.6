Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676B221903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap4r5TtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeLWHm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 02:42:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37199 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeLWHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 02:42:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so6601963lfj.4;
        Sat, 22 Dec 2018 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iC8A1bdkXlOcTCFfxx0MsCJweZ6paKTeFnEkuDpu0U=;
        b=ap4r5TtCKdFFOhDG4vq0kSsMwXPbHZQYfliUQ9HhP1Imo3jqyNP5wLXneRbOgz663M
         w7W1gcBZxXk76xLNRKBi1IfZT/J35Xn3y2YsvK47WDcmi5KfFTMZGOY0rBcdvKnNL1WN
         UM/yfh5+RfwebJ25r/tWezkGnGwKrERUAZ9xIVvrLZRZbykFXYAm9yeNORshtNhGudBO
         xhHTEpMemhdSKO7VtPPeI2sSjEhYiO+hlBwJ/x+8/D7wMwGH5iB7g4pxy6kiKmEmmvG8
         DiTFl/0Xm1P8FTzS4Zfa2rlc+ikTv0wbMSxeMcYkcdftbhtA30qZXReoSRKrCmIKVO0T
         cRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iC8A1bdkXlOcTCFfxx0MsCJweZ6paKTeFnEkuDpu0U=;
        b=OsE0TZZd3xM588RH1ldsNpBbDdd2EaJWVjvID6ELAoghjk61bNAVfWgrsxogQeButd
         kpFJdDWqnSCBAerSBbHZ6lueqqgE1Dsc8rJ0RJPIimfsfom9IKX5XfhytslCQzhHO38L
         gCPYQ1qVGiGhuGdUrkQa9yD2plSpaPM0UVq3lcympNwyZr3F/poNLxDre/jzFoc7t7Sw
         zP+Ls9v1WrbGiuWhhYynWuBPVoCCmG0LnAlWvlOhHt/lSHcKax4jzmva71T4agG7Awyo
         G0rPoCgGBchg4fln/NOj2Wv5l/R/+biQ9aV2TMWSnVmShLvB/mHOfMtwrpvCoOxgcR0K
         +tSQ==
X-Gm-Message-State: AA+aEWYjkWUaZVT3Cit0fpTxYNaQO5GXyPCwvBOSFP8bWmQ1SbL6OSu1
        JVKo2aTitGq2NMYyUklMcHcpAJvwsq8=
X-Google-Smtp-Source: AFSGD/VGAR928jUHXqWxitpVzekn/XjhDh2XVsEMH/00XLQtjZpI2aqPGciP50QpoXUuLaiQFAseRw==
X-Received: by 2002:a19:a86:: with SMTP id 128mr4306294lfk.139.1545550945214;
        Sat, 22 Dec 2018 23:42:25 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id g4-v6sm5769341lji.17.2018.12.22.23.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 23:42:24 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [PATCH] scsi: sd: Fix cache_type_store()
Date:   Sun, 23 Dec 2018 12:41:58 +0500
Message-Id: <20181223074158.22796-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing of caching mode via /sys/devices/.../scsi_disk/.../cache_type
may fail if device responses to MODE SENSE command with DPOFUA flag set,
and then checks this flag to be not set on MODE SELECT command.

When trying to change cache_type, write always fails:
	# echo "none" >cache_type
	bash: echo: write error: Invalid argument

And following appears in dmesg:
	[13007.865745] sd 1:0:1:0: [sda] Sense Key : Illegal Request [current]
	[13007.865753] sd 1:0:1:0: [sda] Add. Sense: Invalid field in parameter list

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/scsi/sd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index bd0a5c694a97..698fe651fb1a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -206,6 +206,21 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 	sp = buffer_data[0] & 0x80 ? 1 : 0;
 	buffer_data[0] &= ~0x80;
 
+	/* From SBC-4 r15, 6.5.1 "Mode pages overview", description of
+	 * DEVICE-SPECIFIC PARAMETER field in the mode parameter header:
+	 *     ...
+	 *     The write protect (WP) bit for mode data sent with a MODE SELECT
+	 *     command shall be ignored by the device server.
+	 *     ...
+	 *     The DPOFUA bit is reserved for mode data sent with a MODE SELECT
+	 *     command.
+	 *     ...
+	 * All other bits are also reserved, and all reserved bits shall be set
+	 * to zero according to the same document. So, we can simply set this
+	 * field to zero for compatibility.
+	 */
+	data.device_specific = 0;
+
 	if (scsi_mode_select(sdp, 1, sp, 8, buffer_data, len, SD_TIMEOUT,
 			     SD_MAX_RETRIES, &data, &sshdr)) {
 		if (scsi_sense_valid(&sshdr))
-- 
2.20.1

