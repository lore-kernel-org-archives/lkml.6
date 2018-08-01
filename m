Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ED020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ED020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeHAT7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:59:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390328AbeHATIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEBFC13D3;
        Wed,  1 Aug 2018 17:16:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <swood@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Clark Williams <williams@redhat.com>,
        Pei Zhang <pezhang@redhat.com>, x86-ml <x86@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 086/246] x86/microcode: Make the late update update_lock a raw lock for RT
Date:   Wed,  1 Aug 2018 18:49:56 +0200
Message-Id: <20180801165015.837161149@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Wood <swood@redhat.com>

[ Upstream commit ff987fcf011d20c53b3a613edf6e2055ea48e26e ]

__reload_late() is called from stop_machine context and thus cannot
acquire a non-raw spinlock on PREEMPT_RT.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Pei Zhang <pezhang@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20180524154420.24455-1-swood@redhat.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -70,7 +70,7 @@ static DEFINE_MUTEX(microcode_mutex);
 /*
  * Serialize late loading so that CPUs get updated one-by-one.
  */
-static DEFINE_SPINLOCK(update_lock);
+static DEFINE_RAW_SPINLOCK(update_lock);
 
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
@@ -560,9 +560,9 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
-	spin_lock(&update_lock);
+	raw_spin_lock(&update_lock);
 	apply_microcode_local(&err);
-	spin_unlock(&update_lock);
+	raw_spin_unlock(&update_lock);
 
 	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {


