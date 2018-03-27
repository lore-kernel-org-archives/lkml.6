Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/qXFUJH6u8fvbT0paFMtx9rhktgKbherb/En0UnXE/8ZyINSwqbt2KJTyxqlOav8O/Jvnd
ARC-Seal: i=1; a=rsa-sha256; t=1522168503; cv=none;
        d=google.com; s=arc-20160816;
        b=XklozQGd9VrG4cnK1+0JteINm0XGPrdXaNa/zyTl6U2wWf3D6J8dspJLdVH8I/HE7Q
         i9UlgL6EH6jmvcNZDIwhB5wdEtOMeeFxjc05/dOJ7U+xtE18OSauAcpsKei1lAEpbt1O
         wYQq9JOREsS7ZN1DLMY+mgM7P/Du8GbGhN43Dhr2x733eeJ7SimCy616qldxBhQ27ZB1
         b/ouvLX1PhPo2pVOyngUcOyOmTx3s3jKt6/SungKNhtBCty/wTX3z2jQQu+rMudjS5Xd
         7+Bdmu2PRanqvWczwv4oDovPG8fgvo7xFqe/jmN/jQV5Y1Hbntg2cWhV30a1MsDUasjZ
         +ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NWSrMLyMrQc581oYLXg6xvTwYRiJBZ4BbU2cwV3o7UE=;
        b=jY11JA43t5vYZ1kMIY1jL+6AiXb8fbHcX9k1Q/oaJNB9+dyq0vLzyQI9GcKbSEc8+V
         NR5hMDpgEg7qL49rvScfbf+IDqXUiPR1pCtB51WQlQyq/kPlxsT0nDiJSC9A6gww4+x6
         XeGI5o2yk0kTJU94xqWb/HmgrQC6G06VBoMsJShfn69CCLQdzZfZPkUn+JmiwcplqzX3
         cXah5dJFGAVYE6xKd9syDjavpfXR2gCWil3Au1EHdhQfpbmBBlH+6rBaGfOF/fKcAImU
         jFz2p2k1dexJQ+unHg8TJUB130F60h2ZGLOTRlKUADbnhYTPwUMqOldYXm2Y8TdIEL2k
         EKLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1ff6f9fcc3c35f1c72a95e26528c8e7e3276e4da@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 034/101] libata: fix length validation of ATAPI-relayed SCSI commands
Date: Tue, 27 Mar 2018 18:27:06 +0200
Message-Id: <20180327162752.092401198@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109044007210332?=
X-GMAIL-MSGID: =?utf-8?q?1596109360561817238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> # v2.6.24+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-scsi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4308,7 +4308,9 @@ static inline int __ata_scsi_queuecmd(st
 		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
 			/* relay SCSI command to ATAPI device */
 			int len = COMMAND_SIZE(scsi_op);
-			if (unlikely(len > scmd->cmd_len || len > dev->cdb_len))
+			if (unlikely(len > scmd->cmd_len ||
+				     len > dev->cdb_len ||
+				     scmd->cmd_len > ATAPI_CDB_LEN))
 				goto bad_cdb_len;
 
 			xlat_func = atapi_xlat;
