Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/aaAavDozZp2esDniCZ75zPb4cBG7kUhn/u8rmbHgCSZEimHyqvI3A9C2h+KjVWscTG0Rc
ARC-Seal: i=1; a=rsa-sha256; t=1523399956; cv=none;
        d=google.com; s=arc-20160816;
        b=XrrAR4fzp58i1DDqSBr3kG2uW6jeZDkuYfq5Rxi2Vffl4ut6MaK7I0aNIni/KIbq9t
         dSNqAqaiK/wYQ2nr3Auqedep6CEAl4hsn1MEZJEeLvr4FZpJO07cOzQphMdHdfGUDTXZ
         zX65NUI5fDCzRZRv91PvVYrwJYzrqjUUOftQmREeHBrRm7KSens0z5UVVGrTp6MGiDMM
         M7h0gFq6qJ2WFtve3i+DgphvFb169QZQdvAj46tT+rEoNjx/CvYDmKiyN1mxs4X6InP+
         TWyI13gcmnKM8NIWk7NccA7oh+w7PrcfrP411gzaWqGXqe1RTknITtyCovgjDNAuLLIj
         UlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bSwexh5GL0BoZompddBnnAULm+bu0VS5VbZbgTEgsyc=;
        b=lkufPc9LD9Oq/hmyikyfsZc28lMxNetcweqdCNRaHq8UnDFCyNOQvO43QGAD/3NTU6
         6jI0SLb6Q+y91fk250brlRAM3ifSejTydNbctlRjduG+dYD9HqV1dlmvfYFwLJtqp9Uo
         z4Ml99odNCR2AIkAefUR5Z8X7iSA+361N3gKi7TW9YH45sljk2q6f638yyrVGbhl4zYp
         RmLLbWzFotYcpLnvtCXDGpZSgdssXzfQdJ9t4J49QbwzDhy6GTHe0UmeQGjv8UINp0sJ
         xidwa3K/FdQtqAWbJvg8sF2faEJAKuXr65GP5bpKAebHKieJ6wkRNIPUjZrtysLgpMRY
         ODTA==
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
Subject: [PATCH 4.14 124/138] net/mlx5e: Fix memory usage issues in offloading TC flows
Date: Wed, 11 Apr 2018 00:25:14 +0200
Message-Id: <20180410212916.611431195@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400221014414332?=
X-GMAIL-MSGID: =?utf-8?q?1597400633154120683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2091,19 +2091,19 @@ int mlx5e_configure_flower(struct mlx5e_
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
