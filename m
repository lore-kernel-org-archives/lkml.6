Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D829214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jhj1pOHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D829214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeIQI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:01 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbeIQI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl/+PuKSIABT5f/qiZ/idH8ojrN6nVhioziDDxbo4vk=;
 b=jhj1pOHwCHE2psfoqgYwq0jwvl01fxFEuMQ7u6l1JZmrmDsNOnYUqwSj7gCqua6fNocvD0sTXJym7xZ9x5mBZpSnhr7fwAPKLHsneAWWNM+v9ayhZjveIR5hO0fQhmpqmNridgBd1Q8yQ3y/9jSq8Y6BcWjv3FZgS4D3WD87+rs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 108/136] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Topic: [PATCH AUTOSEL 4.18 108/136] scsi: bnx2i: add error handling for
 ioremap_nocache
Thread-Index: AQHUTjK1Y8igMawfQkedKNkC5ESHvQ==
Date:   Mon, 17 Sep 2018 03:01:20 +0000
Message-ID: <20180917030006.245495-108-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:mJOL0uR0ZviOQtlmz1kGEEi/nCEfvSs/+bVq7NL5k7/KVl/VzdwQ4NOYl3EzZM9Mc1dlgo0ENAWdZOujLMcojkOGrHiFHPwPkkpP+XiRPpSwhL0ZXU0e3s+IEVBSIP5PqPu7wJUwJY0uZAmaJyt1TIn70KnxoH/nCEaOjHTMU+eUROul63XHXWmrEZ7YtlCaijhyvfM7824Af45cqNAJ7ZiOiUvREuR9sE164Sk7xFOYGVMV3shwZRwyTLKrbDnQp82FOrdbG/Wy1EJMaXJtHQeZjZ3HfB5TlMFFV+SElLh9s1R8qp32U+qXNXrJJYG+7R9GrYCD3s5EVBCzpxYjxjag9wk93kFxhP9Ns2daW0HzzP14E9rbqedp80TZfO7ZlTxavYlV+KGYYSyhuPAvajS9gwJQxsB7CNFwackK2M61p51zpMUIvSBbZSkekU0C4VP6uFyRcJu9f8a5kdfa0g==;5:EMCE1ktVjnCabfOtT9YsC0CvK56n60v9Z5uJzEWy1TLfbupLjs5YoYDHrYljwX4Vxh0ndY9Rha5NrUzS52XIFYDGNKUAiH2sHg8ZbDR8BpXvzS5da0/24/i64K2Zrsp3lVd1VGZzI+eFTQP+D9wKmAJdfWvAsFgGnvVHK33wWq4=;7:N2tNWTVCP2Ct9GkuIKDYmEfQbaE5zS1dh7Nt/dRSwPRbLL+tEITi1V3IEnrGkEFISOYNVPIYglcf9s2EjHkK+d5jXTLKVxq1IG/EMwEngs+2noOi5xNsjTqOL9095y3yttEDeFFWhCCBecMhglodRAdMukONFZUsSqnPa3wIgZRpX1d9ZuaGLeAFTYkzalkbSOMmhCX0NTH5IeuZOcy8n0wae+U05q2JUdOT25gfNNe8Pc3w3lBznIywKzArZP9L
x-ms-office365-filtering-correlation-id: 008df885-fae2-4a28-6e91-08d61c4a09f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB01681611D66C926E32E1DA63FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(39060400002)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zVejDLHb3jrJ3hzEdxSzEMJsuKxYZeZ55PqdWH8ZQ3rYrpXAaYjGJqUn5PDixHz52xvKikT4ktS7/kLdLEKcufM7LaGT+1CR6KIb1ukbDqzNmQVwQvJbZQrs1xCHd7qt0iARWl4+7fe2MxPRKeua0DLBMk0ftZWHBA1jS0R/ivWtJhncADw8FgGwB0PzN+P5XgRageysgJFB18/47EZEDzkYtzPi/bz27pPf3wUi6LddTh/w7mQXoytx7SXH0ixw1abqOaVMNZSX4d1B+Y/TFN7IwByMiFytfGuSgk4+6tL1Rz9i9ZEkjOPq9z/LmLpRWGUHCxGc73QajOAq/TTm66e3S+5jiyXYzrMiFJad/g0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008df885-fae2-4a28-6e91-08d61c4a09f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:20.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit aa154ea885eb0c2407457ce9c1538d78c95456fa ]

When ioremap_nocache fails, the lack of error-handling code may cause
unexpected results.

This patch adds error-handling code after calling ioremap_nocache.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Manish Rangankar <Manish.Rangankar@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/bnx2i/bnx2i_hwi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.=
c
index 8f03a869ac98..e9e669a6c2bc 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -2727,6 +2727,8 @@ int bnx2i_map_ep_dbell_regs(struct bnx2i_endpoint *ep=
)
 					      BNX2X_DOORBELL_PCI_BAR);
 		reg_off =3D (1 << BNX2X_DB_SHIFT) * (cid_num & 0x1FFFF);
 		ep->qp.ctx_base =3D ioremap_nocache(reg_base + reg_off, 4);
+		if (!ep->qp.ctx_base)
+			return -ENOMEM;
 		goto arm_cq;
 	}
=20
--=20
2.17.1
