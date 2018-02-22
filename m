Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeBVW0q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:26:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:34206 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbeBVW0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:26:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,380,1515484800";
   d="scan'208";a="19725483"
Subject: Re: [RFC][PATCH 03/10] x86/mm: introduce "default" kernel PTE mask
To: Nadav Amit <namit@vmware.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203656.25C9B4EC@viggo.jf.intel.com>
 <57A9625E-3F25-402B-8B54-129A68449C48@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <61c68587-3ad5-edf7-539c-8af99c6220ea@linux.intel.com>
Date: Thu, 22 Feb 2018 14:26:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <57A9625E-3F25-402B-8B54-129A68449C48@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 02:21 PM, Nadav Amit wrote:
> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>> The __PAGE_KERNEL_* page permissions are "raw".  They contain bits
>> that may or may not be supported on the current processor.  They
>> need to be filtered by a mask (currently __supported_pte_mask) to
>> turn them into a value that we can actually set in a PTE.
>>
>> These __PAGE_KERNEL_* values all contain _PAGE_GLOBAL.  But, with
>> PTI, we want to be able to support _PAGE_GLOBAL (have the bit set
>> in __supported_pte_mask) but not have it appear in any of these
>> masks by default.
> 
> There might be a potential issue with this approach. __supported_pte_mask is
> exported, so out-of-tree modules might use it. They therefore can
> unknowingly use this value to set PTEs with _PAGE_GLOBAL set.

I don't think we can help out-of-tree modules getting this wrong.
They're OK if they use PAGE_KERNEL*, btw.
