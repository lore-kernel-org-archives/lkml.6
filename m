Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F541C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D238A214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h6S17Sb6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RP24/nNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D238A214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeIZRrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:47:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728107AbeIZRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:54 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBQxpn017644;
        Wed, 26 Sep 2018 04:34:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=/w5b3orWvsWy2++OOlSq8pw4gThK+WjZyq2YWkREhGo=;
 b=h6S17Sb6DuSQKSNYh7kPLqtb7jIq6HBJ6zV4iXtE6hkhdzch5MP9NSqEjpITQvzrYFB3
 ilXcdKB4Or4kpYdZObFMRVjnRUp5usaBx+XbgvD5HIQL75B18R0Uqq6QxYKQeD35Hdsz
 19aj8SjCLe4VGcRmziBcBB4isY7CPEJYInc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mqxqpsevd-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:34:03 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w5b3orWvsWy2++OOlSq8pw4gThK+WjZyq2YWkREhGo=;
 b=RP24/nNtUFsSsez+9nmUIXPuWbERG8V5V7YVH7jWMJGv9ReUFCklUmsIv1bhK7624+NWDsbRgGjAW9eUMkvHww7c63i2f/WmaA5jpseEUDmqMZ6cmtPkiReci+LUhhKlV2dGfU/egPVcBVkmvr2XJPxt90EbDRD5l+ApfGlsy0g=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:34:00 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 09/10] samples/bpf: extend test_cgrp2_attach2 test to use per-cpu cgroup storage
Date:   Wed, 26 Sep 2018 12:33:25 +0100
Message-ID: <20180926113326.29069-10-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14754331-c858-4422-b096-08d623a3f4b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:tPHAoJZWd8Fpm42AmGsI0WWNkM0q3OcKskkZUEWss/6SPAkinYXVN+ZRMP3T5HNOPJV0bc8zeLbYXBD/SnLVBLqMSTdBFifpfIm48P9AUZqNFGwUDyM3ksPeG2+/j+KY4p0I/JPnrIEimDQxDlbLmoyFg11HZQGD80AApoQQkE5LSYzNUHRq9c2H2NP4mgJXgUxfQOyBblfDCRpXRI1pexI2fMaLA59L78Q+fOjM+HVj/CHSAzxDxf4fWNXPGWhK;25:VIBOMnrfLf2j0q/Xwrm6eMISTLZ7g4+8WsWP7/PZ40wbTctnUTG//HbYJHYO3t+5ps5tpAVcHHOfJv+yIgpM16GB1OzFbrJGfxXF2QhsAI4yrb2ROh5j+IT4HEIYBggUaULf00WDUzixQG+uF88wUZNOMJnsfR3Ig+8unqmNUb4wsn8lTGIYZwU9IKJyIkBHH8RXAkCy1BRH4p5mdwshvjZ1AXH35F3OVfGfMV8zG7pWcOlGTww2AqoBji7RnhHT/WMYW7AUT7R5qjCUcCft6tgIF58+NWFxwZgV7rnjcdO/BVsxhoadyf8y6iUkhKuFI6U4Fz58g7zfxLXanzNhcba+9vlWZw+cFQFM7GOGKRY=;31:DHN5LncoMmg7k8TrP/Tu6WnZoNbU0aQDwIcMbscacBJdbW76XSlOmxvbuED2naro41duZWu/sPIL3qMW1u57bs3KcnpktBtVY8g8uJIwD1abI8i7F8qlz2IKTlh0bLtS1LENpfudPKsQD2ijjHIkKXKtwcl6F+PTFL/zSDPbcFarWfwCbq2erY51YmHQ6ilTAonvucdgAtRFg5YfjoX2tud+rJP4sazXzLBF3c4bWFI=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:tYjQqz7A2RB79EFUBiFkF2i13t3YzoJkbkoHWrb6Mfjl6vnAjqUqu2fZ/9rQOWedUOti+RRS5lyVLhqmsJDyA73TVxQVEYN0/pR5gTYOfQ5C76Uch+MzOz9+B4zNa2dGzhzO8IG6UYDgUzCVKiu3qg5qldtiutdWrdUcBM66fjDD+ZcZDbda+Atw0oFixKdxrewUolrRbk2IYwgZSvfqqrQYZvvNkyX0MfL5wSR5FlR8Sfe+vUO7Nkh4w3PIoyrQFajil9SLxlAPA5qg8qbfSEmR/js5cgrhNe9xK3OQmvOue69Uu9FgBJqFXP51TSFA7r/3Txa6/Zc1Ijhb7e0famEJBQGxBYcFp9SLUtYJ/j3HSUg3ljhWZrXtC9RbLr2nYP+OCYt0dYhcNACrielr8MS1QJdEqjTuIGYYU/wOQkN0Rg7yh8cWAjFWCfyH7BtAGDX9qC9CoCk4ZDKMst1u6bcvpsVy9VNd585dxlR7tyHImsfAsJW5Z5aw2j6gmD16;4:LoRdiKsqIvN3yiL3wWRf5/axXyZcbWmnu/GPTJ0rs7BKAMJdJzjfMAXyZaqQHyjVYesfstIjKhkfhizFeHp0AoC9Ik26a7K87lTp6wRKJwf42H/Qvip95ApHf1EwZkn9n5fss9bCFZK9wqi8k2VDKNWnKUWhmyXuU8N3OgNtUhbMNGXMl1RR5rDmgG2QnTb9Pe6yf0FNvPOjQxsYOpNh0Eod7fhUfzKJScaIoF2SNav5ZqE+q0lBflJKJPh6/nW5IhV6+Pw5D1R9w44Ew1dyZ+ZdwidgMek9xrTpcSniJMZjnB3ojxFj0lca2OI/qx+0
X-Microsoft-Antispam-PRVS: <BLUPR15MB01624FD15B5F5F23379FCEADBE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(15760500003)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(14444005)(5024004)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:LUtONWgQPRbhS0PcEIuHllLdmLNplSNT9/uHqdBkr?=
 =?us-ascii?Q?yJLxyZjf6BMwX2NwfOoPdB6u768WTOGJhMmxoeYdxtRlL3OHSWQfrPIVaB8W?=
 =?us-ascii?Q?On80lkMZ/1vUmmWMuulQky6CnFw8J0LdMXbCJV9ckz9a/wa8v9RJ7iz8+KhR?=
 =?us-ascii?Q?Ps2Y4A9vlDiZTXWNjJ9pP4kCEjjV2x21IcQ4Ds/P2MAbWDJRykzvy3UV9pLO?=
 =?us-ascii?Q?aeqlm3jhPNAgle6NE9E5O1OTJ1hTzRfZXowfJgy9Nsz+7EpYroPzIMxmkyEz?=
 =?us-ascii?Q?EE5yOBVtTdFhhbh46CbxboYmBhf9mqP38ygW/af5i+KtJRnJ1ExzYn8zq+Mi?=
 =?us-ascii?Q?ctAsKpeoUHRiMgNTpP9sJkPModFNVZzVWwwSCsm369mcJV/7kGXSN1U7IBXY?=
 =?us-ascii?Q?KOtLHUOagVh+S5mbC+u3qGUpJyB/jN1Z7zXUCALKS2vlQYgexcMUmqWtJlpE?=
 =?us-ascii?Q?ajDeti+Gr/CMZtWOKDG0u7dNnCgPgjfO2qzcxYEQgNuGFR4BAizCGI9Y15Fu?=
 =?us-ascii?Q?XoV4uM5VS8YZ3+Vz6+4MwL8+zD/9ajJHPPgnHp5X33J3+x6WvuZRgvmQfUWt?=
 =?us-ascii?Q?yDOHD9E9aqIUyqiTcx7y/M6y9RgXc8vjd7DBYkh8H9FnboKfZVsKuvbNuho3?=
 =?us-ascii?Q?/atsl+I0/LkQpYT2oo8WzLIoz44PPdzHBT3hyO/o9/lqEFmnlMYwk7LHMS8o?=
 =?us-ascii?Q?yjDYMaovMKoo7hBT3k+G2AKv7UKx4zdQU+yoByzGz7/8nsgB07obdx8KPi2U?=
 =?us-ascii?Q?2FL+TR7PrN17eg+Ygb5E1OQBjXR8s71oJulidOdROE7BS64dlJ2cuZpyYjGI?=
 =?us-ascii?Q?bmiLr70LMefCndYntqlRAPl6hra1k6T8O4JgxGT0VYTLOa5HqMhUwGxz2uSJ?=
 =?us-ascii?Q?ZsKvl2PkF0QJ+ppji/jFQ7JZysGJQle+9Uw2ZWLk3/FxQxtAQ8QwExLW6VEC?=
 =?us-ascii?Q?vkLVWGxLnygohCLDdfVDqHF0ytHgnHXtHvGTO+cywJEk56ETlOKHilB8+Ie/?=
 =?us-ascii?Q?CZXfRwxiu3ULeBJAUgxx9z/sCzPLq5YqIMB3GDvCtGxO1jI4jUKw3Sr4Usi4?=
 =?us-ascii?Q?xguu0pH3zOu8rEgx9xusAgJR5qD2Z6W5pp+9r4cbTqE+aKQsChmHXAkAfULK?=
 =?us-ascii?Q?daymYX0g7xq5yUTpHXLXX89+ov4MwDoe9+wC9JcOtOETRmEMLDGaLNuANFH6?=
 =?us-ascii?Q?c51UX8l+UTdNukBYvmctuewW4+Nwr2pVAEC+3b3oItLnXkEELDttV14UJYkn?=
 =?us-ascii?Q?gbp3b8paaaIicxjiUmVWxG/q/0LzLlwrCGT5VR8PFm5UiBK8c/Zm3e6M0rtQ?=
 =?us-ascii?Q?G3rsaWRssvhJhFaeVjkBn0NoNwAIX+fEUCwhKEmNCc4RD+2lx3fTkzMQHPKM?=
 =?us-ascii?Q?3pCoQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Bog4eQTjmyFBCcQjxsy7EqqW37LQTcKBJJLoB0IPscnD9sTvSNKu94grdzCs3LEd67aJhgYBC13QhhlLGa7oda0n1wpItvwlwrT8jVORpLuhQap6H890y7nrFxto8s1f2EJvqyRax3f8PINJcMvlFuQXeDzFZrSAWC7HloKJOX/+4TbiDn7t/A/ooY60A4AOaROeReJDMvbwC7KrczgVkXAXMrzQ9kIuJ/4QdJwyZe5xdzQHlOMnrkGtrCiOEb6WUdOrsihMFztGCi0jES8vNPum7U7woyJWE2rtbI783/Rxb/au+JdOxxfYqsqPBIi2PRq84KZP9vVt8oVcaazHCsbUfDabirib8ZSuXvxlByk=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:WxwBa8s1utv4XLUR2VzjdQqBkR8QQ0tqkwbN6Sn/1BG3p6SSWqV28qE0YGbtxVqcf/BvyJvwqu8xX6pD3TtYhTXdnlhcSIeYoNqUkPXCHBZZ6yP/vPDmSc570SVWDnbANx9tx9BZT1oAokDV0bX8KQg9v3xxKUqwFdpP6AUNJiLr4Mxcr2kcxxzMoFKJqysxaeu8YcwbXXzX2DrrlZjpxHJLVizUAP0u+qeIShgwpHjuSDE3MjdsbiyQsRwWghzuIp0sBHaUnxxVnayRCPatdPLt1xRYThb6zxQxcRZ0LzKALjTy5tNYF9MM18bOh3xFhiAXOXZVxRSUzVAwnBpjKTuAwLFU2ddJ22rhAMSgy5Bkr8Y5PHpChPolRdfy6oi8wVpMhANHxfkXX+0d1Xp7SeM82Zuw3NNSMB1VPaOkwwpBFmqSO+6wEIgA1GyUXRITFlqlNE07k1WUJlGqHr1pSQ==;5:8PazrELtJyP1XMUlerBfkBpPrifamc6aY3sYqevbj+IurMmUsgDMXdBGqgf0H1Vrhr275X8gUuJlghKxwLLxxA90zlc5AY5P4YtP+xa4gKFTMmhtzdPpDMp9sYsKer3mlgA8KUx60QNl/3KdDMehMn7vmLxaq+WC5e0dRBzi1vw=;7:GpieXgMOPyR6DzaTShcYVDwU1PAY/k7u14OaSf4t9rqxRuXj0oE8i6bPqO2cqQ0yFMhnVIMYdsp/p6ErF7ju/klKDVGnYMYBSdnGsJmwMfjI1tjLfAuN79La1WtJ4hjFVjEsDE4lPjGvYq22MH2PZfP+RNLIqFEDJzrGIehwDk+aKX55lTPS4rHiCMT0e6/qk0BQzc4BeYtCZ7fBjDzc6eF4bLpTCp+YErMCjdbT3peTERvxuei3gCSnkFyDgrgn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:JgnT2yTfMYQd8ZhZUIpzCRHvWa0JGzkiZcgsQVsfvKgAsucpUIu6Z1lOE9XGeP98TtoalAIlZOyERC316oRFLyDEGj4i3BKPAs8gaMfbHOzrFX+irJBQ3zzyiEW2qq+mF+hLdcejnB1eLbZfDNFoN9ufqJUMiv1/efGgsKP54og=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:34:00.3016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14754331-c858-4422-b096-08d623a3f4b5
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
Acked-by: Song Liu <songliubraving@fb.com>
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

