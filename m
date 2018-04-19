Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeDSQCd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:02:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:20999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753633AbeDSQCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:02:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,469,1517904000";
   d="scan'208";a="217852409"
Subject: Re: [PATCH 11/11] x86/pti: leave kernel text global for !PCID
To: Kees Cook <keescook@google.com>
References: <20180406205501.24A1A4E7@viggo.jf.intel.com>
 <20180406205518.E3D989EB@viggo.jf.intel.com>
 <CAGXu5jJS-PYS7ONy_neDQCqVGRwrtjg=VdktXALQnzRe1+RNuA@mail.gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Juergen Gross <jgross@suse.com>,
        X86 ML <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <db2f91ab-9565-7bda-b3c3-a1cdb61d1587@linux.intel.com>
Date: Thu, 19 Apr 2018 09:02:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJS-PYS7ONy_neDQCqVGRwrtjg=VdktXALQnzRe1+RNuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 05:11 PM, Kees Cook wrote:
> On Fri, Apr 6, 2018 at 1:55 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>> +/*
>> + * For some configurations, map all of kernel text into the user page
>> + * tables.  This reduces TLB misses, especially on non-PCID systems.
>> + */
>> +void pti_clone_kernel_text(void)
>> +{
>> +       unsigned long start = PFN_ALIGN(_text);
>> +       unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
> I think this is too much set global: _end is after data, bss, and brk,
> and all kinds of other stuff that could hold secrets. I think this
> should match what mark_rodata_ro() is doing and use
> __end_rodata_hpage_align. (And on i386, this should be maybe _etext.)

Sounds reasonable to me.  This does assume that there are no secrets
built into the kernel image, right?
