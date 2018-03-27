Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeC0NSs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:18:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45061 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeC0NSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:18:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
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
        <87muyxlctn.fsf@xmission.com> <20180326134539.GA15852@chelsio.com>
Date: Tue, 27 Mar 2018 08:17:34 -0500
In-Reply-To: <20180326134539.GA15852@chelsio.com> (Rahul Lakkireddy's message
        of "Mon, 26 Mar 2018 19:15:40 +0530")
Message-ID: <87k1txfyj5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f0oUl-0001Zw-Sp;;;mid=<87k1txfyj5.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19T/8wZIFf/cdqYM8uKr/peKZSNLfEUvvY=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4930]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 966 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 6 (0.6%), b_tie_ro: 4.4 (0.5%), parse: 2.3 (0.2%),
        extract_message_metadata: 34 (3.5%), get_uri_detail_list: 2.9 (0.3%),
        tests_pri_-1000: 17 (1.7%), tests_pri_-950: 3.9 (0.4%), tests_pri_-900: 2.8
        (0.3%), tests_pri_-400: 44 (4.5%), check_bayes: 41 (4.2%), b_tokenize: 19
        (1.9%), b_tok_get_all: 10 (1.0%), b_comp_prob: 5 (0.5%), b_tok_touch_all: 2.6
        (0.3%), b_finish: 1.20 (0.1%), tests_pri_0: 827 (85.6%),
        check_dkim_signature: 1.48 (0.2%), check_dkim_adsp: 9 (0.9%), tests_pri_500:
        17 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next v2 0/2] kernel: add support to collect hardware logs in crash recovery kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Saturday, March 03/24/18, 2018 at 20:50:52 +0530, Eric W. Biederman wrote:
>> 
>> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
>> 
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
>> > recovery kernel, the collected logs are exposed via /sys/kernel/crashdd/
>> > directory, which is copied by user space scripts for post-analysis.
>> >
>> > A kernel module crashdd is newly added. In crash recovery kernel,
>> > crashdd exposes /sys/kernel/crashdd/ directory containing device
>> > specific hardware/firmware logs.
>> 
>> Have you looked at instead of adding a sysfs file adding the dumps
>> as additional elf notes in /proc/vmcore?
>> 
>
> I see the crash recovery kernel's memory is not present in any of the
> the PT_LOAD headers.  So, makedumpfile is not collecting the dumps
> that are in crash recovery kernel's memory.
>
> Also, are you suggesting exporting the dumps themselves as PT_NOTE
> instead?  I'll look into doing it this way.

Yes.  I was suggesting exporting the dumps themselves as PT_NOTE
in /proc/vmcore.  I think that will allow makedumpfile to collect
your new information without modification.

Eric
