Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeDSMuz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:50:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33438 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753516AbeDSMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:50:50 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shuah Khan <shuah@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] selftests: timers: rtcpie: restore previous PIE rate
Date: Thu, 19 Apr 2018 14:50:28 +0200
Message-Id: <20180419125030.5076-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
References: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the test ends, restore the PIE rate to its previous value to be less
disruptive.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 tools/testing/selftests/timers/rtcpie.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index ea98b1f6ac17..47b5bad1b393 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -28,7 +28,7 @@ static const char default_rtc[] = "/dev/rtc0";
 int main(int argc, char **argv)
 {
 	int i, fd, retval, irqcount = 0;
-	unsigned long tmp, data;
+	unsigned long tmp, data, old_pie_rate;
 	const char *rtc = default_rtc;
 	struct timeval start, end, diff;
 
@@ -51,7 +51,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Read periodic IRQ rate */
-	retval = ioctl(fd, RTC_IRQP_READ, &tmp);
+	retval = ioctl(fd, RTC_IRQP_READ, &old_pie_rate);
 	if (retval == -1) {
 		/* not all RTCs support periodic IRQs */
 		if (errno == EINVAL) {
@@ -61,7 +61,7 @@ int main(int argc, char **argv)
 		perror("RTC_IRQP_READ ioctl");
 		exit(errno);
 	}
-	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", tmp);
+	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", old_pie_rate);
 
 	fprintf(stderr, "Counting 20 interrupts at:");
 	fflush(stderr);
@@ -124,6 +124,8 @@ int main(int argc, char **argv)
 	}
 
 done:
+	ioctl(fd, RTC_IRQP_SET, old_pie_rate);
+
 	fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
 
 	close(fd);
-- 
2.17.0
