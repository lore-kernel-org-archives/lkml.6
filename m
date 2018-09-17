Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7CBECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5E120693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bEThW6gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5E120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbeIQIgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:36:04 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731449AbeIQIdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOhLBNtUNPJj2c+zqtlQC/3Dow6mLjkefjUKmNYW9rw=;
 b=bEThW6gCKRDmxfJXZ665NwwMCQue5Fl3uptmBNC7/Tl/OCDRrZiZFOaALsXz9h7e1emrhaKReb3FgvoxnB5ZzE0wKTWV32gNjjB2Fi7FgGaFjrzEv1AJk7EXVTFoGJI+71Vwe6IpBwpuRRegZRWI0BzWNI0/BZeg8dQLtJLL83M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 02/29] tsl2550: fix lux1_input error in low light
Thread-Topic: [PATCH AUTOSEL 3.18 02/29] tsl2550: fix lux1_input error in low
 light
Thread-Index: AQHUTjNPIJofp5ky8kSwPV5ce8gVIg==
Date:   Mon, 17 Sep 2018 03:05:37 +0000
Message-ID: <20180917030533.592-2-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:ybE8x9ii4L53MMaNGV/mtWVa468lZSY6tu9Fm7iIEqNvLWMm0KbRgGdVc8D4HqxHlw8wcrVAZknmesJ41+lLkcU5i9jzowHPyzEaGhAvnRROhgWiHkVhRyiOwkI8CD9/x7jK+VRayOqCP3nDIoj0WFy4o54d4Q3w5bewl4BUCGQigZtzcfsfvTRI2dwWSlQPuOcOMvU61sGmE6w1O8IQ9RaZii+f3QBlBPHA4z7b//ILYL9TxXXkFTLaDD9GAL84b4zoD4OGnhn0GmD02VslUcwyKdZP6C8yizg7hw2P033upypTSTpaTubSFKrLd/k7LDARCQsa1UKQ7U1Syj6IFaKzkCBYHeCK+aEZAN2H41oizmuo9zlWzGUKQwBdJRueJmKj27l21VGwgr1lN+MrqqTOwdPlwBH8eTDGdsERjcH+6tGgYQDxYXaQRI3742t9UXpUjBX9SZ/WCNoxi/Ksdw==;5:/vhiPYK96LWVZkhUcRlRn5jmPeZy6H3ce1vv/KSonKHsX78427xEzk9Az86Waw8DEWqvSad/RTrcYMISPCwQEHi4ShwSrCDP5F+JkYdTNb9UV0KD4HaN5FJEiLEVyfpgeAcl8mQopFwC4wbR+wjoxxRU/PcPFQEFYoXxMVYaESE=;7:oQ6FQXacqAwme6B+F1Uao3VXim3fzK4xnJnjM8o4thsZ1AA7tTcfmfnb5Uz1s08/1CRskow6kfXeOGmZu2Gd4zvxyCXa4+DFCrqcK78wJ6iSRT4wQKsiZTpXskuUTf1MWZ5BSOeoARpV4faWhMtfyJ0VlRJOzMa9PqsBGy7Xz8iOxuNosAXjs+1RFWv93sk6d0vWg27NwIvKjFVLOa1wgfN5xFG7x6SP0DCp0oPPv6pI+sFFFBpzmB4FOzWlCmb2
x-ms-office365-filtering-correlation-id: e51b4f54-e76a-416a-89b2-08d61c4abf62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08390C38396DF6DE7474BD61FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0gHhdTpWaAbMVadO6X0bdpBQrwU8YgF90J4RlVFwAdh1lmDjfliFB1dkTNCbKTaGzt8OO+PNnmNlgdV077c8W+OC5LRrQ3YtMwn+yihn6VOy3eKIJrALdsR3VBz9BdaJB3ZWAmwbHG6QLKdCEdaKQ3OOnE6WkhQKgMnt/y0VBHmAATjer+f+9cJjxjT3WmydseetR9WJeqpaP5yezZOHbc4ByX4qx6FSeOMAO6olfQ84Omvq5C9Naj7rMXtuqDhq/NgUtc7702wtHSYNM8hrpCc2OqY/aBkyJPYvCEJ2MHOJ1IRizMr1QtirjcPTKCJYPbLlqXxMsWxzlzuhtYUTPh3yOOCZFXHVLRJiHC3E2vM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51b4f54-e76a-416a-89b2-08d61c4abf62
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:37.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit ce054546cc2c26891cefa2f284d90d93b52205de ]

ADC channel 0 photodiode detects both infrared + visible light,
but ADC channel 1 just detects infrared. However, the latter is a bit
more sensitive in that range so complete darkness or low light causes
a error condition in which the chan0 - chan1 is negative that
results in a -EAGAIN.

This patch changes the resulting lux1_input sysfs attribute message from
"Resource temporarily unavailable" to a user-grokable lux value of 0.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/tsl2550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index b00335652e52..59b9e46c0a7b 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -177,7 +177,7 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
 		} else
 			lux =3D 0;
 	else
-		return -EAGAIN;
+		return 0;
=20
 	/* LUX range check */
 	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;
--=20
2.17.1
