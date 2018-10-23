Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A96C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3BF207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JZv0G64r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3BF207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeJWRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:43:14 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:21977 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:43:13 -0400
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="21966755"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Oct 2018 02:20:40 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 23 Oct 2018 02:20:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvnbSGl25i40ez1l9ky+TyI6Wx0ip/AcInoQ2WqrW+E=;
 b=JZv0G64rOm4Nb1yRnfP/18VTkqiKlcywZgq4gLb/L9jdLorDGNI3paa87fsPphJlH9NgeDkKjWtK/V0ZmoO3fhVDlko3RwdYUHQdOvHzBYlVXzmAsMmmU3CLjfXtElSCWRJf9S3NEzDV1Zo2UZOAXMZ/t4id9cP8YS01/22LutM=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1524.namprd11.prod.outlook.com (10.172.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:20:39 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 09:20:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wsa@the-dreams.de>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH 1/2] i2c: enable buses to save their clock frequency in
 adapter
Thread-Topic: [RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
Thread-Index: AQHUarGpO/aLa/rmXE6ECdVIjIJ/FQ==
Date:   Tue, 23 Oct 2018 09:20:39 +0000
Message-ID: <20181023092025.32463-2-tudor.ambarus@microchip.com>
References: <20181023092025.32463-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181023092025.32463-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::25) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.7.230.215]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1524;6:sp7YZIvmdaIy7wR2aAXGBrYVD25gfTPYAgT3bFzUBhMvrqiP2cxUtUFVWVyN0gO2H3VWSVbKYIW0GgcNWAMEl3JOpc4nj+Ax55vboDc4hz8CuZKA6e/NbDpQGiks0h2JvCQlyxl3lu4NSNugUGB3GEKPAoXxHqureQtobnjHA3Xkt7QwcNWLwYlusQqn5Q6zr+IBdGKbsFkaPAZuX0Kl8CBQ8dAPcBJSwWQDBH92dMXMkSbyJaQ+dpC8aWK37nevhl1dZM/vRYJuL7725x5AsJl9bpaf50Yad794ZilhMBirveqgSAIKjJvH4zvo0ldhFmr4r9UAzh3u3qE2jFkXPcwKTcogd0nUwXMEQJJLxp2i+YNoJGC+WuZFo0rvRlWwACXiwhdlyIA1cDZXzkKvi+rkdyL3oHvNX/HWuX5TofM7L9YZP2V5l6eQ+cky/+504xM1wUoH2yWt7j1xMTzrEw==;5:RuOHbFh1HTjV/t8dzZuw9HvZjLhgM7xSOgbfsmS1LyKZ+fGJaR9BVzfAaLFvtYLW3yEs7jmNIKCI55jkwlRdc3EyiwwGkEgGwxjKk9LtCGRiZrBypLsyphYwixTCC+iu779sUZwK0adl4IxnbWesOmR8UHDr9AA06RCoKilMZ6c=;7:/JGNl15sWgt/RMXUya5/XLWBkA9WVInec2QfNUrEslMvKMY94r0AcDbEtblNS1Xpqigml/1pYL2w5DofY65q405lfQhA3SRTkBpnpyZ7+galCDaKMLgNdF0WyWC5t6OTQH3z21ztgu1rK9FAwmYkcZxKgiK8x1wsriQH47NxWnS8RKhKfOS+HCys8RE0uolm0RIXAfCN1+9iCwjYBoZd3KE+PwxbfGA97jOAt7PknrAVdUk6GMxKi5yTT0AaF824
x-ms-office365-filtering-correlation-id: 60ba0b3c-5305-495b-f65b-08d638c8cc00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1524;
x-ms-traffictypediagnostic: BN6PR11MB1524:
x-microsoft-antispam-prvs: <BN6PR11MB152446D691490E316784F7ECF0F50@BN6PR11MB1524.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1524;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1524;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(52116002)(478600001)(26005)(4326008)(316002)(14444005)(86362001)(305945005)(6486002)(6436002)(6512007)(256004)(110136005)(7736002)(72206003)(53936002)(14454004)(25786009)(107886003)(2501003)(97736004)(36756003)(105586002)(66066001)(486006)(106356001)(386003)(11346002)(2906002)(1076002)(476003)(6116002)(6506007)(76176011)(3846002)(5660300001)(446003)(2201001)(5250100002)(102836004)(2616005)(8676002)(99286004)(81166006)(2900100001)(71190400001)(71200400001)(8936002)(217873002)(81156014)(68736007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1524;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EY1bKs9mcd0aqgQHl3Fmt21kOleCdPI4WjosUf6/kIX9lGOLT6AGrKAv3XleiFyAFHd0QNARYC7jbeOVJIfZ/2nxdilorkd6VE4PYoq2Mk/kGVXewa0Rx7NpUKthOlnijAyRVjJ+0IaTAl0atlV7hR4V5W3Jy8A8rqJiaZZmMcwGN1m0Uz+8zE5OsRGSPx7HnTkUfhFauoSsICZld/uIagl+wySg4FZF5U3XR4CSICxid5TzV3iY93ltDWdOMCWidPqzsKDnIL+/DzBnqb2p5z4IL5eE8OQODzkv0yMBue4VT9Ian7uQc86hWx4AXQUCJFFAUtr/5VYKXOBtrcZa+sk1eEnzfDbwvpqaZjEWs84=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ba0b3c-5305-495b-f65b-08d638c8cc00
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:20:39.0639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1524
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwis=
e,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and enable the buses to save their clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..f238da204c49 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -677,6 +677,7 @@ struct i2c_adapter {
 	struct rt_mutex bus_lock;
 	struct rt_mutex mux_lock;
=20
+	u32 bus_freq_hz;
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
--=20
2.9.4

