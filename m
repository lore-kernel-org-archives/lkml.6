Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12138C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F6F21A09
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BFwQLRGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F6F21A09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeHFNpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:45:16 -0400
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:6786
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728039AbeHFNpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZbelj1CylAwKk9NNeEgROzPMOfo29dMKqJGllyJmTk=;
 b=BFwQLRGBbSkg41EQiBaKbepR0U0rz/vtiQuMiytAW8HtWQWVV0qm4kMkJUJAAVdhAmneNcbizadwMfaTT6FuyPZUW3pyZFr//5RR2nsIw+yUJi8wW4pM27u0Uzq3Kr6W8zKb0je0uhj+0FJuYD3Navz5tQiMM2eOwA3LgdInFSI=
Received: from BN7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:20::33)
 by BL0PR02MB4452.namprd02.prod.outlook.com (2603:10b6:208:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Mon, 6 Aug
 2018 11:36:32 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN7PR02CA0020.outlook.office365.com
 (2603:10b6:408:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Mon, 6 Aug 2018 11:36:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Mon, 6 Aug 2018 11:36:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fmdoM-0005eP-Ur; Mon, 06 Aug 2018 04:36:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fmdoH-0000zG-RM; Mon, 06 Aug 2018 04:36:25 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w76BaOFO015018;
        Mon, 6 Aug 2018 04:36:24 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fmdoG-0000z7-1C; Mon, 06 Aug 2018 04:36:24 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 2B842604BC; Mon,  6 Aug 2018 17:06:23 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2] usb: host: xhci-plat: Iterate over parent nodes for finding quirks
Date:   Mon, 6 Aug 2018 17:06:13 +0530
Message-ID: <1533555373-24400-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(50466002)(486006)(106002)(305945005)(50226002)(36756003)(47776003)(4326008)(126002)(426003)(476003)(2616005)(8936002)(478600001)(356003)(54906003)(42186006)(110136005)(316002)(90966002)(48376002)(336012)(16586007)(52956003)(186003)(26005)(2906002)(5660300001)(6666003)(63266004)(81156014)(8676002)(51416003)(81166006)(106466001)(36386004)(103686004)(39060400002)(6266002)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4452;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:S643/3uISt3Y+lTLFnnvFlHaqy8fs5epddKHAcEAqN44KURCDF8nTUeV4PAAhIEo30Q/Z8jUEc5MS0xX6C7nKHGughmGL7sonmUAYif8fCDmDTPPrYAmLpi44Tl0R7KQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 588c0654-be67-4486-f13c-08d5fb90db59
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;3:NSaSs5cYOjCmk3dlaa9qLONBdJUedwR9mQTqTGcEz+7qo0VR7whYQPJh0JiLRjhX6dRaC+YIBW3vhB6uJpTZDTP7f9IFmSqiiW/nk8pogqQ2gfaKidJC9x8TN6jje61fK/abykC6ZLyKa6q+fNurY0G3wOsvF1l37nBhtvmAw2EijrZmLWsXvISISpdtDid4QsWTQbvSaLy+dqs5vYeo4qPgth3BIIEYl7oytXDAga62Pt4A68KozvCsnUWPaWEnm7nyO0hmmaTPNx/d3Tq/53b7xODzG/nAyYLZvvRkz3jxcr+wltEv1E/FnUwt3sQ/Lv892zPiZtrAWp6w9d5tXug0d/EbjljJVcRzDOlOgQE=;25:MCLLwv3CBh01m4pvM70cKdCTWRTfEhO3H6BbYUeDlbUBqO1O4xAqyIuZqyuWN0zvdUoJR553Q1HkjRi0/++7h/uLq8BiKBTdaaRVGOufsRhTcaT8lrDIG3puwdEWE2CMPQs4m91t+wWNXLytYn4pwfhMt3N+fz8/UifmQ6LTnnzhz27nzF2ft4t5d015QFmI5uU5MXvoj/By35Eqf1G4q/J1QysCKWgECaw5v//fbIHPgOoYjljyOucRKO/D/e0VnJSejncojGOBnNxadKvFPM3SDwZQTxcCHwsRYWpxBT7PWDoMC7bARMNu9cdGh4niabEmza4SfJzqKIcOTbUgmA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4452:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;31:TVDc9XMfi1vwl1qCQV5PhYLFfQkdQIoZ91K0fFbsgCs5MHh7tbdYhTMguoRv+zJo2Km+6rt151fuwuobAzuzbwlWeYe7WTZr74FCqgAX53XXdF7n82UeZOYKJZwBfvCROtgP6ksMbO+NKGqSbAZjfwLJFIhFGm8hyJJ7YIQGP9XaiXyxxcecD/N2spXFUuYVbfxSA3e2pnLZs5NFJTD4Cvr9LEYFMTvjyuEf6NdSFSs=;20:6H1xTCVpo5Fxm6Y/UP5BBjpgqQ2wbFTYkvBD1nI7wYs8t6838YfQZyT3/lNOSNv+1TYo9RmCAP3MNKjWmJea1BKLiO25SakFazmhVO1PWvyYTfflQGDrr3gxmmhsy8gJxojKzPv5dHb8raE0s+uVfDYploTuW6cvRVKwUnm0LhpvFOY1JFzF6nBXCTkJ90BqBPTQ50lWfeHjtEvZvnhWp5h+H8rcKqZF0vPqKA98n9v91DE8X64ihytMbn7TEsquF+r7TdLu9z4rYqGE9Vw/gDkAEPAtNygRlNW+Ux89EUs9MIwTZghxCPfJRP0xAfCIBcVJAn0Okerd8kLxwEV12NwKskRPR1w/PCHgFjr5+OyMqm+ER/5BY7i1cnJSMza+HRVpgCmhnB+UTtHnfaLdUkgxaifxoBptohTQF3S/uxrq0JlisC+LkmhucdIQmDb+Tn/fRZuMWO9/4gtVa+ZV6S5vSjc+vllgGltirYrHDnZH3DcznrwC/FZmbZN+y4wk
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44523281BF0FB298E0B42932A7200@BL0PR02MB4452.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4452;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;4:5eSMBhOVnfk22CVxk8p5MWnUG8Dq/Yi27Ex/+Vi4IrB4Y9pGvanCw6HQKlfDSeU3O6juxQMtN6b/5J3cm7/SU4KvpU7cb0ByzlHaUm0N9PcHIGGJMI3nbUJb521DOa69LamyTRIBMmEBAmfa2p/UH/FkwNYn9eqhoFcOsT4zDUoRSvGx9z8eV6nzXoQIy/wAMDwOPv/3hYaQZDHNK9EqtRjbGX/pJOEonc95vCiEOTWmRnRDC7/NnZ+XmdQN4mnuydggKDOKslY+Ko4e+pmzGj5PTeuEj+/KOT+0A6ha9SkaXnxO/VOmpGOiddh0ionS
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4452;23:GE+DxAVCazPtOYSW/kS9GBT3tKlIUfhqJJiiYdX3w?=
 =?us-ascii?Q?k8615maqTy/mkykmIlrDEyDMwl0ZQBj+CzoC6oVao8rQMpvxvOVVB9qtlj9/?=
 =?us-ascii?Q?ERlHfvdFYnzMGDXcBlwSoNriyyTTVpHeBcs/k4ZHn41n7yobL6pWKZQt5kC/?=
 =?us-ascii?Q?zUJOBNladCNPazbVtG/1298ZWrbCWRxOXKAWi77PVVy6TGJg7a66HzktiYnd?=
 =?us-ascii?Q?JT94LWFrknuVKeUjOHb8knx1s8JWDL0rM116CW0p1LXSk9eg3NucUK74ev58?=
 =?us-ascii?Q?z1MTk5fixoRx5bk5LCSFHFHZyTzYP1mX6O3UgIB1YwVXVoMiJFX2Ua71wrmv?=
 =?us-ascii?Q?bEQemHTbVXePcKeO6Uoz+2zcAdFgzvjwGD3i5LMkUSm8iMvTaHGg6UVCAsRj?=
 =?us-ascii?Q?Q5aJ8Rvm5xR2zhW/VFd520uyon759wVt2yairlbn5uHf3PyhKklXxS4imAS5?=
 =?us-ascii?Q?8cVGA09UQDNC17P6CEU2FjGXG8ew6f+9bFcNb1A6tqlrkvnAusVOR7QnsUGJ?=
 =?us-ascii?Q?yaLvkE1+QlGYyUAICQ5BNbktBDxL37XC4UgYYtdAU9zsmH8JmS0yMRnLFcly?=
 =?us-ascii?Q?lgOvHt8qTshf6jCATs8AXDdZdMiH+0MyJGC7sU6AHGn5kEZUmrav9SIPMraD?=
 =?us-ascii?Q?t2aigSQrKv/YW9922ZsbRHUQ5FwAWyry1LD5c4ayDBvAqArAQ+o94ffavHUN?=
 =?us-ascii?Q?HftDvYKxKMQfWkGObNW2msHwqkiy20XCa8T5zc9ydzOrrMgbMqnXwQpK2tUU?=
 =?us-ascii?Q?pDCuugeKFO1t8NWieQuY7UN8JGxg9tFE62ik7K2UscXlwFFYH/hiZ+LaLM/s?=
 =?us-ascii?Q?W0SloX9L84cbPQqWQAYgxmFHMzssOPAf+20lsQG/RA7t5fUsOkNQEi0gHIET?=
 =?us-ascii?Q?dsmQ8mAMXUzleqr0zhruJ/IxbTvHxZxEuQ01yty+t5kn2yCKEbbPyJkLiRSO?=
 =?us-ascii?Q?/0KsVKp1pguP4UvC2aVK0QZbyYmwnMIiD8D1oVpRT6lvMwp6nJP7RO/vvGWN?=
 =?us-ascii?Q?b+GuiLMLlL13PkJO5Uua9bavDKLdwxqjlFc6KJh1GXRyFSc6wOUaEwRChbJ8?=
 =?us-ascii?Q?E6Fk47NbTqT0YgC1x6VOvjZOJrrpX4Xn4CegkxfwJHAivRV79+B+HhTeQt8w?=
 =?us-ascii?Q?fXqH4nMe/c=3D?=
X-Microsoft-Antispam-Message-Info: sWOUlundVHMdPCp3hb6+v98WMSbwRChO3xvisrYiw37Y1oKzaLf0TPk17nDjYSjmjGqIVi6p+FmCjTTOBS+uoRnH523D0aV6ijyiEdBeTmh/+rCbvoiScJgMR9eg7oxq2GsSKTAwdjgDhZsqNMrKEPCk6OUy905qeA8CKJePtiAkmW1WUCj9DqkXuKPV3PQy+CBJMZBZ0C/toNEJ4is4qU2dImjadwPUswLzt4jaEea5i4NwaNhNz+mg6RGPglMtk+HIAPBR+fQ/5e4p9wm5KT69Bl/jPtW7EbKQyHD4/I/8gOTpxYvmPvZ7KvDffKZ6Oti+gXYWGHq0tGITnZbUTU2rVVl5In7EdUYYfCDskIQ=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;6:LFKLdg4f9cohTqTV/5PoFY7da1WkT+DJAQLWvW9gPiuZSvry9t47X9MB286zO6BS5e/e9pk3411+ZPWzpXy6tHkZN5Je5RjgWD54/as4i3hNle2uWTmWDlnq6SRq01ViABR8BvMYDF5AAW5PEuwVtJ7r3847CAsJpL215ueazrj3x0mR7b91QnruseX9kUf8GSjaPI12nx5e4Bqk3EMF5RttxpDtj9gEgS2yGLuJcwtSolZNI7OU6g12vqIFMcn82rjeDdLviP5pjvA8OsI27nQOvlum8ezTmi3m5Ysc66QmoD6yN0kXcuXBVtTIxWb00gRTVDDnm7kLYhAVl/AVjB0QvxUp//lFOVZy8SO/DlqD92WuxIWT0kbQYQK62mMW5sgic2mzOgIRHbxiWgjkUxGURyLMaR2lwPtAUdwjOALngMTMKT6iWZ2vz17qwyKo1CLan6xEVn4YRegfX89upQ==;5:N/mdBXwmQfByvXB+LcKhbmUIDk+LPqHwmhl5EaYJy1V1J3MZ2N04xPYvt981fHdR2UKMFCueWvxoE1ISkEIAVcdS14gBgC7LGrcVwoxy2U2T5q4jkcVvokmLTCeQeg7Ahr9QCQHHhSeB3Rjvca7NwRaaYxHGtlBjmsFfS5cljqU=;7:N6iZ7d8HvrI2IrQMdGr6NLsou5HQoIxNXVs6v8iS4h0ATjLhL0A9vgxKPTYD+ZBKrxRJV32gSH+FZltnXfXdeNjmB3tPg7xbDGMmjBBtyZqRT6j2EBI34CqkQk127haGMWg1fKTNuzzUcmI/8zrtCq03JmTh0D/QV7FZYYOR+ElPUicjLr4w5+s1Px47Rt9q0IoXZlflf+SFItPJpXNpslX34KIuL+2OWq3PrHPacewujMVyusq9tXRO/1Euc5oq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 11:36:31.4260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 588c0654-be67-4486-f13c-08d5fb90db59
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xhci_plat_probe() both sysdev and pdev->dev are being used
for finding quirks. There are some drivers(like dwc3 host.c)
which adds quirks(like usb3-lpm-capable) into pdev and the logic
present in xhci_plat_probe() checks for quirks in either sysdev
or pdev for finding the quirks. Because of this logic, some of
the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
host.c driver is getting missed).This patch fixes this by iterating
over all the available parents for finding the quirks. In this way
all the quirks which are present in child or parent are correctly
updated.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. As suggested by Mathias, restoring immod_interval changes to
	   default
---
 drivers/usb/host/xhci-plat.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1b22fc..f121238 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,7 +152,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct xhci_plat_priv *priv_match;
 	const struct hc_driver	*driver;
-	struct device		*sysdev;
+	struct device		*sysdev, *tmpdev;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
@@ -272,20 +272,24 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
-		xhci->quirks |= XHCI_HW_LPM_DISABLE;
-
-	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
-		xhci->quirks |= XHCI_LPM_SUPPORT;
-
-	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
-		xhci->quirks |= XHCI_BROKEN_PORT_PED;
-
 	/* imod_interval is the interrupt moderation value in nanoseconds. */
 	xhci->imod_interval = 40000;
 	device_property_read_u32(sysdev, "imod-interval-ns",
 				 &xhci->imod_interval);
 
+	/* Iterate over all parent nodes for finding quirks */
+	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
+
+		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
+			xhci->quirks |= XHCI_HW_LPM_DISABLE;
+
+		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
+			xhci->quirks |= XHCI_LPM_SUPPORT;
+
+		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
+			xhci->quirks |= XHCI_BROKEN_PORT_PED;
+	}
+
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
 		ret = PTR_ERR(hcd->usb_phy);
-- 
2.1.1

