Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF050ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDCC20868
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BdHMXtdf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cRii9boM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDCC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbeGTSgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388155AbeGTSgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:00 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhhGR025819;
        Fri, 20 Jul 2018 10:46:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=0kpv5DP9yxAfrm7uY1eU6H3FoEtW7FyEGUfBeySMrHM=;
 b=BdHMXtdflpauClUfGq+7lmOZQ+7uGmvSkOCHg629NxUnY9pVT7t/c+eUiXaajeIhnTXZ
 CmyH8bxbIpB0xfH/2iLr2INPaG4ChTcyUihJJnti4uHK5weFhMx+Hh6S9LRHijlELNgI
 QLZiATdK4vNR2f2bKGOvtu1uRX/SHG8qs9o= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:19 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kpv5DP9yxAfrm7uY1eU6H3FoEtW7FyEGUfBeySMrHM=;
 b=cRii9boML6EgxX6wTtsR0SttOGuIUutYikSeu46+YP2fOgYxRktkaohIdOZ363o9hGK48bfO2y3F6mgLk1xXG5F/WNSmz8IZZ+zr9RSeprVcHXvBh6/97cbqIiVp8RJmWZ7FaWdHTzx3eseKXijPZ3Z40CPh/rgQ0+bS9RKEQeo=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:14 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 01/14] bpf: add ability to charge bpf maps memory dynamically
Date:   Fri, 20 Jul 2018 10:45:45 -0700
Message-ID: <20180720174558.5829-2-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 31ab01c7-d082-4b7c-e697-08d5ee68b09f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:+4ZUR1ODusJT8tKVLs+BvJ3V4tRZkJNqEga1hYEl9XUmAciEVe5cmZXqG3Yuq11vtEVKV+I50GDM+M6vFXbxiEj+L3AnZqmDdk1ibxz3LVQAtoyH9l0EpiXc7J/F7MBZq23cKKTTvoSsdEXwbZWPkGR7Is9oiiKXu+71eHJQCZHt/QOJ3JeXn7ldkkcxLNpowS+VroKX9u2e3fBTbp2UQsfhbe41s2p7z2MhxDkFsrSYXmzq9r4AmwJ2+vF05Xx4;25:umqtOgEtf7IskUd7dl8jaR9jfNcOoAS7bpDTkb8xtV8HgaXb87uD+BYqPZ+uJQrBX02WXZW0y1/xr6JYQG/VRS87sMrbN/dESZ9kClr/Ff2gBy4NxbtZWpTMkGWb3oUWP4StycgbG64Zt598WuWUVCxyjxi+FkdkrxxtIngG1xL5r55wE9OAL8H026XIihzgGiRWDp1uwgATDL8nq5kYVYDHLIhPPvFrGgxoPFRo/1VqLtEDWI5473Vmvgsm42HtIAtmgCN9P4D/lsYgY90MWZ/gcX+3/2bBL0xAhT/UfBq8Zn5oWym9MFY3p6TCZILZhTXIZZ/phV82JI9UfOb9Cw==;31:e57LqkF8f028Nky01NDncv73XXxtIRmVIbFPhqxU/UWeC13bCYhRTo8UqZadxf5h0LPCRrl1HaUW166QyljlTomlmpspb6YtJGlF5zL7MwNjiQmTRTbE+tNZxjAzNy9Vva0KmZRvqSC7FGn15Q90fXQKkipr6D4CrBjglxeSIt0z/ds+cjO9cKeLJJ0ianyqi7nU0UheRX6xckVzZEQkZj3QkuamSza0yCxQA9msPP0=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:i+dReEkDV/WRp+XNgO3fRwHQWA3rBUWeWCPesaSCR7FroWKFez2xHH2Oj1QfTTEZyqoeOiGpOb8ch7LjM23c+q1Y6oumJv6UF/+p6mUN1yfOkpV7/PqFwVwEp4dqP6jL2bsbIA2rIEZZ5UnHcwv5T8SnhmQm5nSvdFLfXpaug9wKNj431V1wxawUdM+69rRW8BYPcdJNAJAydswkilVNhTMfk3RaBF0ZFBRZnSfZIaHv/d+fCAyOV1uPoMX/GQ4SB8GA1crLzGhODkGYfgF8oe50G0zdkroP72/Sd4kamUF+VJlrkEWko5yi9xMcvjeCjAxocf1M50AiVo52GkilXEg3ErlvB1FwucaIm0Ip9afV1l6ZqR5DOt3D0z6i2ZLmj3BcwlufUlk3cEQRL0MAEM6mhYNxl7tq+ufkQ1zgg9SQP0ms2mtcAELivRIrKWlujb3/W9FCtYp2+eQxX0W8HGnYnZqWXlDPi1U5JE15kCFWvXDziFqVmTCe/kr36eCB;4:LcE9qyiCfk0USeBZSdv/91R/zosxVSMxhlSVisxxdXToPMk6DJfCIHl9eyhek4uKB+3Ffa1JiLb99Hzb0cyizo3ABesYnGGVu3ajjyEWWSt2lwfZgv7RgfoOQNPXhCJqmS6doPCNP1svNeyBoIrfQ8GUBj6J3GiUY738Wo0vnvASE/7DIuUS1A9f/TH3kPhC7g+SEUryTaySuzMR95SqsDk4LxjNfxGj3Ozkyki7hOTQaqq77Y4+Dsl+PiwSji3EWe0zEyMthmlxS/LjhzADyKvi4WGuFm0ReRey46s/drcTOJ8RRnAokauWf79gpTGyz30qmyrMheUyTyuxrheom4KMMIq2dKmRSOZF7GTsMD4=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175AECD9833C53AC9FE105DBE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:Qz80kxm2SXdUBRSTf+DqQKg3zuLuYyT1SPIjrhHyA?=
 =?us-ascii?Q?uN0RxEUZ++soT3PlQAV8D12g30YAezfo9bdbjCxIWEdTgsaCWqLytd25UP6d?=
 =?us-ascii?Q?Mm/z+3lYlc6WW55q5zxjvdMmPxd0mVjypwdV5fz9kDQwzjI3y6w+fLea931s?=
 =?us-ascii?Q?yZRbhmnHPfjOG0tDEAb5Zln5otLmPzhagnz2FhQFrM3ZEtlNpCHsm/iQcO6e?=
 =?us-ascii?Q?hJu5mBghYz5xJpVPhGrclPMLPlBXpsJaV4obSe1utVkMkHjUpFV62y3OzqGI?=
 =?us-ascii?Q?bFH2u63TpfPKE9q4mpclU05mFbc8OmvxJhMD9dpSMJpYJCh1XKCfcsZhXJZt?=
 =?us-ascii?Q?MzC++Goim6so/K1NXkFmUgHCJbr+TSnQBgqHZ1FpxLxx+AX6Boh1qX0AL8jT?=
 =?us-ascii?Q?wf931qKNIJaGqHKA2Yu0WTCd2v/l2EKqS5RsOEwrZbNng6wO0Rk8/gesFcmZ?=
 =?us-ascii?Q?BaWinKh7ljyW9ZI2+t1vJDznja78ZgGYuJ+dZ3Il2XRLQ5dhdIyALvnQISlx?=
 =?us-ascii?Q?JuEtlc0cT55JmKZSmJndV7txew7h8cbsK/mwELB7Cl7QFY+iFaC5WYlb34l8?=
 =?us-ascii?Q?40P359EE8MIIQzOu1jYtYrnQvujHj39Jyyj+PCXhFiaYt44XgroZBc7DuyUE?=
 =?us-ascii?Q?OPLDyOY8lPuWntu+1fNdFQP4dAP6QwFtP7157PQNZoz1JelxBtiuOPb49v16?=
 =?us-ascii?Q?8b/Ney8XO7QUeRvWEcKIbI1C4yQD+GABp51P6/joZT6FgY9vrnJewTYOYFW3?=
 =?us-ascii?Q?liI7btNQ+VvmGfu0D9vup/O0mHMk3IJP+bIp6Y5kPylggoCHp7GEsrFOUx31?=
 =?us-ascii?Q?yNh21EFA+8byTVtVRJ14sBweasuEMgrP5b/k6X5wX0XJK3F3JdDL4xllmt6t?=
 =?us-ascii?Q?4HMOLHRBgtaLp5hl6v6Uf5XPP4SxBe3qZTagyaj0jB3UwKamN7HVkeQdwImO?=
 =?us-ascii?Q?U3TaW381jfrI+i3SlKRz5O22Nh09S5M0nv6F5t69j+xY4FM1ZpcjhPlSfgbE?=
 =?us-ascii?Q?ULeqIJ2WKqIzzEMJa7UY/yg1Y55BvsCASW/HaHtmL3A64hGCdWJNLlDu4egi?=
 =?us-ascii?Q?i1rMGeC6+eIi9trJqQX3oXVu1sFdkrd8GpSrhaNdSOlTEu8XWcCBB8Hy8c7g?=
 =?us-ascii?Q?unUVqZwmHSAPvkK/+aU0PfBs2Epsq3ZhyJsMauEDYdixIZGO6hlsV2R/ZemX?=
 =?us-ascii?Q?SQQAtn2ObMPLiQ8srSMBNBeXE1v+JyrqUa6i6oiNU4ve5likMXRKGKnwqPXH?=
 =?us-ascii?Q?OdkWYPFsCcOgwopOIlBHSUoSss+NRHpyeYPFH6VC0dD9wM91xxV9G6/e9ehT?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: AL88OqUUKeAaYE4vLtdl7H2GBAxSY1OUB16nlPYeKIQmnUHbbmMB47r09i8TEp7jsOSP3ZQ0VoiBiEhwOi/cqn25tynW1gJfH1FXHK7Zpf1EzqD88HbGHj9Ij14re5miYAOv8A/xZ37QlQYAL5fvSBX8l/k0qT949eKqk3E/MCOFiUJs00AWeo9YquMne9PdaF/TVIJpgIaorPmWdDJID9NF/SlQCIniqzysTq9/yUzf0HLlXlLVqNLbOzGM2ZGqFtDMiZiYVhRGPg2p+K6RHTRP977uu954evb1zUJdTsG18ivDo+LyYRVy+mqZXRnYMAS6vyrFSfPgW8HNrSZ1EvKCswROBKuw/jwoxnNvY48=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:oC79nx0xNv9A3eLY17xvX3L0QW9QgxTudNQ0UtQgIZ5t3vYlUQtJeWIBF+lG89XJ/iKVRze72hXHH0UZAUgBTW3t0xKC6QNgCykAs9tnc+GsQK49s6yJHndwZetvf7Z+p/DxBQzeSZmUD4W34+3LzvKvNwUBdMEmAvu3//IKvNvg4bHkSPaDN+ybPasPdyeqgmH6iuINn50s24WFI0gl+Tx42W24tbbZinPn13WmSHPPcXoVsr2XpjDLBW7apcer3ODnBL4nH9NtckZU1f5ArsXmSLVHQyWcAzL3lgKZFpw9AQ6QQKyER3Ue7nYYOBEI7TbRqk0bnjJnhFuoi+5XJPqeVU9Xllfbzoq0qio9CVK9OPhgJ5Tr5xICV9AkI0+gzB0YWdlRsj2Cbcspc/mIgtEoR94M4ayBNlWy5vKKklKTlZNXVwL/O2B0b15GdkkVyqT2zBJxwDFCoD7hVDmWDQ==;5:4z7nXrOn1A0IpdV2V6wnJzD5ZZ6K4ujjNU+ibChtX9FZG7nMAMFOQ2vGS82z8+BJeNMCzI8prjEnH2T4EXsZh68TAeIWqKXIq9KeWsoW55L9nftB9xlAMPaaXqHk1fGMPcq467KNBgMFnU317C5xaGAxhkXFi98JEeO+Zy9wnAM=;7:g4D2P7MASDwly1UXXV428WpRcs+w4HABrj8S5d4I0VqVon1LyHP5dyE2QCPRZ0aLeZZzzI8ack0Hz1/fTbzn9BQ8dTZu70qAdY5DNU0dx35oFJXaprDkHLS5ictCNkcC6+/B8iMQptPLOy2EBPRn/N7nxPt5JxxTpbNnRm0KVy78lksgt+qoI/iUAZF1tHhGu2G1QYvmpQQdYlFfa6kZ55vhBV5qUkPdDi/sbRivMdzopjYoMwmbTfslKRNhZcJB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:cOM9c66sDtQVbaGUjWvXHPZyHF6o+v14uNE8qExP4fugOEHUSoQ6CnzH2eNxTtj79QHLAlt87WFXwpvLao36QbG3GrR/f0YW6PG8MWOGHRXuXnBCVfoIwocG9JN09J9QS7qtJDt7pEgupsviACNltmNax1KPdalh6WYMwdocyuw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:14.3036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ab01c7-d082-4b7c-e697-08d5ee68b09f
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

This commits extends existing bpf maps memory charging API
to support dynamic charging/uncharging.

This is required to account memory used by maps,
if all entries are created dynamically after
the map initialization.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c | 53 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b5ad95cf339..5a4a256473c3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -435,6 +435,8 @@ struct bpf_map * __must_check bpf_map_inc(struct bpf_map *map, bool uref);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
 int bpf_map_precharge_memlock(u32 pages);
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
 void *bpf_map_area_alloc(size_t size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d10ecd78105f..cee452a19538 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -181,32 +181,55 @@ int bpf_map_precharge_memlock(u32 pages)
 	return 0;
 }
 
-static int bpf_map_charge_memlock(struct bpf_map *map)
+static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 {
-	struct user_struct *user = get_current_user();
-	unsigned long memlock_limit;
+	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (atomic_long_add_return(pages, &user->locked_vm) > memlock_limit) {
+		atomic_long_sub(pages, &user->locked_vm);
+		return -EPERM;
+	}
+	return 0;
+}
 
-	atomic_long_add(map->pages, &user->locked_vm);
+static int bpf_map_init_memlock(struct bpf_map *map)
+{
+	struct user_struct *user = get_current_user();
+	int ret;
 
-	if (atomic_long_read(&user->locked_vm) > memlock_limit) {
-		atomic_long_sub(map->pages, &user->locked_vm);
+	ret = bpf_charge_memlock(user, map->pages);
+	if (ret) {
 		free_uid(user);
-		return -EPERM;
+		return ret;
 	}
 	map->user = user;
-	return 0;
+	return ret;
 }
 
-static void bpf_map_uncharge_memlock(struct bpf_map *map)
+static void bpf_map_release_memlock(struct bpf_map *map)
 {
 	struct user_struct *user = map->user;
-
-	atomic_long_sub(map->pages, &user->locked_vm);
+	atomic_long_sub(map->pages, &map->user->locked_vm);
 	free_uid(user);
 }
 
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages)
+{
+	int ret;
+
+	ret = bpf_charge_memlock(map->user, pages);
+	if (ret)
+		return ret;
+	map->pages += pages;
+	return ret;
+}
+
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages)
+{
+	atomic_long_sub(pages, &map->user->locked_vm);
+	map->pages -= pages;
+}
+
 static int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
@@ -256,7 +279,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 	security_bpf_map_free(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -492,7 +515,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_nouncharge;
 
-	err = bpf_map_charge_memlock(map);
+	err = bpf_map_init_memlock(map);
 	if (err)
 		goto free_map_sec;
 
@@ -515,7 +538,7 @@ static int map_create(union bpf_attr *attr)
 	return err;
 
 free_map:
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 free_map_sec:
 	security_bpf_map_free(map);
 free_map_nouncharge:
-- 
2.14.4

