Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC79AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869A920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livid.pp.ru header.i=@livid.pp.ru header.b="jBqouk0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfAOQO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:14:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33949 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbfAOQO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:14:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so3020763ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=livid.pp.ru; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TB4Cm8e2Fl64TYPTWBUE8YQgabZLtz0Yy0eRN0D9Nc=;
        b=jBqouk0MMQ0gHtVJrZtiRjDJ4+EEMV0st2D2YWwkMurTAQwC/Onm8LZf43WQLvhWuq
         KW4K1t05HKETjp3XdxHV+d93AhOIjVFOwDeob375sSnZ2AjLpchUN84xPMOPPSnw/EsN
         YcOVTJN/jgTvW/51VLt+NxdWU26Ec6EB0AhVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TB4Cm8e2Fl64TYPTWBUE8YQgabZLtz0Yy0eRN0D9Nc=;
        b=jiCRS/ZTMaT/YesYHwnhLhAHTO4DPZRnOewTtsD7gKwKWHhP72Gf0Y8VIrnrb8F4MI
         waXAJLSv0qMQU8vfN7DY5qoRm1UGgnxvFp/efptD9jKy9aSczxmK1dniS5z5yhteF1j7
         t1DXjo4DPHzIcpJMApPYdwue/kIRjKV/OdOOeT+BRCdlLu//QwNRGNIvhLPqyYiUexI6
         gLMN1RBjVd0VcvfXGLsOPJkyL4IPwcd7qGPu/3j/L0OWjB18YIlFh1YhOzzU7jnXGble
         Zs6+WKs16donBqV/mr5qPinWaRFhFBzfk+wiwSanCsYssoR4+hJZKmmyPKOAkz1XNKfb
         rTEg==
X-Gm-Message-State: AJcUukecO8V8IMFT0TFXGLesoXLaXibirCaneFyzxIqWQZgEOlGquGF5
        iQurtLxEE477P1tIH7hIAbIoSQ==
X-Google-Smtp-Source: ALg8bN5EK4thpIeGAb/I3NyNVH6+f4AVjazb8zkxd11XTAPe7pfOudtFEuWoEmUQVNN1IPgGXwi11g==
X-Received: by 2002:a17:906:351a:: with SMTP id r26-v6mr3546188eja.193.1547568864264;
        Tue, 15 Jan 2019 08:14:24 -0800 (PST)
Received: from livid.lan ([2001:470:71:c0c::d0e5:a55])
        by smtp.gmail.com with ESMTPSA id r51sm5029101eda.64.2019.01.15.08.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:14:23 -0800 (PST)
From:   Nikolay Yakimov <root@livid.pp.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nikolay Yakimov <root@livid.pp.ru>,
        Saranya Gopal <saranya.gopal@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Fix configuration selection issues introduced in v4.20.0
Date:   Tue, 15 Jan 2019 19:13:54 +0300
Message-Id: <20190115161354.6806-1-root@livid.pp.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f13912d3f014a introduced changes to the usb_choose_configuration function
to better support USB Audio UAC3-compatible devices. However, there are a few
problems with this patch. First of all, it adds new "if" clauses in the middle
of an existing "if"/"else if" tree, which obviously breaks pre-existing logic.
Secondly, since it continues iterating over configurations in one of the branches,
other code in the loop can choose an unintended configuration. Finally,
if an audio device's first configuration is UAC3-compatible, and there
are multiple UAC3 configurations, the second one would be chosen, due to
the first configuration never being checked for UAC3-compatibility.

Commit ff2a8c532c14 tries to fix the second issue, but it goes about it in a
somewhat unnecessarily convoluted way, in my opinion, and does nothing
to fix the first or the last one.

This patch tries to rectify problems described by essentially rewriting
code introduced in f13912d3f014a. Notice the code was moved to *before*
the "if"/"else if" tree.

Signed-off-by: Nikolay Yakimov <root@livid.pp.ru>
---
 drivers/usb/core/generic.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index f713cecc1f41..1ac9c1e5f773 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -118,6 +118,31 @@ int usb_choose_configuration(struct usb_device *udev)
 			continue;
 		}
 
+		/*
+		 * Select first configuration as default for audio so that
+		 * devices that don't comply with UAC3 protocol are supported.
+		 * But, still iterate through other configurations and
+		 * select UAC3 compliant config if present.
+		 */
+		if (desc && is_audio(desc)) {
+			/* Always prefer the first found UAC3 config */
+			if (is_uac3_config(desc)) {
+				best = c;
+				break;
+			}
+
+			/* If there is no UAC3 config, prefer the first config */
+			else if (i == 0)
+				best = c;
+
+			/* Unconditional continue, because the rest of the code
+			 * in the loop is irrelevant for audio devices, and
+			 * because it can reassign best, which for audio devices
+			 * we don't want.
+			 */
+			continue;
+		}
+
 		/* When the first config's first interface is one of Microsoft's
 		 * pet nonstandard Ethernet-over-USB protocols, ignore it unless
 		 * this kernel has enabled the necessary host side driver.
@@ -132,25 +157,6 @@ int usb_choose_configuration(struct usb_device *udev)
 #endif
 		}
 
-		/*
-		 * Select first configuration as default for audio so that
-		 * devices that don't comply with UAC3 protocol are supported.
-		 * But, still iterate through other configurations and
-		 * select UAC3 compliant config if present.
-		 */
-		if (i == 0 && num_configs > 1 && desc && is_audio(desc)) {
-			best = c;
-			continue;
-		}
-
-		if (i > 0 && desc && is_audio(desc)) {
-			if (is_uac3_config(desc)) {
-				best = c;
-				break;
-			}
-			continue;
-		}
-
 		/* From the remaining configs, choose the first one whose
 		 * first interface is for a non-vendor-specific class.
 		 * Reason: Linux is more likely to have a class driver
-- 
2.20.1

