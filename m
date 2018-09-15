Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB303ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9891B208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SEyv0o+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9891B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeIOGs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:28 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeIOGsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syb++/azLVlLREBVeFeTRDadf0WvnsJs4n9FENSk8IQ=;
 b=SEyv0o+nOZ8NWO3cFFJbEtmki275dy9Da5ejVT/D7ufOWqBRBc9PwXxSI3eGLtpg/TPGBHJg1MhpkyTeCm78lz3SSUkMnLVpOyT35/yQYqZqzllqzHbfI44OtmbRi4BkFUh2rUlgkR70+OH5QMBlWE6R6d321aRmu+qJ0enY5bw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 59/92] net: gemini: Allow multiple ports to
 instantiate
Thread-Topic: [PATCH AUTOSEL 4.18 59/92] net: gemini: Allow multiple ports to
 instantiate
Thread-Index: AQHUTJOwJfiEfbvox0SRNTDASpGt/w==
Date:   Sat, 15 Sep 2018 01:30:30 +0000
Message-ID: <20180915012944.179481-58-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:0QK4IoT8CFWQHm9joxu/4oElwSS5sOrO58vDQIdcy6J//eJu2KsafQrFCFv+OfSlZB8ljiNpJCmhxtdwm5am8Xrg6Jn/9VdwhLoGvPzo1ZvhEp7rPmziwwRq6ZLkTPWn7gNAYks6fqMt4TxZXHZKHovyzALt3L2mO63oJjEW8KYu/lyeyqGMvsqa195dMepwYqYzNYcbRyfDitP7Ret6PutadA1uUqkMEE4td9WhBuJxuXxS7jjD6UoBb95asZL+3IzFOkFnM7Nf2alGi/+YeLyCi6SrOBjHIdfu5kjm4VF8QiuACp4R/pZjRquy6zkitcD539uZS5y1vsCIbECFs8VFx3/SrjsY1UhDaDC2Se8l7cu2XMicHXYgMKqPjps9OCPWychr9c9qu88zYlUe9ysTYbiAMq3buQVzPB5G09osvdXmD+MyT2VVYDa/WZwOiWJPdZRBgPOlFx4O9zPUzQ==;5:T3+6zfKCpZaLcO5aAPiHQQ5qGs9QoGbn5GFEBLnhDaUwmBgjXfPvnlitt26wpzI8NpjRn2eFZ16LRuzG05eXxMuWqzuwSmCVrRduysXaogmAB+Hw9Z1HxpFxnrn03bfnuhwYTi1rmV957b2AxWetyDkONicUvdlC36ihZhjKcXk=;7:BKr8PRalYrZ52OEDDURRV0zjFpcMfs24UDRxYCvWjobqPTZQxfouDVdIyRUq6WRnDuWG3zzPCg3TyLTHHx9yngNt0VAhC7GzhDwE1HHdFNClovycGMSlEwVJuk2PRFvgr+GpAEFWzWr4gOWFc2dFaotZl+okcxwZu1pnGo/PjsK0M1KZ12ydiQ9a0uWBhAa05agwo2d/H92LnLMd7rDbLScQg0ugXYxm/rNRgAvYbMk6/exBHRNd4bBXNvyyM69p
x-ms-office365-filtering-correlation-id: db86a5a0-b88c-4b66-7647-08d61aaae37d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741ADFC1A132FCE5FF66710FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0Z4KCftOL9KrBUcTYaUvn1McLpSlOBg8etb7ljJ55LqD+IaCD92HkTgPlQC+7qfzK4MQ6UdT3Hj3sfAdksk0vrWdRg6Qe9oy31AQzAB+QJTIBtK3Or+5TrP++nHdBKzcEVpH9GjJsebm52lFKLoJSKxUV8zoIe7nbhdf0IXEOky4Gg18lxoENO6i22Cp5//OHXbyIxg4T9bKIRVH9l1biVtfOQGrLUhdof1DoY7iGkdN2RYqZYrsSvEfKW4/I/svrBeE3oZDN57l9uvMWJTqWATmGIIshKEzcppslfyHT28BO/a5OHy6hRvMb/oOOWZnO9YkNAMX17jaj+tAVfuV8J+gDcytjXgFjW044Bdpu/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db86a5a0-b88c-4b66-7647-08d61aaae37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:30.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 60cc7767b901dd1e3f70755c3d2505556ba487c2 ]

The code was not tested with two ports actually in use at
the same time. (I blame this on lack of actual hardware using
that feature.) Now after locating a system using both ports,
add necessary fix to make both ports come up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cortina/gemini.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/c=
ortina/gemini.c
index 6d7404f66f84..c9a061e707c4 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1753,7 +1753,10 @@ static int gmac_open(struct net_device *netdev)
 	phy_start(netdev->phydev);
=20
 	err =3D geth_resize_freeq(port);
-	if (err) {
+	/* It's fine if it's just busy, the other port has set up
+	 * the freeq in that case.
+	 */
+	if (err && (err !=3D -EBUSY)) {
 		netdev_err(netdev, "could not resize freeq\n");
 		goto err_stop_phy;
 	}
--=20
2.17.1
