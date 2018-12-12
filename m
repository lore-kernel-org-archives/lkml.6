Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B504AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761252084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Vf41e4Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761252084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeLLWF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:05:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36944 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLLWFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:05:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so8974671pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hazJnQDZsZo3kVuPkNhwMYMauryGhG8I6tzG46lyL1E=;
        b=Vf41e4Yx1yFJ/qMtwPCXfH5U9sPY8Qa5MpupPB4LH9Rv3EsBZ4dHInvMbAiw2IO3u2
         IvJGs2J/vGZkOBAiu6eezLzuhKhSq01APD4NdKLJv+i+J8EpJv9chqwu7RiG8xoAj6za
         mlgfCbpUY6EZwf/59Y9FM1BXMB6rWfJMjwtCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hazJnQDZsZo3kVuPkNhwMYMauryGhG8I6tzG46lyL1E=;
        b=iC8QkH0ZslLW+SAMfWqSIhfLxacKgge//fSmLiyFi/HRbNDq40QCGEmxTGxl/7+gXc
         lUqxIsDQ/ZWZdMjZwHz2UF2unoZ7ofLTdfLONIkwrqizEpuzXmKbmycT2shw2vWJXpX+
         ebeeXD73HSxh8uIaapAsE/LYGnpmhFth+EFodJuW4iWKGf8xtgtbC/tVrMrbaTGv53LF
         nLZO6L8CfdW2jKkQubsIUxRPldJ962r2FHl36N55DZCyVNPjcvauAYFIW0BQTIIFt3oe
         IsiFAPgiNVzSl3cohu22fEVtInzFbYm4uANDm6BXmKGrGs1Cl8K4/msrUzHq4Na+c/VS
         +O4w==
X-Gm-Message-State: AA+aEWZVTtDPGTbk88k6qmkzn5tm72xd4pxMEhNkr9yEzOodtod/dsa0
        ULhpW5ViGh0QkS7d5wk3TyTapQ==
X-Google-Smtp-Source: AFSGD/UR0Mwu86+321x5T7dF9/t4NyB49dG3jQFLqx5naDqVEJMTq2cBzgRG7HOnsM2H72Hg5sH1ng==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr19610673pgf.33.1544652324034;
        Wed, 12 Dec 2018 14:05:24 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id o1sm29340869pgn.63.2018.12.12.14.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 14:05:22 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-man@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 1/2] fcntl.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Wed, 12 Dec 2018 14:05:13 -0800
Message-Id: <20181212220514.205269-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
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
 man2/fcntl.2 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index 03533d65b49d..54772f94964c 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -1525,6 +1525,21 @@ Furthermore, if there are any asynchronous I/O operations
 .RB ( io_submit (2))
 pending on the file,
 all outstanding writes will be discarded.
+.TP
+.BR F_SEAL_FUTURE_WRITE
+If this seal is set, the contents of the file can be modified only from
+existing writeable mappings that were created prior to the seal being set.
+Any attempt to create a new writeable mapping on the memfd via
+.BR mmap (2)
+will fail with
+.BR EPERM.
+Also any attempts to write to the memfd via
+.BR write (2)
+will fail with
+.BR EPERM.
+This is useful in situations where existing writable mapped regions need to be
+kept intact while preventing any future writes. For example, to share a
+read-only memory buffer to other processes that only the sender can write to.
 .\"
 .SS File read/write hints
 Write lifetime hints can be used to inform the kernel about the relative
-- 
2.20.0.rc1.387.gf8505762e3-goog

