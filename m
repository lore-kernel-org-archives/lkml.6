Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC54EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6024F2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="EX57SM19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6024F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeGRW1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:27:47 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:38304
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726985AbeGRW1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o20F4oBWvJ47tg/AJIIpaf5FSV7InNLUv1/jpCMrI6w=;
 b=EX57SM19NEqxYgx15Bq0YYqOjlidlKdP96VcfIOO5g6LCCqdQ575YimTmw+IfQtTEXITR8zs8WpnyiZymeUfB+ZvJd5HeN0BuXifsx7oHsDDAZng5sJOihTz2D3n0Iq+xytZUKhlqM9dsw4MWAWRmh0J72TVWIGEvHPwqch+zbc=
Received: from AM6PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:20b:14::34)
 by VI1PR0602MB3245.eurprd06.prod.outlook.com (2603:10a6:802:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Wed, 18 Jul
 2018 21:47:52 +0000
Received: from VE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::206) by AM6PR06CA0021.outlook.office365.com
 (2603:10a6:20b:14::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 21:47:51 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT057.mail.protection.outlook.com (10.152.13.90) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.952.17 via Frontend Transport; Wed, 18 Jul 2018 21:47:51 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 18 Jul
 2018 23:47:35 +0200
Received: from harkonnen.localnet (178.196.40.127) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 18 Jul
 2018 23:47:35 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Date:   Wed, 18 Jul 2018 23:47:35 +0200
Message-ID: <2076282.DFHNtXLtgF@harkonnen>
Organization: CERN
In-Reply-To: <CANk1AXSd7V03w=uPuo+HiibxmD9_JwaTZyx4uRJ_OfXB4o-_Cw@mail.gmail.com>
References: <4617134.5euanDEBgJ@pcbe13614> <2419388.jt6midSiEu@pcbe13614> <CANk1AXSd7V03w=uPuo+HiibxmD9_JwaTZyx4uRJ_OfXB4o-_Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [178.196.40.127]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(438002)(52314003)(199004)(189003)(46406003)(47776003)(54906003)(106466001)(9576002)(11346002)(476003)(3846002)(561944003)(6116002)(956004)(44832011)(426003)(74482002)(356003)(106002)(336012)(486006)(126002)(66066001)(97756001)(16526019)(23726003)(446003)(5660300001)(305945005)(7736002)(7636002)(26005)(478600001)(2906002)(186003)(6916009)(53546011)(786003)(33896004)(76176011)(246002)(36916002)(8676002)(8936002)(316002)(230700001)(33716001)(4326008)(9686003)(50466002)(14444005)(86362001)(6246003)(229853002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3245;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29dc319f-5b56-40f9-8794-08d5ecf81c89
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3245;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3245:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3245;20:iETqMUGMnN3prpsu/phrbjQBESy5jm0mERU9aV44PDQFcI2OxH36T4Ur7V88MEkNM7sT1aGHp3D3MTZOIl481D2J+kQDvKbeeDCN4lGWWT/4RRaU8fj5QA1ANfEx5NrG5SNuqx8288OT4Rxfg8JCHXixsNTD8CNG9dtlPc4Wau6J6kDNlRZXxkUyjgqAHaV7yWI/wYYo71TT/f7J1V3ZCPwhYEDJ8TdpQBuFPM6Knz1uIvh6hI3mTq9Ic6f2PYaIVTJzoLUxPQ2o04GnhkCyDv4CBGV3z94Y2qsptamGzzLfUg3hkWt5xzuGdy1c4JyzhQnE8O/4Wc5Q6SmF3nPPD97TJqZoXeGrhuAMNNlybk8Kpa1cr6P51mdZR7LnQXWGskEPSRtLoWpckhv+Cj+G9rkHg4LwpAhljgCSPxTojlJtmWmKWzTn01Xm7s21U1KwoqpPpGPLUmXDkRL0b7yksj9G302va8iS0XdHDbkvr+9BgoScdtHU6RUIEagx69WH;4:5yv7mZ1G+EP3QvjGaOBvm2wJRtDGu4tOrT+CqNA66/30nsqniuX8ZsIJF85ZlnODB9H/DDl85aEBamKuoE3wiHcVnKtSImayi6ptujiwC3KyDVWkrsRlsWRL7FiCfGymmcdZjrUBvLJQQ1p8WtpYd31H9gYUdMsXZeT+LsY5T2QEasFxcgJg+xEGeBAkacGZRzZdFuE0rW9F7SwrY3kQ0QS6DZQ1D+C9FAnQ1e04OTKvOi0Sz5cahgDC+LorWPkDemfB2PhsBhz5KGbmQRCM8KmOMYDXd9JRcBim2DAsdmoAK0ggdhyJ5ZKE5BlSNzeD
X-Microsoft-Antispam-PRVS: <VI1PR0602MB324512757E32E8F5F3AA3ECFEF530@VI1PR0602MB3245.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0602MB3245;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0602MB3245;
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0602MB3245;23:2s4RQ9fOMQfIX7Ddgf3NRJNXky2l1lSQQpT5YHn?=
 =?us-ascii?Q?GpEaRK4fX3xbQMMmTnp/FLlPxavZNyDLpYKaNrEuzXw6HvYVCaFs2oCmoRLc?=
 =?us-ascii?Q?OjzEoAsQSihV7ldMA/aTLbKhVgkz7lThSU/nyPDYX0VvVn7bPBnFeMhZjVWy?=
 =?us-ascii?Q?RNwOlasPv4liT2v4ae9KmPOiwl/ABmt5YcgwBHCj7rknJHJID/X+V0F07ba0?=
 =?us-ascii?Q?DKWtqYwAsGIwwIvNo8WuRU/yaUh11F2zFTDesktzvR4f6+WEst9HCgZjeP5Y?=
 =?us-ascii?Q?bYipHv6y+KstsRFUH+UL/XaKBA+eHg3VGN9Xyud9N1iEmoIzHY2JiFljjio+?=
 =?us-ascii?Q?lh1nKUPf7hQJuUoqkfjcVNWDlJ8isAYd0qhPUQ5grUPgnxnBEJcuuvMewZJb?=
 =?us-ascii?Q?nJzoN8b1aiac8FWBL+5EuuHDDC3xuzfTXbSxezHdy33CCADCgZlqm32oSyy/?=
 =?us-ascii?Q?ZtXI920E1G8qQ+K9NOdwQeqQZUefKqndkVtUQgro7IzJcC5P83kRTx7hEiXP?=
 =?us-ascii?Q?+rd7LB2LhHGfyBXiZ0ked/MvBpr0HR8SgxedGSD6zVCq7SNsGf4VdlPR9IlR?=
 =?us-ascii?Q?8OVIJguUkRWBR4aZ//r+D2lJ54GB4nTHqlblnjei3uqh4N9N9pFiRj5EJw7K?=
 =?us-ascii?Q?MqOTXHhpdUIYFIUsKIsiYIR7cs/+5tSu8X84v1g6tnonmtty/EYpdE+61ooZ?=
 =?us-ascii?Q?fw37XZXv3ywuyWsagHVkI3NVltPe6QcgFQD23ons4p3jVQ8dolok40tyt+mf?=
 =?us-ascii?Q?hdmTIgcO/titCW8ED/QHbNr6+P4Zz3kxZVID3s3l7w52RU312sVfcAE58IW3?=
 =?us-ascii?Q?m2nVztUyLrSdVq10cMRd4c5dzE4wghZQLZXSNX7rOJ3WYrHtvBdchgsv/6bM?=
 =?us-ascii?Q?eZ+8VmEkEKq1VAJZLk9n1VahCMoZDpL8Uwjv+R40Q4fbNST4qYr4wq5KrjDV?=
 =?us-ascii?Q?gyHWveJdPdEsSq/gBtIhzOV/xZ03Nr4IwD0d2MgkWxiEEJPyrKup0MbXdK/U?=
 =?us-ascii?Q?KrcB7Sqa1NP4eY6eBQQXEn36VGW9qRC3qPficsZJa5fMyUB3jvkWbTBXDLRp?=
 =?us-ascii?Q?7UqeUvMemm7KjthsRBjqR6irBFm2t1lWBA9+UVDxj6ySNsJMHG7NHL3AL0EK?=
 =?us-ascii?Q?6HHFQ9ERQDNDXypSbOklnjIFiYfCpSog7UU/AyyOBx+jpH2lQXC3xGLBoia0?=
 =?us-ascii?Q?TKSDKrKhIDOTFay+KdEoVEuJ/mhwueUfFehzAoCEiQWANpcjqOJA9LaxIqRZ?=
 =?us-ascii?Q?Ql4gCK9aMcrfmcjBq/R1SsobhnscrGO7NCsw72pyPPhbVjRNdpbuWq0tN8Bi?=
 =?us-ascii?Q?siinhXpw/gG2pkQam822Kr452OW9gFqdecmbzJtp2aGsX?=
X-Microsoft-Antispam-Message-Info: RBAyTw2XHWpiAvvB4TDnVtqISvsJ9ljbLcarcTqK8I/TXatXoSrlcRUi2UirUoLqNnqDj8h+Pk5cd5grfdVv9Po0KUa64cs/LKC/gMjp1SqQ5qheCcQsXtgT30YJeBWh060fcEsX0dYJwmCfsSt5O2IwOFGl/9cxAzYZHGlWcDeckBrj+vIizsq7uBFdhWVR7dUnpKVa6gmcDiM1Xb6gc8bs+HyfgYd6p6FOolTM5EcMuKq0SQhC1+wLORJmBYaDpjILT/R9Elt6FDpqsQukFB26iY1YzocoaDcm/Q5aSXAby+4Fv6Pm05yMDExkNikBHwySnjZwI4vJwdFA803RQBLZbUHLnHwFIWwlX3SrP3k=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3245;6:EjL5TTmP+BNUEAI4+r8HWSgWZqWsisLJ3IliNALSWvu6iuRNeFigH5HbL+A95ORJQ0Q+cnaaSL/+kADa8w+i8QtPYbSyiMoIP8WZ5X0HO+AgVqDDrSyOqld9mACap4llZ5V7kFSCF1GJ+8DAWN8hSH1HWl533bXVQieHbvYu/ekJpeazNt54K/fLfBbdCJYfXNWu0Rl67GLO9ydK2O3+4Oun+kJI0clp8LMLGHenCgJtAOd2ceq7vwBcZNoRrR5G8y623kJHQQgqIU5yrGhsrszfVNlJH3WhVxwP36erOcBCgwnaisZIr+DMoFT5Ob6wq2GZyBmk5zNMCNofsSPbYmkyUOIbeWL27E0+pUvFptWN4n1boShFOfYnVJy5C7xnKus+Ypti4yv9o7J/qkIg99d2RuhAqW+xzcCJ8n7j2U7lVnKaGQUXdMznxY82fK5hI07G1uD8kpPZfDbyoTiZkg==;5:Mw9xHMSSRsgj/NdimyMZAhcJEXi2tKLMm2qjPyzkXqmkcTEL3aNC1jy+gzmMGvNBuAz4R5c5qywvTuei0+4oCmhQl2jDRYNksT3tKKdjbbh6L1OX+wvrRtW4eFxjdfCxPtCda9TnfB8Sg/yP4ncbxGsavUMXEW4U4abEne5xoZE=;24:c/u01qcvVZT1NRwQ5V6o2NX09nUeF0glQ+FeNgjkcWiJx1E9AyNT+rMQ8HWsGi+uy8Qa8QjgCdGu71Fx7/fFyXIKMStxctLKHjN1mLwmOQ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3245;7:05iyGKbBXRSKo25592oJOEXHLYsaySD1K7eL4YdP0AWrout1R7LJ7SByL/jEzXs8zpE5vmmv7SfDStHlYTaY79dl4Q9GMPa4GHQQ3uwPxET+QDcY6VQNCYKU8qAncT2LfDYhtxPQ45a1GLCIJIcPcvYPO2mRtlEwTcEOshN3yFWnkiw7ukbudFVBtvORJnOmoZnY7WietJWEaZAGFPMIQ11XFYAEXZ2w02Htr73n0imSvk1dpM3VyHxUofbHgWVF
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 21:47:51.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dc319f-5b56-40f9-8794-08d5ecf81c89
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thanks for your time, comments below

On Wednesday, July 18, 2018 9:47:24 PM CEST Alan Tull wrote:
> On Thu, Jun 28, 2018 at 2:50 AM, Federico Vaga <federico.vaga@cern.ch> 
wrote:
> > On Wednesday, 27 June 2018 23:23:07 CEST Alan Tull wrote:
> >> On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga
> > 
> > <federico.vaga@cern.ch> wrote:
> >> > Hi Alan,
> >> > 
> >> > On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
> >> >> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
> >> >> <federico.vaga@cern.ch> wrote:
> >> >> 
> >> >> Hi Federico,
> >> >> 
> >> >> >> > What is buggy is the function fpga_mgr_get().
> >> >> >> > That patch has been done to allow multiple FPGA manager
> >> >> >> > instances
> >> >> >> > to be linked to the same device (PCI it says). But function
> >> >> >> > fpga_mgr_get() will return only the first found: what about
> >> >> >> > the
> >> >> >> > others?
> 
> Looking at this further, no code change is needed in the FPGA API to
> support multiple managers.  A FPGA manager driver is a self-contained
> platform driver.  The PCI driver for a board that contains multiple
> FPGAs should create a platform device for each manager and save each
> of those devs in its pdata.
> 
> >> >> >> > Then, all load kernel-doc comments says:
> >> >> >> > 
> >> >> >> > "This code assumes the caller got the mgr pointer from
> >> >> >> > of_fpga_mgr_get() or fpga_mgr_get()"
> >> >> >> > 
> >> >> >> > but that function does not allow me to get, for instance,
> >> >> >> > the
> >> >> >> > second FPGA manager on my card.
> 
> fpga_mgr_get() will do what you want if your PCI driver creates a
> platform device per FPGA manager as mentioned above.
> 
> >> >> >> > Since, thanks to this patch I'm actually the creator of the
> >> >> >> > fpga_manager structure,  I do not need to use fpga_mgr_get()
> >> >> >> > to
> >> >> >> > retrieve that data structure.
> 
> The creator of the FPGA mgr structure is the low level FPGA manager
> driver, not the PCIe driver.

In my case it is.
It's a bit like where SPI driver is the low level FPGA manager driver for 
the xilinx-spi.c. But if I understand what you mean, I should always have a 
platform_driver just for the FPGA manager even if it has a 1:1 relation 
with its carrier? In other words, I write two drivers:
- one for the FPGA manager
- one for the PCI device that then register the FPGA manager driver

In my case the FPGA programmed is also the PCIe bridge (GN4124). Probably I 
can do it anyway, because the part dedicated to FPGA programming is quite 
independent from the rest (don't remember all details)
 
> >> >> >> > Despite this, I believe we still need to increment the
> >> >> >> > module
> >> >> >> > reference counter (which is done by fpga_mgr_get()).
> 
> This is only done in the probe function of a FPGA region driver.
> 
> >> >> >> > We can fix this function by just replacing the argument from
> >> >> >> > 'device' to 'fpga_manager' (the one returned by create() ).
> >> >> >> 
> >> >> >> At first thought, that's what I'd want.
> >> >> >> 
> >> >> >> > Alternatively, we
> >> >> >> > can add an 'owner' field in "struct fpga_manager_ops" and
> >> >> >> > 'get'
> >> >> >> > it
> >> >> >> > when we use it. Or again, just an 'owner' argument in the
> >> >> >> > create()
> >> >> >> > function.
> >> >> >> 
> >> >> >> It seems like we shouldn't have to do that.
> >> >> > 
> >> >> > Why?
> >> >> 
> >> >> OK yes, I agree; the kernel has a lot of examples of doing this.
> >> >> 
> >> >> I'll have to play with it, I'll probably add the owner arg to the
> >> >> create function, add owner to struct fpga_manager, and save.
> >> > 
> >> > I have two though about this.
> >> > 
> >> > 1. file_operation like approach. The onwer is associated to the
> >> > FPGA manager operation. Whenever the FPGA manager wants to use an
> >> > operation it get/put the module owner of these operations
> >> > (because this is what we need to protect). With this the user is
> >> > not directly involved, read it as less code, less things to care
> >> > about. And probably there is no need for fpga_manager_get().
> >> 
> >> How does try_module_get fit into this scheme?  I think this proposal
> >> #1 is missing the point of what the reference count increment is
> >> meant to do.  Or am I misunderstanding?  How does that keep the
> >> module from being unloaded 1/3 way through programming a FPGA?
> >> IIUC you are saying that the reference count would be incremented
> >> before doing the manager ops .write_init, then decremented again
> >> afterwards, incremented before each call to .write, decremented
> >> afterwards, then the same for .write_complete.
> > 
> > I'm not saying to do module_get/put just around the mops->XXX(): it's
> > too much. Just where you have this comment:
> > 
> > "This code assumes the caller got the mgr pointer from
> > of_fpga_mgr_get() or fpga_mgr_get()"
> > 
> > Because, currently, it's here where we do module_get()
> 
> No it's not.

It is not in the code, but the comment says that we should do it before 
calling fpga_mgr_load()

> fpga_mgr_get() or of_fpga_mgr_get() is called when the region is
> created such as in of-fpga-region's probe.  That way, as long as the
> region exists, the manager won't be unloaded.  If someone wants to
> start unloading modules, they need to unload higher level ones first,
> so they'll have to unload the region before mgr.
> 
> > Most mops are invoked within a set of static functions which are
> > called only by few exported functions. I'm suggesting to do
> > module_get/put in those exported function at the beginning (get) and
> > and the end (put) because we know that within these functions, here
> > and there, we will use mops which are owned by a different module.
> > We do not want the module owner of the mops to disappear while someone
> > is doing fpga_mgr_load(). For example, inside fpga_mgr_load() we use
> > most of the mops, so we 'get' the module at the beginning and 'put' it
> > at the end. The same for fpga_region_program_fpga().
> 
> If we do it the way you are suggesting, then someone can unload the
> manager module without unloading the region.  The region code will be
> in for a nasty surprise when programming is attempted.

Of course, this should be taken into account. I was not suggesting a 
precise implementation, but only the idea to hide get/put. Probably there 
other things as well that I'm not considering (indeed I do not have a 
patch, but just a comment) 

> > Like this we do not have to ask users to do fpga_mgr_get()/put().
> 
> The only user who has to do this is a region's probe function.
> 
> I'm assuming that only fpga_region is using fpga_mgr_load() and
> anybody who is creating a region uses fpga_region_program_fpga().
> That's what I want to encourage anyway.  I should probably move
> fpga_mgr_load to a private header.

All right, if this is what you want to encourage I do not have anything to 
say because I did exactly what you do not want to encourage :)

For me this change everything because I do not use regions since I do not 
have them. The way the API is exposed to me did not encouraged me to use 
their API. In addition, the documentation guides me directly to the FPGA 
manager.

To be honest I did not have much time to look at the region code. My 
understanding, after a quick look, is that it works great with device-tree. 
But what if I do not have it? Actually, I cannot use device-tree because of 
environment limitations and Linux version in use. Oops, this implies that I 
back-ported the FPGA manager to an older Linux version? Yes, guilty :)

Anyway, I'm using the API exposed, and if part of the assumptions behind 
this API is that I should use device-tree, then I'm out of scope.

<chatting>
Just for chatting. One addition I made for the FPGA manager is to support 
dynamic loading of FPGA code using char devices. Something like:

   dd if=binary.bin of=/dev/fpga0
   cat binary.bin > /dev/fpga0

We do not have device tree, and we do not have binaries in /lib/firmware. 
It's quite handy to quickly load a binary just synthesized, especially for 
debugging purpose. If you are interested I can try to clean it up (at some 
point, probably in autumn), or I can show you the code in private for a 
quick look.
</chatting>


> > <Parenthesis>
> > fpga_region_program_fpga() does not do (today) fpga_mgr_get() because
> > it assumes, but it is not enforced, that both fpga_region and fpga_mgr
> > are child of the same device.
> 
> fpga_region_program_fpga() doesn't do fpga_mgr_get() becuase
> fpga_mgr_get() happens when the fpga_region probes.  The assumption I
> am making is that nobody other than a region is calling
> fpga_manager_load().  I should create a fpga_private.h and move
> fpga_manager_load() out of fpga-mgr.h to make that official.

Yes, I agree. If what I'm doing is not supposed to happen I should not be 
allowed to do it :)

<suggestion>
If you want to encourage people to use regions rather than the manager 
directly, have you though about changing the API and merge in a single 
module fpga-mgr and fpga-region?

Brainstorming. Perhaps, it is possible to have a `struct fpga_region_info` 
and when we register and FPGA manager we use something like:

struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
				     const struct fpga_manager_ops *mops,
                     struct fpga_region_info *info, int n_regions,
				     void *priv)

So those regions will be created directly and the interface will be smaller 
and easier.

Don't waste much time on this suggestion, as I said before I did not study 
much the fpga-region.c code and perhaps this is not possible and I'm just 
speaking rubbish :)
</suggestion>


> > Probably this is true 99.99% of the
> > time.
> > Let me open in parallel another point: why fpga_region is not a child
> > of fpga_manager?
> 
> FPGA regions are children of FPGA bridges.
> 
> Alan


-- 
Federico Vaga
[BE-CO-HT]


