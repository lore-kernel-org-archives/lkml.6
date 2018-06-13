Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9374CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4846120891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CjNXDbGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4846120891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeFMJHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:07:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeFMJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1HUKscu0mE+ALM2Nlu99F4vZsRKh63EWuYU7CjEm8tA=; b=CjNXDbGF0J7qHXdao79CFwi3e
        oEPNAD23nUrLD2pwEtbWN9hcPPuskI898+SkPI2BsRkqdWXmwhEQIosYKyNiLD0uNQICYUdYuo+d0
        KV7gxAjEDbUvpGAo3PLbaZ/pZmZ0AMFp6cg6Ymaj+JnY4ro74/zxr9rPDFyUf4tQQ7mBLTiusVvSJ
        k0wZhfKe8QPWZOwITMFtbYXBhdMwRfuAbDrxtM0lpH5czCFv/qe2IqSnGWw4G3wrz/UD36/y0KlHq
        Rv0ariNxMX2fM9nKsVE3LzrlEsk1s3H7ivRu3a8TTM7cnD8ZugWvAaeAjMyPZY427ikuccmstrU4g
        Lv9ToRFCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT1kQ-0007FG-Ho; Wed, 13 Jun 2018 09:07:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 038E1201EA7CB; Wed, 13 Jun 2018 11:07:20 +0200 (CEST)
Date:   Wed, 13 Jun 2018 11:07:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's
 interrupt to NMI
Message-ID: <20180613090720.GV12258@hirez.programming.kicks-ass.net>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 05:57:37PM -0700, Ricardo Neri wrote:

+static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
+{
+       unsigned long this_isr;
+       unsigned int lvl_trig;
+
+       this_isr = hpet_readl(HPET_STATUS) & BIT(hdata->num);
+
+       lvl_trig = hpet_readl(HPET_Tn_CFG(hdata->num)) & HPET_TN_LEVEL;
+
+       if (lvl_trig && this_isr)
+               return true;
+
+       return false;
+}

> +static int hardlockup_detector_nmi_handler(unsigned int val,
> +					   struct pt_regs *regs)
> +{
> +	struct hpet_hld_data *hdata = hld_data;
> +	unsigned int use_fsb;
> +
> +	/*
> +	 * If FSB delivery mode is used, the timer interrupt is programmed as
> +	 * edge-triggered and there is no need to check the ISR register.
> +	 */
> +	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;

Please do explain.. That FSB thing basically means MSI. But there's only
a single NMI vector. How do we know this NMI came from the HPET?

> +
> +	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))

So you add _2_ HPET reads for every single NMI that gets triggered...
and IIRC HPET reads are _sllooooowwwwww_.

> +		return NMI_DONE;
> +
> +	inspect_for_hardlockups(regs);
> +
> +	if (!(hdata->flags & HPET_DEV_PERI_CAP))
> +		kick_timer(hdata);
> +
> +	/* Acknowledge interrupt if in level-triggered mode */
> +	if (!use_fsb)
> +		hpet_writel(BIT(hdata->num), HPET_STATUS);
> +
> +	return NMI_HANDLED;

So if I read this right, when in FSB/MSI mode, we'll basically _always_
claim every single NMI as handled?

That's broken.

> +}
