Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B620C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D22089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xLdSBLU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJCOLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:11:30 -0400
Received: from mail-ve1eur01on0046.outbound.protection.outlook.com ([104.47.1.46]:43252
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbeJCOLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+u8+fwcHXLvAEgyfvOPsKsz6Nax7gktWhzZ5mWkwhA=;
 b=xLdSBLU6w8p0Wf/TzYxQOCzffFSNjqngZCViQ3o2pQdSRsXOj870lxLPI3g4XmCypBiGTaWSasKoYMkfNDUts2AGdyGqSMTyptAyQtqeE/7O4Xazt2Wx/ULdJsqK7PRfDcEBGsH9Okc7NWBIZdDPr6v65+5n54lC1vaEl+qIN3Q=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2909.eurprd04.prod.outlook.com (10.175.24.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Wed, 3 Oct 2018 07:24:18 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::78d5:848c:49af:fbc5]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::78d5:848c:49af:fbc5%3]) with mapi id 15.20.1185.024; Wed, 3 Oct 2018
 07:24:18 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi2 - avoid double export
Thread-Topic: [PATCH] crypto: caam/qi2 - avoid double export
Thread-Index: AQHUWpKLBxXS0OqKE0qLAzJ3+yzlnA==
Date:   Wed, 3 Oct 2018 07:24:18 +0000
Message-ID: <VI1PR0402MB3485CCAD46947DF023B2B3FE98E90@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20181002205720.2255567-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2909;6:CG8gAy7F+Y5nMzGhgOjpD94EWD/0wbkgfgwTGH1xfLAg9SFc9uAbMNYBycaq9oPrlGIR/cq+HO75+WM1uwcGOuBp+k9Uq08LmHUEGuJCW1rxjZM8aBaOVR+ppfnEiDWp9pUbbdgKqXDeVzYVceMr2YUjJQMN4gAFwp1+KXkbsgvlrvJfAH3MB/w0lX/8erG3UcUWtAYwTuBMNPz7nZvoZLrXEMWDv/9cfXYbgZESklRfVgj6IZF4/yx3sot4zSiQm0AzJBHu6Vh60oJnrCZ9uWDAPr3zUWPnHY6Wu+33ekE1o2/AQMKNJNOCfoUcMxWjg6ebdGVHEHcaKYF6QANnWGkvXbtvkM/nw1Cmoldwc7M01k38gWbjEv4J7WXGgzZKnEV+86qZz4k9f5M2wlRjZfohXEyrfuWIjC9QmGSyEjeGCZUkF1L/jkRz4vRDSNH2FQK5yByANw0Q4Fz3rvHxIg==;5:tFkp5wxx8ov/47ZQVpFDDF9Nze/OsAhFGwvvBDENQa0aFTYr3gYcoQCkvyzYo0mWsXLq6n4yMMsjMcx13kBnsY3opylAuU+5x8brrgj5RRrq/XbrxH1KeJsv+uKCezDyP0wt6CJMHO1xyBAJE5L0k+SYXhYKipYd6WV/VaeBaIM=;7:lo1nQJStkqOCFSEJZZXEoDsh5//Lf2TWGRnshOy7uZipe4fitfZSPUm90suE3Gs3Q2MjcpgpzEQjraUCfn1mt2q4Sx/PyCJ8b+KY3KEFIoF8hJdeiIShLvWIHG7R21wrW2pWvxHrPz+BrcMkZbL8dQ7tBbbKWcyckrI0V5LgjNdSb3kSNWj2Q4OH1Ocgjj2n3PHUlNmFTY1OV9L3W/N0S3iBPZcanFUf31WYZbxY2Q08rAS8dehwiKoytK6EAzdG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 38495c48-f079-46f9-add6-08d629013b4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2909;
x-ms-traffictypediagnostic: VI1PR0402MB2909:
x-microsoft-antispam-prvs: <VI1PR0402MB29097FB005277AF1D7BAB57B98E90@VI1PR0402MB2909.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR0402MB2909;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2909;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(5660300001)(25786009)(76176011)(44832011)(7696005)(9686003)(55016002)(486006)(476003)(446003)(6436002)(6506007)(305945005)(256004)(81156014)(186003)(81166006)(14444005)(53546011)(8936002)(54906003)(68736007)(86362001)(110136005)(99286004)(7736002)(26005)(74316002)(102836004)(4326008)(8676002)(71190400001)(71200400001)(316002)(14454004)(2906002)(6246003)(478600001)(6116002)(3846002)(229853002)(2900100001)(5250100002)(66066001)(97736004)(53936002)(33656002)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2909;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cP0O0o3aJ0x0tPSpEqT+TSbl9mTWIJPQ2eztoljWWkyPWkTDhZGZ0tEIoW+e7ZBE6d8tMJN5cVOAOByLx5MYsEyaUk3ewgphn27mLjY4IIjxXpG3fWBXKWUbnGRr5HGJ6jWVx7bYAJ83512Yon/Mjq/EOSJiSPII7zDOYZ6sKey2SvdlPm8xFMHBInAaWm2JNmCgw79IAMW0gxOwIF8Wuocd/MMUohSjvEivbnGisFdN6CMXnFE4/SwN+otZ95K7mYx/PfDB46AmGQavfdG2S32S1LZRS78bPJJZf2tWlNrbk+fJ16Pf1W+099RyqsVOwnyoCwycViM40co0FKpnh080h5DARCEZs4C8ddh8BWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38495c48-f079-46f9-add6-08d629013b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 07:24:18.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2018 11:57 PM, Arnd Bergmann wrote:=0A=
> Both the caam ctrl file and dpaa2_caam export a couple of flags. They=0A=
> use an #ifdef check to make sure that each flag is only built once,=0A=
> but this fails if they are both loadable modules:=0A=
> =0A=
> WARNING: drivers/crypto/caam/dpaa2_caam: 'caam_little_end' exported twice=
. Previous export was in drivers/crypto/caam/caam.ko=0A=
> WARNING: drivers/crypto/caam/dpaa2_caam: 'caam_imx' exported twice. Previ=
ous export was in drivers/crypto/caam/caam.ko=0A=
> =0A=
> Change the #ifdef to an IS_ENABLED() check in order to make it work in=0A=
> all configurations. It may be better to redesign this aspect of the=0A=
> two drivers in a cleaner way.=0A=
> =0A=
I think this fix is ok for the moment.=0A=
Indeed, work is on-going to change the design a bit.=0A=
=0A=
> Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")=0A=
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>=0A=
Acked-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=
