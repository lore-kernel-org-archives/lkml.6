Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZqN2ZTPWSewBBjDgbPKf+1F9CwGIYiLslNxL+rmPt/rSAG91ZcWLb8QyAr92X1/cwEWYB/t
ARC-Seal: i=1; a=rsa-sha256; t=1525482846; cv=none;
        d=google.com; s=arc-20160816;
        b=R4RitKhWYBIh3N5ARmRY5634ervYXAPe5US7/5zt4gpRRPWbZogQqU4ftNnNXpLPo/
         2vNXFcmd5eAZuKcLIhmyX21JY/ELUHE0YcTzqZ170yU8Y5UdFPGyy31ke+qEDapFu38l
         HVV6GWfwdqG/DlJlNINvLldOu0Ep1HtuuIaziGLxy15eHvtqRvbUjfdAxYEMUajUNnWX
         b1jM7cPSLi/IIjxNmul6aHiTF4AFHaSTqRooICUszqDtNcX213rGfqFX48cAPHau503j
         zjwAUYXa3krwIMJWHBirXWq3D14l+5EfuOR4p5UCWurE5Vq+Vtu6JTfcjI/RZVSkER+X
         D/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/t2tmPh1BldkUUk+5nen586DGUrUbmaVdG7hkYcc7lA=;
        b=LgbaMQeo6Cppfrsn7SRR9y6xKem/hdJAaSR6XeejBiqQzUadKnlnvBy/KPzEf0IUYJ
         ioSNtGaH7AJmZRzY2EIM8XomWI0qDHqxS52+37C5YF2N9Dg6RZGC4z8ENySnBiknm7x9
         GVBUGKxlilrzqzyY9sB/DsSsiFRHzPiNYuufnaDsHjiAHchPsuJ1Bn06+0Ku51KSdmK5
         Fj+u+4IfgGWe6dYOxfOZ5HRbMSjQQK8Y1hucFx2J9RB5Do/1k3Pk2EaqepVeBKJmgxEZ
         gRvwrGPGcK6ao4S4GNzI0DTunsWsH/bklr7YrOqzXFfgJ4gb/2TBFU8vlwmgf9TFvsYP
         apiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org,
	paul.elder@pitt.edu,
	gregkh@linuxfoundation.org,
	alice.ferrazzi@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/24] selftests: breakpoints: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:06 -0600
Message-Id: <20180505011328.32078-2-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599584701577962652?=
X-GMAIL-MSGID: =?utf-8?q?1599584701577962652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When step_after_suspend_test is skipped because of unmet dependencies
and/or unsupported configuration, it exits with error which is treated
as a fail by the Kselftest framework. This leads to false negative result
even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Change it to use ksft_exit_skip() when a non-root user runs the test and
add an explicit check for root and a clear message, instead of failing
the test when /sys/power/state file open fails.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 3fece06e9f64..f82dcc1f8841 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -143,10 +143,14 @@ void suspend(void)
 	int err;
 	struct itimerspec spec = {};
 
+	if (getuid() != 0)
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
+
 	power_state_fd = open("/sys/power/state", O_RDWR);
 	if (power_state_fd < 0)
 		ksft_exit_fail_msg(
-			"open(\"/sys/power/state\") failed (is this test running as root?)\n");
+			"open(\"/sys/power/state\") failed %s)\n",
+			strerror(errno));
 
 	timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
 	if (timerfd < 0)
-- 
2.14.1
