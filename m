Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA83C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1FA20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KBbuiMxj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XzRL1AwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1FA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeIKCw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:52:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32916 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbeIKCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:52:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ALs0fH030472;
        Mon, 10 Sep 2018 14:56:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=MGZdVmRmN+xAVRkWq4mvTV6wV+JEDsh8+laIrWHOoHE=;
 b=KBbuiMxjardVlLWaM5ScyhFIpIlsoL5w2F6HhlsqdDCqdI2bOZhlrBA8ZTaC8CDj1sNx
 15tekQOtD+OQkH1rjrunphb1XuNzOw/uxfhuBgL+2dVT4nXX1nJLPoUNK/CQ6AzjOYOw
 eCXeVTkq4rRyNa20GQqBLjj1Ee3QMQegIY8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mdy81rayv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 10 Sep 2018 14:56:47 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 10 Sep 2018 14:56:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGZdVmRmN+xAVRkWq4mvTV6wV+JEDsh8+laIrWHOoHE=;
 b=XzRL1AwTOdnvYjSyt7/10a4WJhckc8HDbcSwGKKSnWCXGv+LJv2hY6RRsgPXFkq86vg2V0mC2pPLrV29+HqXf5B9AzEeDbaMtNEAlJnPWSivqgsiYXrrXjuNFGHvO4TkQe9Fmoggf97k3P93kRKeAJpUMzIPa2O11S1PShM4wg4=
Received: from tower.thefacebook.com (2620:10d:c090:200::6:d788) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Mon, 10 Sep
 2018 21:56:43 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed high-order allocation
Date:   Mon, 10 Sep 2018 14:56:22 -0700
Message-ID: <20180910215622.4428-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:d788]
X-ClientProxiedBy: MWHPR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:300:103::12) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c498638c-4dbd-4eca-9a02-08d617684c61
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:Alohij6mtKj1/V0dMU/KJjNDBJkdONpX2//UAtQzMJY5wF0CKxrfw08dQ6YyM2yLKZTvPTLHrdb2x8AnBl7OuvlvInl6kdGLdp7AMG90rK/a/XYfa+A7FZ6tLIxWBP3EZbv5jMgIUiIHd77A6AW7BAIlv87BUB+kUzpfLrr9HXq/E0ymlMREgscT9qgTGyFM28NtskiEYR/NHAt6cgjnIk7xEqNBlVYw+8Jg6ge+/Wb/7YpyEtQtmVa71Lx6/sGo;25:3QMdLZrEVV8rBKeoRsN6fwkym6TLkdzykXCgI39ts5YhVtbzhdJU1HsoS3o+1NrqMNwvb1wJ/oIQ415Heqp9qUy5pPUMqkV7vqMMemWO3e7pO3toLKpaxdO2vC6HazP3hodqEErk+VsAaZMPL3eochKG7ZdLmbhoT0f5Fd1HKqh91JLDR7eU1ILemlEytyjVRiKm5luQ6Kbf23plLtGq7bJ7o19IpDvIgDbRo8Uc9ZdDfk8/AwO3BapGFh7Y6tNmiSNlNszHsa+yBPq6YWTY80Oy/iHQDZkhEsyzO4G7QtMe1BgJLJAtH2qkP9Ilsxq3quHFN/hagvC+N/nZkxgSDw==;31:OFBprtoAEXm+jhC+QM3C+nbnvlqLQTStdduUliCIfTJ1jP/4ZWj33TpBCVoI8xy0up9w2SuhUwL4NcvBvSJKVafUDWhlD/TeDyQ/oUzU/XG2uXv6H3op5nKc/ftoPx35GlsG110alQUJzLISuNbDeOM0sLVzk8w8Fa6k65dUADgVnbBRiWfkEU51S7b6ZAiROouPeEvzIRY9FO0mJcPqutLgQ5w1IkwNECKoZiAnYsE=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:SxHkTZIE7rVMcy8J+6aq/jjNcwEidPa6S284MJ+DtCHURD5IAXTyzGtnQUOrpWc68fNKjdVoGuHt1C/+7LogqFE+9cgeXR06pqB0fkxhb/xisWpunV1eVpnE9An25Tm4GAn2tuD/KwFvFLx3786jFP4zTHIbeYKpjx2KEVTb7Yicow4MfdVcfJu4SGPzmwJjBO1P9uSI8bK3mxEhWyPQQlxkKCZWQb6iQfrN6FWCd7EoVLlEAkqFWRY/ebSgUvXgiZ2Fd6qIJ0fVnlnPeExR9no4ZptTlBV6BhS1mJaE2pFcNJsT+J4XD/rNfqxNcqk8OtwQNbLRKumbRtqEGceT2CIygC9Ahy/hoxvCoJSvEWFMoQ+vd0eO/iFHTeh5WqpRzPEv1p44w5mdSJ8zE7OZ3sOq7094xYzOTJCPDd31vVSFe4i/Br14PmLUa/6COgu6dbdkOj+2uzl1pARR1roG0WqY+fNCsUEiY44m/xH7ZfDdTqir409orA29iOchbyaj;4:5vlnhZ/u3tXONTrbJPxMuAE62AMIAT6axgDe4ffAP61XL1MbMBo1ML3KOnW3kaDCIM11X8thMwBKrIqrIW4h7Tmrq2XyiEqA36sO9UVIRsWlSudyg+7dWiOoJrovsiQ9SeUryyr42/TPwJwqPNt8ZY1cxyvF1G/Mi5gtE79gCXvx/CzEMnsknuHlUpJAg+vinB+uNiQjzswrCBIm4KU3XbU1CjUMJel0lfx/0Zd1wldHowdXWH7vDERT87B2t78p4C08LdVejrYJMHw0B3MTPXL9i5NtlFMXQ0vT7OqpEwEZlviK4jsRss3L9EyboJwqteFGTN/OLXOhoQ2a9FK2K8zpIOwPKZS5rG2UVmUc5IY=
X-Microsoft-Antispam-PRVS: <SN1PR15MB01764D745FC2AA10B2CC6420BE050@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(52314003)(316002)(2361001)(2351001)(36756003)(106356001)(105586002)(53416004)(54906003)(2906002)(69596002)(16586007)(50226002)(47776003)(7736002)(14444005)(305945005)(68736007)(8676002)(81156014)(86362001)(52116002)(51416003)(52396003)(81166006)(8936002)(6506007)(16526019)(39060400002)(48376002)(4326008)(97736004)(46003)(6512007)(53936002)(186003)(386003)(1076002)(25786009)(486006)(2616005)(476003)(6666003)(50466002)(6116002)(6916009)(478600001)(5660300001)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:g0PTZaSbYfc0l7o4t6OAIEwjIJBJ32YJ1XbJsJ4zN?=
 =?us-ascii?Q?zVESYFywqQbBy/3AbhlgPCq5tj8kAol8a0WuQMYNC9IwDtl7dZjH423IOTYt?=
 =?us-ascii?Q?pUC/gLfSV5rBBiLFfgBL3ij+gfiuXdADjH9j9yMrP/TT+d3L4Rt9AgY6uBCE?=
 =?us-ascii?Q?9aNQFN7d1batt1k/dK4/Dr1P35RA0PDekz6BqcMMR/8rt3MLyM73avfsiw7N?=
 =?us-ascii?Q?JeWW9be/otQ6LsleAlMREg/whIBfI+hdzrvlwYP4KhivObRFy3DZyd3qWKfJ?=
 =?us-ascii?Q?3kpzxvIykbJl9V5AIqy78o5oj9ltEMuVLAXsYKKul0KSuGCqY2MiNT5XaDkS?=
 =?us-ascii?Q?veSc68rZfXGVtOf6Z9TurtV+TOG+21J3nNryahmZCsAJLWCXapdGB/GK3hht?=
 =?us-ascii?Q?A23sK10A3FdyRRt7ZIEGQz7yU4qDb8YgnR3kc3/3X8wuk405wR+iGIhrOZJg?=
 =?us-ascii?Q?4VGnwW3fghfQ6WMzaqYvChs0foKexnuf2C4rZffdsKwpkZFEQim5jdrcrcyN?=
 =?us-ascii?Q?LU+oC6eUWGAGGqjCEANhCMcOiT6TyvWiLQeFH9huwqYCmBMjmSFnxF6fgLST?=
 =?us-ascii?Q?cOkFFemWrinaKKZFc7ZU/n2o/Dd4ip+dIeoVMieWekRBrHlgAMFfVOmKxMnb?=
 =?us-ascii?Q?L93Eq9s6EqIl5Ldtidwydvl5VHboPYhCE2AhzFlgSS0ncay5fhYSty/kSuZP?=
 =?us-ascii?Q?l9QQvGrUU0HC6kHGBoH8tPLLM+OMNXn2wXRRzvxDqyPnOZdNKfUygvgOJIeL?=
 =?us-ascii?Q?GMuTPBmgH5A2FeyUwOCwf+i9dW/g8y3K3X2cLVO35xBEYmjnPv+Sx9A+lzma?=
 =?us-ascii?Q?kwOd2+k3WMewEaJoghg3JvPK+eoLhMkPuZMZzcGb6IECjMrxJ9ZZ4vNk2vhQ?=
 =?us-ascii?Q?+Gj2N5Y+YJzDgGlYUU5++U3B0GqrlDZLtAwrzidYCvBwa4tRkBQBrKrZwX3X?=
 =?us-ascii?Q?WKmPz33kL3wjocPxLpzLlt72kgE++Kh/lPw1ajhCH275vPunH5dkDuyxyGd1?=
 =?us-ascii?Q?04FgnAQusjN69wNf4UUOiT9n3Ce6evYpGCZlYCAZOSu/2ZrSAR1Fck7lHjnZ?=
 =?us-ascii?Q?envz/EGk3si39HnrQ82whyV4HbRaZxQgFj1aKAlmrtRhxD5Routx/P2qvwYQ?=
 =?us-ascii?Q?xF6ebLWFa4M2ODJoNPKo3N/zP9wUJn3dYPLsHlEr6gjv91o3nYPce8kHrRQO?=
 =?us-ascii?Q?wocD/csbZDGqGbtrJBv+jkfEXWx7fS1E4NqD+2MXkvTjHRewkHUU95GwXsoJ?=
 =?us-ascii?Q?k7ikikJVG3RgxIZYEpliNj+BPzlXvd/16K3ZJwM7dQGCfRLp4ajJqxHk+57Z?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: rn7w3/DvZf3MtV0yBHHktovWVbv9p+juplT4KLXWKnITX4cF7nVNkCL/TePW67AaK0fITaFfOss7+yV+eTsGKmZxV8l0Gj73s3ljoQE8aOGIm+9dqKLuVHmllgN9uYR/QwOqZ7NnNQgyJ7vhviT9m8FrkmlNUlLAIMXit09FoKigmCfUeCHETFV32DGtUMn+vwRtt/n2KNuciF60KZXexOul1CSiCKNh5w5Hirc/syzhFs1FvBmMfXULbKeklb2udkRSke4I3kmr57wyEeSd28heab2An5RGeOpP3E/JbGMrSlYQfAJbAOM/ISYVPVNG17ot92yHyOSYDeQYYJFDEhIEiDNlNWoGC8IrNO1yQIY=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:fQEbLZ70s8LVelUL+qjVe0woHqZ2cirOoicz+95bNhq+2on9WVNZCWdQuIupTt7B2H1vRcTzofBDPKHnfKvMZo4kWT/mefEYbmtcV9Wq7mQrOjvpQ/DH8MesFxVyGy5yKL2X6kD5JcRuTqu2ZX25EjGXQ511QXXJSj4El1M5Ss5+hQWi/qBdy1g8BhWV8pw3km3PHXCS4h/M2Jx3XgEM9JksfWHbE9FlbU1QsIxrFGOZ0XwN5A8xorFz9i7grERkdMTnSfiPUd0QLG0bHVynEH6thTIHPBguB8dJ7x2e3tjCjJ/PV/diFZlal8omrBq90TjmW0Fim73RkUFJ6YrRQNvbcvI8aNKJmFGFXFw+7cEDbXZVZNEDTeqxXONUi3q4feVoD5X9FAUmTKpcuvn591PjjNiP9KyWC+UFjMGM7WZPD1JJtgb6YHudFI88h+VMwAGG869h552gPRq+eu87HQ==;5:44rNiYzgA1J8hfWNn402XLVSxDqSk1RtFnCxTcPiATE1tbbw8C3CCdnJ8QGJna71X8AM1sdP+1YGc7r50JiOEJLr3WC7GD9g9TGOJcowkb+HYuwP2WN+xVM9zwqIghW93gnGdj8posUPm4QtX3HqsdkiqWP9xOqHGYCh9jKn0oc=;7:gWUJlgiHUuRWj1XCiUQSCHweUY22E1dazZe8794ZgKI/fIT1HBhSU6oBZVyccG9PWi/2ZH5VZZmrBGfHybBm8OuM8F7hv9JHeabapCnV3A+V2iFK0YoHuviUxOmVO5dCI8LD4QTjMTgT/jFDLwONXhsnNTsbVxbBK2S6+3PEks9M+XcBYqQmLPt3rpjgv19MTkCH1nkKnGfAkJGSkaS9WZkv+9QmeiBNBpjNBthTwjTqGCs/Eow5fPZqrnxykOIW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:4FGzfvdtEi0fuRbJfU9HtD5WxFAn0MWst1dZ9fgiRMgU0Yix6wbB9Bhg2LzcbgvO4D9Fc/GwIfMs9Tt2ow38LCqhed3at/P7wvcKqkxLuxMkAGnk5qftOIJqEPTv6LeStkEXHgA1SqMjG6oeSKlek0Xg0Vn8AliDnmRJUhrZkV0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 21:56:43.8287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c498638c-4dbd-4eca-9a02-08d617684c61
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg OOM killer is never invoked due to a failed high-order
allocation, however the MEMCG_OOM event can be easily raised.

Under some memory pressure it can happen easily because of a
concurrent allocation. Let's look at try_charge(). Even if we were
able to reclaim enough memory, this check can fail due to a race
with another allocation:

    if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
        goto retry;

For regular pages the following condition will save us from triggering
the OOM:

   if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
       goto retry;

But for high-order allocation this condition will intentionally fail.
The reason behind is that we'll likely fall to regular pages anyway,
so it's ok and even preferred to return ENOMEM.

In this case the idea of raising the MEMCG_OOM event looks dubious.

Fix this by moving MEMCG_OOM raising to  mem_cgroup_oom() after
allocation order check, so that the event won't be raised for high
order allocations.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fcec9b39e2a3..103ca3c31c04 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1669,6 +1669,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		return OOM_SKIPPED;
 
+	memcg_memory_event(memcg, MEMCG_OOM);
+
 	/*
 	 * We are in the middle of the charge context here, so we
 	 * don't want to block when potentially sitting on a callstack
@@ -2250,8 +2252,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (fatal_signal_pending(current))
 		goto force;
 
-	memcg_memory_event(mem_over_limit, MEMCG_OOM);
-
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
 	 * a forward progress or bypass the charge if the oom killer
-- 
2.17.1

