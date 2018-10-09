Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED8CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2678214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2678214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJJA3N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:29:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJA3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:29:13 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g9vXB-0000hd-Dn; Tue, 09 Oct 2018 19:11:01 +0200
Date:   Tue, 9 Oct 2018 19:11:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam/qi - simplify CGR allocation, freeing
Message-ID: <20181009171101.jk6lgdx4g5rnq7cm@linutronix.de>
References: <20181005125443.dfhd2asqktm22ney@linutronix.de>
 <20181008110937.29198-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181008110937.29198-1-horia.geanta@nxp.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-08 14:09:37 [+0300], Horia Geantă wrote:
> CGRs (Congestion Groups) have to be freed by the same CPU that
> initialized them.
> This is why currently the driver takes special measures; however, using
> set_cpus_allowed_ptr() is incorrect - as reported by Sebastian.
> 
> Instead of the generic solution of replacing set_cpus_allowed_ptr() with
> work_on_cpu_safe(), we use the qman_delete_cgr_safe() QBMan API instead
> of qman_delete_cgr() - which internally takes care of proper CGR
> deletion.
> 
> Link: https://lkml.kernel.org/r/20181005125443.dfhd2asqktm22ney@linutronix.de
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Oh. No more usage of set_cpus_allowed_ptr(). Wonderful. Thank you.
 Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
for that.

Now that you shifted my attention to qman_delete_cgr_safe().
Could you please use work_on_cpu_safe() here instead
smp_call_function_single() with preempt_disable() around it?

Now, what is the problem with the CPU limitation? Is this a HW
limitation that you can access the registers from a certain CPU?

This still fails (silently) if the CPU is missing, right? If you can't
get around it, you could block the CPU from going offline. You could
register a HP notifier
	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, …

and the function would return -EINVAL if this is the special CPU. The
other thing would be forbid rmmod. This *could* work but if I remember
correctly, an explicit unbind can't be stopped.

Sebastian
