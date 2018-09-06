Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67971C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7EB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IRSeoFnU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IRSeoFnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7EB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeIFH3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:29:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIFH3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:29:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D925B607B5; Thu,  6 Sep 2018 02:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536202586;
        bh=6ZXclQG4RV6rQzOwlrK8mLRgw9s+Z9Ya9a+JKHXTv4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IRSeoFnUrxMIDTXekpIxMFCuEnv3W1+9s6/Pb92VRAwhI6gMjCo1zNYvSJi7ymrqk
         6dBglyIMzG+3PKKeECw5b/1qdAohM0GU65Q8jXRS7cHO/x029w2Er7qlU6nuv1b+Z+
         iWQkNiYpqlko8nPKkE5EF4eEAh2vAWXfhE4xcCIE=
Received: from [10.204.78.89] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D58706034F;
        Thu,  6 Sep 2018 02:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536202586;
        bh=6ZXclQG4RV6rQzOwlrK8mLRgw9s+Z9Ya9a+JKHXTv4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IRSeoFnUrxMIDTXekpIxMFCuEnv3W1+9s6/Pb92VRAwhI6gMjCo1zNYvSJi7ymrqk
         6dBglyIMzG+3PKKeECw5b/1qdAohM0GU65Q8jXRS7cHO/x029w2Er7qlU6nuv1b+Z+
         iWQkNiYpqlko8nPKkE5EF4eEAh2vAWXfhE4xcCIE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D58706034F
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
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <9cac90ff-1a43-8663-da2e-7191975b5e93@codeaurora.org>
Date:   Thu, 6 Sep 2018 08:26:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809051514070.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2018 06:47 PM, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Neeraj Upadhyay wrote:
>> On 09/05/2018 05:53 PM, Thomas Gleixner wrote:
>>> And looking closer this is a general issue. Just that the TEARDOWN state
>>> makes it simple to observe. It's universaly broken, when the first teardown
>>> callback fails because, st->state is only decremented _AFTER_ the callback
>>> returns success, but undo_cpu_down() increments unconditionally.
>>>
>> As per my understanding, there are 2 problems here; one is fixed with your
>> patch, and other is cpuhp_reset_state() is used during rollback from non-AP to
>> AP state, which seem to result in 2 increments of st->state (one increment
>> done by cpuhp_reset_state() and another by cpu_thread_fun()) .
> And how did your hack fix that up magically? I'll have a look later today.
>
> Thanks,
>
> 	tglx

The hack fixes it by not calling cpuhp_reset_state() and doing rollback 
state reset inline in  _cpu_down().




-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

