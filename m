Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6220BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80FC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DMmuT9+w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="h5ZO0Tu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80FC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIGVgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:36:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46534 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbeIGVgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:36:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w87GrTEa028946;
        Fri, 7 Sep 2018 09:54:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=C6oZi6bo3+TOf8RbEZOGXxwGb1fEuv52x8d0UxzZu4c=;
 b=DMmuT9+whTGlvsdBMph+a9/PsvC7lkBqbd5jUvWfomGwgeF0Jawn6NCIw9hQVbbpOSpZ
 av7Z147aBLrHKNR3nTDF5MnBcOPitN7MvkZvRHXmt6h+6FzHoHy/G2lXOKNQoOiEWXpU
 aN9BtJRPL0eQki4zENVgy8uQhUnBTJq1WRY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2mbr548uke-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 09:54:14 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 12:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6oZi6bo3+TOf8RbEZOGXxwGb1fEuv52x8d0UxzZu4c=;
 b=h5ZO0Tu8n2pGdnm9h5Z6QlK5KQyxmcHhkLL/G9I9CrrruJOsJcS5MV4K9d05D+cTpnBUUTB+TZDEtZ/jqlxTr/J5YAJBf9LVmW9VQ8dEf5MOunXrhdQ4Ty+yamjT/S3fA+C1BxaSH3A0CWz5elyVwxrpCPjDalOBhBB86csbcSo=
Received: from vall.thefacebook.com (2620:10d:c090:200::4:cd5) by
 CY4PR15MB1223.namprd15.prod.outlook.com (2603:10b6:903:10a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 7 Sep
 2018 16:52:50 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: [PATCH 2/2] Add tests for memory.oom.group
Date:   Fri, 7 Sep 2018 09:49:24 -0700
Message-ID: <20180907164924.13789-3-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907164924.13789-1-jgkamat@fb.com>
References: <20180905010827.27743-1-jgkamat@fb.com>
 <20180907164924.13789-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:cd5]
X-ClientProxiedBy: AM6PR06CA0004.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::17) To CY4PR15MB1223.namprd15.prod.outlook.com
 (2603:10b6:903:10a::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13f2f50-7503-4f39-9c19-08d614e25a60
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1223;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;3:8Cixqm6M6GBWTcbZkVrnX8LNxQUEFPU2cBWcNQofMtu69nv9RN38EhhWmMPs5AG+RSpdRyrSPviOKRtBzRXCprVc0FfeJo4qEhcwY2I9xxcNipaJBXSNJ04e9zh/89Gty2om2fo3VqD/U/TAg6YeQr8MAJtk4yO8RzR7uCsf1RIaK8PRaHGMEg9g38S4+UDAsFKDlcx9af1zLReT6oWT6I1xjPvYDkUeC5NzMihuBUCDhnrIwvxg4PR87sBidjvD;25:tFu2FmwXu1QwxIRVUR44LnGL3AQHzFchGbQPpYEfuS4Zigo4VJgnMJZzQSuCQvYfqbJ29CWS8TpoLQYGXfVoCcwpUCzDiYJpPYZvaWeiphUdHPkUtNaOXbQ1DeIABekOhJHcFJ27Y7jgHI5gN5QNmGfhROaisiyZ0sg5nNKtxA+sWvQ+02xa1YkJfG1FZU2js5VVwKLNeR1yi81+F8/23qEe4NNlNS267veZ+geYwAT6svvPXaX6enm/AN5gj+xdB2PpvE8cZfp+JFsI/fMXeijp8umfunfeCVzHfiX1EOMaUmMMGW5ghnNn3hsozzYqBzQSdStP8FlgvrCBJebwnQ==;31:bPq00OMiqy3ihsdf9eI/Na71ww+6FMDSumlz6IC4DiIxldUvIl++EclTNNsyxJdOU32c8qoW/8Iq/miAotL/ClJf5zHjIGYdaguIxK6y4nWmr0nQLKuJtTJbwuJBumFBV+GIkciGYcWzGsLkSZz86cliyUUrfr5mrwzjA+Rpmxz4X68fV4wKpkVh+KfNb9A5Xkt3LG848EETYxVYYxPJZfawmTskyG2r4CeqNDo89qA=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1223:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;20:8ROiX6RuxfwwFnXpgO05XaJnzH/qKyWolcKBu73xuPwoDe/r6LdRxTxF1+WrbsO5BtfZBrOna5T8yIhfa1kuAYQHMy9SEd5vMVgV156oZtG7cOuoeQtgWLe8z2aMHA1u79WJr5HbrNciG7ahHz+G4OCzpJA542KeYvgG6uw3Yi7zD8fqleYNm3WVfohQYQ6LYxbEg0JdFxo+LqY2DnnVMG/i+K3y5wuym2SpCAUaIxJmHQRCZ/fDwIAPs41P5mnDKI1mKL1xgHhhG+xUhA5ytOR6rih1vkfzdBt02+ia/KH9XW7GU5JM/jqsRgqbr/r9W9s2MHWy1k03zFjDjyrXCn6ZxickMWFiwjqm67tvcDTnEXA0RSMDqJuhA7MxplNqtzkLI9hAzLGP2azLaIGF5Z+viwf5Lp4aW1m9HyOdxVWXqzAOLjBq/BQSnW+0F+XgZdzT2FrCTUkdB2WmaVdHlc6EZbzwEgm6VNqZPLAsTKfWL1b5jvnkk0jSifjwxJ29;4:eIIBwH38cX4AkczSq98M9y+RCT8Pj2yQm43cVw02c6w+P4ySdxCJayAlZu6pEVpmQqiMCSprquih5a/S6wUiFM4z3OtWaU34Ny7ZARp2waVS+zr8guDT0tF0PTzfRSp2PeQtrl0yIuEl+gO4duBrc4D9JOj4vyR+dsFInobCdffTeycrwfN4u980ldd6KrU1sJUfeByg49qIkm4GssrAcWukJzfhtRnE+jkOGkp5RP/II/JGa0frmag61uWKz6dRFyowVYdqus8Bc9oMGLyCKqeHTtJWDhdPRaiAgAsFxlCoGW7eQIemL7Uk73VZzs5n
X-Microsoft-Antispam-PRVS: <CY4PR15MB1223D6E181F224FFB1DF2A8CCE000@CY4PR15MB1223.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:CY4PR15MB1223;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1223;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(46003)(11346002)(97736004)(446003)(53416004)(5660300001)(6486002)(7736002)(85782001)(6512007)(9686003)(52396003)(105586002)(305945005)(106356001)(8676002)(476003)(186003)(86362001)(52116002)(53936002)(16526019)(1076002)(6116002)(2616005)(51416003)(36756003)(14444005)(69596002)(386003)(6506007)(575784001)(48376002)(33896004)(2351001)(25786009)(47776003)(316002)(50226002)(76176011)(68736007)(50466002)(54906003)(4326008)(16586007)(2906002)(2361001)(486006)(8936002)(39060400002)(478600001)(81156014)(6666003)(81166006)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1223;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1223;23:p8Km08avSxr/HQFGV4LTnGWhzfleK+/kM3QoSADi6?=
 =?us-ascii?Q?EhSvHlKYAyCfNMEBWpWJYA2BlEzBttuUfZpQ/vmv/ukz6ebMoJ1tdZHbHFxb?=
 =?us-ascii?Q?rl1kbYlDw9j2Kby4jl8uZahV/P1sGLeqtrWy/w0vtvPJIVAV5KF3pN10GqmF?=
 =?us-ascii?Q?T1rG8JaXr4sIAj1gBKrfLVdW/Hu+ouBNk/NNEq3ltTvQRdT74foU4TRIOTfA?=
 =?us-ascii?Q?zlBEEI0qH9dUdubHFaCyZx6Xav77OFQhF+y82KpN4MzrjUmVSUC7WbU4JjNB?=
 =?us-ascii?Q?FaDfTFgNSc9A4wQ9O2Bcu68Gjke6+iUWNMDDvkxJQJEzMh2ZLuBn8aRyzE7n?=
 =?us-ascii?Q?/R7HxLlva0chv52KQISbWXzvrHPO9sGNLSSzjBrmenHagUMEh0BVO5vE3NKq?=
 =?us-ascii?Q?/kVBj7pPsfZekAFH6UwiUEJul29zHbD1dZ2JxwstyJK/5rjuSElj3B+qV/ml?=
 =?us-ascii?Q?VQd3BQZWjlWGR02Z3BQto31hwhDpq2gUFHmvHe5DIUU+ryV05hgMKMmUmkKW?=
 =?us-ascii?Q?yWNjH7OJHZvI1U+eAMGEQKNCsYMlBoPDLGArMDqcsV+I8Cc/FKB5Jt6t66AE?=
 =?us-ascii?Q?Qz0s3TB2Y1ul9GQ194pPZrMBQPHOazEQmlih8vXpspwTvRlpiW9cMBxmGv18?=
 =?us-ascii?Q?znoO4aPdU0/i9F61Y9uZTb8OqM/h5qdeCNkdHx34d82kDSR7f7AdQP2AftIq?=
 =?us-ascii?Q?v47mRhPfB/NaSHR93d+6wHU5jEle09jS2UnVCrgfeliq7xers6jXln0rcRjS?=
 =?us-ascii?Q?aRJ+EPif/kZwFyoOZq5x+zjcuwZVKZopC4hnVjjYkwyJRqOmcdPz70nvEg5V?=
 =?us-ascii?Q?NBCR+wzSPYLB8Xr7mNnA5lPlTrKg6iyFFhuWvQUlj1Ybu/YctwyXOabGwYcK?=
 =?us-ascii?Q?2y8O1UFokO8aLd83HtrKwwqYSEs1lB1SKuRHsrrhgq/T4qi12ohgzQLbqYeu?=
 =?us-ascii?Q?oZeUvtmvq12rAcgZ42RFR442a8aMFvvoISh04G2a6IQ7+uqzWAzxTa0fUZIw?=
 =?us-ascii?Q?qNL2DkCd+stQngMB11D+DWH1aHJjHhJU6R/dJMCOPJrIaNiAdxbfRASAh/sY?=
 =?us-ascii?Q?kChBvcxcrcJMP+StFU3e/XrGzlAE21IewEG2J7ne+tL0npEs6M9IgX2x1YKO?=
 =?us-ascii?Q?SXNPjLLNS8SNYD1trmTb5DQmPiP6lhB4a0RM4jAE3R7LSvrhSXfmIZRx0dOs?=
 =?us-ascii?Q?y7+/vw92itAAikBJKLbcCVaqKWc3Y4Lnr0VTjeRv+vOidlgJmPGYYenP5RMP?=
 =?us-ascii?Q?o1qqJ3gIor2qTd6PwMrU/P7CDEWubbV/cO+VFPHubqlN3Pbt1N+v7u2grsOr?=
 =?us-ascii?Q?aDF7egle7Gom0ukbXff7f1wE/BaRqUQK68ffqaj6piCnmZQOuOuZ2W9De9iz?=
 =?us-ascii?Q?1IJifBsroIY0h4n2FvqLaMNC5/k41rRmBaCEmPwG6lST+S4?=
X-Microsoft-Antispam-Message-Info: qsOTFdp6KCFhj9B/JxsIN9SnoTKJk3+cMvhqVpif0V3ibzQBZhT5oytKrfmBp/i36r7C5U2Zsm0e+VsiaHfv5HgZfpm+IVptdKfTHKB/5fJjQopBNh7SNKnHbcxn/ENozi8FKYG8C5OT2KJPHAgpJrzo92CC/vWpj3w94JKZr043SZlIJqsh3zabP5MMsr5Qqu5G/rMmw5ZVvvblkit7tAuObM5dZ+UWaRzXnygi7zGmh5vJ27htpeTTW/+6TqupPd0PwBeyTscOx7PJmQLS6CFWbY3qjzbNgVG9wK1+42n0oB+QSshTQuQn8ZPJS/GrvK6Uw6Yh91uZQfADxQpxZoaHUFQQ0ntTc3ltKSI0rwY=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;6:dUCtZCECRIEK1sbQ9VxsJ09d43KTUwHSDePV2qcxnaqj7uRIwrfHHpB/GeFos2p6lt4Wlz9klGsLKRdz+UWFFDNO2AQwfaXWyJmQCOZZHiTEozuYdX3Au9MTi8zCovpY3YkXoAxQjFRw4YparzPIU9qMYWwUYvxDjU1r/xwJtY6+2IJ7XXrLfBOYY1CukkQUZmbg0AkxStgkW+lU3NFtEKOq41AM0rLTT+VTW1MBoHvSdOy7UQwWClPulyvIVbEZ0B0AtemZLz0zxgQODMGlwPHNRMVwitkzzO8TDg1DP4+F5U2H+7Rb9RfYm+KFbKVRrwqOUBXZDI0xToVMuLLAOpE8hyYMQBwQnQAkj9dWoBuiPyCEs9HJ4qYIDI3SIz1h/fegGHbNyHvU0d9fCx3tsm/SJuuYRkGfb6gmmENHxgV4pG6/QVz7P1IPQYbsb89EkuBtOuVlmsYvR1hDb9nqhA==;5:kR1yfEWxxP4VXFRhBZSS5eBZq7sQNja8lDoJIJeOP4qQVdkSPh7e++i8eRjuquyB5pGoHllwwmwsbDAnxc8og/VuR8cFfTLZFqH5Bica10valftLZzxZkTbDz+rj25vIspKWMkSx9OAyvMDmattFLueZsaUbs9mfmqXMNtZ4/fo=;7:vXXY9Y0fB9kf0bQlMOBWR9wR+a9VHzuXDOC1pa59qt0VBUpyXaC6PKd2HKqsPI+DjaVhPXdlxE27nudwxCddqgeaiElkDJBVtlgQqMXLmWlHrbIMzgoO8jiv0pXO0rEsGCasZA91tcLmTOS9MKV9srCQD4NAGCcuLF6J2uKUAk1gKnSFcsXJXTZGU3PHQQCnkAVrmKUhijBavvwdA4SFNF96cyqbWusWcAGR422HGX2FdRI53HFSVkywVTdAu3Xl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;20:VBXIGivT9PkSekFZm6vmGbsPpQ8F0zH3HVvbFfhnmtw6Ap4cI1pq0yGQhNVoIDiiUHuURSkJlIYXf7/VWfwdTOfO5PV2flgtNq1HuE6GKt8vsBMBNRy1vYwp6uIv7FgFqvW40jH0wpl0ZqKDawbPSWniEMxwM0pAGk5eRnYpsHg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 16:52:50.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13f2f50-7503-4f39-9c19-08d614e25a60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1223
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Kamat <jgkamat@fb.com>

Add tests for memory.oom.group for the following cases:
- Killing all processes in a leaf cgroup, but leaving the
  parent untouched
- Killing all processes in a parent and leaf cgroup
- Keeping processes marked by OOM_SCORE_ADJ_MIN alive when considered
  for being killed by the group oom killer.

Signed-off-by: Jay Kamat <jgkamat@fb.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c  |  21 ++
 tools/testing/selftests/cgroup/cgroup_util.h  |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 205 ++++++++++++++++++
 3 files changed, 227 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 8b644ea39725..e0db048331cb 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -340,3 +340,24 @@ int is_swap_enabled(void)
 
 	return cnt > 1;
 }
+
+int set_oom_adj_score(int pid, int score)
+{
+	char path[PATH_MAX];
+	int fd, len;
+
+	sprintf(path, "/proc/%d/oom_score_adj", pid);
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return fd;
+
+	len = dprintf(fd, "%d", score);
+	if (len < 0) {
+		close(fd);
+		return len;
+	}
+
+	close(fd);
+	return 0;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index fe82a297d4e0..cabd43fd137a 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -39,3 +39,4 @@ extern int get_temp_fd(void);
 extern int alloc_pagecache(int fd, size_t size);
 extern int alloc_anon(const char *cgroup, void *arg);
 extern int is_swap_enabled(void);
+extern int set_oom_adj_score(int pid, int score);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index cf0bddc9d271..28d321ba311b 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -2,6 +2,7 @@
 #define _GNU_SOURCE
 
 #include <linux/limits.h>
+#include <linux/oom.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -202,6 +203,36 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
 	return 0;
 }
 
+static int alloc_anon_noexit(const char *cgroup, void *arg)
+{
+	int ppid = getppid();
+
+	if (alloc_anon(cgroup, arg))
+		return -1;
+
+	while (getppid() == ppid)
+		sleep(1);
+
+	return 0;
+}
+
+/*
+ * Wait until processes are killed asynchronously by the OOM killer
+ * If we exceed a timeout, fail.
+ */
+static int cg_test_proc_killed(const char *cgroup)
+{
+	int limit;
+
+	for (limit = 10; limit > 0; limit--) {
+		if (cg_read_strcmp(cgroup, "cgroup.procs", "") == 0)
+			return 0;
+
+		usleep(100000);
+	}
+	return -1;
+}
+
 /*
  * First, this test creates the following hierarchy:
  * A       memory.min = 50M,  memory.max = 200M
@@ -964,6 +995,177 @@ static int test_memcg_sock(const char *root)
 	return ret;
 }
 
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes in the leaf (but not the parent) were killed.
+ */
+static int test_memcg_oom_group_leaf_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent, *child;
+
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.max", "50M"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.oom.group", "1"))
+		goto cleanup;
+
+	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	if (!cg_run(child, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_test_proc_killed(child))
+		goto cleanup;
+
+	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
+		goto cleanup;
+
+	if (cg_read_key_long(parent, "memory.events", "oom_kill ") != 0)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes in the parent and leaf were killed.
+ */
+static int test_memcg_oom_group_parent_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent, *child;
+
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.max", "80M"))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.oom.group", "1"))
+		goto cleanup;
+
+	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+
+	if (!cg_run(child, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_test_proc_killed(child))
+		goto cleanup;
+	if (cg_test_proc_killed(parent))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes were killed except those set with OOM_SCORE_ADJ_MIN
+ */
+static int test_memcg_oom_group_score_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+	int safe_pid;
+
+	memcg = cg_name(root, "memcg_test_0");
+
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "50M"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.oom.group", "1"))
+		goto cleanup;
+
+	safe_pid = cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
+	if (set_oom_adj_score(safe_pid, OOM_SCORE_ADJ_MIN))
+		goto cleanup;
+
+	cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 3)
+		goto cleanup;
+
+	if (kill(safe_pid, SIGKILL))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (memcg)
+		cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -978,6 +1180,9 @@ struct memcg_test {
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
 	T(test_memcg_sock),
+	T(test_memcg_oom_group_leaf_events),
+	T(test_memcg_oom_group_parent_events),
+	T(test_memcg_oom_group_score_events),
 };
 #undef T
 
-- 
2.17.1

