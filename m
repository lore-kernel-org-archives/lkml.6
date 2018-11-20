Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F95C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A01B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7BxuBmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A01B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeKUCza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:55:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41021 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeKUCza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:55:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so618677qto.8;
        Tue, 20 Nov 2018 08:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LvDXexURC7JDXtx8bhwlzEV40rN1puHR+/+gNK58vJE=;
        b=V7BxuBmDWakSa2+zGHLwmteCApPcPjLgSrRaw4oHnEWl0xgIuDq5bWKa+MLoHQfmZa
         Eqf0u4C1mpVU3D4SF6vUbM1tYDFaWrO1NjUAsTtKsIGKZcrWBH8/T6DgxzBj59MRd+D4
         jS6eV8YGQ6IxAqjDr4Ibsbp153cY7RNbToyMuGeJpZ3ZK7CWeNf7DwHT3M/CKkN8LsOB
         cMwM4gcLAb2wm4DDZwX6FW3Ai9ysAPJCq6UmoD0UFXVUHutQ0mLZCWhQfa8WTc48OfOI
         cGISfKkDHkHh5it1ERt+LuCblgYjpkPKFm81BKcYN89fkY7sHCE/6141J96eBfe+RBVC
         DfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LvDXexURC7JDXtx8bhwlzEV40rN1puHR+/+gNK58vJE=;
        b=lYRtfmPfJe2UcL6MykQBHGX1s/MLQjBgkPVZbwWoxItJMZw7jcuw2VsWSA5Z4BjYW3
         145eTVyS1Abo/2ul0p/0W2d+mB4nbywdLGpD+AnJC12UrLtuTBSw8R9GG9HATiLBb3RC
         xKkPvshPOVOao3KaTZ25t8J5NBVLW8agOTwAMTkOVQRlYz6WV5DzZVrn2W+pX+bX6GDF
         a8mur4cSE0Hj8C7Z/3BdLQZHn3y1zWEoZixNOBsbMs4l4zGbXVvuuB+IIClUtTvEALxk
         7M8Dyy99fGC0Q0k0tk58Afckh4f46+DRKuK6mn0lyTzLQGQpNqOy5G8PijifMQxihKWv
         TR2Q==
X-Gm-Message-State: AGRZ1gIVfar4E4S27HDAXXL5ETHm6VPutIYWGobaR7oujNX66glajJ6x
        iaUBqYNyz1SlrxxA6scnBq3ILUij
X-Google-Smtp-Source: AJdET5ewDHSWzUIhjG3n/dNAQwsATqsoHFBqb8mJcSZkAiUQHvwbK5ARhiJ8qSFYwVBLyHB4T+7PYQ==
X-Received: by 2002:ac8:7598:: with SMTP id s24mr2594022qtq.6.1542731131927;
        Tue, 20 Nov 2018 08:25:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id b8sm27944903qka.79.2018.11.20.08.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:25:31 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:25:29 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Message-ID: <20181120162529.GU2509588@devbig004.ftw2.facebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117003830.15344-5-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 04:38:27PM -0800, Roman Gushchin wrote:
> +void cgroup_freezer_migrate_task(struct task_struct *task,
> +				 struct cgroup *src, struct cgroup *dst)
> +{
> +	lockdep_assert_held(&css_set_lock);
> +
> +	/*
> +	 * Kernel threads are not supposed to be frozen at all.
> +	 */
> +	if (task->flags & PF_KTHREAD)
> +		return;
> +
> +	/*
> +	 * Adjust counters of freezing and frozen tasks.
> +	 */
> +	if (test_bit(CGRP_FREEZE, &src->flags)) {
> +		src->freezer.nr_tasks_to_freeze--;
> +		WARN_ON_ONCE(src->freezer.nr_tasks_to_freeze < 0);
> +	}
> +
> +	/*
> +	 * If the task is frozen, let's bump nr_tasks_to_freeze even
> +	 * if the target cgroup isn't frozen: the counter will be decreased
> +	 * in cgroup_leave_frozen().
> +	 */
> +	if (test_bit(CGRP_FREEZE, &dst->flags) || task->frozen)
> +		dst->freezer.nr_tasks_to_freeze++;
> +
> +	if (task->frozen) {
> +		src->freezer.nr_frozen_tasks--;
> +		dst->freezer.nr_frozen_tasks++;
> +		WARN_ON_ONCE(src->freezer.nr_frozen_tasks < 0);
> +		WARN_ON_ONCE(dst->freezer.nr_frozen_tasks >
> +			     dst->freezer.nr_tasks_to_freeze);
> +	}

If a non-frozen task is being moved into a frozen cgroup, shouldn't
that also trigger frozen state update?

Thanks.

-- 
tejun
