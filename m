Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeCXAlA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:41:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:55975 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbeCXAk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:40:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,352,1517904000";
   d="scan'208";a="36364722"
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
Date: Fri, 23 Mar 2018 17:40:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 11:26 AM, Linus Torvalds wrote:
> On Fri, Mar 23, 2018 at 10:44 AM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>>
>> This adds one major change from the last version of the patch set
>> (present in the last patch).  It makes all kernel text global for non-
>> PCID systems.  This keeps kernel data protected always, but means that
>> it will be easier to find kernel gadgets via meltdown on old systems
>> without PCIDs.  This heuristic is, I think, a reasonable one and it
>> keeps us from having to create any new pti=foo options
> 
> Sounds sane.
> 
> The patches look reasonable, but I hate seeing a patch series like
> this where the only ostensible reason is performance, and there are no
> performance numbers anywhere..

Well, rats.  This somehow makes things slower with PCIDs on.  I thought
I reversed the numbers, but I actually do a "grep -c GLB
/sys/kernel/debug/page_tables/kernel" and record that in my logs right
next to the output of time(1), so it's awfully hard to screw up.

This is time doing a modestly-sized kernel compile on a 4-core Skylake
desktop.

                        User Time       Kernel Time     Clock Elapsed
Baseline ( 0 GLB PTEs)  803.79          67.77           237.30
w/series (28 GLB PTEs)  807.70 (+0.7%)  68.07 (+0.7%)   238.07 (+0.3%)

Without PCIDs, it behaves the way I would expect.

I'll ask around, but I'm open to any ideas about what the heck might be
causing this.
