Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D2AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C4D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hqjrqD/i";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WI4ft+zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C4D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeIYVaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729484AbeIYVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:00 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFI92g003006;
        Tue, 25 Sep 2018 08:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=BRma+7OkY8QNiwAUmqlumwRf3Qyfkkrg3sgyeodk4Wc=;
 b=hqjrqD/iWq0X/rrmhLfQ5x9za+C0YDLZ0dGfjYjxK4QiRh1FEA43WXeunoOxX/p3ubeL
 OphNMtb5wmeGjQrhLb/plIOKagcR6SCMQxh/EOuhKLv4dpB9ymVdTb9L3cn3/oK+OwKV
 /tiEsbhmZRrta8gN162Scs3el2iwDVtlEFo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqn800gqq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 08:21:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRma+7OkY8QNiwAUmqlumwRf3Qyfkkrg3sgyeodk4Wc=;
 b=WI4ft+zE+kqQaAUH6WBJDjsKc2+AfjfoODGVJLUT3dAKYsukYpF8g+fw7izYGb/LBc6C0dFRln9QNyZPf82cUeXSHOFCOStUqh6ciua13W5V0JkhRvTXikV6GNlbnK45ohM8ZImYIGOMkDLpjFM0/qM709InETNQBZo8Te0KH+Q=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:44 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 08/10] selftests/bpf: extend the storage test to test per-cpu cgroup storage
Date:   Tue, 25 Sep 2018 16:21:12 +0100
Message-ID: <20180925152114.13537-9-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155e07a7-3bf9-4f98-7cb5-08d622fa9aaf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:qi2D/rZsnqm009Bh0LHh3GV4Og7n9HblWK5GlB1siBI/6TrWzACoILcmGpeuWBEz4MHZRceTDxkQMylXUHFKYbBBZ2mcT2q7FiuWWRvXxUneMC62k1sy3Jj4e3AopSyG19/3iqESp16IO82TvBOLSigAyXM/xl4+4eRbz6Fxxi57UVsocaH+hzqMkHc+nOY4bzeFP/l5e7G2dk6K+gWSq9zmmb0DZFbQ2dw9I4XA6CkD1GlIcT9PwMTwnZPUanKL;25:gjQd1b1BgAkDb22OJSXWrgJFEVkRe6NxhFE5smUxpcuaijDGWsLKW1oV11oZLYWOsXWSTLbxgc3P0tErvVNX6RvGWRpB+d/H0ByVpXV5VEInHePSSRRfO2FxmYmEIoDQD8mXDR6H2ezdZr2ZaEhFsXmEJOkmDfQtDnK7W0CRzezGr0PZevAvbptWSFAyDFofnkEo94zQj2w7Qq9ACPniHBv1h8ubhQfQi2MEwu4Eo2LN/vNbkS1Vv/SDmo5qh9US7cK67I/0n5Ex+xCkx478blgjRVlEtAgWgWz+VfjsRO3e+FDaUTjuz+7A5waFFhPzzdlho9NFBVRbdT1e4hHSKw==;31:YhCokGI3feQLcR2QE9B74xifhk1p2Dhq8PJrAr5n30HAo/vrd5INR8grw2iwIXAMjNb17fxl7hjlSdQqPZP935s7Jd4UDLT77wLKHqdJNbDqGlYTlw7lDC12U3wZR2EQc5uvNAYxtdFy8JC6IYyqTFtVf3EG4wyI5XrrzhcIoSgauIu1ILm359SyFPzRwtRBmuRXi4yu5NTL56VnsxP7fl4+J2Gs2khumHA9NLbraYU=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:/x1JOT9od7oImrwbjpDA/eMU5valGlyzRXi+15PNcJ+u/dVAmS/cDtrGcYFzT0Rvc4FyZqyL9BD81ZRwyPw8WAVH/RgHtOE6komOP3FxV2rHbpxg03YATguNBZ7nXXPPYzfkqexa7nZjtuo+m1IlZFHqXwRfahlZme/AHH8sgwBtKWKGFzJFik21lBOKCRoa7xEW4N8ET49VNc9Gm79b8EXjsMXGfEbxK4KTAyEJrkFs4tlB3RJ+bI3IMd648jamliuMNEFuENeCRVJjzFv6tJwHuw38oowBk26H9FHXSX/gPdlWOC6VJ1x+zSl/bZ3N2r5PnAziUdOCQXOK0xAIlTNvf+NcsFOJ/q0FuwEUkRs5S7X5B76inp/3q5zYp1inwL66eX9yz8sPYtwhTK1yjpB3aYi+Zk6opdSu1azXCwiA7b7tZ5hpGTuHk7V2EpIEe3pWwH4MPFqp1pi/Ov3OHz6eIttSDWP/gh0EwUclK1RfH7Rb2slQsDAGz8RoILjo;4:V6IGVm1NnuncY6EpO7G7eIsWZ71TEP53SWCLaGEVdOtCmWZCJ0KWUX3U0qoRE8jw/7+K3J5CEALxGnXkNVjOcw6hR2XruB/ph+XWirwUR0658IaevLr/J+Ipz5MOtdHp+kmkkJSNSBuYK/pZ/ytHV0yHunIv1pOhq9nQd+y2CXcvu4UxOeHSlIbCWArKfSw1A5Wte98l8JsGQAY7mODunSqznZOMvtY2uRHJioxQdMbENbX2Cmjpa+kb4qyumJiqL43HGQD4/yKf4xGtLFfFZmGoAkbdIAMXUsm6vIfXnVKLNK8AxvxNUTyyfEVKsBGF
X-Microsoft-Antispam-PRVS: <BLUPR15MB016328C09D7224D9D6837336BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(551984002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:Vv7ZvpeCDMAWZdKC9k1pxQ5bGtmUBrLyvgeefgijP?=
 =?us-ascii?Q?w1NTW1L83YyDqsq2UJVLd6G9Whgm5GezNa8aXWUfInudERkKAJm2Z28NCgs0?=
 =?us-ascii?Q?lfN5U5vK5Q956CcBoBYV2EzclM4PkQNW2ivPv6w8QnPnht0/zAqwts9NVrbq?=
 =?us-ascii?Q?Ln2Fw9joeF+aqUXJWxyGy+8WHzMXbRIrmiqnyr7aRDfzg2mZghNJNA8KvNRF?=
 =?us-ascii?Q?45Fi0lguOpURiFyiV49uh+l9R75kOMlMCiLdEkSrIFbUwtdVScsWsrDRO7BY?=
 =?us-ascii?Q?NTnP5rWKGWOEpN8K8yIWSQNH32mGB9TuWKdSo3bOmQQH3eIraFgqGqKrRAn/?=
 =?us-ascii?Q?w+yp/z6yRnKGxB4QrW+Qx72wF0I2ZKolWHb/Q671RlFYa+453bbEEi2jGGX5?=
 =?us-ascii?Q?aGCFtGW9KLaJ4arRb9TZR8rm4assb/U7xS1Ts8383bqg3KRfmz8k/VWaWzN8?=
 =?us-ascii?Q?yqKbbm0GNHWiGw4q6WSW7DjQQueK7Iv7tfa/ecMRLKjC78XzA/eAM0Snngex?=
 =?us-ascii?Q?oZrGkaVs2GdN5q/OrI5iqWZ+AJPNz+1SUWhJ/FUos9OD47aZmd/xjrwQSeV4?=
 =?us-ascii?Q?inBqCXTjuzsrq94yw1kNH079wUte5jdBBmHahk1pam83fK67amazCMX2w+2y?=
 =?us-ascii?Q?liATubbQ3+6S4Iq+7BVHZVRfbGetNqvxTqGJHP/+Qf6j6VWOtynP6Se9SizP?=
 =?us-ascii?Q?IYlPyjroxzXLv2Mazd/mKR9zV0IqSvnBqPt06j9SqgRtRzFuqLajvp3VcWYg?=
 =?us-ascii?Q?MB7eh0Yy8yxeSOJrqbVBBCbK9R7eB18yY4k95l7e+rmh5Q6AiEvnnAIlWvSn?=
 =?us-ascii?Q?vNZjlD0HL4STzX1Zh0m08XEL3KVJGQibj9Cit9Hq77WKia0AvM7U2t89ZsKy?=
 =?us-ascii?Q?slsEr+rlHKCKQ/BroPvZgoN1MZPmqBhD9sCYBQ79yKZ/FwUbWFv9qLfgPDg1?=
 =?us-ascii?Q?DKi2AABiIH6NvZ4CCi6cQhMslt6G4YB/2IjL74qPgeSyEyB8DT+NTvru1Hx+?=
 =?us-ascii?Q?T/dJXVha6sFZbkUPtu0xnGfToATxP0KWeXymoEt+/q04uXCgGRccq0mE/iby?=
 =?us-ascii?Q?9J0mBxB8CyxaaiWGS17DzoFJwmMyMwUk1lMrQj3A3Ku71ojzQgX/8daBWRns?=
 =?us-ascii?Q?uffbZT6jhxiU70fQpwfGO6PHPMCljg80IsFuU3VcSpaU0u0cQPe4ENClK+HN?=
 =?us-ascii?Q?vpM798PS7llUSkQRjQXcCRkun+CSv3bp4sxQ7/Y/N1zdFBlQYS6kDSi7K9aK?=
 =?us-ascii?Q?ahaE6GjYOVk+VhKfnSpfqc1rOorCwVv5UJacOuh+i1SX1nfAQPhqPG9OqyGy?=
 =?us-ascii?Q?9BmjYOaXhcO+L8p6ANH8xST73q9uidSdwSlFq/atmZ1?=
X-Microsoft-Antispam-Message-Info: GgWdxDeFDxsA+TmL1TylukB0az1qc50IjyVrtXSdzIjIKUas77VFQGL8YdXPSkHO2Z9SUx20jEk3aKX8HiXmjWkbAAPxJrbrFSGQIaNNlrIlttRXaYof3znv4v4GR/caVS0wbSO9gsCrfri4SeWswALVn41fpXB4PCttt004ZBjDfI4v9JD2uwrrTopYaMyvdGZtDsvnIKAQvXziOpxIS1zhOhn3bWq91gmNTP0D6Enxg3GE+zHuZG3M0H0NgKwirBnrSMONF6w3s5pfu+GuIjguEfMxOt3cMZfPnxXjK3/i3wztLWp/ktRslEHkPYKcOF7xDlL6Dj29GtN26dXcHVZw71jkcAXV0Z/p8b4EJlI=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:zGgyPITSx/1QyboL5LznmAgUdYCnSYKtqnbzHpEaG9IDa4TXgBbJYCvqTXu3pafdJeQEj4ZQPQGYa59Iz64E3X9HQus/STgKmZ8Wzj2AVWJ1Gnvaf2KtrKMJ+xpBiFH3E/DF0R2PCbik456o7pFF6lAULFgGeiauPWYVMZowp3Qk7yU6Kpwc6wfebWGEocXACZSTI6ToCj4s5io6vFxbJQXp2ImOTjZLPh85jyj8ZqozRg4fqNQrwNdrNrdXlTy1IE1PdUyVm0WOA+U7r5pHzV4PKFuQIVsNMObBncIOb9AphtDP0heWz/z6TMS13sXOBa0+eP1E2P8lg77Q4xeL5ECPangCZzxAOBgHOvNCHbtFSenFukopMWiMv1dSJHIuwII78kGv7RHmOmjr3IVkQN2zK88j8fqRCDi2ZfHb4vPWrSt0d+/UIaIdWrhnqCGpeH5MwNMzeaOpyqw3TTvPKw==;5:hYWHUEfPki+fEK50z/pHWdwpoK9DrQqHIXymiCqWCP8M7bNa6vXpNwUHnGzSJxdQriOp5EakQuXcFud+rRTtfvZBCGBzuiiD7gXeAZ6DwdEt6Sz59a8WQEEcEJJ1JyEPcXY+CmO4c+PzS6bwFw57ZnRq1EMvCMywbogisYTLI6Y=;7:JW/SXDOC9/DrD2UTgvVJj2Wq3w05ZOghAM4RbF8Y42FCzktmEF8MVaZiNz26zuPs2H8Nl/QcIa9VakiDieQzQd0XMdb/KQDaylFMb0ZVmjl1zJ3amxkS3FCsMYrKohb5CSd/HmspjIDGCuXK4IjAv0FZ4ZIAxNM0DU4FSwAHhEvVSYEZYGtp6Y2V7WmqNscsfmbrOWJ/l5PSQAKPbKQKEhU+ZfqlJ4tNLvawZ4e+SMwIxb9ccukyA8YKYlG+SNSl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:LUAoImZykTGlVWjPrpV+L6EiSaNMNee9VX09aHZMTv+K5TuMVX1ievp2cRnEWNgnXPAqP3Mi2GdcpwZ/0AbO8ZeHfQw24OjGJL49Sse7q+n+ef4abywsseF3tEC9a1bVqGgf8pUYqeQElL9x5tyL1Yia5VZ7GgYqZ6Gl/senp5w=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:44.3346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155e07a7-3bf9-4f98-7cb5-08d622fa9aaf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
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

