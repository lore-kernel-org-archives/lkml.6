Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A52ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274322087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KwrvvEwA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PuHXltMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274322087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeGMT6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:58:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731592AbeGMT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:58:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DJdne2008760;
        Fri, 13 Jul 2018 12:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=94NGzqcRJms8fcbjKjyKP4KwqBXMAQ0TmOhbmw2A6hg=;
 b=KwrvvEwAJDzsaDzrSAO4CjE0e65OPo7nTJAHNA1up5/8yg3RclTftxE+dxfrcN+svsW3
 XUMJ+uFa5ILAxJuH/mCbCbMDs/OaXPmQbOS09SDKsi9R+jlGHIDSTx28u7M8bUGwFlmK
 PqAI0kkXMQcSNhfVnBV+b445J5+leT4/Wt8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k6xyqrm8p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 12:41:51 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 13 Jul 2018 12:41:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94NGzqcRJms8fcbjKjyKP4KwqBXMAQ0TmOhbmw2A6hg=;
 b=PuHXltMMtSiHwE1LZ2dZSXMoJ8TBpd+dswaRfDvatoxwvO+9hp55fvmb5YKj4mdc3NL/Y538aw1Ob7VNjZfw5745OAfUJXRp8+WCW+DtyU2DlkX7mqOYyyzQSda5A4ZuRsp7MtKbLlwM3Ng2AqMsRMaW1NXVHp+WAjeFAJD+qpA=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:1cec) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Fri, 13 Jul
 2018 19:41:29 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf 1/5] bpf: bpf_prog_array_alloc() should return a generic non-rcu pointer
Date:   Fri, 13 Jul 2018 12:41:10 -0700
Message-ID: <20180713194114.2711-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:1cec]
X-ClientProxiedBy: MWHPR14CA0063.namprd14.prod.outlook.com
 (2603:10b6:300:81::25) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb4e9715-c7d4-4ee9-988e-08d5e8f8a13b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:1ROYwqMsmkNvfTh8JWjoP3serLP33Brig0j+d7JUQ+7k/DD70FS2FpATpVkNlWMf/rCGzo3cgmZOvPlV/BtC01wc/HgntJfozdHa/Vc8lOdTFKUD7Gq5VyvT6Ep5n9zi3RaLPipuylp7pWgQlvx3qtp6C/4z83fEwx6ie58kmkpYMtP7Bcffbcn/maIYfFTHCX+dEb5cj1IN+Hdv3da/bJt6RpPADX+C92/d/0trFFN4cAx7LrAJrQjwZ3gg0fyS;25:Kr3Iz5ebV6zlKGdVdwRwuboF9DBLAZL8u//fvnK6GZ61ifDqvgGNgiwprVkmpisCX0YrzhdJQ2HtkbmhoEk1UkFwxOuaB1QrZ8sFtyyo6NuUwB7qlo5ucIoiwutM/iO8Vg+gEQYmorxovjxLhSuTdrXU9PgvToYeo2gmVIHhd/Wic1sjlPlqbV18CTUFYZA3HJE7qNtbh8ZR4ItURqHU5N6Rzl7S4FReeW6HP7RzGylaVmWZwp+roVUc/XXP3AoSC7CKBhlvgLADucyye8gXWes7C/JCp8d5B6QpDxZI4vaSnNVsoz8zHrn8yla3+jJn3mvQaFNzlciiki6NY+OBHA==;31:pKcKLthv9kNCbLsbIv3k4LOwLzSEeuM8FQ1JeVtjv+WKRfiPgql04U6v9MTsVtH1sTUckWdtuc5yxURmDlIJgXqriOCNi6LDAlqY8W9kvXcNrbTvcmwOXylthvN6zD+msR88Y1IWE5hGonmgiEHlLRcAox6o+UivJ+pWlXnt9eOQzbO6dy4Kw9+ZAg0pI3CwfAUZM6WKT+ww/cYkYtJa58Q6WMYaGZoithdHYJAu7+o=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:nzQk9S6xnNDLbrS3LQ8SHiNX3GKXMvPcbHV7A2Eag2wC9PX6g79U3i30ZJRVuW6r3c+/4EedLIGVTRIU0FCVeLlpID265NEtIdp0NLvchZfwEMzGKyvih88+IvDomGI4C7GBEOZM3E9svxgc3m4z90JcX3BhgA9qN0MniONz/KyRpc32xa5hLMeRV2rRYQUG6esCIMo4bXYrTDXXSr2YMkj4R8iIYRHqEa8JfmVUAqnLU/3zprKGtzPxbE1iSO/l79RTlvAPq2wJ1dYdxStl7OtmbnVtL+oNwSu9q342aInHkplC3TSOrCExksuNe/9TOTFxJjIBH2mGpyy93s7dTHabotrPqOBHgxEgEA74t4gd0t5bnmMflm9dKP17qqnFLm04vj4GFOzCtXqqNN3SfAzl+p8fFwUuAxPXUsgkv/OJkhF/htmTmfWLZdFe4B62wGFXYA/PZ+C5Cs1dSCIz3C6vAiUpTB1ntyU1KVc9AxWZi40NefPP/5+riwxEY5UM;4:RB2ymx55rWBoOIzjIzmKwxzgMJISSbIDMOdN/y8fm9tzSqXy3BRdBtl/f/PGO9Um8RlK51TWysgXMmjc7bqAkpYPbtjP9qJzYBkqesDwllvQyMoexmMGzojFuQqXa8+Hq8rvTN7ZnlycqQ/cJYrPzhCqn2YIqXnDOBpW+x71ANCfQUTFXCLDoEJLhKojoABhJ4IAF0U+lDQJ1qFMf88tDDB5tCkNBZpe9XdogO+EQs+sB/3M+Z89EdZ1NlvG54ZAsKCIMPvrtzJ8yHPm5ikTxvBBKnug8h9tZqoKnU8cwDjpn/wC7Wvujj5B9sev8HHX
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171B84A1D0B47ADD5FD8E1FBE580@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(53416004)(52116002)(16526019)(6506007)(6916009)(14444005)(50466002)(48376002)(386003)(6666003)(1076002)(8676002)(46003)(186003)(86362001)(6116002)(5660300001)(69596002)(8936002)(47776003)(6486002)(305945005)(2351001)(7736002)(478600001)(2361001)(81166006)(81156014)(105586002)(50226002)(68736007)(106356001)(54906003)(51416003)(476003)(52396003)(2616005)(25786009)(16586007)(316002)(36756003)(4326008)(2906002)(97736004)(6512007)(486006)(53936002)(41533002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:J1ginoi52pvSj5mfR1+kdAN28KBwii7JEPcZFIs8o?=
 =?us-ascii?Q?1e7yzcOkj1pMK6vKfUCP1RwX3Zqv31O7pBtPAQZvw2N+vV6TTy/hflIa6ltB?=
 =?us-ascii?Q?Oe2Smz1w7CNyvR7gAQcqX+Wt4hCSgi2JGYz+D91lSazYU8CRD2BnKJdAH4Iw?=
 =?us-ascii?Q?aGnUdLLD6Od/43sru49oTaRNFk6kokkS9j8byF784Afd/RXGjEWO6il49pRh?=
 =?us-ascii?Q?VlRFTl3mAjQz3qXqmfU47tagptMx8D3Rbi6p/0XEwJjx8Q1yFTv4ap1fpFTI?=
 =?us-ascii?Q?9U4on8KZ6Iod3jQXirWJpr78aFqjDcrZLYNkTus2mVEvDTcPYg0hrBmikSLb?=
 =?us-ascii?Q?d5RuLTCPv4RjqG6yfT16JOEjA2C949Yd0XCUzfpakuRjCG4D0XQkr26G7umz?=
 =?us-ascii?Q?t6cEEdOADZ/Js0Bc1YDlxlqIiADOLuyAnIc1+i0GfXemd3OusgwYWVvbTBcm?=
 =?us-ascii?Q?by9fx50tL8SS46sstx5FGEP3HJ2NlxdldSm/SRIMa3K+L2Zh3NJpbXpygikb?=
 =?us-ascii?Q?vTS86s7zUQAqu7xvK8+hTB0veyvERxlyaZ5B6TxRgoGbmbmrt3O5dCjFRmFp?=
 =?us-ascii?Q?emdak3M3T4Iz0Md13ol1puMSgNhg9d4HFV6szuFMyftUK2Vo2DaqaRjItI61?=
 =?us-ascii?Q?jvY7z9WhQFnj2E4fuc00hYoCXBiOgmtxD1cAO0FuB6jmGXwjkz3Lbu7yovf0?=
 =?us-ascii?Q?H0C18lqokMFFb1HuU0R4UsS2L/p8ogd/rRMNTfIJ/n93O7rdArU9b/kQN2Tz?=
 =?us-ascii?Q?37393K6wQ8d8hY3XPVdgYheJYdrs4TJ5CpMiV16crZZ6rEmAh/h5xpfqQqSJ?=
 =?us-ascii?Q?nuASTUPngwsxZpTHHS3cbna7CNJ6M/XAmXiThe7WbTzJ4O6Fed5irQFILM/O?=
 =?us-ascii?Q?xQ3j8MrVy0WHL2bsXn1JlP2sVGGw7FTQVj5+L8YynjofPYWVbyZBr8/z8/rF?=
 =?us-ascii?Q?105jzQfWo4CXw2ST28fUw717DhKcpLkHhaiTXaq0RGQMe9ddEX8aOHsqsPf1?=
 =?us-ascii?Q?ijVXsvknOnYWqVqbZTACzDvw0Ya/dP7tDquqUZT9urvL34jYRdI9/kxFYhR9?=
 =?us-ascii?Q?9G2lqftUPBA3m1XZDqPk4bGieuNBYiz/WrbQYNmMpo5f6PR0qmvclU/pJWO7?=
 =?us-ascii?Q?rqsuCYeni7GddTVqCcvNCchFBF1w4GUr1Xjg+CxPXJHIkPQb9IAyY5SpTsK7?=
 =?us-ascii?Q?VgI+mRL6TMda6Nn3SmexrtvrCnvTEDYEzrzZLh8WeHZUiPNJShlwXIB185lK?=
 =?us-ascii?Q?44dv+xZqWvXSQQebx8=3D?=
X-Microsoft-Antispam-Message-Info: nvpW9tEABoio0pbAJwQ+bmE2siAxfHrvWYKpAn7YQ1NgI9Bnf2VccHMX8J9C3tlp6s6ON6n70yGPeTYhDA6PVFlbgrwquaCA7J/VApTz9lI0ZdoxG2+GFuW1c1supaJxgcKRQoTpmmmnrxu3xxYMkcRsgXcWgjOqnkzqMavBH92AZQbYmr6MUxU8y79Se7zNlPt/ZQI2rk2UQr7Vm+yy2UtQJOnHv4hLTHRNbQMyCqFVkG4S/3KRBmSMff43hd9gxVNqKexfoerqMIIexGvkPgY37etQkC+gi39DuMIC9vuK2tw1hhhFK/KdpHcpzZcCa8YGgJ1LXL/DO0DNaPLGgWhm3SC4pwtp4RRy1GqsWWM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:lccVGfNSsVsf5C9TGyxrM+wXkBf31jbO/ecSMHXX2Z2T8M6b9ywQfrKlmrn5uYdZIUsIyCmUM798AGp54L17bFbtqQEmPd4BHJkV1bMY1fX0ykdXP2xXy8j6Bq4KQ5w8Ilm+/1eSagKT/oKu4jacm6QNVo9Ot6VzYZ1ENt+nD5Yrzebd1UxWp3atzoOVQm4nqyqNfc0aPj6CRDJ67/sdLSS3RO3dxjeoDrz7iZx+CfICgVQNNyH0/dgg3gFASQn6SW/ueiFIRd1/VfettAmJqWl+nZ+XQ0p0fdbiEuwtJaqJUYedVm3ijGXcrYZI8iN36wycEMy4PuCAaEme6MCfqD4MgqCH5FIM+G2OLD34l/oeDtmUHH/+aFvgY6k6CPgat/cLQB/JT/dnUD2Aq1k6KQZNEt90VDdf0ZNPmwl4v/tdpRc3RySix2g+D+lCThrJHE/OvH7ZHAvkTgXNpnx0CQ==;5:hxLOJQ4qCEobEgVHUqQamzNiUIMXvPW7WomG0zQ0D05cWwdVllvzO37sPZg1tSp9zZySpahKW/sKoB1vW08V+KQWf1Dx41lq+32MoUzphtWSW5j31geyfU1bcp4s1QIXtNvlr3YT8wbtAEA3tziViNC+xDavbUb8gHX5bfkPwfs=;24:+gCY9Q7la+gU4iMcWd1DlmlcL/KgvFNkKxEB1ztc1RKb/AL31JLivfdxb6E9oYsRsWy3a90To1q7ORmqItJr+v/UgMx1Gn9B1u8BF/5wzH0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;7:M/zO+2tV12z9plCcNMmD+S1iReYuH6uMLZX6PSyrPeZIMRcAqt09Xi5N+U0G6G4htWAJWj4/Np5Gz4oAuWy/Wzrq4nMi4hOYDeMvgvzkcjYVEPiyEEq8Ic9t+HXX8trcDYGt/MnacE9B5iJOqSY/0d0qHl9q6mAW7Z4heHVWNg/QR3+zp9lr0YYsNIuu6RidATpvqJRW+Ztx7pH+8JXwzGlz3jfgBY8bn0WzA5u3iMJrOtzYDn86a+f3ja2bXDG8;20:YBK5H7rN072XzU++KXcMvJIUreulVN8Lw1lFoUrcCd7lNDDputIDWfziNTowVhVeV0JuWGSREVGXugOSv78LnOF1iyXcaJBnbNdlTMygihlajjgAeFit2z251RskV7wtgpY+gjVYTOFOjLrh6bbloa1II8Q3/F8BucLqSmglZAM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 19:41:29.0978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4e9715-c7d4-4ee9-988e-08d5e8f8a13b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the return type of the bpf_prog_array_alloc() is
struct bpf_prog_array __rcu *, which is not quite correct.
Obviously, the returned pointer is a generic pointer, which
is valid for an indefinite amount of time and it's not shared
with anyone else, so there is no sense in marking it as __rcu.

This change eliminate the following sparse warnings:
kernel/bpf/core.c:1544:31: warning: incorrect type in return expression (different address spaces)
kernel/bpf/core.c:1544:31:    expected struct bpf_prog_array [noderef] <asn:4>*
kernel/bpf/core.c:1544:31:    got void *
kernel/bpf/core.c:1548:17: warning: incorrect type in return expression (different address spaces)
kernel/bpf/core.c:1548:17:    expected struct bpf_prog_array [noderef] <asn:4>*
kernel/bpf/core.c:1548:17:    got struct bpf_prog_array *<noident>
kernel/bpf/core.c:1681:15: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1681:15:    expected struct bpf_prog_array *array
kernel/bpf/core.c:1681:15:    got struct bpf_prog_array [noderef] <asn:4>*

Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/core.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8827e797ff97..943fb08d8287 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -352,7 +352,7 @@ struct bpf_prog_array {
 	struct bpf_prog *progs[0];
 };
 
-struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
+struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
 void bpf_prog_array_free(struct bpf_prog_array __rcu *progs);
 int bpf_prog_array_length(struct bpf_prog_array __rcu *progs);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1e5625d46414..253aa8e79c7b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1538,7 +1538,7 @@ static struct {
 	.null_prog = NULL,
 };
 
-struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
+struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
-- 
2.14.4

