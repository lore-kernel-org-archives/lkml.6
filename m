Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E2AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA5220862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p+UjqTgD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VTRTB3b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA5220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeHBA2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:28:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57862 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732364AbeHBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w71MXfON024880;
        Wed, 1 Aug 2018 15:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=HkjTY9917jaa5vJngEByKtiskZT7PS+Gpyf3N6mx0yI=;
 b=p+UjqTgDkKshYTs/nC44yaZJ5yHBth2ZUXSgOa2PACQPCD0U2XgzQJJqEU88FFMCdmJ1
 l9xcwxji2oFFWNpqOGXvthAtbEEDpoVIrPMA5TOzQ9pi4ZO950G2WkfOoCJepbYAOHr5
 LOjfJXXC6XubqR2TVqu0vHSf+N8b3S+sXj8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2kkn2j03yt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 15:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkjTY9917jaa5vJngEByKtiskZT7PS+Gpyf3N6mx0yI=;
 b=VTRTB3b6jsJTokRgVYXtc8xE1nU8gtxpq4XheYhQ1WYsYWqSePhQNPrcIqyWnx7rIdXBipCqsZqvSlg+zEAj1r6z2aeNVrwaXgInQtT92evkplEm4vCYyc8iwHuC8R7dEAu4WU3u9fHllkR0vSXB7TEmP5tVLNJ9JXkCl9EY0KM=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 08/14] bpf: introduce the bpf_get_local_storage() helper function
Date:   Wed, 1 Aug 2018 15:37:34 -0700
Message-ID: <20180801223740.11252-9-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7459cee-d83a-4fc0-0ea2-08d5f7ff7cde
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:u5AVoK+UOFpevTJ9i8gwqUVcvMY2PGp9wDXamfRT9TfhoiUqSBMCPJfEid2ks7RqmZZSibCVaKflcrIDbbDbceEvoHtW1W+BmbaKjPNrPutK4O5y4gFObcUxlDQpjYc4m3kted0HFoYDc5FjkwBsFAwuXG6IOOMmLVFaOvcr0aZ9mLTcFLWeE/Jnt8pxF3sPWBYePUbOgDeHAI5P04CfKiaNmbxIP2NMPf0Y8DR7ULl38e4ZJRA4vOMjvTYw3HSY;25:5rXs8qyfN9DaCDKfxcm2Kxisnvg0Sa6y7Cc6bBPOOZXi1sAcxr7jwMmnk7Sa5LQMsLqN+nCBpTVH1DK2bQTC1zmXwJfnu84+XfbF2Ly1tQG3ru+s4NMnpafP/DNwJyQYP47s2Mi9xTJpcKT7ULWUhJJOllSW8hsKIWVtXQ+FbcawHcqr+Clrl/eKYyFcsFi++RUhg4fDhwL1La+8oRR/SLZub+s0BADA9Gpq2RW9Dl/DRh2kzv2B3f087wCYfATuCMyqP8V7ZbSFFOO30KiqKeEEtxktvFTPLHQ6DM90S3+3ICGPfMs4Z6qMOkrOwLiAouJoyVLpFCwgb2H+CZcKGA==;31:xeXY7BGDVsuVrZtT7wBD8UhreEi0xos7xfebzr+iF5ceGeji0HGqdetgQByo13G1ZRX+Iv9KfNufhBxbRkBfxU6gE8tCw+dp6axTbMZuTpBpEdfmyhimcXKRd+MJlx+aPfPvZ0xSmXxDOJPz6wC1I2UajY2SJNfmvkYhFhCIjYh4l3KQSkAevYe1YfUYAki3lBWTGyXKBmqsIadWTyQMjMlYC2l5evFiKt0WHfuToKg=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:T6mGC+1eqUAy+RoRbj2w/JIQN3DlPGE/yO3H920xoz1O2z7asCAVOSleyqv7QUh029dknY7OZk2NqtLHISWsm7/BgpUb2FFWm7/fy6/zeAuk8QVNu0vGVvdkUkX4H7FyghWE99QJp8INB0Six9KEovtuezqDZ5xO8/Uii+MRALPdoK2MBL8htY5Uv6aYDIbAHoYSl3e0mYQTx9MR3BeDssyfSUqb5y7Wvv64aYuFurRvql0rGNhsYN5F538ivMngNOgh33ids8x5ukluyBWv3uwepO7cwOKh+15EFZRYQxNiCiroNogjwG9NSgR4X9Qlv+NXEs10FnJu9nd/eVX2Dh0I7mUIXulvAdwGAZHwwKZQbYIcC8SC61YhLlsRd7d3FzKSi0Cq++wvSktsnsSDsf4hu3Ul+hKLv0OZUAYKaCmC5GRXzDnUsjdH/yRRAkT+EQyl1s0POqgf2w9Cvoa+FVlRaa2yeJj/ktfCTy5r1SRtYMCzY3UwBrebAgIu8Yif;4:up4U4wB1bvNCT5XqpldpLck7RSKXgIL7BT3Pr1uPlHtSBhv2kLSRadbx29sqmLfUE57qLBwednrCxOOJPO6X96Tcf7/BKx4vw/1m/9MQPsY7KSIE+wCuMSTmKbJdMLwtlaU5/2SF8SUJuJVRnZUBAyW6aBnQp3uiKHnbajbuj4wELxrqHYnbgpSzC97tzUe9h9Q8pPUtUBkRa8lu0blhGw3WISwzgFkEOCMXXP/JSd87w/TlaNH3Yzjc5W4+OIiUEz9nUw9Zm030YvtvEBMvPgoACD/v8ut9F4cnM0j8G2AgO2iw6grNax7urj/btPw49cbwHh4GygvXv6NmLa+wVkzEemAeKeZRl8lUGOxerYA=
X-Microsoft-Antispam-PRVS: <SN1PR15MB01766181443D5E60B071025CBE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:N9HtmE0JifuJXhe6D0zuSHJvvmXM9N0vyrMsjv/f8?=
 =?us-ascii?Q?7rNd+jE+2dgfl3Qpsbh5QLcvse/ai1dIapK1XQxrwORae3hxQyyKCsMtWDRl?=
 =?us-ascii?Q?2VfTjtbFhdb9pNqkG3eCPg/NoDroEio80ol2IgI6sCz15hra3PzPQ1SrzGQJ?=
 =?us-ascii?Q?c/cMCPOgcCfYTyuoalhXOHaLBl7Ahw2upDVigLFFhglmXtCq6UqQBG9VaI+E?=
 =?us-ascii?Q?W1V+ylogaGU5DxPlmXWSWUMOI7JlvRshb9pFgPVl05hbjUngbIe+zJpA4fbd?=
 =?us-ascii?Q?n5dueUVlWBymtD6A4lmqEUp9DzFK+d0qjH3BfAJ9nflfvigDqg7oU8lPCI8W?=
 =?us-ascii?Q?HHVFU3dFpGDkdDRKmh1FisFIlLgApSfqEQwiBZLHumld2N4oXx6I4G2hl930?=
 =?us-ascii?Q?JAeMUf/qNmtzB8FWzBfYbfhqoE5mcFWbD0ApOU09RkMh2jPODtS0UAjYRRCE?=
 =?us-ascii?Q?UeTFzIynwuCcRyvE8YwgKV1iNTCu3v0fullM8fmPC+zq2+hKxlajnYirlN2G?=
 =?us-ascii?Q?4J+Nui0BNx+Y5t10mymiUsXKbcUzQMc6fkltlilsaavUNjC6pLEffZWmxSXO?=
 =?us-ascii?Q?r39QRvGpjO0/H3lHqmrp3fZXP+ziySp7n4qRKvWjSPswpV33vhr2Hrsw4f0k?=
 =?us-ascii?Q?b/S9XbRypPpkoYmmwiJoKSoIrqWhVmeFrBGitN5AjFAV+MojhWT+uLa+E38u?=
 =?us-ascii?Q?owWonfokoEyCkpK88jpyUKKyD1GgOQWqzvPfPiBbm2G9bxIl5iRxWiiTEQ3E?=
 =?us-ascii?Q?IM52dvehenyO/I4texkZ/i7lKrHxjMC/RjGHzCTgXEz87+ByvmwzVt4IQ8ht?=
 =?us-ascii?Q?wfB8EKuEWLktnmN89ekHLNfHbIcZ5xPXrJJn1eqPukc3L5LAopupljvF1UeJ?=
 =?us-ascii?Q?nxPi4ZnXXYCUhzWvJZit3AIWZCr7RTPuXq5LhGJggXa09wLRmt16OmWvTY4q?=
 =?us-ascii?Q?f5Nkr2/G3Y1paIxfV4n++f4U0My6tvhCEUW9+yOysQBeF55x20eyEo26K6u2?=
 =?us-ascii?Q?5Wjk46nx5Alu3/A8c1tzB5IxicVWxxaVS62UBHHMkITYHEl6xot0lFeFrvud?=
 =?us-ascii?Q?mIRFSAvSyw5Jc5t/UHuAKSrcjz6R4pfBg6il4PrSNiDClXT0WLc5H6Y8MRMu?=
 =?us-ascii?Q?lKd3qZLJ8PklhASFsb/Q8d1o585ltLVi2DggoylOUmxVqpLWxPtZ/+V1yPVu?=
 =?us-ascii?Q?8lau2Lapp67zC8UYG9Jp1l5yjEAmwUJNzLvaqZs3SBHnk6z3AHNnTOmSGULk?=
 =?us-ascii?Q?bcg5x1l0hsJJMejOs4qoQ7lPRE0mqD+pOjYFDupO6otMyZp9JXkJvSLXslCH?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: PNjgIYP1cbxEO6/GCfonJakzzWT+2sDEFCZNhfiCCDeiONbUh/VYE4eRqsCEW2sYiIygDjrv2ls7nmXtpCxx8dQ5/0URB80rO8nO4QjAanBDfWN3dS0D/MuPzM53Xxn2gAiKvR8WOjcu8jhmmuvHZOU6EDo66wuZISegyeZ00cwwulCzJtmVC+EtJTAeR3hPG79ozWQcAml9szd0stUOCR7VHZUIRI9eqFs26feIBCmAuL60FVZnsRdFlM3h7EKdyxbaiXzaPVh0UXN19y0Zx11IcZ2B3r+9t5T3KHHzjzPJWYvWoF3q6BZmVaWEKk8kBIKb47lpCZWt490J8aDhFGJrtmwAwzE64EVr/7FjyQM=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:ekbRwEwnykaLXUcJnWkcbRCNs2Vtj7KRT97krf7Et+V73cCwIlmlWM93BRmSK9LMoHVUFRa1e2wzcqH0r2RswtTFXs0JPWO4IB1gbSqPhqR2qGjXDyMtS4SOs4LSGlvVmt/oqa1t/W9799zWGdsJmEDYgZR3wZTXiFP3QU2T76okndt/k8wqZd72BuWA1oYEL92Iiti4n5YqgX1Aw/wAzXIqD5z8rlZv7hBMovOfrKwyyNxHZ0kc+rhU1UHjbesuGKhwiIUMJREo5czZXj/HsZxcKSOZpNJYeGLFzpr1usUD71tWItopCWg9IAr0qmUqeKvsfy2hHc8xvPlSrJne/azZsWSSGMp7XoIDZd5H0C5OphfXY1wQxv4uaBBk6hbNy8cGYmaPjv5xsJO1vIYFmG8gg3/wlZ8xwLJXcNYxihIUg4J7TFzt7iphhmrEZlkbDqpTG/fMtqB2A3jIQRVWjQ==;5:JsjU72DboaTrOlD+bQqINNGLio5S9bfDYpw1XxK3MYMq2jTKqZN6VO37m24nOBUFTzLuVy12KNEmbFV53UG7ZTWcqkpC1m65u/O/6KOnz1uo3jZhDNiyIN3Aeb3EvU42vMf8gPxgMGtRZV+15kxSvAEFa4jFOKxyeeu3gpkiXek=;7:ZJ5h12sqzzzC9WFddSGFAjrVXQivRgy5meRBuiKZyOFQHZ/is72LX4SYh2U9U0VSs/Ji0MVJ/iiNFyDn0LI9v+6fvcFqjZP4yWAgqUL8DByiPeUBI4WG/t4BjncJi96p7Uo5X1m0ujtERPs/4isZPjTNTrqdHkKRQg7+q4H3MEK2ZhxqZNyD+oA7NVJDPtzwChrbz7uAdYgDAZYugwEDpyTYE979LLzjQU3GjMGdwKsjAAl/YoYRVjBh2PFeg50t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:NptsSBMcnknXqx7rV3obnTxIL2Ues1olHc23u5kR/1Y733ksobnRltyyUA+1tQXN4SSGOeySSnXR+GbTcpeAHoydKr5JLod5+jQVnW4WhmVus8uDw6dxJrkCEf5nSf0VD0xyEvHsYfYL+OelRWjtEgcYD5UsqM+BB1JOnGu99/w=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:22.0225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7459cee-d83a-4fc0-0ea2-08d5f7ff7cde
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

The bpf_get_local_storage() helper function is used
to get a pointer to the bpf local storage from a bpf program.

It takes a pointer to a storage map and flags as arguments.
Right now it accepts only cgroup storage maps, and flags
argument has to be 0. Further it can be extended to support
other types of local storage: e.g. thread local storage etc.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h      |  2 ++
 include/uapi/linux/bpf.h | 21 ++++++++++++++++++++-
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/core.c        |  1 +
 kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c    | 18 ++++++++++++++++++
 net/core/filter.c        | 23 ++++++++++++++++++++++-
 7 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ca4ac2a39def..cd8790d2c6ed 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -788,6 +788,8 @@ extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
 
+extern const struct bpf_func_proto bpf_get_local_storage_proto;
+
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b10118ee5afe..dd5758dc35d3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2095,6 +2095,24 @@ union bpf_attr {
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
+ *
+ * void* get_local_storage(void *map, u64 flags)
+ *	Description
+ *		Get the pointer to the local storage area.
+ *		The type and the size of the local storage is defined
+ *		by the *map* argument.
+ *		The *flags* meaning is specific for each map type,
+ *		and has to be 0 for cgroup local storage.
+ *
+ *		Depending on the bpf program type, a local storage area
+ *		can be shared between multiple instances of the bpf program,
+ *		running simultaneously.
+ *
+ *		A user should care about the synchronization by himself.
+ *		For example, by using the BPF_STX_XADD instruction to alter
+ *		the shared data.
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2177,7 +2195,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ddfa6cc13e57..0a4fe5a7dc91 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -684,6 +684,8 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_delete_elem_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9abcf25ebf9f..4d09e610777f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1795,6 +1795,7 @@ const struct bpf_func_proto bpf_get_current_comm_proto __weak;
 const struct bpf_func_proto bpf_sock_map_update_proto __weak;
 const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
+const struct bpf_func_proto bpf_get_local_storage_proto __weak;
 
 const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 73065e2d23c2..1991466b8327 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -193,4 +193,24 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 };
+
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
+BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
+{
+	/* map and flags arguments are not used now,
+	 * but provide an ability to extend the API
+	 * for other types of local storages.
+	 * verifier checks that their values are correct.
+	 */
+	return (unsigned long) this_cpu_read(bpf_cgroup_storage);
+}
+
+const struct bpf_func_proto bpf_get_local_storage_proto = {
+	.func		= bpf_get_local_storage,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+};
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1ede16c8bb40..587468a9c37d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2127,6 +2127,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_current_task_under_cgroup)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_CGROUP_STORAGE:
+		if (func_id != BPF_FUNC_get_local_storage)
+			goto error;
+		break;
 	/* devmap returns a pointer to a live net_device ifindex that we cannot
 	 * allow to be modified from bpf side. So do not allow lookup elements
 	 * for now.
@@ -2209,6 +2213,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_SOCKHASH)
 			goto error;
 		break;
+	case BPF_FUNC_get_local_storage:
+		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -2533,6 +2541,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	}
 
 	regs = cur_regs(env);
+
+	/* check that flags argument in get_local_storage(map, flags) is 0,
+	 * this is required because get_local_storage() can't return an error.
+	 */
+	if (func_id == BPF_FUNC_get_local_storage &&
+	    !register_is_null(&regs[BPF_REG_2])) {
+		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
+		return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/net/core/filter.c b/net/core/filter.c
index 9bb9a4488e25..9f73aae2f089 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4820,6 +4820,8 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	 */
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4844,6 +4846,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		}
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_addr_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4866,6 +4870,17 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static const struct bpf_func_proto *
+cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
+	default:
+		return sk_filter_func_proto(func_id, prog);
+	}
+}
+
 static const struct bpf_func_proto *
 tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -4988,6 +5003,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_hash_update_proto;
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_ops_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5007,6 +5024,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_cork_bytes_proto;
 	case BPF_FUNC_msg_pull_data:
 		return &bpf_msg_pull_data_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5034,6 +5053,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6838,7 +6859,7 @@ const struct bpf_prog_ops xdp_prog_ops = {
 };
 
 const struct bpf_verifier_ops cg_skb_verifier_ops = {
-	.get_func_proto		= sk_filter_func_proto,
+	.get_func_proto		= cg_skb_func_proto,
 	.is_valid_access	= sk_filter_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
-- 
2.14.4

