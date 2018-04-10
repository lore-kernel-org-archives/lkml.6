Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49F5/CSjFEzEuE1tmB6jeVUC9H+sF7UiEXfhBE3yzy/i7c/dkIsYZo3zvZuQBFuWuU9aUnZ
ARC-Seal: i=1; a=rsa-sha256; t=1523399607; cv=none;
        d=google.com; s=arc-20160816;
        b=Dh/Eaz+YvAYoWiCMc4XOjSnsvTaK1EonH9qv7d8Nzsph6io85yddma2Q5/M8Vt7lbZ
         XMdm/HjyByGePD5wLx59gvmszsn6LUcQa6IbdQHakdk6n02PuLpBoTKvGYT4oFezl+ay
         dGH87lDXmME8VjevTsrds9yZBPdcbsPYFZW3sNMLRzg5er3fZtOR80d2FoFfmiDWW7p5
         XCikV3bjPOvycnj52fZh5T6oJYGCGT+uLPqQSr5sOPqf7Dr+OWA5lJ92UPDRWl/6hK8u
         bejap80gA0u/jqhzDE+ifbX6tun5QZ6Tk0htqjKT2wj5SRlz1n/L8VdIIH7r9hOVekGw
         rkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2jAhZYT/2fTTZEmvKn3+3TwA3M3JPWkIfYJRvND8fs4=;
        b=gxWHmCygjXLu8OzPRantDbezEBEHCEwcuoAJaZFCUiIBi6lAXR9v94yVknoQwYzi9B
         gDFlGJoWRsa68N7hpUJz1vS7DpA9jfVwvbiuVZJP4x45A6XGoHDgVoXhhKhZkE07nX1i
         ts6MgssIh0LqovnT/WdaLDDmUz3TU0vVRThm7htLges/ylBHaKPZlZdmfRjU+DCLQVv5
         dUJkdPVg3NrVeciuRQv9dyOejtQUeSg6SYcEcSau61drJPBlWXgzHdqTiv2lLmp4Idb3
         VHCHZlI3f4wZ9VYtKdFYybzN1QTwq+qyBYYEYLKssAkAZ1bkVp9qQK2vPxz62AiwA0Vb
         vsVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianbo Liu <jianbol@mellanox.com>,
	Roi Dayan <roid@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 157/168] net/mlx5e: Dont override vport admin link state in switchdev mode
Date: Wed, 11 Apr 2018 00:24:59 +0200
Message-Id: <20180410212807.770093779@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400266858760846?=
X-GMAIL-MSGID: =?utf-8?q?1597400266858760846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@mellanox.com>


The vport admin original link state will be re-applied after returning
back to legacy mode, it is not right to change the admin link state value
when in switchdev mode.

Use direct vport commands to alter logical vport state in netdev
representor open/close flows rather than the administrative eswitch API.

Fixes: 20a1ea674783 ('net/mlx5e: Support VF vport link state control for SRIOV switchdev mode')
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -611,7 +611,6 @@ static int mlx5e_rep_open(struct net_dev
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
-	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	int err;
 
 	mutex_lock(&priv->state_lock);
@@ -619,8 +618,9 @@ static int mlx5e_rep_open(struct net_dev
 	if (err)
 		goto unlock;
 
-	if (!mlx5_eswitch_set_vport_state(esw, rep->vport,
-					  MLX5_ESW_VPORT_ADMIN_STATE_UP))
+	if (!mlx5_modify_vport_admin_state(priv->mdev,
+			MLX5_QUERY_VPORT_STATE_IN_OP_MOD_ESW_VPORT,
+			rep->vport, MLX5_ESW_VPORT_ADMIN_STATE_UP))
 		netif_carrier_on(dev);
 
 unlock:
@@ -633,11 +633,12 @@ static int mlx5e_rep_close(struct net_de
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
-	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	int ret;
 
 	mutex_lock(&priv->state_lock);
-	(void)mlx5_eswitch_set_vport_state(esw, rep->vport, MLX5_ESW_VPORT_ADMIN_STATE_DOWN);
+	mlx5_modify_vport_admin_state(priv->mdev,
+			MLX5_QUERY_VPORT_STATE_IN_OP_MOD_ESW_VPORT,
+			rep->vport, MLX5_ESW_VPORT_ADMIN_STATE_DOWN);
 	ret = mlx5e_close_locked(dev);
 	mutex_unlock(&priv->state_lock);
 	return ret;
