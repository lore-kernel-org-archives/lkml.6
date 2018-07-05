Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0401823FCE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CljalcDW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QS+IG7Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0401823FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeGEUxw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754331AbeGEUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:41 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KqIm5026792;
        Thu, 5 Jul 2018 13:52:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=cMzzqLiLCPmsOq3FfkMt2sPV1iZ6pisGUcpr8A9kB3I=;
 b=CljalcDWseUWzEy9M/RjAYkSIyZ9VTvdW+5ivBn2N5pLLXEBGdXy0SQeL4LdN0kNsceu
 CcBoZ8j0g9+krU0aLXv+7TIVEqo9WZp3ffQJzwsXnCAm8ZCVNcNRHIRG+0I//2a9miQv
 izpJ8NVENJvSCzZp4QrEGdspd88uDcuZZ/k= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k1q6urqhd-8
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMzzqLiLCPmsOq3FfkMt2sPV1iZ6pisGUcpr8A9kB3I=;
 b=QS+IG7DbjXt8L8tb8tSc5HsR0cjqn8gKETxNBBW/PgCUyXLqFVV7vCwwKPC/qYxeXV6CitrwOYXS1Q5+QujeRarXbYNcKglC5cxnsgJM+iIyyM7lT3enfpGkkkSsYBTxfV6+lfnP2Xob1qqEu0RImWze757MKc2YiYOsD9/Ul5Q=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 08/14] bpf: introduce the bpf_get_local_storage() helper function
Date:   Thu, 5 Jul 2018 13:51:33 -0700
Message-ID: <20180705205139.3462-9-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbac7460-48fd-4ff5-b55c-08d5e2b930c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:YXicpmuDqo1li3XEoaJPXLsIdN1Qf1ST6fHrdpePXd1pDhh9TBLarow88lTRtVcJUwifuQZD2CvFuuoBJGujxjxKS9cwCZ0zg6QhcAGY1uLKOhkwK9lP1+AvT0oBTnklmXyemwd6sNknnvgW2gPQQeOip11pSFRvEMgYkBAJq3SusW/O+CY7QCx3cSoAkGmuuFP/NyBWPLq0Ew0ruKhkPbOwFXKGY9nFQH+uI5HnoXm8Xo5qpBdkNNXTEoChyO9b;25:DespPxFQpelQ9IM3zbQ+YzcZ7Ou7Xgl0RbRsHR815ueZi03WIYG4rfhFpcgXZ7teTQTVCb46OSZCqRK4UU6dSuqr2SgMBfABmfpXGcEzS01cPAyJMQxOvfXm8f4aJ2UZOP4Gol23U8Gl7Gyzb93pZiNzh8w4YqiR5eOg6heu/kDzVGyN1/R8Pyhx8YBLMxkkx2LGb33GwFT6dRYq35pLdVqf4tU9orZkqGxxj7IbPugz+Cx2f5bL6VqUrldJRykF4uyTQqEDfTCLhaCeUnLvgqIJftH0MnmX9USTYkm9GoCUewmW6UrAHGI/z5i161u2DmM4vlEI5skS/dHix3I4Mw==;31:XDHeE20IfOPazo1dQlfY5vjXpTCWScCLB+2TGs5T6Wr5xuQNYAcK68DDyHJ9QPfKK5f1Fq2ok4rmdVQYvwoANOz6+S6kkclkyZErN80oigNnWYsOOB3f9ciUCzcdJtyZgdQL96RdZcvJMfrjuyklyFDt3fkpKbd+g6hSDl19n9PKR3JRc+fvkk30mn8Zz+QIlXuL2WSSzljAtmFh9xG5NaPELfkk2U+PRAJvnKvAzn4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:r09b6aKZv8KaZbTsojdWEt54+5qBYnIYWKrB/uJ6lDIZuZXrOsiAjyXDU30c5M2w80DX/F1T6vhDsHXhCWxo/+DYbffjZ9ivynafwEPH+AhUWj0Bk5vmv3h79Ik2/29niemj84sVWHPePc6TWxI3kmVqPuEwgIzWrdI9x8Z4mPTYxlrMeGtALNQdvSvMaTMlnxJ3SrcKIjpn9ZTv3m4+BDI6gD0ekadu9e71aNml8N6jXMpM8w/Cp2JrpAIAbidRy0myPRfprHm3klt2EzKJqkejDqPFPKT/YGZP8vCpMXeR8iXXpRNZcx0htzwBakt8dLRnN05VvMpX4rcEXOS+wY97aKlhExUK6rUVMXhGG6Xt0hrhlnKuK2SHzCJq/tEE+juPiM2/LMYQlbP3uTuT12jkjulbrh6VrHwsPL7oubKK1G7lJ26PHzhQDg1YIFgqyFG1ETOk8nHkXwSUOMFSe8KR+o4UszDM5UeHtMA8A9VzkMXG13jxyKSWSL8g1/XF;4:7HprbNTbm3GDymUvMpM+Pxb5DvycSBUO8sB8tepxOc7W/Lui4/ZUkhaEIFdsMtJyFiS0hBXNL4HAWgYCJ99SHqazflRX+qH+o0XkhZ8pivhCsOmmPp+cYr7ST0wKNwTp4lFHrO+YxAfYAgKbe47bjaS14mCP0+ozMZIvRRotA8XCdi/E6f4GAGr5DLdtOgGh+zwe9hSuCecjf8xfY0tQ/etLHvXNiqg2FoJs9WBvF0oCZCSR6vjscCdjvDUbhy4U/2IjaEgmkesCtWErp/uXaDZvwdOOwek3qx7t+5qT2aB+c9OCEslG43NSdYRV2wpwE3X7Shzw+6Om2hKTgYt/NQ==
X-Microsoft-Antispam-PRVS: <BY2PR15MB01664EA90463A6D92B6B20BABE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(575784001)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:F5+O3bJ8oX4ic4m724Ke8rBpUKvLX2IOXASCN+444?=
 =?us-ascii?Q?xbiK0xYi8jllosjC7eIBx0Hn5/yJ03vsm2kvadg81YpVu0jydexTt877sf1R?=
 =?us-ascii?Q?Y21PoN7GAsWpBiozQAVt8/GxvxVeSOPf4HZQ3aCKf3k/93xi+oK400pEKGru?=
 =?us-ascii?Q?YaJgUBpRaGiAkcMsCogADYEHoMINbCJyHiD0Ham6VAKKDRypqZM7QJoHkJRN?=
 =?us-ascii?Q?xT+oE/WMWmfFfpUt5/6B/wuIA6SfEF9Nzngm/E4uJLGntrnD9UFsVZY5Sv60?=
 =?us-ascii?Q?O6FiYYVzTqOVcdRp3OJQGMMreP+H8VVPC8Ct2KQiqwkvJckL6Iy7phWXpomA?=
 =?us-ascii?Q?AwzUG+/jGb27fiZp2UitmO+IoQGuNNT8kFeXRcSq9pubYJtZ3oCYOX5TfgYY?=
 =?us-ascii?Q?IDcfxT1nRg4DaKYNRvhtGD8sRUgmldC2OqJemEMHZIreL+FH9R89BgM2ybRo?=
 =?us-ascii?Q?3uWypQYJN2NivPyAgTF0vPZt+yyabFANsugcVktfp3RYLJiVUX3BnWD95Ad4?=
 =?us-ascii?Q?aXMz3kaHcPnKJhRPm1g80wbZmPKoHSHevCD4O0NXDRroC74dS5i6tpXsL6MC?=
 =?us-ascii?Q?/OJph6v3tGJis/xl/szJJWU40tkk9qCcibaD7TWLj3dzgbssQ3puH66lXcPf?=
 =?us-ascii?Q?Ep1kCgYhXvsE30BHrmMZJ6JIbJnDOSZGtw+fhiBGtMmip3LSryduybDSM0aw?=
 =?us-ascii?Q?coLAHOMag+Wa5D12ya/weftllDG3e7Aw2BvDB62SHaDGVyCrCSnL7aRW1eKe?=
 =?us-ascii?Q?bk8a1xjuGWsr7KkIA65XYkTFliaRZakmu2ugTmt2FkzHZZqAiyW4qIBBLZe9?=
 =?us-ascii?Q?g3OlUX7E3wSlmau25V4X1ZhLjWtL4HTDO7bbFE9Pm876lFCCCdRyE/R8q3vj?=
 =?us-ascii?Q?4DTaFD4JenldmFOtFLLDiPWKB5Mx/taMyhEGffvufHCV51zNn0rnxLpPEpYR?=
 =?us-ascii?Q?v4AiVoxMHYEzKQcKCUn1C4dXmN0cBFZ8f2wmMmmvFasPfv2LRnRVVDsvGxNw?=
 =?us-ascii?Q?5+tjeuzY2iC0SQKzM74NQjv12KMtCAm36mf/OWdFfFj7BP44EV4xej5aXMr1?=
 =?us-ascii?Q?fJ0gFRH4yPDV6iPi1R/4lzldjR4yfigrwDdsFeyCgdjmf8g27YTmdMlo2d38?=
 =?us-ascii?Q?CcorqVOVkLyx7JdzaBFB826fCczC5QGkWrENJN44wDxVdYbTeYKGrs8CYJcY?=
 =?us-ascii?Q?JZL5Bnra1xEMSbLpYnyOhyfIl6uKIFTfCVtLLjH/DA7PPflKvhWvAn741SNQ?=
 =?us-ascii?Q?Lx6M/gFGC54EAZmtF8S7jVFFedIfst80ue5dP/dkyYQr/TTeh+UCd9S65Xdg?=
 =?us-ascii?Q?csZZ35VVnlXPNh7LZ8TF80=3D?=
X-Microsoft-Antispam-Message-Info: 8wX1VdzEmop6Om8B2czMm+2xpr9X/ci3/o6ikAVEZtmRNRe39oB0N1hIFFvQgQ3EEWjZj1o85ERlC2uWgE3q7+CHdqo7BsFYE+js2zDZBYaIy3jCIu/w4khfVKZyTAGTHYM7iphWWGAq/N5rsLRYTHTglzSbPS5RDDWc8NRQK1Q+8luQpvgts3TVTRmLaE7YtPt63pld8FsnSnGU87LTNeKL3IQSqK5M53QKPIdmy139qwetwyWIJQYNz1dE0IcpmcylZKxqtSKo8CwD31U0+uDOcaCZCyrxFvKAQS0ZVU8cz8ZM8yWfcTf8yn6ayeBhnjNol+5e0JT2T/nUd4LdWCJjAjqGGpqskZ8OTvt25fI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:1TpTdEAgpgx+BE5iVfsw07OyA6XmVrC0Dg39NDOcwnC8zM/HaAnCfXC2DRUcuLtOZ5hhID9BYbm2f3u0AXuxf9rG9g3e8chFHaAx7EdODB16jOAx7r1y3J7/U06VRrWk7MxxQbHN0Ri1GEK/+1DYTZ3RS0sVktEh1lOVULI4Lh7St4JvmRtEenj15L5te4L2ftP9dPSEfp/p72BJ0mBsfQxZIpOCisscpL9XOYcEggFew+e8beXFPpG0UPMwMWSdy0pN6OEPVxw80L6Xmuznb99vLHPS+tYR4AHV0kqFfVdP0JsI2RBV3XKZTbRju4Le6NRzdaQ+MGYQVkpQ2kIioESvugV23r6GF+irHHP2Atwmfd8/S7KID+6Lze/OUePjR86zAzgw8SFr0AFsI+KtTAt2YHmvAmEyvDLrl5eAkT2nClB5hCi54yl/nUNhtn9S/cPzFRaTtUpHu5HfVFOScQ==;5:jT4ZTpVI2pmMNtbBBBCI0LJtAkPtb1fMRgJqxlBTIshE2qRj9Ay87VGLKhivcUvGgIgwj5jKv2KdciKtJXVlKu+PXLwrtKEE3fxMTnlM/ywew9jmxp8MjFimBDq0jFmTpnAOLPHj7ol9iklA2CIICVwxTSRmr12B+iGD/8P82U0=;24:8FfN8zN2Alk7t2TRV3v9Pkmz5jer0wvh+JSdcYxzmBDAlz956jU2XQ7poa8l+Xt+PxPnrOQmAutHgWM1/5pWZ/a2Rdh0ZE+pJRpz1PY7rLQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:X+EPwNMQy5aweDwsKokLkhSsOVfX5ioC/KmLyh41vnQlp8eVzyfe7YXTqgCNJSM1oNv1Tk0IRJ3hwwNuV4v0uN3KhGPtVlMNVPmT+qSgLi1UviOPcbeudIG4ALC+GdDJvHuNI2gXsNm/nW9BJEhnNM8xAGUHg9qnqX0qlBRl4dbkPukyKtuJTkxzBzszBYyGupE6xDJn+sXu/nYVOVNmokbyXfKWo82LstjQtpyKMdU9alaSkIcAZRhHOM3qIpFG;20:XOE0bgBE838KhrPE+fE1f8bAAoIMWlZFZe+CHXaI2Us7FBvVBZ2weqUfiJAWS0RMuHhMW9E+xai/yU2iAM5bwawQ8uCc5HJyFBT8LxiJA0jIst1F6np6MYWq1Iin91IpW5G61Zha0JHYCOISjzoO/el+SsbJrGcvz4vbhwnLTUY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:15.1800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbac7460-48fd-4ff5-b55c-08d5e2b930c0
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
 include/uapi/linux/bpf.h | 13 ++++++++++++-
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/core.c        |  1 +
 kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c    | 18 ++++++++++++++++++
 net/core/filter.c        | 23 ++++++++++++++++++++++-
 7 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 577fc6cd830e..97a3832fb5ff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -779,6 +779,8 @@ extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
 
+extern const struct bpf_func_proto bpf_get_local_storage_proto;
+
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6f9b907a8a0e..ee8b57eba728 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2083,6 +2083,16 @@ union bpf_attr {
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
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2165,7 +2175,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index dd232a276668..4f7b5bb7d97e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -683,6 +683,8 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_delete_elem_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5903be928722..efbcb4e58a7c 100644
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
index cc0c7990f849..a0f5c26fffc1 100644
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
+	    !tnum_equals_const(regs[BPF_REG_2].var_off, 0)) {
+		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
+		return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/net/core/filter.c b/net/core/filter.c
index 547fd34589be..753b99238516 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4674,6 +4674,8 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	 */
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4696,6 +4698,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		default:
 			return NULL;
 		}
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4718,6 +4722,17 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -4838,6 +4853,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_map_update_proto;
 	case BPF_FUNC_sock_hash_update:
 		return &bpf_sock_hash_update_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4857,6 +4874,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_cork_bytes_proto;
 	case BPF_FUNC_msg_pull_data:
 		return &bpf_msg_pull_data_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4884,6 +4903,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6686,7 +6707,7 @@ const struct bpf_prog_ops xdp_prog_ops = {
 };
 
 const struct bpf_verifier_ops cg_skb_verifier_ops = {
-	.get_func_proto		= sk_filter_func_proto,
+	.get_func_proto		= cg_skb_func_proto,
 	.is_valid_access	= sk_filter_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
-- 
2.14.4

