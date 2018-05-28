Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033787AbeE1PKv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033743AbeE1KX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:23:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 189/268] rtc: hctosys: Ensure system time doesnt overflow time_t
Date: Mon, 28 May 2018 12:02:43 +0200
Message-Id: <20180528100223.765558420@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit b3a5ac42ab18b7d1a8f2f072ca0ee76a3b754a43 ]

On 32bit platforms, time_t is still a signed 32bit long. If it is
overflowed, userspace and the kernel cant agree on the current system time.
This causes multiple issues, in particular with systemd:
https://github.com/systemd/systemd/issues/1143

A good workaround is to simply avoid using hctosys which is something I
greatly encourage as the time is better set by userspace.

However, many distribution enable it and use systemd which is rendering the
system unusable in case the RTC holds a date after 2038 (and more so after
2106). Many drivers have workaround for this case and they should be
eliminated so there is only one place left to fix when userspace is able to
cope with dates after the 31bit overflow.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/hctosys.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -49,6 +49,11 @@ static int __init rtc_hctosys(void)
 
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
+#if BITS_PER_LONG == 32
+	if (tv64.tv_sec > INT_MAX)
+		goto err_read;
+#endif
+
 	err = do_settimeofday64(&tv64);
 
 	dev_info(rtc->dev.parent,
