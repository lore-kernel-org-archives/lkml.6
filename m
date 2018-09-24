Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B3A2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DXi/xPSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B3A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbeIXU7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:42 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:29512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731609AbeIXUw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke7OJeQFBoRL0clj08rUl8taC9Wq7yC4oUWfYouMrqo=;
 b=DXi/xPSSpDcgyUTs75dTn3kypgYN4kvz4+9tbGuRDQWjBhnpE8WjngTK1+Dxh2vRnatet001EaqgUou4OoPsRBsyfKXbfMHnKL8FYTa64vG0Pufr21xRFWhjnOo+chM1tbGbfTQXHyC+B1fD6W7U0ye5qnZWSFsauq0G+fHt3eo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 27/36] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Topic: [PATCH AUTOSEL 4.14 27/36] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Index: AQHUVBW/fvbNIebVS0+yQ+nA0/1tKg==
Date:   Mon, 24 Sep 2018 14:49:08 +0000
Message-ID: <20180924144851.164533-27-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:KQNuX7uxfF5KP7Q9Qm+imSOrl4S6vOA1uZC+JX2gMhQQBYTpOesQjuMRoOuIgsmmKiISh+JdrUSXG87tDOO5Z+/pKJlDwg9bVn5BwfsCqcSwRNRAipAYNyPHScuQhB8L69QuV8DS2+wjdmawfKP++l6Q+vDOYuTa25Jy98yPocPMdM+Wzr92I6pvPwPI6mcu3Cfhqbnv971FZqWhNrhfvnEn4Ua0i9R3I2CTwc0uHw5zAKItdrLtD2JuC4Ggxq1KzUlRxAa51V3OYixO6EML1vx+sv8ppnmxPdtts7qC7rY35BHxh/bJaLMdzqPVnkIBulursH3n/AYcEttLg9Aq42y0uh0dUhFwaCrBY/XWVrXv4DX1qTqcr1xXI9tlDW/DSgL2MmsjHf5ocdokV0UV0aGYrkmtxRV5DK/DTb5rq3nR8Y3QDM+39vQOOnbNqaKl6fwRwnMD1DHHXDqUXtITAQ==;5:KK0+VVNg2CfCw50wj3+bcV6nU1fo+tqnF9Lrg0eKGndOQ9a3tKmwVAfoLSGUajIShZAUeEDMN7HMouG+LF+JtEwWiUIOJxEJz3PQAjwk4GHRSrTgwQDEfaqaQxymq7XPHW58KzLXekLLTs8u5Fem6/wbGquasNBkGgBCsFfHqYU=;7:/xA11Aqd6liaPEc2PTkSH8V6W+D5VFMo7Yk85vglLsOplN3B7wJEtYuipD2bNN/QLK6JtJvzNrbpkKjBN4ZV2pYkL5NwmmiR5BRMzofstj1JGHIvkgZgSbJP1KI3ndrKht3sLxhlfWZYS2dBxPmTn0MDrWLzsxhsW4ZUMOd9E3KlOw0bvf/dIVhUIUPTHtXRLVW203WKw4RMBP4ACj/csbowCJEx4NJPxd91/HS3QlhzewlRFLhRHwLrZ9jIUmKX
x-ms-office365-filtering-correlation-id: 77924420-e666-493f-3aef-08d6222d0c85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04707C650B08FCD50F3A01C9FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(39060400002)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f1HF+ZsXMexL2O/qnMZLzRSxqV1exLkg5sd1QK6Q16O0Ff9/kdH+Njz06ulFxeJwlAP3eSY42DY6Buu0IeowJSrCH6El7aoRlj9IWwBWhwuDx2cAcV5sJWUO90L8RlU26WoGYfSvhhbyY8plo8WvUOhVv9/zQnFI98zG6gN+PEVZ5A/GlAIuCl80SOAAYit/gm5xuV/GncWqRXK/h6u57KSVwQLE0s67vHIG4W7kpa1NC13aWzlT4flPdS7jnhEIAP1Em8m92XdncEKxYtJDrAreB/guC3cRyGRVadod2/OhipG4bRrQfi/Jnifhqyft5TDL8JfXtXqWEPhRk3ktxoEuOHi2aZrbDFeLELuRPek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77924420-e666-493f-3aef-08d6222d0c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:08.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index dfef4ec167c1..c1787be6a258 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -642,7 +642,7 @@ static int macb_halt_tx(struct macb *bp)
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
