Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeDQVxj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:53:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41102 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbeDQVxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:53:37 -0400
X-Google-Smtp-Source: AIpwx4/FCmqSNwWMdJvUUQNhDu9CMHAMnKGip9q+utIoy+fhqnknKzK1Rcb4AAAOUzORQUrOUL7WrQ==
Date: Tue, 17 Apr 2018 14:53:34 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: ohad@wizery.com, arnd@arndb.de, broonie@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwspinlock: Introduce one new mode for hwspinlock
Message-ID: <20180417215334.GF17344@builder>
References: <d7fe0ed3d2dccf51e04a5c9032a73d1fd62dd1c1.1523156656.git.baolin.wang@linaro.org>
 <f18e7e37046873a393ca43ee91986b9e192e977c.1523156656.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18e7e37046873a393ca43ee91986b9e192e977c.1523156656.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 07 Apr 20:06 PDT 2018, Baolin Wang wrote:

> In some scenarios, user need do some time-consuming or sleepable
> operations under the hardware spinlock protection for synchronization
> between the multiple subsystems.
> 
> For example, there is one PMIC efuse on Spreadtrum platform, which
> need to be accessed under one hardware lock. But during the hardware
> lock protection, the efuse operation is time-consuming to almost 5 ms,
> so we can not disable the interrupts or preemption so long in this case.
> 
> Thus we can introduce one new mode to indicate that we just acquire the
> hardware lock and do not disable interrupts or preemption, meanwhile we
> should force user to protect the hardware lock with mutex or spinlock to
> avoid dead-lock.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Looks good, both patches applied.

Thanks,
Bjorn

> ---
>  drivers/hwspinlock/hwspinlock_core.c |   34 ++++++++++++++++----
>  include/linux/hwspinlock.h           |   58 ++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> index f4a59f5..5278d05 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -71,10 +71,16 @@
>   * This function attempts to lock an hwspinlock, and will immediately
>   * fail if the hwspinlock is already taken.
>   *
> - * Upon a successful return from this function, preemption (and possibly
> - * interrupts) is disabled, so the caller must not sleep, and is advised to
> - * release the hwspinlock as soon as possible. This is required in order to
> - * minimize remote cores polling on the hardware interconnect.
> + * Caution: If the mode is HWLOCK_RAW, that means user must protect the routine
> + * of getting hardware lock with mutex or spinlock. Since in some scenarios,
> + * user need some time-consuming or sleepable operations under the hardware
> + * lock, they need one sleepable lock (like mutex) to protect the operations.
> + *
> + * If the mode is not HWLOCK_RAW, upon a successful return from this function,
> + * preemption (and possibly interrupts) is disabled, so the caller must not
> + * sleep, and is advised to release the hwspinlock as soon as possible. This is
> + * required in order to minimize remote cores polling on the hardware
> + * interconnect.
>   *
>   * The user decides whether local interrupts are disabled or not, and if yes,
>   * whether he wants their previous state to be saved. It is up to the user
> @@ -113,6 +119,9 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
>  	case HWLOCK_IRQ:
>  		ret = spin_trylock_irq(&hwlock->lock);
>  		break;
> +	case HWLOCK_RAW:
> +		ret = 1;
> +		break;
>  	default:
>  		ret = spin_trylock(&hwlock->lock);
>  		break;
> @@ -134,6 +143,9 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
>  		case HWLOCK_IRQ:
>  			spin_unlock_irq(&hwlock->lock);
>  			break;
> +		case HWLOCK_RAW:
> +			/* Nothing to do */
> +			break;
>  		default:
>  			spin_unlock(&hwlock->lock);
>  			break;
> @@ -170,9 +182,14 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
>   * is already taken, the function will busy loop waiting for it to
>   * be released, but give up after @timeout msecs have elapsed.
>   *
> - * Upon a successful return from this function, preemption is disabled
> - * (and possibly local interrupts, too), so the caller must not sleep,
> - * and is advised to release the hwspinlock as soon as possible.
> + * Caution: If the mode is HWLOCK_RAW, that means user must protect the routine
> + * of getting hardware lock with mutex or spinlock. Since in some scenarios,
> + * user need some time-consuming or sleepable operations under the hardware
> + * lock, they need one sleepable lock (like mutex) to protect the operations.
> + *
> + * If the mode is not HWLOCK_RAW, upon a successful return from this function,
> + * preemption is disabled (and possibly local interrupts, too), so the caller
> + * must not sleep, and is advised to release the hwspinlock as soon as possible.
>   * This is required in order to minimize remote cores polling on the
>   * hardware interconnect.
>   *
> @@ -266,6 +283,9 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
>  	case HWLOCK_IRQ:
>  		spin_unlock_irq(&hwlock->lock);
>  		break;
> +	case HWLOCK_RAW:
> +		/* Nothing to do */
> +		break;
>  	default:
>  		spin_unlock(&hwlock->lock);
>  		break;
> diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
> index 859d673..fe450ee 100644
> --- a/include/linux/hwspinlock.h
> +++ b/include/linux/hwspinlock.h
> @@ -24,6 +24,7 @@
>  /* hwspinlock mode argument */
>  #define HWLOCK_IRQSTATE	0x01	/* Disable interrupts, save state */
>  #define HWLOCK_IRQ	0x02	/* Disable interrupts, don't save state */
> +#define HWLOCK_RAW	0x03
>  
>  struct device;
>  struct device_node;
> @@ -176,6 +177,25 @@ static inline int hwspin_trylock_irq(struct hwspinlock *hwlock)
>  }
>  
>  /**
> + * hwspin_trylock_raw() - attempt to lock a specific hwspinlock
> + * @hwlock: an hwspinlock which we want to trylock
> + *
> + * This function attempts to lock an hwspinlock, and will immediately fail
> + * if the hwspinlock is already taken.
> + *
> + * Caution: User must protect the routine of getting hardware lock with mutex
> + * or spinlock to avoid dead-lock, that will let user can do some time-consuming
> + * or sleepable operations under the hardware lock.
> + *
> + * Returns 0 if we successfully locked the hwspinlock, -EBUSY if
> + * the hwspinlock was already taken, and -EINVAL if @hwlock is invalid.
> + */
> +static inline int hwspin_trylock_raw(struct hwspinlock *hwlock)
> +{
> +	return __hwspin_trylock(hwlock, HWLOCK_RAW, NULL);
> +}
> +
> +/**
>   * hwspin_trylock() - attempt to lock a specific hwspinlock
>   * @hwlock: an hwspinlock which we want to trylock
>   *
> @@ -243,6 +263,29 @@ int hwspin_lock_timeout_irq(struct hwspinlock *hwlock, unsigned int to)
>  }
>  
>  /**
> + * hwspin_lock_timeout_raw() - lock an hwspinlock with timeout limit
> + * @hwlock: the hwspinlock to be locked
> + * @to: timeout value in msecs
> + *
> + * This function locks the underlying @hwlock. If the @hwlock
> + * is already taken, the function will busy loop waiting for it to
> + * be released, but give up when @timeout msecs have elapsed.
> + *
> + * Caution: User must protect the routine of getting hardware lock with mutex
> + * or spinlock to avoid dead-lock, that will let user can do some time-consuming
> + * or sleepable operations under the hardware lock.
> + *
> + * Returns 0 when the @hwlock was successfully taken, and an appropriate
> + * error code otherwise (most notably an -ETIMEDOUT if the @hwlock is still
> + * busy after @timeout msecs). The function will never sleep.
> + */
> +static inline
> +int hwspin_lock_timeout_raw(struct hwspinlock *hwlock, unsigned int to)
> +{
> +	return __hwspin_lock_timeout(hwlock, to, HWLOCK_RAW, NULL);
> +}
> +
> +/**
>   * hwspin_lock_timeout() - lock an hwspinlock with timeout limit
>   * @hwlock: the hwspinlock to be locked
>   * @to: timeout value in msecs
> @@ -302,6 +345,21 @@ static inline void hwspin_unlock_irq(struct hwspinlock *hwlock)
>  }
>  
>  /**
> + * hwspin_unlock_raw() - unlock hwspinlock
> + * @hwlock: a previously-acquired hwspinlock which we want to unlock
> + *
> + * This function will unlock a specific hwspinlock.
> + *
> + * @hwlock must be already locked (e.g. by hwspin_trylock()) before calling
> + * this function: it is a bug to call unlock on a @hwlock that is already
> + * unlocked.
> + */
> +static inline void hwspin_unlock_raw(struct hwspinlock *hwlock)
> +{
> +	__hwspin_unlock(hwlock, HWLOCK_RAW, NULL);
> +}
> +
> +/**
>   * hwspin_unlock() - unlock hwspinlock
>   * @hwlock: a previously-acquired hwspinlock which we want to unlock
>   *
> -- 
> 1.7.9.5
> 
