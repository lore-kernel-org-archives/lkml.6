Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7A718C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2763920693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tCl+DLOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2763920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934050AbeFMF1R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 01:27:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbeFMF1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 01:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9df8WT0I+/msTiIuo0vVzuiBNF3mIduIYGEBWsiZmcA=; b=tCl+DLOqYB5R8OsU8+Shb2634
        zr0YR72e4eG9xUD4lBNskqU75sYn1QQZmsX7Ra8X3cZ/NEck6ggBqBV8tdHbIlU7isVvCHYxCbWdO
        6LlWx9uJu/xH1X+/OLWfj+xuOpqj5pN6jQdlLraiuV9/LpfmNlpymqFy2oSMJah7Czx8QH9/G8ecr
        7wT2wJdI7yv9W8Avoih7QJNXc+CUb/rPdGpxvj2XQKKD2xe+IsBOOecSQH5/QRjzTaEWhstzIz1zY
        MnpTJPNPx37hPB7ipEeWbSprOHE2tQiBDdmfU7bQUP234IZbhbLOLCQjRLr/VjyYcUZK4DcTAwJ26
        eTr3N6keQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSyJE-0005EW-AN; Wed, 13 Jun 2018 05:27:04 +0000
Subject: Re: [RFC PATCH 22/23] watchdog/hardlockup/hpet: Only enable the HPET
 watchdog via a boot parameter
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
Date:   Tue, 12 Jun 2018 22:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2040d4..a8833c7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2577,7 +2577,7 @@
>  			Format: [state][,regs][,debounce][,die]
>  
>  	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
> -			Format: [panic,][nopanic,][num]
> +			Format: [panic,][nopanic,][num,][hpet]
>  			Valid num: 0 or 1
>  			0 - turn hardlockup detector in nmi_watchdog off
>  			1 - turn hardlockup detector in nmi_watchdog on

This says that I can use "nmi_watchdog=hpet" without using 0 or 1.
Is that correct?

> @@ -2587,6 +2587,9 @@
>  			please see 'nowatchdog'.
>  			This is useful when you use a panic=... timeout and
>  			need the box quickly up again.
> +			When hpet is specified, the NMI watchdog will be driven
> +			by an HPET timer, if available in the system. Otherwise,
> +			the perf-based implementation will be used.
>  
>  			These settings can be accessed at runtime via
>  			the nmi_watchdog and hardlockup_panic sysctls.


thanks,
-- 
~Randy
