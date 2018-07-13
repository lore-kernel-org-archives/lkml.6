Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2DECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649CF208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZDZJkEDM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XTmi2KDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649CF208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGMT6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:58:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39666 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730149AbeGMT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:58:02 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DJcpc4013895;
        Fri, 13 Jul 2018 12:41:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=fkgQqv6q/krIr3dY9RyQ7CTn3U7kL4xYKu00/xLVnfg=;
 b=ZDZJkEDMH21KIAzoGnwwq51meYf5LtL6Fxumm9Pp2TsX9wJni8ziX0hLn9VbDxbdwGlv
 snoG4Ol0E68H2VY2KlZCEq/KmuhmsVzU/hoNcppGgtsExHwxwN+DwHJ21nDfA5wheh6A
 MceE3Cy19eNU+Chsl/P1te7Qw4zQa56W/MY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k7075rd26-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 12:41:39 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 13 Jul 2018 12:41:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkgQqv6q/krIr3dY9RyQ7CTn3U7kL4xYKu00/xLVnfg=;
 b=XTmi2KDbt/JqPU0f6pPIvkxFYs8GWd6E12QWymOWfWSs3bcrW5TxWrfVgxtgIrtBRd+ISuZ2JUD/MAGCGsH9jad1TrdpRtFfOhbTbTSlyQJGIGB3WeVORFBmYhWnG7+M8CNjhc6Vvmyex/GXE945g4JzMFfx8TXNg5hrokqj33U=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:1cec) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Fri, 13 Jul
 2018 19:41:30 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf 2/5] bpf: fix rcu annotations in compute_effective_progs()
Date:   Fri, 13 Jul 2018 12:41:11 -0700
Message-ID: <20180713194114.2711-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180713194114.2711-1-guro@fb.com>
References: <20180713194114.2711-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:1cec]
X-ClientProxiedBy: MWHPR14CA0063.namprd14.prod.outlook.com
 (2603:10b6:300:81::25) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba3229ac-1337-4e4a-7f48-08d5e8f8a1e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:C62CsU+zBzlrCr5qhK+08pYdOOVXgIOObuhv9J+TnxybgIxr/PrkR4UPmS22uENKqs6hCak+NqJUIoUBase4EE6s2jXv845sS2Xlk+6Lq5e1PNBMsNQqPtvGFg/v/d1bhJiPfo9GOd+ADTbBw1wriUylZwz60HailXGnrdFltrGnC0wbkYiEFE1+l38W8PYAMder4XC1jp2GThC03sRo5aBctAlTyWh0UnBJuJpaI8tXnzhTCfCps9b3VbpqN3H4;25:0vHMGmoCJNx/gOr24mO0L13aPkTUl+Op2TvNH9awgSRJpFAPLYuVfhUQ7IYMc+ZK4GpvQG6mH4JOqvPvuacFrF5FeQPDEaZ4jee1s730BCfRpta4qJA4FgNEheAocBjUD9HCoxAi1XNoYy3TkU9+YGoXX/FHe8K7dFvLBMM6O218F6ogAq+Iihkr8eUeX9cdBJvZKOWFLtIFJ50BlpFAEH6/iJUiw6FJrwQyxaOw5KAZfhwhP584OAkk79hkz5baWTVRjnByZ1N/9r7Aj9N6QW4BSX/5U2s16xcyWPSKZ5m4fl5tUaIk3exHe8fvr9Y6FvTA811lkZ723rR8hMOTqA==;31:RXRADbIqJUXeYoam6xxIAW87SEW9XEB0GkNNEShOGDzgXtkG6t6R3LJ/Cg1DwUhr01UarXOHk/Su9EckGA6FthV8wMMsOY/YHW+9gJY3FDOtgdS8em31fMdyAAnnjYVdKH2g+GtBW6CL5Zd+6Myil/vyP79gBJ+Xi5ySFVrL49UxYdavhTRokOqMCQjTQt7nAytCZKRzNeuxKh3PhF/Jqf6WCJTgM6qRGIgIN3vmqqM=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:HGpMaImO+8PSW2bOe/DFlZNmxD94lpoXWl2QvTE1tP2KHefZpmRerPqjDBPSG2H96sSQvAnNVos/T1IfNGlYnM3+RjFKRg/Bf9MkkQpzDwDqyhnsfAi+UZIik7/HUscGr9bqO+zA54d/doqEme9bsgysfSk+9E+fhDMdfOHFxGZGqaBG5kDP8lb9uNSWp6VoEBKfdsBgDznz60I6odMQ2F2gT6tBWv0wkrKMPV58SRcRjSsT33BFZId6d7i7JAx63wiRYUoEAsptqPRQ4BvUGpw3TH1e3oy+D6DdNToLnCzW/7CbSRh3WU1xX5KA7MgMgK9vIui4Nquif7eYFFWmNoXkfHZCPU4zhoNzCpMwiEsZC8lVcNniAh3zOsAaRlyRPRhxlZnQq0KvvLtreFjWhyp/HO0pOSKQ0MFdCgzeS0nyX0nIIPtplbWlNJuHsq55Q1GwINpl8cmxoUmcxe3RZ5K4CaSHI+czKbrqWMn+yuoxJ74cC9SCDF7x4hl/hvf8;4:YeW2b5SECF3tjkxG7Msdfp0mO6fmey7/v1GuX6dt8+zu/PL7Tz0IWQWAKhNwGzR4Cnm9EvpnGMmnuMIynGuw38jsaQpGscBtjXzrTjvAUDzrxltxwEFfQPo76OSxHKa961P9MSWywQf48WDim240HIiWPIS3/JOT/cQ52OgYcUdvYnC4T1dCqS/nRVDdHrNnEC1Rl7vKQP9wXmBAH6T937KFxw4n3cU6ZGAOnL4JksK+pmQkHVpsAFjpFKbw2uD2H1PF9gchQobO6ngUVww+NfWdtg41K3k7sCV3Yv3pa7dYjNjIHweKv2bb3RUxv+UN
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171D84FA5B83BA9355C8184BE580@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(53416004)(52116002)(16526019)(6506007)(6916009)(50466002)(48376002)(386003)(6666003)(1076002)(8676002)(46003)(186003)(86362001)(6116002)(575784001)(5660300001)(69596002)(8936002)(47776003)(6486002)(305945005)(2351001)(7736002)(478600001)(2361001)(81166006)(81156014)(105586002)(50226002)(76176011)(68736007)(106356001)(11346002)(54906003)(51416003)(476003)(52396003)(446003)(5024004)(2616005)(25786009)(16586007)(316002)(36756003)(4326008)(2906002)(97736004)(6512007)(486006)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:Chf1RZ++GU4LFrh8PmnnWmAo7k6gAi/yfO32dn4TD?=
 =?us-ascii?Q?M0rO+lIQs8xJ4kmapvbGFhYGQSC7Zh+1VFULrROQ5KNzacyNbkmN+AKvBie4?=
 =?us-ascii?Q?+tZcvaHi2ebxAEnH9EtSoQLCwkyh2OKRHPdjozn7c1JFhVIdzfceqOI2Um8b?=
 =?us-ascii?Q?grJBGAhJallrIx0jbFQXLlQkBZvD2DTKI9rVHzSTS1J5Y3KBhYgjwyJZraoR?=
 =?us-ascii?Q?KRy+NBkgnNcBx2s/pqevy5P95SwKTp7zUJJdcHs8w1h/7X/1qnde3YPKGes0?=
 =?us-ascii?Q?u3nSj5eW3JQJpuU9Qd6MokK20aHjSdugatWt+/dQZVbwRw/uQ8RCe7fNpSNa?=
 =?us-ascii?Q?J7ziJqwcYauFGd6QT0e/KJmjMNY+9Rv7y7YaRQ/Y8DUj6IownZaovsUL+R2F?=
 =?us-ascii?Q?73YE6kR7nxNf/ildobmf0ec4QpgVf1iAKmeqXXZtOxgI+fTHFE23MtARdrYQ?=
 =?us-ascii?Q?oGkWjm0O092HZG78kY3V4ZpMKYLR7lFHCtpgIMB5nFypoksvKPcExMqNADG5?=
 =?us-ascii?Q?Ra8N+duzLxwsJbuK+gz1Du+JIgtE4lI/YnQ8vLtRmpwdu1jHmxn3jNKxOR6r?=
 =?us-ascii?Q?DLwLEm1t2Kus6BVFxiT6ZrfxGmV8iEtogl0A50OweVTrgb3An7eICGhsAWtE?=
 =?us-ascii?Q?fc2IyZ6969XAxlMsb33ekqmjcEf3sQ9UyxOyjR9V/pNAQTWeD2a93AJ+SBVI?=
 =?us-ascii?Q?qVP6rlo+F3QRXphWyegPDWdyx9vPhwW5FDh2MgrauwScsPlLzeqhNyz0u5Fl?=
 =?us-ascii?Q?aepEZjYdV4Xm5mxD5zejnWSWTBiWWrhXI9M7fDQlSvoJ53lUXbyKvHf4z+Ei?=
 =?us-ascii?Q?UFqFIpZNi6N9wMIQ8ViLK1Ov3lMb2pviV6XViagiTx6UJURjjSNbuif/J8fX?=
 =?us-ascii?Q?I37zmR+emIK+CKCjXqHJu/O1jA5BMLCI3WQ5g2hStRkK2UYQbQtrpjLV4L0u?=
 =?us-ascii?Q?wM74NXEL9/f9omMR0J2ltsbO3wh0sLzDpXVtAkrsyF4S3Z6OIv0aKCPnbdUq?=
 =?us-ascii?Q?L3dCPtR5ElSic9U/87ZktLuui/kmDM8lhkoGXTk/3ZTvIDf7vQpiupj6/wDS?=
 =?us-ascii?Q?8bbM+18oyWZavqDnky2VfHFB43y6kcMuhnFB8Jd2JHrHtR8aotzSiNksgdAv?=
 =?us-ascii?Q?lse4HYNaTnEVPSc85IUogJ98YWErhFEtPtDLgjwra0eu4Tds1Ae6fFDjS/EH?=
 =?us-ascii?Q?fSl3+YfkNnSDLf2N8cb7VB8g2JSzlyeMoC8q/LqSzVJz3OtmvEUVfZ9k9Hic?=
 =?us-ascii?Q?h8aLCtvMfSEWuUSEE7v1WEqvydYpdKPQeyMk9yRkzASABCjdYqiaMiUoemN4?=
 =?us-ascii?Q?arXdWOlzk8i+ZpUwGnlSr8=3D?=
X-Microsoft-Antispam-Message-Info: bLvup2a4a/LBwcp4unWVyb8Zya/HExKn/meB1XGS0e2OMRuNSttlzPwrZ9g66ynSS+isnJTf09wqAzM3qsSVLkEWX3mbQqKDE0jGSOiw8IwWrYCI0FW/sYYJ11utUmGb46WwJXOkfXP7SgZffag6XlVOt15Rs/JZImd7KYowUJrgPGW1Ko6uP+J4d20okskpTlWamcziyUXWtehf2frbUPiWTEVP3/xdohxAZ/2n9Alm9VOBsKglH60AZj8nzvp3ly3dZPG9OgYf47ZGUIQq58uXsGDEHEhNjrUHi2y85j6zlYqEXItZH5+taB/LF8epF+HZxynclCx0KC2AszxwNbs7M8xpt8Ik5TnI5wAilHA=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:RjzSAboXThdD65/2VjsIN8ZvDe9kwyBKINOovhiC1HhiKBWEkg7LadvVn3TpwYv96rHHgj2dvu6JWLDRRuIHpUyTINblukxNRZG4zvMGC1W/fqZzqq5/hZQ6B6FE63g20WUz1hSG8nVWeEUkoDnbGHNZitfy+TiYj2DxdywIHL/8Xequa+nkQSBC3FIwY6qtRykdSOYIB4H0+3iE+1dpIIkxUuD4yC8vPPfYP4D5dnq3YaNPC3uYovG0iYHysqQHFLt3B+z8E4tJ4dMlfTsm2m1cJR4Jv7rwp90lqQrTEuZf5xQV5ojtNo93dYoeh8CB0ph1BphiVhAMJ/vDCwquZBCyUgW8u53Hb8rtBKHUvbl/ufs323psqTT6zHSq4D4GlK4Qw6OZbHbvx7GbcAuyJRwqBK9h3qFSPOoD39UOaVLADlyGj+lASIn34+8YR58zq2mm1uSvETyfKE7YYzxNgg==;5:YX68ozbJmVrl4r9IeRet4zW5s4aQhRxJaruh5zfo0XMUY+7REZjGfug1IsfglEVHB1n0a/E/mT6UYkeBDBeEn/Z8b6B9M/nyetmqgGLt24ytrA+RzjbOTv06RfuxxCeLIu1YWqOVhta96uejdPBU4keUl8HKPU0APa1R9V/mFRc=;24:s1hbOdfeXg4zhj1o/ZPD669VYs7eij7l/ehw0w/yLCoX5kClMxhJ0Z+glsdGlRg01nW59LWa8xB/H6+JVLd6/hsKz0HBAgEODJBOeBEBk6U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;7:Fx+69E9nvt2woBHKex+fba66iU7G3YpKRzSI66cIyiyX3a0MiGmdxp2JXq56dEUvyT/DWpa+gIY9e0L/zsZCJiqOL2XSVwanE3jDaRTUJzIxg4nDCJ0Lo8jx7cc9sN6qW80nbDQAiLjLBzGBUdMOP5B5yHzg2Fw5xKkOPLis6h2dSNYk4gKTxrTL/1MsacuLs0MzFrpExuw9V90qBEJbJgbJnSlpge5s1uAmoRQlixouGrhxZoC6vVgEVhxnk1Kp;20:SBuPXgr9Nr7EbjgszTjkMUpgMy5/wmII3ZNNSALJs9SYk4Nu3mEdEI+U/aSmjTb71wdOTlGD2LJ1jm8kEpT2LzCkO9p572nIBMmUkpq3OqEnxqrgz8Kt66XdmwrhL5WnhwVq3+6odBCNxNYVVC2ytkqodqan3WzWxubyTv1HAc8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 19:41:30.1117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3229ac-1337-4e4a-7f48-08d5e8f8a1e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The progs local variable in compute_effective_progs() is marked
as __rcu, which is not correct. This is a local pointer, which
is initialized by bpf_prog_array_alloc(), which also now
returns a generic non-rcu pointer.

The real rcu-protected pointer is *array (array is a pointer
to an RCU-protected pointer), so the assignment should be performed
using rcu_assign_pointer().

Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 3d83ee7df381..badabb0b435c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -95,7 +95,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				   enum bpf_attach_type type,
 				   struct bpf_prog_array __rcu **array)
 {
-	struct bpf_prog_array __rcu *progs;
+	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p = cgrp;
 	int cnt = 0;
@@ -120,13 +120,12 @@ static int compute_effective_progs(struct cgroup *cgrp,
 					    &p->bpf.progs[type], node) {
 				if (!pl->prog)
 					continue;
-				rcu_dereference_protected(progs, 1)->
-					progs[cnt++] = pl->prog;
+				progs->progs[cnt++] = pl->prog;
 			}
 		p = cgroup_parent(p);
 	} while (p);
 
-	*array = progs;
+	rcu_assign_pointer(*array, progs);
 	return 0;
 }
 
-- 
2.14.4

