Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF865C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3320831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CNL1TxkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A3320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbeKTPxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:53:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34928 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbeKTPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:53:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so426346pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 21:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zlg2BFvpO7N1LBcQOttmC1j4ff35OqfPa7Fz4hl7aNc=;
        b=CNL1TxkS1xvKvPZcGrbZbweiOfD4Pjg27Q/Pu5prr2NEG9NsAVXQB/cPZTVq3tyMEf
         IJx11gETOKnP2M3HzrXEcnGT6ra/1aI8fhqp3VosMYIf+rxLmpdN5vjBcRUiTB+aMlKj
         NfcZr2BWyROpf4Kg4RvYTDmFHzp6YeV+HuPGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlg2BFvpO7N1LBcQOttmC1j4ff35OqfPa7Fz4hl7aNc=;
        b=OXpnQQG5jkGuHcZBvEqKHEDxppiqOkflkOltbkkYhruBp1CCQTFGzUEPptVUbhHNJV
         clDIEJHAYqFwUXcIJidYYDogNjtvN9Uvqi+Fe0tTtjY+NqdRrTV33tsJ4lz22zGSmpGY
         3ffui4qBzYsPoGNkhoQxIBlE9iFlUv9kMrA3CK+ZCYHX6Jxy3684Df6xpGQpKlN8fChp
         ITqN/ssWvBmUokWe072AisTJpsjWq6lkzEEg2j9m42bFbjJVtY2NcfXQdFR45l4YULbS
         VJRya0NQNShcsRHudmAgzphy8kVgoqc6xxy3i28MdezSS6AtRGCOfi1vxQriAEtGOl58
         R58w==
X-Gm-Message-State: AA+aEWa8+3OSyp534OXxa7trqAcF5e7iQiL7jYc7vZftmVSuK+O7EQ5N
        6pSv6XfMGL/PYuCcufxI6QFKjg==
X-Google-Smtp-Source: AFSGD/WpUCMerWrtK83rmC82n57049I4elRaWXN1N/YBSNcmqX1+4FNiqYY3UoDahic8VAH9KCpT+g==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr655725pgd.57.1542691573698;
        Mon, 19 Nov 2018 21:26:13 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p6sm20574271pfn.53.2018.11.19.21.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 21:26:12 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-man@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 2/2] memfd_create.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Mon, 19 Nov 2018 21:25:45 -0800
Message-Id: <20181120052545.76560-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120052545.76560-1-joel@joelfernandes.org>
References: <20181120052545.76560-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More details of the seal can be found in the LKML patch:
https://lore.kernel.org/lkml/20181120052137.74317-1-joel@joelfernandes.org/T/#t

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 man2/memfd_create.2 | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/man2/memfd_create.2 b/man2/memfd_create.2
index 3cd392d1b4d9..fce2bf8d0fff 100644
--- a/man2/memfd_create.2
+++ b/man2/memfd_create.2
@@ -280,7 +280,15 @@ in order to restrict further modifications on the file.
 (If placing the seal
 .BR F_SEAL_WRITE ,
 then it will be necessary to first unmap the shared writable mapping
-created in the previous step.)
+created in the previous step. Otherwise, behavior similar to
+.BR F_SEAL_WRITE
+can be achieved, by using
+.BR F_SEAL_FUTURE_WRITE
+which will prevent future writes via
+.BR mmap (2)
+and
+.BR write (2)
+from succeeding, while keeping existing shared writable mappings).
 .IP 4.
 A second process obtains a file descriptor for the
 .BR tmpfs (5)
@@ -425,6 +433,7 @@ main(int argc, char *argv[])
         fprintf(stderr, "\\t\\tg \- F_SEAL_GROW\\n");
         fprintf(stderr, "\\t\\ts \- F_SEAL_SHRINK\\n");
         fprintf(stderr, "\\t\\tw \- F_SEAL_WRITE\\n");
+        fprintf(stderr, "\\t\\tW \- F_SEAL_FUTURE_WRITE\\n");
         fprintf(stderr, "\\t\\tS \- F_SEAL_SEAL\\n");
         exit(EXIT_FAILURE);
     }
@@ -463,6 +472,8 @@ main(int argc, char *argv[])
             seals |= F_SEAL_SHRINK;
         if (strchr(seals_arg, \(aqw\(aq) != NULL)
             seals |= F_SEAL_WRITE;
+        if (strchr(seals_arg, \(aqW\(aq) != NULL)
+            seals |= F_SEAL_FUTURE_WRITE;
         if (strchr(seals_arg, \(aqS\(aq) != NULL)
             seals |= F_SEAL_SEAL;
 
@@ -518,6 +529,8 @@ main(int argc, char *argv[])
         printf(" GROW");
     if (seals & F_SEAL_WRITE)
         printf(" WRITE");
+    if (seals & F_SEAL_FUTURE_WRITE)
+        printf(" FUTURE_WRITE");
     if (seals & F_SEAL_SHRINK)
         printf(" SHRINK");
     printf("\\n");
-- 
2.19.1.1215.g8438c0b245-goog

