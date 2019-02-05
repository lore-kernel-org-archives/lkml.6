Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9277C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64452080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oI6z5eKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfBEItO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:49:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KYXzUg2sSAEXhCe7Oa4aiko3S0J1+A60eyUxbL/J5bc=; b=oI6z5eKt7n6KoEuuEZsmUm46R
        OQ5R3Us7nZaPGXm/ruAMDgl5lgeVcCPH/Hs4ITH50DaW6gwfcHe3XUtWNsrEW1fY5vAyHHSCc4exf
        2mqQ/yijjvCZC1cg5Hr2hrJQoyyrdOQrDh78LN5m4CR5fhv7cpy7XBaIm4Wz2OJHmpnY/7VNNL9mG
        kT4bDQG0LJ9st60SYNzfxBtuZIJukBxx4QvET9BDQQHIrdpxedq7jana2aAv2ENVvt+1gBNohxFBa
        aWinby4PVneonb+Nf8hWajbyzebCqob+8sZLy2f0Wbj6N7L17SQ6XPW7F7nysOuqucVpj3AenO79d
        ObvEX/Gbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqwPc-00021Q-6G; Tue, 05 Feb 2019 08:49:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB7AB2029FA06; Tue,  5 Feb 2019 09:48:57 +0100 (CET)
Date:   Tue, 5 Feb 2019 09:48:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205084857.GK17528@hirez.programming.kicks-ass.net>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:46:30PM -0800, Dave Hansen wrote:
> So, the compromise we reached in this case is that Intel will fully
> document the future silicon architecture, and then write the kernel
> implementation to _that_.  Then, for the weirdo deployments where this
> feature is not enumerated, we have the setcpuid= to fake the enumeration
> in software.

What user is _EVER_ going to use this? Nobody, I expect the answer to
be.

Is this some transient state; where a few (early) models will not have
the enumeration sorted but all later models will have it all neat and
tidy?

If so, we can easily do the FMS solution for this.

But a cmdline features thing is not something I can see anybody but
a limited set of developers ever using.
