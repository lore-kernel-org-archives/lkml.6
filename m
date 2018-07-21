Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09977ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD6C20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="GFIg3ui/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD6C20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=runbox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeGVAN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:13:27 -0400
Received: from aibo.runbox.com ([91.220.196.211]:57406 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbeGVAN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=cNJypm2JBkDQZ8JoO4Ni3CqeeAAu/d0OXi0U0y0HQ0Q=; b=GFIg3ui/Y679q0Ttvc+PMREI2Q
        m/mQQftLXoy8R4a8oTzYyG1BNVl5859g+tM89mCe/KSDHPR6hJzVbzQHJplSIRF+2EwN6LgviZQdO
        Y3JHx+VOZoIcdff5zdySOtkzIBjKo7d2Fff14fyA/vJNiMIyaT/AMwWXVFCIIFByZMiRtRGRQ37+C
        FyHWzHwZtnFxULiJEUDkeHtU5/nb5z/gT3ZZJXKkFHGSPmMUzTbTdzG9FrCtiTc9tJBRCgPyM32eN
        nd+t15Cw9wBybCoQTLe5c1vT7DXuGJBMmtDF9dyKoy1R13GqgraPhOE08ttB74veykfVuEFhYy1rm
        Mj1na4Hg==;
Received: from [10.9.9.211] (helo=mailfront11.runbox.com)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1fh19P-0000R2-Cj; Sun, 22 Jul 2018 01:18:59 +0200
Received: by mailfront11.runbox.com with esmtpsa  (uid:769847 )  (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        id 1fh19C-0005gG-Uc; Sun, 22 Jul 2018 01:18:47 +0200
Subject: Re: [PATCH 1/2] x86/entry/64: Do not clear %rbx under Xen
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        stable@vger.kernel.org
References: <20180721194909.23903-1-m.v.b@runbox.com>
 <5a21b844-36a9-8fe4-c6cd-6fade3dfa941@oracle.com>
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
Message-ID: <6426e7a4-2da0-9a36-298a-89e956e98812@runbox.com>
Date:   Sat, 21 Jul 2018 19:18:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5a21b844-36a9-8fe4-c6cd-6fade3dfa941@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/2018 05:19 PM, Boris Ostrovsky wrote:
> On 07/21/2018 03:49 PM, M. Vefa Bicakci wrote:
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index c7449f377a77..96e8ff34129e 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1129,7 +1129,7 @@ ENTRY(xen_failsafe_callback)
>>   	addq	$0x30, %rsp
>>   	UNWIND_HINT_IRET_REGS
>>   	pushq	$-1 /* orig_ax = -1 => not a system call */
>> -	PUSH_AND_CLEAR_REGS
>> +	PUSH_AND_CLEAR_REGS clear_rbx=0
> 
> 
> Do we need this at all? We are returning from the hypervisor here.
> 
> -boris
> 
>>   	ENCODE_FRAME_POINTER
>>   	jmp	error_exit
>>   END(xen_failsafe_callback)

Hello Boris,

If you are referring to the PUSH_AND_CLEAR_REGS macro itself, I am not sure;
however, not clearing the RBX register seemed to resolve the issues mentioned
in the commit message for me. Given Andy's comment though, I believe that the
approach in this patch may not be correct.

Thank you,

Vefa
