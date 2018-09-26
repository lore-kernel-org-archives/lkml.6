Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6251C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5220E214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PjG+DZge";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FXklJekA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5220E214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeIZRq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48138 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728317AbeIZRq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBT980025525;
        Wed, 26 Sep 2018 04:34:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=4DZ/EZAiGlOWzKwcpam3EqOkppctv4ik/Gvw/JZXNtM=;
 b=PjG+DZgeiQkP71fGTaEAKKR9K8e9yVXWcL63/S2tWVOdC7J/vF+5nBkNgdCUVEpjxDag
 5YTl+n4YVWLebNpFBlb5uflg6F2asmMjRFE7RIxNzTtXyQzZL+jJmSlzHTEMDb5qLw35
 SsudGn3j0+6hQ5s4/fYKJTEgu3sEZJTorTQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr7ayradg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:34:05 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DZ/EZAiGlOWzKwcpam3EqOkppctv4ik/Gvw/JZXNtM=;
 b=FXklJekAQ3cqf2k+5on0hwmz1dT0eW7uBVJdY6gYPcbNMFdnfmSHY9N1E8e2VpOaxw9x5KTj3yukibCDSqqvH5elM3iQYP86gNDPag6XmwEQRWAyejP4Pm03FjPp5LGX8tztzGz2ZK2AAhZlxoUvrH895GTVVdWKmoBe7iZPL6c=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:34:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 10/10] selftests/bpf: cgroup local storage-based network counters
Date:   Wed, 26 Sep 2018 12:33:26 +0100
Message-ID: <20180926113326.29069-11-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 076e0d04-e45a-483d-fd76-08d623a3f585
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:TBBaSjskzKA1isw2Nd2U2iGj4XQhMEHIPp/1LBgTTjsYCFAqFf0TPXWw3qdCxc40wzUxPbA4cwGseEFFM1dmjjcB1NqkBOa7JfSpxecI8ky3H8yP8FSb82xnMWCq2rffekvRsUsCYEJ1phCf39HiIZMfdFvrjXcW/D+SZQHSpjGnIyVmEXYDbgJHckl6XSrPsPYLJ8aV1N4IHarPjXwf+XPUwNaSJMaK1Ki/KBw1Jq0sXTciBogLk1egTN18DxYm;25:AxSKS4RQlBqbIvaW7bAV8VC1+jdQjYuRis91UqNcS5Ts1jUorF++R9fJw+Hn4IHixJWY+WK+XFCWXWzI3bTDKw7LOwU14av6ihzeYg0rkDYdGaWzkSKBtYuuVNb8YBaw3F29hHlQOnfvueyg4lG8tjpVWoBWa+4gZp+fHwurRILpMFOgh9JM1pkyagot4qBXvp6gJMo7GCSpZRMo14Bfa6O1N6Dp2senYiRc6yLI7f7wRU9RqZJ4ryB97iWwpDk9lwsm7ZrU+HxjfkzB9SufAK3zJz3kOG3eRW3Zq4MG1/0TxzT/lh77ognAp0XiW2ORqpSZpzOToqLrPxLLELirxy+1gl7cPv8vs54cvyJgiDw=;31:nMQ3SQSziuyJd/6Xc47AW0IuiAcAw1Vy2Fct6IzSu4VFf9xJLDfELkB2CP/f4npKjUK5f6+tjpgH1MvkRYqPPPL03GIxgFGkn06VvJuTp4MNL4kKERBL/jU29BaUI6eGhGcg9BV2KaJnvTb5jSAcVZXk0TTrbKe5zLC/oGJqJXf8lpDwCw4i0A+ISB7QZM0aknb77cXjiDIY7wCm8FuNHf906I9kGJoRxxz8tBYR+a0=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:DL9MzgcvF73En80P7+dBGAE8lfBzM18Spp83ZBfrd5HVaRGvbnaHeBb12iBH9IgnkdwRaIxMUE95v7rDvytzYOfVYX2gOJhNiAaMZe1JMNe1nvGdua8zH/t5UlKEQkinte27DEj0DtE3S+pdwM3ul9rgF0h948IoO+9DYwBWq+aD31erjjGt89WtTDgsFQvo2EMrJ2bJ9AxIiP8tgmK2kHBNM06B5xY8YoXXUjy5Ra+Oo+G+V6l76NWfQC9Yn514dj2Pg+whfEguFM446JycqrJYV5aZ5QIQtbfW/icRNxjQQrhYBO+28nTT1HhC6TzSLazUlav5PjgEwgPS2+fYfCduEGVyRkL5EO/JOkEl33B7rXSywoIdmJSdpR8h0Dd2DFeyiNCjbMQfiHt7/f3Ug3agqIqqQTCBXk+j+w62CR2yUtebjRaF2YCFksCOdNwGlYbBf0LjM1Xftc949IdQkFL+f4sFnjKC7iMCzrrWAnfRzKA4yJ6SaI/56B6cU2RE;4:RwREZSj/U9SFwqOBNDTNgYN1nrhsOp5oZ5TWzDPStfvM+7hpS2FKMm3D0yYb7JGjXmRzsFAYHYXQtcUYbfHxy8ZlgMY48TXTWIfNKM0iSmr8U3ktswy1RCZrwRRJLPr4tMtNpDI7iQZXGRmMONgAcgOsP9djWkuhxH0rQHQ4Scbg6YOXyKfxt6tyisbq+0xLk1y1vWWBncZxa+G6XreAtK05o/MIBMUgVULTkt60GVWSIyFLdWH6If0L6SX57VlyD+/2ydktqk+HPCzcgfgfJ/rY3OQr7m5dGwXQmQ5ZM/mS7wuY7K11tSUzhk38jYnLksvMW+03nD96A1IhgTp1IRN3Zu4gZHi/Ojhuw6FwAl4=
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162331A7F2792825E0F0C35BE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(265634631926514);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(14444005)(5024004)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:njW4n64ta/YguduBjD0JEq0BuIlvRF39j1wROwHRP?=
 =?us-ascii?Q?LsBhq9DzreIHfhHysUIASgLp6cqrOLtM9xwZKUuX6QzJ/xhR/NYVQMs0qnoq?=
 =?us-ascii?Q?zeZxBKbikCJ2q4tF4teKHYBD/uX/Os/o+lEbL7fOZHdmFVTgLnByD4tZHh5C?=
 =?us-ascii?Q?XOzoVQ1mVo3cSyR50ZlPRZ6tEzOzdsM/U9y+Acub7gECLZx6q74t/JZOFIq9?=
 =?us-ascii?Q?CifJWOPfuW9E/XgjZ1Tml1bYnmctQOkqMQGxA4MJqFV3lBtkODxmZqxEkMtH?=
 =?us-ascii?Q?ngr1SVVXoPRPjeP6tkScqNxQjJvIAx8L2+pQU4/dZS5LDZ1dsxVfNGNtXhBR?=
 =?us-ascii?Q?V404xxRYj9UG4JoCUkP4eO0XtJyIdqJph1rdz35BW3BD73GT68OdrBxXCkXE?=
 =?us-ascii?Q?bZLUmO6XADpv/7ipiVZ97+iQsCdTg8qnEss/ucMttvRNJ1o4v7YWS0fF3Bz9?=
 =?us-ascii?Q?JpPtihdYquow5BSos623rdoMEA5HPHA6Nuo3EILJAiTK8QFIYbcV6uwjY6cT?=
 =?us-ascii?Q?yIhxgRL3z9Lpve5YEbqGihdAmmw4EmJbvH34EBlNe69nUFug8lFHtkRPOVuw?=
 =?us-ascii?Q?I2OgjPVcr6tOHnURAYvDGCwt+2JLD+K4ImDF6cGVKbzM1u8wqS5068K7FhC8?=
 =?us-ascii?Q?CH9BmvyVlmBhnVzgs41/BXVfSg4rU9wvtxsAfoYS1x+jcbzbKZ6dWNk8MSWc?=
 =?us-ascii?Q?s5tbk6OvJRg97ua2RhJTDqJHpwaKI7bIhgWW7SAlbzFOmpa12MIiXF/pcPHa?=
 =?us-ascii?Q?T1M9XBYZIminbnOUukDA/giTQokZbd97ktWX+Q2IWSo93Pp1TuO/TFMRPcl4?=
 =?us-ascii?Q?0aQJ5+rvi/+vQGNgfZ10yfq/addb/PEyuXqjMbI62lGaDOK1OjOdwpdP9/T3?=
 =?us-ascii?Q?KLCNv6uDpZWrY88ePpXHLcF6qrKX0tmlrVybYZfNipt3lVWv2Uw4QZBfXq6j?=
 =?us-ascii?Q?5CH9nRnYMbxGo7qG4yxLtPA1K0wlpuW1EdijNNlBLFGaEi8jo4VIgBFlad68?=
 =?us-ascii?Q?nqqXGnUOzp0wNO1FWbdHdxDAYYUusoxfV+G3nRqLShIANuYy7fKnxgz5Zxx9?=
 =?us-ascii?Q?XJav77cyIG8SUaps56UmqnGgbPoCUxqYzTR0n9jdw2GnFmiY1y9sIsmK56La?=
 =?us-ascii?Q?ytI9jywXOie1hWv85jQQ3lfHW9+atKeoYCazRlcvTAStbvONdX6pVYEUTp+R?=
 =?us-ascii?Q?ZmuTP7PpcwbvzwB6J5zf7NqgKUjIMqcOPk3goPy411BXaPEN2ce0iUOQftvo?=
 =?us-ascii?Q?Qt1p9k9GjaKJYQ6XYQFMLofUnjQqsmcwdAf1Y5zIxQv1xoN0/lQdtVnzDxFa?=
 =?us-ascii?Q?Xj2WTxSFlZW50hn5pqGf0J/o4C9ZAwWGpFpCJbqIAbWVMPqO1qsTGitJ8BN8?=
 =?us-ascii?Q?11zYg=3D=3D?=
X-Microsoft-Antispam-Message-Info: ztwd1jnr8S/wFF0rFyxSuMFt/MFg5WQIg/eud3SDK5gJpPmvK19Ae+aKaEDjPkipbkoTbSYrUKwNbG7FE06j5EVLauDolw7nmdsNBM42Xn4Qek3CNA8P54fuSvb+dmvZN+m6ukLerJWKN0Gr+t9MjtHWcAgZZSRVzT2M/Ou8WMazMp8pX02WdfWmaHeP65HzDljgpG5oaBJhTvjbMHyXiRKDSMMVO4SKwk/eih9MVYp0TFENPhXdpBqqUueh/Bkjb9xpBIH8yCAjp/ujnmgg9U9+VadQj2fWu7M262MOSS/8LDCXRrg6KluEv6i09Acw+wV8N48ywV5y9uXE9dVLtpFyuiaX7ppFPGCrc2OHOQQ=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:k3PoAc2NCgdCowex6m4an5TTgqE9q2S3ozvqCnWB9OJlftCyAqSgHrYC42YoVTsaXQP7Wllkhm0bf9l50Ec/ub0LERwQSB9WxUcQyBCQTs0bXj4Je4F1AkHOQQ8qkEKYjhvG3QbKfZVdHhp4snA/GniSvAS7tWw2pSWmy1zCKoUpk7ysOAzagDjzkaW7gFGeWYTM4fgR96OtGfL/kBt0O7V99fgFTaNeCRDeq+uI1Eecis2P1zpCUdp4WHbol4x8UK1aVznT2B3IJZoQUeCjKPlRE7nwXJ2XQu8TejydlXrwYZhXNnQczhr8In1MY5dG0R42S143LmcCCxgynbQDv0Sk6Kwk4i/V4Pj0cgQyyWFwK8MbKUupI4J2WFYBGVtb2Q1UmTJKEvP9RNRQquyEXEA+ZRzA4yUKlFIiNZx3SorLt53trryMs1yEA4CSv9xk6LtzJ6bXJJB9hO0wMSfzog==;5:mC5IFm+8Iw4FDXTfdj67dgYCqrOBi5WDEC3ueZYQExCdMH/oRDKM3Y/XiCuDVxErps8B2dWw7SS0CU5agbFJzewGN9jRgBY/+2yvEQz090IVTkZGQZyXde7m7W9q0jraXCHu4urF6tIM4x/rj25nHsA+mqgzPYxNKoeNhMEJSvE=;7:BNHF6EpKZXHxjaDpgNp2Osu8mfE9mFmr0KpkIYL/LgjTozkTPxK9iB6Yqq/TjaTXnmBL5t6oJrYS9Ry8qwCTCOWp1W8EwgY3aqiNtonRXAuDwZQ5wFYLV4xDqLRAdIqUKbxHLKBLONuwHrxC01bgcJs3jol75bEXQzkVR9r7zK5BGj+pvzugceBKhXUxAPeRYu4jxyNtwv80miG+P0zOAz0By7F2GCl+2IrfVlKKXmqZ1bIpTnrUtKTflNPvUFCl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:lck2B4vfHeoiGii1rEJNUbjs64IZxFwejoTRvP/O6F+Z7zA0BFQItxt1oG8wAgmb7NQRnp8XXpPXVMqDIcRtuOxLmMDUwRaLsFUsabGqyhaf3GdNYAuGw7/J09uLXbQgTAtliRF00kxjhqQUMO3OZ21m+CXyKb+FfK7MCTWX1z8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:34:01.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076e0d04-e45a-483d-fd76-08d623a3f585
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

This commit adds a bpf kselftest, which demonstrates how percpu
and shared cgroup local storage can be used for efficient lookup-free
network accounting.

Cgroup local storage provides generic memory area with a very efficient
lookup free access. To avoid expensive atomic operations for each
packet, per-cpu cgroup local storage is used. Each packet is initially
charged to a per-cpu counter, and only if the counter reaches certain
value (32 in this case), the charge is moved into the global atomic
counter. This allows to amortize atomic operations, keeping reasonable
accuracy.

The test also implements a naive network traffic throttling, mostly to
demonstrate the possibility of bpf cgroup--based network bandwidth
control.

Expected output:
  ./test_netcnt
  test_netcnt:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile        |   6 +-
 tools/testing/selftests/bpf/netcnt_common.h |  23 +++
 tools/testing/selftests/bpf/netcnt_prog.c   |  71 +++++++++
 tools/testing/selftests/bpf/test_netcnt.c   | 153 ++++++++++++++++++++
 4 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
 create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_netcnt.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd3851d5c079..5443399dd3a1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,8 @@ $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
-	test_socket_cookie test_cgroup_storage test_select_reuseport
+	test_socket_cookie test_cgroup_storage test_select_reuseport \
+	test_netcnt
 
 TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test_obj_id.o \
 	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_prog.o     \
@@ -35,7 +36,7 @@ TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test
 	test_get_stack_rawtp.o test_sockmap_kern.o test_sockhash_kern.o \
 	test_lwt_seg6local.o sendmsg4_prog.o sendmsg6_prog.o test_lirc_mode2_kern.o \
 	get_cgroup_id_kern.o socket_cookie_prog.o test_select_reuseport_kern.o \
-	test_skb_cgroup_id_kern.o bpf_flow.o
+	test_skb_cgroup_id_kern.o bpf_flow.o netcnt_prog.o
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
@@ -72,6 +73,7 @@ $(OUTPUT)/test_tcpbpf_user: cgroup_helpers.c
 $(OUTPUT)/test_progs: trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
+$(OUTPUT)/test_netcnt: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/tools/testing/selftests/bpf/netcnt_common.h b/tools/testing/selftests/bpf/netcnt_common.h
new file mode 100644
index 000000000000..0e10fc276c2a
--- /dev/null
+++ b/tools/testing/selftests/bpf/netcnt_common.h
@@ -0,0 +1,23 @@
+#ifndef __NETCNT_COMMON_H
+#define __NETCNT_COMMON_H
+
+#include <linux/types.h>
+
+#define MAX_PERCPU_PACKETS 32
+
+struct percpu_net_cnt {
+	__u64 packets;
+	__u64 bytes;
+
+	__u64 prev_ts;
+
+	__u64 prev_packets;
+	__u64 prev_bytes;
+};
+
+struct net_cnt {
+	__u64 packets;
+	__u64 bytes;
+};
+
+#endif
diff --git a/tools/testing/selftests/bpf/netcnt_prog.c b/tools/testing/selftests/bpf/netcnt_prog.c
new file mode 100644
index 000000000000..1198abca1360
--- /dev/null
+++ b/tools/testing/selftests/bpf/netcnt_prog.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/version.h>
+
+#include "bpf_helpers.h"
+#include "netcnt_common.h"
+
+#define MAX_BPS	(3 * 1024 * 1024)
+
+#define REFRESH_TIME_NS	100000000
+#define NS_PER_SEC	1000000000
+
+struct bpf_map_def SEC("maps") percpu_netcnt = {
+	.type = BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+	.key_size = sizeof(struct bpf_cgroup_storage_key),
+	.value_size = sizeof(struct percpu_net_cnt),
+};
+
+struct bpf_map_def SEC("maps") netcnt = {
+	.type = BPF_MAP_TYPE_CGROUP_STORAGE,
+	.key_size = sizeof(struct bpf_cgroup_storage_key),
+	.value_size = sizeof(struct net_cnt),
+};
+
+SEC("cgroup/skb")
+int bpf_nextcnt(struct __sk_buff *skb)
+{
+	struct percpu_net_cnt *percpu_cnt;
+	char fmt[] = "%d %llu %llu\n";
+	struct net_cnt *cnt;
+	__u64 ts, dt;
+	int ret;
+
+	cnt = bpf_get_local_storage(&netcnt, 0);
+	percpu_cnt = bpf_get_local_storage(&percpu_netcnt, 0);
+
+	percpu_cnt->packets++;
+	percpu_cnt->bytes += skb->len;
+
+	if (percpu_cnt->packets > MAX_PERCPU_PACKETS) {
+		__sync_fetch_and_add(&cnt->packets,
+				     percpu_cnt->packets);
+		percpu_cnt->packets = 0;
+
+		__sync_fetch_and_add(&cnt->bytes,
+				     percpu_cnt->bytes);
+		percpu_cnt->bytes = 0;
+	}
+
+	ts = bpf_ktime_get_ns();
+	dt = ts - percpu_cnt->prev_ts;
+
+	dt *= MAX_BPS;
+	dt /= NS_PER_SEC;
+
+	if (cnt->bytes + percpu_cnt->bytes - percpu_cnt->prev_bytes < dt)
+		ret = 1;
+	else
+		ret = 0;
+
+	if (dt > REFRESH_TIME_NS) {
+		percpu_cnt->prev_ts = ts;
+		percpu_cnt->prev_packets = cnt->packets;
+		percpu_cnt->prev_bytes = cnt->bytes;
+	}
+
+	return !!ret;
+}
+
+char _license[] SEC("license") = "GPL";
+__u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/tools/testing/selftests/bpf/test_netcnt.c b/tools/testing/selftests/bpf/test_netcnt.c
new file mode 100644
index 000000000000..aa424f8db466
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_netcnt.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <assert.h>
+#include <sys/sysinfo.h>
+#include <sys/time.h>
+
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "cgroup_helpers.h"
+#include "bpf_rlimit.h"
+#include "netcnt_common.h"
+
+#define BPF_PROG "./netcnt_prog.o"
+#define TEST_CGROUP "/test-network-counters/"
+
+static int bpf_find_map(const char *test, struct bpf_object *obj,
+			const char *name)
+{
+	struct bpf_map *map;
+
+	map = bpf_object__find_map_by_name(obj, name);
+	if (!map) {
+		printf("%s:FAIL:map '%s' not found\n", test, name);
+		return -1;
+	}
+	return bpf_map__fd(map);
+}
+
+int main(int argc, char **argv)
+{
+	struct percpu_net_cnt *percpu_netcnt;
+	struct bpf_cgroup_storage_key key;
+	int map_fd, percpu_map_fd;
+	int error = EXIT_FAILURE;
+	struct net_cnt netcnt;
+	struct bpf_object *obj;
+	int prog_fd, cgroup_fd;
+	unsigned long packets;
+	int cpu, nproc;
+	__u32 prog_cnt;
+
+	nproc = get_nprocs_conf();
+	percpu_netcnt = malloc(sizeof(*percpu_netcnt) * nproc);
+	if (!percpu_netcnt) {
+		printf("Not enough memory for per-cpu area (%d cpus)\n", nproc);
+		goto err;
+	}
+
+	if (bpf_prog_load(BPF_PROG, BPF_PROG_TYPE_CGROUP_SKB,
+			  &obj, &prog_fd)) {
+		printf("Failed to load bpf program\n");
+		goto out;
+	}
+
+	if (setup_cgroup_environment()) {
+		printf("Failed to load bpf program\n");
+		goto err;
+	}
+
+	/* Create a cgroup, get fd, and join it */
+	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
+	if (!cgroup_fd) {
+		printf("Failed to create test cgroup\n");
+		goto err;
+	}
+
+	if (join_cgroup(TEST_CGROUP)) {
+		printf("Failed to join cgroup\n");
+		goto err;
+	}
+
+	/* Attach bpf program */
+	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
+		printf("Failed to attach bpf program");
+		goto err;
+	}
+
+	assert(system("ping localhost -s 500 -c 10000 -f -q > /dev/null") == 0);
+
+	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_INET_EGRESS, 0, NULL, NULL,
+			   &prog_cnt)) {
+		printf("Failed to query attached programs");
+		goto err;
+	}
+
+	map_fd = bpf_find_map(__func__, obj, "netcnt");
+	if (map_fd < 0) {
+		printf("Failed to find bpf map with net counters");
+		goto err;
+	}
+
+	percpu_map_fd = bpf_find_map(__func__, obj, "percpu_netcnt");
+	if (percpu_map_fd < 0) {
+		printf("Failed to find bpf map with percpu net counters");
+		goto err;
+	}
+
+	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
+		printf("Failed to get key in cgroup storage\n");
+		goto err;
+	}
+
+	if (bpf_map_lookup_elem(map_fd, &key, &netcnt)) {
+		printf("Failed to lookup cgroup storage\n");
+		goto err;
+	}
+
+	if (bpf_map_lookup_elem(percpu_map_fd, &key, &percpu_netcnt[0])) {
+		printf("Failed to lookup percpu cgroup storage\n");
+		goto err;
+	}
+
+	/* Some packets can be still in per-cpu cache, but not more than
+	 * MAX_PERCPU_PACKETS.
+	 */
+	packets = netcnt.packets;
+	for (cpu = 0; cpu < nproc; cpu++) {
+		if (percpu_netcnt[cpu].packets > 32) {
+			printf("Unexpected percpu value: %llu\n",
+			       percpu_netcnt[cpu].packets);
+			goto err;
+		}
+
+		packets += percpu_netcnt[cpu].packets;
+	}
+
+	/* No packets should be lost */
+	if (packets != 10000) {
+		printf("Unexpected packet count: %lu\n", packets);
+		goto err;
+	}
+
+	/* Let's check that bytes counter value is reasonable */
+	if (netcnt.bytes < packets * 500 || netcnt.bytes > packets * 1500) {
+		printf("Unexpected bytes count: %llu\n", netcnt.bytes);
+		goto err;
+	}
+
+	error = 0;
+	printf("test_netcnt:PASS\n");
+
+err:
+	cleanup_cgroup_environment();
+	free(percpu_netcnt);
+
+out:
+	return error;
+}
-- 
2.17.1

