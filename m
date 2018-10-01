Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B604FC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649872083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WaIqZ7mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649872083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeJAHNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:22 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:52496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728616AbeJAHNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx0Px6tL9EveeL7eqKYydk4zM0Lcg0t23W/n6kDgS9k=;
 b=WaIqZ7mWIu6TptnTMcotIhHK/gm9FcyuacvXSpyxFe6KHQ9+zqB2x0qDMBiaLzGuXcGYUdxsFqn74zDYQvTvzRemb2MUhe6OyZscOSagXaZ9jQSi/E4GnqOvZe6JgwRxD85picbITj54qYBti+hk7WgJZjXP0IzUsG+3qzJ4vPU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 09/65] scsi: iscsi: target: Fix conn_ops double
 free
Thread-Topic: [PATCH AUTOSEL 4.18 09/65] scsi: iscsi: target: Fix conn_ops
 double free
Thread-Index: AQHUWR8FEvdUMze8nUWHxK7FojiRgA==
Date:   Mon, 1 Oct 2018 00:38:07 +0000
Message-ID: <20181001003754.146961-9-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:EXG+X/V5A9GnZExgqtMD7luLuicTyE1f85RX5qisCTZ+zw/jEphti2t/+0A1LwF3X7EIW+X3tqlByfpwsd/jAzEelw10iJ2zNxbMS0EC8qmo00riVud9MV2QVdz71PBoSm0ykINpf7ygIrx04MVXylsLOeDpQKiWsADBfxcuVavJ7yJh+tB9du4gYKdKyohmfCTHnPHNqR80e5dHcavKX6TZ4/+RsbPTeH2vB0cU8gfLxNISjehv4kx1gU0VONIBSB4V0+XUeHIUaNZfoRb//8JP3oOz56FxQsWZlLqUCgq/U2rtBEelghzzhOJj0Cf1F7v/p9Ey9+1fmLpNUW8ioV09PSmWscZ7lK4QFlECm7hNg8b911nG+X0x26W5pwAuCTYpFlcKnMPM7t+0xkgECYe2Rmtt84XsyX88HQpkNCL+DfLj6vWY39PNV5KmXewW6sBVBRzT3oSytGAeM7Er9g==;5:7wPktv9mAp6HQiq0aA8i8agS+zN2BniRYfOEQAnMA1paLJadb1iQRSO0blIO5asOGM0D4gL7BGJ2Dlt7Tnh20A2Rw1cTH/3tkuNNMPRhhYhI+hy9cDL6OqxcWnVV/eq6am2r8Hrriw1Iy3Cvf6N7yn5EFyN0L7sTPd4KT/8p4y4=;7:o5ZrcrY6OeWWewh89EAbITgz+QytURLaqByZbE/9OsXwbMJJ51nmt0hSaEj+9nWUNa0cLd33e+RJ6dmRDBZ2oAu7TfAfoXS6KHbQBiL0Ak2s4qbfk4dFEO5pv1YDxbFe9AcP+nGAfALyeExpgjUtrrEl63eBjK9HI/omEM/WHfCcLBHDy29j+0WRFbsInZlTGjXcxm9POXO1VzDCAkycY+D1hNHSwA2X1cQJOU3WKTGHo+FCpdI/0bfDqF5DpVpT
x-ms-office365-filtering-correlation-id: e9338048-ec2d-46ed-dca3-08d62736287f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469787BF031911EA1CE9098FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tMZgOPNbCV4IHmUE2DjZmKbVBZB0MliY/Ak0OW/r3huZaB1z8/lhQR6eatdIlAiz7GD5pLhDU6Jh5UvBvvnUjr/OELmPySW89ZzUqgPj1DqTwtLIDsl7/p62Ts37xjbhbxhQH8r2e6DsuHZLCGFFCZChHz1vDv4qFOD+lho132g9Q/ofoYP77JLPJmVufoT9fwYiiBTgsV4wDC42R6fzkaxHXEwsEuiJKPHh/lscbp9Kf1xbO2n0YZyqgvmTTD0ssfJjMRmcX9Fx4U/kGDr/G7cjrdtePiBOMyKwcINq8C507v3KdOPUkJytV2rOGHXB/EWol0LF8uZ5I9tGpsOmGiv9S1nh0KC7vCcNvWR20Fw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9338048-ec2d-46ed-dca3-08d62736287f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:07.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 05a86e78ea9823ec25b3515db078dd8a76fc263c ]

If iscsi_login_init_conn fails it can free conn_ops.
__iscsi_target_login_thread will then call iscsi_target_login_sess_out
which will also free it.

This fixes the problem by organizing conn allocation/setup into parts that
are needed through the life of the conn and parts that are only needed for
the login. The free functions then release what was allocated in the alloc
functions.

With this patch we have:

iscsit_alloc_conn/iscsit_free_conn - allocs/frees the conn we need for the
entire life of the conn.

iscsi_login_init_conn/iscsi_target_nego_release - allocs/frees the parts
of the conn that are only needed during login.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/iscsi/iscsi_target.c       |   9 +-
 drivers/target/iscsi/iscsi_target_login.c | 141 ++++++++++++----------
 drivers/target/iscsi/iscsi_target_login.h |   2 +-
 3 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/isc=
si_target.c
index 8e223799347a..a4ecc9d77624 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4211,22 +4211,15 @@ int iscsit_close_connection(
 		crypto_free_ahash(tfm);
 	}
=20
-	free_cpumask_var(conn->conn_cpumask);
-
-	kfree(conn->conn_ops);
-	conn->conn_ops =3D NULL;
-
 	if (conn->sock)
 		sock_release(conn->sock);
=20
 	if (conn->conn_transport->iscsit_free_conn)
 		conn->conn_transport->iscsit_free_conn(conn);
=20
-	iscsit_put_transport(conn->conn_transport);
-
 	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
 	conn->conn_state =3D TARG_CONN_STATE_FREE;
-	kfree(conn);
+	iscsit_free_conn(conn);
=20
 	spin_lock_bh(&sess->conn_lock);
 	atomic_dec(&sess->nconn);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/isc=
si/iscsi_target_login.c
index c8bc99727e85..2fda5b0664fd 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -67,45 +67,10 @@ static struct iscsi_login *iscsi_login_init_conn(struct=
 iscsi_conn *conn)
 		goto out_req_buf;
 	}
=20
-	conn->conn_ops =3D kzalloc(sizeof(struct iscsi_conn_ops), GFP_KERNEL);
-	if (!conn->conn_ops) {
-		pr_err("Unable to allocate memory for"
-			" struct iscsi_conn_ops.\n");
-		goto out_rsp_buf;
-	}
-
-	init_waitqueue_head(&conn->queues_wq);
-	INIT_LIST_HEAD(&conn->conn_list);
-	INIT_LIST_HEAD(&conn->conn_cmd_list);
-	INIT_LIST_HEAD(&conn->immed_queue_list);
-	INIT_LIST_HEAD(&conn->response_queue_list);
-	init_completion(&conn->conn_post_wait_comp);
-	init_completion(&conn->conn_wait_comp);
-	init_completion(&conn->conn_wait_rcfr_comp);
-	init_completion(&conn->conn_waiting_on_uc_comp);
-	init_completion(&conn->conn_logout_comp);
-	init_completion(&conn->rx_half_close_comp);
-	init_completion(&conn->tx_half_close_comp);
-	init_completion(&conn->rx_login_comp);
-	spin_lock_init(&conn->cmd_lock);
-	spin_lock_init(&conn->conn_usage_lock);
-	spin_lock_init(&conn->immed_queue_lock);
-	spin_lock_init(&conn->nopin_timer_lock);
-	spin_lock_init(&conn->response_queue_lock);
-	spin_lock_init(&conn->state_lock);
-
-	if (!zalloc_cpumask_var(&conn->conn_cpumask, GFP_KERNEL)) {
-		pr_err("Unable to allocate conn->conn_cpumask\n");
-		goto out_conn_ops;
-	}
 	conn->conn_login =3D login;
=20
 	return login;
=20
-out_conn_ops:
-	kfree(conn->conn_ops);
-out_rsp_buf:
-	kfree(login->rsp_buf);
 out_req_buf:
 	kfree(login->req_buf);
 out_login:
@@ -1155,6 +1120,75 @@ iscsit_conn_set_transport(struct iscsi_conn *conn, s=
truct iscsit_transport *t)
 	return 0;
 }
=20
+static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
+{
+	struct iscsi_conn *conn;
+
+	conn =3D kzalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	if (!conn) {
+		pr_err("Could not allocate memory for new connection\n");
+		return NULL;
+	}
+	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
+	conn->conn_state =3D TARG_CONN_STATE_FREE;
+
+	init_waitqueue_head(&conn->queues_wq);
+	INIT_LIST_HEAD(&conn->conn_list);
+	INIT_LIST_HEAD(&conn->conn_cmd_list);
+	INIT_LIST_HEAD(&conn->immed_queue_list);
+	INIT_LIST_HEAD(&conn->response_queue_list);
+	init_completion(&conn->conn_post_wait_comp);
+	init_completion(&conn->conn_wait_comp);
+	init_completion(&conn->conn_wait_rcfr_comp);
+	init_completion(&conn->conn_waiting_on_uc_comp);
+	init_completion(&conn->conn_logout_comp);
+	init_completion(&conn->rx_half_close_comp);
+	init_completion(&conn->tx_half_close_comp);
+	init_completion(&conn->rx_login_comp);
+	spin_lock_init(&conn->cmd_lock);
+	spin_lock_init(&conn->conn_usage_lock);
+	spin_lock_init(&conn->immed_queue_lock);
+	spin_lock_init(&conn->nopin_timer_lock);
+	spin_lock_init(&conn->response_queue_lock);
+	spin_lock_init(&conn->state_lock);
+
+	timer_setup(&conn->nopin_response_timer,
+		    iscsit_handle_nopin_response_timeout, 0);
+	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
+
+	if (iscsit_conn_set_transport(conn, np->np_transport) < 0)
+		goto free_conn;
+
+	conn->conn_ops =3D kzalloc(sizeof(struct iscsi_conn_ops), GFP_KERNEL);
+	if (!conn->conn_ops) {
+		pr_err("Unable to allocate memory for struct iscsi_conn_ops.\n");
+		goto put_transport;
+	}
+
+	if (!zalloc_cpumask_var(&conn->conn_cpumask, GFP_KERNEL)) {
+		pr_err("Unable to allocate conn->conn_cpumask\n");
+		goto free_mask;
+	}
+
+	return conn;
+
+free_mask:
+	free_cpumask_var(conn->conn_cpumask);
+put_transport:
+	iscsit_put_transport(conn->conn_transport);
+free_conn:
+	kfree(conn);
+	return NULL;
+}
+
+void iscsit_free_conn(struct iscsi_conn *conn)
+{
+	free_cpumask_var(conn->conn_cpumask);
+	kfree(conn->conn_ops);
+	iscsit_put_transport(conn->conn_transport);
+	kfree(conn);
+}
+
 void iscsi_target_login_sess_out(struct iscsi_conn *conn,
 		struct iscsi_np *np, bool zero_tsih, bool new_sess)
 {
@@ -1208,10 +1242,6 @@ void iscsi_target_login_sess_out(struct iscsi_conn *=
conn,
 		crypto_free_ahash(tfm);
 	}
=20
-	free_cpumask_var(conn->conn_cpumask);
-
-	kfree(conn->conn_ops);
-
 	if (conn->param_list) {
 		iscsi_release_param_list(conn->param_list);
 		conn->param_list =3D NULL;
@@ -1229,8 +1259,7 @@ void iscsi_target_login_sess_out(struct iscsi_conn *c=
onn,
 	if (conn->conn_transport->iscsit_free_conn)
 		conn->conn_transport->iscsit_free_conn(conn);
=20
-	iscsit_put_transport(conn->conn_transport);
-	kfree(conn);
+	iscsit_free_conn(conn);
 }
=20
 static int __iscsi_target_login_thread(struct iscsi_np *np)
@@ -1260,31 +1289,16 @@ static int __iscsi_target_login_thread(struct iscsi=
_np *np)
 	}
 	spin_unlock_bh(&np->np_thread_lock);
=20
-	conn =3D kzalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	conn =3D iscsit_alloc_conn(np);
 	if (!conn) {
-		pr_err("Could not allocate memory for"
-			" new connection\n");
 		/* Get another socket */
 		return 1;
 	}
-	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
-	conn->conn_state =3D TARG_CONN_STATE_FREE;
-
-	timer_setup(&conn->nopin_response_timer,
-		    iscsit_handle_nopin_response_timeout, 0);
-	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
-
-	if (iscsit_conn_set_transport(conn, np->np_transport) < 0) {
-		kfree(conn);
-		return 1;
-	}
=20
 	rc =3D np->np_transport->iscsit_accept_np(np, conn);
 	if (rc =3D=3D -ENOSYS) {
 		complete(&np->np_restart_comp);
-		iscsit_put_transport(conn->conn_transport);
-		kfree(conn);
-		conn =3D NULL;
+		iscsit_free_conn(conn);
 		goto exit;
 	} else if (rc < 0) {
 		spin_lock_bh(&np->np_thread_lock);
@@ -1292,17 +1306,13 @@ static int __iscsi_target_login_thread(struct iscsi=
_np *np)
 			np->np_thread_state =3D ISCSI_NP_THREAD_ACTIVE;
 			spin_unlock_bh(&np->np_thread_lock);
 			complete(&np->np_restart_comp);
-			iscsit_put_transport(conn->conn_transport);
-			kfree(conn);
-			conn =3D NULL;
+			iscsit_free_conn(conn);
 			/* Get another socket */
 			return 1;
 		}
 		spin_unlock_bh(&np->np_thread_lock);
-		iscsit_put_transport(conn->conn_transport);
-		kfree(conn);
-		conn =3D NULL;
-		goto out;
+		iscsit_free_conn(conn);
+		return 1;
 	}
 	/*
 	 * Perform the remaining iSCSI connection initialization items..
@@ -1452,7 +1462,6 @@ static int __iscsi_target_login_thread(struct iscsi_n=
p *np)
 		tpg_np =3D NULL;
 	}
=20
-out:
 	return 1;
=20
 exit:
diff --git a/drivers/target/iscsi/iscsi_target_login.h b/drivers/target/isc=
si/iscsi_target_login.h
index 74ac3abc44a0..3b8e3639ff5d 100644
--- a/drivers/target/iscsi/iscsi_target_login.h
+++ b/drivers/target/iscsi/iscsi_target_login.h
@@ -19,7 +19,7 @@ extern int iscsi_target_setup_login_socket(struct iscsi_n=
p *,
 extern int iscsit_accept_np(struct iscsi_np *, struct iscsi_conn *);
 extern int iscsit_get_login_rx(struct iscsi_conn *, struct iscsi_login *);
 extern int iscsit_put_login_tx(struct iscsi_conn *, struct iscsi_login *, =
u32);
-extern void iscsit_free_conn(struct iscsi_np *, struct iscsi_conn *);
+extern void iscsit_free_conn(struct iscsi_conn *);
 extern int iscsit_start_kthreads(struct iscsi_conn *);
 extern void iscsi_post_login_handler(struct iscsi_np *, struct iscsi_conn =
*, u8);
 extern void iscsi_target_login_sess_out(struct iscsi_conn *, struct iscsi_=
np *,
--=20
2.17.1
