Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615CA21471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615CA21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390639AbeHNUcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:32:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:32:00 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F290F40B;
        Tue, 14 Aug 2018 17:43:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 082/107] cpu/hotplug: detect SMT disabled by BIOS
Date:   Tue, 14 Aug 2018 19:17:45 +0200
Message-Id: <20180814171525.784747037@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 73d5e2b472640b1fcdb61ae8be389912ef211bda upstream

If SMT is disabled in BIOS, the CPU code doesn't properly detect it.
The /sys/devices/system/cpu/smt/control file shows 'on', and the 'l1tf'
vulnerabilities file shows SMT as vulnerable.

Fix it by forcing 'cpu_smt_control' to CPU_SMT_NOT_SUPPORTED in such a
case.  Unfortunately the detection can only be done after bringing all
the CPUs online, so we have to overwrite any previous writes to the
variable.

Reported-by: Joe Mario <jmario@redhat.com>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Fixes: f048c399e0f7 ("x86/topology: Provide topology_smt_supported()")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cpu.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2063,6 +2063,15 @@ static const struct attribute_group cpuh
 
 static int __init cpu_smt_state_init(void)
 {
+	/*
+	 * If SMT was disabled by BIOS, detect it here, after the CPUs have
+	 * been brought online.  This ensures the smt/l1tf sysfs entries are
+	 * consistent with reality.  Note this may overwrite cpu_smt_control's
+	 * previous setting.
+	 */
+	if (topology_max_smt_threads() == 1)
+		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+
 	return sysfs_create_group(&cpu_subsys.dev_root->kobj,
 				  &cpuhp_smt_attr_group);
 }


