Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB78C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB82123FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lk+26anv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jCJwkbxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB82123FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbeGEUxp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51718 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754357AbeGEUwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:44 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65Km7es005933;
        Thu, 5 Jul 2018 13:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=bORC1JD0YP835z1QFQWDyQXRjeP3qHZESb5m6qq3qEU=;
 b=lk+26anvMdCPug6eiJ1Y6ZZCYg7HJHG02kcOeZKZnPBxO23uIYY8tdT89UijJMKEin0i
 +2qMbrQYscGvoPosSAzI7iE3awIUejl1fAZ4/OVnsSiRh+Q1Qv5GarCPjJ8PJb4KXnM1
 Qi5AQ7W4t0bnZyG62GDXsB2gwUKQrTEg9R8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1pub8spk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:23 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 16:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bORC1JD0YP835z1QFQWDyQXRjeP3qHZESb5m6qq3qEU=;
 b=jCJwkbxwo+GiUNxH4ewVf7VTmpz1tbmxFn7Llkz6yzGDM4oD5RNnfELS2t/kbbBkBvaiivdcT2ti6jxVQRTzF/SxQtEkGsIvQWdYolQ6Um6Y3dj1viQpa1anGRRI5S4gr9IjoSDK1W161igECXJxBoKsMrMhTV48RaAzn5voYMA=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:18 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 11/14] bpf/test_run: support cgroup local storage
Date:   Thu, 5 Jul 2018 13:51:36 -0700
Message-ID: <20180705205139.3462-12-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb29d49-7e49-40fb-5916-08d5e2b932b3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:7tKza6Utw2WFYjnOBCGx2G8iVOkg7UgeOZdiI5dw32purv6J+jd6WFs7ce5Xvb2fQeoZazTA8RYc8WozURgDlz2UCr1J7Ix+cKa8l5ZmrTUp0eafRa7bQetroRTjGfMi72dvCy99Qw4yisMRHnlf2op2IIF7gKoWx6tRUsnZGeyyG85/hbTgSmaebfKAsm9S9PYmMpTQqPfVOj17zqBj4UxB0lBMmAhHu060bXJpt7zguvb543wFP25Uf2huSkie;25:uRYBy/s4C3e/A5QLQWkPnNlHa6hkWbLf9CWrPzAO7pr1yJXrQ535Ep3n6OxMwwM5CRNaWKz1VndlRWK52U27PugOIefH6TwTtpSVYCvN4ibXtLzn1jFFQhdOItbFk5FB2YKdN1EA6BAR76Km9DkMDbMa6R056kjtbjYockxi5lG6CsT6+7wjB/3LFMTt5SSOO0xm+ZFKodNg1OnPrZ/9bTiKxGpQ0remPmj0ZmJRJtRNO0vfkzIFBnP/7sN6AHYwDwrTNHB2yOm3YvlxjDsVW//B+spYAMnND8W+ayE+Qa2tttycs2Ma7QdIrZ8cSNjLPHxBhMhWPm96Vry2AahNsQ==;31:3HeZFlKhxyFD1MPdAp4ju27wPvFvPeSO3kvOBHJMFOpNL87B5PIcBX28tVD+Rg31OOUs9p3oO2bCNJ41JtbO5OdEGoJMQBNeHHQ83gslDFK65oot1qzH5vIUnwf1VM8DQAsUHKrk0TP9cVxPT8aTcJ8g2oRxMXwvYJ+kF/o8/qYMba07c9xV3iTck3nAzt9NE/P9rfP9hHRmKyR6hfqE3nW7YAE72CEVxaQoHGSkicU=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:z7DwaEhqTtLuTzuU3Fm4K8aHgMILZishmzN1omB0g4DBBL86YTkX1PtHPyYfobNK6smkMkF779DyvjSsm5o8pSlHxei+d/NhgRNT5bb6otw+ctojPbi6z8XiD0ZWUsGd9zKan1EkUdI54CSGxmz959nvQd/y1bTWk4QyAYEEFAO6LK+fWpLaHBRGd/oQIerX1s79sm/3BIoaHY1VqoKD+u3RyOEtmJNIx+caiqHrFN2MgU0lHM8modNd+0Youp/EkzTInJh2n42asPmRVOxFaNZWHsod/LTrvMwKLStQYmc/gyDIjKxit+X+qglMhsPfEvH41kU0jQPmXnec1edPXUFVqFQN/bEbuUQAA34rOfWydYlIfWviFOp5MSXRCy8qeoEkztyDVO2v2jg7BNbSzf+n3F04JquVKdXmKNZnWLXE9K4JVl45Bl2jOt+clOtuH/ZRBsJIDoZszAvd0rp4n/Cj9D4+gV0qH4foAVii9dAAjPuYY9VqUcwO6agwo1Xc;4:1tdry5JlTFT7IZ4NZ+DexkgLqV/ePQSbfJ843vdcV/byjTsD74OJae6u/af9o1rENPd39fKGmIxECQs7k3BGnhvrmC2dK8r8k01LzpCrtwJDYpQFZbrE4hqIn+rQRm3spJQtXU7ODuJEeKgAXg6TqYW6mbGH+jX2Qmz5txTLme5tAL9zVPU2C5tSFY73BhgJtcSzP+ConjPByG+jN3DLBLHuGi0AfoiWML3aGRuULotiGGmNaDZFVcZjyamlQyswPDP4O78J3nNpHL2Ujw2gJMjNMNYo+0OSkyGVnSkbcjzEpMcVjAzs9u/LyKZ4F99/
X-Microsoft-Antispam-PRVS: <BY2PR15MB016669399D5D9BEF6F20777ABE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:m1Be/1hYXUcuWHAEY0E+kvhu66XHmvmbgF6vmIbCK?=
 =?us-ascii?Q?GkR1ovGV/Nwbl/bcBxfLBdwQlzbVIxV9OBjzKyjZOtMXPUextKLmPij70Fix?=
 =?us-ascii?Q?eRwLX4tzB5cxz/6lt2TDIh5owQOlFOyicQ5rLnxqyRwdnHAnM5oLyNxKvge6?=
 =?us-ascii?Q?+E43QsYzUsx513xLwo2CLbikIX/PCPaRF3b783h/Q2sh7dKKGd7Uu/Qlt9Lk?=
 =?us-ascii?Q?iQghAjZqHtiSH/HMbARHcJTUOB21D6MHgYqVhDf+ZeIAQeqkLuXxkkYsQO32?=
 =?us-ascii?Q?/yGjGgXumnqBcWYD+lpe2nQF6qXJGPh98L93bMyFSa+2U3urBhLuGMUBMMUK?=
 =?us-ascii?Q?icMBhuH/6MtkhFIYDTBILrO29z3e+ArCM/MaMvhrKqmgKmiTZ0Mo6p8d6puY?=
 =?us-ascii?Q?r2/qOCid20r4IqYxag216FPqG3NhDiy74/CowjpspIyAKjb26oHaZy/g4wEs?=
 =?us-ascii?Q?gY5ymTTLrfse0J4NFcrennq6GdGVoCJSlb+FPvU5zpFC0CmixPYvdaM/JWi+?=
 =?us-ascii?Q?HIJMctxQ+GuOq3D8RoRge5GJX4rnnGd+ggrT1GFhHCEsgUhE3Marmej6CQ78?=
 =?us-ascii?Q?z+W4WnYyTLaYNphIlrqYfzAVxtr+NWrrDWcuLEPuOxG12MAOO0bIc23KKBLE?=
 =?us-ascii?Q?HFxekrBdFYR/J1Xm6NKMSHOWrVAKVzhWHrFoSNE3BJ9sveclxuOcjtscpAcV?=
 =?us-ascii?Q?gmvXsifKA94Zai4kUeVvoY2P2f60Ebb6ZiwHLGMrVLUEFCOvYDcUfLcuZ6tm?=
 =?us-ascii?Q?AVPX6HgZ8G9rkts71hZJ8JEIL6+7L7lU5a66my6zRE7CGQ+v/Pb9FQa7p1uy?=
 =?us-ascii?Q?4OIIS1bB3XCE73CF4YdiJ6jvyAI9cIl+0n6/14n9r+5AofFdXfy2YGEIv2f0?=
 =?us-ascii?Q?Bm5RUBCrzb8iT973i7a1bdBgYV5c+vglmiyyLUsm3YwcdYn9dRsDV5CyNLkN?=
 =?us-ascii?Q?bue+pN3hc7dS1d52gMf7aFFkDu8oUDqWxPX/AVYeaLrugqe9uEM6N3Q1T0/m?=
 =?us-ascii?Q?K2zIm3HQSJ0ch3UTRY4r6boDRE/dzkuR6VNT84Zz0DNiCj+FrwUQVCgRgQzz?=
 =?us-ascii?Q?jNXwULeeOCAA4ZyyJ+M0F2+dQjV9pHNGYZpSr3Ol8zoPr9dQZKtIC582iE2W?=
 =?us-ascii?Q?k27BfZqPLEy7SFfPsyQzaKolEf24j/DRaE80MAbGnwz4mzLtKZChwlum3aVR?=
 =?us-ascii?Q?/7KdX0Z1/iSyYSme26Y3jUivGCTbILiHO9u5kUPx5FUYJxvj5EShJm3MdtQ+?=
 =?us-ascii?Q?0Xfoyzr+EEC6ee9Dwy0aRt/LBboX83MpVZaeBhgWeDz/klRA6dN3nuGdkZ6k?=
 =?us-ascii?Q?8NgPpIyEtEogcPs0zrYzrg=3D?=
X-Microsoft-Antispam-Message-Info: U/TKS0pYMBP55+kQ2KxkdWyTH0Ks3Q28KddJOBBpNfnCY2cFnQGhypF4naxYUbfXPAuxc0F9YwC1QtNdcoVbDYgLw4oOZzngD1vqtSqA73bt8GJpamZEjGUpkG4MBcnWRw9KGC2xsBH0bWAtTLSl6BwpFjZZvesqe5DVXhCgzY7AmIGOCjAADj8HgGOssWWj31P8jUuWNyUF9Gt8UjohVG199hDXqfI4aoy/EzHhYHnoIFAXlsGZm6devPZXLYcMSvZIbat/PHS4F7hrQhbd6lHDBsagi3Tn1MN5HsBFvUnoLlkNcoKJO4t4VgXq6UDo2ymz6dz+Irc3LKdERCXf53niNMCN0CqW6OLM+fe74HI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:qAL10VooyB6GMZXuOXrQILhaYepIHEdcPH0e9/tbnhr64HPyTqwb9mKOzwsIKERYXlW51v84G6ABk2bgL776m3u4VE+b58eqi+FaWtVyjC/eBkhYEZ4eD67HIHsmheOLOpe6vIi4xVcTVkbn0FCshlX5tDv2xfWROo0sxnjpd6nCrVaymeOHU+MdgKV3p7FgJe6lo2CWvJm7P0RhyVpsFGlXYtlEPCGiRgk0VdAn5dFQtOaT778+zt+n/fOGfmST1OCSPVv0GSKqrFmaU6RLpyA6s4aCpXZXzFEj9d5cemOU7lsfCR0aZP49ZCJjPzp/lpf13NdTNBlargVG/QUnEglj+xdQC4wF1LlvboELPGJJeTgmjFD7aM2yEhc/TdDurX34xPYozo21Yt9lKdxl25Dh8w/A+W9ujQZd3YcS+ZXuZw8kjV6/1nxiSXSItlXIUHpaz5ngdq27aDN3+4iioQ==;5:BKqYXy+O/WNoiiphHg1bfkqiEVgmL/jsCWspTfHXYvbgdPC/i7Ujpp84judcXqWlohIRjz8QaDuWFtirkD1L1l6BR9cPHmGaDSyU5+M+LEddVw7J9zosrVe2Ilz+So5oXKITomPp4a/Cjbq0b+CjOLJvwfvvrjf3klcJSxqS2x8=;24:CG053AFZuLP6WMFNHGc/s1/mdMWtcAi9rTguKkt+0TBPqvYVhtfLUCAr2UAdLNHRwXxKl4/qU27sU3xWpB6Q6I8zes77b8difQs7Yptt734=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:Rq8HUeC7AUAr2BUDfqTYER1d+72OtCQczbnd3lVOxjDKwV+sOnPa4+eUfIax7YHa21w+ZVfll8fRPK5xlH7C7ZsvgdvYwcZyYnXgXVijoVERe6Kd/F9UH71EkYTBYkhlOPgUtNiLozDLNgDUevtP+Q7EPBfXZDYvITiHKdJhHN2yP4rYpLi2K/neAdkZ40eJgzO3ANYleb+hdQ/ms8yDY9z66yZtJLUM8t99rUhvkqeZ6CpyOJ2atfRe4iPNOKCS;20:onVWj1kyEgQu8nPc/VcGZAdFd9t4gVZb50D+wiIZe6Txv2nuCozy912zAEN/xaVsu3WB9MZBhonQ2p+2v32F+d/462WaEgPUMN2kNhdm9nA6ZMwtvvVhwL4lhcYO4od6Hj9bxSVijpvjqEMXuF6LcpUjkD6/S71leTHQ3ke8yRg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:18.4449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb29d49-7e49-40fb-5916-08d5e2b932b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
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
index 68c3578343b4..74971a9b7cfb 100644
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

