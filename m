Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3868DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75F221477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wNC+jJaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75F221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeHXS3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:29:00 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:18095
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727251AbeHXS3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igEA8gWtOGFAC9oG07Rnpa5t0P8HYKCsLYrc0RsfQl8=;
 b=wNC+jJaIVzQGWvX6mOMpwL0S39X7QTpDTaixULjqeq2f8/1n0e7UPSbezgHhwageA+F/9NIH3OVU5O6h/DUgDD5Ba6zF6weeJCwPo6vWLrlShiBp6umBBsRt7Jq8MuclEu2FrCboTtGwhyEgVFlvbrrphT0jGdN4OUZ+L07ty2M=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.245.17) by
 DB6PR0402MB2904.eurprd04.prod.outlook.com (10.172.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 14:53:56 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::6414:aa98:7db2:a4dd]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::6414:aa98:7db2:a4dd%12]) with mapi id 15.20.1080.015; Fri, 24 Aug
 2018 14:53:56 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soc: fsl: qbman: qman: avoid allocating from non
 existing gen_pool
Thread-Topic: [PATCH 2/2] soc: fsl: qbman: qman: avoid allocating from non
 existing gen_pool
Thread-Index: AQHUOylQodMfgkj4pkqAJ+hezXnndQ==
Date:   Fri, 24 Aug 2018 14:53:56 +0000
Message-ID: <DB6PR0402MB272745FC786675AB113E7C7986360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <20180823213600.23426-2-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-originating-ip: [192.88.158.246]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2904;6:5B3M6Xt6QwF0PG3PAqvJ3o47tkc0CtYf0EfSP0TXNaBGBeJllxlcrlvl1n+HIciF4L+LUgzncVg0mUNYqIOkCUFaYqc0JRWOTT9EfyxL9Q+qXgutgFeOqCaVBdA9YOyGtfQhZDwDgM5FLhhrd/PlpeGgilgIpHT/bbeBzaxx38WqOoaysTSd9RdyqRshCxjxxjUb++kI5i8aXvHc+YUoRwqXGYc0q8tWio7HQA8ot7LUx4zWSGQ4J7eU1tJgHgUuiMTnJUWyY7WShVrdh2I2dfKsgbb/xL57jNzfcInpfzKx8/IQjT2yiyE9kursTohYwbYda3jnIARZPWRIbQV5EGJlHtBR0NYpmLgXTeNdp9vCVxRvDm5ysWJtcsRh2esafgrLV4irahxUSoxCSxcuIrcvYQtdx/BF/HUUrXZefQNkAXzAqz9j3b8vv6Byfm8TYWtU1al6GYZKOmmI+4tPlg==;5:W8MWUZwjt4rH604KsCy+k847BeyXSQoi40An55gmq8qReyF4MJkOSM69BMIofzQwjI4KyulWurnAAtEYctorig894fAL4gzcL3Zk0uMUF9+9nLFHkwY1tXEPL5eFVFCRcAQi0afpSq00Ew2/MiUd106vPVHq20hQSVQJ6S/Aufk=;7:aDYcqePBCXXceCYpvXtX6oHrrf1Ns1T9RrBtIqMy4NWjYiyvdmdw3+zUx/Dz246wdd64hJGt1BI042C+Jh4+cUaEWFMpqFTCwvNlhhZnmzQ2eogGTJkUAnzv1ChsHY0ZfMk5gR0AgleFxzyWGbwJj6C86q7h3whRzldeTtHP1xDCXEdMVPsh9pv9N/c9/MwwpaiKNbotF9TvcyyPGZHDJ7IkGWTmVTpwsWPiMwIh+guK3StkKKEbcun93ceVDqdD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 66c4db69-8b78-4dca-c9d6-08d609d16af2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2904;
x-ms-traffictypediagnostic: DB6PR0402MB2904:
x-microsoft-antispam-prvs: <DB6PR0402MB290411C9D5BCF983F630618986360@DB6PR0402MB2904.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB6PR0402MB2904;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2904;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(86362001)(5660300001)(66066001)(4326008)(6636002)(6246003)(478600001)(99286004)(105586002)(76176011)(106356001)(305945005)(14454004)(74316002)(8936002)(7736002)(25786009)(7696005)(2900100001)(97736004)(68736007)(2906002)(6116002)(53546011)(446003)(3846002)(476003)(316002)(6506007)(81166006)(81156014)(33656002)(8676002)(110136005)(53936002)(102836004)(575784001)(26005)(229853002)(44832011)(186003)(55016002)(9686003)(5250100002)(486006)(256004)(54906003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2904;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T50Lr/++urd2qmcn4q0anlpw9rpK8wtp/OsNYP0268Nvp4YxRLULj3iHomfAtMbHJI6vT5C6sGCn0n0mwGADblks1PcnR6icHQpmPMbNWdmgMOQf1xG5h5MCK4Y4lXXtbGkgSnf00vymicEpcWjzca82Jt2s5ksCGy4Tijyxk+YStNki4d11+9Umxlj4UPn82278Wkq+ycWSQoHNkvE2xFEMcTW8J7GVKd4h86kYa4+uoH8m+UNIJLIn6ikd1PEWy3CXgz9IKxA8bpQafMOZOgMc0eUcnln7g+BIGxWKaoNPj/cZGKulhAkYsMxpDda6bZ7iYwdeZdv1lRtsNAs3GPIVp4VbARMvYHUUGb4qT1U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c4db69-8b78-4dca-c9d6-08d609d16af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 14:53:56.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2904
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/2018 5:36 PM, Alexandre Belloni wrote:=0A=
> If the qman driver didn't probe, calling qman_alloc_fqid_range,=0A=
> qman_alloc_pool_range or qman_alloc_cgrid_range (as done in dpaa_eth) wil=
l=0A=
> pass a NULL pointer to gen_pool_alloc, leading to a NULL pointer=0A=
> dereference.=0A=
>=0A=
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>=0A=
> ---=0A=
>  drivers/soc/fsl/qbman/qman.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
>=0A=
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c=
=0A=
> index ecb22749df0b..8cc015183043 100644=0A=
> --- a/drivers/soc/fsl/qbman/qman.c=0A=
> +++ b/drivers/soc/fsl/qbman/qman.c=0A=
> @@ -2729,6 +2729,9 @@ static int qman_alloc_range(struct gen_pool *p, u32=
 *result, u32 cnt)=0A=
>  {=0A=
>  	unsigned long addr;=0A=
>  =0A=
> +	if (!p)=0A=
> +		return -ENODEV;=0A=
> +=0A=
>  	addr =3D gen_pool_alloc(p, cnt);=0A=
>  	if (!addr)=0A=
>  		return -ENOMEM;=0A=
=0A=
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>=0A=
=0A=
