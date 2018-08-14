Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB8C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E40521653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E40521653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbeHNUmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:42:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390236AbeHNUaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:14 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4309DDBA;
        Tue, 14 Aug 2018 17:33:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.17 97/97] x86/microcode: Allow late microcode loading with SMT disabled
Date:   Tue, 14 Aug 2018 19:17:49 +0200
Message-Id: <20180814171437.049491722@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 07d981ad4cf1e78361c6db1c28ee5ba105f96cc1 upstream

The kernel unnecessarily prevents late microcode loading when SMT is
disabled.  It should be safe to allow it if all the primary threads are
online.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/core.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -509,12 +509,20 @@ static struct platform_device	*microcode
 
 static int check_online_cpus(void)
 {
-	if (num_online_cpus() == num_present_cpus())
-		return 0;
+	unsigned int cpu;
 
-	pr_err("Not all CPUs online, aborting microcode update.\n");
+	/*
+	 * Make sure all CPUs are online.  It's fine for SMT to be disabled if
+	 * all the primary threads are still online.
+	 */
+	for_each_present_cpu(cpu) {
+		if (topology_is_primary_thread(cpu) && !cpu_online(cpu)) {
+			pr_err("Not all CPUs online, aborting microcode update.\n");
+			return -EINVAL;
+		}
+	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static atomic_t late_cpus_in;


