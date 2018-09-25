Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04675C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928F020843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VmO6fRnc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eF8aW9b1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928F020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeIYVaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729763AbeIYVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:08 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFI79t002960;
        Tue, 25 Sep 2018 08:21:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=07g5uhRWPju28W36T3gUmBYd6AqW7bvW6zaiB1iHD/U=;
 b=VmO6fRncFumWJNlhLp8dRPywnvQWD5GM3N2f3YGmXERbG7YLMlj0GGhYuOeIV1nI9jb1
 v0LkNyvcDkS1i8aXMNrwAi8C/QAWwgM+P6U3SizdcFKvgvgCZVSSzlInLFC7y2f5ZI97
 WVHd7FjFcYaG4RZFs1se4end+fZ+YVz/stc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqn800gqx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:50 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 08:21:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07g5uhRWPju28W36T3gUmBYd6AqW7bvW6zaiB1iHD/U=;
 b=eF8aW9b1D0WrqeGGudaPfIg+fmmNxONlAxVIewo8s2+DruL3DuXsUB8QjYMQJuYAfFWsL5DPzODngQvgqd3SetEiBgYijlGm+KbrYL75ZX+whO+jpYilDk48tc1GaAxcbvAjw/H8EAQqMBObrikt6eAAIAujZMybxAsIjF+8+KA=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:45 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 09/10] samples/bpf: extend test_cgrp2_attach2 test to use per-cpu cgroup storage
Date:   Tue, 25 Sep 2018 16:21:13 +0100
Message-ID: <20180925152114.13537-10-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd6f8f92-e738-4584-b074-08d622fa9b7b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:mQ/jp2ngsGxlIpMqvSpSEeGHAaQlFwfoqsKaaJfA+2AASKmfuyHt8s4Km1+Ip65/3ZYOglCGGexw0+1+VMjOe9zQUdVrdZwPuLbZ6Sk7FzcoPNfiDkw/qTmAL+Nthd463opP/ZswgvJt63TMJtxEG39iNTqXBq2QNwmQd6kbU4pz8extYsZOGRKSQcO8dxG2GVV+/Ij7LAP5msAtd/v22YoUIrbeaZTGJKCrQKePkXHHnUYA8gNpmZm0rLaH0eaK;25:IV7NGW4WFzU+vNw4JFIsAMD3bD6xHFx6/ef1hTXoG+oZm15aZnGUdVl/RXNp/USZ95xtNlnRZ/sRVpkvVRH1CV/lBJb4jnMwcZBzJMl2Nw/uBBUKqZx7QgROKZ0LFmP9XvpMX351Bq+4EVH4An4bW/+cAaiDbklrmoiD099AkdbSoxsQ43d0YdMJIxX5rhcnz+h1mx2LBhv7/dLzvPFOIzvMfREUge9piLyDmbJihY7FuWB8DEQ0/TQdpBB3NtOQP81DovCHEtwjh0G1A8W+2gwlO/XbM+gBRUNkU5Ia26xJ8ZlpxUOS3nPDteiTogEOcRbV8SNmncsqL8cGlPoDeQ==;31:TGJG4Te3aRJ/jRilDh8+Hwq+2p+uiqIaTTP9qoudSaV3I8SVmsc4auQLisCpXb9aHRUxGH5dcUmcrNbuLc7XyghxzRDXJSyK1QpG5/SPDfY6+PL0WsoCPH74isQK3s3WH6uISBlfrjmLjuMkJA1b04LUTxW+LDeeU9/DkkPXqwQSaURWoBpdHEs9JawZH9Z/VEAVqAfhrOrptWgFDwRUK+cM+ulYJpLocIqn4ESqnzM=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:qqLJLAsagB/YrFL79WQH0+gG4z6jOh9rBt7kY9mFUposlivxnXTfySSlO3NarlktqKPz+YRnA1JH3gXUCWS+Ou81daMCpWP4pz2JumwJ4LQI1e7/McGgssVoTIAdvk1dKGDPrUA3cc8BgHedQ2i4f1Ru6qLFGNq17D2in8e6+5Sra7dIHK4t7X66E0Ex3S9MBQ+sVKiSaHJFmoBVkacZKSO50SoA3guHHGWqlOZd9C6f7asaHz/mxrzLNwugDr8cT5GCCffEMO8rne5NEqvoTYcu3oENN9/MAGoVvS9fxBsmlGP0WBFg10WJld2F0//Lq2GhJMf49ef+bc3uhQm2HpK57ErGFkp2uFYsOAZ4U3xFhm1XVHEnGLAoY/2As/gSYdw28X5O6uvY98H1UOgK0oox/vuPbgzK6SdosD7XZuXP/6Bwfcc8kpun124N3eE6jXAkMt/14iKlLUbs0Ne2jaVAp4dFZEViedIwUska5/eVOqd1tm1x+NnNFRvwWHSp;4:UaUSn+pde1RgMNfkM0gTCliatwAaB6FS7UABFP9J/zZLGx3DZdyDRHiX+r3EDp8a+RGtJmhJt8UL26WKV8urnJWl2kmQBkW2TE/J+h/LySYWRlStB5comu/ukmxH82pJkfAVGq1wuHo4YAfIQ9o15Qagm0MWiJESSOxyxoiHJ6CC1MH9wAy1cQk52GYGEIGqHfjAzxJ/Zq8Ss7WV0JuR703uDUFjn5GZ6eaU55w15V3B4n/qGeUZQqmfCa9t9fDwqqL7URRVgjuhxq1cXQY0LDUo3PdUko2qd4GpPeu287bvTTuoF/4Wflk+RMdvZxlp
X-Microsoft-Antispam-PRVS: <BLUPR15MB0163D76A171AB8B468566958BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(15760500003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(5024004)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:xfUor+bf2/R//ES9DGMt5It3dN0XeUqcwsfNeWazq?=
 =?us-ascii?Q?NFPbTnoNqIy+SivDXJIg4dsS05XMZNv+sqBQK5aGxbUfSVWQRtZsg8p/NeEC?=
 =?us-ascii?Q?wkZ3k/FEmm+bzI1NTDXhx38Ejp12U6ZSo1+2iEr1w8A0qz549jpJ7l4By8Tb?=
 =?us-ascii?Q?imcgOSkOtcWgxGr6aJ1azmIGOrlbuAEX2/U3Bqh2ooYDhOpqR9Nvmr8S2XOT?=
 =?us-ascii?Q?3Spr6ykdGbLQ5J7j3sF5YQSmKg1c5Gv/nE/X17jazoH7Sn8UpkjU7GDkEsxg?=
 =?us-ascii?Q?lnTmdJH9uZ93hkCi1OLp66blsph8OVxzy1msxy7Rb6D4lRaUCPv78QGbsotc?=
 =?us-ascii?Q?Z4ZJEVkufShFsmPO7VTQEVKLSzbImwjr/IqNLYaVFPFvagFVzBqL/76AKNm2?=
 =?us-ascii?Q?QfXXPTb2LSBbb9KtP+h3ZpesdRXvq+lS6cmJML7+y3h1eLuswznlWffHxuXG?=
 =?us-ascii?Q?lxEkHv6HQfq4n1ncQioVK0aHafFZMz3vWxPpHAC105vNtVwBh2Yg7IUoSYGJ?=
 =?us-ascii?Q?i6/WWPQUGLN5Nr43higbPWwoyTYGxeWEPBFF/bbEXu1G4gwVhFJZn79UjJDN?=
 =?us-ascii?Q?F5oVNjI5LjDXV9IO2+6rultCF7RqGOk5YHiwKV5i7xrxbnhvMt+08WSJnbKY?=
 =?us-ascii?Q?nU5c0B428fWYfB3r3hRHWXsxdw7hymb+TnrSkT7SvCYs8X8ncdHAsR9FH9Tg?=
 =?us-ascii?Q?PDxx1LqqtjwRupDEtANZSt4JJ8jf8Qb2mpF3F3w+0ynaa2mCI+C8XJJeHSu6?=
 =?us-ascii?Q?KBrzwsL7PFGuelOIaTDjU08M4fP5aCSiVDjDf/OnKXv7RESl6+r/TV08bWqU?=
 =?us-ascii?Q?jKyi0nYGrBvdfkBorpX7lyXD57RKKuYrzBKUMdWgVZr0TJFiw6qJ1Z9qSGKM?=
 =?us-ascii?Q?1zCppVE67fi7hqZRZJiN0kFJ6NmN+gitObFUPXuQ8u6N7xwmf1wH5Z4LbZ47?=
 =?us-ascii?Q?tXUw/36Rbv0P7hG7E6oL5xxsVD01gqvkcdV+JAaIEWTEzhecfu81nYyNZcEi?=
 =?us-ascii?Q?smn4ZxGpZnsPST0oX8UesGXCh2ZrlnMPomGmH0vQ0dFNBbCrVQOkaGLEB9I/?=
 =?us-ascii?Q?CuC6v4l9CWmpJDA8U8CF9+zHN40aNox6SZvEXP4g1sBnNPP616FBxadTzdNz?=
 =?us-ascii?Q?ADnFkpZiFIpxzuTlVVU9wanEBXax8WEPf+l+wB3h3S01AdJLEmMVwjehp0K7?=
 =?us-ascii?Q?hO0d3UhU8sTUSb9+TgKHto0BNlEffX4xyxhbR0w8sToa8N4kRRn90I7ZwZyw?=
 =?us-ascii?Q?wt4wR53s6HnFJmt40vIggOISUIXdkVlCfZqXYzQ4ArOQRQNeWr2D7ODSXocH?=
 =?us-ascii?Q?jvcme/riRFeXSWs9WI6oDuTPKWD5reHZxTHMLsI6LvE3a+f4Iljl3BhNj4C7?=
 =?us-ascii?Q?NawMg=3D=3D?=
X-Microsoft-Antispam-Message-Info: b1C46Pyg0hYRMA6raeEP5oepnzgPJEjvgKu1+6FhDVOxFtv0y3q+R//zEvQM/OgthdV+U/dk8tz3Kv240uqVNGRFWp9l2NyfWK5ILLWf7imlAixDRPLFBemRLY4NX4GaTCy8eINKE9zXvMOuyLkWdjYOWl8GFs4DIrw48M9OCAZClv95H83Cciwk0odVymNfnYe6JnUCU6u0sMDQ8Fnd6GX0kHoRDVSwM7+nq8Yfd4bhq7f0G3Ni/TgiTjs8nqHs5xGCQKn3xAURRQAPwMs8yu94/X3c2UQw+zsTFzEVnW6Z9SsSrC7Zl1LVCRRGFEsSLOPdjxCTQ2mv9o9gzxIIX3218dyL/WXfuyqwdISv3qs=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:7I5sQqLuPHoDH2v44vhQHJl9+zwdCceGunIetUHT2uXLqbuTNlmuN3kUu0c1rGje/kWMTZ4zG5/OFOwGSWcXNwbQl9OaGBTPXwajPeDH+9uM20ChDesPUIY8rPJP4qy1qYeurpxUOfiMui2Rnona0pIKWb+NPQscHzEDWVbU9IyNmuy9WSUtZbc/I8f314RB2cWF6Wh7shBerKZQSWCPUNx3iCtCRNhtQjsyd7DqF/nbloLX+qdcBTkAEIbdZ2wU1PGFJs9VI34D63FNOJpF1+B6uBjCcgdQ3G1T/bF0QIb0P9Kv0bEO4rZbGHy+vifJLRigZY/d91bi6gVYHot8RygdJRyQALz2GfYOwVbLTi//nU6JGnVYo8oKlSkijtciZMBwVFsozuH0Q0shLVW6a5xqVRJ9h04tKPl/JSdvwrBK68Uzqp4CkpEfL3puiK43Pb3/evsiKOgzutXV7bS4yQ==;5:ZCOh9aTYBvsoTqosYylKyIi5OLTvBkoqxSHLn9FqTKLI4GQLazSnjg6roaoPdps6GRCdVKhHFtSWd+YQHuG59OCc6brR/ILk71alTFxg0eYQx2YmD+xz691aQg/kvB3qSrPaeCWsgtm6VU2pOeNeBvqESNFwbwQYHUafB7X4Nfc=;7:vXr7cW0h7cXk+ATPCZUCIPbDMNCvkk8dD6TxFQMojMQdtEn/pJ8K+M25fJ4Pxru1JAzGGtlgqrI2AxuJO3xvT9JMNlSFgG0+rKiwsl43Kd+eSv0Baou4N0BqRxRtJuLOQO7ZmIQyjH0Q6Jhecq6/ASc4gBChesbX187ESr+oOcLvZ1O0NUzhVfFGJY15sFM1at92KhYhQeoq/hiMbOuuj1D1NtMP+hLgkYQmeDHfY1vQTqtmB+E8/HYEnJoD7S3t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:vLJsGUl6jVwd/ehHkBwTR6F9toMUE9qMv24s0pZAekLtYAA5oEErSQ+Zgh/+dbsEpEHbt8AhdEOUzKgZo1l8N7GGnPo3UaJeW7oEShwvKPrNVsEBkDzgcsJPxnfYoP+yc6k7LL5mMcTcoTdfTvA0tJT/OYf95KvyeT+D+oqb6FQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:45.6608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6f8f92-e738-4584-b074-08d622fa9b7b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit extends the test_cgrp2_attach2 test to cover per-cpu
cgroup storage. Bpf program will use shared and per-cpu cgroup
storages simultaneously, so a better coverage of corresponding
core code will be achieved.

Expected output:
  $ ./test_cgrp2_attach2
  Attached DROP prog. This ping in cgroup /foo should fail...
  ping: sendmsg: Operation not permitted
  Attached DROP prog. This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS prog. This ping in cgroup /foo/bar should pass...
  Detached PASS from /foo/bar while DROP is attached to /foo.
  This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS from /foo/bar and detached DROP from /foo.
  This ping in cgroup /foo/bar should pass...
  ### override:PASS
  ### multi:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 samples/bpf/test_cgrp2_attach2.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_attach2.c
index 180f9d813bca..d7b68ef5ba79 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/samples/bpf/test_cgrp2_attach2.c
@@ -209,7 +209,7 @@ static int map_fd = -1;
 
 static int prog_load_cnt(int verdict, int val)
 {
-	int cgroup_storage_fd;
+	int cgroup_storage_fd, percpu_cgroup_storage_fd;
 
 	if (map_fd < 0)
 		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
@@ -225,6 +225,14 @@ static int prog_load_cnt(int verdict, int val)
 		return -1;
 	}
 
+	percpu_cgroup_storage_fd = bpf_create_map(
+		BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+		sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (percpu_cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
 	struct bpf_insn prog[] = {
 		BPF_MOV32_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
@@ -235,11 +243,20 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
+
 		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 		BPF_MOV64_IMM(BPF_REG_1, val),
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
+
+		BPF_LD_MAP_FD(BPF_REG_1, percpu_cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
+		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
+
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
 		BPF_EXIT_INSN(),
 	};
-- 
2.17.1

