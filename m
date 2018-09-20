Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA55EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A131A21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A131A21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbeIUCPd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:15:33 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:50206 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:15:33 -0400
Received: by mail-ua1-f74.google.com with SMTP id g9-v6so2445252uam.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=oosC3zBRlLJuSxO84A2MdK513CIgTm7cyXI638jW6VA=;
        b=Nh9QOkg0GLzufaQqJKcEj+O+Cv1NAY5UAYgx32xY0kr/gnZMKLRDIZWt+yqp6jmhkn
         ZELznpYnM7Rb7IQa+hOESobFvpAIPLvrSNlVoRUQ1QmtjfPrCgtWhOKv9VAw57GfD/+p
         IKsJ8vqjigVDTV8IsPJwQHFW2DdZPgnkS8c2oS7k/e5AAiib1pUb2R1U7zHYWdywywWZ
         mYMmCz8StuPFHaiGvJnrk1Nvx5o3f4nZ+R/WdB3N0o/GX/w/qxXHilu+RCP9GxbeG28X
         gauucJ/85PpaVd/o+08JgDGHxl1m7RXVX7KuMlqrPFaUZEdSukQYmBU+ZhPAyZ4T/rVk
         WO/A==
X-Gm-Message-State: APzg51DextLot+q1ticvZGNOta91B9vh5zNIn3jIhMWuWVkCEzshnAVK
        2yP581ZNIbiIU/g/ITQZNFOw3g==
X-Google-Smtp-Source: ANB0Vdaz/x16SsMD5hvODuctMMpIQD0c9+ASqHrDDmi8zzodrJGI4Y/7+Cm7wYOLTSUjdKQljXqnVfQr
X-Received: by 2002:a1f:9349:: with SMTP id v70-v6mr8303393vkd.58.1537475417665;
 Thu, 20 Sep 2018 13:30:17 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:29:42 -0700
Message-Id: <20180920202942.208509-1-zenczykowski@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH] usbip: fix vhci_hcd controller counting
From:   "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
To:     "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Dieter <jdieter@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

Without this usbip fails on a machine with devices
that lexicographically come after vhci_hcd.

ie.
  $ ls -l /sys/devices/platform
  ...
  drwxr-xr-x. 4 root root    0 Sep 19 16:21 serial8250
  -rw-r--r--. 1 root root 4096 Sep 19 23:50 uevent
  drwxr-xr-x. 6 root root    0 Sep 20 13:15 vhci_hcd.0
  drwxr-xr-x. 4 root root    0 Sep 19 16:22 w83627hf.656

Because it detects 'w83627hf.656' as another vhci_hcd controller,
and then fails to be able to talk to it.

Note: this doesn't actually fix usbip's support for multiple
controllers... that's still broken for other reasons
("vhci_hcd.0" is hardcoded in a string macro), but is enough to
actually make it work on the above machine.

See also:
  https://bugzilla.redhat.com/show_bug.cgi?id=1631148

Cc: Jonathan Dieter <jdieter@gmail.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Maciej Żenczykowski <zenczykowski@gmail.com>
---
 tools/usb/usbip/libsrc/vhci_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index 4204359c9fee..8159fd98680b 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -150,7 +150,7 @@ static int get_nports(struct udev_device *hc_device)
 
 static int vhci_hcd_filter(const struct dirent *dirent)
 {
-	return strcmp(dirent->d_name, "vhci_hcd") >= 0;
+	return !strncmp(dirent->d_name, "vhci_hcd.", 9);
 }
 
 static int get_ncontrollers(void)
-- 
2.19.0.444.g18242da7ef-goog

