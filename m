Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeFASMZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:12:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33967 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeFASMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:12:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz> <87wovu889o.fsf@xmission.com>
        <20180524111002.GB20441@dhcp22.suse.cz>
        <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
        <20180530121721.GD27180@dhcp22.suse.cz> <87wovjacrh.fsf@xmission.com>
        <87wovj8e1d.fsf_-_@xmission.com> <87y3fywodn.fsf_-_@xmission.com>
        <87sh66wobu.fsf_-_@xmission.com>
        <20180601165034.GX1351649@devbig577.frc2.facebook.com>
Date: Fri, 01 Jun 2018 13:11:59 -0500
In-Reply-To: <20180601165034.GX1351649@devbig577.frc2.facebook.com> (Tejun
        Heo's message of "Fri, 1 Jun 2018 09:50:34 -0700")
Message-ID: <87bmcuv0k0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOoWx-0007XS-Tm;;;mid=<87bmcuv0k0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+isxrjnQ14iMM4NFthjupE414r8mkQqTA=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Tejun Heo <tj@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.2 (0.0%), b_tie_ro: 1.52 (0.0%), parse: 0.76 (0.0%),
        extract_message_metadata: 2.3 (0.0%), get_uri_detail_list: 0.83 (0.0%),
        tests_pri_-1000: 3.4 (0.0%), tests_pri_-950: 1.34 (0.0%), tests_pri_-900:
        1.08 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 1.96 (0.0%), b_tok_touch_all:
        2.7 (0.0%), b_finish: 0.57 (0.0%), tests_pri_0: 193 (1.3%),
        check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 3.0 (0.0%),
        tests_pri_500: 14789 (98.5%), poll_dns_idle: 14777 (98.4%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in the same memory cgroup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

>> This effectively forbids process with mm's shared processes being migrated.
>> Although enabling the control file might work.
>
> So, I don't think we need to support putting tasks which share a mm in
> different cgroups.  That said, if we're gonna put in that restriction,
> I think it should be in cgroup core rather than memcg can_attach.  The
> only thing we'd need to do is widening what cgroup migration considers
> to be a process.

Widening the definition of a process sounds good.  The memory control
group code would still need a way to forbid these in cgroup v1 mode,
when someone uses the task file.

Using widening instead of denying should reduce the risk of introducing
a regression.

The only reason I support the crazy case in my earlier patch is so that
we can have this discussion and in case we do cause a regression with
this change the previous algorithmic cleanup won't have to be reverted
as well.

Eric
