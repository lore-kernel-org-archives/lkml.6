Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB43C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE15218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Wyaon66l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBKNPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:15:30 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:17378
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfBKNP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTNdS0g8Q7GNxj3MU6r360jJh782FGbhTBAqg15yg5c=;
 b=Wyaon66l1QT2V65GL+wn8Di4vv1++GjYB7Dj6olUIs94t2UegEchiq3kjByqFUkCu85HxlmQ8VlC39/p/1G616lnrrQN0oVn8067ryajh2SSvA1hgpjoCwbyw7que+WJlGJMblz0iQNZaWPMzlzBesV5nQ8RmMNCb5TvT73mfqU=
Received: from VI1PR06CA0150.eurprd06.prod.outlook.com (2603:10a6:803:a0::43)
 by DB6PR0601MB2149.eurprd06.prod.outlook.com (2603:10a6:4:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Mon, 11 Feb
 2019 13:15:22 +0000
Received: from HE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::208) by VI1PR06CA0150.outlook.office365.com
 (2603:10a6:803:a0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 13:15:22 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; axentia.se; dkim=none (message not signed)
 header.d=none;axentia.se; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT043.mail.protection.outlook.com (10.152.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 13:15:21 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 14:14:59 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 14:14:58 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Rosin <peda@axentia.se>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Date:   Mon, 11 Feb 2019 14:14:59 +0100
Message-ID: <1845501.4feNL5aF6H@pcbe13614>
In-Reply-To: <7ef62069-3ce1-2c31-b64e-3a5d045990e5@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <20190211083122.32485-4-federico.vaga@cern.ch> <7ef62069-3ce1-2c31-b64e-3a5d045990e5@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(246002)(426003)(7636002)(50466002)(97756001)(8676002)(7736002)(23726003)(9686003)(6116002)(14444005)(8936002)(336012)(47776003)(186003)(3450700001)(46406003)(106002)(316002)(446003)(11346002)(6916009)(26005)(786003)(2906002)(43066004)(16526019)(356004)(486006)(476003)(229853002)(33716001)(6246003)(9576002)(126002)(305945005)(86362001)(33896004)(4326008)(230700001)(53546011)(106466001)(478600001)(54906003)(76176011)(74482002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2149;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ebde030-ca5f-450e-e789-08d69022fa3d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB6PR0601MB2149;
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2149:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2149;20:qKXTw3r1lBVDqIsXg2H8SRNypSMMyJmotYCoGSehIRqkQG/MhQ1l8Y4WmQQIPpo1YJ0OIkQ8ioxt/X8WSo1H5O0i/u4A+mFUq9rkZptb01IYireae6SVl73D0IuCJO5S0aEtTszEbAw9jByGrKRvc9Jk0DQgTtJEo+lQR+YComKHDJBKA097NOVe9HMK8XeAYqSuYZj3+ax+tOzIBmBAp+IjRB9ZdILB3k4OVqqNOK/5+xbanmdszoclih1T4/MRBRiWsHOgWGJ2eBaXrBMBmbPq5TIB4INlFNrjwp3uDJ5aD7sg4j1ud2i0DVSuODLKDjZzPquuPqa39bTr4k0rVmBwvU4uQaMot/Mpn6OyXMFJv7t6soNuE8GhGZu3AMErtqnaZlNSaWd4I60fZ44CG4SmGnRZ6m7Eikk9oa5JC19h2m38tFqgMZr0fi148QS19aHQSe1amZfRCEWD63G6JwXeFQdl7/dy4uGIZB+7lFTLZA2RWP7wOROjOFAUacc6;4:1m3QOW23aS1xNRX3HpHiq5iRP4zgpwYW6OEZrE/kUWwAkgGZd8fOCKr4u/q5aOoA/8th24FbI1Zby7KtLCT1HIOhz+hbn0nYQKfn1mF5QqYMXh8DcvqiyX5//2aBBcbpgKspZwgLkVFV9a0JqVD55ET1iHGo3af1CEKPw9GRwG2sgi0QRiZ/CRyBhGIZbNnGrj/atw+EmHIqHGMlVJAUnWwAbCP8aDnkjbCKTxwj2VfmjjBm2XtRG6RyLk9vUE2hrDEY5dV2KI99i/zQAMNfc8Ah5LKITlTjhaS/a8oZwYw=
X-Microsoft-Antispam-PRVS: <DB6PR0601MB214987DE45035CB586443BA9EF640@DB6PR0601MB2149.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0601MB2149;23:BIO76/rdrBdvWwMJ9LAYE+3ItEG2AvFnAJk8YVV?=
 =?us-ascii?Q?EGJkka98CJfB1enIyOsH0bhr663aIt//Dtlgx4A5s4tfDRwFT3emG3JRW43O?=
 =?us-ascii?Q?MA2EZCWmRoudfu+TFHU/zFwZCf7fLVESBxXdB1JDHRM2pBUyjOe/cspK37gC?=
 =?us-ascii?Q?gs8JIjlUPHYNL2mHQIJLQt50USy6+KtGMOVGv4HmTGciMUTFBXhghuhG8pw/?=
 =?us-ascii?Q?jJJmiInTYiEJqjS25cfvsVkT5jtSQe9BD+eRFwFxzLtVagp8PjjD6/z+Vq4G?=
 =?us-ascii?Q?433js/TKhwfi3tdzBW7tRj01By/TybYl0dAly0Je2k2zGhlJbvaS+KyRDTfY?=
 =?us-ascii?Q?p9giY+l/qDrSBM3jjpOJ8tr5xVVfwlpertL+Mhh6zXS8Dkz6Gg103oR3uhIq?=
 =?us-ascii?Q?qtp4VCW2OMYcWsHpzirhJehIZTSU9sszyCCusypAVkH2MdXjjYXbppB4TBef?=
 =?us-ascii?Q?mN7CAH7M3e5li0dwMFQNVd8avE4w+1HsWCVTPkKSHycBNsx8o03drVK36bEH?=
 =?us-ascii?Q?qfk9G6BL650J54eZJ5YpRqVoo8PZaXGbEQdiex7FYQ9CqDwF56F9ywSpDk5k?=
 =?us-ascii?Q?+n8yO4fxVMI1dqdq6FZqyeFfXM55lrQjpeXOnKRiaTgV9g0CTQzGPthDupBD?=
 =?us-ascii?Q?CmE+NyUjAEB2JSQKv2KbRQKIuF7tTcAuXVQ3FUmHK0BdhkB+5MkxDHJv4w+w?=
 =?us-ascii?Q?aFUbFvH+yjB68ubVwuYrPajudjE86bXkCI38zi1FWczU43+CCWlnvYm44WXV?=
 =?us-ascii?Q?pbMJrZQDt91FN37F19W+FndIs/TGuafRyUZTb/+j+PRFRxbgu6Z9iORaqPw0?=
 =?us-ascii?Q?nk7cVkSWWDkvd4t6devcP5R3x0GabIBB7poaYiYEpp7Z4wl+BbWrQ004O1W0?=
 =?us-ascii?Q?TqonIZ97roRJ7qW72Vx5X4DbuYGjK+Mx977+ZzluDlIiHbDxbC00nnuhTbl9?=
 =?us-ascii?Q?UsNof7AXt9b/l65QEmNsHQrV4SNR1sjpHNL///lMBNYqab4E1Vv1q+MA7BFs?=
 =?us-ascii?Q?6IfYUrPjo5nbDDWxuE2gHrZjN/ykSIEsSlItWD2dsop9ecJoWqrRrlCfULT6?=
 =?us-ascii?Q?TUZ3kuA+wuWX6Q1vZDFerUgHTri9UAxvFacYEJ98GOxc4MBEqOBMfPvqqg6D?=
 =?us-ascii?Q?U0g46qFc1kXM3Q0qbX0DnWl6KYmx61Cbnzk2UtUQf5olMKbgXOcxYX3Oole7?=
 =?us-ascii?Q?gT8L4rFZ85a+ZVRo=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LeGpWJDKFZSeUpj9/c9Owv96e1UhbfK2ytW4cVNlh5FGk8P1L6HgUP9mwKEGPe4woLqgJ48cLMlFcxK40stvbmZwjtKR6B+JljzrS/4/hYhMDO2+qUoNIF9zcWjMIz+7FKdRA56Y2JExrF7zUwWICprlCALaDI6ITsafGNeRZyHf420+6k08qgjR83rRlqiTmaQhIFd8ioGsuUtNHIPldXMqo1dFyn6wpqXLpzNUWBiTcNXUN8Cgp6cUffqBnS8CuD5yqOhvS+1HrE/bpTkYxYconGEenximYefA6pTg9ANrKBe1jv7xXnqLOFa8JzGDnqsRCZXnwL6el2rjOGotuWL/VxsLh8I6s6QPX2DfmSYGpZ+lzAo/jgbSFZBNb3XJiyjI+ZuzMXAtPaXSlkcM9qXuX2wTN1mzho2RpRPEYTk=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2149;6:uW/sXiAO0nhRuAoh/F56LoJL0lWoahx+9YI11iq2l73J8I40mIr+7HxC2OIBQpVay+Da5gyxVLrIUFduorTmDn72nWlWDEthTtq0H5ui5IXYvec4gRwYwOzaZNNi1xYNFVXycWRRycPj1xFQ0I5oH6KNUr8+jL+BGskKj77dBC2f9oW8HRPDuGw+6ijBaDSKptWmoDCabeHG6tPJGpCLxN/dVY8KlcnnFkI2PIw0X2DJWuScWwHLDWMwgY1r5yaWodZgDIXPcDMalljV80zp/wgWX3xK8TTrFYkfp01NTOPq5IpiyhCFp8of/NLZcIGg2dOUNyZs988JCNwXx+8TKYSTxgPwi+e+8S66+LZcEegbtqHIjAHfHfhkU7yTpyh7w8R7D6befxWlxWna9InMTkHbNboPB2rkzSSgtHd8TkAyvDspZc8e8D1N32GSM5ZJJf0MMxIkYCd3EtTv7Szk8g==;5:yg79XZSUCmivQaRZ2wr/Lcz8cNgKgZ0S6T0txUZpv7Q31T/pZqijY2/IBm6D64VQ4E4bI4G4XoVtiMyWK4pvhE3US4sBGLRVntUR7asBAgqqULgU8nqi5oBQf2+P0whiahVryFpnChCP6H/L+CDODBYIdBlvtSbd/pb06iWPvW9xzmDYUju77Y3uIj5fvjR4VkAijNy5SE3Xsps2qKl+Mw==;7:7RfpyKrh8c3JxG7e7yWJVTeqd+Ba1Wpj0nfjgRwNQtKE05S5mBx/pswuZ2FVlL1FA4V85N4YnH75Q/qLkDMWd/MEb2asUx+JZnqBDTUuGkTnh31LNRkCx1oo19Z9/Dr4M2xFLOdsNUN6hO0q4fkNMA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 13:15:21.8105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebde030-ca5f-450e-e789-08d69022fa3d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 11:43:45 AM CET Peter Rosin wrote:
> On 2019-02-11 09:31, Federico Vaga wrote:
> 
> > This driver assumes that an interrupt line is always available for
> > the I2C master. This is not always the case and this patch adds support
> > for a polling version.
> > 
> > Report from Andrew Lunn:
> > 
> > 
> >   I did some timing tests for this. On my box, we request a udelay of
> >   80uS. The kernel actually delays for about 79uS. We then spin in
> >   ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.
> > 
> > 
> > 
> >   There are actually 9 bits on the wire, not 8, since there is an
> >   ACK/NACK bit after the actual data transfer. So i changed the delay to
> >   (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
> >   not looping at all. But for reading an 4K AT24 EEPROM, it increased
> >   the read time by 10ms, from 424ms to 434ms. So we should probably keep
> >   with 8.
> > 
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 180
> >  +++++++++++++++++++++++++++++++++++-----
 1 file changed, 160
> >  insertions(+), 20 deletions(-)
> > 
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c
 index fcc2558..d42a324 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -13,6 +13,7 @@
> > 
> >   */
> >  
> >  
> >  #include <linux/clk.h>
> > 
> > +#include <linux/delay.h>
> > 
> >  #include <linux/err.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > 
> > @@ -26,6 +27,9 @@
> > 
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> >  #include <linux/spinlock.h>
> > 
> > +#include <linux/jiffies.h>
> > +
> > +#define OCORES_FLAG_POLL BIT(0)
> > 
> >  
> >  /**
> >  
> >   * @process_lock: protect I2C transfer process.
> > 
> > @@ -35,6 +39,7 @@ struct ocores_i2c {
> > 
> >  	void __iomem *base;
> >  	u32 reg_shift;
> >  	u32 reg_io_width;
> > 
> > +	unsigned long flags;
> > 
> >  	wait_queue_head_t wait;
> >  	struct i2c_adapter adap;
> >  	struct i2c_msg *msg;
> > 
> > @@ -246,10 +251,117 @@ static void ocores_process_timeout(struct
> > ocores_i2c *i2c)
> 
> >  	spin_unlock_irqrestore(&i2c->process_lock, flags);
> >  
> >  }
> >  
> > 
> > -static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > int num)
 +/**
> > + * Wait until something change in a given register
> > + * @i2c: ocores I2C device instance
> > + * @reg: register to query
> > + * @mask: bitmask to apply on register value
> > + * @val: expected result
> > + * @timeout: timeout in jiffies
> > + *
> > + * Timeout is necessary to avoid to stay here forever when the chip
> > + * does not answer correctly.
> > + *
> > + * Return: 0 on success, -ETIMEDOUT on timeout
> > + */
> > +static int ocores_wait(struct ocores_i2c *i2c,
> > +		       int reg, u8 mask, u8 val,
> > +		       const unsigned long timeout)
> > +{
> > +	unsigned long j;
> > +
> > +	j = jiffies + timeout;
> > +	while (1) {
> > +		u8 status = oc_getreg(i2c, reg);
> > +
> > +		if ((status & mask) == val)
> > +			break;
> > +
> > +		if (time_after(jiffies, j))
> > +			return -ETIMEDOUT;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/**
> > + * Wait until is possible to process some data
> > + * @i2c: ocores I2C device instance
> > + *
> > + * Used when the device is in polling mode (interrupts disabled).
> > + *
> > + * Return: 0 on success, -ETIMEDOUT on timeout
> > + */
> > +static int ocores_poll_wait(struct ocores_i2c *i2c)
> > +{
> > +	u8 mask;
> > +	int err;
> > +
> > +	if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR) {
> > +		/* transfer is over */
> > +		mask = OCI2C_STAT_BUSY;
> > +	} else {
> > +		/* on going transfer */
> > +		mask = OCI2C_STAT_TIP;
> > +		/*
> > +		 * We wait for the data to be transfered (8bit),
> > +		 * then we start polling on the ACK/NACK bit
> > +		 */
> > +		udelay((8 * 1000) / i2c->bus_clock_khz);
> > +	}
> > +
> > +	/*
> > +	 * once we are here we expect to get the expected result immediately
> > +	 * so if after 1ms we timeout then something is broken.
> > +	 */
> > +	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
> > +	if (err)
> > +		dev_warn(i2c->adap.dev.parent,
> > +			 "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
> > +			 __func__, mask);
> > +	return err;
> > +}
> > +
> > +
> > +/**
> > + * It handles an IRQ-less transfer
> > + * @i2c: ocores I2C device instance
> > + *
> > + * Even if IRQ are disabled, the I2C OpenCore IP behavior is exactly the
> > same
 + * (only that IRQ are not produced). This means that we can re-use
> > entirely + * ocores_isr(), we just add our polling code around it.
> > + *
> > + * It can run in atomic context
> > + */
> > +static void ocores_process_polling(struct ocores_i2c *i2c)
> > +{
> > +	while (1) {
> > +		irqreturn_t ret;
> > +		int err;
> > +
> > +		err = ocores_poll_wait(i2c);
> > +		if (err) {
> > +			i2c->state = STATE_ERROR;
> > +			break; /* timeout */
> > +		}
> > +
> > +		ret = ocores_isr(-1, i2c);
> > +		if (ret == IRQ_NONE)
> > +			break; /* all messages have been transfered */
> > +	}
> > +}
> > +
> > +static int ocores_xfer_core(struct ocores_i2c *i2c,
> > +			    struct i2c_msg *msgs, int num,
> > +			    bool polling)
> > 
> >  {
> > 
> > -	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> > 
> >  	int ret;
> > 
> > +	u8 ctrl;
> > +
> > +	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> > +	if (polling)
> > +		oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~OCI2C_CTRL_IEN);
> > +	else
> > +		oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN);
> > 
> >  
> >  
> >  	i2c->msg = msgs;
> >  	i2c->pos = 0;
> > 
> > @@ -259,16 +371,37 @@ static int ocores_xfer(struct i2c_adapter *adap,
> > struct i2c_msg *msgs, int num)
> 
> >  	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
> >  	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> >  
> >  
> > 
> > -	ret = wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
> > -				 (i2c->state == STATE_DONE), HZ);
> > -	if (ret == 0) {
> > -		ocores_process_timeout(i2c);
> > -		return -ETIMEDOUT;
> > +	if (polling) {
> > +		ocores_process_polling(i2c);
> > +	} else {
> > +		ret = wait_event_timeout(i2c->wait,
> > +					 (i2c->state == STATE_ERROR) ||
> > +					 (i2c->state == STATE_DONE), HZ);
> > +		if (ret == 0) {
> > +			ocores_process_timeout(i2c);
> > +			return -ETIMEDOUT;
> > +		}
> > 
> >  	}
> >  
> >  
> >  
> >  	return (i2c->state == STATE_DONE) ? num : -EIO;
> >  
> >  }
> >  
> > 
> > +static int ocores_xfer_polling(struct i2c_adapter *adap,
> > +			       struct i2c_msg *msgs, int num)
> > +{
> > +	return ocores_xfer_core(i2c_get_adapdata(adap), msgs, num, true);
> > +}
> > +
> > +static int ocores_xfer(struct i2c_adapter *adap,
> > +		       struct i2c_msg *msgs, int num)
> > +{
> > +	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> > +
> > +	if (i2c->flags & OCORES_FLAG_POLL)
> > +		return ocores_xfer_polling(adap, msgs, num);
> > +	return ocores_xfer_core(i2c, msgs, num, false);
> > +}
> > +
> > 
> >  static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
> >  {
> >  
> >  	int prescale;
> > 
> > @@ -294,7 +427,7 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)
> 
> >  
> >  
> >  	/* Init the device */
> >  	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
> > 
> > -	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
> > +	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
> 
> 
> You fix this up in patch 5 (in what is perhaps carelessly marketed as
> fixes for minor checkpatch issues), but for this patch you are actually
> no longer making sure that you clear the OCI2C_CTRL_IEN bit as the code
> used to before this patch. I think you intended to preserve that
> behavior, no?

I think you got confused by the two patches because those lines look very 
similar.

In PATCH 5 what you see is the "style fix" to clear EN and IEN before clock 
configuration

in PATCH 3 (this one) what you see is when later (same function, after clock 
configuration) the device is re-enabled (EN), but without enabling the 
interrupt because on polling configuration we do not want to see interrupt 
flowing.

So, the behavior is preserved for what concern clearing the IEN bit before 
clock configuration.

am I wrong?

> 
> Cheers,
> Peter
> 
> 
> >  
> >  
> >  	return 0;
> >  
> >  }
> > 
> > @@ -451,10 +584,6 @@ static int ocores_i2c_probe(struct platform_device
> > *pdev)
> 
> >  	int ret;
> >  	int i;
> >  
> >  
> > 
> > -	irq = platform_get_irq(pdev, 0);
> > -	if (irq < 0)
> > -		return irq;
> > -
> > 
> >  	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> >  	if (!i2c)
> >  	
> >  		return -ENOMEM;
> > 
> > @@ -509,18 +638,29 @@ static int ocores_i2c_probe(struct platform_device
> > *pdev)
> 
> >  		}
> >  	
> >  	}
> >  
> >  
> > 
> > +	init_waitqueue_head(&i2c->wait);
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq == -ENXIO) {
> > +		i2c->flags |= OCORES_FLAG_POLL;
> > +	} else {
> > +		if (irq < 0)
> > +			return irq;
> > +	}
> > +
> > +	if (!(i2c->flags & OCORES_FLAG_POLL)) {
> > +		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
> > +				       pdev->name, i2c);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Cannot claim IRQ\n");
> > +			goto err_clk;
> > +		}
> > +	}
> > +
> > 
> >  	ret = ocores_init(&pdev->dev, i2c);
> >  	if (ret)
> >  	
> >  		goto err_clk;
> >  
> >  
> > 
> > -	init_waitqueue_head(&i2c->wait);
> > -	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
> > -			       pdev->name, i2c);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "Cannot claim IRQ\n");
> > -		goto err_clk;
> > -	}
> > -
> > 
> >  	/* hook up driver to tree */
> >  	platform_set_drvdata(pdev, i2c);
> >  	i2c->adap = ocores_adapter;
> > 
> > 
> 
> 




