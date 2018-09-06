Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19959C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D2E2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RIKOKCfW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WIlIUl1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D2E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeIFNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:35:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIFNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:35:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5692E6081A; Thu,  6 Sep 2018 09:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536224450;
        bh=AE++BEUB1fXydUyhHP1nZ4Dbp16C6/uEvaIfdiQ+spk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RIKOKCfWQwdhl8hiw27so1WEuOcXwAgC9YcoK0uWs8b+swJ4RQEW7fB9GGefDjigc
         9O5ySBbEsXzqp1ZK94odBr+e8+VrMzWv0TxR8EbscGpums4Ixrp6iny40u3E7W932E
         Q7lv5dRoAgh7R9fviXEAZTH2gW0DQkEATkEhN9gw=
Received: from [10.204.78.89] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A165607B5;
        Thu,  6 Sep 2018 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536224447;
        bh=AE++BEUB1fXydUyhHP1nZ4Dbp16C6/uEvaIfdiQ+spk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WIlIUl1ijJ4CRONvbVuPAIvY7q12cz13GYVIKlQgk436IGwdliYG8em1Ujwt/5OL5
         DXTiqdcI2DEcw2TnM4FMiSp2kj+/3wfi7+P3JO2aV/hQKaNqrwPnTiXd/i3lavBujV
         e/g3+5t2oh9PBxt3ndpV5bb17LTm+7/cdzpvJohM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A165607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     josh@joshtriplett.org, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
 <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de>
 <5b0e528f-e597-9598-3ff6-b9e08ddb8165@codeaurora.org>
 <alpine.DEB.2.21.1809051514070.1416@nanos.tec.linutronix.de>
 <9cac90ff-1a43-8663-da2e-7191975b5e93@codeaurora.org>
 <alpine.DEB.2.21.1809061016500.1416@nanos.tec.linutronix.de>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <9b4609c6-284f-cfab-82ba-2f2bf7f1867a@codeaurora.org>
Date:   Thu, 6 Sep 2018 14:30:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809061016500.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 01:48 PM, Thomas Gleixner wrote:
> On Thu, 6 Sep 2018, Neeraj Upadhyay wrote:
>> On 09/05/2018 06:47 PM, Thomas Gleixner wrote:
>>> On Wed, 5 Sep 2018, Neeraj Upadhyay wrote:
>>>> On 09/05/2018 05:53 PM, Thomas Gleixner wrote:
>>>>> And looking closer this is a general issue. Just that the TEARDOWN state
>>>>> makes it simple to observe. It's universaly broken, when the first
>>>>> teardown
>>>>> callback fails because, st->state is only decremented _AFTER_ the
>>>>> callback
>>>>> returns success, but undo_cpu_down() increments unconditionally.
>>>>>
>>>> As per my understanding, there are 2 problems here; one is fixed with your
>>>> patch, and other is cpuhp_reset_state() is used during rollback from
>>>> non-AP to
>>>> AP state, which seem to result in 2 increments of st->state (one increment
>>>> done by cpuhp_reset_state() and another by cpu_thread_fun()) .
>>> And how did your hack fix that up magically? I'll have a look later today.
>>>
>>> Thanks,
>>>
>>> 	tglx
>>
>> The hack fixes it by not calling cpuhp_reset_state() and doing rollback state
>> reset inline in  _cpu_down().
> 
> And how is that any different from the proper patch I sent? It ends up in
> the same state. So I have a hard time to understand your blurb above where
> you claim that my patch just solves one of two problems?
> 
> Thanks,
> 
> 	tglx
>

Yes, your patch solves the problem related to smpboot unparking being 
skipped during rollback and with the hack we end up in same state. The 
second thing, which I am referring to, is that there is one additional 
state increment. I missed the part that, it could be required, so that 
we reach CPUHP_AP_ONLINE_IDLE before calling __cpuhp_kick_ap(). So, it's 
not a problem.

* 	cpuhp_reset_state() does one state increment and we reach 
CPUHP_AP_ONLINE_IDLE.

	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
		cpuhp_reset_state(st, prev_state);
		__cpuhp_kick_ap(st);
	}

         CPUHP_TEARDOWN_CPU,
         CPUHP_AP_ONLINE_IDLE,
         CPUHP_AP_SMPBOOT_THREADS,


* cpuhp_thread_fun() does one more increment before invoking state 
callback (so, we skip CPUHP_AP_ONLINE_IDLE) and we reach 
CPUHP_AP_SMPBOOT_THREADS:

	static void cpuhp_thread_fun(unsigned int cpu)
	<snip>
		if (bringup) {
			st->state++;
			state = st->state;
	<snip>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
