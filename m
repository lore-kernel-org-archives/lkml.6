Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF75FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C4620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KgqdLDmC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IuT8xu7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C4620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbeHAX2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:28:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387630AbeHAXZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:28 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LbFJU024053;
        Wed, 1 Aug 2018 14:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=KgqdLDmCWkdzeCHpt65z824VRWtECHpai17hRDT8sRG218cUmB5V7BR+OGZOEleZ1lEE
 bIxICHso5XEynwCotj0cYvgneyRMPVLtSjV0YFBb8w8ifWehhQiDxy9TbmiC8fILKwFv
 69IF4Y1WOlnWNDouPDgeOIPGKgZxNiti/mY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kkfcvh53p-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=IuT8xu7g2ZaZbpm3PzANKIUjvdwXxex0t0MDkeTW+EczOdayf1hI0Ba5phKokJCtNE2Qh8lvnPjxVHFVBl/HZa2uIf2beF8ZhTV8zo+R/4IRWvMFATW0rn8RExkKB4ODb+h8mnB+cpUDpbu+YH69trgmAG5CSwpyAtCTfqwbhcw=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 05/14] bpf: extend bpf_prog_array to store pointers to the cgroup storage
Date:   Wed, 1 Aug 2018 14:36:40 -0700
Message-ID: <20180801213649.30751-6-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b2162e-1df7-4452-3169-08d5f7f6f371
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:D53sbaBD/EswqajeXzqUMiC1J5T32eJfaUPfQ5B7DYfCQWPbZbgIgbFKbdhj5+DbHch+kApgqd3ihyUfXQUhu8gjuUvm7DJLj6NECIUZngyai0GMjr8EKBkOAJOXt0opvwTRAU5eJ/V7EenpFFpt9lwjkLKE/7OyU5mxqD1tEp548sPMVQ4T/XPHjWRAwVbiza0dG4sjqJa4vyDlSw+RQvcBEN7ghCHYwTVJqzZqW5ejNYRLH2nKkGmMeb/lSUuI;25:ZB4yWUd2nPQdHw354C9XMWFTP/xpKVw8E+4wB3Tmxp4ZnrNQMyiBCp0goC5J4JFJcnmJIk43U9nRVJ1DKqDnWJtmFtc0b77ZMmnuFRR7BT58VM2CFyXUKwLWX5J2GCJ8Zhng2cYJMeJaX7sqtsfXb7KiB/mFozWa8Xg/0Hu6tih9xT9ZdXcKT9EcTcOKXXGCuA4t9xcuFdJWnpQjU6Ya5axLqGFaK+JW4xLyrvqqXlpatNvAMfZOuzRB/WNfDOfxhAIM7wYgZsTsKQvtIbryA8yE9thh6xA03E4u8Es1ynGc4WpNyTF0ugenaOMvidIrfIYZPoHgD3TbMVbdoH9R+A==;31:WanUDYEwav1C/sdlgoxHh9d6WpoCTdeQWlL4WBndM/JF3qXSE10jQtusQ7M8cu22b992KDgLf/7yVSWJdLE84lKMl3k9EE0/yBzu9hV+lU/9fP+VKYIDYG9ekJcbmE79dwtSzdyn2YaxW5HbwYiSlMj4YayF+nysINOM/tgVVqRnR62YOqBNMCseUCqDPrCfRwBc0iPYt3SJNvf0jFaUUKlDHiWCmfVlyYOpFFnZLUM=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:KEYw6/VBzT/aDpqD+qjb6fWYdTtW4/AWyMQf0oTONA+PNpEsir9YL9xBX9+1LEkzqVLH60ElbzXrYNR7tpIqTaYCvTRvbjy+arcKmL3Ykzd5Ec8PkTuwKctJoPayXB1fub2Ie2TmNVRz71tiLiIlCYBuAPfJuLLCyjnteN+puKIpz32llmXG32YMiaGhSWheghkXoEtw0zj6xLjP9Fi1c7dQd+eFQLl3BeLU/qNcB+NOEt0H1M0xSzsUb1lofBQaXFeYXHxFgEhwV+r8mRRn+nSW1mCfuj+2q64DMHsnnqZ0vIF9VOorKQTVSWqh1K5va46gBOHLECmHImV6fCPc59tqBVgSTnyzDIr/Tr0+nibSIhOC8qmwxo8FvvLNs6oC4h+dL41/lndUk0dt6v+604wH5Ry5N7Qzuf9zKlAjLvWJXWRyK0QJR3fxukO36CTwp1Zt9NhLg8T2wjtxAVjzUZbpHXlJ7rJfJ8AAtO2BS5LWu3AVE2nl1/afLQRoZpYU;4:T+XkjtAneHWHvm3mo2M0aseyRUAaKMmGffiTXPXncD3nF69wAUZU+RA7UAlO4naFerEHyV0rIkE3ewhcgtTm5f5uJVVQvct89FWhm65I3+7Nwox4fVZXyyq4tFNXgRhG8gu/G8cqkuU7YPIdYH/dFvaynLK4NRMJQ15rWweffcQPGuihpkLg7F3CRhRXZaKQWvPpxz3gt9i5G9OUKtLeVQPvCIoAZtG1HYzca1DspuSdvjKwWTDLpeS9GdRlLenna6lUvI7kvpoevB6g9TYG38sd74BHYrcYRscCmr71JbQ/vKxoDUAzj6wUompO5/PV
X-Microsoft-Antispam-PRVS: <BY2PR15MB016713291A9D2872AD1B5818BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:9vwCVeoQo1i+AhkQege6KVEDOg5txPNA9E9TEjhSS?=
 =?us-ascii?Q?vqdGI9SToXe2A8kbiaO5evUWvX1J7cegbDh/DnEKnoNCXCFihVlBOfc1M/Bf?=
 =?us-ascii?Q?GKvMIeg//YkEwfu5NzlYYkFZcVF39KP7oIx4C1TKTB3XaiQ3/yQO2tg7yTXi?=
 =?us-ascii?Q?+7hUR5SZl8w4J9xDkB5v0nTFDQO402Xfq23PFjHc1weqKgWPIjm7H/CFbKQk?=
 =?us-ascii?Q?AaFnQgMbgM4IidnIKwD4mb46xhxregrtfM6ACNx5529RFQl8uQF/SHIEzaGZ?=
 =?us-ascii?Q?WehAV6YPA+3pIregUpldOh3584sZJ7pI03d0pYPt/5EhRd4KjbslnucV9ljY?=
 =?us-ascii?Q?cx7adjTFqH7tzxp5RLCSlwRFfx5pPIr9MUnvQQXVCLT64ue1CIH+Mrimis+S?=
 =?us-ascii?Q?CVJq6Oo8nD9Q9Ob8JysRuQci4Opy+4TTykCzNoE38kBsL57LE/GFS6pKW730?=
 =?us-ascii?Q?V1ymzqFBogv863rL3zHW+GYz7yftIjGPlgRxmVypfLFKtq4HeVhykS9PGaaC?=
 =?us-ascii?Q?5v7V3bpaJ9FBnxMclMJlGrgc6YCdQGDjz1Hv/0bUp5EMQPKTmFYccXJFTzLC?=
 =?us-ascii?Q?aMvds9Bj6MbPyUtc0KIcly0laZGcyfU67Ou8rO1EcPG1O5Vk8PEIHVJKgoTn?=
 =?us-ascii?Q?3RR+0gHS6tfaWEUdfTJ3SMbFkYIUIHyzdrL+NdjLGPq9zv+8okK6wUK0FxAN?=
 =?us-ascii?Q?bet2tFJI7kk6zr82O+jlZmOCkG0lYHmsobJpA2ujSftH9VgxPkEzvNRLSVNt?=
 =?us-ascii?Q?adX7bJo4USg8gs87SXnX6iRyze0WLij1vl4Qc5pKZOCuTCmuP99etCKrnLZl?=
 =?us-ascii?Q?C0c7oDcTNHXBurKaaNa6koiPYa8iyGxyEV0AYZYWJh8SeB5WyoxRW2muGTm+?=
 =?us-ascii?Q?axjYzGMBBRf+i11fImQ4jvcuR0Sb5IXOqlV6yUW8bR6yHgTPdX7pvjxjMcKS?=
 =?us-ascii?Q?zSnuqaoqnpfhHU9jE1lYMhFb2iLiNkEDstoBq0JIIZ0cT+n7B/diJHdFO6KT?=
 =?us-ascii?Q?T9qLU1e06Hz+4AIohL+CT+fOnQ1s326z64snOLZOLAXnyiOG4L4O8EwOVRSJ?=
 =?us-ascii?Q?9qT4joYvCuJoWFIknfnfUqCmH9Af2KAEzEVRbzMgxI0tlcndmN5ylqQ39qtA?=
 =?us-ascii?Q?n3pnqpjy5/XOvVTFqS4Zv+sMFamXYeJkJoesbJSY4sScF5vGgP9B/9tZf+al?=
 =?us-ascii?Q?On9JqlE7y9P1N+ogGMlnD7NYcbXOzEOaoidBD0YMk/CpvYD53/D2D+wvBF+a?=
 =?us-ascii?Q?QmpbO511+MgzQDBehhn2AoUDG4e2L1P+rdmVPMcbxu0L4jBch+RPNxkCg9dT?=
 =?us-ascii?Q?82c4mOyXSOkhvob7r0F7zQ=3D?=
X-Microsoft-Antispam-Message-Info: Vg1GJAxCs6RS8t46tki0ZpkUvOXeA6GuD5vCgFZ1kBpKBCpYPUwmJNvrg+4kLtMYBYp6Zf3Vz47PwMVk/OnT4BJBmjdvZi4ONrrLht2ki7y82bfGlaoe6TpPGHmyDmrYtTYV0xyYoIcP8rSmAb6evQVPrlVSfZy7+O5JsQX75PkNXcX9X9T99Lh76dnnyM/2stzosTPNDHwWUVv9PlRENEYLqIsnFgI+ZM/OGQjl5fCvdDG7HXWWz/mSTK+lv8J4Mql9TyN2e6LmtZaP6s/2RT/UtWIOOKP81f1ApowqvMgqTyYreX5ZXsWQvIOO5w5ni0JKkj+WNfElL/XlKHQ+mBV0Y9vZ5vcd0eBCIMSCiFw=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:FpFhXSAWF9HpqxNCTqmfqtdiPxCzOQWhLzH412YKQ96vlEc06AWw8DLEtmwqAhdLDcF/9NlXqCmrq3Jw5tl5IUNBUYkWy6i/VAUeDO4BdKxAZ2ZvXLUlHJT5MVM7vx3pbjoyUYyhnJMg5y8+S5AihbUwumovRvCRw1IbU1nBTx5szpcFuGwLl5oGTwZzZCZq9HTV7yU5UdmrWGgJtxmFfqQ8qcDQmKN3ijhpo1v2fayGGwWtxsp+NM1sm9PtJNEuS7/sulkulyTe0FAtUwq12LyFuLjBRtkGbjhUnd+ay/hcgGhz0CO7Gdw4OXjQBc6XbErjCavIBtoYc3rGjv7nk7XdCM1qj3UGwsoofak4WBzuG4aaUAHGae/rnZUv4GycUUwULiZ7ypOVUoLNZUpUGVYAt8bXE8rKtI+jGkqxFJp7pX6bni7YkHAFzUtLboHMjA1xTkzOEV8C+dWxOaGPLQ==;5:zahr9pbXuZLHCBj2Ut+yXztf+C6RxM1me/E/oncnuZ7vpcrHSlCzagglc8/4QxtLVDrD/OmjJ0fMSJ3oRDIBkVfRXwLYLlyf6pcqI1uhLwQ3PCclhaJAMS+uFG6FA3vxcDs73IfZGeT0W8LWN0pkAQiR5r4NBg/u0Fhf9BdWOSg=;7:nCFrPB5Zk/uP3rcyTV+nilK8RvIRbabzywo4dVddZVzLUW41ls1SocvWS5/D+ocnkJYQ9UW3KUsUSGLYrDCXSGjvLvMtUL2M1Gf5Asrwe0LLvoAglDAMGO885qbiOPhv8GBs6+2YJGHdj/sOF1LuSEwPHI4fgUm0Ph4kev9iyEtEgck2FHM2ibTUVgm6vT3/gJFbGsOVINsHPx9yHv/oJxIFSiR8JSZlsR5Usv2nLBJ8w43Bjx5vhlaWx+rt8Bop
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:vV9uMXjoxuOdg7Dk/4w3QEGiw9Zn3TOZGhX0uW9t52mJLkvDErtF+JmddBvvFse6xWe9sPdUMdu6t/voyq139L0RxG1I2ksiZxiD6IEB9a990tkEisJu7ghngKe5PVXgPJwv6E+9T2/N1dsa1/1bUOQoma0AhJvWgXjeUMbLA7k=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:15.4854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b2162e-1df7-4452-3169-08d5f7f6f371
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts bpf_prog_array from an array of prog pointers
to the array of struct bpf_prog_array_item elements.

This allows to save a cgroup storage pointer for each bpf program
efficiently attached to a cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 drivers/media/rc/bpf-lirc.c | 10 +++---
 include/linux/bpf.h         | 19 ++++++++----
 kernel/bpf/cgroup.c         | 21 +++++++------
 kernel/bpf/core.c           | 76 +++++++++++++++++++++++----------------------
 4 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fcfab6635f9c..8c26df9b96c1 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -195,14 +195,16 @@ void lirc_bpf_run(struct rc_dev *rcdev, u32 sample)
  */
 void lirc_bpf_free(struct rc_dev *rcdev)
 {
-	struct bpf_prog **progs;
+	struct bpf_prog_array_item *item;
 
 	if (!rcdev->raw->progs)
 		return;
 
-	progs = rcu_dereference(rcdev->raw->progs)->progs;
-	while (*progs)
-		bpf_prog_put(*progs++);
+	item = rcu_dereference(rcdev->raw->progs)->items;
+	while (item->prog) {
+		bpf_prog_put(item->prog);
+		item++;
+	}
 
 	bpf_prog_array_free(rcdev->raw->progs);
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d1e4727495e..16be67888c30 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -349,9 +349,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
  * The 'struct bpf_prog_array *' should only be replaced with xchg()
  * since other cpus are walking the array of pointers in parallel.
  */
+struct bpf_prog_array_item {
+	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *cgroup_storage;
+};
+
 struct bpf_prog_array {
 	struct rcu_head rcu;
-	struct bpf_prog *progs[0];
+	struct bpf_prog_array_item items[0];
 };
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
@@ -372,7 +377,8 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
-		struct bpf_prog **_prog, *__prog;	\
+		struct bpf_prog_array_item *_item;	\
+		struct bpf_prog *_prog;			\
 		struct bpf_prog_array *_array;		\
 		u32 _ret = 1;				\
 		preempt_disable();			\
@@ -380,10 +386,11 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		_array = rcu_dereference(array);	\
 		if (unlikely(check_non_null && !_array))\
 			goto _out;			\
-		_prog = _array->progs;			\
-		while ((__prog = READ_ONCE(*_prog))) {	\
-			_ret &= func(__prog, ctx);	\
-			_prog++;			\
+		_item = &_array->items[0];		\
+		while ((_prog = READ_ONCE(_item->prog))) {		\
+			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			_ret &= func(_prog, ctx);	\
+			_item++;			\
 		}					\
 _out:							\
 		rcu_read_unlock();			\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 935274c86bfe..ddfa6cc13e57 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -117,15 +117,18 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	cnt = 0;
 	p = cgrp;
 	do {
-		if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
-			list_for_each_entry(pl,
-					    &p->bpf.progs[type], node) {
-				if (!pl->prog)
-					continue;
-				progs->progs[cnt++] = pl->prog;
-			}
-		p = cgroup_parent(p);
-	} while (p);
+		if (cnt > 0 && !(p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
+			continue;
+
+		list_for_each_entry(pl, &p->bpf.progs[type], node) {
+			if (!pl->prog)
+				continue;
+
+			progs->items[cnt].prog = pl->prog;
+			progs->items[cnt].cgroup_storage = pl->storage;
+			cnt++;
+		}
+	} while ((p = cgroup_parent(p)));
 
 	rcu_assign_pointer(*array, progs);
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 253aa8e79c7b..9abcf25ebf9f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1542,7 +1542,8 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
-			       sizeof(struct bpf_prog *) * (prog_cnt + 1),
+			       sizeof(struct bpf_prog_array_item) *
+			       (prog_cnt + 1),
 			       flags);
 
 	return &empty_prog_array.hdr;
@@ -1556,43 +1557,45 @@ void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
 	kfree_rcu(progs, rcu);
 }
 
-int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
+int bpf_prog_array_length(struct bpf_prog_array __rcu *array)
 {
-	struct bpf_prog **prog;
+	struct bpf_prog_array_item *item;
 	u32 cnt = 0;
 
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	for (; *prog; prog++)
-		if (*prog != &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++)
+		if (item->prog != &dummy_bpf_prog.prog)
 			cnt++;
 	rcu_read_unlock();
 	return cnt;
 }
 
-static bool bpf_prog_array_copy_core(struct bpf_prog **prog,
+
+static bool bpf_prog_array_copy_core(struct bpf_prog_array __rcu *array,
 				     u32 *prog_ids,
 				     u32 request_cnt)
 {
+	struct bpf_prog_array_item *item;
 	int i = 0;
 
-	for (; *prog; prog++) {
-		if (*prog == &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++) {
+		if (item->prog == &dummy_bpf_prog.prog)
 			continue;
-		prog_ids[i] = (*prog)->aux->id;
+		prog_ids[i] = item->prog->aux->id;
 		if (++i == request_cnt) {
-			prog++;
+			item++;
 			break;
 		}
 	}
 
-	return !!(*prog);
+	return !!(item->prog);
 }
 
-int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
+int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
 				__u32 __user *prog_ids, u32 cnt)
 {
-	struct bpf_prog **prog;
 	unsigned long err = 0;
 	bool nospc;
 	u32 *ids;
@@ -1611,8 +1614,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	if (!ids)
 		return -ENOMEM;
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	nospc = bpf_prog_array_copy_core(prog, ids, cnt);
+	nospc = bpf_prog_array_copy_core(array, ids, cnt);
 	rcu_read_unlock();
 	err = copy_to_user(prog_ids, ids, cnt * sizeof(u32));
 	kfree(ids);
@@ -1623,14 +1625,14 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	return 0;
 }
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
+void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *array,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog **prog = progs->progs;
+	struct bpf_prog_array_item *item = array->items;
 
-	for (; *prog; prog++)
-		if (*prog == old_prog) {
-			WRITE_ONCE(*prog, &dummy_bpf_prog.prog);
+	for (; item->prog; item++)
+		if (item->prog == old_prog) {
+			WRITE_ONCE(item->prog, &dummy_bpf_prog.prog);
 			break;
 		}
 }
@@ -1641,7 +1643,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
-	struct bpf_prog **existing_prog;
+	struct bpf_prog_array_item *existing;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
 	int new_prog_idx = 0;
@@ -1650,15 +1652,15 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 	 * the new array.
 	 */
 	if (old_array) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++) {
-			if (*existing_prog == exclude_prog) {
+		existing = old_array->items;
+		for (; existing->prog; existing++) {
+			if (existing->prog == exclude_prog) {
 				found_exclude = true;
 				continue;
 			}
-			if (*existing_prog != &dummy_bpf_prog.prog)
+			if (existing->prog != &dummy_bpf_prog.prog)
 				carry_prog_cnt++;
-			if (*existing_prog == include_prog)
+			if (existing->prog == include_prog)
 				return -EEXIST;
 		}
 	}
@@ -1684,15 +1686,17 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 	/* Fill in the new prog array */
 	if (carry_prog_cnt) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++)
-			if (*existing_prog != exclude_prog &&
-			    *existing_prog != &dummy_bpf_prog.prog)
-				array->progs[new_prog_idx++] = *existing_prog;
+		existing = old_array->items;
+		for (; existing->prog; existing++)
+			if (existing->prog != exclude_prog &&
+			    existing->prog != &dummy_bpf_prog.prog) {
+				array->items[new_prog_idx++].prog =
+					existing->prog;
+			}
 	}
 	if (include_prog)
-		array->progs[new_prog_idx++] = include_prog;
-	array->progs[new_prog_idx] = NULL;
+		array->items[new_prog_idx++].prog = include_prog;
+	array->items[new_prog_idx].prog = NULL;
 	*new_array = array;
 	return 0;
 }
@@ -1701,7 +1705,6 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt)
 {
-	struct bpf_prog **prog;
 	u32 cnt = 0;
 
 	if (array)
@@ -1714,8 +1717,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 		return 0;
 
 	/* this function is called under trace/bpf_trace.c: bpf_event_mutex */
-	prog = rcu_dereference_check(array, 1)->progs;
-	return bpf_prog_array_copy_core(prog, prog_ids, request_cnt) ? -ENOSPC
+	return bpf_prog_array_copy_core(array, prog_ids, request_cnt) ? -ENOSPC
 								     : 0;
 }
 
-- 
2.14.4

