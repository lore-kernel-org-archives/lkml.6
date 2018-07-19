Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA421ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700C520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BumlRXgI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EgEyC/UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700C520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGSW6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:58:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeGSW6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:58:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30A1E606DB; Thu, 19 Jul 2018 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532038388;
        bh=xkhdWlUcYsTbd+W6hSXsr26BRBnuwyZt+7P+wsYPeAk=;
        h=From:To:Cc:Subject:Date:From;
        b=BumlRXgIY2knSfeAZjEihpPVEDlHHm0KbAX5GELWsvWhG4GFRtEVB1k81yG8TPFHK
         VIwlmJQw7ZrKi0RnC/8g4H0Gir16qjYCBG78T1LoQ0TfztbD4gNChgOC/5kvR540FR
         oilfjm13YMsY3Whboh6scF0ZCoTBydhfUN273akk=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2A79602BD;
        Thu, 19 Jul 2018 22:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532038387;
        bh=xkhdWlUcYsTbd+W6hSXsr26BRBnuwyZt+7P+wsYPeAk=;
        h=From:To:Cc:Subject:Date:From;
        b=EgEyC/UEItFI3JsCmIER0BsD1wznD86Tn7cFg7fITQrBb65o7mXdH6rx7SBOsiIzp
         BcdToD4OpAkWvdJHBY4ebl8mKtU8vLIoXMYU58aRNAAvN40FkRqbslvSRgbL/Kwwd/
         y6MHlubShrHxWjO2gepkrKUgMhtv845FRV5UDbgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2A79602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, hoeun.ryu@gmail.com,
        adobriyan@gmail.com, zhizhouzhang@asrmicro.com,
        suzuki.poulose@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     Matt Wagantall <mattw@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH] ARM64: smp: BUG() if smp_send_reschedule() is called for an offline cpu
Date:   Thu, 19 Jul 2018 15:12:49 -0700
Message-Id: <1532038369-5159-1-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the 'commit <8b775be35e41b9f> ("ARM: smp:
BUG() if smp_send_reschedule() is called for an offline cpu")'

Sending an IPI_RESCHEDULE to an offline CPU is incorrect and potentially
bad for both power and stability. On some sub-architectures such as MSM,
if a power-collapsed CPU is unexpectedly woken up by an IPI, it will be
begin executing without the preparations that would normally happen as
part of CPU_UP_PREPARE. If clocks, voltage regulators, or other hardware
configuration are not performed, the booting CPU may cause general
instability or (at best) poor power performance since the CPU would be
powered up but not utilized.

One common cause for such issues is misuse of add_timer_on() or APIs
such as queue_work_on() which call it. If proper precautions are not
taken to block hotplug while these APIs are called then a race may
result in IPIs being sent to CPUs that are already offline.

This same argument could be applied to other IPIs (with the exception
of IPI_WAKEUP), but the others are already restricted to only online
CPUs by existing mechanisms, so an explicit assertion is not useful.

Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2faa986..5e39030 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -898,6 +898,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 void smp_send_reschedule(int cpu)
 {
+	BUG_ON(cpu_is_offline(cpu));
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

