Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72663C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8D720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="su1vYpUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8D720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJPOvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:51:48 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:52405
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbeJPOvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPpp0Z+tQ0sVeOIMzzLQ2bPQzrsDd4VegjmbfuEUVX0=;
 b=su1vYpUsqhFKZHAOGYGaiiMIz2pm7Zde1CVt2fkJ0r4xtF9Vuj+Cg1XKsM22wGCbKHNFr4mfLOsZcGWHof4dVEVD9bhj6ZWdtCH8QLrJbLUCXyqAu+97iep4tceNNW9fhlEzUrJ0BozbRRtZuYjy1/2W9YHvR4DdiTWU3mosAVs=
Received: from AM5PR0601CA0038.eurprd06.prod.outlook.com
 (2603:10a6:203:68::24) by VI1PR06MB1630.eurprd06.prod.outlook.com
 (2a01:111:e400:5970::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.23; Tue, 16 Oct
 2018 07:02:37 +0000
Received: from HE1EUR02FT017.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::206) by AM5PR0601CA0038.outlook.office365.com
 (2603:10a6:203:68::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21 via Frontend
 Transport; Tue, 16 Oct 2018 07:02:37 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT017.mail.protection.outlook.com (10.152.10.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.18 via Frontend Transport; Tue, 16 Oct 2018 07:02:36 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 16 Oct
 2018 09:02:18 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Tue, 16 Oct 2018 09:02:17 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] fpga: mgr: add devm_fpga_mgr_create
Date:   Tue, 16 Oct 2018 09:02:17 +0200
Message-ID: <513231489.tkEWzREbj5@pcbe13614>
In-Reply-To: <CANk1AXRoNFqxg3OZLkOsFyn5R+qMPCmoz9MwULfyqwBStzBj7A@mail.gmail.com>
References: <1537978342-17697-1-git-send-email-atull@kernel.org> <1537978342-17697-2-git-send-email-atull@kernel.org> <CANk1AXRoNFqxg3OZLkOsFyn5R+qMPCmoz9MwULfyqwBStzBj7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(478600001)(229853002)(46406003)(86362001)(97756001)(106466001)(8676002)(9576002)(6916009)(6116002)(23726003)(786003)(9686003)(3450700001)(426003)(336012)(4744004)(575784001)(356004)(5660300001)(8936002)(16526019)(186003)(316002)(26005)(6246003)(11346002)(47776003)(476003)(126002)(446003)(76176011)(246002)(44832011)(486006)(305945005)(33716001)(2906002)(4326008)(7636002)(7736002)(230700001)(54906003)(50466002)(74482002)(106002)(33896004)(43066004)(53546011)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR06MB1630;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad6196be-0c5f-41d8-d882-08d633355afc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:VI1PR06MB1630;
X-MS-TrafficTypeDiagnostic: VI1PR06MB1630:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB1630;20:w3xm/f7uzYEKeS0ihckFD0X9A5mw3ifpKlkhsBGe12bPuwZb82g9HyaRMhBmSt0kg6XpX/xMlmAjpHw3MpXQHNJuM9FvbuJKvf93GWx84wD60j7k84rv4RRb1pm3tz7DCGDBtXiSThtVLiVvHNpLoAFY3uC/dOmHW1UnmSVeMW11cxBLIkvdzXCBjpBrF92rIZhZlIdQFl3/L2OKKyk2mgq3pNHV1MrnWKhSY+TScetUtzBqbLU2Dd29xXuorsLwldxu0AblNJrBPfCufUQvjw502ZmPo42GmMIEYN3Ttlkv4cokiOkJ+C1VLt85l6pqMrkDetdqEcvv6YXZGedmR9vxtnr3J8IqOigig8A+dz1Ci9iUXOHHcsnmH+m4iErHIPc09GDLI5WaHBXsITWe8EExSWABRocAC7VGMrQ/yci6oYMsvpn+UVt4BOY/QKCOIAfE5PM/Cu0crp0ZUL7lAbKBpWnQZgzm7X56uvpn1JCLshJQ9ilMa0yVWS4hxIXZ;4:ub/Jd5V+VvyILwgXXwPsX782yzgewJj0xOSXOOBDms71ixo9xmS91/e6AQYBbED4jj3QUISHJ0QBixYbjXjZEfHYjsH4oW8ER/Mv3qJp4KAsfl8eLn+u6RS2GbqUjatoPpe8vII2o2cbNYVXJqxSIcPtlLDyf9XT2LqRVEOtVMB4v7TvoNbThYHPNzsEst2W4z2gFjahywxfWJQ6qauZRNDVNmUXTZzzMV0HskmnjHVtNIMr/8+eqdGZX3RfU8rgjBHskhEEOYApgeUTrCibCQ==
X-Microsoft-Antispam-PRVS: <VI1PR06MB16308F9E5BD85B1E81CC7878EFFE0@VI1PR06MB1630.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR06MB1630;BCL:0;PCL:0;RULEID:;SRVR:VI1PR06MB1630;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR06MB1630;23:HZmZDQeQ0BGm2MMG2USaYJHfWoUswuj8fqzrPqKxb?=
 =?us-ascii?Q?Tm/xMuqU0o7nu1Y7F3FWVH3B9LjtkhCrGJjET3PmtnCBytKCCdve3jIMwOO9?=
 =?us-ascii?Q?BgwvdczSZBs9nIlOksUuBXa0vHDkK9CxoVkmvewbrpLgOQz5bpFnp7ythOhm?=
 =?us-ascii?Q?4SPYgo8fTiommU8BETvnrdI0Iq2SbymaNVUcpA+us4p9Frhj4rlgbkTExvMR?=
 =?us-ascii?Q?TsTdJ6t+jhKt7iGS1pBH1MLnJMb0xoKVX44K2iwO32gX0m1AG77hLkPSNYJt?=
 =?us-ascii?Q?X5LFq96SM2qEB9cnGG9M7lY+GmdPknkUUK1ZSuHxucWKMLlfmrrbdloR8sV3?=
 =?us-ascii?Q?ol5G1/sPdUyJtab4bIQQCoZuN7TZgsjVo1LMiagdq3bUJbsWpn/P6ojJwzux?=
 =?us-ascii?Q?c441gt8hqstMCr0qaZ4w9RDDcA3eMAwXtWrZhxylcCn5yz0iHK/NyQVOV5iO?=
 =?us-ascii?Q?39Yf98wyV3zGng1qMDrqi+ZJ51s2M0RLjChFb9tJ/GKLDQFIuiExfOPWqim9?=
 =?us-ascii?Q?Z4CKtO56k6fuvS84I0KdWYvqHEaIAKe2Dk6Tz3i/uEl18FcmV5GoW/IBdNdg?=
 =?us-ascii?Q?xY5T+ARShRhm7qqPyu5aaK9rRXa2mzUNR/CM39NvhVJkrkEUyfW8yC7sDJEi?=
 =?us-ascii?Q?5A8LHhxXJYYXuyYaagqTIkCxfviNlNLp52QPKIG7r25o5wx2aX+WMbF5cTUs?=
 =?us-ascii?Q?JB/2W3vKPQKVdlo7zFOF9zY9cggGIotC5v9JTtQQwaXT4Vrdj71P1DSt5lqJ?=
 =?us-ascii?Q?mdtF5elS4WlnB6IIHQ2YspZspjeRXP5xIMtAahrIG3PTk5UrPRyhQ218FO4d?=
 =?us-ascii?Q?lCQv8NpItEUp13OSyPdeMfsFNNGmdKsZS/VqIR0d3GG2JLJlYoeFSRUxDz6g?=
 =?us-ascii?Q?js3w5zjl0NiN0cFBGKCSO0Wd6xaq6dC3IstUqW3TOdeGe7w0A5ArdoENL2CZ?=
 =?us-ascii?Q?NP4U+/FnOAmrb/KFh9AauI6+LBmV9++IyGIwnMTVZ/zjKMZm1XJlb33aqWI8?=
 =?us-ascii?Q?73lS/G1F7CvrseuXK+/DZLQggcUYbg8UbnpWQZyD4/5/1aitKTZmgKwu19MJ?=
 =?us-ascii?Q?4C1Kv5SM4J+fM7Tjgkgz+dI1pG0qyzo6B0AKWwLCAJcEMOafz0j9Mkn9VM9V?=
 =?us-ascii?Q?dngACoqYYX/GFpvQtI6w0XfaJSv1F8ivUE9M4L4xz0UoTz6bNaQL/gCtg6t/?=
 =?us-ascii?Q?vbwo97IN7mECpNG3us1ZZKGFkZqaKJGUenSfyHVUcxhFO9dB5UysRNQydn5H?=
 =?us-ascii?Q?GI/96x6axU+qnLmsbM3gxyYwl3nQrqfaGr3lwxpglUW4NmhX3PH4qS03LjG6?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: K4ubqlSEGmGeqsqJC251s35460Xi54AofXgGMJWGpiF8NzEBD4ktVjzwCN/c2jOlPu31agXIgwnJAWZsBxzcM4byUMmMUQYVpNDbRwmGQjnPdO7WDkJSGqcEGBVP2ywU4F6aAAIK6iznGvgTRLpfUrE3wNUMw3f76+8wZoFyPSgI9ZTTWtyQdnpeOpdz6YwHwkA66OxHno+YShrk4sUCDoiNppA+LLft9WyFlcz9qRa7/kwvcfZvwJ6m8j/2pUTdljF0cv4Py2OCHbdVblc88QT3hfQs/sNLSrGquvVkmXC6GaPpdR7iNoCdyaQuWBXFgAg5u2bbXfGUojqVnp3j7CTpUDthLgj0n+Aj+pClj3M=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB1630;6:PtGGFoVEZ3PODXpb1wN4kBDtLCsUUrzwv+2bG8FTqBCP5XTeVz//btvhQQEHQm0Vti2H5vaAbYUCDC1ZoEhFY6cf1rbnqN1T+LKwh+D7lBfp4WwNlgPxTnBY6xxt13GyT1O+jz/zpAqXFg4DlgOgsVDtoybxrF/LGWZDDW4vcUOxm3uFfePZCZNE3MSyX9taOzbkc6plAwkfUz5PxLSMynM3tvUrxmpyro3AC9K3j9E9uC8wwg5SVgYBmQu4MBE6SKL+SOcmRn253b71Ggi9dUeB8fhhyOKDfop324T8gqBFhv66WZFLhf31BqZ7kbuFVaH/Y7wQeAJzm5M1Z67q7h6Wjh5pdkY25NJ4CB9Af28pwUwdAkh8zdlx5rCq3PjySxC5GlSDbA49mf1Dy+ZeljwCQ28fPrJxnd7XXEHYkeT6reI2lUr2z405H+Hn6Txzaw5ZS53TvbuJe8AGK05lrA==;5:VS976Jk28gWXgKtbRBqDHPz/JVsGmJwemwFNoP4BAw2v5Pr7+JVVAlaazifjNp/vLcfc6fHboBC0+t/Byqz0ukUrrOlsXCwdTekSVwtq3AVjwvQwhnC0PN4+acXeZPscIYS17uWaNlzavprPlURKuzd5jEwTHEBS7O+QCFz4hSM=;7:fbiBQCANvmlyFSDD0soAzs3xW+Boqwdycg3K7SclsjGEqlZBR7ee/2as24D9S65Z0/1NvkBn6Qt1ljCRETMFHY2YDypLdH3Hd1h99m8yTavjxnYaRNZaVBTwWn59CiDkLziu6udVHbZO8mYr4iyqOODV+Pe21h0CRLfLchOaxBw1LoiLBOScUlFgMOfJznHLoulHrPhMkELInlK5d9GLdlJh964VPyOXsUD09Y1j2Bo3VsFCiU8AZYxmGsIzVajb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 07:02:36.6838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6196be-0c5f-41d8-d882-08d633355afc
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB1630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

not comment here

On Monday, October 15, 2018 4:54:25 PM CEST Alan Tull wrote:
> On Wed, Sep 26, 2018 at 11:12 AM Alan Tull <atull@kernel.org> wrote:
> 
> Any other comments on this patchset?
> 
> Alan
> 
> > Add devm_fpga_mgr_create() which is the managed
> > version of fpga_mgr_create().
> > 
> > Change current FPGA manager drivers to use
> > devm_fpga_mgr_create()
> > 
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > Suggested-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > v2: add suggested-by
> > v3: remove some unclear documentation about fpga_mgr_unregister
> > ---
> > 
> >  Documentation/driver-api/fpga/fpga-mgr.rst | 13 +++---
> >  drivers/fpga/altera-cvp.c                  |  8 ++--
> >  drivers/fpga/altera-pr-ip-core.c           |  9 +----
> >  drivers/fpga/altera-ps-spi.c               | 11 ++---
> >  drivers/fpga/dfl-fme-mgr.c                 | 11 ++---
> >  drivers/fpga/fpga-mgr.c                    | 64
> >  ++++++++++++++++++++++++++---- drivers/fpga/ice40-spi.c                 
> >   | 10 ++---
> >  drivers/fpga/machxo2-spi.c                 | 11 ++---
> >  drivers/fpga/socfpga-a10.c                 |  5 +--
> >  drivers/fpga/socfpga.c                     | 10 ++---
> >  drivers/fpga/ts73xx-fpga.c                 | 11 ++---
> >  drivers/fpga/xilinx-spi.c                  | 12 ++----
> >  drivers/fpga/zynq-fpga.c                   |  5 +--
> >  include/linux/fpga/fpga-mgr.h              |  4 ++
> >  14 files changed, 97 insertions(+), 87 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst
> > b/Documentation/driver-api/fpga/fpga-mgr.rst index 82b6dbb..db8885e
> > 100644
> > --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> > +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> > 
> > @@ -49,18 +49,14 @@ probe function calls fpga_mgr_register(), such as::
> >                  * them in priv
> >                  */
> > 
> > -               mgr = fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> > -                                     &socfpga_fpga_ops, priv);
> > +               mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA
> > Manager", +                                          &socfpga_fpga_ops,
> > priv);> 
> >                 if (!mgr)
> >                 
> >                         return -ENOMEM;
> >                 
> >                 platform_set_drvdata(pdev, mgr);
> > 
> > -               ret = fpga_mgr_register(mgr);
> > -               if (ret)
> > -                       fpga_mgr_free(mgr);
> > -
> > -               return ret;
> > +               return fpga_mgr_register(mgr);
> > 
> >         }
> >         
> >         static int socfpga_fpga_remove(struct platform_device *pdev)
> > 
> > @@ -170,6 +166,9 @@ API for implementing a new FPGA Manager driver
> > 
> >     :functions: fpga_manager_ops
> >  
> >  .. kernel-doc:: drivers/fpga/fpga-mgr.c
> > 
> > +   :functions: devm_fpga_mgr_create
> > +
> > +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> > 
> >     :functions: fpga_mgr_create
> >  
> >  .. kernel-doc:: drivers/fpga/fpga-mgr.c
> > 
> > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > index 7fa7936..610a155 100644
> > --- a/drivers/fpga/altera-cvp.c
> > +++ b/drivers/fpga/altera-cvp.c
> > @@ -453,8 +453,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> > 
> >         snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
> >         
> >                  ALTERA_CVP_MGR_NAME, pci_name(pdev));
> > 
> > -       mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
> > -                             &altera_cvp_ops, conf);
> > +       mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> > +                                  &altera_cvp_ops, conf);
> > 
> >         if (!mgr) {
> >         
> >                 ret = -ENOMEM;
> >                 goto err_unmap;
> > 
> > @@ -463,10 +463,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> > 
> >         pci_set_drvdata(pdev, mgr);
> >         
> >         ret = fpga_mgr_register(mgr);
> > 
> > -       if (ret) {
> > -               fpga_mgr_free(mgr);
> > +       if (ret)
> > 
> >                 goto err_unmap;
> > 
> > -       }
> > 
> >         ret = driver_create_file(&altera_cvp_driver.driver,
> >         
> >                                  &driver_attr_chkcfg);
> > 
> > diff --git a/drivers/fpga/altera-pr-ip-core.c
> > b/drivers/fpga/altera-pr-ip-core.c index 65e0b6a..a7a3bf0 100644
> > --- a/drivers/fpga/altera-pr-ip-core.c
> > +++ b/drivers/fpga/altera-pr-ip-core.c
> > @@ -177,7 +177,6 @@ int alt_pr_register(struct device *dev, void __iomem
> > *reg_base)> 
> >  {
> >  
> >         struct alt_pr_priv *priv;
> >         struct fpga_manager *mgr;
> > 
> > -       int ret;
> > 
> >         u32 val;
> >         
> >         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > 
> > @@ -192,17 +191,13 @@ int alt_pr_register(struct device *dev, void __iomem
> > *reg_base)> 
> >                 (val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
> >                 (int)(val & ALT_PR_CSR_PR_START));
> > 
> > -       mgr = fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> > +       mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         dev_set_drvdata(dev, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  EXPORT_SYMBOL_GPL(alt_pr_register);
> > 
> > diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> > index 24b25c6..33aafda 100644
> > --- a/drivers/fpga/altera-ps-spi.c
> > +++ b/drivers/fpga/altera-ps-spi.c
> > @@ -239,7 +239,6 @@ static int altera_ps_probe(struct spi_device *spi)
> > 
> >         struct altera_ps_conf *conf;
> >         const struct of_device_id *of_id;
> >         struct fpga_manager *mgr;
> > 
> > -       int ret;
> > 
> >         conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> >         if (!conf)
> > 
> > @@ -275,18 +274,14 @@ static int altera_ps_probe(struct spi_device *spi)
> > 
> >         snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
> >         
> >                  dev_driver_string(&spi->dev), dev_name(&spi->dev));
> > 
> > -       mgr = fpga_mgr_create(&spi->dev, conf->mgr_name,
> > -                             &altera_ps_ops, conf);
> > +       mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> > +                                  &altera_ps_ops, conf);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         spi_set_drvdata(spi, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  
> >  static int altera_ps_remove(struct spi_device *spi)
> > 
> > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> > index 9f045d0..76f3770 100644
> > --- a/drivers/fpga/dfl-fme-mgr.c
> > +++ b/drivers/fpga/dfl-fme-mgr.c
> > @@ -287,7 +287,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
> > 
> >         struct fme_mgr_priv *priv;
> >         struct fpga_manager *mgr;
> >         struct resource *res;
> > 
> > -       int ret;
> > 
> >         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >         if (!priv)
> > 
> > @@ -309,19 +308,15 @@ static int fme_mgr_probe(struct platform_device
> > *pdev)> 
> >         fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> > 
> > -       mgr = fpga_mgr_create(dev, "DFL FME FPGA Manager",
> > -                             &fme_mgr_ops, priv);
> > +       mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> > +                                  &fme_mgr_ops, priv);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         mgr->compat_id = compat_id;
> >         platform_set_drvdata(pdev, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  
> >  static int fme_mgr_remove(struct platform_device *pdev)
> > 
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index a41b07e..c386681 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -558,6 +558,9 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> > 
> >   * @mops:      pointer to structure of fpga manager ops
> >   * @priv:      fpga manager private data
> >   *
> > 
> > + * The caller of this function is responsible for freeing the struct with
> > + * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
> > + *
> > 
> >   * Return: pointer to struct fpga_manager or NULL
> >   */
> >  
> >  struct fpga_manager *fpga_mgr_create(struct device *dev, const char
> >  *name,
> > 
> > @@ -618,8 +621,8 @@ struct fpga_manager *fpga_mgr_create(struct device
> > *dev, const char *name,> 
> >  EXPORT_SYMBOL_GPL(fpga_mgr_create);
> >  
> >  /**
> > 
> > - * fpga_mgr_free - deallocate a FPGA manager
> > - * @mgr:       fpga manager struct created by fpga_mgr_create
> > + * fpga_mgr_free - free a FPGA manager created with fpga_mgr_create()
> > + * @mgr:       fpga manager struct
> > 
> >   */
> >  
> >  void fpga_mgr_free(struct fpga_manager *mgr)
> >  {
> > 
> > @@ -628,9 +631,55 @@ void fpga_mgr_free(struct fpga_manager *mgr)
> > 
> >  }
> >  EXPORT_SYMBOL_GPL(fpga_mgr_free);
> > 
> > +static void devm_fpga_mgr_release(struct device *dev, void *res)
> > +{
> > +       struct fpga_manager *mgr = *(struct fpga_manager **)res;
> > +
> > +       fpga_mgr_free(mgr);
> > +}
> > +
> > +/**
> > + * devm_fpga_mgr_create - create and initialize a managed FPGA manager
> > struct + * @dev:       fpga manager device from pdev
> > + * @name:      fpga manager name
> > + * @mops:      pointer to structure of fpga manager ops
> > + * @priv:      fpga manager private data
> > + *
> > + * This function is intended for use in a FPGA manager driver's probe
> > function. + * After the manager driver creates the manager struct with
> > + * devm_fpga_mgr_create(), it should register it with
> > fpga_mgr_register().  The + * manager driver's remove function should
> > call fpga_mgr_unregister().  The + * manager struct allocated with this
> > function will be freed automatically on + * driver detach.  This includes
> > the case of a probe function returning error + * before calling
> > fpga_mgr_register(), the struct will still get cleaned up. + *
> > + * Return: pointer to struct fpga_manager or NULL
> > + */
> > +struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char
> > *name, +                                         const struct
> > fpga_manager_ops *mops, +                                         void
> > *priv)
> > +{
> > +       struct fpga_manager **ptr, *mgr;
> > +
> > +       ptr = devres_alloc(devm_fpga_mgr_release, sizeof(*ptr),
> > GFP_KERNEL); +       if (!ptr)
> > +               return NULL;
> > +
> > +       mgr = fpga_mgr_create(dev, name, mops, priv);
> > +       if (!mgr) {
> > +               devres_free(ptr);
> > +       } else {
> > +               *ptr = mgr;
> > +               devres_add(dev, ptr);
> > +       }
> > +
> > +       return mgr;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
> > +
> > 
> >  /**
> >  
> >   * fpga_mgr_register - register a FPGA manager
> > 
> > - * @mgr:       fpga manager struct created by fpga_mgr_create
> > + * @mgr: fpga manager struct
> > 
> >   *
> >   * Return: 0 on success, negative error code otherwise.
> >   */
> > 
> > @@ -661,8 +710,10 @@ int fpga_mgr_register(struct fpga_manager *mgr)
> > 
> >  EXPORT_SYMBOL_GPL(fpga_mgr_register);
> >  
> >  /**
> > 
> > - * fpga_mgr_unregister - unregister and free a FPGA manager
> > - * @mgr:       fpga manager struct
> > + * fpga_mgr_unregister - unregister a FPGA manager
> > + * @mgr: fpga manager struct
> > + *
> > + * This function is intended for use in a FPGA manager driver's remove
> > function.> 
> >   */
> >  
> >  void fpga_mgr_unregister(struct fpga_manager *mgr)
> >  {
> > 
> > @@ -681,9 +732,6 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
> > 
> >  static void fpga_mgr_dev_release(struct device *dev)
> >  {
> > 
> > -       struct fpga_manager *mgr = to_fpga_manager(dev);
> > -
> > -       fpga_mgr_free(mgr);
> > 
> >  }
> >  
> >  static int __init fpga_mgr_class_init(void)
> > 
> > diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> > index 5981c7e..6154661 100644
> > --- a/drivers/fpga/ice40-spi.c
> > +++ b/drivers/fpga/ice40-spi.c
> > @@ -175,18 +175,14 @@ static int ice40_fpga_probe(struct spi_device *spi)
> > 
> >                 return ret;
> >         
> >         }
> > 
> > -       mgr = fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
> > -                             &ice40_fpga_ops, priv);
> > +       mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
> > +                                  &ice40_fpga_ops, priv);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         spi_set_drvdata(spi, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  
> >  static int ice40_fpga_remove(struct spi_device *spi)
> > 
> > diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> > index a582e00..4d8a876 100644
> > --- a/drivers/fpga/machxo2-spi.c
> > +++ b/drivers/fpga/machxo2-spi.c
> > @@ -356,25 +356,20 @@ static int machxo2_spi_probe(struct spi_device *spi)
> > 
> >  {
> >  
> >         struct device *dev = &spi->dev;
> >         struct fpga_manager *mgr;
> > 
> > -       int ret;
> > 
> >         if (spi->max_speed_hz > MACHXO2_MAX_SPEED) {
> >         
> >                 dev_err(dev, "Speed is too high\n");
> >                 return -EINVAL;
> >         
> >         }
> > 
> > -       mgr = fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
> > -                             &machxo2_ops, spi);
> > +       mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA
> > Manager",
> > +                                  &machxo2_ops, spi);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         spi_set_drvdata(spi, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  
> >  static int machxo2_spi_remove(struct spi_device *spi)
> > 
> > diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> > index be30c48..573d88b 100644
> > --- a/drivers/fpga/socfpga-a10.c
> > +++ b/drivers/fpga/socfpga-a10.c
> > @@ -508,8 +508,8 @@ static int socfpga_a10_fpga_probe(struct
> > platform_device *pdev)> 
> >                 return -EBUSY;
> >         
> >         }
> > 
> > -       mgr = fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
> > -                             &socfpga_a10_fpga_mgr_ops, priv);
> > +       mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
> > +                                  &socfpga_a10_fpga_mgr_ops, priv);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> > 
> > @@ -517,7 +517,6 @@ static int socfpga_a10_fpga_probe(struct
> > platform_device *pdev)> 
> >         ret = fpga_mgr_register(mgr);
> >         if (ret) {
> > 
> > -               fpga_mgr_free(mgr);
> > 
> >                 clk_disable_unprepare(priv->clk);
> >                 return ret;
> >         
> >         }
> > 
> > diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> > index 959d71f..4a8a2fc 100644
> > --- a/drivers/fpga/socfpga.c
> > +++ b/drivers/fpga/socfpga.c
> > @@ -571,18 +571,14 @@ static int socfpga_fpga_probe(struct platform_device
> > *pdev)> 
> >         if (ret)
> >         
> >                 return ret;
> > 
> > -       mgr = fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> > -                             &socfpga_fpga_ops, priv);
> > +       mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> > +                                  &socfpga_fpga_ops, priv);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         platform_set_drvdata(pdev, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  
> >  static int socfpga_fpga_remove(struct platform_device *pdev)
> > 
> > diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> > index 08efd18..dc22a58 100644
> > --- a/drivers/fpga/ts73xx-fpga.c
> > +++ b/drivers/fpga/ts73xx-fpga.c
> > @@ -118,7 +118,6 @@ static int ts73xx_fpga_probe(struct platform_device
> > *pdev)> 
> >         struct ts73xx_fpga_priv *priv;
> >         struct fpga_manager *mgr;
> >         struct resource *res;
> > 
> > -       int ret;
> > 
> >         priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
> >         if (!priv)
> > 
> > @@ -133,18 +132,14 @@ static int ts73xx_fpga_probe(struct platform_device
> > *pdev)> 
> >                 return PTR_ERR(priv->io_base);
> >         
> >         }
> > 
> > -       mgr = fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
> > -                             &ts73xx_fpga_ops, priv);
> > +       mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
> > +                                  &ts73xx_fpga_ops, priv);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         platform_set_drvdata(pdev, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  
> >  static int ts73xx_fpga_remove(struct platform_device *pdev)
> > 
> > diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> > index 8d19459..469486b 100644
> > --- a/drivers/fpga/xilinx-spi.c
> > +++ b/drivers/fpga/xilinx-spi.c
> > @@ -144,7 +144,6 @@ static int xilinx_spi_probe(struct spi_device *spi)
> > 
> >  {
> >  
> >         struct xilinx_spi_conf *conf;
> >         struct fpga_manager *mgr;
> > 
> > -       int ret;
> > 
> >         conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> >         if (!conf)
> > 
> > @@ -167,18 +166,15 @@ static int xilinx_spi_probe(struct spi_device *spi)
> > 
> >                 return PTR_ERR(conf->done);
> >         
> >         }
> > 
> > -       mgr = fpga_mgr_create(&spi->dev, "Xilinx Slave Serial FPGA
> > Manager", -                             &xilinx_spi_ops, conf);
> > +       mgr = devm_fpga_mgr_create(&spi->dev,
> > +                                  "Xilinx Slave Serial FPGA Manager",
> > +                                  &xilinx_spi_ops, conf);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> >         
> >         spi_set_drvdata(spi, mgr);
> > 
> > -       ret = fpga_mgr_register(mgr);
> > -       if (ret)
> > -               fpga_mgr_free(mgr);
> > -
> > -       return ret;
> > +       return fpga_mgr_register(mgr);
> > 
> >  }
> >  
> >  static int xilinx_spi_remove(struct spi_device *spi)
> > 
> > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > index 3110e00..bb82efe 100644
> > --- a/drivers/fpga/zynq-fpga.c
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -614,8 +614,8 @@ static int zynq_fpga_probe(struct platform_device
> > *pdev)> 
> >         clk_disable(priv->clk);
> > 
> > -       mgr = fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
> > -                             &zynq_fpga_ops, priv);
> > +       mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
> > +                                  &zynq_fpga_ops, priv);
> > 
> >         if (!mgr)
> >         
> >                 return -ENOMEM;
> > 
> > @@ -624,7 +624,6 @@ static int zynq_fpga_probe(struct platform_device
> > *pdev)> 
> >         err = fpga_mgr_register(mgr);
> >         if (err) {
> >         
> >                 dev_err(dev, "unable to register FPGA manager\n");
> > 
> > -               fpga_mgr_free(mgr);
> > 
> >                 clk_unprepare(priv->clk);
> >                 return err;
> >         
> >         }
> > 
> > diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> > index 8ab5df7..e8ca62b 100644
> > --- a/include/linux/fpga/fpga-mgr.h
> > +++ b/include/linux/fpga/fpga-mgr.h
> > @@ -198,4 +198,8 @@ void fpga_mgr_free(struct fpga_manager *mgr);
> > 
> >  int fpga_mgr_register(struct fpga_manager *mgr);
> >  void fpga_mgr_unregister(struct fpga_manager *mgr);
> > 
> > +struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char
> > *name, +                                         const struct
> > fpga_manager_ops *mops, +                                         void
> > *priv);
> > +
> > 
> >  #endif /*_LINUX_FPGA_MGR_H */
> > 
> > --
> > 2.7.4




