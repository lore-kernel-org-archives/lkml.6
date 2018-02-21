Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeBUVdm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:33:42 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42000 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBUVdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:33:41 -0500
X-Google-Smtp-Source: AH8x227Hdt3TRGUbzz0AxRb2QMkFpbrz+Mj5cxl9lZmB+eBmJTp3zi5pU4Cx1sDg4fNeoifbUfMY7w==
From: Anders Roxell <anders.roxell@linaro.org>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] tools/gpio/gpio-event-mon: fix warning
Date: Wed, 21 Feb 2018 22:33:34 +0100
Message-Id: <20180221213334.19969-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRIu64 is defined in user space to match libc's uint64_t definition.
However, gpioevent_data structure in the kernel is defined using the
kernel's own __u64 type.

gpio-event-mon.c: In function ‘monitor_device’:
gpio-event-mon.c:102:19: warning: format ‘%lu’ expects argument of type
    ‘long unsigned int’, but argument 3 has type ‘__u64 {aka long long
    unsigned int}’ [-Wformat=]
   fprintf(stdout, "GPIO EVENT %" PRIu64 ": ", event.timestamp);
                   ^~~~~~~~~~~~~~
  LD       /tmp/kselftest/gpiogpio-event-mon-in.o
  LINK     /tmp/kselftest/gpiogpio-event-mon

Fix is to replace PRIu64 with llu, which we know is what the kernel uses
for __u64.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/gpio/gpio-event-mon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
index dac4d4131d9b..c864544efe05 100644
--- a/tools/gpio/gpio-event-mon.c
+++ b/tools/gpio/gpio-event-mon.c
@@ -99,7 +99,7 @@ int monitor_device(const char *device_name,
 			ret = -EIO;
 			break;
 		}
-		fprintf(stdout, "GPIO EVENT %" PRIu64 ": ", event.timestamp);
+		fprintf(stdout, "GPIO EVENT %llu: ", event.timestamp);
 		switch (event.id) {
 		case GPIOEVENT_EVENT_RISING_EDGE:
 			fprintf(stdout, "rising edge");
-- 
2.11.0
