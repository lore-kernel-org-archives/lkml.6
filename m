Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/n9ML9nlh1Nq9nKY1CTQ5rWUnglWA/RXkdPFSyFejq0sCmkVtxnlzG7NEZLL37QQ3OzcDz
ARC-Seal: i=1; a=rsa-sha256; t=1523473291; cv=none;
        d=google.com; s=arc-20160816;
        b=QoNiXmM1G3x/jzoODlANOya6mjNWsAWLpaNjLcplL5VttaMWdjS4AK1wlvixWG0ryF
         mF5wMTdLZdfynZ4DsGw9B+P0qUUPfFzB37EZIpMbgoBvu8VPVgFIeaR0/5hvqihTRvNO
         VUtw3Vb985g8/1aQK4oV7O4SQIzZi41BH2Kw3qhkXa8YUlbi0qFVXz0+frrbJonPLrdn
         JtvilCqcU2QbNi3p04H8LI7OfuxkTXWNMuiqcjYpoDn4VPLXgfvkfcT4Vsay00CRxUu7
         NitPHndBa1733qn5k7ru0WiNV8OxfIh2kGBKZZ0Y25eERfOuLUVsbWRk1voeqJcdyAVX
         D7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Scd9uQKFulhAs/gGBdgX78dwFuZWOfC7yqUG3fvpAg4=;
        b=QvX1XURHfPDVzWosskNjrVAFdZhfjuC0zpCm/OIRm1uzeVodCcXX81Ccr2od110FA4
         GuUPDZvUSgt+40fFV1gzT6Ff5sUcCJFrQY5MqooVANv/WiN/YJAzfDGAvcv27wfXFB/I
         EH09qOl8y1jyl4ld/5aa6MKcKAbtksTp5862v3Qx73Hd5Lhg3eq6kDB8QZ7JA7n+5zax
         6aWRx+W2StqYSuEkPv9Op0SGq8EnfwNzP1rL+MTkJ8awFc4nc0fdYzqEOmiLVk+jBgpT
         bK6KMetCZT4dnlmTcdgpzVPIj4NV4OAFLJVlvWfeJP9QHZcCLb/aWmjOa1mdRf4j3Bs+
         6iUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ido Shamay <idos@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 194/310] net/mlx4: Check if Granular QoS per VF has been enabled before updating QP qos_vport
Date: Wed, 11 Apr 2018 20:35:33 +0200
Message-Id: <20180411183630.941781064@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476734645931468?=
X-GMAIL-MSGID: =?utf-8?q?1597477530092492740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Shamay <idos@mellanox.com>


[ Upstream commit 269f9883fe254d109afdfc657875c456d6fabb08 ]

The Granular QoS per VF feature must be enabled in FW before it can be
used.

Thus, the driver cannot modify a QP's qos_vport value (via the UPDATE_QP FW
command) if the feature has not been enabled -- the FW returns an error if
this is attempted.

Fixes: 08068cd5683f ("net/mlx4: Added qos_vport QP configuration in VST mode")
Signed-off-by: Ido Shamay <idos@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/qp.c               |    6 ++++++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |   16 +++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -487,6 +487,12 @@ int mlx4_update_qp(struct mlx4_dev *dev,
 	}
 
 	if (attr & MLX4_UPDATE_QP_QOS_VPORT) {
+		if (!(dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_QOS_VPP)) {
+			mlx4_warn(dev, "Granular QoS per VF is not enabled\n");
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
 		qp_mask |= 1ULL << MLX4_UPD_QP_MASK_QOS_VPP;
 		cmd->qp_context.qos_vport = params->qos_vport;
 	}
--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -5214,6 +5214,13 @@ void mlx4_delete_all_resources_for_slave
 	mutex_unlock(&priv->mfunc.master.res_tracker.slave_list[slave].mutex);
 }
 
+static void update_qos_vpp(struct mlx4_update_qp_context *ctx,
+			   struct mlx4_vf_immed_vlan_work *work)
+{
+	ctx->qp_mask |= cpu_to_be64(1ULL << MLX4_UPD_QP_MASK_QOS_VPP);
+	ctx->qp_context.qos_vport = work->qos_vport;
+}
+
 void mlx4_vf_immed_vlan_work_handler(struct work_struct *_work)
 {
 	struct mlx4_vf_immed_vlan_work *work =
@@ -5328,11 +5335,10 @@ void mlx4_vf_immed_vlan_work_handler(str
 					qp->sched_queue & 0xC7;
 				upd_context->qp_context.pri_path.sched_queue |=
 					((work->qos & 0x7) << 3);
-				upd_context->qp_mask |=
-					cpu_to_be64(1ULL <<
-						    MLX4_UPD_QP_MASK_QOS_VPP);
-				upd_context->qp_context.qos_vport =
-					work->qos_vport;
+
+				if (dev->caps.flags2 &
+				    MLX4_DEV_CAP_FLAG2_QOS_VPP)
+					update_qos_vpp(upd_context, work);
 			}
 
 			err = mlx4_cmd(dev, mailbox->dma,
