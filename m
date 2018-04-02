Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeDBUXH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:23:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:13589 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756412AbeDBUXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:23:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,397,1517904000";
   d="scan'208";a="188077982"
Subject: Re: [PATCH 01/11] x86/mm: factor out pageattr _PAGE_GLOBAL setting
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20180402172700.65CAE838@viggo.jf.intel.com>
 <20180402172701.5D4CA7DD@viggo.jf.intel.com>
 <CA+55aFw7mLJrr+VqvEY-T3KqR2-xaYSoyU2Jg7VY1Sb1cu1L-w@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <36637d85-d716-a2d4-189c-10ed209f4827@linux.intel.com>
Date: Mon, 2 Apr 2018 13:23:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFw7mLJrr+VqvEY-T3KqR2-xaYSoyU2Jg7VY1Sb1cu1L-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2018 10:52 AM, Linus Torvalds wrote:
> On Mon, Apr 2, 2018 at 10:27 AM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>>
>> Aside: _PAGE_GLOBAL is ignored when CR4.PGE=1, so why do we
>> even go to the trouble of filtering it anywhere?
> 
> I'm assuming this is a typo, and you mean "when CR4.PGE=0".

Yes, that is a typo.

> The question you raise may be valid, but within the particular context
> of *this* patch it is not.

I thought it was relevant because I was asking myself: Why is it OK for
the (old) code to be doing this:

> -	if (pgprot_val(req_prot) & _PAGE_PRESENT)
> -		pgprot_val(req_prot) |= _PAGE_PSE | _PAGE_GLOBAL;

When _PAGE_GLOBAL is not supported.  This "Aside" got moved a bit away
from the comment, but I actually mean to refer to the comment that talks
about canon_pgprot():

>> canon_pgprot() will clear it if unsupported,
>> but we *always* set it.

and its use of __supported_pte_mask.

I'll redo the changelog a bit and hopefully capture all this along with
correcting the typo.
