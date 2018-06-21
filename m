Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA544C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821A821EA0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6QmJr54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821A821EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934069AbeFUVcz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:32:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933963AbeFUV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jpZNJHBBUaFgsshEoBzRwf4a8gtQRhGpCjXWABd7Qzc=; b=V6QmJr54rLUDuXjwxXfeoZK8a
        Li5rLTQ9PlGKyFW5wyv7Ywl46wZJte0Cut/aReEyTeYQIaQAJTZPSJ16DVKAFfR06L9Ze/kocKbeZ
        2/migke4fI4SoXKJzjly89GtJLu3jybcu5H/zGjmUYz1dzu1uqhsCrLegy6SottaOGT3sbu8fBa1b
        i+SKhle14ImwaqdX4KJyutRweMI4sAnVR10BoZn97k01cLRO5tSrjrB0Yhmgq0AN1zjtjv16P61lT
        A0lizpOaKPppkcKcRc98Um43aL2ipWbWG/AD4GzBG/983Y149DxwIz0wFWxBXxsL1K5FS03U8bEWK
        Z1K2di2KA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78g-0001cH-5M; Thu, 21 Jun 2018 21:29:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Varun Prakash <varun@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH 18/26] target/iscsi: Allocate session IDs from an IDA
Date:   Thu, 21 Jun 2018 14:28:27 -0700
Message-Id: <20180621212835.5636-19-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the session is never looked up by ID, we can use the more
space-efficient IDA instead of the IDR.  I think I found a bug where
we never reuse session ID 0, but there may be a good reason for it,
so I've merely documented it in this patch.  Not reusing session ID 0
doesn't even leak memory.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/target/iscsi/iscsi_target.c       | 10 ++--------
 drivers/target/iscsi/iscsi_target.h       |  4 +---
 drivers/target/iscsi/iscsi_target_login.c | 20 ++++++--------------
 3 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 8e223799347a..94bad43c41ff 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -57,9 +57,8 @@ static DEFINE_SPINLOCK(tiqn_lock);
 static DEFINE_MUTEX(np_lock);
 
 static struct idr tiqn_idr;
-struct idr sess_idr;
+DEFINE_IDA(sess_ida);
 struct mutex auth_id_lock;
-spinlock_t sess_idr_lock;
 
 struct iscsit_global *iscsit_global;
 
@@ -700,9 +699,7 @@ static int __init iscsi_target_init_module(void)
 
 	spin_lock_init(&iscsit_global->ts_bitmap_lock);
 	mutex_init(&auth_id_lock);
-	spin_lock_init(&sess_idr_lock);
 	idr_init(&tiqn_idr);
-	idr_init(&sess_idr);
 
 	ret = target_register_template(&iscsi_ops);
 	if (ret)
@@ -4375,10 +4372,7 @@ int iscsit_close_session(struct iscsi_session *sess)
 	pr_debug("Decremented number of active iSCSI Sessions on"
 		" iSCSI TPG: %hu to %u\n", tpg->tpgt, tpg->nsessions);
 
-	spin_lock(&sess_idr_lock);
-	idr_remove(&sess_idr, sess->session_index);
-	spin_unlock(&sess_idr_lock);
-
+	ida_free(&sess_ida, sess->session_index);
 	kfree(sess->sess_ops);
 	sess->sess_ops = NULL;
 	spin_unlock_bh(&se_tpg->session_lock);
diff --git a/drivers/target/iscsi/iscsi_target.h b/drivers/target/iscsi/iscsi_target.h
index 42de1843aa40..48bac0acf8c7 100644
--- a/drivers/target/iscsi/iscsi_target.h
+++ b/drivers/target/iscsi/iscsi_target.h
@@ -55,9 +55,7 @@ extern struct kmem_cache *lio_ooo_cache;
 extern struct kmem_cache *lio_qr_cache;
 extern struct kmem_cache *lio_r2t_cache;
 
-extern struct idr sess_idr;
+extern struct ida sess_ida;
 extern struct mutex auth_id_lock;
-extern spinlock_t sess_idr_lock;
-
 
 #endif   /*** ISCSI_TARGET_H ***/
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 99501785cdc1..561d2ad38989 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -336,22 +336,16 @@ static int iscsi_login_zero_tsih_s1(
 	timer_setup(&sess->time2retain_timer,
 		    iscsit_handle_time2retain_timeout, 0);
 
-	idr_preload(GFP_KERNEL);
-	spin_lock_bh(&sess_idr_lock);
-	ret = idr_alloc(&sess_idr, NULL, 0, 0, GFP_NOWAIT);
-	if (ret >= 0)
-		sess->session_index = ret;
-	spin_unlock_bh(&sess_idr_lock);
-	idr_preload_end();
-
+	ret = ida_alloc(&sess_ida, GFP_KERNEL);
 	if (ret < 0) {
-		pr_err("idr_alloc() for sess_idr failed\n");
+		pr_err("Session ID allocation failed %d\n", ret);
 		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
 		kfree(sess);
 		return -ENOMEM;
 	}
 
+	sess->session_index = ret;
 	sess->creation_time = get_jiffies_64();
 	/*
 	 * The FFP CmdSN window values will be allocated from the TPG's
@@ -1163,11 +1157,9 @@ void iscsi_target_login_sess_out(struct iscsi_conn *conn,
 		goto old_sess_out;
 	if (conn->sess->se_sess)
 		transport_free_session(conn->sess->se_sess);
-	if (conn->sess->session_index != 0) {
-		spin_lock_bh(&sess_idr_lock);
-		idr_remove(&sess_idr, conn->sess->session_index);
-		spin_unlock_bh(&sess_idr_lock);
-	}
+	/* Um, 0 is a valid ID.  I suppose we never free it? */
+	if (conn->sess->session_index != 0)
+		ida_free(&sess_ida, conn->sess->session_index);
 	kfree(conn->sess->sess_ops);
 	kfree(conn->sess);
 	conn->sess = NULL;
-- 
2.17.1

