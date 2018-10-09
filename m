Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C1CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48733214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="whV01Jh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48733214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeJISbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41764 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJISbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id q17-v6so665861plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xw/0bX6g1bphl4qCLi3oqhSdmZqGRZB0w26ZEqBFFwM=;
        b=whV01Jh603VBEE5sBace/+p7wXP/keQz0wD8YVjlSTPYAheayGJSSc8L+afGqPZxOA
         lQ5p7Ebxk/HyB8OokYUkC5hpMD+l9QxYINNTbThQre3U7fyp3Q/7XhGs8oS4blM9TqyD
         jc9nkiknQP5C865yMyyMS2lMhIWpcv0Z6IKI9U/YkW8H3+PmgIbhD4lQ9BrRa1qzzy6f
         v60do2LmUxqqqhEExKbOAWgXFFvnpT6YiLzvylJDsTtAc8BT5o25N+0ZGfgl7uNhnqqf
         WgNzGJKEpP/xPW5vNLtUuf0aWTO7CKVUj+qJhkTM/OerspCbQNl9b2y6ftnCjjlhgMon
         U8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xw/0bX6g1bphl4qCLi3oqhSdmZqGRZB0w26ZEqBFFwM=;
        b=owbUG4ky+3FRh0gnpnUSuNKeTs08djpArmWXoLaPESBNPKCiaIS2U9btPdnJK4nTUC
         4nwxBY1QDCTysNPdf/QaRtj+2GfRdP+A6hMNHjIGntpAb7TSvpdlDCWZ2oMXbrrzxhEx
         W9/VWoBXIzIMG42cVpBQydOGAB2Hgl8USG22wtV0tCiuHVzyrnHHC/hRE1WOU8R8LBmD
         5Sh4u/8MsaxMswDHAI7Teww2YSCKF74dyATR62EvtQEFH1w057LsZQAH0o+L0g6pSGdj
         7eeavZFl2g9tDy0lEDMC5DjFDhPCm07z2/mK1o0BJLU+tlP7XmYYORL+i6SsMzc1+KOk
         tAZg==
X-Gm-Message-State: ABuFfoj3dvbWJITH9nWJ4Sk9KJ82hm0+aJ/LBN4iMysB77uwapyVQrip
        DVuVf54dy2kklEqFmbs3VT6WdE6WLH07Mg==
X-Google-Smtp-Source: ACcGV61yCGKy+3yAb37r9V8Oy1LYL/9OuSQthqrggLMcknxwuSozXT50jOOaFvOu3az0517fp8nw3g==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22-v6mr28170872pll.321.1539083674443;
        Tue, 09 Oct 2018 04:14:34 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:33 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 24/45] lightnvm: pblk: add trace events for pblk state changes
Date:   Tue,  9 Oct 2018 13:11:54 +0200
Message-Id: <20181009111215.7653-25-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Add trace events for tracking pblk state changes.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  |  3 +++
 drivers/lightnvm/pblk-init.c  |  1 +
 drivers/lightnvm/pblk-trace.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ef52c1647f88..c482ef7dd4b5 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1503,6 +1503,7 @@ static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
 
 	pblk_set_space_limit(pblk);
 	pblk->state = PBLK_STATE_STOPPING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 }
 
 static void pblk_line_close_meta_sync(struct pblk *pblk)
@@ -1552,6 +1553,7 @@ void __pblk_pipeline_flush(struct pblk *pblk)
 		return;
 	}
 	pblk->state = PBLK_STATE_RECOVERING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	spin_unlock(&l_mg->free_lock);
 
 	pblk_flush_writer(pblk);
@@ -1573,6 +1575,7 @@ void __pblk_pipeline_stop(struct pblk *pblk)
 
 	spin_lock(&l_mg->free_lock);
 	pblk->state = PBLK_STATE_STOPPED;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	l_mg->data_line = NULL;
 	l_mg->data_next = NULL;
 	spin_unlock(&l_mg->free_lock);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index fca37da16266..9aebdee8e4c9 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1109,6 +1109,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->dev = dev;
 	pblk->disk = tdisk;
 	pblk->state = PBLK_STATE_RUNNING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	pblk->gc.gc_enabled = 0;
 
 	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index f9aa9e25e428..c171d0450c07 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -25,6 +25,13 @@ struct ppa_addr;
 	{ PBLK_LINESTATE_CORRUPT,	"CORRUPT"	})
 
 
+#define show_pblk_state(state) __print_symbolic(state,		\
+	{ PBLK_STATE_RUNNING,		"RUNNING",	},	\
+	{ PBLK_STATE_STOPPING,		"STOPPING",	},	\
+	{ PBLK_STATE_RECOVERING,	"RECOVERING",	},	\
+	{ PBLK_STATE_STOPPED,		"STOPPED"	})
+
+
 TRACE_EVENT(pblk_chunk_state,
 
 	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
@@ -75,6 +82,27 @@ TRACE_EVENT(pblk_line_state,
 
 );
 
+TRACE_EVENT(pblk_state,
+
+	TP_PROTO(const char *name, int state),
+
+	TP_ARGS(name, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, state);
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->state = state;
+	),
+
+	TP_printk("dev=%s state=%s", __get_str(name),
+			show_pblk_state((int)__entry->state))
+
+);
+
 #endif /* !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */
-- 
2.17.1

