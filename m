Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A5AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8038E21571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q2Aepiv0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="So8tzMwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8038E21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeHBXV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732033AbeHBXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUe012185;
        Thu, 2 Aug 2018 14:28:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=Q2Aepiv0b972JQQN870/GfWoOo2v3nwxcgCnP329rmSVVI8AajYtUiLgbhdT/gaIznf9
 6ahnzz81WaEYT7PHShw5p9/yJnIw5qdTkDPUGsxesrUEDaSyn+LFUNyv2Dd6CVPwEAdq
 7wG4PQT2xE1VYOVEPh5EMDvuyHuK7XpYgkw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:07 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=So8tzMwxzkxhgscVi7PUEV4Ox27JcC++AMBWyBdNad/M6DFAIQtTycW+KcXMo1XOaFkqdzxl6s22ERw3PUwlPF5n/W+Y+tPFVG/FOsfnfzSwymVrEEPA+0uTbisE/M1sVswxqc6yEQ63619b8q0fets1IjcUC1KDsXlsTpwWK9g=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:27:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 05/14] bpf: extend bpf_prog_array to store pointers to the cgroup storage
Date:   Thu, 2 Aug 2018 14:27:21 -0700
Message-ID: <20180802212730.18579-6-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: a63d4e0d-c51c-41e1-8b27-08d5f8bed199
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:8egvWGkBH5LryoloywcStfFl4QEnBLiUyKTaEC2KbrejPyjwFAuMDMgLWRf0A6T/OdYIwMW6CJuSURd4H/RR3ZFKBph44l1LYXFKkLgWjjjMCj9foLpvYq1uq57UoqI24ZrOdydYYYhdTkjgc2LfVrU5XQlF8jB+Bmse3kbHh8LANp/IzNRmxSQA3eYoiBicchRcWt76D4uPIGvALzt6S7pJHTaJ5aF6m7/wAPTBmYanTSrkiSOjiX1JV9ilRGFq;25:yFDGreduOGu5l4Rtw3l4f0HOXhNHmHZRcZC6yRLJbBBJAzBm6H1ct5n4YsBR4m1DobqVIQxXKRpOIm4RlDs1dWDg004Y1qvSE5eWWjNsxWKRSzR8uwpnkG3uqq6Ieyj7i15fDNr9ExEPRAKRs/S9/4LpMTx3d4OrPmpV5VLzlzsVVfV/EtOyBG+Qv/HOb3UDOaNZ3UObz4Xld2PP/vPGP9rQxAbqhykLFSxKd63kSuZU2FFZ7qyjQbm09dUoDUeey3a5UEC9gkihe7WpkS31Uklqt2ey5ycDcXeDITKp6xqxy5r/4j+mxNNxIr93le4X36N1SYGLny8sgqhMD26E3g==;31:blO01auZjsFyquMDAzNzVimqt1Au2Z811bKUxHk6GaNmjSvqueE0RecwzmuQyaaJBLEzKULwzQcGBeJF9hHT76UoNVHpmvArrKHHpDSvpIKvQ8DkYWJGqDXOn9yvXGNnuucgBU6UYL7YSrGI3bDYNdzPbA017K3gWzZh1X8W4oRF9CH8xVD62pKgwrBdryDPlsA4AbqxDrUnJUmhj822MyRhpVIyYS1z/+X//nx8DmE=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:hlhovaWQmb4fi3eRjXEVpuUIz4+9hFGOsy5Z7jx6zkHsc7UPBHrOm/dXLtKsaIgkAwIeP73jUMzfYmA2imBLZcauWuuoBtVS4ukQysM0XFU0TLe/cw6rzmSdcWLKg1zfKEEEO2tx9y68NP8LtkiBxjlbCVyZsJBAYSFgR1kjOm0IzKRri3alB44eRry1tK8zK0TWfSc/WD9AJuIKa++qz3ARItgjCwKpVkvZYmOVYNSbEE2/0XKlgSLjkfKmZqX8nKvGA60PHB1u/Byp9zx0537b91cnJDxmayvV12wUQoiBQYhrVBT9xlhGypaNY2/IU4A2WZZ2c66jbGpCzQyJ8tEEPU/dln95SmbbjkHNVTA+k0yn4os3/PWoc+6ewKHRSmlbYICgOY/bRtYoA4TERuTcTKHUxBfWVGlkZLTZ9v/QqY/8ZoF91Pfgj6kDGNPjDvtrfelTfA9fpJahQPH5EV71l21Ipk/VoB+dqJasKqsCspGMQgEfy9rjeW1EWS4y;4:BtA4A2m/UlBVughq0G+JF07ZXt0pCzSW5Y62PkF8gDazMtFCMmQWYbtJiDVuOjV9z0ni3JzJKRFCDrwWqqvPdUAEypTQBhCMaHge+kl68WQHE6xCrN7AnpC0AJF3j6WGZsO8qABjEVNOzhzTfIop7goVymnxPZg8qqDdD6WrZK2SzmpPTvyPeT0DT6k9N0dSc69D5MdE7o2z6QwRes7dxstWeaNtcN+9704NA5XRZ6hiooax5TFltB0rc5eL4Ds0DZc+oy4PTzyympA1EGeViF+1XuFzmnbDBNA7+Cdo3ED06hDOnSxt7g3/5I+zpj63
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167680DD34FE2FA99A1A256BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:yI1vaNKExIRD9Ag8hF4Uvwi5IcuIZlL3a3zUpfr4r?=
 =?us-ascii?Q?6cXbo09gJ0UhL021Pn6vhEnsm4Gi+rjdQ6FlXSrvfOEVnXuh3LLvAko/s8eO?=
 =?us-ascii?Q?f+ONoMnkHqkE8XpE2V1lhiWindqKBAgjsvMqIY/T1mTy/0GHu1cd/ZvXCs7x?=
 =?us-ascii?Q?STIU4iz35t/q63JR85FwZYoT65qylUOlJIqma3vLmIRHal9iSp/SAVGciBLZ?=
 =?us-ascii?Q?YByGqfZC72yq7k2iVJBPYjF6kW8g2Num0AATHLJGjbVIYbsiBFUaGhnrLBr+?=
 =?us-ascii?Q?JlZUkIvNCFRDsu0g/6Faw4WQts443VYJleEpX2BW6iSTyITTgsS811/Nl51F?=
 =?us-ascii?Q?M2BPmxdvFuAS+JSboii10aamGFNLrlrImGipX4iigWNVcvQU9u6sLsVHK5S/?=
 =?us-ascii?Q?kVapVjE+i7mA+BWT0AVsdsSEwsgYxW8dPug+CpnQf0jZ+SrObxoCFUdJi8ki?=
 =?us-ascii?Q?R0xVk77+QoC6wWUcs01/py5D86coSQXp6r6yo5aMNgUGjr3j0oVL6XoWe0vu?=
 =?us-ascii?Q?CgOkYUaWQ6jct03GVTCd6lhHiOe6BLM9EY7NiZTTYTQHLrVNqt0zO5uRATol?=
 =?us-ascii?Q?+QGFMKACqiD3KckC32sbZao2lVwDRjJMWwWjyXW/aO21hb2fiBcZzL7fTEnG?=
 =?us-ascii?Q?K4piSdWaW2W2msKH9zeYQABRUTvvvEyqxvAzA9soX9HNuUHvHxafrvehm/xB?=
 =?us-ascii?Q?e5z5Dj1+EpoRvzhHPWsuEQM7cci+VS+vYD12ltCWbyAPgGD6GH/VqKURin+W?=
 =?us-ascii?Q?lWZ8HSsorI7TKmK8zSSGZcXGheKgC8WzUqL6toyay9+IctBmuofvffAym4pb?=
 =?us-ascii?Q?5VUmpytnRI1zDu6z4sm2XiNTEgmcOo8rJwTSSfNZLqnQJ45sYok2rSTnLUkF?=
 =?us-ascii?Q?pbvoBppPez3JtHH7xZsRgGAXZF5fgv9IieI/jwcIAUfSqYQYZGBZTgdGsY0x?=
 =?us-ascii?Q?3eJPZvThTQcoCx3z/OyyIDTkpuCvfRvh6Q1IMxLOMBbfZOvoyLnEoe70DNL1?=
 =?us-ascii?Q?4Xo2BtXVWflDoTJ3X/+s+wzl4YQj9MFc5K3rtsil78mMD+9mGgFeUNiuGFhw?=
 =?us-ascii?Q?Gn3Bb8kB0TPUMYGB20oIG/6LYf5vlaLwBLAUV4YGC19lvLHMRGIoGJhsBRG7?=
 =?us-ascii?Q?8DSJkc4cmTxj8XxtGf+lVFZ78tqPneNcf3wfZzrfNSrupoUn1DiWv5zEM2Fy?=
 =?us-ascii?Q?vEa4ywYtIbBQEPV8tPHY6w9+jzI4OXgkHfJ9uUHslwyGVbc3r+/yrkJV3fOU?=
 =?us-ascii?Q?LhgjgrMl3Hf9npCIJLDcR213AK9h/VXCrxPSWhUc0IinhJakRzW74D9PVv/O?=
 =?us-ascii?Q?5alsuLret1Lf5ID35rl35M=3D?=
X-Microsoft-Antispam-Message-Info: rk0HkMQJbUi9JcYa+kE3jeXcfMtqukD9zaBZ0D79D7NSIbvhmcXZtcy/1EufjyDd1baVJNitj9Vzf+0msCWqvhK6btyDXxpWe6unnrjXVjPO8HCv2/gcdQCbaCP7vM3ngroqkGSysnE/jBG6v7AQ8B9NUvWBAQ5r3QbkowvKBFupEKAXpdB035T0LNSUiYIn/jcB3YHKuzBbGBbUHxSp8gArvFnTG1yHCSGlNB1M+4INcsacSKfQXTPrXPCGMkz+aS6yMFgP/lxA4tLF8VRThljCIR1GtIn+d1OuDm7aFfGL2ysXrRCJbGhyMGX1Z1tNK/mm2uWX0PaBk3zUq9BuSl1j3+uCIyd3z6gCurAzhBU=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:jYwiuUDHYQCCIPUHQMLpprz91FO0rGOtf2CBxtB+rnYsIY0xNjrjEYQlElzwu8Q8khUn9lv/l82Mk154y50Lzsl1kSnUf1BcB2hkq2ChRQp86njYOcVv4vxO8fSEtEP6tDYTrVTiiHEhbfekDSqlyQ6gTGMaB1EICysiBKUOFP/ey3uuCzlCjeRoCbIRL6IY7VGdylVjTymElGf9xT5/SfZvKTtt53A8IiYDwMDZ7UYPNB7c291v0PKjy+fgmsQ60dCqvMKvK5D+QTHGuK3X/BHFJE422vcic5QL/jBlWeVVAnDdwSOmAaRkARy5JUmM7Z+BANFfX7MpbpGRg+gdg0iBt+fWuss4quaM8++05QBGA4S4DDuv9yXIa5UXuUPQwYQi64eU6aV3PVKxI/5fRvsEpa3nosAWMPIrPC6HRUcMvSrzAiMTJ58m7n9TS2/mMYe8sl/bJr8euw95jqKUTg==;5:/1XozYsTK0r6SW4Jm/CSexPpb6J1rgh0FzidXGZ3/HNeQDE1w8/3t76ABIgIGTN8qy/15FA+nDfDwpjFswsGOWa9k56TjFLSHrlPeQQmNhPZevUsyB2Tn2waEPZNuKi/NeMo5YKmSdnu5UdN9b90xN0ro2kAqbwoRgt+X/Qxs14=;7:Tkmmhp5czXdAS8IrqbzKyVemT4ssGPHdVT6sU2RFO60+GphtsLeBOB13aT6IM8t3y1MoxLhU+s6jbqpSiGgPJZyosX3pmWpLYYJ30rg0XO9PMfzy5XSuDA/JXhGxXdT1kNHlj9PUGAp/8poa3qiNhR0nSDpe6hiWtkU7oxbQy3W8exAMpDo4b8lYHWJq8KphfBoaqp0vivzWEVcu4wqXfAtzV/nHthul6ls8symqDiz7+ITd0oUEmmrglLnv1kMi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:gx7L1QS9G6alcrt14UJ0iaiX1jDdPr9V/ZDH5EsGusurpkGl2WBMjokXKocWQc5g5uRHDXXJFYYtag9ho8J/4fmRisgmXb0F+Tf80en+WMcdjsGiaA1ZVQYl9uIHNTb6DmUorozQ+DqyNdGGaBqsKSNDrzF2F1eLTeo89S08Ltc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:27:57.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a63d4e0d-c51c-41e1-8b27-08d5f8bed199
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

