Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8888BC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE2920661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE2920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeFSXJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbeFSXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 211A13082A4F;
        Tue, 19 Jun 2018 23:09:58 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-34.phx2.redhat.com [10.3.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E50575C89A;
        Tue, 19 Jun 2018 23:09:55 +0000 (UTC)
Subject: Re: [PATCH] locking/rwsem: Fix up_read_non_owner() warning with
 DEBUG_RWSEMS
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-nfs@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1527168398-4291-1-git-send-email-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ba5a8266-b475-0f80-50eb-1ed39ffa6d2a@redhat.com>
Date:   Wed, 20 Jun 2018 07:09:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1527168398-4291-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 19 Jun 2018 23:09:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 09:26 PM, Waiman Long wrote:
> It was found that the use of up_read_non_owner() in NFS was causing
> the following warning when DEBUG_RWSEMS was configured.
>
>   DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)(1UL << 0)))
>
> Looking into the rwsem.c file, it was discovered that the corresponding
> down_read_non_owner() function was not setting the owner field properly.
> This is fixed now, and the warning should be gone.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index bc1e507..776308d 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -181,6 +181,7 @@ void down_read_non_owner(struct rw_semaphore *sem)
>  	might_sleep();
>  tch
>  	__down_read(sem);
> +	rwsem_set_reader_owned(sem);
>  }
>  
>  EXPORT_SYMBOL(down_read_non_owner);

Since the 4.18 merge window has been closed. Can that patch be merged
upstream?

Cheers,
Longman

