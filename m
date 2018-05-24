Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032945AbeEXUUo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:20:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40623 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032690AbeEXUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:20:42 -0400
X-Google-Smtp-Source: AB8JxZpGJ+CSpm2Hg+HoASWYWTCt8RDLxPzulyEXkBpy+NcdWIdJXwiQiXhT0zNALXS2ilXZRK8W0g==
Subject: Re: [PATCH] leds: class: ensure workqueue is initialized before
 setting brightness
To: Luis Henriques <lhenriques@suse.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180523222221.27621-1-lhenriques@suse.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <980e565f-a4da-eaad-0550-fe86a34182ce@gmail.com>
Date: Thu, 24 May 2018 22:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523222221.27621-1-lhenriques@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Thank you for the patch.

On 05/24/2018 12:22 AM, Luis Henriques wrote:
> An application can try to set brightness before all the initialization is
> done, in particular before the workqueue is initialized with the call to
> led_init_core().  Here's a WARNING easy to trigger:
> 
> [   36.780813] WARNING: CPU: 3 PID: 1411 at ../kernel/workqueue.c:1444 __queue_work+0x37b/0x420
> [   36.780815] Modules linked in: ...
> [   36.780868] CPU: 3 PID: 1411 Comm: systemd-backlig Not tainted 4.16.9-1-default #1 openSUSE Tumbleweed (unreleased)
> [   36.780868] Hardware name: Dell Inc. Precision 5510/0N8J4R, BIOS 1.6.1 12/11/2017
> [   36.780870] RIP: 0010:__queue_work+0x37b/0x420
> [   36.780871] RSP: 0018:ffffaced048b7d78 EFLAGS: 00010086
> [   36.780873] RAX: 0000000000000000 RBX: ffffffffb3f01440 RCX: 0000000000000000
> [   36.780873] RDX: ffffffffc05a90d8 RSI: 0000000000000000 RDI: ffff8eac7dce2700
> [   36.780874] RBP: ffff8ea547c16400 R08: ffff8ea547800000 R09: ffff8eac7dc22700
> [   36.780875] R10: 0000000000000000 R11: 0000000000000040 R12: 0000000000000003
> [   36.780876] R13: 0000000000000200 R14: ffffffffc05a90d0 R15: ffff8eac7dce8600
> [   36.780877] FS:  00007f871e61cf40(0000) GS:ffff8eac7dcc0000(0000) knlGS:0000000000000000
> [   36.780878] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   36.780879] CR2: 000055c91115e308 CR3: 0000000883ee0005 CR4: 00000000003606e0
> [   36.780880] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   36.780880] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   36.780881] Call Trace:
> [   36.780886]  queue_work_on+0x81/0x90
> [   36.780889]  brightness_store+0x5d/0x90
> [   36.780892]  kernfs_fop_write+0x105/0x180
> [   36.780894]  __vfs_write+0x26/0x150
> [   36.780897]  ? common_file_perm+0x51/0x150
> [   36.780900]  ? security_file_permission+0x3c/0xb0
> [   36.780901]  vfs_write+0xad/0x1a0
> [   36.780903]  SyS_write+0x42/0x90
> [   36.780906]  do_syscall_64+0x76/0x140
> [   36.780908]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> [   36.780910] RIP: 0033:0x7f871dd04c94
> [   36.780910] RSP: 002b:00007ffeb3a57d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   36.780912] RAX: ffffffffffffffda RBX: 000055c91115c810 RCX: 00007f871dd04c94
> [   36.780912] RDX: 0000000000000001 RSI: 000055c91115c810 RDI: 0000000000000004
> [   36.780913] RBP: 00007ffeb3a57e10 R08: 0000000000000003 R09: 0000000000000000
> [   36.780914] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [   36.780914] R13: 000055c911158f30 R14: 000055c90f3a9a4e R15: 0000000000000004
> [   36.780917] Code: 74 18 e8 49 80 00 00 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08
> 0f 84 c2 fc ff ff 0f 0b 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b e9
> 82 fd ff ff 83 cd 02 49 8d 57 60 e9 69 fd ff ff 80 3d
> [   36.780942] ---[ end trace 1fce4edad54c4017 ]---
> 
> This patch initializes and acquires the led_access mutex early in the
> of_led_classdev_register function, so that any application trying to write
> to sysfs to set brightness will block until initialization ends.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>   drivers/leds/led-class.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index b0e2d55acbd6..3c7e3487b373 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -260,10 +260,14 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>   	if (ret < 0)
>   		return ret;
>   
> +	mutex_init(&led_cdev->led_access);
> +	mutex_lock(&led_cdev->led_access);
>   	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
>   				led_cdev, led_cdev->groups, "%s", name);
> -	if (IS_ERR(led_cdev->dev))
> +	if (IS_ERR(led_cdev->dev)) {
> +		mutex_unlock(&led_cdev->led_access);
>   		return PTR_ERR(led_cdev->dev);
> +	}
>   	led_cdev->dev->of_node = np;
>   
>   	if (ret)
> @@ -274,6 +278,7 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>   		ret = led_add_brightness_hw_changed(led_cdev);
>   		if (ret) {
>   			device_unregister(led_cdev->dev);
> +			mutex_unlock(&led_cdev->led_access);
>   			return ret;
>   		}
>   	}
> @@ -285,7 +290,6 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>   #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
>   	led_cdev->brightness_hw_changed = -1;
>   #endif
> -	mutex_init(&led_cdev->led_access);
>   	/* add to the list of leds */
>   	down_write(&leds_list_lock);
>   	list_add_tail(&led_cdev->node, &leds_list);
> @@ -302,6 +306,8 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>   	led_trigger_set_default(led_cdev);
>   #endif
>   
> +	mutex_unlock(&led_cdev->led_access);
> +
>   	dev_dbg(parent, "Registered led device: %s\n",
>   			led_cdev->name);
>   
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
