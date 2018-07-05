Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9BBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094C2241AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094C2241AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeGEGhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:37:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41228 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbeGEGhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:37:48 -0400
Received: by mail-qt0-f193.google.com with SMTP id y20-v6so6266313qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 23:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=elW0zWZKZ3z4Rpa/iTI5WC1gIpJRW3sx44dG7DHgeUU=;
        b=ZHC5nphL9P3DPGmtF9X0DCbDGpZBkEdku1HLAzCZqNZ7JbyNRipukdaGGA2CYHsNYx
         p5se+Le0wlqf8ipfwyUsW0x86Zt6zBgrc/rqtBJg0GZX4vrkY18kCuM9+w6/eCgHNuqZ
         GPrhZLfmV7ldFaYK3niVYiT+7urqmc2rUCod34LSjqSyVo8J8oaSu5mu6HXHSNp8H12a
         IOk/2kVlvFu/pctuKpO1CvlzT70EI6rt6dMZdofvJkkwuJ0qJ8nnLqDcF34AZNAj6Mzm
         2VTx9Z3lZtl1yWA71pfXTxKl3vlfHp7FqHZ+uPQs/HGAVRerdnwiiMtvr8n5JXQLjK8b
         F00g==
X-Gm-Message-State: APt69E1e26t/eVziXRdBQhq68m1d5hdJLvv3XiRSj6OJGE9zefP73FUa
        W2J+KjyHm1UpcYVnuF9tFu0B3mZtra0Gn1IM4kcoMA==
X-Google-Smtp-Source: AAOMgpdVHAbW1zdAPRW9KFN5fAKgkuPYorvw71/ze2qASvk+iuNOeLYl4ePfRBOoUqvRwGY0hQebnIRtGIKEY9H5B1c=
X-Received: by 2002:a0c:8c05:: with SMTP id n5-v6mr3957785qvb.185.1530772667702;
 Wed, 04 Jul 2018 23:37:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2fca:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 23:37:47 -0700 (PDT)
In-Reply-To: <20180625075148.22140-1-benjamin.tissoires@redhat.com>
References: <20180625075148.22140-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 5 Jul 2018 08:37:47 +0200
Message-ID: <CAO-hwJ+f4xAnGFLCEwXoH7W7CDpy6vx9dUAXxYyb5AJTJ3Lj4Q@mail.gmail.com>
Subject: Re: [PATCH] power: remove possible deadlock when unregistering power_supply
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Richard Hughes <rhughes@redhat.com>,
        Aaron Skomra <Aaron.Skomra@wacom.com>,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <Ping.Cheng@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 25, 2018 at 9:51 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> If a device gets removed right after having registered a power_supply node,
> we might enter in a deadlock between the remove call (that has a lock on
> the parent device) and the deferred register work.
>
> Allow the deferred register work to exit without taking the lock when
> we are in the remove state.
>
> Stack trace on a Ubuntu 16.04:
>
> [16072.109121] INFO: task kworker/u16:2:1180 blocked for more than 120 seconds.
> [16072.109127]       Not tainted 4.13.0-41-generic #46~16.04.1-Ubuntu
> [16072.109129] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [16072.109132] kworker/u16:2   D    0  1180      2 0x80000000
> [16072.109142] Workqueue: events_power_efficient power_supply_deferred_register_work
> [16072.109144] Call Trace:
> [16072.109152]  __schedule+0x3d6/0x8b0
> [16072.109155]  schedule+0x36/0x80
> [16072.109158]  schedule_preempt_disabled+0xe/0x10
> [16072.109161]  __mutex_lock.isra.2+0x2ab/0x4e0
> [16072.109166]  __mutex_lock_slowpath+0x13/0x20
> [16072.109168]  ? __mutex_lock_slowpath+0x13/0x20
> [16072.109171]  mutex_lock+0x2f/0x40
> [16072.109174]  power_supply_deferred_register_work+0x2b/0x50
> [16072.109179]  process_one_work+0x15b/0x410
> [16072.109182]  worker_thread+0x4b/0x460
> [16072.109186]  kthread+0x10c/0x140
> [16072.109189]  ? process_one_work+0x410/0x410
> [16072.109191]  ? kthread_create_on_node+0x70/0x70
> [16072.109194]  ret_from_fork+0x35/0x40
> [16072.109199] INFO: task test:2257 blocked for more than 120 seconds.
> [16072.109202]       Not tainted 4.13.0-41-generic #46~16.04.1-Ubuntu
> [16072.109204] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [16072.109206] test            D    0  2257   2256 0x00000004
> [16072.109208] Call Trace:
> [16072.109211]  __schedule+0x3d6/0x8b0
> [16072.109215]  schedule+0x36/0x80
> [16072.109218]  schedule_timeout+0x1f3/0x360
> [16072.109221]  ? check_preempt_curr+0x5a/0xa0
> [16072.109224]  ? ttwu_do_wakeup+0x1e/0x150
> [16072.109227]  wait_for_completion+0xb4/0x140
> [16072.109230]  ? wait_for_completion+0xb4/0x140
> [16072.109233]  ? wake_up_q+0x70/0x70
> [16072.109236]  flush_work+0x129/0x1e0
> [16072.109240]  ? worker_detach_from_pool+0xb0/0xb0
> [16072.109243]  __cancel_work_timer+0x10f/0x190
> [16072.109247]  ? device_del+0x264/0x310
> [16072.109250]  ? __wake_up+0x44/0x50
> [16072.109253]  cancel_delayed_work_sync+0x13/0x20
> [16072.109257]  power_supply_unregister+0x37/0xb0
> [16072.109260]  devm_power_supply_release+0x11/0x20
> [16072.109263]  release_nodes+0x110/0x200
> [16072.109266]  devres_release_group+0x7c/0xb0
> [16072.109274]  wacom_remove+0xc2/0x110 [wacom]
> [16072.109279]  hid_device_remove+0x6e/0xd0 [hid]
> [16072.109284]  device_release_driver_internal+0x158/0x210
> [16072.109288]  device_release_driver+0x12/0x20
> [16072.109291]  bus_remove_device+0xec/0x160
> [16072.109293]  device_del+0x1de/0x310
> [16072.109298]  hid_destroy_device+0x27/0x60 [hid]
> [16072.109303]  usbhid_disconnect+0x51/0x70 [usbhid]
> [16072.109308]  usb_unbind_interface+0x77/0x270
> [16072.109311]  device_release_driver_internal+0x158/0x210
> [16072.109315]  device_release_driver+0x12/0x20
> [16072.109318]  usb_driver_release_interface+0x77/0x80
> [16072.109321]  proc_ioctl+0x20f/0x250
> [16072.109325]  usbdev_do_ioctl+0x57f/0x1140
> [16072.109327]  ? __wake_up+0x44/0x50
> [16072.109331]  usbdev_ioctl+0xe/0x20
> [16072.109336]  do_vfs_ioctl+0xa4/0x600
> [16072.109339]  ? vfs_write+0x15a/0x1b0
> [16072.109343]  SyS_ioctl+0x79/0x90
> [16072.109347]  entry_SYSCALL_64_fastpath+0x24/0xab
> [16072.109349] RIP: 0033:0x7f20da807f47
> [16072.109351] RSP: 002b:00007ffc422ae398 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [16072.109353] RAX: ffffffffffffffda RBX: 00000000010b8560 RCX: 00007f20da807f47
> [16072.109355] RDX: 00007ffc422ae3a0 RSI: 00000000c0105512 RDI: 0000000000000009
> [16072.109356] RBP: 0000000000000000 R08: 00007ffc422ae3e0 R09: 0000000000000010
> [16072.109357] R10: 00000000000000a6 R11: 0000000000000246 R12: 0000000000000000
> [16072.109359] R13: 00000000010b8560 R14: 00007ffc422ae2e0 R15: 0000000000000000
>
> Reported-and-tested-by: Richard Hughes <rhughes@redhat.com>
> Tested-by: Aaron Skomra <Aaron.Skomra@wacom.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

This also has been reported on the kernel bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=200397

Is there any chances this could get reviewed soon-ish?

Cheers,
Benjamin

> ---
>  drivers/power/supply/power_supply_core.c | 11 +++++++++--
>  include/linux/power_supply.h             |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index feac7b066e6c..20a8c2a12199 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/notifier.h>
>  #include <linux/err.h>
> @@ -139,8 +140,13 @@ static void power_supply_deferred_register_work(struct work_struct *work)
>         struct power_supply *psy = container_of(work, struct power_supply,
>                                                 deferred_register_work.work);
>
> -       if (psy->dev.parent)
> -               mutex_lock(&psy->dev.parent->mutex);
> +       if (psy->dev.parent) {
> +               while (!mutex_trylock(&psy->dev.parent->mutex)) {
> +                       if (psy->removing)
> +                               return;
> +                       msleep(10);
> +               }
> +       }
>
>         power_supply_changed(psy);
>
> @@ -1071,6 +1077,7 @@ EXPORT_SYMBOL_GPL(devm_power_supply_register_no_ws);
>  void power_supply_unregister(struct power_supply *psy)
>  {
>         WARN_ON(atomic_dec_return(&psy->use_cnt));
> +       psy->removing = true;
>         cancel_work_sync(&psy->changed_work);
>         cancel_delayed_work_sync(&psy->deferred_register_work);
>         sysfs_remove_link(&psy->dev.kobj, "powers");
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f0139b460a72..0a587526a916 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -251,6 +251,7 @@ struct power_supply {
>         spinlock_t changed_lock;
>         bool changed;
>         bool initialized;
> +       bool removing;
>         atomic_t use_cnt;
>  #ifdef CONFIG_THERMAL
>         struct thermal_zone_device *tzd;
> --
> 2.14.3
>
