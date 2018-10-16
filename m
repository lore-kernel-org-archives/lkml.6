Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA987C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B49A2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kMGR1b8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B49A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJPWEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:04:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43070 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:04:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so21469184eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHN27KQ6yFIIIp4s95TmyBuNYCs1hvD4Fo3NP2Yl0is=;
        b=kMGR1b8Fxlvc7enhCQ/ZHnBJPbK/M8h3xzyGa8WGq4qvKravHybg+Zq85hZBUS337o
         phUMikrLJ0J7G504gp7s06zjygPqsFqDVg2CyN53e2ijxUidvc88wlLTZ7zJkJSWA95C
         2tr0Jp9JKSdEFvTzYfniIKROgny50tYfv+W58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHN27KQ6yFIIIp4s95TmyBuNYCs1hvD4Fo3NP2Yl0is=;
        b=RVmr6L02w1z68kwcjgCd3Q/nAo13Cw8Sv4CnBq4wmSzcLuGYV940TglntOs/pkunZ7
         vMAwJm0Svvf5juttO6ouXt7elcaG6vtS7gigWd3EgFhuGYSIf0QS5vXt4D8J9dCABGES
         /XW9KvHAC5rMNGvXoS7xx1YvvIqkYj4fpGgowBmP0hKj0+ZFCcMJqh8iD4JWUKsefFJv
         HOOFZJGV0MonF/RLJp7qBIyMNUz31f0GU21msAYT+Kqp8AUvvhMrrREjJea6GJ5bqNwJ
         vSeMsysiz2buiQIUc35Rn0jhjbZ+Wf+8OSC4P7vSuux/E7i6klQG6bZ5jIlteQvWyCre
         tObw==
X-Gm-Message-State: ABuFfohWIezfmAi17QG1LzHTVGvlm7IIKbV0+hr4Cks3JMUONNF4n5i6
        L8wQLjALMCu+/J/IQL3EdZctVA==
X-Google-Smtp-Source: ACcGV61cTI8KA5hznqKQMyeKVHaEVmaQ/0dOJ2ntGk3VF5hr9q0g2EPZAcFIki459wH3jyZhgJY5fw==
X-Received: by 2002:aa7:d615:: with SMTP id c21-v6mr29595039edr.286.1539699251687;
        Tue, 16 Oct 2018 07:14:11 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id h21-v6sm7059872eda.23.2018.10.16.07.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 07:14:10 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] selftests: kvm: Fix -Wformat warnings
Date:   Tue, 16 Oct 2018 16:13:46 +0200
Message-Id: <20181016141346.19922-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

dirty_log_test.c: In function ‘help’:
dirty_log_test.c:216:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Wformat=]
  printf(" -i: specify iteration counts (default: %"PRIu64")\n",
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/test_util.h:18:0,
                 from dirty_log_test.c:16:
/usr/include/inttypes.h:105:34: note: format string is defined here
 # define PRIu64  __PRI64_PREFIX "u"
dirty_log_test.c:218:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Wformat=]
  printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/test_util.h:18:0,
                 from dirty_log_test.c:16:
/usr/include/inttypes.h:105:34: note: format string is defined here
 # define PRIu64  __PRI64_PREFIX "u"

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 0c2cdc105f968..a9c4b5e21d7e7 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -31,9 +31,9 @@
 /* How many pages to dirty for each guest loop */
 #define  TEST_PAGES_PER_LOOP            1024
 /* How many host loops to run (one KVM_GET_DIRTY_LOG for each loop) */
-#define  TEST_HOST_LOOP_N               32
+#define  TEST_HOST_LOOP_N               32UL
 /* Interval for each host loop (ms) */
-#define  TEST_HOST_LOOP_INTERVAL        10
+#define  TEST_HOST_LOOP_INTERVAL        10UL
 
 /*
  * Guest variables.  We use these variables to share data between host
-- 
2.17.1

