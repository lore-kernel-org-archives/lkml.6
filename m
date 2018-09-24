Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC43ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCABC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OyTNxDk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCABC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbeIXVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:14:01 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730739AbeIXUur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnOVArIYGLrKdvLfYobW3lw91dFvK5UcvjRMoByY1Hw=;
 b=OyTNxDk8i5UbJCwAMBIFLYSVMj8Z1AVyB5/8pT3A8yBrKIXsI+tRnwA5UaHLtjyLFcmUTPg7n3mwAEowCCtRcpdi1fBeJsZxMJw5KLbPMKAaubvloY2mH/k7yzoRWQkOdensmCZ9KZufFwJS2JUy4pnJAQmTGRz3J/QkJ6v1kQ4=
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
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 10/76] scsi: aacraid: fix a signedness bug
Thread-Topic: [PATCH AUTOSEL 4.18 10/76] scsi: aacraid: fix a signedness bug
Thread-Index: AQHUVBWaJLoBH0y7NUq0a4XJ6gPmEQ==
Date:   Mon, 24 Sep 2018 14:48:05 +0000
Message-ID: <20180924144751.164410-10-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:RhTzeFEpJbCf6sofBuJTQOqnLCm90jpGKNSGD+jTA5KBtsS7Opx/WUR1yCHoJ8rfRW3faavsjvb8EACgjs/MlJAHf+9HjLD1mOPUjB56d+1gQuoC9DAWtuKmKeBRYJbo5NJjat/KyVSjZmw9Nzmf3eMcCOIeXgM5fS5tDDPXitQ9bOOxmJJjIePNJuvyiIqI6shePhgqCTtOSMJ+uVTgWIApx3QmrNgZ5i1k8ZEcEMQxYIoMPNcJSHbiakt+sqasIXBklZVr50YxztpvUiDxzNNR3+kI2Yh5hTaVJrGOZdPASlHNZA68LaBYBy3t2zjS2F0d9aw7+xgelpHmCy+BLygzwsgT8GK+bGKm6jnLZV33I9iM2MLasdy60Cqgr4cW4CZfrVTOB+w9F8PDDTHUHS1fxj442qdZ+cGqzyTBxdXlBYtcXqTxMJzxVQdyjN5tTpdQwdOdbeFLH7ewoRQaXQ==;5:eWN7GMCRCKPsINEnWY7dSc0BVIB0qZ9OasOJPedLbPBt/6OmrG7EDIEP5q4Ei+eazevBaF17leMWOFvuPEmiUW+GrWbCBYXtoHpsYCip+uiDK7gE4yZ5QDTr2xSY6hVzQgFJNjkIXQqYkaO/M7cHR5imp7VcE3p7WEv5Q1PHlc8=;7:AVXQDThdikwiZTH6LzLS1z0Q2kQKw78D/uoU3m5Is2MdUmHPw+VQAiQf4z5CGE4XcY1dFkSImmE7kMcQhGB6bkNg8KqtwOgJIGoJ4wRQRO+vMhJugS0i2lfLDq4P3G/yEi3z7N/6L0TOiDiHNEdKCzqApcFjm5LpCIIESvEe9ks/viUGOcnlRsqwk6NKzAPXTaB/3l6DDSh9MHs1OW8iXSiH3drJWdyVCPtjIwC+hE78n9p9Umf5UJ+GGA+3CSq7
x-ms-office365-filtering-correlation-id: 455f5db5-61e0-4464-dd99-08d6222cbd4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB01340D3364E65A49D6415F50FB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /or4aaepCsFwnvddGKUgzRBYRUrczZxy8fRKrfs8j2WiWik8ASEH82/y87DWTST9oBk4pyJcUgoSxly9RsDgnpyY2HtVGzEMM+4hrmsu5pPa3eYGOLQZpwRARCLgYFkRz2g43R9zZj6slUvP9RcTezdFs8zitX3IzPvPFRRcsX25dzMVAgLblnE3ENzq1NOsji1/o6yT0hh6xQ5REF4+IhQBzTz95/UtYzcq6yWCH9QDNLh9QB3tEP3/3fol+Us9pcYI3Ljl59pIy9XnGN+fkdLdWHNVnPbejzVgVj5RqMDQzu38p+9Rt7c2anrBTPkcU9HqzCJCaJa5DmhKpIqC+Q9uReTzHp3tQwZrCaxavnU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455f5db5-61e0-4464-dd99-08d6222cbd4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:05.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b9eb3b14f1dbf16bf27b6c1ffe6b8c00ec945c9b ]

The problem is that ->reset_state is a u8 but it can be set to -1 or -2 in
aac_tmf_callback() and the error handling in aac_eh_target_reset() relies
on it to be signed.

[mkp: fixed typo]

Fixes: 0d643ff3c353 ("scsi: aacraid: use aac_tmf_callback for reset fib")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/aacraid/aacraid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.=
h
index 29bf1e60f542..39eb415987fc 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1346,7 +1346,7 @@ struct fib {
 struct aac_hba_map_info {
 	__le32	rmw_nexus;		/* nexus for native HBA devices */
 	u8		devtype;	/* device type */
-	u8		reset_state;	/* 0 - no reset, 1..x - */
+	s8		reset_state;	/* 0 - no reset, 1..x - */
 					/* after xth TM LUN reset */
 	u16		qd_limit;
 	u32		scan_counter;
--=20
2.17.1
