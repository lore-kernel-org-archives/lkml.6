Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E96C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C8320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ILJgRzWI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Jq9PPjGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C8320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeHBA05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387630AbeHBA0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:53 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MZ0oJ020865;
        Wed, 1 Aug 2018 15:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=ILJgRzWIwCUnUhTfGiFXEATcFZdjI428QA49kt88HvzU5+g+4Q0xPzg9df76hI+WW11/
 RBXv8Uir0IeSTrxLBXC5CgnvxDTYaSbHf0USEeirG7K3M4XIGbuibiA75b6H6hmM3zpG
 5fS19HE02YMCOUtSaVZyY8EnfV5ibTDPFTU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmqb05qt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=Jq9PPjGAkCxecNjlrkDAVnBHTzn4xQnCcH3qL82wppOE+1X6fijIbEgtojYGuI4PtZ1x83SqckQKgY+dsiWKB9R50l814ub7RbhBy0cvOmejTFRbIsGcNQQzMgLOiUnTV5CLcsfkiUduT8ZPvg+NvQYsiZceZ4metY8untxcBEI=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 11/14] bpf/test_run: support cgroup local storage
Date:   Wed, 1 Aug 2018 15:37:37 -0700
Message-ID: <20180801223740.11252-12-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab5237d-96d0-4c5a-39b8-08d5f7ff7ec2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:Y+syTrpIP7uosIE7xx1AL3C8IE5Nho2iAoeAQoH3IaLSa93O46Vb1mxZ3YiB/oiekAnhPiXUCnGZkAHUYSKzTyyqu0Pg3neU9Gp5ziBid1IMNHVRaU+VrepXmYzzwRGw9PqMwceeJYW92W9IVKlX0uF4knXPdshAvLgJwfOlPw+0jVIxUq7eWM/yS1EZPvc9fCFCKBO4P3GIBSWfdBBRSjg7OZ0apgZKz1NAkjRz1B1MoIMGHIq7ZgZ8UzwIkdVG;25:xCgq/D222nuY6QVTN3TbfcjU7hWAa7IV8e4LI0VsQhYCA0G29RV6eNjq8WSTg7PMtcOdELDttaVldLDlL3GjrGSBUiYzLrKbLh+xh4IhxiZkQn5DucSPicJM2bTZNc+kzoYd4j2zjzux+gOdboSMorwwEpkXpyIhqCvAkd2YXgW+hryAI+3pwvoBVkBet39/SuaoFrx0nQ1/mM4OyEzBHvlVIGmwHxNSNOedEQA8iazWVS+Jo1oRsWya2J2ugrv+TeZyrKSQimNGRvo3aijxDo+v2Lm4nUb7V33t7FCJz+HeioHArp/FaOuCaMmi8iQu4Uyp9+gAzvcIpFmcf4jciw==;31:SAeC1ghWMrH7EnsUeEP+McZdkdPNZ5gejNwkoMm4Bj1jjHT0jIykub99Ef/+l2Gc5OHhUffhLDIVyfuuYC+tIyKo+vyhYhUE+bQTgfbgnByrMIGLD+xFkzaT9K0VuaNX0NlIidkuVb3nowH/2yJho7tdJKNyg3eMAvWAu2RAc6GiP56TUkmlcC+xaiVsxcyi6YHXLRgUNqSEriocOPc5Fh0Zz3X1CySaRWk4wt+Egds=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:Tz190elG3h7k5bck5jMbgy0ZpEnbukvhUDZ6QxvGT54zj2OGqrLE8pAFgb5vEh45/PkVkZXaYL/M+9UWPJPpZKS+tMP+rEyKuLph+OT+LaF8jAwHL7cPiWFzSRAZI0l2gf4zdQVrzQ86rMNJJ9icWMBFLsWIy3Kpi9pIPB5fwRIgLTpTuXy3lwJhgvqcZmxot/9MbYNaa/SJtl7dA7AgJsyWwPlG0BRCBcemTMPwTdbXn9+9GJNgnn9KWOM0I2iO0OEBlXH61f3ijwyo03IQR8baObrtl40uJronRm6Nfd9SGUe4KXkhfuCzrAXlJL3uhaWohS1G4bmd8bWwu9iCt+wKuqTHqkV2Iz9BzjE/SyvNVspv1McvYpaDYxPl5qxYvq58toloYF7ZiyHjfmJszsNiti8JAu5GGkf01Oa+w2Dv2wPEJ4lAl2OT+7b/lJ1pyJXMBJicQ5p6M/eNIf2x/EPRs2WV/Feb/ivpiqt00uD97ucsO3jgIEM6Ii/YtiTC;4:af+RLKRNGZqDJNvfIrbVqL5i/fi54Ev+X0v4Qun36CNXnJhOvKmZlgQ+/tBHdqaRWRK5/7+OQDxRYQnam/p1T2aO6rKcXjcyuxurKbwSEUF/RU0dMvnbMSjwqBx0yUk8MQ1++j7dik7mu9OjpQeqI0RSoSItjqZaAyPbaPxjQfYG6rtavsTDi9njmcHQW00h4DrHQlZ4gmhvcT1RNPumPMB+70a4aXyQwYQy23KHFMDFkuRplMv5PoDzTf2hSP+C5JqhhdNcdxPolF6/p9APkph2UcVEYMEhIBjOJHpnUVpOYB7zC4Q0T4eTGhIP9HY9
X-Microsoft-Antispam-PRVS: <SN1PR15MB01762B345F80E94CDD89A08EBE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:Bam+cLX6fWlSjNL9qOt8LvUDuLAekr98PZsRqsOnP?=
 =?us-ascii?Q?TWePgx3+KAmJ1JvYlJKh/YZI6SZZe1o7xHu0yMPGgGLhQS5LNQh54ka6kHIg?=
 =?us-ascii?Q?tHVdmhkG0VhzaXTZXu8R/AE6sd+V1UtXdemXUcvdQ3CPdJtA6vttZkDrcXzE?=
 =?us-ascii?Q?8KhkEgrbJDIeKN3u5+k+Kjs7eoQ9eJwMhpkmqqhiRbflU8ayLt1e+DwohAK9?=
 =?us-ascii?Q?OuLISIUWc+5/rN4RG9+t4JoXjLBNh1EN48mBSLtB6W2kqabAZSm7B/R1cHDz?=
 =?us-ascii?Q?29cXrSQZayhPWbihVSjMYoj2/YkFY4pYTaGINNOhAAncCgq7wwoRb0YFX5LI?=
 =?us-ascii?Q?J7WnM48zm27HfjCt57DZKsBM0LYG7UqnVD7JkYVaAXUgh4xzriap5puq3gbk?=
 =?us-ascii?Q?8IoEX+GzK+NWUC2AJ2oZopmYP45kbBOuFbg4fo+8o9GVXV3sZiq3Y8G5DIXt?=
 =?us-ascii?Q?ram0HRD8HHpLeeypTpM62r5PVSzeKqiYmDf2JihhRZqs3pfU1VFslEx4/p53?=
 =?us-ascii?Q?rTt73FqJkAytYoeu7GpXNBUl9RaEChxn/kYkDGH484wHX3ut5+hjyeTZHCMd?=
 =?us-ascii?Q?NB8/3iiCzDfUfNe6c1ze/uREeqnhN3JQpPuyZoPXvxlWBBoBeuOj3Ld8lyIx?=
 =?us-ascii?Q?hXBWmxQIdEI/1RvZcST641yMZzY5FP/Hh6WrDGn2k+bz4NtJSX0H/hPTsLZf?=
 =?us-ascii?Q?8fGD8SbZOVXiSm9VYzJhUGGDB4nu/8cG+dzfxEL7lLZeNSU+iYcUJvy1Xxxc?=
 =?us-ascii?Q?55xC7JXcn/kv/8+CK0LHZhDEFZ+K/TNaV2PRa5b0PbWaDN9Hz4ijG1x5e9fk?=
 =?us-ascii?Q?GxZMQWqL2oCJtwC9fody+Jbfj/V1Wfop/CRcUFBoRE3yj7YyOp9vZbDRIchy?=
 =?us-ascii?Q?q0ew2jeFMFjxwiejmTRSGZvAPsNQ7ojUXtHmMV8tEn7OuL84YuWc5wZgsXmH?=
 =?us-ascii?Q?zlycgf9dt7/adEFi7ZuEaqagQPYxYmYY1OMEZg2EElhAxG0Ezig0VbUuJVBl?=
 =?us-ascii?Q?HK7xbsfJbMgnB+i3X91MBW34YEdUQz11qecA+GYR4WaJFtL+Og4nSAuOF/LC?=
 =?us-ascii?Q?B7Zdhf3dz5IdimrxgBRiBLO89Lxw/5oqtM5tzxI/miL1ymlShMpdEWoTMKSj?=
 =?us-ascii?Q?ccLUXoNXQ+KvhU/v6GKcvdf4HmK/usHhqCiQBAsU40eOOpX99C0GQcRtvN0M?=
 =?us-ascii?Q?biGSaMyGK6Q4Tj6Ybc17KqQ5XNhjgr/nZc1i76iOKLfskbTSbbworbyDHxGV?=
 =?us-ascii?Q?BephyAf3dYE4lCYoPKuPjscsK6M+NJH5gQWobWGMJRFs8Ue4PPoOP/7heu2l?=
 =?us-ascii?Q?/MzHM6XzHLUfCjuia7GJRA=3D?=
X-Microsoft-Antispam-Message-Info: yicNrfMWw7mjFgHBj5xeFV2yxdTAx+MPU6kbTo4lUJmXpXyDgIa66mRVhZDDSNcNmYP3+o1yOb97LpGCvf8d4RROLoE4Kfi/KIzAzD1OJxiV3tEntX/AzHJb0IWJzdrR4ZBoLRdyW0/34/JwXw+Jrmvwj1RHCCKGoncB59sawT5/vuoAiP4h9nD+qgQM/DvQhPGpr6REgX/FY/i2IoH4vK7rgQF8OgRLwWPCsEQ+CC2uybw3mR8D+2NbhDURg4mTZUpv7JgmLcy/L5hDLhQ0Pw3K+EQ9bUEC2tT2r1MNiUQfmkrV8xYD8sZQ1LvLA4fJHQ7sgp4G03R/TTtEM1z60QDsC+2YDLkKaDFMqfiZTdo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:JVDw2xbOLpZQHEl6bt/qbjdt1FwBE0QzUSaSG9ZJ9phG/4SV9nQISXVXQyjTG4T5nSZOgoOUWfzuQXFVuTwpAV7dI7FoPlWKKLvKdx7XSDKiqx7PkBrIoBZU6JpUYE1Qyog8p/UeoRc2vl8VLMaLx704CuJHp294XCPvdpMJIy51ofIZYZbZVdp2sdBhCaaAY37Q/i60VuaL/Z0ZevFAFAEees3NdxsgGblQ8mUzjo8SMvn5PdYpd//gEDPZsgPua3hMVg8qhVvxZ9DPk9z/tWeeYdb+BHf12ctlfKHgH6ddiGvBgDYcTvftMkTfPnzkYZzTxol7KKzqdgfoWItdPezbGUyUAOBz62CGyh08Knk+DBSw4VsPOQlx20km0LsVpNfr0xdqbR1IXjkN40BzPZZlE5ielsktrWmFbr92T9ujAr/O9LhUrJBWYGTo9CkLYOugveUlg32SeCOiLqxrFw==;5:xwsVu+3m59Jg2ug5EBjnvuG8IXyWl1N/kj+wCneGK/XhM145c/aaGL3/uvWviByn5IFvWiqOdSq6BQ8hlrG5vAX0u6IhhRP9KTQs08yVQw4LDnNKEeKuPoFnuX+zaxpHwdCrGGYnXU02YCD/hexwqigCa9Y8UKnf4OgwOjisybo=;7:hi2Lpd/Qtms1MNLDY1vhfVfAdvIbS2s5+reOFI6WVP+im5DRTJW1EA65yV3VDOffTGgQQu8aa+QImhloHty+h4OyigXaE+8zfN1hS/lBi+5QaUJheOrzgGS0/ulUalQZcW/kNbYDms+Wdw2ui9HpNsrXvYJNmf362iP4Y41B2P3cvDfBZnGzMpwKw1eKQxB2ktNxNaKqhFkgNqrlXPq3QL+elSsdrUT6RWd1FCbW9XJSN4KpG0eQNeLarBV6kokm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:rs8Tjbm64mTw7D8HVR/xpgb4qQTffIHv2f/x+N2bLcp6CMDvfB/XyQb5QgoF9QHutGeTPv2q474g33G0L6/YWOCsE6G20YaP8rwC6Q70yO/lLqgwxEAu/YmL0KyIFjRvz3DrcV3TYTRjgwF6IvuiQeziaETHLUBmqSz59elocFw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:25.1966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab5237d-96d0-4c5a-39b8-08d5f7ff7ec2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a temporary cgroup storage to use for bpf program test runs.

Because the test program is not actually attached to a cgroup,
the storage is allocated manually just for the execution
of the bpf program.

If the program is executed multiple times, the storage is not zeroed
on each run, emulating multiple runs of the program, attached to
a real cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 net/bpf/test_run.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 22a78eedf4b1..f4078830ea50 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -11,12 +11,14 @@
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
 
-static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
+static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
+					    struct bpf_cgroup_storage *storage)
 {
 	u32 ret;
 
 	preempt_disable();
 	rcu_read_lock();
+	bpf_cgroup_storage_set(storage);
 	ret = BPF_PROG_RUN(prog, ctx);
 	rcu_read_unlock();
 	preempt_enable();
@@ -26,14 +28,19 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
 
 static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 {
+	struct bpf_cgroup_storage *storage = NULL;
 	u64 time_start, time_spent = 0;
 	u32 ret = 0, i;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return PTR_ERR(storage);
+
 	if (!repeat)
 		repeat = 1;
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		ret = bpf_test_run_one(prog, ctx);
+		ret = bpf_test_run_one(prog, ctx, storage);
 		if (need_resched()) {
 			if (signal_pending(current))
 				break;
@@ -46,6 +53,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
+	bpf_cgroup_storage_free(storage);
+
 	return ret;
 }
 
-- 
2.14.4

