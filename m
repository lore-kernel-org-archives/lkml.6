Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676A7C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3D523FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cF+JyPOE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ekiznpXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3D523FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeGEU4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:56:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754208AbeGEUwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:39 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KqIlx026792;
        Thu, 5 Jul 2018 13:52:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=uQbcMIAUjqNcAX0WW8J0f8X7Oq7AsoJHe5fhb7m17+Y=;
 b=cF+JyPOElSMu4DlgLLGsIskATgBDFKA1dAua86iIgqgKCOyDFJh3nesfLYFI0QC8wo9g
 TXLIuF/jXqaViJubH1iSAp6POwyJwD5bTEKqxofVjAQgq09zYLy7QZYJB4WH5HxdeSDb
 FRQVMMbYe+ZmSELAghybRWxBTTo461gMR1M= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k1q6urqhd-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQbcMIAUjqNcAX0WW8J0f8X7Oq7AsoJHe5fhb7m17+Y=;
 b=ekiznpXIQ6G05nTKkm411kIcHiIA8qZyfagqkGLOxq48gpH3QyqCTyV6pc5eX0XaZ13Q97L+0zxMvrfcf7+NoSy+2rFG1wL+A7Sky5FHVLDfoebo4gRAAkowmaBMrA71FBQqqGtVBT9j0kAnKFn4z1gFXv/iJiUgHVJvSoXs+cE=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 03/14] bpf: pass a pointer to a cgroup storage using pcpu variable
Date:   Thu, 5 Jul 2018 13:51:28 -0700
Message-ID: <20180705205139.3462-4-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0851057-b122-4972-98e1-08d5e2b92dbf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:lYZ1VCTF80+x7CFDknfKkc6H4P3VX7wi5rEcpWP4cQxXCD2gXpzCJikQkCaFxXApbodxClze/w+v8yiwpa9P4rXIWeOMmRY93nljkdGmbJ1BOwsufF5lD5ZVEKlYVse081q3jYHhC+OIIlRgcV/aiyR9du0DWPq/5aoYJEUyCPoZddXi6nNRFurp46K+/pzUvThLHU2w8o9k5IE0++EODR1OeNOByh8ZpoZAD4A2S+IHdMpKQr3ucauA5KpFLmMR;25:BvBzmFIOeeHdlrpidISm/qZo6OPDzBg93xZPjyuPNziCX06E2ItSASKo2AtowA8MZan6ykCsyA3YEXDreQJYAF4E7MlHwSt6uzoblwNia4uft52CN4f9KTrlRa6eM0oq3GNcEzul06p/DLV64WVLfyMIlzB9aOipad78GXhB+jFvOg3rzghlwlYY+IqLpRL2Zddx3mmL/hj0bY7JS54afXiQnGRg+OOUGaQiMPl7aH1bMVXHKmxyRbuig1KNK/sqS0gVz4yaVcojXcGluH9PSM9hvYZm+vbnWdkTxt8zS68YOd95j0dnGd2mIar9II/q4Bb9Jcwj2dX5k2jnhql2ZA==;31:wcxpueN3/u90GaQFBFVtPU7Fz0oqf2kzNx4mci7Zg+LsDZ+lSyB/TCsabDGAPiR7o/5Mud/Q5YCGGTBcIgSAqxTJxaSWdtJiCIMQOlMG4Bp9xWAOWSJoUBSxPFp8h898eXRqZGBY5RmeEegPHc5F64lazEvJ6lodbRFOJVGJMUUfysYw/rcuEE0T4wJRzWyi3CtSpjG0jrMau63RYoVWoDHX5PVoQXaJBpJgbbrecl0=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:B4685QuW1bVY8em3+qUkXLO4yh1dDk/P7jv2AEvgCMLUfXhP6dfzInZpBmkltY2vqOueyUyJ3uYuz30nq6jtJ32gz5gEbdR4xwBmaCf+CJPR3YMrcEzTKlLjj4Vi0iAet0qsg3A5w7UhAvhXhd0h6C4HaVqtpyJ8Ni9p0vstFF75V4Gsppjh5qfDok1gpTrMLVtZUUlB9doGJSlAkpnwkhPUeM9ntpLXbDO8Waq2BrLCSLxUwzyUNO8jvpRR0baS8dkhNqlZDvGMDuNyzItb/SpJ7l4DmXU6gsd8IXGspN+Omv3onKPk0+2lnxMuFZuAva8+bs2tVR1Le3Pq1yejIAtbz+tJTcMCkh2HU5/grlxbIqvCApv2xCiZNNpCZcgaJEiw+hpi8mNjXPSDOQBZPDy9Ny5xZ1R50trsAf03KeQyB2LZjn9uxQEndhFB8cj01z4jQXoV3U4o0prBEgjZfnhthBNf1BihXtPK17ZP+zXDzI5ggTOS7pxznmEzU0I1;4:4RWa+5kVX69dr0dK63lnbiwB30T6U8Bydhi1G5aBQAt9AIbfgNZTj/plRlHGDdGI8gOv5K0C4kB+9LyrR9zZzlCJSxaLwUm78yF2joAVss7qdEXK03VYbfw+zCtsR9puZhdqFRTtUGTnDSgXDe2l0q3GwRcR0Eu3Nwoe8uYKEW0Mc6a4gOK9FO1XX9amH0gabL5JmWA+oBkSFEzkx9yyUvbaU77SO4uazRQgBrIbDNmXbeAiHKUk289cB20cqSLcQ2+CHu+nMQ9cqz/tVA+hT5+sSjrf1sSuAlfouNp8F3veBeVeh7MCq5qYzcywSGn1
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166D9E2EAD82EBDAE7CDB6BBE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(575784001)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:dW8IJoYFDonpAxIsg50YoHu6EgZQjxp9LWdLSJKlj?=
 =?us-ascii?Q?RE/fxcDwVyL6ZTqCKW1At1CoGNRtWI7vG5im28le1ZBF1aicssmuxxlml3XQ?=
 =?us-ascii?Q?dm/lOKv/3h69EqDSM6eZLfzTWQpPg4DZE3gOL3BCHc9JS/jIpVYXLTE6ckhR?=
 =?us-ascii?Q?79KWW1t5gaFJkftHEnSOrd50E1c8Cj5mRi6Yp/keyHTkgApSBXhurE4VM/7o?=
 =?us-ascii?Q?2UhpAB5xP52E36Yh+jIVujt+0vHDiIAFytknvXCLz/iozHoCceF9d3lGm0yL?=
 =?us-ascii?Q?Z0sThOgF9G+Zs7a+kVYoGWlb47l3mnlX3IOAATahx/sjwoIpUDdIYVrl/JK1?=
 =?us-ascii?Q?EawapUdVM1r4HKGL+OBzh5t+kxxJNBpxcl9JzaLw491BA8HObprRVzwyAdAJ?=
 =?us-ascii?Q?xDQkZu0ABJTIq4kIh02IWxkTwX7E9dmkO/LZm4DtdsrHNgfwvMToyXNxHDzm?=
 =?us-ascii?Q?xo+ya8iso19EedBPTovhGJymDNBY+s/seAnP5sTUi7lYU99FK5KDyTOVF4Yd?=
 =?us-ascii?Q?O3PPVNSQYu3CZ2zpvYfOBLLmx5CXRUNeaCYD7cXZuh/Q6l3aNDF41oUaZHU4?=
 =?us-ascii?Q?jhhlTaPgjiR7gMBCImaGBevQU5PvlVhOFL1E2ODtd+j78aY+EWX0Zl+8rCIq?=
 =?us-ascii?Q?yESzNsULrG2XX+wlNbtoZKVhFM9j76lvHCLX1bWO7bb/hHGnCd4je4eeecye?=
 =?us-ascii?Q?5dguOORDd7ZTIhQex5Ig+Mo6cXvdqHNbgBhCDGrYIoZmKH8W7maLlZZfP2Ft?=
 =?us-ascii?Q?OmTzQeXXKGReAP5tV9Cu42VoGVeb4DQVgxmVU+plt7Y6gSoDjqufjA0v2o/T?=
 =?us-ascii?Q?JdBRD3ZQO+oTvnGEc21dGJh/EjIHZVvY8O43d6AuJjUWmikxX/jdhMVmYkJR?=
 =?us-ascii?Q?hlrMr9KxDoPtZt72OU96pzgHSNhvR/O9+px2ENwWiKng3fp+El9NZYymvRP0?=
 =?us-ascii?Q?YY1lmu5QJfKdHP6fQmn6+nu6zKKF1To6k5A56h+8ySgwygL+Z0cmnNU3EC+3?=
 =?us-ascii?Q?ETgYk76jlOR+IolMLNRHuZawhqimcSxhzU0D/Bnit7aj5i+y6Vixxyw4Kq8G?=
 =?us-ascii?Q?VAkX/gu6g3VSpfoo0PJXqR0el8JKutCNEZ2vqalYai1S31rjkmXScQsuUqlF?=
 =?us-ascii?Q?ntl++O+Bvhaog6POVUJC0VebQDbKIFIqT/nPcHiWeYtNSiR7zRw4uqbs42zB?=
 =?us-ascii?Q?WXkwnACOffr7wFDK6VBqag8tZ/dV9zZIfT3n0he7JOVVjRgaql2yegfQk13G?=
 =?us-ascii?Q?zHvm2LdrJA0gRnxoaHB8RI8Vb3XAuVIK6w+MC2c1oMzmFlvvxlly7j8jh1aH?=
 =?us-ascii?Q?ibQkzguJbtrO4QNl29gfQtuW9ZWRfAgCUFlBFVeJV4n?=
X-Microsoft-Antispam-Message-Info: st3FGeueF+8I27n+UBlW4/5+EM4BTvMEMSSpNjiRAEDLlV60xdGJVoi26b/6Q/f86naxYUVOinuY6/UAKxJWRQGNsa0qmqNz1KJlOgirJHf6BwfZgjieqo1co0ZwNRG3HFZHbxX58kUar2Crq0nMGjmCyE+RyeB6sPZ3p3pkMgziggZFyx/vJitrF4fgdWUEPDsDpxTAHHZtrSaOdEDqJo/c/0SaIRYGK17RM6cH4tRmpFeERdYVWzxOO9y6b7YROaG667XAGEBcx7T9qFI2g7DkpFPFA8KsWFPhjT/IPFJwe16LvKDIkpMg4BTwELRV/gFs4/JwHkFoO288q0O4xHEjbC81cedVl4abZYLSSyQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:403VewRrqW7OPayE67p5Ig5KSE6bu+1GlEsO3Q+2GeTGZhnbEYbX9qTrVRYEjs6cWUD4SRcE39q915KwiX6OCroQy4L5AoowxZqyRZyo3KMbZGjeWgmOzUhWNImzQ2gmxFSTZ1DJZEEH5VV2mp3zThejs6f87Iss+DijNCxibOke8ehs+Q0SVm6ZOOCczKqOkDc7ZDw7Uhk5LVlxzWNWYpmOcwIoy+q3SXlF8j1368Rdg70DeB4auC57/LFMTSB6dJ/YgUSThEKAmhP7aR3jS+OO7swY1fB58wFQAe7yY0GrEEzWgka1zcULwuo5jgQgyVhBJBvQQ+o6+lgYFk/zVG/INk38fp4zZi1FClY33F7c7rIbhrnDobF1gjQjU5RT309ELdm7DpgmzsKuLs5ZlY42W8fpJkNnT+QilldzJ5Xq4TpW4z7nSKProe5RK0JP5oeAeyjc3M8jt5gAgqgcbw==;5:f8vSZnP8B8N+suqf+fL9gTk88SlPOOJ4uL40BaKuOCGHxdsc+YEBgi5TQtF4DZ4KD0+w46hTh26SuR/FEuuxiPiIqF/ZCpW8bLBGKCmZEAAPPKISn4L4AfBMZSdj/3+sJ7AopgkvYeGdKzrMQ+9OsEKvQiO39owK7ePi4Ltifqc=;24:T75bKjX2kSK3HlTtuAnThhbTgw26whhds3lOd4T7vpFSGDBP/yt4zy/zm3zD/HyuhGW3OmVvI8+vQtcbDcxambDx51c1ZJGzBwHgZ2xmiGU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:qim2mqy7Wf9TBdweCKRKY1vkq+wMIRraTLHIgSM8wnsPi6uAjv3Ms+MKyz3wdIQkE4HIhRy1S4N9yzZmpNYbtaucwI7Hy3Id5w0AJSi4CrH7fPYMG1epdYboifXoTXwA4j5Dp4noUDzICm0wKLc4qLfLp49W8t+3qIsHkTUU5thI0gooOhJPWyEdjKzcEoE7M0HzG0if8iV4EfpMtjSorSBnh9rzE+Ts/yVGkvQF85wovwUsfrBkS7r8hdQMK3em;20:6MtpMpXgz5Gpja4nQG4Ty1IgLdIhEzP7PMHDk0EFKwVWQtjmr6liIiG5YhlzOtSy5aiKL05J00EgZx8EtPP7MSa8jcF0ORl3Hdna8MeKKNgfZUHDaG+6mj6LRuT50gprxD6hQEL4GdqnMQLRK3MIuKYmtaGTLG1H9kaW5ZhS/R0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:10.1506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0851057-b122-4972-98e1-08d5e2b92dbf
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
index 6b0e7bd4b154..ce77a6dffb6d 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -3,6 +3,7 @@
 #define _BPF_CGROUP_H
 
 #include <linux/jump_label.h>
+#include <linux/percpu-defs.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -20,6 +21,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -96,6 +99,17 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_storage_buffer *buf;
+
+	if (!storage)
+		return;
+
+	buf = rcu_dereference(storage->buf);
+	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+}
+
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
@@ -249,6 +263,7 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 940889eda2c7..38810a712971 100644
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

