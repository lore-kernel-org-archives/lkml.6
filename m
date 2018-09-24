Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955D02098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iSLzDVxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955D02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeIXUvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:23 -0400
Received: from mail-eopbgr730114.outbound.protection.outlook.com ([40.107.73.114]:62688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729984AbeIXUvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCEA1sNWbYCYWdnsAMTDCsJUILZ3HAuHhM6/fzd8HX8=;
 b=iSLzDVxEw7BuvJrPNBUiwgDLKJS+XQ+oVEGwzyUqPlKy3qwud/pftL7hzq/b4tm4q/KciJSkcswUMw+VqFVlP2w0ND6Lqw0+1odDGywnvTq83uHis18HyhvBrF37u0rB12PI/eJkCvYp/tiPl9fXPZmIfAX9nSCtZjKWAfM8a9A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 32/76] net: hns: add netif_carrier_off before
 change speed and duplex
Thread-Topic: [PATCH AUTOSEL 4.18 32/76] net: hns: add netif_carrier_off
 before change speed and duplex
Thread-Index: AQHUVBWjT2POSborqE6j81pOxJI3Aw==
Date:   Mon, 24 Sep 2018 14:48:20 +0000
Message-ID: <20180924144751.164410-31-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:IN1bpyrej9mmTLxMYxwXwS2t5LCNqgFJox7vu+BdoT9rlJmj7VJDgjU64LYYTrcFDwl9hHzVmSbtPz3s0KKBb2MxFgl/U8sPa4ftMidl1w9eHB+vKsVP7y9EnTqnG43HHBJemWGOzDx9yVXJcKbKJEZjaS/6j4d4qizHOgKVhhqaByCHMkvh35U7zbJ9YMYdP9F6ySnNW6tmdh+ring4m73jeJ8R0u3666TMVe38O16mSHRk/IVqyyMFzj/YlXMirskREWslASPKcePOmMfjJfnjCaNIm7L01yAzRqbwppFTdmDYRzTtPavzV7l5mNfWiEgWB74i+qbIFOglhpwkIzFpyM2LtRaGqbYfXO0aqhVT+uNkbALU2U7hbLzVGgbdqDhRlftc5BZmOQ/BqcyyFKBWITbcY4B4qbbzuWgLgNd+6HlzhaftwYe/L9qR76ALZLaDovimikjM+MK0HPIzgg==;5:MrCESE+CJrR2hOMpUikfJc6d4Q4CC2jguJ66N/k/HYoFwCsk5S4jWsAF0ank9BHmYg/nFEKq1v0lQqKtb4lOEL0EI7fPw6Q4C+9Md4NyxuXZrOTKh5/VzQ0vIGoLNzNc/R5CZSSAipd8HtJSVLAMTLQN/Puy4Jma3AMAlf8bndw=;7:eLhNmZhcGydiEXnfx+ERebrHjfFETdg87zseWu+lgPT15bo0ZGmYqYiXnwZC4QfiusClLOVYjffmaqWPW3NMWurX7VtJjRnxgLrEzejaZswP0JjVqLyxX+UZgauz3WkK+T1GGmhmGF+d8osm7i8w+6t/PWRQA38qGRd+KyhstCussbY/yTLD5VPQBmrrlq0Z1nB2QwavO8XRLe15P/jkrBtJxJOfp0GVJgxtS2YYPBxA41hzxZxSGejZ9Au7SyDU
x-ms-office365-filtering-correlation-id: 8c57bfae-d007-4bf9-8dca-08d6222cd797
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855946A62C5E1E433C3E4EAFB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9PHSe0v8dmUg24GmJd0czL2wELnMg0sqG1ckvZrMWOPlYRZzufAMSjAsuQtnFl5+AxqI2AToyyYdGCGjNvhL/pxRgCecfJZ1w05GxgdrW1T3g7xRpgo9GXMhKpgsP+2yvixonOoZNAlIuzEwyNk1kMbYDVrmZirjt4aef4aWV9THfmnETGucxoFSjdMTwISuZyfo5EJwwvPEZFzOdfV62L2f+xEQbbTrcgbQlZWHIiUDZacqMNJ97wAIxGFcd7w1oEnT3Va/D192PDReA+l2Ly6N6GsYlMjirmyrMa58eBp2NQDuZcOaXHITyu9RrEY21JPPqRSH0SW8K0Zrc4diwQMeQ8360neeKk/TNA+aVUM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c57bfae-d007-4bf9-8dca-08d6222cd797
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:20.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
