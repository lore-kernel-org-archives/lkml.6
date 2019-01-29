Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC1DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655252083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762491;
	bh=yDjDsPjhjZXwuHUfI6IPHiH4hHp3sBi1Rtces0l3N9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGe0yPQZPJ3OVDt6Ckm4nPUkoapujCLSXCnwf7gcKh01TP30n9nnd5e5FsnJYRLyZ
	 RBn0KTFLtH7ahEvYUeFycvAZR8TCgsDfVj9NOuGThaMKobwNV499hCtAoAGLnb6Ay4
	 RcZfB+TC8MOjMCyaBLzkUkAlQLzbu6Qgq36GlqAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfA2LsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731278AbfA2LsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60BF2083B;
        Tue, 29 Jan 2019 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762486;
        bh=yDjDsPjhjZXwuHUfI6IPHiH4hHp3sBi1Rtces0l3N9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gb/0APpAAwkI3YZnd+UBbzvH4KmNLnYKx/EBZ2Gr6AcjRG5Oxj1RBa5lQXXAMpQcd
         1yx3toXenlNBDQ8tXdnYsiM8hCzvWcpUjKIc0JD6Z5vsQ3bPqZSagVpWJl6VFEnBC9
         IrffikFhE5+my3aAJB42fbQ67Z4lK9vfG6JgJbfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 21/68] s390/early: improve machine detection
Date:   Tue, 29 Jan 2019 12:35:43 +0100
Message-Id: <20190129113133.399476216@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 03aa047ef2db4985e444af6ee1c1dd084ad9fb4c upstream.

Right now the early machine detection code check stsi 3.2.2 for "KVM"
and set MACHINE_IS_VM if this is different. As the console detection
uses diagnose 8 if MACHINE_IS_VM returns true this will crash Linux
early for any non z/VM system that sets a different value than KVM.
So instead of assuming z/VM, do not set any of MACHINE_IS_LPAR,
MACHINE_IS_VM, or MACHINE_IS_KVM.

CC: stable@vger.kernel.org
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/early.c |    4 ++--
 arch/s390/kernel/setup.c |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -226,10 +226,10 @@ static noinline __init void detect_machi
 	if (stsi(vmms, 3, 2, 2) || !vmms->count)
 		return;
 
-	/* Running under KVM? If not we assume z/VM */
+	/* Detect known hypervisors */
 	if (!memcmp(vmms->vm[0].cpi, "\xd2\xe5\xd4", 3))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_KVM;
-	else
+	else if (!memcmp(vmms->vm[0].cpi, "\xa9\x61\xe5\xd4", 4))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_VM;
 }
 
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -884,6 +884,8 @@ void __init setup_arch(char **cmdline_p)
 		pr_info("Linux is running under KVM in 64-bit mode\n");
 	else if (MACHINE_IS_LPAR)
 		pr_info("Linux is running natively in 64-bit mode\n");
+	else
+		pr_info("Linux is running as a guest in 64-bit mode\n");
 
 	/* Have one command line that is parsed and saved in /proc/cmdline */
 	/* boot_command_line has been already set up in early.c */


