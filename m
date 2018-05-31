Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755897AbeEaRns (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:43:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51892 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755763AbeEaRnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:43:45 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
References: <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com>
        <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz> <87wovu889o.fsf@xmission.com>
        <20180530115246.GB20910@dhcp22.suse.cz>
Date: Thu, 31 May 2018 12:43:24 -0500
In-Reply-To: <20180530115246.GB20910@dhcp22.suse.cz> (Michal Hocko's message
        of "Wed, 30 May 2018 13:52:46 +0200")
Message-ID: <87vab3en5v.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fORbm-0006LA-SF;;;mid=<87vab3en5v.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7DnYmQKjVW7DvzBp6+3negZCqR5XNU3o=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 179 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (2.7%), b_tie_ro: 3.5 (1.9%), parse: 1.06 (0.6%),
        extract_message_metadata: 3.0 (1.7%), get_uri_detail_list: 0.83 (0.5%),
        tests_pri_-1000: 4.2 (2.3%), tests_pri_-950: 1.33 (0.7%), tests_pri_-900:
        1.15 (0.6%), tests_pri_-400: 20 (11.1%), check_bayes: 19 (10.5%), b_tokenize:
        4.6 (2.6%), b_tok_get_all: 7 (3.7%), b_comp_prob: 1.41 (0.8%),
        b_tok_touch_all: 3.4 (1.9%), b_finish: 0.81 (0.5%), tests_pri_0: 132 (73.7%),
        check_dkim_signature: 0.41 (0.2%), check_dkim_adsp: 3.2 (1.8%),
        tests_pri_500: 3.9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] mm->owner to mm->memcg fixes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Wed 23-05-18 14:46:43, Eric W. Biederman wrote:
> [...]
>> As two processes sharing an mm is useless and highly unlikely there is
>> no need to handle this case well, it just needs to be handled well
>> enough to prevent an indefinite loop.  So when css_tryget_online fails
>> just treat the mm as belong to the root memory cgroup.
>
> Does that mean that a malicious user can construct such a task and
> runaway from its limits?

Unfortunately if the memory cgroup is delegated than yes that can
happen.  So removing the loop in get_mem_cgroup_from_mm won't work.

Eric
