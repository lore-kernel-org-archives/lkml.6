Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuZpjFGq6w/cWmWUo5McmpmKgigxH37m80tlthAbIF69uNy6kgfNzCwM7baggSBysl2UtMF
ARC-Seal: i=1; a=rsa-sha256; t=1519981255; cv=none;
        d=google.com; s=arc-20160816;
        b=KK1KLWSRocfNWOL6xuoXSZgts4rmHc/1X9wkuWiQHuiMxUuKjJWpRn7uJbC+uBL1E8
         GImJmtKgouEMv5vL/k/0LbggpmDiHFy9KmC4EBBbdbF5BW11GViTeG3kLhn31js0Dqdk
         MW5XazE5cqYOEzhQIjpRQAURpX/nJ4enk9rpk9UFjVHnPIF1khJuWlN/kWjuLYfnUQHi
         ptPeRL2j1r5e8dG99wH1bbQt1PTgpFJDilNtOFzgLtSUHL02y8zk07gEtnTCHRLMIEEV
         dBdTBO2nIwtJKz6id/10epM0atWHiWHlpjS5ITYLtjG15KHsppt8kk5JZPzdpuf+PEo3
         mwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K9PJWh3YExTGRVkn2MiSYrmq88ANVI8nMmtOuyeoGi0=;
        b=lcZdwKg4VVrLOgv9WRaN5YEKmKg+rlZteUKfVsrPNOUlphmSpR0OlxjhBhdGri1qjF
         5apt3I35E/9G627p9XNq/6mn3XgE4bGtAxnpIc8v0TM7iYqXxOm24rZS0Vw6C3H/k0hY
         /pRCJvARNWFkX6sQHxugBLQZK4nmgs8FtcGVD6zCneOOOAxCN3/TGaIpkkUxb3bfvxPg
         DalsfBZn4oTEm9GBlZdjzJYI+psdiGkcNTSGAAIEQ8t6wz0W0iaywGD6QTdE5Q/DHGoo
         bMNXfA/gjdE6cdVGRxhMRDrB+ksU6+dd3BSPjzbv72yVt9hqF+uu5aF95xEeLR2rBzdb
         0Y1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moshe Shemesh <moshe@mellanox.com>,
	Huy Nguyen <huyn@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 038/115] net/mlx5e: Fix ETS BW check
Date: Fri,  2 Mar 2018 09:50:41 +0100
Message-Id: <20180302084505.421642574@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815865121207374?=
X-GMAIL-MSGID: =?utf-8?q?1593815865121207374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huy Nguyen <huyn@mellanox.com>


[ Upstream commit ff0891915cd7b24ab27eee9b360c0452853bf9f6 ]

Fix bug that allows ets bw sum to be 0% when ets tc type exists.

Fixes: 08fb1dacdd76 ('net/mlx5e: Support DCBNL IEEE ETS')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -259,6 +259,7 @@ int mlx5e_dcbnl_ieee_setets_core(struct
 static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
 				    struct ieee_ets *ets)
 {
+	bool have_ets_tc = false;
 	int bw_sum = 0;
 	int i;
 
@@ -273,11 +274,14 @@ static int mlx5e_dbcnl_validate_ets(stru
 	}
 
 	/* Validate Bandwidth Sum */
-	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
-		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_ETS)
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_ETS) {
+			have_ets_tc = true;
 			bw_sum += ets->tc_tx_bw[i];
+		}
+	}
 
-	if (bw_sum != 0 && bw_sum != 100) {
+	if (have_ets_tc && bw_sum != 100) {
 		netdev_err(netdev,
 			   "Failed to validate ETS: BW sum is illegal\n");
 		return -EINVAL;
