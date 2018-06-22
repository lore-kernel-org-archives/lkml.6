Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71849C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055D123E7B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="XrH+eXB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055D123E7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeFVHxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:53:21 -0400
Received: from mail-he1eur01on0041.outbound.protection.outlook.com ([104.47.0.41]:60105
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750985AbeFVHxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eraXsO9h01HcS9kAYImtUFKVWNMgR1UHbcNyZGgyE2k=;
 b=XrH+eXB+aIJ0OTriCqsJJkVxP+sVfuYjM8vhSnYV8rnAmhR4iX7XFHw8YLwUyyDdOBJrRGIpBXn73IZSGsvFxvcDsGJ0cK5AUYBOvQnW9/xUdRLL/higGSmtcHsnBVxFCSg5o6PlFrMtnr0223b1k/v+8x1YXEwP+8ngD5koDik=
Received: from VI1PR0601CA0030.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::40) by AM3PR06MB1139.eurprd06.prod.outlook.com
 (2a01:111:e400:5873::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Fri, 22 Jun
 2018 07:53:16 +0000
Received: from VE1EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::204) by VI1PR0601CA0030.outlook.office365.com
 (2603:10a6:800:1e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.21 via Frontend
 Transport; Fri, 22 Jun 2018 07:53:15 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT033.mail.protection.outlook.com (10.152.12.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.884.17 via Frontend Transport; Fri, 22 Jun 2018 07:53:15 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 22 Jun
 2018 09:53:07 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Fri, 22 Jun 2018 09:53:06 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fpga: fpga_mgr_get() buggy ?
Date:   Fri, 22 Jun 2018 09:53:06 +0200
Message-ID: <22840601.TEhG8FuRZq@pcbe13614>
In-Reply-To: <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
References: <4617134.5euanDEBgJ@pcbe13614> <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(396003)(376002)(2980300002)(438002)(199004)(189003)(51914003)(486006)(16526019)(478600001)(46406003)(186003)(786003)(54906003)(316002)(106002)(43066004)(53546011)(966005)(11346002)(476003)(6116002)(126002)(33716001)(50466002)(336012)(446003)(26005)(47776003)(5660300001)(230700001)(44832011)(23726003)(305945005)(6246003)(356003)(106466001)(7736002)(86362001)(7636002)(229853002)(426003)(6916009)(8936002)(2906002)(97756001)(6306002)(8676002)(9686003)(33896004)(4326008)(3450700001)(74482002)(9576002)(76176011)(246002)(39026011)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR06MB1139;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d4b6988-8acc-4b20-5a36-08d5d8153656
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM3PR06MB1139;
X-MS-TrafficTypeDiagnostic: AM3PR06MB1139:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1139;20:oIBKGk7aUsdQap+UybUflfwJjeaFMoCIOtR9uEkImNTsOroeXccAjEbzT3ddz7aWhuszdd5hrMIY/9PKyc950jgPh8VLyrSYonWxbEIBka16Sk/Ud+cQc1NkegwElrNc1mL16zMBI0+bhrDwoqb5U8Gbb+TabRWMxbTfqUKKDaHmzDMBBzvJBYNJtlbNKiVdywxje84MVEmtyU+OHKcZCMuxxJjoAmhy6b2YRGjmNHtKfqVBE8o34AEPIGlHcleeARpg61PlgxlD+fxxnkWG3MHHo9ntg3be7nzcU1p3eDF+ievxqZek0EIe0n8ijPSUsk5T6hg15Le4VpWVOrugTYMEEOeYZuu9ydYatWKomT2HYncsuSVFsgZ9sqj/N+s7AqlXkplpY0yMwMS9LUaaW2g7URANvsQaeLZoxnxwx2UEIrLSeBkk8di3KF147OmL0bUZN7ZttVegQ4voJNAJ6YtKYQWwBiRAQOqjvD7uh51DZvIWaDiNctntzujvpmtZ;4:bz6lPWekjyS7dXJNHO4aIO0a4BolKbrwbXcWnABbf4f7/htWnIQDxnT7O+sQMt0VHBmShNy0ETSPyrQvMmiGMz7MMzl3DiRYhXtmtY2K2WeiZ96Hn9ZWqZ47xgnAdaFvbh6P2xpmHN4efgf2ZJ777vVzKyyyEE2f0LhTWQ4/Iszm/Wm3x44XepwEpCdTa07kpQr2Me4Mv3Ry6cSD0lYLjnA6eHo7zsEz419DLsDscomSaRdxlIqO6Z7JEXa9DVGScZlRDLTll0m2upxscsa2q1jE0EXBlxzwIhGvG8QvkctnuQzpN/TD3bIXF1P5pI/3AaYv+FZYGwOPAi3c1EGmM8O/7epfTWOK9I2qLjyIHuc=
X-Microsoft-Antispam-PRVS: <AM3PR06MB1139F728C95F3D5A6F1F8666EF750@AM3PR06MB1139.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR06MB1139;BCL:0;PCL:0;RULEID:;SRVR:AM3PR06MB1139;
X-Forefront-PRVS: 071156160B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR06MB1139;23:vp1HlNw6u9tKx0RHjVvYTBNjQvovUbMNlEvcD1r28?=
 =?us-ascii?Q?CJTU+dyFZks4xu5564yDs8En9fg9HX23CXSLplwAYnO2RNfswexFnjwFzmsK?=
 =?us-ascii?Q?4FfPk9CkOn5O9K8Ht7bozOOzH7uzMe5RtPBR/0H9qEuG7FheTPvH0sHZnxPK?=
 =?us-ascii?Q?P3sCbPMEcuMB3xk86RCHhNLQwxTUhdGZ/A4S3qQDvKLGNbiA+KgAqE99Q65M?=
 =?us-ascii?Q?xsie6RjXtTG4FovmzK86L8IjPpKfKaS/6xe1xj8kbsiK6+Kbum4WoF/wFiy7?=
 =?us-ascii?Q?ugeocKnTbP1KOulTaorr5wLJlTdk8RWJm0F2Rqjqk/FWm6fQ3v/6g02qtEb0?=
 =?us-ascii?Q?28KTua2+yoyc/01qxE3PVHzN4ixebBrVRos8qs0VR7io/jdP2om90jsDlezl?=
 =?us-ascii?Q?63DAsBVv1Gxm4yoEP1FBfxRG6bo/7ZlOU8LJDLjTfq1svOLFV88efAmkuyRL?=
 =?us-ascii?Q?cXY24EVgscwgqW2BWFGE+FOzV3TVXPjYHzn7Dz74D2CT/BfTLZI7DERmgFMP?=
 =?us-ascii?Q?SKwOxEnT8X4NCLnuzZd7DlToORwEmi4bVq4B3cP5+pXjawG+NLw5qt2acKFq?=
 =?us-ascii?Q?H66lUVdsmz6X7apOUuQ/lPsCWz+3/1TJHJ34rnq5tXic5i9XicPiHS94NqIX?=
 =?us-ascii?Q?/uyL8h8JGy40vZgVNsyiA40C4gf8D7Sro27OMW9IUackdvksDqJDFO5Xivg5?=
 =?us-ascii?Q?kYTJIbk4XZtOmwOo/Zg722pKK3kDP2VFKViTUSDxmogD/gnngvFy093QF/VG?=
 =?us-ascii?Q?189lR3bYkY5eFky75pCeecckVFKDfaBnpsB9kCtdh7Vt+8JfY6Rk8KOMVrcN?=
 =?us-ascii?Q?MVT00a7koLstmoFQMbkclFIa9LhTBgmzuXG1wzRDAFqRaF8tJ6EfOwNWjElE?=
 =?us-ascii?Q?Du6xpou6k0X0MBzTmvR0ceXVtCp03cycQn3fPRYzyeYIsXHtm7k5gjxg3iC1?=
 =?us-ascii?Q?JabRZunQGpUvWhM36n69p5yUiXec8DPGBMATaXS3ovrQeuEuo5BNCpFhQC+G?=
 =?us-ascii?Q?NhwjUtS7foCXvxHeI8bh8mnSfz8gDoq/yyzTvqRBtdTwx7fsZlblh8GfntHd?=
 =?us-ascii?Q?EwsM9a5sNWdu3LwPEEqez+QZuQLquAWZtVRwGecdk2upjyUAFN9QquEn2lnU?=
 =?us-ascii?Q?sQkjry5dCVFXsOr6+XumfqkeNbXt6l1tlq5uy7JvnIMhOWA2H8PhtxsWmYmO?=
 =?us-ascii?Q?t5yyu5IMK/CMNy14fGWbbwRd2IuI3yi6dYgQgr/fgfNP+agEWHbQ5aSCrx6J?=
 =?us-ascii?Q?pVx3HIw7A/hfyJO2sQ+8Lo22vzuIeimMZL3dFMuEPURkdA94GytLGud5hRXH?=
 =?us-ascii?Q?TPpF50dihXIjP19y4b76U6spmhra1dKTmaDuh3IXqI5?=
X-Microsoft-Antispam-Message-Info: u9BmY6tvFTrPrdxBz3fTX6FVexk/l1JmjYB+6QZalrHSNkR0CeiUwNiJBznPV9/azb6Wl0rUT+Wi1Y8pk0Kb4C3MPfKYAqM8cVP4FW+MSXOklKBUcWMwSwy4N4qqYW+aAxREyVIqJ2/UtMkXbUU2WTGuZl4vQZ/noGdRGGOnKPkYsE82NOXBKJmsKw9XunLSLyqgSapf57UnA2Eo9VagbTdEH/uRv/BCedHdv2QqloqkbVjZ+zVZMj2c50rKBHBjkcWumF6JuhUcoinkz+i1tAV9mCZYO4MCweQE6b2w6PKy3w2gz5ClNbvOI1rEuXMYpBqayI+NsDyWIQrCPaDWFA==
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1139;6:zK1ADYzW1wwpcK45168LvEEQz2UJO2XfGA+3T8Wy9EUjlFSAqRs9xYyzjoJu1k3qKS1XNuRsFBZWv7bliC5W0hqdfPUVSlCRADERT4QO096VgfFGM68Si6h/bFKkn6H95mggnLDxxG2F7fxbJ79NxJ/I7iDkgDVcNCSaMf0dK2Mn7UDl49/c08jT7bWH6r4G3Z/u8e7jGzi78AIbp07uRAvHjDhctdmqR42I1nSYgU1OQux5ABBR2Ww45yf/HEGWEWlKQKG+d8LdYxD58VSOzghrb/qkWO0KvvAxFgkTuOH2NHj1NvRtB+xAMTt7W7oKmJd+EaW5Ty6t9lC17YC4QpnBQrP/sNStromXkajH5RiUrnPKBlKcrCgj9R7KeG46OF5QTAX1MKnuLMCQMO4XPZR4DEn8c8QVVFYBsIuehET7DOWSYhMlB2taDP6hbA1n9onBG/iyq6tDuVS9F9f1wA==;5:CNWNqkFMeQ3T6zenPL84o8tCs52Y3YcZCJP9PDgSFLPdNvf2Kzd+1Q/4Ry2835jOwEw/JHpjy8qwN+myJCYl2abVxbISGRRjYA87xV2VTmEdYQ4aiLv9ay2exLEE9PIMx6n7xyVLtUOx6ezrZju15Rxsdjl+vmVRt4qf9fXWChE=;24:iCnRq2UljXkppjSTsFrVYt7lGRLkM3sl94ZLhalovtHetvvI7i0yoQuvVRPuNtoqvknBOMvZhG4Ap5L8Nl+5/Qn7GE4ZBEyxiooVtDm9ks0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1139;7:H5WUC0TwtvIi+WpXhLY9yTQ7Rp+QwrOH5qpZ66xuRxPct/fyi22nyxIFcscGs3r9YIqciSRSlb2sc9qlN+n55rGc/n1PdCJIucPTKJbliTFZtNgIbKcc5eqE7uJn+vD6lqZ3KByKalbE9qnK9j0W+f0Lwcjtrv+rO0U2Yd2ZpfB3ippsNZuAYCcEtCSgb10zFUHsHK3aRfNF73Ze0vCTGkWbMjDTs+cP3ZUwAiRHFKq91thZo936rh7hA74GCRiD
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 07:53:15.7678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4b6988-8acc-4b20-5a36-08d5d8153656
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR06MB1139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

inline comments

On Friday, 22 June 2018 04:07:41 CEST Alan Tull wrote:
> On Thu, Jun 21, 2018 at 8:13 AM, Federico Vaga
> <federico.vaga@cern.ch> wrote:
> 
> Hi Federico,
> 
> Thanks for the analysis.  I'll probably not be able to look into
> this very much until next week.  A few notes below.
> 
> > Hello,
> > 
> > I believe that this patch
> > 
> > fpga: manager: change api, don't use drvdata
> > 7085e2a94f7df5f419e3cfb2fe809ce6564e9629
> > 
> > is incomplete and buggy.
> > 
> > I completely agree that drvdata should not be used by the FPGA
> > manager or any other subsystem like that.
> > 
> > What is buggy is the function fpga_mgr_get().
> > That patch has been done to allow multiple FPGA manager instances
> > to be linked to the same device (PCI it says). But function
> > fpga_mgr_get() will return only the first found: what about the
> > others?
> 
> I was thinking it was going to be one manager per device which makes
> sense if the device corresponds to a single FPGA.  But I could see
> that there could be valid use cases that had more than one FPGA
> such as on a PCI card.

Here a practical example where we have 2 FPGAs on the same card

https://www.ohwr.org/projects/svec/wiki/wiki

> > Then, all load kernel-doc comments says:
> > 
> > "This code assumes the caller got the mgr pointer from
> > of_fpga_mgr_get() or fpga_mgr_get()"
> > 
> > but that function does not allow me to get, for instance, the
> > second FPGA manager on my card.
> > 
> > Since, thanks to this patch I'm actually the creator of the
> > fpga_manager structure,  I do not need to use fpga_mgr_get() to
> > retrieve that data structure.
> > Despite this, I believe we still need to increment the module
> > reference counter (which is done by fpga_mgr_get()).
> > 
> > We can fix this function by just replacing the argument from
> > 'device' to 'fpga_manager' (the one returned by create() ).
> 
> At first thought, that's what I'd want.
> 
> > Alternatively, we
> > can add an 'owner' field in "struct fpga_manager_ops" and 'get' it
> > when we use it. Or again, just an 'owner' argument in the create()
> > function.
> 
> It seems like we shouldn't have to do that.

Why? 
 
> > I'm proposing these alternatives because I'm not sure that
> > 
> > this is correct:
> >         if (!try_module_get(dev->parent->driver->owner))
> > 
> > What if the device does not have a driver? Do we consider the
> > following a valid use case?
> > 
> > 
> > probe(struct device *dev) {
> > 
> >   struct device *mydev;
> >   
> >   mydev->parent = dev;
> >   device_register(mydev);
> >   fpga_mrg_create(mydev, ....);
> > 
> > }
>
> When would you want to do that?

Not sure when, I'm in the middle of some other development and I 
stumbled into this issue. But of course I can do it ... at some point 
:)

> Alan
> 
> > thanks :)
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-fpga" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html




