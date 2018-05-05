Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZqslvoLPpWwbmEiLCUKxjcKDmf0UjEkG7hEV4TzdSFquWT+oMwJ2zGBWFxISoDuNXWt58Dr
ARC-Seal: i=1; a=rsa-sha256; t=1525483057; cv=none;
        d=google.com; s=arc-20160816;
        b=DdIptzNyAGQrQYpWcfdbxF9bZL4QsSlSkJ8BbVmbgBs1WMSmap8Oc3xc658/Hp1BM2
         TQW/gY7EFTOlYtuQcRf7+dmkyy4858bn9AauHm6GhNyKArXWQaKRZjzHqGHDWySX90+5
         tUtItcxbNY6RFBzj2j0ApbKSlNMCL3oVJJFq4xAiNNBj4MYg0VUPzYvWwD+BoBNv3RMp
         OHU67HpxIBtjsC2esz6li1RgJL8UgegR+weU2rKpdiijStBDBIiuKHSITffks9HaDNxi
         4goQMzxeZ5lajO0kST8n+C0ZvHIk1cirWz2EywQaGNig4cmRMlXh+DXhy43xPwlVKL9M
         SvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jIj0KAWIQac+v7Sp45+B8E7ftJ6Op/XDakMPMqL+17s=;
        b=hJ3ZDd8flwqiU7dnnRkxmhjTpHttlH5f1+ANKvpmsxFe+UnlJR4tJUCb+vmx2khEcf
         WNF5Y50/z6VVMR2krP/L2c7fSXvXgE/8z5DX2deGOETfmxibJhnHVt6GBm9UaiuQzcL0
         domL9ztV2bpLmSKS3z/ZNDPSPtid2glmS8dlsjXwfWL6+6GLMBS3myv9QdilHPf1ujoN
         rjh5MfiwnMO7+i8S9yz3/u0jBauVW26rXlNWprEMCkbcPHcMU7P1GEoTF/u3eeP/66Ji
         Iqbe0f7NnEwAZ7aO2DG19zQdkIWsrtjjm6UV8wjGahEz8crQXx4SYaWO75HQU6PvImI8
         bcMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org,
	mathieu.desnoyers@efficios.com,
	gregkh@linuxfoundation.org,
	paul.elder@pitt.edu,
	alice.ferrazzi@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/24] selftests: membarrier: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:24 -0600
Message-Id: <20180505011328.32078-20-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599584921671110620?=
X-GMAIL-MSGID: =?utf-8?q?1599584921671110620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When membarrier test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as a
fail by the Kselftest framework. This leads to false negative result
even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Change it to use ksft_exit_skip() when the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/membarrier/membarrier_test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 22bffd55a523..6793f8ecc8e7 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -293,10 +293,9 @@ static int test_membarrier_query(void)
 		}
 		ksft_exit_fail_msg("sys_membarrier() failed\n");
 	}
-	if (!(ret & MEMBARRIER_CMD_GLOBAL)) {
-		ksft_test_result_fail("sys_membarrier() CMD_GLOBAL query failed\n");
-		ksft_exit_fail_msg("sys_membarrier is not supported.\n");
-	}
+	if (!(ret & MEMBARRIER_CMD_GLOBAL))
+		ksft_exit_skip(
+			"sys_membarrier unsupported: CMD_GLOBAL not found.\n");
 
 	ksft_test_result_pass("sys_membarrier available\n");
 	return 0;
-- 
2.14.1
