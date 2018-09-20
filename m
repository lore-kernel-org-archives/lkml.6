Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CFDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FE421521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QtKBNtnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FE421521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbeITIe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:34:29 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388309AbeITIa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kuHpk9zwmBn8oCtLIb9/ifTtvIxQ87dm0vAIacviSc=;
 b=QtKBNtnzeEeyrSoWBqFsJSqI8QtpZZbUk+wcHRvdvIozq/1hqvNDx7C+PxJTTTcrEixXWUA54LjRaBxQYh73Y7VI92H3sC0ODsBK+WPW4MgiD4dlj425tQd8/B25e3udPqc52W93yh1liao2oqCRT6EJLZYHUxlooo5CxE5msJY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/25] qed: Wait for MCP halt and resume commands
 to take place
Thread-Topic: [PATCH AUTOSEL 4.14 02/25] qed: Wait for MCP halt and resume
 commands to take place
Thread-Index: AQHUUIxhpjJNR0IhYkWJNlyt6fUVpA==
Date:   Thu, 20 Sep 2018 02:48:15 +0000
Message-ID: <20180920024810.58594-2-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:8jCJQxrHjeDgI8VHwLeYQEbfrb/7PzmItecRi5KyGqiGmo8zUvarhIRNob8UFgsW4VIufifou2qQWKKxwaYh0TsRjjFH2xKYoGrTBuUOVr8BcNkowKIiLedQs1Rpwrf9wV69YXdnuGYLJJF/SJbde+NdnAXBJf2cB1xkMZeWiLrGKqOH5kCsoRiTUHN5BsBXeCnQVGYh4eeIq2W57syjEFu3zef6sSsH1CnKUDyd29Q9tlgUGrWSStAy05pnWjrxgc/JYZ+dMJl8ladQ5FF0NlrW6PUBxlv/UhfspVSwMhwX7org2nn9nof85LiHNhYasDFyO+ug03VOI1JrDErr+Aka1mCKNX8xSBC8iLFYFcprI7rkR1JoXyrahMai0yEpNE3YmYTD7ErpiVcGsZbfHsI6jjpSz3xBZE6aixn6SPO08mpQxRXxkNxtAmZ1pJtcKjOxawXIE6WgjXnaei916Q==;5:hrXDI8hDj58o4UR6s+0ShUhGJSXQtBD77UCPslAUS0I4vQa6jkY+T6X7fZ6o6yDLpDURsm30ogpiZuaiMGrX4eLDkRf3EGIL1Q3d0jTXXYR2SaWvkAzpCsbq3GTTMmkWLoVbrIyJ8gv9ys7uLa6GpehOfFOTkhLJ0+PjY+s1doA=;7:GRnDblLzZPdWM28hE8ItCbW79LunWZ6q6Uzx6DeYJuabYgfVzY5pY8QxfVRIhyb3N0+2qn7uEBEUofVeW5yHFgV1dwCSlJvCJysaYaWq8vqh/uZMzWhBPp7SbipOA3jFcEDuL7VqbFRka6s+fgPGJbcsDducNKKbvqsqjo3S2Qeynkq89wVXCeIGpx50kyyXsfZd3C6AP7etxgqxsA1mBoenpoR4JkACB0YoylpfwkWkwQMv6aJejvqFv9tJqzN/
x-ms-office365-filtering-correlation-id: 6edaf763-1f17-45d6-e77d-08d61ea39064
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119EAF43A4D70590FBCBB2EFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qPXb8pn5XHSzFk4b6OSH9KagGt0s5Ds/Qenk0a+AToyq63BxFf8qgz+CdM9oDTAJK/MEw/ouDq8K5Y6A3Zf/29W4rJDzWKkb3c2GsHzI9f+Ln5J72Et6OV1Vcy2ZGl5TqAzssN7cr32T7uga0jtdRzKqt3l0oof7DEHa1CgoOYEJGYBtYLljTRV5rT5Y008ScDC8Uvg/QooD1qmvyJV+VmMpWWkoL4hydEsahZmeZOREM6H4LBpncbYG7RFmCjJxUvvqWLS8ZNC72hnctTsZzPM7CMJ+xho9xoF1qR1HsNDdfF1X6clPQSyKdfRbJsJci444VYj5WQhTHnZQVJTHQQT+oKuz4vy36VU4sTob4AI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edaf763-1f17-45d6-e77d-08d61ea39064
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:15.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
index 9348d367cfdf..5748bcb26d40 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -1998,31 +1998,61 @@ qed_mcp_send_drv_version(struct qed_hwfn *p_hwfn,
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
index 0cdb4337b3a0..887cfb16b53e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -554,6 +554,7 @@
 	0
 #define MCP_REG_CPU_STATE \
 	0xe05004UL
+#define MCP_REG_CPU_STATE_SOFT_HALTED	(0x1UL << 10)
 #define MCP_REG_CPU_EVENT_MASK \
 	0xe05008UL
 #define PGLUE_B_REG_PF_BAR0_SIZE \
--=20
2.17.1
