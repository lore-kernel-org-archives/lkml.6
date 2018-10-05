Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4683AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE85B20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE85B20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeJETxY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:53:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbeJETxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:53:24 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g8Pcy-0000j9-6F; Fri, 05 Oct 2018 14:54:44 +0200
Date:   Fri, 5 Oct 2018 14:54:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: set_cpus_allowed_ptr() usage in FREESCALE CAAM
Message-ID: <20181005125443.dfhd2asqktm22ney@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this block:
|int caam_qi_shutdown(struct device *qidev)
| {
|         struct cpumask old_cpumask = current->cpus_allowed;
…
|         /*
|          * QMan driver requires CGRs to be deleted from same CPU from where they
|          * were instantiated. Hence we get the module removal execute from the
|          * same CPU from where it was originally inserted.
|          */
|         set_cpus_allowed_ptr(current, get_cpu_mask(mod_init_cpu));
…
|          /* Now that we're done with the CGRs, restore the cpus allowed mask */
|         set_cpus_allowed_ptr(current, &old_cpumask);

in drivers/crypto/caam/qi.c needs to go. I saw it twice in the driver.
set_cpus_allowed_ptr() is not intended for this kind of thing.

What you want is to use work_on_cpu_safe() instead. It takes also a CPU
as an argument. You need to check the error code of the function if it
worked because the CPU may have gone offline. This functions also
ensures that the CPU does not vanish in the middle of the work. 
Also please check the error code in both cases of the function because
it may fail if the CPU is not online.

Sebastian
