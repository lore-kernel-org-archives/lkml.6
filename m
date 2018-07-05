Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD672417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD672417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeGEGAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:00:30 -0400
Received: from ozlabs.org ([203.11.71.1]:59747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbeGEGA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:00:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LnJp52F1z9s2R;
        Thu,  5 Jul 2018 16:00:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        akshay.adiga@linux.vnet.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Add the CPUIDLE_FLAG_POLLING for snooze
In-Reply-To: <20180703150348.GA13348@in.ibm.com>
References: <1530595456-32352-1-git-send-email-ego@linux.vnet.ibm.com> <20180703140616.GA13660@drishya.in.ibm.com> <20180703150348.GA13348@in.ibm.com>
Date:   Thu, 05 Jul 2018 16:00:23 +1000
Message-ID: <87a7r6kyrs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Tue, Jul 03, 2018 at 07:36:16PM +0530, Vaidyanathan Srinivasan wrote:
>> * Gautham R Shenoy <ego@linux.vnet.ibm.com> [2018-07-03 10:54:16]:
>> 
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> > 
>> > In the situations where snooze is the only cpuidle state due to
>> > firmware not exposing any platform idle states, the idle CPUs will
>> > remain in snooze for a long time with interrupts disabled causing the
>> > Hard-lockup detector to complain.
>> 
>> snooze_loop() will spin in SMT low priority with interrupt enabled. We
>> have local_irq_enable() before we get into the snooze loop.
>> Since this is a polling state, we should wakeup without an interrupt
>> and hence we set TIF_POLLING_NRFLAG as well.
>>
>
> You are right. We have a local_irq_enable() inside the snooze_loop.
>> 
>> > watchdog: CPU 51 detected hard LOCKUP on other CPUs 59
>> > watchdog: CPU 51 TB:535296107736, last SMP heartbeat TB:527472229239 (15281ms ago)
>> > watchdog: CPU 59 Hard LOCKUP
>> > watchdog: CPU 59 TB:535296252849, last heartbeat TB:526554725466 (17073ms ago)
>> 
>> hmm.. not sure why watchdog will complain, maybe something more is
>> going on.
>
> Will look into this Vaidy.

I'll wait for a v2.

cheers
