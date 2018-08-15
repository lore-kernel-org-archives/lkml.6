Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A66EC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0761216F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lg9y5jYy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XwTPYzfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0761216F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeHOD0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:26:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35834 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbeHOD0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:26:32 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7F0UOna028091;
        Tue, 14 Aug 2018 17:36:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=eesPrDvOqeXhMz2Kka4CiC+3KQRHS0oUCbgFaiOyA2I=;
 b=lg9y5jYyHQURsMpjlHM/eNSGuBXqflp3SMMpZ/hF6NXnwwQjzDvpAICHml4w1O09mNn+
 9DR1ntzKkNteyStGrGbu+tA4P2Am1k+7EMpu0o6kFvchWx6yXaEN4p6/fZfyg/4rAGKh
 0HGSpHrXniZhygfKa3HRjmaZkgxPE9vs6PQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kv6hqgg7w-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 14 Aug 2018 17:36:45 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 14 Aug 2018 17:36:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eesPrDvOqeXhMz2Kka4CiC+3KQRHS0oUCbgFaiOyA2I=;
 b=XwTPYzfVJkqTd9zEHQE8MPRh6PwxAVe9/nQSMv6OF+y7kNvujKmFmCrRjVREy4h7ztByEgPWcl9DFReazpQ3CLEaxvwihOXF+/7ItGeEP8Zr3ygNOLy2CRQzkw7tzaCwimI2nX4pXDnKEu0qR0fEf+eRlsLkYS8e2+sbdI0iag4=
Received: from castle.thefacebook.com (2620:10d:c090:200::7:b884) by
 CY1PR15MB0169.namprd15.prod.outlook.com (2a01:111:e400:58bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Wed, 15 Aug
 2018 00:36:41 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 2/2] mm: drain memcg stocks on css offlining
Date:   Tue, 14 Aug 2018 17:36:20 -0700
Message-ID: <20180815003620.15678-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815003620.15678-1-guro@fb.com>
References: <20180815003620.15678-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:b884]
X-ClientProxiedBy: MWHPR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:300:d4::16) To CY1PR15MB0169.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f46611-207b-4f65-0590-08d602472b88
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0169;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;3:UI46yOKmfkpe/1meHUV6jztQpakFTB7S868xTeM/dM2ON1Ozzdn48vQCtNV1qO0KEoBHCf8GLbn52n7QoZ4md8Hhf+p0EVRhAQMf4Jjf3DFRHoQAIloxikda12pubGoqmcVQwIoFVVOlh4znWs8OYIW90E2b9tKi67MJQgx5roeOlSCCzzMLl0gZYKaj4EaK7qRP009vXBJ3yQnFXTKZ27KQGe4YcgcpBBSCSEVx+VBJMJLU1NuWc1CGsZkphpI5;25:etb9QUBEsFrmnsF5eFjbLKdrDslScAbPgtc+e8V6HcWiNk5VTbbhR1zwEJ+Dj/HRvZ7VpnWj0m5rGksturpqX2M2mTI+GKYBU9v9NnhQkF+GH9CZLRWLGv9xwkVFIYoixpsLwXnhIDTcflAFupKQe5qdkneyWTirwnK4DJL49JFIS2c0lq3ylJzfm5yBulAQty7XkGSqk3Jg2H1iUV937vZ3FLOS8WJZPd+dNWKsKMo60L/WnMoLvETSrk9ftdwz6pb+js0K7tcsTROq4FtU1Pk3PNxEtusQxLCk6aHMbcesWp76NWO3Z87ykudlPlkapIqhjKHMGwXAJGQdzznEPZxe8aXAByJPmc4aj/cDdPc=;31:TQX7d8i3dhwbQuhefTUdDD81eDFFHl349DMYA4abeOSIqAoFVlX/yW2b3PeRTK70Ox62aMtf8gUNtkx130ptAJXD0MKJacYEzgTwWcPAWk5SdLTBnS9+Z3PlI0wzA7qFB0mJbILmVdT1Wny+MyFIkw2CJD8Mwdx2/gavgfoZX8d0vjqUEr7sd7JeWsux1yJE4e/4wqluWbvjdpEg1BkB5A2B41YfLgILg1PV/Su04oc=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0169:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:uqXjB3dORnpltw96RizXDjDSrlxpj/G4EiWZ3XejixKgAYke52yCkVDpnUhz3gwLZ4RpMZKdXW6iXV1MNfIGrkSeZtaEGMS48GRbXJZKmqVe0RdlrBiLnHAUasYt3c2GJM6CuhbjN3Xb/8KWLp+NrsbdZg9zVjfQ885xHLJG+7wF3jN1emJ+Jfey6xEIfxUn5yPQ/B9f9tpDq/ExZAqiLQgk5sD5AbVQNa22tvwJHuiL4VeCxjPFzUGGlLSdIeTe3KnfIO0eUNlGeGtOlBSnt3emWFK9snUkNXiCsBJm0255F9IYZ4poS+awZLFCpynMIPOO/gF+Kfwimbm62YcAkwwZ7+BnKgPhYMtsQ6DJCu8bRUYRN37i4ktmVkQKVqvJcQKqPbIYpcUhbzl+Hjk1Phy2N9iGYp7hs0x5DfVQzmdFAWtHNBK7R5gqwh0hG2xNl826qGs69NlkEBGaetdwmm0/MW0Yij2wmf22zTcywQW3aoCYqtQnXFyCUj+4h1eS;4:P32FkiNsLl8wDY6/4n68RPX0XV3jku8zQPWgCjSWTiJRK00HjF7FPTO6QgHUKuh5IYRetYm7MO3KlwAsNvDqJkyct0FhoTt7ZnfIdiz7KA8Sna1Q7Er6nz8D1777+ZKgYQWxgL1AIPLrSdM9ohDZdEpmQ05lFqPLxvEZnH+xIBgOqqEhpZSGAwqbTPyyFDDRGxPY+s0OMAL+oU27sm1KSyrjXr0iH76M7H1gRaRigAItBz0W0zjIbdoVNT68rpCoW3QvylQwE2kwvLp1FZpfKSrG1HeKZ1sUhnM90HDhcSTtjZh2lcIGTvePO6ChhTqHXQ6LPXVm2LYWhcdTpbJhcHAP9lAjeIcOl3YgVNfSGEE=
X-Microsoft-Antispam-PRVS: <CY1PR15MB01699E95FCBD983E2A7702C5BE3F0@CY1PR15MB0169.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0169;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0169;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(316002)(2906002)(52396003)(54906003)(105586002)(4326008)(39060400002)(69596002)(51416003)(25786009)(16586007)(53416004)(76176011)(52116002)(36756003)(305945005)(50466002)(7736002)(106356001)(48376002)(2361001)(97736004)(68736007)(8676002)(81166006)(81156014)(6512007)(6486002)(53936002)(46003)(8936002)(2616005)(486006)(476003)(386003)(446003)(11346002)(6506007)(186003)(1076002)(86362001)(6116002)(2351001)(6916009)(6666003)(47776003)(5660300001)(217873002)(478600001)(16526019)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0169;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0169;23:UY4HuPUJKdKcLYQjpc56eGtqA9hoQFrwYHtlFvWa/?=
 =?us-ascii?Q?UF0Ycraq6GR+pIRpHRwVMXzZIVJPRgYQlGS+dgdzVX4GYZkae2qH8WUPX19m?=
 =?us-ascii?Q?6V8Zzl4skoGV+3IXjYRkmpvsLxP1AjNbOb1XNgQb5xXzk3kTy9D2UK9YI2V/?=
 =?us-ascii?Q?hLf6m/mZn2SMPUMC+IM2z1RcXeTmDI4n0k6SBUmlL6UM6JiWx88PcS+fnm8r?=
 =?us-ascii?Q?BkleknfBwYSO8tBDXaGFB9DdIwCtxNw72I28cPSAAjdugzkYGGa/wx3FCXE/?=
 =?us-ascii?Q?rSTjUEjyifrjkLqbyo+tvgIOo+BVlx365PHVgOEezyAGWXWurVZ1etEgKRV5?=
 =?us-ascii?Q?dJuiTDHoGOV6tE4e2oVKYybP9baH+CtJDvvLVDt7E1Ai0vRcoGa7WvYfeAVM?=
 =?us-ascii?Q?QcOQo+3Qj/ubwLWUcgy+PvZfvi2iwWb/ed8C2qefOI4KT+SeDwdGq1G3rHGx?=
 =?us-ascii?Q?3R/geMBJYEBgAatWr+wriwCEBygBJXXxxO91xW9UnE5XabTrU2CR5Oo6oZp7?=
 =?us-ascii?Q?MDQvWaOuyImccJG7ZwsJThehCvendKy8h4EFcTXPF69PFcHCKB4rndFTEuAT?=
 =?us-ascii?Q?FFYJYYax+AgLOx0UqILE0IH9nLVrbaoQCQfsQpxH6fQvN3WVkVMuhR/gW7Zm?=
 =?us-ascii?Q?mXm4zhGunVUExQHWymz/XInsePf7+jGZTxumkka8hpmlUk6/zhKuMwbQoNT8?=
 =?us-ascii?Q?nZgdeF3C/CgYE8fh9L4vv0gSdTqe9lTrO14wayaasC2CS637i4cCi7l7iz/x?=
 =?us-ascii?Q?MAHzGTplag3NofR3bXD0nB+pRuff4dM9plZnA9kdb7BEoqjTlYNmlCyGlNhB?=
 =?us-ascii?Q?J5k7HVSeMsa4Mbo8OlL+0Ai4b9tBNiq2u8vMI4N8KYUxyGZmYQTpcNXq7XTA?=
 =?us-ascii?Q?zKX6Kphi2K0d+HiIVXlEntqqa9cOfrA7E74elAi8792e8fhhNm6CPFSBRsdk?=
 =?us-ascii?Q?K2oi3wLtxFN0Yux143FJqIl2RGlMVNrrm65ip5d2uolsMOUclbVCGybbBlPP?=
 =?us-ascii?Q?4LCFfwshYoGWbq2V96VBnfLDNpLIdR9xCHDAGCEdaY0aP0mYwd2UBZ4cQYU+?=
 =?us-ascii?Q?eW+Nl8imb8hall+lJiTMyjHbRZJWMQx524mF0pSlYB5oyOATVmSIvp8jFiQZ?=
 =?us-ascii?Q?BaBDz8sRCixESrmlfQjBRJTfrIuJLg0SFQlptfBh0GkqErLeEP4lg+mN1hrE?=
 =?us-ascii?Q?OEPthSPzsnJgm4rV8O6dqaBE2FqMuKK+egOjrg/GANQH6nK+dGXCwvsRx9DC?=
 =?us-ascii?Q?KyIK7xKLFv2y+azr5ldPGrgcB6osp3j60bM2U3UX21aWO7IVKVj962P2rrUQ?=
 =?us-ascii?Q?vgUKfqpremz4w1h0E0sbOs=3D?=
X-Microsoft-Antispam-Message-Info: lNFA9jVecFSvQLY97xe/I3ObTih7Qk+RN0I7SzmzwsT3CgDpZnt7S62ES3+u+9EperH4wHcYTl5qw1kd19TUQzIHNX8GnD3Qwv0AmOl1VUb6dUp75aREzgiDHsxGpVapMniFK8JkqjadPQOWCeWdNIJWtAhD4tG7PajulrUoqCWkVQmiSSIM4NS6xa0zrDCzsXZoCshf9YgAjjtCUsVdQhNgMU/Xrn96POEgfjJNr9YBBq8h3HAcMb2CuYU4/2JTMvEEDGHupX40O0wAY+b5jmgrzFqkiwjB1K5gsyER7oPTsQdFWVchaJIpKJd7Sjgcsu0wPKnoroypOXMBRym8C/1sXotY1KTpdQcA9jLpJgE=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;6:+8mMtTD5r8Io95dGhOONlnqS7Z5hl/qDvPjlVfMZw+UfJkkSHbCTNXWS9GjV1VB+6cyVVigTLLdZeWs+xHeznn4jMN4z8kfaUcvpkpeHXpZilE4SeHD+Ed2DwXPJ9Ro0PHehnCF1ih5qhfDFaK8w84Yrs19rrbuUfnU7+1vyrHrEsbKQegwOqfVJyZFlZaNCC4XcDIcHDFAW59RmH9T5bc8Hn64MdcF/Da8m8XwjcZE5xGqXusODeCMOK/GFkF0oVyhMiUA0JBzrXwCWJ2LdMi6ro2uldp+E8BE26d5m7jrCAzKeAXjNYZWpWJL7HLdBLQvNCdqI7NhYhIgH4fxH5PCLJYDHtQhnBBzI2IB9wMrjJ9luRQsBFyNAC/uYSjZQXD/0PM12aoaRhxM6A/Eiin8nqLuqIKxsMwHRFbHkumuVnKe2+491Qv+ci4cq0kiEiCP0UFiaVUsGqd+juDxKVA==;5:F3Tm6MGeRibFLgZMAXUB+DxM+LPvG3llDVaxTccrQFYgrxzTjZ9bKNQFOVlD3oCIuPsjjSQL5kwJ9IgwIyoGNk+boh5LUFJI+hIolbeOQIOX6kPZhPWu1H6IQYfKoLfx8KBG3RFk3vSxPpi8vYW16cPwH9qGpufK/t7H/yqhmYk=;7:hr0iK5zABr70wuxRxy/xl/MqbEZZK3+/Cq+w+EX2TUWnRS76NOW95pDk1wtkGZl02KxV8J1uItfIW2mrtPsg3+CkZw3552tDmmAbLJV1c6DO8OwNaWWdtr2yg6GDgm//uagO1lKuoJQYfGtB7/CnuAVSPVcEQ4MSn6IoQJipXunA2PVQudq1wDeR9oIIR9ys46V9wPptRsnq7gBY0aV8LxCByzVEtXKU+ldyp6DoAcONTOprDV9nMKcQiDQx1kNb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:dRmZNGU4EStOcIfQTVsgNK4E6+Uj7zLvYCUnpBydMr6yh9y2hLv75QC/g2wO9BA6vFKPmLfBqeTPBa5AYk9olcRPjeNq/24VOurejgndA9qVm7tC+QJl9dL+CfXVOg5g56zq3OXAmjxlsEYcSQkaDb+yIQ7nR7HC95aoIpo4jgo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 00:36:41.0302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f46611-207b-4f65-0590-08d602472b88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0169
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memcg charge is batched using per-cpu stocks, so an offline memcg
can be pinned by a cached charge up to a moment, when a process
belonging to some other cgroup will charge some memory on the same
cpu. In other words, cached charges can prevent a memory cgroup
from being reclaimed for some time, without any clear need.

Let's optimize it by explicit draining of all stocks on css offlining.
As draining is performed asynchronously, and is skipped if any
parallel draining is happening, it's cheap.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4e3c1315b1de..cfb64b5b9957 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4575,6 +4575,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	memcg_offline_kmem(memcg);
 	wb_memcg_offline(memcg);
 
+	drain_all_stock(memcg);
+
 	mem_cgroup_id_put(memcg);
 }
 
-- 
2.14.4

