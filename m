Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2313C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0BC20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ZGMQtLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0BC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967129AbeFSQRM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966978AbeFSQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:17:10 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6CA20652;
        Tue, 19 Jun 2018 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529425030;
        bh=iHDIH8BwKPpmZCrZjRyXx9ka4T3PAbPcNQCiCPnhVTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ZGMQtLaJvqTCb4ejVGEspGCxxDq9dIbhH8yD43b0jQwfueA1SG6n4/s5mRyfnqUm
         wVX4chagDHPP17wProDnoT4Vz03bEEv9TwOCvGuAvqgBwL5ooag079i0odv9JpIzCX
         rcaCDFhc/0jjGeeTKTxw9wIxFOdP2UeNlLfMUhCE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH -tip v6 26/27] Documentation: kprobes: Add how to change the execution path
Date:   Wed, 20 Jun 2018 01:16:46 +0900
Message-Id: <152942500680.15209.12374262914863044775.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section that explaining how to change the execution
path with kprobes and warnings for some arch.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/kprobes.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 3e9e99ea751b..8a98eed1521b 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
 "post_handler," if any, that is associated with the kprobe.
 Execution then continues with the instruction following the probepoint.
 
+Changing Execution Path
+-----------------------
+
+Since the kprobes can probe into a running kernel code, it can change
+the register set, including instruction pointer. This operation
+requires maximum attention, such as keeping the stack frame, recovering
+execution path etc. Since it is operated on running kernel and need deep
+knowladge of the archtecture and concurrent computing, you can easily
+shot your foot.
+
+If you change the instruction pointer (and set up other related
+registers) in pre_handler, you must return !0 so that the kprobes
+stops single stepping and just returns to given address.
+This also means post_handler should not be called anymore.
+
+Note that this operation may be harder on some architectures which
+use TOC (Table of Contents) for function call, since you have to
+setup new TOC for your function in your module, and recover old
+one after back from it.
+
 Return Probes
 -------------
 

