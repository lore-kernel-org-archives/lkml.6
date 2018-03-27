Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeC0GHB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:07:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44223 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeC0GG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:06:59 -0400
X-Google-Smtp-Source: AIpwx4/AjU5IW/W399QFjoQkuWL1Dl4qG5WmQ6BFAi07xO6oW6YjUfmTVGQnAuONn4kx81uvVnA7MA==
Date: Tue, 27 Mar 2018 08:06:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
Message-ID: <20180327060655.25zjgqlgbfsp6b3p@gmail.com>
References: <1522091848-18426-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522091848-18426-1-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> For a rwsem, locking can either be exclusive or shared. The corresponding
> exclusive or shared unlock must be used. Otherwise, the protected data
> structures may get corrupted or the lock may be in an inconsistent state.
> 
> In order to detect such anomaly, a new configuration option DEBUG_RWSEMS
> is added which can be enabled to look for such mismatches and print
> warnings that that happens.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 64155e3..0958192 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1075,6 +1075,13 @@ config DEBUG_WW_MUTEX_SLOWPATH
>  	 even a debug kernel.  If you are a driver writer, enable it.  If
>  	 you are a distro, do not.
>  
> +config DEBUG_RWSEMS
> +	bool "RW Semaphore debugging: basic checks"
> +	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
> +	help
> +	  This feature allows mismatched rw semaphore locks and unlocks
> +	  to be detected and reported.
> +

Makes sense - but this should also be integrated into the rest of lock debugging 
Kconfig hierarchy similar to DEBUG_MUTEXES: i.e. DEBUG_LOCK_ALLOC, PROVE_LOCKING, 
etc. should select this new lock debugging option as well.

People generally are not supposed to know and configure the finer details, 
CONFIG_LOCK_DEBUGGING=y is a one-stop-shop in this regard.

Thanks,

	Ingo
