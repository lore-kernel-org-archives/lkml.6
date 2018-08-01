Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE9FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5C220862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k9mo0tL2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ER477MJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5C220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbeHBA2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:28:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732358AbeHBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MXJYr025470;
        Wed, 1 Aug 2018 15:38:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=SS3hL9y/Kz8AKahUGvBHEw2nIAlhiKXXnDeKs9koJN0=;
 b=k9mo0tL2FTZx6OoC5A6i0GmnWjZR5gws9UUQv+tcQk9FwuDa428tC2ar1+mp9VMLdYDs
 ONhVrx3qZgLe+kNxwleqisVMdd8Cjw5JyHzGKE1GE2qadUMxphnTSYnbLXhAv2SurWUz
 Yk9yIMI1F/RlVhrVDHJul7xbGWfkQohJMoQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmytg4e0-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS3hL9y/Kz8AKahUGvBHEw2nIAlhiKXXnDeKs9koJN0=;
 b=ER477MJu23JQsGCWoLB3YyosU0Elu7onQbS7EfQqwqf291fMgxQtUulSS04KG5Qu57KgupVIdeJJg4lkpmDRq+QAMHMZ2neDE+v0QmirOkBylNfFktEJxOL/0wBltbfCf4YbThBoqszQ09KZd9+AD1TeDO2czPcU1KtNCVnAUj4=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:14 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 01/14] bpf: add ability to charge bpf maps memory dynamically
Date:   Wed, 1 Aug 2018 15:37:27 -0700
Message-ID: <20180801223740.11252-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f527068-3e02-41fc-ec9e-08d5f7ff7879
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:7rGQOUciCnxiyq+maoEq0kPIyRTbnPB18UYIOPpu7k3iX/ylMkqm7m11Ma+dVVsmW7yHsuKZ6RKAi7t8ZMkOcV3E9SZx50rPQfDpEkQho9A6c84acQ1VNl8p/SMPVLkZyyyJ68fCXf/nE+AfP+cAl2/h0zrBGmQCZ35r4NyXkccwu8DeDovanH1JdC0ijDvrXJhtwcHVFDNAOLVzQio4N0q9HrBAvyUDXOSHCJqtN8pMMjs+C/HSfHjCcPafXSaE;25:Pkm23t0XvU1+iRNiHqxm41pa0ybphKl7EMRs5Uv3dTJQKIP8wLd5JUK9EXirudngMERwJ2cMpFhcbsbSMU6jsTd/+yD4o9NUx6vKL1MLz0MJ+VhlWk6aCViRFqlHNqWcqx3sNZKEaN63xN964J5O8lpB3oqiuSkIKI0oIJkz1Px5NMQWaJk3WfyUYte/m9y2ugOtRB5GXlTmFDDxfaTCy6WNKnK+/i5jX3cZ/F5+OhRT7/LiqYLkEmPSaHjEdJIlskIVSaLVwq1mm6birjYxxdiQ7K4d0RaYnoC3+v2RKYyAaWUMmQqy9hYBcKuxn3RvprR/ts6VTW9naQxGIIKRhw==;31:mWkMbnePKEr12NbEzjpK1agXy4UioTmgYyR37bSQn2IOBebGkAKU+HexXOM44F1Nx392MdGSUoqGvbPM3Udih5jjnlPQNkvJ6j1MObJN/u/ke3BYGoTzOCXQz2b3MJp5+afjTzxONdxq1hKYcEhnTb/LIGMCV+5EhuRXG8N1M0nK5RS/Rpng6p+8+UBtKBuJHwAhbe2zFkW8mYf8ENjw20erJMXC/HvQSOnhgLPAIk8=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:c57DCugqi+TE24tj8g06qNdz+LNDkmLzFqXaKefI9UXaV4LAlP3isMtHKh7rAPgA3ue22pU5NxsmQCGljAtklVnvyu2p2Qm/o7eWa5xnWNhpRKyLTyfZqtFPqp13ApTQD25w61POAdHV6bxJEMqHbEmiflmFbEVx5lhUxl0uXDBRrsHQgw1TeLytRo21AicG7eq0w2RfUDX0oZlnc/rl9+lf7ffos1x57u0khG0KbEeEL4mPe0ZvNvYKLW+kubrZSYKTV58IZzgcXB3nEgZZ/jnJY7tORN5UifXkNq1lsJRVJhAcVz9fgkmuT2VARHkZ85pe09YWFt5sbaTLvMp1vYT6z11B3umUeILG3CUXdEMeAUfb8ljIrI4wFJ9zoTEp0riNRtpKXOVXI+n78GVoTGvDdmo3wgqjZrAyrBDBe3CifXDP7Pqv3Md3XbbTgC1FhHfHPoMsEliAQyKoRL1CleNigKp8bSQVnX8vJNHyn88RKfvx0FYhy3Z0erRzIZis;4:GrIQBKg3/5OCtriIb6l/8tISUy12nnp/0ZDmeXmUpUsuF5GH2g657IOKHIxqs/a553Mt+CNNCOEwasuIrI9kVkHeEVRPI880f0Evl0rYFF5wfpo/xfRxrMNvuYnymAZv8zpQ+Nnjg62PSnRVLIAijPzJdujJWNCDVD37R4fcXRKOtx3LOY9pIA3G/+7nlY7ycdSi5QFrAy2nrsCJIorw7FfqNwpoHhy3JTrkbz9Qsj2WQC+fUVagjxqweHCVeXBFOqrofRF5I2x7VHI3BAfMtar8EcQ+EOiFW6mhI6r+dKxp7VpN7p4uuZylH4NQVumz/H+8j04TCveDRhe56IiMWkpdVixpj7vnN3yWn7YEhkE=
X-Microsoft-Antispam-PRVS: <SN1PR15MB01765F790033C08125385BF2BE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(575784001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:acHIR3p5Ssdbelgrr7gK26voFrv6BVFQnW6+Ln1z3?=
 =?us-ascii?Q?jNX/LFkFdiPl5YhqwVgtyWyjq+Fj7nozlMA1F+tD03M+WFZms3n3iKK8bPL9?=
 =?us-ascii?Q?zJ+cx1t0VQ9mvOuU83eSO3DHBsKfiF6n6MoePSY7y7M+fpafHR/Dham+f2u0?=
 =?us-ascii?Q?OY/QRJonSsIRznJu6AlbyHcyNmjYWZDhYDb/R7+lVH6LbI4H94BYWtYBaWbK?=
 =?us-ascii?Q?joe941qDU6ZyOpnxRkWXqnRKVwUyC+D6ySjQ5WyQZD9yRvL+5voDAUQx/XKQ?=
 =?us-ascii?Q?/PVInIT6QZfVJHIQ89NC1rvRSJ/Vy6lPfiM/ONrYYtOfx/Rn5hDZUk/2kECl?=
 =?us-ascii?Q?gxPBEWjDFE0wgTqHrTF48iPu/n4dFjSKzwj/Wo80wRdr1XZ1Iu6NjfI+VO03?=
 =?us-ascii?Q?2E+Ki0kuotsTYf0N4ofhVrCAIetvFWV1oEgO1EX/8pBPE/UbnMAejE0SywzQ?=
 =?us-ascii?Q?6ftRzF9959DKf2bKgY+vmqHA/gxSSIiFgbNSCwXORnCwrI3XmSRXBom+8QIS?=
 =?us-ascii?Q?p+4FIFigFHbGjas85FLZdhHvIHcYpD6deIr6NoJC+kji57/HfT0RbfZB8ag5?=
 =?us-ascii?Q?KZ7wh9WQheJy2wKkl8QrwB3IpJC0oYe7b+yR314H+t37ldXRMbqCudW4d3gj?=
 =?us-ascii?Q?JI5v0asWwFha4R7L+vPS40/b8K4LsY4QqzsgEhSgc5pMd4utfTxa6TXsBAVV?=
 =?us-ascii?Q?QcW1F8iDOZygu+O5l5tNUHF1YgK0AjfMmoSq66XFtmBbAegviQAUUD0JVfQe?=
 =?us-ascii?Q?fvQjf+udWz9IgaYhe3HpZSeJmQ2ObCHhJTPDBiSkuHJhsCAfb18p7lJjBxfD?=
 =?us-ascii?Q?wkaIVoioxIwYIbbfwzIhWpqsLJfwCTXUqLRPXp5mtRRiBR/kTE5aHnad9eii?=
 =?us-ascii?Q?c9Dr/JqFdGDrSY9iXiQp6bLR44OeuN5CgSCJGetAktH8dEEjADYhlaOk6pAX?=
 =?us-ascii?Q?nkSdJbYszH1QfGzEMSlDGHygNTJMBaCwfHRETR1iwR/K0LRC1qrYhGXlvTuK?=
 =?us-ascii?Q?vrtqFo/zcE86XgTZWjXfMwJwMbaAezWlOrHdyNadGxMF4HL0t9xWWKmbbz8V?=
 =?us-ascii?Q?DxWSuPAFJl6AwQ5tu5r2gPXFIOVdPoYsEJiReA+BnQpDDfk+GZTWIial3CXD?=
 =?us-ascii?Q?hOdCzqpmYXXOKphS+TQtmemVv7e7c3EByOIm6++wGX1G/7D38NyLmHJOsHRZ?=
 =?us-ascii?Q?0jojnL1ScCo1ZEs/PwBcSOaxn0WmfHhfqOvIgWP2Ykxj5Paw13hVUoO6BoCU?=
 =?us-ascii?Q?NuEzh/9l4F323zWe9Dk3IshTLWFV5gXcv3LgX5MmjJISD3MWwx+2QIjy7slM?=
 =?us-ascii?Q?WpXq9f0nHonCJ4yObjMzzo=3D?=
X-Microsoft-Antispam-Message-Info: dB6ahwNGXvRFNcFyN5wCV6Hfb03a7w7AYY+TgylxDPslKvavvyLhVQRKtQmaI+/KUDk9l3Z5Z3PRlytIEsa7Oy/Mv/Z2dcq0EjcOrPrsMD/uojzyXB7ThSogfDCdwX1vf8c4hkyacibT0BO1linyQjnLBcHv9SmPhtjGwZHLg+8u0Ahv7sDRsVlBWQdlfCZOVnr5br4oxQbTOzvXiCbZliOuqItCF6klYG+mXm7u6rtCgcHYr9XoB1SYc1LSidlfsaxPz9LnQAAmz55xeeDiEtDGn7yLHhDTFLu7N9ncyED39cUxxt3HbAx8crS4UyUYNn3QRg+q2ThW6oFOXJmhBct+vycTCR0Y0ltHXJrcvAo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:kbnA46C5sf/Bb6vlo9Kpd6lo5c1fROvaWo3BImeD+pcDssdvOLOCnGRCsXz41ygV2LLYnuBQr8H7i48FChqSRicVU98kra0Huab61muZe5TVDFpIqSSXceuKyYbXdlvqQAXcalzb/MJgVa+JU8VI42LeTjNj+q42oj+uocwM/UX21GodrGwMQ+4UFBFNI0YnqZf3sKoTkctejhDLbFzqhlmhhVNh0rCnm6515Kvi8O08+uJlC760Bs2cFFOsI/rroR8hBIBlxjM8CD9Byqy8D9QraGj9oOfQYvvaZXlywPBG1GUmzRbauSSRhmcplUAencgdgIbfMY0fyfIprdnOQdcGqPwqiuyIAgkZ5zpFuRFwnq5ibILA/YKXyWcBXlXfNeUiPfmtwXidgWuOiuI4xPRrH/mDR2Ut0dVM+bU7yrRoBvsd6gVk5D7gm22Yma73Xo09NXX6rCdstLYdgP9EtA==;5:XzRoxi6/vfQCySC+67ew69g3Lf0KV/yJf4whpTIP2pX/ROJqQwzfQAaIBXIUUB0z1Qip0zQv9bnLRHD0vWvUihmZKnw3ZzNAedRAoHSd/DCJ0yQdQVOdyaPbWXg+xGQMeeBq9HU+GIoIwrQyT0K8Xi/TiYFnc5Roq1miA2ygy2s=;7:Q7E14HOmSpZJNWNw6z9Dzi2kosF4KfE7pkzscbHEkZOezzX8MYDi8+EZvXaZuveiRCKgxL9deWImJ396lGhjx1j3K20GZKeHbWIveqSjXLRsfs9ZLipVeMC11uz3PRRWpm9QjxewKL5pqDmTdo4hRaG+QBsalFnz5VY3OmR3J9yP5zo1fLvOtBKR4QqCINtMXJmG7IdvxXx7KWH057KWaPGGHr5eLa6XpuuoJw0QcvJM/dFIo+ym0cjDL4yMcvDq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:VKCE43IjYDHXXLBg4Cy2JWPmUUPUxdIOlXmgGvj7xSJvHrnYD9vBCwcdYuCuchbyAWYOFrEFUFzXztMxxmG/QV6pHPGo2qL85BxQEiITkK3cIn061oUXkfKrSzfhEGEN7ZqBXxK/LlQtYG+2MIayJsUO9ik5zvt6cX8SEeM804M=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:14.6504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f527068-3e02-41fc-ec9e-08d5f7ff7879
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
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
 kernel/bpf/syscall.c | 58 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 15 deletions(-)

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
index a31a1ba0f8ea..7958252a4d29 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -181,32 +181,60 @@ int bpf_map_precharge_memlock(u32 pages)
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
+static void bpf_uncharge_memlock(struct user_struct *user, u32 pages)
+{
+	atomic_long_sub(pages, &user->locked_vm);
+}
+
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
+	bpf_uncharge_memlock(user, map->pages);
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
+	bpf_uncharge_memlock(map->user, pages);
+	map->pages -= pages;
+}
+
 static int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
@@ -256,7 +284,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 	security_bpf_map_free(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -492,7 +520,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_nouncharge;
 
-	err = bpf_map_charge_memlock(map);
+	err = bpf_map_init_memlock(map);
 	if (err)
 		goto free_map_sec;
 
@@ -515,7 +543,7 @@ static int map_create(union bpf_attr *attr)
 	return err;
 
 free_map:
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 free_map_sec:
 	security_bpf_map_free(map);
 free_map_nouncharge:
-- 
2.14.4

