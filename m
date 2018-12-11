Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA40C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673E2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543572;
	bh=HuF+PECMEawAfoILl0MolxWjoey1fepCWEjhZCTC0ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wPGVJF9uc/e6TXPVA88GuvbhPy3KkCeSev8sInkYJd8HZbQFfpmVl9l64NFDYY2UX
	 AdDscJ8PLvF1CNIEfTW6X8AOi9bzbvP3sFE1c4aEppL/fcUIj0HHlqEITlRdFvBWIS
	 pCRbVCFug5gvXnwzwt/iSI77sNEBfGXfzKFnIEe0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3673E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeLKPwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbeLKPwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAB02146F;
        Tue, 11 Dec 2018 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543562;
        bh=HuF+PECMEawAfoILl0MolxWjoey1fepCWEjhZCTC0ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HY+K6TgFp9LK7dD4OtF58/r4OcRKP85Y2n1TiwNVh0Ew+2m2bObf/u8Q2TtmjzVqa
         koKHJFBzi1BJIl9/RqbFCYKQLq3XOzuuMDn+QE9H34SaSFB7gwY81rCZhuL4MCSS3a
         2UTYF4jZfaN5eU/JBOAQg6bxhjfQdxEdLk+i0Jcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.14 46/67] ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
Date:   Tue, 11 Dec 2018 16:41:46 +0100
Message-Id: <20181211151632.705493291@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit e46daee53bb50bde38805f1823a182979724c229 upstream.

The arm compiler internally interprets an inline assembly label
as an unsigned long value, not a pointer. As a result, under
CONFIG_FORTIFY_SOURCE, the address of a label has a size of 4 bytes,
which was tripping the runtime checks. Instead, we can just cast the label
(as done with the size calculations earlier).

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1639397

Reported-by: William Cohen <wcohen@redhat.com>
Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
Cc: stable@vger.kernel.org
Acked-by: Laura Abbott <labbott@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: William Cohen <wcohen@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct
 	}
 
 	/* Copy arch-dep-instance from template. */
-	memcpy(code, &optprobe_template_entry,
+	memcpy(code, (unsigned char *)optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */


