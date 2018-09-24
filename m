Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58837C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96EC2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dsq0LQB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96EC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbeIXUwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:22 -0400
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:17577
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387653AbeIXUwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCEA1sNWbYCYWdnsAMTDCsJUILZ3HAuHhM6/fzd8HX8=;
 b=Dsq0LQB9q2A4uWsV7FbwrPpFKKJTirp7nVAgRnabV4KWy9O6DtUVAlC97N5EYyLavj3WaCCZKoPFwbL948FrTvUyyU0vNLbSaZI5WnnLd0uR1rtGYxx+Oz4P1Yq38Z/+uVe6oznQQ2SxxV3OF9iWPUVdXzhQqr6/G1ETlCPDf4w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/36] net: hns: add netif_carrier_off before
 change speed and duplex
Thread-Topic: [PATCH AUTOSEL 4.14 14/36] net: hns: add netif_carrier_off
 before change speed and duplex
Thread-Index: AQHUVBW7Firr3ED+cUS6Ln5IZr0esA==
Date:   Mon, 24 Sep 2018 14:49:02 +0000
Message-ID: <20180924144851.164533-14-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:NWfx+MmhdANJllsEDCwuSVTYdela5jZQ5SMS/koaZYYw9a//9GkcX5HkdYCI6MyGH5aTtVU1IN08qKGSyr+Vvpk/zMo6Xbv72VLR+1sObVqgCm9/01Irpqjce67yLpGJeh3YCxMoThtSGLKPsacf6C3vV5hpPqQCNMt9qtBsHwOJaCHRH1bKhnmdtrPCSizA+nbCZJrrVi7f5SukOKXjN3/4wxpphTRPIbGkdZmUhiawfzrL+HbKGABv7f/+AMFK4g9EivyeNvckUG3nI4wwwFu08K+zEueF9W76aIuRh1mstS3dPTWM7dGckZAq2UaVtkv+FsKgMYZiUawdYVUpWzDoSizyavJsy/b9uMBIptrViK8wj3jtpnr96u4hzuJz28kk7fs5g4KQlAdVzJr18CwdBGBYhSRXDavviOj1nFZdzxRkvLfzeKUZDRiTi68pz7PE8gph24R9FlIjeiA5eQ==;5:P6NClwXQnAQ0s1dku7Gp3RK4CALUp9Q8nVSqWtRetVp5QWe2/5XH8oX5WEnt6dChTfJz9r97b8IlZV+OnRp+kQKYBRe7KC4JH+CXIm0usNClt0RhGq96WphCKHWigEliEiO1Hv3XvsfStmNJVqUcBxLT6S7w5Gwe86Tj0B/cpkY=;7:Iz1czC+ikqaZ1pYh3jhJvrMa+SF9szl95gAtoPglwfZM16c9WHawVsMMbYb3XKW4N0AW+IY2H1+XnOVvrdPDUNp4ryxqcNLwVjhWq0fe6btuULPwdQsEWqoa9+UAEUQA9XK77vHh+uEW/xqyuZM7HeiZg/aE2CosF7o3wXy6C/9GlPViAD37Aw1TJKPI5gbN3UQNxy/q/HLpVGOyGB1+zQWI96V29iiSIbR5O1JJsJs69UXo8k238rz7T5aSxxBY
x-ms-office365-filtering-correlation-id: dbaf4672-aa31-4726-ed6e-08d6222cf748
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181300AC528BC57EC0186E3FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QRYLUN0X7ldJcVB13jewq1kPIzoZn7+Xar/xxVZ0QGeKGGKzmZRXpbKbidW+c4EI6szB60coB764j8U4t1CoUfMMK1H/3UwTiU2UJCngS7cVaYeyHG+HdX85RBpvIl6QCU50JqTWpUYHFDnhYaTmGJEQFy1o3VL7a45v4BJcWNPdBDpoY2dVlP0SUlfJ/WomoqBtcKWpSwDL+DvFxNzldI3Md/iEBckyslV/fMDcSNbpXyt2zULPcBdw7p8yTf7llE8E37MUtdkIMv/bdrfNd6bQNmBfK2XN9XSwTiT+2sI7R2bp1Vg3X2Et93rMAsp9xWXCGZEb9fifYMAorqC7Fg5k7yRwuKOK3/uy+m/6EEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaf4672-aa31-4726-ed6e-08d6222cf748
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:02.1564
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
index 2e14a3ae1d8b..c1e947bb852f 100644
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
