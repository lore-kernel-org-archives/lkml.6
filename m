Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D840C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E008522419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPkJ3CXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E008522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbeKMB5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:57:03 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:48576
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbeKMB5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEzUD7Yn8anvcAbFvMl8ypdLdAvbBfUrRJl2atMrinU=;
 b=gPkJ3CXJvFgRANQQiTn/TIRooEXjrttXW/IkC5FP/tFz8iPEQoQmZXAdiPhejYZbr3A4JAGwAOymWi2Oyb0mLQXapkq78VRjlp9utdYhTXDpT7WF0xLT13goDJz6KpnKlwgVact16Nl03R6it/jVjcWHrEQx+AuI0W+2DI+l0vQ=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.245.17) by
 DB6PR0402MB2774.eurprd04.prod.outlook.com (10.172.246.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 12 Nov 2018 16:03:09 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314%4]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 16:03:09 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [PATCH 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Topic: [PATCH 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Index: AQHUdOoyw508LA/2JU+iwo1j5rjn1Q==
Date:   Mon, 12 Nov 2018 16:03:08 +0000
Message-ID: <DB6PR0402MB2727CB4ED8267C5CED85B65786C10@DB6PR0402MB2727.eurprd04.prod.outlook.com>
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2774;6:4RzGPjLes/iC5pUJw7P6nIYiZiiIC566kHoMDZpxB7EtYn0Ey0paeWJjZrbQ1d3nxlHWlKeqB/eH0nb0rNraAUQOUBbtFYljuZGIX3pkpuUUetq6EluasrxilbKioTgdRW06ZnnJVuqKHjpVEeN+0bWL7rOY9i1owQugioB6L/05RsoKhbmxsfBhG86NlwM5TuzCsUSjJ81djE2uwdSzeX0MMFB5xHXOIA6jr1tygNBS/akXgrc0ySBQmu6Lubv5RxIN0ThRVa6Pb36pP9B7pj4fo4LUEw0/RjftFuC6m7Wy4Wkys+qO3GfhE6O/AIlfRqCENa7r1hPvqy/m0VDLfPX0JG9fVcuxHy/hbL5BwfSitqtM5DG0eB29riP02U/1Z88oIdMGLfEn/DCydfGOaXu7Z6HJVLzGlpS0k0qYE2Tk2M+MOm/Zu32GFohivuPtXq+uykiz/xjZTTcKoIbbXA==;5:aUcU2ibjCCM3XNVoxaF5uwXC3G7+z7gTSfaoskidz1FLf7APZC7gvTq8Z9VBW5iADr5cboraEbF6CKPfw1W0xr23R1etTZ1RxRhFPYoTrugx8b2wdnYIYp5yqrnkjmfnLQN4J2JWhn5HQEUYqCIXVrXT9hada76cOPXhqtWbvlQ=;7:sXVARqet0Pnn/cwDbMQ20Gdqp88pmDH8aU0qgr9PR6Ja8PBp0yLwfFEnyLJMXmzybxTAZ0Lct0RzpuCgZAksv3ll/F3XICfc9I4PaZj/PxkgW7ethfSgaunyjw8HC6ByvrFo6C/0yO9KXSQdqUQaDg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 49f38943-5dfc-444d-22bf-08d648b8570a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2774;
x-ms-traffictypediagnostic: DB6PR0402MB2774:
x-microsoft-antispam-prvs: <DB6PR0402MB2774E370CC02140C2416B57D86C10@DB6PR0402MB2774.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231402)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0402MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2774;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(105586002)(106356001)(4326008)(2906002)(478600001)(33656002)(66066001)(74316002)(7736002)(305945005)(25786009)(2201001)(44832011)(86362001)(446003)(68736007)(476003)(186003)(229853002)(486006)(14454004)(2501003)(53936002)(6436002)(5660300001)(6246003)(55016002)(9686003)(8936002)(26005)(71190400001)(71200400001)(81156014)(8676002)(54906003)(81166006)(97736004)(6506007)(53546011)(76176011)(6116002)(256004)(7696005)(3846002)(110136005)(2900100001)(102836004)(99286004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2774;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fgn/zAL4SS3g8VKEKcw/19pTV7N4bxAbd7jOr8SaFMymu1NFLx3qQRkEgej6LV6fW2+v02JSEr66lp0j3/Wc13M9ZEwHXLR1MVy/s24OYBO/Z6mNqi6I2i7bFBuXD0HnSUU61ARiPF0q0ZcaU12wwDiUkKGdFlcI3+GoF2qDh8E1TSpQQ7bOMNmjQKleqPWGkQc1q1nkSpPwfE8LN7imxrHnMzbQuNZoAMduvfFEp39EmPEARpolqUY8AM2rFWiV4UxvHSgnjE9fWiA9SqgkUl+ZwmYhwWZILDseE08mo1RTjFzr1THoLg4w0XpPXM2N38BPydGX2u4Kplbl+VbMKDNdYrcECI3htrorKopqKyY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f38943-5dfc-444d-22bf-08d648b8570a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 16:03:08.9877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 4:30 AM, Ioana Ciornei wrote:=0A=
> This patch series cleans up the remove path in the dpio driver so that=0A=
> successive bind/unbind commands behave properly.=0A=
>=0A=
> Ioana Ciornei (2):=0A=
>   soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down=0A=
>   soc: fsl: dpio: use a cpumask to identify which cpus are unused=0A=
>=0A=
>  drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------=0A=
>  drivers/soc/fsl/dpio/dpio-service.c | 11 +++++++++++=0A=
>  include/soc/fsl/dpaa2-io.h          |  2 ++=0A=
>  3 files changed, 29 insertions(+), 9 deletions(-)=0A=
>=0A=
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>=0A=
=0A=
=0A=
