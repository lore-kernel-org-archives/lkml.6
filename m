Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DC5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B992204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="pKyAgn7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B992204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJYQUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:20:11 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:61344
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeJYQUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DLqdRZfJcqcCllLuI5C3Kes0PfKAwddMVh+UFqU+Aw=;
 b=pKyAgn7z7qV+pdCXzC9GlEWmJrNuBUgo2dGP9Ff+BoRTFNO3AsqH5yqZHVmrWlEF81bbMktln2dZjaK7O3qqWrcRXwegk3jFwOvEE/dv74l+EqDG7DtZUjhLHgGcVATU9XtexVefSLL4rqFfM35OpEURH1R5ICGb16nc3KzRcIw=
Received: from DB6PR0601CA0043.eurprd06.prod.outlook.com (2603:10a6:4:17::29)
 by AM0PR0602MB3521.eurprd06.prod.outlook.com (2603:10a6:208:22::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21; Thu, 25 Oct
 2018 07:47:48 +0000
Received: from HE1EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::201) by DB6PR0601CA0043.outlook.office365.com
 (2603:10a6:4:17::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 07:47:48 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT021.mail.protection.outlook.com (10.152.10.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.13 via Frontend Transport; Thu, 25 Oct 2018 07:47:47 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct
 2018 09:47:46 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Thu, 25 Oct 2018 09:47:46 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>
Reply-To: <federico.vaga@cern.ch>
CC:     linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date:   Thu, 25 Oct 2018 09:47:46 +0200
Message-ID: <13515533.pzSJtVrg2o@pcbe13614>
In-Reply-To: <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-4-federico.vaga@cern.ch> <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(76176011)(74482002)(33896004)(8936002)(230700001)(26005)(478600001)(9576002)(53546011)(186003)(16526019)(786003)(316002)(2906002)(8676002)(33716001)(5660300001)(54906003)(9686003)(4326008)(229853002)(6246003)(356004)(11346002)(44832011)(446003)(7636002)(426003)(305945005)(7736002)(97756001)(486006)(106002)(6916009)(46406003)(336012)(3450700001)(50466002)(6116002)(23726003)(47776003)(246002)(43066004)(106466001)(14444005)(126002)(476003)(86362001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0602MB3521;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d128587-8f85-4562-1e5c-08d63a4e2835
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR0602MB3521;
X-MS-TrafficTypeDiagnostic: AM0PR0602MB3521:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3521;20:+xkwKq2T7neKAmB1N0NLnxraa6rpjwUz0kvGDJVNfnZwFu7SOMoQpsrXCMO7fFljtSUOBx1wMSAbjxwz8j07Ud2Y4hQS45/hfW46QFRPHWo7uwo4TDmEBLSeEev0IpD/i3QL4fAHeULPavhmfxDFPA1zN1ilLv1q82hIOx/1CHZ5RsCqF/UsiQQ7xK8/yqUrYo3mraaksTvjA7c3X/IjhDdF70S1eu7FgX1loI7HpkoemvkO+Diq/8EMZyjGn4VaqJNjzVOrh1+O/31qtoOJBFkl9ugV1He4JaKaq+0f+jeRU5jU3K+z1L4is881Z/06Roggw2kFJ1NYUlzPEUb666xXM5HOGDuTdnxDGvFBGOh98l4uha5ed69DOTTfNFA3jPwSvrJH8wqzzmZ8tnQiHpqKrms0SxwXkRWu4VSKKtr39Ng5+oO52sfmxEMW3ug12P/btu/SRNqjn3Mebx7VXZEsaPWZ+B4M2hoopfMWIDIwN4kpAGTK4yYDXvyvyH+j;4:8aHcpR5MzrmRs6tFtv3QRd4YBf7ki2tYKI/eCSQ8E3por4SMUABr9NeOnpixUyA1H2WJqgnqMOmwTJA7GobpSX95MA+Q9EHQxPa42dfMEAQ0ziE94CXlOlRru1mAq7dc4yc2x4R0bhhpFd6Ribtb3VRvpJU3juGPqNoSc9nbaFtIZyOU96Jmnwdl8j/AWb9mGzEgwj7QrVbySD3iZbUqJUtHSeJyFa2/u14CD8n/RBmZfhc/sdU6qiO2lBlutG9zEkXbkH2h9sPCCxA9fEmz/w==
X-Microsoft-Antispam-PRVS: <AM0PR0602MB3521B20D7A87087559B7861DEFF70@AM0PR0602MB3521.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR0602MB3521;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0602MB3521;
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0602MB3521;23:AXrL9HQE69CYBuydZXkS82rbYF+y/E4+o/GfKh/?=
 =?us-ascii?Q?jVb9UEfwNLomrEG0Y/m0GllgPgtLMxYnkdhQkPkM0mh8KWsCGK2Ey6x9eqq6?=
 =?us-ascii?Q?UdzxcgIbwG2+HL/465HdWqV5Ki0qUM7tU2w3EOy9KRU4HcnynYSLDOpS6+fB?=
 =?us-ascii?Q?vEiq7DaVjYXKwic7ikY6CLHcd+OGNG1o5Y/Yry5972y2nmwLk57gvfeiygsS?=
 =?us-ascii?Q?GFMPNqd1AzzsHTnZIj1OgAWztcawuS09p2ZMXG3wfapQfe0XBVZ4DHLTaDo/?=
 =?us-ascii?Q?r1sWp1BshFRXjAdLGJOGR2wGKd68mtU8IfxpUpCu4ccF6hcubvciGCupQPL7?=
 =?us-ascii?Q?elpVhyp0gJe1cP+kpSplWNi9slTDBxUZ926tmjo5beCnE43gw4rEQHiT/YTC?=
 =?us-ascii?Q?iGOT5+iQiME9fxAbB7F5CrqZNAizOUb5zNPvI1ZMfqgpY1lBVfECshvzeESw?=
 =?us-ascii?Q?y0G4BeJjUoQzyiHJS5vfaF0+3J3FDDy7OZRVk2XrYCIE3AOKdtMkzL45k4El?=
 =?us-ascii?Q?dVD+OQYuGBXe3clcC3t73RaqxelTX8HMC9NQD0zSKWK9QFhJINdAi0au9Z9D?=
 =?us-ascii?Q?brN6+SMz0FTFYFODCRetVlkOdYOtHCCV/TuH/iP5X5uE64r3WIcaO5OkvSZr?=
 =?us-ascii?Q?YX5h+C6E+CbCb85TSU3Gp9tRgLW2cKKzaeqqTV1oBlZpyGv3ArBh7G1mZBm/?=
 =?us-ascii?Q?GGpwS6das94Yyb1tkz5er+0Sqec9ZAv12R4THCf3e3DEVkwtnXhphwljzm5e?=
 =?us-ascii?Q?RtOpTa3XRWMfKjpfIPEer0L21N8Ax+27L+9eYIaVt4ba+PKusUBCeh94po4b?=
 =?us-ascii?Q?7FFTEUxpXXJNGHVBvRW5iV4cYKqecJtlGQwULwML3ykjwKClGsZMh4r0O9ia?=
 =?us-ascii?Q?9bGnGjfEQHh3eYWIvuc8W/l4wtA5XnX9A8felP7HLWySpB4AvrJ+JFuzPCql?=
 =?us-ascii?Q?DKCovHmqylKsS1mhTYepb1YLh2yGCZ2TPsbaJlMaRaXr0RZNr+c1LULr2FCW?=
 =?us-ascii?Q?+rWV6MhYmmRhPwiOh/sb/Mu/uJIS+7bO0/kbM2+KxE5IPNpnytimlqfnMwZX?=
 =?us-ascii?Q?GkeC6Lw/00TlW6Dt9WL746GDC99jYEIUDyKloZnDUDf6jRcu9nsqPJCP2NG5?=
 =?us-ascii?Q?k4YoaIUYB4KQ5aFax2EDVV4JdBOwWJiqdUQ3KNSLZdVWff7nLFpvRnEv7mtQ?=
 =?us-ascii?Q?F/HJ+W6JBSBYUXPaFe9WaPl5LfY8/RufBtcUMScyeBrL4jfW7zi6IkqSUY1G?=
 =?us-ascii?Q?6vLU1f/c8D97PbrhnjPzArLDebwHKcpCuGw1PSs4/?=
X-Microsoft-Antispam-Message-Info: czMu9weIrkgGlsshru4vhPwJteJX1W7i0pLPrW8itiy0Rzw49Kgp7An9ojn8vee8Tykz4j5iW0XQFoQc6EQVAAeUsIO4Ip0WgFo6YzHsEQewC/ax5qefmtunLCpvA1Bde3oORAzycUIwGRb7U2eu8oTapalYJFKiTz1hSnrmWj65I1wDsoF0ZTugKKfd0ZA1srNlLXNBBPW5u2FkGMKSXz3/pVUlECWFgOcH8HmdFkNz3ARc+CDUC/OOx/llS3JhEsULmDk2Y0avoYyiLxL/fbi3FJJUspzWr0OKdreX8jsjYJDafXV6qJ6xhlpRKZuDonu5MBH/mZvUEWI7REJLSrh1EVVag7dXm3Ku50IG8yE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3521;6:9rHE8g8hW+AiIpNtUuzkJDkjN+XzffAhP5BAdv6SOmkyceqVTnu5MguzSj1sd2F4DE2BqG1SYZ1/iQzZ2hChqj08bDtb6ryS28h5xBKbVPGXwkj2qLPU80mgX0nGJQx8T0/YsN0rcT3zUdNvuETuITQctuGZofKVxYP7ObqxuHo4YsyC+IMyRukP1zDwyzmHh0U+yK6WgJiYha0h4S8FsdIPssqH+M9fris7CtTNeCyPlVPDY0UrmETAg1OUVKKw6PPj+DAPAUkE++Zbl0tjGPF/imG3AF2+sclT7LEpmlcolDiauX0nk7GSD+oM9fMIIZVWwodfVxwvhL192U+xXDgs0xZZVgiJqixR/ElRtNxi78BIOXssm7Lnjfs7aI6YgIZDOSTCKc+WPpvyHIeYTIBYMpUrzmbzU0XKlO032FiGi8l8Y1uMzwxfyI1nV7a6xe4gwom2uMvYp5QhiDM6mg==;5:qcn3fMMbImgT+tangQ851Xemc6e0kvvkvRhn5Pl/WGem5w7//2idexeQ4pV7kBdE0z33CvXlwLyHZSbJIBA9ckxKBhRZ0XoS1Ns2MA/H6RM2Sv8xi1zDk60fe4WzSyl/mwWca0aqFrFvVo6OqhMU/AJUPC/tmIyWvZRYXUFaJyE=;7:DQ+zwF3CGjGMkFVoc/UEiJzroPLR/Y6i01Xi5WS6TVpE9lTZyfdiXRqJ4wg7S1MUU+7o+XMhZsfbHKWkpBGoE2e0IoT6rbLHWpnHwNSLo3dnkkn7OkCS167tki7cTlK+bJKXzZrDkOyBxMBTddXKsw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 07:47:47.2496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d128587-8f85-4562-1e5c-08d63a4e2835
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the noise, peter's email I had does not exist, so I'm resending 
this email with the correct address)

On Sunday, October 21, 2018 4:39:07 PM CEST Peter Korsgaard wrote:
> On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
> > This driver assumes that an interrupt line is always available for
> > the I2C master. This is not always the case and this patch adds support
> > for a polling version based on workqueue.
>
> It probably makes sense to make it the switch between irq/irqless mode
> dynamic to support the upcoming master_xfer_irqless logic.
>
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> >
> > drivers/i2c/busses/i2c-ocores.c | 94
> > ++++++++++++++++++++++++++++++++++------- 1 file changed, 79
> > insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c index 274d6eb22a2c..0dad1a512ef5 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -13,6 +13,7 @@
> >
> > */
> >
> > #include <linux/clk.h>
> >
> > +#include <linux/delay.h>
> >
> > #include <linux/err.h>
> > #include <linux/kernel.h>
> > #include <linux/module.h>
> >
> > @@ -26,14 +27,19 @@
> >
> > #include <linux/io.h>
> > #include <linux/log2.h>
> > #include <linux/spinlock.h>
> >
> > +#include <linux/workqueue.h>
> > +
> > +#define OCORES_FLAG_POLL BIT(0)
> >
> > struct ocores_i2c {
> >
> > void __iomem *base;
> > u32 reg_shift;
> > u32 reg_io_width;
> >
> > +       unsigned long flags;
> >
> > wait_queue_head_t wait;
> > struct i2c_adapter adap;
> > struct i2c_msg *msg;
> >
> > +       struct work_struct xfer_work;
> >
> > int pos;
> > int nmsgs;
> > int state; /* see STATE_ */
> >
> > @@ -166,8 +172,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8
> > stat)> 
> > oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> > return;
> >
> > }
> >
> > -       } else
> > +       } else {
> >
> > msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
> >
> > +       }
>
> This looks unrelated to $SUBJECT.

Do you prefer a different patch just for styling?

>
> > /* end of msg? */
> > if (i2c->pos == msg->len) {
> >
> > @@ -232,6 +239,50 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
> >
> > return IRQ_HANDLED;
> >
> > }
> >
> > +
> > +/**
> > + * It waits until is possible to process some data
>
> Please don't use "It waits ..", but rather "wait until ..". Same for
> the other function comments.

ok

> > + * @i2c: ocores I2C device instance
> > + *
> > + * This is used when the device is in polling mode (interrupts disabled).
> > + * It sleeps for the time necessary to send 8bits (one transfer over
> > + * the I2C bus), then it permanently ping the ip-core until is possible
> > + * to process data. The idea is that we sleep for most of the time at the
> > + * beginning because we are sure that the ip-core is not ready yet.
> > + */
> > +static void ocores_poll_wait(struct ocores_i2c *i2c)
> > +{
> > +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits */
> > +       u8 loop_on;
> > +
> > +       usleep_range(sleep_min, sleep_min + 10);
>
> Where does this 10 come from?

It's true, it's just a random number. It can be zero as well, and we ask the 
system to just sleep for that amount of time. 

(1) usleep_range(sleep_min, sleep_min);

I noticed that it is a common practice to just put numbers that sounds 
correct, indeed there are many random numbers (not commented at least, so they 
are random numbers for the reader) in drivers/i2c/busses when they use this 
function.

This magic number can be also something like:
 
(2) usleep_range(sleep_min, sleep_min * 1.10);

to give a 10% (again random choice) extra margin before starting to actively 
poll.

But I agree that random numbers are not good. So I'm ok with option (1). I did 
not try it, but I think is fine to give a zero delta (delta=max-min=0).

>
> > +       if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR)
> > +               loop_on = OCI2C_STAT_BUSY;
> > +       else
> > +               loop_on = OCI2C_STAT_TIP;
> > +       while (oc_getreg(i2c, OCI2C_STATUS) & loop_on)
> > +               ;
>
> How would an I2C transmission timeout be handled here?

There is the assumption that the hardware is alive and what we read from 
oc_getreg() is correct. With this assumption, when there is a timeout this 
will happen:
1. STOP command (previous patch)
2. both TIP and BUSY will become zero at some point and we get out from the 
loop

I can see now that there are cases when it may loop forever: for example if 
the device is broken and it does answer always with 0xFFFF: we should not 
break the host as well 

I can fix this.
 
> > +}
> > +
> > +
> > +/**
> > + * It implements the polling logic
> > + * @work: work instance descriptor
> > + *
> > + * Here we try to re-use as much as possible from the IRQ logic
> > + */
> > +static void ocores_work(struct work_struct *work)
> > +{
> > +       struct ocores_i2c *i2c = container_of(work,
> > +                                             struct ocores_i2c,
> > xfer_work); +       irqreturn_t ret;
> > +
> > +       do {
> > +               ocores_poll_wait(i2c);
> > +               ret = ocores_isr(-1, i2c);
> > +       } while (ret != IRQ_NONE);
>
> Might as well drop the negation, E.G. while (ret == IRQ_HANDLED);

ok

> > +}
> > +
> >
> > static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > int num) {
> >
> > struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> >
> > @@ -245,6 +296,9 @@ static int ocores_xfer(struct i2c_adapter *adap,
> > struct i2c_msg *msgs, int num)> 
> > oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
> > oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> >
> > +       if (i2c->flags & OCORES_FLAG_POLL)
> > +               schedule_work(&i2c->xfer_work);
> > +
> >
> > if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
> >
> > (i2c->state == STATE_DONE), HZ)) {
> >
> > return (i2c->state == STATE_DONE) ? num : -EIO;
> >
> > @@ -264,7 +318,8 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)> 
> > u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> >
> > /* make sure the device is disabled */
> >
> > -       oc_setreg(i2c, OCI2C_CONTROL, ctrl &
> > ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +       ctrl &= ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN);
> > +       oc_setreg(i2c, OCI2C_CONTROL, ctrl);
>
> This looks unrelated to $SUBJECT
>
>
> > prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
> > prescale = clamp(prescale, 0, 0xffff);
> >
> > @@ -277,12 +332,16 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)> 
> > return -EINVAL;
> >
> > }
> >
> > +
>
> Here as well.
>
>
> > @@ -538,6 +600,8 @@ static int ocores_i2c_remove(struct platform_device
> > *pdev)> 
> > {
> >
> > struct ocores_i2c *i2c = platform_get_drvdata(pdev);
> >
> > +       flush_scheduled_work();
> > +
>
> Why not cancel_work_sync(&i2c->xfer_work)?

you are right!





