Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7712077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EqMmBiDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbfBOIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:39:24 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:17293
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfBOIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LaRQolBKpQXCQHQ6YbaAq1tvSl9HKcBbGI8kdLU+ds=;
 b=EqMmBiDfS/Dj/79g1KylkvCFLu7o1ANVX7UsFl2f7J17hKwJ1Gxnhoouqznp1JrHzSq2yr7YTPBSYDLar6cD8K3f2ReW3vYBwIUv+WpPbNxFxEPE5yaTpgv+RvxsDD2KILDtCz7Gkh3wIGXKfThREwaNzfARjwowhs6hrCtU9G8=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2931.eurprd04.prod.outlook.com (10.175.42.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 08:39:19 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123%6]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 08:39:19 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Topic: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Index: AQHUrWdx3CIJLXThzk+kTWUVQ+nAh6Wx3xQAgC7U+7A=
Date:   Fri, 15 Feb 2019 08:39:19 +0000
Message-ID: <AM5PR0402MB286587BA0B90A50FB0AC8A58F1600@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190116064820.20007-3-ran.wang_1@nxp.com>
 <201901162139.dkm3lJv5%fengguang.wu@intel.com>
In-Reply-To: <201901162139.dkm3lJv5%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [183.240.196.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 638a441d-2d0e-402b-7080-08d6932113a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2931;
x-ms-traffictypediagnostic: AM5PR0402MB2931:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM5PR0402MB2931;23:BmUjUUEFSQ+PyNPaTkSsPrRdJNypJruntc8LaM2?=
 =?us-ascii?Q?xV+cCwzHa6iPxRYzMJQhpkxPCXBjS2ew7BwSFdk8DklCN5phvRWhLQI+GX5g?=
 =?us-ascii?Q?TWlqCsq46wQjW76KxpjpAdfbFY6YuMnJLvE9PNZUScY/OUuAlB1QpGPEO5ab?=
 =?us-ascii?Q?4GvTcKo8IoUL+8taB1dQWMqsG6oPhmf+KjGQolOmXW5+LjuuX7A/58bFDKqE?=
 =?us-ascii?Q?JVyszhlL3xRtERK6vYrQTGxeFSmQYqXA7GZ/r1+jLyFSex92kdo2qZdLum8I?=
 =?us-ascii?Q?qswjpB2F8M22eqiiS3iqboJ6Dw0YTalM0wFsNGDC+w7s9Ijib35nzhpJ5qTe?=
 =?us-ascii?Q?72deF0l27mKVK2XM3JbC2YnKBTjcV3YLgA9xUSNfEuMxvXrIc0LUkDrEia8o?=
 =?us-ascii?Q?9mqJG4mP/JhEvTMOR7j4nDs1+1KcQmGDOF8pno2SnFAa5cetCnnsg804lKv/?=
 =?us-ascii?Q?FNkxVbKPyrdkS2wp6SKsSW6+EXnJEvzzbyeXxKhVVQGnOy+keMir6N9MlDk0?=
 =?us-ascii?Q?fIegXYeDf/3q2fDlyjXDv+ZB9NAzJHTC7sQJWbN72W2iBHAAgf+oKhRjdV4F?=
 =?us-ascii?Q?bXJTqzTAZlFwLRJDtzrqxk8FudWLGJ2MOBBewbJPhFfyUl/8fE3veEiIxgJm?=
 =?us-ascii?Q?auXlabkUgIcnCAhJFVHDtc2fnq8CjsnVQyou38sIcLoeq9LEyObs8DYGd68f?=
 =?us-ascii?Q?OiOMEswsWXR7mT55BKHF2xaJieQkcc6oJJDCXg/AFRDF5fBThEJwLHI3yyO6?=
 =?us-ascii?Q?CbmZ5fweIypk9+T3tM4UjFK3J7VKfWChyj2qyAHhalxpS9f5OPHwlQmBGzHc?=
 =?us-ascii?Q?nd4aToUi9smXcbTXEexnwgjVXlRar7n6JQbMZe/4gI9/9pLXQ078/rIQelFD?=
 =?us-ascii?Q?52SJcwNH2mvFA6lcSOvToYKZ5yd84brCrOgKf9vJyuUGPv+cLYQgI3ke1fog?=
 =?us-ascii?Q?gIy5Zhg29r9RWUkWsGxC9AWK3olo+FA22lHWipmXvLRA5uF+9iLMgFqeFfP/?=
 =?us-ascii?Q?gJcSe0HK9ghffY2EHYwOh2INff4bpg+PG2dWkhFYd5K8ZbdPmc43JQKnjcDe?=
 =?us-ascii?Q?f5EBSIBU7O0iUL6X/g09Xnf7p+8rESMf8Hdt1M7MbVHua/C3Hnfy/l/hFr+6?=
 =?us-ascii?Q?/46PFyX7J/CIJFbL4nP3QfMmi0WRMqozrxMM8P38OlLv/s4a6hK0KMA=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <AM5PR0402MB29314EBCE885D0ACED92F8FBF1600@AM5PR0402MB2931.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(8676002)(81166006)(9686003)(106356001)(81156014)(105586002)(446003)(476003)(11346002)(99286004)(4326008)(486006)(186003)(26005)(102836004)(71190400001)(76176011)(316002)(54906003)(14454004)(7736002)(86362001)(55016002)(305945005)(256004)(71200400001)(74316002)(25786009)(97736004)(7696005)(478600001)(33656002)(53936002)(229853002)(6116002)(3846002)(2906002)(6506007)(6916009)(6436002)(66066001)(68736007)(6246003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2931;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e01G6zsjb0yl9fNb6qeKKGP4qbvPDwv7ud6wJl+M7+7FzWCGvQ5O8IV3LGZUFkuAa6znt1tDXDmzuhLIZGKbm5bgYQko+7pM5dUrfJ81McWWx1fLvaCqHEPrQTiICAteowj7MLXW4Z1ZhubFPiJYNo9/WTHwmPf8SAWnPuxYdim6/mAP4bpyYUon0n+oUjKGqSkGU+UnzAQGwCPfr2UQ1ps157aKcmIJlPZ04r2Io3TzsLNeFShm9z5MnZ2rmD/7+tAeMbZWIrvEZveuVKPj1IlYqlnBJyA/t5neGDSx2e6wmz1yvPF2CPbbjOfgyHyRPnXY8uHJAsSZ7HmfDj+9cCed6sMKJ/MpbwoY/OX4UAuEh9FBXUJgVwIPUqXpXndBo/Kct8CzpgyETRad9sq48ttQRzn8TOD3lFNZp3q7mLg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638a441d-2d0e-402b-7080-08d6932113a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 08:39:19.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

    Sorry for the late response, I didn't receive your mail.

Felipe Balbi <balbi@kernel.org> wrotes:
>Hi,
>
>Ran Wang <ran.wang_1@nxp.com> writes:
>> +static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
>> +{
>> +	int i, port_num;
>> +	u32 reg, op_regs_base, offset;
>> +	void __iomem		*xhci_regs;
>> +
>> +	/* xhci regs is not mapped yet, do it temperary here */
>> +	if (dwc->xhci_resources[0].start) {
>> +		xhci_regs =3D ioremap(dwc->xhci_resources[0].start,
>> +				DWC3_XHCI_REGS_END);
>> +		if (IS_ERR(xhci_regs)) {
>> +			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
>> +			return;
>> +		}
>> +
>> +		op_regs_base =3D HC_LENGTH(readl(xhci_regs));
>> +		reg =3D readl(xhci_regs + XHCI_HCSPARAMS1);
>> +		port_num =3D HCS_MAX_PORTS(reg);
>> +
>> +		for (i =3D 1; i <=3D port_num; i++) {
>> +			offset =3D op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
>> +			reg =3D readl(xhci_regs + offset);
>> +			reg &=3D ~PORT_POWER;
>> +			writel(reg, xhci_regs + offset);
>> +		}
>> +
>> +		iounmap(xhci_regs);
>
>why can't this be done during xhci_gen_setup()?

Actually I have done experiment like what you suggested (in xhci-plat.c), b=
ut the timing
seems too late--making VBUS waveform look like a square wave as below:

              Here DWC3 enable host mode, VBUS on
              |
+5V          /---------\ 40ms  /---------------------------....
0V  ________/   90ms   \______/
                       |      |          =20
                       |      Here do xhci reset, VBUS back to +5V again
                       Here set all PORTSC[PP] to 0 in xhci_gen_setup()

So I am afraid the solution might have to be added in DWC3 core driver wher=
e just after host mode enabling code if want fix this :(

Regards,
Ran
