Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEC7214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oUPl06FS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DLBGGsQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEC7214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeIZRq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbeIZRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:55 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBQxpm017644;
        Wed, 26 Sep 2018 04:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=85egIdVuiuZ9M5KELnH3tIbiuDDQlOmhQrwiPQn3UaI=;
 b=oUPl06FS+vhVmUXianugWg/aZH1iSW7c7Ju0bTf/aa8LBinLwYkius2CzhyRrnWB6yy0
 HmWBnrEgsi3FaP1vKtd3Nr+snlntQk8UcQZwID+3n8iiC9f43hpyoKaq8Y0l2KK3oGW3
 yhlU0WtKb7i9xAYdOnkSfxCnfIK+qLNTOsg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mqxqpsevd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:34:03 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85egIdVuiuZ9M5KELnH3tIbiuDDQlOmhQrwiPQn3UaI=;
 b=DLBGGsQr8N9sA0CeQph9KNDknmliE0zUzT8p0yGGevuSFDKvMkJ0+qbV3xhwcdMTV65hdq7snc6JXU+8yRUC8tBOjhGbcvLw9UD7o6NoYD2yAhO9fn9dGyUDtQqhOPwEVnmDTLQ0l+nzp1YCmi5scBwCeNvrEJQl/rzmchzpSPM=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 08/10] selftests/bpf: extend the storage test to test per-cpu cgroup storage
Date:   Wed, 26 Sep 2018 12:33:24 +0100
Message-ID: <20180926113326.29069-9-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926113326.29069-1-guro@fb.com>
References: <20180926113326.29069-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:15cb]
X-ClientProxiedBy: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e84a8b-b742-4c75-cb16-08d623a3f3e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:zq0kpxjMG2RtyZsKrE/i7xkZHAWpMYLDW1ysldfUDtA+k/nl10VXpcIdwxH3xePrueZWDhHldOXWT4oAbkaRHQRpurtPGmI1xUMPt4q0k8LKc3UBlL6hXdbXJnARO8O6+L0OhP2XbBPDs4IhWNQvEakWUXVIHRjlSuyaD0Q3tmCamIwYaSEuEg4j0chRxt/+xhdzHIWuJUspUZZgkw4aoCaOp9x7mdcIasBfuTmawuEL6HswnZcEOQek9yh5xJ1x;25:hNVSDFL5d9A3WMEdMungQqszTH3w+3z5X5Zqe1Uh8uvvqoioesGG8SsCo1zdO/jLrKja0Qr4dVdtmvBN8AzhYKDMNuZgBEJ6wVMSEC90raPkn9NO2/5zU/PZe+pwuDQWAYr0PnZRz0upIEn63gQEDA1EKvvJ0csiyqnRac83zRTRYAxzagsCUQ8GFlsl7Sbm3OPlnRZe0Ciyu7MNGQvD08rn9clDmE0z7NI+iCoIiJ9uurCeMO8E59u6eB+Qdx8gxalTOk3FdZwR8OzLzPQjk93LGL+jF80Mf4YZm7drrTWucDsGwdjHBJnpKUUYdbiY4gONLoWfPDo4Ck+fv5rc0g==;31:eqAKuTZ55voQ+ltVX2cFEb9JOUSlrZK5nC2VkHBzBWotM4r2EkRyauoAPJPpRN+17gg1c822u+FF+qyaaIk313mPa/E917HGflGI+D5uMv9hiH/eNQ0uQKKsMs1OaY/mv97BSiJfjBzEOlemSchUnwIeuNhMrIia8N/0k+CCliD/bnq+2ID3J8HqQM3erKnfPqlxMHk+8N/MH6o8qjIaKzznEmvyLfS2Fa87/RVw4sU=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:YfnL1c8jQVKwY9lOkgJ1D/8e7jBSDakIXOvWAl4FwixkmYA6HqMmQIFfPSyBXwJcwpVmfgtlOY1yh30NLrChxd+scHIOPBeNJDQ/zx7u95hc9mLTeFCeNlORvBQnZEKIGPVHnfQsEs4wZKBN8ZcTblqArv70AGYgETEwZ+DaNpe0y1amNzn3frShuocOKdDzFqwXnRQpj7TpQ69SkVQzJ5V/JLxOSXcoXL8pGDkmAgsHtLlbBut9yixil4QWA6TCJK4Wjqw9Wl0pm43y8/cYUcFvX4l4FIg0mxnnZ1pbQkOvgSFO8NUXXh/DhJKSK4n378/PATsC9qd+Lt3lHWSqenmipzG+0huwgGZNnHzK2t2d1BROx2s/LvHo0u0U1qDJ61SygQ3PUroPT28p6TP2FY8Pkoji6zebK3fobxuVnvnrwc/pOEIZ8xj8ulBOhMLK7qY6JLgIvd+zsr1JhmWW/g4/VoVlLS6bAX2oAr4pp+89DIZ5BIT0NI8X8CQmrPQs;4:9+TyKkn7tDmqNbOgHQN0O//vt0NpTp/reTXztYCiZJTm2Ak6qAzOlgT8XSScNKlIMcCOD3MT9suzIVhO8vT2ww13znW3sO8ksyC0+u2hkc3BFVZAHBV0E2A/3zSiwnOC4dMB17rvclUbGUkOXIepWpYCyUY/FYL8e1Eju+5Z4Tn5bc4bLMzwtqbTqL5TEqabDKH4A9tBK1Mb5/4h5R5LAR1DxliLo3nHjCu2Be6DROzYsbrO5MBI2ShzzbsSz9A+NiXNkceHD9ZbmxTIAtFDQu8xHb28WL/KtB7EVm3sy2UTBZ5xDoJ98FvPTyP5v28P
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162E33852C5E2D28DD2281ABE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(551984002)(86362001)(14444005)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:G/vkSRkN5/FQGfQBBKhg2X+3zdgC7QjuuzpGY3ics?=
 =?us-ascii?Q?iQYS+bIxUKp7h+PJUDe+V/XUb4WKboAKhxQn7WHjxsbmzmaM/brPcsuGuqN1?=
 =?us-ascii?Q?PxLe/j9OJCUHT4DQfoT4xn6womWNlUdGyMJZvspnz6AeKLoPO4Oc+c25O/ey?=
 =?us-ascii?Q?G4JIgP6/vQYljGtgB6XPa6yLyXpU+qU9TaxpLxHap1wdBoE3+Nb57kuf1vBi?=
 =?us-ascii?Q?ka17NJ228XJgpqwjzixSkGemB+xxqeaMxv/p4c1guLjmw0IQDtYYtc61JUSr?=
 =?us-ascii?Q?aYV58Zg5pfibJAud/HR8GsUUPaNNKWYbW5z8hB7rdetbW1pLW7qaJJgDQPoV?=
 =?us-ascii?Q?d6zT6Zw1bNf7wInbCzyGmXNrt4ddhpa8Wm1yz3Lq6XA1qdaTrgcMCp0JDk7J?=
 =?us-ascii?Q?T2spJ682ry0hbf+mg501LVKxVQTIlbW8nmrRNvdWMFT9yH3wUrPPnmU93MTr?=
 =?us-ascii?Q?zyjru1Ab3DbbI1zRXSJFZFGKPQutOB4xAwpRqhK5xdfdKFENggkzWLbhfArC?=
 =?us-ascii?Q?YhhqRSMGjlvnG0+F1Ar4asrRh+WpzIJvelv1UfN2aH8Sbq9QPUBO+XihHXAf?=
 =?us-ascii?Q?sresN4MAVsEz1H6HbB3bkiPHP8IbuiXhw2rx2V0H4RVht29fXzVwfd+MYJOu?=
 =?us-ascii?Q?JVP7Cna6esDIGKeJhOOHYUN8RYOM0HhBpOP+7NdOgAUMytfXmjqyceE+tPUZ?=
 =?us-ascii?Q?L+lZM+EstaBfhS8K6tTDAvj1zB9IwtIa6hdZGQR58ODV3xxcI+hMPctqq4JE?=
 =?us-ascii?Q?i0tq5DkR3CBp+/2R6Gb3QeeJAZVjhhzwGxBhNXjeKm9ckuexhMs2pdLkcEdG?=
 =?us-ascii?Q?UqioNVP667y3EvtoaKHRUe/zJq2b1Q/xPCgPWBo/Y8NEyE5xvjoPpoqEOVqn?=
 =?us-ascii?Q?713+YU1JagDfygmbetAkAaMNDTe+UR52dyhD7USffr/bDgBQ7fqPF5CoROg9?=
 =?us-ascii?Q?RQaB0lxbVmhFK1wsKCMxsw0TuTdQjRPUvCKtkI3fDpVkM74tpoLnTP4GYvQz?=
 =?us-ascii?Q?IMkv4Dj0ZTfGh1OntX/DqZ/5q3FSEwJcPXFzKVNzImRW9HAu00ihgNxJolb1?=
 =?us-ascii?Q?066c+1T75oBbjKiVjX5hAx5hW4VX9mYVcu4x7KZnLocg0W534x7u1YqLaNdL?=
 =?us-ascii?Q?cNqudfwG69IQmDHZKTNL9Jsjh+fJoosT5ddbbvpolvTkLpU6uuWRfk1rdom2?=
 =?us-ascii?Q?0oa+UdJRMF1qoOCzgqNhTqql5yfFxkxy+aiCGg/L/fioe+w8vRQox6LleYge?=
 =?us-ascii?Q?BAurbEnJ5nVbno1LOLpTNsOAi1q55RVYZ7dnhbU2ms2U8scQRD9gBomhjdJ1?=
 =?us-ascii?Q?rBLSWBlH9OOflKZrjG6sDuIKFzSAiZ1j6ZurwTaiLrg?=
X-Microsoft-Antispam-Message-Info: IDOzkv62ZhYArgXk8+xq4JUoClTuj+K9M/0Xwz/cshGt5JiUoE/+UvqxjYSgEvxc/TKwZoHRPOhAuzHeAcL8jh8aqnNfhjmbfgU7VGc9DmJmGcfVDXvUHw3O0ejg4tQLYfIRutXS4dXB7q5JeyepSAfragLe96yDFSqAIvmFjRGkf4MSuIwqbdnFoVcIMjWD0fa3kirE6yDKaSvndgo374T/v2+V/DWJ/GPZo8XsPh+eK6uAsHaNgC3nokH8N3NinXv/WU4hXCOYXRzVSipqPiqTEGmMUmoeC7jiV/X3RRj0+cJbhIBpxsIBLTq/+2vxqYiGt8MIj/8gAn0h6d9W7uYDCLX/GXZtkd5RjXqlaIs=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:rlCwzSEjudcZvS+fRE8fpiplwbQ5GzO4Xp802/mJnMz9gs5IJx436O5LG/j6c5tpg4JdwERZX6mMh5I3Db7TlwhBDXPYEAwI5ph7JqKFYSD1jkRp6pb7lD7HgNZC0PBoER7qpdt4O1PRRTLFSD6Igp9IA7vVWfbcmGl7GqJy+TeYmshayyYKG/w38qiBnNl7wKVTqUw2UbxQRbymAC0JOXzcTJeajm0W7PEgfkPzVSJIzzuSBM5O2eBsHlww71ON9Xo2h5sapWet1nwVvzH9RUz3c+aOA+x8cOoLzaG/P8L3jF20wtmr86KA2n6ThXqDL56kVoNsXIAUpplbT/wubBYy8W/O/Swt593vHsnIg05P8vQSx9IRaZqsWtoVrHN6HqCQgx/glBd2C5F76egb6MLb6/rp+FTLhBfZxwfJz6LJZJhSo2c8CEjuZoF35TQBOh+CfR9Tka4tu9XHIVwO9A==;5:MpSESDHsj1lqvZH6SBcxD3xC/cXEavf0zPjwouum9FQQCDl6R+zC+gSBs9Oiymh2RSRkF64KhFQzo6TOlaCqGOo2ss+IRpz+iQnkTdWGRXnkOokkegcGg4mn8VLLtmZ/sxvlVedYROrfgmTyAqlob20xyQfDqAOQSAPrp+WOP1o=;7:54nzm9Na4X0Iu0u0LYRrg0XdWvun3DTpPBKhvwFb9xiCeGVvz6F+OGp/AYjbkud08Rp/WaZQB6MpTJYzaMIdsenIENBtv66A5TSET0eSr6EQVmYIpjehFiSJC4ZvSdsYKnrdVx1AFpIoO5Gu8l3gHZsKVl/dN+gj3xNUsZBuRwuRl6y3aQW1sQpKoCQvy22xt+USb/n0WzwkcXISN3S9etEZi5XzzbInsI7DrZpq21zDvzfovYSvnd1T7xyKsLFk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:EOazzvF+3gTA+LPm5hhAkqItodrleXPWgdHtrG+07wiH9LZ8O778H1MZJkcfaW1nJRI2PPvNBxOAAAKo03a3zcrnfp3W+bCTICpZQhe4U7eM297hTpaLNuyTuyTULmqCrGTy16TMgDGsxIcp6ITOFOwCUqMGSnBnGmqTsdOVcVA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:58.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e84a8b-b742-4c75-cb16-08d623a3f3e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test extends the cgroup storage test to use per-cpu flavor
of the cgroup storage as well.

The test initializes a per-cpu cgroup storage to some non-zero initial
value (1000), and then simple bumps a per-cpu counter each time
the shared counter is atomically incremented. Then it reads all
per-cpu areas from the userspace side, and checks that the sum
of values adds to the expected sum.

Expected output:
  $ ./test_cgroup_storage
  test_cgroup_storage:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/test_cgroup_storage.c       | 60 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
index 4e196e3bfecf..f44834155f25 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -4,6 +4,7 @@
 #include <linux/filter.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/sysinfo.h>
 
 #include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
@@ -15,6 +16,14 @@ char bpf_log_buf[BPF_LOG_BUF_SIZE];
 int main(int argc, char **argv)
 {
 	struct bpf_insn prog[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, 0), /* percpu map fd */
+		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_local_storage),
+		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
+		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
+
 		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
 		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
@@ -28,9 +37,18 @@ int main(int argc, char **argv)
 	};
 	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
 	int error = EXIT_FAILURE;
-	int map_fd, prog_fd, cgroup_fd;
+	int map_fd, percpu_map_fd, prog_fd, cgroup_fd;
 	struct bpf_cgroup_storage_key key;
 	unsigned long long value;
+	unsigned long long *percpu_value;
+	int cpu, nproc;
+
+	nproc = get_nprocs_conf();
+	percpu_value = malloc(sizeof(*percpu_value) * nproc);
+	if (!percpu_value) {
+		printf("Not enough memory for per-cpu area (%d cpus)\n", nproc);
+		goto err;
+	}
 
 	map_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE, sizeof(key),
 				sizeof(value), 0, 0);
@@ -39,7 +57,15 @@ int main(int argc, char **argv)
 		goto out;
 	}
 
-	prog[0].imm = map_fd;
+	percpu_map_fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+				       sizeof(key), sizeof(value), 0, 0);
+	if (percpu_map_fd < 0) {
+		printf("Failed to create map: %s\n", strerror(errno));
+		goto out;
+	}
+
+	prog[0].imm = percpu_map_fd;
+	prog[7].imm = map_fd;
 	prog_fd = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
 				   prog, insns_cnt, "GPL", 0,
 				   bpf_log_buf, BPF_LOG_BUF_SIZE);
@@ -77,7 +103,15 @@ int main(int argc, char **argv)
 	}
 
 	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
-		printf("Failed to lookup cgroup storage\n");
+		printf("Failed to lookup cgroup storage 0\n");
+		goto err;
+	}
+
+	for (cpu = 0; cpu < nproc; cpu++)
+		percpu_value[cpu] = 1000;
+
+	if (bpf_map_update_elem(percpu_map_fd, &key, percpu_value, 0)) {
+		printf("Failed to update the data in the cgroup storage\n");
 		goto err;
 	}
 
@@ -120,11 +154,31 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
+	/* Check the final value of the counter in the percpu local storage */
+
+	for (cpu = 0; cpu < nproc; cpu++)
+		percpu_value[cpu] = 0;
+
+	if (bpf_map_lookup_elem(percpu_map_fd, &key, percpu_value)) {
+		printf("Failed to lookup the per-cpu cgroup storage\n");
+		goto err;
+	}
+
+	value = 0;
+	for (cpu = 0; cpu < nproc; cpu++)
+		value += percpu_value[cpu];
+
+	if (value != nproc * 1000 + 6) {
+		printf("Unexpected data in the per-cpu cgroup storage\n");
+		goto err;
+	}
+
 	error = 0;
 	printf("test_cgroup_storage:PASS\n");
 
 err:
 	cleanup_cgroup_environment();
+	free(percpu_value);
 
 out:
 	return error;
-- 
2.17.1

