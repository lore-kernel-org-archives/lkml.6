Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD41C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E592081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E592081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbeKFIL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:11:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52180 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387965AbeKFIL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:11:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E242CA78;
        Mon,  5 Nov 2018 14:49:25 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9643F718;
        Mon,  5 Nov 2018 14:49:25 -0800 (PST)
Date:   Mon, 5 Nov 2018 22:49:21 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>, peterz@infradead.org
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
Message-ID: <20181105224654.GA25864@brain-police>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030060441.16107-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+PeterZ -- please include him on stuff like this]

Hi Gao,

On Tue, Oct 30, 2018 at 02:04:41PM +0800, Gao Xiang wrote:
> It is better to use wrapped smp_cond_load_relaxed
> instead of open-coded busy waiting for bit_spinlock.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> 
> change log v2:
>  - fix the incorrect expression !(VAL >> (bitnum & (BITS_PER_LONG-1)))
>  - the test result is described in the following reply.

Please include the results in the commit message, so that this change is
justified.

> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index bbc4730a6505..d5f922b5ffd9 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -15,22 +15,19 @@
>   */
>  static inline void bit_spin_lock(int bitnum, unsigned long *addr)
>  {
> -	/*
> -	 * Assuming the lock is uncontended, this never enters
> -	 * the body of the outer loop. If it is contended, then
> -	 * within the inner loop a non-atomic test is used to
> -	 * busywait with less bus contention for a good time to
> -	 * attempt to acquire the lock bit.
> -	 */
> -	preempt_disable();
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> -	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
> -		preempt_enable();
> -		do {
> -			cpu_relax();
> -		} while (test_bit(bitnum, addr));
> +	const unsigned int bitshift = bitnum & (BITS_PER_LONG - 1);
> +
> +	while (1) {
> +		smp_cond_load_relaxed(&addr[BIT_WORD(bitnum)],
> +				      !((VAL >> bitshift) & 1));
>  		preempt_disable();
> +		if (!test_and_set_bit_lock(bitnum, addr))
> +			break;
> +		preempt_enable();
>  	}
> +#else
> +	preempt_disable();

This appears to introduce a bunch of overhead for the uncontended fastpath.
How about the much-simpler-but-completely-untested (tm) patch below?

Will

--->8

diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 3ae021368f48..9de8d3544630 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -6,6 +6,15 @@
 #include <linux/compiler.h>
 #include <asm/barrier.h>
 
+static inline void spin_until_bit_unlock(unsigned int nr,
+					 volatile unsigned long *p)
+{
+	unsigned long mask = BIT_MASK(bitnum);
+
+	p += BIT_WORD(nr);
+	smp_cond_load_relaxed(p, VAL & mask);
+}
+
 /**
  * test_and_set_bit_lock - Set a bit and return its old value, for lock
  * @nr: Bit to set
diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..d711c62e718c 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -26,9 +26,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
 		preempt_enable();
-		do {
-			cpu_relax();
-		} while (test_bit(bitnum, addr));
+		spin_until_bit_unlock(bitnum, addr);
 		preempt_disable();
 	}
 #endif
