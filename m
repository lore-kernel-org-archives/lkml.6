Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C82C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2770126427
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="PzRu8R/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2770126427
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeF0J0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:26:20 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:19519
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751953AbeF0J0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP4MQ+CfJiJDQBQwfMmhtc5Aq7pt7FHeBA3X/lUXJWo=;
 b=PzRu8R/xFYJ6EQ82yq6OMarDC68qhBZclgeHM7qTUrU1wLzn+X3WCRzHhiMODe5q/Dl2kWpW033UP1GqEQSs0VY4yjui8ShPXAO0v/xiPDk2w/FC4tAbQtNyAtAaOI6uPOcM94hylCotgap2CmcaRSmllfv59EfIUpvPoik5NSI=
Received: from DB6PR0601CA0032.eurprd06.prod.outlook.com (2603:10a6:4:17::18)
 by AM0PR0602MB3362.eurprd06.prod.outlook.com (2603:10a6:208:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Wed, 27 Jun
 2018 09:26:14 +0000
Received: from HE1EUR02FT023.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::206) by DB6PR0601CA0032.outlook.office365.com
 (2603:10a6:4:17::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Wed, 27 Jun 2018 09:26:14 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT023.mail.protection.outlook.com (10.152.10.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.906.15 via Frontend Transport; Wed, 27 Jun 2018 09:26:13 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 27 Jun
 2018 11:25:40 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Wed, 27 Jun 2018 11:25:42 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Date:   Wed, 27 Jun 2018 11:25:41 +0200
Message-ID: <1569671.PEFH9RgftX@pcbe13614>
In-Reply-To: <CANk1AXRFK8CYn_c7ckpJeXpFbc-CcZ+xzZiJzUsiDUUS7ancPA@mail.gmail.com>
References: <4617134.5euanDEBgJ@pcbe13614> <22840601.TEhG8FuRZq@pcbe13614> <CANk1AXRFK8CYn_c7ckpJeXpFbc-CcZ+xzZiJzUsiDUUS7ancPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(51444003)(76176011)(33896004)(8936002)(336012)(4326008)(186003)(16526019)(229853002)(26005)(478600001)(230700001)(53546011)(33716001)(7736002)(356003)(7636002)(3450700001)(246002)(106466001)(5660300001)(6116002)(6916009)(2906002)(8676002)(23726003)(9576002)(305945005)(47776003)(50466002)(426003)(106002)(43066004)(316002)(46406003)(44832011)(86362001)(786003)(126002)(6246003)(11346002)(476003)(446003)(54906003)(9686003)(97756001)(486006)(14444005)(74482002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0602MB3362;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx13.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c59f4a9-a805-4884-278b-08d5dc100709
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM0PR0602MB3362;
X-MS-TrafficTypeDiagnostic: AM0PR0602MB3362:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3362;20:f1D1VJ8WFWvd9HCFJpBPSM/cwks8p2QR9w8Uu78D6nqh5HGGcMg0aOIHnLtZGJsTdk75kpQ9g17JiU4xBc7tI0l0PZN6lpxlAKUfa570SELZ4RQ6g6h8a9Fm0wHjWn/lSTyZLAddBSIA99Zx2PjC8iMBcp4q7TqdIYOwfgcF/nx1eQKc0HxAdDyuL6aaorPOtpGe+Gon2nlt7R2TrV62m8ML/TSdb5DCXvrqXaA+ZPuEDIfMvSdnEJcLNuEa1+te8aPWfhRUiF5mx9VLwOGh7jwoPzQ8FNZeSiLJ1UygduJ6QXy8uLmYUy++XEWMITwd2P2hP0c0uLt+2137FuE4bgYSWqmIrSNo+/7n7mSZ12jqP48B/qMfIdEfN5nu3ANnIIEpx4log7B6MX2M08AsuY9ygBcPIOblwFK9lAgasURy5bybmecrQlnmmsXHGM3ATpXcPdJcQM5I9OCwTCpXcPQM5+yseD34wgFhofeGk13br39wxLu4sJhxM4uQkS+v;4:Zs4F/D5B+ta2Y2k8aYKpnHbX1le5CLccBV/YTmmSZp1Sy48lDdnir0zbGCMvwcI+GZrIXDB/ioJeCIluPquRFTlVDbOaafbTa2NzCyZtK2DNnJBjY9a7ja36bMptuYP8+uimXVqW5KxIoehGWE8oLbmW9warzSMNT4zATdmjEFxDGRCm4qRZkZxgb3+0xre3/yliZbK69RS1zTFiEzXLRHZT4sl8AReNIGx7y2cQ4p7R2BiniHDB+caXNahwtyJL318pZb5VcuCqs8BRGwj6rQ==
X-Microsoft-Antispam-PRVS: <AM0PR0602MB3362FC5594DB1DC27A5A83E7EF480@AM0PR0602MB3362.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR0602MB3362;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0602MB3362;
X-Forefront-PRVS: 0716E70AB6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0602MB3362;23:vXg7qytUDnjQ+KexXBv4vEGG/iV6iVnE5510rAo?=
 =?us-ascii?Q?a7v/5IQM44G5XmAX+1pWRR3QdFIpNMBsaIb3xEK2KlmiYaISVSs3qrnVQMil?=
 =?us-ascii?Q?UNMVAoSWzP1u5yLxkNl4LIgYLG7IiJnDqqhMxcmhGomcRew9/v9QHxVrDwzk?=
 =?us-ascii?Q?0+vBbL2Kk1QJC1H6T5CsSNpja3KAT3n73rJcdsifhxaID2DVdbdPvAU0GdXP?=
 =?us-ascii?Q?+Anpzqz2RXQ730T9MfCY16gXMNiB/tKcITf1E9XSn658d30J+kCR5amZz38+?=
 =?us-ascii?Q?jWiZAWFnsNycS2WeuVjb2qDlLPoXLax9c6gL+4jeR7qbDuCmveppEIYd3uha?=
 =?us-ascii?Q?mMUixxLeLw7ytac41CPylsYaQEEJppxMQlmNRutI+lEfsR0az72PJwmdruGp?=
 =?us-ascii?Q?N0BStW2naCwYBEUAd+YtBGfLfQtEK3dsN/HNcw0xbbHgYh9up5aNbfbxICE1?=
 =?us-ascii?Q?8pECBoK3bchNSK70IeAgpWANGQV3ZlGNZbzBFfgLmk7r2K4B8xWdE91Y+rbN?=
 =?us-ascii?Q?XOC/GX+BSaRj0LbV0+3XRt7BIkPNqUuFIFZX3izuOJu/OU5aWkPa/yeMYaMk?=
 =?us-ascii?Q?C+gGzl5wNcf/aHWT6vb5C8busa7Fqdo4eoA9rXbhL+IvLe9hykNJ/vKmofff?=
 =?us-ascii?Q?ndDIea3FB1110kbD8AtKfwXoYLM90lFjh/or0qCWooU6igNN5alV0OOuA5P1?=
 =?us-ascii?Q?YTmh7CN0zg8Tjrm6dWUH5U4eIGT/3zLhznrGDuitYgsuNlHn1SCpQdvZ+VSo?=
 =?us-ascii?Q?fiTQP5BacrZup544rGpmApxmfopPNUPYeN+DHHNmKOCK+aWvMBT5a2nmVS0d?=
 =?us-ascii?Q?f0Qqd1OVfdF23VFvyhxjQzGHKOH2lH+QAMO/7DruEty9UWWEH9gQniR6r2sI?=
 =?us-ascii?Q?08P3ssykyDVJG6afllBJi9TqYIbt0BCZKxsAVYxGakXhH/XT8GXK/AnEiAbA?=
 =?us-ascii?Q?ZD7ywYtxO5++LGKqNNQ8RVeFw8o0qP9v1sVAp3+Fpe8Lf3NvA38TN33H7pEP?=
 =?us-ascii?Q?sGJuW7u2/13oiFBukaM/2NpgVXR65isbPc1s9rhN/syZo6m1XwtfE1fGQ+Qi?=
 =?us-ascii?Q?1c8UI4T+TzvO+CV+jj6sTJA0RjMaYEtL0G1sRmJD5eO9Kxe60yYZBL3H4SfL?=
 =?us-ascii?Q?nRpm3DXGJ7hqKxHcIpMzdfShN/c5ibqeYcKy5kcFz/NpfdZQcJK1DlPTYxAV?=
 =?us-ascii?Q?Gf6oOVCx507NUk8Dd6xJMRP4gUyD68ueB0YYsmu+liGWoc2jtcMd8VDbaPbR?=
 =?us-ascii?Q?R+CXbeWLBRPlhpzFFHVvwoBljMHQ9czdHNV6CRSGpFWpBjzd0wp6oqKkW9s+?=
 =?us-ascii?Q?6lA=3D=3D?=
X-Microsoft-Antispam-Message-Info: FMesf3VvNqcVwg4aMK7J0Am99qQewpqRWJNEmXyy6XFYyAjIc9L81bkVy1speapadLjeZpgh2KVTE/fhsIesXPreDHPwjhzYhjWlbktfb+8uyqJqw1DyCHMNpuAPQMj7Je09wi8F0A1Qn8Fy6RWV10YO10U5oCgnF+C1ruI609UKGg2iIyxaHv8kGVUVUR2tmMW7ASpKbhYyVjVlrFM15bc1GhbigPW5YgVDnVk6zCO2KTczrOMg35A2Xfl3qi93s64nEtqXLrqOpXGIwCrvfEYRl71zWrH14Gqt88Uw+2V6F0yxNmvi0SNJzS+Oz2JWdzDwpg9SPxyNl1T5IgtA8zKRR7pMM9XKENxLltmxu9s=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3362;6:mK/ZWw2Ctk80em9ONBt07F7ibDL5uImO+OVLXXDK9KbzVhFiOhYEWT/SCNwi8nZZ4a5KN8O/zT564prsa+WL3EuZKA6JyqGJ7iYz+o5MVJ9gB7Z0uwlgRi1hXWlD0nLc/wZCLRJ2L+WPpcw4jAZQWI8R8JiXIHn97CcDkdQi5MY0YeSe8bYIrMrdreEPBwrJchVO0PNku5E88kOwjYn03vZzKesOy5UVxGeUR4Vw3tnZfz/Se5rfI880e7A0AD6eNBj6uElkQBlEU4N35rjx4m79nMAYASJlNRssZ206bF1TOJL6q5p7J8d3D3Sgsk5Kzbi2GprkIa+epfxfCuv9DD4uPh6hxDi6t0vrCbACzhKCn0EonSJjI8FnRqMSetRUqRsrYWHqU0s+WzNHpbnKJUASp/FOj5WhoynEzfPjws+KQAw1uwen7NF4Xsgg8Kl51mSx+sPCulZKaXHg6O5thQ==;5:LmuBsFJBFX8JmwAU4IuT0axvofyt51u37wUDC2z+VE8+3Lk1EzT8g6UIprr7cXikmRXwDDINZqdOVyF4q1WVXCBq0DEeuDv39PcghCcb31AsmSZ3FsNNKbUFOAqJHDbiseB6fNedp1y7sQKf4FZQCInfB9oh/DqjNL5L5OQwA4o=;24:3LwKthhv+rN9aqwo2yPSHjqRtTHTE7PPo8JaywP9zWVLgtTaYnVSeOlOKKWCTTwu0eji5P5rVcknliKxVIdZlteK6gGm+i08DWHz0UssT3M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3362;7:qmjvBCh0k3t7aBw4wEvp2aXMZM2gk9XIAtMDQJoMGh6+fj64DayS4KFvdUVXfLiKU51JtS3Nnp8f4dVAh5GS/9SxAwME4BethnTo+OX1upfY9+dKftvx9TGQ0Ym9e4XCycD6FdRjysUAntZI5rttxtj5GrAg0/Up7EAV6xn+ZZ3RNakSFIHtgvTK8LfW+XAab3BKSM/DoPqhGzWdzyUNCfpUk3dGu5FVKKk2UY6m/30QnRKkqd9E5yBAcbsO+eu8
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 09:26:13.5452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c59f4a9-a805-4884-278b-08d5dc100709
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3362
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
> <federico.vaga@cern.ch> wrote:
> 
> Hi Federico,
> 
> >> > What is buggy is the function fpga_mgr_get().
> >> > That patch has been done to allow multiple FPGA manager
> >> > instances
> >> > to be linked to the same device (PCI it says). But function
> >> > fpga_mgr_get() will return only the first found: what about the
> >> > others?
> 
> I've had more time with this, I agree with you.  I didn't intend to
> limit us to one manager per parent device.
> 
> >> > Then, all load kernel-doc comments says:
> >> > 
> >> > "This code assumes the caller got the mgr pointer from
> >> > of_fpga_mgr_get() or fpga_mgr_get()"
> >> > 
> >> > but that function does not allow me to get, for instance, the
> >> > second FPGA manager on my card.
> >> > 
> >> > Since, thanks to this patch I'm actually the creator of the
> >> > fpga_manager structure,  I do not need to use fpga_mgr_get() to
> >> > retrieve that data structure.
> >> > Despite this, I believe we still need to increment the module
> >> > reference counter (which is done by fpga_mgr_get()).
> >> > 
> >> > We can fix this function by just replacing the argument from
> >> > 'device' to 'fpga_manager' (the one returned by create() ).
> >> 
> >> At first thought, that's what I'd want.
> >> 
> >> > Alternatively, we
> >> > can add an 'owner' field in "struct fpga_manager_ops" and 'get'
> >> > it
> >> > when we use it. Or again, just an 'owner' argument in the
> >> > create()
> >> > function.
> >> 
> >> It seems like we shouldn't have to do that.
> > 
> > Why?
> 
> OK yes, I agree; the kernel has a lot of examples of doing this.
> 
> I'll have to play with it, I'll probably add the owner arg to the
> create function, add owner to struct fpga_manager, and save.

I have two though about this.

1. file_operation like approach. The onwer is associated to the FPGA
manager operation. Whenever the FPGA manager wants to use an operation
it get/put the module owner of these operations (because this is what 
we need to protect). With this the user is not directly involved, read 
it as less code, less things to care about. And probably there is no 
need for fpga_manager_get().

2. fpga_manager onwer, we can still play the game above but 
conceptually, from the user point of view, I see it like the driver 
that creates the fpga_manager instance becomes the owner of it. I 
think that this is not true, the fpga_manager structure is completely 
used by the FPGA manager module and the driver use it as a token to 
access the FPGA manager API. I hope my point is clear :)

I'm more for the solution 1.

> >> > I'm proposing these alternatives because I'm not sure that
> >> > 
> >> > this is correct:
> >> >         if (!try_module_get(dev->parent->driver->owner))
> >> > 
> >> > What if the device does not have a driver? Do we consider the
> >> > following a valid use case?
> >> > 
> >> > 
> >> > probe(struct device *dev) {
> >> > 
> >> >   struct device *mydev;
> >> >   
> >> >   mydev->parent = dev;
> >> >   device_register(mydev);
> >> >   fpga_mrg_create(mydev, ....);
> >> > 
> >> > }
> 
> Sure
> 
> >> When would you want to do that?
> > 
> > Not sure when, I'm in the middle of some other development and I
> > stumbled into this issue. But of course I can do it ... at some
> > point> 
> > :)
> 
> I was meaning to ask something else. 

I see, you meant the example about the "virtual device" without 
driver. I do not have a true example, but this is a possible case I 
think we should support it or not (check this on register())

> I don't mind writing this and would be interested in your review/
> feedback.  Thanks again for seeing this and for the thoughtful
> analysis.

I'm here for any feedback/review :)




