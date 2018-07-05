Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD0EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633C4241AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="S8COongv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633C4241AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeGEGlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:41:23 -0400
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:14606
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751609AbeGEGlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NCkN6Kndc5YO8KE+n3CdvcFK1xnP4ewGjtmOxZuLdM=;
 b=S8COongvtSo2x1rSFj5lzjSm7x5NO+dDFJ78Zfd+Ep0uWFEbqV7TX+kVoYAwUPEcxFYZMD7QjT19HgqHdVBEA2n7rIGzfbvjF3Edqxi733F4UcNy2jIJ4S8kadbVO+bYxeU6IQi60G6fbA0VHZai7hHFVIR49pAAszgSVREK2I0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2634.namprd03.prod.outlook.com (2603:10b6:3:43::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 06:41:15 +0000
Date:   Thu, 5 Jul 2018 14:39:21 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180705143921.6a8aeb50@xhacker.debian>
In-Reply-To: <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
References: <20180704165908.4bb8b090@xhacker.debian>
        <20180704170310.56772d77@xhacker.debian>
        <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0162.jpnprd01.prod.outlook.com (2603:1096:402::14)
 To DM5PR03MB2634.namprd03.prod.outlook.com (2603:10b6:3:43::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5e2be76-1068-455f-8147-08d5e2424f89
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2634;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;3:ydvRAUOBsmombUDUEPRl0aBZ3tOdnE9ILAorP2qT25iVZGYhDmfzWu8l8rBsJHBnX3jLqfRQaGopomaT6ElKgV2bwfMJcc/8tiTQ8OSgpQb7PTCO6fPJOpPDDTsj05a8a27PzVaiBtMSY/0z9jPh/FmEDOQphP1QYpqv4xCI9xGDlrSXSgVunQUKmUcsbKUfx/eQ/Ly/EChgnfKD+0nbzx6+1F5/yHB7tZEYfp3SznEg6MzzMxemmCFNiaLfkVP8;25:QJJU249Kwu8gFkaVTI3CGuzdXUqfjyONoR5ckpZLqDbuPtegtnx1mIwdhUmo/FoQ0as3shfcQ2M8wm/AEPDoZspcwOjSDu9t7b6lem73bBZaZagpH5PFThJr2btFGtjkmGrJRcIeYgPPoNdziB24l8iRFL2fejToTp2TW89lFq39lI5xfgZYG4AKkMw0KOjauvqkGts+rqaVJebbtL0tRqk9hHjGwsSrxb6+yZCOEfAU9T66ss8URUCVIfjfcEHxudxs2D8t+gJ35DYdtk4pJdzSytasfe/rMdQSLb0dq7RFwYLmSxMlkhcoDLybwW/TSZz4d8K/K7xHTIX0LEo5uQ==;31:MQ1ZwtQex24jhVM+fRHgvi48yI2nNTkdLF+bvvMH7HzdgHSCY4wui+3vslcUGi6IaMHepQ/Tqp84UBMALIiICgkP90T+kvRN8Ao+a3b5F9No4hAaSwfOid3DjPDjv2eJGVwHbS0TyXMEfcUrrrgMJFQkc05760OJqvKLl1MReFeDHZUtZ1uDEKGnjQt2VhmuZ+HCDKbrDEN1lgd14XH7npqFgzJHS0K6UNeSAqOqyCk=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2634:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;20:23q5XONad8UZt+OCdXtm/Hsheix6hdGhAoJtB9uTnEUHxgrMMHraUUF9ln/MGmTChl2sV5zCe/3rCFGNCOEkuO7KFt6kfpD254uT/BCa+BBFHI/V3mo4E3jMuATBjZj/bvYgzAlyehuieqsW0topX3oKWezoWbJEkTKNf5qLj/kvWHX1sYuxs27l9fHeDgXGwxd1ympF/kioTphp9d23qCUkMmW8vJ9S8f3uEbLvuN0+qyi1ysPBHI3pN7CMViADFvwmYLunYNan8OkfYB6W6hiFIlifNvxNWteEI+qX2YUnQREhCPLy42q2INJLUeFAT7Tc5apPVWPEZ9PgoBMf5q28h+rmSRkhWAUqeq9ZgEhxldo5Fu2TP7L+zN8lDgoHQrYR79J4vER5ZhFZQ4NDhWW8lbfZ8G5jjKTrH9NsZEqtRvrYEGppmnF6XPfO9rNryQ/CpjzYY5HNqm9a0BFA7HUvWgDb1y4UhOHVQTmguA4kaOdu0ZVwgOnvZQMiCtm+;4:wHExP057seAlhQ7iOlieoX7h1uNM7DnRiCX2hGmg47IS2i0SFJwqbdysT3yDNM7WF7dDFGLpeAZTkkwK0dtSO0cpFlnfbkKqOP3TjdaYGEJef+olEs+jh27LioukzwbKV7/ogb/+/3TacIRWFIQKH8jM6PPrCDfvL3B1ZxGcRt3Xea72suKGNjQU9SMeJmP92MOdEJcbTFBheFCcoycpldziDk/TZR1PADk/9W0A5BgpVaYpJsbpG354mqvZasinwWQOIptKUFABIRzVf64+3A==
X-Microsoft-Antispam-PRVS: <DM5PR03MB26340A06C3457E7311A01B5CED400@DM5PR03MB2634.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2634;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2634;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(51914003)(189003)(199004)(478600001)(7736002)(305945005)(86362001)(8746002)(81156014)(81166006)(8936002)(8676002)(14444005)(316002)(106356001)(1076002)(105586002)(50466002)(6116002)(23726003)(3846002)(54906003)(97736004)(4326008)(25786009)(72206003)(9686003)(476003)(956004)(11346002)(486006)(76176011)(7696005)(52116002)(33896004)(16526019)(186003)(26005)(446003)(6506007)(386003)(47776003)(66066001)(55016002)(229853002)(68736007)(53936002)(50226002)(6246003)(2906002)(6916009)(6666003)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2634;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2634;23:yqjw7v6cVi1KSvYQdfymTnsTXyskhckMUpobjX5j5?=
 =?us-ascii?Q?VpZWXC60HtE02nUCFXwnjzVS4JOklmcUZq+BjhOH6wYJmygeDgorbOYbfNCB?=
 =?us-ascii?Q?Hj+seqHmQijp0oGhsDOmAjWQoCwbriyga7/dmW52ZOttoQACn2Z3A0k1HO9x?=
 =?us-ascii?Q?OTHRhiePTVTqArYym6NlRxl26XHPypgA7TvZXLENZewkIak6yrwnBY1S9POE?=
 =?us-ascii?Q?BJs3qBzha9MgpkCCSNCtFehLWNn0x3B8Cns0LUpQjp6xabsYlzpXc8TT1mRw?=
 =?us-ascii?Q?nUJWrJymkl3cxG5Lz+5Wm7ila/FggswwsO3uzMqvwAtcVlc2RRUorvwj9gJ0?=
 =?us-ascii?Q?qbqlOq3HiEeK/V3lLamH0pjfyD1pwPIL2Qz0P3gApl5qx6gSwfnfFcRp7WyZ?=
 =?us-ascii?Q?Nzc059C/fs0+DdYtaL0ZVwpmgnALo8TLdGzj3fMeqWJym+hbAVM6aUmV2ZMI?=
 =?us-ascii?Q?SWggSvsZHa8WEHzsHMBnf32GYJUFzY8DvAvufe13EQ6lKTRfUIE6uluHuplP?=
 =?us-ascii?Q?QEtQ6Hi1/J2FHP7IqKXJa/RCsVadNLd2bPrq7JOPZRuBUZ+E3apVmsWfc8KY?=
 =?us-ascii?Q?aGYEYf6hfVWPEjbjf2APwQyk+Br7JF+KvlHmLtCCEZAXiWliwPpcy2PnD5cV?=
 =?us-ascii?Q?pXPG8r87dvJ8Oxk4BuccUMKLLq+/fhJ2L4TPBb+lrq2EZX1QfhDmmXkJLDKL?=
 =?us-ascii?Q?l+hj7WwYKVc+SJVpJD6miVArwaKFwNReMppw945TtusMxQdIk+fjAbrZGPop?=
 =?us-ascii?Q?zmyqmLis9A9jsW8y08QIhV2LvcwkWU0RH/YIVUQ7ET2dwS6UKIanqN1gRFRR?=
 =?us-ascii?Q?C3dO1Ey20YcNDhaXWfvIU5oCmlWx2MzYyojXbz6NCwGXjAd09OzywzgxXidv?=
 =?us-ascii?Q?T389A4Ye56IEywsg4YPdLWb9EH/DOQ3OuUK8XnYu7jWvwEB3fB90MCks0j9I?=
 =?us-ascii?Q?P3WPggsxx9xyV1aqrQcKeWPyq61UTNEh0Blwrk/AkF3ViEZ1eTUYS0qCGZ00?=
 =?us-ascii?Q?hITNOCyEjbeAV6XsQrkJuzskZFhcmdxF/Sj6ukimrnDNAAabLwI83s9cGwlK?=
 =?us-ascii?Q?Azc/rHjJfTOV6voa7pfrlTsUcqq0E/LhSiO6+Svs+VcRA7B5epg2yfgQJbi+?=
 =?us-ascii?Q?3n/cFao+7wcQXEmGMc9miEVnB6p3eT2peFGW2GkDAWOy3ldGokJ4biPBqto3?=
 =?us-ascii?Q?VluywSySuz4xlsgvPKjPts2OOYlac8inMkvlgfZMZuIDSOVUv0HNdUvCf+U0?=
 =?us-ascii?Q?j/mfTK2z1wE5HEGKvVWID7ewV4XxN/hO4QwEUno4K/NN8LhyYUVf4VHoISqP?=
 =?us-ascii?Q?9o5mtP0R4xH5QTjJEo1gNg=3D?=
X-Microsoft-Antispam-Message-Info: EfRmf0fa1C7ZFQ2OZDsoknTMRV3hJRK+lAFS/zHqaVv2Nxx6fim/bGQ38BU7x3Rjp/eJdZ5pOD5gZjfwvzTPvHRwJ23Y1o70YGifAUvJAreOEvahU+b1bm9Xn1jYfNpsV4s+Poc0v+LZsWFkEGC7xaQJA992bCCLpzNnJmTgKRIjugDjfMSUUH/BcXY2it8dNeS/HWyQnpM8cN/cMgz0PgzaePaUXqpMqsL5zcw8waeHDR9cmW+NyjtjYGCOhBdhcyOYOm4U5bQrbKIGYd1Rki5nksv4WcLb5BhbmjJsKHEOtxqODEC6T3HMGR0zuaPfjxaY3sv/ZUC+y46zyKSky+TYD6jDmxna2bDoYDWCW/c=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;6:pRqe5OO60O5uNih4nE0TjHJQk2mquJmJcNIpA037jX/3qtInSXr8NgICOQwbe4K3yCc7Hgw8nPsWXNLMwFE+crrPdB4yiVDRL7vxf2q34HVLNeWS972pwT8wgP5DZ4PID/laS3sHmOSRTi4tCgqIaTMtVeS/wXv6mUZDTPjQkhqEfHDt6f4fQMvt7zIKoALWa70xfhCWIpPkfaQrD7+Dy0r9Cm/xruSonl2AmKC4Hvauy7dIS7OcAOW4xbVSJG+TALXdpVHjfgwQwItr+RwDV/8zSm0onXLurQzZ2YdfR8o8VsZhHlSXZOQqFk9U7oMHIUdn6xqZ7qRTC9t8msSBKN0Sv1NVOX79rLvmCwSBpOp3sDEx9MGZCFJpzvrVZ16bDfZ0y9s4i6byDWkhXaVDKm2F9kZXRwvFUhJq7N8n7GCHmlkYmT01vZmD8S3FtpLzAuyfh/qQ4PN15mz1W1KSjA==;5:xpxGb04V6EWXVxfsM5q8P1gRE1P4FJdR5GpUkJ9JZthmRBazB7rBf+3iQe47WHvX95ZfFB+ELVm34rSJpjynLJ9GHQ+97hUieMUsy4Nt+Z9zKcOr3TXkJN3gUw7K8v4qVopWQdBQmETs82/5YiIBOceFc6o8CLTW5ou9JmPIjGY=;24:ZUl0CMZ/Y5suq2CwFmgEu5QettVa3o1DerrW78kFmtB5TlsT6SJmSQ8MT7/nzQHKZLkSOdLgOmz55zG/fgpLkdgbEiNC8qJcrcLlTpsrkdQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;7:qc1ghTn28QoJjDDSij6MsW9hxmqHe13zzJ1Hd4cc0gTXjjc+F6T3Sf1+ISxw5de6AkLfAIK42IkJVJYQhJMhFBA0LsmZ0grFyaux8YWKwsdpT/3jpjJU6vZdABvw/q1s0+mPiv2hNzZkBQtg+tjHvLhNUlQh7AQdX5ZvClrmAQIjEMTco7HUXFzH9faemUxmvkfq/azbE6cSvETmhQ+SErjAhvFKs/kf8e/bre9mKcMpSCDPn9OYMDm0l6J66sAp
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 06:41:15.4538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e2be76-1068-455f-8147-08d5e2424f89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, 04 Jul 2018 19:08:22 +0300 Andy Shevchenko wrote:

> On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:
>=20
> Thanks for an update, my comments below.
>=20
> > For Synopsys DesignWare 8250 uart which version >=3D 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits. =20
>=20
> I have read 4.00a spec a bit and didn't find this limitation.
> The fractional divider can fit up to 32 bits.

the limitation isn't put in the register description, but in the description
about fractional divisor width configure parameters. Searching DLF_SIZE will
find it.

=46rom another side, 32bits fractional div is a waste, for example, let's
assume the fract divisor =3D 0.9,=20
if fractional width is 4 bits, DLF reg will be set to UP(0.9*2^4) =3D 15, t=
he
real frac divisor =3D  15/2^4 =3D 0.93;
if fractional width is 32 bits, DLF reg will be set to UP(0.9*2^32) =3D 386=
5470567
the real frac divisor =3D 3865470567/2^32 =3D 0.90;

>=20
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly checks the component version during probe, if
> > version >=3D 4.00a, then calculates the fractional divisor width, then
> > setups dw specific get_divisor() and set_divisor() hook. =20
> =20
> > +#define DW_FRAC_MIN_VERS		0x3430302A =20
>=20
> Do we really need this?=20
>=20
> My intuition (I, unfortunately, didn't find any evidence in Synopsys
> specs for UART) tells me that when it's unimplemented we would read back
> 0's, which is fine.

yeah, I agree with you. I will remove this version check in the new version

>=20
> I would test this a bit later.
>=20
> >  =20
>=20
> > +	unsigned int		dlf_size:3; =20
>=20
> These bit fields (besides the fact you need 5) more or less for software
> quirk flags. In your case I would rather keep a u32 value of DFL mask as
> done for msr slightly above in this structure.

OK. When setting the frac div, we use DLF size rather than mask, so could
I only calculate the DLF size once then use an u8 value to hold the
calculated DLF size rather than calculating every time?

>=20
> >  };
> > =20
> > +/*
> > + * For version >=3D 4.00a, the dw uarts have a valid divisor latch
> > fraction
> > + * register. Calculate divisor with extra 4bits ~ 6bits fractional
> > portion.
> > + */ =20
>=20
> This comment kinda noise. Better to put actual formula from datasheet
> how this fractional divider is involved into calculus.

yeah. Will do.

>=20
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{
> > +	unsigned int quot;
> > +	struct dw8250_data *d =3D p->private_data;
> > + =20
>=20
> > +	quot =3D DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > baud); =20
>=20
> If we have clock rate like 100MHz and 10 bits of fractional divider it
> would give an integer overflow.

This depends on the fraction divider width. If it's only 4~6 bits,
then we are fine.

>=20
> 4 here is a magic. Needs to be commented / described better.

Yes. divisor =3D clk/(16*baud) =3D BRD(I) + BRD(F)
"I" means integer, "F" means fractional

2^dlf_size*clk/(16*baud) =3D 2^dlf_size*(BRD(I) + BRD(F))

clk*2^(dlf_size - 4)/baud =3D 2^dlf_size*((BRD(I) + BRD(F))

the left part is "DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)",
let's assume it equals quot.

then, BRD(I) =3D quot / 2^dlf_size =3D quot >> dlf_size, this is where
"quot >> d->dlf_size" below from.

BRD(F) =3D quot & dlf_mask =3D quot & (~0U >> (32 - dlf_size))

>=20
> > +	*frac =3D quot & (~0U >> (32 - d->dlf_size));
> > + =20
>=20
> Operating on dfl_mask is simple as
>=20
> u64 quot =3D p->uartclk * (p->dfl_mask + 1);

Since the dlf_mask is always 2^n - 1,=20
clk * (p->dlf_mask + 1) =3D clk << p->dlf_size, but the later
is simpler

>=20
> *frac =3D div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> return quot;

quot =3D DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)
*frac =3D quot & (~0U >> (32 - d->dlf_size))
return quot >> d->dlf_size;

vs.

quot =3D p->uartclk * (p->dfl_mask + 1);
*frac =3D div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
return quot;

shift vs mul.

If the dlf width is only 4~6 bits, the first calculation can avoid
64bit div. I prefer the first calculation.

>=20
> (Perhaps some magic with types is needed, but you get the idea)
>=20
> > +	return quot >> d->dlf_size;
> > +}
> > +
> > +static void dw8250_set_divisor(struct uart_port *p, unsigned int
> > baud,
> > +			       unsigned int quot, unsigned int
> > quot_frac)
> > +{
> > +	struct uart_8250_port *up =3D up_to_u8250p(p);
> > +
> > +	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac); =20
>=20
> It should use the helper, not playing tricks with serial_port_out().

I assume the helper here means the one you mentioned below, i.e in

if (p->iotype =3D=3D UPIO_MEM32BE) {
	...
} else {
	...
}

>=20
> > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > +	serial_dl_write(up, quot); =20
>=20
> At some point it would be a helper, I think. We can call
> serial8250_do_set_divisor() here. So, perhaps we might export it.

serial8250_do_set_divisor will drop the frac, that's not we want ;)

>=20
> > +}
> > +
> >  static void dw8250_quirks(struct uart_port *p, struct dw8250_data
> > *data)
> >  {
> >  	if (p->dev->of_node) {
> > @@ -414,6 +445,28 @@ static void dw8250_setup_port(struct uart_port
> > *p)
> >  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> >  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) &
> > 0xff);
> > =20
> > +	/*
> > +	 * For version >=3D 4.00a, the dw uarts have a valid divisor
> > latch
> > +	 * fraction register. Calculate the fractional divisor width.
> > +	 */
> > +	if (reg >=3D DW_FRAC_MIN_VERS) {
> > +		struct dw8250_data *d =3D p->private_data;
> > + =20
>=20
> > +		if (p->iotype =3D=3D UPIO_MEM32BE) {
> > +			iowrite32be(~0U, p->membase + DW_UART_DLF);
> > +			reg =3D ioread32be(p->membase + DW_UART_DLF);
> > +		} else {
> > +			writel(~0U, p->membase + DW_UART_DLF);
> > +			reg =3D readl(p->membase + DW_UART_DLF);
> > +		} =20
>=20
> This should use some helpers. I'll prepare a patch soon and send it
> here, you may include it in your series.

Nice. Thanks.

>=20
> I think you need to clean up back them. So the flow like
>=20
> 1. Write all 1:s
> 2. Read back the value
> 3. Write all 0:s

oh, yeah! will do

>=20
> > +		d->dlf_size =3D fls(reg); =20
>=20
> Just save value itself as dfl_mask.

we use the dlf size during calculation, so it's better to hold the dlf_size
instead.

Thanks for the kind review,
Jisheng
