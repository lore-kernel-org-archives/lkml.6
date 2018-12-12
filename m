Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574D2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0540A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ObSrFuyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0540A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLLCsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:48:30 -0500
Received: from mail-eopbgr810088.outbound.protection.outlook.com ([40.107.81.88]:17952
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbeLLCs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMxnIn8KH7KVuKBpVETHOUOLbZINNYKFfY4rMkX7p44=;
 b=ObSrFuyPmDTowj6JuX1eSgoFMYjy7D6PiQtJPCOC4qqBwNzWBpZixDFbTdfSo2wsGQEZxj1i0slDKHuj2a0wAeKxI2JL2IpTc0XVCe1cs4JZo5D54CM6fpvDaNyW783gzJjKgAYykheIpn7GaV7vHHI7jOlCmbcA2TxQVj7eJq8=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Wed, 12 Dec 2018 02:48:22 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc%3]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 02:48:22 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Marcin Wojtas <mw@semihalf.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "stefanc@marvell.com" <stefanc@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Topic: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Index: AQHUkVET6MmkkP0I6kWJw6RDslXtBqV6Zi0A
Date:   Wed, 12 Dec 2018 02:48:22 +0000
Message-ID: <20181212104304.49026ed2@xhacker.debian>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
In-Reply-To: <1544533009-12425-1-git-send-email-mw@semihalf.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: KAWPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:402:b::19) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB4336;6:cu9t1Zh+At5bli/B7dmHCY/X50lCmdaT9KGZpzQ99tLeIdSqGqE8nmnmR8z+gGT2/V/iDyYssiBvKC0v2bwvSclx1cbSkPpmZe5Fo/W0r5kVl2JO5EUY7raE//Hporv74ONW9ZfLPHGg7GHgamvOWskr6KsS8nCo4D1YiTjypgC4ILT+7EJicTZqn4t8IZfLTd9hhlgpsE8My3hYtqw6mVTeyHsWzX7HeRmO4ERJCCl5tX4c3X2LiTOqUQFiWk5K83IZ06rcOGhhFiZ5gYGDZv/wIZzboPHvX6X+7ho2A070xikOshkDIaCPonbXJ5NBl6pvA4fqTYi8vd6YRu4JMyAir3ezSqHarGSxg8cZ5nNSqX9SfNfcnZZp2BkN2oMPKRPNgihwiVmUZINKMyFbOWGfpgLGeSTvCfQp7wHeMZG1A+9fb8+SsxIynlzJfsaHuWsuBNQ0Kee2h0MkUiRJnw==;5:8wXv45sahAwS78B5D3g6FDXwhNYer7zT2cpN2wG3TkesLu1xmkT2bLorRLRF0P/eAp2qxBI+ymdWIAHxyh+6EZyeJlecY4hc0y2AaD7k0vnBdbTIMJeImNI9+8bIvRie3F5T1k3wZDsGMBNf2rN8sFcAzMd9aVdii1fBKEmqXP4=;7:wXEV9lapt+Ed1SNgOviEIYHhfMdQM9gnv2KMbitRlPP8WDMWqVfpU0T8pZUFz8BRckwv6gmKSbs+q5tzQqNLkBeXC7MO9wh70wgGymGRLAlSbbGVQXkzOD391N0E5BAH41dSCbxal14ELhzG6HgeTQ==
x-ms-office365-filtering-correlation-id: fe6e460e-f0fe-47ec-e0ed-08d65fdc47b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB4336;
x-ms-traffictypediagnostic: SN6PR03MB4336:
x-microsoft-antispam-prvs: <SN6PR03MB4336F817D7B6A0DD995546FDEDA70@SN6PR03MB4336.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR03MB4336;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB4336;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(11346002)(446003)(476003)(71200400001)(71190400001)(86362001)(99286004)(66066001)(26005)(4326008)(33896004)(256004)(186003)(486006)(52116002)(6512007)(76176011)(53936002)(68736007)(9686003)(8936002)(6246003)(81166006)(81156014)(8676002)(7416002)(5660300001)(7736002)(305945005)(97736004)(14454004)(6916009)(6116002)(2906002)(478600001)(3846002)(72206003)(1076002)(229853002)(106356001)(105586002)(6506007)(54906003)(386003)(102836004)(316002)(6486002)(6436002)(25786009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4336;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rcIPp4kqrmx0bDxDIFzvvZq40SpVwrsvUq/KSjUVgNkzwUCwvL5FFJ0dZtWtM8x5UDsdCilbReCsGeuT7zUipQa/y9UCsij/QU4aGJTwxuZYYGom8Xq2uYC0EPNCl7I7fyYIVilfbPqVakn9DYuYjo5ADjQEWQ4yosI4z61yi1IJIgFoO139OblD6pG93/aZkl+2LmbokjHh5lp+7JI92Q8LYsXLcviDMAGu9msViSXd8jJP6VkLlncOBce1JPsTCxefW06REcRvLWxCbyaAlactXHrOUMbhUDUuRY7bCV4cqVGgr/C+fE5uVjkWkVtH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B60FC7B2DAC884DB451D82CB1599FCA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6e460e-f0fe-47ec-e0ed-08d65fdc47b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 02:48:22.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Dec 2018 13:56:49 +0100 Marcin Wojtas wrote:

> Recent changes in the mvneta driver reworked allocation
> and handling of the ingress buffers to use entire pages.
> Apart from that in SW BM scenario the HW must be informed
> via PRXDQS about the biggest possible incoming buffer
> that can be propagated by RX descriptors.
>=20
> The BufferSize field was filled according to the MTU-dependent
> pkt_size value. Later change to PAGE_SIZE broke RX operation
> when usin 64K pages, as the field is simply too small.
>=20
> This patch conditionally limits the value passed to the BufferSize
> of the PRXDQS register, depending on the PAGE_SIZE used.
> On the occasion remove now unused frag_size field of the mvneta_port
> structure.
>=20
> Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation
> method for SWBM")

IMHO, we'd better revert 562e2f467e71 and 7e47fd84b56bb

The issue commit 562e2f467e71 wants to solve is due to commit 7e47fd84b56bb
It looks a bit wired, to introduce regression then submit another commit(in
the same patch set) solve it

Per my test, after reverting 562e2f467e71 and 7e47fd84b56bb, I can't reprod=
uce
what's claimed in commit 562e2f467e71 -- "With system having a small memory
(around 256MB), the state "cannot allocate memory to refill with new buffer=
"
is reach pretty quickly."


>=20
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> index e5397c8..61b2349 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -408,7 +408,6 @@ struct mvneta_port {
>  	struct mvneta_pcpu_stats __percpu	*stats;
> =20
>  	int pkt_size;
> -	unsigned int frag_size;
>  	void __iomem *base;
>  	struct mvneta_rx_queue *rxqs;
>  	struct mvneta_tx_queue *txqs;
> @@ -2905,7 +2904,9 @@ static void mvneta_rxq_hw_init(struct mvneta_port *=
pp,
>  	if (!pp->bm_priv) {
>  		/* Set Offset */
>  		mvneta_rxq_offset_set(pp, rxq, 0);
> -		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
> +		mvneta_rxq_buf_size_set(pp, rxq, PAGE_SIZE < SZ_64K ?
> +					PAGE_SIZE :
> +					MVNETA_RX_BUF_SIZE(pp->pkt_size));
>  		mvneta_rxq_bm_disable(pp, rxq);
>  		mvneta_rxq_fill(pp, rxq, rxq->size);
>  	} else {
> @@ -3760,7 +3761,6 @@ static int mvneta_open(struct net_device *dev)
>  	int ret;
> =20
>  	pp->pkt_size =3D MVNETA_RX_PKT_SIZE(pp->dev->mtu);
> -	pp->frag_size =3D PAGE_SIZE;
> =20
>  	ret =3D mvneta_setup_rxqs(pp);
>  	if (ret)

