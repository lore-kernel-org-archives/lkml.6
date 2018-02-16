Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756795AbeBPAmx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:42:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:6524 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752984AbeBPAmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:42:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="18132304"
Subject: Re: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
To: Nadav Amit <nadav.amit@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
 <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <9a825978-fe69-1c10-0da0-0c67dbb9b232@linux.intel.com>
Date: Thu, 15 Feb 2018 16:42:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 04:25 PM, Nadav Amit wrote:
> Dave Hansen <dave.hansen@linux.intel.com> wrote:
> 
>> On 02/15/2018 08:35 AM, Nadav Amit wrote:
>>> I removed the PTI disabling while SMEP is unsupported, although I
>>> must admit I did not fully understand why it is required.
>>
>> Do you mean you don't fully understand how PTI gives SMEP-like behavior
>> on non-SMEP hardware?
> 
> No. I understand how it provide SMEP-like behavior, and I understand the value
> of SMEP by itself.
> 
> However, I do not understand why SMEP-like protection is required to protect
> processes that run in compatibility-mode from Meltdown/Spectre attacks. As
> far as I understand, the process should not be able to manipulate the kernel
> to execute code in the low 4GB.

There are two problems: one is that regardless of Meltdown/Spectre, SMEP
is valuable.  It's valuable to everything, compatibility-mode or not.

The second problem is the RSB.  It has a full-width virtual address and,
unlike the other indirect branch prediction, can steer you anywhere
including to the low 4GB.
