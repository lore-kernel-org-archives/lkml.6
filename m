Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57243ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BA420866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cqFfEzph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BA420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeIOG7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:59:30 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbeIOGu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxwcuhKbju/qE3cveJyQU7IY+FBZDdzpP7AdAPi2lkQ=;
 b=cqFfEzphsVX6W2I3s0R28DZ6BweVaoUOTJkC7nktPNOvL25WmUkkyvO6dV6E4LXe4ZmzINZ1BX3THk3GWCqSQC8ehP5dde1DmDdiexDwSEiMiMQruSdLdaXVfc1gixqK0qXfI3+sejpG5mEaeU+OVU0N+zv9sZnnOU/Vx9YFvsw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 40/57] mfd: 88pm860x-i2c: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.14 40/57] mfd: 88pm860x-i2c: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUTJQGfgJYT2Go50ybkNv6hPHbcg==
Date:   Sat, 15 Sep 2018 01:32:54 +0000
Message-ID: <20180915013223.179909-40-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:X/6ceVA3ilTHCzJiHGWIJws9W51Wb3BvXnY/7SqNZVlTu4Ep9P8i3hOHqHNPgZDJeW+YyEzXSlTskIFrU2QwQN+zT6NdYI9vVeo0I4k9620DA+7GE54EtswVYTmMrdP1h0eq4eAKpXKl1CaNQrHiTeR1ZVo6p5yDhq889pNwni0zPzSdaDwfVWQFmc2sF0n0lOU2km3jSI01tEZAX0pV3YORMHhB2951+8E+TqcO2vsITpMbQMqP+GJdXoI3DhDXAmiYtnvEIdmuThNl0wDBtOdydbDUarQmfrnrlclo/78p+Iglho2Pi/DQ75+vcAQRW+BQ19YCS4lnBTxcQecsz1BkLv2et9nr/U+j6pC8qvVgfYWWUtdw4xCS0R5RSE2c2oYd1i4TQRWW3d/x1apTqKBruCNi2yBCKwc19NRcaFRGZ4tGoFvZJfb4T7FtzSRboIkrJnECGWD7m3taGLzP3A==;5:PA/2eO+mEqYQZQ4pqM8QH5BrKTPMyaUKKj2zie8iEE4gWftzkhYQ5rngaD7wcnYofWNZMbU9VirBXzl8us2xZpOVzAnASwAO1Pl1l2cXx9fmUIu1uwJE4wXBi7mtU6PE6FKp3AhoAmOiETOG9Hqmnue2RuEPakkObIPu0ILH4WY=;7:cpM5jqSKjnqpeFvMHJWL4LqbV7PER03h9wiqSUgZLYPe6coPrD6wJyhC7TNDUrR53jNvHsHx6vsPPleB8dyDo3Uf0cJpiBvr9qQNco1aDFAIN+tOvTn4IBTeeU0ZIHpBXd35OnUXmj8/Ipa4hbNRRpC+6J/XhDwrEZ/JBCSg8BZD4akZuR/UWxsX6PLCVZ7bQDYjP3PnULrlseYOWz9qhb0j3SaoUJbvhY+hekSEVKmP0s6/2jk/p6axzddBibdp
x-ms-office365-filtering-correlation-id: 74f59705-d6e5-441f-4974-08d61aab394f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471CA09145F3BF6E8ACA4BCFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005)(15760500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Tl353hZNwp3NPCnvMW+WyqSrIcAXQmGUvsGOjb7LUVZ8wF6wuzHOsDtTtRfUNVsXuThYcyF8fZftXltHu4tj8/rLHvbJ3b6HiIMAt2sfypmJEeNsh4NWq2tsleouf9qJbL/YcSn+K82WSk/Uc3D0i7uxsYO1HdUtgQXdLAS9o5VeW59fzrP/BrKp5Xr7nRWIWatbrN+P4k9zjTrWhzjq3UItsQ+2qNe96ybhSd7txFkH4ls7v+gcauk5A1Psm14XplunzOo0XlCFJqrOAYTWk14kJn+7IecIqm24Zpdmnf8IdxOqIDsCSOYbu9RlULsvoZ5FrSvcii7t/8JTP2H8pteBmHtusUnJ0Ukqtbt9x3M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f59705-d6e5-441f-4974-08d61aab394f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:54.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 8c8f74f327a76604a499fad8c54c15e1c0ee8051 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/88pm860x-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index 84e313107233..7b9052ea7413 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -146,14 +146,14 @@ int pm860x_page_reg_write(struct i2c_client *i2c, int=
 reg,
 	unsigned char zero;
 	int ret;
=20
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xFA, 0, &zero);
 	read_device(i2c, 0xFB, 0, &zero);
 	read_device(i2c, 0xFF, 0, &zero);
 	ret =3D write_device(i2c, reg, 1, &data);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -164,14 +164,14 @@ int pm860x_page_bulk_read(struct i2c_client *i2c, int=
 reg,
 	unsigned char zero =3D 0;
 	int ret;
=20
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xfa, 0, &zero);
 	read_device(i2c, 0xfb, 0, &zero);
 	read_device(i2c, 0xff, 0, &zero);
 	ret =3D read_device(i2c, reg, count, buf);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
--=20
2.17.1
