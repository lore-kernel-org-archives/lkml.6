Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C16CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADC221A1C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="ZqqsMzxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADC221A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeHQUtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:49:05 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:13216
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbeHQUtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RoiUNuTM/n7WqHHrx5BD5vNtWeq/pmBwrhgjs6Gvvo=;
 b=ZqqsMzxehlrij1/537mWt2gxxAsKYs/BnpKclucuvUZB56ltmD+YjHhBGD8GmYKisGB6JMswal+QJZY4TOr5U7eNN6yGvJy0nIdoUDZNWlKsN2Ry3BBMX5r/FWaBvXbYRAh5x0kfQTqxw3Rh+MgXTMQsHx8e+JLOnsnwPjuBtas=
Received: from AM5PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:206:2::26)
 by HE1PR0602MB3242.eurprd06.prod.outlook.com (2603:10a6:7:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Fri, 17 Aug
 2018 17:44:33 +0000
Received: from AM5EUR02FT017.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::201) by AM5PR06CA0013.outlook.office365.com
 (2603:10a6:206:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.21 via Frontend
 Transport; Fri, 17 Aug 2018 17:44:33 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT017.mail.protection.outlook.com (10.152.8.111) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.1080.9 via Frontend Transport; Fri, 17 Aug 2018 17:44:33 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 17 Aug
 2018 19:44:27 +0200
Received: from harkonnen.localnet (178.196.40.127) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 17 Aug
 2018 19:44:27 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
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
Date:   Fri, 17 Aug 2018 19:44:26 +0200
Message-ID: <3514241.rTi7VbLdux@harkonnen>
Organization: CERN
In-Reply-To: <CAJYdmeNJwkr3dLpdDDL-ER=X+TJgB+7Kf2U0VVQbhUjQE8TBMQ@mail.gmail.com>
References: <20180815220958.3606-1-atull@kernel.org> <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com> <CAJYdmeNJwkr3dLpdDDL-ER=X+TJgB+7Kf2U0VVQbhUjQE8TBMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [178.196.40.127]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(966005)(26005)(86362001)(336012)(478600001)(186003)(97756001)(53546011)(46406003)(9576002)(16526019)(230700001)(6116002)(3846002)(8936002)(23726003)(7736002)(356003)(7636002)(305945005)(8676002)(246002)(229853002)(6306002)(9686003)(33716001)(2906002)(36916002)(316002)(6916009)(106466001)(76176011)(50466002)(786003)(44832011)(47776003)(74482002)(33896004)(106002)(54906003)(14444005)(7416002)(486006)(4326008)(66066001)(476003)(5660300001)(426003)(446003)(126002)(11346002)(6246003)(39060400002)(956004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0602MB3242;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b3c9f71-e94b-47c8-7393-08d6046917e0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:HE1PR0602MB3242;
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3242:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3242;20:OxyNExS09ZyP5ET+4H9dBfFh8axvmzJk9MLU6bb4VD4IjHKSEVcFFiPJZBPURUk0fFBEWjnlkYKReJQOkVopsUodcj6tRfOfhQE4egfAKoYYF7FPXJC2UV7eMXfsXtWqGbStjUFL97oUCVEmsQhGMckzl3PTvKmI6i7gPcaYYrZcGdQbo3qXN3Lo86s2c3e6ZVauNiCd4MpVsz21DjbJSgRmQO/css1JEDkh/9/sbR96B5R9hIFnbyeC2kCwL0zU6sPa16X9LQGuRJcqQsaZooZ/YV//8Uwn+tOFV3NS1VMRK/qoFeWS1Jab3c7Zz9cLwXLFuCf62bl6x6va6gHpQUeVGQCOV2nf68XlE4yWuDc8G3jWhJ/Qrl9aplCwKYg3xX6INC8+v+n/hkC408YoiUwnB9Kk3caxWatGjaQwv3tFOL0gFAv2QKp6LZoheEMMKytqiVnGb+EW5jLRVNfeFDsDXLEW9dKlcZ11prt8+TqYbBcCN9yWb/Srtj3i83iQ;4:1zNA9PL0VYmcW+k947ZFyExHR/dfBMAO93sucmuNYrEch9tICGutx0UtBPwvUesw54Ys+OEhCwc51LIX1EK5qt1t/5pSlCHrmJUpJnYY2cB/yVSBuR8Uz9b1GPa+RkFXp/APEaPadmejGUqloqJNO+6idw6xpsu3EHG9z6zVo7Gsxd7Kk0L1qws7NVk18cjHzS/TnLchvNUBMrkk0HeO46bB5/t0vIG1sPIZkJdOLGQpHQxrevjRVP6JI5XDjaful+aEMbdR88UZy9c3xe2Z/g==
X-Microsoft-Antispam-PRVS: <HE1PR0602MB3242F96C8042A8070FE47C15EF3D0@HE1PR0602MB3242.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:HE1PR0602MB3242;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0602MB3242;
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0602MB3242;23:HA2QJxJZkWZKXO1on4Qj8wcPrzOP9UsNl/rtLDM?=
 =?us-ascii?Q?3wU3WiF8fF0lktsVowFI/HAfL/HElIaT1USQmCwtCAd98jDA2HiZ8rQI1s8Q?=
 =?us-ascii?Q?+xqKGH+ChRK2NykMnmxa8jCP2Lyq57Ko0zPNkxc4vfU6waz/7R02VeNTo16f?=
 =?us-ascii?Q?k/yEqcEAHeVFi1g1XN1NS5x97WTCvdFJ4pQFh9B1s5JkrZMRiECkIEh2yShR?=
 =?us-ascii?Q?8QQ3cDRVwfLcKE8I63PIE4esCIEt18SVzCI/16I26hB0jHYsCGebJQi2N/4i?=
 =?us-ascii?Q?STApaNr32r2Glz99xXQ8wCbLWBa1amxQaaO3NNVsxweNZ8HdvA6n9okZTW/N?=
 =?us-ascii?Q?V5jQGhKudnbrDH6xtMYAbIZ/xkNfBvC1GPHGiTcwzwYzDrofZw/ZkPGuwsek?=
 =?us-ascii?Q?W49akg8WTBzBUI5TvnfXdCqcPUFvO4RbgkeYaRf/tG1WZVLl0jxiXXjS/7/a?=
 =?us-ascii?Q?/ZxfLB40pSCXWy01uu4ReZybEhNTuKOYOED05dnEWnGGhRsUIdjA8d1egsad?=
 =?us-ascii?Q?b6hAp3WwATXVm77FKW52/9hXA8oz2MUKjwn1C3qRXxoJqJMINEIQOOrY4VMK?=
 =?us-ascii?Q?R9Vpc7Gkpd1aRWOzljD42kggmNlrkO5H8hn3fmep0jNv3hctIqvif0TbjF/9?=
 =?us-ascii?Q?vzsDtZQXeR+BD7N2tTBs7Nv/Q0ShYJtR7yrLoHorPbK7V2M/3/0KDP6Pc3Os?=
 =?us-ascii?Q?ZPVMWprXMhuNGqntqsVyHucFuBAelrW+g9BHz/qJhj+6JKz1amMxrQ6Z54c6?=
 =?us-ascii?Q?6CpRHu+4E8BcHPLGGHeRGe+6Lo66aV2+pIxIe63jL3bz9T3MSYLXJ9k1ilH4?=
 =?us-ascii?Q?hsuM9aGcpd/OxXHIyHB5G7niwKNxn8h4SkCsSOCr+JEHrMvTslYWnTuHe+HH?=
 =?us-ascii?Q?xeFX+vaaoNUynCHvmuN3p4CJKHQBwAgdWqOp15W6hOD07eRc15YyPpyVhHg/?=
 =?us-ascii?Q?F8/uJjt3/Jub3+ru3F46sNipFmXZZMLKCqf53XPJl2KXUsPjL+GGezFR6omT?=
 =?us-ascii?Q?O+WY1hn+ARxGyb5NML+6I4GMzahZppxRIrpkCJGpTn01Hf1gJJenz/EehFXX?=
 =?us-ascii?Q?SG0OFvbozpfgSiUWQ4zXPln6fjvY8Mu+Kvw+avRhZbJzs9eMl/KBlLjMWWRm?=
 =?us-ascii?Q?0m3D0zZh0cYeN46tPJ9QeVTik8MKlRwdrfmc0YnYxOxGcVXuMksYhfcPANvY?=
 =?us-ascii?Q?BBTMenCaqbMJdyrtT8Ra6fB/5BjsLilTCOLHVcrxhpvbMaJupuQlThr9vYte?=
 =?us-ascii?Q?GiXYiX9hFTdrlw2bTnO3//GF5l6cbIw0evYnUlyZ40Yyu9J64HO3TKPfeF7f?=
 =?us-ascii?Q?DjeFCuUVBz4zffqjcJNAqCFUZ4LwAoMyjSSzQYFMq8srRAEXQCyNzkscNM/M?=
 =?us-ascii?Q?cHQB6j6WX7MvDWwrXpG5D7d0V+lk=3D?=
X-Microsoft-Antispam-Message-Info: OQZ4YgqEB1unz153NdSN+nGT0JmPoY/OWZ3pUe2Gl8Y8dD7pGMLT0TiF79QxvosuQz1xFuu4V65APD6zGVTAzyK/YGOvnxF2EUHz33E7OuS1niVb2R5bxGzcP/hToMJctLwb0bQ1uYID32HmjU8I0XKw8Vyw/RJfMTD8ZuLjNil20yW0PP26u1e+NSQpAbqyw3x+RH23nw9lOJ+nH2mAs0h5yBbibYY7uXCvkLNF+3Y6HtoR5QUlph7CZGnZAoPL+BQ12SLwD3FOgHGc+qo4aLI8lIX+p3iLQli2ZcDa7HOrS+HXNiSWa3TW6L4q3OcqZXN5qWVBCngsFWcOj+EFZlJ7sqw+JWTN1xyGxLX2I4Y=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3242;6:UIEV4XRsNVh0SQE8mqest886ENR7VwnWQFlGHSCvPSM4yiZ6poJKO8CQ3eu/W2umXAag1k6/ujpzYxScoaA4fYC3YJgc2p30Rp75GJDqFZhXVeMqBmB3qQ6S7VbiKOuH3bvf3U2PfRSD8pPhMC9/GAXe77R/Z5m8xs+Hcg99cLvxTw20g5gDlHXO0HSHwDatyRHyU3v3NBhyTV4Qc7Hd2aBz5ZibsH1/4XBtX707GJTTmhPwIE3BcrDDTtiMHrgKwe8s+XhJmQVZsI9ZONKfyYcw5FtJoD66OWmg7IZQttf4OCPyaPnpJM0Y5FRc1xZuCrySDxy4gCD8NAQi+qncKILsD/YOHCPxFR6k8qoFw94/HeiCBBuzSCmxMNhtEoOgpggDI8yV9n9MukKtJt2Nys2qfv+gBHRzGT8l3sFRuNyj6LjHs53pwk0wAHqe3Q1pal4MzzUKRIDMO9P98Q377Q==;5:nBO8x2ly44PGU9jg4/oA3/w4m94pK6WnA+tgqtQJh2Jg9R3pQ2rYq5ZKVFB/6HEYZWjPCso0sndxNVcGy+U/aaKXc1rJBzzU7pIqS2mxj3G8XrWqCyNhs7QgaCqMHbgzWsbEdPoyHf/hKeohXqTjIO796tIi47+uFP/KdTMSn9c=;7:niXUGdvimEcC6Mx/B2npQkmSok8yg4WVZLecJbqyePtyI12PfSlAKQC7CcCNbjfuSMbc/TiiQhDaK1bim/22PDdX9/dYMhxB9zmQy22VTMeqiMDoTxaJ1HIS5YutqYBlM1AAJm3KDiuLu6mtpwpH0GESnuTm8EqgAdodIIcOyomO65dN7DaqVJIvDMlabJKmdb8KWIXjzwlPv5asjz14yrysQKS80z0uzZKTk4eauSqrcXsEEE9Qwa7mW5WHJCgo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 17:44:33.3478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3c9f71-e94b-47c8-7393-08d6046917e0
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, August 17, 2018 5:22:56 PM CEST Moritz Fischer wrote:
> Hi Alan, Federico,
> 
> On Fri, Aug 17, 2018 at 6:19 AM, Alan Tull <atull@kernel.org> wrote:
> > On Fri, Aug 17, 2018, 2:00 AM Federico Vaga <federico.vaga@cern.ch> 
wrote:
> >> Hi Mortiz,
> >> 
> >> I'm not 100% into the problem to understand all cases. I'm putting on
> >> the table the point of view, mainly, of an user. If you say there are
> >> problems here or there I believe you. At the beginning, you did not
> >> say that this interface may introduce problems (and I'm interested in
> >> those problems since I
> >> implemented one and we are using it), but that you fear that it
> >> becomes
> >> the
> >> default (usually, being a default is a good thing).
> >> 
> >> Since you and Alan are working on this for a long time, you can read
> >> each other mind, but I need a more verbose email to understand ^_^'
> >> 
> >> Of course the interface must be safe, I totally agree. In order to
> >> make me understand what are the issues, can you list some of them?
> 
> Say you have kernel drivers (a network driver in the FPGA, or an I2C
> controller) for example bound to hardware on a MMIO bus in the the FPGA.
> You reprogram the FPGA using the debugfs interface, and the drivers don't
> get unloaded correctly, the driver will try to access the registers and
> depending on your system / bus either give you bad values or lock up.
> Now userland locked up your system. Bad.

I think I got confused by your reference to the MMIO, but now it sound like 
it was just a very specific example of a more general problem. Because this 
is true for any device driver for FPGA soft-IP/IP-core, it is not strictly 
an MMIO problem. Am I missing something?

I get the problem, I have to fight with **this** problem daily because I'm 
loading images with:

cat hello.bin > /dev/fpga0

And then, somehow I have to load the device drivers (memory, IRQ, ...). But 
I will not say publicly what I do (it is a "don't try this at home" thing).

> I'm not saying it isn't possible to do this if you're careful, of
> course you could
> first unload the drivers using rrmod and it would work just fine.

Or having some reference counter on the last loaded FPGA image may work. 
This way it will be possible to detect if there are users of the current 
FPGA and inhibit any unwanted FPGA load (like the module counter forbid 
rmmod when the device is in use). If a device driver is using some FPGA 
component the reference counter increase. How to do it? Need more studies, 
but probably this is a safe way that perhaps worth to look at.
 
> I just feel an interface like this might make it easier to create the
> wrong design.
> I've seen plenty of Application notes from vendors where they literally
> did "cat foo.bin > /dev/fpga" followed by mmap(/dev/mem...).

Actually, I'm doing worst than this (to compensate the lack of 
infrastructure). You tried, but you are not scaring me :P
 
> > Before we repeat what the doc l posted says, could you look at it and
> > comment on what I'm not saying there?
> > 
> > https://lkml.org/lkml/2018/8/15/525
> 
> Alan, maybe I didn't express myself well. I'm fine with the debugfs
> interface as a debug interface, just not for general usage ;-) I think
> your document is clear on that.
> 
> Thanks,
> 
> Moritz


-- 
Federico Vaga
[BE-CO-HT]


