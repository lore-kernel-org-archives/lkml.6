Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB90C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D506E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfAGPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:25:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfAGPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:25:09 -0500
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5CA9514C8371A;
        Mon,  7 Jan 2019 07:25:08 -0800 (PST)
Date:   Mon, 07 Jan 2019 07:25:07 -0800 (PST)
Message-Id: <20190107.072507.2123333109511407402.davem@davemloft.net>
To:     ap420073@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, ast@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH net v3 1/4] umh: add exit routine for UMH process
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190107121014.13499-1-ap420073@gmail.com>
References: <20190107121014.13499-1-ap420073@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 07 Jan 2019 07:25:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>
Date: Mon,  7 Jan 2019 21:10:14 +0900

> @@ -679,6 +688,29 @@ static int proc_cap_handler(struct ctl_table *table, int write,
>  	return 0;
>  }
>  
> +void exit_umh(struct task_struct *tsk)
> +{
> +	struct umh_info *info;
> +	pid_t pid = tsk->pid;
> +
> +	if (!(tsk->flags & PF_UMH))
> +		return;

Let's really make this low cost.

In linux/sched.h or similar:

void __exit_umh(struct task_struct *tsk);

static inline void exit_umh(struct task_struct *tsk)
{
	if (unlikely(tsk->flags & PF_UMH))
		__exit_umh(tsk);
}

Thank you.
