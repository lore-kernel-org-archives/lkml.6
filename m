Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeDRO32 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:29:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46773 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeDRO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:29:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Dave Young <dyoung@redhat.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kexec\@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Indranil Choudhury <indranil@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        "stephen\@networkplumber.org" <stephen@networkplumber.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds\@linux-foundation.org" <torvalds@linux-foundation.org>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "viro\@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
        <20180418061546.GA4551@dhcp-128-65.nay.redhat.com>
        <20180418123114.GA19159@chelsio.com>
Date: Wed, 18 Apr 2018 09:28:01 -0500
In-Reply-To: <20180418123114.GA19159@chelsio.com> (Rahul Lakkireddy's message
        of "Wed, 18 Apr 2018 18:01:16 +0530")
Message-ID: <871sfcy4ge.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f8o5L-0005EG-Of;;;mid=<871sfcy4ge.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+gJS50/TT6lNomT5JyeARc3R5qFat64kg=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3766]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 321 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.0 (1.3%), b_tie_ro: 3.2 (1.0%), parse: 1.42 (0.4%),
        extract_message_metadata: 21 (6.6%), get_uri_detail_list: 3.3 (1.0%),
        tests_pri_-1000: 9 (2.9%), tests_pri_-950: 1.18 (0.4%), tests_pri_-900: 1.04
        (0.3%), tests_pri_-400: 31 (9.6%), check_bayes: 30 (9.3%), b_tokenize: 8
        (2.6%), b_tok_get_all: 12 (3.8%), b_comp_prob: 2.6 (0.8%), b_tok_touch_all:
        4.4 (1.4%), b_finish: 0.54 (0.2%), tests_pri_0: 244 (76.0%),
        check_dkim_signature: 0.47 (0.1%), check_dkim_adsp: 3.1 (1.0%),
        tests_pri_500: 3.9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware logs in crash recovery kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Wednesday, April 04/18/18, 2018 at 11:45:46 +0530, Dave Young wrote:
>> Hi Rahul,
>> On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
>> > On production servers running variety of workloads over time, kernel
>> > panic can happen sporadically after days or even months. It is
>> > important to collect as much debug logs as possible to root cause
>> > and fix the problem, that may not be easy to reproduce. Snapshot of
>> > underlying hardware/firmware state (like register dump, firmware
>> > logs, adapter memory, etc.), at the time of kernel panic will be very
>> > helpful while debugging the culprit device driver.
>> > 
>> > This series of patches add new generic framework that enable device
>> > drivers to collect device specific snapshot of the hardware/firmware
>> > state of the underlying device in the crash recovery kernel. In crash
>> > recovery kernel, the collected logs are added as elf notes to
>> > /proc/vmcore, which is copied by user space scripts for post-analysis.
>> > 
>> > The sequence of actions done by device drivers to append their device
>> > specific hardware/firmware logs to /proc/vmcore are as follows:
>> > 
>> > 1. During probe (before hardware is initialized), device drivers
>> > register to the vmcore module (via vmcore_add_device_dump()), with
>> > callback function, along with buffer size and log name needed for
>> > firmware/hardware log collection.
>> 
>> I assumed the elf notes info should be prepared while kexec_[file_]load
>> phase. But I did not read the old comment, not sure if it has been discussed
>> or not.
>> 
>
> We must not collect dumps in crashing kernel. Adding more things in
> crash dump path risks not collecting vmcore at all. Eric had
> discussed this in more detail at:
>
> https://lkml.org/lkml/2018/3/24/319
>
> We are safe to collect dumps in the second kernel. Each device dump
> will be exported as an elf note in /proc/vmcore.

It just occurred to me there is one variation that is worth
considering.

Is the area you are looking at dumping part of a huge mmio area?
I think someone said 2GB?

If that is the case it could be worth it to simply add the needed
addresses to the range of memory we need to dump, and simply having a
elf note saying that is what happened.

>> If do this in 2nd kernel a question is driver can be loaded later than vmcore init.
>
> Yes, drivers will add their device dumps after vmcore init.
>
>> How to guarantee the function works if vmcore reading happens before
>> the driver is loaded?
>> 
>> Also it is possible that kdump initramfs does not contains the driver
>> module.
>> 
>> Am I missing something?
>> 
>
> Yes, driver must be in initramfs if it wants to collect and add device
> dump to /proc/vmcore in second kernel.

Eric
