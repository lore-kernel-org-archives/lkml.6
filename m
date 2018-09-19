Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0D5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE8420880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE8420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeISMXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:23:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38756 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:23:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2WG4-0001o4-Kd; Wed, 19 Sep 2018 00:46:44 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2WFz-0005ZE-EA; Wed, 19 Sep 2018 00:46:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-2-ebiederm@xmission.com>
        <20180919054653.GA32263@infradead.org>
Date:   Wed, 19 Sep 2018 08:46:30 +0200
In-Reply-To: <20180919054653.GA32263@infradead.org> (Christoph Hellwig's
        message of "Tue, 18 Sep 2018 22:46:53 -0700")
Message-ID: <87pnxaf0hl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g2WFz-0005ZE-EA;;;mid=<87pnxaf0hl.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19SCLt185ZZcn1QD8duvX6MTgWM3wI/UAI=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in it's only caller send_sigtrap
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>>  
>>  	clear_siginfo(&info);
>> -	fill_sigtrap_info(tsk, regs, error_code, si_code, &info);
>> +	tsk->thread.trap_nr = X86_TRAP_DB;
>> +	tsk->thread.error_code = error_code;
>> +
>> +	info.si_signo = SIGTRAP;
>> +	info.si_code = si_code;
>> +	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
>
> clear_siginfo already zeroes the whole structure, so this could be
> written more clearly as:
>
> 	if (user_mode(regs)
> 		info.si_addr = (void __user *)regs->ip;

That change does not make sense in this particular patch as it is just
code motion.

It also does not make sense in the final version of the code at
the end of the patch series which is:

void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
					 int error_code, int si_code)
{
	tsk->thread.trap_nr = X86_TRAP_DB;
	tsk->thread.error_code = error_code;

	/* Send us the fake SIGTRAP */
	force_sig_fault(SIGTRAP, si_code,
			user_mode(regs) ? (void __user *)regs->ip : NULL, tsk);
}

In this version the test also makes sense because struct siginfo is
gone because manually filling it out results in more bugs than
necessary.  That is now left up to force_sig_fault.

I was hoping that we could show that user_mode(regs) is always true.
But according to arch/x86/kernel/traps.c:do_debug watch points that will
trigger even when the kernel accesses user space addresses.

Eric

