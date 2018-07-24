Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134AAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF3F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF3F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbeGXQTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:19:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:34186 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbeGXQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:19:07 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6OFBWeU088805;
        Wed, 25 Jul 2018 00:11:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Wed, 25 Jul 2018 00:11:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6OFBVk8088801
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 25 Jul 2018 00:11:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH v3 5/8] proc/kcore: hold lock during read
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
References: <cover.1531953780.git.osandov@fb.com>
 <d7cfbc1e8a76616f3b699eaff9df0a2730380534.1531953780.git.osandov@fb.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <7f905293-5c30-f001-987f-03caf8f36737@I-love.SAKURA.ne.jp>
Date:   Wed, 25 Jul 2018 00:11:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d7cfbc1e8a76616f3b699eaff9df0a2730380534.1531953780.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/19 7:58, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Now that we're using an rwsem, we can hold it during the entirety of
> read_kcore() and have a common return path. This is preparation for the
> next change.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/proc/kcore.c | 70 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 95aa988c5b5d..e317ac890871 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -440,19 +440,18 @@ static ssize_t
>  read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  {
>  	char *buf = file->private_data;
> -	ssize_t acc = 0;
>  	size_t size, tsz;
>  	size_t elf_buflen;
>  	int nphdr;
>  	unsigned long start;
> +	size_t orig_buflen = buflen;
> +	int ret = 0;
>  
>  	down_read(&kclist_lock);

(...snipped...)

> +out:
> +	up_write(&kclist_lock);

Oops. This needs to be up_read().

> +	if (ret)
> +		return ret;
> +	return orig_buflen - buflen;
>  }
>  
[   43.508922] ------------[ cut here ]------------
[   43.509931] DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
[   43.509940] WARNING: CPU: 0 PID: 7933 at kernel/locking/rwsem.c:133 up_write+0x75/0x80
[   43.512792] Modules linked in: pcspkr sg vmw_vmci i2c_piix4 sd_mod ata_generic pata_acpi vmwgfx drm_kms_helper syscopyarea ahci sysfillrect libahci sysimgblt fb_sys_fops mptspi ata_piix ttm scsi_transport_spi mptscsih drm e1000 mptbase libata i2c_core serio_raw ipv6 crc_ccitt
[   43.517692] CPU: 0 PID: 7933 Comm: kexec Not tainted 4.18.0-rc6-next-20180724+ #715
[   43.519237] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[   43.521498] RIP: 0010:up_write+0x75/0x80
[   43.522391] Code: 00 5b c3 e8 0d 03 3a 00 85 c0 74 d9 83 3d 6a e4 10 02 00 75 d0 48 c7 c6 c8 2f e0 81 48 c7 c7 a3 e3 de 81 31 c0 e8 fb 8d fa ff <0f> 0b eb b7 0f 1f 80 00 00 00 00 8b 05 42 3e 06 02 53 48 89 fb 85
[   43.526253] RSP: 0018:ffffc90007ec7bc8 EFLAGS: 00010282
[   43.527303] RAX: 0000000000000000 RBX: ffffffff8207b5e0 RCX: 0000000000000006
[   43.528874] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88013ba15b70
[   43.530496] RBP: ffffc90007ec7e28 R08: 0000000000000000 R09: 0000000000000001
[   43.532007] R10: 0000000000000000 R11: 292928746e657272 R12: ffffffff8207b660
[   43.533448] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000e000
[   43.534969] FS:  00007fdd6e0c0740(0000) GS:ffff88013ba00000(0000) knlGS:0000000000000000
[   43.536623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.537943] CR2: 00000000017dc000 CR3: 00000001376b5006 CR4: 00000000001606f0
[   43.539608] Call Trace:
[   43.540154]  read_kcore+0x81/0x630
[   43.540932]  proc_reg_read+0x34/0x60
[   43.541722]  __vfs_read+0x2e/0x160
[   43.542450]  vfs_read+0x84/0x130
[   43.543166]  ksys_read+0x50/0xc0
[   43.543856]  do_syscall_64+0x4f/0x1f0
[   43.544684]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   43.545909] RIP: 0033:0x7fdd6d798c70
[   43.546688] Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 07 b9 09 00 e8 52 8a 02 00 66 90 83 3d 2d c3 2d 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e cc 01 00 48 89 04 24
[   43.550607] RSP: 002b:00007fffe5207428 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   43.552192] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdd6d798c70
[   43.553711] RDX: 0000000000010000 RSI: 00000000017cd840 RDI: 0000000000000004
[   43.555240] RBP: 0000000000010000 R08: 0000000000000001 R09: 0000000000010000
[   43.556779] R10: 0000000000000079 R11: 0000000000000246 R12: 0000000000000004
[   43.558284] R13: 00000000017cd840 R14: 00007fffe52074d8 R15: 00007fffe52076c0
[   43.559809] irq event stamp: 25471
[   43.560597] hardirqs last  enabled at (25471): [<ffffffff81800966>] restore_regs_and_return_to_kernel+0x0/0x2a
[   43.562821] hardirqs last disabled at (25470): [<ffffffff81800fa6>] error_exit+0x6/0x20
[   43.564515] softirqs last  enabled at (24962): [<ffffffff81a001db>] __do_softirq+0x1db/0x48e
[   43.566308] softirqs last disabled at (24955): [<ffffffff8107197d>] irq_exit+0xcd/0xe0
[   43.567982] ---[ end trace 0140237dd1b1be70 ]---

