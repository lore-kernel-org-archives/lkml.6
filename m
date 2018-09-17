Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576B5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049EF214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dgxki9UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049EF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbeIQIa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:58 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730626AbeIQIa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWr03d3IbpI/QP8VyiCFJgq4Lm8/xO+E1ZRH0Qw+fb0=;
 b=dgxki9UKak/V9q43KuBH9MM+7O8gJxgfvZVxkJkZL4+nR6Sodg8gLbUg/gGbQNWbt3h7fFYIqiigcPAnLsb7BeGd741oVQl/LwVx8sdWZFjBvtox6dzYtO2uFTlY5LO5qyyG4KnzFMG1XHuyhnBndvX81wHgon2AngqUaDrc7cA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/57] uwb: hwa-rc: fix memory leak at probe
Thread-Topic: [PATCH AUTOSEL 4.9 06/57] uwb: hwa-rc: fix memory leak at probe
Thread-Index: AQHUTjMNmj8/wIdLvkyPSsnKjk+u4Q==
Date:   Mon, 17 Sep 2018 03:03:47 +0000
Message-ID: <20180917030340.378-6-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:Db1wG+V9lTIElnLbzdWcbs31Fo3RrxQRFqzyoft+gRWNaitFhsx0tkPjJS05e3w4FPCLY8wSPIHef5dJPGuScO/RBrKGHpNhSOpx5+NIr5otpvfz4e78Cgy82+aYY1OJNQXu5hEnBd/78vvV0hqb3OAbcAuSuKAoRcP/D2r/Bw4s52D3PCHzdua4daej5BTXplE4UE6X8q2IJQWD9tkcEfb0YhFQGuTr3mP52l87V223WJzL32hOX8m55BnQ8kH8DbeTcIZBfHml3jb8saC5xYL+u7Im2Zn1VGdT6JmvTD4G5B47JFO2esaNlUa1ycej7j/nRKG92gfGBN6l5/yB7XMQjdPIU9xuKmfatetrYIRRL1k3vWm985CT0R0/ltpP7mUzdSGdZ7PLGI4okQ+34ga/BVw5zH3+Dj/XmMgSe4Cjbf5cTB4aEBzDf2R4nl7O3nuWKhgpMABQDYW1FVaAMw==;5:i8xw3dyNfUT8U1ydeuSzbAe+BRpN45xSclGChF1+JGUboP0baloKNjsPCXYTUAo0gohN05wKt2r2VbDhjPBcZAwxV5x1YpXNNiCevf5fXOf3X8F7BTEW+KXsgwIuhctC6FnDCRjt8pL0ljBRvy1saO71qWrZyLPeeiVluDlQcrQ=;7:c3n0g/NNE3ew0IEn7y6XeZE0zgKJjtyePGQqi15Dcj0CjTgvS/G27FgW7uPtiR+mrOMMdHvrfUmY9oypAZ8AlcOWLxkIrTRxuEWohOplW+WgZfedP4MAqfqrsqWkGVhMoWDmZNipNKGR87aFw0zhQo2KRmx6xgvJj4+o5D87pe/frww5HW6GUWEC6o2N5NmCLHuF9A32drCcQntpqpSjKGJJkTgK7FV8+avvilzALIs7jViBxPY8WZyXiNGKGDj6
x-ms-office365-filtering-correlation-id: 014a62f7-1cd9-447f-4ebe-08d61c4a714a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120C6B77C3894F3ED8460D2FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(4477795004)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: m8gbS6wypd6ckGANROZq/1hQkEHlYMEdCveL6YybVB8le3vylHAPHzP+JQoGbhhNmuveCNnNWofyeuR2hjNd1OWcO7gJi1G1caljSYiPQh2wUOhqZjv0Ni0iRkh0TMAUeQC2FooUjd3GJvKSVSLwksB32tI91YZ27LN9EwaZoTNYnspXH10v77xxPTwKDKdXDIRfyqp20Gqv/2Koy3IjJnqC2mV/Lmr8udeayh5oLYC3vpuJJF1er3te3mYJHsJ3XdOuK9e9aj9GorVih6PlzvB5NW2MlaMX4KP0cus+07Sg/iNhpXX/BFtJt6/WmfMSNd7PYErpPuKLDcSWhZMlJ568ZzTzq4cl928wQfIqPjw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014a62f7-1cd9-447f-4ebe-08d61c4a714a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:47.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 11b71782c1d10d9bccc31825cf84291cd7588a1e ]

hwarc_probe() allocates memory for hwarc, but does not free it
if uwb_rc_add() or hwarc_get_version() fail.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uwb/hwa-rc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/uwb/hwa-rc.c b/drivers/uwb/hwa-rc.c
index 9a53912bdfe9..5d3ba747ae17 100644
--- a/drivers/uwb/hwa-rc.c
+++ b/drivers/uwb/hwa-rc.c
@@ -873,6 +873,7 @@ static int hwarc_probe(struct usb_interface *iface,
 error_rc_add:
 	usb_put_intf(iface);
 	usb_put_dev(hwarc->usb_dev);
+	kfree(hwarc);
 error_alloc:
 	uwb_rc_put(uwb_rc);
 error_rc_alloc:
--=20
2.17.1
