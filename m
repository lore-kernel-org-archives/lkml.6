Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2DF2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j3RPGZ1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2DF2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbeIXUxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:51 -0400
Received: from mail-by2nam03on0094.outbound.protection.outlook.com ([104.47.42.94]:22973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731821AbeIXUxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2HOooh7Y+yKGaoQB25OJw9RcNHcuiP8JIHWx9y3qUc=;
 b=j3RPGZ1aRieZXJZL5Mujp5iwHSDakdDPohbqiHeYbYAiyje98JpgW0Y6bzYBZFIc6CEuN6QLXoJvmX8zZX6WAeV8s63RKs/F/hshTdxAoKFwBTolTLNjrpQPwRPeKnjlg7UYnvRRvlZQHpjGSxjU3GZDXYKeb3029TndF5D+oHk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 15/23] net: cadence: Fix a sleep-in-atomic-context
 bug in macb_halt_tx()
Thread-Topic: [PATCH AUTOSEL 4.9 15/23] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Index: AQHUVBXNU6ZLKQFtOE6bpW6lmi/LeA==
Date:   Mon, 24 Sep 2018 14:49:32 +0000
Message-ID: <20180924144919.164617-15-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:J0ReQdpLoJ+HEvn0M7Q0byHjZhUBKdIx+Rnc+04Ue3mDMfmH0YPfblYKdZsnrYaJkOreTNkD21PsP4a+jr2nUxT7IJ1okhQmCBE8Fgix7Mad76x5hpWwPlabgETBUEjYqkczBI2stHlBJ3mnofyPL5FQi6Y944CLyeFmJWX4YP+pi4XUV3s7oyyKKSH/G1FgJTtoj7P1E9eOX8KrgLNc+flxLTjf/mjVBFlbD9jOUWkglP2Njn8KkhE859xNxOAqH+oSjThRujGajgWA7KBuNH9X5vspVJwEeVatV3SmNSDNCvBJlnmUIB7WKqg8QZHbAAXD57KUt7eagKvikbwZnbbA+mAIRRhLB/aJFGe3cCWM0TiATd8nNlfkHcL0hC5Epmn71CfUsrGR9NshCbJwoNCVNeRvOFoaAqQJ1Us7BP5d6LZWI3EdclMkwIW4nsjkv6CUMexTykwbDbdlAYFXMw==;5:Ouo5Wwtj+Bl9ojezeD4V0eOeMVCToxS9ptVzmmGfzYKzy89QnMWYk40EaQjRlghPveAM4WNllcIzoZwu5HPk/z+nrE7WAWwQzPzUWZZlaJctFYU0UzgBnUAYnNYaZK0IqVcPOfICNzO2AEMwwKHrniNHtGRycaWnTyfJdDtl3G8=;7:pmpa6j4cIYBWYfyYagdWgvL/drAv0j+nKwe6e7yDavNj9gMcKblMTdQyk2c/LerwSCLGYELmZipgXIfdp0ASrYHhHU92JizuZIZbgOeD7kvn/HdR5VGIt0DNbg2K7Eaj6SFqPQQ1kspd+GQlIshsdkNn7EtOrkvCwVa7j/YD4ENNIAqdfqObVjlsuNGKpuckFkQWoRGQXB0UKhq6MN6RrdFENc/OT0tEwX5cRErO9nQncP/08/7dwOJpMfL1OBH4
x-ms-office365-filtering-correlation-id: fa171db6-632f-41ac-94d3-08d6222d252c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01818E92E7F6C46FEBEF9898FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(39060400002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N7BcbHPSVVRuFkVRT0DKhyOF21JK0jMMxJFLjOpme+9X4hQlPuHNTwhxzJCuf+RRG3FNknUfoz8fN5Gzvzq+yvOa+puacE0mmFqj10Gd3Bj593r0FjFQcHd4/g5AbGpKnQ00MZhaydwpOAy8c0xSQkx73ycSG5hNmdaujCULwMLIii0bZb4Ra7k38jr1U/RN2wnYo3eKYWkK1qJRafqpd82ztKKqk4Bg21NqxHd3KzTqX+X5m3BHNJP6VZV/9ax3JHZXwSlxuVo+eO6WlZn176EQNDTQ/jdcijNIUgBcI3/uQQ77TIq3za0p0DH64XMT/KvvUMrrRLEPL8FFPYp83y/NGQBW+NtNRFjJ2hk58QY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa171db6-632f-41ac-94d3-08d6222d252c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:32.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 16fe10cf92783ed9ceb182d6ea2b8adf5e8ec1b8 ]

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] usleep_range
drivers/net/ethernet/cadence/macb_main.c, 648:
	usleep_range in macb_halt_tx
drivers/net/ethernet/cadence/macb_main.c, 730:
	macb_halt_tx in macb_tx_error_task
drivers/net/ethernet/cadence/macb_main.c, 721:
	_raw_spin_lock_irqsave in macb_tx_error_task

To fix this bug, usleep_range() is replaced with udelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cad=
ence/macb.c
index ec09fcece711..2e1585635083 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -517,7 +517,7 @@ static int macb_halt_tx(struct macb *bp)
 		if (!(status & MACB_BIT(TGO)))
 			return 0;
=20
-		usleep_range(10, 250);
+		udelay(250);
 	} while (time_before(halt_time, timeout));
=20
 	return -ETIMEDOUT;
--=20
2.17.1
