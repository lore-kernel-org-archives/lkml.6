Return-Path: <kernel-hardening-return-12400-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsmkd4dLV4OoErZ6oOf3KwneZUdCsXjn2e9iSQZJC/aR+6qKsksPfTmSPecwINZzwEg8I5r
ARC-Seal: i=1; a=rsa-sha256; t=1520802608; cv=none;
        d=google.com; s=arc-20160816;
        b=uegVUcm6ZpjcfKpGwLeSTFAJoje99ObHtt0qmO+p4scKs4R4rhNkF/ShHZBdAEDI8L
         8y2swoCwKE0ENCYEPZmBygbSCD0NRTESxObOi4UcInUYE3MpIiUkhEgqsAcTZAiTI2+u
         jElwgurPE/MHK5HYRqoyU/eMs6Ouz1TLsPwVcCw4Mo5pdX52JzB0S9d04nUz7yjTjrdY
         9IRx6YU0zxAuYpnbjRRxhWXQHYySfDiSqWnhd6JlrQJ2jspDIPDa7iTue6F9qSihSqnz
         sssHFLBc258HFtQ8g65Y+ptodX/iZT7yLJP76Tk0xhFnz1MkTNfSut5cTuusglT9xl9s
         zQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ASBoo/iq4FnQZM67OtjBA1CkBLKa93AR6pHEA4zVrsA=;
        b=p4yV2f++keE7iw5NCFa5d8fobh3lTB6m1H4811HtERuUgCFrQWl1myAxHQOQcNJBVd
         nC0EjJgKsIOOdMwQVWQzFN2pnZ+9rvekKB1qujco1l2nnHUtwRqmWRnqWPrPH66LUy8N
         QHpDV3R/5Cd1Ag8yuy9GXShfdrJCsh8RI/so6LVJirAxM82lwEKkiAY8MwG3fwv/cmFn
         s/tZENBZLZt1VfPCkHZZONxjGrfO/TGYz73pQfL86EDZG8jRlyIa9AUu4F8YlTOsSghQ
         dwDdX+Of8167AdohA8dVey3mJPIgKJHWb2gsgwPvvKfeZ4WPN3MTa8MiWt8Pq1iF28ZM
         Udjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IRCQpDnS;
       spf=pass (google.com: domain of kernel-hardening-return-12400-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12400-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IRCQpDnS;
       spf=pass (google.com: domain of kernel-hardening-return-12400-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12400-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: [PATCH 1/2] net: rds: drop VLA in rds_for_each_conn_info()
Date: Sun, 11 Mar 2018 22:07:49 +0100
Message-Id: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677115997192072?=
X-GMAIL-MSGID: =?utf-8?q?1594677115997192072?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid VLA[1] by using an already allocated buffer passed
by the caller.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 net/rds/connection.c | 2 +-
 net/rds/ib.c         | 3 +++
 net/rds/rds.h        | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 2da3176..f80792c 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -540,9 +540,9 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens,
 			  int (*visitor)(struct rds_connection *, void *),
+			  u64 *buffer,
 			  size_t item_len)
 {
-	uint64_t buffer[(item_len + 7) / 8];
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
diff --git a/net/rds/ib.c b/net/rds/ib.c
index 50a88f3..02deee2 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -321,8 +321,11 @@ static void rds_ib_ic_info(struct socket *sock, unsigned int len,
 			   struct rds_info_iterator *iter,
 			   struct rds_info_lengths *lens)
 {
+	u64 buffer[(sizeof(struct rds_info_rdma_connection) + 7) / 8];
+
 	rds_for_each_conn_info(sock, len, iter, lens,
 				rds_ib_conn_info_visitor,
+				buffer,
 				sizeof(struct rds_info_rdma_connection));
 }
 
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 7301b9b..91ea08f 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -709,6 +709,7 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens,
 			  int (*visitor)(struct rds_connection *, void *),
+			  u64 *buffer,
 			  size_t item_len);
 
 __printf(2, 3)
-- 
1.9.1
