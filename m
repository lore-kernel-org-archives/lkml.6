Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeBXEel (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 23:34:41 -0500
Received: from cock.li ([185.100.85.212]:33598 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeBXEek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 23:34:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Feb 2018 04:34:35 +0000
From: thetruthbeforeus@firemail.cc
To: undisclosed-recipients:;
Subject: Re: [RFC][PATCH 00/10] Use global pages with PTI - Truth about the
 white man.
In-Reply-To: <CA+55aFzT4XcZ1i4c7Q_A0bsc0M9qh705h84HLnCCq2pNv2G=KQ@mail.gmail.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <CA+55aFy064KtXdduyM2E4rU6-ZJsOB69x2aJdZxbXgJPh2HUOQ@mail.gmail.com>
 <7e81fb89-5908-7d31-9225-defc48dbfa41@linux.intel.com>
 <CA+55aFzT4XcZ1i4c7Q_A0bsc0M9qh705h84HLnCCq2pNv2G=KQ@mail.gmail.com>
Message-ID: <9eae50b5ba196051bf35911abd54c5ab@firemail.cc>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, this talk about the memory map bullshit is interesting and all,
with that binary encoding and shit. But I want you to take a moment and
reflect. I want you to reflect on truth.

Ask yourself. "Am I a white man" and then listen to those who...
who see you ALL for what you are and couldn't be.

Take a listen:
http://www.liveleak.com/view?i=017_1519418755

Or are you too ... well lets just let that one slide.

On 2018-02-24 04:20, Linus Torvalds wrote:
> On Fri, Feb 23, 2018 at 5:49 PM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>> On 02/22/2018 01:52 PM, Linus Torvalds wrote:
>>> Side note - and this may be crazy talk - I wonder if it might make
>>> sense to have a mode where we allow executable read-only kernel pages
>>> to be marked global too (but only in the kernel mapping).
>> 
>> We did that accidentally, somewhere.  It causes machine checks on K8's
>> iirc, which is fun (52994c256df fixed it).  So, we'd need to make sure
>> we avoid it there, or just make it global in the user mapping too.
> 
> They'd be missing _entirely_ in the user maps, which should be fine.
> The problem that commit 52994c256df3 fixed was that they actually
> existed in the user maps, just with different data, and then you can
> have a ITLB and a DTLB entry for the same address that don't match
> (because one has been loaded from the kernel mapping and the other
> from the user one).
> 
> But when the address isn't mapped at all in the user map, that should
> be fine - because there's no associated TLB entry to get mixed up
> about.
> 
> It's no different from clearing a page from the page table before then
> flushing the TLB entry later - which is the normal (and required)
> behavior for unmapping a page. For a while it exists in the TLB
> without existing in the page tables.
> 
>> Just for fun, I tried a 4-core Skylake system with KPTI and nopcid and
>> compiled a random kernel 10 times.  I did three configs: no global, 
>> all
>> kernel text global + cpu_entry_area, and only cpu_entry_area + entry
>> text.  The delta percentages are from the Baseline.  The deltas are
>> measurable, but the largest bang for our buck is obviously the entry 
>> text.
>> 
>>                         User Time       Kernel Time     Clock Elapsed
>> Baseline (33 GLB PTEs)  907.6           81.6            264.7
>> Entry    (28 GLB PTEs)  910.9 (+0.4%)   84.0 (+2.9%)    265.2 (+0.2%)
>> No global( 0 GLB PTEs)  914.2 (+0.7%)   89.2 (+9.3%)    267.8 (+1.2%)
> 
> That's actually noticeable. Maybe not so much in the final elapsed
> time itself, but almost 3% for just the kernel side sounds meaningful.
> 
> Of course, that's with nopcid, so it's a fairly small special case, but 
> still.
> 
>> It's a single line of code to go from the "33" to "28" configuration, 
>> so
>> it's totally doable.  But, it means having and parsing another boot
>> option that confuses people and then I have to go write actual
>> documentation, which I detest. :)
> 
> Heh.
> 
> Ok, maybe the complexity isn't in the code, but in the concept.
> 
>                Linus
