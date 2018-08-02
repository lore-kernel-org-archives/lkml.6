Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992DCC46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4096C21581
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rqb2Cs3l";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UpOdc8Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4096C21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeHBXV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59164 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727262AbeHBXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUh012185;
        Thu, 2 Aug 2018 14:28:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=rqb2Cs3lBB/vrmEwhHH0iChW97zYL17o2ZRlHtemdglQtcm+4szPSEXNEK9DF0TP+OV5
 krFSRcvSb2ieds8LaIYbqWHHq2wHxTCCJ9mUwJRpA8tSe9Vdx7gXVjV9u6F1yZiDUznl
 +1SmBrcxq8KDe2lHD0fhLJsZX5Yo0bbloao= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-8
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:08 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=UpOdc8YfSeIZfPN0i1KJdIqir2EU1BSeR1IT3NAJUNFCIUVgMWvOHMA6IE3MSuNOGormupgvxasSaSmiGW5dNEavhZz1/gRSto4my/MQuox2AMGdLtjJQwGky1yI/mrIFd79+BhJmT3TRroMlcbvpyFYisVymfHjaQcs5/cKt1o=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:00 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 07/14] bpf: don't allow create maps of cgroup local storages
Date:   Thu, 2 Aug 2018 14:27:23 -0700
Message-ID: <20180802212730.18579-8-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a85a6187-2645-4c2b-0715-08d5f8bed2f1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:vspuHGY0842SjXLonZpaAbNkrNA29jNyU+ryHD0ehqq6NGzjRl/9PJO+aZ1bhsfDEMuA0P2FwrkqbUrylFP/05yJ/ifm5D+T9gK4CuhgY8ruC/FW/n1Xx//0hjQF48YvxoG/+d3nNmkwpFXv0UuXnclxIuh8pxltg3EZtzDlJsPolJLyzLNi2DXB/KQSgp0mKYHvCc7qc4Ib1RNwxUxYuyebPm8y2XccB+kCDSPTUYTPaHj+qoCp/G3zmcjBp80b;25:Ft8P9cIYUAA/IzjvwIiOpwOyhs0Q5WuDloGqwhzVOW2qWL6AUt8OVZ4Q6WBlSVRBSN67a+4SOeeKiQPpx+LRyLsHwubFPxV1Kcv/gKO0bEWCmWvThZGhwKaL0/vIBQOfFnkYBzCGR+k8BgtiP7wLQbhSr0uAXFO4g4dmQTjVWzM2gwTxGlqNue/QzChC+gG0Bc/aMmSF/S38f0Xv7Of7CPb+o2C/ySGo8atkef3LgDOBnWs1vhdjvfTqHqV+g2bj6XYU1LMB8blcpJilQQp62L7GD2h/NCEVuoHE1nyjEK0SJqhQjjSNPVuQOQNextxDk7fsRWWxWvdSsw4GsJe4JA==;31:S1gRHop4SZV1UAE9szemqCdWDOORFAt6rx6cjyO2tiDEi68/IMOONDPGsqFXfgao0TyZ/gYk+oRjiyDXXc62LYJ4yq50YEN2MFJNuT2iFdzf2DpbD5aL6T/WjzGoqGB0wf1H6wrGFTEjaWwFJCciBwFOEBqLgzt9ErJt/ERwjaJ71N983IKHbuQa69pEl/8mkXpoaM0L4x0DdRKac+vdDrlbI0gdhSg7+bPD/jt3bqU=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:T7oduVqbx5lMO0EtqCdv84ykRAmRKkq7MnSM7YF2uyyWL3RA4Ap1Wirs4pfYuA/KWIEjK1KWyKNAkA5uallCOD1pDQauoA9K6lRAv2o5xURKBXpu8FVRIEzuemaSy8T9K10GkFYz3hd0pcQb4sNosKiw7alybQZqPczQNoCuwVTuDlj0ogsenV2nyzPsfF/ns4idyTt6+3ktj9/H4brKutT9e1KaOQ9dClgoISuPt/KJYN9FlNrzDY8TeJauW1eVwaUM9hkcIXY5gjHZ9QQw0iDbgZ/lSQ9NBljD8bxwY545mtXdn6l0HjtIFX2AHpKaSzkax5I5rKPQ+dJTPvtp/pB4DsHHXxfG3gN7TsTTry93K0z56ddXb8Y81KUd9+Mjz/whyz62U72hBGiexXjM5nmQ9Lo/CNYCLU7A5nxaDsENTUoSA7QuUbg3pKthb9gzOdtr/tHFZqu+746MxXAqEn3ikzNQlAXfSgeK7AnBY8HV2/90j3NntY3rHFL2Mp6r;4:RVO4SVr/q0xLnOwUNnIsJHlSvXqFHEC244F4moknXvNFuW2kTx7NClGQOlzBS6BqQYPehB5xRBq7yyfdZ/Oc+BuCp8QAkoFs7HP1yHzt7PQZwSf44XuLhKNF8YlBMuE7I4ChLa+WPJsW0hI2vt7wCiSFqBpCTLAi+3DMbfdLI6q/nW2YNO8k64cHfvpEfQCOD52YSDwkyg4NdDK99k+UWFwkdY5KUgf8TaBmPnjmERRUsRc5E5d3Ld2N5bYB83KU5LUm8OWgtQr0TD2M6vatsCjNp3tG8d0UL2G+2igyXZuRTp14iwouLfSypqpwVUKU
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167BFF8D66085D8D3B7127EBE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:KrXFQaTPnvAa7bKtSEjXfprcjE4xYgqxLjuwnBBAJ?=
 =?us-ascii?Q?ofClB7RFDnKf+PCyxbCz767nuavchtLD1R2874y85YhrcYhVQeDin24ybidV?=
 =?us-ascii?Q?l5Mr34g20vETlaT5Ox3CTMId2qKlrhAV4CeFAaFvf3yuL4eG29dSEYv3iRwo?=
 =?us-ascii?Q?YMQAQ7atwR/b/cp5Y5Oxoy1jdTki+loE1NBHAf/rbvbjmnR1CEjcFEjYmR6v?=
 =?us-ascii?Q?HDGGhKGCEXZCY1O9x+9urJneVgUGcxh11wGM9eEYD3j8iRaN6cG21kVlRgaN?=
 =?us-ascii?Q?zT8PVixO55BOR2MWYBUZvt386ngvfJsX5d0j9RDg6jhTxQH3OdL8BxwH8/Y/?=
 =?us-ascii?Q?1wcJxe0wLw5jz2yiwhlnKIn8WLSiMZcQFeuZsQHj6CHGo6PEeoqNESEepICD?=
 =?us-ascii?Q?0YJgv3OgvZbQnbeDqQ9gpe3mksP26NhJjp4n0FOv4aH4Z30M8tpA7kMDKTWG?=
 =?us-ascii?Q?LszTEyXKVItwAtlHG3SEvZojetVV0d6hLZEINoUV1y94sMZo7mOkQwKM1thv?=
 =?us-ascii?Q?4ID4aQIgbS1CBsNtuIbdhJfmdgoTzwIEE1OXd398aqWUnypyx91ZyQPw8enq?=
 =?us-ascii?Q?+4n05PuKAp5rFZitVItzhIpbLSRWd436NOPhyXkVFTE2vlLgK3/F4hlqTlcC?=
 =?us-ascii?Q?95AeuXnXrR8MqViiSnIcr+B5E/NHRsZgVvfYe3Wom1LADbG1QJPnU+OG7db4?=
 =?us-ascii?Q?gKwx6NGfZVdaac1Kl8AZC7v2Qbl0IwXRW004kAxNGuLa5i98dmGt6YObk3/P?=
 =?us-ascii?Q?HTvvAbR7kX4CqzPXIUE1S3+NuYgkdXLa0XqCINXAM4jDRbko2UUpMAIqSQni?=
 =?us-ascii?Q?5MOFggBR/ejfoq9YHzGrwx+FUrpPupB1AgS3/ekCdpYrRGocDRgXcxlYFx6D?=
 =?us-ascii?Q?ZQC7NM5L7iB+3VKAjFxLpCJH1nOyDYVqll+OgRKy4FJ0SH0uADZFjbGU4+cq?=
 =?us-ascii?Q?C1MuwUpj6LtwlMq+lWKoUhnv+1O8dWzIRLYQNqs0/gZTukbu2Gb7rIRisS3X?=
 =?us-ascii?Q?XqM0nqSf52Obo+u7Ds1Zrnta/JP1t+53RDocvIxQ0DuGphAtng2AB/m22orU?=
 =?us-ascii?Q?iezJ4CsfMje4kpSZo99oqqgSCEDv5hQIlqPSzkFIPzWWF7EfbUP7GYRWUCZO?=
 =?us-ascii?Q?5WJfAbCLNyaacbcOZqzkWn50VTrBO8YLMvYLWCYByPtSIDQZcRE7xoDIp6dG?=
 =?us-ascii?Q?grAYUDqgoO1cW/jxPJyUqd7vAaFmVdDRSoFXJMwrfHtt4wKnhfjAqLZY+cyq?=
 =?us-ascii?Q?zfpoAMOvtKhKgNdO7n+kYvXCL7XPd0h+Vy6GYA0dGJODZRNCBuhIW4xwNGkm?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: oVjxH2Hlc0zGnDpEI5C+Qy6bNB0uFgYAiD0urlu9F2ZDM5ZNYa4QCEjqPutDURVVxkPVTbCmVHsbniibj0eCc0mbmJlXYqS6adESBzwApcn3Au7VJ/MVBpwxJEf6ZcmgGZMIKl6XYIm5xNYKVrh3X/pzlvkX3rzh0KH0ufQkbJSlh6w4rHXib2h/skuzdorV0OpCtJO380lUagASxmDQuCTyJjjGWYYS2mHLzNzB/DXwGpDLZxpANnNO7Xp2tl04OB2wfZyTkhw+53x60rZgCzjxyAyMcOCfFrusgATkN8Xr14KaHYUAQnvoTpRzpYBDOV3pBVMhjTmU/CW3iIx13whRpEkdhDOfgvA5Sh7pGiE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:8gS8ce0mTEqEmhJJHttolae6Zpsoh77wrWDM4vjarfp6VmafJ0n8xmBFwTFWN8qdJIflme+VzefpL6k21NX2U4tzR7vyggbWYUW1qLLIaq9hye5KejOzDP0PUp7IHCzPFQwnU4hxJnev+96bib8b/JJRfml7CIQlEtqoMoE3TKgtIeHFvECDB27kmPTttQ2EtzQ6r4/shg6B7J3i6UUpwN8ZZk26PAG+yPlC56FyZ7BoNhsmYXvLOQRfxeaQ0vRsJog/1/6pc8tLinG3RCdMxD23mf+5oCiXxrN8geiq+7In/FV0SbiOXE3CLOdS9v+F7QlKDeqsqECRb5rVr52EYnjyZP2LawHfdFoPiOGHj4So9gly1kisJzYPR59EaTxOtPDhX3j6GY+UVA/xHt8AbtQsvyHmBk8T3HhT9TCidYIdEfJLo/ZPU8skN2sDm/4iQSyVyxgvpaCxMY66SUCqWA==;5:YNstZiax4nh+qoPk+0YcnPuocOOgCB9Iy58uNCR9H2BojO2j1Zsf8GYv+uqqg61npZ0laF5xN45nbyb4EGfeRzfwFl5S71LShE0HZfAa/0KlYJkl3z151Fb/O5z0FQfHnuEOghnP4Hs8Fo7st2RJ9v5540G8igacLVnqaiAaroU=;7:ygOWIANcgHWHO37K28DfVpunP8krnTzmL748N4hDlgrOFKiYK2NpBGAAH6iOO4z7iFnZ/rebZ2qR68ZDM+fOZy9J2Qr6jmRG/DVJHn8qPJOc4T3+xN4wM5TxC2qBhaEBe8pbViBZe9WUKDIBzOimlDBfzT1yNn+hPuQveEUOi3egIDCWmtfLS5WgkR5bWejRWGMoV+X70QKPpb6Xz1fME1uQGB1WB5yG9ykr4CEQyClq7a27lwubKXpqCkN05Qnn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:tPWDH+77d8wc0y00e80S9BotVGo9xBr6lQ8oovjG8/c7GNQm9mWI+tnTe8XKlwHSZXf7JJ7wxXyfUeWYjyMwEv2QbG6LZY5xd/0y8UsUaGtTQA9aiUcr9Y5TyTN9WujACuvLHaQUNdZKSADRhkM47jE9AMYSe4Jpakd/fcJVFtA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:00.2392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a85a6187-2645-4c2b-0715-08d5f8bed2f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
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

