Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523545997; cv=none;
        d=google.com; s=arc-20160816;
        b=FwoP4gW1T97ggFRTYn6PrxeoWiO8q6LkBYC9J3akohX2AjMKj/ZCDFbvs/C7KK93gb
         n4ZHwFwBj9+rtRBDkcdwfpnXLvWD2A8nLV7e8CC9maPZGLo/6eV928kSwa9mStwseSSb
         cB2O/rxi0wPcgL1rfOPW5cwOFT56yHc12ue/ylREc0mD520VtUwo5zeJWjrNDO460R+L
         FTlFuiRLQTMRgmRDgKQ+sVZDH9Dsft3ULMtfYj4qdfGEoTuOXNdesl4ZMYzBAYBfK3Sj
         qQ8QjZgz6vQxzYa6AT9nOtFETEZtab7/UUNaE9D4rkWJeBbmgujphNLRO6bS0AGddymp
         V/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=8TzyfpfA5ieOr/VpbEn9s17VsOy5oAiDgijXcT+WbCw=;
        b=q00BkLiIP3MbkyffiIWpiZ5nni1LfMsNaVlw+CLg3FcwtqGbf7E7NO1luCDe5/IYjy
         LB44DpPgfPiffA1OMvwXkaiKRVwB40imdD3Ywj1hhK6gU5BxzcEHwXH37J/vKMWtbyHC
         34oA1uDVem/HO4O3eDPPcJNQTmxy1AmHc8dOTVXIjlcKKI7qxKQeYKwWqOD0YIdw3MU3
         CiWHWRiY9t22sqURGxq4ngW1Pm8PjHkWcpsoVRzpM+WmzCwDx7ZGdxjnPctu984mzeST
         Ar7vNapAQkCTaDXR10hO/BBbJDCiVijqybjtO3IgJ1jz13WkidsjGGjkkyDrMxc4d2S9
         vuDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=agdUhIbP;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=agdUhIbP;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/+V4rptqxzWd7CuA0UTvLzyvGH3VvZxFsesjCAlf2Z9i8wUt14pjAVqhDNabtyaSZU7kzfeQ==
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Meyer <thomas@m3y3r.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/intel_pstate: Enhance table printing
Date: Thu, 12 Apr 2018 10:12:28 -0500
Message-Id: <1523545962-5281-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597553768695349642?=
X-GMAIL-MSGID: =?utf-8?q?1597553768695349642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using coreutils' pr, a nicer table is printed out with the
results.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/intel_pstate/run.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index bde31a0..a40068b 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -92,18 +92,28 @@ done
 
 [ $EVALUATE_ONLY -eq 0 ] && cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
 
-echo "=============================================================================="
+echo "========================================================================"
 echo "The marketing frequency of the cpu is $mkt_freq MHz"
 echo "The maximum frequency of the cpu is $max_freq MHz"
 echo "The minimum frequency of the cpu is $min_freq MHz"
 
 # make a pretty table
-echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
+echo "Target Actual Difference MSR(0x199) max_perf_pct" | tr " " "\n" > /tmp/result.tab
 for freq in `seq $max_freq -100 $min_freq`
 do
 	result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
 	msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
 	max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
-	echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
+	cat >> /tmp/result.tab << EOF
+$freq
+$result_freq
+$((result_freq - freq))
+$msr
+$((max_perf_pct * max_freq))
+EOF
 done
+
+# print the table
+pr -aTt -5 < /tmp/result.tab
+
 exit 0
-- 
2.7.4
