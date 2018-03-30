Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeC3SnL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 14:43:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34091 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeC3SnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 14:43:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kexec\@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "viro\@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen\@networkplumber.org" <stephen@networkplumber.org>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds\@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
        <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
        <20180330103907.GC3313@nanopsycho>
        <20180330105156.GA24344@chelsio.com>
Date: Fri, 30 Mar 2018 13:42:00 -0500
In-Reply-To: <20180330105156.GA24344@chelsio.com> (Rahul Lakkireddy's message
        of "Fri, 30 Mar 2018 16:21:57 +0530")
Message-ID: <87k1tt2yo7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f1yzP-0005Kk-QP;;;mid=<87k1tt2yo7.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18fJdImGsH74Ul+UtgYC354BgLiwhpflbQ=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 254 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.1%), b_tie_ro: 1.98 (0.8%), parse: 1.04 (0.4%),
        extract_message_metadata: 16 (6.3%), get_uri_detail_list: 2.1 (0.8%),
        tests_pri_-1000: 7 (2.6%), tests_pri_-950: 1.11 (0.4%), tests_pri_-900: 0.96
        (0.4%), tests_pri_-400: 23 (9.2%), check_bayes: 22 (8.7%), b_tokenize: 7
        (2.8%), b_tok_get_all: 7 (2.8%), b_comp_prob: 2.5 (1.0%), b_tok_touch_all:
        3.3 (1.3%), b_finish: 0.65 (0.3%), tests_pri_0: 193 (75.8%),
        check_dkim_signature: 0.46 (0.2%), check_dkim_adsp: 2.3 (0.9%),
        tests_pri_500: 7 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware dump in second kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Friday, March 03/30/18, 2018 at 16:09:07 +0530, Jiri Pirko wrote:
>> Sat, Mar 24, 2018 at 11:56:33AM CET, rahul.lakkireddy@chelsio.com wrote:
>> >Add a new module crashdd that exports the /sys/kernel/crashdd/
>> >directory in second kernel, containing collected hardware/firmware
>> >dumps.
>> >
>> >The sequence of actions done by device drivers to append their device
>> >specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
>> >as follows:
>> >
>> >1. During probe (before hardware is initialized), device drivers
>> >register to the crashdd module (via crashdd_add_dump()), with
>> >callback function, along with buffer size and log name needed for
>> >firmware/hardware log collection.
>> >
>> >2. Crashdd creates a driver's directory under
>> >/sys/kernel/crashdd/<driver>. Then, it allocates the buffer with
>> 
>> This smells. I need to identify the exact ASIC instance that produced
>> the dump. To identify by driver name does not help me if I have multiple
>> instances of the same driver. This looks wrong to me. This looks like
>> a job for devlink where you have 1 devlink instance per 1 ASIC instance.
>> 
>> Please see:
>> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
>> 
>> I bevieve that the solution in the patchset could be used for
>> your usecase too.
>> 
>> 
>
> The sysfs approach proposed here had been dropped in favour exporting
> the dumps as ELF notes in /proc/vmcore.
>
> Will be posting the new patches soon.

The concern was actually how you identify which device that came from.
Where you read the identifier changes but sysfs or /proc/vmcore the
change remains valid.

Eric
