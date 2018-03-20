Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeCTQds (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:33:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:8967 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTQdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:33:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,336,1517904000";
   d="scan'208";a="35388172"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Topic: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Index: AQHTv61aFYaSukXqZEajMVMtZoAMNaPZnPEA//+lWwA=
Date: Tue, 20 Mar 2018 16:33:42 +0000
Message-ID: <B96DA962-6278-4FDE-A8C6-020E789CE67F@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com>
In-Reply-To: <CALCETrXes+XRLWQfKO+jmzyTAxncZAm0WReuKFvNDcFGERqyeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.178.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <998024BA004D1B458EDC0043B50CBF81@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KGXsuO025666

On 3/20/18, 07:58, "Andy Lutomirski" <luto@kernel.org> wrote:
 
>> On Mar 19, 2018, at 10:49 AM, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
>> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
>> GS base is not the kernel's.
>>
>> FSGSBASE instructions allow user to write any value on GS base;
>> even negative. Sign check on the current GS base is not
>> sufficient. Fortunately, reading GS base is fast. Kernel GS
>> base is also known from the offset table with the CPU number.
    
> The original version of these patches (mine and Andi’s) didn’t have
>  this comparison, didn’t need RDMSR, and didn’t allow malicious user
>  programs to cause the kernel to run decently large chunks of code with
>  the reverse of the expected GS convention. Why did you change it?
    
>    I really really don't like having a corner case like this that can and
>    will be triggered by malicious user code but that is hard to write a
>    self-test for because it involves guessing a 64-bit magic number.
>    Untestable corner cases in the x86 entry code are bad.

Originally, I took it. But since it keeps kernel GS base on the (IST) stack,
it is thought as fragile [1] AFAIK. If you really don't like this "comparison"
then GS base can be written (unconditionally) while the original GS
base stitched (like the original approach did) IMO.
    
[1] https://marc.info/?l=linux-kernel&m=151725088506036&w=3
