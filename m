Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1B120672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eRlr6M57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1B120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395196AbeKVXpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:45:20 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:54487
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732044AbeKVXpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZ0t1UZsX1ASOmJOjsCdMT76WJ+xKmrog1yPddhlp94=;
 b=eRlr6M573BPp47eCTHAkwkqroBrZ5X7nP3xKVHa7BnmJMAUKCnVnh8Lifpi9txogeX5thvAF5I/XcX6q/y5JmtfNKyCVI41aOVZxvZYYPbITM5vDRRY+s6pGANDyF1jzP/NjYGZCb+KGtVvBkIZekE5pVIv6oaVywSJpRkS/I24=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB4224.eurprd04.prod.outlook.com (52.134.31.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 13:06:01 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3cf6:b5ab:ac8a:fd94]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3cf6:b5ab:ac8a:fd94%4]) with mapi id 15.20.1361.015; Thu, 22 Nov 2018
 13:06:01 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     David Miller <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>
Subject: RE: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Topic: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Thread-Index: AQHUgP0VcQXM/br9+0etCnjg7gktoKVa8JgAgADTuGA=
Date:   Thu, 22 Nov 2018 13:06:01 +0000
Message-ID: <VI1PR04MB48803D4A3D8D331046CFC63196DB0@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1542737734-21756-1-git-send-email-claudiu.manoil@nxp.com>
        <1542737734-21756-2-git-send-email-claudiu.manoil@nxp.com>
 <20181121.162118.2250773796794960530.davem@davemloft.net>
In-Reply-To: <20181121.162118.2250773796794960530.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4224;6:vLlUq6jorrapK5cm1XE7AiJd/W+vzslXBwx0MHgogCDn9mrRm0FplpW+v/LwmBQSxDKovEEzt+TXvdQybE/XyX1BPqjIeoLdYyZAhWW3z6fYqXCijbFZzdEuvHi+N3hQl0giJXXRxUW4mtX30xFMRS4RiWDX5oa9Kll016iOoq11O+KbYocQ1BPAHLhSwxA25lUQF7VhbxEa65ox+0PcAINdYuosRkA8O3oSdpqC6kiIvpp9HdYBv0ZUXRcV6pIza7FvrAoEVXCKTew6ah/7QNrbBuWJGB5HFUSR9F0oq+6HvhR2ARdcnTBw5LTQgp93+7YZHJX8S2Q0hzk32iAwyYGN2a6efqMKWAPvLxg2S3aYwCu9l/tOaDL26oPnHSjr67RDmR1HipCwEEgGgmSyEBg447dcOuS5zooB+Dc8TNfakKDq+Gx2gUUqWWUxJ9khqIeoMnecV7zVrqz/zT6YkA==;5:cYmHbLCdHofocjDdguwg0Tz0FEFSTzpW5iB2kgb1+L7sY+adehpwGu0SbmLwj+mkipA42XeNfPCT7SyQC568Cs/ITJdvdBnT/wMIXE7TsEvEaHGur/eqHkAdqK9QbTy1XgcIS0UDlbwjSpTm9yuO7NBwZwU3XOmDxzjHJh7Dfd4=;7:tFYva/jSeDsrtYuPJKbeHQe0f8d33CqG9JJHiV86f7EM1fad0K1NgaTF+X13khFn2OpWwzJg2HvCoEvFZH8x7bKdDrQVIOFcJG8FEWAr/9Q5SRAwwvY+nl/+I5NHNo8vY6G3LioToQA/f02jMhUj6w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c5162122-0519-4cf0-78cc-08d6507b40c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4224;
x-ms-traffictypediagnostic: VI1PR04MB4224:
x-microsoft-antispam-prvs: <VI1PR04MB4224A15138A25069B02BDE1996DB0@VI1PR04MB4224.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4224;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4224;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(13464003)(102836004)(66066001)(6246003)(97736004)(229853002)(6436002)(99286004)(71200400001)(14454004)(86362001)(316002)(6116002)(3846002)(256004)(446003)(476003)(9686003)(4326008)(76176011)(8936002)(26005)(186003)(7736002)(8676002)(44832011)(53936002)(54906003)(305945005)(5660300001)(105586002)(2906002)(6916009)(71190400001)(55016002)(25786009)(68736007)(33656002)(106356001)(81156014)(6506007)(11346002)(81166006)(486006)(74316002)(478600001)(7696005)(2900100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4224;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mNiwHLIJvpRj+oiBYGWqbp/jCNyfXD+CzPNttwCt7D4YL+vjVajvnZTEnADaYZ4aBE83aTCQi8SJn2zRTtgYzbGwcvnRhtDtYTJIRXS5IMQvEPC/PFC+fxCkDzaUs/Jz9+qsHV0VQe18HJkYiJcp6Nkj3MzkrZmZxNcKf5gc6H89QZaxE9ygAVN07XcKXjv0+Zhh2aaRefenXjLXVCz36npwOqsbpmXN4ygRy/jVY/UN5qnt2ZAGcPtYtVUXK9UC86xoGFesLutkTSk3xfyVkqaYO/NFCTo9Ib0v1z1TP5CYhUHf7KR4RKU/7pjpjrJgBn0gfiP1gFcpTpUO5SdzHYz5Wg+SKran3daSFfkwKw8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5162122-0519-4cf0-78cc-08d6507b40c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 13:06:01.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: David Miller <davem@davemloft.net>
>Sent: Thursday, November 22, 2018 2:21 AM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Alexandru
>Marginean <alexandru.marginean@nxp.com>; Catalin Horghidan
><catalin.horghidan@nxp.com>
>Subject: Re: [PATCH net-next v2 1/4] enetc: Introduce basic PF and VF ENET=
C
>ethernet drivers
>
>From: Claudiu Manoil <claudiu.manoil@nxp.com>
>Date: Tue, 20 Nov 2018 20:15:31 +0200
>
>> diff --git a/drivers/net/ethernet/freescale/Makefile
>b/drivers/net/ethernet/freescale/Makefile
>> index 3b4ff08..20e5c2f9 100644
>> --- a/drivers/net/ethernet/freescale/Makefile
>> +++ b/drivers/net/ethernet/freescale/Makefile
>> @@ -23,3 +23,4 @@ obj-$(CONFIG_FSL_FMAN) +=3D fman/
>>  obj-$(CONFIG_FSL_DPAA_ETH) +=3D dpaa/
>>
>>  obj-$(CONFIG_FSL_DPAA2_ETH) +=3D dpaa2/
>> +obj-$(CONFIG_NET_VENDOR_FREESCALE) +=3D enetc/
>
>The driver enable Kconfig option should guard traversing into the
>driver subdirectory, not the vendor enable Kconfig knob.

The enetc/ dir contains 2 drivers, that share a lot of common code.
Would you agree if I change the vendor enable with the two configs
(one for each driver) as below?

-obj-$(CONFIG_NET_VENDOR_FREESCALE) +=3D enetc/
+obj-$(CONFIG_FSL_ENETC) +=3D enetc/
+obj-$(CONFIG_FSL_ENETC_VF) +=3D enetc/

Thanks,
Claudiu
