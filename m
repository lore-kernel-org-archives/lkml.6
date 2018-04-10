Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+CZJZO8uODLS3tS0U4rdLSIc3SB4Cyyech9IAwhfZuvqxaXCbG446A+yu1NXicTRrFu7i+
ARC-Seal: i=1; a=rsa-sha256; t=1523399564; cv=none;
        d=google.com; s=arc-20160816;
        b=wYs1pzNTcUJY1N/qWGD/ltcCq3AzG81CfUXIfkd4Q+gdXO3qdMK0xOVSGyUHtbIyaJ
         mcFG1xIqN09+jylwY5/aCxvxMdcy8XCZAYeZ+o4uQf6aO6o57OP2eGjd/u8DLh7n/MjP
         pFkXyWwfyXEYU/Emu+1JYV2BX56Z5f0s43k5rfPPhpa1Mp282214n9kL/8m9KBzE4dr/
         vmG9cTLFYfMDwSwVdKbNGTmFtbZaJFmsFH4vVkhQKGhBK4A7xQaEGTtrXkmai0pgb3P0
         Wshh7RanO4oFYo+7A79WdjtdceIqRtsWVAp+j/zgzGStvHftMShHPL1MICRqC/449Jvv
         9+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7UQV4E1ZEORC77wBOah8F412WCsgb82mOL9dWxHFSsw=;
        b=T/2f7Co6Be06DBt2t/MeqkI238hMtxYW0Pj4ouQbozO7d0CYuDBZnRmpDQeht2rx/m
         C1WLrq+wok/uwPqrd5j/pFY22wLQgtqYrTRWFrPidCEncDjSAUUDgRXfBgfdXYqGNSVf
         YdiAu3xvPJuy3dy4f1BXXI2qnO3DW+8BnTn7OP5liQc5Yoa/RaFtlN9zv36HPYOk8kw7
         lFnER+ZOgZzONjGjBtCUpOa4kIliYGaXnTrbl9D4azPfIWC7EWbJzGMHnysymcnjV/E0
         efrlAxux0+zbAW3g3lo4GxDpQ6Spn7YYgGPF9zDkun+kSN3Ju2fZ+WwV47A5qbFqsinf
         Gfxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianbo Liu <jianbol@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Roi Dayan <roid@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 153/168] net/mlx5e: Fix memory usage issues in offloading TC flows
Date: Wed, 11 Apr 2018 00:24:55 +0200
Message-Id: <20180410212807.585405833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400221014414332?=
X-GMAIL-MSGID: =?utf-8?q?1597400221014414332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@mellanox.com>


[ Upstream commit af1607c37d9d85a66fbcf43b7f11bf3d94b9bb69 ]

For NIC flows, the parsed attributes are not freed when we exit
successfully from mlx5e_configure_flower().

There is possible double free for eswitch flows. If error is returned
from rhashtable_insert_fast(), the parse attrs will be freed in
mlx5e_tc_del_flow(), but they will be freed again before exiting
mlx5e_configure_flower().

To fix both issues we do the following:
(1) change the condition that determines if to issue the free call to
    check if this flow is NIC flow, or it does not have encap action.
(2) reorder the code such that that the check and free calls are done
    before we attempt to add into the hash table.

Fixes: 232c001398ae ('net/mlx5e: Add support to neighbour update flow')
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2102,19 +2102,19 @@ int mlx5e_configure_flower(struct mlx5e_
 	if (err != -EAGAIN)
 		flow->flags |= MLX5E_TC_FLOW_OFFLOADED;
 
+	if (!(flow->flags & MLX5E_TC_FLOW_ESWITCH) ||
+	    !(flow->esw_attr->action & MLX5_FLOW_CONTEXT_ACTION_ENCAP))
+		kvfree(parse_attr);
+
 	err = rhashtable_insert_fast(&tc->ht, &flow->node,
 				     tc->ht_params);
-	if (err)
-		goto err_del_rule;
+	if (err) {
+		mlx5e_tc_del_flow(priv, flow);
+		kfree(flow);
+	}
 
-	if (flow->flags & MLX5E_TC_FLOW_ESWITCH &&
-	    !(flow->esw_attr->action & MLX5_FLOW_CONTEXT_ACTION_ENCAP))
-		kvfree(parse_attr);
 	return err;
 
-err_del_rule:
-	mlx5e_tc_del_flow(priv, flow);
-
 err_free:
 	kvfree(parse_attr);
 	kfree(flow);
