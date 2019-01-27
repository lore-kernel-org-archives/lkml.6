Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D5BC4151A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826BC2184E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z95qUwXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfA0Jn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 04:43:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42429 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfA0Jn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 04:43:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so6449510plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 01:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4wt96ezv21X1O+EFi8O9ramir52ck0BWI5x6GktBbJY=;
        b=Z95qUwXkhvKOLOyHkPKceuSKDClXQUBMS3157K9afZ2TgwBC8Fy9nm8OS17A5uCjlN
         qE2Wy1y5km6hlMyidwWZBLdjR07tfQQxYhlINZBPsBLuJaueAlNbQDC+BEuiLMg58QUM
         wF4LWQc5MUheFNd70xznWLsgcs3diRK4uhtvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4wt96ezv21X1O+EFi8O9ramir52ck0BWI5x6GktBbJY=;
        b=jzPpQgZS8D6SA+Esw9DAOUntrF8nmd+JO+jX4X/0Owec0O8kDvZsgbw4RzDG14B4GH
         aQB5vnZZCHmQcBkEh/pVBknTZkK2t4CGqAJb5qGdkbxrPOADa6IXncTJ3QK5YTwys61F
         hmoUiBevRpy+NW3efRxP594doYYiK7WxOzBKTgBvUcgltnsNyN/tGHxNdegazLEu6JIg
         xm1t891IsaatFj3hER4nDc2iuKkMN6L5w0fP1IaRAcreu/5kLYFaaYFc4A0371jUL3lU
         PDTZeqjDZ/LEuzDA8Huv3Q2CvyQDIvLzyJIfbyXORtrP6v0NDxpnO1mPFpCC4z7Eqa8Q
         wEPQ==
X-Gm-Message-State: AJcUukfXazqQYfYuBksGmVSpA1q+KmCWBwoPHINoeUtxc206jU0Wuplt
        pBbHYpzg6cXqwytwooIwLYI4XQ==
X-Google-Smtp-Source: ALg8bN6kobbEzXRunvrsIBXKYTv54dvAGl0GvYxWjjpxX2Ey+UdII3q+gq8ncnWRU/bD/TTzM6Xc/g==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr17393048pll.33.1548582238647;
        Sun, 27 Jan 2019 01:43:58 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h69sm37401699pge.4.2019.01.27.01.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 01:43:57 -0800 (PST)
Date:   Sun, 27 Jan 2019 01:43:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH] selftests/seccomp: Actually sleep for 1/10th second
Message-ID: <20190127094357.GA9436@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang noticed that some none-zero sleep()s were actually using zero
anyway. This switches to nanosleep() to gain sub-second granularity.

seccomp_bpf.c:2625:9: warning: implicit conversion from 'double' to
      'unsigned int' changes value from 0.1 to 0 [-Wliteral-conversion]
                sleep(0.1);
                ~~~~~ ^~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 067cb4607d6c..a9f278c13f13 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2569,6 +2569,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 {
 	long ret, sib;
 	void *status;
+	struct timespec delay = { .tv_nsec = 100000000 };
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
@@ -2622,7 +2623,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
 	/* Poll for actual task death. pthread_join doesn't guarantee it. */
 	while (!kill(self->sibling[sib].system_tid, 0))
-		sleep(0.1);
+		nanosleep(&delay, NULL);
 	/* Switch to the remaining sibling */
 	sib = !sib;
 
@@ -2647,7 +2648,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 	EXPECT_EQ(0, (long)status);
 	/* Poll for actual task death. pthread_join doesn't guarantee it. */
 	while (!kill(self->sibling[sib].system_tid, 0))
-		sleep(0.1);
+		nanosleep(&delay, NULL);
 
 	ret = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_TSYNC,
 		      &self->apply_prog);
-- 
2.17.1


-- 
Kees Cook
