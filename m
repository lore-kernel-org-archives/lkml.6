Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoamKgddp8N+sfEcQtgYbZz/ahl7pBrLQridBVCO+bf+rMMVG4bOgm2AzVR21FegVk5R8hm
ARC-Seal: i=1; a=rsa-sha256; t=1526631480; cv=none;
        d=google.com; s=arc-20160816;
        b=UgJbIYs9p///9TFglZQVFYYy8VWY7J4I3/DS/XwzG0ZvMvuCZNmnQClE6iYUF0qKf+
         M7XP/DnoWa/2P+4SfzLsfrkx61cOd8gNQVW3waJj5HeRawhfX2i4RMUOccTjJVni3w4D
         SEfFJ9OW1zzf7gwJ7ntgfyjGwq5lHy7dTA8GdRy8CVVpV5c0LndkRkcDrNGswo4xM9ol
         ASSMFpfncNjFvzRWO+cIpKUofOdFNbiTQn85op6AIiDw8XGrz8/hL2TOfoWof3mMjZp2
         fA+WTqDzAZIiCtUN56e9uCgy8dxS5MWbOghctfq9Na4BehoM4Oa6iDHUPRsqcCP39qgD
         7DLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=WQhYPT2Iak125x7/g5wrIuz15zoBk69h/BzTOM0w79g=;
        b=E1g2f5gur0A5Exel9W9b1LMe0KiMDWvPQA2l5XgGOUXWJner0A8sdzS75m+xLjPBi9
         FrVVEgr5WvWu8Paf0y/BwSOhoz70ol3Za8qwAsX5UNfS8LWpCjpgq4Ax+gN0k/nXZFLb
         aFii4FyTPNMHwu7wRpKdQWlL22Tsqy7fBOdEYO4a85r7pMgC7nnK6TomwPvZezM2ka2W
         IaHC0LEER5Sm6yvfs67tkEQP02/eUawj6EaOJmw3mUJGutxLDfOGUQbbHHbqOwGdPw3l
         l9XuDlY26dnSPHBm7sh+ay1qJYbzcwmm3YadUvSAdLfBF+3X1qpFh2ODkMigwtVZm0QL
         BgSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xi4sTjUj;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xi4sTjUj;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Talat Batheesh <talatb@mellanox.com>,
	Mark Bloch <markb@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.16 35/55] net/mlx5: Avoid cleaning flow steering table twice during error flow
Date: Fri, 18 May 2018 10:15:31 +0200
Message-Id: <20180518081459.131254817@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789131160542701?=
X-GMAIL-MSGID: =?utf-8?q?1600789131160542701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |   23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -185,6 +185,7 @@ static void del_sw_ns(struct fs_node *no
 static void del_sw_hw_rule(struct fs_node *node);
 static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
 				struct mlx5_flow_destination *d2);
+static void cleanup_root_ns(struct mlx5_flow_root_namespace *root_ns);
 static struct mlx5_flow_rule *
 find_flow_rule(struct fs_fte *fte,
 	       struct mlx5_flow_destination *dest);
@@ -2329,23 +2330,27 @@ static int create_anchor_flow_table(stru
 
 static int init_root_ns(struct mlx5_flow_steering *steering)
 {
+	int err;
+
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
-
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
