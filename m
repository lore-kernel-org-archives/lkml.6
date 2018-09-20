Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0975221525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cEUfLTrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0975221525
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbeITI2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:34 -0400
Received: from mail-sn1nam01on0116.outbound.protection.outlook.com ([104.47.32.116]:8864
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733225AbeITI2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWpl/+NkeVPjqhidLCqsN3w2H6+SSTQlGxI/DIf4BaE=;
 b=cEUfLTrmDbVs95STucF9FO3nlSrOd+LjyLBVQ3TwZx3NO8L9Rhtio6NceGmJHtbVm0/gCZjJzyiBd2nT9My2JTzZYToiYeByehYNJErZw1hzLCPKowOpxljuB0MmexomFqd9M7ahoCL6w/yeN/3ADZSMiX3b1e+qpWF5Q+IsXUw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 05/56] qed: Wait for MCP halt and resume commands
 to take place
Thread-Topic: [PATCH AUTOSEL 4.18 05/56] qed: Wait for MCP halt and resume
 commands to take place
Thread-Index: AQHUUIxFbgdRNM/u6EeVEGc1nCQjSA==
Date:   Thu, 20 Sep 2018 02:47:29 +0000
Message-ID: <20180920024716.58490-5-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:z2emay5zBPd9ia31mzAHQ94G5WExHKWLrryBhZEXeLuM+A6x/78HlGFN6ooHFzBP6c8tGBrDu2s//pnaI0KK0BF9HzFGh45j5L7FyQtS3gK2Ljw28lScF7mQTdT1cVyg59+zK4I1T9TuvtubHwxJRyZX1AkrgK93ux4prsZpBP9w2x5NHbXvh/9OIo9Cl1NOCdPFMoiZEC/6q8H/ht0D7PFRw6At73+RywHpKFUulfp11Kg69UOliWQ91fqAX/zM7zQ9Eml+HZeNq6Iqg51QMlNkkmT+sXyUqHCxKbbGwCpDyIPzlE/WaQusYcJamQlugy/W/3gm8nTXArVONn6xJss0sm+bfQqpkRzPFWOjERZvvxQPIi5PEBIl1g7+GlqiwX13HQov6qdCDJ/foAXNUOauWnIAw91S792jSdf0YWc+yyC4a47Q/whpL9mg6HOl6MoA3xestR3wIytGBQMZ6w==;5:cto6qGml4iETctgnq3rhYvf3nJNjzswJ/uEVkSsffiA44AkM+N4vQh6A1f+2xv8N3rnw6jDz0L3JdYR9tOJhXDDIMFF2v2FUDbKT//hKZseQqlFbRqfEe9VDYY1wpYRNMTlJqv45ZtNgX0a3FuXUjrBMzYJHF7+f4+61BP7slRc=;7:4Ic+FfcnvINADFmjl7bGDaTYih2H49Y7LRCyS7SU/bij8wYqeTvFwu0vlHLFBKyTnh95MLITHkqI1WkNsJw4eUHuI8VcMaNbXt+gqtTrKgmtBpziGSzE8DjqWcgJl7Xz7eBzy+JECQcMqT0O0FFxl1zGz3oDlXFac5O5yk/Jj66flB7WWcLmC7J3TLNtD+Zk81pu3jjrs4wnugyJvbO/biIuF6PgSwXnHMn5ec0RRDFz/vugHWyVD2OwTZ+FChgi
x-ms-office365-filtering-correlation-id: bc552a70-ba80-44b5-458e-08d61ea36816
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855D7936E95CFEBF3453261FB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(106356001)(575784001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(14444005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eZmXArrfQMxS1UR0kgdUI0qlvtgLiyJwLK0q7/aKYCia08ilCaOAPhMuYhUurbuEhaH+r1BnuLQ1RxKjLl1IzQg2JOGcd/I5T3Uc5pUpOHMV/INH9xxe2WMR6GvFEQ9EeoLJfAunkzUgWuPWq2xhMxeofTkjBE4vxt/ta37KtTLXRmUZxDriej+7dJEUqeZKfC5oLu1i382L74ZZYyjigPxm759lR+hBDf/ZHYaBiZUk3IYILHKqyXiHYs5z0Ph5vktMn8G04JVacECbe47S7nwmRtSqe7y/5OsObk0iexojIVkGKiatTAr+i7WN48mYxFBeBFdv8UfkMEFms+p6Tl4iJrHdsjS8Z7Eq2qfyVYY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc552a70-ba80-44b5-458e-08d61ea36816
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:29.2733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit 76271809f49056f079e202bf6513d17b0d6dd34d ]

Successive iterations of halting and resuming the management chip (MCP)
might fail, since currently the driver doesn't wait for these operations to
actually take place.
This patch prevents the driver from moving forward before the operations
are reflected in the state register.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     | 46 +++++++++++++++----
 .../net/ethernet/qlogic/qed/qed_reg_addr.h    |  1 +
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.c
index f3937491d545..34e0db313850 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -2107,31 +2107,61 @@ qed_mcp_send_drv_version(struct qed_hwfn *p_hwfn,
 	return rc;
 }
=20
+/* A maximal 100 msec waiting time for the MCP to halt */
+#define QED_MCP_HALT_SLEEP_MS		10
+#define QED_MCP_HALT_MAX_RETRIES	10
+
 int qed_mcp_halt(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 resp =3D 0, param =3D 0;
+	u32 resp =3D 0, param =3D 0, cpu_state, cnt =3D 0;
 	int rc;
=20
 	rc =3D qed_mcp_cmd(p_hwfn, p_ptt, DRV_MSG_CODE_MCP_HALT, 0, &resp,
 			 &param);
-	if (rc)
+	if (rc) {
 		DP_ERR(p_hwfn, "MCP response failure, aborting\n");
+		return rc;
+	}
=20
-	return rc;
+	do {
+		msleep(QED_MCP_HALT_SLEEP_MS);
+		cpu_state =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_STATE);
+		if (cpu_state & MCP_REG_CPU_STATE_SOFT_HALTED)
+			break;
+	} while (++cnt < QED_MCP_HALT_MAX_RETRIES);
+
+	if (cnt =3D=3D QED_MCP_HALT_MAX_RETRIES) {
+		DP_NOTICE(p_hwfn,
+			  "Failed to halt the MCP [CPU_MODE =3D 0x%08x, CPU_STATE =3D 0x%08x]\n=
",
+			  qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE), cpu_state);
+		return -EBUSY;
+	}
+
+	return 0;
 }
=20
+#define QED_MCP_RESUME_SLEEP_MS	10
+
 int qed_mcp_resume(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 value, cpu_mode;
+	u32 cpu_mode, cpu_state;
=20
 	qed_wr(p_hwfn, p_ptt, MCP_REG_CPU_STATE, 0xffffffff);
=20
-	value =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE);
-	value &=3D ~MCP_REG_CPU_MODE_SOFT_HALT;
-	qed_wr(p_hwfn, p_ptt, MCP_REG_CPU_MODE, value);
 	cpu_mode =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE);
+	cpu_mode &=3D ~MCP_REG_CPU_MODE_SOFT_HALT;
+	qed_wr(p_hwfn, p_ptt, MCP_REG_CPU_MODE, cpu_mode);
+	msleep(QED_MCP_RESUME_SLEEP_MS);
+	cpu_state =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_STATE);
=20
-	return (cpu_mode & MCP_REG_CPU_MODE_SOFT_HALT) ? -EAGAIN : 0;
+	if (cpu_state & MCP_REG_CPU_STATE_SOFT_HALTED) {
+		DP_NOTICE(p_hwfn,
+			  "Failed to resume the MCP [CPU_MODE =3D 0x%08x, CPU_STATE =3D 0x%08x]=
\n",
+			  cpu_mode, cpu_state);
+		return -EBUSY;
+	}
+
+	return 0;
 }
=20
 int qed_mcp_ov_update_current_config(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h b/drivers/net/e=
thernet/qlogic/qed/qed_reg_addr.h
index d8ad2dcad8d5..2279965f8f8a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -562,6 +562,7 @@
 	0
 #define MCP_REG_CPU_STATE \
 	0xe05004UL
+#define MCP_REG_CPU_STATE_SOFT_HALTED	(0x1UL << 10)
 #define MCP_REG_CPU_EVENT_MASK \
 	0xe05008UL
 #define PGLUE_B_REG_PF_BAR0_SIZE \
--=20
2.17.1
