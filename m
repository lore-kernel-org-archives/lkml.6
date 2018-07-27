Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA323C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9D620842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NiMO37GJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SyC8DNah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9D620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbeG0XR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390006AbeG0XRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:25 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuI006591;
        Fri, 27 Jul 2018 14:53:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=OxBUnppWZwyS1PHTrz7mdeFFjhqESokB5jieomfxA0o=;
 b=NiMO37GJ+qhHZZucBHW8tocRVTdoIZEdSi3IIMWx1YFP78YP/i0sYBa0zXe3RXIgA4Co
 +5/7J8rQ87fmDxyFe5aPOSgdzY72VQwEnYb4HEx3eR7/7vnDsBfn4hBp3lQQ2VXURrDr
 5G8w/GWsxYIytID+w89lKl3UAaAm3qhuGNE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2mv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:15 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxBUnppWZwyS1PHTrz7mdeFFjhqESokB5jieomfxA0o=;
 b=SyC8DNahlQPF90QeO3KRQBe0+I1nv6KSPu9UZW1JW+ay/S0QqKqKzLWSAJAC59uyZnYvzZCVxS/hJSEA279wBDbELWTvvwJeIPGPIXWrECnzD3D6Z0yEK2AF+ko926f8azYddimdN1xHmgfwtFfJByaXdMwNdycQ+/VUkWXDqgQ=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 12/14] selftests/bpf: add verifier cgroup storage tests
Date:   Fri, 27 Jul 2018 14:52:41 -0700
Message-ID: <20180727215243.3850-13-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e1a1605-3733-4767-36c2-08d5f40b584b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:LTWeIF4PzaTPy3wpmZ4040Bb6cjVqpDfV2EOSR9C/nK90L3chkKxkLXGL6zATvQS0Mn2IDlsk+FqAW9ZiUjd5IlT3Xi9m/+XLjzQeQ6jBuPDDr3HkFryLLYdZHoaZt4RvFJWtNH1Z8uqMkuvZMj3IjzHNlQS9e3C+DmCwM6X8tazAZ0ddLv+VmX6o2jV6HS8btkwZWLrvZFAnFJ19LiW34XZ9ZuH04jZ7fdmZ/pqyNYEsgQC5imc/ZwRAAhSGtjs;25:TrVKXKKC/T8hX6jwO3uSATrXP+dHclNypAhsrzx0U08Dpb8bC/UJMSdjLBXg2b0Mfxm1Lc1VW3hPMHJ6T5Jwc4GHN1IugIhO+ArVztA1X8ZHhn1Ox2ZIb5WPg2YakYIawnrIXA25lG9l9KactJnxzsJHbSdoE9AZur6MDSg+CYSVPOcePdnQazF9teJxFrvdxw+nDXz5/7w5d415rYZMuTdi+KcJX9cEBD1hmGQTSvbbASh1Q9e0QAutS1GdD2K6098Iy0lU1iDnBBpav5Ggx3oo2rapMkKgJCVS2MYXyhcTQrF1HitzRjjFfrt38v1yegIoqJNK64PrZLTVnRgRzA==;31:ViMhviqUsWr0B/1yyWljWbw5KIgNvLd4enTZ1h/iBSspmpePhy5LJUanH6zTZBBxA+g6NpmHmaaWxN7SrZ5en0RZ5FOiN6HwNepVMqosX7kaI/5YrUq781TSG25qOCb6h1BmwdX2jzBXN4GTkH8vrfDYPTlptDyRV4lhOGznhhP8S7JU37I9Oa/DhashYu+e5iRv4wx6HKgJgSXdyvXY94DJUy7Rm5DH0tO4y06DKHE=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:YbKd5DBZnPyc0o8wuGb1ytv0FrFYDdrJdgHOaF0aQnaFnL7dPNriGMmD/FmhNdPNp/VXXwQWD1iUV87dV/x87sd0dClfo+N0s7GKrGf9vyisk3P/yIRp6Jp5Kfiol/2mUSC+QHmEZFgwX2ZIfRmM00zaLgPtBGxVx2X/MDWMpgq2cvs+Y7pFdVp0WykFVQE55pul5dC8LM2SIbkS2kYs5ysIX6PoPs5YBo+aRuWGX0lKZbx5gxlHUzWkEvamzu8D/9jpmn+IQuF7nU/J9OeiJ+qg2MwuQYDzdruf5chQcLKyxIz7k9VuVdUFfW4h8kIG1ByUiXdnGYQGs1OcrDE5sXkEOmNIkAcr34Fo+ftHLCgvDNXvHOlxBQEsIO2rLFV3x7JgLlphGEb4QsEuOIA8pcJpNDXWH9SKCFpxhOeQ4EtECKBAM03n91b4VDFLRM+OfBIHpDdJSuwrCcikw/j7Al2NnCaFP4eE2WpkQiGBC5Cu+K4BWFFvpexmTP2jATdl;4:amBs0DVL0AuMTc8IoM2wyzBAdvzi6xDJXY2ypktAZ7E2KF4fKBnIaAftDrZh/m3dobwNDTgZjOUBiEM40EBlG1Cq0AXRCcf8W+oxev6MAv9r+aq4058rMmWwNEOjfK5yBuBpvL9MkLKw5ZpwjVmvZIx4bzcQWqG4DBYiQeyaxFAVRQt670/3h2fLqtoeGsL5G70a1jE/JTXPkvgA8hGnwZDdsahQBbzmlbaxf/DQMu+kHOhbwn8ylAHxDujf+cudEaMqxXqrE/LmHHzVoQFHUybsuKo9TL9cL0C4ozKAnvfVd070zfEhL1n8pD0JeMLE
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171FB42CF9CCBA246A4CDD8BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:j2ZtcS6Q2DQ1BeBi4IRnV4fsQLUg2EfgIHpKWGEEJ?=
 =?us-ascii?Q?EOX2zDI3g+CBIaqe8G9+IiLYYSOcWaYiOX/PmFUJ3PPQQ1Z0+OGHj96N3M5L?=
 =?us-ascii?Q?f9p9FSYMYLkh4nFmwl8a4kOI0wU5Rjcz2XWdggh7xuSOM59vIK5PpmgWuvxj?=
 =?us-ascii?Q?cwro1W7PNu4mli8boaR1Yu8vWnAsFA2ybegTV7x6vbwrTxNSbspd0Hu2JySv?=
 =?us-ascii?Q?ZB3QutMvWjEc459kyjtV0apPFGFv87WWYfBkIsDO2/1xTp6iHnv2NbfJLfJV?=
 =?us-ascii?Q?PbmwzysNjy7N1W/L1B8PzbcFlLoTpD8slEwNBdvBuvOvaj/2n30cUxVMYers?=
 =?us-ascii?Q?ci3grZspTq1LFp0eAiZFM2yqM34Cw6IaoYKoJDf4gR2RuXhRP6TKD5UecPZc?=
 =?us-ascii?Q?R/D61UnFRGSmht0xXbAfM0M9iLI4MQP6B8cKshmNJWBCaHvJdmacOY0XGVWE?=
 =?us-ascii?Q?uTEffzbGZGEk8cuZNqRpf40xvIVI6HXl9rJIlItShNWOonXwRTMpQJVVM6rA?=
 =?us-ascii?Q?3Jn7z7rA6rQuGiyqtOneJudYoQiRENmZTvtQGHIeQieeWh9ZmOc1ywOaTgTO?=
 =?us-ascii?Q?J9DZr3OHYRIrmuCNGDhdPTW3RDd0ZWVei5nw4SF1zCTLJN6IBOudAqPzt7k6?=
 =?us-ascii?Q?T2o2BQSXwLl0t4ur9Cuc2HZaiuTe3EPGJkMwWxbWygcPlE8/HxDpTiuCuBBm?=
 =?us-ascii?Q?0us4ueDJzKv3tMt6NlOqFRl5ni4H3D/p3w4OS8dP0dg3s70lyCgFfgvaOjTq?=
 =?us-ascii?Q?C5uiHS52x9Hk0Acoa6HObjkqfUr/YPMNTY7AJJ69UXMarMF1pORLReAe12PV?=
 =?us-ascii?Q?EV6OGgVtugpGIE7063+oF6usyi6QPqlG/ede5jtP8v+VvSpzxfi3bsIGCB3f?=
 =?us-ascii?Q?Rs562YxZwAd60OqGncWBEbCkDTld0ibfMJUdrQqsRsM6g2mv+6YZa9Fka/x/?=
 =?us-ascii?Q?ekT3xv7q2XJO2ppI0/tJqk4kO2xgCr/AQFj9CNmb7QRXXbLZA58oN+jRMO4s?=
 =?us-ascii?Q?X1+SOuGzlzn5w8AteH/O+ymRFcKC0z6QnQwEl21XpN3UKD46+SEydyGiUhDr?=
 =?us-ascii?Q?vcALrtCFTgLhMnR4L4etk/NQu23FyczyhplOHLsib8hTsdU/xOXm86ChQRhE?=
 =?us-ascii?Q?OYxScdvSng+ONsE9LAFJuEqPyMFHvLrhP43ls0bbjuHIsx3OeNBzyz05NDt3?=
 =?us-ascii?Q?vHWwcWEAUtTVZzN5viS7IBy8aJ96ziexJ2zTFuJ0ZkveOGtbqgRSAepODzs4?=
 =?us-ascii?Q?s5mAKKXe7owXQ9Uq40GR52u4Bd4g6JxmGQLqWp1QNJZOMsucS1ioAj668YmM?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: Cqk1gnix8vEY5yHbLS72gA8DeFhIrUIJHqOTpCY03mJEYl8RGtsO5GtY3YLT09As5E2D0P7MHieyHIKdqiSoKnSI/z79FiRlXEU3fvh+RmoVa6PABT0y8xfzhQhu9PM1fEVVWiMEBgXyGVzZHOihSMqb6qrRNXnEU7a+euoHuu5FxHZ60GgXzfDiLTRift7oM4Db0MH8rqk9QdI+vz5pR0GfbD5oU1mT2y+KCWErY/9cSUcvREUIc/TSV7f4QBfbHOgNjrlBTqLarvNxcKixSd9+tVKrLA7bLhI0r8v1E9HxovxxbZvbaUiL/+PNIHLptOb0zXgxul7GsugHQ5MULbcDeiAkR5RWuyv6MshsXjE=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:ZD16Pv3r8kmvATl1YiTCxUbyN4ndTRFKBH42kF+J7p+Gh22IT2jT1x8+x4xWQNLPCzT6uF4r1xLLTLdmF5janOpBo89G0EdQF4WWzclzajxHegaUCME/UfQ34nLsvN3v/TxhmH0hbnYkG59vAtW5hIVxvJeYcHLIjXIxPdmE9kDRQoebzNrb0dWtNPgcf5oo+hqaPjMEintmXZy/ebGPPEjw1/xUuM1eA7C1XW7SJmjBEudcXiLi/JVhMLvHDDXHg2XUUDJkUec5ZD2+mqrWLtrrGJaynIjx8mQ1qdUtpVM6CGh8OJsdzzRiclH+dfgmWwLRMjIDFevngaD9YzxVIxlLbUXbB+BevKKxsRIL3P5JQK6UaaPM7lK5YEVU9Xy+KG3joRqEQ12YLZNPnyjxyMXNVnj7YT0pp7w1Go77YnLJp5JdFGkzIhftGLUx3wXmhUac5aePJuLHW8DwF+8CFg==;5:cOWAqjzFK/oh8INYQc7/N+D9+dgu4aS6/0ZQxKLc30DegYkZ4YVKZtBZZOfZ4mBQx9+iBYI0fOZ9JXwddKeqiVzj8mEgsImZzMui/llzbEC8r/hIvWLlVU+ghrDtc5NprYFIfcpWhnP1edRrrf7FTHkVcNBNXq69E0AKUcqbtQk=;7:lVWkqmDf65IF6RIDzOnGF6gD5F40aOSzQa6lr+TGxgW1bnliQt7Xu4wJkGlB1p3xwmITT4edK8ORzRy5PZAqgFVjx4SbR98md4x6IAmthZ2RzTw2Rfo3e7zeb6omijjPtM02dp3OlIAC5VcX3LFtq4z11rrIkxcFv1AKHZ3Fbl2WM0Iab6Gjy8bX3Ra96WqEJdbj0X8Bv5+9LYToPo4eoFhZ8dDzGqkmZEwK6PTGsTk2EwB8TqTdAMSu0yXG8gBY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:0sZifSMK2jVpVJFf4REKWOiGJr5EpJNDJmUT9Rmai7de3mXIzv8lzVOzZjviIksC4/P4F9X+7RVRQkHGoXVj/DSNHHxRLbwfiMeUHZgiOgoNp0IlFMZgLMjqRqqg5b1nsW7TckK/M8rQgjvU8WnFYeVkwl+fIRDReWwYlQPkLZY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:10.0750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a1605-3733-4767-36c2-08d5f40b584b
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

Add the following verifier tests to cover the cgroup storage
functionality:
1) valid access to the cgroup storage
2) invalid access: use regular hashmap instead of cgroup storage map
3) invalid access: use invalid map fd
4) invalid access: try access memory after the cgroup storage
5) invalid access: try access memory before the cgroup storage
6) invalid access: call get_local_storage() with non-zero flags

For tests 2)-6) check returned error strings.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  #1/u DIV32 by 0, zero check 1 OK
  ...
  #280/p valid cgroup storage access OK
  #281/p invalid cgroup storage access 1 OK
  #282/p invalid cgroup storage access 2 OK
  #283/p invalid per-cgroup storage access 3 OK
  #284/p invalid cgroup storage access 4 OK
  #285/p invalid cgroup storage access 5 OK
  ...
  #649/p pass modified ctx pointer to helper, 2 OK
  #650/p pass modified ctx pointer to helper, 3 OK
  Summary: 901 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h   |   2 +
 tools/testing/selftests/bpf/test_verifier.c | 123 +++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index f2f28b6c8915..ccd959fd940e 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -133,6 +133,8 @@ static int (*bpf_rc_keydown)(void *ctx, unsigned int protocol,
 	(void *) BPF_FUNC_rc_keydown;
 static unsigned long long (*bpf_get_current_cgroup_id)(void) =
 	(void *) BPF_FUNC_get_current_cgroup_id;
+static void *(*bpf_get_local_storage)(void *map, unsigned long long flags) =
+	(void *) BPF_FUNC_get_local_storage;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index f5f7bcc96046..8549c1f92bef 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	7
+#define MAX_NR_MAPS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
@@ -70,6 +70,7 @@ struct bpf_test {
 	int fixup_prog1[MAX_FIXUPS];
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
+	int fixup_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4630,6 +4631,104 @@ static struct bpf_test tests[] = {
 		.result = REJECT,
 		.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 	},
+	{
+		"valid cgroup storage access",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = ACCEPT,
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 1",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_map1 = { 1 },
+		.result = REJECT,
+		.errstr = "cannot pass map_type 1 into func bpf_get_local_storage",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 2",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 1),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = REJECT,
+		.errstr = "fd 1 is not pointing to valid bpf_map",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cgroup storage access 3",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=256 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 4",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=-2 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 5",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 7),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns = {
@@ -12436,6 +12535,19 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
 
+static int create_cgroup_storage(void)
+{
+	int fd;
+
+	fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+			    sizeof(struct bpf_cgroup_storage_key),
+			    TEST_DATA_LEN, 0, 0);
+	if (fd < 0)
+		printf("Failed to create array '%s'!\n", strerror(errno));
+
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
@@ -12448,6 +12560,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog1 = test->fixup_prog1;
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
+	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12515,6 +12628,14 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 			fixup_map_in_map++;
 		} while (*fixup_map_in_map);
 	}
+
+	if (*fixup_cgroup_storage) {
+		map_fds[7] = create_cgroup_storage();
+		do {
+			prog[*fixup_cgroup_storage].imm = map_fds[7];
+			fixup_cgroup_storage++;
+		} while (*fixup_cgroup_storage);
+	}
 }
 
 static void do_test_single(struct bpf_test *test, bool unpriv,
-- 
2.14.4

