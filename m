Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258B0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93EE276BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lCVnDQwp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JOFrqZKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93EE276BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeF1Qsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:48:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932809AbeF1QsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:25 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGkYvc013481;
        Thu, 28 Jun 2018 09:48:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=O6vcl98FaKdpkk+JvlXz1NqEAN2ZUlA63XLzNLC+cxE=;
 b=lCVnDQwps9mnA0iroI7utqPkNGj4zkCnx8jI4mulyYmWXGgjq6OLGU8iLAlfK5l4RjWH
 EnmBOoHTFtndrImrtyhxEVml6jOXZ6/xuTTgrQlo0dSc3k8C36+g/wzdkboyFQJzOyXD
 qytw9B0sql9v5eEhW/rAhPhN8GyIWFM+RXM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u00757-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6vcl98FaKdpkk+JvlXz1NqEAN2ZUlA63XLzNLC+cxE=;
 b=JOFrqZKGH0izLMAd6bar1AheWpBfSR+Rki7f2koWmWnLxb4ILvZFesk0+9lzZtZgU6Ic5yb99A5GDy7vc/9R6O8Viee6lAnV9nj0s/y0MZyE2XB5sbvuTRj2yX2mcSCY6wLx5q+tInJjq13itOiY6+bIp+k+KmD5UNDTZf89EpE=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 10/14] bpftool: add support for CGROUP_STORAGE maps
Date:   Thu, 28 Jun 2018 09:47:15 -0700
Message-ID: <20180628164719.28215-11-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8975cec7-814c-4498-9547-08d5dd16ecf6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:+UOxa28NMecDpG88v5rDJxHITQ9FoR0/cQ1DiPH2bb9qAiQCB7X5x1M3bQhtfPmsQ63YYEV77bTY4k0oxuwsOsm41XJYCe9Gcp6iTJY2CRxTXlKc4Jfw18Wgezn0RdqPxmB0YdysfidVhSRoCCum9TERiCIntCQ9dzKjKEY8yuahwR6kcMqWiS9jt1cnmRgeALlTlpLOVhaytZwDMxXD2eOYk5+oMx8+eWTAWeUolUrFvF93wIDgu1iZsG7cQ7uP;25:d97wd8ZL+DuftqFexPJkwsjE6NtfNm3z1II374RTJ368E423OM9OXHmjbIgdyN0A51FqKuKAjiokESAnqdpNxyGmqdtYKsBJ3Ilvpw1M6Q7Ktvr28riD2Um6HsNyQmq88Mz6meTvXKeCtSRPETnuAlwG0YiedSQv+K1lqqbPYbVpeXMJP/qQ1Us5WJ+smmgZT5ZZ3eWzdz+/JuYEJkqYYPoGgPN/s4B0/vslIHw0raJBgPhBvv/Hh+lIH8XxRX5FqWdgS0IKD1u5KFeHYNVc80sMugfIEZeD/h5tg4ujMhZsT6AT9Tojzn5Kh2h3LdD5djTgAb5xwNE6lXb1SFx46Q==;31:4SPvAvB5O7jV4zmvQNFwrn+TExaNwPrPARy7oxhFYBc4qoUaYcweV2s9zQ6Y7pcEb5Zrd1iSYSIfpbqg2qf5ZTskVsh3FkAcOJhNgscKgd0ozL9PUYRAxNi+6O3CCg5rn4nm/lA8+P8dGcBMVRkrVAuU9q6ESCgL35eYIb2pyke4a4qjOdURiWJDxK0oWMM2dZqgmvnOLbr0KimHnpQDacY3zKXYIOxAH5vKLhEQhLU=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:0ExrIpUcbddVY2sdmujEPhIeUsUsZoe/dVZrU7VqFlKsX0Sd9XvSbtwsL65fvLWybluUwHkQ1z4I7Hh1D0IqtTTY/rzsQrmXXWt948bGUWIpxhmVv64Idi2wY52RLnQbqLpjazqos0bRUqJz1a81hMfwWyDYRTBWeZjpyZBjtU6WfsQVG0aYXPvrWys02i0+7EoUZvMPAHvXcUsvZrVasu8HzHuByeMl6dLEJf2JSrN5C952Aaanq0AEnTsm4/kZYUP5TI0T7e0UEt/2rUW7CWKou6gYHXDN6YB5dPZfDQva4M7gufA8r9q87Prvc4vEyrn7uoTAiRI05WSnClDGTGDN89USRtHgTxtA/rkji1CYvr2wdUIeMoKhm+mYOIGZxGoHnOaIeA296thjyPTLWOjH+02H4K01yb8JBA8QA6PbBsilvu1MebL/eDW2kBeaUDFoXnGcESzSZWutuGsrWJUdWArUlB7Oju/Ci+9zp6vIGinIwtO6yuOSjooJro4X;4:AIBkhku38q89OduqKkQHn9ph4Y2YQYdX25B7r7SAfJDN56eLw7vJ0qvdchQO3gqwX6LcprT6TVOXzcV+PqRTWniIko6QtHOfLPoPqewGAQdCQTsqeA2LCMmQS29oNXqjObrJPPYHHLU9lC9EaTrdpoeH+qU09P3rO3aU+YM804AYkfqnWY8nYDGQ9SNSeRSDQn+ouq55ReQMDTSbUKjDdnBnkKwVnoC4JIYef1uO+35q9QaOPLxhcu1eKcZzXTsDg2unL1swWiG+FoZVqx4j1zvvCJU8/i1mfdxzAhT2YRaz8ZrMFnMzyZMwfncNdnxk
X-Microsoft-Antispam-PRVS: <DM3PR15MB10817F8481B14EE6FD905940BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(39060400002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:BzdV3816lXwAAvMWUL9CQzrVhhqlLzIwshstRTyRD?=
 =?us-ascii?Q?zvdFyxHvmQ8ViKmxqd+RltNG+duEJvx90HsrGYj+rkgvmYHLfkqSgFun9fra?=
 =?us-ascii?Q?HJtzGQFzWhgvrfjrwrEQ0dsirVZgtXOtiEmNoRFTcGKfivR3FkvCdYkCNjDM?=
 =?us-ascii?Q?s/2AQGsTXkY7ghRHTZ6lMx2O9LvMQzT8xZ+4xzZlv5T1hI5ypayXUY/dG1OJ?=
 =?us-ascii?Q?ChCu/lEWkl0cR/fVQRzKg3I87tyRAYm+CUBQLdsiEsYgo2ZNVkWz0qjkOsSx?=
 =?us-ascii?Q?FmepB+6GmlywiSIvu4/vWUeonodxHtA7D1EUJsTZc/sOy7de2dcaRGxOJ2K/?=
 =?us-ascii?Q?ilTkUnXKHRsj+XpPDiJqn3R2Mbt9a4WoidRlls/HroR8uYPy5bh/y0Z9K64P?=
 =?us-ascii?Q?ACwTRNDI+iIgamDOMzGN2WstLDedWSYZjcqMG6irfKJSCUwuTQ9y5rOf7IWn?=
 =?us-ascii?Q?ssuNqoFz/bP3OpSDzTGX+GmriXyra8Ar8Fcn8w6wCAQ3HC9aNRBVdlRMc+3D?=
 =?us-ascii?Q?A3vnj4X+Kmg2NEBOwVCwpnZldDh9f2W0lmhWotbS4ymDvwRL/LUMU6IRyVcL?=
 =?us-ascii?Q?FZpEeQQ+deY+NYaOmuVMD95YTwmMBL3fY1y4bhnTL85dj4AUb+KOSbD4KHTw?=
 =?us-ascii?Q?y0nQFe2CCHVAA23LugxaohPR09cV5GIee9/wcpBb51oU+ppgXYeO4gYns17I?=
 =?us-ascii?Q?y9feb3bT/6gN4lL0c+vsxuO2fDiiJbVaryHYTi/L16AZuPO+EUJESnnTZpOs?=
 =?us-ascii?Q?Sp/dXZvZuLum74gxA6RGg5YNvWQW+eY82YECOgZnsaAfosxrRQhcTT7vkr3y?=
 =?us-ascii?Q?WUbYmmdIDNSl5ZfcGuX7vnEOtEiYG63kyAX3Mu9Kz1E+bfrFcWMSCsyfa2q4?=
 =?us-ascii?Q?3PFLRbpOFc3Cs/X5TrXl3m03q+TyO6rocG+4s4hIGBD6XQRWY+KHWn/yeSRd?=
 =?us-ascii?Q?75/38KlVdA88pPloUyNn620YSRmzPigkh7FL00QPVQpSoyrWghHnUE9ib1h7?=
 =?us-ascii?Q?gEmKBGZmmoXeuFES31zX2z/G4bRvUpg7ubvTG9hsBZBf/cuAT4MmrBigOIoO?=
 =?us-ascii?Q?ArzZTy1b6S4O5iSdQfX8qQz9VzrYySZ81PoYH3Nul/HUQIgCcfNHbDNL2hS0?=
 =?us-ascii?Q?+LwcbRhj1EHahzanXAlQjnMMNaINqVqfJrQtDSlE5AB5HqxRzKZ+aRTAp28u?=
 =?us-ascii?Q?DWAaiyHP7cnArUt/1CqLMKBh32q7tfn91MIqXGD8YhUeEbh0YTBkmF0mQWiq?=
 =?us-ascii?Q?hCJG2yurmlq2sNFm7XuywKknvM/EgEA5RV2cYvPsTCfTdClYjxSSmk3iyTAt?=
 =?us-ascii?Q?DXnnaGu+c5lL/Jng0CIfOE=3D?=
X-Microsoft-Antispam-Message-Info: DqKmQ/jvKM+FJAzEZXXDHg7/dKTUAwWgmHY+6FpqfooCbrro96h5LTjV0lnjxdOS7mFZ+OnLEhpO1I70Y0uLc5RM/SLJ6m75UnGfAdQEtvcXOCxPhnEzAX63IbvrxxzhjRlP0UkUWza9X86fWpL0XfH3A9SOHH+MZFZ9nC9UWLuXIF6XOkCOxbhuyr2xefUF7jJcZBR+rpu/iwqtKUhTHNDBYAXwerAFx31w0C5NLj/lgIjvYhZbD0CUhevJIg28yh+S0IrjQ8jf5xhqjNRl0YdQCVqGhVbdmpDlKLdofrJ2/c1bYeHpp/31f8RbdoPLcV9GnYeOhQOA/3eBDHvGs2fBzTgr+Rg4Z2SB8fcKwwk=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:O8WZbSnJ1V3GkADBV1+TwU83Z3dekAWqw9XesQKtnjP+6BgMaBOnwt8VGNpKXXov/OtslgSzYX91IqZPxtvBV9pk+n2q8jcZNwXbT2VWEoYOhq+OwKFmivn55AQ0FQ8vX8yjmb5XkAbjFn9qjOfROHft+b0dikmgpHi/z7dijHYp11EOYpQT2Y/G8fTcry7v275QZ0vKHUigaJn93kHFEFlpGUAqK4Hv9yL/W6ii1uDWPzKhEyHzkQ+Gq+1caKxFTvUqeXsMUsZ7frzVDVw9UI0/jmGo1UUo0j6wWLd/1s1R0M+uO4rxL24AhtwNLzGHVCSt+LJcNxyl6mkDEbadwMYPP0DvYaMq1SHJJIWp5plFlPyX4ub/08sxPAdmz8X35QNkqss9jNYhYVlbIYRNIIUD68Q+iG441UQDJ+bN3ENSJhBl70TgWGsT/FlyuS1ysMMGH07baFvXU8apcryDQA==;5:oq7ViTbQ/tyvEYxAChxRksxiOi6ASpkWPKn5gyjU2fAgOlNiCV30ApsvUgNBIbhG4MJa0PwpQMkEo7TzyzH3MofHh4GSfSW9AjT0/fW5r9heXNxQBe2u1UiIAVCBzJPAmVD1HnRZysw+OY/bAvkaadpyCAB3LCVJeluFpF85SwQ=;24:2XdyIpFiP052gb7Uarh5TeYl84T+90BcJfpaXPgFu5fe0+05s14v8R3o5tk3WLXFFj7qQeH1rTla3tl6wP4xR6P58hDXui/zKAO/XBTPqs4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:Tvh9U+EeaFXXyMJEyKu3gpSRvQ6htrNW69acJtWdh2jjG9bZOE1kyHHbqtX1c4Y4bNhI7cOF/9W7dQdWMfGGh7ZIqLeKzUNeAZHdgY4CZEqEjRYeyLNyiWwl7urU1vUo0jgwEnFkbL/ZcIKpK+g90MSwMvQbrn4zq/FHPpnsaXePNXnxk04lNkRWmdwp3i74GxZxKqHcw3ZJl+dHtRRM4VOalKZJBlbIq0kDq+0v13LPlzAbC1XzTnqnZZJafVZV;20:Y5uCPQyHnXomAa1QqnK/SwsR2TwHnIvYhQnvQ4OVPsxMETO5IFVjJdqpjAH2Y2ECf5Sd3PA5STnOVAmRZ7liqWFZ892mtvkAOoT6GKNzaJhCIB4Gs3XGgJ3F3lXWuQTvapgx3sh13fPjB7WbGrqQeuzl/moslaHqRbW/zY2x5zM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:06.8644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8975cec7-814c-4498-9547-08d5dd16ecf6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BPF_MAP_TYPE_CGROUP_STORAGE maps to the list
of maps types which bpftool recognizes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 097b1a5e046b..154d258cdde3 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -67,6 +67,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SOCKMAP]		= "sockmap",
 	[BPF_MAP_TYPE_CPUMAP]		= "cpumap",
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
+	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
-- 
2.14.4

