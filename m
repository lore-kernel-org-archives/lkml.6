Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941E8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B41624458
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B41624458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeGDOnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:43:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752145AbeGDOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:43:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64EdW8d092699
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 10:43:46 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0ywqrt56-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:43:45 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 10:43:44 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 10:43:40 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64EhddE3670490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 14:43:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 229CDB205F;
        Wed,  4 Jul 2018 10:43:22 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EABDBB2065;
        Wed,  4 Jul 2018 10:43:21 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 10:43:21 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2BA5416CA3B8; Wed,  4 Jul 2018 07:45:54 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:45:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC] ipc: refcounting / use after free?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180704115305.2583-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704115305.2583-1-manfred@colorfullife.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070414-0064-0000-0000-000003250F72
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009308; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056460; UDB=6.00541943; IPR=6.00834382;
 MB=3.00021995; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-04 14:43:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070414-0065-0000-0000-000039D17B57
Message-Id: <20180704144554.GK3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:53:05PM +0200, Manfred Spraul wrote:
> The ipc code uses the equivalent of
> 
> 	rcu_read_lock();
> 	kfree_rcu(a, rcu);
> 	if (a->deleted) {
> 		rcu_read_unlock();
> 		return FAILURE;
> 	}
> 	<...>
> 
> Is this safe, or is dereferencing "a" after having called call_rcu()
> a use-after-free?

This is safe because it is being done before the rcu_read_unlock().

> According to rcupdate.h, the kfree is only deferred until the
> other CPUs exit their critical sections:
> 
> include/linux/rcupdate.h:
> > * Similarly, if call_rcu() is invoked
> > * on one CPU while other CPUs are within RCU read-side critical
> > * sections, invocation of the corresponding RCU callback is deferred
> > * until after the all the other CPUs exit their critical sections.

This is true, but so are the words that appear earlier in that comment:

 * The callback function will be invoked some time after a full grace
 * period elapses, in other words after all pre-existing RCU read-side
 * critical sections have completed.

In the above case, the kfree_rcu() is executed within a pre-existing
RCU read-side critical section, so the memory cannot be freed until
the rcu_read_lock() is reached.

							Thanx, Paul

> <The patch is for review, not fully tested>
> ---
>  ipc/msg.c  | 11 ++++++++---
>  ipc/sem.c  | 42 ++++++++++++++++++++++++++++++------------
>  ipc/util.c | 35 ++++++++++++++++++++++++++++++++---
>  ipc/util.h | 18 ++++++++++++++++--
>  4 files changed, 86 insertions(+), 20 deletions(-)
> 
> diff --git a/ipc/msg.c b/ipc/msg.c
> index 3b6545302598..724000c15296 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -805,7 +805,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>  	msq = msq_obtain_object_check(ns, msqid);
>  	if (IS_ERR(msq)) {
>  		err = PTR_ERR(msq);
> -		goto out_unlock1;
> +		goto out_unlock2;
>  	}
> 
>  	ipc_lock_object(&msq->q_perm);
> @@ -851,8 +851,12 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>  		rcu_read_lock();
>  		ipc_lock_object(&msq->q_perm);
> 
> -		ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
>  		/* raced with RMID? */
> +		if (!__ipc_rcu_putref(&msq->q_perm)) {
> +			ipc_unlock_object(&msq->q_perm);
> +			call_rcu(&msq->q_perm.rcu, msg_rcu_free);
> +			goto out_unlock1;
> +		}
>  		if (!ipc_valid_object(&msq->q_perm)) {
>  			err = -EIDRM;
>  			goto out_unlock0;
> @@ -883,8 +887,9 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
> 
>  out_unlock0:
>  	ipc_unlock_object(&msq->q_perm);
> -	wake_up_q(&wake_q);
>  out_unlock1:
> +	wake_up_q(&wake_q);
> +out_unlock2:
>  	rcu_read_unlock();
>  	if (msg != NULL)
>  		free_msg(msg);
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 5af1943ad782..c269fae05b24 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -475,10 +475,16 @@ static inline struct sem_array *sem_obtain_object_check(struct ipc_namespace *ns
>  	return container_of(ipcp, struct sem_array, sem_perm);
>  }
> 
> -static inline void sem_lock_and_putref(struct sem_array *sma)
> +static int __must_check sem_lock_and_putref(struct sem_array *sma)
>  {
>  	sem_lock(sma, NULL, -1);
> -	ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
> +
> +	if (!__ipc_rcu_putref(&sma->sem_perm)) {
> +		sem_unlock(sma, -1);
> +		call_rcu(&sma->sem_perm.rcu, sem_rcu_free);
> +		return 0;
> +	}
> +	return 1;
>  }
> 
>  static inline void sem_rmid(struct ipc_namespace *ns, struct sem_array *s)
> @@ -1434,7 +1440,10 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
>  			}
> 
>  			rcu_read_lock();
> -			sem_lock_and_putref(sma);
> +			if (!sem_lock_and_putref(sma)) {
> +				goto out_rcu_wakeup;
> +			}
> +
>  			if (!ipc_valid_object(&sma->sem_perm)) {
>  				err = -EIDRM;
>  				goto out_unlock;
> @@ -1483,7 +1492,11 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
>  			}
>  		}
>  		rcu_read_lock();
> -		sem_lock_and_putref(sma);
> +		if (!sem_lock_and_putref(sma)) {
> +			err = -EIDRM;
> +			goto out_rcu_wakeup;
> +		}
> +
>  		if (!ipc_valid_object(&sma->sem_perm)) {
>  			err = -EIDRM;
>  			goto out_unlock;
> @@ -1898,14 +1911,12 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
> 
>  	/* step 3: Acquire the lock on semaphore array */
>  	rcu_read_lock();
> -	sem_lock_and_putref(sma);
> -	if (!ipc_valid_object(&sma->sem_perm)) {
> -		sem_unlock(sma, -1);
> -		rcu_read_unlock();
> -		kfree(new);
> -		un = ERR_PTR(-EIDRM);
> -		goto out;
> -	}
> +	if (!sem_lock_and_putref(sma))
> +		goto out_EIDRM_free;
> +
> +	if (!ipc_valid_object(&sma->sem_perm))
> +		goto out_EIDRM_unlock;
> +
>  	spin_lock(&ulp->lock);
> 
>  	/*
> @@ -1931,6 +1942,13 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
>  	sem_unlock(sma, -1);
>  out:
>  	return un;
> +
> +out_EIDRM_unlock:
> +	sem_unlock(sma, -1);
> +out_EIDRM_free:
> +	rcu_read_unlock();
> +	kfree(new);
> +	return ERR_PTR(-EIDRM);
>  }
> 
>  static long do_semtimedop(int semid, struct sembuf __user *tsops,
> diff --git a/ipc/util.c b/ipc/util.c
> index 4e81182fa0ac..ba7f96fc8a61 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -462,18 +462,47 @@ void ipc_set_key_private(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
>  	ipcp->key = IPC_PRIVATE;
>  }
> 
> -int ipc_rcu_getref(struct kern_ipc_perm *ptr)
> +int __must_check ipc_rcu_getref(struct kern_ipc_perm *ptr)
>  {
>  	return refcount_inc_not_zero(&ptr->refcount);
>  }
> 
> -void ipc_rcu_putref(struct kern_ipc_perm *ptr,
> +/**
> + * __ipc_rcu_putref - reduce reference count of an ipc object.
> + * @ptr: ipc object
> + *
> + * The function reduces the reference count of an ipc object by 1.
> + * If the reference count drops to 0, then the function returns 0.
> + * If this happens, then the caller is responsible for triggering
> + * call_rcu() to free the ipc object.
> + */
> +int __must_check __ipc_rcu_putref(struct kern_ipc_perm *ptr)
> +{
> +	if (!refcount_dec_and_test(&ptr->refcount))
> +		return 1;
> +	return 0;
> +}
> +
> +/**
> + * ipc_rcu_putref - reduce reference count of an ipc object.
> + * @ptr: ipc object
> + * @func: cleanup function to call when the reference is reduced to 0.
> + *
> + * The function reduces the reference count of an ipc object by 1.
> + * If the count drops to 0, then a call_rcu is triggered to free the ipc
> + * object.
> + *
> + * If the reference count drops to 0, then the function returns 0.
> + * If this happens, then the caller must not dereference ptr.
> + */
> +int ipc_rcu_putref(struct kern_ipc_perm *ptr,
>  			void (*func)(struct rcu_head *head))
>  {
>  	if (!refcount_dec_and_test(&ptr->refcount))
> -		return;
> +		return 1;
> 
>  	call_rcu(&ptr->rcu, func);
> +	return 0;
>  }
> 
>  /**
> diff --git a/ipc/util.h b/ipc/util.h
> index 0aba3230d007..fbd55aeee933 100644
> --- a/ipc/util.h
> +++ b/ipc/util.h
> @@ -134,12 +134,26 @@ static inline int ipc_get_maxid(struct ipc_ids *ids)
>   * Objects are reference counted, they start with reference count 1.
>   * getref increases the refcount, the putref call that reduces the recount
>   * to 0 schedules the rcu destruction. Caller must guarantee locking.
> + * As the reference count is reduced without holding any lock, this means
> + * that the caller must use ipc_valid_object() after acquiring ipc_lock_xx().
>   *
>   * refcount is initialized by ipc_addid(), before that point call_rcu()
>   * must be used.
> + *
> + * Most callers must check the return codes:
> + * - ipc_rcu_getref() fails if the reference count is already 0.
> + * - ipc_rcu_putref() calls call_rcu() if the reference count drops to 0,
> + *	dereferencing the ipc object if the function returns 0 is a
> + *	use-after-free.
> + * - with __ipc_rcu_putref(), the caller is responible for call_rcu().
> + *	This function is intended to be used if dereferencing must be done,
> + *	e.g. to drop a lock.
> + * ipc_rcu_putref does not use __must_check, because error paths or the
> + * IPC_RMID codepaths can safely ignore the return code.
>   */
> -int ipc_rcu_getref(struct kern_ipc_perm *ptr);
> -void ipc_rcu_putref(struct kern_ipc_perm *ptr,
> +int __must_check ipc_rcu_getref(struct kern_ipc_perm *ptr);
> +int __must_check __ipc_rcu_putref(struct kern_ipc_perm *ptr);
> +int ipc_rcu_putref(struct kern_ipc_perm *ptr,
>  			void (*func)(struct rcu_head *head));
> 
>  struct kern_ipc_perm *ipc_lock(struct ipc_ids *, int);
> -- 
> 2.14.4
> 

