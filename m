Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDFFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A7720843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NyqTSIT2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NuMC4gYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A7720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeIYVaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28705 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729622AbeIYVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFJr1A031887;
        Tue, 25 Sep 2018 08:21:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=A16zMFhAzOYLkhAtlexCV4f4XVYNCBKPi3Wb6mJnZeY=;
 b=NyqTSIT2undzCwc2wa3PMT2e8wc/01Tt8iJx3UtxPs4TL2cuxZ8J3uD0tFoygRVI7zJm
 sI1lmLJShvTf8ZQ8x5pwROwfm9wTbMhnaMtsK8XPdLU+sr02kKye2TR0kD8A3JCxUsC8
 miVg+mkRYoui/F/JvYN+1zoEW0jG48HBxOg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqpp2079y-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 11:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A16zMFhAzOYLkhAtlexCV4f4XVYNCBKPi3Wb6mJnZeY=;
 b=NuMC4gYtkUgslnH2DgC3xz5K08/SUPo3DKKNoTGCzbeAgHXUUQhhkadDRuMEJo72ZSOGF6nzzHVacqVhENYRd/dBdvu1hdCLqZC5Qeycikmgo2h4Vbnh9/cPB0QzCQysC1tAMdkqYyR/DpFLcxQR66g6OWKRKGDXpjro6uHZwjo=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:38 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 04/10] bpf: don't allow create maps of per-cpu cgroup local storages
Date:   Tue, 25 Sep 2018 16:21:08 +0100
Message-ID: <20180925152114.13537-5-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: aefb75c9-4c0c-42c8-2a24-08d622fa9751
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:NT521vhkC1Kml5vCAbnyaqc2ncw6oXtRB/t+f9uBk9LLw2vtzJyrZ3H4pv4Q01h1vHHIU5la1n9EkqCjqiz00qb3BVliV9ibIAEZoaqrThkive4EQRAEIafQmnjDFx607bXjdO0jweO757VBmN5oQU4MH08ikdnWYRmBZA+5mUBVipK1ok0SKKBXKWoslDbjgzY4MRJTAgw/tP/ofcxJDrppBNA9x3fV7i/HnwsgVcEdtrZoJ8fWBgtTNFZkngfz;25:yWsZ4JiU45tyT3UiD85prvNMEvROtGZFDPr7ZXZUmTDBbiUfQcWt5oc54ikZ7YNIBPLFfaSPXgDEzgwb5ey5FG+rlC/lsO3IOXZK0ip7iOHzmBFXenWZlgxpXhGqOd/04W01aXLjKs2RrUq7AQQPm9dp9pD9mqaL2KPP67HBZeOJnlzNRax1cTm6/ByGskuHjUspydqNzF79yfrwlW25tqt+E4ha5EsJKHjApeopYqKO1W+2o/qc1jkfNSvD/L8LSeEtjGlqNl4LpidfpCWNAGAOITGz0TGhulZs6IhERxL9CuQbtdLT5aqShzqaQg92npPafwR6HwLDXRsLEi5q9Q==;31:oJT6JXLzuI4hDTe7zTwkYq+3fgp6USOqEgSkXsGsg/jDiugdJPqrlIt03Oi8nwFd5Nwd3hLq0gPUdFBy34vxP18ZP+HIfofe45f4iGsoE3i8bO0rwrmXcaBIz6gmokr31aD5VBMhALqcIyNL8NOR7tw5741xkk1xHfHar61oQy2lnrS5ob6Pw5P7Ru8ygZlVjc80rWwF6u85Dut4Sg3zv2NFf5OWqycE+5ZFoiEZ3KY=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:io4tyeVnLLYNGkSsCixfU2gbG7Rx+ErtkXR3Onx3/vij4SMMiVAKdUCJGdbnzUpbWdTFitKqspNoMH7RE6TurmEXQqlKFZICsyEfE4ITCqEUMoTO7xH1L18Qb0J/veD4L0H6lFk24nsxQWp0ErCLe481n6X8Eq8mlwMDXdLrUOtpqR0AHEHRJdUdbNFu/xyYdPahbKNGtzFtPvLK6x3zGxaKbR4Cy+hKXp9q/NiCaA6CKVpAeaphe0jDJKhKZ0tibD99J1lpwvHOpI//8Xl+13M3OXwRplc0OLBBx+djsj0d7fL3b8zOknhW82k47XDYEBzFh0GUgfztL+qYtlL5csGKSYyZQGqCpZ6Pt3STfmJE8vBzJOhiUgjwqmv6DxTzwuU01WtRubPm+6Vge9047+FoByd3zV/b5OeqVDBRAYpc2toImB3TyGQN4wpoNlRZIcu9FVxIBdFogE1iBtk1RuJimAirIDJwgRkE1x5zEZUbrO57VBhn15kuRVRFC0vL;4:XUpbSI3C95Hrf3fOQmNuZtOoP0oaoHRIemMpa2vZq/GqRpePyvSvMFpiUd3ut7NzwC1qKQdZq31U1eUUudnGkPvHGvBzBK8hcRAG+GvJGUeym7C0ujKE6T6J8Vdie5D4gnkXkzgCe6VgLA9e98AiniJnWF3aX0j0VRwbteiCsMPt0u1W4z7FWxte+rSFfm2BE7NNCjUyJW3OkZc53jAJr9VgIKo4ks3S1RGDjVQ1NRgUtrtf4aJKYRRtDgDN1NIYEHwUtopm79Qcp6ypKwO+sLAKe8KDvJfI3tdwvFuVUtX/xJ+22G+E18lRMGtYgGTz
X-Microsoft-Antispam-PRVS: <BLUPR15MB016395DE0CE23B55307AC324BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:HhKp3qrGzE/oHzeAr3HmTc5p7THcmK1RPLkxudShQ?=
 =?us-ascii?Q?o0G5I8Sci6F79bBMGWhv2sPghEjtbabvE2GbmP0U1VU3LNmYpm6QhUhZLGGD?=
 =?us-ascii?Q?ypbMT2M94yi4B+LcfTR4tdJNrg3ZGIiNzPjsDfl6Stnh/Vj+WjsoczoYXfIA?=
 =?us-ascii?Q?aUjQmY3dDFXV0JXjPspzOk8I11V0EAMsp+e7do0RVSLXWyQ5PM7SGV0nEtgr?=
 =?us-ascii?Q?bMKEjVbK1ReIplnOycZfBCOMMHcXDe0SAZUdnRBckQJuQ5eNZbOBu0OQNyzP?=
 =?us-ascii?Q?VGcnNnryGa5xQWLiznbtvvGWB+er3th+LzkmYpHkTRVXLHMRgGwB6IOe4TIg?=
 =?us-ascii?Q?6Dhd8oL8CiQx9ji1kqgjsZdyBEzUifei5pbUrJ7IKl/slktnglgQRIgPcpYU?=
 =?us-ascii?Q?RqaGl4mjDW+kUmbdJu5uZZStkbzCIC5/QdpqoVHQ/gZ1/b2vbCUMvAty5Eg/?=
 =?us-ascii?Q?frAeRs9zxLkiKeN/DWjWvzwCX0CzxlgL9LpWTjkyfzwp+25M00KDZsOO74x9?=
 =?us-ascii?Q?1GNflIhPU8lGGi0jhuvVzeQn7rtXmKC7NBaBa0KjNZ1CqrWptmZaPeIETLuI?=
 =?us-ascii?Q?Cg9+u8pMoNwODy5obshh/2LOLTCilNf32+xOJQrntrRIWy5LCtU8uw1v1Jic?=
 =?us-ascii?Q?rU0DNhxVm+dz3IZBZzTrxz8NzQuL7nGdhsH+MtPTp9cVEhV/5NEVmMlHeRuR?=
 =?us-ascii?Q?kLLZY7Rzwz/pwwe8u8FSaYPCeVnqPf1YFMaeHi/FG7J4DshCI0x/hDTp3OUZ?=
 =?us-ascii?Q?x5shfq+0DE1prx9+icoXMXHln6Q33E6/9utJVwmrLMiwl9l90ovpLrfbz0lt?=
 =?us-ascii?Q?4hYtqV8pjvySTGfJbWrcbf74b/OPW5cKVmWJFUHE1cldniRIZkKuelOETqJv?=
 =?us-ascii?Q?tly4l4JLiSs+/qj76eHdxc4Xnf34RRjLRAZmqrDH/yXLMBbaig7wb/ecpR0n?=
 =?us-ascii?Q?lYEmPrWeQsmHghiPb3w21w/oM4UmNK15RrTP3FyUskfAz+OgZ2zrTIg8GjU6?=
 =?us-ascii?Q?bgL9lxZufXaG7kyQdlKgHI/kxUbjR1CPXUz5tfI6fcjLDZxoNDBDb+88MS+/?=
 =?us-ascii?Q?ExSJPaoav4vm37alGnBl8+O/a+HNHECRH7BVu2YTKd4SXCP6EehYvg3Oeks9?=
 =?us-ascii?Q?cqZmZOUIE8on34pAhIj4l3weaTSaKBEbTxg2gneAeM3kH5I6od3EjpXDinPM?=
 =?us-ascii?Q?sXDYD6ldWUmRloZVrpoMKfJMc4sbfxZnrLVWxu1Dp70pooJQ22E8eSRyieb+?=
 =?us-ascii?Q?WZVhGQe1JRUldEAjPN0LGTv1MlsvOwskTBIHbJFlvm78viXPDtPNdIs0PK1b?=
 =?us-ascii?Q?9PN8g/75TEExuGpL7c47O0=3D?=
X-Microsoft-Antispam-Message-Info: ysnfA9F9YCuAP4PNTu/FQbfpZczXmSlZEwsjmtH7oy4sRbpojv6NOP5QUgsUXyOWEV+suJzpp7eFYDvTSEmmWcVKZZkhlHbrFdRyVkLWYQqkX4VcYjCRLRDWwSJDpyEtBl8y0j/571bRn7kDsq7H5TSpkGu+P1IG2jsO5omZG13JaPOaWr+s+7G4dcMI6NLlFc66HTT3ZY9w3bBQ97DEsdyxgcTLy9tGm5BqvMJuJAhiYNtDbxfAArblmWV4J52Ckl5kcsm/qnZtSfRC9f2FZdBsrxWFg5go6OvqEeIGkwRstSqS6kBKuFVOGIl/zfeNtGU240+NIPuHANGe5yS/6oDTt2R4zbyMXYTO+UsolVE=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:U5+Xc0xJt7GrmD7o5q93IM9dd9+BdApkJiRHF2Jm+01LsKbLtlkL5c8uNXuewKRjEEoPdtunyzKH5OZ3XjedFee7yzEgtcHxx8OJyj7joujY9mEt1yVunwSRUDM6e8ewlUtjK86CmgauKGR4wwYHPhcLIE171mZSt4Yq3dHYMXQxc1yYghj62cyYCiC9po3rOJqPkD0Ds38bJGXhjue5o604E9Sk+0X0vtrcAKwF3ZIiS0TxHtRytb83oZrkFNbIyaozO6kLqs0rek2I1kR93An50eLNCUVBH7tauFTzmrqQODfINnrNDqic3ZzOMqogR30jtdCVPyKlCSpUbDofDYO1qvLwujvmlssoAuIuauBviixd/jFisyO4ZMdRfgQ+TTAaR9R/DCruAc8QhAB4ol1GPygaGO/IeodFj9ku1QaWORo2tFymNQ/dxWcUhkFFa/Gkb/ESo4X9ljVnwmNjDw==;5:xkumZ432uShdCiqYhCU9VnP2Pg0ubWFGhPfUHUK/nwlb44OK91DLuuyMBccBXfsLZAVq0/AnmPCAoKYcIAsw95LXNrgpds4ZHSDeUbxrILrty4KAl8Sg65sZBjBuD/8G7fCQBY9fSr7YCdA1Igx9KpyoDWjTxsfKNApvNku7oCE=;7:3H/fKziO1VXgCxKkJJWxrhjXWB8+mWIi+D9LWV/JUVOItYfCi2CUicXdk74o/Gqeqoh2STMGdCOZNfGzrm2AHceagcOUJTa22cNxu6UNZIMb3Zp8RWOao350LlHZ+1qDeiYty03evezkneo6ILtHvA4vP6QuokxYoBFZsnXNZxu2RVKtHtOLZ4+MmlKdzfuR36glJevkURDWqRm/Zcc3DY4vmj6QaJ3EprLk4ydl3Fs6jd5zuqB6J3DGWNYEK4oq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:Bff1vq8n8mudrQv/h/egM9O9QANUqJrTmPOPI4O9NYZC/rXCbwr2wFEdtRuSyo6y8U0JjX7p5lYEtcpBIJhupaT7Q3+Y9u8sBVe9lxOG/SYDburPOeWfS79kgTJcs5RoDjRH4UlyLyoH6qHdU2NL8QXpQczSBiyDRB14eFfit2c=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:38.6662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aefb75c9-4c0c-42c8-2a24-08d622fa9751
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

Explicitly forbid creating map of per-cpu cgroup local storages.
This behavior matches the behavior of shared cgroup storages.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/map_in_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 3bfbf4464416..99d243e1ad6e 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -24,7 +24,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	 * in the verifier is not enough.
 	 */
 	if (inner_map->map_type == BPF_MAP_TYPE_PROG_ARRAY ||
-	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE) {
+	    inner_map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
+	    inner_map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
-- 
2.17.1

