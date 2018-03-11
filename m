Return-Path: <kernel-hardening-return-12401-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtCwRkk/BdNPLRL0/+Oy0+O3bxw+Uwmhrg+Ay/utLI87nu6LfbPI7C51CjXEtUFHYIXySf+
ARC-Seal: i=1; a=rsa-sha256; t=1520802624; cv=none;
        d=google.com; s=arc-20160816;
        b=Qr+ASBALrgw84uO44LAF3UCOvNC22uTdGu5aUS4omBebq7Sgv0EP6wK03U0MqWSonE
         0wAWhs10s99MkngBZhQxDCbJBtZYMfhqjdFsohEMYs249zJrg0jTBDRtH+jkeA9cWVJd
         Z92UmcGPqv1nrcxYRk+c0GzLwR/TlxjiY97syrJhZPMSfnrxlJ/SGqQHZFSP4doliGuq
         Dyp3fJUlfXIk0s7clK86IrwQRJN0o7W5/WPqrLGA9ALCAsHy10oh8qQqUKvIBfEg16Ba
         FvjyIiZhIrn2fIWFPBKx3yPHhUjY695dxlq96rWRHeJBKQRiw4Jf1asFxgtJRERE/y1Y
         nFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=M4Md3pv3NeiD1GgCHnYlv2PH6GeQaI2kGLg20hAVPaM=;
        b=evvgRM4+VMRBQdNOsgVPnLRS9yyc2s/q5fJLnNW9ZBwHpousl/a+XnnvJovhNerhdo
         A1PSL1eoyNzxo1QHJjqsGXizoWP1Bg+Ho1mf+4wxnhuzSRFkhS2uxUP3SWduFBWhrykX
         3eN/nBIv3s8kGPv0MMk7S40oG90FmNWLY92mMgUjRuhhqEu18aULfF36qVFFUkXau+gO
         13cdilnsFy4dtblsjBtlUnCcqs9BPxnGOVLKjCKn8kAiXfrj4NQ2//b23n8Yse6GBPbV
         JBXlo8DNjfhBYTQMU/IMkRUY12Ts9+EbKDiTi6vvFysWxGwMyAr12Wp51UlaKDORwVkb
         sMBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kMOkZF63;
       spf=pass (google.com: domain of kernel-hardening-return-12401-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12401-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kMOkZF63;
       spf=pass (google.com: domain of kernel-hardening-return-12401-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12401-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 2/2] net: rds: drop VLA in rds_walk_conn_path_info()
Date: Sun, 11 Mar 2018 22:07:50 +0100
Message-Id: <1520802470-17374-2-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
References: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677132836039871?=
X-GMAIL-MSGID: =?utf-8?q?1594677132836039871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid VLA[1] by using an already allocated buffer passed
by the caller.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 net/rds/connection.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index f80792c..abef75d 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -578,9 +578,9 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 				    struct rds_info_iterator *iter,
 				    struct rds_info_lengths *lens,
 				    int (*visitor)(struct rds_conn_path *, void *),
+				    u64 *buffer,
 				    size_t item_len)
 {
-	u64  buffer[(item_len + 7) / 8];
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -649,8 +649,11 @@ static void rds_conn_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens)
 {
+	u64 buffer[(sizeof(struct rds_info_connection) + 7) / 8];
+
 	rds_walk_conn_path_info(sock, len, iter, lens,
 				rds_conn_info_visitor,
+				buffer,
 				sizeof(struct rds_info_connection));
 }
 
-- 
1.9.1
