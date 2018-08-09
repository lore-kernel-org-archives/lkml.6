Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C0AC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B99721C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="fTmm+udA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B99721C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeHIExG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:53:06 -0400
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:36420
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeHIExG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Skpc6a+ZBvHSTVFtrzB4Mbf3KftALJPhSRmd5YnY8bQ=;
 b=fTmm+udAMZI8LDgYLKSPij0sG7TWEsSQinW9huttcVnjuQrT6DPEutvzr2WMC3u+m3FV+5AczlvyEN7QjN/tbBoqdzOIntYfIHPjuKNgPZ562neCYMscN3IeXCdXHosb8IV0RcENcDaYxQ/pqUHQJVloa7XosVQ42cnv7SSj0H4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Thu, 9 Aug
 2018 02:30:33 +0000
Date:   Thu, 9 Aug 2018 10:27:59 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH mmc-next v3 0/3] solve SDHCI DWC MSHC 128MB DMA boundary
 limitation
Message-ID: <20180809102759.191d211e@xhacker.debian>
In-Reply-To: <20180730104228.28b58bd0@xhacker.debian>
References: <20180730104228.28b58bd0@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To BLUPR0301MB1571.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620b0aed-1034-4a84-ff1b-08d5fda0160c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1571;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;3:1j0vnUDXRtW9ZrgSxFuBgPalkBKBa8vO+ZMX9s9y49F97CtOxyte6f8sDa5QLLfAYx2ZcpQLwN+byM5nSA+id82Ch6l4V+TnGEdYhFDRwZDFCH7mxwBmPwJkx9ArHgdffFkknfL/uUHNkzes4qUwxbMoZ3P3tbeqfVCvnPfrgO/5ATKWh0GNOzLmUMQ/xUdvLNgjBTGt3+Y/+Qs4N3Yn+LNDNDvE5BfStyYzhiukbKep1IZgIstoskHFikhK48Jg;25:SCbS/4m7ajUOqr1G6T+4y5l+EKpWgAajAQuZhIKson/Dsu0pw04k6jzbyuBYMmwiidvsO60Aig3lj20SJ084j5RxtPB+o1/UfJGfef3QosC+YLvTexSRmPqJb78P1M2rQ9038Nw4Ak6eoztKsAN1D+MMFikCjQyx52Mnt3Mg+gbSMT2/egVTwUGdxhA26KfJZqODTOdKNjMwgbb++4pMwJlk2aompODD0DQYSORNi7NGkeFI3gIayDn6jDWqN126vuhzosrA3pM3ujpm5PLzYWxB03UCz309CQ0GOdiettglr44dIygxnm3UEgLer9LPn3iyawDfQCx3YTcq9IjBDw==;31:zD+vWWmlur9wvGAFjU7T/9U8PfeAMGkiSIfufYl/SVKTASNNFb3dTqMJVy2XSb+EQxFXO4Y6LWmiZDwXrGOXYIh0BXPqUqJ4HKF4OWFjwuOHU6GOqaR1etYOxkhya9E4Wn1nfApvQyYDZKKvbKIClmH0Xk4O/U15bUmyyoHdZfFQ7xWxO3gb1WsTrHHBIOxnsTX/BOqCOCW5itp2SB+ZQ+/2hbZy12PwHoDoT8zVPqE=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1571:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;20:UY0UTImHVdRMEHNRUmGnbmWKQcMbPMW750q2BN4sNRXZ85+jbASG4cn2s/oQIpwQKTGfdp6AQKlKcsAbVlkiMDFMMl7l1St5lyYj5AUCN3c9FHwMAgTG2j96rAh4nreG0vT+LuhYbBwQJh3xZsbkwzvt9f1PO6yQ/hKQPVtbl2Ysy57QhVFgWi/PQvwGXnuocfsl/N4J3d/qePsdjlrlJKl7BcVdbsan9f8SgKtczFHvEQdZQyp24jFSQJnnmX/CLRwmVDXCYLInb6C9bgxjgjyt5ta1GhVmp3BQg0xpQjt0j5Ee+OYSgRyqhxneqGOenVZ5vf9fa21dHK88EsyeRozDvSWQjQOyUSWq73yDsqFfIFhCmyurtIaX4fFzag1NgJovjd+X7jvFMnK19PT8UpyF1+eehNHUX8O68tbFnJjllCvqU6zElTzkhWxCK3rlHTXQKYNzNOZg/TstgVQRK7A/CSuLOSWN+pyLTMoXJjHIWBFaLM7hB7+/N2YhmGbi;4:E6eolSY4f6NiRJ9JB5X+JqU+DORk6IrpU32C6WyNEOXm7HcaeF1IZXUEcWTngnK5ux3KorwtL1rQwAQC0h/g5TfKTANyFLATrTrRbldxaKFhN/56XoqYR0Y64d+rKECj69L4BFYwhiWBp/HeP1nocVsskZv3ijt3jtyv0v9daqSqGyksNP+sfxJYpzJJZJ+SKrE2wa1rxG8UEl+kuDVbW5Is8q6V4U0SBe7DhfVrj+PEtq4wLoByr+HLeDopKCpoSGrXVFhmBFj0091jW4/waA==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1571691BA954D3C5DB21B1C7ED250@BLUPR0301MB1571.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1571;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1571;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(51874003)(76176011)(5660300001)(7696005)(52116002)(33896004)(14444005)(50466002)(6666003)(47776003)(53936002)(68736007)(50226002)(476003)(446003)(11346002)(26005)(55016002)(386003)(72206003)(6506007)(66066001)(8936002)(217873002)(110136005)(316002)(486006)(9686003)(956004)(478600001)(8676002)(23726003)(229853002)(4326008)(97736004)(25786009)(81166006)(230700001)(81156014)(106356001)(305945005)(7736002)(105586002)(186003)(16526019)(3846002)(1076002)(6116002)(6246003)(2906002)(86362001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1571;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1571;23:MrNJ3c2YjxmlnUu6389PQsKDS/nfEzREc3ajpwi?=
 =?us-ascii?Q?o9bHRs0Q96LVPe6kmZfjc4ySfZ6IE/ikBDKgIu3agFiRRkj7DvwY2vCKp7pg?=
 =?us-ascii?Q?ezSVFDTbP6AmZiOKKesgMaWKwYRJgkBjnMeV341oUAeiSkBAtuxwHt9ETC+y?=
 =?us-ascii?Q?FA9IjWm8HETiXlQ6JKbTL5vxwgwrcj1ZRp5ZoEXzHgDBvjvqzNjhxaAD5UmU?=
 =?us-ascii?Q?8FjGayar7aLqQpxnvWmfOkcaVL+HQ6RrOREoOHmfiOsOPKwYb33/7Ui+2per?=
 =?us-ascii?Q?3/lT6/+7DBzdkj/AIiEdarITtEoGpW8ufj8mueR0gnoUi6elBiqzv5sJ+3qy?=
 =?us-ascii?Q?8lNAKCseQr6Zm49q6e4+S08m6u4Ru6OY9OC03ez0a5ux8lqqfiLnctJsmbrq?=
 =?us-ascii?Q?qx4Dq8K6pMhzbGhSNwMr0i3ikj9FOH3nM0wua/Mmxkfhfil0RIu9KdP4Cfl/?=
 =?us-ascii?Q?tBVHS7NvEYyzJrEvYKuFuvWI1NQq7eq691YfHQW0q0OHvicGzSTWschIEXU5?=
 =?us-ascii?Q?DwSJlzQvxSZSekCxS63ClI9nfCBza8jrBR8w8pjPL9DVQUaDPsYrxoWaoCA9?=
 =?us-ascii?Q?Shc1U+cfiBOP1ZtFrgiF5Mak/Ptt1wQnUazDGUSNVLWlgx377jMxAuemZLFi?=
 =?us-ascii?Q?EM1eqkk+8mldNTcptdlXdZJtSi9Squ1x/4DjP9mrVVS3kljxCqPKjPrToLxk?=
 =?us-ascii?Q?RTujQpZL17+lJ3D1AxTLrkDIbbf20ukaBUuAKtKorR+rONBGlpRNE5kp0OnY?=
 =?us-ascii?Q?+yqj92b00OggtfyoBw0HmTOLLd/6kUGkDHAwZlzlcciHBJKY1HBv8S7aDM/x?=
 =?us-ascii?Q?CT/wW7s3UkYmQ8U5Y4g0RXy5Ec4aDmrX/Gp1hretK5geOYl+urRGhywQev5a?=
 =?us-ascii?Q?92jtHEd4Unk6b9VELZLRAQaZXCASuRc7lsBwcQfhkz7KICp/ADlttcP/WSYy?=
 =?us-ascii?Q?ijErHtvXg+HaqpM9CcfBYfwVuRQkrpNez6pJ8+eBZUf68d/6ZoBLg2HZ6EDf?=
 =?us-ascii?Q?r689sXkHeCVKwPFRtyZf9tPJQD0AOY/wUC/M2f3WAdk/uehKN+PFBuSqPB6j?=
 =?us-ascii?Q?tsqAbPLTujKNCVwwByXWNAdS/0Kb97WJeHGsuIzZnRomAYLQDqln3OuZgWlV?=
 =?us-ascii?Q?GilZ9BrwkN9rzcgJVzG9W1k0orwV0SbSVceyFEnn1W6wVraoJmCjEAbdjGrO?=
 =?us-ascii?Q?Tu8Rzwx+oUb2nqg15k1EH4pYqJsGQYq2FweWnRkof1KIBekOs2dcXxZPeYl3?=
 =?us-ascii?Q?6K4vC57kq/bl/6eY+6qGfb14Cm29oFoe26bQI7S2Zf1qS78XHuKF9TFQxDfn?=
 =?us-ascii?Q?8WixM0Cldzw/B47tpaGv71Bo=3D?=
X-Microsoft-Antispam-Message-Info: i6jzyIQRiQ/CfClUn2RRQDNJvvPrfGfs2nlE6NoJEVqB8DWfSsR8BcoAVa3Ih1/VVvfgWHTytXmeeJnny7/rYTAQe5H73mL1gzE1VYXZLGMYp6kl9sFXuKUM6vJVoq+gwjPmV/ytkOexb4QBP0SocIf1LYveM1aICSXxtX4qrB2Ar4brAPmTHZqdX9a7nI9fwiMi9XmHrh5/UR49IWtaWvtWmfyC3CLzWfyWFHHv6laLeUHzu1ScOXO5zLRjkZtidbqJaR0CxSjFT3J3qwcUNDA/58TARxkD7sxJCDaWNHetzCQ5BZCRB31cqjP8+Nmb33IRmtHG23Rt6aBo4SYVkT5byeTowyHSvjUGcjFcjww=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;6:2SywXOceI2lje/5ROuGnKs0hK9jz8Lwt1pj1tqrWyFeEk53RlceO4fyIpMqO1+r8a/XY1P37BwrTTyIqKoHQlm72mcdnC2Qvr4geop4QI1xoOw3fuyxXxaW/V7VwZ9oHSmDktxZ9ITLvMTJpcHFAO0KR37UyavdjqXeTuEl3+cbpQ7agaUtoPo4mvZ/RG5rbYbYAsU6YB9wKJ8VKFYmVHSWyW6YGG5hLWAHNDIXHLDayHQyXrTxz4EMoU2KZe0hv62z9zYC0qEXX0UH36W5EBRhwQ/4DLr+ZtsoE5p84WoPiUasglRACsNRt3Ur9HKV9/Mojk05AvFCi6lEQtCTFEEUNqsydWudu4oMwgfhdLN8RgYyRAKf+bRs1RluHsUcN7Vqn4FuKzPzikhC6O1LUKYG1c/TLbIVSPJFgP2IkAtDJjAibc8DtpJqk3Ji37gV+5e1Zuvy0uS2qfbFPQD1Nkg==;5:MjvOqXM7HLQCrNpFh1N0iVPjQmL5sGDKouPTPW5MEvfp+mMj8xKcNkQw+N9olZn/u+lN1TCjN73C2CktEixwEMM6o576qyADK7dY+Rri81Un6/rieXEAcprIh2v2m/daOJxqNv+z5wo2tKmdEXfEcyuiGf9Nh4No0mCKSR/ORkc=;7:5CE2pXX1zXgrxyQS46idqs7uy2V7OVnDPt3TNq6/JJDW/ML3THQQCQg5poci1CcQpfO0v3mRLJjsOG+os0nxLCJUnf2aHg7o1JHiOW0TVb6ncmF8Zi4YwypkYPw8uxcwQgItZ/hKgDpr+HRGFf8TDF/m8rzRKqXglrDWxRI625/prJX0MqndY8QzE6pYyHwbSf21mGQJz8ZVMfayR1BtbkSTJ4BMawUwI/Zo1YzBsfDTPbQpsQvYWIKHTR5LlWBF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 02:30:33.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620b0aed-1034-4a84-ff1b-08d5fda0160c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian, Ulf,

could you please review these patches? Any comments are welcome.

Thanks in advance,
Jisheng

On Mon, 30 Jul 2018 10:42:28 +0800 Jisheng Zhang wrote:

> When using DMA, if the DMA addr spans 128MB boundary, we have to split
> the DMA transfer into two so that each one doesn't exceed the boundary.
> 
> patch1 adds adma_table_num to struct sdhci_host so that driver can
> control the ADMA table number.
> patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
> driver can override it.
> patch3 finally solves the 128MB boundary limitation.
> 
> since v2:
>   - make use of "likely" to check (!len || BOUNDARY_OK(addr, len))
>   - explictly include <linux/sizes.h> for SZ_128M
> 
> since v1:
>   - fix BOUNDARY_OK macro if addr+len is aligned to 128MB
>   - use DIV_ROUND_UP to cal extra desc num
>   - fix !len for dwcmshc_adma_write_desc()
> 
> Jisheng Zhang (3):
>   mmc: sdhci: add adma_table_num member to struct sdhci_host
>   mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
>   mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 43 ++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c            | 48 +++++++++++++++++++----------
>  drivers/mmc/host/sdhci.h            |  8 +++++
>  3 files changed, 83 insertions(+), 16 deletions(-)
> 

