Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF3ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413F208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZcQ4uLXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E413F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeIQIZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:42 -0400
Received: from mail-eopbgr710092.outbound.protection.outlook.com ([40.107.71.92]:43008
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728249AbeIQIZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBIbuH0kHhaluwpw+XjVmwEdm3woB1TQSBD5x4ly19Q=;
 b=ZcQ4uLXfpDsOkYSQM8WugYKmRqltZeHjmb0mk1i8NRqXXxW1ty1f4gfLg+/nCFmIO/a7pZw3kJl2Bu0ERlg+nRYi7+IQclJCYLW3JcRRN9OkkpVYiWa5aNlFtMOAOXdu1cVvKGo/LGC9XRNq/+I6SuwVDeQTLP9CtMorLLG58OE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 009/136] net: hns3: Fix warning bug when doing lp
 selftest
Thread-Topic: [PATCH AUTOSEL 4.18 009/136] net: hns3: Fix warning bug when
 doing lp selftest
Thread-Index: AQHUTjKP5dYmfiuyzUONlxEimk0x2Q==
Date:   Mon, 17 Sep 2018 03:00:16 +0000
Message-ID: <20180917030006.245495-9-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:JGzKI7qlFN3TK3pWXPbah/AYtzTLiFKjvNfH8WZ0P+kofTjQ1Aq4MA8BjmYgmZhUXbjCPDL1rCkYnufrnG53un27dbm/E7msWuOk9J0jfn1eppPgQ9LrPQltqa90IhCz/EAQNVz15S0gkIfzJdUuiDhDJlXQMCctF8+tuOtS/EsWCxVRejJyftEAm54JIKHP2ungjOZWHEZfEs6+ntTsHfrACUxHLHl6sBCj2qRXAssofS/vqwxe32QIawAMhlL0f3VPnOCKvHHR1qF2/yJzlGaON43NfuvxyVG82TJyYCwYYhzs9yOca/aCcuDjyj0mBxD8ISgRw4LjMrFhQIM+/i28xAcO8ULbw/fHyuoUx9NP+6f7M+oCtgWz77Crt8zm0+5Xs9ybrIeau0RDHlGP1FDTAAbEOWfhDC9B0L1IDnmFnNW7ghgnhWC3ZjWZUIvay2Jo9wafsALYAa1+7AM00A==;5:JX0z05x18BLQB/ouju3KSf5YIA2PPGSYmW5Elty6TveaZz0y1U7RyVWdoGqyZO4kFRgZK/xbytwhKNwLJyrRPY5kCPmQnGA47iDosVGAj940Jej6Xy1j6GFYyKmRyu/dFrIFt6MdzGtQLHshI369axq507lpJL4V8kymZiSnVU0=;7:lMKqmgTWL0wBe5dy3Jdltg3HDTCQ0r2qlDRM5td0sNcsfESU/U33LhsIf4BpE9rfxa6TDOnQte0INkKRx5eSfBvRAZREb56qS0k8hpjyPkHGtOk4NTpDZ5p2g6mw3LzmbTQOKVjTjlQR4DonBymecvDcL+ueEWSMMlbBRU1pSOcQYYR4AQENHhkPWCmqXZcG5zIgOH+eN7o3tiOk1uKZdqXM7OwfxdoW+1VXZfGTUt10wY5peGMjevhHY8jx6ddw
x-ms-office365-filtering-correlation-id: 72aad09a-4f84-4a7a-5d90-08d61c49b22f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0134900B403F934C3038132CFB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0jl4Kl3W1PH9KPXPeuBAjOlXGzxpqEp+iT2V88W0NGQaMe10sn4ikCeFwqZSHExyp4ZmeoZs4xnHx5DcDNy0ILMwvFsFBAgDzKHlpPxQ54btVhT95DSVFaem+ELXtpgOuqrHOf230/b28gj/jv0UhyaprX1WsfDXTEGhX+MOJA1avH0xy859oOTZ6VypsygCdWJJG2x0qdkXTm5JzuSb+YeLXeIh67wRQdH/+rK2kauq116SWVAGLAj0YORo+n9Iroc+uBSREk1/uGLs/htGZZpdmYkvGhVAb25PWr/uvmRhLufxnqFJCQ0BeXgPwr3ijTCcV8AbuMiAY+cXgq0zVwhJzgRr8geyap7ZW3WFDuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aad09a-4f84-4a7a-5d90-08d61c49b22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:16.6517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit d7099d15478e89edb9bc6c6e3ab4cd341884a367 ]

The napi_alloc_skb is excepted to be called under the
non-preemptible code path when it is called by hns3_clean_rx_ring
during loopback selftest, otherwise the below warning will be
logged:

[   92.420780] BUG: using smp_processor_id() in preemptible
[00000000] code: ethtool/1873
<SNIP>
[   92.463202]  check_preemption_disabled+0xf8/0x100
[   92.467893]  debug_smp_processor_id+0x1c/0x28
[   92.472239]  __napi_alloc_skb+0x30/0x130
[   92.476158]  hns3_clean_rx_ring+0x118/0x5f0 [hns3]
[   92.480941]  hns3_self_test+0x32c/0x4d0 [hns3]
[   92.485375]  ethtool_self_test+0xdc/0x1e8
[   92.489372]  dev_ethtool+0x1020/0x1da8
[   92.493109]  dev_ioctl+0x188/0x3a0
[   92.496499]  sock_do_ioctl+0xf4/0x208
[   92.500148]  sock_ioctl+0x228/0x3e8
[   92.503626]  do_vfs_ioctl+0xc4/0x880
[   92.507189]  SyS_ioctl+0x94/0xa8
[   92.510404]  el0_svc_naked+0x30/0x34

This patch fix it by disabling preemption when calling
hns3_clean_rx_ring during loopback selftest.

Fixes: c39c4d98dc65 ("net: hns3: Add mac loopback selftest support in hns3 =
driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/n=
et/ethernet/hisilicon/hns3/hns3_ethtool.c
index 40c0425b4023..11620e003a8e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -201,7 +201,9 @@ static u32 hns3_lb_check_rx_ring(struct hns3_nic_priv *=
priv, u32 budget)
 		rx_group =3D &ring->tqp_vector->rx_group;
 		pre_rx_pkt =3D rx_group->total_packets;
=20
+		preempt_disable();
 		hns3_clean_rx_ring(ring, budget, hns3_lb_check_skb_data);
+		preempt_enable();
=20
 		rcv_good_pkt_total +=3D (rx_group->total_packets - pre_rx_pkt);
 		rx_group->total_packets =3D pre_rx_pkt;
--=20
2.17.1
