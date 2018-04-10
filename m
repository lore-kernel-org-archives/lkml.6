Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523398313; cv=none;
        d=google.com; s=arc-20160816;
        b=L78RcdPhgukYJL03qEwjeuwuas1317PxBqy5W/RLj3Hghv7Yfm8zdvQzmXweeDLKeQ
         hVWDyyWOD02o+OH/pw5NWldRN4Dhn0XxBSqhf9deTgzkKOSvlyOPXdSBq7c+DlMrW92T
         fdLr+3Jcv+GIJINAAK9v+smiyvvCg+jHTizsgf6pJpR6y87F3jC1dK4LcCObNy0Cl94L
         DUiZIW6XJbmP548KTj+xGG2IbaG7Dx+6kk1CmPaUi1ywD9G0NJDCAEFmYJrtbws+qsk1
         KqVpGFsAx+bk83JO3loC8n/+n3JBaY/rF76VHXRBV083CoTOiET5IhGtYimXu4+9JvIZ
         yHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=FzYdj1ir5hsaCB5SEkneo6//D13q3KA/6xRS5O7atq0=;
        b=LYCxUhiwiY50qPqlqhK2fGDH11Pn0pKvqNOHjcfO/JAoyDNAUXh+fwki2Yxw5dy9kR
         Oz4WViHJnsjsCxhjJsRvmCN1gvO3lmmDjqT5A/VGLR4jTKZRgNzmQdlxKdWK+ZLpzS8e
         fpxPcM0FgMptABFCJnsuRWYL2cDhB5EYfwGtSj3equJHtw083MkvSGr5TkaeMR4ygKsP
         OftznltigodGEFC+8oWIWDq9avriOGYL0k578ofzuFQ7EpvDTD+udC2VWgUXc83dbA9h
         /Z/E/CyaBj66qDKiXb083uiQ7QTJ2KhngIVvQEr7CpTMGyl5CjUuzVyeaYCs5H1ISmJs
         lgaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=U3HQ513B;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=U3HQ513B;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49iEJRRb0Qwrczft/NJ70iOQYL31mZkDR7zhLu9ysh4Sxuen2/q0WGmvGF3KudsitgftGEjQw==
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Meyer <thomas@m3y3r.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/intel_pstate: Improve test, minor fixes
Date: Tue, 10 Apr 2018 17:11:15 -0500
Message-Id: <1523398277-2066-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597398910011233262?=
X-GMAIL-MSGID: =?utf-8?q?1597398910011233262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A few changes improve the overall usability of the test:
* fix a hard-coded maximum frequency (3300),
* don't adjust the CPU frequency if only evaluating results,
* fix a comparison for multiple frequencies.

A symptom of that last issue looked like this:
  ./run.sh: line 107: [: too many arguments
  ./run.sh: line 110: 3099
  3099
  3100-3100: syntax error in expression (error token is \"3099
  3100-3100\")

Because a check will count how many differente frequencies
there are among the CPUs of the system, and after they are
tallied another read is performed, which might produce
different results.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/intel_pstate/run.sh | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index c670359..bde31a0 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -48,11 +48,12 @@ function run_test () {
 
 	echo "sleeping for 5 seconds"
 	sleep 5
-	num_freqs=$(cat /proc/cpuinfo | grep MHz | sort -u | wc -l)
-	if [ $num_freqs -le 2 ]; then
-		cat /proc/cpuinfo | grep MHz | sort -u | tail -1 > /tmp/result.$1
+	grep MHz /proc/cpuinfo | sort -u > /tmp/result.freqs
+	num_freqs=$(wc -l /tmp/result.freqs | awk ' { print $1 } ')
+	if [ $num_freqs -ge 2 ]; then
+		tail -n 1 /tmp/result.freqs > /tmp/result.$1
 	else
-		cat /proc/cpuinfo | grep MHz | sort -u > /tmp/result.$1
+		cp /tmp/result.freqs /tmp/result.$1
 	fi
 	./msr 0 >> /tmp/result.$1
 
@@ -82,21 +83,20 @@ _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
 max_freq=$(($_max_freq / 1000))
 
 
-for freq in `seq $max_freq -100 $min_freq`
+[ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
 do
 	echo "Setting maximum frequency to $freq"
 	cpupower frequency-set -g powersave --max=${freq}MHz >& /dev/null
-	[ $EVALUATE_ONLY -eq 0 ] && run_test $freq
+	run_test $freq
 done
 
-echo "=============================================================================="
+[ $EVALUATE_ONLY -eq 0 ] && cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
 
+echo "=============================================================================="
 echo "The marketing frequency of the cpu is $mkt_freq MHz"
 echo "The maximum frequency of the cpu is $max_freq MHz"
 echo "The minimum frequency of the cpu is $min_freq MHz"
 
-cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
-
 # make a pretty table
 echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
 for freq in `seq $max_freq -100 $min_freq`
@@ -104,10 +104,6 @@ do
 	result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
 	msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
 	max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
-	if [ $result_freq -eq $freq ]; then
-		echo " $freq        $result_freq             0          $msr         $(($max_perf_pct*3300))"
-	else
-		echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
-	fi
+	echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
 done
 exit 0
-- 
2.7.4
