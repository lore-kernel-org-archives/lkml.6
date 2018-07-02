Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD57C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D69E2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D69E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeGBPNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:13:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752162AbeGBPNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:13:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73DEBAD37;
        Mon,  2 Jul 2018 15:13:48 +0000 (UTC)
Date:   Mon, 2 Jul 2018 17:13:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] fork: don't copy inconsistent signal handler state to
 child
Message-ID: <20180702151346.GD19043@dhcp22.suse.cz>
References: <20180702145108.73189-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702145108.73189-1-jannh@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 16:51:08, Jann Horn wrote:
> Before this change, if a multithreaded process forks while one of its
> threads is changing a signal handler using sigaction(), the memcpy() in
> copy_sighand() can race with the struct assignment in do_sigaction().
> It isn't clear whether this can cause corruption of the userspace signal
> handler pointer, but it definitely can cause inconsistency between
> different fields of struct sigaction.
> 
> Take the appropriate spinlock to avoid this.
> 
> I have tested that this patch prevents inconsistency between sa_sigaction
> and sa_flags, which is possible before this patch.

Looks sensible to me.

> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> I haven't added a CC stable line to this patch because I feel that it
> doesn't quite meet the bar; if anyone disagrees, please say so.
> 
> 
>  kernel/fork.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9440d61b925c..4c86e8daae53 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1394,7 +1394,9 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
>  		return -ENOMEM;
>  
>  	atomic_set(&sig->count, 1);
> +	spin_lock_irq(&current->sighand->siglock);
>  	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
> +	spin_unlock_irq(&current->sighand->siglock);
>  	return 0;
>  }
>  
> -- 
> 2.18.0.399.gad0ab374a1-goog
> 

-- 
Michal Hocko
SUSE Labs
