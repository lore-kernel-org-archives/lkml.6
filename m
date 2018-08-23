Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680BBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC73208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC73208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbeHWM3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:29:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:29:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0F6ECA0;
        Thu, 23 Aug 2018 09:01:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 244/324] ARM: 8780/1: ftrace: Only set kernel memory back to read-only after boot
Date:   Thu, 23 Aug 2018 09:55:10 +0200
Message-Id: <20180823075008.292430809@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit b4c7e2bd2eb4764afe3af9409ff3b1b87116fa30 ]

Dynamic ftrace requires modifying the code segments that are usually
set to read-only. To do this, a per arch function is called both before
and after the ftrace modifications are performed. The "before" function
will set kernel code text to read-write to allow for ftrace to make the
modifications, and the "after" function will set the kernel code text
back to "read-only" to keep the kernel code text protected.

The issue happens when dynamic ftrace is tested at boot up. The test is
done before the kernel code text has been set to read-only. But the
"before" and "after" calls are still performed. The "after" call will
change the kernel code text to read-only prematurely, and other boot
code that expects this code to be read-write will fail.

The solution is to add a variable that is set when the kernel code text
is expected to be converted to read-only, and make the ftrace "before"
and "after" calls do nothing if that variable is not yet set. This is
similar to the x86 solution from commit 162396309745 ("ftrace, x86:
make kernel text writable only for conversions").

Link: http://lkml.kernel.org/r/20180620212906.24b7b66e@vmware.local.home

Reported-by: Stefan Agner <stefan@agner.ch>
Tested-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mm/init.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -736,20 +736,29 @@ static int __mark_rodata_ro(void *unused
 	return 0;
 }
 
+static int kernel_set_to_readonly __read_mostly;
+
 void mark_rodata_ro(void)
 {
+	kernel_set_to_readonly = 1;
 	stop_machine(__mark_rodata_ro, NULL, NULL);
 	debug_checkwx();
 }
 
 void set_kernel_text_rw(void)
 {
+	if (!kernel_set_to_readonly)
+		return;
+
 	set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), false,
 				current->active_mm);
 }
 
 void set_kernel_text_ro(void)
 {
+	if (!kernel_set_to_readonly)
+		return;
+
 	set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), true,
 				current->active_mm);
 }


