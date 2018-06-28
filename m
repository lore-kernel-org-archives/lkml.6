Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AAAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751D276E3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BEXFThZ5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dCytAe47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D751D276E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935941AbeF1QvJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:51:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56932 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935751AbeF1Qs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:27 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGka5X013501;
        Thu, 28 Jun 2018 09:48:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=BEXFThZ5EkwgLDVhTAvmbVgc7fUyrndsPk4mRoy61TakCX/QHy6pbecjU4hFYvlpzo1b
 NogjuZvOeffIXwQ14X6cqePxUzqxNjHVcry2EEJARx9HfwtoTKu4DUwoqftHhze4xAzN
 0XYiuYPKE7QTbrak4O9vjOlUN4QbgwuEbls= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u0074v-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:07 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=dCytAe47EkCUXWuYphhrP3jxhvGgo3amouCzYdaz7ZYckqA+a4T/+8XG1q9gccNmgatABLvCci4qzzfAjCQt1j1BqUfm3ydlvlrR8u6rMB5pL7IEVJFYkCDUuGSizRQ1ADJK5yz+V5eUX3gsEiMlnNZBcKKiREiMzUpI14uhM7c=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:03 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 07/14] bpf: don't allow create maps of cgroup local storages
Date:   Thu, 28 Jun 2018 09:47:12 -0700
Message-ID: <20180628164719.28215-8-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc1026ec-7110-489c-1fb7-08d5dd16eabf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:kkSGPUcTc+aYlaoXTH+8FLQSRr16qEbZB5dyRxKToFqiX6fAmKRWc8k1GV/4N6020oImKNEoFcVoEUcBU0YR4KmhtgfCyKNBhKe9roJnWqIY6Vt38u6LR4JcAyKJTgZyvY5085T2trQoQFf9l9/JfvtUtWAENr7/P+rnUDTYRl0G7eNQ4j6zBWSjK6tNXsafuWb0S5scgl+UfHUozkbsCESHUusNQD1e46z/bk2MQWIStDbOu1ZOZoF9CBYe4f/Y;25:d8/l2ofcL2wEdwVcPH5cEG8khfVZ1rPrBpw3zjWvrUKvG6pRyPxN/zG4Njn1zv+os7gPWxMcuBZ4qlVuA/uKVYX5Dv9uAWhKXRzzteDs80f39PD0bJYABLo+6zu4uwT5l+GyXuycHm+k3Z37+7MFJ3uoJ9PCF1nbuUrOa6ZSEkA+Dxcz5np5ZPUaOAkXkxKvgE1cGo80pfDgkle9Hgl43XSsjDzIxFKB8zo5mvoBsL2r6P3Mz25s92ayeVkSjjm9YoIGb09Qp3ou9nCLg8MCGz0hTZHJv5NlEiTHvld5xGiyayKXAFKvbm/hyOv3eZkhMm2TvyvUNun3D2XJtHurEQ==;31:Tr04q3HQuENUpaz3RTc6rB157jWZYWS+PPPl3RIPYB9dcKO84viLjZtvXNJiMb2H21ETu05MwSQ9Z19ibOxvjXyT0Tp0C2oKNS4lw47ngR/3cpZxGvL2UoL7cq6YX/ghWHZ7Q0STd9Oie1+TRc6VepXGsHFohgygV4Qev6O4HCqvvKqBz8rTYuZhUbIMgDnu1EmEIZ2zlwHRwS01s+h1zymmICL4wZO7uA7Ox7Lx6Zo=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:2/XkjO1epVt6qlMwXIX6+W56AVodIXjsQH0z7fB60eM7RlvAGI6JyICaRWgIz4ztSGq6SuPVeC0N6FCQzV6ZgtS9ZkyZS80oyPhKJdmEeucILNgSO2dbjvUaJ1DB9k6wmHQvMukuH9hujD3rwfN4+V8OJgMhueWkn2M38nNBF4sU7t4YRl49t/mNkZ0DTCKonmfcF2WaRNOYnsd9u6yjsr0RkuLCMcbF4/OneyXiu7Rj1w08JPVr1p6AjIePxk1CV9xlxePvSQe/QXITY6TqhfEg2MpXiSvDjkmaSJOKAnEE7I14PLXwsgjwH38jzDcgOjDef/m9yQ0hKdW1FxvRKARipWBRVyug58z+XoDRKwa4RA9mHyMPvUkPOOfjKRBQkSnpAPwwb4yhSiu3pNv6Ci97PyiFog05J6FFkRoY4pQw6YNoiCgMS1J3B481XFae05XetcMSDmWS0hAIf5ZI0oUk+dJHw6ugUd3kePsUtRq+65QUgBaU4Y6YpKjfguLx;4:stO0+Nq65U28sbYvYBZj3LqGhTrC6g2NASBYnhraRZDbJHjfwxANErS/eTQ+o2uRBwU8UJy+9c1aET/Xv9VFL6ZIDO9EvGzC5lbyC7/L5GnyFRnSZvXonikO6ma3pKjknDVUyRBsjV9UAtYZzlFmNHeyv0z4brB8MBel9k6OHpFSyLRnC81Hrl3EDYpGwdLiXcHbizQjAz9GnEq+LlVuy5EtYialzCZUSdr6DH8xyfO2Xv1fx/kxuSX8JjbWAD0I9onL+ys6u04n4lJZtvl6fO6qkesgVrifo7JIednzWNehRfHs+CZmronumjsj5BG5
X-Microsoft-Antispam-PRVS: <DM3PR15MB10817D473121F43172D58094BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:D9qHfvIrXQots2EJ/eJ2HeEX26Ptb9JvveZN0/YdP?=
 =?us-ascii?Q?/ZKqYPkOO9qf9kEWVxQv8krJujKp2BGAHNe7o5Oqev2N/+UItbtfQrFdrqY8?=
 =?us-ascii?Q?s9PsjIwDf8C9Rv9u7TaHP5abRlm0/dh7SXxHNsODHx9bOeNtNcwrN3Llz+/6?=
 =?us-ascii?Q?KZe9U4DbP86jIMXze5pGOxCfkcdL3wM5WimVU1pGGCyJKe8j7sTkWu8hv3Pv?=
 =?us-ascii?Q?mbugXS4bUb/AMiutAszIIrNMyzHNSGwe+DlDb4/yUBhMpXmdszgfLV/n2OX6?=
 =?us-ascii?Q?pFUwEEYp0dQ8sX7quCRGuHdBF4qVbma5ZZuTgsDa3jZRIzG3jeKldsxZvBF1?=
 =?us-ascii?Q?FcFpw0WnLTp82Jq9ZJyVHmK4Wf2MY/b74rj4rqK1Afg4hoz3dQTuHyGF34jf?=
 =?us-ascii?Q?qRbP6jivl5KdUXiDx4RNdZrON3HdjVEDERmIyj14+MrbhRPbHSAA4WwaPzpx?=
 =?us-ascii?Q?uPy+U5t6eRBt7xOO99i3XwzWEMKyuQGznVUowLBHCGK6O2kyt26Xf/sXvFRv?=
 =?us-ascii?Q?SNc/5a1ijgCGCGgRn6Z87+y1KIa1eUiuaNYTWLUl6XiB0boDaY0aEFDnpUks?=
 =?us-ascii?Q?mV+KKmrJVupjQTLZgehXoK0x/54pGqpBVPspe10tMOHSamw1NZ/PSY/Tbv8o?=
 =?us-ascii?Q?CqeeBsmwNLrnZJaR2B0fhBCMJOVy4QvUP2wpnh9hLyq9Cvy34WHMovG62Qrw?=
 =?us-ascii?Q?pTKAqcXOKYMQrFctScIOs6HAOKbq+6J5Nar5Jb/c9RlsLlGs/RpEfsCJWDkV?=
 =?us-ascii?Q?L+oCalytpQAOYrymbbjjWEz7GDB/x9xQBmVym2kKfFIp2dQgtQ3KT8Y66KGS?=
 =?us-ascii?Q?x13T0o86dz3MQL8d0YZEEemF0s3eaLLmKeLxckZosKUUE0q7w9bWTsb4FNAa?=
 =?us-ascii?Q?o7KgBxUCuS0grEIhC2d+QsklcF7+ULFvzEj3EDUlRs87wuQq3VA+imIN333z?=
 =?us-ascii?Q?XUwh5owaMR2OC4TiYJfIbGLTo6eXbNgCTyewJGz87d4rYfcOm/WXHbPUUWzF?=
 =?us-ascii?Q?6EY6MV8YWykCfUnsbs5cdzzB3FomV7D9LFXTeo7LjAM4JsdcyAJozA3oTk3E?=
 =?us-ascii?Q?f1OJu1O+S7m9+IGLrsgervCQrnjsn/sIqJF2fW/aaxLA47IlBlpYISIj/93P?=
 =?us-ascii?Q?X4bA0dtaNUMYyjaQBxVgk/92Dn+AEzosQhAmbVF13w+xWC3FZsfrS6LCYNXi?=
 =?us-ascii?Q?+wG5hpmBmxc7e8FLye5jsLzh7YJmvnPLPV8PkylQ4jBJ1j0nadHRB/GNUWkv?=
 =?us-ascii?Q?tDrhM5awC3v/fppDLpFtZo8ZkIsa/B3G2mDAyCfdgXz99Dhe+n/+CqceHJmj?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 7cEvlHinHBJoPMLSDmdH1pGwTC9guj8l5mjpVBhF0ILo3IkSgS0auQUkdS1amheR8Z4pHseCts+nTQ8iZfsHulSp68uTqQwxjx67V5+KaU1bQCKjY0eLYNkaY2XDiITO4KHfCUGTF4XC1zvMSzRjCKJxH1YR+WxDgvse7rstHdMHFI6M1AkcR9dLXyI1yxCsbfFIgcqWIzFk8hk99/eIDmSpI4IKITC1Q4TdC8QLldzZAY3pJIma391XlH6HFE0B/+nAPAZgGBYvEbH2nsQjOumgc0NkSmHSX+meV8qvitTyMUpOuNMxIErpWmFNqTJjlG71/KVVeD0hig/MBYRH1caKRA9eGBRee1lZAuIb95o=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:cmxwGaTn00yIg1KCS9IqQVYc9JGOzydFKbjQR3qDiE/VJ1+twPqoJnmtrPzE7y7sQqALBYmK2b+1Y+uG83yoCXTJ8WFC3cPZY7Zp/BbseVm93LOOFHMnLDCoLtvdUN6CGq60uOKctI+cW4ZlAX5+ZC2iBdJRGARcRVgVN03gC8J32IQbTuw/pgeWmR4w4cPIR77Lr1aOd/hQS/Ay+gRnPcaI+ag45UiZhgOQJTH0FbW9zKCALFxjzvE2oiODz4a30MrHRgIGdB0tRy/fl9mSOUxfPf8LHtlLygkq8qkw1+iDspHmRrZVq3/RghU88knHBIu1QJdyG8Xuqvr5ViJ/jGivdfCJCfAZlAhyVs/QvpIKhq9p/OyL7b9YxkYrv9Qm6L5Xou46B6whBLTS76niBEkyx7vvxQpaEHJYpshwJFp6arlJie9RNGYOjWb6BMcnq6pxDNWRg/VrCOh5gVbMnQ==;5:VWcq6gGM6+v3kIHOR1nlHawXTvBjvO/qh3ENaSpznlfjW8lxmaCDywKfKVmY5culvnNDF5BsgnWYaBqvuiGIrB0GGFymXI7eOgtlKi7LyT5ICuNu0qIeqYtL4IZWPfzAbuB/jtO8fg5Upz62L0u15mPGWKktew1Q+VB7ex3EQEw=;24:hlx/JwmihPa9toLS+0q+qPIXz0EXKTUx0/LyJMtAAuAWYEdnEtSWt4UrGZerLrOwuv7JlMyMHYH+69EmM6AkoGXaBFEZ01eXX77A7Rr3xhk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:TvF/vU2wj9yCpq6hGjxrXIO3kewIexGt3171iLlW6LMjat+IejYeldkf6SSM5CJzdOl2fNybscd4SyBKqGibD793pAH+9Ci/84TwsQRE0If6ZaM4qNlHbsgWaCGoBAoO112fWQbqNwizLZkBJvmj0Wu19BsGs1QZuA7Pfi9X5BceviXIjpQ/aza3Ozv+97lX99fJY701+imxJkmx62P4f9RSQ3n/q42MJAqPuNKfRYRVLbe/fo4zD2xhkPogya8e;20:gfSKq5CmLKLZwAAOYbXkUArQlQb6XBFSOp0PNtWINM3/IpnrBTna9Hh+aZptmvmcMw+spIa/4/AyAh8zoTduESn5Fr9kpzlKBwu47T4pd4tjWoLOsIESU3CFGuLzZsLp2Cywi+lGs34bWZ8MIWkqGi7chYNmNRd3i92qhwoNnLQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:03.1143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1026ec-7110-489c-1fb7-08d5dd16eabf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is one-to-one relation between a bpf program
and cgroup local storage map, there is no sense in
creating a map of cgroup local storage maps.

Forbid it explicitly to avoid possible side effects.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/map_in_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 1da574612bea..3bfbf4464416 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -23,7 +23,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	 * is a runtime binding.  Doing static check alone
 	 * in the verifier is not enough.
 	 */
-	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
+	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY ||
+	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
-- 
2.14.4

