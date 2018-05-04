Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEDR0R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:26:17 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43448 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeEDR0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:26:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
References: <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org> <87lgd1zww0.fsf_-_@xmission.com>
        <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
Date: Fri, 04 May 2018 12:26:03 -0500
In-Reply-To: <871serfk77.fsf@xmission.com> (Eric W. Biederman's message of
        "Fri, 04 May 2018 11:40:28 -0500")
Message-ID: <87tvrncoyc.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEeTE-0002Pk-2b;;;mid=<87tvrncoyc.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19pKGmG2B239jrWH5+6nWRawl8ZL5TTUTw=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 183 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (1.3%), b_tie_ro: 1.72 (0.9%), parse: 0.71 (0.4%),
        extract_message_metadata: 1.78 (1.0%), get_uri_detail_list: 0.33 (0.2%),
        tests_pri_-1000: 3.2 (1.8%), tests_pri_-950: 1.11 (0.6%), tests_pri_-900:
        0.98 (0.5%), tests_pri_-400: 17 (9.5%), check_bayes: 16 (9.0%), b_tokenize: 5
        (3.0%), b_tok_get_all: 5 (2.9%), b_comp_prob: 1.53 (0.8%), b_tok_touch_all:
        2.5 (1.4%), b_finish: 0.53 (0.3%), tests_pri_0: 145 (79.0%),
        check_dkim_signature: 0.43 (0.2%), check_dkim_adsp: 3.3 (1.8%),
        tests_pri_500: 4.0 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/2] mm->owner to mm->memcg fixes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew can you pick up these two fixes as well.

These address the issues Michal Hocko and Oleg Nesterov noticed.

Eric W. Biederman (2):
      memcg: Update the mm->memcg maintenance to work when !CONFIG_MMU
      memcg: Close the race between migration and installing bprm->mm as mm

 fs/exec.c                  |   2 +
 include/linux/memcontrol.h |   5 ++
 mm/memcontrol.c            | 111 +++++++++++++++++++++------------------------
 3 files changed, 59 insertions(+), 59 deletions(-)
