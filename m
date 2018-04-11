Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49L33fWETGzsneiLZFGhl+uhR5rOZGB5Tl7AL77AT34xnxqD5sNnVwD97hrfPpBEUtiUhdg
ARC-Seal: i=1; a=rsa-sha256; t=1523473272; cv=none;
        d=google.com; s=arc-20160816;
        b=yfDaB6IC62tRU05Sva6Btx15qMJFSTXqobGAaxojdcf2R55JaR/isv9cD7ACZLzDmE
         +Gc9nwhP738qRX62/aVTCek5h3d91KWbb+J7gqHfogbRIyANeAFevGeRvtvt++pYCrNs
         /1plCsHg9x0izYf+rMX/TfLKAqZTWTEZMRvZ689m3c+Rl0TdSS+WxYvTUjsDwhRx90n/
         pDI31LnzEi8Lw9sBxM0EwTqP3RKT2KfhONqZYsSSdkFHgLuYuU9GOl1VYuqLVEd47ZJ1
         6WpPyf1QGJ0T18qlkcqGsurUPGzLDI2+Fcf5YtviG9AjW61HSJyqgMsCiOiaKV17Axz7
         QoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kii8p+J0Olsho00xkFck7ClzlSObWXvnrTjwjlkZz0M=;
        b=oRjG4/DFfvL1/qA5m3J1GV5u6+lSFzwcTuNJuLpAUzeWLf5sdhQ/Itcj1KKJHTujeL
         gLJAPXNrir3ka3VZKZ5nAnrniZTlxXxXdPY8VcETgZaqg+1hldGGm8EFNNfr9Y86lRjW
         1sd3ZpCcOla2ktP/InOY5leb05+KFOVNsbXBhQZ4Eqicoczg7WyDd/iTKWv9Qt7flXap
         3a1gbmOCPnf+hnOW79ET2YNnzr65fMe6tMop7jnXWpQHxik3Lj54nElowf4s0CN03iMu
         hZpOUAoiDKmomNMWDFRdet+SJyX2xqEtG88Hb12qRpAkqC0KoZ6pS26pExyg7eq6ItRo
         5QwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dmitry Monakhov <dmonakhov@openvz.org>,
	Jens Axboe <axboe@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 188/310] bio-integrity: Do not allocate integrity context for bio w/o data
Date: Wed, 11 Apr 2018 20:35:27 +0200
Message-Id: <20180411183630.697344537@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476218089196148?=
X-GMAIL-MSGID: =?utf-8?q?1597477510457336779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Monakhov <dmonakhov@openvz.org>


[ Upstream commit 3116a23bb30272d74ea81baf5d0ee23f602dd15b ]

If bio has no data, such as ones from blkdev_issue_flush(),
then we have nothing to protect.

This patch prevent bugon like follows:

kfree_debugcheck: out of range ptr ac1fa1d106742a5ah
kernel BUG at mm/slab.c:2773!
invalid opcode: 0000 [#1] SMP
Modules linked in: bcache
CPU: 0 PID: 4428 Comm: xfs_io Tainted: G        W       4.11.0-rc4-ext4-00041-g2ef0043-dirty #43
Hardware name: Virtuozzo KVM, BIOS seabios-1.7.5-11.vz7.4 04/01/2014
task: ffff880137786440 task.stack: ffffc90000ba8000
RIP: 0010:kfree_debugcheck+0x25/0x2a
RSP: 0018:ffffc90000babde0 EFLAGS: 00010082
RAX: 0000000000000034 RBX: ac1fa1d106742a5a RCX: 0000000000000007
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88013f3ccb40
RBP: ffffc90000babde8 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000fcb76420 R11: 00000000725172ed R12: 0000000000000282
R13: ffffffff8150e766 R14: ffff88013a145e00 R15: 0000000000000001
FS:  00007fb09384bf40(0000) GS:ffff88013f200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0172f9e40 CR3: 0000000137fa9000 CR4: 00000000000006f0
Call Trace:
 kfree+0xc8/0x1b3
 bio_integrity_free+0xc3/0x16b
 bio_free+0x25/0x66
 bio_put+0x14/0x26
 blkdev_issue_flush+0x7a/0x85
 blkdev_fsync+0x35/0x42
 vfs_fsync_range+0x8e/0x9f
 vfs_fsync+0x1c/0x1e
 do_fsync+0x31/0x4a
 SyS_fsync+0x10/0x14
 entry_SYSCALL_64_fastpath+0x1f/0xc2

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bio-integrity.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -175,6 +175,9 @@ bool bio_integrity_enabled(struct bio *b
 	if (!bio_is_rw(bio))
 		return false;
 
+	if (!bio_sectors(bio))
+		return false;
+
 	/* Already protected? */
 	if (bio_integrity(bio))
 		return false;
