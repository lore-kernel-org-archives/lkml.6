Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C519C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D877720873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MkYT0i1D";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KQJ2OgnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D877720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389986AbeG0XRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60008 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389907AbeG0XRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLiF6s032150;
        Fri, 27 Jul 2018 14:53:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=MkYT0i1D8SAxhmBLmVG25nDTer6AuWBynnENivMGvj6jOpJNGFEdON9vVhkSWU62cM24
 V/lLBV9WohGC7osrECCgyTDSK9y22GU5Mm0WavQji1Czi0VgFn/yZTQjt3ft0EiYy+RS
 +Lh1J8ZdS0/cLgIulCByLAgW898BH1eJMHs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb52r2t4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:10 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=KQJ2OgnR8wcEApIZkSOROd7YxV69LL++/wqHH/StQp1MGZFj/ydHS0iEWQZHsfgrZEQEtEcZotxskOXaXFuQFQBy9lz1YIJOy2YxHgcMcNZglXIsbeo44ZnU7dGstDWr/wFqQtBxAyKoY6DW973452gOe9h8qhRSbs1dgdP6Mdo=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 07/14] bpf: don't allow create maps of cgroup local storages
Date:   Fri, 27 Jul 2018 14:52:36 -0700
Message-ID: <20180727215243.3850-8-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab4f1599-5a64-4e2f-215f-08d5f40b55bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:oGrfPXUG/gOoho6n1MzbY7YjiklUeJ3pim6XltqgxghXNE+TuVtudb0SX+RuxylBI+HmE33HA2Xvm25Fs/4cJrF18v26APN6w+eCOQ7ExibMUbubU8GAiTn5t53Aw6Y+8fQRtoMZKGbnHocwFFDx0ZBY9j8GmJ111cgrfPtP9O08EpH7QMAVylC5ko2lu7DRImOkxC/iKvJqUHu/L5vv9EsLmCGMqxkSQAo9DuxdKAphEvptKJjdujTWB/5bvlAv;25:VKa8OgooCwQ5uobfSaTIAwfZViDhoK8v4mTWjv/SSdMMGXOZmGfwWld6gY/MGmVPwrCIkKw9IwbopvoNy5m2glR99Y3CHS3xPcrKh7FRBUdjcq5+uN7Io2/Jhr2BKTbYxKbHyXJjtYDf3YbUolYeq3fxlX7nKqJ6Lb6P4n8XmlifYzpyCQAYlYbVkXyoiyExYPzLrNGw0dhX4O+4wpM/NkevAwNI7KwYrttq1okYAffZu6WneOZ2+7qn+337HN6+HUieOSLir/YZPkaF+40oMSuQiNPmu/PAUGPfamrmXqCi7GoXUW5U1xdFghzjmFwPmOco4V6laOurkQiFdTH5yQ==;31:Wv9C2cYm2WBvtbNfl91Q57mj3jVcbKNukNpHmf7gsVopHzxVxJp7bsL0UcFtjd+Qy8k7h1C2pPwU2DTNfecDaS9xPeqpkgLG0vOIz2489GJTQ73BXx6+df/1HVTvPvwZsdeR/ZFOddGKLTc0zi7yfJlMRVFW1uM1DUqve38ENBmF3Ucm2jQWRUFkHiFpVcpnGYbuvomvf4XqKWQb7TR7aEYi3y5MubjDfdekeQ9nqjA=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:ojfnVJcHCRcBCguRK+eyn8r3r57sKQrr7tnv5lGpYx/Ih5VgKKPV613EwY4gftUOfdBjsProUeu48RYivi2KRv6M2ubd4cjmmhOOPQIupdBc+lDgPA+iRM/jgdPncUp233bczjpkj5Q5Mn+XeXjJe/anpcDowQN+9O06guJRyUkjzWrjtCeGHZ2C9X3NpReEuojgdgvZE1HS8aGsMxc0R8ozXPTouTTdHpkjvSPdLakZGUpDkTwDw3v7TY4/vnGOGaP1ZtPGiZz1kTJv+GoWFWG+23ofIa8tTda2olgJ3NHgE6BwJLCgtDxQvTLHyTAIkb1vp5fTAyKEh6FpXiRjTqK+eyKYb0nj6AwuBydDufxTg7tR7koqQLF51sFzYwMlxdXSWrDnVDY4kuUYUmWrL1/rM5gkVsDqfzTcQ1IWjSzckNeLUl7f3PWOxDEMtz0iSoK+myWRz//DmYv9ajYC9R3lbodoVbhhkcX5KUzDCYPX2GA+Fg9l/Bhpkm5oHUKG;4:SsVcW9IfWbXF/rHK3JEIAD/RfUqUioFBi3pgW713iTHQmeW2gg0+QdL8OlL/bs407lxgnislI6UEcGgqadJuDNZG+IPSd/uj9cvAbLeXG8SBG8FFxoF3pXwAohZgdaqJlKUZrE9jwCkS7HjlOLOj8lRes3H7pt0PSXEbMIssKYn4pW8QURD1SSUASI22MhBmCCIp6b/dgHvOxMgjxSsLjtph441/nxviubiCTen/61iItQF6vhJRXq5OtFYtuoLU4n8O+rbVYqUR/MwYrNSFxXUg1qw/hNXD2uRKU+SNye5HU0pTVVge0CV9fwck+Ref
X-Microsoft-Antispam-PRVS: <CY1PR15MB01719645A6E4CAC90BEBA036BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:WB2Jj8KB7SFvROq7yV0jK+GZO4iThmfnZk7m2BwNe?=
 =?us-ascii?Q?S4ZF6CK6lH9dNHtJh8XXM0oraIrXLMRF8KSNpBvp002x4yvb6YiojLBJLVhH?=
 =?us-ascii?Q?9z57KEiTEzSuiF/xY4/wgqu4rSzxGQX4728A2zgI9mIlNx9SfmwhGJheRYvk?=
 =?us-ascii?Q?Ht4KQEETa5DCppjr4RRhvWPo/fxZ5EMPUawDEKg0TetY7Bo2GH+wZB1T52be?=
 =?us-ascii?Q?AtNAtQIcsecShtY6yEsxTqyqoqZGCdOL0uCayAcBKZAQGi3/Td++SPNHpF0z?=
 =?us-ascii?Q?guvDqflkQGpZvDAFb3WJHcLlPlOHD8RR7yxK+XlDeeORPq1pqz1jMCPIkuIX?=
 =?us-ascii?Q?uau1kcCg1sjJBzIo11Tu0OeHwhQG5gfQDH5zXqZxH+B/lhrBLf21j7KL+7If?=
 =?us-ascii?Q?b5RmqLOoyy+FSLytQfF6qUktPY7F9rLCgmjXnNuB5naguq3OgHnzalJ/Vfm0?=
 =?us-ascii?Q?PplM2sTHPkXsbXCmqCa6tpY73xDKsllxPWw94zHLiwzpXOm5YKgk28g/CYcw?=
 =?us-ascii?Q?Gpx97QxWEeRIkk6A2y+Y3kucQSYEIcQJzFt4oOyTIHbYiv4WoCXYya75L+KV?=
 =?us-ascii?Q?/RgDfPkB8Wz9pAUTnMRw+26A9EDLFO2V3m0IgvL/MMi1jlKtXwmlgp20UOVO?=
 =?us-ascii?Q?WF4GwmNbN1W/+g1z28sKhpOYR1+KNVsh1Eg87ZoBiF2TrO3p//swO+L+ZzoY?=
 =?us-ascii?Q?fSeXXeJ6R/A5OfcTGFK/diU5ag1z038DMEr01FutzowPcZmypMz8/iXpfxhF?=
 =?us-ascii?Q?eyuhH9u9gNxw9+/OKwONrgifv8bBnEEhvTgsslI910+HWwTCW/mgU10dWxd9?=
 =?us-ascii?Q?FClXMUIgDXZCmB2NiNcblQXyq0NO2EKxBXrIgbWeTI4Xro/X6tICAHsY1UTS?=
 =?us-ascii?Q?t1soyWg2v212yx4IRD9bQN2Ak41/LMp3dUa/NozGMs7B+PChV+naiOiSHM6q?=
 =?us-ascii?Q?fP0WDMFkBllrMI6WigNlTBNn8zX4ay/2HNt0VIFbchl3cyGkLm7EzPT/oqdM?=
 =?us-ascii?Q?xJGdZozFxRwhupW5+rmBrJ0aOzGYEcXels0QzjxkldIs1+BpzBp+M9lwLS8u?=
 =?us-ascii?Q?MwpoLyrSKgUoiMu51VVrmvvrWICvYLLupI/GD59fXNd9ts3Jb2dBry9vGWs0?=
 =?us-ascii?Q?naDSeof6y8bl2EYDHHIbLh8Il5IhxlGUwEsbig7/R6BO9iaLheXBwNZYPGxn?=
 =?us-ascii?Q?Zawzli6eK+GIODddqpbNrwDFx8ZHzp9cLaw4nmmiA8MikNqnzO6G+DccXyI6?=
 =?us-ascii?Q?AcjFK13/QvtI3JxKtM9bLZyhngtoFli897IKpuil8pm2f+Z4x6nHFgyJ3ZNE?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: BjQEa2ErOx4vp5mBw1CitBo+X5gMSTn+wQ1shYN+IQYVF9qQ8THFuQ97Pd9AhseaoIQ0Nnd/KVl1/UyDV/fS312ghR7P/YwJaMvJJA3mHYivwIpPn6uAHO/PVm9esKwMddzsEaeOIp/6nNYxW81wl90PXq2vmWHpGlu03jyszrw2Ey3zRC0ZWsEFXwuvHNrvjW/B5/YYej57/MpW8qZQbxh4VEEzWROlGsZZFjFGnBjZs62qnoEYrKllXPGYtrNiH2bc2dTFKuAcOV6yimZtDQvBMZIiAkVRdSCFRq50YmohnIVH6GUN6CypwpiW6qf/6NWmAJAvu8BWYrcSkVcE9dtaWAyIRtOZmt6vRpUjvzc=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:t9rhnwGCRhWFKH2WbmKOTXAdw2FD2ie83Aw0yUHUp8OvkiRBbAO1EOrO6ESUUk7HeEtm426SNPi6/CZ7oWL115mOhDf7D2g+XSz7ehbQUuL0wcWYlch/prMn4LdYchTS2PP7EQu2jyBcCwfgOjzOEiHkCNxP/aCxl5bKJ9ZhrPwdaGqFyly5Ww8i2lQ4uGwPGvel/qetEABK2l3kZL7d74hM7d1SIxU1wwsecXoF9EVNsZJPQS1fWPvyShIN4dsdQJRyBxyARr5D8yoBd0pv7b2vIhAlPm5RyQyIduIt4DafduH0RQSzY07ycwnd2v/EbqSt8vj1uaofwnKhwBXsSrPJcIbIzxsBche4Dx2VK2Z4T8FQEFABcHzDFqn5IWQFquZVUuupU+BGb1EZq/+CYTD1rC2SWG2w3LQ0Kq6EPXUpzvFyFvaXjqSk2bsnWfFyCO2F5E4S9Yl//V2wyR+udA==;5:QTFAVgoa2wE8Su8eo5/gnm/a2+1Xx0XBbByGHLUA/KUrN+/ynJ5npuNj6d1kSMDkd9JN1mkD7J48WRRzDMBIt/oocK/lMRPNaM1oXj44PxS/j9BMiDbmObiiZZ64vLwkvVTm1kir36HeKkLZzt+5EGVy2wsAgs/6Cnkil6E8tyI=;7:rYPov3r5JMAL8RcREBHfr9iuljUW0doE2IAC+2JDdSVNwd3RK7hIMX6GR+O6sVT3it1cWiUvKDoWX9IDNMAXWt2oo5ywI+w1efCk3PP1gtt2SHPvnDosdPjXQko7Dimj2eOZnVBfgL/RncnAN/T75S/I93zyPPTfYghed05ipnnbCndMbFwYOfK0r5m74gt0cl+bfslpfR7gNOnGrnHbwADs3Y6b7sAtQJt7QXUwQNiNnqaRAKT0WVSlxE0vMpMF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:Boyw2EddZ6DCuZ+wUHFm2VhaRovtjmr8GWz4AoqleSuvYaY7oUy555Hs9mp5EEB3TEfTOHC59Tiay3VuhqYmC3P1UC2O88Lhsk15Kfli8aTXvDak3BrjPItGV7phBJ2Su07EZE5AUdvcXmobeLc1Fp8D+NSN6IkcNECQhwM0e+I=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:05.8796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4f1599-5a64-4e2f-215f-08d5f40b55bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
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

