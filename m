Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEEFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85231214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ai+RibVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85231214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeIQOpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:45:15 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:63872
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbeIQOpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jyq5lNqpw2cEfYvPyaXC/No8rCsJXVgVa4VLdJjDcs=;
 b=ai+RibVgPdDWLosi+xOVlqMOXFwJi92WszTYInxkMDxY0SRGadDcX+iWqQtUJYLspazXrhjuRH6M53MN82L6MKitvIbEkfFqgVdnwSf+NFfebGUPFqs7FF9Tv2DJggIDIO+rrYvMcdTlgdqkJ4gdNvZ9woR33L5yPWrmeS5ZGmI=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3632.eurprd04.prod.outlook.com (52.134.7.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 09:18:37 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::74ac:8e9b:2ad0:dcc3]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::74ac:8e9b:2ad0:dcc3%5]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 09:18:37 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Richard Biener <rguenther@suse.de>,
        Jakub Jelinek <jakub@gcc.gnu.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] [v2] crypto: aes-generic - fix aes-generic regression
 on powerpc
Thread-Topic: [PATCH v2] [v2] crypto: aes-generic - fix aes-generic regression
 on powerpc
Thread-Index: AQHUTmdpoVJc8Modo0G1sSmtpH+Rew==
Date:   Mon, 17 Sep 2018 09:18:37 +0000
Message-ID: <VI1PR0402MB34855F454AA1D324ABEC0090981E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180115160735.593519-1-arnd@arndb.de>
 <20180120004425.GA6484@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3632;6:e6JeaXfNnZmcqYTL27ZcSXiiSx4tP4SsvihMDyz074S7+F+F2YZerTls+wkPmXYTavmdNxHFfoKJOpWchKJbSjy3UYAlvjOUm/XEBjfFxRc57om8gEooLankbxkEoua8GXwSK8EUebN1SH0QXTQQ5KJ/akWubGQKRm4KgMZIpOf/9CNeve+/AacRGmldlTqdxBLo5u9+5Zfh/mME1Hps+/Pjvrh0t0QewQAAHoDPbLoYYnu/IziSPwevSnnn/fUYt8X1pT34I0/O6m3SZ3rR3juVFGg/BCDzBicuk0iZfesZnFMLhaGMIbnJIy4FhLbVA5s0FNJRgDz6dn+1XL02CY7Uz83eZqj+76ilBpOXNXvmRu0hJID4KRMZaIQHI3fI/Z0auPKsPnwi/k1vcbPthjtq6u/nU7FqpZjRs+0kI7FqOOLrd3ap8ytvXTycbkNEGMAA7BrgqpdkvIN068ugTA==;5:zdPD4dRR4NYbM7uS0cSLzuqHUt3MZRjiR9KIuIqVJ613Bt5+GXNezV5tjZGls4kJyj1RyGt5ZQ+vjBqBhyCF112+TGySq3HV9Xv8p4WG3wKzuX3nrV5b8tPzYfAnB+E4Sw3QrnoSTqMdezXLhCsil6XMwNZo7REDTQC6vW4ZWNk=;7:Wzas5eIEvACcVL8yy1JXqE+G15gHtfMILTHVp/jQNH+ipc5QJ3qOXWYIHr9vGqGxhckeJmRLe17mmLT8OW6CXnXff74NZSj24tgHNIeK0A3r3KOQ1AM1N5LSG5dlPUYLdzg5ApGAGP+WfISvOFVLDt3StFDgEe7h2ZttNn8EiQoVkTHolJTtjd352mnB7APZDYT2dU9z+iBiy8sKgapls8dqwH85obV0cZ4ycCcXENpP7NFIaRqKtBGDyN9kDTxh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c5b6cd85-3880-476c-a92d-08d61c7e8cd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3632;
x-ms-traffictypediagnostic: VI1PR0402MB3632:
x-microsoft-antispam-prvs: <VI1PR0402MB3632A616024A51047C7C55DA981E0@VI1PR0402MB3632.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(22074186197030)(9452136761055)(183786458502308)(278021516957215)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:VI1PR0402MB3632;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3632;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(966005)(53936002)(74316002)(102836004)(9686003)(54906003)(478600001)(6306002)(55016002)(316002)(7736002)(446003)(486006)(476003)(26005)(6246003)(44832011)(186003)(76176011)(53546011)(6506007)(305945005)(229853002)(5660300001)(6436002)(110136005)(2900100001)(5250100002)(66066001)(14454004)(2906002)(68736007)(33656002)(97736004)(575784001)(86362001)(99286004)(4326008)(105586002)(8936002)(81166006)(25786009)(81156014)(8676002)(106356001)(3846002)(7696005)(7416002)(6116002)(256004)(14444005)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3632;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BvjqrM4wuJGzpsE1qkotlsf1ZhWkrAvfJnTT61LpX2ajV4WinpIeLlGJbsHf3tf3HXIlc5dK1wfU0J8xdwLfdshsYzLHNkFDwC7SZy/7PYXg5EmAGQBmpcG92yDpghFAvLXZUZu6M8dre2wkjnfKZwkplxRPyvLyN13p100r6CWm7nH72VMulA2pEeWf6rGDyiaaeYMvmh4URCLXSo+PXoI8b8HbIQzLdPgvJexFOtCU/JnFk55GoaP581UClgSQ8lOuGT8LxAWhA0cHVJ6Ltto5keI7j2wzfeRQC+pDtTA3T4Qkfe0npEOVcMOCfuQJhjYGO8TqtCKSyKwLoWFielKovoq3H0oHsLs/KErOGlo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b6cd85-3880-476c-a92d-08d61c7e8cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 09:18:37.2483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/2018 2:44 AM, Herbert Xu wrote:=0A=
> On Mon, Jan 15, 2018 at 05:07:22PM +0100, Arnd Bergmann wrote:=0A=
>> My last bugfix added -Os on the command line, which unfortunately caused=
=0A=
>> a build regression on powerpc in some configurations.=0A=
>>=0A=
>> I've done some more analysis of the original problem and found slightly=
=0A=
>> different workaround that avoids this regression and also results in=0A=
>> better performance on gcc-7.0: -fcode-hoisting is an optimization step=
=0A=
>> that got added in gcc-7 and that for all gcc-7 versions causes worse=0A=
>> performance.=0A=
>>=0A=
>> This disables -fcode-hoisting on all compilers that understand the optio=
n.=0A=
>> For gcc-7.1 and 7.2 I found the same performance as my previous patch=0A=
>> (using -Os), in gcc-7.0 it was even better. On gcc-8 I could see no=0A=
>> change in performance from this patch. In theory, code hoisting should=
=0A=
>> not be able make things better for the AES cipher, so leaving it=0A=
>> disabled for gcc-8 only serves to simplify the Makefile change.=0A=
>>=0A=
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>=0A=
>> Link: https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg30418=
.html=0A=
>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D83356=0A=
>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D83651=0A=
>> Fixes: 148b974deea9 ("crypto: aes-generic - build with -Os on gcc-7+")=
=0A=
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>=0A=
> =0A=
> Patch applied.  Thanks.=0A=
> =0A=
This fix ("commit 6e36719fbe90213fbba9f50093fa2d4d69b0e93c upstream") is ne=
eded=0A=
also in 4.14.y stable tree, since it contains commit=0A=
7cae67e31292 ("crypto: aes-generic - build with -Os on gcc-7+")=0A=
=0A=
Compilation fails without it:=0A=
crypto/aes_generic.o: In function `crypto_aes_set_key':=0A=
crypto/aes_generic.c:1300: undefined reference to `_restgpr_31_x'=0A=
=0A=
Thanks,=0A=
Horia=0A=
