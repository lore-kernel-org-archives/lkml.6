Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE9C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833442089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Asn7SdtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833442089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeGKGqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:46:21 -0400
Received: from mail-eopbgr730081.outbound.protection.outlook.com ([40.107.73.81]:43447
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbeGKGqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk1NIdEUqQNUdAkQnzsaGiJ0PqhvMBtW5S9Ck5kE3mI=;
 b=Asn7SdtEjFHS3grOmelUoQqSBq75o7eKiBiIGbnDFg8r4UbnDr1SUZxSl0uAi5rqnqmmwpGNa0PjWJCCJU0wnhbcvz7OgyjcRCjdERzILla4fne4IfD+QrL1bVKfcLOjo8kpArwVWlP8SYPrfR+TFDf9Ysu1T7kPxtWY4quSMUQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BN6PR03MB2627.namprd03.prod.outlook.com (2603:10b6:404:59::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 06:43:26 +0000
Date:   Wed, 11 Jul 2018 14:41:25 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180711144125.7d4e6a73@xhacker.debian>
In-Reply-To: <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
References: <20180710110942.5b0a016e@xhacker.debian>
        <20180710111516.13b8c570@xhacker.debian>
        <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR2P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::30) To BN6PR03MB2627.namprd03.prod.outlook.com
 (2603:10b6:404:59::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf2a545-4dc5-42ac-a18d-08d5e6f99c9d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2627;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;3:F+rqnHZ8OYGNBWfD/VvIpDi0upjqTBk2iCbbFowI43oDSC7/MWSLvYLVk+cZynIkQo0sp9jX1tMHeXbf8Y40LjqUgkv8e/ivFUGKm1z5cGxCvN7pHdt5mV/RDcde6kEpXI7pptNy49wGzagXhMsqGXrVs11oUvmZ2yY9anVfEeQvsbAQo9Z0QolU5j7EpmclG/kYO/dbHJ/9Bu0yETF1YZNM9Cjgr63qvq1K7b9RU6nqvl5CBvKyvwdXYiBTU6Aw;25:3Od92QbaEcJ4IzehlPn7s7Xpw7r9rURjlRmD3iUyu4JYERQ5VZbht1uf8BefjjtHZ5uQ80vg0RtjmVF1p5Fj7DiuKqy/7+yS5xnB/UM25D9d+4yM7bbn3nFHXG4tG+Wt7YUWqMVq6wXfn7+AvYeMRqMhLS5URKTFvwRllmo7A17huoWGafacTtwd9HTZIJ6nLXwji8ZdOW/qgLA6JYnvX0MD+tyn/PUUTpJUGrFmG6NksFri9aJgl4NCp119XL6oLbAgsxCy/HNEDCmsIJz71Ly3UyXobImWMz6az74aMeY7Ew7yCp3z7YdyqY3OyXnDTOCfPGAD45/mgQ6ZVGitPQ==;31:ob3M80wVcmw5VhAD9QqmRkPvpPdqd6FXwBKG4q+OCEKMKilwK8RYueguAkGjoTzyxyEaSjhLZR/gMgDBmP/i/sck+i+1ttB5I/iKAfbWi9MLaLkX9Pu0WENTS6EkfHHmQfFPUKVWyTW16DTqmQO39QqcMNcUVGRSRcWrLEw6mjp6tBG3oDBEM+ht/vTxNqOC/iN2FqpebZ81HXwzT2ULB+vhUenXxBw5cOD5/VMH5ck=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2627:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;20:fJ7pNCkvAZ5uKIlJ0tChehUZP8iJkd/28XXkek6ucy2JfKiu9EkJI5KejHzZDMuSWvyFp0PcmLUKawr1PriMlWhwviAf5HCBOiKjA5CSCNzn5zLVp9WZr+li45+nEihJzcszjjewVxc281ke3r/dU9lQ8tnrKdgC3nWjc1S2fEm8XDPQ33D9y98Lf0BI2dv0A3SYgRUd5UO15WEgaIEJ1te6NmAEhtZNkDbH/8ew+C59ewWNtNYQrVS7LB2c0GnOU0a5Eb+s3Sh/OqRXMHW1C2FB+hzJEgWuo6IJ869t0R1EJVf35PDVcjkxWkCMKGdnXiEvfet5WDReZ50eA/iSFwYoAyexX44BNoNIPCTwaOJnc3dJslPXgEJvewUKDmALMnQTAInIObNaxUIng3FNRWt0RwW/zyIYjP+EEB8weSVUTWR8CH8GVsZfuqjN3Je3+UZoonN3zCUz1KL8hhQfFcR3miwl0JPL6BdSMXZeYMiaoywAbOPd5coApXd8pxKy;4:cpyP0R57O6VFd4vbIKsu8HQAZhCcOnCK/cr1LSUm/Yi0hsnqnwPse6l6QqR03lJd6ZjvnUQIS2P4lleg0kIjEXUsSCm5fY4SlMth3fElBUejyt9fCu3xer3MVu5P9MlJHamZL82+bqb5iprPHjOObkulx0VJ+F3I6ib8yk4PKyWyD51rt0Rm2Rg4O0V9HsfYVqdFIB7DcQkuUYTCjuJph9tyCELMIZ2X5nIjcZHQ6jmeU5Znxj7r8gVSjyY8qZuzRmPR0mpLqjXSfDNgKkxFSxL672K1BLPGpxg3hsZVgaA9lpFPuRZLFMgFZHvXqb9jf/oVu8q4jGjyFX91JKlfuOqH9PmdAVXcTMyqeNb37snFfw8OnD7cE9E6SAU5TNZ2
X-Microsoft-Antispam-PRVS: <BN6PR03MB26273FFCF221E11A9A416073ED5A0@BN6PR03MB2627.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(788757137089)(192278398808882);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2627;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2627;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(86362001)(106356001)(1076002)(966005)(6116002)(3846002)(105586002)(23726003)(72206003)(6916009)(55016002)(229853002)(5660300001)(6306002)(2906002)(6246003)(50226002)(230700001)(4326008)(97736004)(478600001)(9686003)(50466002)(53936002)(68736007)(386003)(6506007)(316002)(54906003)(8936002)(81156014)(81166006)(8676002)(52116002)(76176011)(16526019)(11346002)(33896004)(7696005)(7736002)(66066001)(14444005)(47776003)(476003)(186003)(305945005)(446003)(956004)(486006)(26005)(25786009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2627;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2627;23:bX1PtEzIyUTAj3SZgoT+jFr+1ixGKyvOflHfRaIjZ?=
 =?us-ascii?Q?Grs9CjWtL26FrbkPJtHSgXpEz+90X9N42ZtcqUrlEJ/28fYirP4Bj7BGjjv6?=
 =?us-ascii?Q?1S3hg+9giYCeSUoA7C3BPEtWhNyI6NLGAp3rM8bP0pICkNrW5wOAvdmSsYDv?=
 =?us-ascii?Q?5x4KWAIMmmFHPcGVlV+hH6xgGKLdpa5cA2sLKTcoSBMBaPs1l6oZEh6551VY?=
 =?us-ascii?Q?udeHrTNxjIPUbjkNYrkc2ymFy72JbuJxpbN0/GUNeIAd4D3WfpwQprqrpDdP?=
 =?us-ascii?Q?bLUit09szW84POCF0OoKbf9+PqGeixydbreAmv2ONfBIbE0VQ2Q/CLM1sRve?=
 =?us-ascii?Q?dCBfeIa88Hh1b4WBGrVh7O0VnxHj4RqWSfo/yoQxPvbpOlaBWVcvSRoIEzby?=
 =?us-ascii?Q?Kwx0joEq11PwvZwY52Q+pykDz2rSXT9V/q0LytcZ/pAciAJL/5aH1g6sM08G?=
 =?us-ascii?Q?ovH5V1ZmQKK0L22I4w3x1egI8jkncTFFr68qLSl+1nq8+I0nVPNVlZwNnc8i?=
 =?us-ascii?Q?iOv3YHnu+vF07Or56CsomOl9gxr4EKQERt6DRkVrCziF7bN9DR+yJ7YAWvAG?=
 =?us-ascii?Q?R0ciiBvzVME9p60Jr0b1mryvPHWvQh/e/Q12brB/cMw3TthgpzoSgNN40MQU?=
 =?us-ascii?Q?EXVoNmueGE8Kl40kGP1k2xoUy6JMRavSjVUndWhIeYFKiuEWPob+3dD0GPOJ?=
 =?us-ascii?Q?ZHWnHKwJ1ajRasp39M/vIAslk9LxlSeMB0VFSeP/30zGT5S/bRCvgv3tMIH0?=
 =?us-ascii?Q?QmVcII2jU0Gs8yX4Ya8nSpHr7+MuRLOYU4JKe3TGJARE73MR5anpk3Tf6hxd?=
 =?us-ascii?Q?W8wpHT2j8X96MzxlmEyh9iua1JwKNWIxpzRnBD3DmXpKXvIB6yZTzj4krPsY?=
 =?us-ascii?Q?aQarP3S2cQbxfR0Rr6bY4ia6NdF4MNR+D3JNU0dVZvElwhfWeom8CiOgl6pD?=
 =?us-ascii?Q?jHwxUUGw3Qz2zTQFy9AeUlacPDYCHpRua8CEP9Q77LhnXAW8G8EYbW6Dv3J0?=
 =?us-ascii?Q?nLPN6h90vXdci1/E6LF9WtyqN7pDMT3J/Vbk7JPb6LNZErXP8v2drz2yBthQ?=
 =?us-ascii?Q?ajb6crJMYwFpnJ5r0TELzqKvgv2/Dp5hFD9lAVv0yI7LklpwqBV9MMZ4Tsgo?=
 =?us-ascii?Q?hJXRb/px23V5kcSRKZzvqaR5od2eOcQrtXuJKhkbAo5ZtlTbqcDIKNdX9Exx?=
 =?us-ascii?Q?b4tAfJJkZr/vGgizrtLTq7w0KZFKS59scQCmb3ANA4D8Bh5iJZwtYQ2OmDu3?=
 =?us-ascii?Q?3lzROC4QRDv/bywdV5jVNG524oiIitoAiQ24Rwqx2BAsVNcFugG3VBI352Vn?=
 =?us-ascii?Q?C6BSzO23nlr5YrGLSyu1c0=3D?=
X-Microsoft-Antispam-Message-Info: srH6GXfsScXMofNUzR4EdsqTaxhBe5YOY0M2sccqwt3uY4FKl3myp4ncUwkkw3MCmBAFNKvcaBmTAXFvDCoNPrrNyfrbp6ce1EmR/XJ6hgBhYWOzlFOKK0f8OEgkOrGo21HCIluK6BHMmLfiqUVlRbyFFTYvDhI6YFgnW2bB72vcX01J9VBoLhjQf0iKnGUnTjxgM7h8qpH8ePwpKjzwV9UEUYxxhxzXY/ddSA1asyNT8vruAG/N7/EuJIqs8SIasOQkgh5zdZHlNzIvkTjAXBmEYhJ+xCHjbdbaDT8/nWV5ef55z6KKJyDi7fY4SqaupJ9/RQoxtcNTkLx4NQgTsEGE+nY/outq3LHWubWzRJ0=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;6:tAx1vh5Pymh8yqKrJONUPJLYxb6FJD/mPWOgbsnZnpZ+tF3QwSLFkYNjtvnR0Zt02Cbpql9cCcYZ5KbuuAxYnaEsuQ6y1OmN5S8yvAyVKfk4+/O5D0U4gqz2CdJrNH9pjZqZJ9IlWMRyP7PBBRgaMNhruTfRgGjM/709EbS15PCUEc3VMYVkxwsOFbBTE7PZUUFHmCbP8X0mUwnWCho+Qi5tdMR9dE8Z4kY0M/QncqVIIHx8nb0kbVU0/WAmwpHY3G3ynY7MR5xvyVN8mH7td4HWBg0fGcTRdTIcy2x0sPbgPl2Q8d6hS/WCQ2Ub9rUKn5MliYhAt/2XyQejBRgID9e0EJtrghM5PBB0NYc3KtzaIyUwhmOztdl0H/s7Wp0mNtjGeoeELRrM4Jk3dLeMGX9wW6m7ui18aG6DOACJKb7YtGjF0hMJTb8wEXRvcLjRNDbCwGMqWqEe1av14aW8YQ==;5:hMVZltSSwrlsBZkEPnsm1/HMY82zf7hE59T5l+ac6Ktj73MhrTCTA1DfbacgABDxTAfgtCsJIIVI6NgcITpLbLwSp2AyqGz21Fj13+U26dmTTHlqf2Gft6hgmBxq9iE22M0HTN7YBczyXc+9uUkwHJy6ULoQSda0j46h/Brl+QI=;24:nc+RWgDD64mJW+eM8C01/Sod6NWLXn303PYIWYbxFkdDjnq3HtEkGBI/yfHdeKV6DQwUWtwto/sO8JcSDzVfhnOQk4ZyrdMAocciYNfmMlU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;7:zXtwCn+Ro3I+2+OZqnvq477KvM6BQC1VSvATH/QIAdz8TUjbI52LYq/0UQIj/wc0m7mifpS23dArOvB3KS4twHj8oPJkILAWegTdAXnLpptXJJMyQzw8HYvmZPrt/oVO6FFxpsQ4qv06hBTN7AwMM3diN6xuPX+IbgrF+wRQNxHqImDdFZhFktGEOvK5x0OUuUTlk+m3OjlLlpP/h9kxh1RXt3b9gH5vZAP7IwwI/WgSStCaHY37IlzB+v90Rvpp
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 06:43:26.5032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf2a545-4dc5-42ac-a18d-08d5e6f99c9d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, 10 Jul 2018 19:19:21 +0300 Andy Shevchenko wrote:

> On Tue, 2018-07-10 at 11:15 +0800, Jisheng Zhang wrote:
> > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits.
> > 
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly tries to get the fractional divisor width during
> > probe, then setups dw specific get_divisor() and set_divisor() hook.  
> 
> Thanks for an update, my comments below.
> 
> > +/*
> > + * divisor = div(I) + div(F)
> > + * "I" means integer, "F" means fractional
> > + * quot = div(I) = clk / (16 * baud)
> > + * frac = div(F) * 2^dlf_size
> > + *
> > + * let rem = clk % (16 * baud)
> > + * we have: div(F) * (16 * baud) = rem
> > + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16
> > * baud)
> > + */
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{  
> 
> unsigned int base_baud = baud * 16;

Good point. will send a new version.

> 
> > +	unsigned int quot, rem;
> > +	struct dw8250_data *d = p->private_data;
> > +
> > +	quot = p->uartclk / (16 * baud);
> > +	rem = p->uartclk % (16 * baud);
> > +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud);
> > +  
> 
> While it looks indeed better, I would rather like to have a confirmation
> it's working as designed.
> 
> For example, when I did some calculus, I cooked a preliminary check in
> Python (easy and fast to prototype), for example:
> https://gist.github.com/andy-shev/06b084488b3629898121 in Python, or
> commit 9df461eca18f ("spi: pxa2xx: replace ugly table by approximation")
> in the kernel.
> 
> Or another one here https://gist.github.com/andy-shev/8b2a73aeca2874f4cc
> 89 and commits c1a67b48f6a5 ("serial: 8250_pci: replace switch-case by
> formula for Intel MID"), 21947ba654a6 ("serial: 8250_pci: replace
> switch-case by formula")

My python coding skill is limited. So I wrote a simple c program to
do the check for common clks and baudrate combination. All passed. I
paste the code here:


#include <stdio.h>
#include <assert.h>
#include <math.h>

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

#define DIV_ROUND_CLOSEST(x, divisor)(			\
{							\
	typeof(x) __x = x;				\
	typeof(divisor) __d = divisor;			\
	(((typeof(x))-1) > 0 ||				\
	 ((typeof(divisor))-1) > 0 ||			\
	 (((__x) > 0) == ((__d) > 0))) ?		\
		(((__x) + ((__d) / 2)) / (__d)) :	\
		(((__x) - ((__d) / 2)) / (__d));	\
}							\
)

static unsigned int baud[] = {9600, 19200, 38400, 57600, 115200, 230400,
				460800, 921600, 1843200, 3250000, 4454400,
				576000, 1152000, 500000, 1000000, 1500000,
				2000000, 2500000, 3000000, 3500000, 4000000};

static unsigned int clk[] = {25000000, 50000000, 100000000, 133000000, 200000000};

static void check(int baud, int clk, int dlf_size)
{
	unsigned int rem, frac, quot;
	unsigned int base_baud = baud * 16;
	float div, divf;

	quot = clk / base_baud;
	rem = clk % base_baud;
	frac = DIV_ROUND_CLOSEST(rem << dlf_size, base_baud);

	div = (float)clk / base_baud;
	divf = div - (int)div;
	divf *= (1 << dlf_size);

	assert(quot == (int)div);
	assert(frac == (int)round(divf));
	printf("checked %d %d %d %d %d\n", baud, clk, dlf_size, quot, frac);
}

int main()
{
	int i, j, k;

	for (i = 0; i < ARRAY_SIZE(baud); i++) {
		for (j = 0; j < ARRAY_SIZE(clk); j++) {
			for (k = 4; k <= 6; k++) {
				check(baud[i], clk[j], k);
			}
		}
	}

	return 0;
}
