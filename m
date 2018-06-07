Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AGKFN4CAGVuQBAAAmS7hNA
	; Thu, 07 Jun 2018 18:59:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CCFE36089E; Thu,  7 Jun 2018 18:59:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 45B8E601D2;
	Thu,  7 Jun 2018 18:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45B8E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeFGS7J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:59:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751231AbeFGS7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:59:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4386B40122A1;
        Thu,  7 Jun 2018 18:59:06 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-135.ams2.redhat.com [10.36.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C11081C65D;
        Thu,  7 Jun 2018 18:58:57 +0000 (UTC)
Subject: Re: [PATCH 03/10] x86/cet: Signal handling for shadow stack
To: Andy Lutomirski <luto@amacapital.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-4-yu-cheng.yu@intel.com>
 <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <2b920019-cf03-334c-3b6a-b2c6b7f4dfa3@redhat.com>
Date: Thu, 7 Jun 2018 20:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 07 Jun 2018 18:59:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 07 Jun 2018 18:59:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 08:30 PM, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> Set and restore shadow stack pointer for signals.
> 
> How does this interact with siglongjmp()?

We plan to use some unused signal mask bits in the jump buffer (we have 
a lot of those in glibc for some reason) to store the shadow stack pointer.

> This patch makes me extremely nervous due to the possibility of ABI
> issues and CRIU breakage.
> 
>> diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
>> index 844d60eb1882..6c8997a0156a 100644
>> --- a/arch/x86/include/uapi/asm/sigcontext.h
>> +++ b/arch/x86/include/uapi/asm/sigcontext.h
>> @@ -230,6 +230,7 @@ struct sigcontext_32 {
>>          __u32                           fpstate; /* Zero when no FPU/extended context */
>>          __u32                           oldmask;
>>          __u32                           cr2;
>> +       __u32                           ssp;
>>   };
>>
>>   /*
>> @@ -262,6 +263,7 @@ struct sigcontext_64 {
>>          __u64                           trapno;
>>          __u64                           oldmask;
>>          __u64                           cr2;
>> +       __u64                           ssp;
>>
>>          /*
>>           * fpstate is really (struct _fpstate *) or (struct _xstate *)
>> @@ -320,6 +322,7 @@ struct sigcontext {
>>          struct _fpstate __user          *fpstate;
>>          __u32                           oldmask;
>>          __u32                           cr2;
>> +       __u32                           ssp;
> 
> Is it actually okay to modify these structures like this?  They're
> part of the user ABI, and I don't know whether any user code relies on
> the size being constant.

Probably not.  Historically, these things have been tacked at the end of 
the floating point state, see struct _xstate:

         /* New processor state extensions go here: */

However, I'm not sure if this is really ideal because I doubt that 
everyone who needs the shadow stack pointer also wants to sacrifice 
space for the AVX-512 save area (which is already a backwards 
compatibility hazard).  Other architectures have variable offsets and 
some TLV-style setup here.

Thanks,
Florian
