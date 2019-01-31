Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E960320870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YrHDrLkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfAaG6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:58:37 -0500
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:10450
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfAaG6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJs3M9J7SwevxRlMge3tXEC3y1zHhoZQV4Z6cHfaZyo=;
 b=YrHDrLkY5I0dSjupWBa4BOcq8QoOWnCROL+DWRxea6/g16xqvAEuzuVTtOEgIWhcG7ndzy3oAoQiRHETZlZSpGL3gkjjMXokC58scohSTF67JFh5pK0W6tNFlE1wFS6TgItryHJLu5TRR/AUbotmcE4nfomwNvVyu7bNhYJNEZs=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4169.eurprd04.prod.outlook.com (52.135.130.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 06:58:32 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181%4]) with mapi id 15.20.1580.018; Thu, 31 Jan 2019
 06:58:32 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Topic: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Index: AQHUuTJgKWsp8N+NE0K42HojVTeBgQ==
Date:   Thu, 31 Jan 2019 06:58:31 +0000
Message-ID: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4169;6:0mJKKmdpOwVnKwPgWrAphDCWIEd6Uep3OhrLhjNOGW18ze6OS7TYfKFaLIgFhIjp7gwbKh9Jnsauqs2EzllHz3pohssJdLnUiWydxbpYO2RtLma4zjPy+tMJ4DKcJqJby695NIFgWC/JqZpoYgz52SEiApc+xxtWiIMa4rGoz+PFyjgeB2qt5l+xnzPE4NScw9mFKba8wASN6DtLGzeEX9j88LDATTXWUDbxO85HRqLaXe5PeEf2yCHOH6raAsc7p4lQAL4fLpZejB7BC9lWbChl8ytrKKVPVbIocH96ZKnhARN0IU/uCuK3m3d9W0VaIEeZ+Nkl7u88sPfrEV/xAJITwjNQRz/WLzYvQNgu4pELQ8iugDwh//8FHbC1Ra1Ed2degdMKUPAwalScIFwVq1zfKBozlnGZ3X47wUqTmSWKyuIufAMFWDi77HsTsclsPdxY6PUp6ZJ99pDYbFp7Vw==;5:eEgvN0FEq/vn86a5oaz3oCobQ8fhzkHGwxx/xbDMVdhvYV/1Xhxux3uOINks2+NrpeG09gCmG8kRJNvPIz044+AVpQ7Qlvy1Y7VTz6D/VaBqq0wvhUx+HeQAGYw6v9txp7grXAlU6Yw+GthlymW+3FwGcnfoBF/KHYgRL8o/q7JNKEnhdh5RqEXtj4A3TjOBiiQ78QXjw16ZzfFqxveZqA==;7:sbSVzPsx57qT+kY7OEpfb/mxxoG/xhx6OZm52I82OsveTFIh/afibVvfrlADXGqvjJXeCf6f7/Aja0G+QE7Q5c1cuAbrivSna+sbabDizO4T6n0GGtNGsv3ItqU7tttyLRBE61mfqSllcyPhE1JtsA==
x-ms-office365-filtering-correlation-id: 8ddb485c-7ae4-4adb-1d00-08d6874982d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4169;
x-ms-traffictypediagnostic: DB7PR04MB4169:
x-microsoft-antispam-prvs: <DB7PR04MB41697FC60D7132B80100B888E6910@DB7PR04MB4169.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(346002)(396003)(376002)(366004)(199004)(45904002)(189003)(478600001)(52116002)(4326008)(14444005)(105586002)(2906002)(97736004)(2616005)(3846002)(8676002)(7736002)(106356001)(6436002)(305945005)(256004)(486006)(476003)(50226002)(6116002)(1076003)(36756003)(86362001)(6486002)(53936002)(6506007)(386003)(316002)(102836004)(110136005)(2501003)(68736007)(6512007)(186003)(71200400001)(81156014)(81166006)(8936002)(26005)(99286004)(14454004)(25786009)(66066001)(54906003)(71190400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4169;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +hwlG/6Wf/m4APLNFmN4b2MDx6Z9M0hFeibNsvntPvWkSk5N58JC5QH9xxqgT/8YItKydcKQijulGc+EHvQ6LNN4cLqf3bhPwe4MQHQbxzOH41d4j76GpqtIb3iCL3cVQS7auXlXGY5TKwvjJIL10dL36ZpGcvvK7Fo4P2nevUPr3y8LmcsVk4vmIGCH95kj1LWr8zWo5VxmFKG+QZOMVfflww3/NY3UKYOV3MyGik3al+FxBrCWNz9SHZGAzHQTxphwdlt3X6sTZsh+ljrCVUB7gdlsgSe4Ei5t8MJGxuF6PPoAe19E3LpwGA1aLlpKuK7iHhrt/lq0N1CIIqnY5hTRHpDLZhzR+yD1hukuUWsPerFUfz3Lwap/INmIQRC5IVzuSDpDdAVmq40CXE/b1PkGNLsVwrJVUlfWb2oVMLE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddb485c-7ae4-4adb-1d00-08d6874982d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 06:58:28.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Current we can meet timeout issue when setting a small bitrate
like 10000 as follows:
root@imx6qdlsolo:~# ip link set can0 up type can bitrate 10000
A link change request failed with some changes committed already.
Interface can0 may have been left with an inconsistent configuration,
please check.
RTNETLINK answers: Connection timed out

It is caused by calling of flexcan_chip_unfreeze() timeout.

Originally the code is using usleep_range(10, 20) for unfreeze operation,
but the patch (8badd65 can: flexcan: avoid calling usleep_range from
interrupt context) changed it into udelay(10) which is only a half delay
of before, there're also some other delay changes.

After only changed unfreeze delay back to udelay(20), the issue is gone.
So other timeout values are kept the same as 8badd65 changed.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2bca867bcfaa..1d3a9053bbeb 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -530,7 +530,7 @@ static int flexcan_chip_unfreeze(struct flexcan_priv *p=
riv)
 	priv->write(reg, &regs->mcr);
=20
 	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
-		udelay(10);
+		udelay(20);
=20
 	if (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
 		return -ETIMEDOUT;
--=20
2.17.1

