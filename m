Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBHJxa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:53:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50736 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeBHJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:53:25 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: osl: Replace GFP_ATOMIC with GFP_KERNEL in acpi_os_execute
Date: Thu, 08 Feb 2018 10:51:41 +0100
Message-ID: <1808276.ZJn2ZeULZY@aspire.rjw.lan>
In-Reply-To: <1516875222-12293-1-git-send-email-baijiaju1990@gmail.com>
References: <1516875222-12293-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 25, 2018 11:13:41 AM CET Jia-Ju Bai wrote:
> After checking all possible call chains to acpi_os_execute here,
> my tool finds that acpi_os_execute is never called in atomic context.
> And acpi_os_execute calls acpi_debugger_create_thread 
> which calls mutex_lock,
> thus it proves again that acpi_os_execute can 
> call functions which may sleep.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/acpi/osl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3bb46cb..8ee605e 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1066,7 +1066,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
>  	 * having a static work_struct.
>  	 */
>  
> -	dpc = kzalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
> +	dpc = kzalloc(sizeof(struct acpi_os_dpc), GFP_KERNEL);
>  	if (!dpc)
>  		return AE_NO_MEMORY;
>  
> 

Applied, thanks!
