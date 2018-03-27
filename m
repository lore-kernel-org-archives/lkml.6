Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/L6YM+4uJqODvhJxW9WgEyA+GP69xvp5R80RO20z3dowFiXsdGC+S4elsLVtADSiBrxkIm
ARC-Seal: i=1; a=rsa-sha256; t=1522168201; cv=none;
        d=google.com; s=arc-20160816;
        b=qrLrUBkyOoYN0Il+6W9kcGLN+/9RfmXA/AQzUW7v82hSfXDkff/0jwsn/tWW8vbASU
         n/hTmooGqCmcFU+f6GD4EOxXQ4/LHvHdPWzv5svalnSMYRacsu6GOacpVbWWU2Hs9CyY
         PwnvviWEB4qWTiIzYvn4tk+Bo1G0N32MJbjxB1qM3+Bvf+ng445w+sBnjJrq9+ewe5KG
         nFG1N9335AtOn6S4Oxebs67HnRlwoHtd6MHolh1OFWOkYiiK8W/KxtQbDk0rDDwz2/LU
         v4Q5Uuy48NP1jJZZgFCbo/EqdKCOyid3APKlonB1g1qa1umH2rF42e/vTTwdeCTrctYr
         VOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w6R7i9i9Ds4lrbrWMlJplKGtPuTSdeTo26FzvGImajM=;
        b=cMTY53iyha3Tbjs1cFj5Gka4yk8o4muJgRq0E31OSq8b2v8TLgaM0Masr6SyQhGsd9
         uQgN7oGiBjVtkkpyjttWKYgPq1LTcV/xBM1C6faJ/mL1MQN0/IcArWKMPPjtGmtNy7GL
         iYZgvRukjb0bPSoqmPwAXSRF3tifOFORDjwOaQFFiM8gavNvAbMZQdLzGc6KMrOvRdi4
         um4HErp36aGAtOwfYsOKwMPd1JIA7d9BWIwDKcvL5GIOQMIae+jY/mZEAQNuxn0K7Q39
         u/AfeH/XwiGVHbiKM1uqUcSo4hL41NQZxFHH5V4hSyctmghVVPgYsEpiJbgyWFi+YjC1
         3+sA==
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
Subject: [PATCH 4.4 12/43] libata: fix length validation of ATAPI-relayed SCSI commands
Date: Tue, 27 Mar 2018 18:27:16 +0200
Message-Id: <20180327162717.069237899@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109044007210332?=
X-GMAIL-MSGID: =?utf-8?q?1596109044007210332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3472,7 +3472,9 @@ static inline int __ata_scsi_queuecmd(st
 		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
 			/* relay SCSI command to ATAPI device */
 			int len = COMMAND_SIZE(scsi_op);
-			if (unlikely(len > scmd->cmd_len || len > dev->cdb_len))
+			if (unlikely(len > scmd->cmd_len ||
+				     len > dev->cdb_len ||
+				     scmd->cmd_len > ATAPI_CDB_LEN))
 				goto bad_cdb_len;
 
 			xlat_func = atapi_xlat;
