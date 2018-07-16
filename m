Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8EBECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A815208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwdnkMjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A815208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGPP7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeGPP7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:59:09 -0400
Received: from localhost (LFbn-NCY-1-193-82.w83-194.abo.wanadoo.fr [83.194.41.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FB820647;
        Mon, 16 Jul 2018 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531755073;
        bh=rvna0uGV6D/Y6DRIspCJFRz6t+NjNSTawLUUQRzDJbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwdnkMjGmWpYzGQvlnqE9KkqfLG5brAQ8krO7vUkw9jrgH1XAdw9RXjTOvCHMa0An
         VKne8d2uCiw4rBnLGVUHDzbHdMX7+5DcXn8qIAlDfAVlkWXucSGoXAfDMKMvL4ZoIr
         K637R4Q5BmLElpUjjsU/YMfsR9TGKZWYxexTfJpM=
Date:   Mon, 16 Jul 2018 17:31:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Goutham, Sunil" <Sunil.Goutham@cavium.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nohz: don't kick non-idle CPUs in
 tick_nohz_full_kick_cpu()
Message-ID: <20180716153109.GA29270@lerouge>
References: <20180712181922.23073-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712181922.23073-1-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:19:22PM +0300, Yury Norov wrote:
> IIUC, tick_nohz_full_kick_cpu() is intended to wakeup idle CPUs
> that will not be poked by scheduler because they are actually
> nohz_full.

Not exactly. It is intended to trigger an interrupt on a nohz_full
CPU that may be running in userspace without any tick. The irq_exit()
code let us reprogramm the tick with the latest dependency updates.

> 
> But in fact this function kicks all CPUs listed in tick_nohz_full_mask,
> namely:
>  - idle CPUs;
>  - CPUs runnung normal tasks;
>  - CPUs running isolated tasks [1];
> 
> For normal tasks it introduces unneeded latency, and for isolated tasks
> it's fatal because isolation gets broken and task receives SIGKILL.

So this patch applies on Chris series right? For now there is no such
distinction between normal and isolated tasks. Any task running in a
nohz_full CPU is considered to be isolated.

> The patch below makes tick_nohz_full_kick_cpu() kicking only idle CPUs.
> Non-idle nohz_full CPUs will observe changed system settings just like
> non-idle normal (i.e. not nohz_full) CPUs, at next reschedule.

That's not exactly what we want. In fact when a task runs in a nohz_full CPU,
it may not meet any reschedule interrupt for a long while. This is why we have
tick_nohz_full_kick_cpu() in order to force a nohz_full CPU to see the latest
changes.

Thanks.
