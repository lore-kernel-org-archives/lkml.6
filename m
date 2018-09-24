Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DEFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE1D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CMJDy8cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE1D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbeIXVAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:00:06 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:29512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388399AbeIXUwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kf+Ha3ugOdzw2EJnfJRNmtqK39T66ZDJJBT0zeSPRg=;
 b=CMJDy8cjklpSxAR6c/REPg3zNfY9F2qn2O5zfep999GBHu+9QM4T+c4rRzid/V5fcoXwFbQayvz3DqkY1j0atRF0xW3INEwR7/c9zNmNVWyUCMB0broV7C8bP+Lb5tsVlIhmEl3rhlyDdS7zmVKm3HXcbqbfArGNMCqIX8mM0fc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 25/36] i2c: uniphier: issue STOP only for last
 message or I2C_M_STOP
Thread-Topic: [PATCH AUTOSEL 4.14 25/36] i2c: uniphier: issue STOP only for
 last message or I2C_M_STOP
Thread-Index: AQHUVBW/+O87PRhee0CrhRc3DhlM1A==
Date:   Mon, 24 Sep 2018 14:49:07 +0000
Message-ID: <20180924144851.164533-25-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:LWnBGCgbZfmAl7dR0ltWQacZ1g8hSco81rwRkvhtcmBYHrp1DLuFGj/PTG2Mv9pNVGueZGmC+bPcJyFnorvGd+JKPi6wkh9KZYec+P8QJaV6/BN/cypw2LTCsDGnHs8KwviuF5XZsxQy2n6HHagnFcRk6R66a8ocVAYguGNB3hAs/Q0Sgoin7hW+cE6y7dqKertk78PRvouKI5SfJkzQfoRvlukZiFnGrTbCiF1THQJNTwEqiPc/R8lYTfF8jR1fYJEAS6SOf6ybMaT2LuRkypHKEBQ+SJMFDMFpjJ6e2h0yW4LF2Gw19lDg0YpP3FqBTY5qi8VSqjW6HT23YZMiH0tBd00PJS/ixKBVQLYeh+i5TWbwraCDFYXAwpsTv0/EYFHxdWW/asauClua1by8FdY7Sabbt/91WLijXbS4ZsSGBBVoCWfPvg1sQ1k/IcrwHKJuk/CRTzeFreMONJZhWg==;5:edXe/1NXgim04iOGeaN+YRnQQAN8NkM8NH6eQ5RQTGOvIeBwR6D26iQ4XF7sdZnMqzHqpsTNCkLfpgyxevQ/AdDgAr3q04j5OW6NjGgfN54xXSYnNxnQbQLn8FvTFs6t/yAY+I/2I3vcBykob16qDKIttMGX2V6+mo3/Zt1nrLk=;7:6i0tc8l/VB30hyNnu0K2TWC989L5PxS22uA5IYllfCwbFz2Cvzc7EZhf+Xywe/t9E3lme0aTkssORSKBY22TjW5iiPzmUD+DNUlsDfDQGpZgz2jQlENXJnPOuXQuGOWEBCs/AD9K8MzlSuVUrOYKfoQNYWxYLbjr5QfY1QIT9Ow4VZ9J9RWsMq8hLQXr/Lc16BRm4gPBJZHcTH6IXzNy1klZIf9xGhU9pgN19wI6otCNd2J8njmRlCGgLlrbXdVe
x-ms-office365-filtering-correlation-id: d012b26d-91bd-49a7-4b40-08d6222d0bcc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0470BC77D6E3556A7F277E06FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(15650500001)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UsOc9GZq8aYpPM8Zj5R9WlZ5CqRXwSTcpxNZsvD5c7vlA972v/OOxHylAjEoxhOTsfOCrvYUx9pi1LgUvb9zjdxRsZXITA8LBNJdZpT2JFtH6zNdkTyJJg5YaQrFWSmhPjV0z68SNPyUF8Sxl9fw4sW0j3OFObknIudMfRAo4YbpALh2ykJfIj4EqjTsa3L1c0sWI4US+iVELD3yAbRMXNOCD9Xuw46aUf0cVyZT5sHqlwmUYeg+YO7snA1+XQiN+Z6KjKp7siwr+pWK8tphOmIVwDk9iB2aUtl9TFfnU9S+JqAiwJSfhi4vmi+D0iUvY1ZRPDcRx26V7CvNjG6+Hr7kkiN5oO4RRD0UA35VS0Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d012b26d-91bd-49a7-4b40-08d6222d0bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:07.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 38f5d8d8cbb2ffa2b54315118185332329ec891c ]

This driver currently emits a STOP if the next message is not
I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
ioctl, where read/write transactions are combined without STOP
between.

Issue STOP only when the message is the last one _or_ flagged with
I2C_M_STOP.

Fixes: dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-uniphier.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uni=
phier.c
index bb181b088291..454f914ae66d 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -248,11 +248,8 @@ static int uniphier_i2c_master_xfer(struct i2c_adapter=
 *adap,
 		return ret;
=20
 	for (msg =3D msgs; msg < emsg; msg++) {
-		/* If next message is read, skip the stop condition */
-		bool stop =3D !(msg + 1 < emsg && msg[1].flags & I2C_M_RD);
-		/* but, force it if I2C_M_STOP is set */
-		if (msg->flags & I2C_M_STOP)
-			stop =3D true;
+		/* Emit STOP if it is the last message or I2C_M_STOP is set. */
+		bool stop =3D (msg + 1 =3D=3D emsg) || (msg->flags & I2C_M_STOP);
=20
 		ret =3D uniphier_i2c_master_xfer_one(adap, msg, stop);
 		if (ret)
--=20
2.17.1
