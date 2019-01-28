Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2CFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5F20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfA1SPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:15:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA1SPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:15:17 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32F7E25CE;
        Mon, 28 Jan 2019 18:15:15 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:15:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Arkadiusz =?UTF-8?Q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] oom, oom_reaper: do not enqueue same task twice
Message-Id: <20190128101513.f35752d6210f0781d0de8d17@linux-foundation.org>
In-Reply-To: <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
References: <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
        <480296c4-ed7a-3265-e84a-298e42a0f1d5@I-love.SAKURA.ne.jp>
        <6da6ca69-5a6e-a9f6-d091-f89a8488982a@gmail.com>
        <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
        <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
        <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
        <2b0c7d6c-c58a-da7d-6f0a-4900694ec2d3@gmail.com>
        <1d161137-55a5-126f-b47e-b2625bd798ca@i-love.sakura.ne.jp>
        <20190127083724.GA18811@dhcp22.suse.cz>
        <ec0d0580-a2dd-f329-9707-0cb91205a216@i-love.sakura.ne.jp>
        <20190127114021.GB18811@dhcp22.suse.cz>
        <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2019 23:57:38 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> Arkadiusz reported that enabling memcg's group oom killing causes
> strange memcg statistics where there is no task in a memcg despite
> the number of tasks in that memcg is not 0. It turned out that there
> is a bug in wake_oom_reaper() which allows enqueuing same task twice
> which makes impossible to decrease the number of tasks in that memcg
> due to a refcount leak.
> 
> This bug existed since the OOM reaper became invokable from
> task_will_free_mem(current) path in out_of_memory() in Linux 4.7,
> but memcg's group oom killing made it easier to trigger this bug by
> calling wake_oom_reaper() on the same task from one out_of_memory()
> request.
> 
> Fix this bug using an approach used by commit 855b018325737f76
> ("oom, oom_reaper: disable oom_reaper for oom_kill_allocating_task").
> As a side effect of this patch, this patch also avoids enqueuing
> multiple threads sharing memory via task_will_free_mem(current) path.
> 

Do we think this is serious enough to warrant a -stable backport?
