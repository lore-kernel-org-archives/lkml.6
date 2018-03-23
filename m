Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsrU2QnhSnQDd5uHFF88FECoNb7s6g/KaqpEYk37sYI2BZd886KJlpXr1ciHYmIDNqvWYwx
ARC-Seal: i=1; a=rsa-sha256; t=1521800146; cv=none;
        d=google.com; s=arc-20160816;
        b=qFHpkA3umSA8kGFV4tsGro2HZV9FlTyMimy+Mx7EsIoI1PisKTLPncrYdqqe1VgYiP
         h8XNOWquXoJLBOaWYEiQ0Kj2arYyo2Fbr5kICc+C5zF0Q/ObC34OqgSdx2H7HJQiNbcW
         7rpE61jV2qwBvOVCmg/JInBtesFBT2M+HUWvTifbUhE63DjJMzYxDhHcoyxSodHUOjuL
         2le8jbqZpJF5gfJJMQN+RaSg0IKJ4IvBrPGEeROTgjuGK+WIQInq1yEOnlImAyj+wTVl
         appzkXOO/iJoUGzX4GrpbCGntzv/Wdcvr4HgP4zzDCKHRon3NxOVHmLhUGAgNCUOdmPX
         igfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mHh2LeJ9gzgieMaMcD2Q7u3NdJk/6vHe0j42BCQuawY=;
        b=MneXtbMqBlTEKFqCDEgk2m8RwpeJrW8Vwv5L0v5h5acj6iyqf7FLJGHZ7oFQt0kwvt
         pIWGmGc2cz2x2LGtrk573qFk//P9u1g73noQZhJ3m7UotZiPZSh+t+F3KrurYxdR9rEp
         d/dgve1wJgzEPzu/PIGfDmpIlZvpB/pprxQbaGW/hYoTiPA8giCYVpPXZSQ3tvTliTmU
         JB2Rtf2OCWe1uV9hF0uLl8d+xnCC7K2HZQ/OtR7Tms9kHXIbQrf01L/mAy4UnFJclrjQ
         PrYwYkCZ0Dm7FYObaHZqQbOR5TasOiDpROxDppCssjIQfmSWouIDKXl3oaBRREhMXo6P
         R91w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 52/97] mtip32xx: use runtime tag to initialize command header
Date: Fri, 23 Mar 2018 10:54:39 +0100
Message-Id: <20180323094200.569562172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722613910979251?=
X-GMAIL-MSGID: =?utf-8?q?1595723110786076602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit a4e84aae8139aca9fbfbced1f45c51ca81b57488 ]

mtip32xx supposes that 'request_idx' passed to .init_request()
is tag of the request, and use that as request's tag to initialize
command header.

After MQ IO scheduler is in, request tag assigned isn't same with
the request index anymore, so cause strange hardware failure on
mtip32xx, even whole system panic is triggered.

This patch fixes the issue by initializing command header via
request's real tag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/mtip32xx/mtip32xx.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -169,6 +169,25 @@ static bool mtip_check_surprise_removal(
 	return false; /* device present */
 }
 
+/* we have to use runtime tag to setup command header */
+static void mtip_init_cmd_header(struct request *rq)
+{
+	struct driver_data *dd = rq->q->queuedata;
+	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
+
+	/* Point the command headers at the command tables. */
+	cmd->command_header = dd->port->command_list +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+	cmd->command_header_dma = dd->port->command_list_dma +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+
+	if (host_cap_64)
+		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
+
+	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
+}
+
 static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 {
 	struct request *rq;
@@ -180,6 +199,9 @@ static struct mtip_cmd *mtip_get_int_com
 	if (IS_ERR(rq))
 		return NULL;
 
+	/* Internal cmd isn't submitted via .queue_rq */
+	mtip_init_cmd_header(rq);
+
 	return blk_mq_rq_to_pdu(rq);
 }
 
@@ -3818,6 +3840,8 @@ static int mtip_queue_rq(struct blk_mq_h
 	struct request *rq = bd->rq;
 	int ret;
 
+	mtip_init_cmd_header(rq);
+
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
@@ -3849,7 +3873,6 @@ static int mtip_init_cmd(void *data, str
 {
 	struct driver_data *dd = data;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
-	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
 
 	/*
 	 * For flush requests, request_idx starts at the end of the
@@ -3866,17 +3889,6 @@ static int mtip_init_cmd(void *data, str
 
 	memset(cmd->command, 0, CMD_DMA_ALLOC_SZ);
 
-	/* Point the command headers at the command tables. */
-	cmd->command_header = dd->port->command_list +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-	cmd->command_header_dma = dd->port->command_list_dma +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-
-	if (host_cap_64)
-		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
-
-	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
-
 	sg_init_table(cmd->sg, MTIP_MAX_SG);
 	return 0;
 }
