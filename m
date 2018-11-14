Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A5621780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TPVtcwuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A5621780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeKOFzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:55:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKOFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SbIHJ6Qgb/UHyCHdpX/ITanH1IL6ffpfB5+IP7GGx3w=; b=TPVtcwuv9buopKaIpi9AnOXfyI
        7pheUl2J9ylPqOXFwvb3/5VaGOdauuJJgGpFbEyRjDjIIqlMVK+J55aP+HXzqxqw3rK1O9qnjj4FT
        PVGekG429kZlqkjK/rTFQh4t392zzFvzkpwYVfIyECzUJdgQb0MM3hoTkviUj3Cw7pP4=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gN1Bd-0004Ka-7D; Wed, 14 Nov 2018 19:50:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0DB5144007A; Wed, 14 Nov 2018 19:50:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC 2/2] selftests/x86/fsgsbase: Default to trying to run the test repeatedly
Date:   Wed, 14 Nov 2018 11:50:43 -0800
Message-Id: <20181114195043.8021-3-broonie@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114195043.8021-1-broonie@kernel.org>
References: <20181114195043.8021-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In automated testing it has been found that on many systems the fsgsbase
test fails intermittently.  This was reported and discussed a while
back:

    https://lore.kernel.org/lkml/20180126153631.ha7yc33fj5uhitjo@xps/

with the analysis concluding that this is a hardware issue affecting a
subset of systems but no fix has been merged as yet.  As well as the
actual problem found by testing the intermittent test failure is causing
issues for the people doing the automated testing due to the noise.

In order to make the testing stable modify the test program to iterate
through the test repeatedly, choosing 5000 iterations based on prior
reports and local testing.  This unfortunately greatly increases the
execution time for the selftests when things succeed which isn't great,
in my local tests on a range of systems it pushes the execution time up
to approximately a minute when no failures are encountered.

Reported-by: Dan Rue <dan.rue@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 6cda6daa1f8c..83410749ff1f 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -379,7 +379,7 @@ static void test_unexpected_base(void)
 	}
 }
 
-int main()
+int test()
 {
 	pthread_t thread;
 
@@ -437,3 +437,28 @@ int main()
 
 	return nerrs == 0 ? 0 : 1;
 }
+
+int main()
+{
+	int tries = 5000;
+	int i;
+
+	if (tries > 1)
+		quiet = true;
+
+	for (i = 0; i < tries; i++) {
+		if (test() != 0)
+			break;
+	}
+
+	if (quiet) {
+		if (nerrs) {
+			printf("[FAIL] %d errors detected in %d tries\n",
+				nerrs, i + 1);
+		} else {
+			printf("[PASS] %d runs succeeded\n", i);
+		}
+	}
+
+	return nerrs == 0 ? 0 : 1;
+}
-- 
2.19.1

