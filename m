Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF60C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBB920827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBB920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeKHDPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:15:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41574 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeKHDPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:15:40 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKRs8-0004sw-21; Wed, 07 Nov 2018 18:44:08 +0100
Date:   Wed, 7 Nov 2018 18:44:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
In-Reply-To: <20181107171149.165693799@linutronix.de>
Message-ID: <alpine.DEB.2.21.1811071842340.1906@nanos.tec.linutronix.de>
References: <20181107171010.421878737@linutronix.de> <20181107171149.165693799@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018, Thomas Gleixner wrote:

> Add a document to the subsystem/maintainer handbook section, which explains
> what the tip tree is, how it operates and what rules and expectations it
> has.

Peter asked me to add a section about locking comments. I added it and
forgot to refresh the patch before sending. Delta patch below.

Thanks,

	tglx
---
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -578,6 +578,29 @@ Sentences in comments start with a upper
   usage of descriptive function names often replaces these tiny comments.
   Apply common sense as always.
 
+ 
+Documenting locking requirements
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  Documenting locking requirements is a good thing, but comments are not
+  necessarily the best choice. Instead of writing::
+
+    	/* Caller must hold foo->lock */
+	void func(struct foo *foo)
+	{
+		...
+	}
+
+  Please use::
+
+	void func(struct foo *foo)
+	{
+		lockdep_assert_held(&foo->lock);
+		...
+	}
+
+  The latter enables run time debugging when lockdep is enabled which
+  verifies that all callers hold the lock. Comments can't do that.
+
 
 Bracket rules
 ^^^^^^^^^^^^^
