Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbeBMBla (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:41:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55508 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeBMBl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:41:29 -0500
Subject: Re: [PATCH RESENT] nvme-pci: suspend queues based on online_queues
To: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1518440713-1031-1-git-send-email-jianchao.w.wang@oracle.com>
 <5011398b-8797-ece6-9df0-436c32aed33e@grimberg.me>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <fa4de9a1-5d2a-0bca-d234-fcf2e01e5abb@oracle.com>
Date: Tue, 13 Feb 2018 09:41:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5011398b-8797-ece6-9df0-436c32aed33e@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130016
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi

Thanks for your kindly response.

On 02/13/2018 02:37 AM, Sagi Grimberg wrote:
> 
>> nvme cq irq is freed based on queue_count. When the sq/cq creation
>> fails, irq will not be setup. free_irq will warn 'Try to free
>> already-free irq'.
>>
>> To fix it, we only increase online_queues when adminq/sq/cq are
>> created and associated irq is setup. Then suspend queues based
>> on online_queues.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> 
> Can I get a review for this?
> 
Here is the log

[ 2269.936597] nvme nvme0: Removing after probe failure status: -4
[ 2269.961238] ------------[ cut here ]------------
[ 2269.961279] Trying to free already-free IRQ 131
[ 2269.961299] WARNING: CPU: 2 PID: 134 at /home/will/u04/source_code/linux-block/kernel/irq/manage.c:1546 __free_irq+0xa6/0x2a0
[ 2269.961302] Modules linked in: nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_realtek intel_rapl x86_pkg_temp_thermal snd_hda_codec_generic intel_powerclamp coretemp kvm_intel snd_hda_intel kvm snd_hda_codec snd_hda_core snd_hwdep snd_pcm irqbypass snd_seq_midi snd_seq_midi_event crct10dif_pclmul crc32_pclmul input_leds ghash_clmulni_intel pcbc snd_rawmidi snd_seq aesni_intel aes_x86_64 crypto_simd snd_seq_device glue_helper snd_timer cryptd snd intel_cstate soundcore intel_rapl_perf mei_me wmi_bmof intel_wmi_thunderbolt acpi_pad tpm_crb shpchp mei mac_hid ib_iser rdma_cm iw_cm ib_cm ib_core parport_pc ppdev lp parport autofs4 i915 i2c_algo_bit drm_kms_helper hid_generic syscopyarea sysfillrect sysimgblt usbhid fb_sys_fops drm hid e1000e ptp ahci pps_core libahci wmi video
[ 2269.961525] CPU: 2 PID: 134 Comm: kworker/u16:2 Not tainted 4.15.0-rc9+ #68
[ 2269.961529] Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
[ 2269.961537] Workqueue: nvme-reset-wq nvme_reset_work
[ 2269.961548] RIP: 0010:__free_irq+0xa6/0x2a0
[ 2269.961552] RSP: 0018:ffffc14d8240fc10 EFLAGS: 00010086
[ 2269.961559] RAX: 0000000000000000 RBX: 0000000000000083 RCX: 0000000000000000
[ 2269.961563] RDX: 0000000000000002 RSI: ffffffffb56dd5e1 RDI: 0000000000000001
[ 2269.961567] RBP: ffff9cd03aed04d0 R08: 0000000000000001 R09: 0000000000000000
[ 2269.961570] R10: ffffc14d8240fb88 R11: ffffffffb46f7b64 R12: 0000000000000083
[ 2269.961574] R13: ffff9cd0626ab5d8 R14: ffff9cd0626ab4a8 R15: ffff9cd0626ab400
[ 2269.961578] FS:  0000000000000000(0000) GS:ffff9cd0a2c80000(0000) knlGS:0000000000000000
[ 2269.961582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2269.961586] CR2: 0000000001e7b9a0 CR3: 000000020ae0f005 CR4: 00000000003606e0
[ 2269.961590] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2269.961594] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2269.961597] Call Trace:
[ 2269.961616]  free_irq+0x30/0x60
[ 2269.961624]  pci_free_irq+0x18/0x30
[ 2269.961630]  nvme_dev_disable+0x35b/0x4f0
[ 2269.961639]  ? __nvme_submit_sync_cmd+0xa2/0xd0
[ 2269.961651]  ? dev_warn+0x64/0x80
[ 2269.961670]  nvme_reset_work+0x198/nvme-pci: fixes on nvme_timeout and nvme_dev_disable patchset0x15d0
[ 2269.961715]  process_one_work+0x1e9/0x6f0
[ 2269.961732]  worker_thread+0x4a/0x430
[ 2269.961749]  kthread+0x100/0x140
[ 2269.961757]  ? process_one_work+0x6f0/0x6f0
[ 2269.961763]  ? kthread_delayed_work_timer_fn+0x80/0x80
[ 2269.961773]  ? kthread_delayed_work_timer_fn+0x80/0x80
[ 2269.961781]  ret_from_fork+0x24/0x30


After this patch, I've never seen this again.
On the other hand, even though it was seen with my nvme-pci: fixes on nvme_timeout and nvme_dev_disable patchset,
but this issue should also exist on current source code.

Because the Chinese Spring Festival Vacation is coming and looks like some more talking is still need on the patchset
of nvme-pci: fixes on nvme_timeout and nvme_dev_disable. So I send out some of the relatively independent patches of
that patchset, including this one.

Sincerely
Jianchao 

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=YBEprmLALFZHeJ5S3c_TM8FQwXgZhi2GaUYn3i4T7DA&s=pN0FrPI10CfrgET0crnpV8EJs8sHN5MKaB7fZ6OWGHQ&e=
> 
