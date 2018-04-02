Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeDBUl7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:41:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:30897 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756760AbeDBUl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:41:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,397,1517904000";
   d="scan'208";a="188081413"
Subject: Re: [PATCH 09/11] x86/pti: enable global pages for shared areas
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20180402172700.65CAE838@viggo.jf.intel.com>
 <20180402172713.B7D6F0C0@viggo.jf.intel.com>
 <CA+55aFx5GCahkr_-Y0qF5S=USCXhNcvWZ6gr_TxpvUVAh46STA@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <503339cf-7e54-0888-1767-c8ac87ce2130@linux.intel.com>
Date: Mon, 2 Apr 2018 13:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFx5GCahkr_-Y0qF5S=USCXhNcvWZ6gr_TxpvUVAh46STA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2018 10:56 AM, Linus Torvalds wrote:
> On Mon, Apr 2, 2018 at 10:27 AM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>> +       /*
>> +        * The cpu_entry_area is shared between the user and kernel
>> +        * page tables.  All of its ptes can safely be global.
>> +        */
>> +       if (boot_cpu_has(X86_FEATURE_PGE))
>> +               pte = pte_set_flags(pte, _PAGE_GLOBAL);
> So this is where the quesion of "why is this conditional" is valid.
> 
> We could set _PAGE_GLOBAL unconditionally, not bothering with testing
> X86_FEATURE_PGE.

I think we should just keep the check for now.  Before this patch set,
on !X86_FEATURE_PGE systems, we cleared _PAGE_GLOBAL in virtually all
places due to masking via __supported_pte_mask.

It is rather harmless either way, but being _consistent_ (by keeping the
check) with all of our PTEs is nice.
