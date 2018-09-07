Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3672083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GhXZy8SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3672083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbeIGFR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:58 -0400
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:43908
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726984AbeIGFR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCkxpXbdKa96LmvKOLp9MCkQNUY+WVLyVJ+RQH8hop0=;
 b=GhXZy8SZpIIFHv0CDRaIyVClwnx11TOGTDOsr/EBcCfxGMKLCy8jSHhgdgll3r0XnNu5Yy3FsHUivdkCeLbC61DLZnXL7eqplppxm324YjbGOOJZQXlGmoG+DwWRPLEu6nYl09HQibkMe67hgAthlsluKwwqNTts61maohuOqvI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0695.namprd21.prod.outlook.com (10.175.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 62/67] i2c: aspeed: Fix initial values of master
 and slave state
Thread-Topic: [PATCH AUTOSEL 4.14 62/67] i2c: aspeed: Fix initial values of
 master and slave state
Thread-Index: AQHURkMK2R2hvyewVkmnFihfA4k22A==
Date:   Fri, 7 Sep 2018 00:38:05 +0000
Message-ID: <20180907003716.57737-62-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0695;6:esGVJ2yYDfffHc8ougy6j3GUjgS//SBfTbQvoLhIT0kh+jgcMAPr0RtZAdJeUwG1ynjgDhMsbfzWH+318SND73DaXLfpCAVOlEBrwNVYyZg6JaKk/tNj8tmnQXy3EceAGK8kJC9vef4N+LaihAZflL4ZOhKA9E1AO4ooPmH0SO7mQB8K5X36B/8TQJSnusfMJ/J0Av0SJTdSFzcph73R66rcWL3wpfUtvMvW5VncKWGW7QMvvhNVGI5SmjfbLthX8ynX96QYuZKJSi9sJmmNb2RQ5Rw7trkYOjkbGVMN3Phy8N7HDxvts81kVfG0GSfdedyI14flE4dJn1peVS9eEupJCq1qDDEzzd45XWi/4RRAdiXHMUcP9h5+0C24HJIGgEAv23loU0NBIsKX7VLqjkyuWfLy9XEbBlPIK+KfTWF2cqJDcgTxRbbqoH3mr76/kqe3ZcNd1xWzRZo9FkoaGQ==;5:h6+EYNIndoGnd4rgSnVzMBKuF7vy+S4cf7WCkFifkplujLpgG6wLwjbqRTIOa8pt1bC6frTgacZyKsuyFYdg4CNilXyNWt0bxKZUFTQ9OtlGxDZLhXJ87eWXb64jHi4oGK3VXAAfGL3TR8ye8pW3O7X/J6TIbaLpiek2Az/ohAo=;7:GHXu8mxIFsUQ60TR/K//mi7vCWJnZ6zaKjgBiG9YeoWP58oyaup2vpwpbMLsNJypRc5OCr7981HzcmHUoJ1F8OIxa7hJvkB7xACYAE4ZKXvh7xSAzqaXPPN/vEkAk7GfMVQW0dIeUDin2EoJtFvYyZi8lbG3hnZ5yE+XmnORXuVK1eJhxvv+8a5b4tFlaao5aglj7jvd69r9Da2ofbBUjvZAWFcdLz2PbUI6422EyoVtsqwhmZko5znpTed66+xG
x-ms-office365-filtering-correlation-id: 63a0c57e-d3cf-4240-7fbc-08d6145a5400
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0695;
x-ms-traffictypediagnostic: CY4PR21MB0695:
x-microsoft-antispam-prvs: <CY4PR21MB0695666806928A54058FBD99FB000@CY4PR21MB0695.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0695;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0695;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(14444005)(99286004)(6486002)(5250100002)(256004)(6436002)(8676002)(81156014)(81166006)(2906002)(10090500001)(97736004)(2900100001)(76176011)(305945005)(7736002)(25786009)(36756003)(86612001)(105586002)(22452003)(106356001)(575784001)(4326008)(66066001)(476003)(2616005)(5660300001)(486006)(6666003)(446003)(11346002)(86362001)(316002)(8936002)(6506007)(6116002)(72206003)(3846002)(14454004)(217873002)(2501003)(6512007)(478600001)(1076002)(10290500003)(53936002)(68736007)(102836004)(110136005)(6346003)(54906003)(26005)(186003)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0695;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6krRTd4lZhO4tQL0J7PNMPi1yCNrHQSSnDAE6VZWOhFQLCJcyTJ7npcQASKQvA9hjFflWkC340MTHv1KDEGd7skntAe7ni79BBhcdvlMbomAPlRxhin2thHG7R6M/0tut0CZrnt873YKUhjDsZifP8BPRYzGt3xm3bGKyi18ImSRwijVDOF4vGiZOtrlaP4UD3QtI0BoXPhizwml3m6etW7iumWW4K8UNZ5r6XmeYBvnXt2E4Y76nuIPOZmVnpu7/EYfB0WD2D9QFS9TGfQbTthQF1PnIvgu8nBIs7f/keTkl9B9Ar3oF0F/v+gpMtnPExRzHgAek2lkaqNS9ednctTcxUem1V780L62tUfhwE0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a0c57e-d3cf-4240-7fbc-08d6145a5400
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:05.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

[ Upstream commit 517fde0eb5a8f46c54ba6e2c36e32563b23cb14f ]

This patch changes the order of enum aspeed_i2c_master_state and
enum aspeed_i2c_slave_state defines to make their initial value to
ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
In case of multi-master use, if a slave data comes ahead of the
first master xfer, master_state starts from an invalid state so
this change fixes the issue.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspee=
d.c
index 284f8670dbeb..d4b37aa98a49 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -110,22 +110,22 @@
 #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
=20
 enum aspeed_i2c_master_state {
+	ASPEED_I2C_MASTER_INACTIVE,
 	ASPEED_I2C_MASTER_START,
 	ASPEED_I2C_MASTER_TX_FIRST,
 	ASPEED_I2C_MASTER_TX,
 	ASPEED_I2C_MASTER_RX_FIRST,
 	ASPEED_I2C_MASTER_RX,
 	ASPEED_I2C_MASTER_STOP,
-	ASPEED_I2C_MASTER_INACTIVE,
 };
=20
 enum aspeed_i2c_slave_state {
+	ASPEED_I2C_SLAVE_STOP,
 	ASPEED_I2C_SLAVE_START,
 	ASPEED_I2C_SLAVE_READ_REQUESTED,
 	ASPEED_I2C_SLAVE_READ_PROCESSED,
 	ASPEED_I2C_SLAVE_WRITE_REQUESTED,
 	ASPEED_I2C_SLAVE_WRITE_RECEIVED,
-	ASPEED_I2C_SLAVE_STOP,
 };
=20
 struct aspeed_i2c_bus {
--=20
2.17.1
