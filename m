Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UW9TGoFDGVvtCAAAmS7hNA
	; Thu, 07 Jun 2018 14:39:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C92E608BA; Thu,  7 Jun 2018 14:39:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B246B602FC;
	Thu,  7 Jun 2018 14:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B246B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934325AbeFGOjg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:39:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40506 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934304AbeFGOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:39:30 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbS-0005Zs-5d; Thu, 07 Jun 2018 15:09:26 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003CZ-4w; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Borislav Petkov" <bp@alien8.de>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "kvm" <kvm@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Wanpeng Li" <kernellwp@gmail.com>,
        "=?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.401858383@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 334/410] x86/spectre_v2: Don't check microcode
 versions when running under hypervisors
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 36268223c1e9981d6cfc33aff8520b3bde4b8114 upstream.

As:

 1) It's known that hypervisors lie about the environment anyhow (host
    mismatch)

 2) Even if the hypervisor (Xen, KVM, VMWare, etc) provided a valid
    "correct" value, it all gets to be very murky when migration happens
    (do you provide the "new" microcode of the machine?).

And in reality the cloud vendors are the ones that should make sure that
the microcode that is running is correct and we should just sing lalalala
and trust them.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm <kvm@vger.kernel.org>
Cc: Krčmář <rkrcmar@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180226213019.GE9497@char.us.oracle.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -68,6 +68,13 @@ static bool bad_spectre_microcode(struct
 {
 	int i;
 
+	/*
+	 * We know that the hypervisor lie to us on the microcode version so
+	 * we may as well hope that it is running the correct version.
+	 */
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_mask == spectre_bad_microcodes[i].stepping)
