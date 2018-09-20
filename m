Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7170C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC6221521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mDFLH7HC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC6221521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbeITIah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:37 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387646AbeITIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxb9AYrqyz9AhHoBpLa42H2BxkEMZj66YntXG9DCw/U=;
 b=mDFLH7HCx3ronbXOz4bCBriZ755Jv0fsatuvC6tfoxjA2F9mwuNMgpYnmsDnrHk0pBnGO0iJiwWofciOm+dR4iVPxlXHjkP3YXoqDbMK+Bxd9njpuTVAH56qQ1+uuZBqG4bfNj+XP0HQ8gnUnr+cxpDI7dibXYprtt3eMAtq/W4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/14] qed: Wait for MCP halt and resume commands
 to take place
Thread-Topic: [PATCH AUTOSEL 4.9 02/14] qed: Wait for MCP halt and resume
 commands to take place
Thread-Index: AQHUUIxxgMesR5D6rkml7CaFYGDSPw==
Date:   Thu, 20 Sep 2018 02:48:43 +0000
Message-ID: <20180920024838.58666-2-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:BNLzx7WWZbS/UfSIZ8AyZiqpT0mCs5eZVZdNkB0LCmkfx4q/fLKaqGGx3RGi42uO6bfJrglhwVWk8vjQG8RYMBVC0A3fELwztDzmJIyMPNJMikfCgUBM0BklmpZ1tIeTWILQ+KRTgaMY49uJ3NxDDh9iJ+e9Cs2hVw+qvOVkFNbwNv5fggvIn78EtXVt0+nQ3L0vdaE98/soCEpn6ES0L5QDmT4BsXCyPmIrw46emz5JGa9h2AdZuY6EXzTW43RirvJZv5UoK96sgekOhxHLcifFYa3BGUE0v249r9v22o2gfR2XZYGixDWWUa0GwrCgGHM0SsF44gOWL+DQsiYuFCAranaI7ydWYow8RXFGsU+3ZPeNH8eus/RJpOAoxs9BrVk4cvJLBXmJzJI2+QTTbjD6yAS0wxcxsx0fybkW/BWvebntroVXZATl/FJBsNCue4n/uKvdCW0Wi07CWhETEQ==;5:Qm65ARIs/ZQG0WwSmX3SydrSwHAm16QodpQwFt1DPgAyw97uvn9vhdPqkuYW05IaPaCnFNWXeE8Lv1BMMnrxAZ8Ny2iGhwlL/Y+fw2J5mt7ZPyjSbKm+hrRjBx1G5u4F1hWR8fZJOAs06we7FAFEV5a9zSE719yFh1N9jsfNwY4=;7:zu+GTOxZPldIeYdZTvVhcGvN5Z6sDeNjqosanHf/7iSNmb4ZITcO81LrQD3T+lULXj7IFw0gvt+G7tHtFXPNwPhJxNCSzeHSK6OyaB29xbDj4lx/HCzji/ymCwpffxqUcSAYhpxI4WTCNEvwhdIpNNSrL48MVb0lLxiELYeGG9ymnM/Nm3+B/d4fnHNB7ZsKoOpF4lpdN7rpBC6zn+z/Uqs55644PDoBZ0/3sUOOOGfohqU6P65MZTQtOL8vB4eS
x-ms-office365-filtering-correlation-id: c1935616-f17e-4a5b-248a-08d61ea3aad3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744E651EE302C7E836A1768FB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SDji3TpjpTu/qtay35vF1t+R+JrdFxDJGEdVkaE8/RhmDAQjY7SbffxQ/zkxa+QxwMR7YvJ3CA/Z1fihdrfJNT+YqUytnunhATYsHslHGK/6H2xVff/XDDriOqvYIGG2KbCkNQxGOKQjPdmxb8IyFOxZO0TXnfjOJUayhjF4I3wGnCgq1Mf72SlchqRc60RHRkqyTRneiSN6UEbBu92YLRnq68Bu4QuWFZjONdU4mhEIoayvOsh65D3yyQ9sY8pwFU+wHiV/xAVmmoOWm1UjEQpl75aJlcqV3+eJMO8gxJlZ/NFZ+PSh26iXk2TzAtiIuev7ecl4Secufl3Twxitv1J/fNJHdV41JEDNx8P+2uA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1935616-f17e-4a5b-248a-08d61ea3aad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:43.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index a89385ba6b63..e175fcd73739 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -1230,31 +1230,61 @@ qed_mcp_send_drv_version(struct qed_hwfn *p_hwfn,
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
 int qed_mcp_set_led(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h b/drivers/net/e=
thernet/qlogic/qed/qed_reg_addr.h
index b414a0542177..56be1d6adfcc 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -510,6 +510,7 @@
 	0
 #define MCP_REG_CPU_STATE \
 	0xe05004UL
+#define MCP_REG_CPU_STATE_SOFT_HALTED	(0x1UL << 10)
 #define MCP_REG_CPU_EVENT_MASK \
 	0xe05008UL
 #define PGLUE_B_REG_PF_BAR0_SIZE \
--=20
2.17.1
