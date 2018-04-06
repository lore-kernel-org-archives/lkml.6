Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/zJ1WQvG4iBg0RlZ3c96SMALekxnAAztJQnp3ubAyuZrj+w+OH4/8KHQrq/vaXz827FgeO
ARC-Seal: i=1; a=rsa-sha256; t=1523021529; cv=none;
        d=google.com; s=arc-20160816;
        b=dfO5k5ineyvBkMx1/qWed74Lb7gipMULwjdaeIcYqhsgqM5NIZBTDqmlZk559Ksy00
         BODpip/acPmUYDvfRG7Gw6vOWG1LOlMKkIJFY6dA7YY7DMDzFZSH6Mks/fS2RTBTPI7z
         +Pu+XhsQ7iaR6poZiKWu/MyzgPvxLVvm81GbD9oQz9TI2I6t9/07P1ZQWiYhk7286gFR
         yPiGqF4FH6ObQP6MfLk81QoZTBWPar4jxydPNJCSk2lcWDTItN07LHYL7v7MSo5ronIk
         NBKN1XCh3atj1nNaLZc2tuodvgyPjei8TZOc6241FRM8aUUzG/AZ5USC/k+smArTYROV
         6eVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UoDvtIoBkU6sVjPmjd2aVW1aX4wIHODguASIqR6RlKQ=;
        b=vrdfBp8QOf/z62jDN5eySQiTDwVs+f8J90UMG2YYZO0bdnOl8foH0G+FAoAVHnMzAH
         rraWv3NXlS+REmL7c7sGuK+2jhyxu8aL9/wM9bgHoexTLdY4ilX+m+Lf1I+43CwWg6Hr
         0XWSe7SgQvUy0KAC2irzH9jdts9QQohswH8B/ikKDt2moLnlLCYZj2v2g0JxOSAv6A8I
         nLpTBtMPhp2DGDI/ZjLArHbMZ5BEFqaSOt72qUuAHiaLi6ypjo87rHG3Yy3waxmQKnYZ
         ai5fwGdhl/cdXCaSo622uSu6yF/uzcFVawRkm3oLRgEVSBtKq0sxBfznq66qZLxAj69F
         EMQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 69/72] Revert "mtip32xx: use runtime tag to initialize command header"
Date: Fri,  6 Apr 2018 15:24:10 +0200
Message-Id: <20180406084311.455222269@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003823692363057?=
X-GMAIL-MSGID: =?utf-8?q?1597003823692363057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 9bf9e352ed51d4cdee107675609ba12b42d00c5b which was
commit a4e84aae8139aca9fbfbced1f45c51ca81b57488 upstream.

Ben writes:
	MQ IO schedulers were introduced in 4.11, so this shouldn't be
	needed in older branches.  It also causes a performance
	regression (fixed upstream).  Please revert this for 4.4 and
	4.9.

So let's revert it!

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/mtip32xx/mtip32xx.c |   36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -169,25 +169,6 @@ static bool mtip_check_surprise_removal(
 	return false; /* device present */
 }
 
-/* we have to use runtime tag to setup command header */
-static void mtip_init_cmd_header(struct request *rq)
-{
-	struct driver_data *dd = rq->q->queuedata;
-	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
-	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
-
-	/* Point the command headers at the command tables. */
-	cmd->command_header = dd->port->command_list +
-				(sizeof(struct mtip_cmd_hdr) * rq->tag);
-	cmd->command_header_dma = dd->port->command_list_dma +
-				(sizeof(struct mtip_cmd_hdr) * rq->tag);
-
-	if (host_cap_64)
-		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
-
-	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
-}
-
 static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 {
 	struct request *rq;
@@ -199,9 +180,6 @@ static struct mtip_cmd *mtip_get_int_com
 	if (IS_ERR(rq))
 		return NULL;
 
-	/* Internal cmd isn't submitted via .queue_rq */
-	mtip_init_cmd_header(rq);
-
 	return blk_mq_rq_to_pdu(rq);
 }
 
@@ -3840,8 +3818,6 @@ static int mtip_queue_rq(struct blk_mq_h
 	struct request *rq = bd->rq;
 	int ret;
 
-	mtip_init_cmd_header(rq);
-
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
@@ -3873,6 +3849,7 @@ static int mtip_init_cmd(void *data, str
 {
 	struct driver_data *dd = data;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
 
 	/*
 	 * For flush requests, request_idx starts at the end of the
@@ -3889,6 +3866,17 @@ static int mtip_init_cmd(void *data, str
 
 	memset(cmd->command, 0, CMD_DMA_ALLOC_SZ);
 
+	/* Point the command headers at the command tables. */
+	cmd->command_header = dd->port->command_list +
+				(sizeof(struct mtip_cmd_hdr) * request_idx);
+	cmd->command_header_dma = dd->port->command_list_dma +
+				(sizeof(struct mtip_cmd_hdr) * request_idx);
+
+	if (host_cap_64)
+		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
+
+	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
+
 	sg_init_table(cmd->sg, MTIP_MAX_SG);
 	return 0;
 }
