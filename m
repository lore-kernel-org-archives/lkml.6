Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoIMXSCBHvRmnL0Pj00onUPIlPKjCjHW8gAxKceudh3zeSwGZ1o/PtGKfhGiprYg6YTfQEi
ARC-Seal: i=1; a=rsa-sha256; t=1524838380; cv=none;
        d=google.com; s=arc-20160816;
        b=dHNDHSLlmCNPIZOw1qjsDTWbaaiuiFw5/+9YSZV3k/fAm0wzrN1fYo8vri+Quu0Ice
         lgAKPtH+qLrv5Hje5eoTu2zJiAnmGlhW2ERSytBdGo0HcAoIp9CG/UT2OvrC/nOKPrxm
         mWa3yST1Y9VyjZt/JqtofmmgGH/n9oSuEZYyJIS43K81tAu0fTPaP/aLQ2NCVGyo49vi
         bs/Rr1Nm3utOqtpoV5tgvAiIhbfPlSZMbFF8sVCOA/i4ymqqbl9Rzx2kyEnGVeKwj7Da
         DLMskDCeSOgjknfm+gtM5GA937aSLqMqhkBSJQgAVaeiC5S6HAd1KSA8ym8cp1IxwX2k
         1tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=10cNFr0+K9AGD74U3qaxMJMpHNWAZD3iW4wYsMKhqLI=;
        b=LjjgNlkVfmrmsWczgbmC/OWvPq+lyGdXfPvvOECLxNOzoUHdJPIEbVDH3oEMgKE4dk
         rWQc08LcbiZ6QkVWKk33kqXjErorrIZsjxDwkc6biJwCrP+q89z6tF2c+6SLOkfC2UV0
         RykDTzJ8XTnhyO3pBYJSAnzoXE8fwShtAaQG1ixWyZbzL3qT6GWiLcgW54GKjXPXuLey
         st9Ls2Ar3mglbhYnBvUHOvih5SBPEvvPdwX5wEGgJKApbtS/7/mgivInqIXd44akNzdz
         dXGd48iMKtmMwyRebhyXTV7nRk3GqJp/3KKtnc35+RIisLJQojBPqzCLKWAjQgEuWo5Y
         ngXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3879E2189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@telegraphics.com.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.16 71/81] block/swim: Fix array bounds check
Date: Fri, 27 Apr 2018 15:59:13 +0200
Message-Id: <20180427135747.422285490@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908691588285919?=
X-GMAIL-MSGID: =?utf-8?q?1598908929257651623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit 7ae6a2b6cc058005ee3d0d2b9ce27688e51afa4b upstream.

In the floppy_find() function in swim.c is a call to
get_disk(swd->unit[drive].disk). The actual parameter to this call
can be a NULL pointer when drive == swd->floppy_count. This causes
an oops in get_disk().

Data read fault at 0x00000198 in Super Data (pc=0x1be5b6)
BAD KERNEL BUSERR
Oops: 00000000
Modules linked in: swim_mod ipv6 mac8390
PC: [<001be5b6>] get_disk+0xc/0x76
SR: 2004  SP: 9a078bc1  a2: 0213ed90
d0: 00000000    d1: 00000000    d2: 00000000    d3: 000000ff
d4: 00000002    d5: 02983590    a0: 02332e00    a1: 022dfd64
Process dd (pid: 285, task=020ab25b)
Frame format=B ssw=074d isc=4a88 isb=6732 daddr=00000198 dobuf=00000000
baddr=001be5bc dibuf=bfffffff ver=f
Stack from 022dfca4:
        00000000 0203fc00 0213ed90 022dfcc0 02982936 00000000 00200000 022dfd08
        0020f85a 00200000 022dfd64 02332e00 004040fc 00000014 001be77e 022dfd64
        00334e4a 001be3f8 0800001d 022dfd64 01c04b60 01c04b70 022aba80 029828f8
        02332e00 022dfd2c 001be7ac 0203fc00 00200000 022dfd64 02103a00 01c04b60
        01c04b60 0200e400 022dfd68 000e191a 00200000 022dfd64 02103a00 0800001d
        00000000 00000003 000b89de 00500000 02103a00 01c04b60 02103a08 01c04c2e
Call Trace: [<02982936>] floppy_find+0x3e/0x4a [swim_mod]
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<0020f85a>] kobj_lookup+0xde/0x132
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<001be77e>] get_gendisk+0x0/0x130
 [<00334e4a>] mutex_lock+0x0/0x2e
 [<001be3f8>] disk_block_events+0x0/0x6c
 [<029828f8>] floppy_find+0x0/0x4a [swim_mod]
 [<001be7ac>] get_gendisk+0x2e/0x130
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<000e191a>] __blkdev_get+0x32/0x45a
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<000b89de>] complete_walk+0x0/0x8a
 [<000e1e22>] blkdev_get+0xe0/0x29a
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000b89de>] complete_walk+0x0/0x8a
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000e01cc>] bd_acquire+0x74/0x8a
 [<000e205c>] blkdev_open+0x80/0xb0
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000abf24>] do_dentry_open+0x1a4/0x322
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<000b89de>] complete_walk+0x0/0x8a
 [<000baa62>] link_path_walk+0x0/0x48e
 [<000ba3f8>] inode_permission+0x20/0x54
 [<000ac0e4>] vfs_open+0x42/0x78
 [<000bc372>] path_openat+0x2b2/0xeaa
 [<000bc0c0>] path_openat+0x0/0xeaa
 [<0004463e>] __irq_wake_thread+0x0/0x4e
 [<0003a45a>] task_tick_fair+0x18/0xc8
 [<000bd00a>] do_filp_open+0xa0/0xea
 [<000abae0>] do_sys_open+0x11a/0x1ee
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<000abbf4>] SyS_open+0x1e/0x22
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<00002b40>] syscall+0x8/0xc
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<0000c00b>] dyadic+0x1/0x28
Code: 4e5e 4e75 4e56 fffc 2f0b 2f02 266e 0008 <206b> 0198 4a88 6732 2428 002c 661e 486b 0058 4eb9 0032 0b96 588f 4a88 672c 2008
Disabling lock debugging due to kernel taint

Fix the array index bounds check to avoid this.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Fixes: 8852ecd97488 ("[PATCH] m68k: mac - Add SWIM floppy support")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -790,7 +790,7 @@ static struct kobject *floppy_find(dev_t
 	struct swim_priv *swd = data;
 	int drive = (*part & 3);
 
-	if (drive > swd->floppy_count)
+	if (drive >= swd->floppy_count)
 		return NULL;
 
 	*part = 0;
