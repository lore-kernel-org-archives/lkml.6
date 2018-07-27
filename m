Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16A2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F0320857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p0m48c3Q";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kxmbeeIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F0320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389960AbeG0XRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389889AbeG0XRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:18 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuF006591;
        Fri, 27 Jul 2018 14:53:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=aaL6jEaAKv6xk2HSLA2YpOKJojDVFyvDTGqOyzafF1c=;
 b=p0m48c3QMElsuVzfAB6NL8MURNAm5uMpv7ZBvgUACb2Xwv5Cp/93HBdffesENXfim+uq
 5yH1B2Js8y31IIRTXpg15ge+QNoJjaOgHpD2HyPff2g4eQADZXw0TcfdKKo5LZaPg5/o
 DaViQfee23kI0mjeVIqypDKUt6b0lD5Ry+U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2md-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:07 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaL6jEaAKv6xk2HSLA2YpOKJojDVFyvDTGqOyzafF1c=;
 b=kxmbeeIVinKw2GU9KuMOQKUmQBXv59rZa65h1gJMGWacPTuKk9gNJhdf0cexEuUcy4VMJMVEzg/KOmfLmgj9XbFX0Hvt9yk2kJvmqAWmo9W6r/6xv+cSUMMnKx9crpELPgyZ4dafElODBcOko7REKcEtHTlEsvNj0Wjrr1ds22A=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:02 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 03/14] bpf: pass a pointer to a cgroup storage using pcpu variable
Date:   Fri, 27 Jul 2018 14:52:32 -0700
Message-ID: <20180727215243.3850-4-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fdd1e5b-6633-461c-25c5-08d5f40b538d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:pUMJVu75p3xbYTFQi0AZwC5obGuQpVa3K9cNtrnolvbSknnTd8B8NnxI4PFh0a+xW+MrI84pAGpWKlrS1QslWEbr84npteLZg91IOKPMo/D9qTyJsSa9rEAyprZZznSmY7JacMn8Sg3ZVYvN8TBT1YecHzC9jlLkhiXteN76ZGggQ5jrBbWCn5eNwXoA5bUwStOPGySx+lMjSTcUJ+lZ7Udr6QtSUgmk0jsNy7Vbvfg7b143OE7ccjVpUQ9/16UG;25:zhDU+2jQF9SixL/EoCAX5dVs8QSSnAnrzlHRuhuhZGeEUw4tz7IA4L1tIVrA9Cncd2dN/Umir+cMTVmK1oq+fhaRMHl04mGLuj/eHlhkmN0bQiGKdRvtP4nsQ+O508qJFORRJRKz3IZiugEqbWWlusLKsVAFpWycBd1HGoFGOXfLhc6QGE4L3aNDZe3iHGy816Uyd/5/de6hYqgAKCQJxCw+Yaev3UV/Z/4Z5yhrhCDTcEYVuAavbDhmAACvK4SmgT+J6P6f0Hay6Nkqh4JN2NVV9gkNmrJzZM1otfgIb5pRoeM0Hdd2cgxnj9Vdt7AstSg6MQ3QgFHWL6DTjfMhPQ==;31:D4i/sUFO/q9IVyOmJadvCrPHuuf5zLIVn3Shjs8zXl5wxQsWNalGlZ0y9fRVX2pQI9SaCRBJKkm5oSM1kJlGxA4lLP42deITNuIVcNRrDDvTlcAJebGy87eCbxE+XFdPhZkUuA1Hs7P8/eNUpWTLzBaK4djUDy/367DgJfCRVHCqr9SoA4J0se+UTZ3tvvySNIGV9+r1zp2DnHQISkwQmbYp/NLbsHScjhnI9NOubUw=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:Aa8sJGIwR80ibmkzsReiP9ocTKIHZSkX8yltaN9G7QDsEclYSWyPtGu6daMvQWjtxtNh6Zp7wELfSM64aSXXP5uwXlB8IaoNp+b7DpSDfmlHFoftURfhcx3/Z+Zi6jbgP796mc/J5ktHBjKdlvXy3abzKF5ad+3wYuLlfRq+b5f1Lc9UP6OCUV7P5k4yH8ONmUBlAjG7PPmJEUk1e9iGJDpGx+pcPXIwW9IjDgZ91kBSdSzorKveNJCl/7D9CyNjL5S9MoC1tUsSJUYfzWtq1RXuFLXNItZTmoDjcvpEnLW6W3zzSb02IENk4meTQrpKE4+bNAixWYCsRWrZvcU8DbUFEzzoBVkII7dmTT5m4KncuDIkgqRrcOFoWiDPKdu9zCiAC2ScB+OygwSzmsoJFG2MLXRhvzmV66cRj/LZywB3Rkr99Rhsb6BkDIaZD3sSCywAvv6lokr0yqfR5InMYoGE1FqN/UdJcb6qsKiL6kXbY68D1penwg5rvRaen3G1;4:lznxqaQngE0x3VGLWkV8AcyKZ4nBNnXLMvy47ZIyODHHIfbnDqKLGno3JYftvlSJ8t7vG4umP4CarMxWkwb9WHcFZnHk15coSJ0c4eFxRP6g5nc4bczHrYsX0z/o6miTt9ixGjLDDw8p3C7gOIZC0V/yPsJSKFUF+sKdOUC5K4o7odfOjFiAsf393k5mex1PIOjN/EBBwEHKphxiPMw/6QIx9QyFPzQewnW4pnXwjLWMUAtR4+HDsXr+LewKuHLQloHMHBMhRYXmda23tXgGzR6aw9ibLPanQJVvCRJOLV4QDA+W+8gsUTF51jJIeyc7
X-Microsoft-Antispam-PRVS: <CY1PR15MB017142A2F7E9BAC6B54E50F3BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:9+THySN52Dfj86xbtG5X9pi4B6pSj2H9svISkuVuS?=
 =?us-ascii?Q?g5U55hjvefaFrxVw3dQY9/0/aLOSjr/gNn1rd3kri36+4M5JAcmhHLdTTXYX?=
 =?us-ascii?Q?OJBl9218lKNNFqX6nS51knXfp4U1n+IPxR7CDpj0/jeuvzrjE1iTjl3X7Udi?=
 =?us-ascii?Q?fVwUiZw6+Jnrs4d3jxUmUiXBLHVR8FzZVK5zUvDA6f/PawEXkpr+ZesRuY+b?=
 =?us-ascii?Q?b8UrlATk/3Y6y5a0i1gDRcdqclk+dgQaULiwx7nKiN7mQoiwg741KRJ/1k2Q?=
 =?us-ascii?Q?bjtKZUX94Svcpu1++d3Y7roYw6FhQ0sIapc/7NY98xusVNYNvSbKzmddkqY0?=
 =?us-ascii?Q?eKb1Lq+0OReiUF+NpojTBGNr7up/rVPW/AH37XTaCehIbpXXbyabkVnJNaTP?=
 =?us-ascii?Q?z7PUrteosoBlIa/8edIJdWmmODbW73K+QmWz754LE9wtMvK8Anx8vr75GNks?=
 =?us-ascii?Q?i7xkRLWjCKTgS1r7U4rpqRslVv9PFhJiTL+Kzqr8sN7h0yCGBXAdKAIEqM7y?=
 =?us-ascii?Q?5K+zVFqPAXxUzBU8kqXU6SQ1gFwVlNajKfDtC7vFKZ1pVY+O7j3DuzapwZHj?=
 =?us-ascii?Q?G8rebOOPbsxHOIbFj8SPHWXVGpnofCYTRsZD8e/LqfzkhPdmuMdAsgyuhiFT?=
 =?us-ascii?Q?K7a94zkm5W3EqaVq4KngWPiPghDm4FWRDxQWHJWXDgaddbmTenpSN2U/nOGK?=
 =?us-ascii?Q?X1lORAtm6loyVwkaUaLIZxDF/J06Ur6HR3rVfobmkQ6YefEXHVYlLukEPTTP?=
 =?us-ascii?Q?3li9qqiRe3sV6hhWHOQCYB+fZZ3OzKmzOBHOmuSD4iTHxhoR7ESC8F7zKAu8?=
 =?us-ascii?Q?oNzHtxk26CmBa2V8Y9z3VoAd+gm8mbYFwh7keO+RtS8QWtlcpZJ6F7r679pg?=
 =?us-ascii?Q?xBcdGkGZWQhWC/FtxtFXkEp2O/90a3UZgV76Kb1+nISjiiQCfFFRHM/KcDRg?=
 =?us-ascii?Q?vDhd34M2F1e7JB6MxYhn3KwHrVlhCWw1OpipRa7q3G7ErPva9KVpkoZoJAvP?=
 =?us-ascii?Q?AMp6/S/CKmzMIb3P8s3pNwdZBEXiej+Piv1F6k1sbgJF4aG3Y+VCSxY2JynH?=
 =?us-ascii?Q?rUupsh2tRm6TFWeg28UwOYKxJechbsiZRYNHY5/SXSr6ZnpzLHhYn5nnlQk2?=
 =?us-ascii?Q?Vx63gcz21wVgSxcNi1ao0qaFu71HtnguCvXg5EQJWStovAG/qk9F09ZDWNL5?=
 =?us-ascii?Q?BgEcn38O0xZUZfUT9rcze/nYmU+DgCVL8Z5I4bm1M4cccS3iWxcK4H9QF3XJ?=
 =?us-ascii?Q?Lyj3yz4/hSL8vNAO6UiZk+g3FpYE+dDAZ1ADl6YCivAuXhYDhuROHQunOSGn?=
 =?us-ascii?Q?nfiRPCwOqs0t9AzGL7gveI=3D?=
X-Microsoft-Antispam-Message-Info: edF+VqTweeNM9RSL6sPAlnAtoKbfv4BplwXxXJ8foPeoev42G0JBF8mcD+Y5w2eR5Q1YuChjpW3YvetXGK1elQ05so/y4F9Bs7VNKjHB85/8tXaN0Za5htSTrpfKNfO7FLRUJHB+276u5nJEzvSv8mBM8LSoVp/9F2ss13OdsBJdAW3wav6Am2n9oDktPbYCYfCbzo843IYfLx0Jzk+o7ouY6rU3BVXJkzbQgPJqXPotxsxC7PRnBAY1LER0OkbO/sFy7ILMXxoI2joKwzfqhPOYvO6r4yjr80TkCN5JnB/IM0NI5xkWZX/4Ake9y5kcD78akWHa/WIWzQi7XcLYnLuemZnrYNDcP1KTjBV74r0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:UuTEZ+TD61AmdKmfzWb16EsGBucNmAegnqcYtVFqSFOO1KbBnLM0C/xORR43b0Sq9AXmk1BSUUzxvl5DD/MHQsFmHArSoNsGAYrPlWWOEybaZJbYPh0mGFmSkWufkbfxHlaAyZ9x3dVO4RCG2+hUAW4R/gsI454l9SXbURfwD+KIpvaoZe02FjAZYzvz70Eo7VijOQ+wqwffd7y5gij46gi+BB1oS4BtdIGMIM+uoUO1yQWWEaDYXRmhRrdrXkWNKlpFurbzlhtKv9grWGtBM06tyO6j6K0Grz/1/dhA3xL8QLNWv6hvf3L2xTke17Md+I8xVfbL26/9/ylSsN/oGbNjqJbYEOKuoDwfXBia/V3X5UONVmcinvDahishLZ5eiafB5aJv4kpy6bf50tEGK9soMrjXnNh3tOsip6FMUJLSzSC5zu4hJ9EIwwMEj5R6u29ACsWn5zCkelkK4BKLtg==;5:wbfJfORRVT8cTjQuBWHMW6Fp8PMoGbCw2ntrmFpzMhrYs3FHPGXaEzK3NG/NjybTABbqPs6AkGODhhcB1rFnFbtu9paqaDuQX3Wswvgc3/1VWXdQXd8tZ0WmfphjVlUXWKdQMv4HcAcO9HikbNwLcT/yIPqPmAh1wo80WpkINAA=;7:CHV8xnpq3qI/f9sQzZQHLgKStxcUXDg2EG2C1yf3yyoLWqZrv9GjBYckFeNaXxK3Yy1OUTEuFlgmHT2R56pOAIp5LbVt5dT5qdx6hLlGWDJb1bnNeTJTbfBucPqOiiEmLhxlgNIh5Bbg7TWMTS+KvOLQkiuK7QdzA5i11FOxpC1vgUOQRIA4mxAI3lOueGRUnhpTxWJLe7HI82s0iRRwTHHZR3MFfbBMvpaswD9JTUj8buYvitHesq6MnR9TTbyZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:B9D2O/hZxe1WKdw5LuYcCvGtuSre+KGHCdNi0cMDdRg6F3Sg1nJ/ydMumF/wRnz75Q9840BCK/CNZ31wt26Ul7838rt0g4+QXb1UXWlRE98G0NXOFsmhnMxjs4Jz9BSPuQfwiQ6v1CT/GsIRrsV7CY7XKdIT+F6zYxNF8prTCLk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:02.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdd1e5b-6633-461c-25c5-08d5f40b538d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
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
index 395e7278ec75..62feded85e6b 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,6 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
+DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+
 #ifdef CONFIG_CGROUP_BPF
 
 struct bpf_cgroup_storage_map {
-- 
2.14.4

