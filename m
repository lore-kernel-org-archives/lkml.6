Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADV0BQpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D5BB60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeFFRob (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:44:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44777 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752393AbeFFRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:44:29 -0400
X-Google-Smtp-Source: ADUXVKIxQi7Slbz/4uZxEColbO22KHfygo3U2F/3F9eOwBpWMWNaTmThOG+QTN4DMAKYNOywyuQA0Q==
From: Rafael David Tinoco <rafael.tinoco@linaro.org>
To: bamv2005@gmail.com
Cc: brgl@bgdev.pl, shuah@kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.tinoco@linaro.org
Subject: [PATCH] selftests: gpio: gpio-mockup-chardev GPIOHANDLE_REQUEST_OUTPUT fix
Date: Wed,  6 Jun 2018 14:44:24 -0300
Message-Id: <20180606174424.9630-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following logic from commit: 22f6592b23, GPIOHANDLE_REQUEST_OUTPUT
should handle errors same way as GPIOHANDLE_REQUEST_INPUT does, or else
the following error occurs:

gpio-mockup-chardev: gpio<gpiochip1> line<0> test flag<0x2> value<0>: No
such file or directory

despite the real result of gpio_pin_test(), gpio_debugfs_get() and
gpiotools_request_linehandle() functions.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index 667e916fa7cc..f8d468f54e98 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -225,10 +225,10 @@ int gpio_pin_test(struct gpiochip_info *cinfo, int line, int flag, int value)
 		if (flag & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			debugfs_value = !debugfs_value;
 
-		if (!(debugfs_dir == OUT && value == debugfs_value))
+		if (!(debugfs_dir == OUT && value == debugfs_value)) {
 			errno = -EINVAL;
-		ret = -errno;
-
+			ret = -errno;
+		}
 	}
 	gpiotools_release_linehandle(fd);
 
-- 
2.17.1
