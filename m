Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32455C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07BA20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OO2p7d+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07BA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeHaCAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:00:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46815 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeHaCAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:00:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so4473247pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNkXjyd/TJwjJQq5sEuLkOphZyxbub4Zs7WyVtO+UM0=;
        b=OO2p7d+CZgD4xu58qnmC/I+WtDMVinCv2sRX+QxYmOggLJ6HEFrSO5eq3Xwd8yOO3I
         2YD0a33Qp016oqh0a0lciOhz2xY9q7NxcgvCrMbbaVJJineVysS91WrHY84ZLuoZyNMd
         okn84jvHPZ4wzARZvMvhFwOwkyIgsDQHf/sKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNkXjyd/TJwjJQq5sEuLkOphZyxbub4Zs7WyVtO+UM0=;
        b=jP2JSv0kMj+KlwuSIevfxD7quJAiR/NA4pAiWxF36eRnnLRl1vwOnF9Vw2Q5M8LExj
         fMUS6HZQeH+Py4PugEZnaPoCuGNccEqIe7Tg4ozRbH7ZpFQaK81D0E7wBKVcP2NQMWL2
         VvMBtFIO3NMzAev6slH2aloLfhRozwaKro+71DzDufr0SScaxCrgVtdPtCJpBOfKO4rX
         y/dP9zwa2mw7TnYIywmu1Spm41oo1zEf8Yl2IgZfxe07b+72tfH5mWoFmLqoa9Up7VvH
         F9ZwF7DJifJoso8SfjNoYGsBaDWpqXbXAHNKURY45NxVuu8X2EePpGoM1PkLU7Ucd58b
         +DLQ==
X-Gm-Message-State: APzg51D1zjzX0VZLK9oKVvKfWNzmE1AE1Ymq6rkF90aQyxp2oTO9dfcM
        TSHe1H5wZXOdcBOkTYfBiVskQQ==
X-Google-Smtp-Source: ANB0VdbNkl8lbvHPMvyngVgpXh3ZSQLD2vCCYre8H6NFVp07Ua62TVik9DMEPfWU76DNHJGykuMSzA==
X-Received: by 2002:a63:f501:: with SMTP id w1-v6mr6830908pgh.446.1535666188590;
        Thu, 30 Aug 2018 14:56:28 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id h132-v6sm13516828pfc.100.2018.08.30.14.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:56:28 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 1/5] Add the `REL_WHEEL_HI_RES` event code
Date:   Thu, 30 Aug 2018 14:56:18 -0700
Message-Id: <20180830215622.47550-2-hcutts@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
References: <20180830215622.47550-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event code represents scroll reports from high-resolution wheels,
and will be used by future patches in this series. See the linux-input
"Reporting high-resolution scroll events" thread [0] for more details.

[0]: https://www.spinics.net/lists/linux-input/msg57380.html

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

Changes in v2: None

 Documentation/input/event-codes.rst    | 11 ++++++++++-
 include/uapi/linux/input-event-codes.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index a8c0873beb95..cef220c176a4 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -190,7 +190,16 @@ A few EV_REL codes have special meanings:
 * REL_WHEEL, REL_HWHEEL:
 
   - These codes are used for vertical and horizontal scroll wheels,
-    respectively.
+    respectively. The value is the number of "notches" moved on the wheel, the
+    physical size of which varies by device. For high-resolution wheels (which
+    report multiple events for each notch of movement, or do not have notches)
+    this may be an approximation based on the high-resolution scroll events.
+
+* REL_WHEEL_HI_RES:
+
+  - If a vertical scroll wheel supports high-resolution scrolling, this code
+    will be emitted in addition to REL_WHEEL. The value is the (approximate)
+    distance travelled by the user's finger, in microns.
 
 EV_ABS
 ------
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 53fbae27b280..dad8d3890a3a 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -708,6 +708,7 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
+#define REL_WHEEL_HI_RES	0x0a
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

