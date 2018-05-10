Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756560AbeEJDAL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 23:00:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58415 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756235AbeEJDAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 23:00:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com> <87fu37cow4.fsf_-_@xmission.com>
        <20180509145151.GB25742@redhat.com>
Date: Wed, 09 May 2018 22:00:00 -0500
In-Reply-To: <20180509145151.GB25742@redhat.com> (Oleg Nesterov's message of
        "Wed, 9 May 2018 16:51:52 +0200")
Message-ID: <878t8sqkpb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGboM-00089g-Ho;;;mid=<878t8sqkpb.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18LJvHciffRFrZccgbcwBJ29J0pYGgD31w=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 231 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (1.0%), b_tie_ro: 1.66 (0.7%), parse: 0.81 (0.3%),
        extract_message_metadata: 2.4 (1.1%), get_uri_detail_list: 0.91 (0.4%),
        tests_pri_-1000: 3.4 (1.5%), tests_pri_-950: 1.15 (0.5%), tests_pri_-900:
        0.99 (0.4%), tests_pri_-400: 22 (9.5%), check_bayes: 21 (9.0%), b_tokenize: 7
        (3.0%), b_tok_get_all: 7 (3.1%), b_comp_prob: 1.96 (0.9%), b_tok_touch_all:
        2.8 (1.2%), b_finish: 0.64 (0.3%), tests_pri_0: 185 (80.0%),
        check_dkim_signature: 0.46 (0.2%), check_dkim_adsp: 2.9 (1.3%),
        tests_pri_500: 6 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] memcg: Close the race between migration and installing bprm->mm as mm
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/04, Eric W. Biederman wrote:
>>
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1044,6 +1044,8 @@ static int exec_mmap(struct mm_struct *mm)
>>  		return 0;
>>  	}
>>  	mmdrop(active_mm);
>> +	/* The tsk may have migrated before the new mm was attached */
>> +	mm_sync_memcg_from_task(tsk);
>>  	return 0;
>>  }
>
> call_usermodehelper(). perhaps it makes sense to change flush_old_exec()
> to clear PF_KTHREAD/etc before exec_mmap().

Yes.  That does look like something to be fixed.  In practice while it
is rare for anything to be migrated during exec I expect it to be even
rarer for kernel threads.  But that is a legitimate issue.

I expect all of these lines after exec_mmap actually belong
in exec_mmap.  Which would then make rearraning the lines easy to ensure
mm_sync_memcg_from_task sees PF_KTHREAD cleared.
	/*
	 * After clearing bprm->mm (to mark that current is using the
	 * prepared mm now), we have nothing left of the original
	 * process. If anything from here on returns an error, the check
	 * in search_binary_handler() will SEGV current.
	 */
	bprm->mm = NULL;

	set_fs(USER_DS);
	current->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
					PF_NOFREEZE | PF_NO_SETAFFINITY);
	flush_thread();
	current->personality &= ~bprm->per_clear;

Eric
