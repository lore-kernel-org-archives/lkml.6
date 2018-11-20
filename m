Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5BCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D9D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d0VOLtUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D9D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeKTPx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:53:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35949 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKTPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:53:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id y6-v6so416859plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 21:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhPoQZhqgkEYd2R0TR94fBIobE2oIUczJVXl8rOT65A=;
        b=d0VOLtUkBjUsWwJ2X8edrqI7xaMpeXVg2YL7CxPVLDyWuMqlVL4fj8yAHE+xG9IZWB
         49okWuYT2X7C5NpJe5AjJQqAT6HGfIgHoCDJdB6L2zBwcDKBXsIqKRy9Z9kBBTqJQDNo
         Zjk7sg0hCinUvDgSYGHPVpQrBpcRqy1qz4ets=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhPoQZhqgkEYd2R0TR94fBIobE2oIUczJVXl8rOT65A=;
        b=V7luFFeVARRm5GAZNixvxWTraumlJvvPEdyyOMQvOwc5vF+IfH+2rK1n9GGwd1P0SU
         tdMR3z3MwzEAm1PRWWb6/yZ5icnnyNMCw5pq71EIHv1A6ZcsmFoVvLoCaNqi53/rMwYF
         Y+50ckI9nkuZuHeNIxMO+0Wx8GNe3fYwT3ZF7peERkyiHxjsZ1RKM7jJ78K3kcIAb6DU
         o7Xd2SA6iCKdN8Z36/voQIySuNwVG0dQgUw3rkyzwqkN2l8eRN2/TmaukwYoZyi2HyFA
         bGbQ/fV5KBO5nZ+iFx/URZG949de4CiBaANLDmMO3ufAikM2GXunQDmiRMalRjoGh+yP
         LzMA==
X-Gm-Message-State: AA+aEWYsWQXqrI55YjLg9I5Y3PEFJGgQpB4r6ZzzRC3qlxA7KkJ4z6TM
        /c/sSQdw651rrwOZ17FCOTgHLQ==
X-Google-Smtp-Source: AFSGD/VVeYLa9QA/bxhkOMA/ndTVgu3RmCtiaib129NDCRTVz6dGKpjvtQgnM2eJskFnuafM5NXj2w==
X-Received: by 2002:a17:902:66e5:: with SMTP id e92-v6mr772902plk.92.1542691572002;
        Mon, 19 Nov 2018 21:26:12 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p6sm20574271pfn.53.2018.11.19.21.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 21:26:11 -0800 (PST)
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
Subject: [PATCH -manpage 1/2] fcntl.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Mon, 19 Nov 2018 21:25:44 -0800
Message-Id: <20181120052545.76560-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
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
2.19.1.1215.g8438c0b245-goog

