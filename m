Return-Path: <hamishm@alliedtelesis.co.nz>
X-Google-Smtp-Source: AB8JxZqpROOobnTWEL+D5j0iAkC00dy59DgH8G7fsLh1TN32dJD/FWXBEqdkL93EmWdnWkdqmvRG
ARC-Seal: i=1; a=rsa-sha256; t=1526001237; cv=none;
        d=google.com; s=arc-20160816;
        b=mHuFuUHj4BoCcsnn5QzRY9qvFtmxJQqIvmZjIbBcrmNEQ9c4VMcfCry0FKHPMNJFzE
         bbXRuSIzsxKKMxOiH6sSPqysXi1yNv9VSZoGL1hqFtR/ta9Zb3OtFaKz7UcFRq1ppdqh
         y+JC8ilEfTjbXKptr9pYPz2mXwPuD+3kAZUeLbbYkxeefCHa4JP3CFt2bL3RnMe/z18C
         5RwlGzL0/qXxBE593HsXgewFFEUkGBjKbKRpVjKoSykzJhuLtDG86wyfCPLx/boBJ8sv
         ycQqX7Xes0cGV0RMTXPPrKBOcULra1w6gGvlUZUvlOI5EIFGwTV4zgVGxozd66bYlD/8
         wqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=/chGaxTZ+N5QKGfwgG7rsBnR2Ueobs60uoHITzXEUcg=;
        b=w1p2tuyq1QAijuvzGKpAI8skbXDmeFZM3nc70dkezE9pPlkrU/7v84u+yY+JVoTMvb
         v+sqqzERdpXfZs/Q2YvCS628gEBV6o9VKRdO3kMX8YWAgibsZrLfGQwElsnP35arDjut
         tDfOfI8+HH/6OJdehak+Kx+JrxjQ/KdqQYbf4XllLXAcS4kf1DGAM7/iAomfTMNzUMEk
         ukVobkJ8YdiDa7FeazKcgbIEVXU7a/bLmnNpJbYikxWXDxbQvW7xyhu+Gn8pgEoJc+ay
         H3KRwBRVdEUSWZMkjmmphCDx63MemLos+VqMn849w19CYip94ddy30hx071oxF2mqsKw
         ehHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=NeB0yW6Y;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 202.36.163.20 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
Authentication-Results: mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=NeB0yW6Y;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 202.36.163.20 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH 0/2] Prevent kernel oops on UIO device remove with open fds
Date: Fri, 11 May 2018 13:11:03 +1200
Message-Id: <20180511011105.12193-1-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600128273339436018?=
X-GMAIL-MSGID: =?utf-8?q?1600128273339436018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If a UIO device is removed while a user space app has an open file 
descriptor to that device's /dev/uio* file, a kernel oops can occur when
the file descriptor is ultimately closed. The oops is triggered by
dereferencing either the uio_listener struct's 'dev' pointer, or at the
next level, when dereferencing a stale 'info' pointer on that dev.

To resolve this we now increment the reference count for the uio_device
and prevent the destruction of the uio_device until all open file
descriptors are closed.
A further consequence of resolving the stale pointers to the uio_device
is that it exposes an issue with the independent life cycles of the 
uio_device and its related uio_info. The uio_info struct is allocated by
the user of the uio subsystem and connected to a uio_device at 
registration time (see __uio_register_device()). When the device
corresponding to that uio_info is unregistered and the memory for the 
uio_info is freed, the uio_device is left with a stale pointer which may
still be used in the file system ops (uio_poll(), uio_read(), etc)
To resolve this second issue, we now lock alteration or access of the
'info' member of the uio_device struct and alter the accessing code to 
handle that pointer being null.

This patch series contains two patches. The first is a cosmetic change
to the return paths from uio_write to facilitate easier review of the 
second patch. The second patch contains the change to prevent destruction
of the uio_device while file descriptors to it remain open and the
additional locking to prevent the use of a stale 'info' pointer.

This patch series is heavily based on the work done by Brian Russell
(formerly of Brocade) in May 2015. His last version of an attempt to fix
this is seen here:
https://patchwork.kernel.org/patch/6057431/
My new addition is the locking around use of the info pointer. It is my
proposed solution to Brian's last comment about what he had left
unfinished: 
    "It needs a bit more work. uio_info needs to live as long as the 
     corresponding uio_device. Since they seem to always be 1:1, 
     uio_info could embedded within uio_device (but then all the users
     of uio need changed) or uio_info could be a refcounted object."

For further info here is an example of the kernel oops this patch series
is trying to resolve. Output is from a 4.17.0-rc1 kernel with a test app
opening a uio device and doing select with the fd, then removing the UIO
device while the select is still happening:

Unable to handle kernel paging request for data at address 0x6b6b6b6b6b6b6d63
Faulting instruction address: 0xc000000000605c98
Oops: Kernel access of bad area, sig: 11 [#1]
BE PREEMPT SMP NR_CPUS=8 CoreNet Generic
Modules linked in:
CPU: 6 PID: 282 Comm: uio_tester Not tainted 4.17.0-rc1-at1+ #8
NIP:  c000000000605c98 LR: c000000000211d8c CTR: c000000000605c60
REGS: c0000000f02f3480 TRAP: 0300   Not tainted  (4.17.0-rc1-at1+)
MSR:  000000008202b000 <VEC,CE,EE,FP,ME>  CR: 24284448  XER: 20000000
DEAR: 6b6b6b6b6b6b6d63 ESR: 0000000000000000 SOFTE: 0 
GPR00: c000000000211d8c c0000000f02f3700 c000000000dc7d00 c0000000ef365bc0 
GPR04: c0000000f02f3800 0000000000000000 c0000000ef4b9b58 0000000000000006 
GPR08: c000000000605c60 6b6b6b6b6b6b6b6b 0000000000000000 0000000000000016 
GPR12: 0000000042284448 c00000003fffd440 0000000000000004 0000000000000003 
GPR16: 0000000000000008 0000000000000000 00000000ef365bc0 0000000000000000 
GPR20: c0000000f02f3c00 0000000000000000 0000000000000000 c0000000ef365bc0 
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR28: c0000000f02f3800 c0000000ef365bc0 c0000000f02c2c68 c0000000efd01d20 
NIP [c000000000605c98] .uio_poll+0x38/0xe0
LR [c000000000211d8c] .do_select+0x39c/0x7a0
Call Trace:
[c0000000f02f3700] [c0000000f02f3790] 0xc0000000f02f3790 (unreliable)
[c0000000f02f3790] [c000000000211d8c] .do_select+0x39c/0x7a0
[c0000000f02f3b90] [c000000000212eac] .core_sys_select+0x22c/0x320
[c0000000f02f3d70] [c000000000213098] .__se_sys_select+0xf8/0x170
[c0000000f02f3e30] [c000000000000674] system_call+0x58/0x64
Instruction dump:
f8010010 fba1ffe8 fbc1fff0 fbe1fff8 f821ff71 7c7d1b78 7c9c2378 60000000 
60000000 ebdd00c0 ebfe0000 e93f0038 <e92901f8> 2fa90000 40de0030 3c60ffff 
---[ end trace 8badf75b83f45856 ]---

Hamish Martin (2):
  uio: Reduce return paths from uio_write()
  uio: Prevent device destruction while fds are open

 drivers/uio/uio.c          | 121 ++++++++++++++++++++++++++++++++-------------
 include/linux/uio_driver.h |   3 +-
 2 files changed, 90 insertions(+), 34 deletions(-)

-- 
2.16.2
