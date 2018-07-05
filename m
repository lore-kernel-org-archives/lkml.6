Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C2C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C5423FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nTJ08SOd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cgKdfR9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C5423FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeGEU4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:56:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42556 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754225AbeGEUwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:39 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KqIlw026792;
        Thu, 5 Jul 2018 13:52:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=NwqBq7SN7lbNVpf5raLIlj2CWJ77fbj0nKAtEBOgDrg=;
 b=nTJ08SOdTkfgRS08+/vevaoEYCqxXYrRu3QHNY/qljomeJoTQS0m3MBdXg364PUlzvMt
 vWPnr6p2VmgQGaB7CuvWAihhPji8scMJPRKGDay/0tOlf1vpj3UCloRMvhhTo8Aesnxo
 hCGzySJw4okN/OTm/xP5ahwpoK5ieeO5gNc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k1q6urqhd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwqBq7SN7lbNVpf5raLIlj2CWJ77fbj0nKAtEBOgDrg=;
 b=cgKdfR9Ap8l4u1EZIA+5ydLlg7j8vPhp70SJsWMQvTIHMIBPh8YVIOtUTbhhj6J8id5mqERh7JpRogLg/BEGajYLIQQppdAN1DGSiQwPBTWszd9D35Eo+jusPE5wZiRJmKXydaREZIu4r1EIRlyy5S1LhN5LgWEy/MJLKud/p2k=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:09 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 02/14] bpf: introduce cgroup storage maps
Date:   Thu, 5 Jul 2018 13:51:27 -0700
Message-ID: <20180705205139.3462-3-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6e1a656-5a07-47ad-fe77-08d5e2b92d35
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:3aFxrr+R4NCvtxuyl9FcatidSLzNeWwyhyRFrWh+fxYh4clFb6l2SO2n7EN2iFhlAwRQNRTb1210oWz//6Ry+VBC78LsceBGDtybxtNKw6/6Lmxvv3ES+2IsThV2sLIcy8iziMsQONlJkbcjCmtdWSX1z8Kzn42t+85yy8rAuh/mN+h86lKSAxv6DvH0yUVM8egRanJX2RV19AS53Wmzv7FcptU6QX5O6tk8jtzMuKuvEuv85gwRu46h53QapJH8;25:IoTJSDgBY1wQZgXhi54aRtErqmrw03UCQWGnly3vmji9NQOCDjjf0rb1xPM1gFj/8+jJDSgUh8BUBekSvSc8UFCrA0E4RJxysr5Ct0H72YQ4nmTR8r4sf6riYGBtJlYWPHFnSeIwTvgSe1md7iiFxcTqk870RMl8zv7jqckvDopaFkwMKoeXqXHwo8Qxn8Bj7f3dUQNgVYthmS7YCzhVNXgfoubreZ1h5VW4SPO6irFcOJIXWmxnwTQKGdDdobwbYLWLkUgxopl5YUj6/q51r5DNki1laDgdeYT9jH01erNYp8JsqWT7B57o1ugFCjZBSX9IWwh3ojOlmYqoo4Q6QQ==;31:XMiKj342/mPhTRJv8qU9e/UK5FQ6CwP35538XXqwIiGk4PlWVCzrcOw3MYgH8CbwkFpsQu7I9BZCjUTMaJVK4OxZc2AG+nart7fuHc5W0L/RP7Dpck6nw75222+uzpSvTyu9zeuguLoEuuemCxGemL1xCbI90L5xy7dRJf/bWxKP9uFpkF00uup6iIXJdFTCdCH+2bPQug4OteZTRZo4Wz3i3zW2QgnOYt0WLn6RIG0=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:XQWu9KVFj4LMIIQQ6ZE9wvyU3B08mGg47h+UdETQZzkP4AYYQP1OQ2i2qkNYa/XNdrs7TupRgkY+mNFuh87XmMbWleRkpUIF1aB/H5Fp+CBt4zcwW+mcIOpRj40P6QO59l6AvM+2w99ESC8sJjwMDq9gioFUqahMbhevh36+Coq/msM38ZrpZRSnz0q4oYnsP0BZnu5JqWYiL48CFool46/IDooX8odzfl0v6NSwjLcUqpvTZFIMd8/gD1slwcIYxpASkvFtzSB4lhf4x3Gz8aZvHPor3d6K5UfRqclSSIOGU6B95MZIhiMnxLK15kxRDGdmmNynR7EsHds37PV080P6RjWsVHJ4uxhGYpVc5LxzfcGOw1u70nb3OXV/UXfFFZkZPV7fp0QC53097ZASdnwu5xST/9iT20NcWZiX8CyVt+MMHM9yopiObt/ZAJJIBqFlX/dKMzBjTT+imTWUWdhxNdEsEHkPlI6wW6YJ2veccnnCMholdkXZs69GUXPC;4:0GhKZRAfip90raCapT2QYzFu4G/mgv+gWmvP5UfchGM4yCm/vbpLXxWTy+SXurTXr120oFyatINj9mVSZZ8tqP4AmoXJOlQWONFl/LXK7805VBsL4NAxkpNXfBWXXdBHLMz1zxi5cbHzFDquJeuibNDkPMqfL/ca6mmGuMd3HUrduqWq4OfinTs1VMnfkhbIaD1HjDxmZcTw6PpCh6G0TS8oxscrVTp/gCM2gAog1oE0PpddAi8GpFkBJfouOrAljSB9RhUWmSDDXxCfCgT2mMR2mZiEdXKmTrGySgElMCHRuSdo4wlyXAPYiUhllcMRvX3WWCxIiYlcbRFz+8CUjg==
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166BEB6B6E4ADB7BCD8159EBE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(575784001)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:+5FxQFjCCkcqQtdCGJ0lRvAM7mpXkgwfsI+ktAHq9?=
 =?us-ascii?Q?rksYvTBzTLC7YsXqNKAdv/SCrMPCFoaOW1N4rYIYgIW90KXiXZP/AP2FiLq2?=
 =?us-ascii?Q?uKuc9VtUm5HLHmeUVX3t1oN/Oflwt6lpDla3SyPpFGuGkt29SaBhXJvrqfdh?=
 =?us-ascii?Q?qsVK8fFeP4BiAaSSc0fWGWgSLHQvW11SHDm5jSkIw4lWNrrH0w1AGhWhS57g?=
 =?us-ascii?Q?NCOnX7jfpKHyS1sZPqcH3ticRYbFTbsofjO+mkRElaFJ3kiAo9YY8uRil0c+?=
 =?us-ascii?Q?7bJ5JSY7dKoq7MfzkrZHkohftcVnvGww75i57WDe1CazX+RMqsBE4B4Fz/B5?=
 =?us-ascii?Q?rYGi1b++yqERRy+noer9EvzgXj6K+8clhC6ah1HVIynA/2PqFowGmMTUiVgV?=
 =?us-ascii?Q?DivJ4Las17IebixB3zGNCLlaibwMOPf2im1EmI1vgbhFtFnLeXVvXn+oz2Sf?=
 =?us-ascii?Q?regz5zW3xZzvQFVaMmf8ETVc3P4OvjsW3wrrEVJoMUXBRAMLNqRde8zOaOL4?=
 =?us-ascii?Q?RLuEVIe28sJ29WuEJaqh87FnDjdtdOqKP5zfyd/sUiBXG/dPsol5TlTNeGtQ?=
 =?us-ascii?Q?tythBSR4vQsxF+uqZe+epAW8boqPEXNSFDpxW466+6F6nLi0Hdj9+LYVVJh1?=
 =?us-ascii?Q?ATxaY20n2dGmm/va39jmKXeg8Eq5ihrEfP4N2sKOxqLfsHgHPfTqTcCioXLn?=
 =?us-ascii?Q?zRjHMRWPR7G9pRUYPiTQ6udvi9ZUD5w823K2Bl7ysrXUxoL/y7De4JdfStKA?=
 =?us-ascii?Q?kOcpGEhB+k6kskgjc74KpiTlXBmVCFaOiW5VcGemmI1K1sWG9r2/M4Oc2s2C?=
 =?us-ascii?Q?jDbtC7cJe0zkDL08Rn4QsbphuthnODuRzk7zfEelr3gLSXX7kehhbHSXzcZu?=
 =?us-ascii?Q?QrfQKLYgor8xZNWGB6rBLX7nXF3aFSdxPchnuqbqCl3J4i7/JSA4w05BVWoa?=
 =?us-ascii?Q?XOjWduw16M0J9GSjTFlm9xpwzjVaLWlCZeCpLavODJERYAAp3ee1YfXKZI9j?=
 =?us-ascii?Q?WpczziVrr2n7ge+hmndX40dPwn5sWAilOlnwreJazhWFbB1RA8c1a2lug+2o?=
 =?us-ascii?Q?DrS7IxyOoE8aEN73iq8hGhpK4Gh6GzxasVAp29Bfy6usNzg6a2uGPOOdnIGh?=
 =?us-ascii?Q?/DWgYboFQNTLwjnVOG5wwwzFkApbx+RaGqDMXl3dgWvm52JS6e6elMW8SQOh?=
 =?us-ascii?Q?+rTF7d39Ek0IWqpHv6dawB1neKwlCYzMBs8KbZyzRZZ6SH/ZoYad5VkK9sfy?=
 =?us-ascii?Q?7+R+KaLtZJoDzk9yWQJPYGJoyzCODRQlYglyJQ3PjQ7gpcwklOw/7mKqPD1y?=
 =?us-ascii?Q?DIHQevILOnsDgQiIVywB7t3/0PXH4RkzVUXGcgkJdQ2?=
X-Microsoft-Antispam-Message-Info: ukZnQMEpFmNFPcV2kNedHbOdhU5u/lDq4L64XgmLTBljAzRJ7c+qHsdmRAl8HB7+jbYiOtJ53FM72+D4nKMuGd81hWa+vxmGUWI5+8IPQeIPw+yGXDWprvJ51L2+CuDMiDmgRkNgC40tzZSNtcsfd6WEdLmIyg3EhXyMUrp4YNTg5smiCFC1z7y2wV5/UP733061Z6UvMe4UUpgbx4NFEqjp0qPoz7cLIFmPKI1LVID3cNl9EQgGUMTYP93kjFXUsZVQdLchAp6tWzFLyi5NhBVvs2dI0d8TQBc+qCuTOIpLI+hgiRmAhCCfGzGHCxsi1deih/v9End2+kTuAtSpxpba2MfKgaIhIbd2NgTsZ6s=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:TEJYzu25HUS3qmX1ORoiRsYQzsFeG2BegeIhEqJM/GpVKimbHfRHMAI/rE8hBqeBs7kQhxU0XXZCD3NtUtAAVMRepCUqsRWSehUzD8YS71dfJcijAU6am+feMSppg1W2Gsaj2X0tYU+BUP56TiuQ2kPIUTY2ubS9/4Fso7j/GP5z2G1b51PNbsVDuOdioL2mxlcDFezSKv+0Sxayh5g0p1K/xTEpwMsprfrbei+O/Lzj0BWO093NQCWhT3NvXd4QnsASREikDC8BV1AcnYmpT6G2wqxkaLsHP8kmBOe7VIftT/eEsXttxCEGrYp44Bew7OfgqVMKuRyUaOFCmZRHGgWF06VonKiE3rK/CJHtjS4RaXZ22MsU4WckpX/WNS8WbhrQRGnpHmOXHXhKZ/eavOrH6mvNRFckwTAMYeK/t6IVLeUq8qW0uN1WVeyMoFnIYnpfSueh+tly9Lo34mILiw==;5:kCMqCH1fKWDHtEP2fM+FrANZCxdEfQY0kmeYzgrivb4CrKMcbDgftOs0yKwE96v6PbDHgFTEfsyoX88chGb/69t3WOOdIIfnPZVyX5zKGez8m8wjSF+F9++8RzzoEwzGEgY3wF04Z0VYs3IxYLHASHIsyB8m6EB9MUsL5nBKOyA=;24:a4yhjNTa3vpR96xvBzv/pj6bIQAvy9LRtNIiEcSUU8+CufUX0QxDS6OCyn4Wg7aMSW+BPb1yPSrNTTWfG4kx3t11LybABRLbQbaGQ4EVmFg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:LHo4V4EvFSCOUNi2eLHsqjj9+oE0rv17j0MKESUcMZ1yxhCGj1TZWXVpIYsNfC6Dtipoq+UNDx0v19+y5efj+KE3FgKVw/X8FHBk+vlfAqC8JjHHvH0wd/E8iyNbzNpe1cAHvr9PsnuDZa0GxcDbodKIW3Ht4Lf7LJI8KtjRgGFtHm8/Qm4hxcVOvl4V3elK2MELKNkOSfQHll6xOIKspj51ioUS0l1BMiWxaOFn+I7saMIl2Bl/D73AYg5SUjkp;20:PbU0hFEVNeJHWZ16YOgemIXJSg+oWlvd4taqpf9VxaNMP/F9awnO5ALBZoT7eZT+D6gDyWqcRA+D73ur9vUGEA+iVafo7JTOoumdCYM0FpbZRwv8WiyElumRlSliQ5c65oVm6hRfS1TmYm1ooMiql0V9SYs23BUFe8hBoOb0/CI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:09.2488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e1a656-5a07-47ad-fe77-08d5e2b92d35
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

This commit introduces BPF_MAP_TYPE_CGROUP_STORAGE maps:
a special type of maps which are implementing the cgroup storage.

From the userspace point of view it's almost a generic
hash map with the (cgroup inode id, attachment type) pair
used as a key.

The only difference is that some operations are restricted:
  1) a user can't create new entries,
  2) a user can't remove existing entries.

The lookup from userspace is o(log(n)).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  38 +++++
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   3 +
 include/uapi/linux/bpf.h   |   6 +
 kernel/bpf/Makefile        |   1 +
 kernel/bpf/local_storage.c | 367 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c      |  12 ++
 7 files changed, 428 insertions(+)
 create mode 100644 kernel/bpf/local_storage.c

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 79795c5fa7c3..6b0e7bd4b154 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -3,19 +3,39 @@
 #define _BPF_CGROUP_H
 
 #include <linux/jump_label.h>
+#include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
 struct sock;
 struct sockaddr;
 struct cgroup;
 struct sk_buff;
+struct bpf_map;
+struct bpf_prog;
 struct bpf_sock_ops_kern;
+struct bpf_cgroup_storage;
 
 #ifdef CONFIG_CGROUP_BPF
 
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+struct bpf_cgroup_storage_map;
+
+struct bpf_storage_buffer {
+	struct rcu_head rcu;
+	char data[0];
+};
+
+struct bpf_cgroup_storage {
+	struct bpf_storage_buffer *buf;
+	struct bpf_cgroup_storage_map *map;
+	struct bpf_cgroup_storage_key key;
+	struct list_head list;
+	struct rb_node node;
+	struct rcu_head rcu;
+};
+
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
@@ -76,6 +96,15 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type);
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -220,6 +249,15 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
+					    struct bpf_map *map) { return 0; }
+static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
+					      struct bpf_map *map) {}
+static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
+	struct bpf_prog *prog) { return 0; }
+static inline void bpf_cgroup_storage_free(
+	struct bpf_cgroup_storage *storage) {}
+
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3d1933707374..1205e81871d9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -281,6 +281,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
+	struct bpf_map *cgroup_storage;
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c5700c2d5549..add08be53b6f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -37,6 +37,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
 #ifdef CONFIG_CGROUPS
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #endif
+#ifdef CONFIG_CGROUP_BPF
+BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+#endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_LRU_HASH, htab_lru_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b7db3261c62d..6f9b907a8a0e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -75,6 +75,11 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+struct bpf_cgroup_storage_key {
+	__u64	cgroup_inode_id;	/* cgroup inode id */
+	__u32	attach_type;		/* program attach type */
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -120,6 +125,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f27f5496d6fe..e8906cbad81f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -3,6 +3,7 @@ obj-y := core.o
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
 ifeq ($(CONFIG_NET),y)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
new file mode 100644
index 000000000000..940889eda2c7
--- /dev/null
+++ b/kernel/bpf/local_storage.c
@@ -0,0 +1,367 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf-cgroup.h>
+#include <linux/bpf.h>
+#include <linux/bug.h>
+#include <linux/filter.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_CGROUP_BPF
+
+struct bpf_cgroup_storage_map {
+	struct bpf_map map;
+	struct bpf_prog *prog;
+
+	spinlock_t lock;
+	struct rb_root root;
+	struct list_head list;
+};
+
+static struct bpf_cgroup_storage_map *map_to_storage(struct bpf_map *map)
+{
+	return container_of(map, struct bpf_cgroup_storage_map, map);
+}
+
+static int bpf_cgroup_storage_key_cmp(
+	const struct bpf_cgroup_storage_key *key1,
+	const struct bpf_cgroup_storage_key *key2)
+{
+	if (key1->cgroup_inode_id < key2->cgroup_inode_id)
+		return -1;
+	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
+		return 1;
+	else if (key1->attach_type < key2->attach_type)
+		return -1;
+	else if (key1->attach_type > key2->attach_type)
+		return 1;
+	return 0;
+}
+
+static struct bpf_cgroup_storage *cgroup_storage_lookup(
+	struct bpf_cgroup_storage_map *map, struct bpf_cgroup_storage_key *key,
+	bool locked)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node *node;
+
+	/*
+	 * This lock protects rbtree and list of storage entries,
+	 * which are used from the syscall context only.
+	 * So, simple spin_lock()/unlock() is fine here.
+	 */
+	if (!locked)
+		spin_lock(&map->lock);
+
+	node = root->rb_node;
+	while (node) {
+		struct bpf_cgroup_storage *storage;
+
+		storage = container_of(node, struct bpf_cgroup_storage, node);
+
+		switch (bpf_cgroup_storage_key_cmp(key, &storage->key)) {
+		case -1:
+			node = node->rb_left;
+			break;
+		case 1:
+			node = node->rb_right;
+			break;
+		default:
+			if (!locked)
+				spin_unlock(&map->lock);
+			return storage;
+		}
+	}
+
+	if (!locked)
+		spin_unlock(&map->lock);
+
+	return NULL;
+}
+
+static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
+				 struct bpf_cgroup_storage *storage)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+	while (*new) {
+		struct bpf_cgroup_storage *this;
+
+		this = container_of(*new, struct bpf_cgroup_storage, node);
+
+		parent = *new;
+		switch (bpf_cgroup_storage_key_cmp(&storage->key, &this->key)) {
+		case -1:
+			new = &((*new)->rb_left);
+			break;
+		case 1:
+			new = &((*new)->rb_right);
+			break;
+		default:
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&storage->node, parent, new);
+	rb_insert_color(&storage->node, root);
+
+	return 0;
+}
+
+static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage)
+		return NULL;
+
+	return &READ_ONCE(storage->buf)->data[0];
+}
+
+static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
+				      void *value, u64 flags)
+{
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	struct bpf_storage_buffer *new;
+
+	if (flags & BPF_NOEXIST)
+		return -EINVAL;
+
+	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
+					key, false);
+	if (!storage)
+		return -ENOENT;
+
+	new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+			   map->value_size, __GFP_ZERO | GFP_USER,
+			   map->numa_node);
+	if (!new)
+		return -ENOMEM;
+
+	memcpy(&new->data[0], value, map->value_size);
+
+	new = xchg(&storage->buf, new);
+	kfree_rcu(new, rcu);
+
+	return 0;
+}
+
+static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
+				       void *_next_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage_key *next = _next_key;
+	struct bpf_cgroup_storage *storage;
+
+	spin_lock(&map->lock);
+
+	if (list_empty(&map->list))
+		goto enoent;
+
+	if (key) {
+		storage = cgroup_storage_lookup(map, key, true);
+		if (!storage)
+			goto enoent;
+
+		storage = list_next_entry(storage, list);
+		if (!storage)
+			goto enoent;
+	} else {
+		storage = list_first_entry(&map->list,
+					 struct bpf_cgroup_storage, list);
+	}
+
+	spin_unlock(&map->lock);
+	next->attach_type = storage->key.attach_type;
+	next->cgroup_inode_id = storage->key.cgroup_inode_id;
+	return 0;
+
+enoent:
+	spin_unlock(&map->lock);
+	return -ENOENT;
+}
+
+static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
+{
+	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_cgroup_storage_map *map;
+
+	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
+		return ERR_PTR(-EINVAL);
+
+	if (attr->value_size > PAGE_SIZE)
+		return ERR_PTR(-E2BIG);
+
+	map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
+			   __GFP_ZERO | GFP_USER, numa_node);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	map->map.pages = round_up(sizeof(struct bpf_cgroup_storage_map),
+				  PAGE_SIZE) >> PAGE_SHIFT;
+
+	/* copy mandatory map attributes */
+	bpf_map_init_from_attr(&map->map, attr);
+
+	spin_lock_init(&map->lock);
+	map->root = RB_ROOT;
+	INIT_LIST_HEAD(&map->list);
+
+	return &map->map;
+}
+
+static void cgroup_storage_map_free(struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	WARN_ON(!RB_EMPTY_ROOT(&map->root));
+	WARN_ON(!list_empty(&map->list));
+
+	kfree(map);
+}
+
+static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EINVAL;
+}
+
+const struct bpf_map_ops cgroup_storage_map_ops = {
+	.map_alloc = cgroup_storage_map_alloc,
+	.map_free = cgroup_storage_map_free,
+	.map_get_next_key = cgroup_storage_get_next_key,
+	.map_lookup_elem = cgroup_storage_lookup_elem,
+	.map_update_elem = cgroup_storage_update_elem,
+	.map_delete_elem = cgroup_storage_delete_elem,
+};
+
+/*
+ * Called by the verifier. bpf_verifier_lock must be locked.
+ */
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	if (map->prog && map->prog != prog)
+		return -EBUSY;
+	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+		return -EBUSY;
+
+	map->prog = prog;
+	prog->aux->cgroup_storage = _map;
+
+	return 0;
+}
+
+/*
+ * Called by the verifier. bpf_verifier_lock must be locked.
+ */
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	if (map->prog == prog) {
+		WARN_ON(prog->aux->cgroup_storage != _map);
+		map->prog = NULL;
+	}
+}
+
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+{
+	struct bpf_cgroup_storage *storage;
+	struct bpf_map *map;
+	u32 pages;
+
+	map = prog->aux->cgroup_storage;
+	if (!map)
+		return NULL;
+
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	if (bpf_map_charge_memlock(map, pages))
+		return ERR_PTR(-EPERM);
+
+	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
+			       __GFP_ZERO | GFP_USER, map->numa_node);
+	if (!storage) {
+		bpf_map_uncharge_memlock(map, pages);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+				    map->value_size, __GFP_ZERO | GFP_USER,
+				    map->numa_node);
+	if (!storage->buf) {
+		bpf_map_uncharge_memlock(map, pages);
+		kfree(storage);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->map = (struct bpf_cgroup_storage_map *)map;
+
+	return storage;
+}
+
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
+{
+	u32 pages;
+	struct bpf_map *map;
+
+	if (!storage)
+		return;
+
+	map = &storage->map->map;
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	bpf_map_uncharge_memlock(map, pages);
+
+	kfree_rcu(storage->buf, rcu);
+	kfree_rcu(storage, rcu);
+}
+
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type)
+{
+	struct bpf_cgroup_storage_map *map;
+
+	if (!storage)
+		return;
+
+	storage->key.attach_type = type;
+	storage->key.cgroup_inode_id = cgroup->kn->id.id;
+
+	map = storage->map;
+
+	spin_lock(&map->lock);
+	WARN_ON(cgroup_storage_insert(map, storage));
+	list_add(&storage->list, &map->list);
+	spin_unlock(&map->lock);
+}
+
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_cgroup_storage_map *map;
+	struct rb_root *root;
+
+	if (!storage)
+		return;
+
+	map = storage->map;
+
+	spin_lock(&map->lock);
+	root = &map->root;
+	rb_erase(&storage->node, root);
+
+	list_del(&storage->list);
+	spin_unlock(&map->lock);
+}
+
+#endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e2bf834f13a..de097a642c3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5140,6 +5140,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
+			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			    bpf_cgroup_storage_assign(env->prog, map)) {
+				verbose(env,
+					"only one cgroup storage is allowed\n");
+				fdput(f);
+				return -EBUSY;
+			}
+
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
 			 * will be used by the valid program until it's unloaded
@@ -5148,6 +5156,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			map = bpf_map_inc(map, false);
 			if (IS_ERR(map)) {
 				fdput(f);
+				if (map->map_type ==
+				    BPF_MAP_TYPE_CGROUP_STORAGE)
+					bpf_cgroup_storage_release(env->prog,
+								   map);
 				return PTR_ERR(map);
 			}
 			env->used_maps[env->used_map_cnt++] = map;
-- 
2.14.4

