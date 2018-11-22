Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73016206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ihu6qH4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73016206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbeKVNIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:08:02 -0500
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:41664
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729785AbeKVNIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfiWertVcQncuXvdAogs5lUKOfokvfWK14OC/jCOVzw=;
 b=Ihu6qH4p2rbyrzZQ/gJ5/tILZicHSQMwKOUksuvV3YE5vl+Q7zR5x8+8W8pr4RqkU41PrF9tH6v6dkjn+piNvJvwrFwcKqIbKG73A/mloYU6AdGgszmPEt1jvwWQXjsXJTgWpXcaDh3u7TDhjQKr2LuvBZL1uNecsU2VLpYFtxE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5009.eurprd04.prod.outlook.com (20.177.40.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Thu, 22 Nov 2018 02:30:46 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 02:30:46 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Topic: [PATCH V4 1/1] can: flexcan: add self wakeup support
Thread-Index: AQHUgZY4VvHZKYhbxkiYG7EMB9VSQaVbEb1A
Date:   Thu, 22 Nov 2018 02:30:46 +0000
Message-ID: <AM0PR04MB4211B8283948F8DB63115DD580DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
 <20181121122957.2684-2-qiangqing.zhang@nxp.com>
In-Reply-To: <20181121122957.2684-2-qiangqing.zhang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5009;6:pFO24+NML7r7+J3v9pqS1T9U+o/Xc5IYur2/GbB8j6+9fjka+LcsaqUZw4o77EOZ6ZCe5RPaj3RujZXvK00kNtH5TUi3UZcBlfJ4bZ95leZN6TkaUaBH3lpB0Wprsz9yEuR2r9PsF9LH2CGov71QWKHLwKYkWcGnb2XZPNAKLlxeiEa+z9cxTvBPsayzw6fvFetjYY/o9V0MCg1xlMzrKrnmSWL0v7C2xlYcPHHEtsqs7yQYI9p+ppCt6BL7KCw4GTuIDU9t8ugN1YSPPhxuL8fcMIv0T4puUs/xkUbiHlYzZ6T8ijRELknzGYCH6pO5YdeSi38008x5Wrf+1HdMxgviY9nbFpOOE37/Ivm/jqN0ZAwzzSfYa5i5R7Ds1hq4YCeMyd6kN5qrGQ/m4HTn56hjdvTe9txzHHBe5+DFloor/4Fda0SuST9kuU+n1GK/bIyvgCVvb4BnrxFfXnqYiQ==;5:YG4rBcUASU7BwxtqvUPpiFxHHu29fLJF4Qnwi4L++/oDxbWpdc995YMY4xFyON0XIyioHd4o+Za+BK6zgdipVjdPv56tn8fBuqkJrxkKq1MD0hEXV9ftgSsezA+7MO5wuon9EhMEgWWRVNkYVCAj4WL2pwlyrjd8SavyfC7yIH8=;7:vzSIrJLhgnrl4vH7CX7HKwFvrJoql2npI2TVdgz4FVZ8ode/zGC3WZ6FPHjhjRj3KyglnIF3eY2rdF67lL7m72NtZRkD4OlC10o1qpevGPm9Eydwp8dV1qTKKVOCOVMyrl8qTM7fPLvnCHvDhyGjng==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c91836f4-a376-4a6d-f764-08d650228283
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5009;
x-ms-traffictypediagnostic: AM0PR04MB5009:
x-microsoft-antispam-prvs: <AM0PR04MB5009C6947753FF0F0B5D9C8F80DB0@AM0PR04MB5009.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5009;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5009;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(446003)(2501003)(11346002)(2900100001)(66066001)(68736007)(6436002)(3846002)(81156014)(478600001)(81166006)(25786009)(4326008)(486006)(97736004)(6116002)(2906002)(476003)(71190400001)(71200400001)(74316002)(14454004)(186003)(55016002)(305945005)(2201001)(86362001)(6246003)(8676002)(7736002)(105586002)(229853002)(26005)(14444005)(110136005)(316002)(102836004)(5660300001)(33656002)(106356001)(99286004)(256004)(53936002)(9686003)(6506007)(7696005)(8936002)(76176011)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5009;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R4q/WP67KU+IncV8GX0jm7k5uX/hBg6Ym0JwP5hxBBGvTpSAR6MN8lTUYRB2EMdgaHZnR7x0VTdJO+yBAkCyTDaIsaOsOkJDaws8nPU37vm2tEQBE8V56f/cZu/CObX62qsbgXuf8cRlAY8jRFHlY3fLCOc1Oqcu11yXlHgjypzEosgJvchZzdTojymwUNh+B66qNjJQvVpiVgxPmNCik2NL3YatAwnc/ddRLWGWRPo2ndfQmb/sdzfE+0q3JLSlRE+0dFa464I2ORqYFuPzixinxLaoMPABDT5tcZ1uX8ZKTB3Vq7KIV6z9FFhzP04E1QXZJp5umWrynhvrJvsIPSBouy+LVg7QKaJbqeWz3k0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91836f4-a376-4a6d-f764-08d650228283
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 02:30:46.7519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> +
> +static int __maybe_unused flexcan_noirq_suspend(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device))
> +		flexcan_enable_wakeup_irq(priv, true);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused flexcan_noirq_resume(struct device *device) {
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device)) {
> +		disable_irq_wake(dev->irq);

A bit more thinking:
Can we put flexcan_enable_wakeup_irq(priv, false) here and move disable_irq=
_wake
to resume function?
Then it looks better on pairs for those functions.

I'm not sure if irq will be lost or we may even not need wakeup irq.
Please help check it.

Regards
Dong Aisheng

> +		flexcan_exit_stop_mode(priv);
>  	}
> +
>  	return 0;
>  }
>=20
> -static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend,
> flexcan_resume);
> +static const struct dev_pm_ops flexcan_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend,
> +flexcan_noirq_resume) };
>=20
>  static struct platform_driver flexcan_driver =3D {
>  	.driver =3D {
> --
> 2.17.1

