Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAAEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B9021473
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="j0PAD93o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B9021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeHQKDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:03:09 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:54176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbeHQKDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9np23IBDtGf5W4mtz+9wWLM3DL//0MyVn5ixLN8XUhk=;
 b=j0PAD93ogWDR/e7Yhw2IAco9etjNCg3z6V4fXM+UaqIWe0or7EBA1Ony1wjxV4OhQvmg9wiAPGI/M+DMMeRA/6kODPoKh5m+AXgtU9oFCCDv+hN1f3fQro0l5ziKI0/feC8+jfNjms03ms8ss5IWyJvYI8a0A3VZNatGL76aP/I=
Received: from HE1PR0601CA0028.eurprd06.prod.outlook.com
 (2a01:111:e400:c513::38) by VI1PR0602MB3245.eurprd06.prod.outlook.com
 (2603:10a6:802:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Fri, 17 Aug
 2018 07:00:49 +0000
Received: from HE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::200) by HE1PR0601CA0028.outlook.office365.com
 (2a01:111:e400:c513::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Fri, 17 Aug 2018 07:00:49 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT041.mail.protection.outlook.com (10.152.11.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1059.14 via Frontend Transport; Fri, 17 Aug 2018 07:00:48 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 17 Aug
 2018 09:00:40 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Fri, 17 Aug 2018 09:00:37 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Moritz Fischer <mdf@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Alan Tull <atull@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Appana Durga Kedareswara Rao" <appanad@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Date:   Fri, 17 Aug 2018 09:00:38 +0200
Message-ID: <2759044.uKe7sI2ItL@pcbe13614>
In-Reply-To: <20180816220034.GA4431@archbook>
References: <20180815220958.3606-1-atull@kernel.org> <1841468.1pWPcT6Du7@harkonnen> <20180816220034.GA4431@archbook>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3245;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53af1d4e-88ab-43f5-29be-08d6040f29b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(5565046)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3245;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3245:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3245;20:dvj208Hs+0x8HhSY7ROmuA5tCMgPliyK5RSoZOp5UOqSIppGkEUemB2Z4F9teKHnFFVSTlrJRFH8WTyhPA8Im4Obr1uRnNMaKc7ZRqV553+DhYh/fKULM1wD9B7sF2b/FSIec+sP1o64v56bM9NSExZt6ysw3sf6lkQIApumWybccAlo4o+9ghScc1hA/uQy9LiQdEPVomvRVoUtXjbM+6YK5SFbYg6utH016x+NV3undDkGqqACi2zTSG/UzJriFtJLIEQt76M6dU75Mqn3PTHf7tMVMnKra/odeyKYHXESAs2PBdrtUvJIoa6fcv5LEChJha+Nwam/z0DNfwrtBo95s9j02B7RV8mVNGvQ1IGBsLLhuWE/oiYdSIy9WkJKsZB4/eMXtgHkAyMTXIAo2ewaTdorBpdVEFMlNu4XW51Tu/Qe38sWTfol2Sr/ywbstQkxbCNiYgQHMDTJzn7jC2hditfxoq6Qx3keKp1y8q9lBrHJvgfoGWswG1KuR3c1;4:uNk2vQo2phGL6VypisHXZ5/LMeouOFiWOesp2GmZLattxdHBtqeQ39OCIpe9J68vf9np4hl6O4+47oFqPLPI3Apv7+/BvHNvKK/u0tYcVx8ycdHnhXkaXgjnSJ75IDaHdJiIQTCbMA9ASRgkZR2JY9ZdkUo5pjfMSZ51dZUaChm3QGlxY4qV7ILfYY8Ht1Iq9VPVrSUfmzHXEAVfZOldSWpWP6vnbGlfMl3bheGru9u/MkMx8Puf8peyt9YjqWBgRSvqasaf7QUNnLgNAqPEhQ==
X-Microsoft-Antispam-PRVS: <VI1PR0602MB324501C0BEDB780F43035FB3EF3D0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(7700054)(944501410)(52105095)(10201501046)(93006095)(93004095)(149027)(150027)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016)(7701012);SRVR:VI1PR0602MB3245;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0602MB3245;
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3245;23:I5gGeV7qSBzxhm88OOiALnc61vxxnS5PCwextBMI71jSlEI8eMgnJ2GZRRe6n+bzLZBwmpL0Q7ZESlgNtGvii993n64d88+ZIFQN8wX/xzORKmXX/mpDW1yUrCCFkTkn6cp+Lm4TQrwfCkiKrEv8+IrT7SSDhVHTEGVhm7zaAlXs7ye+k0yTXcigOqIIpa4b;6:YBumwg8NVh9ElVgr9UkVzBK6Qb1fdgCgQrW27SnNNS0gfMa4/QbwHB0F1XlhgjRnFx/qNrJrwTcDQ/Fz3LcJAOEiid0QuNk83XVMLEVXuDmCqJ1vXzZuApu11XXf+Dh3nenJOqT4STPNz2BWrjT8uHRbBvhxvlNqx7UeMC8EypXb3Xz6acUTepClNJJfnHkagB063gkNA3769XcvbKpP8BL/4EJV6nQZBDwvQI0/c/hhF9IBXY8BPwTow7cif54I3kXR2NBRWhFD4XcMyCsLDQOn7MQB55unUY1+7sUCvLmtNfgtm7Nc6eNKZX0GaT1bgffM8+t3gJsLlXYn7mJdqk8vTwhv1P7HQyeje9M6vw/FCwYPpxO3q+5xjdsmZXz2oYrGMYkO0+3G9446mLb56QAQiOXKm7HClm6b0XxQNPrqgdCZ1WT/P/ilV9vOqcKvg/lLQ5sbKVRoT4NzULcG4ojEOmynbUDzfcB+P423KqmfeHKvJ54Sw7pvqlCLVBqm;5:dZ1ItDJvFel1ERKlYKvend0HVR5s3R5HrtpGcUIM/nPloTtTG0bZP6S0HnlAbYg5ewJdInfuIT2GUuUYXYGhflH3vE7NjZgSyDirA5uyqW2eAlNbNk/54hMmE9nDHlXyuDOmPZR/JaUkBwml6fnBEzULsPymLqwfcnwkez4hUB8=
X-Microsoft-Antispam-Message-Info: UtE6ela6Df9Q2TxZ+PqWWBTDtqZwYrps5se/uphqooBleVyA8+09gc5yU54h23dfhfjmskSQqVyshtAJaP78ylVU0X4BQbpMXG04ca9eP6fVHyv54sRqXeErgmLrJ1OB07UPQQ32doMGmxCZHoCjBhM04s093kfV6gJIdcpO+n6/kx2whXBLFZ340tlCwQkp9QZQPokZ4FhcjMb8lE38XjKVL19r2DIRsjLhYN81dszTNN54f3xe15tmaNCStxx0u2/PLBiZwlZmsSs+yLPEXb4+M5fZIfTfw0IPtJr+pTeyEaeYi/XI2niLJZ86N4kpoRV3pC5wKEQ97aIwEL4IXpmpZv0baWT6bUJ7gldZeSXLi68T4/fRVdsf8afnGV5o1CHq7sO/AgOsGYKpECVXXmV/dS5POiuT0DND8v3VV3dH4qHrYBRbK+9T4yajQRWuJv2t4ou/qu3qRlhg1T4CM1wClljCEfjE0vErxRmWAlc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3245;7:8hg7Hqo7up4qguiwdUwSUeSFU/ozsliQTZKWg+W9AD7/yOdE77BM6J6Qa1c/EmhLMuhbm2PX8o7Xb5R283XZCee1OqcXvEVvlXXO80fpf36yR9U4Vusb9xzN7FeMIdByD4/NrkAlenUK7qZKES4E4prKpBS6OFjiepvndncL7wIOf64yC74zztsD6GNlbipzNn/C0PAnkeC/uGz6JQTBT/8zj1pLjK2zTlCHL324OXcgpxJGPhuxGNww9mRg/qP/
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 07:00:48.2350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53af1d4e-88ab-43f5-29be-08d6040f29b6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mortiz,

I'm not 100% into the problem to understand all cases. I'm putting on the 
table the point of view, mainly, of an user. If you say there are problems 
here or there I believe you. At the beginning, you did not say that this 
interface may introduce problems (and I'm interested in those problems since I 
implemented one and we are using it), but that you fear that it becomes the 
default (usually, being a default is a good thing).

Since you and Alan are working on this for a long time, you can read each 
other mind, but I need a more verbose email to understand ^_^'

Of course the interface must be safe, I totally agree. In order to make me 
understand what are the issues, can you list some of them? And expand your 
comment about  MMIO.

(I just did a dummy backport, and implemented that interface. So, I repeat 
myself: I do not have enough experience with this framework to understand all 
consequences, but I'm interested to know what are the risks behind this 
interface)

On Friday, August 17, 2018 12:00:34 AM CEST Moritz Fischer wrote:
> Hi Federico,
> 
> On Thu, Aug 16, 2018 at 11:21:32PM +0200, Federico Vaga wrote:
> > Hi,
> > 
> > On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:
> > > On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > > > Hi Alan,
> > > 
> > > Hi Moritz,
> > > 
> > > > comments inline. While I see how this is useful, I have the
> > > > suspicion that from the moment this gets merged vendor kernels
> > > > will just default to use this ...
> > > 
> > > Yeah, I have that suspicion as well.  That's probably why I sat on
> > > this and didn't upstream it for 2 years.  But on the other hand, I
> > > keep hearing of lots of cases of people implementing this
> > > independently anyway.  At least if it is debugfs, it makes it clear
> > > that it's not intended for production use.
> > 
> > I'm one of those guys who implemented this independently.
> 
> We all have in one way or another ;) Most people on ARM run an out of tree
> patch using devicetree overlays these days I hope rather than /dev/mem
> and UIO ... or other vender solutions...
> 
> > @Mortiz
> > I do not see how this can be a bad thing (from what you wrote I guess you
> > prefer another interface). Which interface to use depends on the use case.
> > If you have this suspicion it's, I guess, because such interface it is
> > extremely easy to use.
> 
> What happens to a kernel driver doing MMIO with devices while you reload
> the entire FPGA from userland?
> 
> > @Alan
> > DebugFS can be a first step, but I would go for a normal device in /dev at
> > some point. I do not see why this should not be used in production
> 
> I'm not against having a userland interface to reprogram the FPGA, the
> Intel DFL code is a good example of a sensible one, doing so in a safe
> manner.
>
> Ideally we'll get around to have a more generic interface, as we get
> time to work on it.
> 
> - Moritz




