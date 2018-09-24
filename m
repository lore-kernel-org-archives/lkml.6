Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB2ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5514E2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yp8v1AA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5514E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeIXUuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:46 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730312AbeIXUun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYMO4fwhlVnRagENpPHtilSi4evKfLBu4h8gVCMB43o=;
 b=Yp8v1AA5o2vxmWjkit7IJR/y6nSNQU10RB7O90Ct1wro/iERI5hm+pn2e8fFx/EnasXlpdXGDFW7O110U/KWYLITypdy1yT+8MIOL/lDe1Peq3Ci98h+9KU1mvHLK0V9I4m6sxWGjCt/egVsEWTiBHqpiytFd4mBbC9CzAuYOhU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 08/76] scsi: csiostor: fix incorrect port
 capabilities
Thread-Topic: [PATCH AUTOSEL 4.18 08/76] scsi: csiostor: fix incorrect port
 capabilities
Thread-Index: AQHUVBWZhiLXyPhJhEOTmvUb+3ZeKw==
Date:   Mon, 24 Sep 2018 14:48:04 +0000
Message-ID: <20180924144751.164410-8-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:SVttcbuD5xi2wRqaPs3x4KNC75cWsoV0TJ2ObYpakmdxKFsU3Yzj85hYzMlo5FWLWXT08C+yVB9NEcKQoqdKGJmqC0IsgumCTtmyS4eDkgCBVVEn9g2x08qSi/QYOfrcGYqtEvX7RErCK6Wbqpu+Ziov4J/Daj389iu0OGpvB2u1TcF7wsJWFgcwIC0sO61oGDrj3C/Fm0KzTn5fsFRLOaWXciKPTQR+l36fVsb2yRfTDqrSFQnOHan6WeJzIFLOd3zQ6+3hm9ijI3SDiptoOdJl8wm8qjTDzI2u2Qc653r/dXrgn1WYAW7wlkEzNHqE79JErSsrS1+WGrYTkjJFf9QMY5wbAOkYyvgb/xU4VRML7YZ3qjP+ywsDdA2M2rvvUq7ZdtrPwcCOt8v0OX0GLMO1Evb2dkTd+ZnGSEPZB9+LuV3z/bcNCW+TcJ/zxpBoOsKPJ8O5sJu1AapwDUMcBw==;5:1h7zM/9oxX6HIWMkeMS10yPBNsgUlF93jZk2LDqiHj7Qr7adXyi/9nK0fw5sfda9VT9HklmV/VzXcPeQpsYQfsQw6M1jIglWa5Jyi3TIuaTa1S1UvH8JKsqeWc8+AiY1PuoOybLhGyL2Sn4oq0xx0Zzos4hEClpNi72fm9Aa25s=;7:DAKlZTofFfJ50Ws1plPE8XDujaXThua0ujqYBLUbo4MzfIkD/7Zrt8nsbIg2pEnXgyP0vRWWf5cAZNimGQpyL4m7TMIGRyAkFzVHtH/q5wxhCVHGAFOStzOqFRRfF5STDzmt+3hD2FNfTPtOQUJuOw5N5ooqZFtS92gUGlyv5yMSlG1BiethlA1NVMJ8vPKZdRxTzzWXzRoqtmJ93JETc09208MWYLFbM7Db77iUDlzSBTeI2zJey59NJITkG6Dk
x-ms-office365-filtering-correlation-id: 913b0899-7973-4e1d-b702-08d6222cbce2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB01341AE183BDA02B7F6C4EACFB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9aPbX5xC4pMnjcEdd1CLBL99k6HquhdQ9Tay5QcHRzi/em1iVfNesl0yfeQTOb/A752DH4NNA4tyamJCpPeTgrlYdXQ+jHyu8YzPxnfw2H8huDpg5AiihmNqheAEMQ+2eykhqlHrqWDjQNu3Y+sfOn5BtNpaNDiwjTsOJWNW3NTCrdYCr5GIsd8HRqkHqCyj4HjcYpgs5+lAPDWivwsp2oKzuagZhU+MPhTbj2gNkPvNwzb0dhlL5YSWzS1KtytfsXE7/5dz4hts072XWzKubh42b0PuDBhGjIrh4i3Lei+7NF6xjC+J1ytfgP/xbUXAWuw1HWVsO0+1WGVdwvERn5SFsYsXiuQ2NyREvArnuBY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913b0899-7973-4e1d-b702-08d6222cbce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:04.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 68bdc630721c40e908d22cffe07b5ca225a69f6e ]

 - use be32_to_cpu() instead of ntohs() for 32 bit port capabilities.

 - add a new function fwcaps32_to_caps16() to convert 32 bit port
   capabilities to 16 bit port capabilities.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/csiostor/csio_hw.c | 55 ++++++++++++++++++++++++++-------
 drivers/scsi/csiostor/csio_hw.h |  1 +
 drivers/scsi/csiostor/csio_mb.c |  6 ++--
 3 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_hw.c b/drivers/scsi/csiostor/csio_h=
w.c
index 1ee255a62f1b..e4baf04ec5ea 100644
--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -1512,6 +1512,46 @@ fw_port_cap32_t fwcaps16_to_caps32(fw_port_cap16_t c=
aps16)
 	return caps32;
 }
=20
+/**
+ *	fwcaps32_to_caps16 - convert 32-bit Port Capabilities to 16-bits
+ *	@caps32: a 32-bit Port Capabilities value
+ *
+ *	Returns the equivalent 16-bit Port Capabilities value.  Note that
+ *	not all 32-bit Port Capabilities can be represented in the 16-bit
+ *	Port Capabilities and some fields/values may not make it.
+ */
+fw_port_cap16_t fwcaps32_to_caps16(fw_port_cap32_t caps32)
+{
+	fw_port_cap16_t caps16 =3D 0;
+
+	#define CAP32_TO_CAP16(__cap) \
+		do { \
+			if (caps32 & FW_PORT_CAP32_##__cap) \
+				caps16 |=3D FW_PORT_CAP_##__cap; \
+		} while (0)
+
+	CAP32_TO_CAP16(SPEED_100M);
+	CAP32_TO_CAP16(SPEED_1G);
+	CAP32_TO_CAP16(SPEED_10G);
+	CAP32_TO_CAP16(SPEED_25G);
+	CAP32_TO_CAP16(SPEED_40G);
+	CAP32_TO_CAP16(SPEED_100G);
+	CAP32_TO_CAP16(FC_RX);
+	CAP32_TO_CAP16(FC_TX);
+	CAP32_TO_CAP16(802_3_PAUSE);
+	CAP32_TO_CAP16(802_3_ASM_DIR);
+	CAP32_TO_CAP16(ANEG);
+	CAP32_TO_CAP16(FORCE_PAUSE);
+	CAP32_TO_CAP16(MDIAUTO);
+	CAP32_TO_CAP16(MDISTRAIGHT);
+	CAP32_TO_CAP16(FEC_RS);
+	CAP32_TO_CAP16(FEC_BASER_RS);
+
+	#undef CAP32_TO_CAP16
+
+	return caps16;
+}
+
 /**
  *      lstatus_to_fwcap - translate old lstatus to 32-bit Port Capabiliti=
es
  *      @lstatus: old FW_PORT_ACTION_GET_PORT_INFO lstatus value
@@ -1670,7 +1710,7 @@ csio_enable_ports(struct csio_hw *hw)
 			val =3D 1;
=20
 			csio_mb_params(hw, mbp, CSIO_MB_DEFAULT_TMO,
-				       hw->pfn, 0, 1, &param, &val, false,
+				       hw->pfn, 0, 1, &param, &val, true,
 				       NULL);
=20
 			if (csio_mb_issue(hw, mbp)) {
@@ -1680,16 +1720,9 @@ csio_enable_ports(struct csio_hw *hw)
 				return -EINVAL;
 			}
=20
-			csio_mb_process_read_params_rsp(hw, mbp, &retval, 1,
-							&val);
-			if (retval !=3D FW_SUCCESS) {
-				csio_err(hw, "FW_PARAMS_CMD(r) port:%d failed: 0x%x\n",
-					 portid, retval);
-				mempool_free(mbp, hw->mb_mempool);
-				return -EINVAL;
-			}
-
-			fw_caps =3D val;
+			csio_mb_process_read_params_rsp(hw, mbp, &retval,
+							0, NULL);
+			fw_caps =3D retval ? FW_CAPS16 : FW_CAPS32;
 		}
=20
 		/* Read PORT information */
diff --git a/drivers/scsi/csiostor/csio_hw.h b/drivers/scsi/csiostor/csio_h=
w.h
index 9e73ef771eb7..e351af6e7c81 100644
--- a/drivers/scsi/csiostor/csio_hw.h
+++ b/drivers/scsi/csiostor/csio_hw.h
@@ -639,6 +639,7 @@ int csio_handle_intr_status(struct csio_hw *, unsigned =
int,
=20
 fw_port_cap32_t fwcap_to_fwspeed(fw_port_cap32_t acaps);
 fw_port_cap32_t fwcaps16_to_caps32(fw_port_cap16_t caps16);
+fw_port_cap16_t fwcaps32_to_caps16(fw_port_cap32_t caps32);
 fw_port_cap32_t lstatus_to_fwcap(u32 lstatus);
=20
 int csio_hw_start(struct csio_hw *);
diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_m=
b.c
index c026417269c3..6f13673d6aa0 100644
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -368,7 +368,7 @@ csio_mb_port(struct csio_hw *hw, struct csio_mb *mbp, u=
int32_t tmo,
 			FW_CMD_LEN16_V(sizeof(*cmdp) / 16));
=20
 	if (fw_caps =3D=3D FW_CAPS16)
-		cmdp->u.l1cfg.rcap =3D cpu_to_be32(fc);
+		cmdp->u.l1cfg.rcap =3D cpu_to_be32(fwcaps32_to_caps16(fc));
 	else
 		cmdp->u.l1cfg32.rcap32 =3D cpu_to_be32(fc);
 }
@@ -395,8 +395,8 @@ csio_mb_process_read_port_rsp(struct csio_hw *hw, struc=
t csio_mb *mbp,
 			*pcaps =3D fwcaps16_to_caps32(ntohs(rsp->u.info.pcap));
 			*acaps =3D fwcaps16_to_caps32(ntohs(rsp->u.info.acap));
 		} else {
-			*pcaps =3D ntohs(rsp->u.info32.pcaps32);
-			*acaps =3D ntohs(rsp->u.info32.acaps32);
+			*pcaps =3D be32_to_cpu(rsp->u.info32.pcaps32);
+			*acaps =3D be32_to_cpu(rsp->u.info32.acaps32);
 		}
 	}
 }
--=20
2.17.1
