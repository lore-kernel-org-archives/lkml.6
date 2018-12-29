Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DF0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C52020869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeL2Wez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:34:55 -0500
Received: from mail.nwra.com ([72.52.192.72]:57252 "EHLO mail.nwra.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeL2Wez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:34:55 -0500
Received: from pacas.cora.nwra.com (c-67-166-25-97.hsd1.co.comcast.net [67.166.25.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.nwra.com (Postfix) with ESMTPSA id 75C1D3404E6;
        Sat, 29 Dec 2018 14:34:52 -0800 (PST)
Subject: Re: [PATCH] fanotify: allow freeze on suspend when waiting for
 response from userspace
From:   Orion Poplawski <orion@nwra.com>
To:     linux-kernel@vger.kernel.org, Vivek Trivedi <t.vivek@samsung.com>,
        Jan Kara <jack@suse.com>
References: <c1bb16b7-9eee-9cea-2c96-a512d8b3b9c7@nwra.com>
Organization: NorthWest Research Associates
Message-ID: <dfcfb136-7030-86d8-9462-f5ab96051009@nwra.com>
Date:   Sat, 29 Dec 2018 15:34:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <c1bb16b7-9eee-9cea-2c96-a512d8b3b9c7@nwra.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/18 3:04 PM, Orion Poplawski wrote:
>> On Thu 22-02-18 15:14:54, Kunal Shubham wrote:
>>> >> On Fri 16-02-18 15:14:40, t.vivek@samsung.com wrote:
>>> >> From: Vivek Trivedi <t.vivek@samsung.com>
>>> >> >> If fanotify userspace response server thread is frozen first,
>>> >> it may fail to send response from userspace to kernel space listener.
>>> >> In this scenario, fanotify response listener will never get response
>>> >> from userepace and fail to suspend.
>>> >> >> Use freeze-friendly wait API to handle this issue.
>>> >> >> Same problem was reported here:
>>> >> https://bbs.archlinux.org/viewtopic.php?id=232270
>>> >> >> Freezing of tasks failed after 20.005 seconds
>>> >> (1 tasks refusing to freeze, wq_busy=0)
>>> >> >> Backtrace:
>>> >> [<c0582f80>] (__schedule) from [<c05835d0>] (schedule+0x4c/0xa4)
>>> >> [<c0583584>] (schedule) from [<c01cb648>] 
>>> (fanotify_handle_event+0x1c8/0x218)
>>> >> [<c01cb480>] (fanotify_handle_event) from [<c01c8238>] 
>>> (fsnotify+0x17c/0x38c)
>>> >> [<c01c80bc>] (fsnotify) from [<c02676dc>] 
>>> (security_file_open+0x88/0x8c)
>>> >> [<c0267654>] (security_file_open) from [<c01854b0>] 
>>> (do_dentry_open+0xc0/0x338)
>>> >> [<c01853f0>] (do_dentry_open) from [<c0185a38>] (vfs_open+0x54/0x58)
>>> >> [<c01859e4>] (vfs_open) from [<c0195480>] 
>>> (do_last.isra.10+0x45c/0xcf8)
>>> >> [<c0195024>] (do_last.isra.10) from [<c0196140>] 
>>> (path_openat+0x424/0x600)
>>> >> [<c0195d1c>] (path_openat) from [<c0197498>] (do_filp_open+0x3c/0x98)
>>> >> [<c019745c>] (do_filp_open) from [<c0186b44>] 
>>> (do_sys_open+0x120/0x1e4)
>>> >> [<c0186a24>] (do_sys_open) from [<c0186c30>] (SyS_open+0x28/0x2c)
>>> >> [<c0186c08>] (SyS_open) from [<c0010200>] 
>>> (__sys_trace_return+0x0/0x20)
>>> >
>>> > Yeah, good catch.
>>> >
>>> >> @@ -63,7 +64,9 @@ static int fanotify_get_response(struct 
>>> fsnotify_group *group,
>>> >> >>      pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>>> >> >> -    wait_event(group->fanotify_data.access_waitq, 
>>> event->response);
>>> >> +    while (!event->response)
>>> >> +        wait_event_freezable(group->fanotify_data.access_waitq,
>>> >> +                     event->response);
>>> >
>>> > But if the process gets a signal while waiting, we will just 
>>> livelock the
>>> > kernel in this loop as wait_event_freezable() will keep returning
>>> > ERESTARTSYS. So you need to be a bit more clever here...
>>>
>>> Hi Jack,
>>> Thanks for the quick review.
>>> To avoid livelock issue, is it fine to use below change? If agree, I 
>>> will send v2 patch.
>>>
>>> @@ -63,7 +64,11 @@ static int fanotify_get_response(struct 
>>> fsnotify_group *group,
>>>
>>>         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>>>
>>> -       wait_event(group->fanotify_data.access_waitq, event->response);
>>> +       while (!event->response) {
>>> +               if 
>>> (wait_event_freezable(group->fanotify_data.access_waitq,
>>> +                                       event->response))
>>> +                       flush_signals(current);
>>> +       }
>>
>> Hum, I don't think this is correct either as this way if any signal was
>> delivered while waiting for fanotify response, we'd just lose it while
>> previously it has been properly handled. So what I think needs to be done
>> is that we just use wait_event_freezable() and propagate non-zero return
>> value (-ERESTARTSYS) up to the caller to handle the signal and restart 
>> the
>> syscall as necessary.
>>
>>                                 Honza
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
> 
> Is there any progress here?  This has become a real pain for us while 
> running BitDefender on EL7 laptops.  I tried applying the following to 
> the EL7 kernel:
> 
> diff -up 
> linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c.orig 
> kernel-3.10.0-957.1.3.el7/linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c 
> 
> --- linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c.orig 
> 2018-11-15 10:07:13.000000000 -0700
> +++ linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c 
> 2018-12-28 15:44:26.452895337 -0700
> @@ -9,6 +9,7 @@
>   #include <linux/types.h>
>   #include <linux/wait.h>
>   #include <linux/audit.h>
> +#include <linux/freezer.h>
> 
>   #include "fanotify.h"
> 
> @@ -64,7 +65,12 @@ static int fanotify_get_response(struct
> 
>          pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> 
> -       wait_event(group->fanotify_data.access_waitq, event->response);
> +       while (!event->response) {
> +               ret = 
> wait_event_freezable(group->fanotify_data.access_waitq,
> +                                          event->response);
> +               if (ret < 0)
> +                       return ret;
> +       }
> 
>          /* userspace responded, convert to something usable */
>          switch (event->response & ~FAN_AUDIT) {
> 
> but I get a kernel panic shortly after logging in to the system.
> 

Here is the panic:

[  324.774862] ------------[ cut here ]------------
[  324.774872] WARNING: CPU: 1 PID: 18685 at fs/notify/notification.c:84 
fsnotify_destroy_event+0x6b/0x70
[  324.774874] Modules linked in: cmac ccm xt_CHECKSUM iptable_mangle 
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT 
nf_reject_ipv4 tun bridge stp llc devlink ebtable_filter ebtables 
ip6table_filter ip6_tables iptable_filter bnep hid_multitouch iTCO_wdt 
iTCO_vendor_support intel_wmi_thunderbolt dell_wmi arc4 iwlmvm 
intel_pmc_core intel_powerclamp coretemp intel_rapl mac80211 kvm_intel 
vfat fat dell_laptop kvm snd_hda_codec_hdmi dell_smbios 
dell_wmi_descriptor dcdbas dell_led irqbypass snd_hda_codec_realtek 
snd_soc_skl snd_hda_codec_generic snd_soc_skl_ipc snd_hda_ext_core 
snd_soc_sst_dsp iwlwifi snd_soc_sst_ipc snd_soc_acpi snd_soc_core 
snd_compress snd_hda_intel snd_hda_codec joydev snd_hda_core snd_hwdep 
snd_seq
[  324.774918]  snd_seq_device pcspkr snd_pcm rtsx_pci_ms memstick 
uvcvideo cfg80211 videobuf2_vmalloc snd_timer videobuf2_memops 
videobuf2_core snd videodev soundcore i2c_i801 btusb btrtl btbcm btintel 
bluetooth rfkill idma64 virt_dma i2c_designware_platform 
i2c_designware_core wmi pinctrl_sunrisepoint pinctrl_intel intel_hid 
sparse_keymap int3400_thermal acpi_pad mei_me mei binfmt_misc 
auth_rpcgss sunrpc ip_tables xfs libcrc32c dm_crypt drbg ansi_cprng 
rtsx_pci_sdmmc mmc_core crct10dif_pclmul crct10dif_common crc32_pclmul 
crc32c_intel i915 ghash_clmulni_intel aesni_intel lrw gf128mul 
glue_helper ablk_helper cryptd serio_raw nvme nvme_core rtsx_pci i2c_hid 
i2c_algo_bit iosf_mbi drm_kms_helper video ahci syscopyarea sysfillrect 
sysimgblt fb_sys_fops libahci drm libata drm_panel_orientation_quirks 
dm_mirror
[  324.774964]  dm_region_hash dm_log dm_mod
[  324.774968] CPU: 1 PID: 18685 Comm: gnome-session-f Kdump: loaded Not 
tainted 3.10.0-957.1.3.el7.fanotify.x86_64 #1
[  324.774970] Hardware name: Dell Inc. XPS 13 9350/0YT4WT, BIOS 1.7.0 
01/16/2018
[  324.774972] Call Trace:
[  324.774978]  [<ffffffffa8961e41>] dump_stack+0x19/0x1b
[  324.774982]  [<ffffffffa8297648>] __warn+0xd8/0x100
[  324.774986]  [<ffffffffa829778d>] warn_slowpath_null+0x1d/0x20
[  324.774989]  [<ffffffffa84892bb>] fsnotify_destroy_event+0x6b/0x70
[  324.774992]  [<ffffffffa848c7a9>] fanotify_handle_event+0x279/0x410
[  324.774996]  [<ffffffffa82c2d00>] ? wake_up_atomic_t+0x30/0x30
[  324.774999]  [<ffffffffa8488c27>] fsnotify+0x2d7/0x510
[  324.775003]  [<ffffffffa84f940e>] security_file_open+0x6e/0x70
[  324.775007]  [<ffffffffa843e9d9>] do_dentry_open+0xb9/0x2e0
[  324.775010]  [<ffffffffa84f8e62>] ? security_inode_permission+0x22/0x30
[  324.775013]  [<ffffffffa843ec9a>] vfs_open+0x5a/0xb0
[  324.775016]  [<ffffffffa844d1a8>] ? may_open+0x68/0x120
[  324.775018]  [<ffffffffa844f7ad>] do_last+0x1ed/0x12a0
[  324.775043]  [<ffffffffc06f387c>] ? xfs_iunlock+0xac/0x130 [xfs]
[  324.775046]  [<ffffffffa84529d2>] path_openat+0x442/0x640
[  324.775050]  [<ffffffffa845406d>] do_filp_open+0x4d/0xb0
[  324.775053]  [<ffffffffa84616f7>] ? __alloc_fd+0x47/0x170
[  324.775057]  [<ffffffffa8440197>] do_sys_open+0x137/0x240
[  324.775060]  [<ffffffffa84402be>] SyS_open+0x1e/0x20
[  324.775064]  [<ffffffffa8974ddb>] system_call_fastpath+0x22/0x27
[  324.775067] ---[ end trace e834a395da6ce84e ]---
[  324.775225] ------------[ cut here ]------------
[  324.775231] WARNING: CPU: 1 PID: 17759 at lib/list_debug.c:33 
__list_add+0xac/0xc0
[  324.775234] list_add corruption. prev->next should be next 
(ffff8a8d72d5f9a8), but was ffff8a8d36b7a280. (prev=ffff8a8d36b7a380).
[  324.775236] Modules linked in: cmac ccm xt_CHECKSUM iptable_mangle 
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT 
nf_reject_ipv4 tun bridge stp llc devlink ebtable_filter ebtables 
ip6table_filter ip6_tables iptable_filter bnep hid_multitouch iTCO_wdt 
iTCO_vendor_support intel_wmi_thunderbolt dell_wmi arc4 iwlmvm 
intel_pmc_core intel_powerclamp coretemp intel_rapl mac80211 kvm_intel 
vfat fat dell_laptop kvm snd_hda_codec_hdmi dell_smbios 
dell_wmi_descriptor dcdbas dell_led irqbypass snd_hda_codec_realtek 
snd_soc_skl snd_hda_codec_generic snd_soc_skl_ipc snd_hda_ext_core 
snd_soc_sst_dsp iwlwifi snd_soc_sst_ipc snd_soc_acpi snd_soc_core 
snd_compress snd_hda_intel snd_hda_codec joydev snd_hda_core snd_hwdep 
snd_seq
[  324.775281]  snd_seq_device pcspkr snd_pcm rtsx_pci_ms memstick 
uvcvideo cfg80211 videobuf2_vmalloc snd_timer videobuf2_memops 
videobuf2_core snd videodev soundcore i2c_i801 btusb btrtl btbcm btintel 
bluetooth rfkill idma64 virt_dma i2c_designware_platform 
i2c_designware_core wmi pinctrl_sunrisepoint pinctrl_intel intel_hid 
sparse_keymap int3400_thermal acpi_pad mei_me mei binfmt_misc 
auth_rpcgss sunrpc ip_tables xfs libcrc32c dm_crypt drbg ansi_cprng 
rtsx_pci_sdmmc mmc_core crct10dif_pclmul crct10dif_common crc32_pclmul 
crc32c_intel i915 ghash_clmulni_intel aesni_intel lrw gf128mul 
glue_helper ablk_helper cryptd serio_raw nvme nvme_core rtsx_pci i2c_hid 
i2c_algo_bit iosf_mbi drm_kms_helper video ahci syscopyarea sysfillrect 
sysimgblt fb_sys_fops libahci drm libata drm_panel_orientation_quirks 
dm_mirror
[  324.775339]  dm_region_hash dm_log dm_mod
[  324.775344] CPU: 1 PID: 17759 Comm: bdepsecd Kdump: loaded Tainted: G 
        W      ------------   3.10.0-957.1.3.el7.fanotify.x86_64 #1
[  324.775348] Hardware name: Dell Inc. XPS 13 9350/0YT4WT, BIOS 1.7.0 
01/16/2018
[  324.775350] Call Trace:
[  324.775356]  [<ffffffffa8961e41>] dump_stack+0x19/0x1b
[  324.775360]  [<ffffffffa8297648>] __warn+0xd8/0x100
[  324.775364]  [<ffffffffa82976cf>] warn_slowpath_fmt+0x5f/0x80
[  324.775369]  [<ffffffffa843ec9a>] ? vfs_open+0x5a/0xb0
[  324.775373]  [<ffffffffa8594c7c>] __list_add+0xac/0xc0
[  324.775378]  [<ffffffffa848d1d6>] fanotify_read+0x2a6/0x5a0
[  324.775382]  [<ffffffffa82c2a10>] ? abort_exclusive_wait+0xa0/0xa0
[  324.775386]  [<ffffffffa844117f>] vfs_read+0x9f/0x170
[  324.775389]  [<ffffffffa844203f>] SyS_read+0x7f/0xf0
[  324.775393]  [<ffffffffa8974ddb>] system_call_fastpath+0x22/0x27
[  324.775397] ---[ end trace e834a395da6ce84f ]---
[  324.902124] ------------[ cut here ]------------
[  324.902132] WARNING: CPU: 0 PID: 18693 at lib/list_debug.c:36 
__list_add+0x8a/0xc0
[  324.902135] list_add double add: new=ffff8a8d36b7a390, 
prev=ffff8a8d43b29b70, next=ffff8a8d36b7a390.
[  324.902136] Modules linked in: cmac ccm xt_CHECKSUM iptable_mangle 
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT 
nf_reject_ipv4 tun bridge stp llc devlink ebtable_filter ebtables 
ip6table_filter ip6_tables iptable_filter bnep hid_multitouch iTCO_wdt 
iTCO_vendor_support intel_wmi_thunderbolt dell_wmi arc4 iwlmvm 
intel_pmc_core intel_powerclamp coretemp intel_rapl mac80211 kvm_intel 
vfat fat dell_laptop kvm snd_hda_codec_hdmi dell_smbios 
dell_wmi_descriptor dcdbas dell_led irqbypass snd_hda_codec_realtek 
snd_soc_skl snd_hda_codec_generic snd_soc_skl_ipc snd_hda_ext_core 
snd_soc_sst_dsp iwlwifi snd_soc_sst_ipc snd_soc_acpi snd_soc_core 
snd_compress snd_hda_intel snd_hda_codec joydev snd_hda_core snd_hwdep 
snd_seq
[  324.902187]  snd_seq_device pcspkr snd_pcm rtsx_pci_ms memstick 
uvcvideo cfg80211 videobuf2_vmalloc snd_timer videobuf2_memops 
videobuf2_core snd videodev soundcore i2c_i801 btusb btrtl btbcm btintel 
bluetooth rfkill idma64 virt_dma i2c_designware_platform 
i2c_designware_core wmi pinctrl_sunrisepoint pinctrl_intel intel_hid 
sparse_keymap int3400_thermal acpi_pad mei_me mei binfmt_misc 
auth_rpcgss sunrpc ip_tables xfs libcrc32c dm_crypt drbg ansi_cprng 
rtsx_pci_sdmmc mmc_core crct10dif_pclmul crct10dif_common crc32_pclmul 
crc32c_intel i915 ghash_clmulni_intel aesni_intel lrw gf128mul 
glue_helper ablk_helper cryptd serio_raw nvme nvme_core rtsx_pci i2c_hid 
i2c_algo_bit iosf_mbi drm_kms_helper video ahci syscopyarea sysfillrect 
sysimgblt fb_sys_fops libahci drm libata drm_panel_orientation_quirks 
dm_mirror
[  324.902233]  dm_region_hash dm_log dm_mod
[  324.902237] CPU: 0 PID: 18693 Comm: dbus-launch Kdump: loaded 
Tainted: G        W      ------------ 
3.10.0-957.1.3.el7.fanotify.x86_64 #1
[  324.902239] Hardware name: Dell Inc. XPS 13 9350/0YT4WT, BIOS 1.7.0 
01/16/2018
[  324.902241] Call Trace:
[  324.902247]  [<ffffffffa8961e41>] dump_stack+0x19/0x1b
[  324.902251]  [<ffffffffa8297648>] __warn+0xd8/0x100
[  324.902254]  [<ffffffffa82976cf>] warn_slowpath_fmt+0x5f/0x80
[  324.902258]  [<ffffffffa83df5b7>] ? 
anon_vma_interval_tree_insert+0x97/0xa0
[  324.902261]  [<ffffffffa83f6557>] ? anon_vma_chain_link+0x37/0x40
[  324.902265]  [<ffffffffa8594c5a>] __list_add+0x8a/0xc0
[  324.902269]  [<ffffffffa83f654a>] anon_vma_chain_link+0x2a/0x40
[  324.902273]  [<ffffffffa83f8909>] anon_vma_fork+0xe9/0x130
[  324.902277]  [<ffffffffa82947f3>] dup_mm+0x473/0x750
[  324.902281]  [<ffffffffa8295f52>] copy_process+0x1452/0x1a40
[  324.902285]  [<ffffffffa82966f1>] do_fork+0x91/0x320
[  324.902289]  [<ffffffffa8296a06>] SyS_clone+0x16/0x20
[  324.902293]  [<ffffffffa89751a4>] stub_clone+0x44/0x70
[  324.902297]  [<ffffffffa8974ddb>] ? system_call_fastpath+0x22/0x27
[  324.902300] ---[ end trace e834a395da6ce850 ]---
[  324.902316] BUG: unable to handle kernel paging request at 
00007f96c05d8000
[  324.902319] IP: [<ffffffffa841bf64>] kmem_cache_alloc+0x74/0x1f0
[  324.902325] PGD 8000000143adc067 PUD 1493c1067 PMD 14386a067 PTE 
8000000132ff2865
[  324.902330] Oops: 0001 [#1] SMP
[  324.902333] Modules linked in: cmac ccm xt_CHECKSUM iptable_mangle 
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT 
nf_reject_ipv4 tun bridge stp llc devlink ebtable_filter ebtables 
ip6table_filter ip6_tables iptable_filter bnep hid_multitouch iTCO_wdt 
iTCO_vendor_support intel_wmi_thunderbolt dell_wmi arc4 iwlmvm 
intel_pmc_core intel_powerclamp coretemp intel_rapl mac80211 kvm_intel 
vfat fat dell_laptop kvm snd_hda_codec_hdmi dell_smbios 
dell_wmi_descriptor dcdbas dell_led irqbypass snd_hda_codec_realtek 
snd_soc_skl snd_hda_codec_generic snd_soc_skl_ipc snd_hda_ext_core 
snd_soc_sst_dsp iwlwifi snd_soc_sst_ipc snd_soc_acpi snd_soc_core 
snd_compress snd_hda_intel snd_hda_codec joydev snd_hda_core snd_hwdep 
snd_seq
[  324.902376]  snd_seq_device pcspkr snd_pcm rtsx_pci_ms memstick 
uvcvideo cfg80211 videobuf2_vmalloc snd_timer videobuf2_memops 
videobuf2_core snd videodev soundcore i2c_i801 btusb btrtl btbcm btintel 
bluetooth rfkill idma64 virt_dma i2c_designware_platform 
i2c_designware_core wmi pinctrl_sunrisepoint pinctrl_intel intel_hid 
sparse_keymap int3400_thermal acpi_pad mei_me mei binfmt_misc 
auth_rpcgss sunrpc ip_tables xfs libcrc32c dm_crypt drbg ansi_cprng 
rtsx_pci_sdmmc mmc_core crct10dif_pclmul crct10dif_common crc32_pclmul 
crc32c_intel i915 ghash_clmulni_intel aesni_intel lrw gf128mul 
glue_helper ablk_helper cryptd serio_raw nvme nvme_core rtsx_pci i2c_hid 
i2c_algo_bit iosf_mbi drm_kms_helper video ahci syscopyarea sysfillrect 
sysimgblt fb_sys_fops libahci drm libata drm_panel_orientation_quirks 
dm_mirror
[  324.902423]  dm_region_hash dm_log dm_mod
[  324.902428] CPU: 0 PID: 18693 Comm: dbus-launch Kdump: loaded 
Tainted: G        W      ------------ 
3.10.0-957.1.3.el7.fanotify.x86_64 #1
[  324.902430] Hardware name: Dell Inc. XPS 13 9350/0YT4WT, BIOS 1.7.0 
01/16/2018
[  324.902433] task: ffff8a8c3108c100 ti: ffff8a8d3e4a0000 task.ti: 
ffff8a8d3e4a0000
[  324.902435] RIP: 0010:[<ffffffffa841bf64>]  [<ffffffffa841bf64>] 
kmem_cache_alloc+0x74/0x1f0
[  324.902441] RSP: 0018:ffff8a8d3e4a3d30  EFLAGS: 00010282
[  324.902443] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
00000000000bd1d1
[  324.902445] RDX: 00000000000bd1d0 RSI: 00000000000000d0 RDI: 
ffff8a8d7a001b00
[  324.902447] RBP: ffff8a8d3e4a3d60 R08: 000000000001f0a0 R09: 
ffffffffa83f88c3
[  324.902450] R10: ffff8a8d43b29af8 R11: ffff8a8d3e4a396e R12: 
00007f96c05d8000
[  324.902452] R13: 00000000000000d0 R14: ffff8a8d7a001b00 R15: 
ffff8a8d7a001b00
[  324.902455] FS:  00007f96c3eb6880(0000) GS:ffff8a8d7ec00000(0000) 
knlGS:0000000000000000
[  324.902458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  324.902460] CR2: 00007f96c05d8000 CR3: 000000014389a000 CR4: 
00000000003607f0
[  324.902463] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  324.902465] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  324.902467] Call Trace:
[  324.902472]  [<ffffffffa83f88c3>] ? anon_vma_fork+0xa3/0x130
[  324.902476]  [<ffffffffa83f88c3>] anon_vma_fork+0xa3/0x130
[  324.902480]  [<ffffffffa82947f3>] dup_mm+0x473/0x750
[  324.902484]  [<ffffffffa8295f52>] copy_process+0x1452/0x1a40
[  324.902488]  [<ffffffffa82966f1>] do_fork+0x91/0x320
[  324.902492]  [<ffffffffa8296a06>] SyS_clone+0x16/0x20
[  324.902497]  [<ffffffffa89751a4>] stub_clone+0x44/0x70
[  324.902500]  [<ffffffffa8974ddb>] ? system_call_fastpath+0x22/0x27
[  324.902503] Code: 52 bf 57 49 8b 50 08 4d 8b 20 49 8b 40 10 4d 85 e4 
0f 84 28 01 00 00 48 85 c0 0f 84 1f 01 00 00 49 63 46 20 48 8d 4a 01 4d 
8b 06 <49> 8b 1c 04 4c 89 e0 65 49 0f c7 08 0f 94 c0 84 c0 74 ba 49 63
[  324.902545] RIP  [<ffffffffa841bf64>] kmem_cache_alloc+0x74/0x1f0
[  324.902549]  RSP <ffff8a8d3e4a3d30>
[  324.902551] CR2: 00007f96c05d8000


-- 
Orion Poplawski
Manager of NWRA Technical Systems          720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/
