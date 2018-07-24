Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEEDECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19EB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxe7nU0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19EB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbeGXCpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388194AbeGXCpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:45:24 -0400
Received: from [192.168.0.217] (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087C220874;
        Tue, 24 Jul 2018 01:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532396487;
        bh=CuWAZMcHp/fTNsdqlI9EZoALnDKVcLTWdhE9n8mCK5k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qxe7nU0TPh+97eVmHgk6bKRkmAVTx4+RKsIiaEHZZbQPlF/bArDIyUymV3lShmEu5
         BcceIRf7JdrR/5QlwqUb/yFKb7WTC/DESKuIr0nf2EueNFudMBF8FTW8GKWp89xqof
         1tFfVL2UzRq5x7vBGie441/EsjdFIkL8k1Oe26BE=
Subject: Re: [PATCH 4/7] x86/umwait_contro: Set global umwait maximum time
 limit and umwait C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
 <1532350557-98388-5-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <28650265-964f-caeb-5ebb-788bf86ee9e3@kernel.org>
Date:   Mon, 23 Jul 2018 18:41:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532350557-98388-5-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 05:55 AM, Fenghua Yu wrote:
> UMWAIT or TPAUSE called by user process makes processor to reside in
> a light-weight power/performance optimized state (C0.1 state) or an
> improved power/performance optimized state (C0.2 state).
> 
> IA32_UMWAIT_CONTROL MSR register allows OS to set global maximum umwait
> time and disable C0.2 on the processor.
> 
> The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which
> means there is no global time limit for UMWAIT and TPAUSE instructions.
> Each process sets its own umwait maximum time as the instructions operand.
> We don't set a non-zero global umwait maximum time value to enforce user
> wait timeout because we couldn't find any usage for it.

Do you know what the instruction designers had in mind?  I assume they 
were thinking of *something*, but I'm seriously mystified by three things:

  - Why does CF work the way it does?  It seems like it would be 
genuinely useful for CF to indicate whether the in-register timeout has 
expired, but that's not what CF does.

  - Why does the global timeout apply even at CPL 0?

  - Why does the C0.2 control apply at CPL 0?

And I'm also a bit surprised that the instruction can't be turned off 
entirely for CPL 3.
