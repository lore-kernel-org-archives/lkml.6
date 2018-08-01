Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF3A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pWciU99T";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NBIrLTl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF3A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbeHAX2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:28:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387635AbeHAXZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:29 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LbFJT024053;
        Wed, 1 Aug 2018 14:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=pWciU99TYlb06jGK6VIG+m1HVUX26rsuXdAumgbqtfUzKordGoOqgDKmikkJvQk/FYwy
 kLoFBDtyhGteJ++YLDMV+timIFlJlQDmtzshnv3TS1WMQNY0YMGeEYOka5UI4omdtpJ8
 IY2bl3PCBa35FhL0qgnWJheDv+ylCwbPdZw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kkfcvh53p-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=NBIrLTl8yYwcujwIQXxoIHd1LtCKO+AKdyq6QghvpOIzEu6hB2QkPQQBLdKz7OEyy7/iePZZodVd6GbE92YZ6UI/fFm7qU9I7sGTQmj0cmWWgf7k+lJeyR6kyRbWSQwD2j6TvQG/rHgwqI/SuZiAjkHuxC+OUk6xas8MhNDrcs4=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:14 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 04/14] bpf: allocate cgroup storage entries on attaching bpf programs
Date:   Wed, 1 Aug 2018 14:36:39 -0700
Message-ID: <20180801213649.30751-5-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ebf2325-239e-4674-7f2c-08d5f7f6f2d4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:Rv1XXGEGY0+F3Q4MDV9NpSOg33gQ9piZ8DAtJbEv02JxHgShQ3If+aGwWWZDe7fudVH2TCZT+2vO59FCwdfP0rID8zOjSwcfBcv0m6JfmsTDo60LQgpsL+R4HfuIfwO093jt/URFw+M01qVJ0NYQFVuR0wUNpyh0f1mPKh4q90Y2nZ4hVFqqjgzKdmYR5tf+ptDfwHscyRDj219CJXVbdbBjijj2LZdjLTfuzGW6QwIdEwY2w/TzmZmN7L+7JNuX;25:A4avMAPMq+iMdKlZCb/haFzUJoOMuf/l1XJ2aBoJZAcDvyPA7FgNkJMvn6wOr2aInu6d6qBtWytMRjvlk0Kfyk6DY8CYYx//ogS/FOJh/gOS0G6zQy5iYwxCj3ixHOhUEmko4RmNCJv36Q1G643gib9p/0wsOFW/NddJNq/ALUV+015up5XdS/tcc2oelCWi0e1mgpw+duteRai01Lv7oa948uTCC9G0C1cSFAoENfiaZw0yDzNWamMLxZfPvBbZ8zLToYm2WbbaeblZ95MGb8W6E/nTfYYK3MR4ymZSBvNCihflw68tuDC3P5GNWD3gXNxTkReT1ToMcG+6jOvCjQ==;31:IBs86ejnYkXnvrgF1QF2uTkAbxIfyxBD0j767D6NTNQ6PmP5PRtMPz+IA6w/uUR+3yYsisnOlDa3NRKrMciw5JdaQwtFtodghhGqCe4welz6+Dq1pp7GK4OgQZCRK9XtmoCrRfup0EQkIjvFrI6FjnqxL3Pt77rTaIgNh/HZNitx/4FWHp38rGRL8mgZkDK+IeBPlUPTuIV7ZkOcXVNCVeGvwav4IjXmdNnK9GkeNFY=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:cHHXJr0FtAEwpj5rh8ZEmT22RycJqvkUrxJtL845PNbfXErJfNI/iCutjo0EKrGsP8TnHJll2/vzxOPpN4JJ/BCxp37wd129zwM3ZVCWInsUfZmsMNX8tV8KWHj5KnSID6jLyAb1asiSwKXst+R6zPgvXVj5RNDKUeutAlfLghAF+ixfEWNkikMqO9rfuKR917vCOI1FxrzFcC8RsxdCDXwamcAPEvi8qkjXbI6AN7Tp8Ow58aOovQxp8emvvPqukGpjRoyQzkoY92jckWQu+Mpr+Ww1vk8aijSrVxTyjcyDDItzQcX/IJcUjR76cQBSt/tZq9+Lz4S8BbULWh5+LDhV5da3BcNEEm7fOcnnw0Ar6jJRBbbAmoFP3PV+e3k26/qaAv4Y6kWwCgeMmBWTxXnvBMKrKI4+FBSZrejTuobQb5SA5Al2gM7hFaCJ64keIEjfSYXJrw7rhgnINtYV7ldVJotcmmC4E5r35LNs6YxRnrijb0ELl8SSoFTKzEpj;4:+SbPBhCcUgN0D9GVfmHjYS4uW4nU9o3cpdBwM4osfBsILg3JGhgdDNgrRoIf7Bk0YGpEPEGMGoidoMGrYqLq9UY9JUZGY6ES7mHE+g1B14pBtdFI6kK/cs+n9Dxm/hWHTxNbdqhsthvVs/aauBL7hc4YaS1NwLxuSJpRaP3ujQlR80nqULnqrjYyILUYh5jLm4MheisjbGgorskeEInuu1Iid7iYjILZ7xbMLUnQu0NMNrRuPfZUVh1DinRdsW6TfCM1fYRiHtW6sC/0qgUl9rml0wqR1m3lxlR0Tg1wfjVwVMd1olAfk1LAuDq5i5iP
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167059650BA1B3586504064BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(575784001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:z+fKunggJHRXswUUPktPbxKGTtWSCLJRW46e2ZmFx?=
 =?us-ascii?Q?sjO/N/Uao84gRPBWGVf8ucE0I0sGRXL8A+1/tGFj8BQOJO0qP7O9CN8O3nka?=
 =?us-ascii?Q?ARoIW892Av4/q+8es/qM+VbTBPkpa0XzuMAXa2a7BZxbtXKk6eR+aEv+7u8r?=
 =?us-ascii?Q?PwTrzW4ddESkTWKGn/sVQw7J+/hvloKbPuELE9C2v+I9W8phFoVoT9mZDEDJ?=
 =?us-ascii?Q?AztshoK9n1lKW2kgSEIGVuU0lBeXSf4aHXDxFCHxTpDgdzjiObWyZ9xbJboe?=
 =?us-ascii?Q?FeyHxWZWYkpVCDOxxS1EOxZBTRm6kz1HL1C7rHtvT3/9glrfB1thl/dDdbq/?=
 =?us-ascii?Q?Zm1MjTtVHfwaDJgC75TvtP14l92fQ0lGDgqxQsP2L6oa72XjLauiIppKROiT?=
 =?us-ascii?Q?Fi/+LN58GqW9ZWOcKjyfBHephw67fZp+AA3lMgoaus5Eux4VM3luS7KeHIOO?=
 =?us-ascii?Q?Q6lBNvxNM98mAw5/eqGUO1CcKXRhBGODuhl/nJ7zUXHkuKbtR8pBMLgQqO7n?=
 =?us-ascii?Q?XbEmyVGtPXGvceW7Ikd6IazTTBTDpfFiKvZI11aatdOoaLf0SsPJ8zMlUeyj?=
 =?us-ascii?Q?dMNS9+uXQLpuhP6K8HzNa+qIjDMh0HCRU/fug3LhAmNr1rl2E/Rqsqrjt4EE?=
 =?us-ascii?Q?QdScbEZbdF++121/94WMPbUXDPJ+xKGTwWkKGLMP4tVc8MRzXESpVvszHApp?=
 =?us-ascii?Q?qw4kILvX6/15Ws476LFX0u5f2TFM87QeU6Idz8s7Yt+nEgFb4Z4W5hU38GxF?=
 =?us-ascii?Q?kvXbWoJFU+6gj+NDZcnlHgNn/Is9KNwOTHSVIBV92KoqNH/56EfWSCgjDH0E?=
 =?us-ascii?Q?RMJFGgHfGUYVNEtqawnxvoNx+Fj74HdTYxLOr8CMdqBmGTxZrt2rnTeOR6rk?=
 =?us-ascii?Q?xpS3KO2A+YcUK4906fnoUtKgAwqvz0xrXACVWpcnAiSNLL2IRGyazJzkpg9B?=
 =?us-ascii?Q?kfAjQTwKTJR8On0y32uSoFPLdixWrhU8Vf7KJ2jN1Z7bR5yydQPtyq3A8aCt?=
 =?us-ascii?Q?ApAt6w+Z6RXDEQXBFPzGOtd2rRjQbIrglHmC7toTq2NqppDEivRKVYxO7MQa?=
 =?us-ascii?Q?PpRpKoT6tvKMYTxpqPQpJbkmMD87ToiMHBJkOOzsTuvW0CLtPfYFopzVIQ/3?=
 =?us-ascii?Q?pgfN+KhLKHUT2OmFZ8CZ/MqSVhQ+Z8xzqAYkyX2wWWP3xd3n6bMCjN0P8EEm?=
 =?us-ascii?Q?FFnRT/srMrECyArDOJ7jECE9L4MmlkUReDQfHsBH9TTo8uT0LMfUpPiCx9Wm?=
 =?us-ascii?Q?Y82lbROosteAW7KhqVZ+TfSFY/KByPjwxc3UgSV+MilFVUuUNXL+UtH3xXsW?=
 =?us-ascii?Q?2kXPl666rC00M4JNMmqU4V+Qb+2PlL+LNKwilpEaLYq?=
X-Microsoft-Antispam-Message-Info: H6hxr6NdeoIBjJtHfHDVcS/YPSb5NkHhXsQ3hKuXbKuFlI6Yr+nr9CfSqGONJ6b36u/O8FTWDtx19q5p9Vah1QCyCh6OaTf5SqoFF+xq8XgjeT7Mcu7xmXDStIxiit/DH+XRGCwYsTGCtnNDckpgeQGyM8Lv4ZoKRz6aJABf62rf6/srJq1PVYK/q88jbur0xd5J4dO/rOpTkpbZwoEn9jCgAMpVnaCBrx6+C4HLUEJ+4k/s5YW9q4LoVX12IcuV56DOpJI1V/VQ70fNF5AQ5tLLV8EOeIfH73l5YJ4lo2GN6ZVV6lVy4a8ySsrtfaaes5WyeL0utT15B2Rs/dXcw0TJAfMNIyNV+V1yYnHcBCs=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:VkMYMJvXxfWIqvjV2HaUJrrH2+Or3enGVdXcuegwXT6aTjbDnILUOKeqWYB97MX4nfe2awzpkVRkCsU9eHHtl1ZDPJxJ1dqitXG5XFiEuI/KWhibWuzDkgUqoStMy+Mn4UEmT9IYTz9c8d31ejW7xbw/qoaMWwwyWZ6qlUH2Yt4idcKHMDt+gsnDNNSXS3wL3ksUeS1Q5fTgs3s4c7z2nHQLeRc7QfdaDozdHSt+hivmQ+gM/1T+yPB6cbVq28/EErgtHJqTLeSRV5EqaYAyoWxlbANtQSs1Li7sAXgbswImmUpN9awgLOxV+31bumI3X4kP8fbdDNCrAQgg+gTjXA8XKoNwFc5xV6WkOvx80ItlSqjA0TTMREN9gzQ77nsxrHwtVOTw0Sd4xk8mTC4q3FY185vMW10sBuIIs+EsT4vDJyRAiGj1HOWjRB78WiYtSjm+eDl8L0UuQJ8w3Xmc+Q==;5:AzhyoBFk55oNiPr86qdvmwPeaRftykkl2ZqyBCaJTE6vkNGdMjUGvcKPw/KA9Op9xQGUUElVeY3xbr08MsFTdUo3k1Dj92pIgvVE6u9o6/WWTlZ2gM3N9xBF80Ka2xpHc1mk+Z/Gujyn3LeikO1EFQ3XvBwPnFSsG/hv6ey40Ew=;7:KUuiTEQHqfM/jG2KYfHDsY45xHS3iuuROdJ7XqMvnVcOmcxmIX8WmG579cbyzxD4xVYQsaic3r6xKrN9+22B9PxNdIOs8BXgQDxsrJRAmhCeQ8Qs/xshBGtSIWR+J6IaeRswkCtzFkzQ7H9bAmjuYg9Y/nvBMvyjjVenlDBPsj9oxl5ODtTGqxhY9kO25KmoKB/s78kpNLlierfyagAMPc/bJK/1eBrBKS8Vz83+/bakW5iQmr9zwOWQUI7kNIUj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:Q81uY2Sjm8c1dYSenw19OWW1XztuS5ZMaQoOMlSLmmLmAUTjMUZuY7xa6kHCvYZMjhZIry/m8BtPFnY7csLSO5KRJ6SIcD7U7WPnRFwCW/r1P31DTbB5+/Xb0V1Qu7V2bVqAw71nQ3WYVmVqLZ3BT6hZ8JjppLBf8jwSr/A3a8I=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:14.5636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebf2325-239e-4674-7f2c-08d5f7f6f2d4
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

If a bpf program is using cgroup local storage, allocate
a bpf_cgroup_storage structure automatically on attaching the program
to a cgroup and save the pointer into the corresponding bpf_prog_list
entry.
Analogically, release the cgroup local storage on detaching
of the bpf program.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  1 +
 kernel/bpf/cgroup.c        | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 9a144ddbbc8f..f91b0f8ff3a9 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -43,6 +43,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *storage;
 };
 
 struct bpf_prog_array;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index badabb0b435c..935274c86bfe 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,6 +34,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
+			bpf_cgroup_storage_unlink(pl->storage);
+			bpf_cgroup_storage_free(pl->storage);
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -188,6 +190,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
+	struct bpf_cgroup_storage *storage, *old_storage = NULL;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
@@ -210,31 +213,47 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return -ENOMEM;
+
 	if (flags & BPF_F_ALLOW_MULTI) {
-		list_for_each_entry(pl, progs, node)
-			if (pl->prog == prog)
+		list_for_each_entry(pl, progs, node) {
+			if (pl->prog == prog) {
 				/* disallow attaching the same prog twice */
+				bpf_cgroup_storage_free(storage);
 				return -EINVAL;
+			}
+		}
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-		if (!pl)
+		if (!pl) {
+			bpf_cgroup_storage_free(storage);
 			return -ENOMEM;
+		}
+
 		pl_was_allocated = true;
 		pl->prog = prog;
+		pl->storage = storage;
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-			if (!pl)
+			if (!pl) {
+				bpf_cgroup_storage_free(storage);
 				return -ENOMEM;
+			}
 			pl_was_allocated = true;
 			list_add_tail(&pl->node, progs);
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
+			old_storage = pl->storage;
+			bpf_cgroup_storage_unlink(old_storage);
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
+		pl->storage = storage;
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -257,10 +276,13 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
+	if (old_storage)
+		bpf_cgroup_storage_free(old_storage);
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
+	bpf_cgroup_storage_link(storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -276,6 +298,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
+	bpf_cgroup_storage_free(pl->storage);
+	pl->storage = old_storage;
+	bpf_cgroup_storage_link(old_storage, cgrp, type);
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -356,6 +381,8 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
+	bpf_cgroup_storage_unlink(pl->storage);
+	bpf_cgroup_storage_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
-- 
2.14.4

