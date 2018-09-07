Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AF72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AAcAxbnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AF72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeIGVhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:37:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIGVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:37:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w87GmwAY031818;
        Fri, 7 Sep 2018 16:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=N/AOTabMwj96ebOngMF8GMg/j4NA9aRnNvfQN8J90cg=;
 b=AAcAxbnzkDwN40wKf28OTmcG4W9gEmupbF+pEQItgxAbkerPPBRp1YELJE3c2fSMhain
 laxDU1ZyLYRPEFghPsgpgr9vlBsJ8970iurBxvuQdJTNNv10uIOXOdr8UOAMc0GldhMv
 xbGkFeE735lceM8lrcRbKrPCCPWycZUW5LH5GasFDLWCvOFgxSA9RV75xJAfamrCQ3oV
 bXcMLsEjwyHsVsu8uVTRYRUcy5WioLhA4m6Ja75No3OOxPm6C36GRcKtCMFw7Wkdq+rB
 3LZUGQqbTwDQLHFSKcdBlClSzj8JHxvyGwnQGmYGUiurAnip3NUdEGHflVvfxFriBvFq WQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m7j6u3s0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Sep 2018 16:55:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w87GtInx029917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Sep 2018 16:55:18 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w87GtHVv000624;
        Fri, 7 Sep 2018 16:55:18 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Sep 2018 16:55:17 +0000
Subject: Re: [PATCH v4] xen: avoid crash in disable_hotplug_cpu
To:     Olaf Hering <olaf@aepfle.de>, xen-devel@lists.xenproject.org
Cc:     Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180907143135.29608-1-olaf@aepfle.de>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <4f623671-e1aa-1804-449c-a26b0c4b9ce9@oracle.com>
Date:   Fri, 7 Sep 2018 12:56:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907143135.29608-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9009 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809070168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 10:31 AM, Olaf Hering wrote:
> The command 'xl vcpu-set 0 0', issued in dom0, will crash dom0:
>
> BUG: unable to handle kernel NULL pointer dereference at 00000000000002d8
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 PID: 65 Comm: xenwatch Not tainted 4.19.0-rc2-1.ga9462db-default #1 openSUSE Tumbleweed (unreleased)
> Hardware name: Intel Corporation S5520UR/S5520UR, BIOS S5500.86B.01.00.0050.050620101605 05/06/2010
> RIP: e030:device_offline+0x9/0xb0
> Code: 77 24 00 e9 ce fe ff ff 48 8b 13 e9 68 ff ff ff 48 8b 13 e9 29 ff ff ff 48 8b 13 e9 ea fe ff ff 90 66 66 66 66 90 41 54 55 53 <f6> 87 d8 02 00 00 01 0f 85 88 00 00 00 48 c7 c2 20 09 60 81 31 f6
> RSP: e02b:ffffc90040f27e80 EFLAGS: 00010203
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8801f3800000 RSI: ffffc90040f27e70 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff820e47b3 R09: 0000000000000000
> R10: 0000000000007ff0 R11: 0000000000000000 R12: ffffffff822e6d30
> R13: dead000000000200 R14: dead000000000100 R15: ffffffff8158b4e0
> FS:  00007ffa595158c0(0000) GS:ffff8801f39c0000(0000) knlGS:0000000000000000
> CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000002d8 CR3: 00000001d9602000 CR4: 0000000000002660
> Call Trace:
>  handle_vcpu_hotplug_event+0xb5/0xc0
>  xenwatch_thread+0x80/0x140
>  ? wait_woken+0x80/0x80
>  kthread+0x112/0x130
>  ? kthread_create_worker_on_cpu+0x40/0x40
>  ret_from_fork+0x3a/0x50
>
> This happens because handle_vcpu_hotplug_event is called twice. In the
> first iteration cpu_present is still true, in the second iteration
> cpu_present is false which causes get_cpu_device to return NULL.
> In case of cpu#0, cpu_online is apparently always true.
>
> Fix this crash by checking if the cpu can be hotplugged, which is false
> for a cpu that was just removed.
>
> Also check if the cpu was actually offlined by device_remove, otherwise
> leave the cpu_present state as it is.
>
> Rearrange to code to do all work with device_hotplug_lock held.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  drivers/xen/cpu_hotplug.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
> index d4265c8ebb22..b1357aa4bc55 100644
> --- a/drivers/xen/cpu_hotplug.c
> +++ b/drivers/xen/cpu_hotplug.c
> @@ -19,15 +19,16 @@ static void enable_hotplug_cpu(int cpu)
>  
>  static void disable_hotplug_cpu(int cpu)
>  {
> -	if (cpu_online(cpu)) {
> -		lock_device_hotplug();
> +	if (!cpu_is_hotpluggable(cpu))
> +		return;
> +	lock_device_hotplug();
> +	if (cpu_online(cpu))
>  		device_offline(get_cpu_device(cpu));
> -		unlock_device_hotplug();
> -	}
> -	if (cpu_present(cpu))
> +	if (!cpu_online(cpu) && cpu_present(cpu)) {
>  		xen_arch_unregister_cpu(cpu);
> -
> -	set_cpu_present(cpu, false);
> +		set_cpu_present(cpu, false);
> +	}
> +	unlock_device_hotplug();
>  }
>  
>  static int vcpu_online(unsigned int cpu)


I was hoping you'd respond to my question about warning.

root@haswell> xl vcpu-set 3 0


and in the guest

[root@vm-0238 ~]# [   32.866955] ------------[ cut here ]------------
[   32.866963] spinlock on CPU0 exists on IRQ1!
[   32.866984] WARNING: CPU: 0 PID: 14 at arch/x86/xen/spinlock.c:90
xen_init_lock_cpu+0xbf/0xd0
[   32.866990] Modules linked in:
[   32.866995] CPU: 0 PID: 14 Comm: cpuhp/0 Not tainted 4.19.0-rc2 #31
[   32.867001] RIP: e030:xen_init_lock_cpu+0xbf/0xd0
[   32.867005] Code: 4a 8b 0c e5 00 c7 14 82 48 c7 c2 90 4f 01 00 4c 89
2c 11 e9 85 00 00 00 8b 14 02 44 89 e6 48 c7 c7 a0 0f 08 82 e8 ab e3 05
00 <0f> 0b e9 7a ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 80 3d 59 02 20
[   32.867015] RSP: e02b:ffffc900401ffe40 EFLAGS: 00010286
[   32.867019] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000006
[   32.867024] RDX: 0000000000000007 RSI: 0000000000000001 RDI:
ffff88003d8168b0
[   32.867039] RBP: 0000000000014f98 R08: ffffffff81eb04a0 R09:
0000000000007f9b
[   32.867045] R10: 0000000000000065 R11: ffffffff82a9b7cd R12:
0000000000000000
[   32.867050] R13: ffffffff8101a820 R14: ffff88003d401280 R15:
ffffffff810aec10
[   32.867061] FS:  0000000000000000(0000) GS:ffff88003d800000(0000)
knlGS:0000000000000000
[   32.867066] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.867081] CR2: 00005569b64e72b8 CR3: 000000002e902000 CR4:
0000000000042660
[   32.867089] Call Trace:
[   32.867096]  ? cstate_cleanup+0x47/0x47
[   32.867101]  xen_cpu_up_online+0xa/0x10
[   32.867107]  cpuhp_invoke_callback+0x8d/0x500
[   32.867113]  ? sort_range+0x20/0x20
[   32.867117]  cpuhp_thread_fun+0xb0/0x110
[   32.867121]  smpboot_thread_fn+0xc5/0x160
[   32.867126]  kthread+0x112/0x130
[   32.867131]  ? kthread_bind+0x30/0x30
[   32.867136]  ret_from_fork+0x35/0x40
[   32.867141] ---[ end trace 15d4d7112a1b1cea ]---
[   32.867148] genirq: Flags mismatch irq 1. 0002cc00 (spinlock0) vs.
0002cc00 (spinlock0)
[   32.867154] CPU: 0 PID: 14 Comm: cpuhp/0 Tainted: G        W        
4.19.0-rc2 #31
[   32.867160] Call Trace:
[   32.867165]  dump_stack+0x5c/0x80
[   32.867171]  __setup_irq.cold.51+0x4e/0x9e
[   32.867177]  request_threaded_irq+0xf5/0x160
[   32.867182]  ? xen_qlock_wait+0x40/0x40
[   32.867188]  bind_ipi_to_irqhandler+0xae/0x1d0
[   32.867194]  ? sort_range+0x20/0x20
[   32.867198]  xen_init_lock_cpu+0x74/0xd0
[   32.867202]  ? cstate_cleanup+0x47/0x47
[   32.867206]  xen_cpu_up_online+0xa/0x10
[   32.867210]  cpuhp_invoke_callback+0x8d/0x500
[   32.867215]  ? sort_range+0x20/0x20
[   32.867219]  cpuhp_thread_fun+0xb0/0x110
[   32.867223]  smpboot_thread_fn+0xc5/0x160
[   32.867227]  kthread+0x112/0x130
[   32.867231]  ? kthread_bind+0x30/0x30
[   32.867235]  ret_from_fork+0x35/0x40
[   32.867249] cpu 0 spinlock event irq -16
[   32.880877] IRQ 16: no longer affine to CPU1
[   32.880879] IRQ 17: no longer affine to CPU1
[   32.880881] IRQ 18: no longer affine to CPU1
[   32.880882] IRQ 19: no longer affine to CPU1
[   32.880884] IRQ 20: no longer affine to CPU1
[   32.880885] IRQ 21: no longer affine to CPU1
[   32.880886] IRQ 22: no longer affine to CPU1
[   32.880888] IRQ 23: no longer affine to CPU1
[   32.880889] IRQ 24: no longer affine to CPU1
[   32.882202] smpboot: CPU 1 is now offline

