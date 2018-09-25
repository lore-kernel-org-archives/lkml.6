Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1852C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415FB20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I4eIiFFS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PX9SQCJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415FB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbeIYVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43534 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729398AbeIYVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8PFIgDs005645;
        Tue, 25 Sep 2018 08:21:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=8yOGCeo3sjG+7GztaGG4ZybVaszxYilsz/RWGeYxAAA=;
 b=I4eIiFFSLMsGpA9TNkFRP4dU3KcjgR9KDEOGkyJSJxcK371gzXcMEtFwiMocZ5JDTu2l
 vPG03iSxcGzVsMPc3NH8p87DVD248gjTw48Br3DJB6CryUntSDphHeCkngTzuFiLUia8
 4HSe04FfQ3a860MhpTArmUR5Qr4n1ioL42Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mqq01r6wu-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:39 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 08:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yOGCeo3sjG+7GztaGG4ZybVaszxYilsz/RWGeYxAAA=;
 b=PX9SQCJwYyzhfCaS3vhV7sUHqrzJ0oJmQJ0q3IadA3UxhzjxM9UMK06/WzW7Cy8dmXiW/ldvKiC++HrdHYvb9yvSPVCE2b38gd4L6ZlMOdh+DTeaSiNytHk+7WsnY7t26vaWVlBKnx/mgtp4MsuYYuMJriUjJWnZtdha7wiKAZU=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:34 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 01/10] bpf: extend cgroup bpf core to allow multiple cgroup storage types
Date:   Tue, 25 Sep 2018 16:21:05 +0100
Message-ID: <20180925152114.13537-2-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25759271-061a-4921-4bda-08d622fa94e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:aa432xhU6RYWqUn4EWS0m3/0wsrnyB7iB+Cqm6RASxx4a1dGtYHX6yHDdTAUGGn9MNnvlflJm8ev0S/OupMa8AOZvuxKWd/ykcf8axZlQMYKoN47weO8brHv7famD+DR/Vts0HrCJTwuKbdWDrCsCH0Rg+cq+MrBqoBpF/rd86NKqY8yjadlAf9PnOiocAgw80Q+RyZDrlamPjX4/GWwGL2+dgr1P+AwpatGjgsPZoI0uxFKytrQKFuYiPg3cR8t;25:z0JREMyqjadfe36XA8k0lQ8DVRWVeoVLRZD+71ASV8va87x84ryWJQGiHmDJh9mZLaxzPuv69Vh3TXu5Q2QTMryxs1inpetHdCkXZzJkWrJ2BvQ77KZ4MQkTwXaLkXxG41BQEdTak7x6eM5rHdqpCN4DLY1V0FFqaG9UKO3UTiR7/orrgoIEnfDyWDnE8XBHI9ni9YNppBzOHCxxTze/iSg+Jwxnyc6tJEGt/XSS/aDj8RTGZu1BIVpATqfXTS6k+SC4WRxI98FGSlM0/824DfJlglCpTCWoWnS9za3T9emPsEMrDqjJzR7rstvXD2iApSzPrJeXvJ+8AneJLMbf9w==;31:IRKUwsqirUdr0dAmJqwnEb9Oi+1i+UfWVLs2LHDjjZWzcul7TpBUBmG+OELiOQHeQhi8EjNKSxBh0lMTbPg6xZeCpGOjyV/GROI7OBw4Nu53Gv9gBTHk4ZUMhrkQPxMwgVCJmKZ7zjEzDvQZigBGgPgK1Z/sedtOFeAROrPz8MS7JvYgdWotpnG23RiynJma2zWserDk6rkPY+CG6Bis1EEZrqe0BnB7rMcuNrJRSDk=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:Ny3RRRswXo0GAfu05KwrHzcEDQ8BkH3cFfVxlSW4b9kVNPa9oEA/WKKPbNYRjNzwWPdpHT0LM0rEn+pk2+mUDlSFN3Soi+u/9XrWrMJY9YR/cNhwbxK7ME2lgPZHvjp/iJeHkVwxSqjOj16YfTzffLsQf5Yk6vHth/eO/LD7FkhenraZbcjs66Q37uQ+Y0P1Snesd/hy9d4dfR6JwN7WvvxikIN0e8WlqC5gGI0bAwnGzIj4ULAVrxi7djVtlH6Nv2a/cjYfJ1CM+RNuqG/rI4ZcRESK3YGtVPFMmXvCAt0R/RFZXzPk3uBN+MFt7yYmPSfKlqrBqPJXn3p/caY9gCv8QN0LU8S3O2HM6KkSZqA7WLJ1JKTjOQS6OelzJ5gOwkLj2177Q3kopbOf0PDsPoypRpwtOOy1Ty9sAGBDZtkLt9wpFHuKlyCS/3QC/bhP2yzYUJgoWKEVB3yf9ygzwcTXlhfnNBFszU8dCaRLOr8/8n1x8lak+skrUpowwuPR;4:6nFfQWpBydSAlGtMEVFdO3eKHGH6aHIbsGeZy63TYL22n/9irgZXjMMwI8cFs+JOZ7H+dV9+rt1zOeY7iD7uQeTyMVvJeD0+Yd7s+kxFnrrCmKfGV1ulbRAOOHxl1OsbJu5xw9d6GiuOGFiP38fu5S6DEP7ptKlrYBhFNCH1oDw+DLd7Gs3H0DmBFFjUkmOjAxsJ4cqZLQhGd97sWvaOYBlcP2uufcN/hXi25h2KsTx3phDcoWTZnAsrED0bUTl5Sk/yRXSSYElto7A2OarpPESWsXXP9g+oJcWT9eS7AY4424yr4JityHv/IEAzHZqUyg1hhWc230Q+qLwi1+AyUw==
X-Microsoft-Antispam-PRVS: <BLUPR15MB01634087807FBF052F935BB2BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(575784001)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(5024004)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:Wm7YGfGDo4Sf6w20kU7GeQwTRWQxctQNW6SdqsCGn?=
 =?us-ascii?Q?u4TxZyxz74MEoaCqyTkPsPZpePEvOvG7PfK55EzJUJoIRIJQvsCmwfVYClts?=
 =?us-ascii?Q?HPU0bzR3PSkS9ry+46Jo0SScNWfQK7WIzUKm8US3Zjms06m3R1m8bPW3YPrr?=
 =?us-ascii?Q?qAV1/nILm3IbEQbpSt+nJRI+jbUbLDt4gofPGu21uDYkZV/2OJaW7JpJN7wB?=
 =?us-ascii?Q?QNP8P7BveM7VPDJWfDj4jGuOJuXwMvDXsyAdRM2H42z5sj/uL6ZtgpYfGldJ?=
 =?us-ascii?Q?uaeJgctoOmoUM5+ns5phwC9paXFK8o5T6xG6mQh+xKpCkrXobFX4Eir3P3Wj?=
 =?us-ascii?Q?Rz6zrbAihATUJz0hylofcch/GewlnssLPClyzXsr9GRy/wthejF5aA1Zu3X5?=
 =?us-ascii?Q?dIodykdc7dOq77U7J+6YBXDujeB9XU26aDkwk9gQl8QxKZRF83Pkx7mhCRQa?=
 =?us-ascii?Q?66+vUs8bFW55ZVZFjDovVSKHS7ooxJPkF6wkEj2ZkMX5fR0TKYmWNdB6kVqQ?=
 =?us-ascii?Q?tO3S18Koxcv0O36pfGegy+J1qDbo9nB97ryMCpQELQl2OrVcuRI3qozEitFv?=
 =?us-ascii?Q?VZINRGnb4iNWtPDRDiiw2MrjWT0rnnKuBCoPC3jt3Ao3XRWHkVbZfJ7pjYZ7?=
 =?us-ascii?Q?A4Idom6+e7BzbwWnwseb1OYSdPfxGHyXkSotIICqJbLmu45J/WnqhzxLTxeg?=
 =?us-ascii?Q?JrgI0adrItxuEboph/jMb6WZe0cDFh8Dn4+MXZHwnK28EVXhB5iWV+rl5byA?=
 =?us-ascii?Q?LvCm7HmUr9j+nh2UdtOO9B6me803dGs+VilvF7hky5b92bRe6aRfoUeDwXVS?=
 =?us-ascii?Q?hlSRG3rlF3x+PuuJ69i1AzuTCGtTywnh4XYT5ay4ceFIQgrIlc3nzOGoA5xC?=
 =?us-ascii?Q?uAROYPG1kMU0xaiSUvNJDzWp3zJzyPCyXvWYO1ZM2qDnrKoKPmHga8/t7Dav?=
 =?us-ascii?Q?cSZHjlX+aiZMeVP27lIRJpQX2P1sKNBfNq0b63nKV58Qd8uGXKcrZCaTPEtK?=
 =?us-ascii?Q?6NsscEw9/9RjFir6gRxr1kmA1vVieQpLcxItKm6jdN7dSCWchqLH3uXvYZ9t?=
 =?us-ascii?Q?X+wcw5j49KiQeZoz+kIZyQBpdqeb3yaODmayAh9MWww/8ATqNZGD0+NxNaCu?=
 =?us-ascii?Q?/PCfMEL+jwASl9SdX3d8nTatKLG8nw44nyAwRnbxCsvEMMg2aPyhkSN/mG8b?=
 =?us-ascii?Q?mOdhvR70E7xzOC0W2X08qz2nGqMQGZmZH73Xw420iHz8XypyGDFxy8tSCdaa?=
 =?us-ascii?Q?c/ZWmUnAOPXl51N5a1FbnHxt7wSaicnhhtFg8DlIkjLGkLp9ofT6/l99YzUk?=
 =?us-ascii?Q?xsEFHBt6q90RoXUj9/srcPWz2IDQKQCbb1opQCfLbKV71MvuziKXLdcD+nxe?=
 =?us-ascii?Q?yOpVA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Hs8oYWw+vfGGLe+kykcEOSTS/KgxyJnXX1Npt4In/6uEWDDaEN8Cjke5ETNvjEjA31DA19mOmyWpKkI+PLNbcdOZ9vnN5gomLI0NFri5a7aufsmT6C/kUl7xyUL0PqsHtS/15Ur+llenCjdxk1gyJ0gmflZ+IQwCXqXYdAAeBpCGdlaYDqbWNAIcumvfnDBR2gySZm3r0rL6FKygCWNJvvjDlG+8J0MJfduy6/MHekilYgdIgzn6CjlZ6Jyidnwt6QKEV7wOEncY63Wy/F34hsrNuKZx0+MUs/QZ8wYq3WpsdrdaBdXSto/mYMKhvuz9OtIKtUSjMMITH17G8agGWfOwD1tNUBEegBNNyiJJeP4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:1qfKmjDNACQxiR7GGUOu8Jiw6hJzUGs2OlLQZ58wyrHlE0U3EXvH2EATRVMpM6cfiBIUcwg5QvJrPqjMSUx+MkrTjxK3GeGSwkNBldS0awilCmPM4C8vCeK0q/NCNNIaiyxNdSpJ+96jwoChHhLCuFgbJzlfgNjuOfXTOIE9l7A+k/uAxA5N+vJFVrq7oa4ndtMMilCPJtGG757QiAh/3Y6i9O0FRs81ekgq57nR0IxlIXQfbQQ836tiXW8QWdlW7MBzZ5UQJvMq7YEPyrpEL5V9fVYGsqk0i/IE4HCCMiSyaegh4uVxvZhA1hb84d63Rppm1KaCjAxHRWtxZRlRfV04qI/B5cdem/o5DP3/wBGnnk++PFS+RypQQtbDOa1XrgV4hp/3ZR7vnKQGGe+nkGQ1XjAfcQpD89lzejNwrSgCMU3d/VW1mDOE1LYT8RPNVR1K7gFi4MEbeol8ykMbpQ==;5:1NoTmUMV8qCDu1SXgZ9/A1NN4KmS0VHVHm/zVCjK5GDvk4h876eGAmwSLCw6OFDJv347APh44f3IzFJE5wcSbzSqmCZTCfBkNbk/WiI1JoDeml7VvvNulpdBU3CENIJYTWlfC5dKKLnAAHAG4cfEnT1mwGC9yVnSzKJ8pV+yuxc=;7:q9u+jj18bZXAkXXHKeR/lKuzo7A7nLW6RTkQrTmYAxRdh3z7B5h4l3SeUl6dEXvUC8cVr72yZro0lP5KgfWOPLP9+3qDjJb4Pve1emy8fkUI//LLc95W9VL6+1UYuhwKdlYhmS4UttrmWW4CBBOiu4l4pZLnQIFkIr5LbImr2Z01GIxaj/1HIwyDe6r6taB+3I7LjjFe/eNieBcnNXCXbAiI2i+a5i7E0x9uU4h7+RmpJnkchcG0SjkTW8+SxKtF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:1FdJGoZ7KVPkJU6pMFxwczmIYGfkK7VdJ+GNFicfd9O1wynXkoffkhM9lQBiEckXfqvAqbyw4luKacLEOYroVqwTZSZneEIGkintEm88ah9ykOCndkVzTgzpcd3EXCzR/R5d5fY6A7E3p4NB/aXfLatPlOqeuhZ8FcKsjrq6lJc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:34.6034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25759271-061a-4921-4bda-08d622fa94e6
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

In order to introduce per-cpu cgroup storage, let's generalize
bpf cgroup core to support multiple cgroup storage types.
Potentially, per-node cgroup storage can be added later.

This commit is mostly a formal change that replaces
cgroup_storage pointer with a array of cgroup_storage pointers.
It doesn't actually introduce a new storage type,
it will be done later.

Each bpf program is now able to have one cgroup storage of each type.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h | 38 ++++++++++++++------
 include/linux/bpf.h        | 11 ++++--
 kernel/bpf/cgroup.c        | 74 ++++++++++++++++++++++++++------------
 kernel/bpf/helpers.c       | 15 ++++----
 kernel/bpf/local_storage.c | 18 ++++++----
 kernel/bpf/syscall.c       |  9 +++--
 kernel/bpf/verifier.c      |  8 +++--
 net/bpf/test_run.c         | 20 +++++++----
 8 files changed, 136 insertions(+), 57 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index f91b0f8ff3a9..e9871b012dac 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -2,6 +2,7 @@
 #ifndef _BPF_CGROUP_H
 #define _BPF_CGROUP_H
 
+#include <linux/bpf.h>
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
@@ -22,7 +23,10 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
-DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+
+#define for_each_cgroup_storage_type(stype) \
+	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
 
 struct bpf_cgroup_storage_map;
 
@@ -43,7 +47,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
-	struct bpf_cgroup_storage *storage;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 };
 
 struct bpf_prog_array;
@@ -101,18 +105,29 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
-static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+static inline enum bpf_cgroup_storage_type cgroup_storage_type(
+	struct bpf_map *map)
 {
+	return BPF_CGROUP_STORAGE_SHARED;
+}
+
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
+					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
+{
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_storage_buffer *buf;
 
-	if (!storage)
-		return;
+	for_each_cgroup_storage_type(stype) {
+		if (!storage[stype])
+			continue;
 
-	buf = READ_ONCE(storage->buf);
-	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+		buf = READ_ONCE(storage[stype]->buf);
+		this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
+	}
 }
 
-struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
+					enum bpf_cgroup_storage_type stype);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 			     struct cgroup *cgroup,
@@ -265,13 +280,14 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
-static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
+static inline void bpf_cgroup_storage_set(
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
 					      struct bpf_map *map) {}
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
-	struct bpf_prog *prog) { return 0; }
+	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
 
@@ -293,6 +309,8 @@ static inline void bpf_cgroup_storage_free(
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
 
+#define for_each_cgroup_storage_type(stype) for (; false; )
+
 #endif /* CONFIG_CGROUP_BPF */
 
 #endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 988a00797bcd..b457fbe7b70b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -272,6 +272,13 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	__BPF_CGROUP_STORAGE_MAX
+};
+
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+
 struct bpf_prog_aux {
 	atomic_t refcnt;
 	u32 used_map_cnt;
@@ -289,7 +296,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
-	struct bpf_map *cgroup_storage;
+	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
@@ -358,7 +365,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
  */
 struct bpf_prog_array_item {
 	struct bpf_prog *prog;
-	struct bpf_cgroup_storage *cgroup_storage;
+	struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 };
 
 struct bpf_prog_array {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 6a7d931bbc55..065c3d9ff8eb 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -25,6 +25,7 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
  */
 void cgroup_bpf_put(struct cgroup *cgrp)
 {
+	enum bpf_cgroup_storage_type stype;
 	unsigned int type;
 
 	for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
@@ -34,8 +35,10 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
-			bpf_cgroup_storage_unlink(pl->storage);
-			bpf_cgroup_storage_free(pl->storage);
+			for_each_cgroup_storage_type(stype) {
+				bpf_cgroup_storage_unlink(pl->storage[stype]);
+				bpf_cgroup_storage_free(pl->storage[stype]);
+			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -97,6 +100,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				   enum bpf_attach_type type,
 				   struct bpf_prog_array __rcu **array)
 {
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p = cgrp;
@@ -125,7 +129,9 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				continue;
 
 			progs->items[cnt].prog = pl->prog;
-			progs->items[cnt].cgroup_storage = pl->storage;
+			for_each_cgroup_storage_type(stype)
+				progs->items[cnt].cgroup_storage[stype] =
+					pl->storage[stype];
 			cnt++;
 		}
 	} while ((p = cgroup_parent(p)));
@@ -232,7 +238,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
-	struct bpf_cgroup_storage *storage, *old_storage = NULL;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
+		*old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {NULL};
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
 	int err;
@@ -254,34 +262,44 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
-	storage = bpf_cgroup_storage_alloc(prog);
-	if (IS_ERR(storage))
-		return -ENOMEM;
+	for_each_cgroup_storage_type(stype) {
+		storage[stype] = bpf_cgroup_storage_alloc(prog, stype);
+		if (IS_ERR(storage[stype])) {
+			storage[stype] = NULL;
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
+			return -ENOMEM;
+		}
+	}
 
 	if (flags & BPF_F_ALLOW_MULTI) {
 		list_for_each_entry(pl, progs, node) {
 			if (pl->prog == prog) {
 				/* disallow attaching the same prog twice */
-				bpf_cgroup_storage_free(storage);
+				for_each_cgroup_storage_type(stype)
+					bpf_cgroup_storage_free(storage[stype]);
 				return -EINVAL;
 			}
 		}
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
-			bpf_cgroup_storage_free(storage);
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
 			return -ENOMEM;
 		}
 
 		pl_was_allocated = true;
 		pl->prog = prog;
-		pl->storage = storage;
+		for_each_cgroup_storage_type(stype)
+			pl->storage[stype] = storage[stype];
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 			if (!pl) {
-				bpf_cgroup_storage_free(storage);
+				for_each_cgroup_storage_type(stype)
+					bpf_cgroup_storage_free(storage[stype]);
 				return -ENOMEM;
 			}
 			pl_was_allocated = true;
@@ -289,12 +307,15 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
-			old_storage = pl->storage;
-			bpf_cgroup_storage_unlink(old_storage);
+			for_each_cgroup_storage_type(stype) {
+				old_storage[stype] = pl->storage[stype];
+				bpf_cgroup_storage_unlink(old_storage[stype]);
+			}
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
-		pl->storage = storage;
+		for_each_cgroup_storage_type(stype)
+			pl->storage[stype] = storage[stype];
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -304,21 +325,27 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		goto cleanup;
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
-	if (old_storage)
-		bpf_cgroup_storage_free(old_storage);
+	for_each_cgroup_storage_type(stype) {
+		if (!old_storage[stype])
+			continue;
+		bpf_cgroup_storage_free(old_storage[stype]);
+	}
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
-	bpf_cgroup_storage_link(storage, cgrp, type);
+	for_each_cgroup_storage_type(stype)
+		bpf_cgroup_storage_link(storage[stype], cgrp, type);
 	return 0;
 
 cleanup:
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
-	bpf_cgroup_storage_free(pl->storage);
-	pl->storage = old_storage;
-	bpf_cgroup_storage_link(old_storage, cgrp, type);
+	for_each_cgroup_storage_type(stype) {
+		bpf_cgroup_storage_free(pl->storage[stype]);
+		pl->storage[stype] = old_storage[stype];
+		bpf_cgroup_storage_link(old_storage[stype], cgrp, type);
+	}
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -339,6 +366,7 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 			enum bpf_attach_type type, u32 unused_flags)
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
+	enum bpf_cgroup_storage_type stype;
 	u32 flags = cgrp->bpf.flags[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_prog_list *pl;
@@ -385,8 +413,10 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
-	bpf_cgroup_storage_unlink(pl->storage);
-	bpf_cgroup_storage_free(pl->storage);
+	for_each_cgroup_storage_type(stype) {
+		bpf_cgroup_storage_unlink(pl->storage[stype]);
+		bpf_cgroup_storage_free(pl->storage[stype]);
+	}
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1991466b8327..9070b2ace6aa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -194,16 +194,18 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
-DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+#ifdef CONFIG_CGROUP_BPF
+DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
-	/* map and flags arguments are not used now,
-	 * but provide an ability to extend the API
-	 * for other types of local storages.
-	 * verifier checks that their values are correct.
+	/* flags argument is not used now,
+	 * but provides an ability to extend the API.
+	 * verifier checks that its value is correct.
 	 */
-	return (unsigned long) this_cpu_read(bpf_cgroup_storage);
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
+
+	return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
 }
 
 const struct bpf_func_proto bpf_get_local_storage_proto = {
@@ -214,3 +216,4 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 #endif
+#endif
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 22ad967d1e5f..0bd9f19fc557 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,7 +7,7 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
-DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #ifdef CONFIG_CGROUP_BPF
 
@@ -251,6 +251,7 @@ const struct bpf_map_ops cgroup_storage_map_ops = {
 
 int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
 {
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	int ret = -EBUSY;
 
@@ -258,11 +259,12 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
 
 	if (map->prog && map->prog != prog)
 		goto unlock;
-	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+	if (prog->aux->cgroup_storage[stype] &&
+	    prog->aux->cgroup_storage[stype] != _map)
 		goto unlock;
 
 	map->prog = prog;
-	prog->aux->cgroup_storage = _map;
+	prog->aux->cgroup_storage[stype] = _map;
 	ret = 0;
 unlock:
 	spin_unlock_bh(&map->lock);
@@ -272,24 +274,26 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
 
 void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
 {
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 
 	spin_lock_bh(&map->lock);
 	if (map->prog == prog) {
-		WARN_ON(prog->aux->cgroup_storage != _map);
+		WARN_ON(prog->aux->cgroup_storage[stype] != _map);
 		map->prog = NULL;
-		prog->aux->cgroup_storage = NULL;
+		prog->aux->cgroup_storage[stype] = NULL;
 	}
 	spin_unlock_bh(&map->lock);
 }
 
-struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
+					enum bpf_cgroup_storage_type stype)
 {
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
 	u32 pages;
 
-	map = prog->aux->cgroup_storage;
+	map = prog->aux->cgroup_storage[stype];
 	if (!map)
 		return NULL;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b3c2d09bcf7a..8c91d2b41b1e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -988,10 +988,15 @@ static int find_prog_type(enum bpf_prog_type type, struct bpf_prog *prog)
 /* drop refcnt on maps used by eBPF program and free auxilary data */
 static void free_used_maps(struct bpf_prog_aux *aux)
 {
+	enum bpf_cgroup_storage_type stype;
 	int i;
 
-	if (aux->cgroup_storage)
-		bpf_cgroup_storage_release(aux->prog, aux->cgroup_storage);
+	for_each_cgroup_storage_type(stype) {
+		if (!aux->cgroup_storage[stype])
+			continue;
+		bpf_cgroup_storage_release(aux->prog,
+					   aux->cgroup_storage[stype]);
+	}
 
 	for (i = 0; i < aux->used_map_cnt; i++)
 		bpf_map_put(aux->used_maps[i]);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ccbff4fff93..e75f36de91d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5171,11 +5171,15 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 /* drop refcnt of maps used by the rejected program */
 static void release_maps(struct bpf_verifier_env *env)
 {
+	enum bpf_cgroup_storage_type stype;
 	int i;
 
-	if (env->prog->aux->cgroup_storage)
+	for_each_cgroup_storage_type(stype) {
+		if (!env->prog->aux->cgroup_storage[stype])
+			continue;
 		bpf_cgroup_storage_release(env->prog,
-					   env->prog->aux->cgroup_storage);
+			env->prog->aux->cgroup_storage[stype]);
+	}
 
 	for (i = 0; i < env->used_map_cnt; i++)
 		bpf_map_put(env->used_maps[i]);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f4078830ea50..0c423b8cd75c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -12,7 +12,7 @@
 #include <linux/sched/signal.h>
 
 static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
-					    struct bpf_cgroup_storage *storage)
+		struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
 {
 	u32 ret;
 
@@ -28,13 +28,20 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
 
 static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 {
-	struct bpf_cgroup_storage *storage = NULL;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
+	enum bpf_cgroup_storage_type stype;
 	u64 time_start, time_spent = 0;
 	u32 ret = 0, i;
 
-	storage = bpf_cgroup_storage_alloc(prog);
-	if (IS_ERR(storage))
-		return PTR_ERR(storage);
+	for_each_cgroup_storage_type(stype) {
+		storage[stype] = bpf_cgroup_storage_alloc(prog, stype);
+		if (IS_ERR(storage[stype])) {
+			storage[stype] = NULL;
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
+			return -ENOMEM;
+		}
+	}
 
 	if (!repeat)
 		repeat = 1;
@@ -53,7 +60,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
-	bpf_cgroup_storage_free(storage);
+	for_each_cgroup_storage_type(stype)
+		bpf_cgroup_storage_free(storage[stype]);
 
 	return ret;
 }
-- 
2.17.1

