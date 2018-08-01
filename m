Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E130320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FhMxhbfE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UmJD32fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E130320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbeHBA0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730632AbeHBA0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:49 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MYfoo016468;
        Wed, 1 Aug 2018 15:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=FhMxhbfECWZ89m8I8hYWKjJLQNxns0xhX2bU+UFqvRd//9hWYT1OG4grPiq1sKp56JHm
 NSglJydc7MeoLkkWjC3xlFfMnAUeMIOQsA5D3xwooMEZZcbmnGKWdfDyOoLkd1OQ+KOa
 7gLjfPwHQA9Mh8PNFYQUlvYaCSB9aBKSem0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknrj80d0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:25 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB09.TheFacebook.com (2620:10d:c081:35::18) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 1 Aug 2018 15:38:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 15:38:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGtDowD9XKbzM8Jae4SYFfVcCSuFG5sG+sEXv0fEVv0=;
 b=UmJD32fy3G38h/pSOlhqJcDRGf1Pu1WLG9IdY7RONNm1uUJA2IREpk8VJDGnpqWO8j4QKfPQlgv9d48VxNWSv7EePGqzZahE4q04qMndIDv60XJM5YpIoFigdTp9tZsu7SU9AqLQRgl42ZLYHrLllGB1LbgUa2MSpm+rInP2FQc=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:20 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 07/14] bpf: don't allow create maps of cgroup local storages
Date:   Wed, 1 Aug 2018 15:37:33 -0700
Message-ID: <20180801223740.11252-8-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54ba96b2-2991-49b9-f627-08d5f7ff7c41
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:Lm1PAn/7eVZSjUz6hHhbb44NA6O7+o5xMPXYnIAjU1qVm4E7ZH9BAANcDzj2wR0oIscTigmoAIq/vNWOgEtsRHTjxE4JNrkowmg0oCsHI0C8XJXqaWA7bzmv7nz6KBzOjNP1VZ9f+cbLceV/msABIVMG6ivZUs4Lqwt50wyAoQAHCsUiTduEoTxYHX/4il5fRWw/5Z/PpyyjdfGyl7lXTLsg8L9tGyVvX3t3LmnWUCSfYDDhdC+G8cBLSjhfQ6CC;25:A1u8nMeHMQSbHXIckaPEovGFZH4aUa/foPypmRP1qhOGcddYFkZjnre/QaByLoMq1kA2tkU78Ig4vWw2X5lurx8dWjrma2V8cd68KnkWoAUbQ3my+RGu2ug/mZkwWWE/DLNA9CwdxmY6WfWEkjR3unAZYExzu605EAy/L3EiuQCtsrBb4Fk+6DsW4tgWzQvwV4P11C7VEP7XtXdtQyzbYjyl4Xhjq5JSPCUBCciBf3dYHG+xO5TWvH8lLxrh2FMzVgIuDKlCV+gLse/SEcCZ7wFEddSdBpfhbgGIxc0JIcOqWFjS5t9GT5Nl2bGCPlnR2a5q5pVUx9RpdfK+mbR2dA==;31:77lto4bWxNMx+3Nm96bxxfZ1VD3aaG3eyA7XEOBvNjA7/UvaRAXNQt6wM5NhHQ8ETQnII7CRaZBtbZNMnMcx6gbzB+/MNNkqoka4MhDSF+lfOzbbpfNOEWCAOYdEn13T2mq/qXO7wSj8ICwPPPfJiZI9tuECvIfbkoNVx4CeZzkVzTn+HNHjR9E+t3xzkrbckDuSYKC9JKkZoTewqjAffFSKoEwW7hBysjg0hDiAizs=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:384I8qZ6dXhTRSBxBRDVkEYw+nHL4TwgU4v4z52Si03CQjP8B9HZec2Np4W/efMNmEfBhqBkqbyKck3+epJNc0icYzdD/44a1sx797HmiPHgl3b7f/FgWQ8byBLv/t0E2nT3kIxL20GJdf15SQ5lW9lsT3NEoq6ciyD8hFZ5IM2HF1HND24trjOwSRFpITXZ5kHC+9mMV15wK6ucNxLg2PW+K+WRJo5JtSefd4V5XUIMc6MI5KqCxqSFghgrr9jtuY+rRa0AEOUhiQa8gCPiey2UbI8SV2tbu+jlBrfn6W2Ub6QWLxfkTt+j08K8Du8mLaFCJqkcyhzWcQ/OCNPSf3pReNmkWzUwyVzGhUpBQ9mwPbTR3MZVuBBRAsnol8L3FUPXLaBGXpmvOUmW02/4ccnuKPgcnoCwKgoRVgJ0HO+Hd7t56BGTvCApLm88+3xAMlPxn2cZ2DzJfHctRVBuIgs+gbe5eggwDDR9WJjsG/xNOqDn5gy6JzLulBGaRG7P;4:BZ/u3+MK1xKTPvGyVqkw1JfYU/hKV7W/r1QLUSlz9rU98sQ3CTMbXJT3uNQiFcRJZRyeN2cawMZq0vW8VXd8yn9cSydCjUIXoF0AdT50UipRoHob97ZKTo4UIfA9iKqZnPQIMEHvGLiKlZK13wvqJ4q9GVoZb0Mex+51UwwL+jtWYAKmD+dFSj9HLczuO/E44xBABay5k9aqmB4ORrXhXYPEfvliLnifCzS5nNw1p6/NM2G3hhFzdNmyi1k5/llw+rWFQnlIs5wmfZbnDKiVkkUFqLHFNktUyA4IPiINLFD6azQGAzvJ+qGrS20+kA6A
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176B756286E96A830E7223ABE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:2G0Zb2r/ayRvQGnyKCgh9e9Hbke6CFyS8libfkDxN?=
 =?us-ascii?Q?g3KpkdyNF2MfReflI+zpva5eGYIGMVxItzHZ+673nfsBxUJrgBss2TJSv1Mj?=
 =?us-ascii?Q?VQADg4NkiPzkrNfC6pT8+yej5yZWCR2jZpSsUFEB0dPkqShVD5sQH6cxOT9p?=
 =?us-ascii?Q?hF5gkJdsVosf70tiVeRM15r53IMFi4lAxFxt4lp9a9L/Ik4vypRt1OWUvmmB?=
 =?us-ascii?Q?XCQXTi9dkwYzo5NYnrmpTG5tboNOJPILYwIvs3ZYzeGy4zsyK3HtAIrno1vK?=
 =?us-ascii?Q?Kb9TROKjJgRx2XnVCXD15W4GUxucBjlUEjgkmge/eN759fRsggCV0+vWLOSZ?=
 =?us-ascii?Q?7NtIF6lo8B1LQeza3/LyL+yK1J1ndsUWGdeuHkeXUI6xFO7nhiXOnnocNrdX?=
 =?us-ascii?Q?3tQFzEH+DHJ3R0eNrFetxeg5oqGRBDr+D1bunNOgGrNsOJG8EclTbL2Hm3gM?=
 =?us-ascii?Q?nefk1bGK+gd8qVVGpOgPBOM9vLH4o7Dv2Ge9K8oKXDMYvaYoZF1y+o22R+Ad?=
 =?us-ascii?Q?Z49u/Db7MJF9jznM8zWlFAJ3NvsVOxx3XMnGPeHwsu+d0RHnEKb/GaMb17uR?=
 =?us-ascii?Q?O35Aj8HhlHBgTjqqWExaU5V7sFvTtxQQXnKADHCkCTwoPpS2697Xi3W10YN7?=
 =?us-ascii?Q?nmUYCQr3kPcBQziJHp1cR4a4VH4IBBHC+jRTZJaQ9G1y8sf+5A2E/L08+Wyr?=
 =?us-ascii?Q?pPMOAjIPqKcw2qEcW74LKXfXzMURKsMvZjOzTaWA/do/OmDE6o8eHWR1nsnt?=
 =?us-ascii?Q?6pJuqF7YdwJyjw1DpyNMsbnWbHJOvTichQoGkOKta8UK6/oiOV3UQh02M3eT?=
 =?us-ascii?Q?Kiv3HdjY9ez8ucPi04l8L5DszMmEXtMgQvfDBr4ph1mfT+dh+a0hm0HPxhiH?=
 =?us-ascii?Q?Tk7RZer4xUvgBV+FdSsOuGV8n9kBgLpkfWL5eO9ebGFiQubA7qkDi2BXJ1iw?=
 =?us-ascii?Q?2Zh0q8odXNCiv1QMolxk69ArIQutMxgzJMVvOMWYyz4A/Il26H8plXN1CBKI?=
 =?us-ascii?Q?+BRjNaEDUFIpdzfezqaUwO/KZ9z2ex3xhBRS2qMnYsCuAHDsI0689J6NaRWD?=
 =?us-ascii?Q?qGHoEigBd0dxBKLFRn/xhDi/zxWgPh96+NEbbpmbREqVkccIbvi/0z3q3q0I?=
 =?us-ascii?Q?3hE3hALGGQoTx2Z+qR71u43ip+6uvJ667ptCdM5Rh3PAscwepu8kt0ovd3Qh?=
 =?us-ascii?Q?tePX1s8usKcVCAlC/FThZU7XIJJ+oG4XOtxkGCFWWWl0OJw3LZn/C2DNafwt?=
 =?us-ascii?Q?b6PnHEhpMCP0SNw/+y4VKqW9maGmaYEznKAyqFytjtblusSs/0uAwinAd9Q9?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: BHqtH46F4oQLc2A73etnNLF28Q9ww8H6l2nLdQ5LLHyQE8o95v2UHWphCZ/Aro5rLFAsBgl/noaRuryT3QEMX5LdgQ25h1SRqmhoHRYBkeUpJn9wHd5x1LRZj/JTy6iSMbbCDDiTfIP0l1Sq7OsRzaoN/dVdxhuTF4yUD7tMPXd4Oz/Wmp7y4bCgtKYsiJ2jUYKrMJZliss214TFGRt5LH2K+Ar99CXMzUpZw51Mk8pZP/o8nHlZ/4BG/mMs0NaSdJD0RfWOrC5RET+Fd83wbagqBq0DDKfoFF9IE/tMI5qSHcoOclgedRcXzKsfGsjsOhN8T0uIruWdezDpCVM1RtyBvEet+nar1mNcwi9IIt4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:YT6EJnR6XJnwmjm8gdR/zLF1x6oZ6SPFOu1/XlVoL68YQ/Gxu2zXVjn6gfQwlaWP7C/KcEcGhOOBGU0yQE3uxylXixF9ObtS8QEASg23hCZxLutFN5RU7wlVQAf0Q4bkD69z9O/25Zru+9yfDcbkRidCC1ptJKZ21VgmknUpInoBJiOP0g3ap6AB3nsBLX6GcKN3qrfrLYZWh9u/LrmMjIInSS5yldGL+mXBH12gOuXXsIy8IZH+/Gfp3zNGB90PZfIUOQhEJLP6ruxTQN/+c2QvC/viNKp2yagLUglFeAu+NuERLJEryZLY/Djwvf8PD4CPLZt4gVUjFS6rX5vwZ6fct2lTQ4A/ZkyEZx8C1FkqS+Vp/b7rZAFBC0IMO4OTm93ly8DmmnFSYHBe3qSHvL7XZq0knEGmm83VDy/N6u/pD2E2PUpTpAH3a9sXdPMLpz5jPKP+K0NZC1a5BpfhyA==;5:ChbCfWS8XtKwwgwv0S8IskckStOoFY9cZG38O5ZKWd7NkrkMkzRWIzHHrxHsrvEYZIy1ztmuanLmFOuNbL0RoxSIxdp24HuGCM/6QKPeJD38mBXoHK9TgR4p3yhg7TTxGQdxdDR4kG9gMcSev1PZovbrLcfB9ENeR9UmKBJc/xs=;7:yDVeWEepC9li4nTFhkVJS//3+zSgKwvhXyw3jOLKQX525nR1rtisUhONl35uzU72BCUMLEnugSIKwdtSlJ8hAeWSi7hj7qeTFrNeY/JrjftaSxphhUfMHT1Shw1eKw375NC8/y03NqMmiKJsTh74FIlcLmpZB6LcnVKRe+xdEpxZCaLX+SsojBj2dAsPKGt4kOhShYFy8GEVae0lOxVfbt3kLt2NnB/ysl+X7QMV8COY08wuwisW21+fw8quWvC3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:eC3nMXlC7UyKZSPlizHOtzQdugnc7jWl1ycwfxSo5rBsvtiQ6BvZe/0UbbIKFPoerwvxU1nBWLXMLuKwuNb6tRgB6Sp73oA4WbELqFrfBwKJbQWjvEtHMLk8uxXhseyfeecNw6yiQfNwyIWUvdn+QZa4XeBuY+5QzpgWGIeOOvM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:20.9996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ba96b2-2991-49b9-f627-08d5f7ff7c41
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

