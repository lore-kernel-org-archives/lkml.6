Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E717C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDE9223C7
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="03qFNxQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDE9223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403883AbeKLIWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbeKLIWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912AD22353;
        Sun, 11 Nov 2018 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975573;
        bh=owcmn8Da8IiL6swhfcx8otGtnEODOUfi2fgk7Z8Ap7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03qFNxQBzqP5qWZbPUUK3WQCHG8LgGfGyFagxlKVGRz7Z2AqTJUQgPUTXG9dejpFl
         Uf7xczhFaQDkV93jOZlrbRUPS1X4lV+LeU7rxbL7OVsXUbRXomJOkwGp4ASxnsNa/v
         YiMo/VuIwgD/RkwnVwoGyFbLAeZEMb/AhxDBSwKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.14 150/222] signal: Guard against negative signal numbers in copy_siginfo_from_user32
Date:   Sun, 11 Nov 2018 14:24:07 -0800
Message-Id: <20181111221700.815082705@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -34,7 +34,7 @@ enum siginfo_layout {
 #endif
 };
 
-enum siginfo_layout siginfo_layout(int sig, int si_code);
+enum siginfo_layout siginfo_layout(unsigned sig, int si_code);
 
 /*
  * Define some primitives to manipulate sigset_t.
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2700,7 +2700,7 @@ COMPAT_SYSCALL_DEFINE2(rt_sigpending, co
 }
 #endif
 
-enum siginfo_layout siginfo_layout(int sig, int si_code)
+enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 {
 	enum siginfo_layout layout = SIL_KILL;
 	if ((si_code > SI_USER) && (si_code < SI_KERNEL)) {


