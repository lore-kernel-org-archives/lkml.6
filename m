Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4066FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D1C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Ydjv38M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D1C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJYQO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:14:29 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:14045
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbeJYQO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToKa62wY4qL+lZ0lUED3jO6vw7AYK+/jzt3E1+7JBN0=;
 b=Ydjv38M5/gHKKX/G4BuWp1cBfH5ZZgz+sd6Uj4G6yIIRtc2qOO56+PxtI861ldL1qIGCRAQEUzqYazwORMS6LiuCJuCGpszgfWu2TCy20DXr8IQIbgpn8CDyTtGCDiIQc7ToiJiM5CfPxQ9YCg00/9wRabQiu43PL8W+FGhwR+I=
Received: from VI1PR06CA0155.eurprd06.prod.outlook.com (2603:10a6:803:a0::48)
 by VI1PR0602MB3533.eurprd06.prod.outlook.com (2603:10a6:803:a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18; Thu, 25 Oct
 2018 07:42:51 +0000
Received: from HE1EUR02FT035.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::206) by VI1PR06CA0155.outlook.office365.com
 (2603:10a6:803:a0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 07:42:51 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=temperror action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT035.mail.protection.outlook.com (10.152.10.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.13 via Frontend Transport; Thu, 25 Oct 2018 07:42:50 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct
 2018 09:42:21 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Thu, 25 Oct 2018 09:42:21 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>
Reply-To: <federico.vaga@cern.ch>
CC:     linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] i2c:ocores: stop transfer on timeout
Date:   Thu, 25 Oct 2018 09:42:21 +0200
Message-ID: <2970900.LV2nBjgqHh@pcbe13614>
In-Reply-To: <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-2-federico.vaga@cern.ch> <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(438002)(189003)(199004)(5660300001)(6916009)(74482002)(3450700001)(575784001)(86362001)(486006)(47776003)(63370400001)(336012)(11346002)(426003)(126002)(186003)(476003)(44832011)(76176011)(43066004)(106466001)(97756001)(316002)(7736002)(305945005)(9576002)(7636002)(33896004)(246002)(8936002)(26005)(8676002)(106002)(50466002)(478600001)(54906003)(16526019)(33716001)(53546011)(356004)(446003)(9686003)(4326008)(786003)(230700001)(14444005)(229853002)(46406003)(6246003)(6116002)(2906002)(23726003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3533;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7e0e845-46d5-456f-a911-08d63a4d773a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3533;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3533:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3533;20:N/VKGENAe+w/OPCiMnVjHsIr4yWSxRNxktOSRQGll3sPyG9yAMN3MRNVKmHcyLuxfBz1J1rta/e+JjTTkkpwmObtdmZDm5wPmSbuC5hVL6wqjaQTDso2bOOWRhNw3r94sqEJHAhSjBPi7VdQ6yyf9fPdVaHfHlcm96ZUZPEFe+Sun/SjiHuCvSxyfhhhbcvEBkSKFhkCAYhScxNliOI1fqavi1dqaHgDbIkV+0YMHZPTiD6yFpLJ1O3PZLyvA+nwlq33n3B4eG9XHzJxJVYiJSQZh3HCELwkJ+/j9cZNYQeXiA2inNbz/xtaHfZSatgBWzZQWxhURQAKeYRRkeav+RtAfoC+Koi3LJjhwlAzLTxNyxkg327WO4BT+uLFgiWIEw8SaoK8HkSXUYPSjlS3THduQJO8gD0j7eFtI00nFlFp2Nh/X2KrLoV2tJ9/9xRVgTwGReynQ14EJ3yP4e3jy4elbWjfngWol29Iijhka7z5VHkBAYjijCRYZgX7zZsB;4:YI6c8+SquYel0eJ32FyUtxrjOgY1DDz25d5wg1LWc2VZfhtN6/3/edNGHsMk+D+qyQxN01w1HhdjWER7+46VbVly6+X6DCNyky4Jc72xxN9aHsu2fdoiJDbp85RdJNjPKEctvPgRISdJ2+1Bzus1yv3IhD0Z+JncuTlU01qESjfGfd/pigQrRWOm9WngnSKnslcbpkSN08ehkRTNJ/nBQNSM0mcm1Zhbm2uA3q4i+kruZFc6vtYOkFfyMCKBYNNffhuVKQxuxKEXw367XAGdaw==
X-Microsoft-Antispam-PRVS: <VI1PR0602MB35337A222BDB67A31A25372EEFF70@VI1PR0602MB3533.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0602MB3533;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0602MB3533;
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0602MB3533;23:L8kaEHbhGgEyFjN2AZFYKuBF6jLWwjgzNU927Cj?=
 =?us-ascii?Q?8EPDn8CHwOwJy+DOvMyUePRAA8sQ23UDBbE0pJhQcaH7hmYhR8ZT7FKsghod?=
 =?us-ascii?Q?apU89RI+Dx2/Q9seliCwhfsTpNP/SAEnl1c8wTwGGC/DTyMFClM3aSPceP2o?=
 =?us-ascii?Q?c7bcFAxdYE6CJwpsfhiYJUyt+oCgshiNgrIi5Z6H1rByoO5YL85vKCJb9lxR?=
 =?us-ascii?Q?Y7dvH4yRExecklIAV/75QZ9h3q1c/Yyaftu0BLbLf4scdVdXtGQpInphNvN+?=
 =?us-ascii?Q?u8rDFlhgzHX68rVvxo4KVKh/1WQt8Qdl73TCzrZcy4xZ0Gzh1nWhsTqzxqJr?=
 =?us-ascii?Q?It2n0gcUUpt/kCQSNcgFzAraW7NlbkGu0d3JOV8kuhBSQI64l7r6/ndiaSd8?=
 =?us-ascii?Q?UA3xq4r+TtABO57fi++8oP5TA2k0RaAoaEK/GWXqSB5pwyp8N1a0CZSRNA2Y?=
 =?us-ascii?Q?W9gvIXk2kD+FNy5IE5aNbBKRGd7MTrxsKEPfApqe42w5bBOlNMBj3iWzmg1b?=
 =?us-ascii?Q?ea0GF7xFw0GHvAsaNn92VdEEqnKxf/TP/ubKIWbjqnD0cpJ48KtpUN8S6OH9?=
 =?us-ascii?Q?R/fwdq2dMsX9+pghcNvQW0kRr6XrvpHTO7Z4OVRnJlQxEGTbnutE7O1so/Wn?=
 =?us-ascii?Q?pyMoIC/9HtiAcsS9GJ6lAL3uyWMQ0+UcMefoHm7ulxr6+iHg4er0vZTSDeit?=
 =?us-ascii?Q?WKz5yK4EUeOOAD4lHCQxRqaPczL2LpBSzLmK+Wz2vLVs2IuwDxxpxx7TrOAK?=
 =?us-ascii?Q?W+T+cGnzrSjSCNa7nV8L3vTF503FqomQtRB0xoFeZK9N0Bkt5CEPfSn7mawz?=
 =?us-ascii?Q?SYYt1ld80g0pHeKXEU2S0GL4KYq2Hh35cun41KUfBO9CmjIAefG0FCiXHarC?=
 =?us-ascii?Q?ubxhTlO7Eu7hQE5lDCAuq0LVVv43NDoo26Z9ZvYiHPRW34AEsF0eWHdr6o7j?=
 =?us-ascii?Q?Gm98nxcAVFYfqWCljORbKrpv3WAU21NYrxrxwWqZxAcEV8S8mX4MDRrJbf93?=
 =?us-ascii?Q?FhV8I0rBUGaA8hnZmasmLTTVs/iM3fIDusj8yeKBYanhUs77LnIxQGLsQsxL?=
 =?us-ascii?Q?1wO+mVfN3ipuc2MCLC9kjH8OylLlQHA59/YXkpZv2pvNaMx+2ycMW9Q99bO+?=
 =?us-ascii?Q?m2A0z264OmgVSXq6ezBUeGPVC37HlGSeX2SIYScB0jxG3OkkA+8mEyeqDMbb?=
 =?us-ascii?Q?/7ZRm6WGWuY3tmuTaiDjkZ3Cuc39d5z/dvapLC3m6U+h5Oo/kvctf0XZdb8C?=
 =?us-ascii?Q?34EoonWUWYPeGPANo5P7qFOdFpV6RX7LmHw1nZ+0/5PwkL1mcUfVa/hs0+bA?=
 =?us-ascii?Q?pZigx/qCxcv+GWgiLz/WphDc=3D?=
X-Microsoft-Antispam-Message-Info: eoe6yOYrUeeTK/UO9oqSQYKJY7ETdwNe/MBAg66ziJxqiBhcGEOphnQ4AUjM8xYFIQJbAC5++zAlZwOK0h8O1V6vieT02h5vhJnkYS/cqkDx12oJ7aardYvtZvFnl4GveCJ25E9+1WjIuds32L3AP3mUVYg9U6QL7fq7qRHc7hLtYbkgBNJozbWXAilLYMEp83sS8ZmsL8+6e2Eo0J6uCUwbSZFHHraByOF8Qfc+LbXTXcCawrr5wdiEWJ4IicGRvVVYBCZLmDd8epHhRNCqPbms8A55oVatkF9wZhmHnHJlyo6Sg52k/EbWnSRDips+ViDNKoMoOrPNuuC6LJMaCBAvmkywsshS3Q6A5b1nhhI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3533;6:4uAW94ZTG2X6W2J2QCpANPJvfPjw1RxFdvY7RwNnrhyIQngA6HAEb+vQiRTqw+gA0HtgL6tQGQMhcgCpYTIlfbk39zh0IUydCi7hcR02Yag5t8aiUS0CvINGHZhnVaATunhedYqQ+oPhvszy099JQgCximkKVW7OgQ8NxfgPH0kABbdEf1qirBjUlaCwl7N9N1hVAUxy+3XASvx2dSbDvk7B7pt6qXAgD6W2qSRhDucnMf1UORTyyqNVeUlLa8JtHPkBCzUBBIeF7L632iMLD5oWit9EI3hmWZyf7+BSgqD2/4gH31LdBTCR4TyMCOQOrBQN7n7c0mae3isMTjBCfzt59zOpxfz5Dh4/F7upYzDGNqpn58OXPl7SCmcpD1Qr37ppOgKiG7X8ot9e0tTeLa2LDnxBFifg9feUaI6zD1KQDbd/1mrwXLxrAVqml7Y+E6KiYAY9Oqr9yiBNHDsFDg==;5:D0vLPgjAv+FJrQ1Ffkgbu2Mlo3GQjj02wD+79SlAzJTaJ2BKFa6WaVGcEmkSEayAKC2Ey0/RJtfZtGnlTZaJ5KcMqNgQzhnkL4xOgG29CuNuRUB8dg85LPbi4QP4rHH2f+S5vFS+61i6J5zK5TiFonmql81+3Za8y66cnHIsGK0=;7:IDAXg6UnPE2w5GeDJZ0zE1bQyEJHWsExNZX0qxVVsGo/TORliM6ztDPSeu6zIfE7XBxFlC/6bGgoazhytC7a/QeyOcfPdo/5/YWgRI7F1ENBl86dAvlXYb3wB0PTgYhlfDlXHrtxvBZX9mAUUtJMrw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 07:42:50.3760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e0e845-46d5-456f-a911-08d63a4d773a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the noise, peter's email I had does not exist, so I'm resending 
this email with the correct address)

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



