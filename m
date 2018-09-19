Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0537FECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF862150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF862150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbeIST2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:28:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45795 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeIST2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:28:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2crh-0000NI-LL; Wed, 19 Sep 2018 07:50:01 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2crg-0000d3-Jq; Wed, 19 Sep 2018 07:50:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-3-ebiederm@xmission.com>
        <alpine.DEB.2.21.1809182217000.1468@nanos.tec.linutronix.de>
Date:   Wed, 19 Sep 2018 15:49:50 +0200
In-Reply-To: <alpine.DEB.2.21.1809182217000.1468@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 18 Sep 2018 22:19:14 +0200
        (CEST)")
Message-ID: <87k1nhfvgh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g2crg-0000d3-Jq;;;mid=<87k1nhfvgh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX186PHDbpIHtPNLMretxbiFFGzg9TRJJMZo=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 03/20] signal/x86: Move MCE error reporting out of force_sig_info_fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>>  #ifdef CONFIG_MEMORY_FAILURE
>>  	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
>> +		unsigned lsb = 0;
>
> Newline between variable declaration and code please.
>
>>  		printk(KERN_ERR
>>  	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
>>  			tsk->comm, tsk->pid, address);
>
> Can you please convert that to pr_err() while at it?
>
>> -		code = BUS_MCEERR_AR;
>> +		if (fault & VM_FAULT_HWPOISON_LARGE)
>> +			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
>> +		if (fault & VM_FAULT_HWPOISON)
>> +			lsb = PAGE_SHIFT;
>> +		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, tsk);
>> +		return;
>>  	}
>
> With that fixed:
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Fixes applied.

Eric

