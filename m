Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq8Dzw0qvxSreQHgxjREdCl7s4EU851iNwnNUKpgAQ2deSaxaFx3JiqANFhg9Lq5AXcTpBQ
ARC-Seal: i=1; a=rsa-sha256; t=1526631714; cv=none;
        d=google.com; s=arc-20160816;
        b=uGE1JYJw/YWDeb3n7eb5vbh08F2pzTQC2Y7Pix1V1zxyFyWQGCJPfpzHFrvwSYfhNp
         3fKSuPrstm22kCCdSGyJkFpC0S6xc91eyxtKI/BpYAIxjB6SSLbLczI/UvutBSoBT1yq
         PXjpZSsK7xZkeJm1rgvZxPU4ANKmGUuW8f4jfdYSL3gaKu+9nLxRqot5JDfkoG26GJAx
         ui1HcyAmUorB37aAcn8a50qKLEmRTxVNbinTW4fsaqyy8f3P2Rv5Q6ZyPIEYxafZchQD
         EoRiLvMb8nrUBQ+bm9Oy1t9ZBpAcJmHm8jDvKhvS7sI7ku9eO8p10pLllNYeZPhWz5kN
         SOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AJsFpsgEs5lTeHRmnZImKWqoPuHKbH4k3eBWrpWTvP8=;
        b=vLh/GBPAQG3SfFmK05MofSc4cOfIY1TY6r3QpslK6UmOeolkkkpB3uS6CJYTII+d5l
         iQ7pJCHc313xjVBGXF0VN7faQmizJJbvq/xbocyrjfmKrj/VbRAIEofLPyR0CHOckeut
         qiYwht9rdP9DkkBEspwn35G78S9Im5OgKcqhla/dKaBNKq39Mk81y9NP/azeJnQV8FOg
         CUcrbXQMkIqI9BiBInnpxHZ64f+cIk3tqjdOZ3mN4pWexlw8Z9G0PQZ0SSWaqDIWHjTv
         1DMBqWJW5mhMXw+Pnkb2o3FYEvxq2EqXZHGvB+YXFNEg26t41GmqMfwEdI9F9k1zYOuv
         +bsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D5e/2AXv;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D5e/2AXv;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Talat Batheesh <talatb@mellanox.com>,
	Mark Bloch <markb@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 21/33] net/mlx5: Avoid cleaning flow steering table twice during error flow
Date: Fri, 18 May 2018 10:16:00 +0200
Message-Id: <20180518081535.945164406@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789131160542701?=
X-GMAIL-MSGID: =?utf-8?q?1600789377256983075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Talat Batheesh <talatb@mellanox.com>

[ Upstream commit 9c26f5f89d01ca21560c6b8a8e4054c271cc3a9c ]

When we fail to initialize the RX root namespace, we need
to clean only that and not the entire flow steering.

Currently the code may try to clean the flow steering twice
on error witch leads to null pointer deference.
Make sure we clean correctly.

Fixes: fba53f7b5719 ("net/mlx5: Introduce mlx5_flow_steering structure")
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -153,6 +153,7 @@ static void del_rule(struct fs_node *nod
 static void del_flow_table(struct fs_node *node);
 static void del_flow_group(struct fs_node *node);
 static void del_fte(struct fs_node *node);
+static void cleanup_root_ns(struct mlx5_flow_root_namespace *root_ns);
 
 static void tree_init_node(struct fs_node *node,
 			   unsigned int refcount,
@@ -1690,24 +1691,28 @@ static int create_anchor_flow_table(stru
 
 static int init_root_ns(struct mlx5_flow_steering *steering)
 {
+	int err;
 
 	steering->root_ns = create_root_ns(steering, FS_FT_NIC_RX);
 	if (!steering->root_ns)
-		goto cleanup;
+		return -ENOMEM;
 
-	if (init_root_tree(steering, &root_fs, &steering->root_ns->ns.node))
-		goto cleanup;
+	err = init_root_tree(steering, &root_fs, &steering->root_ns->ns.node);
+	if (err)
+		goto out_err;
 
 	set_prio_attrs(steering->root_ns);
 
-	if (create_anchor_flow_table(steering))
-		goto cleanup;
+	err = create_anchor_flow_table(steering);
+	if (err)
+		goto out_err;
 
 	return 0;
 
-cleanup:
-	mlx5_cleanup_fs(steering->dev);
-	return -ENOMEM;
+out_err:
+	cleanup_root_ns(steering->root_ns);
+	steering->root_ns = NULL;
+	return err;
 }
 
 static void clean_tree(struct fs_node *node)
