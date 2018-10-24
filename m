Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C94C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C5620831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="WIdDCtwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C5620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeJXSTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:19:13 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:29328
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeJXSTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5rkrj314yCIOrbn06gk9tbkUC+Q4Z1X5cNO6zXX9co=;
 b=WIdDCtwaL296EB+/1cRVI6DrZTp17SuXg/29uGbeKL1ZHoXHPQ3CW1Jafeaf+wW0YUU0jkaiQLZBh7JzQ60sTplGg3vKYWgtr/18UGRDBfoB7KL+VQP1qX1QAle8lDNtdad0Hlav7WYpJGV4K/qT93oe+k0HAR045aOO88NTe3o=
Received: from AM0PR06CA0063.eurprd06.prod.outlook.com (2603:10a6:208:aa::40)
 by DBXPR06MB525.eurprd06.prod.outlook.com (2a01:111:e400:941e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.29; Wed, 24 Oct
 2018 09:51:42 +0000
Received: from HE1EUR02FT022.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::208) by AM0PR06CA0063.outlook.office365.com
 (2603:10a6:208:aa::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.29 via Frontend
 Transport; Wed, 24 Oct 2018 09:51:42 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; sunsite.dk; dkim=none (message not signed)
 header.d=none;sunsite.dk; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT022.mail.protection.outlook.com (10.152.10.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.13 via Frontend Transport; Wed, 24 Oct 2018 09:51:41 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 24 Oct
 2018 11:51:21 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Wed, 24 Oct 2018 11:51:21 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <jacmet@sunsite.dk>
Reply-To: <federico.vaga@cern.ch>
CC:     linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date:   Wed, 24 Oct 2018 11:51:19 +0200
Message-ID: <4222986.LvGMQbjSbS@pcbe13614>
In-Reply-To: <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-4-federico.vaga@cern.ch> <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(6246003)(6116002)(23726003)(478600001)(9686003)(5660300001)(53546011)(33896004)(316002)(786003)(76176011)(356004)(43066004)(106002)(106466001)(50466002)(47776003)(3450700001)(33716001)(54906003)(26005)(186003)(6916009)(46406003)(336012)(14444005)(8936002)(16526019)(305945005)(229853002)(9576002)(8676002)(74482002)(7736002)(7636002)(86362001)(246002)(44832011)(2906002)(476003)(486006)(126002)(11346002)(97756001)(426003)(4326008)(230700001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR06MB525;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea23973-6638-4056-f71f-08d639964cd0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DBXPR06MB525;
X-MS-TrafficTypeDiagnostic: DBXPR06MB525:
X-Microsoft-Exchange-Diagnostics: 1;DBXPR06MB525;20:vJasZd3VZulRvG835ix+JA3wSKVQGIvyurO2pUkIGslE+jLmHaWbeBW2KfqFQMCD+J1iOQyL4+XEeLc/kRG+ky3METp0xtTJOvj7lMM7f09mV9OFm1eRPYE41cODC24OZqtxV6jQzUXduKF1QMGw65ipBTVhaUZ6tXIg2n6R5G0MO1xua+hvvWbeMzZMle7YGD5JmcJzR0z1CN8lqvP06/w5DKSTtjzvjkTtQhxTOIQX2NUCfkRRiKEdspom48zLesLJZVB4U5qqV72d6NB1mDDTN2oTVN6dbfLkfC2QpV+5pgjGBoI1YpPQR0KArGrK+RyHvVUT98+XSC+3vCf89B9qfQyYLofJVzqkR6e1r+8Kgt6yX14NkhmQ5hnwPMmcRlp2/+hs7lx1KaN6JDAr+v1HXShgbj1ZJ3zFRv90y+JkKKCMglIQ31BQUr7kelJamL6ocCkUObGz9YYzVXyqydp6KqwpeYH7EzfYDKofQWiR7NNeYJibR4BRfBg2QZkx;4:fPQpQztXu6gc4DSOArspVPdcUNdJDNf3wjTSzEwCxPD3J5K3761p9zUIsEkMi8pDsvx7X5LovaxtDTswiqVq9AflTaSqfKeuibjn1lg1A0WZTApNfScGvy1uaIm0kn9zxtmxnRA7V7LgvIMCAKvGpnqgKRClY6fNWEP2vHdnITNXKJFeXNRYqblF3FHW1JqQIzaKcEimkdEiv6D4QFcMtVZyNDHRedI4gEAMBB8Pbj8Ji1B8D5gkMttRsHDAs3zmOMpVX+da0CONuWiFJlFT2w==
X-Microsoft-Antispam-PRVS: <DBXPR06MB525A832F863458EDB93A343EFF60@DBXPR06MB525.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DBXPR06MB525;BCL:0;PCL:0;RULEID:;SRVR:DBXPR06MB525;
X-Forefront-PRVS: 083526BF8A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DBXPR06MB525;23:8QQjJai2oY2SCeGUn254QnU9qZVYGbtP9p6GKJ4bPU?=
 =?us-ascii?Q?KFdsktP1R0tAFCmo86ZxpEUuOK/Dfn7h8poxt41BsBn/QGVblKXHyDOCaxiq?=
 =?us-ascii?Q?mDXVmlpPn/qI0LBxEbg8qKHD1ghQlFKJzCfIwMKt6GTO8x/Q/EMBMuJ3rYlx?=
 =?us-ascii?Q?4bVG9jEI1SJYCZlrLotJ2NWylkqErIr50qiwWk7Ro1B4ZlvPv2AMHROOAYLC?=
 =?us-ascii?Q?bU2GmdGPmVdvx4dPXTQpvcbSwE2NqHMV0Ds4OgJ0KAjLIeYkx5MOpFHezSFM?=
 =?us-ascii?Q?e+2YKLX2JbxO/3t/qTI3enLkSwKo+Lt4H8iG4c+VRPDNY86hwUxZEx9WYnxp?=
 =?us-ascii?Q?LpE6eGd0HvWCT2AZdcR1KVzkdupGsIrlCAdNQUpzAk9MwtgEAbNrPA93Buap?=
 =?us-ascii?Q?b7VzcT6zVhSco2fkweNQcxjtagskCY1JliPRn5ZSpQSbumhyEfLkgqITAjmg?=
 =?us-ascii?Q?9/NezDaZb7bJqYejPL2I7OZ1DJy9u7FVV9e6sC23kaf4V9p2syGNnzj+Y4hK?=
 =?us-ascii?Q?YxvwLeh2mSVxHcoehZka765yjGzEUw1zgwnLe2kAgJZH5S/LnEZUlfaGzLAw?=
 =?us-ascii?Q?1pg2+uDLqTsmW+i+wq+33MpQqfXkDrzg+BBcItdRysjmxhNxeA+GJVbGkKr1?=
 =?us-ascii?Q?NzrnizK4cHLORDxfF1apbEzxPMtmNFYeOtOxXE12msl1M4HAn0/aAB4Mb0Fk?=
 =?us-ascii?Q?e1lulk4HSkuuMVZWx50uU90gq6ciPAjb6aPG5PpOQH+cmya3lHuxm+Avdxtx?=
 =?us-ascii?Q?QhqRzsQR7Okywvb7yK1Ks83ksNplCIGKF5KulKst0zD/d7zpfHAg2AnLB8SM?=
 =?us-ascii?Q?dp9nT+k2MVkNlBidwRpbesncqW9/G6qVihMJ4GhjUWF0dccoLe+hXsyeVL+W?=
 =?us-ascii?Q?7SkK9CokbwFaHZEphD+puefgoSbJKqyep8JKotIAliSr0ywZAimkawJfad9b?=
 =?us-ascii?Q?mgQa+SQ9JYwf+QfmopjJa1EQHxmjRLmrNodqiTs2a9Ip6FC2TbuwCS11kzFa?=
 =?us-ascii?Q?JjBEewPElLz289j4d8qKJzzIRoQfYQkVeOZ9zLCiOkGnH4IL5b8MFbCc7rWU?=
 =?us-ascii?Q?jmUzJQsAnvq7Mq2MFalW1HREoooEEYusx1AUB8dd9xWfYbCCJqOFXuweJ7D1?=
 =?us-ascii?Q?XlPgydmjbNB4eFz5ZNa8ZjK8wENNp9zwl6WP2HpBO42KLDWpTHGk32d3c/Sk?=
 =?us-ascii?Q?AEU7aQkbYQk3Ptr73Ifx2L8flTRy+Zla5UukUjEeTSeCU13w84SrYNag=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Ad7okpt1HedaFt8Q/TYHU91c30q/DXRmcxAPnQx89S5v1zJoqPNiXne+2ty+Zzzxtq/Itojo62NKgZyvSqUj4kgjSCBIZViMr4G/Hohi/Y8Qla2hAoQXQfDR0OXfaBmEl8cC5EgHlOHGPtnAkITFnADEGMbyr0yU4Eb0moRp/LGJLBeDUcOEQycKmMOWWTJ3KmTdBq9Rhh2h8h/mDUnQrKifbKGXl9LBWcbLI8tfVOojg9Xl3HhoYfm1cI5gSC1YILVv/DBk92aX6mgYoe9vxWavZ4F1zslWcZkfvN2RPxiXKyBf4gFAVFA3QiaFXjHow1DsXjjdR497eD3VDwTcE479Mn10mvjTkG/UfOAEo1o=
X-Microsoft-Exchange-Diagnostics: 1;DBXPR06MB525;6:EDD5lh1UXL4FsY6D6gbZzDpBwGtSF0s10N8on43F9uJFSkWLdJVr1hslouKozdrK+Bycv+ShDfye79h6cZ2vmMKzuC2zEf35O3B40tbh0but0ve+/UdeQFYIESJ+GZY0+KE9Vj9rSHWtGdajQY6taOWpLCtl9uHdbUicsgvJ/cS95KDEUMIliWacAtbymHEq01mJ8mr7W4bBU6Hv8FVsBZTIcAgwzkMfphBIUqje3iXE8AmYVt4FLGDgcAgqYSidIK3COnX3n7dG4fxVaWnMkiFnrb5CZlOPHlSxHdJgvmBXfCG9SuRj89SZr1TbjlkFcr9ZH6IlyivUGjEtNOplAiQc3Gv3i4f0Y1yJZSvJxaajzr1GmFzGZwzDgwZot3sdTYAbDzcPdJVKwS37ny0mXzRX/IRgQF4OZT9Dd2/Cy/txtZ0U6JczxpLFHPWCDKXfW3IHbviRhgbKZlJu1Kl7MQ==;5:tfLbEKpAbU9DJd3C9pUf93mtw8Ckr+PJpLPGn+o0mbnucNHZnXhbbAJgNLllGJRr5PRzSSaa3w8CE5m9jP4qthIW3VjrTt2I7O+KLNRpmIt/blrCQNZdU7ZeB6nVRruOWgISw7MR50CULotbnZcp1A4vGQVtv6+6YxZcAQTJmmg=;7:bZz82mJMCq8FTd7/z/NWv19lsjHFBApr7CVUfk0xOBGhkCH3WwvGikRZkuylAguQ5nAGaAG0gHykST2c5DaTwDhhMZL0s5rOKODrXFrr24uRd4/k7aowBz1Vud+secxS2qCbrsa5KOB8/fvX0vgIpO1HfCjYb/vwOPqBDqJrbXG1gm9PJTaVjotLHiGlriSEobrOMRQcMYVtCpY8IqUaKFr2zSiOzSDWUnjweOR8oWHdwvQr2Dvpye557bBAqk7D
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2018 09:51:41.3175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea23973-6638-4056-f71f-08d639964cd0
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR06MB525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> >  drivers/i2c/busses/i2c-ocores.c | 94
> >  ++++++++++++++++++++++++++++++++++------- 1 file changed, 79
> >  insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c index 274d6eb22a2c..0dad1a512ef5 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -13,6 +13,7 @@
> > 
> >   */
> >  
> >  #include <linux/clk.h>
> > 
> > +#include <linux/delay.h>
> > 
> >  #include <linux/err.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > 
> > @@ -26,14 +27,19 @@
> > 
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> >  #include <linux/spinlock.h>
> > 
> > +#include <linux/workqueue.h>
> > +
> > +#define OCORES_FLAG_POLL BIT(0)
> > 
> >  struct ocores_i2c {
> >  
> >         void __iomem *base;
> >         u32 reg_shift;
> >         u32 reg_io_width;
> > 
> > +       unsigned long flags;
> > 
> >         wait_queue_head_t wait;
> >         struct i2c_adapter adap;
> >         struct i2c_msg *msg;
> > 
> > +       struct work_struct xfer_work;
> > 
> >         int pos;
> >         int nmsgs;
> >         int state; /* see STATE_ */
> > 
> > @@ -166,8 +172,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8
> > stat)> 
> >                         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> >                         return;
> >                 
> >                 }
> > 
> > -       } else
> > +       } else {
> > 
> >                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
> > 
> > +       }
> 
> This looks unrelated to $SUBJECT.

Do you prefer a different patch just for styling?

> 
> >         /* end of msg? */
> >         if (i2c->pos == msg->len) {
> > 
> > @@ -232,6 +239,50 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
> > 
> >         return IRQ_HANDLED;
> >  
> >  }
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
break the host as well :)

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
> >  static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >  int num) {
> >  
> >         struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> > 
> > @@ -245,6 +296,9 @@ static int ocores_xfer(struct i2c_adapter *adap,
> > struct i2c_msg *msgs, int num)> 
> >         oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
> >         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> > 
> > +       if (i2c->flags & OCORES_FLAG_POLL)
> > +               schedule_work(&i2c->xfer_work);
> > +
> > 
> >         if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
> >         
> >                                (i2c->state == STATE_DONE), HZ)) {
> >                 
> >                 return (i2c->state == STATE_DONE) ? num : -EIO;
> > 
> > @@ -264,7 +318,8 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)> 
> >         u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> >         
> >         /* make sure the device is disabled */
> > 
> > -       oc_setreg(i2c, OCI2C_CONTROL, ctrl &
> > ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +       ctrl &= ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN);
> > +       oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> 
> This looks unrelated to $SUBJECT
>
> 
> >         prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
> >         prescale = clamp(prescale, 0, 0xffff);
> > 
> > @@ -277,12 +332,16 @@ static int ocores_init(struct device *dev, struct
> > ocores_i2c *i2c)> 
> >                 return -EINVAL;
> >         
> >         }
> > 
> > +
> 
> Here as well.
>
> 
> > @@ -538,6 +600,8 @@ static int ocores_i2c_remove(struct platform_device
> > *pdev)> 
> >  {
> >  
> >         struct ocores_i2c *i2c = platform_get_drvdata(pdev);
> > 
> > +       flush_scheduled_work();
> > +
> 
> Why not cancel_work_sync(&i2c->xfer_work)?

you are right!




