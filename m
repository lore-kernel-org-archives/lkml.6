Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbeFAWzw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 18:55:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42844 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFAWzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 18:55:50 -0400
X-Google-Smtp-Source: ADUXVKIhXNCc49vJmmlQqwfwoVqiVhDXSLXK32fmUkntSHUPcfEu34/D5nbnCLzyZJp6qQmbhJ1cEw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: dapm: delete dapm_kcontrol_data paths entry before freeing
Date: Fri,  1 Jun 2018 23:53:34 +0100
Message-Id: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dapm_kcontrol_data is freed as part of dapm_kcontrol_free(), leaving the
paths list pointer dangling in the list.

This leads to system crash when we try to unload and reload sound card.
I hit this bug during ADSP crash/reboot test case on Dragon board DB410c.

Below is the kernel BUG with SLAB Poisoning

=============================================================================
BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
-----------------------------------------------------------------------------

Disabling lock debugging due to kernel taint
INFO: 0xffff80003cf1c310-0xffff80003cf1c31f. First byte 0x10 instead of 0x6b
INFO: Allocated in dapm_kcontrol_data_alloc.isra.37+0x34/0x2a8 age=6929 cpu=0 pid=50
 __slab_alloc.isra.24+0x24/0x38
 kmem_cache_alloc+0x190/0x1d8
 dapm_kcontrol_data_alloc.isra.37+0x34/0x2a8
 dapm_create_or_share_kcontrol+0x1d4/0x290
 snd_soc_dapm_new_widgets+0x410/0x568
 snd_soc_register_card+0xa58/0xcd0
 apq8016_sbc_bind+0x31c/0x458
 try_to_bring_up_master+0x204/0x2e8
 component_add+0x94/0x178
 q6pcm_routing_probe+0x38/0x48
 platform_drv_probe+0x58/0xb8
 driver_probe_device+0x324/0x478
 __device_attach_driver+0xa8/0x160
 bus_for_each_drv+0x48/0x98
 __device_attach+0xc0/0x158
 device_initial_probe+0x10/0x18
INFO: Freed in dapm_kcontrol_free+0x40/0x50 age=3135 cpu=1 pid=1792
 kfree+0x1bc/0x1d0
 dapm_kcontrol_free+0x40/0x50
 snd_ctl_free_one+0x20/0x38
 snd_ctl_remove+0xf0/0x108
 snd_ctl_dev_free+0x3c/0x70
 __snd_device_free+0x50/0x88
 snd_device_free_all+0x2c/0x50
 release_card_device+0x1c/0x78
 device_release+0x34/0x98
 kobject_put+0x90/0x1f0
 put_device+0x14/0x20
 snd_card_free+0x54/0x70
 snd_soc_unregister_card+0x84/0x138
 snd_soc_unregister_component+0xa4/0xd0
 q6routing_dai_unbind+0x44/0x78
 component_unbind.isra.4+0x28/0x50
INFO: Slab 0xffff7e0000f3c700 objects=25 used=0 fp=0xffff80003cf1fc80 flags=0xfffc00000008100
INFO: Object 0x        (ptrval) @offset=768 fp=0x        (ptrval)

Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Redzone         (ptrval): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
Object         (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
Object         (ptrval): 10 c3 f1 3c 00 80 ff ff 10 c3 f1 3c 00 80 ff ff  ...<.......<....
Object         (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
Object         (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
Object         (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
Object         (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
Object         (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
Object         (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
Redzone         (ptrval): bb bb bb bb bb bb bb bb                          ........
Padding         (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
Padding         (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
Padding         (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
Padding         (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
CPU: 1 PID: 1792 Comm: sh Tainted: G    B   W         4.17.0-rc7-02229-gb429ee402d16-dirty #202
Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
Call trace:
 dump_backtrace+0x0/0x1b0
 show_stack+0x14/0x20
 dump_stack+0x9c/0xbc
 print_trailer+0x124/0x1d8
 check_bytes_and_report+0xe8/0x120
 check_object+0x24c/0x288
 __free_slab+0x9c/0x2f0
 discard_slab+0x60/0x88
 __slab_free+0x35c/0x3e8
 kfree+0x1bc/0x1d0
 snd_soc_dapm_free_widget+0xac/0xd0
 snd_soc_dapm_free+0x64/0xb8
 soc_remove_component+0x50/0x80
 soc_remove_dai_links+0x110/0x208
 snd_soc_unregister_card+0x9c/0x138
 snd_soc_unregister_component+0xa4/0xd0
 q6routing_dai_unbind+0x44/0x78
 component_unbind.isra.4+0x28/0x50
 component_unbind_all+0xc0/0xe8
 apq8016_sbc_unbind+0x50/0xa0
 take_down_master+0x24/0x48
 component_del+0x90/0x130
 q6afe_dai_dev_remove+0x40/0x68
 platform_drv_remove+0x24/0x50
 device_release_driver_internal+0x170/0x208
 device_release_driver+0x14/0x20
 bus_remove_device+0xcc/0x150
 device_del+0x10c/0x310
 platform_device_del.part.3+0x24/0x90
 platform_device_unregister+0x18/0x30
 of_platform_device_destroy+0x94/0x98
 q6afe_remove+0x20/0x38
 apr_device_remove+0x30/0x70
 device_release_driver_internal+0x170/0x208
 device_release_driver+0x14/0x20
 bus_remove_device+0xcc/0x150
 device_del+0x10c/0x310
 device_unregister+0x1c/0x70
 apr_remove_device+0xc/0x18
 device_for_each_child+0x50/0x80
 apr_remove+0x18/0x20
 rpmsg_dev_remove+0x38/0x68
 device_release_driver_internal+0x170/0x208
 device_release_driver+0x14/0x20
 bus_remove_device+0xcc/0x150
 device_del+0x10c/0x310
 device_unregister+0x1c/0x70
 qcom_smd_remove_device+0xc/0x18
 device_for_each_child+0x50/0x80
 qcom_smd_unregister_edge+0x3c/0x70
 smd_subdev_remove+0x18/0x28
 rproc_stop+0x48/0xd8
 rproc_shutdown+0x60/0xe8
 state_store+0xbc/0xf8
 dev_attr_store+0x18/0x28
 sysfs_kf_write+0x3c/0x50
 kernfs_fop_write+0x118/0x1e0
 __vfs_write+0x18/0x110
 vfs_write+0xa4/0x1a8
 ksys_write+0x48/0xb0
 sys_write+0xc/0x18
 el0_svc_naked+0x30/0x34

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1e9a36389667..36a39ba30226 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -433,6 +433,8 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+
+	list_del(&data->paths);
 	kfree(data->wlist);
 	kfree(data);
 }
-- 
2.16.2
