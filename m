Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeBIHGz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:06:55 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42617 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBIHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:06:54 -0500
X-Google-Smtp-Source: AH8x227gCoCTFM0AfQyhpxoM6sifjn9LPZh9bLLdMFUX1+SDM3QUzqvLkoy1G+sTIiONAbbz3YbPeA==
Date: Fri, 9 Feb 2018 08:06:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 6/6] sched/isolation: Tick offload documentation
Message-ID: <20180209070649.kuk3dbwsycnqugsd@gmail.com>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
 <1518112779-30196-7-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518112779-30196-7-git-send-email-frederic@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Update the documentation to reflect the 1Hz tick offload changes.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Chris Metcalf <cmetcalf@mellanox.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Luiz Capitulino <lcapitulino@redhat.com>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 39ac9d4..c851e41 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1762,7 +1762,11 @@
>  			specified in the flag list (default: domain):
>  
>  			nohz
> -			  Disable the tick when a single task runs.
> +			  Disable the tick when a single task runs. A residual 1Hz
> +			  tick is offloaded to workqueues that you need to affine
> +			  to housekeeping through the sysfs file
> +			  /sys/devices/virtual/workqueue/cpumask or using the below
> +			  domain flag.

This is pretty ambiguous and somewhat confusing, I'd suggest something like:

			nohz
			  Disable the tick when a single task runs.

			  A residual 1Hz tick is offloaded to workqueues, which you 
			  need to affine to housekeeping through the global 
			  workqueue's affinity configured via the 
			  /sys/devices/virtual/workqueue/cpumask sysfs file, or 
			  by using the 'domain' flag described below.

			  NOTE: by default the global workqueue runs on all CPUs, 
			  so to protect individual CPUs the 'cpumask' file has to 
			  be configured manually after bootup.

Assuming what I wrote is correct - the CPU isolation config space is pretty 
confusing all around and should be made a lot more human friendly ...

Thanks,

	Ingo
