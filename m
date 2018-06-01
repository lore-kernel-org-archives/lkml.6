Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeFAOwN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:52:13 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60598 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFAOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:52:10 -0400
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
References: <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com>
        <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz> <87wovu889o.fsf@xmission.com>
        <20180524111002.GB20441@dhcp22.suse.cz>
        <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
        <20180530121721.GD27180@dhcp22.suse.cz> <87wovjacrh.fsf@xmission.com>
        <87wovj8e1d.fsf_-_@xmission.com>
Date: Fri, 01 Jun 2018 09:52:04 -0500
In-Reply-To: <87wovj8e1d.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Thu, 31 May 2018 20:57:02 -0500")
Message-ID: <87y3fywodn.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOlPU-00008q-Kd;;;mid=<87y3fywodn.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+MHQ9/zaNPJmOpr4SYdm1ekOyHJekQFFg=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 224 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.0 (1.3%), b_tie_ro: 1.99 (0.9%), parse: 1.13 (0.5%),
        extract_message_metadata: 2.5 (1.1%), get_uri_detail_list: 0.48 (0.2%),
        tests_pri_-1000: 6 (2.5%), tests_pri_-950: 1.77 (0.8%), tests_pri_-900: 1.67
        (0.7%), tests_pri_-400: 21 (9.4%), check_bayes: 20 (8.8%), b_tokenize: 7
        (3.2%), b_tok_get_all: 6 (2.6%), b_comp_prob: 2.1 (0.9%), b_tok_touch_all:
        2.6 (1.1%), b_finish: 0.71 (0.3%), tests_pri_0: 172 (77.0%),
        check_dkim_signature: 0.54 (0.2%), check_dkim_adsp: 3.3 (1.5%),
        tests_pri_500: 4.8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH 0/2] memcg: Require every task that uses an mm to migrate together
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a follow up to my last patch of switching from mm->owner to
mm->memgcg and as it might be significant enough to break userspace.  I
am carefully not depending on this change.

Eric W. Biederman (2):
      memcg: Ensure every task that uses an mm is in the same memory cgroup
      memcgl: Remove dead code now that all tasks of an mm share a memcg

 mm/memcontrol.c | 94 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 35 deletions(-)
