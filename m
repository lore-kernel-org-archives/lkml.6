Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeDRIXY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:23:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39973 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeDRIXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:23:23 -0400
Date: Wed, 18 Apr 2018 10:23:19 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Alexander Popov <alex.popov@linux.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, sil2review@lists.osadl.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/1] i2c: dev: check i2c_msg len before memdup_user() to
 prevent ZERO_SIZE_PTR deref
Message-ID: <20180418082319.wxxhwxwhblwh6llo@pengutronix.de>
References: <1524010605-21552-1-git-send-email-alex.popov@linux.com>
 <20180418070704.35zj5chpdkirnmdt@pengutronix.de>
 <92f44b44-a5a1-c844-4d96-db0697b2e090@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92f44b44-a5a1-c844-4d96-db0697b2e090@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 10:56:03AM +0300, Alexander Popov wrote:
> On 18.04.2018 10:07, Uwe Kleine-König wrote:
> > Hello,
> 
> Hello Uwe,
> 
> Thanks for your reply.
> 
> > On Wed, Apr 18, 2018 at 03:16:45AM +0300, Alexander Popov wrote:
> >> Currently i2cdev_ioctl_rdwr() doesn't check i2c_msg len against zero
> >> before calling memdup_user(). If this len is zero memdup_user() returns
> >> ZERO_SIZE_PTR, which is later considered as valid since
> >> IS_ERR(ZERO_SIZE_PTR) is false. That causes ZERO_SIZE_PTR deref oops.
> > 
> > You're saying that
> > 
> > 	memdup_user(ptr, 0)
> > 
> > reads from *ptr? I'd say this is a bug in memdup_user, not its user.
> 
> No, I don't say that.
> 
> memdup_user(ptr, 0) returns ZERO_SIZE_PTR, which is later considered as valid
> since IS_ERR(ZERO_SIZE_PTR) is false:
> 
> 	msgs[i].buf = memdup_user(data_ptrs[i], msgs[i].len);
> 	if (IS_ERR(msgs[i].buf)) {
> 		res = PTR_ERR(msgs[i].buf);
> 		break;
> 	}
> 
> That causes ZERO_SIZE_PTR deref oops after that:
> 
> root@syzkaller:~# ./repro
> [   22.015442] kasan: CONFIG_KASAN_INLINE enabled
> [   22.066965] kasan: GPF could be caused by NULL-ptr deref or user memory access
> [   22.068624] general protection fault: 0000 [#1] SMP KASAN
> [   22.069705] Dumping ftrace buffer:
> [   22.070399]    (ftrace buffer empty)
> [   22.071033] Modules linked in:
> [   22.071562] CPU: 0 PID: 3899 Comm: repro.exe Not tainted 4.17.0-rc1 #2
> [   22.072632] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [   22.074219] RIP: 0010:i2cdev_ioctl_rdwr+0x12b/0x7b0
> [   22.075023] RSP: 0018:ffff880061f3fa68 EFLAGS: 00010346
> [   22.075877] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000000
> [   22.076973] RDX: 0000000000000000 RSI: 0000000020000000 RDI: ffff88006a2e9542
> [   22.078086] RBP: ffff880061f3fac0 R08: 0000000000000000 R09: ffff880060b44780
> [   22.079166] R10: 1ffff1000c3e7f1d R11: 0000000000000000 R12: dffffc0000000000
> [   22.080251] R13: ffff88006a2e9540 R14: 0000000000000010 R15: 0000000000000001
> [   22.081339] FS:  00000000020bc880(0000) GS:ffff88006ba00000(0000)
> knlGS:0000000000000000
> [   22.082615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.083526] CR2: 00000000200002c3 CR3: 000000006724a000 CR4: 00000000000006f0
> [   22.084631] Call Trace:
> [   22.085501]  ? i2cdev_ioctl_rdwr+0xf/0x7b0
> [   22.086865]  i2cdev_ioctl+0x4ec/0x940
> [   22.088677]  ? kasan_check_read+0x11/0x20
> [   22.090555]  ? i2cdev_ioctl_smbus+0x6a0/0x6a0
> [   22.091862]  ? do_raw_spin_trylock+0x1e0/0x1e0
> [   22.092428]  ? kasan_check_write+0x14/0x20
> [   22.092946]  ? trace_hardirqs_off+0xd/0x10
> [   22.093451]  ? _raw_spin_unlock_irqrestore+0xa6/0xe0
> [   22.094013]  ? debug_check_no_obj_freed+0x341/0x7eb
> [   22.094547]  ? i2cdev_ioctl_smbus+0x6a0/0x6a0
> [   22.095086]  do_vfs_ioctl+0x1cd/0x17b0
> [   22.095482]  ? kasan_check_read+0x11/0x20
> [   22.095978]  ? rcu_is_watching+0x7b/0x150
> [   22.096428]  ? ioctl_preallocate+0x350/0x350
> [   22.096908]  ? __fget_light+0x2fc/0x4c0
> [   22.097351]  ? fget_raw+0x20/0x20
> [   22.097721]  ? kmem_cache_free+0x31c/0x450
> [   22.098164]  ? putname+0xfa/0x150
> [   22.098511]  ? do_sys_open+0x31c/0x710
> [   22.099792]  ? security_file_ioctl+0x8c/0xc0
> [   22.102080]  ksys_ioctl+0x94/0xb0
> [   22.103204]  __x64_sys_ioctl+0x7c/0xd0
> [   22.103643]  do_syscall_64+0x193/0x920
> [   22.104186]  ? trace_event_raw_event_sys_exit+0x2e0/0x2e0
> [   22.105061]  ? syscall_return_slowpath+0x6a0/0x6a0
> [   22.106717]  ? syscall_return_slowpath+0x2de/0x6a0
> [   22.108183]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
> [   22.109597]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [   22.110167]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   22.110735] RIP: 0033:0x44df89
> [   22.111077] RSP: 002b:00007fff7fb01ca8 EFLAGS: 00000213 ORIG_RAX:
> 0000000000000010
> [   22.111932] RAX: ffffffffffffffda RBX: 0000000000400418 RCX: 000000000044df89
> [   22.112958] RDX: 0000000020000080 RSI: 0000000000000707 RDI: 0000000000000003
> [   22.114078] RBP: 00007fff7fb01cc0 R08: 0000000000000000 R09: 0000000000401af0
> [   22.115784] R10: 000000000000ffff R11: 0000000000000213 R12: 0000000000401b90
> [   22.116870] R13: 0000000000000000 R14: 00000000006bd018 R15: 0000000000000000
> [   22.117953] Code: 00 e8 7a 53 bd fb 41 83 e7 01 0f 84 e8 03 00 00 e8 6b 53 bd
> fb 4d 85 f6 0f 84 12 06 00 00 4c 89 f0 4c 89 f1 48 c1 e8 03 83 e1 07 <42> 0f b6
> 04 20 38 c8 7f 08 84 c0 0f 85 e7 05 00 00 45 0f b6 36
> [   22.120532] RIP: i2cdev_ioctl_rdwr+0x12b/0x7b0 RSP: ffff880061f3fa68
> [   22.121290] ---[ end trace b365c176b1d95614 ]---
> 
> 
> > If however the problem only happens later in
> > 
> > 	if (msgs[i].flags & I2C_M_RECV_LEN) {
> > 		if (!(msgs[i].flags & I2C_M_RD) || msgs[i].buf[0] < 1 || ...)
> 
> Yes, that's true. I think I should make the commit message more verbose. I'll
> come with v2.
> 
> > Your commit log is wrong (and I think the patch, too).
> 
> I believe this bug is not a memdup_user() issue. There is a nice selection from
> LKML discussions about ZERO_SIZE_PTR, which convinces me:
> http://yarchive.net/comp/linux/malloc_0.html

Ack, no memdup_user problem. i2cdev_ioctl_rdwr() should not access
msgs[i].buf[0] if msgs[i].len is 0.

But you should not prohibit i2c transfers with length 0 in general.

So a better patch is the following:


diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 036a03f0d0a6..0137538c36a0 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -280,6 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		 */
 		if (msgs[i].flags & I2C_M_RECV_LEN) {
 			if (!(msgs[i].flags & I2C_M_RD) ||
+			    msgs[i].len < 1 ||
 			    msgs[i].buf[0] < 1 ||
 			    msgs[i].len < msgs[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {

But having said that and after reading the comment above the if, I'm not
sure this is enough. 

Best regards
Uwe



-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
