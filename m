Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D252DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA9821A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="fZOqjrPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA9821A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeHFOOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:14:43 -0400
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:38336
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731324AbeHFOOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUhSTTFWjq9QtTKogSkoK6OCRvNrcnQJQ5bYOOrEfBA=;
 b=fZOqjrPbJePL5tURduvLHHl9nBAyLz+fG6tkGSfFphclnPEaSIyBson7Sbu1zpumnC4ITjB8T9Yt7PmP6T8u9s5gpuMWEJ+mjE2AEO+Ul6DImKCBTfeJWzFQaIggwCZEVR2k/H1OaDL8pzL2D6MUdNBVzwerFe2mRlQEGloS/8I=
Received: from BN3PR03CA0052.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::12) by BN6PR03MB3123.namprd03.prod.outlook.com
 (2603:10b6:405:3c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Mon, 6 Aug
 2018 12:05:45 +0000
Received: from BN1AFFO11FD024.protection.gbl (2a01:111:f400:7c10::112) by
 BN3PR03CA0052.outlook.office365.com (2a01:111:e400:7a4d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Mon, 6 Aug 2018 12:05:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD024.mail.protection.outlook.com (10.58.52.84) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 12:05:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76C5iiT012565
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 05:05:44 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 6 Aug 2018
 08:05:43 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
Date:   Mon, 6 Aug 2018 15:04:42 +0300
Message-ID: <1533557087-10401-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(438002)(189003)(199004)(575784001)(7696005)(106002)(51416003)(7636002)(5660300001)(7416002)(305945005)(16586007)(76176011)(110136005)(47776003)(316002)(54906003)(72206003)(106466001)(478600001)(53416004)(2906002)(4326008)(966005)(6306002)(48376002)(50466002)(186003)(8936002)(50226002)(1720100001)(36756003)(336012)(8676002)(77096007)(26005)(356003)(246002)(446003)(2616005)(476003)(14444005)(426003)(11346002)(44832011)(126002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3123;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD024;1:tjwO6WyNoLIRyf35SdGhWFOrKwGDATOK3Q/fpQH/p/EUTXW4SlgWFdvD8gCbDocE6/qYVbN7IOF4Y/vv96VA1HG6nUzwxwEFQPRK41EW8DpXKN4Y0qrll85a6G4lJmhZ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a32a989-8dfd-4e13-21e0-08d5fb94f08d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR03MB3123;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;3:s7XFlCl1KLgDwAkj1tU7a9yNzi8tg5pCBZDal1eZDk9D6faU3lYtzz+fWHkf0egQCu6qDmHVQMk9pRSd3VwglBJefDvKyjTJERbgZDwLj6lt88BNEnzPfJ+vSNGofiDcKVqiqGXIFsFsOHm+93OZJYOAW0i5zDidsyEYYI66OYbd0VUqXV6vhf5aGycYwXZgWJYoC1sYjoiuWm/qqEz4luvoirpgftsWWk9hB/12yL8g7vTTss0WZQgj/KnaVLqoErs6tsWEJaea5WD4wfky0ZsspR5ePWVithyKbkycsYTXf8qVZcW40IWdsSlKDMnXMS9HTmzp8F8DUaZeAIz3c2OhCPBMRpjzxwi9gAQi0HM=;25:hS0rfqOLrhKDd3f93+68bKqyZikWmjL8tP+Mt2n3yMWeQOgYqfmYCeeMf2w5RKFXSsP0C7SxZVGI9MZ6k0lgwMSfpeKy2OD+Cpj/Gb78yrw/DE3pkTYHaMgIUiRJ4ztuM3g06YiBY7pFjYwDmOYRVfqRWR4PAGFhG11QkB1dpRrDGka+RH8DodtjOJdynLcraboQfp0OLWhYnWJ5oesDkKUqMgXAeW2xnqa+ScKlJgwlUfwgpAaOjGgM5UCp7P1/64hNYyPfCfqKtiVqXXRzwJZUJyplDtXkHS+F/fXf+YeKeNdLlebrHxlPrAopKylHJKWBsKL8pEnYhwQ5ls3Kng==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3123:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;31:wcrOdgL42H3M8kk0Se9WrXfTHai7sWoivns5wwjZLMs8aSfU9mu21VAsXzd4hdnjDakYsx0wPjQX4YnsqfwUp1ALRKxmsTo92JTWEg0EdcUe/5Wps2BaDQfqaR0FP4ZFJE09czWcvQW839wDUtoFxC8pVP6CKVQtNcxHMgtoqpZBvgKsACtHcfa3hdOwMYeg8T6mTNNJ9dBdiR30JqcuVkdl1FN38yHo9LHzrfHXrFk=;20:EsaM3hD35C7Iuj5+MAEuj6Ybuf49By7PsYs2Tdkk5c2aXUyPm8X0rSGty+e3RAvOMJjhgulQcetrRhz4BKYG1ejaRJ/T0204DPjUiEaJ1uS/pi3J+109JxD6SzYRSWf2m/flfuNPCYcObkEYBV5KUpeD0BxuXIJWyYW1wvO0AI/fAfzjEm28dwkRZZIqcIwaoM1ig1u+euPXcdHliUTXQ7stUybdbRalU0zHCqEDiaMiI9Bj14rFrkm+nltJYjIXjydohdeLOeI6UhaKqD7Ax158tpihtzM7O9f0KC7mD+LB2f/6WsAD9If+rZu8Y/n8RFG8+VB/jYthkK4ZnrpWGoXub2Uie7tg/sF0TU6+Zk5po3YG4EssWAS6wSlOZrXuf4cHf7r63rJ1GOBpu3IehSvAXJpFu+zS98G6XkzHnuoJv3jnwthzJJZ56uiV0RKGGWZR2VvS09JCytI7CDdFknKCYndUyZcZkR0EMidLYnrxVxOzmmymVOECIokZ2O9o
X-Microsoft-Antispam-PRVS: <BN6PR03MB3123C10A41155BEA78E4DCFE9D200@BN6PR03MB3123.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3123;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3123;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;4:BU3rGV4utTytIwi0ywzeQe7Fby2irIgMdjUO7bJIIXUezFMyjAF1JWLrQ7fNEui8LkO2btC6n4z4R1IABezyVt7JVsvfUEMcyIRDCvXfexrQd9OiZwMK1W8TFD443N8Ok2NM5YPVH0lteHp5T4XiqYHmb+hpAMvLefwqyNPGhmx2hQhIJ6i1g8ZEK02T1rmgDQz1JfMvWAGhuFXomVQOWbhKvHfSCkHH4j1mzzg79WlVbOzDVOGYxnAmN1HnQvIqSDLZgNb9WQU7TrRzjJHc39NOkpkbbfHudv1Jf6rPJ4w+U4a7XYatGU6d0hJbNVrTgo6ipUm3LOsEIjrTy3xZbsnMcxUQZNKeu1rByhoZhPdq+s7eCZowsrJj0M5cThgLMoTxJZdbTnB1SMx/mHhpsFoigr9xsIncOhnLcX/+Nvg=
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3123;23:oeTaDOiZyjZ5U/VcUv3k1Lp29GnHosP8p3eenXKaY?=
 =?us-ascii?Q?s5jIz5zU6tFeDgNZ83+3HfcFsn6eyHNH0fUUx2NSIZKS/e2vDHQAlUNq1F5B?=
 =?us-ascii?Q?Q/XOGtfyVd2eS8zN315oqI3o7oW28E+d9hiDOPdSnD4Aty2DWc34+s661dsv?=
 =?us-ascii?Q?0vzG9gfvL3Rvs6pZZ+8Gf6vCYpjFECJGmET9s5tw/0ri1OCTxJbiBJKI9Uu7?=
 =?us-ascii?Q?tzk/4wC3qFwzUrJq8bDVSgszevMhVzU3cESDNRyQsU7u6D9d9eFX4aTpAQ7e?=
 =?us-ascii?Q?IhxWjQ65iCdyjCBqF0yEcYHk+mWWDBIN6uOo2MR/ZbrLwO49cE7+FgDaKoCT?=
 =?us-ascii?Q?qJJPzbs9vsy7ahYS/uHGFVE0cQpxj1yNSRx6AFgMEmdtIN5ULyDNMzfy9T33?=
 =?us-ascii?Q?707Yx6DWiNEDIqwQqiKBXIgQh8G70gNCuVPBmvOeFt8pI7cOcarHyD3jdApO?=
 =?us-ascii?Q?M0zq3F4fh4CELQoUrghOSDkDvSPpO/QC/dNWbNrvBwuKbGpLKfrYoYcU8SWI?=
 =?us-ascii?Q?p5ulxGVBM/XKbFjVZcES6vgqA/buji6IkMjplh2FspBU9r087XpLAoV9sWSL?=
 =?us-ascii?Q?3KWxAXBOnhqxpgHUICKwOKoHUhsOD7paZyVoYJmKfi3E3cnLzwZ47KqA4QRr?=
 =?us-ascii?Q?3AKh8Yp0RONspqjG7JEqMacToN4fTwbJ6y91BAiTBs7SNbrKUe/J/eMT5ewj?=
 =?us-ascii?Q?PSgdSrF/A3zxhmT2kSRgjdYMm5Tok7wBPLUk6gYl1D1kVU4DURGYsbKEGdUQ?=
 =?us-ascii?Q?Tndeeptap5YGN6akKsTw7ITSo09s+YmuMnhumSwhVtpFvS/JQ+oUv9yQHmu5?=
 =?us-ascii?Q?TCVUJyxIUKgXLqrUliZjvYmAv3hDEISbPa4nFPp20m02HVO2NYA02YEZg9ap?=
 =?us-ascii?Q?+Q7Ge+fpCojzG6kll38xyqcPiVfF3xQrEC2xrmSGu8ocO1B/AhNMtGa5Vgnr?=
 =?us-ascii?Q?/dddTq2zWp+J2p0wSTevtt/Hoqua/Q0HQ7OAYezugDx0FSN10JCIj1EhgJWb?=
 =?us-ascii?Q?mADouOOlYuoOYAN5b592Jox2xRYwxntmaVsA9+EZGowhKyPdxjMNieY/02Ol?=
 =?us-ascii?Q?CWW95hyl2atBfNgaTSOnmEpTLcDd3rZHdQCM9GUG9Xapzw8R3zTVfyBndJOW?=
 =?us-ascii?Q?PcbQwJaue3dpgc9u9AnNX53IAGEomhsqynoerJ3vcLDjczR3IJhWg=3D=3D?=
X-Microsoft-Antispam-Message-Info: tbgsv5dO/MQoHlZPiZbK3Diueub+QnLgjmE2YNfvYk/iAxAX0IO9hyKRGhjwjJ9+R9w5jgSWXScbEQ005IvJTghpEpwjq4X3PiOW99LDEGW3m8meYKySRK536XhXUsYNNxjWhNSUi6gWWDOnfNNcwZkbqHdythSGeH+RDQBDEz4yTflrtCQMKm64MJke/LJp0FB4SHYzPj5632FBHgZUb5V7V4QCGV6VT6JtsNMv+CN/MxsqhLkj56sahx+xmZyoJ+fiv5Peto6+Q3t+uP1KddCBOksDLbdGEkAoh6BmWTZlP1qT/36cBwsxs6lJ9Mrwbbg33qh987Rnqj9bGqlR6x1IF2BL990yoH0J4IOm1f0=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;6:OFEF74uMjMBXfGDtnq6NoR2Hr5AuXn5sUyIbwNxbU3vkkbgSF2MeqyXR1bZ/g4+Mzia21/g9L7Ek+Zf/qFzJqmirqYRYZjeeI0kHDnuh7xplrE+kvCeKBjKIlBSeXBpCfcFJtzsqsKGkI2z0qCr+E1WbOn/xpIWlEpr/elnNnWXhI8anqrkanWLV748KQXA5PkedlOnSH+9KzTEVN44xn0denLKCOK/OhWHWx+Ig3Qlm2MGHr57eM+2f92pafhycP0jmhnv5RWo53xG5S9YxcpupsDjOMu6KFTI8YQ6LWo5azPGOTymknhXtj5MxO1WlB6gTXS1ilGtgVZWiHamHsYKhQdcd3lylBj8ZTQi9/bltpZnIo7e9f96lwA7JH4ZsEa5ESTrC2vUgCpCJt5oF1cATNNxXh519ydKDWwJQe7hO8BvVzRrFqGv5AzoZyaBAKiORMOPwlVGvT4K3QgVbnQ==;5:TlwHDwMhgtPVa+bZkDkF85cfJ8DBresZWXlBLjUfBnqyKiW0S/VmoiU7aNN4tzNTzp9Sl3nDgjdtGD9dDmlcm0Yts+IliRTOfuXnFscTX9IkA0jEEiIX5kwhayMUhGPsqegwoBHK+G5O21xX+THskpWQkP77/geqp3iRCof7xcs=;7:LILtCCfuNerwmP63p17hvaBhuBDxwgYumb5gCJWap5hw5jrCT+zEnVrAFohQpSPAxbRH+O7aRdGIEbJqQV2voLD/+Lo9v1yF1AA+AiYsU6BBo0eqiSMkofIgzvZurw+FT+n6NkUlzy9IK2qnfzA5orcIr7x++KxuPD4qX0VZBFXHmxCntIlE2NtyRFwb0Buq0wC7SLcJp+egjzCAbENTsKyyCLBfJh1JgiOu4LbvlhCDukRKgq8TQ5rhc/ao0KVa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 12:05:45.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a32a989-8dfd-4e13-21e0-08d5fb94f08d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Devices ADXL372 SPI-Bus
Three-Axis Digital Accelerometer.

The device is probed and configured the with some initial default
values. With this basic driver, it is possible to read raw acceleration
data.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                 |   6 +
 drivers/iio/accel/Kconfig   |  11 +
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/adxl372.c | 525 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 543 insertions(+)
 create mode 100644 drivers/iio/accel/adxl372.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60b1028..2ba47bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/input/misc/adxl34x.c
 
+ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/accel/adxl372.c
+
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 62ae7e5..1b496ef 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -60,6 +60,17 @@ config ADXL345_SPI
 	  will be called adxl345_spi and you will also get adxl345_core
 	  for the core module.
 
+config ADXL372
+	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to add support for the Analog Devices ADXL372 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl372.
+
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 636d4d1..5758ffc 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
+obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
new file mode 100644
index 0000000..db9ecd2
--- /dev/null
+++ b/drivers/iio/accel/adxl372.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL372 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* ADXL372 registers definition */
+#define ADXL372_DEVID			0x00
+#define ADXL372_DEVID_MST		0x01
+#define ADXL372_PARTID			0x02
+#define ADXL372_REVID			0x03
+#define ADXL372_STATUS_1		0x04
+#define ADXL372_STATUS_2		0x05
+#define ADXL372_FIFO_ENTRIES_2		0x06
+#define ADXL372_FIFO_ENTRIES_1		0x07
+#define ADXL372_X_DATA_H		0x08
+#define ADXL372_X_DATA_L		0x09
+#define ADXL372_Y_DATA_H		0x0A
+#define ADXL372_Y_DATA_L		0x0B
+#define ADXL372_Z_DATA_H		0x0C
+#define ADXL372_Z_DATA_L		0x0D
+#define ADXL372_X_MAXPEAK_H		0x15
+#define ADXL372_X_MAXPEAK_L		0x16
+#define ADXL372_Y_MAXPEAK_H		0x17
+#define ADXL372_Y_MAXPEAK_L		0x18
+#define ADXL372_Z_MAXPEAK_H		0x19
+#define ADXL372_Z_MAXPEAK_L		0x1A
+#define ADXL372_OFFSET_X		0x20
+#define ADXL372_OFFSET_Y		0x21
+#define ADXL372_OFFSET_Z		0x22
+#define ADXL372_X_THRESH_ACT_H		0x23
+#define ADXL372_X_THRESH_ACT_L		0x24
+#define ADXL372_Y_THRESH_ACT_H		0x25
+#define ADXL372_Y_THRESH_ACT_L		0x26
+#define ADXL372_Z_THRESH_ACT_H		0x27
+#define ADXL372_Z_THRESH_ACT_L		0x28
+#define ADXL372_TIME_ACT		0x29
+#define ADXL372_X_THRESH_INACT_H	0x2A
+#define ADXL372_X_THRESH_INACT_L	0x2B
+#define ADXL372_Y_THRESH_INACT_H	0x2C
+#define ADXL372_Y_THRESH_INACT_L	0x2D
+#define ADXL372_Z_THRESH_INACT_H	0x2E
+#define ADXL372_Z_THRESH_INACT_L	0x2F
+#define ADXL372_TIME_INACT_H		0x30
+#define ADXL372_TIME_INACT_L		0x31
+#define ADXL372_X_THRESH_ACT2_H		0x32
+#define ADXL372_X_THRESH_ACT2_L		0x33
+#define ADXL372_Y_THRESH_ACT2_H		0x34
+#define ADXL372_Y_THRESH_ACT2_L		0x35
+#define ADXL372_Z_THRESH_ACT2_H		0x36
+#define ADXL372_Z_THRESH_ACT2_L		0x37
+#define ADXL372_HPF			0x38
+#define ADXL372_FIFO_SAMPLES		0x39
+#define ADXL372_FIFO_CTL		0x3A
+#define ADXL372_INT1_MAP		0x3B
+#define ADXL372_INT2_MAP		0x3C
+#define ADXL372_TIMING			0x3D
+#define ADXL372_MEASURE			0x3E
+#define ADXL372_POWER_CTL		0x3F
+#define ADXL372_SELF_TEST		0x40
+#define ADXL372_RESET			0x41
+#define ADXL372_FIFO_DATA		0x42
+
+#define ADXL372_DEVID_VAL		0xAD
+#define ADXL372_PARTID_VAL		0xFA
+#define ADXL372_RESET_CODE		0x52
+
+/* ADXL372_POWER_CTL */
+#define ADXL372_POWER_CTL_MODE_MSK		GENMASK_ULL(1, 0)
+#define ADXL372_POWER_CTL_MODE(x)		(((x) & 0x3) << 0)
+
+/* ADXL372_MEASURE */
+#define ADXL372_MEASURE_LINKLOOP_MSK		GENMASK_ULL(5, 4)
+#define ADXL372_MEASURE_LINKLOOP_MODE(x)	(((x) & 0x3) << 4)
+#define ADXL372_MEASURE_BANDWIDTH_MSK		GENMASK_ULL(2, 0)
+#define ADXL372_MEASURE_BANDWIDTH_MODE(x)	(((x) & 0x7) << 0)
+
+/* ADXL372_TIMING */
+#define ADXL372_TIMING_ODR_MSK			GENMASK_ULL(7, 5)
+#define ADXL372_TIMING_ODR_MODE(x)		(((x) & 0x7) << 5)
+
+/* ADXL372_FIFO_CTL */
+#define ADXL372_FIFO_CTL_FORMAT_MSK		GENMASK(5, 3)
+#define ADXL372_FIFO_CTL_FORMAT_MODE(x)		(((x) & 0x7) << 3)
+#define ADXL372_FIFO_CTL_MODE_MSK		GENMASK(2, 1)
+#define ADXL372_FIFO_CTL_MODE_MODE(x)		(((x) & 0x3) << 1)
+#define ADXL372_FIFO_CTL_SAMPLES_MSK		BIT(1)
+#define ADXL372_FIFO_CTL_SAMPLES_MODE(x)	(((x) > 0xFF) ? 1 : 0)
+
+/* ADXL372_STATUS_1 */
+#define ADXL372_STATUS_1_DATA_RDY(x)		(((x) >> 0) & 0x1)
+#define ADXL372_STATUS_1_FIFO_RDY(x)		(((x) >> 1) & 0x1)
+#define ADXL372_STATUS_1_FIFO_FULL(x)		(((x) >> 2) & 0x1)
+#define ADXL372_STATUS_1_FIFO_OVR(x)		(((x) >> 3) & 0x1)
+#define ADXL372_STATUS_1_USR_NVM_BUSY(x)	(((x) >> 5) & 0x1)
+#define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
+#define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
+
+/* ADXL372_INT1_MAP */
+#define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
+#define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
+#define ADXL372_INT1_MAP_FIFO_RDY_MSK		BIT(1)
+#define ADXL372_INT1_MAP_FIFO_RDY_MODE(x)	(((x) & 0x1) << 1)
+#define ADXL372_INT1_MAP_FIFO_FULL_MSK		BIT(2)
+#define ADXL372_INT1_MAP_FIFO_FULL_MODE(x)	(((x) & 0x1) << 2)
+#define ADXL372_INT1_MAP_FIFO_OVR_MSK		BIT(3)
+#define ADXL372_INT1_MAP_FIFO_OVR_MODE(x)	(((x) & 0x1) << 3)
+#define ADXL372_INT1_MAP_INACT_MSK		BIT(4)
+#define ADXL372_INT1_MAP_INACT_MODE(x)		(((x) & 0x1) << 4)
+#define ADXL372_INT1_MAP_ACT_MSK		BIT(5)
+#define ADXL372_INT1_MAP_ACT_MODE(x)		(((x) & 0x1) << 5)
+#define ADXL372_INT1_MAP_AWAKE_MSK		BIT(6)
+#define ADXL372_INT1_MAP_AWAKE_MODE(x)		(((x) & 0x1) << 6)
+#define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
+#define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
+
+/*
+ * At +/- 200g with 12-bit resolution, scale is computed as:
+ * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
+ */
+#define ADXL372_USCALE	958241
+
+enum adxl372_op_mode {
+	ADXL372_STANDBY,
+	ADXL372_WAKE_UP,
+	ADXL372_INSTANT_ON,
+	ADXL372_FULL_BW_MEASUREMENT,
+};
+
+enum adxl372_act_proc_mode {
+	ADXL372_DEFAULT,
+	ADXL372_LINKED,
+	ADXL372_LOOPED,
+};
+
+enum adxl372_th_activity {
+	ADXL372_ACTIVITY,
+	ADXL372_ACTIVITY2,
+	ADXL372_INACTIVITY,
+};
+
+enum adxl372_odr {
+	ADXL372_ODR_400HZ,
+	ADXL372_ODR_800HZ,
+	ADXL372_ODR_1600HZ,
+	ADXL372_ODR_3200HZ,
+	ADXL372_ODR_6400HZ,
+};
+
+enum adxl372_bandwidth {
+	ADXL372_BW_200HZ,
+	ADXL372_BW_400HZ,
+	ADXL372_BW_800HZ,
+	ADXL372_BW_1600HZ,
+	ADXL372_BW_3200HZ,
+};
+
+static const unsigned int adxl372_th_reg_high_addr[3] = {
+	[ADXL372_ACTIVITY] = ADXL372_X_THRESH_ACT_H,
+	[ADXL372_ACTIVITY2] = ADXL372_X_THRESH_ACT2_H,
+	[ADXL372_INACTIVITY] = ADXL372_X_THRESH_INACT_H,
+};
+
+#define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+}
+
+static const struct iio_chan_spec adxl372_channels[] = {
+	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
+	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
+	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
+};
+
+struct adxl372_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	enum adxl372_op_mode		op_mode;
+	enum adxl372_act_proc_mode	act_proc_mode;
+	enum adxl372_odr		odr;
+	enum adxl372_bandwidth		bw;
+	u32				act_time_ms;
+	u32				inact_time_ms;
+};
+
+static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
+{
+	__be16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, addr, &regval, sizeof(regval));
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(regval);
+}
+
+static int adxl372_set_op_mode(struct adxl372_state *st,
+			       enum adxl372_op_mode op_mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_POWER_CTL,
+				 ADXL372_POWER_CTL_MODE_MSK,
+				 ADXL372_POWER_CTL_MODE(op_mode));
+	if (ret < 0)
+		return ret;
+
+	st->op_mode = op_mode;
+
+	return ret;
+}
+
+static int adxl372_set_odr(struct adxl372_state *st,
+			   enum adxl372_odr odr)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_TIMING,
+				 ADXL372_TIMING_ODR_MSK,
+				 ADXL372_TIMING_ODR_MODE(odr));
+	if (ret < 0)
+		return ret;
+
+	st->odr = odr;
+
+	return ret;
+}
+
+static int adxl372_set_bandwidth(struct adxl372_state *st,
+				 enum adxl372_bandwidth bw)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_MEASURE,
+				 ADXL372_MEASURE_BANDWIDTH_MSK,
+				 ADXL372_MEASURE_BANDWIDTH_MODE(bw));
+	if (ret < 0)
+		return ret;
+
+	st->bw = bw;
+
+	return ret;
+}
+
+static int adxl372_set_act_proc_mode(struct adxl372_state *st,
+				     enum adxl372_act_proc_mode mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL372_MEASURE,
+				 ADXL372_MEASURE_LINKLOOP_MSK,
+				 ADXL372_MEASURE_LINKLOOP_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	st->act_proc_mode = mode;
+
+	return ret;
+}
+
+static int adxl372_set_activity_threshold(struct adxl372_state *st,
+					  enum adxl372_th_activity act,
+					  bool ref_en, bool enable,
+					  unsigned int threshold)
+{
+	unsigned char buf[6];
+	unsigned char th_reg_high_val, th_reg_low_val, th_reg_high_addr;
+
+	/* scale factor is 100 mg/code */
+	th_reg_high_val = (threshold / 100) >> 3;
+	th_reg_low_val = ((threshold / 100) << 5) | (ref_en << 1) | enable;
+	th_reg_high_addr = adxl372_th_reg_high_addr[act];
+
+	buf[0] = th_reg_high_val;
+	buf[1] = th_reg_low_val;
+	buf[2] = th_reg_high_val;
+	buf[3] = th_reg_low_val;
+	buf[4] = th_reg_high_val;
+	buf[5] = th_reg_low_val;
+
+	return regmap_bulk_write(st->regmap, th_reg_high_addr,
+				 buf, ARRAY_SIZE(buf));
+}
+
+static int adxl372_set_activity_time_ms(struct adxl372_state *st,
+					unsigned int act_time_ms)
+{
+	unsigned int reg_val, scale_factor;
+	int ret;
+
+	/*
+	 * 3.3 ms per code is the scale factor of the TIME_ACT register for
+	 * ODR = 6400 Hz. It is 6.6 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 3300;
+	else
+		scale_factor = 6600;
+
+	reg_val = DIV_ROUND_CLOSEST(act_time_ms * 1000, scale_factor);
+
+	/* TIME_ACT register is 8 bits wide */
+	if (reg_val > 0xFF)
+		reg_val = 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_ACT, reg_val);
+	if (ret < 0)
+		return ret;
+
+	st->act_time_ms = act_time_ms;
+
+	return ret;
+}
+
+static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
+					  unsigned int inact_time_ms)
+{
+	unsigned int reg_val_h, reg_val_l, res, scale_factor;
+	int ret;
+
+	/*
+	 * 13 ms per code is the scale factor of the TIME_INACT register for
+	 * ODR = 6400 Hz. It is 26 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 13;
+	else
+		scale_factor = 26;
+
+	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
+	reg_val_h = (res >> 8) & 0xFF;
+	reg_val_l = res & 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_L, reg_val_l);
+	if (ret < 0)
+		return ret;
+
+	st->inact_time_ms = inact_time_ms;
+
+	return ret;
+}
+
+static int adxl372_setup(struct adxl372_state *st)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL372_DEVID, &regval);
+	if (ret < 0)
+		return ret;
+
+	if (regval != ADXL372_DEVID_VAL) {
+		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for activity detection to 1g */
+	ret = adxl372_set_activity_threshold(st, ADXL372_ACTIVITY,
+					     true, true, 1000);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for inactivity detection to 100mg */
+	ret = adxl372_set_activity_threshold(st, ADXL372_INACTIVITY,
+					     true, true, 100);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity processing in Looped mode */
+	ret = adxl372_set_act_proc_mode(st, ADXL372_LOOPED);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_bandwidth(st, ADXL372_BW_3200HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity timer to 1ms */
+	ret = adxl372_set_activity_time_ms(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set inactivity timer to 10s */
+	ret = adxl372_set_inactivity_time_ms(st, 10000);
+	if (ret < 0)
+		return ret;
+
+	/* Set the mode of operation to full bandwidth measurement mode */
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static int adxl372_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = adxl372_read_axis(st, chan->address);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = ADXL372_USCALE;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adxl372_info = {
+	.read_raw = adxl372_read_raw,
+	.debugfs_reg_access = &adxl372_reg_access,
+};
+
+static const struct regmap_config adxl372_spi_regmap_config = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+};
+
+static int adxl372_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adxl372_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st->regmap = regmap;
+
+	indio_dev->channels = adxl372_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &adxl372_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adxl372_setup(st);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adxl372_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adxl372_id);
+
+static struct spi_driver adxl372_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = adxl372_probe,
+	.id_table = adxl372_id,
+};
+
+module_spi_driver(adxl372_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

