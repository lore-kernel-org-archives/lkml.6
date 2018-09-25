Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2425BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B321D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pR4T7sfo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fHbwdtvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B321D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeIYVaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45056 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729475AbeIYVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:13 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFJS4H020684;
        Tue, 25 Sep 2018 08:21:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=NqPqlfhxve+a3pQiztwWx+eFuF2wTvf4gotNMVXJsD8=;
 b=pR4T7sfoTawoSS1uKlDFuFt0DQjX0gQIY/VHlftrOOGoWGjS0476ltt5WKo8qDdH/+Ff
 4VNpy1gPUEtWAPAsmEqhxEWNuqYF3cWiRqi6jotDJryPUAiK6EaHkIEw6Z9/DRKBKemS
 /qbVz+AM6EBfekPRkWFbT6gTssnzpR70cuA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqp018f0w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:52 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 08:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqPqlfhxve+a3pQiztwWx+eFuF2wTvf4gotNMVXJsD8=;
 b=fHbwdtvH5Zh4n9qIfUGkcq8pDFJo1LW2pG273Cec5PM9JUbBynJRkJfW/1PwEQ524ImLOrCJSR52tLrQQicF/6Kms2LII4ICub5yZwhyW2cQsz0ovLiUNrUarscY9yvx0YtWyUGYupJ+lqQnqZ5EYQD6mPfx5ZMQ07EiR71+Wf8=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:46 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 10/10] selftests/bpf: cgroup local storage-based network counters
Date:   Tue, 25 Sep 2018 16:21:14 +0100
Message-ID: <20180925152114.13537-11-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25d11b2b-0a0c-46b6-c836-08d622fa9c41
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:KHQyRAsThkUAJQrV8Zw4LCfg7aBpbSc0wDDWjmty6dYd6jyDJT6VlxKAPBVXuppOFlyUyBj3Lo1nHkWR8WiMcwWb3WO60qpgJC4cdy7O32bB+kEY9vh64Lt9Dv+wZ/QsfWIr6JtYpvudG9N2dwx+3uUEEeOMGQ6Dp9wXuZ6TdiuU1pExexdi229SLh1lK8hkiu2N1mY6F+g3HNtnxqKMi/fSvyYoQeR/nXjZhUh5W9V9UEnj2XBKP6cYJUJleEoN;25:QS4prBWzckFU0lDeEoG0kggfI/s9PLdPUCEc5XjVDGuXCMEhf2pZCPZ0kVtmhtfEzk4I1vUzVS2PR11GFG8p45jJfS5nYRwtTT0bRKjAuM+LZfmCBXbsApZmF01vr3fV5J15gKthaQYdVLkzjl8fuY1Qh2chOrsZvXm4y0u8tcIc2LrKhZQnN+RiSD8CShpAu7ITBukcjda8uG2+HtqNnBVn2POayXYpMxxJEyasfaV9oiwepLifemGV4ULhCVQrIqTavQAjyVS7eQoapOWl+qynEQYfjm2q4JkBnhWqIGKRBJ7+mcpKq/s9dy/bKfD0NPilhDT+sTuqVw/8yRCfiw==;31:Nkvj1IYkV5PUkpSCkfgTQI5P7hWI/171WkwW4Sikc8H909ZqmCbdsMi6osW58LnvhFVkX2j9bx0OPwdZNkxq9zZCVopjijjmOIZmi/JewwQV7IBM38BhcCHhUn4yp//8fdH7r9Ut2pWJL/4WP6IBFgkG8kvmU4lLSOsCMsWw/EPtt51SZVEGurazbX+FwukxCMjnAuzZNhkOzrRXvTSorC9K8JG6Pq8CGbuVtOl+f4E=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:KJnZ8K3rdQDzZ3h1fgXZlDCPrtbMF9H/z+/MqYfxqgUhrmyEkVjqKpqZIubFKucBTBEGun2z7T5KK4q4hZDWpsLE0nzy0dSA4qoxWNM5821tOyrUYL2nA3VRFJ3s3n4VeKJAqIKolkxZd85zEAJo68xNCYGFMgur+zTmc/BZ18nYDjAXr8Gf2AYmAtoKXv0QEcqq3qRGmWFU6DFtdNeVC0nG7J9Lzshab/UxG0TzRh40gF1fUAkcIc/MtPnfmzw3rxCVim+IAPrjkTUA1UDSfYkMk5xMQtveeyUFq19Xa43pT5wJKa3X1hwXiPhccFs+9VOt3qbizGbOptSn7w0wu7sAJOyKMR2H5lKLxuPYXjaWCLA9qxk4hxfjs3F6wbBdrGslcQ6L85uIvj92wAAVGf846PmQopex8ym2xbPq/SZ8wm2dgEO0jAv32lsV6VABLlQgXsYc3kUFQtONOw9kou+wDEscvubYAI7eroAPl1/MWD0XELC9onhwJXr72Yct;4:pgfveoTROLat9eFcqNTXCZuEFoipkjfPUvr0d8oSY8WFlb8bQZnzBU6TlNEbnqxr5KmeyTDNWpdsmfuCY7Y51K7o0ZH0BXnEe0muwkXp6hLTNw3R81tE2FKCzppKfcfh+uN4UFCNRocLcdRRjhXeqMO7+OFNswa0AZ+mYVR4hr9fWxJRM5RiKvEIk8sG7MwqLFLIP21GDHm2sHQIrBzjqAWnFx+SaQ1RfHdC1dJieHQV8D13lCtchDYxkpn5p+xia5Xamd1JSkVyg0bGmI1JKcqI3hZEvBiKPREmmrBKTIW1x5opyLP2tJEOl9Ya/A/Hv45ku20CkDIpg9+XTTSn3z8L+PnqcL9tfwFD0SG8I/0=
X-Microsoft-Antispam-PRVS: <BLUPR15MB0163EF4D7FCCAD989CEF8AC8BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(265634631926514);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(5024004)(34290500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:uRRGk0dV916OCNm9WJGluR0fh0E1WGW4JsWvcm7ng?=
 =?us-ascii?Q?RXHKVyRLncBVpluZ0CO6albyibAOY+6wBsydjCtL35ra9/mxe1YZjsH34Hl4?=
 =?us-ascii?Q?kGnCzdq8R6yCj3VRLhPHB6CsghvA881fp6a/+pEgyKa728whVUYX/xviKL28?=
 =?us-ascii?Q?qgY15Ho81T4dtmynQOA+nzC/dTQFkDi4B5cW/zAfeNTaKurMkxwYF0edsiKC?=
 =?us-ascii?Q?VxI6YiQwlzLuGNpISwWFR82qdhxNI+p5I4BrxgYkpw6PqwQYJVpNqdkFOUn5?=
 =?us-ascii?Q?4wBk9Yr/4xdEtyb9gjLOIMawHPW7F85v4t7MRFNCDELVFR+42pBl+VeA1ErZ?=
 =?us-ascii?Q?FySowYDEWq2EYmpO/CfvOzrdthy7SW1WAUE7AeSzrTNW/KA5LdaSdc2IoMku?=
 =?us-ascii?Q?0E6MhIuOiwuMsz5fqH+E8ijqr+7dDEbBrduZWX69jqR/6z7ie+yXTnlczYIm?=
 =?us-ascii?Q?rCLDLuVEhHPN/DqZPrusByjGBU0h/uwYCVfUmbg4i4vPJRM5Ac7RUwlV0Ly7?=
 =?us-ascii?Q?Aqtj0oKSKiZ3IQXrHLZcZvD8FN8JdMk5UbMvrWPGfIIEE3gvNwOAOq5UinVw?=
 =?us-ascii?Q?V1Z+7Xf7CkFJXcsfULrvizRax+7FUhgcaED64zhueEM7qoA4weNEgcJZ0DHp?=
 =?us-ascii?Q?UEhMyG92WCokU9MHpf3Z8SCpqJqeI/L5h2uSm8xP3JaU8Zl+3/FJ8Ia7T60J?=
 =?us-ascii?Q?CBxWwgHP9zUFfLd5XEYfPZ4BD+GUdhb32bXrdSw+qDXQDtEuG+xwl5V51SxN?=
 =?us-ascii?Q?YnktQu2awjIwEct7qy/GwT67MrXZQ61aUhniekoFqoQ9Fh0kEv2OaCTM/jkz?=
 =?us-ascii?Q?p89N16h/pZOTabFxpcLkLPGPLwuQtfGxDNkRT88PJgUxR2Tp+KanaVilm6th?=
 =?us-ascii?Q?gsU1xqAUc4dP6Qbk2dT2RO227tMoOzt6lq5+P4KKuLTCDkxq0RM5bFjDAkyB?=
 =?us-ascii?Q?IUNCvdEn5Bfhf3R4Yoq5VYlfE5zrCFnHRjj6xDbfI2BuVzE+YOqJiGxbt21h?=
 =?us-ascii?Q?cbLlhIOIe4o+YgFUsKSx6BDY/vt9ilzVeocLUjoPAQU5VkxHFTYjg9BEMtIb?=
 =?us-ascii?Q?DYSI6Q+AqpQoqdZHlrj/BxBlFau6ncmeOBtkx7gvVajKy/GJR5BgA4ed75vE?=
 =?us-ascii?Q?lEX3rSEnQMYTUT4C7mWpzLOvYlbpzQdigSZjBuLbcRTNCSiZodXpaYeXSLm/?=
 =?us-ascii?Q?I//ubkhCYP3XFURu38wMPIlARfPcCGmSysH27M/dgZZyUOAlm0l7gFvpwxKU?=
 =?us-ascii?Q?Pl0OjKtfMwwwEWfQKIhgrVN4qRMPPADDIpRdgvht8Et3BAbVtgRiBhT5Gebu?=
 =?us-ascii?Q?xq7WYZScoGn2Tj9XtHCXxY7dlbBp2F61GOOqn8Nr2COoD/RUgjCJJIwIatjc?=
 =?us-ascii?Q?LsVWw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2F7OOg5cgcBPZMCcYY/PMZMBlT9Q587N1A7V+jCpa26OiiUCJznAFxB8jMkMDcIflSxCmbrz7+QHE9ClFTV1KeH+TsPUdu4C9TbwYTBSm6J5gGa3n97aHHEqwpdAKzRfEnAHycg41HNMwl7xaJzpObC1ZL9u/2Hxalko47fzJkiA9p4XR/EKIG0Ej3MFgTaEjlALhsM2dNdwQhbbe2OeNUGEjETl5ToolCAuRSMxyTLBQJrfyxMUZqC4xLJE4taTCmQ58WjccxD9yiIzX7kNyzPG6adCJVYQawVGKPZoQToejzGQo89s9mJCgEF6mMonNtVPAQOek9OgZzQbChva7YmLKAU8ozBTun2djZxfqB8=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:Se2+tajx/H0zhq5+NUekSllMw6taCWfgWtpeMervfmGYukSFnfzyz0TCXN/mNcZ1bu7C6Z9b3ORRRi5dwh88TdJdGUTDJVvKXT667L537FNrq9imHnp96TBuCkd3acM+2KoZaxAOtnuCZpk6pxRwFu6k5jj/lTPbqC6aAkoEBXmclLKzlsScqsgk5EaXneJpgNfgbXfXJHoTBz9Ih0LK5E4Sw3+YyUIEwtFdtonDapHK20rGKjViCwje8ZpsFeWWhkYzTODkkEQ5suw6BdJ249WCE91/2sEmfxAIyUN4Tiw9Abc8+wM6NV5569KY3rjNb31PqSuAqkzGqVsEXL47So2e1wj3t9svQ7msfDrKun9c6NW81IEuSO2xy5Oow/rPBzmLhnovOc6eoaEhScS4rSYLyYw+yRcIR8Vh//ta5gjhkVbgTs2Zr7Bk6r2ixkM4bD6jK96EVyjl90iXQMksoA==;5:z6DzMTbns5o/KTkaMzSsQpdcsl0NSgIyWqvfeN5sxRN4DdTwQ+XftPXlgT34J6sycSvSmXBUSHoCpNgHlbq0qX6pBaM/u71NrAFLa3FPocYnnBinq0h/OaXI4rnZfFE5BZskzsuKsVj+wlS9kvSQ/8I8hcGElL41LUdO7yvjR6g=;7:U+WfN0dMxr9YnxZD9QkqzYvUszrQr28JVH4ajExh+yZspRrc9K3Xac6lRHiADm6DZ3zR+Q/XkkwgxfcxEo1XcHUyefuJ9ulFlnsP4BxMDKdEYGDn1NX189BI4SNyF5NGlqDvkCiTXLhkIm1sdnRDlrVYzjAaaO47EdoLCXlu+Z0VUwlvo/matFtt1+vqCkR6sKDUkW0vWhA0DleTdHn4FK+YGGJtprLadoiwrOogsm+AKXftkTZ4jITj/NwsXsjy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:kVb/y0owe0KnwSh0Qw/RvBMHYS1wjHP4fcoZln0K/+hDltxoCh+xb10K62Ereoa2NlBaL6mNlP3qO+7A9qEL5e2pLqUeO8HQLpO8qClzWkUMvX7OBc8ZjlID7kgts1eLO6KCvIvbPqND/nE8qVKYeDkInoMxlCC8HA3A+yn4msM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:46.9610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d11b2b-0a0c-46b6-c836-08d622fa9c41
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

