Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C410CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A77721521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z5Ab2n2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A77721521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbeITI2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:43 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387538AbeITI2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJP0tGUduUhotBFAc2xPOMt7/gU6AuzDHDhunGof9BU=;
 b=Z5Ab2n2T0AMPdZLRd8AHzgOWgfacLinULNiM0SWjaQvIXEYH6G6XIcNURE6QFdTBzMCgXitNxeEntUG2kQpzHSFv3qqeK0La3rZu58eRm3Xy/THrHnBVZJl/fughB7LGMO/h1hkGOlRuSPtkCbT08PcJX+iVyNwzt9Kyths0sbQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 11/56] mmc: android-goldfish: fix bad logic of
 sg_copy_{from,to}_buffer conversion
Thread-Topic: [PATCH AUTOSEL 4.18 11/56] mmc: android-goldfish: fix bad logic
 of sg_copy_{from,to}_buffer conversion
Thread-Index: AQHUUIxIb4kpSj9Xg024SpxMgHd9Lg==
Date:   Thu, 20 Sep 2018 02:47:34 +0000
Message-ID: <20180920024716.58490-11-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:nFfou9JOM5ega3KR8vs1GONk308MDNw1oQLaLDGMs4D9c41Dn0JKnNqn0N2iwhwn1fmpbNZdfxzCSbMiP7bMpsLqhaV5nS2gm4/PrHK54mExC66gMjkejPUdmY4xre+zfUThDzjgA8Vr3gxrTfXZrlA/hdlWg8JDC3/DLPGQmeCViHW1kRDx3AtimD0I4cqA7WrOvFyaejUAaeH8q+kIjevo68BM7X03/SCG3jeH3uy2P0B+htm4g2RBnUMuHznRdewBX8qlC6OecdUiNNtOZIp2021Wgvm3AV5OIFhN9K01EwCf0a0ItNZdlt/Yp2NNgPOHeSKgfg+WFvmzaabQfElubjy/0QdJ/jame+7YFkqGCKcwymdLo6sycmGL0nlwG0hcLx7pySPoGj2WQT88Pg1/ogMBaRepIDS1zypQi7nEUbTASoFYFpYu6UkgswPJl2wlsB2lXJ1vBFFjdA3p8A==;5:/7DWplZJov4Bz7MSfQ+QQ4HxGbL1YH2CfmxZha1lgop8EsTgmL4nKdRBfnwTBqpq6DLJKdd1YOAoxX3Lcdqce51qjc/7v/qDlfdmetzr2QBDYzmfj0JtwiGdTNMMr1FEVwq6d8BxbvcO0d/WNg4w5O6btDLKsi31VqUV05hG4/g=;7:2yAjZ5mHhetYenR+aFd+HWuE5vnY9MbqjHcdhLzZzP6+MWdl5rHHmtuPw4oAxQf9GvWsLzrLkhlgdn5mTYh4WqLCL+iimKgFTmq3JN+PTtmEVm7dfrtXgEghc567TQQNXDIrN23YA+FHJoa9IXwl85tomiMow+GKU8/LPGq6eQj9ePqkPLCiEfjW9RbAzFgnicvd331BBUwWkcY89ZUgySavx/ak+1lIeTyZgBS1p1wZf/3I+oBjpP1dWpRrmGn2
x-ms-office365-filtering-correlation-id: db9aec66-0efd-4970-ba08-08d61ea36b58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822C6351842335844DDB4B5FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(12401385986421)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(2280148)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002)(60540400001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1cUYWPgNsYysJRysK0sxMEw6rDTBPLVJEcWIm5lp+5anPsB8NQ2rRTbpxYmnzSmREAUf4FaHOrtecJFDm8LcE02cI6St+elGF3fSjnfW5ReKfH3SubIUXZfKz4eEnT5mfG5Dlj+elUQlEQh2S19or7ELgsUMUPXiYWsVQlzgEZghEnEVDxI4fe48hDmLVhvkXWuewfH9vZU5b9IQkA+7gx0ap1HVEY+pimNJPXgmExuicaBo2l8XTLQGzSLw8ME/nq6Y8lO43TK8iZqw2+ppxSMPZODQ0CwnRJpr/bU/BmMfAywKmeuveOqnQPvQp+3PwhLiWNYahY2bdSe7iNevvYDCJUteLiLXJkwmSNfX2GRcA/+wP2ZNZdNwIVkm40IFk4JESF9bJO76rsZ+a9XQePLlnMf5f+q/MUc0gn8kUN8wpGKqcTqZuTi/8XBcNa+uSyLCbzVSsgix9BTN1jRiYx5j/G+TMSs0Z/QmeT38h9H9/Zq2JFtr6dto9GMzo6uP1GkVPjEya8lKT/0Eucqc0xXescBG3giXZWfvlG8u2Vivxb7kL1OpNeCQBRmNHbfZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9aec66-0efd-4970-ba08-08d61ea36b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:34.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

[ Upstream commit 17e96d8516e31c3cb52cb8e2ee79d1d2e6948c11 ]

The conversion to sg_copy_{from,to}_buffer has been done in the wrong
way. sg_copy_to_buffer is a copy from an SG list to a linear buffer so
it can't replace memcpy(dest, host->virt_base, data->sg->length) where
dest is the virtual address of the SG. Same for sg_copy_from_buffer
but in the opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 53d7e098ba08 ("mmc: android-goldfish: use sg_copy_{from,to}_buffer")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/android-goldfish.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android=
-goldfish.c
index 294de177632c..61e4e2a213c9 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -217,7 +217,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_=
host *host,
 			 * We don't really have DMA, so we need
 			 * to copy from our platform driver buffer
 			 */
-			sg_copy_to_buffer(data->sg, 1, host->virt_base,
+			sg_copy_from_buffer(data->sg, 1, host->virt_base,
 					data->sg->length);
 		}
 		host->data->bytes_xfered +=3D data->sg->length;
@@ -393,7 +393,7 @@ static void goldfish_mmc_prepare_data(struct goldfish_m=
mc_host *host,
 		 * We don't really have DMA, so we need to copy to our
 		 * platform driver buffer
 		 */
-		sg_copy_from_buffer(data->sg, 1, host->virt_base,
+		sg_copy_to_buffer(data->sg, 1, host->virt_base,
 				data->sg->length);
 	}
 }
--=20
2.17.1
