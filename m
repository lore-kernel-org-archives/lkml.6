Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeCQTR6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 15:17:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36868 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeCQTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 15:17:57 -0400
Subject: Re: [PATCH] init: no need to wait device probe
To: ning.a.zhang@intel.com, linux-kernel@vger.kernel.org
References: <20180315072029.11441-1-ning.a.zhang@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <403951f8-a083-40d4-d58e-1f69ced6195a@infradead.org>
Date: Sat, 17 Mar 2018 12:17:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315072029.11441-1-ning.a.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/15/2018 12:20 AM, ning.a.zhang@intel.com wrote:
> From: Zhang Ning <ning.a.zhang@intel.com>

meta comment (i.e., not about the merits of the patch itself):

You'll need to send the patch to someone if you want it to be merged.
Maintainers don't mine mailing lists for patches to apply.

> there are 2 reasons for no need to wait device probe
> 
> reason 1:
> mount root device is very late in kernel initial stage.
> all initcalls are finished. that means most of probe functions
> are returned.
> 
> and deferred probe are also finished by late_initcall.
> only async probe driver are possible in  probing.
> 
> no block devices, device-mapper or nfs are use async probe.
> so no need to wait device probe.
> 
> reason 2:
> let's check dd.c, probe_count is increased and decreased only
> in really_probe, and when really_probe returns, probe_count
> always be 0.
> 
> when someone really wants to wait device-B probe.
> but code looks like:
> 
> thread-1:			thread-2:
> probe device-A;                 wait_for_device_probe();
> msleep(30);
> probe device-B
> 
> when device-A probe finishes, thread-2 will be wakeup,
> but device-B is not probed.
> 
> wait_for_device_probe can't make sure the device you want is probed.
> 
> based on above 2 reasons, no need to wait for device probe.
> 
> Signed-off-by: Zhang Ning <ning.a.zhang@intel.com>
> ---
>  init/do_mounts.c    | 9 ---------
>  init/do_mounts_md.c | 2 --
>  2 files changed, 11 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 7cf4f6dafd5f..a9fb2ad44964 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -555,15 +555,6 @@ void __init prepare_namespace(void)
>  		ssleep(root_delay);
>  	}
>  
> -	/*
> -	 * wait for the known devices to complete their probing
> -	 *
> -	 * Note: this is a potential source of long boot delays.
> -	 * For example, it is not atypical to wait 5 seconds here
> -	 * for the touchpad of a laptop to initialize.
> -	 */
> -	wait_for_device_probe();
> -
>  	md_run_setup();
>  
>  	if (saved_root_name[0]) {
> diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
> index 3f733c760a8c..4aab3492e71d 100644
> --- a/init/do_mounts_md.c
> +++ b/init/do_mounts_md.c
> @@ -292,8 +292,6 @@ static void __init autodetect_raid(void)
>  	printk(KERN_INFO "md: Waiting for all devices to be available before autodetect\n");
>  	printk(KERN_INFO "md: If you don't use raid, use raid=noautodetect\n");
>  
> -	wait_for_device_probe();
> -
>  	fd = sys_open("/dev/md0", 0, 0);
>  	if (fd >= 0) {
>  		sys_ioctl(fd, RAID_AUTORUN, raid_autopart);
> 


-- 
~Randy
