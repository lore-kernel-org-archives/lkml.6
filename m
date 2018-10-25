Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D384DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8136A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Xl0/HPHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8136A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJYQhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:37:02 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:10166 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeJYQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:37:01 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 803FB446137;
        Thu, 25 Oct 2018 10:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540454721;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrDaViNM/ozBGUFoJuB3YqIafMFMW0Yq+z3k1wdK3rE=;
        b=Xl0/HPHy5eIkk9CwWWc76jeOOyjnK5TMleP1JKKaTzGVBgUetfiGAYNEAw3500Ha9I6g4l
        URo0AaF9qNf1znp9OQB/8qp3V0A3UJ7VvkZhtPA3yJ6ypSe83YkTjYAp8W4NujIryPJzD3
        cGnmz66XLV2P1jktv92ZC+4bCgZl8EE=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 803FB446137
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 10:05:21 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org,
        bfq-iosched@googlegroups.com, Federico Motta <federico@willer.it>
Subject: Re: [PATCH BUGFIX] block, bfq: fix asymmetric scenarios detection
In-Reply-To: <20181024171325.7154-1-paolo.valente@linaro.org>
References: <20181024171325.7154-1-paolo.valente@linaro.org>
Message-ID: <b747250df5e1d93175ac0a56e697d611@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540454721;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrDaViNM/ozBGUFoJuB3YqIafMFMW0Yq+z3k1wdK3rE=;
        b=nwzFssDix/eOMRiMcI9LjdHDVjxAqcLc99hC/F2fcMwZ0ZSxYXrfBSaeEbY0r7+J14Ghf2
        iKc7HRZ6+OwUmp+9z56gwXi7gR7dsLKFnz8bV8pr22PU2emfKLshEzXglDnCDfhg+vaBod
        kbMQ+pbbEGfjAJmm7hEJrSvS6wskZzs=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540454721; a=rsa-sha256;
        cv=none;
        b=wdRP27VBCCn8MTfsJwlL6YXwSV0WaSOJ+2zWGZnW79n0lKSVOIRoLVQ+dQhoiYxZSTvtvHj9qNSvE6ETKwl2e82iY2ZX8E+4BxecNcOxrClDUEBsPpzjvSt7vZgvRkuxrUxHUc1YP2M2gARHiBYYmAdhySsP2U8Y3TMM9iAMbcQ=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 24.10.2018 19:13, Paolo Valente wrote:
> From: Federico Motta <federico@willer.it>
> 
> Since commit 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
> detection"), a scenario is defined asymmetric when one of the
> following conditions holds:
> - active bfq_queues have different weights
> - one or more group of entities (bfq_queue or other groups of entities)
>   are active
> bfq grants fairness and low latency also in such asymmetric scenarios,
> by plugging the dispatching of I/O if the bfq_queue in service happens
> to be temporarily idle. This plugging may lower throughput, so it is
> important to do it only when strictly needed.
> 
> By mystake, in commit '2d29c9f89fcd' ("block, bfq: improve asymmetric
> scenarios detection") the num_active_groups counter was firstly
> incremented and subsequently decremented at any entity (group or
> bfq_queue) weight change.
> 
> This is useless, because only transitions from active to inactive and
> vice versa matter for that counter. Unfortunately this is also
> incorrect in the following case: the entity at issue is a bfq_queue
> and it is under weight raising. In fact in this case there is a
> spurious increment of the num_active_groups counter.
> 
> This spurious increment may cause scenarios to be wrongly detected as
> asymmetric, thus causing useless plugging and loss of throughput.
> 
> This commit fixes this issue by simply removing the above useless and
> wrong increments and decrements.
> 
> Fixes: 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios 
> detection")
> Signed-off-by: Federico Motta <federico@willer.it>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-wf2q.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 476b5a90a5a4..4b0d5fb69160 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -792,24 +792,18 @@ __bfq_entity_update_weight_prio(struct
> bfq_service_tree *old_st,
>  		 * queue, remove the entity from its old weight counter (if
>  		 * there is a counter associated with the entity).
>  		 */
> -		if (prev_weight != new_weight) {
> -			if (bfqq) {
> -				root = &bfqd->queue_weights_tree;
> -				__bfq_weights_tree_remove(bfqd, bfqq, root);
> -			} else
> -				bfqd->num_active_groups--;
> +		if (prev_weight != new_weight && bfqq) {
> +			root = &bfqd->queue_weights_tree;
> +			__bfq_weights_tree_remove(bfqd, bfqq, root);
>  		}
>  		entity->weight = new_weight;
>  		/*
>  		 * Add the entity, if it is not a weight-raised queue,
>  		 * to the counter associated with its new weight.
>  		 */
> -		if (prev_weight != new_weight) {
> -			if (bfqq && bfqq->wr_coeff == 1) {
> -				/* If we get here, root has been initialized. */
> -				bfq_weights_tree_add(bfqd, bfqq, root);
> -			} else
> -				bfqd->num_active_groups++;
> +		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1) {
> +			/* If we get here, root has been initialized. */
> +			bfq_weights_tree_add(bfqd, bfqq, root);
>  		}
> 
>  		new_st->wsum += entity->weight;

I'm running this patch on 3 machines ATM with no visible smoke. I don't 
do performance comparison here, just checking that nothing is obviously 
broken.

With regard to that,

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
