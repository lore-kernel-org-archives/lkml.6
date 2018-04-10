Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/nJA5efLC2hOzSnbWSJI+6c3dYzGSwhAWSVgxLdGqNScu4p2CrNf7slYdtZHBKAKkAwiL2
ARC-Seal: i=1; a=rsa-sha256; t=1523399300; cv=none;
        d=google.com; s=arc-20160816;
        b=JmDmgqH1YdC9YtOfhc/lOdqva7gN2EyR59HRtaN8uaTxm72avKI3OLf2ES6CmIHdrz
         9cSU3cvsyHhPE8SYcNGoPF+/QYYQ1UnrEyq2I+Itar+PbM9Qej7yR1FvmQ6iOIGbplCH
         ozcJvv0WZlDegpW633swkOgRaFKUqe1ZtB5hKL56sR53h6fmV+QCcho5BEhHA7seeSNv
         d3uvjy6ga8UmGY9TNXkIlDAOv2fNiEmXCfl3+xcd3yPLBry61E0Rrxwf8InR0WNykuSo
         //LgeYDw5g00a12DsXVlXlQh/siol1nUMyQrdze0oFfsrRPVE/2Ifqp0aRcyrt4eJ88x
         rfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CHpVUMOiwffBCGW1kvpi+dPnHRU+8xCtK79+hIGb9QE=;
        b=RMB3TJnH5amXpC3opuXXlUdFphINL3Jnv5DHkGNp4WhLnZB966SJWkU6ivDZCjhQR7
         19W/1/0zSTc1ce3i9ciGjAwszkzNkHdR2e5JFqbXFyoQbThtZMNljHOAKiJoKjWVLpNU
         ROVzXuhdGVCazsMwVnglFPe/MCEKNTEJgnCxJNU5aSMHcqauQqIfCWaNyutNLIHNMpg9
         jroL+Ui7IeabqAk7qaJAgiLR79xuU3hj8upR7YFLSbznSbIBqi2gk7D8vCfhrwvHeA4q
         PeXJ6kz7xjO3I641g/tEBbxckOIsoaJ2O8fDDj3zf631yCYF+Ni+nNtiriO4FfkBYQtx
         Bjbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Alex Estrin <alex.estrin@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 037/168] IB/ipoib: Fix for notify send CQ failure messages
Date: Wed, 11 Apr 2018 00:22:59 +0200
Message-Id: <20180410212801.774621395@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399944991430694?=
X-GMAIL-MSGID: =?utf-8?q?1597399944991430694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Estrin <alex.estrin@intel.com>


[ Upstream commit 809cb6955650d892c6ef95f1d55f28fceded0ce1 ]

If IB_CQ_REPORT_MISSED_EVENTS flag is passed in ib_req_notify_cq()
it may return positive value indicating non-empty CQ.
If return code not verified the log might be flooded with false
warning messages "request notify on send CQ failed".

Fixes: 8966e28d2e40 ("IB/ipoib: Use NAPI in UD/TX flows")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c |   10 ++++++----
 drivers/infiniband/ulp/ipoib/ipoib_ib.c |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -766,12 +766,14 @@ void ipoib_cm_send(struct net_device *de
 	skb_orphan(skb);
 	skb_dst_drop(skb);
 
-	if (netif_queue_stopped(dev))
-		if (ib_req_notify_cq(priv->send_cq, IB_CQ_NEXT_COMP |
-				     IB_CQ_REPORT_MISSED_EVENTS)) {
+	if (netif_queue_stopped(dev)) {
+		rc = ib_req_notify_cq(priv->send_cq, IB_CQ_NEXT_COMP |
+				      IB_CQ_REPORT_MISSED_EVENTS);
+		if (unlikely(rc < 0))
 			ipoib_warn(priv, "IPoIB/CM:request notify on send CQ failed\n");
+		else if (rc)
 			napi_schedule(&priv->send_napi);
-		}
+	}
 
 	rc = post_send(priv, tx, tx->tx_head & (ipoib_sendq_size - 1), tx_req);
 	if (unlikely(rc)) {
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -644,7 +644,7 @@ int ipoib_send(struct net_device *dev, s
 
 	if (netif_queue_stopped(dev))
 		if (ib_req_notify_cq(priv->send_cq, IB_CQ_NEXT_COMP |
-				     IB_CQ_REPORT_MISSED_EVENTS))
+				     IB_CQ_REPORT_MISSED_EVENTS) < 0)
 			ipoib_warn(priv, "request notify on send CQ failed\n");
 
 	rc = post_send(priv, priv->tx_head & (ipoib_sendq_size - 1),
