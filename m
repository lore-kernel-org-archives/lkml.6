Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr+Ep+ugoaNfu2UpEuG29KY+x4mo5OmtHdbHguauVzgINfp1X7Izxn+IJi9MbAQwyGea1v9
ARC-Seal: i=1; a=rsa-sha256; t=1525767104; cv=none;
        d=google.com; s=arc-20160816;
        b=wyDYs32Tt54TjPwq1RTtPiq/xhglZjpzh5CFjq+j5BGeYeTXlN6v+SzDiiHfWgz0gX
         LzKgOrNok21csCs1M+5AdtlxaaqcYyUS+6oc9WQi25cIjNmevlmHU0v3bSm9tFFjEVuD
         GUckza0z/XNwsgRitK+iWFrQRcl1jLdXT2mBtF2gdnuzq9wRmlYwB2vpnbdLSS6QvQcV
         WHV1g1qz0N7TN9LGlR+zg7r3RKtjsp31xocI1TV+0KI2M7WB+lqC1fN8FPSS0xDzf/vM
         m0e5t8k2O9h4KsKE+e44fisZvPywUwHGOmr7Mwkb92dAsete2KIfxaZGPBBAXfBmdqtU
         dlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0nv2aHDto5FbI1HMPjp3aBBPtI7kMoCfvjyhJSVOr/k=;
        b=W53AfeVCx6l6hPfYbGmDYZs/xgYj8eprh80GkM8gBDHGkpXDukGwEYOAHKGR1hRAHb
         1Ce2lhuGw/hyjo3JUFL6NXYIiZFrfmm+K5LYjIcGp/5iK4iQIlk9Pkrx7jEP440nJidU
         /NlLafPeWF3KMbGqulSdg+tbWvOVIgU9PfXyApo6yE+9eil0TvlZxVZg8yTefsqLMgiW
         m4WttpuqKdXK0T2PU0IAEKFsyPT5Vto3GORC1In+6LsJzcv0j/caLTLytEr4Z9tWwzSy
         XIsObQmvAJT2TUX0Tv3jS/rIUGqu79e/Dl7jeUizrziHZj9JGgtkaeHL0vJ5hDaZcpAY
         6Gig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SPcOBt4V;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SPcOBt4V;
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
Subject: [PATCH 4.16 11/52] scsi: target: Fix fortify_panic kernel exception
Date: Tue,  8 May 2018 10:10:09 +0200
Message-Id: <20180508073929.533623320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882767356757708?=
X-GMAIL-MSGID: =?utf-8?q?1599882767356757708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
