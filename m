Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BA9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8992148D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="cnlTnTYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8992148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeHQAWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:22:41 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:55712
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbeHQAWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkYgdHxSRV3Z6uzVQq4ndc9cj5vmdGH/Zv1AmRCVP00=;
 b=cnlTnTYJ1X6W7R5jZX+cXPK8Q67z4ODw5UKEFq+Ug71AhfvGy2Cua74iXVhXxhNa38V9TpDaj+ZQg6LprzK9Gjg6+dagAVZtVNfj7T9+tNz+4k4mfsB0h/ziSZ/utdwMUTLPeOUsPYTrqFxYoCwjX1JEX/X3x4i3ez8zhs2MnJ8=
Received: from DB6PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:6:1::49) by
 AM5PR0601MB2467.eurprd06.prod.outlook.com (2603:10a6:203:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 21:21:49 +0000
Received: from HE1EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::209) by DB6PR06CA0036.outlook.office365.com
 (2603:10a6:6:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 21:21:49 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT028.mail.protection.outlook.com (10.152.10.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256) id
 15.20.1059.14 via Frontend Transport; Thu, 16 Aug 2018 21:21:48 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 16 Aug
 2018 23:21:31 +0200
Received: from harkonnen.localnet (178.196.40.127) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 16 Aug
 2018 23:21:32 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: Federico Vaga <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Appana Durga Kedareswara Rao" <appanad@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Date:   Thu, 16 Aug 2018 23:21:32 +0200
Message-ID: <1841468.1pWPcT6Du7@harkonnen>
Organization: CERN
In-Reply-To: <CANk1AXTZqaZxrEeb3TpyH7HtiVNw+MvVsBZzXWZkSLzUGQkrnA@mail.gmail.com>
References: <20180815220958.3606-1-atull@kernel.org> <20180816185952.GA3932@archbook> <CANk1AXTZqaZxrEeb3TpyH7HtiVNw+MvVsBZzXWZkSLzUGQkrnA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [178.196.40.127]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(8676002)(106002)(54906003)(23726003)(3846002)(786003)(316002)(6116002)(336012)(230700001)(9686003)(6306002)(33716001)(356003)(50466002)(7736002)(7636002)(97756001)(33896004)(76176011)(44832011)(43066004)(305945005)(106466001)(966005)(36916002)(478600001)(46406003)(246002)(4326008)(956004)(53546011)(74482002)(8936002)(86362001)(426003)(476003)(26005)(186003)(6246003)(16526019)(9576002)(3450700001)(11346002)(446003)(6916009)(14444005)(5660300001)(47776003)(229853002)(7416002)(2906002)(126002)(66066001)(486006)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0601MB2467;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51040a83-177d-4dda-438a-08d603be46f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM5PR0601MB2467;
X-MS-TrafficTypeDiagnostic: AM5PR0601MB2467:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0601MB2467;20:syXAvYz46umuyMpy2pijyecgB/mGs0bGR7Lp1m7a7YyUR+VkUD3suQYYKJi4uPaFTRbgylOxE0ZAhyXdAMwWP53xfoJmClm8XshK1ihScEgKcWjf3bnGzwR5OXUHNTY1xjOtvy+HBnet2vJKiaGf5T6GQB0SHXt0a3prGMAC9QrtieI0RPwrJDmCu2dlWksYG77KQgoRbAx0H8c2ByH2Oxs44qd1vEvwVvo5Ba3uWe4XgQ5iA2bCfc0gFAZYAAoQqkcCqah1oQ/6kUv7RSIup79Nh7LRRW/5TlzWLJi87PASkhsx4KWzahMow3sbrQ4NCpAGYv/nYg7RAJvy1GSTkf0CMixzE3/mJYvVFLR7Ibm6FnjDXnzRy+N1e5lQu3XYrHNWuMU/pjauZUaybcVdcFrHI+LYVpCYwbY562RbrAPYD8EHhbzhqw/JUzJXxpM0TVcdL640QaLiPM7qjYiiQVlqeaiNpDbmxgMkaI3uVtNL8OxKIzrbS9Vvz7/A1T04;4:czqIyRis9+Vi9T9/eSK/d+0oxdKxmBK59Bj46+ZrSkYG47+xdvCw/G62wuxH8m7RB2PytH00I0Fd7h9+pkqTn5sdq1XwQr+lGMhVoEoDMKwHn0or7qjWJTXWS48zdbGNQld2kfmxAcauYqITxWG+JGZhbAFTe9w74MTUtOmAfwXL4mMElBaYh7vcVbCdcsF6ajdtT+qYhxtLDd+SOATZ0R2WZHrOxAfJMb6GlUwndl3VyyyO+9kG9OanpPP6sxq1PVBEZpqgLLvqpkCJEwELUonZ64kbJMGQL8WLKSJswTEXLKQ+zL1jzHI1cojRTJG2XQYXp9J3M7br89vNGqwEMf2xl/Dn1jC5zssV1wIuOzaKeh0swO/5O12F8nVucinm
X-Microsoft-Antispam-PRVS: <AM5PR0601MB2467E626FD3E94CC7DF003A8EF3E0@AM5PR0601MB2467.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(80048183373757);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM5PR0601MB2467;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0601MB2467;
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0601MB2467;23:41PKf6jfo5nWPDcnO81ZHO2ez6G/btPBXYxLxCu?=
 =?us-ascii?Q?ZnV2ISDlo5toT4fzKTL+KBgWqz0DhJFt98P/nt81mf800/K4uol6Hqj3gn/9?=
 =?us-ascii?Q?toaECJJkuIn8k1OayD5UXTmiV5FNkXIovlaHuP2GS14ihA3wmuw1VqE5Hjv9?=
 =?us-ascii?Q?mA4EkzisFbup25nOyhdskuW7NcMUAmwYAdFHAJd06tVqILKefgcfZZPcxfTl?=
 =?us-ascii?Q?1rRMF/KxftIcInmtqMmHoCpzhhumOalskmY/kxR2t2gmyNsot5OhQ98Y7tHV?=
 =?us-ascii?Q?2dGRTT0SEr61dHOJ+/JQ6Pd95Xkcc5KeH6FsT6rEaQ+/sWtm3NmF52rN7VRu?=
 =?us-ascii?Q?YCDF5xRv2vBdfB7D2fW/gtLs4E5aR5zxDT+Frgq8CvKu8tRoj+ZeZ8l3aoKI?=
 =?us-ascii?Q?d7EWRAMl8VD8APFHypmvEuVK5ikvTYochTYQ0/36VK7bFpRW4gtQ5B4IElkc?=
 =?us-ascii?Q?tHU8CZlEglId5B9X8ViXvAsbopOo4rbB5pnLylfkkqt3GB50N2OnLcOaSJbF?=
 =?us-ascii?Q?ceomn5zYsaPdIMxYPzGv6A7MX03kJIgX2mcrQJf6+WL1gl4zsnHA+4pfsN6O?=
 =?us-ascii?Q?fJRhnMU3LMXejmugQnlAk/+FQENNWFNxcTz5LzgCinD8dJvUw6nmJdtrQifd?=
 =?us-ascii?Q?2MQ3EahFw/cLo0ePdWT24m05oyh9Q+q13sBvx2H/CAzRbv1a+8c61mv5ySs+?=
 =?us-ascii?Q?8GuMUVMTCgmFQ5fPDZzkZ85UZEDQfg/VPup29F2NiZqDHtT63RkVUOuieb2r?=
 =?us-ascii?Q?VkNChqDONaP+ilcLZtXiKuvdt2Kg18ZTKXB6zgvu2gmS2kIPVBR6t2FCcqOK?=
 =?us-ascii?Q?SiXOqK8HcA7JG9NUFtmuZ7ha6wNafCtorUkvVvFT8d2I5Uu7h1p2nQ9wLhfl?=
 =?us-ascii?Q?fI5JfPqHgGhOm35zxuzJEQE7VMTuz1ATy/ClBSNXI/RFF04mEe1dhS23TCJB?=
 =?us-ascii?Q?p5MnHOZOY9QV5WiDlxPoY4LTKmm0cess0+dkVBScCu8fDfWTe4IZYtoN+FxI?=
 =?us-ascii?Q?H/qfJwTbyA6eNIuntnIz+461KNvc+9pKjUCSHgvfR9qKh5pHCRFdLA3YSm/m?=
 =?us-ascii?Q?ETcoI0djturrViHxj7TWWiTWz7RnbsfbEOf4jyomlmk2R6JADzGEHnKJAMc/?=
 =?us-ascii?Q?3XUxaP7OqiVBYz+j2p/6a8wIo1K7QUXNZ3TfsvQHfHDscFU/8Zqrz3KgbjNs?=
 =?us-ascii?Q?kXJ10PYb3I4D9UhetDYvoVqy07HKG18eq6YhuRfdFRAyqH4HQXpkNnKd5q1F?=
 =?us-ascii?Q?17kAH6zq5PwDJAdoPMUv8K2AocPO2mzglomGcnVMGiIYWsoiYxjGQboQAOws?=
 =?us-ascii?Q?TwwkhMDj42noTjejIPcrmlVzkSVHG/j377li0BavDl+p8NKTyUj3E0RJyhHR?=
 =?us-ascii?Q?S/Nyt0OArpHwjYmSHW8mU6v9IoOgA/i4tvJhCb4zPeY2oii6t?=
X-Microsoft-Antispam-Message-Info: riZcc/0w4DirGiFQ70szhFh2jUKziY7QUUQ5Bv8ZOh5WhZRQCBPJrK4askGZEUp+x/MEtIfn4vuwEUr2ldA4jCZ3q4pRf917UOOybZV1A35Xdvh2l0PzRd/zKhjHg6liOhYt4GOeEP+McjGsFwCIHwm51/HO7Mu4RIM6jDzZmVki8S7m4lOmHaEmhBtkHpw0d6C1iq9WXkCTXZ45TdZVEnZsdvnrcXUIxy4DTqxX//88oi7sTEE9CBk8FFkWuTc+4D9uVUhFSJixR5v0f8v4OJRj02vkgRyikJ3G6/6mn+aw1F30YoOV2olGwEM7BEb1lTorcEYD2oV8Oky9C7EbehOLqM1xqPxhqkkmyZRK9uk=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0601MB2467;6:j1y1RRv5XIZyWYxv+U9BdIx/SHIgqW2mf0iV1wtHDa7iBknW0xBn+gCyOtDnzuUt8oROdRcoAhrfG1Jyuqcp3jSWWIxhD1yFWkCOqrRlN+cbnqVln1lSmEFGJkWe+2jLos7/whL/Ysrk514gLkEvXNWN2yB2eyRIhq97eBzJNIZ0aftYM6bEDvQhKDtky+5Fkv6HKR2qQ6w90YzjTBVgtpEk1vGsIijRVMeCCeC8xOI653l38dsMUdokPPfWuLu5i1sSfaQgG9Qtar3ZZ+JUL96R3R9KcegraBe9c8vpZv88tDZwvI9NrgED/k29HALcs22xkbxCG6ANfVY2eh8aCxi+mH0EdSyd0D1/qr3ix57U5CvudDpU7dnGuiiTEKGwHCJQInHo08+jHJGjsBUoBJ2s0+t0iWDmXpoBSEbJg/Y8cswwiRzDr8pUBVjrCYzsZooi1X8gzYWsOzzFHM10Yw==;5:6S+tGZC0pJOlJ7BW0G3zMqRyT8vAYtga2hg1dh9OcD15xJ+3c8mlO2pRoASJsvNmpf+B8l03ddgjZgvV7Zqz1A27jUOzc1iDihkBXaBQFWk1F4zXRlG01rx/3Qyr2kmK74wQFdLalM5bLCIBHIyKl7ztLS+3Rz6e8PY8kBLnCsE=;7:o6qIeLz5NPOgmXqu80JjcsF9HBSxcpR+b17qWwoebpBw63DGUiRl6riLKXmlfZqwMn6zITsH2k3x4llUsJtBYylWXRd+agEYOXRiR0OgAAcx2T9hg6WjsBTz0OiViW7hWN77zWBSMw3KTppJFq9JEZApxO35HHBSrBfXLEp2ygQGy5omAm18ZfzQ54bXiZi0cFFa+cWcBqCgp5PuD7cLo+H2GF3C+rIKG9iv6fqIdPJ1uYOXg9VL9j0vRXEo6wGX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 21:21:48.0395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51040a83-177d-4dda-438a-08d603be46f3
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0601MB2467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:
> On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > Hi Alan,
> 
> Hi Moritz,
> 
> > comments inline. While I see how this is useful, I have the
> > suspicion that from the moment this gets merged vendor kernels
> > will just default to use this ...
> 
> Yeah, I have that suspicion as well.  That's probably why I sat on
> this and didn't upstream it for 2 years.  But on the other hand, I
> keep hearing of lots of cases of people implementing this
> independently anyway.  At least if it is debugfs, it makes it clear
> that it's not intended for production use.

I'm one of those guys who implemented this independently.

@Mortiz
I do not see how this can be a bad thing (from what you wrote I guess you 
prefer another interface). Which interface to use depends on the use case.
If you have this suspicion it's, I guess, because such interface it is 
extremely easy to use.

@Alan
DebugFS can be a first step, but I would go for a normal device in /dev at 
some point. I do not see why this should not be used in production

Below, again, my code that does the same thing. I already posted this in 
another thread [1] but probably this is the best place. As I said in the 
other thread, this is what I did quickly last year to make things working 
for us (where this kind of interface is a must). Unfortunately, I do not 
have time to review my own code and improve it.


[1] https://lkml.org/lkml/2018/8/16/107


-----
From d6a6df9515c5e92cc74b8948c3c10ac9cbeec6d2 Mon Sep 17 00:00:00 2001
From: Federico Vaga <federico.vaga@vaga.pv.it>
Date: Mon, 20 Nov 2017 14:40:26 +0100
Subject: [PATCH] fpga: program from user-space

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/fpga/fpga-mgr.txt |   3 +
 drivers/fpga/fpga-mgr.c         | 261 ++++++++++++++++++++++++++++++++++++
++
+-
 include/linux/fpga/fpga-mgr.h   |  19 +++
 3 files changed, 281 insertions(+), 2 deletions(-)

diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-
mgr.txt
index 78f197f..397dae9 100644
--- a/Documentation/fpga/fpga-mgr.txt
+++ b/Documentation/fpga/fpga-mgr.txt
@@ -197,3 +197,6 @@ to put the FPGA into operating mode.
 The ops include a .state function which will read the hardware FPGA 
manager 
and
 return a code of type enum fpga_mgr_states.  It doesn't result in a change 
in
 hardware state.
+
+Configuring the FPGA from user-space
+====================================
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 6441f91..964b7e4 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -27,10 +27,56 @@
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
+#include <linux/spinlock.h>
 #include <linux/version.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
 
 static DEFINE_IDA(fpga_mgr_ida);
 static struct class *fpga_mgr_class;
+static dev_t fpga_mgr_devt;
+
+/**
+ * struct fpga_image_chunck - FPGA configuration chunck
+ * @data: chunk data
+ * @size: chunk data size
+ * @list: for the linked list of chunks
+ */
+struct fpga_image_chunk {
+       void *data;
+       size_t size;
+       struct list_head list;
+};
+#define CHUNK_MAX_SIZE (PAGE_SIZE)
+
+/**
+ * struct fpga_user_load - structure to handle configuration from user-
space
+ * @mgr: pointer to the FPGA manager
+ * @chunk_list: HEAD point of a linked list of FPGA chunks
+ * @n_chunks: number of chunks in the list
+ * @lock: it protects: chunk_list, n_chunks
+ */
+struct fpga_user_load {
+       struct fpga_manager *mgr;
+       struct list_head chunk_list;
+       unsigned int n_chunks;
+       struct spinlock lock;
+};
+
+
+/**
+ * It sets by default a huge timeout for configuration coming from user-
space
+ * just to play safe.
+ *
+ * FIXME what about sysfs parameters to adjust it? The flag bit in 
particular
+ */
+struct fpga_image_info default_user_info = {
+       .flags = 0,
+       .enable_timeout_us = 10000000, /* 10s */
+       .disable_timeout_us = 10000000, /* 10s */
+       .config_complete_timeout_us = 10000000, /* 10s */
+};
+
 
 /*
  * Call the low level driver's write_init function.  This will do the
@@ -310,6 +356,158 @@ int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_firmware_load);
 
+
+static int fpga_mgr_open(struct inode *inode, struct file *file)
+{
+       struct fpga_manager *mgr = container_of(inode->i_cdev,
+                                               struct fpga_manager,
+                                               cdev);
+       struct fpga_user_load *usr;
+       int ret;
+
+       /* Allow the user-space programming only if user unlocked the FPGA 
*/
+       if (!test_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags)) {
+               dev_info(&mgr->dev, "The FPGA programming is locked\n");
+               return -EPERM;
+       }
+
+       ret = mutex_trylock(&mgr->usr_mutex);
+       if (ret == 0)
+               return -EBUSY;
+
+       usr = kzalloc(sizeof(struct fpga_user_load), GFP_KERNEL);
+       if (!usr) {
+               ret = -ENOMEM;
+               goto err_alloc;
+       }
+
+       usr->mgr = mgr;
+       spin_lock_init(&usr->lock);
+       INIT_LIST_HEAD(&usr->chunk_list);
+       file->private_data = usr;
+
+       return 0;
+
+err_alloc:
+       spin_lock(&mgr->lock);
+       clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       spin_unlock(&mgr->lock);
+       mutex_unlock(&mgr->usr_mutex);
+       return ret;
+}
+
+
+static int fpga_mgr_flush(struct file *file, fl_owner_t id)
+{
+       struct fpga_user_load *usr = file->private_data;
+       struct fpga_image_chunk *chunk, *tmp;
+       struct sg_table sgt;
+       struct scatterlist *sg;
+       int err = 0;
+
+       if (!usr->n_chunks)
+               return 0;
+
+       err = sg_alloc_table(&sgt, usr->n_chunks, GFP_KERNEL);
+       if (err)
+               goto out;
+
+       sg = sgt.sgl;
+       list_for_each_entry(chunk, &usr->chunk_list, list) {
+               sg_set_buf(sg, chunk->data, chunk->size);
+               sg = sg_next(sg);
+               if (!sg)
+                       break;
+       }
+
+       err = fpga_mgr_buf_load_sg(usr->mgr,
+                                  &default_user_info,
+                                  &sgt);
+       sg_free_table(&sgt);
+
+out:
+       /* Remove all chunks */
+       spin_lock(&usr->lock);
+       list_for_each_entry_safe(chunk, tmp, &usr->chunk_list, list) {
+               list_del(&chunk->list);
+               kfree(chunk->data);
+               kfree(chunk);
+               usr->n_chunks--;
+       }
+       spin_unlock(&usr->lock);
+
+       return err;
+}
+
+
+static int fpga_mgr_close(struct inode *inode, struct file *file)
+{
+       struct fpga_user_load *usr = file->private_data;
+       struct fpga_manager *mgr = usr->mgr;
+
+       kfree(usr);
+
+       spin_lock(&mgr->lock);
+       clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       spin_unlock(&mgr->lock);
+
+       mutex_unlock(&mgr->usr_mutex);
+
+       return 0;
+}
+
+
+static ssize_t fpga_mgr_write(struct file *file, const char __user *buf,
+                             size_t count, loff_t *offp)
+{
+       struct fpga_user_load *usr = file->private_data;
+       struct fpga_image_chunk *chunk;
+       int err;
+
+       chunk = kmalloc(sizeof(struct fpga_image_chunk), GFP_KERNEL);
+       if (!chunk)
+               return -ENOMEM;
+
+       chunk->size = count > CHUNK_MAX_SIZE ? CHUNK_MAX_SIZE : count;
+       chunk->data = kmalloc(chunk->size, GFP_KERNEL);
+       if (!chunk->data) {
+               err = -ENOMEM;
+               goto err_buf_alloc;
+       }
+
+       err = copy_from_user(chunk->data, buf, chunk->size);
+       if(err)
+               goto err_buf_copy;
+
+       spin_lock(&usr->lock);
+       list_add_tail(&chunk->list, &usr->chunk_list);
+       usr->n_chunks++;
+       spin_unlock(&usr->lock);
+
+       *offp += count;
+
+       return chunk->size;
+
+err_buf_copy:
+       kfree(chunk->data);
+err_buf_alloc:
+       kfree(chunk);
+       return err;
+}
+
+
+/**
+ * Char device operation
+ */
+static const struct file_operations fpga_mgr_fops = {
+       .owner = THIS_MODULE,
+       .open = fpga_mgr_open,
+       .flush = fpga_mgr_flush,
+       .release = fpga_mgr_close,
+       .write  = fpga_mgr_write,
+};
+
+
 static const char * const state_str[] = {
        [FPGA_MGR_STATE_UNKNOWN] =              "unknown",
        [FPGA_MGR_STATE_POWER_OFF] =            "power off",
@@ -352,13 +550,43 @@ static ssize_t state_show(struct device *dev,
        return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static ssize_t config_lock_show(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct fpga_manager *mgr = to_fpga_manager(dev);
+
+       if (test_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags))
+               return sprintf(buf, "unlock\n");
+       return sprintf(buf, "lock\n");
+}
+
+static ssize_t config_lock_store(struct device *dev,
+                                struct device_attribute *attr,
+                                const char *buf, size_t count)
+{
+       struct fpga_manager *mgr = to_fpga_manager(dev);
+
+       spin_lock(&mgr->lock);
+       if (strncmp(buf, "lock" , min(4, (int)count)) == 0)
+               clear_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       else if (strncmp(buf, "unlock" , min(6, (int)count)) == 0)
+               set_bit(FPGA_MGR_FLAG_UNLOCK, mgr->flags);
+       else
+               count = -EINVAL;
+       spin_unlock(&mgr->lock);
+
+       return count;
+}
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(state);
+static DEVICE_ATTR_RW(config_lock);
 
 static struct attribute *fpga_mgr_attrs[] = {
        &dev_attr_name.attr,
        &dev_attr_state.attr,
+       &dev_attr_lock.attr,
        NULL,
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
@@ -367,6 +595,9 @@ ATTRIBUTE_GROUPS(fpga_mgr);
 static struct device_attribute fpga_mgr_attrs[] = {
        __ATTR(name, S_IRUGO, name_show, NULL),
        __ATTR(state, S_IRUGO, state_show, NULL),
+       __ATTR(config_lock, S_IRUGO | S_IWUSR | S_IRGRP | S_IWGRP,
+              config_lock_show, config_lock_store),
+       __ATTR_NULL,
 };
 #endif
 
@@ -507,6 +738,8 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
        }
 
        mutex_init(&mgr->ref_mutex);
+       mutex_init(&mgr->usr_mutex);
+       spin_lock_init(&mgr->lock);
 
        mgr->name = name;
        mgr->mops = mops;
@@ -524,12 +757,19 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
        mgr->dev.parent = dev;
        mgr->dev.of_node = dev->of_node;
        mgr->dev.id = id;
+       mgr->dev.devt = MKDEV(MAJOR(fpga_mgr_devt), id);
        dev_set_drvdata(dev, mgr);
 
        ret = dev_set_name(&mgr->dev, "fpga%d", id);
        if (ret)
                goto error_device;
 
+       cdev_init(&mgr->cdev, &fpga_mgr_fops);
+       mgr->cdev.owner = THIS_MODULE;
+       ret = cdev_add(&mgr->cdev, mgr->dev.devt, 1);
+       if (ret)
+               goto err_cdev;
+
        ret = device_add(&mgr->dev);
        if (ret)
                goto error_device;
@@ -539,6 +779,8 @@ int fpga_mgr_register(struct device *dev, const char 
*name,
        return 0;
 
 error_device:
+       cdev_del(&mgr->cdev);
+err_cdev:
        ida_simple_remove(&fpga_mgr_ida, id);
 error_kfree:
        kfree(mgr);
@@ -572,17 +814,27 @@ static void fpga_mgr_dev_release(struct device *dev)
 {
        struct fpga_manager *mgr = to_fpga_manager(dev);
 
+       cdev_del(&mgr->cdev);
        ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
        kfree(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
 {
+       int err;
+
        pr_info("FPGA manager framework\n");
 
+       err = alloc_chrdev_region(&fpga_mgr_devt, 0, FPGA_MGR_MAX_DEV,
+                                 "fpga_mgr");
+       if (err)
+               return err;
+
        fpga_mgr_class = class_create(THIS_MODULE, "fpga_manager");
-       if (IS_ERR(fpga_mgr_class))
-               return PTR_ERR(fpga_mgr_class);
+       if (IS_ERR(fpga_mgr_class)) {
+               err = PTR_ERR(fpga_mgr_class);
+               goto err_class;
+       }
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
        fpga_mgr_class->dev_groups = fpga_mgr_groups;
 #else
@@ -591,12 +843,17 @@ static int __init fpga_mgr_class_init(void)
        fpga_mgr_class->dev_release = fpga_mgr_dev_release;
 
        return 0;
+
+err_class:
+       unregister_chrdev_region(fpga_mgr_devt, FPGA_MGR_MAX_DEV);
+       return err;
 }
 
 static void __exit fpga_mgr_class_exit(void)
 {
        class_destroy(fpga_mgr_class);
        ida_destroy(&fpga_mgr_ida);
+       unregister_chrdev_region(fpga_mgr_devt, FPGA_MGR_MAX_DEV);
 }
 
 MODULE_AUTHOR("Alan Tull <atull@opensource.altera.com>");
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index bfa14bc..ae38e48 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -15,8 +15,10 @@
  * You should have received a copy of the GNU General Public License along 
with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 
 #ifndef _LINUX_FPGA_MGR_H
 #define _LINUX_FPGA_MGR_H
@@ -24,6 +26,8 @@
 struct fpga_manager;
 struct sg_table;
 
+#define FPGA_MGR_MAX_DEV (256)
+
 /**
  * enum fpga_mgr_states - fpga framework states
  * @FPGA_MGR_STATE_UNKNOWN: can't determine state
@@ -118,22 +122,37 @@ struct fpga_manager_ops {
        void (*fpga_remove)(struct fpga_manager *mgr);
 };
 
+/*
+ * List of status FLAGS for the FPGA manager
+ */
+#define FPGA_MGR_FLAG_BITS (32)
+#define FPGA_MGR_FLAG_UNLOCK BIT(0)
+
 /**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
+ * @cdev: char device interface
  * @dev: fpga manager device
  * @ref_mutex: only allows one reference to fpga manager
  * @state: state of fpga manager
  * @mops: pointer to struct of fpga manager ops
  * @priv: low level driver private date
+ * @flags: manager status bits
+ * @lock: it protects: flags
+ * @usr_mutex: only allows one user to program the FPGA
  */
 struct fpga_manager {
        const char *name;
+       struct cdev cdev;
        struct device dev;
        struct mutex ref_mutex;
        enum fpga_mgr_states state;
        const struct fpga_manager_ops *mops;
        void *priv;
+
+       DECLARE_BITMAP(flags, FPGA_MGR_FLAG_BITS);
+       struct spinlock lock;
+       struct mutex usr_mutex;
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.15.0


-- 
Federico Vaga
[BE-CO-HT]


