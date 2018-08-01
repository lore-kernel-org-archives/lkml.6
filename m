Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F3C46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD23208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kZ05yY4e";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KJONsEbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD23208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbeHAXZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49696 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388609AbeHAXZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LZUL9030076;
        Wed, 1 Aug 2018 14:37:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=kZ05yY4eHWNCY0t4lI9SF/NXsEk6lwcuVxhuAWWguAiH1JKSHVK5jYI/iQIuMZ/j4jik
 5GSIZyHVZATBayPQc84NcfUUCp46ME4zWxvqgoI71NKCtNsG7KnDdDYG9wNEJL1oVQ10
 PGpj3Vm5qgL8W6ZKtm3nL7WH6fUHCtDQAO4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkjp8rchb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:32 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 17:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=KJONsEbrE9+Vo/MNjhsrEBl2S6HgjSfNzuP3e7qKVnMWPkgLoS5z88VYfEpw6kcNSqgJp+yEJ5sd3EuNiz/jcM/3BEdqy5mNNqRmO4+BfhBPypnCSLt4956iHHPNUHctgkUeUmym99rWMYhJhsnXnlVgm0YsfMYW4nwc97ky0cI=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:26 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 14/14] samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage
Date:   Wed, 1 Aug 2018 14:36:49 -0700
Message-ID: <20180801213649.30751-15-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d45eb838-b760-43a1-d995-08d5f7f6f9b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:x2UuF+xinlg9RGDCzppgNLJ9rltsj5BfGw9vVczFhf4Sri2GFc0s5FfbBxb8WQqAqeOvBGoCbAyO1B9/pgeqQ3ydBOqOShuAnSLCbnm+cLLWgedovXchxhe9ms/XhzOp9a5gkpDzJ1btaHn4GqRNSMD5HDvsbwW1n1FCh1nzNHTZBHPoFX2cA7vmkV39a87pMo6yaBmSD10ys9VbhphR8XF58aRluQ3xGF8jntcZYiagXeirUHdwVM8zfVLqfMwz;25:joFRRmQG7kzFnmzRyoSDfqqx1ZzPw3x8QBNHRgFsQRn7dMDW2OTE+UKj7+mND4lmuQ/sF3FcLBJdP69b7gOBAN8b+/hVkc6StO97RdXeZ4bwtzbuOxJ01uifS2IC7VO/BxZkuEbAqFWJJZKXQZGJQbVwtl5CEyWEUOdu+o7DB2FQPBH91/YUOHh83n0eit0VdzR35yBc8yS4ksWrdTvFxRXfVHo5VqmIpICKGIg4HjmW1Xn3HRdHAxvIlKMFBZZnzT0ZFFmfIz2pyLRODGJgheX2MhTQ3uGooqRoP4waXn1J7rhbHYseNU8XigfNtkn+H5aKFltNcs4DLD0qW6HK6g==;31:RyCJuJlcGLYSz7UFE04fMXbhLlQG3GNjrbvpWJ+OaNb5WxVXFtoYQE5QDhekHfnF2bvd3vw5BDypaY22fCqEQ2WZoQBvIdUJB0jvPGAGON6w68tG2jFaVxY5ec4+hvD1facVUN/E2oUcZ59ioJ3yfUZ/3hPQmmLjdO1UO1A6Q+0MMEX03AGieWsnLmpsrGzD+aMJum8elO0RhsyI2y4rCLqVAIq7XAttbX96EbovMiM=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:3BW7/fMgvt744W8P/LFNe9AEYZKtcXj8V6Gkmds+mlBE0lFcWAgX8QVBBU7qmb/NrMoxA0mI1Z1oF+Lc2lQDOgNz+Vq+IugiDylJoooeCcpOH8Evool5GLV/8F9Bg8n8x43bAo4GSN83cqcrTMa9xsMRbT6e6uCH+XtAYhm1YmxpTDxcLcs8WZ/9A1efmCqUfLrkCFWusj12iTy5TVApTbrce++Bj6HPcGNL3cZOjsGjMyqCcN74fJoiBpMAib2sPp8eATRkdqs8OPR7C8c20j5p55r0gf0i7yMl0+HXk8qb/MNUFpWswl9rsTogRr5Z9Ur/0ipiRFmEIxf5f5ZvQQc0JORQXPcpIZNaEjmIQMZ2Z5jP3pcbiAjpMZp9dTp88QZzEYOKrnHEAOpJRFnlxYCVUBRDMhT88nLVwgvjQMB4ae5NVD4By3apjN6mRCzfGIqEEON8CtnQANl3APCv4OVmbIxMjJdP0I0r29W8hdUIArYymJC/p0hb/ohO7rHb;4:gIDlCcXsEZ4/D9cxbt3irHq6p2RKSBkt2Q5dBB35HXajq9hitjYo1zHmBkVtWjJFtDv8/epYHDg6Vav3W361rRHB0MYoQQoU3R2wZGn/tbGISJj8G4IrHZcEfxnKKkqZCqFvS6D0pjezFq3wGBZju5SkV5OK54hROvjR9OsCKfPIWd942hrs0frplOSqHgEAZvOjwBXnIKfgH/QqPjmoJ2cc+1AGe3+fMSnKOZ+IY1CmBvYDuSWb7KpC3jVpBB/8hN4LGAJ1L4wRXmuD9+630yZJjPm9n8EY75Hr+ceB+LA1JccRZpNnrPp94O6rCvXW
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167F45C4CE31A0766BBBA6ABE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(15760500003)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:aZKwVcjgclfAJAHAd+hMdIVJU8ndw2Vt3+i+omzGE?=
 =?us-ascii?Q?X0L7fkw0PZiYQKMLq0INNJ/11YUIGwaW3Mm2oRXgZmCo18IHuALCUiU4mv5n?=
 =?us-ascii?Q?48I/Il3uvgMWB6Rc3Ov/MZT7zgjNr4/k3KF/pP4BDuTL/mnd/0tyjIU1Ruvq?=
 =?us-ascii?Q?4N4wOdN/EibiFdWuUlrlQTxYt85KE7tsUlBedI2epSnc9mONSDp4BWUlfbyA?=
 =?us-ascii?Q?QkwycgTAVV9WJo3bA5gaLfKVlRiyxQo+VW7lh5AoleMlc/1XUFfQR8glAfND?=
 =?us-ascii?Q?t3OMJ0WODzswmzNLJv57RfneS2qXEEfqL3Hc9yEogOsFfPLtFoW9IAvpkqlo?=
 =?us-ascii?Q?bLcG6Zi1fbQawf6j91QFHnfj/evQrLK3quTbOwxwYMLiShn0sWzn66mdgp3x?=
 =?us-ascii?Q?5j1mzwdxrN9WTPq72gF3RimfAeA0GoqC9A5sUFmBKt+d/vhAr/NRUoWIYHVS?=
 =?us-ascii?Q?nn4r/FObFUOwFB0WXvo1aW5ECrHw7y7JP4miuQh9o1EJeB8EahnKThdSaMOj?=
 =?us-ascii?Q?OlLmB0AGytgWax+ZCDxsbH3mECwiz/RpyDUQgRFjW/lD4j6RZFCXbcMPRiIB?=
 =?us-ascii?Q?PwTuAFYI3GxMVXYEY+xArbUmjIPWgwR37glQrUfzICCGD8MlNH7eUWNyi7pp?=
 =?us-ascii?Q?CgoFpYAF2c4VCs4HXzBudXmnhNPU3m0ly97qscVZeaXt4nWLJCHScXuRCMNf?=
 =?us-ascii?Q?i895pfDxg5dMaZxswXUXJi0QUCdS/222GdElR3LJ497NNs3EXHLQNi69uuTw?=
 =?us-ascii?Q?Lu5AKIyB5QxcRxRV1pFzPn96ksJI4lLCCJ1+HApxl//0RHKR15LolGb5VCfi?=
 =?us-ascii?Q?GMNHSTK9gzEglNNAPIKKK9oAmjwxvHVodqEEr25dA35bQDCyog7aDB7rgr1z?=
 =?us-ascii?Q?6RTBE801JnGjrUxbBTAwgr61Epmc89z+Pn0TJQpnliSvYNpdweM8a7TnUT6s?=
 =?us-ascii?Q?e/oL7XLucB3TlElsDQ1cW9TyvFlMRfiNeky97Xcm39r8ttbewyDyzk5adR8S?=
 =?us-ascii?Q?4CLj6sku7gUk7Q3l2IlRZGyEe5lhxXdSd5hBw5NMNOsHzwe2P3MVWumCY1V6?=
 =?us-ascii?Q?+/LNcFgDNSC0nJNzRD6Xv63rptH8D8EQYDbMId1CjpgsPZC7fsI/vzE0JeA7?=
 =?us-ascii?Q?qTibNjyV6OjJhDU/efaRz1i87wxmQ/qyQGJVitFYpmrDe+OEwodJCqNUTvdy?=
 =?us-ascii?Q?i+iT5q6susoxp4WQjFnPKDaapx97/yaWunqJyYCBDVcThbl8cxjw53So927h?=
 =?us-ascii?Q?LJgdjomB7J2YXg2qaQgSgiBdTmy6z9SCvXAT0ZVwOpkOBgMcmmps33K7VhP/?=
 =?us-ascii?Q?nuAPdV9/xqPHu7iUwpNi2LNMqDaX45enax2ObQrr1QZmGwTnAXBMMYflqhHf?=
 =?us-ascii?Q?0qLMQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: M4PiJBfYo3q+ab6X1O/CXRmUPZkZMs+rsMQFCyIY/BJNxbHIc3efAQdd0DPMCcCsccPuRn5lyQLmR2kTXclekJ5z0MjxFvNnrHT6RKzvk7ihKJq1r9A6h5b80B8lvwegYv0B+h7Frht8Pmvk/Q+szbToRwk+nHst/cUuJ1NTVO+sYPT0/dRNwrb4eBzZHFDq7vk6Z9FWkzkC9KasF/RgtO3DxPjzlgIPdWWznPY7LTqi9u3VQ8gPNE8tl5k0KkxHZSK0+M3AZHyTcFOyEOe8jiXiJc3FBc60F2nZz9cU6G7IPw5me0U8iXL7e0KctMSvNhBYrvAvJWgJh7vMnTJacUQ2tOKSIct+QTA7FkRJ08Q=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:swwb2QR+Li+5jsgxjWiYgvtVb3IR4UEDiCVVybCfpJHXJdLDawb/lfbo17eHf7IclWIcFHbq5XGvGSewD3szQJGHgEagzMnZ7EO/Dyis6R+rI0dw2Knox5h1AExzTTZm3qrzJWOGNg1mkz30dfH733P8dDgGVLc0LB8EpIR10iVWhTtMkj7kB+YnKvGfBRsIk9mRc7SJm5PzcAWYzXbsIFb/WpoNCto0Ei7NGsIxRLOmL1fge0nDirWWtstYiikeBz5JfzQa7YIaByTkbStv7lZyb1TBhyr/IqMqK5C3e/7dgEPesNAsF8TY1BIC4p/zfljkeFuW4eCfPvnG/Qbw0P5KMQd6fUGD80wuOiI+JQGbXsr3yYrNuRvQMBSNSLXLLIT8rNonOlk25u2uAJU3LsQUYxeWTTg9OiY2E/r4y6JTCaxygLp1HUb9jTnT+I/PWwsg0rqu3HWNfKf80/0DBQ==;5:tDCmrRX7ZOpwGFp3tq3ZdwsSYrDF8F6Y1HevJJsHLeo3BJTboxenFBMvSoZ2GpGyTzRmIIwyrjsqP5dTVKTdHhKT95W/XKrm1LNePV8B11ELqKiD+EONVKH/7CL1CrN1aY0GMDwuBzpm5BOuXFRWZG7mHr5A/dWA3HL4TwL+LBM=;7:1ppK1dcD7bjHx2h+JwFIiVbOIoU/Anah0iPVxGSdbnWldnCGANBr7Zrv2gRVDweUM9vlVLlAj8KYy8T+lnptN5DhKF3xkMWmOLSjf2fMmF5v4OVFGqGYJ3+O/aM0F1lZnhpLOC1vYwYo8UvM7KWABrtZmlQXCsI89ZQBfpHKJlVSGCED4QfZG9u8au+xpSLK0hMW6k1A7KsUpKbgRXs2G0jgzkgspgCL1LzirZ6Mpq9YqeVpHMTYtdMpgGuenF/4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:I9i7cn/mUBjSr3izWg7r11/m8jBlmORMxd2yvU8NBXJCfXFvYbkYXbbnVTYpD5tnjvwdQ5BdEBrkCma8Lcf8UCZclqNIjsH32cmarg/HjizRY9WYEWV3GWqjm+NKFvdVX8YG7JBGrRgoGdlokuq+XRGLO1wnPgjQLxlq9Kr7JAk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:26.0279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45eb838-b760-43a1-d995-08d5f7f6f9b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_cgrp2_attach test covers bpf cgroup attachment code well,
so let's re-use it for testing allocation/releasing of cgroup storage.

The extension is pretty straightforward: the bpf program will use
the cgroup storage to save the number of transmitted bytes.

Expected output:
  $ ./test_cgrp2_attach2
  Attached DROP prog. This ping in cgroup /foo should fail...
  ping: sendmsg: Operation not permitted
  Attached DROP prog. This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS prog. This ping in cgroup /foo/bar should pass...
  Detached PASS from /foo/bar while DROP is attached to /foo.
  This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS from /foo/bar and detached DROP from /foo.
  This ping in cgroup /foo/bar should pass...
  ### override:PASS
  ### multi:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 samples/bpf/test_cgrp2_attach2.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_attach2.c
index b453e6a161be..180f9d813bca 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/samples/bpf/test_cgrp2_attach2.c
@@ -8,7 +8,8 @@
  *   information. The number of invocations of the program, which maps
  *   to the number of packets received, is stored to key 0. Key 1 is
  *   incremented on each iteration by the number of bytes stored in
- *   the skb.
+ *   the skb. The program also stores the number of received bytes
+ *   in the cgroup storage.
  *
  * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
  *
@@ -21,12 +22,15 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <assert.h>
+#include <sys/resource.h>
+#include <sys/time.h>
 #include <unistd.h>
 
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
 
 #include "bpf_insn.h"
+#include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
 
 #define FOO		"/foo"
@@ -205,6 +209,8 @@ static int map_fd = -1;
 
 static int prog_load_cnt(int verdict, int val)
 {
+	int cgroup_storage_fd;
+
 	if (map_fd < 0)
 		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
 	if (map_fd < 0) {
@@ -212,6 +218,13 @@ static int prog_load_cnt(int verdict, int val)
 		return -1;
 	}
 
+	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
 	struct bpf_insn prog[] = {
 		BPF_MOV32_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
@@ -222,6 +235,11 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
+		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, val),
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
 		BPF_EXIT_INSN(),
 	};
@@ -237,6 +255,7 @@ static int prog_load_cnt(int verdict, int val)
 		printf("Output from verifier:\n%s\n-------\n", bpf_log_buf);
 		return 0;
 	}
+	close(cgroup_storage_fd);
 	return ret;
 }
 
-- 
2.14.4

