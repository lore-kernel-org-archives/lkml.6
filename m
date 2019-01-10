Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A32206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="haK29tiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfAJGaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:30:09 -0500
Received: from mail.efficios.com ([167.114.142.138]:42340 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:30:08 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 36DE6B0150;
        Thu, 10 Jan 2019 01:30:07 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id l8ds6Jw8Xgkh; Thu, 10 Jan 2019 01:30:06 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7E138B0147;
        Thu, 10 Jan 2019 01:30:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7E138B0147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547101806;
        bh=1i+FuNE1GZJGB73rEXhQlyfTZDMJqV2OKVKQoUnosDo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=haK29tiw2bgesuIjrqQBVkv3C7LEeeWqzXeROsFOnpL/DFEfDLXKToujVGkZn5A5C
         iKcJSpAZrn43Zo17j4ZyoZZz7miwxhVJ19Y8uVyt4K6qIeccYVPuoxF6Ao4jqL3ADR
         wZaztIjnpSNgO4tAyZrBj2ZiKJY0qiMK2VerVU/dnuQZbaG0Y+EFfXoGEGHlAfsLk4
         giXBUPDTlkxGz41qGVLTr2f29dwYkAc1gXtKF4mzOzKW44iMPpP2hcwMcLaJga/5D4
         SMXvAvlD+4byOH7CzsXl9pUjQupTyaZKbPi00zLA2zFj2YqduI3dhTbQNOQskWt6fe
         iKPBPtMsJ0V2g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 05VQ7vK6eO8z; Thu, 10 Jan 2019 01:30:06 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 29C39B0141;
        Thu, 10 Jan 2019 01:30:06 -0500 (EST)
Date:   Thu, 10 Jan 2019 01:30:05 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>
Message-ID: <219114011.864.1547101805680.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190110041328.GE1215@linux.ibm.com>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com> <20190110041328.GE1215@linux.ibm.com>
Subject: Re: Possible use of RCU while in extended QS: idle vs RCU read-side
 in interrupt vs rcu_eqs_exit
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: Possible use of RCU while in extended QS: idle vs RCU read-side in interrupt vs rcu_eqs_exit
Thread-Index: AsVByuRYawQIRQ6onzvx0eBvIB4G7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 9, 2019, at 8:13 PM, paulmck paulmck@linux.ibm.com wrote:

> On Wed, Jan 09, 2019 at 08:38:51PM -0500, Mathieu Desnoyers wrote:
>> Hi Paul,
>> 
>> I've had a user report that trace_sched_waking() appears to be
>> invoked while !rcu_is_watching() in some situation, so I started
>> digging into the scheduler idle code.
>> 
>> It appears that interrupts are re-enabled before rcu_eqs_exit() is
>> invoked when exiting idle code from the scheduler.
>> 
>> I wonder what happens if an interrupt handler (including scheduler code)
>> happens to issue a RCU read-side critical section before rcu_eqs_exit()
>> is called ? Is there some code on interrupt entry that ensures rcu eqs
>> state is exited in such scenario ?
> 
> Interrupt handlers are supposed to invoke irq_enter(), which will in
> turn invoke rcu_irq_enter(), which should take care of things.
> 
> However, there are cases where a given architecture knows that a given
> interrupt handler does not contain RCU readers, and in this case, the
> architecture might omit the rcu_irq_enter() or maybe even the whole
> irq_enter().  And then it is all fun and games until someone adds an
> RCU read-side critical section.  ;-)

Even if an irq handler does not contain any RCU read-side critical
section, won't it end by possibly invoking the scheduler before
returning ? Considering that the scheduler has tracepoints which
use RCU, this might be related to the issue that has been brought
to my attention.

Do you have examples of such interrupt handlers which do not invoke
rcu_irq_enter() ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
