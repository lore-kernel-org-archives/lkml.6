Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoKLl3Cmgm/bbmHfYkROjlJq/BEID5TxR1Mqd6lDu10u9usfHreeDhzvT/dKbsAzPeqyRES
ARC-Seal: i=1; a=rsa-sha256; t=1526631625; cv=none;
        d=google.com; s=arc-20160816;
        b=OmiGSoFpM1mRsuMjV5fs/nt7J9Vck4E7jE8f9xiryKe6e+Vvc7T85mJ7Lu4HTyscWN
         6hHZt2wM+uc7TUovfWHdN8nMN4B6JYWEPBVBCOugYyyY/U5+vTbRwlSp1EB4KH19gJ9z
         km8D02xT6g9MMDszcWEHXRdX5uSmy1SLKy3K1kHED3ZnGf1W0kSr4QgKhuTlUncMm5gp
         hS9vWRr6B8D67cBZYerNEwzzsdd4xwwgYTp2/95qD1h7T3rpFa7zCDQNAZDb3Oie+r4n
         hNaABe1sCB3vJats7rwkawOQp5O1z5RQk2IM513d+1FKgrZGzHr80clu0iJCEXOHc/IR
         3lDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3TKUZSCgCJeZi0o0Mci9dhDJ/bPvdPcVyIkPLZZXkQs=;
        b=CS2gdAEyxFmNDvXhvUNRfx+LpvWEB1YCpyT8XjuHZVsMZOXF0i621psS9tndI+vLPR
         ZVlAjIUL/rLQgBSu/ta4Jz26aWW90X1NkKf9RmxK9bwD1JSlNva/1wT7TcVqbY3yUVuW
         IsfBFiRcAY0TYEhMmFfDZcA6VNqm6DU423IVsoqXkfmxcSEJ31rlgCJqW907cI+HynfM
         VdkFrcIvOWyMPo/zfstYNS0tXYUtrAFQJ3VzrLFKEU/jkH+clAtvY0/tbQgsw28mwAuY
         n/49J2vX0O0Ge4hHa4ZCf5oJ5w1QfIz3SwIS1zjtYTtUvSegMHFiUlYsRue/JIjR05OS
         O7sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XS8dKfyq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XS8dKfyq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Talat Batheesh <talatb@mellanox.com>,
	Mark Bloch <markb@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 34/45] net/mlx5: Avoid cleaning flow steering table twice during error flow
Date: Fri, 18 May 2018 10:15:51 +0200
Message-Id: <20180518081532.105503583@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789131160542701?=
X-GMAIL-MSGID: =?utf-8?q?1600789283491612392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -174,6 +174,7 @@ static void del_flow_group(struct fs_nod
 static void del_fte(struct fs_node *node);
 static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
 				struct mlx5_flow_destination *d2);
+static void cleanup_root_ns(struct mlx5_flow_root_namespace *root_ns);
 static struct mlx5_flow_rule *
 find_flow_rule(struct fs_fte *fte,
 	       struct mlx5_flow_destination *dest);
@@ -2041,23 +2042,27 @@ static int create_anchor_flow_table(stru
 
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
