Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92604C6780B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578E920652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJjrpn3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578E920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeJLCMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:12:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37831 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbeJLCMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:12:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id x8-v6so6127172qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3bQQWocC3HuwOzt4zpfsSQh51EQpWfENSgZkqebcms=;
        b=JJjrpn3dYWGiwscpAnbnWMRxHGkH3W1d+cbHnr+1utxQXyqUCqB8vp9gQbHRyOSF2P
         I9gKAE4+L/AeibS+8kK90a0EPKcJoKdtIOsa1gGR8hjB9fXISPur5eQi8C7pUBd/OVyG
         dmYQb+24p3saB7iZ1iNMOEorqETweiIXnhL90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3bQQWocC3HuwOzt4zpfsSQh51EQpWfENSgZkqebcms=;
        b=TG9nc4hHYol0VzaCaVXVpN6KaoDWOR+rECJURbSV/lagB4RXVx4Znr4nu36+aGbiJj
         qX9xEMPgs0oCL4Tw6lvR8t3n8Fnh0EE6z2c8ht2zL0jwzQiyaMYtvGJN993E2Hz1hhF3
         QcUu+oSTRCfsZtk8nqr/guWfLktFxWFPE3DuMQLpe53OqncsRXwSjkq0epoxDUsIQgPo
         wvbKjpQgkFVn+ruobQXB/zd01OAvIdMuJ9W0rWTvSmdF5JMB93HoWQ7Xszph7q/gr7s1
         yQeDgJlv9DDbPgjvUZ3KQOemTeobrUD67rWAbY/N2QWV4Bt0xVjT3ajBaLYcyCq9vGwQ
         0u3g==
X-Gm-Message-State: ABuFfohfm3zAo/ui3lNrWJ+/aOJuW4kwaUrKim/o6IlpOaSEqcrbCq6f
        k9WZQcQsSxi59t2ZMz10puy0+w==
X-Google-Smtp-Source: ACcGV61VagJLOMsUTxVNqCZOTfTQkWoTvyccBjuxtLw181lnNvTI3TfOP1Jid+DZlkYtApwDgYg+nA==
X-Received: by 2002:a37:6cc3:: with SMTP id h186-v6mr2731001qkc.49.1539283444694;
        Thu, 11 Oct 2018 11:44:04 -0700 (PDT)
Received: from workstation.celeiro.br ([138.204.25.12])
        by smtp.gmail.com with ESMTPSA id 18-v6sm18527434qtm.13.2018.10.11.11.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 11:44:03 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gorcunov@gmail.com, rafael.tinoco@linaro.org,
        akpm@linux-foundation.org, shuah@kernel.org, adobriyan@gmail.com
Subject: [PATCH] proc: fix proc-self-map-files selftest for arm
Date:   Thu, 11 Oct 2018 15:43:59 -0300
Message-Id: <20181011184359.15627-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAP_FIXED is important for this test but, unfortunately, lowest virtual
address for user space mapping on arm is (PAGE_SIZE * 2) and NULL hint
does not seem to guarantee that when MAP_FIXED is given. This patch sets
the virtual address that will hold the mapping for the test, fixing the
issue.

Link: https://bugs.linaro.org/show_bug.cgi?id=3782
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 tools/testing/selftests/proc/proc-self-map-files-002.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index 6f1f4a6e1ecb..0a47eaca732a 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -55,7 +55,9 @@ int main(void)
 	if (fd == -1)
 		return 1;
 
-	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
+	p = mmap((void *) (2 * PAGE_SIZE), PAGE_SIZE, PROT_NONE,
+			MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
+
 	if (p == MAP_FAILED) {
 		if (errno == EPERM)
 			return 2;
-- 
2.19.1

