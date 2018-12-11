Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F255C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E898A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLKIE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:04:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbeLKIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:04:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBB84org089025
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 03:04:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pa4ta1yym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 03:04:56 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stli@linux.ibm.com>;
        Tue, 11 Dec 2018 08:04:54 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Dec 2018 08:04:51 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBB84ogi48693320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 08:04:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C41FDAE045;
        Tue, 11 Dec 2018 08:04:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F63FAE04D;
        Tue, 11 Dec 2018 08:04:50 +0000 (GMT)
Received: from oc4452167425.ibm.com (unknown [9.152.222.184])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Dec 2018 08:04:50 +0000 (GMT)
Subject: Re: [patch] futex: Cure exit race
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20181210152311.986181245@linutronix.de>
From:   Stefan Liebler <stli@linux.ibm.com>
Date:   Tue, 11 Dec 2018 09:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181210152311.986181245@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121108-0016-0000-0000-00000234D28E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121108-0017-0000-0000-0000328CFE8E
Message-Id: <06e7e269-6c87-f5f2-9a15-435b0a376105@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=982 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

does this also handle the ESRCH returned by
attach_to_pi_owner(...)
{...
	if (!pid)
		return -ESRCH;
	p = find_get_task_by_vpid(pid);
	if (!p)
		return -ESRCH;
...

I think pid should never be zero when attach_to_pi_owner is called.
But it can happen that p is null? At least I traced the "return -ESRCH" 
with the 4.17 kernel. Unfortunately both returns were done by the same 
instruction address.

Bye
Stefan

On 12/10/2018 04:23 PM, Thomas Gleixner wrote:
> Stefan reported, that the glibc tst-robustpi4 test case fails
> occasionally. That case creates the following race between
> sys_exit() and sys_futex(LOCK_PI):
> 
>   CPU0				CPU1
> 
>   sys_exit()			sys_futex()
>    do_exit()			 futex_lock_pi()
>     exit_signals(tsk)		  No waiters:
>      tsk->flags |= PF_EXITING;	  *uaddr == 0x00000PID
>    mm_release(tsk)		  Set waiter bit
>     exit_robust_list(tsk) {	  *uaddr = 0x80000PID;
>        Set owner died		  attach_to_pi_owner() {
>      *uaddr = 0xC0000000;	   tsk = get_task(PID);
>     }				   if (!tsk->flags & PF_EXITING) {
>    ...				     attach();
>    tsk->flags |= PF_EXITPIDONE;	   } else {
> 				     if (!(tsk->flags & PF_EXITPIDONE))
> 				       return -EAGAIN;
> 				     return -ESRCH; <--- FAIL
> 				   }
> 
> ESRCH is returned all the way to user space, which triggers the glibc test
> case assert. Returning ESRCH unconditionally is wrong here because the user
> space value has been changed by the exiting task to 0xC0000000, i.e. the
> FUTEX_OWNER_DIED bit is set and the futex PID value has been cleared. This
> is a valid state and the kernel has to handle it, i.e. taking the futex.
> 
> Cure it by rereading the user space value when PF_EXITING and PF_EXITPIDONE
> is set in the task which owns the futex. If the value has changed, let
> the kernel retry the operation, which includes all regular sanity checks
> and correctly handles the FUTEX_OWNER_DIED case.
> 
> If it hasn't changed, then return ESRCH as there is no way to distinguish
> this case from malfunctioning user space. This happens when the exiting
> task did not have a robust list, the robust list was corrupted or the user
> space value in the futex was simply bogus.
> 
> Reported-by: Stefan Liebler <stli@linux.ibm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200467
> ---
>   kernel/futex.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 53 insertions(+), 4 deletions(-)
> 
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1148,11 +1148,60 @@ static int attach_to_pi_state(u32 __user
>   	return ret;
>   }
>   
> +static int handle_exit_race(u32 __user *uaddr, u32 uval, struct task_struct *tsk)
> +{
> +	u32 uval2;
> +
> +	/*
> +	 * If PF_EXITPIDONE is not yet set try again.
> +	 */
> +	if (!(tsk->flags & PF_EXITPIDONE))
> +		return -EAGAIN;
> +
> +	/*
> +	 * Reread the user space value to handle the following situation:
> +	 *
> +	 * CPU0				CPU1
> +	 *
> +	 * sys_exit()			sys_futex()
> +	 *  do_exit()			 futex_lock_pi()
> +	 *   exit_signals(tsk)		  No waiters:
> +	 *    tsk->flags |= PF_EXITING;	  *uaddr == 0x00000PID
> +	 *  mm_release(tsk)		  Set waiter bit
> +	 *   exit_robust_list(tsk) {	  *uaddr = 0x80000PID;
> +	 *      Set owner died		  attach_to_pi_owner() {
> +	 *    *uaddr = 0xC0000000;	   tsk = get_task(PID);
> +	 *   }				   if (!tsk->flags & PF_EXITING) {
> +	 *  ...				     attach();
> +	 *  tsk->flags |= PF_EXITPIDONE;   } else {
> +	 *				     if (!(tsk->flags & PF_EXITPIDONE))
> +	 *				       return -EAGAIN;
> +	 *				     return -ESRCH; <--- FAIL
> +	 *				   }
> +	 *
> +	 * Returning ESRCH unconditionally is wrong here because the
> +	 * user space value has been changed by the exiting task.
> +	 */
> +	if (get_futex_value_locked(&uval2, uaddr))
> +		return -EFAULT;
> +
> +	/* If the user space value has changed, try again. */
> +	if (uval2 != uval)
> +		return -EAGAIN;
> +
> +	/*
> +	 * The exiting task did not have a robust list, the robust list was
> +	 * corrupted or the user space value in *uaddr is simply bogus.
> +	 * Give up and tell user space.
> +	 */
> +	return -ESRCH;
> +}
> +
>   /*
>    * Lookup the task for the TID provided from user space and attach to
>    * it after doing proper sanity checks.
>    */
> -static int attach_to_pi_owner(u32 uval, union futex_key *key,
> +static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
>   			      struct futex_pi_state **ps)
>   {
>   	pid_t pid = uval & FUTEX_TID_MASK;
> @@ -1187,7 +1236,7 @@ static int attach_to_pi_owner(u32 uval,
>   		 * set, we know that the task has finished the
>   		 * cleanup:
>   		 */
> -		int ret = (p->flags & PF_EXITPIDONE) ? -ESRCH : -EAGAIN;
> +		int ret = handle_exit_race(uaddr, uval, p);
>   
>   		raw_spin_unlock_irq(&p->pi_lock);
>   		put_task_struct(p);
> @@ -1244,7 +1293,7 @@ static int lookup_pi_state(u32 __user *u
>   	 * We are the first waiter - try to look up the owner based on
>   	 * @uval and attach to it.
>   	 */
> -	return attach_to_pi_owner(uval, key, ps);
> +	return attach_to_pi_owner(uaddr, uval, key, ps);
>   }
>   
>   static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
> @@ -1352,7 +1401,7 @@ static int futex_lock_pi_atomic(u32 __us
>   	 * attach to the owner. If that fails, no harm done, we only
>   	 * set the FUTEX_WAITERS bit in the user space variable.
>   	 */
> -	return attach_to_pi_owner(uval, key, ps);
> +	return attach_to_pi_owner(uaddr, uval, key, ps);
>   }
>   
>   /**
> 
> 

