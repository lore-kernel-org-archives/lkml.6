Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C48CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482A20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5qvnv+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5482A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFTKh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:37:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40068 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbeFTKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:37:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so5879655wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6s+p1TIw0pBcs/Fh+j/cgRtp6ZB9xEU7re7j+lxdpjQ=;
        b=O5qvnv+hHg0fdhBwUG0wlAnuURNEfGZMzYOr3bjiHF5yhbgcrnM9grlBCUnko3YrFG
         4O5x9f80gnpuy/dqq6kvOIJwEoVv/fs43A97elW7xNNo3MmJs/eJ7vOYM7zfxDvUQHYU
         Ny2WzBUCwJNVTzg03IINmn0WThLiALgVUsobLVPhtJH+xZr6fAflOEO9OpbTLPzxTejJ
         P2OklyvUBIEdBMsntPHbfC49WZ1uI3U2+q6mhYhhLvz2uEWaRjclO3JKaw0TPCLAcpIe
         kMM90pwBVAeHG59OVRQBXUZh8m8f6ZAUWivIEHKhAo/MLxByNzq8AnEWy2b8YUYvYPl0
         504Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6s+p1TIw0pBcs/Fh+j/cgRtp6ZB9xEU7re7j+lxdpjQ=;
        b=Qp9iKEO4z6DmYzl8uwNDLNykkDNFLv0wTf5lcGNEP08tuDmZ4g6IlmoBttH+5MzuAN
         SPJzgdrnZCbOumPvlzx3x9C304fS6uaqyQ7ZeoqSlEYpVlGAUk7udLYCIAjEFGqkz2gM
         mV4CWyWjQCz/1Dp7E9EgJ3DKOtERSL8wKYEspVWMnkM90PZO2vhhFRlvwjzgTSzO4hoc
         u+C1BRYASPQcN6Be4PioMnjyripRZoA0IvxGZNEQaOnGKsOnRDl1hFPf/NUNlUTyxPy3
         kQGLmJwXmvefFmxiXFOjV0yAlZwB9lwpSNV5XUCDYojnpyrKJdqvmVzXDBucqAvSiNeu
         9p+Q==
X-Gm-Message-State: APt69E22DNCRHpXE8i+Hca1/NoqeBe98xF54tH0sAzxZ5zQ8tp6TZ8iU
        0CdC4/FT4qAct8xW2Wv71TqvRA==
X-Google-Smtp-Source: ADUXVKLe88NqJ4GWcjwEN/+NrXIETuCePnyCZMc5AOVVH8oNwZ2PxrIne2FyjEBuvERc5bvVBZ0pRA==
X-Received: by 2002:a1c:b211:: with SMTP id b17-v6mr1171088wmf.74.1529491044787;
        Wed, 20 Jun 2018 03:37:24 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([2a00:79e0:15:10:8971:4ae9:dd1c:10e])
        by smtp.gmail.com with ESMTPSA id e81-v6sm3567427wmi.28.2018.06.20.03.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 03:37:23 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] include/asm-generic/bug.h: clarify valid uses of WARN()
Date:   Wed, 20 Jun 2018 12:37:16 +0200
Message-Id: <20180620103716.61636-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

Explicitly state that WARN*() should be used only for recoverable
kernel issues/bugs and that it should not be used for any kind of
invalid external inputs or transient conditions.

Motivation: it's a very useful capability to be able to understand
if a particular kernel splat means a kernel bug or simply an invalid
user-space program. For the former one wants to notify kernel developers,
while notifying kernel developers for the latter is annoying.
Even a kernel developer may not know what to do with a WARNING
in an unfamiliar subsystem. This is especially critical for any automated
testing systems that may use panic_on_warn and mail kernel developers.

The clear separation also serves as an additional documentation:
is it a condition that must never occur because of additional
checks/logic elsewhere? or is it simply a check for invalid inputs
or unfortunate conditions?

Use of pr_err() for user messages also leads to better error messages.
"Something is wrong in file foo on line X" is not particularly useful
message for end user. pr_err() forces developers to write more meaningful
error messages for user.

As of now we are almost there. We are doing systematic kernel testing
with panic_on_warn and are not seeing massive amounts of false positives.
But every now and then another WARN on ENOMEM or invalid inputs pops up
and leads to a lengthy argument each time. The goal of this change
is to officially document the rules.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 include/asm-generic/bug.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index a7613e1b0c87..20561a60db9c 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -75,9 +75,19 @@ struct bug_entry {
 
 /*
  * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
- * significant issues that need prompt attention if they should ever
- * appear at runtime.  Use the versions with printk format strings
- * to provide better diagnostics.
+ * significant kernel issues that need prompt attention if they should ever
+ * appear at runtime.
+ *
+ * Do not use these macros when checking for invalid external inputs
+ * (e.g. invalid system call arguments, or invalid data coming from
+ * network/devices), and on transient conditions like ENOMEM or EAGAIN.
+ * These macros should be used for recoverable kernel issues only.
+ * For invalid external inputs, transient conditions, etc use
+ * pr_err[_once/_ratelimited]() followed by dump_stack(), if necessary.
+ * Do not include "BUG"/"WARNING" in format strings manually to make these
+ * conditions distinguishable from kernel issues.
+ *
+ * Use the versions with printk format strings to provide better diagnostics.
  */
 #ifndef __WARN_TAINT
 extern __printf(3, 4)
-- 
2.18.0.rc1.244.gcf134e6275-goog

