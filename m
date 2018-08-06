Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D1DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC8521A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="T+tCx0jG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SuguyULh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC8521A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbeHFXjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:39:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36348 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732191AbeHFXjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:39:14 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76LPHS9005060;
        Mon, 6 Aug 2018 14:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=q90sjdeTH1UIw3Ms1pfOKb9acHbsEilc19BZKuzjcLE=;
 b=T+tCx0jGkBN0cB4bP59kMQbv4MeM8GfJJnHn44kn2SLl604mEn7r/FQl//7os2FtefBT
 VwI/yKCbsXuuJ5scmW8hU920s6GISbosSM7qvSlRFIQccJ8Tv5mR/C+vg3SgJzsCnMvB
 g8oXu+F3ZNv/kPRLuWMD9wODz3irjEThaLQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kpx7xg06n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 06 Aug 2018 14:27:54 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 6 Aug 2018 17:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q90sjdeTH1UIw3Ms1pfOKb9acHbsEilc19BZKuzjcLE=;
 b=SuguyULh+Hjj4RhRvCt4ZGyZpzmtuoyGDCdXLe5Qv9/0Eeo1KKvwk1Jkmk+bV0j7gh37E7IQDddLH83nADTAYcnCVaMXSs+gRCO9R23m6/MDM0HgBNFa71QWI59pUFJt7XaGVCaSfClFM/dSZf7xVlXfPDuJwvcB6L7Y64GsCMI=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:f106) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Mon, 6 Aug
 2018 21:27:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: introduce update_effective_progs()
Date:   Mon, 6 Aug 2018 14:27:28 -0700
Message-ID: <20180806212728.8514-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:f106]
X-ClientProxiedBy: MWHPR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:301:3a::33) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2440a74c-58b0-48a4-916e-08d5fbe375ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:MmSmVxL+e9LGktgrloRc7qz2mdtV9N6hxcqFvO1tl8ltlf+iLG6nbmxpj69995dN13VEXKY1hG3X0/9n4YMe4A7yGxEZi8PBFuvbG66n7CfHMa127xsKTYOl6kS3fcTzW1dT9x72zUSZTAfsScESXlbKwtoj0iSgqgW79OZv8U+yyWcOn6+iWBJis2Yb2yJD4OR934JqirLjOfmkQiisC6AmqH7Y3PJYQkF2hbd67kO5oEnLuH36odFr484SCo8+;25:F2vIExB1a6nZq10eC4Fkru3X6EjfKCVEcGjL1eG4HsDxzKqFOhdC7JJPvqYPkUqMzS+2VL72kYyEjNw5Xd7F51Js1xNGScbhCg4QCw5u/WsvtH3g6izncQzJPlbnYTg9S08AJaj4ELiqYUtMgclf9Ev8ozX/ltylEa5o1jFo7zPwRn6OGx9uCVrwQn8lZ+RU6m/HxyxEguYNB+jQBoZzH3diQv8nJrhlvHKItvH3ZbFw0wzqTARW4FygX8IU8GBhF8CE8pgUN6YhnLIg4nCyaRQEo7BT4DzwIg3C2jMxqCo8xmO7Exc0+l9Scf4Udu2jr2oJF8pp0qJJnFd6yDE4rA==;31:6ZDKxd5jC7TN4MRhKbMbm2JFoI1N++BRIcCX1l16ZSqARNlx2TEVC/zEV3PzD3DMetwW193wl5ABzAtAUiyGuxKmv8EY0gkXaxomRXfToKs4y3X3E8iQibi5lk3pTUlNxzSa8bI5K3Qsdt0pW4T74TEAgLly+F0RX/QjbId7RzMds7AVGqs79TzhyuwSEr/TOIzBOefgyUTDyCqtt4rdnUiVO6jx+w6n7VvC7ULfUXs=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:xiVyuTOWpBAumcx47dLSKB3qvhW652POWNL3dylee5lj86GPdFOPYRYo9Pfu1u488wNluI3YciAY7+qiqhBcApGNcQqEKWG4eI6RjYgYI3cc+2oktvZlzR1MJA1+N+Cp5DC9uhPqmoa0agHxUTHAjfnGcF6u0lKkXouO0G2S0JHclWjZKRz2I6GOVTBISXpZuyelifHiO02jSNZL8kHmV52h9P2C4u4S7q9sTWCxQ13FXU/2t5fpPR6e1ppKDp+Z0OZZ5DnJLV65mpxvnE5YpFqZ67bGBR8FT/8heUB6rYHsKr64OjHGD9WKHD26H0y9X2zh74UL45FMcHPTQzi6Xeiz6899gG1VRIIXPZai4Slcumxt32x65T3/AXEAZd0aUhOyircLH+AHhWnQMRTbFusfY6f/Ce1riQvVBvpIE9agme213x8iM6Wtjc9QrwCh/Rwo8rkLRAboGy2zNWGDOS9MtWhVvhpkss/S7SIsO4d0HQK4EQlrofM4VfueIcZo;4:TRzW5ssZA3b1ih1NST9IaCE2QWsGBBdNIccMwnaEmY+i4uAkLrQU79uvsmtPDfROxmzfsJNqYDKON3x4gggdH2CpPC0fhsr3kKv6hzlWnTO0YD+Da5qL/W15uGooqtPVtWki0WSqksgy6xKfVt+taqee28ItoGAJIZHBXXDhl4faztFOFGGVyJfOwufnq3HvZYSeUWkb7ly1XC5/drJP5lqb1vDT/ViQctXuDNLI/o5aS1c5Y3vfIm6vjFChn2QMeul1Z/+LfkD75FHMx5jjYjrPVUNSujThPz0T9SaIshAx6sjWCttbcd2P86n2Z9ni
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167836AEE655A2499D95105BE200@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(5660300001)(6916009)(2616005)(476003)(36756003)(50466002)(48376002)(486006)(52116002)(54906003)(53416004)(51416003)(68736007)(16586007)(316002)(6486002)(50226002)(53936002)(14444005)(5024004)(6512007)(2361001)(4326008)(1076002)(6666003)(6116002)(69596002)(25786009)(305945005)(8676002)(2906002)(47776003)(15650500001)(7736002)(16526019)(186003)(106356001)(8936002)(81166006)(46003)(81156014)(97736004)(478600001)(52396003)(6506007)(105586002)(386003)(86362001)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:unHtjTb2yAw+fLDF6cXf+CixscRAOg6L1+r0//6xy?=
 =?us-ascii?Q?n5vlOHUOFE013yJsaKboLW20uFYRb40dUIdJrzOcsf/+HmZ2c7hsCTX1dhLj?=
 =?us-ascii?Q?GBp7y+6H2/mfvh6ZqZ1kE+2OBQAXt/k3Qu3lrN2PqoERo7fjJw9I3yGOoH83?=
 =?us-ascii?Q?cP2Y9Yz4k/5xmJ3diHtlUrPBql5FasZpxgly7ysve7ROOC8dMoi22xt+MSuv?=
 =?us-ascii?Q?5l2OADX/n9BVR6Ga0rEKaauXFO2HR6PbxAHYFy5TOxde0MYDSJcezDAs29Zx?=
 =?us-ascii?Q?unhEZ1C+JehIqFXLCBAped0utlQc/EpOykwcchJF2NR/X2Jn65L04LNEWs3e?=
 =?us-ascii?Q?0fwGnt3oilWAG81D5A97ddaai5WtKHAq1vMPwDG/8KQUhH6uwxFvjOBfi40G?=
 =?us-ascii?Q?UxxJC2DbRNA+9IIQSxuzj0LSslxS5fUp3S0DhQKyFDxhOg21Z/mLHOOmep+n?=
 =?us-ascii?Q?zi0XLim7QrjEyAoCXT8wmpCMwaEzrpqPPRNqnub7x7vCgl+8YKbmuIyoiLP3?=
 =?us-ascii?Q?8FBBNf1gNEJwod4R/p6nhdhfw4YS+TiFGqXNkYUe29Ws/4GxCMPBToDJZ9Wz?=
 =?us-ascii?Q?08XuXnHwTM1KMwpdMTQ3WgHZum94bNYZa22XwDbngwnRSEaw5uVLAyECAQP9?=
 =?us-ascii?Q?uydKW8DcVAkzPVofxKxI2CgbqsIJOXoUKkElVIKSpXkg8GK8LONL6xnfiDek?=
 =?us-ascii?Q?+eeCGJpZYQtByYXwAIc9q1OvXY4zgaNIlFFu84A2CSVi72hs13qVIRJcVpyL?=
 =?us-ascii?Q?rQYsHcd2L4YFskMER2aOndOxzBudtiKmgR2Tl7FQocA/vnd2KTwZ4s7G6sWN?=
 =?us-ascii?Q?5xc64G/kXvFM+Ifc7teAryQWi7OLm4yjFP4EqcHLnZuI9I5T+8DqyLhS2M8G?=
 =?us-ascii?Q?yc6CJC5pNm85HGwPhinL//ByjkDfIWitlQAxXxwqGm3z02D+KOq/vyVN87EV?=
 =?us-ascii?Q?NTVxWlXHxfiQ8NazdMonC4AqcDigz6muQyUJZ3BtmoBQllNhABbb0JLGZDxx?=
 =?us-ascii?Q?tPkWpjyX68QwNiVEfzcueNd42bPKhJsNcliVP7AkrUDcIAfpi8CGsVSU0ApU?=
 =?us-ascii?Q?QtD5gkluLFID8QMet3jQ3qpo5xw+ZXGUn8ZtKYkeXc8kuXUEAnjKCuAFw6j3?=
 =?us-ascii?Q?AWAJ/gdfe1SdeCM5LzD6keKCXftx8J/YBgweWqdQ39ani1yq5cudqaJf/Roc?=
 =?us-ascii?Q?vpoU7v8YDiK5zwP0t8adq3b7bqqtc7IvkBiEWciA6rHezMCxUEEOnQW1sWCZ?=
 =?us-ascii?Q?7Wp9wI8ijgTHvnR7Unldk2H4t1P7Ppk0aESgK7jL5FG1ADMcPf7POr/05+UT?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: dCQkEPrRyPvBbbqVLY/QvEr//Od8YFaoZngUJ0H5M6GwwE+uQvrLmTxinmFowxDf13oIclv95Wq8kBPMLOBNQMIfWNKQ7TUGGpHOC/pvxIPdKzSMyEvKwaDxSqIV1XZtDCcic1rS/B0pGG7Vjxirkghutm88ahucBIfHhyBP4+MJtCHY9PSkAkBvqf0qgGtXN/YjCfGgUXIg+NK3HWRski94MIWEo923v3PsW4xR4FsxlMCaNtf95ahdTovJF95NB8tLhPKbXQsaCorgb3GvdcEXNQrgFKaRp7t6JLivu1r0pav4THG1QLczR6xM+vNvW1+r0Wy5KeorIyql0HGDO/6/9LH//flmoL/NQkJIYk0=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:om50ZEjH1OZNAr4hq7gx/hWTxS82e+tTZPokuqe6YacOlbBbXTl79zBntbZjH393KiKbVFuUp4be3E9YQV32imQmV2EvTGBRpS2Y4XTMhM3RUvovNVMGCPlIl7z73DJzS0B1AXyUxIVZAGYVxqdcfklsqk7H8sDs0aqt37dZRyNGjOrVTg8Ol4nZkaytQS8x3TrdFX8POMj0LnlQyMlfZ3HLE21a8yORRo0DR53OcAiAd8CAuyt49B3dESZjKUjaAtTawfHAs8aEq1D2GQWqctQIO085bmZFjXw/0RKnLusl3Eqlu589H9kq1JZe48Q+HaASQ0N5dBEbQ7pwURmhyZTKbZrYxcIjjBjfC6hxtyUQ+Kv4eq93/R4czxKDZ8TsZ/PbDyyTEWlMm2MRAxuA9Q18W09P9LBenaF3zgK1aA0H3uXS6xq1U6ax9p0Z+l67x/awyGKD0Qb6PTt0ZNsm3A==;5:dR9XjvbDbwaJNxEqfukPcj8OWCl7O8LA/f/kQYj5pWlA9k9I27Rp5ON9KXfstkN75MMPsxEIOhI0r4lCCsnIQYNRCYayPlfJPK/Nw4BZW2EdBuwOL66qS6BOMiBhP73bWzpG6TJQNSluySDhMwNG7yfUJ7Mnw/O6FmTxAzJD3QY=;7:q+h5gAHodZclhUg3+P9mLCc5G7fG6N7oXpTRlTBhKwb4lpSj58ENiJaFRL7DQhvcnSmoYSkITYUbcrC2LNYh7w8IsVvhXJmmqwDT3KMFldy4yZEw14I4kqYLJJ5wr+k0QvrTSiy6UKFHQl3j3E9Yt7IOj+g6wjlgYNLeGroGOOl9wCPm+Ha2EtUeoeDK1FSSFXAmGZUj8HRKbs2+PkX9psgCm/fUdW//WnxrgqE3DAklaWa5ZqsVYJrSh2U8Pqo8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:hFjuObjimYW0UsxQjQLBwYQT9JQKMrzwDR83lDlTfJyHWYP+Q+Xqx/Duek5YfOUOqnHUPprPVAZTWSkmSmD0uTfsz+ADUrhZ64zh6bUZGVav0YIjJsW34jU90n03aQAwNabrpmZto4otqDeLmj3ju7tj+gHrG28DMnMrL+6RCNM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 21:27:48.8024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2440a74c-58b0-48a4-916e-08d5fbe375ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__cgroup_bpf_attach() and __cgroup_bpf_detach() functions have
a good amount of duplicated code, which is possible to eliminate
by introducing the update_effective_progs() helper function.

The update_effective_progs() calls compute_effective_progs()
and then in case of success it calls activate_effective_progs()
for each descendant cgroup. In case of failure (OOM), it releases
allocated prog arrays and return the error code.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/cgroup.c | 99 ++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0a4fe5a7dc91..6a7d931bbc55 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -177,6 +177,45 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return -ENOMEM;
 }
 
+static int update_effective_progs(struct cgroup *cgrp,
+				  enum bpf_attach_type type)
+{
+	struct cgroup_subsys_state *css;
+	int err;
+
+	/* allocate and recompute effective prog arrays */
+	css_for_each_descendant_pre(css, &cgrp->self) {
+		struct cgroup *desc = container_of(css, struct cgroup, self);
+
+		err = compute_effective_progs(desc, type, &desc->bpf.inactive);
+		if (err)
+			goto cleanup;
+	}
+
+	/* all allocations were successful. Activate all prog arrays */
+	css_for_each_descendant_pre(css, &cgrp->self) {
+		struct cgroup *desc = container_of(css, struct cgroup, self);
+
+		activate_effective_progs(desc, type, desc->bpf.inactive);
+		desc->bpf.inactive = NULL;
+	}
+
+	return 0;
+
+cleanup:
+	/* oom while computing effective. Free all computed effective arrays
+	 * since they were not activated
+	 */
+	css_for_each_descendant_pre(css, &cgrp->self) {
+		struct cgroup *desc = container_of(css, struct cgroup, self);
+
+		bpf_prog_array_free(desc->bpf.inactive);
+		desc->bpf.inactive = NULL;
+	}
+
+	return err;
+}
+
 #define BPF_CGROUP_MAX_PROGS 64
 
 /**
@@ -194,7 +233,6 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage, *old_storage = NULL;
-	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
 	int err;
@@ -261,22 +299,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	cgrp->bpf.flags[type] = flags;
 
-	/* allocate and recompute effective prog arrays */
-	css_for_each_descendant_pre(css, &cgrp->self) {
-		struct cgroup *desc = container_of(css, struct cgroup, self);
-
-		err = compute_effective_progs(desc, type, &desc->bpf.inactive);
-		if (err)
-			goto cleanup;
-	}
-
-	/* all allocations were successful. Activate all prog arrays */
-	css_for_each_descendant_pre(css, &cgrp->self) {
-		struct cgroup *desc = container_of(css, struct cgroup, self);
-
-		activate_effective_progs(desc, type, desc->bpf.inactive);
-		desc->bpf.inactive = NULL;
-	}
+	err = update_effective_progs(cgrp, type);
+	if (err)
+		goto cleanup;
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
 	if (old_storage)
@@ -289,16 +314,6 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	return 0;
 
 cleanup:
-	/* oom while computing effective. Free all computed effective arrays
-	 * since they were not activated
-	 */
-	css_for_each_descendant_pre(css, &cgrp->self) {
-		struct cgroup *desc = container_of(css, struct cgroup, self);
-
-		bpf_prog_array_free(desc->bpf.inactive);
-		desc->bpf.inactive = NULL;
-	}
-
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
 	bpf_cgroup_storage_free(pl->storage);
@@ -326,7 +341,6 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	u32 flags = cgrp->bpf.flags[type];
 	struct bpf_prog *old_prog = NULL;
-	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	int err;
 
@@ -365,22 +379,9 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 		pl->prog = NULL;
 	}
 
-	/* allocate and recompute effective prog arrays */
-	css_for_each_descendant_pre(css, &cgrp->self) {
-		struct cgroup *desc = container_of(css, struct cgroup, self);
-
-		err = compute_effective_progs(desc, type, &desc->bpf.inactive);
-		if (err)
-			goto cleanup;
-	}
-
-	/* all allocations were successful. Activate all prog arrays */
-	css_for_each_descendant_pre(css, &cgrp->self) {
-		struct cgroup *desc = container_of(css, struct cgroup, self);
-
-		activate_effective_progs(desc, type, desc->bpf.inactive);
-		desc->bpf.inactive = NULL;
-	}
+	err = update_effective_progs(cgrp, type);
+	if (err)
+		goto cleanup;
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
@@ -396,16 +397,6 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	return 0;
 
 cleanup:
-	/* oom while computing effective. Free all computed effective arrays
-	 * since they were not activated
-	 */
-	css_for_each_descendant_pre(css, &cgrp->self) {
-		struct cgroup *desc = container_of(css, struct cgroup, self);
-
-		bpf_prog_array_free(desc->bpf.inactive);
-		desc->bpf.inactive = NULL;
-	}
-
 	/* and restore back old_prog */
 	pl->prog = old_prog;
 	return err;
-- 
2.14.4

