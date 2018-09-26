Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AD5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E2C214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ji/vctrK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DhcHZHxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E2C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeIZRqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbeIZRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:53 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBTaV0016743;
        Wed, 26 Sep 2018 04:33:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=NTk5eWf7DPBJK9xuFHU3R7T/afT24irr5KTP92wyYwU=;
 b=ji/vctrKkOF/OZZi7mcApyFXJ+OPFxK0gQKVw6+tOMQaP1G0j2MOZIbT7OGNZ2hU0+oq
 bxPAObHX0nSf81rbc8+Hj6aZzJZ+7TALLCNXoBgvojOOiN7AHaxu+e8KYWnEKvxT0jA3
 Fo8R7cP8YTWFLwOPLDHtPafFjuCDiadou6U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr779raq3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:33:59 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 04:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTk5eWf7DPBJK9xuFHU3R7T/afT24irr5KTP92wyYwU=;
 b=DhcHZHxYXEar7X8bOlmEXXBE2UEMpjX43030rhwMOTDarI7VWTCKZ0YxjMw1bgex4+EbgdZ8TT+dPGdNodf4oggqMhqY0pNmOICkkJhvBSVoSyVu3wluK7L8PDaTvE9FloyoUEf7dZy9dPH5y/PLGOkK2YzDAuQYaclL2B3UyQo=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:56 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 06/10] bpftool: add support for PERCPU_CGROUP_STORAGE maps
Date:   Wed, 26 Sep 2018 12:33:22 +0100
Message-ID: <20180926113326.29069-7-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbcb5d48-591e-46b3-926d-08d623a3f238
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:wOKzcK9N7Kww9OT0gkCfhBwrV1c6ae1frbrPk/RtJwnbUhZQ+vjbZ+/L1l/WuB0jnwCIsi+0x1+1pNq5ssJ0YpIq0ctFCUvO4PMrNDzFC5Rdy/akha2UlS5+mtLaFxM1+Ym7LhqwVj3qzkbVKgm5ClYxtsUw4WpyxEfWDM039lea5JIgeDmzScXoUs+OFXphLsP9bsSg+1s+YyebVNWAC0FjgVG+fgti00K1hXue785WMDAgwMAXKattfdGwgKvh;25:nTIU/cvrYvD+gftecjPDna5EjuazRBAudd0NuuDOXk8u1LZ/U24crMniLvyeG5aAPyrBf7RSpjNY9rGhcGPgk8+tg5RjpGYT2Cmfde4dCFpHCtoV7+k2BTjQR/ATnJEb2/RKPZ2czZ31vcgqU4Fzvr9jvfggf36hRFqYVVDUCmL9fMZWwnAxw0MtI5tcOPcWcoVapfYx7mWC4eRwoT60aY0CPLYhihuigzgNV6VIknvULL6z9BXrfvU4p/oWAL4y5yY2GoF4X1vaTMZbW1zwhhcs1l8Ej+0A+SjbkApBadjmjiaFkFY9WjpbYohYWcrNkB0wdsin8Vh0jXx6HgNywbF6svDoJt0mGAX2KYRgjBM=;31:KhlN6t8Hl1Vt0SAg3FhaJPqxej8tVgZtgFM6wJVdUnIp9A11mKp2Dh9q9TEV78U9oNltSPgsEFc5q2O2RRmtqY08qV4vJ8TNOtL8Nad13kOsa2hvGvEuEatWjOPKVWdqTTLvMoitJthycmj+yTeQgZHGw+p0EvbyIbVFqVEEggrY06Z+YHPyGAFOvDs4sTGSc3saVTtLk7Lcuh2A7A/t5hUrKcrtL16vNrgSLkDc81I=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:/Y+bKiyJnc74dcooonLjGoWD24m1p9BYFQaUNLSuGBZXBEMYHSOD4VgbWX+tIJDAxQOKXzzbUxDn+kPULkZST0L7nVBKzkHpBDIgLUeSMOok4jBVGocrHISdJRHbbxcJ+l2UatozBpfDfWjR3oZ/3TtHpfPb0UcGp4DmuaRQZPzCvLZMjMBo5DG1QclkdaQYSheCmGyzaRksf/KHUiO7bstWd/X3ghAdLHHZ8v41VJvCXk32W0uKdiv9QO6RkJTrmAwONqr0auOLwdOfjjPnyeFzoweXJTC+iSF0Ghdw3yswfTXttd513IlE7LnM5AkVBvRwDBHg+vMxpQhT0orquOvcAm3y1OriAvTQoZSTmDG+TxzJSF39s0Kfgu2YvcTQJ2+OerYZbzVW6dGd5ZORyAtqS1lH/iSHBzwULIEaTczZ4ciTjat8bRAKPRoSr3Bb1rpPregkGeU8ac+KT1/goeOOqCljr6DDNxXAl5xiSXZWNgDd3W5LmiIcPHaz+VFN;4:2V94pFirX8X5Uw4LbVtRt6xZIgl4sr5Nvnq5wieKK/qZeVJ4mhCUCXX9CxwMJmGcuhmwqj1HLwBIKF81rV5ODZls4UwnpCLkENwE0eFswDNoD7PrWAJbsvKgJ122nu61ffCi5NqPPIGCfFWgmdTzD67awMfrha50kf134nQigMbpGA0VUgvK9jZqHNCYUNlqgsSBdQoA7SppHXhaXOagQknOWy7NgsdwCq7GayYZbc4OzMwFDjt8qNdzGpaE5Qa3r7N6iNT80YSfseoOav3aUddMqe+C4+9/hVeEBWFThu3s87040xJm4ZONVhsQLW9c
X-Microsoft-Antispam-PRVS: <BLUPR15MB01628B385EACB588E9099ED8BE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(14444005)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:0LES5WHlU9J8IV5xk+4CmchKuWRhCKuh2ovgC63gJ?=
 =?us-ascii?Q?gXE6DuiMuNth8LzLekFBv+gmZIlKGziymaCLRpfBT2S2Ezt5j9wLzXSf5tAc?=
 =?us-ascii?Q?M1deMM8xwzj25A0on7WnXASxCrSIPFAITCfVrsJ4F4zt3WcaVEy0UePE+lw6?=
 =?us-ascii?Q?KZ2MATgVC9tVCrDEcYDZhNUXFtjhebNVcUqEnx3BSs12F5y58NypxcvRc7aB?=
 =?us-ascii?Q?K4CXOWibR1O1vkHC/XeMo/bpEQgC7pKc4697gMdR0C/i/rDlnM/VV33ugKIx?=
 =?us-ascii?Q?PqrwtqmtVxsiDl9E4B1g3w8eriP/GILvMaz4Lc6hyBkAnrHgVyfyUXr/KPCb?=
 =?us-ascii?Q?dQFtLw+DVeZ0pk9eWY2Ci1GopsFvp5e0x+bxNAANYKkQY09dk3QMP8vA1p+q?=
 =?us-ascii?Q?6AmeDJigLUsKn+hpGBAMzDqrcM3iK3lMpR0lw9ffx8GvuvDgmna1S01a8Oeh?=
 =?us-ascii?Q?pq0+JfF/fVpFZunJoZ8vxekG+XfEK3xElvECmk/ciduyE4jQulZVKf8PWlz9?=
 =?us-ascii?Q?BY8a5Vk5DD6WQmZFJ41R+l4WanT4X3NFyAvIecq7bijs32y5RIwlXw4V0Fol?=
 =?us-ascii?Q?yOKelHpocVR5oI5/niGsbZvp52K2Iniv9MHdWKy+1vJR1M8IU4ben964D+1g?=
 =?us-ascii?Q?aYK5M+/p09Vv5MmRH4Fm1vl4R8K1os3nS2gvPWFVslm63QqaXp8whyF5IY4w?=
 =?us-ascii?Q?s9i6DRoCy9rD8nWmnxU0XQjg2P5bUxOHAJNO15iY25OoOA1pgxMHqva7vQyS?=
 =?us-ascii?Q?+VvdkSLsIidvh/dqq9HlXNRsmGLBlbwb0fE7xXcKpfkksA+4GSCsKH6f5hVh?=
 =?us-ascii?Q?emi6MNK6YYZ+vR8ToVhMInw0jCcEOQ9QpeN+vZSLbHwNE1Cgu/rE64KTRmc1?=
 =?us-ascii?Q?qCsycCEOv2oz4Ls4zEIbrRkT2wG5BOBvmimlLiGu/4mVr5GK9h1I7FZfarIa?=
 =?us-ascii?Q?/+EdlZMuYkOuDFqigv6DN08ti332O6WIsQhF/ik1wbYbj+7rZm/fYHf5UY8X?=
 =?us-ascii?Q?idT/sdGsnrfWNOq92hLEgW0Grt3xxzl6cFWU9VtlwlJbyzVQLAXvVaOWz6hS?=
 =?us-ascii?Q?7iLOhz90j1/Gt7o9blWSqjDXibU9TKtTZh/kDz6Zu9bL2kRl5j+OkMzGLnX0?=
 =?us-ascii?Q?1QcSO9a15tY5R/o430wwde4ROLAlJiAzmebgpIKfLxVZL26dl39xbmbNBg5u?=
 =?us-ascii?Q?PRSuQyZC8SKAH+Y/ujY7YCig8h0Btht7ymDndcXnSt2Vr8nHYjD8FQntRWs1?=
 =?us-ascii?Q?84SfQwv+vqRemFu67ZojWguIb+7JZbRlGV2cX0DoVWjpneUxMi+7R1uaUR/T?=
 =?us-ascii?Q?idsBbCTCoLM6hRGriFZh30=3D?=
X-Microsoft-Antispam-Message-Info: n4nC42QaBad1oUMHFtpAttpFlJNF5Hc2Uv1jp7U+CA6ZmrovAMvpwH5bI5QZcMV6iVcgX0dhV7nG2ET/ALf4aQIINEVEI5RF8R8fxqKR0cK2FFwrTNEbUUu1v7yvtUTDVbGhgegSIF6sbTniCWpR1rXii60N+e8wwjFsXkxdQlPGt/6f1bA+xe/ECusAQLoqdGTxtEPwDwWYm3FnkHZfnJyLANCcO3ic91XhNlsRTnGjhYj4ZLvAxnGKg++dRUhaiX9WctjxPSPdAuxHahpqV6W1rSiwZqsuizFkBu3jsUFam4boVomMzoBf2OY2Po4+VD+q6YQsm+tbWwQunf/l8pVlgpANuXHUJ/4VA2XogJY=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:mvDBuV7lxFZAT9avfxCll1OxGss1L9RKm5nwVkEFbBNm9fVZIAH6JNSZ0U7ZfPqgmLVBMqdshpbkRLBPJ71Ebs+TlbL0sAiG1ivyGnD68Tkz/MHUwWemwRcLxOXxlUN085h6h8xoKK17Pi8QQfASvePtWabqvhrCDscvR1CjW1XxotcXynjOimXoV7KHlQw7rQeWSzWgF36ZkE8VEm4fNd8rdW3MH6TgoYxDukC8mNMomqf5TIpIF1DUFAe8uzwKygRCeZKtKUMINlt2AlVjboW71tSrmDd/fGgxJKhHCj4QxJdWOkGSEdJ3wHmsNXi7I1WQMO7cAA39hFDyq7wJYpJJvSpnn1kY8V8ifBuxgM3KGWXOMmkE2luAsxUR/TCAjFyDciThFeBymfcI3jt0+PKveFNnSNJxmxttYBGkjm4HQLIOtH/td3odob56OMU7CAkAnngdMeQpkJj7jJJJqg==;5:oFO3kyUDiqCloKKtkpk7W+7Y1Ftl/O98zlm9lYU+w5gfd9ilIvCY5Z6G4bGktULFva7i0Yqz7go3f0obmr9VvMs9K/9fgMxfH1+jOFBNM+1637eTClwzVWnu/4QYVxIUKbJfJ9BU1Z1zOgz1A4nlRysIzgMonZzLWYc29685rnE=;7:+L6FU3j3CigG9nCTn8qPN9iuzUOn0rznaitbb0V2NsYDLifKxj3iTtcC7qOd+qHSCaMzfLeDalkkvx5QvLFsTjqqodVLhaz9COzyc8oZshkAtN6Adh13GqKmvidPI/yOIxezSpNYlfMH7wOZ3Rr0TH4rEPCJiv0OP/FE0aCK+Y5X600hojc/PmRH1B2I2ZYKkUbdtTEGfmpp7BPHzlUruINUuFxn5/FKYB2AzDh4OwvYLqFI8VQVyTrmZ/6vrnKp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:QdpcaJ0JITRlCWKc8cyDyKC6HB1LSY5m+Ut7TMFyzrO4Cmc6t1OsDmynwBNvAH1p0nZz/nml1h/5oVlrruWyxdhgo+YZwFpZF8YHVBFxUwaaiiSdlp2W4ctnMDsWwTrl6BXSHlAasypbaE1QA4RrD4Zn128uAAsLT70wAArnxbA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:56.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcb5d48-591e-46b3-926d-08d623a3f238
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

This commit adds support for BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
map type.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e22fbe8b975f..6003e9598973 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -72,13 +72,15 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
 	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
 	[BPF_MAP_TYPE_REUSEPORT_SOCKARRAY] = "reuseport_sockarray",
+	[BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE]	= "percpu_cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
 {
 	return type == BPF_MAP_TYPE_PERCPU_HASH ||
 	       type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
+	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
 }
 
 static bool map_is_map_of_maps(__u32 type)
-- 
2.17.1

