Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeC0N74 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:59:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752775AbeC0N7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:59:54 -0400
Subject: Re: [PATCH v2] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <1522091848-18426-1-git-send-email-longman@redhat.com>
 <20180327060655.25zjgqlgbfsp6b3p@gmail.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <72b8a73c-bfc0-5884-199d-349ee3311802@redhat.com>
Date: Tue, 27 Mar 2018 09:59:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180327060655.25zjgqlgbfsp6b3p@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 02:06 AM, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
>> For a rwsem, locking can either be exclusive or shared. The corresponding
>> exclusive or shared unlock must be used. Otherwise, the protected data
>> structures may get corrupted or the lock may be in an inconsistent state.
>>
>> In order to detect such anomaly, a new configuration option DEBUG_RWSEMS
>> is added which can be enabled to look for such mismatches and print
>> warnings that that happens.
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 64155e3..0958192 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1075,6 +1075,13 @@ config DEBUG_WW_MUTEX_SLOWPATH
>>  	 even a debug kernel.  If you are a driver writer, enable it.  If
>>  	 you are a distro, do not.
>>  
>> +config DEBUG_RWSEMS
>> +	bool "RW Semaphore debugging: basic checks"
>> +	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
>> +	help
>> +	  This feature allows mismatched rw semaphore locks and unlocks
>> +	  to be detected and reported.
>> +
> Makes sense - but this should also be integrated into the rest of lock debugging 
> Kconfig hierarchy similar to DEBUG_MUTEXES: i.e. DEBUG_LOCK_ALLOC, PROVE_LOCKING, 
> etc. should select this new lock debugging option as well.
>
> People generally are not supposed to know and configure the finer details, 
> CONFIG_LOCK_DEBUGGING=y is a one-stop-shop in this regard.

I can add a patch to rework lock debugging configuration code. Do you
want to hide the individual config options but still allow them to be
enabled manually? Alternatively we can also just add a master lock
debugging option to select them all.

Cheers,
Longman
