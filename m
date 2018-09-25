Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C478C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DC020C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jtNcZe2P";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="M7kimhEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DC020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeIYV3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:29:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729398AbeIYV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:29:39 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8PFIgDr005645;
        Tue, 25 Sep 2018 08:21:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=DCFQmaGDQsOvH8Z58cOYUKQNLoiCCVkpED4D6JQq44M=;
 b=jtNcZe2Po+qgeLi9oz/uG8OyWd21aMyqxQyhCEhP1ksTI19SM1LpzWcryEzlUjgYJObz
 i5lC9wNNnS9D3+LWpJ2Z0FN47UBllEp+V4bkGEHdQgMvSWEI07eI4fnPxAfCINTB9s0M
 IoeyTJ8V8yO5Mxf2cQEasKoe6cj2AYEopUE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mqq01r6wu-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:39 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 08:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCFQmaGDQsOvH8Z58cOYUKQNLoiCCVkpED4D6JQq44M=;
 b=M7kimhEQykY82fi02v1qNGUkUIe8Ab3O+w9M/CuVdjX3RuA/SgP+m1BchNx+s83NPrLwQtWpv4n0bz1kgEIkW8clGuqYlJob9gzxknB/cfwYt7YpYZPE4Ig0IikPwgFko8kNs89Cq0d27yFJcLfl5lhnT/Ajp7/u7Wm0T77D2yA=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 bpf-next 00/10] bpf: per-cpu cgroup local storage
Date:   Tue, 25 Sep 2018 16:21:04 +0100
Message-ID: <20180925152114.13537-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a513b1-6cb4-4de2-3fbd-08d622fa93e5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:tlWt2OmqP10dGGn5oIsO4/Fp4PBA0nD1jleCA+/btMlj2KXhLYHtrD5Hl3mtDMTCU0L4FSNfWfuZo2hUnJYxeoRLE0/yErOq+3gAe5WJ2KaHwX8iI3KV8AbnVz3EclrSMR9xcJikD/I7n/OwYq4YNXx0scGT7+fqcTFKiaNXO/gbTzm5/B4Ui0+Y2var28nd3RDipeJGBUAKx2n6D4okHG33J4nt1aB63SJS747NutayX3ofrRF20xOsdqgxOOw8;25:TklvMTDM2tOKB/pRc1zK2nYBEGElk4pHGsFeH9VxiOvQ2bdQlIJTTVtoayXA9T1vA4Edl6ck9MghAIyPZcXxLoEt0PMtyaDEQrwXCYdfgc9fLB/6Z0QssJl086UPmyFOCvnR5Ux9vlxFlmeZJT2ZEbfTwiMHGbfEEHgJIeWXYREtUSszqjaj3zRBzq6gTuSmmoStvhoinAarYxHRy8V18zYinU8uHtDjNqYabvRO1XTMuF5XQashthLb5TOhU0dqMV/uYkVuPxr6TS6U6HiJfyWUYu3c5AJXbOMIzoImW165G2OPVcEtp2KPGwRnXJ5ebwhu4c8LJKcngdnOCYr/Ww==;31:FRXFKTVe3Z0SedsMB/nd9El8dD74zlVQagCkSH72wgLT5kZMwhvicf5anhsofUSBC41uPIoDF8XEsY+vgnOklyz2BJogakmOSxgEmWoSMTjjB2CRyhleXYhnunWwjRzFzaIgsM35w3+wEL5GRsn1syfiGak8TP+4FgHaGH/DcCPddzM8yXBsg6ARfPlKsAjQNWTKv1/Rxu6W2MntUBt5mGdJkq7pCqI5Tpz/bpbfgQs=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:JiHr8MCSBa/q+aMF3P0jnaFrxy+KUVOPBI0ooev7+fZKYWTlUVC2Tlj+yNXvbn5oYTGlp1TaW/Uffhs34IAxQiDmtbOFvcEesiJqlY059YOJz4jHcVBhGaG+CZZDfbMkr90piDwEiYsDoHP6g6gE5+OYjZUhcJdGKdqOlwDv+YbUHwGg/GJDXqqOJTxwZDYJgI9bkTki/JxXGzGvoOe7TvD9pQeP5k/jZELttp6SN5l5LewkIDhXi3OEQxAeUuQdaMEdiJr9TcBFrrreMA0fzWz+4dCFUacaXsxEsgRpgZNlrWW0+4bJ+frWo4s5+yBz34D3GAsHlnZY/exSFu0des02Ab0pTaCeMMxTceTaDw79RZMZEmezSmtoNN7CFR+xSD/ngDN45hGXUh+qZx2BEVi2n31Nbq7MBNZINarJ/KjKqyHAvBcXdG/kvTuEisvfVGkhnT4HOyjwSjXzoB6LL9Lg151YJw6cRkSw/syc8eQNYhNvxSYNgV4HDkv3iuU1;4:JgNbv2UzugSAqLGov6APMm0vXPP7xnzDXqI2GdL3t2N+MlnrbMwWUSDzkyzr4ncc3IM9FbXGuRtmN9ieOVn72ktSSdnUN9KjpPFRY1Bx6BeDi83cCUIYl7IyLc79hUrr8waBWotG1myss4S0bHxxsAT064tZ6+AIoOrsaZB6cUDQREmSSx5AGZIpZVApWzRVFxqsA2aINZ5o8JKNSB4dcRZmCgb2afz6zo/DVOJqUcXYenosGCkcSxgbapzrwJha/etlZ6CFyCybqdVq9CxXug==
X-Microsoft-Antispam-PRVS: <BLUPR15MB01633B00E1C3B58EAEB519E8BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(450100002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(52116002)(476003)(2616005)(2361001)(6506007)(46003)(386003)(68736007)(97736004)(25786009)(6486002)(8676002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(5024004)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:rlLZMH2TXbQFMdsac8PBvWKYT0w/2e21WpCBXygmS?=
 =?us-ascii?Q?kFG1hNDop13D/MOlHrxiSlsX0Ms0v1nKsW9r7OcNtby75W1gjfaw3/oKDOag?=
 =?us-ascii?Q?RXpQF3ADeLQ0yDFiLHp3Fwg9IfPgeZKtoXMu4uiYw8girPaDeIth12TDkuOQ?=
 =?us-ascii?Q?pLhSL7iP3rFN/i6olsPHdOIFcjw4ZRBDsRCl/xHE3dYNNvNnTkIPoGQwHY+K?=
 =?us-ascii?Q?NGV+bAk49XC8H7274LMA5l9GzmSJJLsz7P8tSY3EqaqKeOB7Ox6XWuOHuCle?=
 =?us-ascii?Q?/Yhvu/dOiBYKAJYHR8V06JSM9ox0EnkSVBGadO7P/GAVl5YAuKpRxDXQKW4j?=
 =?us-ascii?Q?5s+eLqatSJ8oGvQbv6FAuS7yqcxbk5qdkn3Eng8CpYCb4fimnjEWevkV7ybg?=
 =?us-ascii?Q?DiOtntWmJowUR9bD9oQJnduYin0lhn+MdCOgYBVaIilYS0dhDFTgnnzNdzAW?=
 =?us-ascii?Q?/cXTtN+XJJOjxlNsetiYa+K/cevk7VTRI8pTsjXH+MkjMT2QZ4wc3ltwXbtg?=
 =?us-ascii?Q?ZyLuPILO/dkr1vBMRt7Jd053iSwPL0dtOjaHw82AcnNuE3anQpRapmXJE96G?=
 =?us-ascii?Q?u7smTzHmveNsF+x8bh++1b0ZS3V0i9aIshp7wHUzOFCfKUZu1ANb9qCxEXER?=
 =?us-ascii?Q?ZCdnk1jeA57NzqwleRKtoa4vmg7AGlDwXylOg3SS+V0iuu8xxpa8iHjD+DCD?=
 =?us-ascii?Q?0FkwB6/KggxwGukJEF/Rv2YWfqxg4WHB7Yg5t8S9OyWqELNK1pqoQXd/mFmr?=
 =?us-ascii?Q?y+aI8RVwn71b6g47ZksEJLFkMeGM9c7elOwwPjSNoCZcM9dOmUF3CMibtTkn?=
 =?us-ascii?Q?4e15L4KjUfpgbaIHRYgPEqHAs/o6DQbB57BQXUgeK/vGwxzNrx8JwgLbB8kI?=
 =?us-ascii?Q?av9oRIw826t8XpxmIgKsPp7dnV9gjk712C5GvfS26+XtJ3/NRx2pZetcc3PT?=
 =?us-ascii?Q?3YOMBhlXJgXQPB3nBeMfUtTH302scWCKzlyTE1/snL7fgca8owD15KBFQAFd?=
 =?us-ascii?Q?rKGDi2fgIa1BO7AwuIk+L03gLLUoeQ5gKA3ujKmZJZDec6yFrIBS8WiQLfO5?=
 =?us-ascii?Q?Y1Ami/yJGVpRYi2CAEKVpD4CztRM/13pEjaiX4b3iSqxTXzTxLwxPOR9pppP?=
 =?us-ascii?Q?q08djkHBF2oEat6/w20S656IFjXDVO6xMzwXYnemUYCxS2C3GvDBpoIvOF3u?=
 =?us-ascii?Q?ZDJokPjsX+Sk7vpuAYkqf/WYUgsjrwhsXw4Wwn6zgSUHVGC3bbQW00G74zct?=
 =?us-ascii?Q?ax9wnWFMiF/pkC7fPRxi9cynJk5BgSHkUZ0tT5dUqDpWkxIREu9ocixLdrjW?=
 =?us-ascii?Q?Yn5or7FiN+QaMtu6lCDQU0=3D?=
X-Microsoft-Antispam-Message-Info: 0zsW3HYJqclvUGtEUCKc9lEAuT80m+1e90pxxNtuCKiDL5MOW1t+P8OqFiwmQQL8zM9BkFehiMPv9GK0SCknp6xuYeaCM3eablkRnvGsruKVHtT5MGNESnzaBGDocaUAGjIbQ+jVbyGcsj4/xfU5VgxfGGTA0IsUOMq2rdj5/rvvIINoTrbvccHhuLXYz0lFTViZRAa7BZ+WOh0LseJtcg4Yw0OHZxoNKYlBFODov1sbnucuPLLinYzsIqV2/fxXkoGmQayhW7vDX2DuZVVIAA4rqLHNAekMrd8RFcb/u6UfWlaJx56Mbq3wBZlpa1j+FPx4eQLVfgvsHn7GNlKEnToh6g6wwG3d3jjtKpqLs8c=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:AEr35XEhubQIvq6xHigWTWRaPhzoFLfCjuaCI0sybEA5swxk0gvdwX4qGuGfr88c43n4BfrBjZyA3eor0tN9BXj3Byoy9YWy4fA5vVFCYehkMZBsfS3sOw48Ih1LyNtL6R/jRufxTQvKNduorulRaUkWRpfw+NavnYzKpL+15VnF2RsBj2RNeBMz1pePGJewRRTvZpi00ZgaZUgsetRVZAoXCr3hoY+2cqZQODpg+A3nBW705kog2XX4QacI4YOnGKhH2nH7t4JoWNCY6MCMoNuZRgBha5ZIH3PAOP5JH/XKMW3w4QNw9GGsiREEEvZdH97IyhAgbQXSCvJsoxJzrnwn1U4DlifSx+vTgUx3i54raWdBydGHupassIY7Nk+zM0ALWtL+QoAsxCxxzLxKBZWCpe3Z9pIxXKlwkrUvA/G7C1B9LmHHSChtIoy4Ug5spdy7nKvFBcAnxXJ/uvEoVw==;5:T8WrYif2bqJevcXTUZ0d75pnuGuCLf0IDE0wHl4Uhj23xbLG7GQn6esKQGg0aqIVYLlbBWPP+IY9jUWSuG3WtcjDnyNDv9QvvGZDClz/4XHsu2mKAhAQ8XnoBviYl/i+4Y1Uq8Np+iQx7ppvZT5SI5dxI4JkQcLjPCPegW6V1UA=;7:zXBZzAyyyQhutXk1Z1biEUPa/3htfe77Lyr5JeiE8LTUucECeS+CmMFztWQBt/PbE3nCwOZ/I795bloU3NNdMnEyDiqcDfllEiLfI8K3EpFTQwBGWg8nmSzhz06+Y75BRv3+8MLxVkMoLH5vN/DhYSLgvS95oMHY4m2YKfYbq5s5QlxTuIxR3LjDTg2F0BV2mmVRwboMJBEUjsrIsWuSqRPn9GH21Q3At7Kb7B+bPQagp5RX//8RzSmAEc46CXTV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:rZffO023Zl+OS1HW0OJz6qrUwWMuEC8KJDFC4daAZfQvLWYoQToDEE5hM1AOd+dEHdF/rVyo1HHF29gnmlE3vYFunyldp43+mqQ825VDv3H3q5No6eJc7TOlXg0yZaLBKJqREsSVofHXXKhFHIHV/UjBP3xG/mqRZjXcfQBgqwE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:33.0910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a513b1-6cb4-4de2-3fbd-08d622fa93e5
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

This patchset implements per-cpu cgroup local storage and provides
an example how per-cpu and shared cgroup local storage can be used
for efficient accounting of network traffic.

v2->v1:
  1) added a selftest implementing network counters
  2) added a missing free() in cgroup local storage selftest

Roman Gushchin (10):
  bpf: extend cgroup bpf core to allow multiple cgroup storage types
  bpf: rework cgroup storage pointer passing
  bpf: introduce per-cpu cgroup local storage
  bpf: don't allow create maps of per-cpu cgroup local storages
  bpf: sync include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h
  bpftool: add support for PERCPU_CGROUP_STORAGE maps
  selftests/bpf: add verifier per-cpu cgroup storage tests
  selftests/bpf: extend the storage test to test per-cpu cgroup storage
  samples/bpf: extend test_cgrp2_attach2 test to use per-cpu cgroup
    storage
  selftests/bpf: cgroup local storage-based network counters

 include/linux/bpf-cgroup.h                    |  55 ++++--
 include/linux/bpf.h                           |  12 +-
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/cgroup.c                           |  74 +++++---
 kernel/bpf/helpers.c                          |  25 ++-
 kernel/bpf/local_storage.c                    | 167 +++++++++++++++---
 kernel/bpf/map_in_map.c                       |   3 +-
 kernel/bpf/syscall.c                          |  20 ++-
 kernel/bpf/verifier.c                         |  23 ++-
 net/bpf/test_run.c                            |  20 ++-
 samples/bpf/test_cgrp2_attach2.c              |  19 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/netcnt_common.h   |  23 +++
 tools/testing/selftests/bpf/netcnt_prog.c     |  71 ++++++++
 .../selftests/bpf/test_cgroup_storage.c       |  60 ++++++-
 tools/testing/selftests/bpf/test_netcnt.c     | 153 ++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c   | 139 ++++++++++++++-
 20 files changed, 778 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
 create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_netcnt.c

-- 
2.17.1

