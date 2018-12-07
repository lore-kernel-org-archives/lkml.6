Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87348C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E4420892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="R5dBGSl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E4420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLGL35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:29:57 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:46686 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:29:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; 
   d="scan'208";a="22004543"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Dec 2018 04:29:55 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 7 Dec 2018 04:29:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvWLNm60HLe2wJvVXvEX5F6PQReS+XKnK2TUzinvgtU=;
 b=R5dBGSl0OhcK9BOa5i3/LvAr6YpCJLxlX9/8BI9kBME/6Hx7edyIEcr8oqZ3X3iaCZ0EZrVUlblpzeHyj12hVQxkr4h60iF9P4txKT3hVl9+oo4xVAKrjlLB0dI5TRSVM9WnpdejtdBTz4BvO4Y3GY+9geXQGpa3FNiTiaTbPRI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1395.namprd11.prod.outlook.com (10.173.33.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Fri, 7 Dec 2018 11:29:52 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 11:29:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wsa@the-dreams.de>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>
Subject: [2nd RESEND PATCH 0/2] i2c: enable buses to save their clock
 frequency in adapter
Thread-Topic: [2nd RESEND PATCH 0/2] i2c: enable buses to save their clock
 frequency in adapter
Thread-Index: AQHUjiArTqcCvgJ/8UusH/AtOpqJBA==
Date:   Fri, 7 Dec 2018 11:29:52 +0000
Message-ID: <20181207112939.15791-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:803:14::20) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1395;6:3uiEgDtc8qBeko284u9yFdJg+bcJnwY2HoerVAxkf4d7JawWknF+2OYIQaCTaTajhwC9tHXhv9SncPUQ2YWhPMVNCcHJiVEHK1nvHp0SUDdgphSVLCtwn5921C/JK4F+fG0P1T1d1SwUqvsjhS8Emzx+cLWpSgM8HxTWBXnbHqFaCH+nL25UrY5CLzN2JfGbXam97N5asdz3HOpmd49nI8/l0DBgMATe96Ymf8HnfMBh2U7gPjNohtwjDTqpjPpOAtQz7o87a5K9G4uKIbeRg8O0ONQCvy3Yym0buhAGq/qH/tMS2YIf4xDHTRNopCd4m5vlkELL/eSs5JSxJHXPAmozR4P4K8zvgawUzsnG/+z7tTYnQ70UuDHfYXcsJgkG5YClmrvt2pyC6KGk2q57c8jozx/TE5NsIwrfj20H5oas8gSupclVAUxEaEVDLNhBJc3JlPaByyRheXEIPu+8rA==;5:ucVIMYvpT3yT+xhLc+8qvehUYh//Ess0PDHaurNxVqD1pOWT9JUqatP/MAQ6iPVC8m6eYuMSS/ApPuEJmWUQT4nRO3J5k3CSsOYVOrfJCIsmneh5E+ut9A7PP0vhdrfj0QQg3pgfgp/dtBSykXgfNkKLos/XtDC2bBz2X82AEDs=;7:nBC9v1hvpp6Zany4KEZn+nzJpY/GCzfg+dGvLORqRw724PXIVa89Z1LRymok/ukBOj8147sdtVN6UdiihI/g4kJ9UCZBcw8rTHClwQR3UsH7e5DyvIMWURfvqLhqtMotOIAjX6MxO2fqWAc4XZZrdw==
x-ms-office365-filtering-correlation-id: 725d26c3-78bd-4634-4830-08d65c374dc9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1395;
x-ms-traffictypediagnostic: BN6PR11MB1395:
x-microsoft-antispam-prvs: <BN6PR11MB1395325E9B2D359A55E9F6B7F0AA0@BN6PR11MB1395.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1395;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1395;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(7736002)(6116002)(68736007)(107886003)(186003)(26005)(36756003)(6506007)(71190400001)(305945005)(386003)(316002)(2501003)(53936002)(54906003)(71200400001)(97736004)(2616005)(6916009)(1076002)(99286004)(476003)(66066001)(217873002)(72206003)(52116002)(6486002)(2351001)(86362001)(81166006)(8936002)(105586002)(6512007)(486006)(5640700003)(5660300001)(6436002)(4326008)(3846002)(478600001)(102836004)(14444005)(14454004)(81156014)(8676002)(106356001)(256004)(2906002)(25786009)(1730700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1395;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: clhl0oGuJIokY0Lbe334ZDdF3f0jKujOu4zsboX+8Ahk1MZuf657wc6BHGNFq3+9zpbZa6vRw+8UNLR1W7zXDqbL0pDpt9QoUzrbb8pKvbxJFLm1N+im63+aYIVXDeDAry8zVV4CXEN4zVrUvN7sAzI1LWF22+S3hugxFkm1RGA9LO9O05sXclYqsaC9sjP1SSpHUBmOt8YrQ+8dViponlvrXHcz4lL/g9L70qVW3ZS+h/vG/d/5gCaVspT/FB5JwZUKpKLbwMjJUtV0Evs9R8LRIf10wLBAXgFYpM9NLsOpShHhY+JI32cw2VpBftX3HfnRu0mXQQV9aGT3GPV/9JU6Cfjr2OcCc7nVJh7TdIg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 725d26c3-78bd-4634-4830-08d65c374dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 11:29:52.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1395
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

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

since rfc:
- reword commit messages

Tudor.Ambarus@microchip.com (2):
  i2c: enable buses to save their clock frequency in adapter
  i2c: at91: Save the bus clock frequency in adapter

 drivers/i2c/busses/i2c-at91.c | 1 +
 include/linux/i2c.h           | 1 +
 2 files changed, 2 insertions(+)

--=20
2.9.4

