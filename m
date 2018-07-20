Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E221ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D2F20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I8dqMZf8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IXGoUi8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D2F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeGTSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387881AbeGTSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:01 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhh0s025812;
        Fri, 20 Jul 2018 10:46:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=I8dqMZf8HD8fNM4Q26ekiMt6CAnqKAM3wkJK3NNTtacKzomBdz66E2L+xYwGO8BlSPFj
 UZK7+OI8R5N56VP7IqpKOAaWexc/18TxFaOEqCy/omYDEehh0voCp+cbY7zECwPNxI0A
 xXjuaeSkm0rAvGbRp6sCaSzBIC3oPiIFJ5g= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dv-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:26 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=IXGoUi8fjPm6xr3qZQUPo2s34vhkNQ7KURKuPYmI8UabUVPkxcTqCaXAy8ACLyinigSJgv+a7pWpKmPzctEY9NwT84NiU0hn1TcKgyyMFVbAbCaHD5+aLxoe3SofLrSz0qskra73vlm9zRwSkSq68DkMv+1mgMDMaxMlk9ANiqQ=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:21 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 07/14] bpf: don't allow create maps of cgroup local storages
Date:   Fri, 20 Jul 2018 10:45:51 -0700
Message-ID: <20180720174558.5829-8-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c8d2bc7-b913-4239-586e-08d5ee68b4a3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:VjL2fahZfqsPVBz5581ZfaTrGhlH3mGT/isSz8JQEz2DwlH4Szs0dSSDrZmZd1sqXmqCK9hnrIst8HaJ6IABDp74whTDgQ0Jm+w0KIQHPPHo0pVsrXk18LxLyFIGiDPNR5Vedoex3/J4HbGN2FvQrSWHD6QQ9yWmIKt5JABkdz3OijmfmA4tTRIkcEkAl//GQVVCRuujaizgj8w1UloTcw6xznD4/dfoxvEJlzuAfoWL8rHbi2xUFKr0Koc6oWeh;25:89mM1L9sV4s2jI4s85pmGMA9DUykKvaA1qV+bcPi2e97sn+Nhj4YPF7/2eRv3KVKckdupmHZnTk84pePp89gaFVcckFuFNvYGM/0e9YPQNm3+ASo9wbL2iq4P42Nm6wU6+dfV2o0ul0ia+QwADV1cyhfwCWca+UyYrSeX5fYXcZceCgFR6YZbnKAvJ8BIrVbfY9IaIJXFwYGSB/EXXp6Z1pzD3fbMuADtDWKPewQVOz4auGwpvrTrnqU16YWKbejKdNIAz1sMzi1zQihse6R7oM6mIGNBhUdbAsfhp1b5gCKJbhDij205sn+emLrQTAjKGrhHOld/e7aG7MDtxb/fA==;31:RjI/hyQb9JBBnDDwIaGIQwZMCqnkenc/gGrrTCAV0ZmpzHxKzgL6G2JZNJIVVDBv1dF+852PR4IeFNLPMrP83UiDOidlN7lMP6mwx6a3ICPWR4aYcBiMuoVp/97p1NSLqWBySVUJ9+inZYy0FcDFFL2ROSeD5VuEqG+mIp6p0aclpGpei3m+2apCVBCPyfQBRrRcNyBGOhT4iV2yRptK1b59wnYPV5rEfUpiayuw2vg=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:zgjqDJuh3Ty2iOSOnpW99BH1QHlin1Wi4FFp7bXmKFL0XHcV6GafkGwECfka8uHsWJ1AYGwKt321B7Ptqal131vwkAahIJdWUMDmfpYTI2IuTZyill9fbZJhxg07PNZ4stC5XSN60NQDsCdcKgx7XtcwfVCetBdkKWbD2g57151M+lQlqYTgosSDO4BbYKHgovhuXFSSprNCzj145O2TjFEOPkfuoprW1qnM/KSai6ACCD31XNbT+GZjGLa/hLeRksh0NZEhtAZ7jp+tbEbpGM/yr20UuXydolBRbCfIs73XPJTYNUTr/uhCTh31h2y8WvTGYoRZyCvWgRbJ8ASr00xE6pJRagpVyuYRZ4ctdfKvhBMGPbbaRHYVKWTjrZ8Dvq192i0ycLybWzLqvnnlc+3hYEZqk59ZYibiG15raV55a0ASEFKVa0wca1vYTJX/jZ2mjRKhpf7kQOWkxKjOldJ4azh35uFZfDngjXeHYTuos0UDbx+XuOlIAXv+v9ra;4:qY+S9EH4JSH5kQKpqXIkk0Kn63Pq7FQpHglovodD68JTmd48GbamExN1HlERcY8Q9xQ3oQCQAHVIgbkUvg6XyernvutfGIQADlihDr+TCnt93R0chK736XQTngLeImymTORrH/X+dVWnAxhQmmJwXY0M1826mOQvCQmL70O64tIRvEQ0Zp2HWJ9wWmRYptpKELAVfxv5wzFZwy0dBCgb12dUkosxDlz5wJxHaJdL4B9/VURNcKJdyAPk7GRqb7NSQCwMR357u9JXTlEqLLej9ZVQUXcj8WT+JE7Nji4ExTSZR8hBjSOejiSePQInHJAe
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175F2A953CBAF9A1F8F91ABBE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:pAhKgDpBpDOMZt8M28M76uYnl6txA4p611BUPIdI4?=
 =?us-ascii?Q?Q5aNkyjqmNWH3jc/LIvnXDNAlGQQ0V4nihG7M+9ZL6FKidiasU5OVUpiblb/?=
 =?us-ascii?Q?sCHC3VZBZKMeMtggawvB5CnuaVknviCV51CPYWdBdX6qIH95AC8niwpUuS7M?=
 =?us-ascii?Q?4taWYzud4Rp4mSnzQIoY5ZCL/XTgtaJOUx56KBC9HvKqygiRNipXFG7bXf8U?=
 =?us-ascii?Q?6X+lttW9dOAXj/uDHpqHwnbo8xOMYaxgKA7GCoHjmBd8FBSG5GC9QxkeauBu?=
 =?us-ascii?Q?9pFP4aX8pCZX3TkODYw/X/Vyd1vjFKwHYAlnumam3i2ZnJKElh9kDtrpWCnA?=
 =?us-ascii?Q?B0+yn9eEDrXAF7okNg7XkYUKbWx+6IF+ASmNnoSiB8iEkR6R8KZk98gZvvmk?=
 =?us-ascii?Q?tZHcHJgVr0DVoEJrJ4iP1CY1l8Uagd2nnNarj/7WW0G9m7QEqAXboeJ88lYV?=
 =?us-ascii?Q?gc2ZK5cDm4jxoZ1Axe1GQy+jdMG9qdF3KEtwjk7tNslFY4opUkxNJpeacXzu?=
 =?us-ascii?Q?G/GZTdfcW9i9udR2IOOkZD6wMXmgYlH2a8hY+NZKa0nC6kdd7H6EBcE9fw7q?=
 =?us-ascii?Q?qA/ZaTNx3JmhDxKLDvXKDrRiWsJuEhLF7g/w2HY4CLl9s25WeeMEvr7dshwG?=
 =?us-ascii?Q?kM66WlO+7AJdOEYlTWkOzaeBq++QQd+V2itRpylfch1PctnFuDYDKcrdw//6?=
 =?us-ascii?Q?xcbUub/wfIr8rqf1cBR4uHY0iGClCajgNwQtR0AdRSAXSMVdQNXBsg2cBCee?=
 =?us-ascii?Q?cC8soahlnS7KqkfokYSfsm7mUOiC9ggEXpaqvlwQHl47o8cTfCJ943eBqjqW?=
 =?us-ascii?Q?gvpcGI8USqYRwh9wjHagSEeiKz5nbDS0Ae0i4XmoqWqvOYNrvi41w52QETED?=
 =?us-ascii?Q?hMAzYaEe+ItCLNgyH+iB+eyfYdzjzS8yvuVpHpy/f3Tu4X2wKYbLGyI472hq?=
 =?us-ascii?Q?qUYVXoMbnDjv+yDCZk3x9RYUpf7lVrj5bpIEtjdTMsCSUmRqKZHahXmAGUjX?=
 =?us-ascii?Q?KJHKS+JGvlSf4TF+uKuQlSmpInJjxsWLKkvuHCbQx4navnx2PqJacL7/QY5a?=
 =?us-ascii?Q?LgnNO/bvJamHb36U32/fRa5Tv6N5uMUp0G5jYd6hmGmaNdwBTQmwIf8q/rrc?=
 =?us-ascii?Q?NmKVgkCicrB9eVNiCyMUKetMik2H31jnoAjWfBkS32qIqOInI5KCgMAQ7Sgu?=
 =?us-ascii?Q?cvt8A8XVHvPfylkPjgkFJ/eZ72mR8Uvk9ta6IgRCaxxqE9OX4bMNYkex3fkS?=
 =?us-ascii?Q?v4sXKMZ9EuHO3YW0b4uWwlzrkuFWEPULJOq5J9bR1vPec2sDzk0D8pwC9UJK?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: VtV0b9O77PXhWbd+w+vnlb9hpTvHdOCh69hLgYmnzPZxSUZJpzUa+ZMOvjTl0L74zwJEJOFoKhYy1Du6Y2DNRKnimDhue7n2dAsbb8arAZ56txN6j1GW5dKL/DR9Rmh3KARJZwlqu6MvDFrTUx8iK5me+VS42D8RzS2bhOulsupcrnAo8bJqnwMCnhIJ40v7nACZ2UPKpQmKVJ1NZZumEaV/cfUhmNmdRPeJbq2tpNpN+OJvJ9/QFzdh+0T4jbK9VeS+HO46M65Xs8pV+ywngAHS57mv3VNVpKa/QYQovpKFiwwxlpDgTKchRwsjNrvifBsdC4wqDL9dkfgmsXbV4/hLQG+N2UCWIfd8eMrlZok=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:czdx1KtarLi+/pNgWOyCy/SSZ0VRkTLREmz7wnviXfMbwxpwv2sycuJChEq90/ystqSWcBmLIi2yQx20zvUMDpQ8fXaPoP6lkhDBnBrxGndvIvK/pDb1/uR0zXuLlH4qgbVI4371O/GVKdwfCRh0ELFVdkYhwZEIRY88BurpExPtofGYGQUP78V5dVOAqtEfagvyZGRjipQsZwea/42XuyjjS/AsmUHgdRcw7CkaTQmNSl5w/E8C8MFaxU/uXdycvdSxZv+a3fD7cD5jp3f1TjxOQ/eXUCZtILzvi70LN0heFdO6zWigzYszdP2WdJzxG3pZh8XEzTwWNIT8TxeTeQJE3Y/RIz2FvPah98utFrIEqEn/ia8TyCizWt3kCSfcTGrDrCQahzNt/dFhvGMDYk0DyVu9ej6TpIsDUlzgxPzSfxegAHJjxlqtIjOOOXE0JCH0a3xA5ADXmWIQs3uHqA==;5:wQk8NtTas/qT2bhTyPSe0CafOR7ki6KxU+B6nU/6/I+MiGh9JGiRnnJPgIu5kZy1MVm8GqVyeiHbfaYL4t4f4CJBzsW6BzG5WUA3TV4YMQVVWkoqjYQlv7dSfSm3aQllIKP+Fm7ohtow44Oqd8T9+5+edZ2frHrvStNBZga5C0U=;7:+B9CLWTr1HZonaLsRaXcUw/dx0Oui9F8IlDT4m2wrpR+sw3mdYBgHQ2d2NyniG5Ljt3/CBqYVWRB2R7FfJyj1ZxEzFEujICOUOKJ9TAWAVm9wfBV2cj9iPcvHSXzdd8Z/KI38bE+ykJgBTEYCca9fz77twhbrxi0c/q4WpwrphhIvhFbaQog+IjvHzg2oWZqEIA1Zys5mCFohNaPdKFqPR3u63r/bFmq90wsYnFsrMeSjPuJQhMYLB7vQX77Pbby
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:/CLhRWDqowtDePz5RbdbnryPJSXOLK5fl68Le7jHNTxv1B8wTbxeZC+maYWWeId15xhGGhjoVJSqcetXEBZEGNtg4YSBS4+pkERabyz1KMDJXEL7804KdjRwvbDHjN4AZjAlDmA25pBSdz9qV4mRJDUucrTxst14PSnhjbwj/FI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:21.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8d2bc7-b913-4239-586e-08d5ee68b4a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is one-to-one relation between a bpf program
and cgroup local storage map, there is no sense in
creating a map of cgroup local storage maps.

Forbid it explicitly to avoid possible side effects.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/map_in_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 1da574612bea..3bfbf4464416 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -23,7 +23,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	 * is a runtime binding.  Doing static check alone
 	 * in the verifier is not enough.
 	 */
-	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
+	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY ||
+	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
-- 
2.14.4

