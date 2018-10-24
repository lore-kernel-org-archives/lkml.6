Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6362082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="pZRcD3sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6362082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJXXTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:19:37 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:55744
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbeJXXTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLLI12od2LTd5wqa0hL5JJiA5+ybIpzyyTZfY5WlOsU=;
 b=pZRcD3swGLP44pQ5gVNHyeB1wOsl4vwSTS0uGQzT/wNvdFC2BurZL0G0TahJD2cPHxYp4uvwmwL6my2aehLzuwJ7Dgrffik2GjY0QIR76l5NX77LhiIZM8wV7JGmNKBHXnCpFfQURv3D/JnoX3Rd00BA4Dy5tVheQsJD27r5UwM=
Received: from AM5PR0601CA0041.eurprd06.prod.outlook.com
 (2603:10a6:203:68::27) by HE1PR06MB1627.eurprd06.prod.outlook.com
 (2a01:111:e400:59ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19; Wed, 24 Oct
 2018 14:51:08 +0000
Received: from VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::204) by AM5PR0601CA0041.outlook.office365.com
 (2603:10a6:203:68::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Wed, 24 Oct 2018 14:51:08 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; sunsite.dk; dkim=none (message not signed)
 header.d=none;sunsite.dk; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT056.mail.protection.outlook.com (10.152.13.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.13 via Frontend Transport; Wed, 24 Oct 2018 14:51:07 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 24 Oct
 2018 16:51:04 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Wed, 24 Oct 2018 16:51:03 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <jacmet@sunsite.dk>
Reply-To: <federico.vaga@cern.ch>
CC:     linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] i2c:ocores: stop transfer on timeout
Date:   Wed, 24 Oct 2018 16:51:04 +0200
Message-ID: <1549360.saVjYH78Bt@pcbe13614>
In-Reply-To: <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-2-federico.vaga@cern.ch> <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(476003)(11346002)(14444005)(2906002)(446003)(126002)(486006)(44832011)(336012)(74482002)(426003)(26005)(50466002)(6246003)(246002)(9686003)(575784001)(86362001)(6116002)(23726003)(7636002)(7736002)(305945005)(46406003)(8936002)(8676002)(229853002)(356004)(3450700001)(9576002)(106002)(786003)(316002)(53546011)(106466001)(97756001)(54906003)(33716001)(43066004)(478600001)(47776003)(16526019)(186003)(4326008)(6916009)(76176011)(5660300001)(230700001)(33896004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB1627;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 574aca2b-073d-45b4-63de-08d639c02188
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR06MB1627;
X-MS-TrafficTypeDiagnostic: HE1PR06MB1627:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB1627;20:2GYbZTOnR1S79L7iJ6diHHffVs+KvuCOXrDhAX9aWi9eXc1yFuGyzoFb4/tMyBoq76pooh+fM042rfstPKG1vOoCQ/iM1fi1/W5Vu2jERTFxjkE6KlpeGYVp916oelrvKLo80gIHkE5anzreK0S6gfjy8cFW9jt3GDqgVGrruqcwk+LCopy7H9gcU72iFC61UXO7WmTZwBCXsEHOUEkJ3wkMOi4Im19LTVm33/2c6HjDuD+DC+fV6RUHmCR2Nl4rRYaLv7yzLhnpJpxQbKK2ZGoAmVsNyITz6u1tGyqWmU4XrrvTVb9p+58pgtd4FjRVl3g2hH2FlfRGNO4MQZ2+48//ybPTrS9qSspuJjkXRDNdm26lwPEy50+vvOwN1+XiIna/maVfCp2Jq7Sxx9ojjPLXDTqdjt4BK4Fy69elPMSgwVBvLEkS05Al0foam4ZUSGu2k6kUaC1soDVlBpMxdu5C6plPbeh2vLKqZeOjmGJaPSUoDuwOqSYAJer4ULYN;4:DdEfF2Vm/i1dbRenyMn61kNAzjohvWi1EGjAKoC4IWaznn9rsT2HoBlOHgud8cwVi82y36RwA3chVuTl+3Gj3OHz01iEu5SvXzzYlWtLSGUpm0t1hc1NnD+oN4Dqqj9hNma7uGUoJk/vvwk9sUYv3PvBC+5sNTvJWHX+zzYpPHvjXzFS3fqeLfr1Mu2PY/6JOn0X7dcdmQCAOfUXQP+JTR7YTXds0bm94A78Q45xKjbZ8rMuMCG3POyaAwASnnVx3fxJX7PsxSyCeBFnm4xplA==
X-Microsoft-Antispam-PRVS: <HE1PR06MB1627AAC322A4970F8D6028EDEFF60@HE1PR06MB1627.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR06MB1627;BCL:0;PCL:0;RULEID:;SRVR:HE1PR06MB1627;
X-Forefront-PRVS: 083526BF8A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR06MB1627;23:G0XcdXEbPW74hVl06X0MAOojUBczHYpN6uvD6P372?=
 =?us-ascii?Q?ACXaN4miiWjGAhYy5Fb/RYOWTpvEVxnctVotUO8Acc+7o+vqShOwQJIsCbnT?=
 =?us-ascii?Q?VzAbcZTQuXBMogEuE77E9ulNgEEzFuBRyAStQQlpDln1FMDXpn5wAnd6jDzp?=
 =?us-ascii?Q?Z+FewvAt+iTSAas7iCGBBxQavLVX7sjxAOzNPcWvtrhai5Km4SEWg3hFQect?=
 =?us-ascii?Q?SbJgl1yteiolNA1Caw2jREb4Pt+95yOpQonJs8LnsXDfCjcG6UhdNYfl5l5V?=
 =?us-ascii?Q?fnCW6ED7E67AhSGc0o624pQRSsPg+OrHXoaeWzVWrXmfMKoORLk4Cw0esI4i?=
 =?us-ascii?Q?/Lr5A5O5lUkdFAJhit0ApKP3XOnb/zq/+1jsfMC5tT6pWBJQ32LrRG1K17zc?=
 =?us-ascii?Q?LAB66TsMiE7G8J/z0OYEfpqZDiMD9IcVXb1FK1KOOpbvVEypwVuTgC++QYlR?=
 =?us-ascii?Q?A2wMhdp83jj/E8iq2r8HP03ZVWTYJwYIawBCMU55WLZ4yR+ZHu8p19FkH1wJ?=
 =?us-ascii?Q?IbWCs0RwyQrvYjoNid8ewr82K9lmgIw8id7Es9yLY5OcAwMJCUO3KY8CpnE1?=
 =?us-ascii?Q?fO74DOa9zFdC/2omY5k3ksuNYWEOzNaPrBagN2lQuRD/z5akHHwiwlBstiUD?=
 =?us-ascii?Q?9yPqcF5LDRmvh7+SIey/3ZGklpbJQ34iUpDA+gv9zuGMn9OQdVFQosGl4gHY?=
 =?us-ascii?Q?76vcB+TMJkTxS9cQ9bzHQR9KDFy8AOMHV24dFxUuBtrtWS9G9nhCOmXy4b6B?=
 =?us-ascii?Q?mI46HRyS3sP/PLQBGyv38NDCB7EDzGbDh9fvaAXo3TyYczPOvo/ZIUwazj66?=
 =?us-ascii?Q?cgemNs7J9hOnf0QixUHfFFbOMTIkE06WKaSFiTKMdlFaHhxZj3F5xbmDwK6j?=
 =?us-ascii?Q?BEzhUdlYgWCBo2rxbOqkVfAfXWBEBYXDrAR13SumoqS8E7oAYIeHA6z7bMIL?=
 =?us-ascii?Q?vRgPNgNhLWEiFmr3NeKqi0V9LQ1ESdl7dKUstBd8C7SIKPYMm6zrwg8ggAd9?=
 =?us-ascii?Q?0GaGx8rThrvK6Nc2nR0/jRRq1bAwjHy16oMhVO1WBbonizbky8A0tqIscONz?=
 =?us-ascii?Q?CdFL+lEGqS0uQjEvzLddgP0gW2ikLJPrf/Gnv3hl+pfgJV/Gc2fLTR+9j82t?=
 =?us-ascii?Q?qdKpILRU9jtoXouUY05yUkzP4e8oUTZQsjSclx6MH5wLwk8rchFMvxVZNPrP?=
 =?us-ascii?Q?2IVuHEXTU7SwBa8CQKggfifxqvUTUFAz8eIMMRGnfBILid3M0E3rqCxJt4bF?=
 =?us-ascii?Q?C9qxQ+EIBFf2Q1hCs051FKqVwBdWm4z8Wo6wWUKtEHvP4hWRf8fDfinwWXWT?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: mjo8UlqsiSrlVCxw0IYJDVjhQwp9BJ/zHnvaQVsuaVJ3b6BdNpaDxGBPOuf2rSDpE3TA85xe9/Bov484CSOfYLXW7DxY5WZ8UXsumlLZRRfUPlYJaX5CM6mc76zO1SNCYk2C1TUUR00fZnmLtLAwvcVeuuYoFrty9wZu7BH8i7gQa9Cb8V1y5yH5stiYF1KPkYQQdCky1OugTqqxSLmU9N7DZsd6Q+ebVRalGXImv0Q4MDz54dymbsRVscI7+LHszBCLjqEaIpmGVD9JXci3T8CoPt4RND/cQ+G/kqBhlHg2G+m4ju2tsZKuQOVvimaiBvMyCmkXJnRP/wPM16B8VDdf3t9bJcybDZlHcq8Ky5Q=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB1627;6:DaSZIQr0eAnIeGKZVPUCYvM3l2Nwa9O7saLSddFeEwfxW0ahI40UmocKzWrZvGVz/cp5LmB8mPcALOj0cN017OeAnEAfOBy+ot2FaCkLSWeNAbv7xOU4e1plAjbMn2CR5wigGkOdCxKbYtZjHT4noqYLkNgA2vkuPAkUPUBQhXMhVjtpCYTXxW8ZgTSDSbqJiyr24a028QKKIZIzr0xEoyVCAhgCKZdFCIo034Ds4eaWctIoxK/IBiweRGoqsj70ijxZFSnPxDFBaTXlnUwfSKvdRQOGRUt60m3G7BGjR90P9tFdYxWqHfWCNGwUbvuEMzLqz7GiuO4A7mRe5IoLL8QeXp7Txg3rTPUce/OB5yq+0GIoERpc2SPLQboULFuYdrksx6LFtsiDdLr7semgDQkU/su5c8XY16R7MZTWY9GdmNNvW8R2b7EJDqnYXb680IIKDXianwk4JhJ7HJRsMQ==;5:epQE3dIbmdyDclXVTeUJFOvPz2I4t3ql6jqTTmr7Jqghqh120iN/hcUTK+OZI7bNQm2+wnCp5gt5LMt70HTdfJTu4UAOuCvJdEDOotPPkLdnSsjrrRcWS5D+zHm2YfT2vzfAIB/MUWRJadq0Nlcp6jSHutcc0WjT0yKhQ3uiunY=;7:kJfLkQT87t1EpBht7F1hix02eQQSE7OyI4H1WlrHhr2ngxivVS2nmOgaKn/TT5NbwWd5WHD7v1Kmn0T7aXMzB8Qc88ZkDNgFUl+ev1O5Hz319ptC9qOQAONixWHnTSQyYwxkbY0Xjn6ZwKLXH4L4Zw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2018 14:51:07.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574aca2b-073d-45b4-63de-08d639c02188
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB1627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 21, 2018 4:10:30 PM CEST Peter Korsgaard wrote:
> On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
> 
> Hi, and sorry for the slow response.
> 
> > Detecting a timeout is ok, but we also need to assert a STOP command on
> > the bus in order to prevent it from generating interrupts when there are
> > no on going transfers.
> > 
> > Example: very long transmission.
> > 
> > 1. ocores_xfer: START a transfer
> > 2. ocores_isr : handle byte by byte the transfer
> > 3. ocores_xfer: goes in timeout [[bugfix here]]
> > 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> > 5. I2C driver : it may clean up the i2c_msg memory
> > 6. ocores_isr : receives another interrupt (pending bytes to be
> > 
> >                 transferred) but the i2c_msg memory is invalid now
> > 
> > So, since the transfer was too long, we have to detect the timeout and
> > STOP the transfer.
> > 
> > Another point is that we have a critical region here. When handling the
> > timeout condition we may have a running IRQ handler. For this reason I
> > introduce a spinlock. In the IRQ handler we can just use trylock because
> > if the lock is taken is because we are in timeout, so there is no need to
> > process the IRQ.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c index 88444ef74943..98c0ef74882b 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -25,6 +25,7 @@
> > 
> >  #include <linux/slab.h>
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> > 
> > +#include <linux/spinlock.h>
> > 
> >  struct ocores_i2c {
> >  
> >         void __iomem *base;
> > 
> > @@ -36,6 +37,7 @@ struct ocores_i2c {
> > 
> >         int pos;
> >         int nmsgs;
> >         int state; /* see STATE_ */
> > 
> > +       spinlock_t xfer_lock;
> > 
> >         struct clk *clk;
> >         int ip_clock_khz;
> >         int bus_clock_khz;
> > 
> > @@ -207,15 +209,30 @@ static void ocores_process(struct ocores_i2c *i2c)
> > 
> >  static irqreturn_t ocores_isr(int irq, void *dev_id)
> >  {
> >  
> >         struct ocores_i2c *i2c = dev_id;
> > 
> > +       unsigned long flags;
> > +       int ret;
> > +
> > +       /*
> > +        * We need to protect i2c against a timeout event (see
> > ocores_xfer()) +        * If we cannot take this lock, it means that we
> > are already in +        * timeout, so it's pointless to handle this
> > interrupt because we +        * are going to abort the current transfer.
> > +        */
> > +       ret = spin_trylock_irqsave(&i2c->xfer_lock, flags);
> 
> This is very old code, so I might be missing something - But I still
> don't quite understand this trylock logic. If we end up here with the
> lock taken, then that must mean that we are on SMP system. We still
> need to ack the interrupt, so just spinning until the other CPU
> releases the lock seems more sensible?

I think you are right.

When I wrote that, I had the idea the STOP command stops the ongoing I2C 
transfer and clear IACK automatically (I do not remember why I had this idea 
in mind, unfortunately I did not take notes about this). So in that case, 
having done STOP on time out, makes IACK useless: that's why "try".

I had another look at the HDL code and apparently my assumption was wrong, and 
STOP just do stop, and IACK is still necessary.

So, yes, without try is better because we save an extra, useless, IRQ call



