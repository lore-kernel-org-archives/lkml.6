Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965607AbeBMSyK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:54:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965473AbeBMSyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:54:08 -0500
Subject: Re: [PATCH] powerpc/via-pmu: Fix section mismatch warning
To: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180207194439.32680-1-malat@debian.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <dfdca2f9-bf75-cdd3-e149-f3a30944d4ae@redhat.com>
Date: Tue, 13 Feb 2018 19:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207194439.32680-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 20:44, Mathieu Malaterre wrote:
> Remove the __init annotation from pmu_init() to avoid the
> following warning.
> 
> WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
> The variable via_pmu_driver references
> the function __init pmu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/macintosh/via-pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 08849e33c567..5f378272d5b2 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -378,7 +378,7 @@ static int pmu_probe(void)
>  	return vias == NULL? -ENODEV: 0;
>  }
>  
> -static int __init pmu_init(void)
> +static int pmu_init(void)
>  {
>  	if (vias == NULL)
>  		return -ENODEV;
> 

pmu_init() is really an init function only called by another init
function (adb_init()).

So I think it could be good to let the __init marker.

Did you try:

--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -198,7 +198,7 @@ static const struct file_operations
pmu_battery_proc_fops;
 static const struct file_operations pmu_options_proc_fops;

 #ifdef CONFIG_ADB
-struct adb_driver via_pmu_driver = {
+const struct adb_driver via_pmu_driver = {
        "PMU",
        pmu_probe,
        pmu_init,


Thanks,
Laurent
