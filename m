Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA39E21477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bCWpFvbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA39E21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeHXS1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:27:06 -0400
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:36717
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbeHXS1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQyiCWnAzwneRg7Aez1afvSnhPHv8pFI6cs/tEUlBc4=;
 b=bCWpFvbRGDQBGoDfSDrFE++pcGqidUP/TyHcRVuo5gKhsTORsszHXf53qWZBMNrVWPFTUy6UkhKvCiNV6vGSX0zhUe0P22Knwx63YuaxjhCDM96VJy0bawSjmzwTB77cPrgKeKUlVuTkB7ENerYxIQsyzXTwvhEFgkYfGa4a85k=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.245.17) by
 DB6PR0402MB2711.eurprd04.prod.outlook.com (10.172.245.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 14:52:02 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::6414:aa98:7db2:a4dd]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::6414:aa98:7db2:a4dd%12]) with mapi id 15.20.1080.015; Fri, 24 Aug
 2018 14:52:02 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
Thread-Topic: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when
 qman is not available
Thread-Index: AQHUOylQ2NNkF5RWl0WF1A0TtXJBEw==
Date:   Fri, 24 Aug 2018 14:52:02 +0000
Message-ID: <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-originating-ip: [192.88.158.246]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2711;6:8fWK7Jq5ly3g5jtCVlChuuPVbS/S675wTNQ7AQgi1yJDLDJv6L1BMo4qF7435K4QwpAz3m5akk/Oe13WFTG+LSzMN0ZhOAx6w/p587XgO19r1y3aU7IfwDeO1GBW3IE86JCAHqUCyJAJhDIVXbxwGW+98G1CdwNDMjE4wsdqrF7792hUmqJRk3TGFxZd2fmB02f4liD0ZRJ/ALEwWQB8v1bUBW7jf4OlhGn8YcV4vs1diboqqRqEMhcteM9XC2z0WblPBxokVXWcfd08UOvDQTF9lv5Lf9E1FX6rTYSdr5+WqZQ8H7FtZhZTGXLi3yw/5LA41F0ydcNyk8nXSqXp5poMwTD5UipVTi5QH+OFijtBSa1HuxDiSqczIX8rGkeeEhL7ozeVIL58xrCFXF8ykuPaPXlL4HMQzRDwiv2TesbcDOCXYEdm7ujT/MrUUbCjGW+0ArFPwaS71mqpdzVN1A==;5:ESrkpydySK82MSbbgvENwloC2LePZ0/NXC9h9qgOiDZGN7AERZSX8FbG2tDtJCCaUa/TA9lEzQvMbEX0/Q5PR9GiQsNCzTh9a30IFn366LjyV3LMkww+oEUX73mvFH4O4Xu8FsGprL4ZHZuAqNc9kS+vmAoX6qtquqMa2rAJ/os=;7:nOMKKk5w21JdIRtp1U/Ybsl7FRfWbDtL5nWrs2FN0Mx5YtA4z4I05iGZbqvVXYl6AOeIyWyxPAbpiGVTgfHy2YILviB1ZTb5yJfCyoY/8ZgmFGy4ImEqSd3n1NGprVqyIZRLFcCS9RUxmRqT1RTozKr+yN1f/B6iXZfHoL2I6GOK3EssXBknoDv8ElwcdR7zHAKWq7IO+JbncaOywBjrwmOqRp3GqiFOTWPOCex0r4OdidO55RY2n7kn2/rLjXBt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c9ec9d67-c7f3-4724-5370-08d609d1271a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2711;
x-ms-traffictypediagnostic: DB6PR0402MB2711:
x-microsoft-antispam-prvs: <DB6PR0402MB27117A8273B1AB5CA093435A86360@DB6PR0402MB2711.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DB6PR0402MB2711;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2711;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(53546011)(99286004)(26005)(186003)(76176011)(6436002)(97736004)(6636002)(33656002)(446003)(476003)(7696005)(486006)(5250100002)(256004)(14444005)(81166006)(81156014)(229853002)(478600001)(55016002)(53936002)(8676002)(14454004)(44832011)(9686003)(6506007)(2900100001)(8936002)(106356001)(68736007)(74316002)(2906002)(6246003)(7736002)(305945005)(6116002)(3846002)(316002)(110136005)(54906003)(86362001)(105586002)(102836004)(66066001)(5660300001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2711;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jBuXaubSXoE3t3f8zVhGBKcDXnQE8zuXTa4/umX0T0QqtitlCmL2FB10K0Tgsuwdy59h0QMdmWbfz8J4jjguyOJCV2RJxowL9KPHL8DKkWuYe6O1PIGeEF7B0Cwbz0LUzG9ozVFdFlWIz7XSjPkbSh+2zLL5hSV3xOrhssYWGuKdkR0o36F/JhTXU9pZPUiLWlM6Z6DrMon9S5y7kgmma/kpB3o/eJ/MFk2xHFY/s+TPWiaoKhUp2NHqHcP9katdidXpIktSPCldGePOd54cqK4k2bwGETyYVRO8CHA5xC8j7cU72bPa4ZPKADd0Wcr0w+QfrskvQWRc4hU/sQpMz7bIWBieFKzUYjai/JiSiUk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ec9d67-c7f3-4724-5370-08d609d1271a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 14:52:02.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/2018 5:36 PM, Alexandre Belloni wrote:=0A=
> If the qman driver (qman_ccsr) doesn't probe or fail to probe before=0A=
> qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an=
=0A=
> unmapped page.=0A=
>=0A=
> This leads to a crash when probing  qman_portal as the init_pcfg function=
=0A=
> calls qman_liodn_fixup that tries to read qman registers.=0A=
>=0A=
> Assume that qman didn't probe when the pool mask is 0.=0A=
>=0A=
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>=0A=
> ---=0A=
>  drivers/soc/fsl/qbman/qman_portal.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
>=0A=
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/=
qman_portal.c=0A=
> index a120002b630e..4fc80d2c8feb 100644=0A=
> --- a/drivers/soc/fsl/qbman/qman_portal.c=0A=
> +++ b/drivers/soc/fsl/qbman/qman_portal.c=0A=
> @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *=
pdev)=0A=
>  	}=0A=
>  =0A=
>  	pcfg->pools =3D qm_get_pools_sdqcr();=0A=
> +	if (pcfg->pools =3D=3D 0)=0A=
> +		return -EPROBE_DEFER;=0A=
>  =0A=
>  	spin_lock(&qman_lock);=0A=
>  	cpu =3D cpumask_next_zero(-1, &portal_cpus);=0A=
=0A=
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>=0A=
=0A=
=0A=
