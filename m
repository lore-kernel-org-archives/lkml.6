Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D9CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A7A20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A7A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeIKV6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:58:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbeIKV6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:58:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C63240216EB;
        Tue, 11 Sep 2018 16:57:48 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E822ED144;
        Tue, 11 Sep 2018 16:57:48 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
References: <s5ha7ooxbps.wl-tiwai@suse.de>
        <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
        <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
        <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
        <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
        <8d5f3ab2-50e8-226c-8ccb-c722872910db@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date:   Tue, 11 Sep 2018 12:57:48 -0400
In-Reply-To: <8d5f3ab2-50e8-226c-8ccb-c722872910db@kernel.dk> (Jens Axboe's
        message of "Tue, 11 Sep 2018 10:54:19 -0600")
Message-ID: <x491sa0j7jn.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 11 Sep 2018 16:57:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 11 Sep 2018 16:57:48 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jmoyer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

>> And then there were 4...
>
> Exactly. I'd bump it to 5 to leave room for one more, if we have to grow it
> again, probably worth it to make it dynamic. So for, not really needed. Takashi,
> can verify that the below fixes it up for you?
>

You can slap a

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

on that when you commit it.

Cheers,
Jeff

>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index c19f9078da1e..c630e02836a8 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1510,8 +1510,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
>  	for (i = 0; i < BLKCG_MAX_POLS; i++)
>  		if (!blkcg_policy[i])
>  			break;
> -	if (i >= BLKCG_MAX_POLS)
> +	if (i >= BLKCG_MAX_POLS) {
> +		pr_warn("blkcg_policy_register: BLKCG_MAX_POLS too small\n");
>  		goto err_unlock;
> +	}
>  
>  	/* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs */
>  	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d6869e0e2b64..6980014357d4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -54,7 +54,7 @@ struct blk_stat_callback;
>   * Maximum number of blkcg policies allowed to be registered concurrently.
>   * Defined here to simplify include dependency.
>   */
> -#define BLKCG_MAX_POLS		3
> +#define BLKCG_MAX_POLS		5
>  
>  typedef void (rq_end_io_fn)(struct request *, blk_status_t);
