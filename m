Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeC3KHz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:07:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42844 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeC3KHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:07:53 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: acpi_pad: Fix memory leak in power saving threads
Date: Fri, 30 Mar 2018 12:08:10 +0200
Message-ID: <2044415.8uv91vuFCW@aspire.rjw.lan>
In-Reply-To: <1522159000-7778-1-git-send-email-lszubowi@redhat.com>
References: <1522159000-7778-1-git-send-email-lszubowi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 27, 2018 3:56:40 PM CEST Lenny Szubowicz wrote:
> Fix once per second (round_robin_time) memory leak of about 1 KB in
> each acpi_pad kernel idling thread that is activated.
> 
> Found by testing with kmemleak.
> 
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---
>  drivers/acpi/acpi_pad.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 7544310..552c1f7 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -110,6 +110,7 @@ static void round_robin_cpu(unsigned int tsk_index)
>  		cpumask_andnot(tmp, cpu_online_mask, pad_busy_cpus);
>  	if (cpumask_empty(tmp)) {
>  		mutex_unlock(&round_robin_lock);
> +		free_cpumask_var(tmp);
>  		return;
>  	}
>  	for_each_cpu(cpu, tmp) {
> @@ -127,6 +128,8 @@ static void round_robin_cpu(unsigned int tsk_index)
>  	mutex_unlock(&round_robin_lock);
>  
>  	set_cpus_allowed_ptr(current, cpumask_of(preferred_cpu));
> +
> +	free_cpumask_var(tmp);
>  }
>  
>  static void exit_round_robin(unsigned int tsk_index)
> 

Applied, thanks!
