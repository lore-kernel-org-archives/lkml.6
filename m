Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrZp4huahzsfSueJTKJiN3knwkK0w1ewT4qmsMvfTV3Yhi+7U+OvaChClQGgZIYma/YCIbf
ARC-Seal: i=1; a=rsa-sha256; t=1525767322; cv=none;
        d=google.com; s=arc-20160816;
        b=xDTt1B6VSKJy9DK4jx1V5HtqtXVc52l12RSC1171DedBj1cmFTOicsJxp7RNZjNx4f
         ZiNNvKuSUXiD1BkUpwRXyd4nq5kQ/T9mQRiOw8HEeA3LTLF0Ihbs2iZT68ZGgUM6Jyml
         lvfbFXAR8uqe6VdOgQrgNFsIf8rg5G4nShMHv6008OVdNHmN11ls+mP9AKYnYWrhRs+S
         86tgKyJfITGBiHocgEiRml3qf4Wco7dXJqgHMPoxU3zG3VElXEiqKhKCpWdOn5QaZAiq
         wxYQATUECXtiv/uJlSn7X551giAKjzxx6esDNx61t8E4IEtRW6+FvxsoeFlf4IA2qzOJ
         7Vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=oIdiNrqd3mcnFPrHLnHRjJebTAcdRBAPZg3nia+QgkY=;
        b=r7kwE0iaeCkkHOhcNYhSr3s9Fnl7piR5kJT+wsvE9fjC4rK+GkwOc32NDH5lgVFKbq
         lqyUP3yzDoIK0x21fY6UM3Qer4vT7fiKwQDAeymyRpw1XqYDjMH7y2sM6Yru00ENhsce
         wdaiQQ7/emV216pVdzSGFCqGbMTuYbSvggR1fgR4rD42E8UNLvOOQi4CCjPZapiNchrt
         B08dxOXghMAGrphTpRjMWbiiFpMDUtzBoTBbIIR4aQDCm2PTXXO8B9vhcOmCQrYQiIXB
         PXbjT2cE7cZBmImeXAzcgOftm5+zj1+Erv63RxXdddBJx0d/R6wVbP08lTbxFrMQhKmM
         8WRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CePaBeWi;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CePaBeWi;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Steven Royer <seroyer@linux.vnet.ibm.com>,
	Taylor Jakobson <tjakobs@us.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 14/43] scsi: target: Fix fortify_panic kernel exception
Date: Tue,  8 May 2018 10:10:33 +0200
Message-Id: <20180508074006.273835011@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882767356757708?=
X-GMAIL-MSGID: =?utf-8?q?1599882995657599039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryant G Ly <bryantly@linux.vnet.ibm.com>

commit f5957dade4f373b04fa1f5315a489f18cc2c4cb4 upstream.

memcmp() requires the two buffers passed as arguments to be at least
'size' bytes long, otherwise a fortify_panic will trigger.

Use memchr_inv() instead of memcmp() to determine whether the received
payload is zeroed or not.

The bug was found by running a block backstore via LIO.

[  496.212958] Call Trace:
[  496.212960] [c0000007e58e3800] [c000000000cbbefc] fortify_panic+0x24/0x38 (unreliable)
[  496.212965] [c0000007e58e3860] [d00000000f150c28] iblock_execute_write_same+0x3b8/0x3c0 [target_core_iblock]
[  496.212976] [c0000007e58e3910] [d000000006c737d4] __target_execute_cmd+0x54/0x150 [target_core_mod]
[  496.212982] [c0000007e58e3940] [d000000006d32ce4] ibmvscsis_write_pending+0x74/0xe0 [ibmvscsis]
[  496.212991] [c0000007e58e39b0] [d000000006c74fc8] transport_generic_new_cmd+0x318/0x370 [target_core_mod]
[  496.213001] [c0000007e58e3a30] [d000000006c75084] transport_handle_cdb_direct+0x64/0xd0 [target_core_mod]
[  496.213011] [c0000007e58e3aa0] [d000000006c75298] target_submit_cmd_map_sgls+0x1a8/0x320 [target_core_mod]
[  496.213021] [c0000007e58e3b30] [d000000006c75458] target_submit_cmd+0x48/0x60 [target_core_mod]
[  496.213026] [c0000007e58e3bd0] [d000000006d34c20] ibmvscsis_scheduler+0x370/0x600 [ibmvscsis]
[  496.213031] [c0000007e58e3c90] [c00000000013135c] process_one_work+0x1ec/0x580
[  496.213035] [c0000007e58e3d20] [c000000000131798] worker_thread+0xa8/0x600
[  496.213039] [c0000007e58e3dc0] [c00000000013a468] kthread+0x168/0x1b0
[  496.213044] [c0000007e58e3e30] [c00000000000b528] ret_from_kernel_thread+0x5c/0xb4

[mkp: tweaked commit message]

Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Reviewed-by: Steven Royer <seroyer@linux.vnet.ibm.com>
Tested-by: Taylor Jakobson <tjakobs@us.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/target_core_iblock.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -427,8 +427,8 @@ iblock_execute_zero_out(struct block_dev
 {
 	struct se_device *dev = cmd->se_dev;
 	struct scatterlist *sg = &cmd->t_data_sg[0];
-	unsigned char *buf, zero = 0x00, *p = &zero;
-	int rc, ret;
+	unsigned char *buf, *not_zero;
+	int ret;
 
 	buf = kmap(sg_page(sg)) + sg->offset;
 	if (!buf)
@@ -437,10 +437,10 @@ iblock_execute_zero_out(struct block_dev
 	 * Fall back to block_execute_write_same() slow-path if
 	 * incoming WRITE_SAME payload does not contain zeros.
 	 */
-	rc = memcmp(buf, p, cmd->data_length);
+	not_zero = memchr_inv(buf, 0x00, cmd->data_length);
 	kunmap(sg_page(sg));
 
-	if (rc)
+	if (not_zero)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
 	ret = blkdev_issue_zeroout(bdev,
