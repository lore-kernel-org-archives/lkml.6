Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4BBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D18123FCE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jehfX/5b";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iE4DqhBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D18123FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbeGEUxy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42580 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754338AbeGEUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:41 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KqIm4026792;
        Thu, 5 Jul 2018 13:52:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=jehfX/5b4ryngShwcJkQwsxXB1Q2OkLWgT+xikY4h+5EUjWiQq9dVBQFwUFnolDWnjGu
 iWUX4Me5pdu14vteQra6y2JkoiMdzeNuYrhhyWPPyVozBRa1p1sRAYajC2NROAXIy2sY
 OwACQG9Ol9PBXf3KEdZw7KNMe1AlL6y8Lpc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k1q6urqhd-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=iE4DqhBwWMqLAqRuoONcg4wdt083XYP3y4XEonsUbKD3OSfSJau+1NauNX4WjTi86U/toBeYviTx4okWKUyUMnSLW2kxV0avZ1XgiyUv9RoFhXGoi4Ny5qBO80kydEvn3qpJruKwS2dQnS4n1y1mk//I0As82THhEJEvMbpJ+eY=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:14 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 07/14] bpf: don't allow create maps of cgroup local storages
Date:   Thu, 5 Jul 2018 13:51:32 -0700
Message-ID: <20180705205139.3462-8-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24ebbe5e-9da1-4b7a-099c-08d5e2b9300c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:DRdW87157A3+wZ1tVnwwEyHECbidNPL32BYy9v43cfrN1vzjSIWJitoBwEq2+1kOWy5LINZdIgm4nkCE1CLoVbr/I4bqYIOtklLloTh9ZoLzJ0y1G7/tPZKE/cGCFoHqAznm+2uST7jOZCpVxuHKe7EPAxSgbyzrkcUqupNvtUjwHBm5pDQ+06K78VGeRPxbrR/zp9LT6SlUEMpf/maF6v5RHT1SWxzhs/AZQBtIdJ0hRd2t2AX/odtFv5ZNVsSW;25:LOsDyjffTZAyxYNdM9Cfs8FDxGWBW1wg2p/MTi9WEbJ4HJnvpK0Cil+rwHfD0IfHfMJLq4R8vV96qHFAyQCfmrWXwkg3fXldx4br3L3XqiqJ7SMzBdnXLeOEUbuKo//di+oTpOumEto+o3Xf3rs4/tSY+MRntAPXkRn3pRuv0qA1dpNV+VbrMEOOW3o4e8a41HMg+rhY1FdkeFN7WIQgVBYty0B7czkxybetjHGXUbqeS8kuMNlBlq82l37PrjWBeix/e4/EdX+GwqnrvsMRRtZ3QkD35qBakK6SaSrRJfgFsqgGJhf40jjhaxBhFgKC0Nz07YtpbGGKLKTFSXaWLQ==;31:yjZzm5rzzjGWCuHVHI4C/0nCvPWvGdjyUQkGG0QFI3a5wdPW1J/79ufGMv+st+Jc7nt3muZ+Pepi9QyAQ+rWvRSJYb0gunFkvx2TLllQ6tkbrEAz4k8yz0bHtBwooScMGKvczeKAbg3N9qTHH94OezVtHx8IuWYTT0bG/vidyOxww0/TQg3jHSmApgy7ukGb60rmouzBjvJn0SpKtPOsLCPG0b2vNam8bS5dl5d1/oQ=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:1see7hK6ZOwmWnfH1sfEC7LogdGZLWCUtHi7onQvqpndSKqwbHMqjJ9F0s4StD61g8RbUFX4QKe2aJsP6UqzlOPaOtiHzuGZDQpyDHGfZqGKNdSg/g9GO/pwYqlQA3xNRz2dbnL3JxWznlC8VIHN8+9XRZsa29z2i+mVVL3iFbjZZhk3GdVfNg+XdM5XMSutk6IS1dmgFhfRldH2uXRwRzOt9BZo1Y+eGI7ank6PTQSFb8PsUVD4ApRN5iCSSXukQzJ5r3q3q+9y9GLLgvUBeCMn4KovFHLt3ijGZ4zhcNqJvzn/XC8u9h0uAslrt0oTJa9eAjGvlXv17Ptma3XyM6L0JueUD6NaQk7v4YCDseg06sbgQFUGCRFfoilWCY3eimvAfE5Ei1uVUdZtgngT12wSznirQnvuvIypGhK8YM3Avm+ijtPf1cNAveNeRozji8xFI7ebfwO25Bkt1QX5VR/vRKSX6HDKR/UUel1R6+ycBsvYHn5khtHE9URu9y2L;4:EMHAYH+5jPUwyCf9noZnKfwLx8Dy79JCJDAbZxQMxZt+S5JzVU5M+NvxMyKclHJT5jdouoAHBjdIOahMU3N9xOziEu+269k2ZHfFHHSIqnqirULR5FPcejN9Nb6EAvYM7XZqkPSBvw1gkFrnwPYtw+/hXXOZWRTSyk3mMQya6sM2B3VPm/+hgjQYrK0NZ3WoE8dAheyZbsTtU6asmZh70OD45E4sg0UhIv8oCejKIBxA6TbHcQ4EJX+JZi1TWE9PR526tPg1YNDSrxsIJqJz52yCC46tgZfFiDbhZ9R7MePi6dloTX+PnLYg6hOD9NgE
X-Microsoft-Antispam-PRVS: <BY2PR15MB01662CE7EC129512CDFC08B9BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:NKNMl6+FI/FWvq1jxdVailbitmWhX169PnMy/JATk?=
 =?us-ascii?Q?W+KC7ZSmqZKYjzO9ppNOPryTIhdCYK0YsU0go8szuvZETOAWDNySVeizSR1C?=
 =?us-ascii?Q?cKQIXgYqfJbNJDcusx1LMFK6v+yo1X1DvXiiWGFvTF5uRGIBSHAIA6f5wrZ5?=
 =?us-ascii?Q?DTWS6j3NhEdM+Svfyfl7/7xtm97myfChcuA8hLk7UzM6osOks6xppbxXkfWb?=
 =?us-ascii?Q?trjrZJ1npCYJ86vgSy8ZRT2ph5rXJ+tIozZVp+ZS4NRzSdhc6Z1FICcY107J?=
 =?us-ascii?Q?E1r+aoeG4XBDK36eC9DCr8gQ5MtJxpQICtMNRjzaVwSNdwjD6AaX3wtXXkyi?=
 =?us-ascii?Q?k+Fxo27j9EuBxpZqOMqbuzBnqdlz5l+1fO0kbpoXetfZcgvq8qmXS6SPCS4M?=
 =?us-ascii?Q?zMGfRSpWDyVpcxauUgrnYdMNbPa+p4itdIT2s5f9k5JMrzo85He1zwi43Z1w?=
 =?us-ascii?Q?mQhLXENdmv+kpeWnkhBqB7s5ACOj0CYjdA0BZVzuw5bNOT65pT4QkSSFrPmG?=
 =?us-ascii?Q?PIKsegDvx5/RM+Nc5lcBK5InAAqL1/qckwV29USIPm4jX0yEkxdRrqB5wOzI?=
 =?us-ascii?Q?ZO5aJZSlNNEpC8/nh/I22kx5GKEWL4hw4B8OpfLYH0ds0QLZfwfWhMmsK+fr?=
 =?us-ascii?Q?i84cjOAslcDUlwmLscw8JAJqT3jdEbICfzny+3RIUqjmpFbT++rQ3oGbn3mQ?=
 =?us-ascii?Q?qZ6REm4MJMXtiW6Jbo4APU7C7q+5TgwAyw4/MnWOvCD3N9P+6S0v44M7qfGJ?=
 =?us-ascii?Q?XJdozILTlUUyYOja5VZK7GTwXWFgua2VvD+TWmWxj+YHSZXDhenLUXTKLkeU?=
 =?us-ascii?Q?et0jWaTVntjfUA9ZttHaHsVYZ3DfNo2zscRYQRTufJ9ThtxGYrLDYbhD6DZP?=
 =?us-ascii?Q?g/ENoMqYuAKzCRYimF17Z98ABmvtEEFZLuaE6MEZg9TZXC2rVxIuPJw3zLS8?=
 =?us-ascii?Q?4Y8+HyEDrMI3OI1FYwjeCulq/itLD7SNWWPCe3Rz9LXlkzyrLRNdUkOFWr3l?=
 =?us-ascii?Q?gxWnLCYy3ojmlsqaD7diMCDy75yWyaxXjte1Gg5jmgUUWBMrQTe5/jVE++n0?=
 =?us-ascii?Q?nnUeU091ZyCAPGiovy1VOBJCTBTdtCIodyFiA9gHfhpYsH6mPu+wL4E714fB?=
 =?us-ascii?Q?jJ6S3nl1eodBq1BrQ+7BLc+1qgis6KSt6xWMSv250cqOqGHDKS2F0M25SosZ?=
 =?us-ascii?Q?hmngrPNCUpujXRiUTTmQyo1HsqdfpgBnZ/WfsKU0+3FgPSNw1BB5tB0vE659?=
 =?us-ascii?Q?VStUPhb5y9db4CQ/GlpPOIHMLA/gQbsOXvf7GBEwFsAI4EeOiL+CgMajir8M?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 7ZEAo/LmGHwvAud/KAiJIpd360tX5XjSXW6LPbvXoTVm/CY+WUgK5SJ0IZWLDduGGhCfKXpVkUDS0moUlhPKOwE5xLPDb6zsEpd2H7O/LZVV3CQENISqRGqeWozMAf2JoLQxPyfXAgQ2LvwVGzFQ6KF79isDwB7G6u2W0QzPK+nehRImzW7fuxwImuutIcKPa2EKQTPzWEdVHCNlMOuXlUvkj1yuuK9CPtyAz2A5ncsQMLISbi3EfM02EKqPiTLCUKRleHArASwwZY2L2mu0Kn6vwt7CkiFnHHRSD79vFceFJek1DTHUvlN/3G4p6K/ZI5WCdfthEsjajiYPr5yietOnE6CNDwQOkJGiU+InN/M=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:yVXqNS7atKUC57CZPYOLO1vbdrYDEu2Unhzzq5qc5r2gjaK5ipsrQAK3txqyaUo0pFoJQuomHB24jFXMcnJeQhVeO9/QhbWR7qzv7VQcMqGwR+xcAUe32/VXxBvkTk5UY59zfjgykD9zu5eHxokorzvy0SGOnwDcwOQMLVM2BBKKQCRhbuuxhFWSxzJiC4CEkAtuguaepyDx3J3TJLSkIT8kH81sH0g1R+bqLlrfvuMginfnb/5avAy/8ft1yYrVYwoQFWt6wXwq0kEsQxkj37FAQJUMml4E+7UewB7PlWsbjLDnMNd5zTJtrHVbCs2Y/frCVrUT3eG4Wq3jFiwu1ACoKkimuv+MaOBznpTjTNaBAWO85Nfsl7CRo/gC4WsKWqjRcHFsAjMobZxnVxMwmK3krU3bfrzIbgy5JC1pWBIuW6fycULy6VUZwP2zUm7mDFWrvX1/V8wvB+ltBL8JyQ==;5:twKNzOBwXh2igkOSASf0cxHIMEUuULJSULWwsTHXN22hPzH3lC8p/nOzaOMRpO/LY5zivnicjgF3aR7neZKL6jStiPpBE8NWoJVWRDyQtQnrGx0siIYBQ6vmUfIyCoLBlp4zQ61JSYYVfMATa0kdykAQFO0XeVPT7+sKUpzlaVU=;24:MovrZMYyh5+joehTe7E6GKN4fbDxKc5Lc9e/CYC4IT/8EzPiC4/lNSUZ4QEaNHGC8rppDpE/HQN4fZW2nJyR5MIqLjhEe36glLymhhl6sXA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:OSPiwSX/MMcCXxeQCcAhaC1DTRBatkOAj+zkjSJ4ES3HFpzyE6A0ykKxyz68dDgSJT62coeCbfGSsrcbXFCnKNIj7JdxL591eK/xcGAOboGPkibpOTr66urFj65hKmfXGa7jBDPuz3dYCkDU0LXXz7J990ukQQr/vjb4LhrOVtX5dtnyETYplsgQ2Cua2U3+eApjC5nVZuYYGu+rzlmO1P+aiF2zWNIT3Ed/qvC5PSQIIDmM7zMAqchp03J14HOR;20:63cG+1iE1tTPqgt9YVI3Tzq2//65vzUcR5Yhj/zhtIXYwmC8544poorCGcA1Rke0VDyI+WLQ18w3/sJzJhi/DviCi2kHeQuBwVkFFYRY4dIuUeFrTJG+tqgPGV2+FsaEKxTjiVqKLkDIydyrb6mpH4xLICmjVnLKDN1P/Rgsbd8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:14.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ebbe5e-9da1-4b7a-099c-08d5e2b9300c
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

