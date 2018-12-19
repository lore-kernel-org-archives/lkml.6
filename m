Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015FA2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeLSN3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:29:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbeLSN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:29:13 -0500
Received: from www-data by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZbuQ-0004ta-EO; Wed, 19 Dec 2018 14:29:10 +0100
To:     Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch] futex: Cure exit race
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Dec 2018 14:29:10 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
In-Reply-To: <alpine.DEB.2.21.1812172239090.1660@nanos.tec.linutronix.de>
References: <20181210152311.986181245@linutronix.de>
 <20181210160205.GQ5289@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1812101824070.1667@nanos.tec.linutronix.de>
 <20181212090418.GT5289@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1812172239090.1660@nanos.tec.linutronix.de>
Message-ID: <539c47359b37a5b6b9177da823be45d6@dl.linutronix.de>
User-Agent: html based client
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-18 10:31, Thomas Gleixner wrote:
> On Wed, 12 Dec 2018, Peter Zijlstra wrote:
>> On Mon, Dec 10, 2018 at 06:43:51PM +0100, Thomas Gleixner wrote:
>> @@ -806,6 +806,8 @@ void __noreturn do_exit(long code)
>>  		 * task into the wait for ever nirwana as well.
>>  		 */
>>  		tsk->flags |= PF_EXITPIDONE;
>> +		smp_mb();
>> +		wake_up_bit(&tsk->flags, 3 /* PF_EXITPIDONE */);
>
> Using ilog2(PF_EXITPIDONE) spares that horrible inline comment and 
> more
> importantly selects the right bit. 0x04 is bit 2 ....

Plus wake_up_bit() and wait_on_bit() want an unsigned long, but 
tsk->flags is
unsigned int....

Moar staring....

