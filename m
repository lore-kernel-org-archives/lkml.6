Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCC3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BA5208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FGDQKLIA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ST2sAVCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BA5208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbeHAX0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:26:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46310 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388609AbeHAXZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:39 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LYL5C009953;
        Wed, 1 Aug 2018 14:37:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=FGDQKLIAUIzM/0CjFJspySxWW/QatN9rQ8rk+zrXpL5FwFLRVmqFXsMR0IhmjcgGfaCX
 4tW63NohEvY6KAX7wU9LBz+XHYBrszjKCzzR4Hb6k/iNSOsbOHrv7Xyp7VtP7KRdpD+B
 7+IGLYd6q4c75m4rKTQasssz0tnpkhAgco0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkm9tr3qg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:30 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=ST2sAVCGs8m4i1pLK6zpw87HzOeB2LHLlXHRvcFPSUR/6fNbUmgVe7EDtcL99z9zoE6eh0svNR2lGZbCUOYR8b/+wNa8EtLiJskW+vDgQl4dPF7iJguV5YGdd6PcSin5Ab3D2vZTMNkWYleZaLoWS5ubksvu+3BRKfJGzmUHBX4=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:21 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 11/14] bpf/test_run: support cgroup local storage
Date:   Wed, 1 Aug 2018 14:36:46 -0700
Message-ID: <20180801213649.30751-12-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 228ac692-0627-4e3b-460c-08d5f7f6f6cc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:vShEjJTmAhS32Onosp3YxAdbkvXQOGDiKZnQebtnefI01lZqKI0uF/yjyXZ2qd2j2ax7TTqObyt6PU1BABVTINUzWWZwQtzne3D33HtT/urWDb6kyMZU2W0hKvhH37RjLkYVkYJwkHgwK0CIevzz8FOW9jmUehj2rjb/U0P51Ub54cozyVnSL+QzcRkHMMphhBSQVjjgKfOqYuJYM8kowYPHqqQOn5Q6eIT/kdjoyhUISPy0ut3yWp+HECv2GB/t;25:yl/ruQTfmPnGSokTMvMvontTCAH5pY0QboMmeuFrRO0pFCSIXhIoxjDdlwFt1dMjcCOsRvF90qVhfVNHZgCLjE3lkUULhOBm8vzw3/4bIujjJOCqotNMku/tcwP4N+HyR6IdrDo8r2Zif0z6trA/RL6RV16LQkdnN8wouxWx51LuQQi6VzBXLDblQP1ouoWqFI3L2dhXY2Iumb4KRyAODdcP+w4+FEWaH+Xza+LXRcIhe2ceC8ZW6OkSKXNTyd+IZ+DpRWbrN40kMpTBj+yeNrtccheL4+Hw23ZYHtZI3+NQIqsWEB+h3gqJpITWL05Oog0LNeHRVeQeUKa5IJNvzw==;31:Atl/8gRd08AqCOVcP6zBG6aMYSzsKVOyS4oeQxDtkVSHgC3fojNhMEf/kHzidtF+Lo8PDmFxlv0SBgA+15rqClLlxCZzhrNV8D9t8yZudXwLtuw7RXoLZEToUa/aEQaovKY8yPVh2DXXtUh2QwR0YkRF+s6THiUyMSTA2v1auHAFQwlR0d/QUvtPI7qNO5LOUkPjfXZXQysQovCdbUF2gOzIBq8DcvbLUngv/YhMkZ0=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:3r85BWdNNxixORctTJ7XS13dIorqecNXr57zhuEFxXEwGOfS8Q5+DfqQY62z7Q9AgJ8xMo0ALXjZ+NMOxIEDZbOBmKMVRL0I5je+Kb1T/1trGymuWDrsWCzjIsDPH/Br9eYKXfUjxw/j27HNCbiQkebRTVzU5Tb/4LLAVmmQamVQeO5ovNIfla6bGQqFLOyabjR28QJWcSRgoHor7UF6KYmD/noFhDRdpSx9peMiAxlTbfeEOF3j6EiBYSyDjM7SI9DyQQpZpfhm0iN5tiRqR3wwuVK5fB1yHYGfR5xOyIYBLaz18HMJdxh+SNVaVU9WxhONub+kgDYVIedjxph8rDdgIhsz8o+dOTcmblhly1haCVXidL/NPVXMBByW4/hKaP4cb/xaYitnX8ScQ3yBQdsuP/idjKZnS4QCjg90vNDDWgD4LF99wCdbMLvyDiv8ErbicufiCSswtQ3Ui+NOwnKNI4khlWpcRnT/KOO4xMODFkTsNO8sfrP7uqkS6F9l;4:P6JavAucViHW8JFkQowhk9BFvF+5Z3t7H5Y6nnJJzmnM6NtxJDiAn47UsA5XIPHN/JDFawMiNwwqXj9iMma8OdOvDc/FpNQfIvbf/mDZkerSdxghqDuk5WeHipJt+o9+K79DdrIyy1PXXb8g8sPnnK4FDMOxaKb5Dv0ukPiEpx328uR9brBYRhD5z3NxLnz90F6y02EYofvstNtiuhM2QR8+8RLKrMqVUej5OBB8RQCBB0021EW2aM5zGNLgW5Rpdkw04doJibhNQYxfMgHLXMsLz1SeWskTSAP8kw31fcgIBNEYynkbsmABb+taHm9x
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167B51CACE7B2C6FC04F011BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:auaKMmF22GbqtImc+pXNx3ldViRzUn6DbNYo0MsZk?=
 =?us-ascii?Q?aWIagR/0UolOYa8HwgKSi8CbPfmrXugDI7aoC5RR9/SBJFEeMYC/SYbuXXX8?=
 =?us-ascii?Q?SrodJ7gwQ/G1yK3jzJ0wMO9WCHI9B15kAx2/FTtUX279RjkYnnsFLRYYU/7q?=
 =?us-ascii?Q?V60xFKfCP5/I8iR/ikGQBq/3wfL5gzzM2pNQuZr96LDt39OYZAiKCO2u44Mp?=
 =?us-ascii?Q?vmZ1yZA8qxcnYXTqzajIz0q3weftyXMXHH5rbOe6NoMPYfntwb6ukNWSLKxh?=
 =?us-ascii?Q?sqbEV/ZJa+pop3kjHQfS5MYQrTEpTKuQtfBpZ6+M6oN3QFKfk6X8p0u9iVjr?=
 =?us-ascii?Q?MDtGF2f1GPyGTy1WnjEzuDjDzioBOE4HQX2e+hCqrN86CNZGNTzkpULjSkkW?=
 =?us-ascii?Q?zFm3AZWU40kdKWmuwAfHohedGbZA0BnLGo2qerYNrOjFE6gcBPY5BR06FqJP?=
 =?us-ascii?Q?fWwZdtn+lm9gPQgD3KRXku+1+yZmbGFOCUX98wMadsBZ4zn3PZmsqpY6zH9+?=
 =?us-ascii?Q?1lwomwZfoNLRwHVsRIySskrLSUFmiLQJT7Bzlvr2Y0TPVbujGap9XPD84/bt?=
 =?us-ascii?Q?UOTJ3W0aKj6fzVuXs7yG6g0UMXOadnqNtjRoAtq6XJwmD36qWacyEK4CZ5wo?=
 =?us-ascii?Q?0fHeXW/z3VVEf9GY4ohaO8YO4oTlzHYqFIFRK1w0nEmMgW11pIbTRs55ILwV?=
 =?us-ascii?Q?+ppMFMJLQtfDgcGyyk6224tVAS7PlsQ7zcCjkq49rXBYGU5Avyj01NmRKLkr?=
 =?us-ascii?Q?iynxcf2z1Eun4E3PICM8IHMcLGdhxwBFnrykfCsERwYnoIgnQ4/7zvDD+p2q?=
 =?us-ascii?Q?+t4XIfJUU8p70UrfD0fMX/pGDTHSmLypEy/fQ3u0DFksliYTF82maOimKmTs?=
 =?us-ascii?Q?W9+GtNvy7R+CNjc9DAqC2mwKJ7UszfM/CwPHnJMRh8pqTHyvW49Npp6WL+9j?=
 =?us-ascii?Q?tPpA8z8AozshGrlJRbXbdIIibobQu+6vmyqVAgEeHOSTsYPkjZ4Qf+POgPLp?=
 =?us-ascii?Q?LAmt3l9H62rDRGGxlHL8VdLcWbbIRHyH5p+OsCBEiExSBMtk+r42Q++Au7eg?=
 =?us-ascii?Q?DZsotXia8lFXaq4ZDDws6E7RHoAAqLHg6x8c9PKX3iDaZ+rwvxolyWmnq8YP?=
 =?us-ascii?Q?ykTtWitkNDxqAH3rZhoG8GJaESBhfxAJy/2LVUGr/WCRazBYhN0ziNfny67D?=
 =?us-ascii?Q?wkIlwxZzNTUybqx1skrphy8MMYRcGk7PjpuyMUQzXyyNjhiqJ24pzdZEJznx?=
 =?us-ascii?Q?gNdZnKeyEvsAEQ2tYh1sapw3vGN/Zf5kkfQSf9EHDk0u1QVAnAs+fx7OZCZO?=
 =?us-ascii?Q?UMUpKe+ZG9Eb7mVJzHlArA=3D?=
X-Microsoft-Antispam-Message-Info: jSkTtybAEO+DE3GwhvtzcV3OAef0DA5jtjVKUdDl3jejmyx0S03opkYtKtqEtjBbDftYpwWMBOLN8S2NkkgPe+Sjpp0CkdL92wClNcBFf268IPdx0Vm2vFxIQ1ns8Us4SxrAE+cZA4ydGibR+ghlsgPy89kznvKMXTB8PeGFU9E0CewlJQ+07tDG64GkXXrhZNrM+GyPhS8fMMfgM9hGGDByNgK1yUgwR3TsEjapxtgUv4NFCY12gcPsUknRaeL3/HuBYz/KL69K9Op/UUPWN3eKHD3OVk7Mu4I/S4OSGfjSEPOwW6sMnZ6uAfOo2ERbitvp+4KK2V8QMaEm5GSSePSlzwWU/mTzewcHoj2xwAE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:BXAWYDsdFxgbvkF4F+Hw0aN9hPinWuKk/RA+lK3YjWgSKDJ0RNZmfyVs2Sv8QM0KuWf0z1jd5XRhBB0Pw9YhyHVgJTEha6TGjqDNoEwavFQL5wTZ68D/CdAf3RMC/p/pYGsmX208VXBMoj6R1XN5zCxu9DUkz0hmQTh9G6ZNz4l/3tX9LxhncwGCbJ2UYJxkMYAu/QMX+UDmSUV393FEaWUuBXSyd4tdemI8JdpyUchVNLDmj+7ls07ZutVHwy6By6pNSk65YUOAptK1NL/HdA5Wx5rdRM3PuMHrP0mEbi5kS9jN6s2u/eH+ZBveEoeZph3dvOjpMZLp2NQ+lCVeZV7SJnz966W7E+o4S8vDJvdCiVcjS27PheAW65Hsxp8MjMFRNdyKjzmrWtDXwH19+ANqtMTNRVPcNAcbot6etar/wctk1LeADaDGtzNOUBsZLKg5qRj0MWyj4r0zSkPthA==;5:kF3VJ7Lte/vXiDCEoOP7CZK052dwFMcUgEydcfMtDxXrSr7r9BfQ8aFkjukKW2jtWpz+3UfLGvrYCYEgLRGKj1gTGrLU0UQgir8rEwz0HDaxgiBzlQORfWeD+7QAtXVo0yKRbFHKYqD56xnRMBDDv4XLp5Ryw/fs72P0taDkLsQ=;7:QZkeQs4atrNL8w/1MOrhewzw1RSfWZjwPN2/S8QgS+kL71yPTtk+ldZKAQ52UWKqKcdnuLEP5ADODqdA82Rv2vbq5w3XGJXpTqwGnhhw0KQieIttvIWyG9XpAPRzeTwtJvpcVbnnh4WGJRK6XojiHkSpNqyDS2ZHXi+K85YD4sjQymGT1gRB/GMvclVd/5AROikX+GHNRl7k8/P2AHmUrmu/TgqDMM+1q5Lt0ysUylrGW5Qq7+tG7187FGsfRGP+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:71jcfdRVIbGVsHXBFlYofyW6nqHgEf2VhgCfv7OdvPNXW/pOVvCV0suhX+F3zvl7GHQGjSyjkzhRaInAgv9oHVXCQdEy4mU4BqENsYI4W3mn5jFKQQLXi5NGcKbj8ZCBTUAuhmuoEGUgQNVtKFjVetsN1Q96KuWJA95yTR8vpN8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:21.2186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228ac692-0627-4e3b-460c-08d5f7f6f6cc
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

