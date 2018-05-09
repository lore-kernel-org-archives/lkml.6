Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935257AbeEIOv5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:51:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934517AbeEIOv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:51:56 -0400
Date: Wed, 9 May 2018 16:51:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [PATCH 2/2] memcg: Close the race between migration and
 installing bprm->mm as mm
Message-ID: <20180509145151.GB25742@redhat.com>
References: <20180503133338.GA23401@redhat.com>
 <87y3h0x0qg.fsf@xmission.com>
 <20180504142056.GA26151@redhat.com>
 <87r2mrh4is.fsf@xmission.com>
 <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
 <87tvrncoyc.fsf_-_@xmission.com>
 <87fu37cow4.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu37cow4.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04, Eric W. Biederman wrote:
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1044,6 +1044,8 @@ static int exec_mmap(struct mm_struct *mm)
>  		return 0;
>  	}
>  	mmdrop(active_mm);
> +	/* The tsk may have migrated before the new mm was attached */
> +	mm_sync_memcg_from_task(tsk);
>  	return 0;
>  }

call_usermodehelper(). perhaps it makes sense to change flush_old_exec()
to clear PF_KTHREAD/etc before exec_mmap().

Oleg.
