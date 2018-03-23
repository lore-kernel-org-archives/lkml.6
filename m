Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeCWT0a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:26:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:5959 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCWT03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:26:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="185455139"
Subject: Re: [PATCH 05/11] x86/mm: do not auto-massage page protections
To: Nadav Amit <namit@vmware.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <20180323174454.CD00F614@viggo.jf.intel.com>
 <224464E0-1D3A-4ED8-88E0-A8E84C4265FC@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <ed72b04d-de86-113e-ab45-e1577e5c4226@linux.intel.com>
Date: Fri, 23 Mar 2018 12:26:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <224464E0-1D3A-4ED8-88E0-A8E84C4265FC@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 12:15 PM, Nadav Amit wrote:
>> A PTE is constructed from a physical address and a pgprotval_t.
>> __PAGE_KERNEL, for instance, is a pgprot_t and must be converted
>> into a pgprotval_t before it can be used to create a PTE.  This is
>> done implicitly within functions like set_pte() by massage_pgprot().
>>
>> However, this makes it very challenging to set bits (and keep them
>> set) if your bit is being filtered out by massage_pgprot().
>>
>> This moves the bit filtering out of set_pte() and friends.  For
> 
> I don’t see that set_pte() filters the bits, so I am confused by this
> sentence...

This was a typo/thinko.  It should be pfn_pte().

>> +static inline pgprotval_t check_pgprot(pgprot_t pgprot)
>> +{
>> +	pgprotval_t massaged_val = massage_pgprot(pgprot);
>> +
>> +	/* mmdebug.h can not be included here because of dependencies */
>> +#ifdef CONFIG_DEBUG_VM
>> +	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
>> +		  "attempted to set unsupported pgprot: %016lx "
>> +		  "bits: %016lx supported: %016lx\n",
>> +		  pgprot_val(pgprot),
>> +		  pgprot_val(pgprot) ^ massaged_val,
>> +		  __supported_pte_mask);
>> +#endif
> Why not to use VM_WARN_ON_ONCE() and avoid the ifdef?

I wanted a message.  VM_WARN_ON_ONCE() doesn't let you give a message.
