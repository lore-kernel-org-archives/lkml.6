Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935374AbeE1KJ2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934596AbeE1KJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:09:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Pylypiv <igor.pylypiv@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 084/185] watchdog: f71808e_wdt: Fix magic close handling
Date: Mon, 28 May 2018 12:02:05 +0200
Message-Id: <20180528100057.757845303@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Pylypiv <igor.pylypiv@gmail.com>

[ Upstream commit 7bd3e7b743956afbec30fb525bc3c5e22e3d475c ]

Watchdog close is "expected" when any byte is 'V' not just the last one.
Writing "V" to the device fails because the last byte is the end of string.

$ echo V > /dev/watchdog
f71808e_wdt: Unexpected close, not stopping watchdog!

Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/f71808e_wdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -520,7 +520,8 @@ static ssize_t watchdog_write(struct fil
 				char c;
 				if (get_user(c, buf + i))
 					return -EFAULT;
-				expect_close = (c == 'V');
+				if (c == 'V')
+					expect_close = true;
 			}
 
 			/* Properly order writes across fork()ed processes */
