Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F02C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273C821571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GNnbjhcm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Kw0U5Rxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273C821571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeHBXV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59162 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732116AbeHBXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUf012185;
        Thu, 2 Aug 2018 14:28:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=2f2oZ5nTFhXCCxmD98z07ydS7myVbDZ2bdmu5+ktmlM=;
 b=GNnbjhcmT+v8UeY2Kny7RJDr6nYm+4TovMCnyxujA46pK5kK7QS29T7ELDiuAUvb2QN1
 VpluBOiPOomQ+bi4Tfjrp9QlhcpkNyE2egsz+DLy4gytm4IRP+YRnViAd1ZaRvllaH+H
 f5Idg5PXJCANWPoLXaLhvHmrpnJZ7RproIk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:07 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f2oZ5nTFhXCCxmD98z07ydS7myVbDZ2bdmu5+ktmlM=;
 b=Kw0U5RxaNPqaqQhMTSSiudcrhsfMkinBShFvT4HbEHKFr98s49L01X4SqX1vJkMX5c4Z7q8OkhzRSTH8GYrDuYS52mcTq56N8mgh9kTFqcmh9+VDDWz/6Kzu28DjhImqm4UKb1CcCLbkmaGeiUEJnWcQLcd0dx8V8tWaGYxQhic=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:27:59 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 06/14] bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
Date:   Thu, 2 Aug 2018 14:27:22 -0700
Message-ID: <20180802212730.18579-7-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a96e1209-e30f-4420-75c9-08d5f8bed242
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:CwYIRbp+kyEDKZEO/BAgVDORvTrGh/Hs4GP31GsWgk0a24bkrJfWvvCuqfLlRzSXgyWd5uhNTOxrN8f/a3yphDLe5+F0ck8sRhkyrTXV8yuvCehwEBVIRy7yr43tkokJMplScTafx5PwOtV+UIYNS/HZeu920K5CDAFrYQB7jxDCQLW+XCwNh3n9SPhgIHdCukWbhVlnmIuPN9GfeN6Krm3LCZ9/Xj39vzLl4UJVHzvI6QCTcVIR4L7W5SrYmY9/;25:04pQUIAvAhdfbMVDDtTvnVXadcYxp10yioslnzXOV7f4fCLzt9Kju4MCf6dvX/ZIsuzULkpaHY+GFMQOW3/Aj6/G15vP9HDxtkpTTd3U0OcOsco5p+KpCY5kMmX4vlKbT/ToBi+8o8ePgA+Rv6GiX9gZ7p2zZ5rT10PeJR2XlUaZiKqBNFTDrByvFQKz9hytMgH4oZkXLWDnPTS2y2vfzzdZGlLR3XLMZSfSNbFTHZL++9AT2FdBF3dYv9ntTKh5wpCSzS0iYy8zBCl5WH60H7o16VbR2iGbfjr3bq3e2uGticY17X15eaKyPwkqZyTLBT0mCJlqza1ldBRAPFAtkw==;31:OBltxzHTr6XJQ2nS5ciZJkkxq8B5GwCPYxaN7F2Iu0yeORf9+LqQcLbH+kuJ3OGqVFfnivBUGo/ETuuP7rCuVKODmOIy/pv2MgU7CyBCJBhloUhhi0MQdUwVDQxvKE8yrjSMwjxDUF60ONrVhxrGYABMzQswbEDJsNk0AbrixzOpnhh1BBaHi3ZL/OsTURPNef9whxKukDzAovvji15xHdzSDwPlZrPkCj3tC/UXU6E=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:vi/i+pSwsLW758vwAS9HAetP2ACOLrGKhlO3x+hAXKcmtxwDio7nqV5cyAocAfZika/yynToUwra4xLna809B3CHRYsjAbau0Gq2mdP/94mmr5gkc6sw3GJRmGvZCeUdlXLKOD6qhbIGupM6cQ+ANsr9ghR5a68Mp76qiqNkwmD50e3d+jJ1/9+y7iXwlQYZbJwqMdeJ1P7ZdpXLQ5CIcWZ+aLYtFXFvKCS9zgu5Rx+AyGMD2GiHS87IQYAblyRolIe6VbBHhk1wvlrL3RXITEAkFDD1tfAoSGDRnNDiiZf2OylsbP1hcvKJxSWNwpA0nhXre/kuXUOySOjzPv6sjraqMGswNy9eZLiH9ePSkoSMBoFHaAE5yhxXR/VM8pcb4lX3LW1C9kkRZt0kKuuAfVA7QABzqDYbSmx9q58qUPYwSaO2K/dVtz0m+DDRxlXUztez9L7i3dQEps5+j+LMnQqDkAfrl0R3chflWuoDRQmybSP868YRdSC53IOmj7bt;4:iFp4TDpNWhuGDbqP1t4u6MYIhUy0HHnzsjNPbERz2Z9EUnJRPJK35aJfJv+ZpqwGowQS79vsmG95kAQq6It3epcXde+6338Tqu8D6P2XFDFppXrWz/TXopaTfgil4IFLfNY2pvfjMMQNmdN79SAQ0CRE5U92reEV6sTLhzWt/Mr31Mi7VcuOwMPMmC1I+a9WAwE8U/OFwzsb9mpbWf5umABQXPjlgrBnBZRvmrZ27DV/BelbI+FxJbbTbhm7MdNEWAub7FBQDbmWYFX4fs0Er8h9rKnPrI6Y7LPCRAqP+Hh0Mlq/bvnOvYcu7fmQtAJB
X-Microsoft-Antispam-PRVS: <BY2PR15MB016715CAFA9BAB3545B8B349BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:pO3yXLksHKO8Kk/vTRq1t7wVBSPrVyp+nS0AV8XY2?=
 =?us-ascii?Q?SR173Ll0wLKiUgfyOE7nWlcl58huYXI7bLod7FD0MBn0njA2FXkfFd8Gypax?=
 =?us-ascii?Q?w+BKOqpP60nRqChsR0w3lolL6Ciqy/vIdsmL65GR/VjcGLVTcmf6kyZnV9/G?=
 =?us-ascii?Q?penQoJGDjup7CTCWn2qESNUpF/muEIYvd3aPKjwv/oQX6zkPK9WOi3d1YnbD?=
 =?us-ascii?Q?FATB2gNfKy9w/GE8L12mgJAZsx7pyOgRs0L/R7Ca1Ps8kgZQ7EPXtydumlJq?=
 =?us-ascii?Q?kT81HUV9AcN7KK+VERWPX9T7FELhXn6uVip+ETMF8/4rh4ujK0eSARHcgrYD?=
 =?us-ascii?Q?bnfGKZo1NjIDBZFSGqeddazIXiYeNaotR/joTdUbL5hK61VH9igB9yZe6L8m?=
 =?us-ascii?Q?p9AJK9rfHjT8dwLU/kCWCHuFUztjpAYc5Ytt6R8XF7ru/3pTCihsu8LUNRZ9?=
 =?us-ascii?Q?iPXihZdSS85HC7fK0u0O/ID+ZVp/OioEgvHe0ngSw4tjmXPl1MQvQssw6FXa?=
 =?us-ascii?Q?Kx5bsfJDmoKYjRZMaKiT234AsdNFkYjhwfcOjldLcJK+Ng9S9pdjSAmiQ14V?=
 =?us-ascii?Q?ysDapABoaCmbLdXDYD6vcAWpiV1Bax4eBRHe+yratK7D5hdZZR5mrVKik1aZ?=
 =?us-ascii?Q?qbs8qf/ba2OZHqGw4+XzR7AsC5Eud+qu6ahAPpQujfQsv7ArOkooGfRKQdcj?=
 =?us-ascii?Q?tZ2AyXZlkRr+zwHmtWpcZeIRLBxfIoK4Q/IcPD5NNF83qsvCKkb3Lkg8R3DO?=
 =?us-ascii?Q?sbJCQytUYj5dK+rgfxkS3ml/3aZNtXkQ9xWSMu+YWnl6VhL7o9mrhlDS+UwV?=
 =?us-ascii?Q?3xWNJ8Pt0A6GFbZpzfJL7bD+EkG600zRKlwP05/DWhsbyZGCYHL4xBhdnfDt?=
 =?us-ascii?Q?3Sase/YzIDdQ8knYE5PbVKMLSm+T7sT2wEDhR20w/SPBBmSiLrWfEUbb1ppb?=
 =?us-ascii?Q?5jUAdfgS2ZubWkroJuWTTJOmVhxkUKIN2yZfzcJPaC7MdnxtgdhEcGqTJk2j?=
 =?us-ascii?Q?cjAVAZl50I4zFoh0fYI+Qq+cCtXvOOphiW2tGxDzAaoq+tSVGh+aq6g1yKlr?=
 =?us-ascii?Q?sCWnHGDmYj2GcrDs4uR8BV45BDXLqwXbKlVcWCFK1o+ssBnDE5RTyt8SoLaR?=
 =?us-ascii?Q?qOSwF6v6wYtkItb4p+q5vEl4N/buj1/f6JC8mSJCS+IxOp13+gLyKuIlfOn2?=
 =?us-ascii?Q?m+toJbHl7JTJdyLnDvPzsr7l2P/UxnNjTK/G7sLPw2Yo0Dr4Uh4McN10kB1V?=
 =?us-ascii?Q?b3qMgCtolqOAib/S1//cT+UVDc/8CFvj8apGlT/3ythiQsxbo21SmV+/haO/?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: TwEdQ/X7UgyDgdRbta8wO+Mb8S8EqSiahs6dQQhDqHqbF/8SOlB/2tK833XVnRhjer/sgaqCVzn1XwOTohRF3omSRfbfxW+hpx9JG/7WLBMFaSHGdbq/zRpkKoCf/mMSF7L/olS8bVpI5Ri1DeOyXFMC34W5IHXV0fGqQLFIVf587ygz0Z5h6kaxrIJBaU8DBHb564x6XAwomYn3UtrQh9kVgpYm/jq2fsfBihFlSxpi0xy7HYFJyNky74/YuqBJeIRmS9Ue927kni82KgVnLV1tVeFWHrXab1e6e0JqgP77gG5y+Jc2YQjBke8Nv0+GXbHrP2INdYZ3JBdjkTgHw7yLVCx5/KqYn5ivTRofj4U=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:CMfKwx/97BaTXEHuzv+3jEcXQVU89k5SfOqzWeyi6lmaBgteeXp5kUX9iUu7vpTeoZa2IDgSKwj2H4xl8UKj+vCyQo43bXa7jV1e7/aHDRdm/keMpexTIeY1ksjG+peymhebUYyGgDTF4i9iZhdvpGrVwkdsh8b3K24b62LycCqpPY3f+h6mfAjT4vCkoHv++wcNIjCQsxFC0td8jbCckxww4AOv2dQdfBX2ATHIn9Mv3jjLS4XP2L5NczmNAmGqS5Ab4Q0MyQCAp/a5XyTxIhK8yScnIeSSdYiQcVGphK+1aTMwdf0dr9UXZ9HOzQRTNczU0I+QH/784TQvWj+GsFJc9pgZeyuDcI5XeMD/gy/AMCmqP55q/vKUHe3Lv9bMHie4Sngi/+EHuElUgx71SplCs7/LgJcxbRzmNfVASGPZPGqvhIyGkhByJjmxlyhDkPAUawPVnovvN3PNRqwKiw==;5:2BmrzMKPkPggoiPPI0znOPCi6MT2ntWQUZ52kJUjok2b6GMIPDzChEwznUW6/4m6ryf1oAkkQx+QGzfRUJgXIM47GztkDp5kb7FkWmhZkCnU8vsZ5IwoFJLt6mU3lP6d2ZRX5Fa3XWyRX2vqkxYyILne3tzZ5/giGnTRvCGLPC8=;7:gfVzyKPLktxLu1IZqaQTUO0uqDAfZEPicAG6G0+fQnZZjRSID+e8EUzfqCYmpwnb4g9Dd7dNHw06IfxMSKe7x7PhmR8WzZWjU3Z0pLIskTS+EqFwnP/JZsOb1/JlOWQjisJMArI+Phsuy7lUAb1AE248HC1rl6o1NFk9D7QnCC5E8RCrNQgPJ0p+/ziFFihTZKQQ8haWE764I7JWQO3yhfajAvU8y8iWLRzBBmrUNP18k/yzzonta608Ho9Yy/6k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:7Bs5+Jnj+4IBet4eqfHVcOVvZ/jfbeyglShbXm3w4Deb0/xXKHVcVieWhuWbHDUJOLiriikWUDR8XWbtgEEJea7A3JHJUlodbm7L9S73K4bAm7/2gne5aovDBUapGs305UyG1SfnS8gNmBLimVNtclq8M8rXC4wBBjTLaXNDB6o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:27:59.0842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96e1209-e30f-4420-75c9-08d5f8bed242
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF_MAP_TYPE_CGROUP_STORAGE maps are special in a way
that the access from the bpf program side is lookup-free.
That means the result is guaranteed to be a valid
pointer to the cgroup storage; no NULL-check is required.

This patch introduces BPF_PTR_TO_MAP_VALUE return type,
which is required to cause the verifier accept programs,
which are not checking the map value pointer for being NULL.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 16be67888c30..ca4ac2a39def 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -155,6 +155,7 @@ enum bpf_arg_type {
 enum bpf_return_type {
 	RET_INTEGER,			/* function returns integer */
 	RET_VOID,			/* function doesn't return anything */
+	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7e75434a9e54..1ede16c8bb40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2545,8 +2545,12 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		mark_reg_unknown(env, regs, BPF_REG_0);
 	} else if (fn->ret_type == RET_VOID) {
 		regs[BPF_REG_0].type = NOT_INIT;
-	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL) {
-		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
+	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
+		   fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+		if (fn->ret_type == RET_PTR_TO_MAP_VALUE)
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
+		else
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].off = 0;
-- 
2.14.4

