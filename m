Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeBSQKK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:10:10 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51530 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeBSQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:10:09 -0500
X-Google-Smtp-Source: AH8x224xa9OBdzoOaYo5p6r5twK5bRycJMhSj3cht0GRaCQJ15NIKpJ1ygRArxIFs+61deiyiCIcdw==
Date: Mon, 19 Feb 2018 17:09:56 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: linux-kernel@vger.kernel.org, paul.burton@mips.com,
        geert@linux-m68k.org
Subject: [PATCH 3/3] auxdisplay: img-ascii-lcd: Silence 2 uninitialized
 warnings
Message-ID: <20180219160956.6uky4zxlnn5kas2t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warnings are:

  drivers/auxdisplay/img-ascii-lcd.c: warning: 'err' may be used
  uninitialized in this function [-Wuninitialized]

At lines 109 and 207. Reported by Geert using the build service
several times, e.g.:

  https://lkml.org/lkml/2018/2/19/303

They are two false positives, since num_chars > 0 in the three present
configurations (boston, malta, sead3). Initializing to an error state by
default silences the warning and makes the code print an error in case a
num_chars == 0 happens in the future (unlikely, since it does not make
sense currently).

The warnings seem to disappear starting with gcc >= 4.9

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
I will queue it up for 4.17.

drivers/auxdisplay/img-ascii-lcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index d8133024fd5d..bd5ebb5c516c 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -97,7 +97,7 @@ static struct img_ascii_lcd_config boston_config = {
 static void malta_update(struct img_ascii_lcd_ctx *ctx)
 {
 	unsigned int i;
-	int err;
+	int err = 1;
 
 	for (i = 0; i < ctx->cfg->num_chars; i++) {
 		err = regmap_write(ctx->regmap,
@@ -180,7 +180,7 @@ static int sead3_wait_lcd_idle(struct img_ascii_lcd_ctx *ctx)
 static void sead3_update(struct img_ascii_lcd_ctx *ctx)
 {
 	unsigned int i;
-	int err;
+	int err = 1;
 
 	for (i = 0; i < ctx->cfg->num_chars; i++) {
 		err = sead3_wait_lcd_idle(ctx);
-- 
2.14.1
