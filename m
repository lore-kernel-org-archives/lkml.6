Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4GsCApE/GVvPWwAAmS7hNA
	; Thu, 07 Jun 2018 14:22:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EC2F4608BA; Thu,  7 Jun 2018 14:22:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 50A7E602FC;
	Thu,  7 Jun 2018 14:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50A7E602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933591AbeFGOWE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:22:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39426 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933069AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005Zi-KD; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00032t-6z; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        syzbot+1ff6f9fcc3c35f1c72a95e26528c8e7e3276e4da@syzkaller.appspotmail.com,
        "Tejun Heo" <tj@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.735046541@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 228/410] libata: fix length validation of
 ATAPI-relayed SCSI commands
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 058f58e235cbe03e923b30ea7c49995a46a8725f upstream.

syzkaller reported a crash in ata_bmdma_fill_sg() when writing to
/dev/sg1.  The immediate cause was that the ATA command's scatterlist
was not DMA-mapped, which causes 'pi - 1' to underflow, resulting in a
write to 'qc->ap->bmdma_prd[0xffffffff]'.

Strangely though, the flag ATA_QCFLAG_DMAMAP was set in qc->flags.  The
root cause is that when __ata_scsi_queuecmd() is preparing to relay a
SCSI command to an ATAPI device, it doesn't correctly validate the CDB
length before copying it into the 16-byte buffer 'cdb' in 'struct
ata_queued_cmd'.  Namely, it validates the fixed CDB length expected
based on the SCSI opcode but not the actual CDB length, which can be
larger due to the use of the SG_NEXT_CMD_LEN ioctl.  Since 'flags' is
the next member in ata_queued_cmd, a buffer overflow corrupts it.

Fix it by requiring that the actual CDB length be <= 16 (ATAPI_CDB_LEN).

[Really it seems the length should be required to be <= dev->cdb_len,
but the current behavior seems to have been intentionally introduced by
commit 607126c2a21c ("libata-scsi: be tolerant of 12-byte ATAPI commands
in 16-byte CDBs") to work around a userspace bug in mplayer.  Probably
the workaround is no longer needed (mplayer was fixed in 2007), but
continuing to allow lengths to up 16 appears harmless for now.]

Here's a reproducer that works in QEMU when /dev/sg1 refers to the
CD-ROM drive that qemu-system-x86_64 creates by default:

    #include <fcntl.h>
    #include <sys/ioctl.h>
    #include <unistd.h>

    #define SG_NEXT_CMD_LEN 0x2283

    int main()
    {
	    char buf[53] = { [36] = 0x7e, [52] = 0x02 };
	    int fd = open("/dev/sg1", O_RDWR);
	    ioctl(fd, SG_NEXT_CMD_LEN, &(int){ 17 });
	    write(fd, buf, sizeof(buf));
    }

The crash was:

    BUG: unable to handle kernel paging request at ffff8cb97db37ffc
    IP: ata_bmdma_fill_sg drivers/ata/libata-sff.c:2623 [inline]
    IP: ata_bmdma_qc_prep+0xa4/0xc0 drivers/ata/libata-sff.c:2727
    PGD fb6c067 P4D fb6c067 PUD 0
    Oops: 0002 [#1] SMP
    CPU: 1 PID: 150 Comm: syz_ata_bmdma_q Not tainted 4.15.0-next-20180202 #99
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
    [...]
    Call Trace:
     ata_qc_issue+0x100/0x1d0 drivers/ata/libata-core.c:5421
     ata_scsi_translate+0xc9/0x1a0 drivers/ata/libata-scsi.c:2024
     __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4326 [inline]
     ata_scsi_queuecmd+0x8c/0x210 drivers/ata/libata-scsi.c:4375
     scsi_dispatch_cmd+0xa2/0xe0 drivers/scsi/scsi_lib.c:1727
     scsi_request_fn+0x24c/0x530 drivers/scsi/scsi_lib.c:1865
     __blk_run_queue_uncond block/blk-core.c:412 [inline]
     __blk_run_queue+0x3a/0x60 block/blk-core.c:432
     blk_execute_rq_nowait+0x93/0xc0 block/blk-exec.c:78
     sg_common_write.isra.7+0x272/0x5a0 drivers/scsi/sg.c:806
     sg_write+0x1ef/0x340 drivers/scsi/sg.c:677
     __vfs_write+0x31/0x160 fs/read_write.c:480
     vfs_write+0xa7/0x160 fs/read_write.c:544
     SYSC_write fs/read_write.c:589 [inline]
     SyS_write+0x4d/0xc0 fs/read_write.c:581
     do_syscall_64+0x5e/0x110 arch/x86/entry/common.c:287
     entry_SYSCALL_64_after_hwframe+0x21/0x86

Fixes: 607126c2a21c ("libata-scsi: be tolerant of 12-byte ATAPI commands in 16-byte CDBs")
Reported-by: syzbot+1ff6f9fcc3c35f1c72a95e26528c8e7e3276e4da@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3435,7 +3435,9 @@ static inline int __ata_scsi_queuecmd(st
 		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
 			/* relay SCSI command to ATAPI device */
 			int len = COMMAND_SIZE(scsi_op);
-			if (unlikely(len > scmd->cmd_len || len > dev->cdb_len))
+			if (unlikely(len > scmd->cmd_len ||
+				     len > dev->cdb_len ||
+				     scmd->cmd_len > ATAPI_CDB_LEN))
 				goto bad_cdb_len;
 
 			xlat_func = atapi_xlat;
