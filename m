Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42585ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE7020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l8AHkW2T";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LIFBCPFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE7020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbeGTSgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388414AbeGTSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:12 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhhnX031415;
        Fri, 20 Jul 2018 10:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=bORC1JD0YP835z1QFQWDyQXRjeP3qHZESb5m6qq3qEU=;
 b=l8AHkW2Te7HvJ4rJTDGgD7Llo0Unl+5e6gG05xSBTK/fKWOPkJP3bYo1T0fOBJa4Oxgj
 D/ktY2NwYg6RLvu4GH/nHOvqvZgQZW//lImLFaMKRd4lJw7VBr5zKRHD21no9TPX3tRH
 ljWzQZ0QmO6XfvXx+I33OAEwMwPp3AkQ3hQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbj23rknq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:30 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bORC1JD0YP835z1QFQWDyQXRjeP3qHZESb5m6qq3qEU=;
 b=LIFBCPFGGFOZrZpBBWX8381wzfz5VgDUQs3soPY0DHse3CNKkFzU4oQ/T2jE7cs+GJNea2cOlZWXZ4qPaZ+0gVQlQ6Zcc8EqBUY+M0Ab37/+POZZyWqSMzsiFo8OXACjfkX2QoTEEk70n/FoIfEJ+srDsMOD17c6UJoWpbGXJng=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 11/14] bpf/test_run: support cgroup local storage
Date:   Fri, 20 Jul 2018 10:45:55 -0700
Message-ID: <20180720174558.5829-12-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfda2d98-db7f-4f4a-9a5b-08d5ee68b774
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:Fs5YN1wFPDakYRL9sWgqnoyyfBGFeSLJ3I5kCGi2IcWjfBtu3Vt8KKcl6ngOajn5IriUkm7F3ZHLwOyVevl4mD1a1lOjUmFXOrnu8xUt/licNISb9Ko9N70bsDrJyWRKD3jlKAabvlbobVuQ5QOTi2I8oLSp9STsJNRWXvSoBpJ0MhkRUlfciU1kSl22YAX/m1o7kZjalR+cVWtiGzKG4IZZTNxQk/6bRXL6OgvPLDWZaWBLClVMTsOjbpJJK2V4;25:Ci9eQtcgLCv224FTkXNEkVMMFH3idMij7m/lOYgHd2fgm8B3maHhl2yNah70bWGWPrIg4WScfxvAwCWgfA4n79HKUtrHkhrytHok9Q3lMNa0IQqSfKdtJft2c12AkAJlmt3vpxPECn0hGqbi8ZUcRlLpzrLdKjiy3YpwwnuGKUOK0B06P+10ZLV74vVyd2extrw0H1+5Ja7MaHgXlYf6K8WhGShktFTUIRJtDwStqn+cdwxb+IcUQyMZnJPpAM0QA9TY4GpZuEguKtuPhYzUf3cQyrIPvHFefGR1Du19i7kqfWTd+pLBD25ZXVEswVA0VU/AGoMiOB7G0/8cvTWrOA==;31:armCNfe/OXOX1ZnQh9KGgQRrFWNpEJmgKTNACyhd1S0MCyJe+XMPNxoH4iarFsHYtbMoK4eo/+31GSxYxA/DaNPa09LcO2D9SEJA8JJlT9QsU28KJ6wnooLJq4y8s0WeKkEBbVEBHZPQQmP0Wm8I2m8hrlGqB9+fTYWqwNMKd2q2AIhBsjuZiEuEvvVSYx6eFJBjLfQ4RJ5d/G33XIeugDwPwfuDeQYhXiDlNFaGlPE=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:eXdwVqvrKFRSpytsjjkqlzgYT1lnPIA25C1DhnFgge7b5AGyGdCoh/Nsiyd4v/eKdyIhTrE1oxBJ9/9ZB7IktEcfo1ZeEUGZzSN2u+8dWoLB7zbpSjPMd4VsVPq+z+WnPBm7E6xQvO5899ib+pjwJXVPuCzI/OMq93NkN7SNDL5EHSAHHwoOTVyz4oCi6RFujVpUV38VXdan4CGnWIfqU07YjmrFjbNTcwm2DYoRThqxSGi8+N5gWS92/aLDYU+DLhYVWp6yfndDjowdCIKO8PGovvdqexgDSh/Gf6cINNDPrZodcgfa7xlKWhHXlzTBFGTKjirkUaLwphghppu7anHqWDBfQB4ioaMGV9FkwqYuQNg5bq9lTntBG/n6+nkPn6g0fzgURX1ELAsg6VlKbL4RHL4N54TbL4e2yQ8dWoNAkD67dgjDq7bwZVSinlAVw1Uqh21tI/pXnivl4nXCFjzivtUFAySVHZ4tAIJCjJyWZNbA1BfRMDF5ZhQaN9U2;4:gZa76OO+GzCKsz9RpDwSDd1G1rcL/nooUJHdcnH0RIoNLTZb4f2DWRMScFMAGJ5djUYqOVXV1othzGmrem2O5FHPK1jUZTxE7oFpc1112NT6A4V4z0FgNgEDVbI0/b6hUs38GvfRlZUdVVAjDM4XacPmvlErLNGJqzYCd5DmWR+x9dQOxibhTsNoep8DTmWYkqUQENgvq/HmN9GiyPFUAoGPQ9IRqp5mQPWRRtJoixvVGSd7P+cjLLm2Dg2tSUgb0DpSxsxpNVgYu3KyONmZkkDY9qoDvYzjEoyIFy8Oqom7thaaWrwXQ4FDTS2CLKni
X-Microsoft-Antispam-PRVS: <SN1PR15MB01757327F047D6E395A69FE9BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:rloC8xsKTq1oPS74huYlVlE8UaJzuAYnaEIlcujlf?=
 =?us-ascii?Q?L8uLdPj0HDeRQUa6iq2E0cEONLxb6YLSjlHQdppI5c5pToorIs/fvs/nBrDX?=
 =?us-ascii?Q?fuXCXNI42aBXr5zqn9T3WN2I8dg9VUkiSDKlqx/HG7uF9N5unkUlw46OHG58?=
 =?us-ascii?Q?UYvp5ePRCwN/l342Sm1Y8Q5hJMxrbhsFry2RWNqUfNjJbCMvK+A7Qbk0OQKm?=
 =?us-ascii?Q?vasf2hf+vkkBPk4FWMuwRRwXTe+ZBCm6NhPpzkguLQWW3bcrZeCUiio63LKJ?=
 =?us-ascii?Q?uRDE28RO/uMPqfMcUcA1sxzqYWd9I7+EY+OF9vqQnA/3yHI8RqV6gDZn+ygO?=
 =?us-ascii?Q?Q9T41PZEiSnfSS9Brp6rJKp9uj8PRHLF2p8oTGqveoS5xqZ8q2vIbBFO11oh?=
 =?us-ascii?Q?pdgg6H0TnWhNUbr5b9aY1sB0tvEdEMcx3V8CHeu+R4wj3Kbw5aN6URKIxrSV?=
 =?us-ascii?Q?/bjrp7duYmTMpiR7JRA2izjrHLATF1uoqHDCJytn8PJJk1Oq2T7XhiaUJeis?=
 =?us-ascii?Q?paJUYkJdu0hTTtM4GKwOhNjnl7b3NVNvDaAv7r+VVZlSOlR88PdYqrGK6R/B?=
 =?us-ascii?Q?T5eIEeLzOzCcFMSK2eybzX8TefEBTvOetJPvAR9i7OcAohlTRYTjieFpJ0Jk?=
 =?us-ascii?Q?+CAFs06z0ieVNwDIxuK8KoFpAi02HcWtEZALaWs/mkVM/U+XJ4obmVv4/699?=
 =?us-ascii?Q?T9+CTbUImE3YmBI0UPBeK1ZfsFY/UYZD6NIl65zddWGmI7H8cjGvCy9tDTQP?=
 =?us-ascii?Q?XBzY/dZCD2bMz9v7SNFMKfQg/FrhEFhaaIYgDLuoLC9wN/eMzu6nM/9LCtUC?=
 =?us-ascii?Q?i4/4vUB1JHkIXqXabmjXlmEZU3hDGMxc5xoyCVO+zocwdXll3RRgThlaum4U?=
 =?us-ascii?Q?foNyzO5CLUokbsXFd0QG2C9s7ACRqb6u1b0t6UGbgklDKaf3dptob+EG+xxv?=
 =?us-ascii?Q?VXOvmoMPRBztuYGpdxlsjxD7QiljFcgm//xu6eh6JPsfw2iMiLaxCdsGbXt2?=
 =?us-ascii?Q?nvo74oBhACRhjLsV1ED+4pmjHxhz41JLQkoTz+LBK2S0+4jPLWzHMwLATtNj?=
 =?us-ascii?Q?nluCmjmYYEhZTxBPFwmr9HOZ9w7n0E62dcN9SfUCAxy3mUUKby5xLzSdmfq7?=
 =?us-ascii?Q?nQGCSjGA/2YAeKoJneZFmFgKT5KMnApPOjvRwTKCmDIWlNs7vjNmKtCkdPUc?=
 =?us-ascii?Q?q78ha6DeuVVrwIskSlmFOj9rILU71IK9jAvBiFmHI6sdUKAk+ifbbg9D91W2?=
 =?us-ascii?Q?1YywsvbYNuSO7yJ9sH3iEgTy3sufxu/Kfsj6PAv+yLicG+qjYkG0w04REGBQ?=
 =?us-ascii?Q?MckjDsbvgN/r1Zv/TbHJKU=3D?=
X-Microsoft-Antispam-Message-Info: gOguBOZP1MNDDHPmJTfphZPpj1NjfxAWcCA7hRtOD7Fe8FKNebpFxJFPj2O5SownhcS4zSF7j/TtUMOFkK28ChIfv9m6QP4g9nlZ+mol2Nho51riO8qKw+zvSwyppBxCwLjOYfXfOXUyZaniw2rU3yRSW33llGqW6gBy/LYdC3FIIimBCGzhGQBuKrn7JrhhVH1/Ox6VZ+ZLJ42/h55Ystz3K+wtvLmcW+/20n0Cvefowi0+OuhZcdctMO9ZRwsEkIMzx5JV+ZsMnZX+C8IDRnMv8qVanMz6kbTiTvre41pMqNDDl5Hz0DvwaCeIg9QdUlyaT94dzX02GTcYSf2vWFAseAMr4ReLahb8OaeNwPk=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:uUtt3WTRfKVhrka36kxeeKIxafj2IrHZKZg0PoVOHk2hhv8V+yf38GT+tujzhXEouFlfzxV/CNSrPuARCeUxsfrHT4zPKLisu3HfCQpfyXLRfJtoLJzignH7sT2yQs5hHIEpSiQw55ehkyYRuVpHyAh2bU2Oo9b9eFpm6wIlspMW1FCYTvef07R06xHuXzFEweNGMH32UETHkHeeB1pgbdoQLkxzMuTD1hYTUU/dRzlCJjKTRXo9Xyak8scndmhRdi6++WM4fqlbHxbGUTV9goTu0X99jhbdMmedMns5MROYeoDMjoHAfct7kUaD/VXSVVOLZhbZds/wAuFibrecWgycDCE0F4Dtjt1Bdp8pQ1hxrb0oGKsxrLwnyIihIHVPjoS7DFYa6ZLxoQcOkMCZwSUMTJMwpNhyShr/sFqXdMKhY5/u6CTZ843frQwO8GsApuoTkrV4dSTwf9YTIMcHeA==;5:zfHAy8kkeqiPLo69dc2qOFjxqn+x3kJsoZOSA31XyBwDr6fykbwhune9fHYvYmSiXljW5tvZMz0tuJN3fD/Wcq75Ch6ap4RqwWXfHx77rKCQQcczwFH36Hf80QhPUEr6/+ZU8WyOuQwCdBLBfHaBgjym61Aa36rMijUrSxkZeYc=;7:xYKpPUO1PTNoBqQatDMeMPJg7rYc4n8t4v74UuoR2ATWy7rf/Bx/NCg4uvuu+Pe1enA4MkhNaEU+x6EIJxUpFfFr329cjIqu5JZiLQ+nK5IYyXS6rbeLRVBvGJxjVn0wkIsY2gX6w7lKi0CPZ1ZSfrkPiM6+hNO8TCD8PxryTKD8WjSnjABGChgBNkapRYUtGA5dI4w8AY4vZgrzJenshMJaWECjSSs94AmIAUNu2Qb26IRgnWLEkUXX0BDoHz7o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:f0BgpfOmupFDzoB72X1SFuKKhNzg1ZgG/HMMufIfxHH3hDG0wpkZ96pS5ap87pytWVMn0BWemook6KB43LvQtdcm3Y9NxgluNPVIupt6CurjReWe17o4Pp0AFgwSCJB9SJBP2MvSpWM0HytnpPM/QACxkk/oTkCHYGEzQxilaaY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:25.7639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfda2d98-db7f-4f4a-9a5b-08d5ee68b774
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a temporary cgroup storage to use for bpf program test runs.

Because the test program is not actually attached to a cgroup,
the storage is allocated manually just for the execution
of the bpf program.

If the program is executed multiple times, the storage is not zeroed
on each run, emulating multiple runs of the program, attached to
a real cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 net/bpf/test_run.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 68c3578343b4..74971a9b7cfb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -11,12 +11,14 @@
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
 
-static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
+static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
+					    struct bpf_cgroup_storage *storage)
 {
 	u32 ret;
 
 	preempt_disable();
 	rcu_read_lock();
+	bpf_cgroup_storage_set(storage);
 	ret = BPF_PROG_RUN(prog, ctx);
 	rcu_read_unlock();
 	preempt_enable();
@@ -26,14 +28,19 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
 
 static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 {
+	struct bpf_cgroup_storage *storage = NULL;
 	u64 time_start, time_spent = 0;
 	u32 ret = 0, i;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return PTR_ERR(storage);
+
 	if (!repeat)
 		repeat = 1;
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		ret = bpf_test_run_one(prog, ctx);
+		ret = bpf_test_run_one(prog, ctx, storage);
 		if (need_resched()) {
 			if (signal_pending(current))
 				break;
@@ -46,6 +53,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
+	bpf_cgroup_storage_free(storage);
+
 	return ret;
 }
 
-- 
2.14.4

