Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD537C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C9E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="k2mBy4GI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C9E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbeIXU6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:58:30 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:52378
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387575AbeIXUxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZBSnZpMEwQPq10/BGitIkUJMuLC28a1Y3QSRkh5nKo=;
 b=k2mBy4GISE8o/zPu05jxL4FpBY7j6g0/fVk76wnFqdxbhJudcR51tzLqkkkxnJi7umKLMEjAQGtLsvpdfWjptRkgnOnRQpWohgY9B+LP/LqhR1ThQ2y3aKXWI7APEbGAGiP55QAkVY3nhchdwaIm9uOcaP7WKAK5fjEpcMMqyrY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/23] net: hns: add netif_carrier_off before
 change speed and duplex
Thread-Topic: [PATCH AUTOSEL 4.9 07/23] net: hns: add netif_carrier_off before
 change speed and duplex
Thread-Index: AQHUVBXKNibw5Vxb1kiV4bsGqhNDTg==
Date:   Mon, 24 Sep 2018 14:49:27 +0000
Message-ID: <20180924144919.164617-7-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:EehAuikmSXhk24yo4NpeaTS9Dx/RcjierF918AFovJ1kGHyjAexnf/HPah9XDSN48n47aGKO9ikAmMHP/P0Q1AYAUPJZQVXxuL8m1W/vQMJNixcYsvaQYOC1I3H4B2Ce9MzKbFHjue21wC3AlHRNVx2SbVSqUXfZtP3m4B7J6wVwgUy+qJ3SWqatgnpgQv7RjQdCm9OoUUK6Zg9wuipqkT4ifBj+P3y7KuooHW1M6FtQA3b7jku2JaD3mveRoNMyTQLXK+c+4dlzGKTydVXPFrhCYP5LVnHJx61FUzpfTqEjSHoqfPwGkpZ4iZL3i6eWGb+b8e1btGpKLZYsEL/Y7KOYO+UpNvCRMfztiOHku9Epsc/9N/F5ivOip0luqiEZ8obHI80JPwVy1ex4OFwxZ/SgdBJWEyFvPz6vYNYks6tsjR2qdzbW9Tr7vcvKO6mdyWzlopz4Ou4Qr9aqaTJ0/A==;5:q8911TwkjRWM4O4sof0Ax51Kd9y2WZgIw9l6tafutbDr9Ou8GjKUUGqBWGXquifoYDI+YRvjit52RanQNAujgrF1mA/QUqGJgdXtHFLnChlAJKcvBmx4zu9m4wzDi9QR44aJUMh+pFwkw/kBj3JeBI587xxJ9fbLsHHYzbWnVQM=;7:5XYxWO2TMbyMFxjjuDefFVYXSiSjQcLSI5uIUz8LEBbapOHspxgoLzdzikYMEVI9XZQUdLUw2Q+53oCKD1Nl6Iz7EqRM1niirpWDuu4Wu/TzmH2tLEqXeIL895B11JQGk0gDDniP9hw51f/0LIeEyHe20hUhMVTmRft94XunDj639Vix7KrlmdaDXdc6Y+M2VxIixEqNoSE8tg9927ieQW6i7B4N4XBV1CYNZVxA/GdPLIePcw6HfPCo79pcCxKL
x-ms-office365-filtering-correlation-id: 42a46938-fe0b-4052-347a-08d6222d1081
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018100F5DD22E8B1D5D071B6FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K588x9GKqqMkrL9DAUfvTGvGKpyAUVQwDiYJFXI/+/cv6LKTFvXlCUUIAAA31VzDOTIGWuGAP0BlWQr9fYHDPVPkpISCxvm8y6gMd1ivTq+1Glzn0VMguol2OWVGU5kWNJvhbe0dU4bN0MTOFfZ4XZA+riX7TkJlpgGfsuEJNdT5hOJ/DUuRC9nQO624nwpx5CSI3cL5csQ2AUgHXPBZDz89QgxM5GD0srav2wuNUzHpO9VwMqHVpxHUiRiYrrziUaeiHOG3X9mo5JeCOUwDHNpbJdRw9YgfcNAH85YF9RzGFsiRTHmWhRh7ullx+d//mKVrBvsw3wRkhDVTqPQLiuZQsmraOqcHe9s6L9vJ5i0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a46938-fe0b-4052-347a-08d6222d1081
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:27.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

[ Upstream commit 455c4401fe7a538facaffb35b906ce19f1ece474 ]

If there are packets in hardware when changing the speed
or duplex, it may cause hardware hang up.

This patch adds netif_carrier_off before change speed and
duplex in ethtool_ops.set_link_ksettings, and adds
netif_carrier_on after complete the change.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net=
/ethernet/hisilicon/hns/hns_ethtool.c
index 6be0cae44e9b..4cd163390dcc 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -243,7 +243,9 @@ static int hns_nic_set_link_ksettings(struct net_device=
 *net_dev,
 	}
=20
 	if (h->dev->ops->adjust_link) {
+		netif_carrier_off(net_dev);
 		h->dev->ops->adjust_link(h, (int)speed, cmd->base.duplex);
+		netif_carrier_on(net_dev);
 		return 0;
 	}
=20
--=20
2.17.1
