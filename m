Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeFDTLh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:11:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41956 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeFDTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:11:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
        <20180530121721.GD27180@dhcp22.suse.cz> <87wovjacrh.fsf@xmission.com>
        <87wovj8e1d.fsf_-_@xmission.com> <87y3fywodn.fsf_-_@xmission.com>
        <87sh66wobu.fsf_-_@xmission.com>
        <20180601165034.GX1351649@devbig577.frc2.facebook.com>
        <87bmcuv0k0.fsf@xmission.com>
        <20180601191652.GZ1351649@devbig577.frc2.facebook.com>
        <20180604125934.GR19202@dhcp22.suse.cz>
        <20180604184738.GB1351649@devbig577.frc2.facebook.com>
Date: Mon, 04 Jun 2018 14:11:11 -0500
In-Reply-To: <20180604184738.GB1351649@devbig577.frc2.facebook.com> (Tejun
        Heo's message of "Mon, 4 Jun 2018 11:47:38 -0700")
Message-ID: <87d0x6jrjk.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fPusw-0000yA-Vj;;;mid=<87d0x6jrjk.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Dtt2oFikayIh5E07/Jp3/AJXTlccI/48=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Tejun Heo <tj@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15022 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 2.0 (0.0%), parse: 1.07 (0.0%),
        extract_message_metadata: 3.3 (0.0%), get_uri_detail_list: 1.22 (0.0%),
        tests_pri_-1000: 3.2 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        1.02 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 1.97 (0.0%), b_tok_touch_all:
        2.9 (0.0%), b_finish: 0.62 (0.0%), tests_pri_0: 173 (1.2%),
        check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 3.0 (0.0%),
        tests_pri_500: 14807 (98.6%), poll_dns_idle: 14799 (98.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in the same memory cgroup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> Hello, Michal.
>
> On Mon, Jun 04, 2018 at 03:01:19PM +0200, Michal Hocko wrote:
>> > On Fri, Jun 01, 2018 at 01:11:59PM -0500, Eric W. Biederman wrote:
>> > > Widening the definition of a process sounds good.  The memory control
>> > > group code would still need a way to forbid these in cgroup v1 mode,
>> > > when someone uses the task file.
>> > 
>> > Yeap, you're right.  We'll need memcg's can_attach rejecting for v1.
>> 
>> Do we really need? I mean, do we know about any existing usecase that
>> would need this weird threading concept and depend on memory migration
>> which doesn't really work?
>
> I thought the requirement is from the ->owner change so that the
> association doesn't become 1:N, right?

Yes.  We need not the existing can_attach, but my new
mem_cgroup_mm_can_attach.

Even if the cgroup notion of a process is extended to be any set of
tasks that shares an mm.  We still need to fail cgroup migration through
the tasks file for processes that are not single threaded for cgroup v1.

Eric
