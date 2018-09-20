Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C11ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B826821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TY8JTcQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B826821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbeITI3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:30 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387959AbeITI33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sedxZmgYb7Kb+tbIBPr2Cc/ITC1Mz/wEmCX7N4ZF+EQ=;
 b=TY8JTcQtRAJMVgJtIrAkLh3iYDUN6GTxcZPyCPGJNDtn2GCIKjyJHEdqn8PdTs/0fXJXRTNxnCLac5yC7Pb3ISAyUeJIOOYGNpCKLo0s+WekfkUwPQiaVkfHY4G3bkyIe9p+PFQ2z8agkC9Vh5woSnFYfzAqOPWJxAnRUNobLJQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 36/56] e1000: check on netif_running() before
 calling e1000_up()
Thread-Topic: [PATCH AUTOSEL 4.18 36/56] e1000: check on netif_running()
 before calling e1000_up()
Thread-Index: AQHUUIxTzozgdwLvG0Sk7fesl9yatQ==
Date:   Thu, 20 Sep 2018 02:47:52 +0000
Message-ID: <20180920024716.58490-36-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:FMfzLe63B32ymfXpvP6uCoiZMC2rnDjbxdo85QhIZNdCvroCibFXTa6nefiPzPQdfNiZYTs/bpCjGNBL69DWaJMSQPCXr4tkmCWZUqstu+CHVJUMr7SKZ2EaiaMPpaSylabV17o1co24r1K1y5f8nBt7TJ6aLZqoLmEhL5GZAB7WRauH63URZfXCcz8yVMsBAwvP2U0ssQk7IgmJ3ih7r+t0OL7rjMzvRkdVaMIwjXAwLwe/9PD7IoHx6DrfGA7sPAjdVXvVl/wp7bZhY1sTwFjF6gLffLVGK5QmprsZx3rI/j/IjzhmIwyWv6XSiSa+cBti37MQx2sbLsF+VVVBL34NrdDfbNArSK6UxEspHrV6M+2C7ohTOw3Zcy54/qCd72VYSpkPWabkQisFcY8r8BA/IuHtHVjaIMLQQ7LJVSTSYOWyFf+V5aVWnrZEMF6iNRabN3I2vowDMo5+roG9Tg==;5:pq+DmA+5t4ZtD/TOt0xUgq+iCA4SCbrL8k7fWTjdbs/pAp+CdeV53K/B4ocPMYWhtQpSwbQkeJb6uYFYYysp1mSVRob2eVN2NiGMfor/XAW+WqK6f3kW2jpXJsU9Af12oR5UKfii+G9hbT1oGL1y5rnF2bJw1GL3w/rtBddZ6QE=;7:AqWlLJDtuxFvcYyIfD4uJiTjhHWcGPL2NeA4EMb2WgUFhfF50TDTqc/6ngmviITj3YzC2xf5wFVuYT8m+hVKkcnNDH7Xns1VWVwugcfbGn7jKWXI0A6rFklNGPz1b8Ou/eDHmzWh0zEXo/OWn1RTspupVQpiIXpyAcvs/R/z1/lPuoYdiAN9jJpd3zfjovOeUoVljoQfzA+ef58C3EqJlaq2C1fO+PpvRkSjHjDCSZDSLf7+zhmw2QmjLPdBV0AN
x-ms-office365-filtering-correlation-id: 513de20a-038e-4255-a4e2-08d61ea3879c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016577E293C33D103B884A69FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wJ3pTGJDvSgrXfOVhnzKIiBjEy63WVZLdiVVG/B6nZqd17zGJjmsfVjAGIrkpQh2aXT0WWHlY/x67StufUr5Rd57ySvdKcXZfsjIQFoz84YBYJj9Jo6G/8eVtbiEg1KJ0q8ppl9tyCbtrZ6w5Qgiey8jlqWoHW0od3gfX0ZGWsdMikRBySW+ECBxa0DgYoSKpwdrO/Ymc5XmmJ9qW+ZWM9E5P5lArMNNB97Dy4g4OoVIiBsBqbitUfyT4JT/fEXGIbprDtojFgQZ2uoLcdCO3Z0oShq/qaUSjOm6si01gpl/isl692sOlBQN4+cNpJA7wI8bFn+bToMQqPCgIz1s2fKNKQp5CC4vQBstqFGx0ZQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513de20a-038e-4255-a4e2-08d61ea3879c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:52.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit cf1acec008f8d7761aa3fd7c4bca7e17b2d2512d ]

When the device is not up, the call to 'e1000_up()' from the error handling=
 path
of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
dereference. The null-pointer dereference is triggered in function
'e1000_alloc_rx_buffers()' at line 'buffer_info =3D &rx_ring->buffer_info[i=
]'.

This bug was reported by COD, a tool for testing kernel module binaries I a=
m
building. This bug was also detected by KFI from Dr. Kai Cong.

This patch fixes the bug by checking on 'netif_running()' before calling
'e1000_up()' in 'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index bdb3f8e65ed4..c1e4e94f100f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -644,7 +644,8 @@ static int e1000_set_ringparam(struct net_device *netde=
v,
 err_alloc_rx:
 	kfree(txdr);
 err_alloc_tx:
-	e1000_up(adapter);
+	if (netif_running(adapter->netdev))
+		e1000_up(adapter);
 err_setup:
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return err;
--=20
2.17.1
