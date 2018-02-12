Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964904AbeBLQUC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:20:02 -0500
Received: from www.sr71.net ([198.145.64.142]:53760 "EHLO blackbird.sr71.net"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S964916AbeBLQUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:20:01 -0500
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
To: Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, peterz@infradead.org
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
Cc: linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
From: Dave Hansen <dave@sr71.net>
Message-ID: <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
Date: Mon, 12 Feb 2018 08:13:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 02:22 AM, Ingo Molnar wrote:
>> +static inline void firmware_restrict_branch_speculation_end(void)
>> +{
>> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
>> +			      X86_FEATURE_USE_IBRS_FW);
> BTW., there's a detail that only occurred to me today, this enabling/disabling 
> sequence is not NMI safe, and it might be called from NMI context:

FWIW, Tim Chen and I talked about this a bunch.  We ended up just
saving/restoring the MSR verbatim in the NMI handler the same way we do
CR3, stashing it in a high general-purpose-register (r%12?).  That costs
a RDMSR (at least) and an WRMSR (which you can optimize out).  We have a
patch for that somewhere if anybody wants it.

We also came to the same conclusion that it's a rather challenging thing
to exploit these cases, especially when you consider that we can easily
do RSB stuffing on NMI exit just before going back to the firmware.
