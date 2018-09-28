Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13EFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644E4215F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qOXrTLAH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HfZW9xww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644E4215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbeI1Ra4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:30:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729093AbeI1Ra4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:30:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SB4eAt016207;
        Fri, 28 Sep 2018 04:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ewgA+Z7l7fcy/smLrbGkIqIhRWrVTM/0u82v4WecQWM=;
 b=qOXrTLAHWBM5x84+XgFulH1UpsOVy5hv74vhPbJvjsgBMZrQHEuDrh/MMWnE172o+KhR
 e0idUNcdGvnmVjJZGhQk47QVBnUKDvyxs20Vy+l7oMxIfp3I4qLd4xQlZ69ZWLyqnCic
 zoW5QO2Dnsq/5NK8dqr/kYfNp5jW+IlScYI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msja2g5dk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 04:07:20 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewgA+Z7l7fcy/smLrbGkIqIhRWrVTM/0u82v4WecQWM=;
 b=HfZW9xwwOUiNQPvAsRjFdLNq60Qq5WFAAffXc+vk6jH9nu6C0qOHJb61cUwSGqITBYfw/xoDV/nP7Lgc3wXR5jyepowhQyoXGGUvrfziIG1CWi0ctT+smcXCBCHv8LPY6G4CmO/HQRnC4MTOtzOiYJUEg8r/D58qTgx37Hz7Tlo=
Received: from castle.tfbnw.net (2620:10d:c092:180::1:7e75) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Fri, 28 Sep
 2018 11:07:12 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] bpf: fix flags check in bpf_percpu_cgroup_storage_update()
Date:   Fri, 28 Sep 2018 12:06:48 +0100
Message-ID: <20180928110648.22973-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:180::1:7e75]
X-ClientProxiedBy: AM5PR0701CA0054.eurprd07.prod.outlook.com
 (2603:10a6:203:2::16) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e304c1-3336-4a72-ee7e-08d625328be0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:2zFpS8t0/zruAl3aVrA//BzueyyUqF/GBOYXtxw7jooMJ6GYFJOaO+uOUC1EVXsOkOZsJV9hlhBNdUuRi9pzrin//xlt94EEfYmp3U1x3epXAMW5XO7TtwajQmEWcEzmP5/IXKdgWdm3nmV2FhhcPhHmlIKmlb2p81TDRL+taKqTDBHvZus4PNTraxJjyS8xFpUEf40bnwPABgRfrepxIpScImzIFSw9FrwvwwY/hM3rLbgEYKYIoG3W1OudFJu/;25:BKPODQBzNNcyVMPzz5SJO0JKoYPlMJJ0d0SfN5Db5oYFdPqbPI5923X5OBplcxrGPQLCqKMw5uxROwpFP/JNXAOePa9Z0cvC0cJc5QIFgKbl3rrFUJcIRUvGaut/qOD+aAS1zHi3jISD4+4WTnd3fZmC5oDNcyHY/Fk02lUaCgXIt04AwIRPSeXsluL9+zwF4vxAeiz9PsLqkrlnSxK5TYSUU1Cs4EzFT/sTG+i6PcLHuZbGJlfq7+56eCgidqi88elPsmbfnV6utZshbDNvfWAtXOXhauSHyUgYFzRbJlf2K95StgMpCTwIa8qXJmNBGT89FgilbqfKfKjItgvHJGZetF/gDm8c6jtVk8u+IBo=;31:H4dTWGWScFEnZkCtuX4UtxEY30kEJczoS2mdjVUKqBWBsgo6NAfFu2xn+QXPGOKxUfp+3EoJ6DXjUuHAu3+bagC7No0e0yoDzNWwEeS9m9KfuszhlpifMM0QkJPrJvp+oVwsq6oVuJnXR/lKEHWpkaygBww0ubu3J8TAku57SaNRx55oU9O+kNw6oONPyznNSXrsiupL+5rseG0f9hXRd6Vlrdj3c/ZU7gcfY733/ds=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:ssghkPuNaHmVCMrUdzLLgne5wc7UThg64dPzuPNF4n9Vv68ohnkNAMTJCqyu3lT/35lkDINyOZWAFinIme4l9QYib16QCkJ7zG2IjT8YrTH0cusTdWFwQ5e89PmwfRxkqXoh4sKoruRgpr27Bl6gMOYpbu7QQ24stfqydSmH1VR+xU/Y+lrQj2rxHnZpFoe5hiKgJZG0vdxRdk5G+RI4l5/WgiGUGCMFEfPTyKOpw+/d9QZlUble1vV2GObulWkX5BdZWeNT+LnVijoiaqz2no78F5iNVGjhmrKuicy3JEYrncGNJRrZjhHmXQTGftWR5GSgxghYjWA5unJwAgSdudlIIr+pGA7qm1zRxNoPGtMbSEHCk8X/3L2qa64n5lkBUPZlzjdtiOaOnZ7v88W2qK9NYIymhZEIOjFv67VTtQ1Qzxj26aXwbKQ6BOE+yMNPmHSF3L2m3SHvXZidPyUd6BN7CEi4zudTbXMEOFS+Qa2okSGKIVp8p2mQmhFb6aQT;4:EZuSxlGE4ejYkD2RmWri9lJ1Z/uqldlgyr6PBxq8aLFBzbEhv+ALkwhrtnP+jOCUH32PKwsOwqgTAlTKEVykuaaJP+OUxi44NV6njRaX8rAEDzjaHebuI7npCbSsJ/XcgY2MAc6vCaJ96Z+0wy/b3gBMobk6ShbwBgO1q3WWapWcPeEPXZzOWIH4wajq5KYK4HrWRx5Ev4Vul6c1/AkDt/oIb5efbNv8GjHqQTCCkMO4EZHuBeeWb0ONtsOH5IYRW4Yo/cpdS66Gt5hanaVAXgErIQKWO0RyRVP2AOGEeYSkzMLB1BXpVbgCCGwUqHZk
X-Microsoft-Antispam-PRVS: <CY1PR15MB017175C92CC59A92AD5292DFBEEC0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(486006)(52116002)(4326008)(16586007)(476003)(2616005)(25786009)(86362001)(69596002)(54906003)(6506007)(386003)(46003)(2906002)(50466002)(7736002)(186003)(53416004)(52396003)(36756003)(478600001)(97736004)(305945005)(16526019)(14444005)(6512007)(6486002)(5024004)(51416003)(6666003)(1076002)(48376002)(316002)(34290500001)(47776003)(6916009)(106356001)(53936002)(6116002)(105586002)(68736007)(2351001)(81166006)(8936002)(2361001)(81156014)(50226002)(5660300001)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.tfbnw.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:aBDcZhaeb6XM3De+4/Pg7ek0OqQkv2eIitiJND3gZ?=
 =?us-ascii?Q?TvQz1mHpItO3MKTsiyxpUVywHIAhGWBnb9bM5xMXsprtDi6pJz056SfcI7A4?=
 =?us-ascii?Q?OlKwczHL848Z+Vdu3u4Es6J4JkdMjHES/mHqWqscKTzlcPo0Ega/1hcWNE6s?=
 =?us-ascii?Q?0SkpZDN1cPxknBumvtFdT7A4zIdhnu8wOC+y6Sc5bz8dLCV6XPYklA7y2fVT?=
 =?us-ascii?Q?R4vEe2SWpYF7xBN7I4VL/ewUrSIAeSRd+KxuliD3gsPoPCQICkXhgbGfpHOu?=
 =?us-ascii?Q?2slMweFe4QneDlsOJCr0ON6XH1J5feH8+2y9aG/ertXbXXPKzpJIaWgVgc8j?=
 =?us-ascii?Q?2azlpdKrs7usaLHEx1HI8YObgugYybqH6mjSnIvou0KG6rfYnH0CB8yyfEm7?=
 =?us-ascii?Q?zxLalC55P4wbU4AKY2nhsnHYWMOKZcCQorCEPlF3rDa/3f+BewNaj/87j4Kp?=
 =?us-ascii?Q?hBTX0A0IR9zRJqjhe5nGZNPofZ6iUFH6C0t6tKEVEyBeQ6+F4J809UOMPwWP?=
 =?us-ascii?Q?cKelGlPwkZYEDh7f4Bdfdz6x4xJX3rH+msAjzj5m+++tb42sgP4sc4N5OJeW?=
 =?us-ascii?Q?izlPmg8YxHJl3drJJinhXrb2H59HuNiSzGJ1Or/EJwiR+4wsQKxUAdYnQBKP?=
 =?us-ascii?Q?9yg10i4wQJx584EYopTgy69FYJCWDOF9H3VlbXmktYHsLzg0XofeygCtoej3?=
 =?us-ascii?Q?PtjShaqw9CC3RZonvGtFT4fNnYC1SJy0cJiUoiaqKA2/USL5myOkHiPOALCS?=
 =?us-ascii?Q?4iNA4Mt0HTYCyt5gePouD1xoD9LW7q0EHjT5Ax6af1K2KitzbAvRj/CuXl25?=
 =?us-ascii?Q?pxxrhALNF12nZjec4+2qYZFaIpUCT4Y4lPK45OioSufGhjBO/oHQTLZrrfBI?=
 =?us-ascii?Q?6UwqsItlBb6fuZ1VjUOeT4QSsgCLijrvr2PvSU/oe56JbyKqkaPBVtXFOkRI?=
 =?us-ascii?Q?HNaIKyJZZvoBEwH53XmLwir+8vs8DR+bAWhzlFL+jGAqPFbT/z+blBQ75Hi+?=
 =?us-ascii?Q?f8KS/e0lGZTMwTUE7TFg3sWLlFJwLMMXHpYn2qfivAigLpnIBs20nrdAPIin?=
 =?us-ascii?Q?pln/5ycSOEq+ct6PBRsLfuuBl9xKG/qLwWbp2Cw3hmFySguPZFDHLidStq+t?=
 =?us-ascii?Q?/p7gra435PVcf9EkjZ/vXc4XnBh5UZGJicTFtAEdbwMrqJlb3t5GK/f9SIMy?=
 =?us-ascii?Q?PgbYOivmyHPdWw15/Xh55Rpx8kgVh4t11hHRSce7+flx6RrLPZooBGGsbAQu?=
 =?us-ascii?Q?aQlL0g4Z757o8ru12jXTao2lQ61Il75toUJbd11q4WqmJg//opVHWwZKgVdn?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 4Cdz7L152hrpQ3zlBH9HKR2J1DW4jDpLiT0fYgZRrTxFtPXhNlj3xg8JinsWyO+FN0lxus9lR+SNrI+oczEAH6BrJxZSPUAsVrCYiyGNdPQ24DcCCaKj0FK9+PvKpiPoDiMlt316Dqhd3hanTT4woT077ck4bPPxselwhxUl1crnrnFVF/c7Pv2gQz6Nb3gaB3cpSRQL0cuF2WgLZjHYZMo1s7RW5jJGDeAhT6VCyNF2PgWRWuD1ym6/4nWFhuSYHCmi2exB3eJN9goXnZnpiMJwNXqYXOM+10k+1zpfp5zr1E9Qi4Z8C442fyTMoxUZ2joT/UBkEAFYy86Xsjcak4xAPfpPsCFhpPzNOgvrKEg=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:tUOk7j66zpG8Xug3zwS1IY9PHWZtApZLpWmlB/MBHPUXIPtai3LcpDksnBOtRSx9uf6hLhanEK4RrkpEGKSuDgDak7Fw0eUYU9BnvCrv8niRPZzfdbfNrhFs60ElkQgv0LYaZIFbjljJ4eNUn4qIky1ZqbDfmjBa/Z7MK6N2qflwZfknLgjgDYStl8kK3s9RQqedO91h6vp4h7hArQz10jCGSy79xEc7pCC0xE72OIPstuK6RyrWR22yVQfSUjE53QygScTSNe42y5Qa4V+zNhEIjD8jpngQriARVe7RayGxejQfhLxyE5ATOpnCXwv5UizlivVXbwt3AIoFQQArLCkxHHv10SPv6+ikhKchHzVNhfP6bqgEjQSIWl6K5fnj/PQbYIW+aZU3p7EbeeIOujE4sm9QGSGfefVFL4Gss/FlAA2hdYtle6eUWW0Gkjk7YtuuGk6CRIw40Row/Wxk8A==;5:NVId/LDIStLmy4C3YW8zC+Mbyu2iBuUbJdw8MbS+MQFk5ejZCd8GBEk4Bl8CgrGyAF0MAqHW7eBukrwtUTOV1LAC3rwa/hwGmDSEmfnWpiG3FyQ2DTdiEAT2owpRRY/0VdeKVMb6G5Wk1dTAi0xBOFWUvt/4QEOJSLv7vt78wIM=;7:9k8DHntxiwbFemd6wT21CF6rcW+M3do7ZPvv7us0HerddM+k/DL6geqfobBqeULpQ0KPf2udwwhYpHsKR2zI0fSm+HOyAjrXfC4eWzyJrc8TArlDhLWzrLeyg5Yn/fUnBAnY2nQ1DyfMiiUNLHFKPXYAAUolxsmlzuANNAN/RLL9mRWlPo6jhy8TACYpuHFLKAprR29iN9YYxW3+1YHWmCEP11Cq5PNa4kf82Q3lriUks86gVfqdNIa4NGuytGah
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:v+ferlZmIKjcpHWH5fk3X6dcLhFBVhJ2f/xFSFtrzBZLWggU+Zi+Q3CrRD2WeZKlyux70UUYYrs6gxRIBYJCikkrzqnwTRSC6qYzkTUJfKJpxRIkgp379pyMLsbvThD0QeLriNVDk8MI8U3Gr7Rzr1RK6Sdp+m/8v5RL3l0+4qw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 11:07:12.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e304c1-3336-4a72-ee7e-08d625328be0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue in bpf_percpu_cgroup_storage_update(): it should return
-EINVAL on an attempt to pass BPF_NOEXIST rather than BPF_EXIST.

Cgroup local storage is automatically created on attaching of a bpf
program to a cgroup, and it can't be done from the userspace.

Fixes: 0daef9b42374 ("bpf: introduce per-cpu cgroup local storage")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c739f6dcc3c2..190535f6d5e2 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -191,7 +191,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
 	int cpu, off = 0;
 	u32 size;
 
-	if (unlikely(map_flags & BPF_EXIST))
+	if (map_flags & BPF_NOEXIST)
 		return -EINVAL;
 
 	rcu_read_lock();
-- 
2.17.1

