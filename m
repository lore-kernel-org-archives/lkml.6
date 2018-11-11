Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91A0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A011B20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bglsab7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A011B20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbeKLIVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389277AbeKLIU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C38921707;
        Sun, 11 Nov 2018 22:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975463;
        bh=+GX1wPB6XfjjpWxKpcM/wpvHdkmLqtSYHa9eQyzcOlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bglsab7YHV18AqM5xj0EAJ3n+LtmTVPsftPMA5gHxrjizf6ybUWurnhNXcbvHVxhN
         ByuBLxZenBnrqv4IiUd3k8A2IGUC2RNM+CGPAqlEcPMaduVkubmc+kA3b/LW63BCJC
         H3fqRSDde/wnK+bg42nbhlBRvNqPkzJnO4JIu474=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.18 236/350] signal: Guard against negative signal numbers in copy_siginfo_from_user32
Date:   Sun, 11 Nov 2018 14:21:40 -0800
Message-Id: <20181111221717.911182399@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit a36700589b85443e28170be59fa11c8a104130a5 upstream.

While fixing an out of bounds array access in known_siginfo_layout
reported by the kernel test robot it became apparent that the same bug
exists in siginfo_layout and affects copy_siginfo_from_user32.

The straight forward fix that makes guards against making this mistake
in the future and should keep the code size small is to just take an
unsigned signal number instead of a signed signal number, as I did to
fix known_siginfo_layout.

Cc: stable@vger.kernel.org
Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/signal.h |    2 +-
 kernel/signal.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -36,7 +36,7 @@ enum siginfo_layout {
 	SIL_SYS,
 };
 
-enum siginfo_layout siginfo_layout(int sig, int si_code);
+enum siginfo_layout siginfo_layout(unsigned sig, int si_code);
 
 /*
  * Define some primitives to manipulate sigset_t.
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2804,7 +2804,7 @@ COMPAT_SYSCALL_DEFINE2(rt_sigpending, co
 }
 #endif
 
-enum siginfo_layout siginfo_layout(int sig, int si_code)
+enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 {
 	enum siginfo_layout layout = SIL_KILL;
 	if ((si_code > SI_USER) && (si_code < SI_KERNEL)) {


