Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD0720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PzO2nxOC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Gx+KEUid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD0720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbeHBA2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:28:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732429AbeHBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MYwxS020856;
        Wed, 1 Aug 2018 15:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=inkWtakTKNZwwC64xYhRo5MuEDl1ahFkYt6AKSnCgDY=;
 b=PzO2nxOCZaPQ2jUwvQFc6e+EgFGY491eCVacJryK8qQVMzY/ByI8MI0I9715AMtz634H
 CbKFsz5nBJS2Cz9i6acmNxx12NNGqBbdLia7gkMd2rVv/FiqRE9mk1/u8az0HbNTbBTZ
 slYh4Zw1OMnZJjPR4A2L9BdQw/RGOmReI+A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmqb05qg-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inkWtakTKNZwwC64xYhRo5MuEDl1ahFkYt6AKSnCgDY=;
 b=Gx+KEUid0+v5dQLhdOIKEW7skwqoCBdXjpQrN1YchHq8RcUQ9yFEqZ8jNlRxAaKmPvTxrbtAz4zHdrUG6r0cfxhg0BGrKr1xQwPhV1FX4goTAFCYnqpQuziVCcqXyiVbtSr+rlGiTkIDmZLCToX14tmS8ECpiT2sEeeSJbuLXyQ=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 03/14] bpf: pass a pointer to a cgroup storage using pcpu variable
Date:   Wed, 1 Aug 2018 15:37:29 -0700
Message-ID: <20180801223740.11252-4-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93a44266-164f-4bb5-c730-08d5f7ff79c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:7+Hn8JCZzOKSWIGTI78sYtvnZQRqMBuW8gLvEw/HouQQA8pa3o5wS120n7NLactHHwKlhEeubu7FwRlmLLgLyWO8oR9j/jv7kbflqVqq95aKJTQSTuOoX5ZYymBiJ2mKtIhgJtnRmXwBe/4l6JtWhQ1RNETx7RP8NfFj+wfyzBJFc3J+pdPmN8kvbz960t4bNr/GJJ/Zyxv1QSRAqyjbLw/ZGFwUkPQp3f0FQhL5YlhMo6/vvxfwRqnda8z+H1iQ;25:5VtAVDudaPygNNsAUaCQsCA47+KBnTGs8BLO/bf2K+YbDuWwq3muamgqbxMHW9MQP/p65jQ20sV8F6FcUbEyPgYiYg4FlNGlWv5+qgUH7q6VYnMlIwHkEYl8XeXpgYhdXmR/vSC8oyt3Zbq+sFO4ZeiULUIKlc+euo4EBQXsZRZ+3v/jsxWdTx+d0gyZpy9v+aeqpwWuzL5XawpiasKF4o1S+Hp5RhdyksMtz4ky0ge89EkvEIbSySQLiekVZyCjcBUANsg3c6MCNLDmoohADZv+H1dMIC9T/cbAHzGS1oC7CYRv3kZvC6Ppi+MPgfJewTioWhkeL4952/mTdbAzcg==;31:WbS95rQRBB7+5O9OWq6MEQnxsltB0sSfdsJaIZtL+fSlqJEDYi3pqq7LvqW8/3IrrxnAHrpOBRhgYE/2HsrHWIiQyb4JLmwAW2/T+5UJ9kQyBFDw5W4JGavljt1UjhQJZXSs2LmBlnRXBzbTL6+Zv/ci19d38NtMolGxuUY73+Lg25weCDRKFeMchBjzw7lUmXSBM2xpFdZMUW0GRS/8cBQzc7DvMU/VRIbS9+67Is8=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:Ippf6fzFG56/CdpRS48u8V3K7r1pHIKiJb9XKzfbgTAP51DrUwpfWzrn4Qiv55stuvZjHsUCZYlvC38nmAolJMUwWg+azDzb9drCJYs9dVeuEIGQsTavPw1wpQSiCWbhCLeM0TuxWPVGTNgGPUnOa6mHcfAFveFxcFzSm0FCjvBD0lCNFaHC5vlEpSm21mSZjdL1blQMx8SzxkJm+zMRHTNw+P96B3NGGnbszhmBIxBjptZEcWd0VMLORqnjpFqUDTbncpLJEze0A10MOMcy95KuuQTf2OikhhDFxay8tqkv+D2JPP0vSqDZe+iOATvA52Eu0p75TlKqsK/OS56vvxo45NcBGZ3Asihd8Se3Ou6YzFzF0y2CLvh+FqKMprJkqgYuwx+2P1XLiVG7Wf1diQJRnOt2Kz33KQVsYFBhLFZCf9wyHTYGS0vF2fdkUPddN9tlFhEHkUio0nTt8O902wi6jLMqiX//0dQniOSr5vhj/x1ZMKJJPGxMWllPJjsG;4:+Pj2AWKEvsu5JRg4as54Rx5WjStSVgApwzaYMMtREkrocdGBjnVPcI/s/RpmYB003lOhAb4ouEOy2fqAVlxh4IlEryQp5/7zUC5MjEGR2TZ7mZyoGP4WmtsKsr8NexDAp9eDwveQPHeWT5Gn12Rqj5GxwV9AB0Xxfz/gVr93wH2VN/ByVIIVpp0a2uJgA6fRWmIJ7vrCt0gewyIY2xE9fveVzbzNzfafbsfcUGQCAMIRmaedf7VyLUKlOblMwqaYFbIsUdySv4MJx3TpQn2pasJyI6bRQxwDygB/msRYYGv+TfWhcl8kXgaVTG6/7EKx
X-Microsoft-Antispam-PRVS: <SN1PR15MB01760D6AC9F2812E4B08DB96BE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(575784001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:+1SPut6xT5jkhZHGnvw6KB/tuM5U8PR1kgT0VQZxw?=
 =?us-ascii?Q?UdmNdxD1H1AbqXP93wV28Z862RODryoiUkoyUHn0Zj97MmWtWl7wH3/A2iM3?=
 =?us-ascii?Q?n62l9l2T+PHrwpdp0ZXivlPg133XWM3IH/n9rFXKS59aUIHlD67PziIz00SO?=
 =?us-ascii?Q?1QzuOSstL7B/OTciqwBNO7i4Xga0q/SeHpFLj8xvnmtC5skh3haoFrr7ue6N?=
 =?us-ascii?Q?gx1kQkvTkia1VKojqnfgWw0O74E6yaJ01Gp8TcGCqRWdVo2aAuNka9768YDq?=
 =?us-ascii?Q?sRNW3mfIYM929APAVkUTrZ7d1dOHhL3oD4s7sPU14WMiFmWDxHqXDIYe67vH?=
 =?us-ascii?Q?H5JB4Hcg57DNm/GlIoQ8kpLqhVtLF5KmspmXl+1J4cBRcNtlt6aT1cp59IhQ?=
 =?us-ascii?Q?VHVOhW4ay6WHrMnZ5WCIrH6cryGPXJ9rkHIF5VPHjswh6qZFQWdR02FMBdld?=
 =?us-ascii?Q?+D5YSpAUsxeOd2nwcSU1OwOUMGSUXqHv6WX8KSUy2sF20u088bZToH73S2aw?=
 =?us-ascii?Q?QY57qM93wpLusnsnZC4QY2Gc6/HZuVB8wi0cjfrrbbjiGGbLrD6DPCUfDZdF?=
 =?us-ascii?Q?9YxUnQEOBMF1vLhymN2qwv+i7elQgffA055IohWnxshfk+ycyhU+NAoIbEar?=
 =?us-ascii?Q?bduMUhhYPCivXQh2TzX9iPymkRMagSxbb3D8bLGmZdgXfvbT+LdgJn7oSYlL?=
 =?us-ascii?Q?WtWWzY5wYse1ruLBeAxzpL70AG9WgHGRW5dJkWH0z72MXTrxVdgb79wsby2M?=
 =?us-ascii?Q?RFMfILQXgiVuADdLmt/0SvQxw6LyJVVx+mp/0LLlyZDmncIAgzIAULoQ2PaW?=
 =?us-ascii?Q?+P2eMgSy20zU3u+NpDWqz2AO3lIoTuQKp6JUS2zNCE7TUzkTjCb3v8NhpHCJ?=
 =?us-ascii?Q?R5tS3eZoqpjuF5/WXIxoLAQw+cxppfgm2w0Ha70J+A3g6YxTKoj8UZWDkFQ+?=
 =?us-ascii?Q?7RvpgC4BXQR9/WKZV9cqjsTQ/AM1tWVaEbJSFmvHTxVzxS2Ay5H+4mQgltOE?=
 =?us-ascii?Q?TkZFW8kjg9SpkN+SBWQV7qkeoTXEi34/ztTRCXECcAF/Abd02S21sLxU00gI?=
 =?us-ascii?Q?43aamwl1fnQWVIfSSGCljee7BP4F8wtkBPpeOmD5uauOGfIfYhkm5QYZABhl?=
 =?us-ascii?Q?8qg3F8fL9JVGfJ2TaWFgrnGA/gxxNZu3c5EbGMSiiPCxGjukkSviFimP4bzS?=
 =?us-ascii?Q?F7FQzieDAvLYTM1dZzPTkCeDzeQWIV9iDXirH3831P9uB4qm8ZeAvYZLuBSf?=
 =?us-ascii?Q?nC9T3fpT1HsU2YUkOcCKCM5tEkLTkZnlpaGQBSZ7BHPWBqBnaZh/1i7MFRNB?=
 =?us-ascii?Q?o+BE9uf1y3vNBSJFRYlPMrLS3kb+PFwZaSheoNeJV9Z?=
X-Microsoft-Antispam-Message-Info: Q9FjVw0TNBa1FFSBvpQ+IeimIE/CDqrD1myHbzOtVQOiz/13gbIy2lFRLxtDocvPSTsNN1qUsRuydgZJm0RVoMSl9Mjy8F85YQhIUyCJe+9agWtOg24hYYK7jk36so1zJCio6itoQJ0pgmCcS+nmkWRS2/fGqlHFxCSFyEqRzBgZM0f5x+R6lQflJ9HyhC2zuMS7FeoDG19Clt4MNVGWNrrP6z87cKSV4rgdD7SucLfydCBt8ykhVeA6neFFAHOUpP+OqTcpJxIj6j66muIGp0wpGzFkB1CcwZby/MB7mJHDQ05K2eoTCXzKt0sJvJm0S1HxstamZMYxqabuuAN2Z2jscQmQqPLNERVI+TyLUvA=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:MJ6HB0SFE5XLIX8uuTugGw/Q1W5c3FYv32gfdL3AnV4ft9MVsM6+OwLfXSsj1Cyvt4mFqdLl36Je7j88c/LVO5XxduzgReyrWdODaKV3YkTc22x+nolJgn5NogTE31SkvGYvzPNcCPQpM2zADl8HqOzSEjuEOic1XJqFhYywL6WGVkw3UyiwvtYb5mdORCPu9tFRN8ZuqHnnyleevN9jeRnLJToH6Nn+LFVJ3c6oQxQyknegO+OTAXyWw6fiPRd3BnXMc4h0GoKiS/DTW1q6+XSX8oFJ32JXcRH2Pv7eCE6+E19X1VSaUxQHd2MpdA7w7euVZwAWq+RHPKY5kW3psI6C8qtAZjxqWze7nkboGh+CIwns0NEZVK4Fyyo7sBBeSCVqsVjRLThFYRSUJPKA3/JazStDNfw3rF+S7st282yCzhufce/PqpzngbRfOppwC1OeS6o6+fL7wm0XTYZhFQ==;5:UATW6tmHz+s4tG+bz7/kZk8p3xQYpCWxaDTim/nikaxZjfPPF5K0DI09LxU/t4dn/hbAvBiO0414CMdUnyS900GOZdddn6yu0dab45KylfeQ2b5qidNdcSawFrWDx0micHOqVKKJkQs4+RmjCyiuKSWlrqfSWhumjy4W2sm7WyY=;7:B7XEv0P6YyAVBebSIBEy9TEWhKVYs2/k4/sm/0761uKEnkHI3ZySRReeYXhFCzYLdgz5WEZcYbaUxoo8q0kXZwPqj46+02hPcHm7jWCOSPd0kCVqdIzQ1grI5BJiK+pg+q59eL2bA6yvDlfZOUBnKeZdRGrYNfdZLrgsE2LOsVgjKpISORPqe2nXetbYhK7pugAgcBADShsNeJGnb1HRW9rvkfiGTcvMAlBypVba3c7/647m0JM00gh8cvdAU0Ol
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:5E5yKHOl4QQcxjO2F6dYTTVn5kSRQPAfs447MxoNMPe1bK95tcZExIIl3KYJh7VcTfSrBi5PaI5jCfIsBzt7UOto0GJ5oIBWDxx3RtEXvUjZgPJgMNs4RHvZgy8+Z2GNGFtbec3npBt4WQp86eNlMXd6wuStRz5vvF3RsQ+BsME=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:16.7975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a44266-164f-4bb5-c730-08d5f7ff79c0
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

This commit introduces the bpf_cgroup_storage_set() helper,
which will be used to pass a pointer to a cgroup storage
to the bpf helper.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h | 15 +++++++++++++++
 kernel/bpf/local_storage.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7d00d58869ed..9a144ddbbc8f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -4,6 +4,7 @@
 
 #include <linux/errno.h>
 #include <linux/jump_label.h>
+#include <linux/percpu.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -21,6 +22,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -97,6 +100,17 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_storage_buffer *buf;
+
+	if (!storage)
+		return;
+
+	buf = READ_ONCE(storage->buf);
+	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+}
+
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
@@ -250,6 +264,7 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index fd5edabc48b3..cd0b115c2395 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,6 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
+DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+
 #ifdef CONFIG_CGROUP_BPF
 
 #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
-- 
2.14.4

