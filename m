Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2D020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NFeDpfZU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="E2Zpa+2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2D020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbeGTShr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:37:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388126AbeGTSh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:37:26 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhhGn025819;
        Fri, 20 Jul 2018 10:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=cKQG0CMEAsoJMedIhmEy7BnXo0h0UXd6qsQx+9xY5W0=;
 b=NFeDpfZUElGW1CjKw5DBaSipLM2Y7tYKq0BywPGam585zIWNxGdCwMgXOgmTUU8vLlJf
 KdQmGNyyIJA5K31dwW/hgyCwk9MQ/ASsdaMU0n6+6XFj+1zWNrYYTiQtaOkIeePGUlwD
 Fx3icHE+S0zxNhrcP3+JPkyikYUUNymIYlM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80h7-11
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:47:45 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 10:46:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKQG0CMEAsoJMedIhmEy7BnXo0h0UXd6qsQx+9xY5W0=;
 b=E2Zpa+2vl6cCTRmzjeFsbbt6tMzorVnTLIUTfuf1o49BhnN6d1sPSkXMt4eRArTdES06dxP9KHP2m484EJML9oJrmGGO5/YpQhxPUFL10MWj+HbIJ+ts/2rK6hvIB56cDxJP1m16VkpgZTuoPkUllLWSaOPBw/1klybZmw/tIUM=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:26 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 12/14] selftests/bpf: add verifier cgroup storage tests
Date:   Fri, 20 Jul 2018 10:45:56 -0700
Message-ID: <20180720174558.5829-13-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae0c07ff-fd13-412d-1062-08d5ee68b82f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:K04kxTqZtleuX5Mpv88qS09ZkiKySgCCDASQovaQJaw7H5nUmjeSagPISskyxgArGcYaywqR+4hyba+/lN6SsR5iHDMaADVUI+HSMrHYmMp4Q+u4sfhUe9/1TofmaTMQSmr8PVNN10d3NDLN/8rjq6pSFhfVhL60LzqMxfFs3xwMAAKoj6kGj4b8iEjau/tJCulN1G5VluXqdhjTFMFMpLJgBI0VKd8fRjzetUlHDzsHfOujTNyDUdMEcXqiXoTP;25:YZBJsApgGvJSicxtH/rkLAWOVjBam8mhPJ+Gwoez8y6zoayquLYRfN5t7mfjTflglY5l4zo6oKzB8aNNpKwRFEJSmLAoLBsaCq6Rvb6Ja7ENT6+2lJNhbaQBNtVUc/f5MjQTrj25gvs6sT4blGyuZRp6UVfsT8sTrgcgZJ0eEBTOxLsnxzFbj2q35eJSsxkbzv/DDI53nCnIB5RGdr/zbBgUsQRs8IweaB1HQ14QhEq7yaZSK1llbzJItUF/WU/nZNHLv3Msoc7oNPXnbh6PxlJ2DWN5k608PQvmIx1IyZC6+jTfRnu5gQReY44yWGuc4ZiT7yUHDRPOxLubYa+NjA==;31:ys+Z1LFpAaczzXISpru8QexKcI6eZzkQJ0JGVhrp1wXB8WXVOjxRktdPwygZuFxpxCQ/L3W7KJW5cH+4g8/p5WImEF530sh641eBwNkkjrJAg/QF4B4+1tcMZvZg1btecH64o5hyHi9e52FbNHx4UimxTbsekDAXLfnHIFCupFILtbWrOinOyNMrszyCWz/egOQNn9PbkiZ7ID/OEcKbPMDxXElGrm9HX7iJBCC4+VY=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:Z0qsDTNhlQfztMeDUQV7A2EdpflBQskqRbnVpBoHndgiksodHdeX9ge9HY6utV6NCrRW/VEWWOvGrkJH2V6tipwNnvB2n078PPUCdjJKmPUNnzOt7a9FSEl66ZJSRLc0guHVe3QQmYR7g79uahWzQuDYm+3HYVqa4s0yzVKj8uvzjNUD86BhYyZb5eng1Noua/LMzZj2Hh+UxriamWiny633IRC3PcUbSwTcHw3kLjNLUAKm6X7DkviB8tTOV5342X3CoLY3IMDkoL0GpiT/GkrJN4IRnX6KZUUfROh94qr16ACNGpvQnVvh8EpOZRzhXxXC3/6aLjxBnz/BvOvlnyOupHATIpLO7gFAZ+7rdClNgeIf3NQ7UEM1v7SLHkDswe3XKktDWN0UX5repFjVBqO1cZlAs7eK18U0SwYz6EmBxeuhEIPHEF3wPnQbuQE7xoiue4ag8l16UFP/6RY4YxORQ8sgeKJIavNcBGpPbUPCpe494XgBmX4zEo9Y1UiN;4:fyD/OKSg81Ybo1KCOG3SPDDroQkLX/A49Si9zSWjw6ZHzXcJYVExQHhhNwMyc5luPnRk6WKo0POnxSBnAXm0Gy5jiP0N8hMpIDvUn1VxysDlNeR9LftuW4KyKahDmvtNzKh78NphcSs3nmkAsUzkLHb2hCfWsBTWdPbfu7y2n5xV3Qpn4vGScNyw2yJkZc+6dI6Z6OZ91iRnsgVNr3lOKVHrNUfMhNH0ydkCH2UMyAQysiDEY0gO5pSM3PaoCQfs8FZXD/8gLH8T2W74C3h5CK61KMTccqWQyANa3pJWG0V9u/2CQdXA8JsHipkGhNIo
X-Microsoft-Antispam-PRVS: <SN1PR15MB01751A7D9EE261D368B2A386BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:hBEYYu9bsWg/fMltg/Wzgk/hqpiJI74qF0saq7oI9?=
 =?us-ascii?Q?vlJHQYwDy58AWIUilNS90ao6gGF7XhoKc0gVcJYNmkusciya+Ldh2MbAXa0u?=
 =?us-ascii?Q?RKoqaBLDHpEcJe5Y2IuoJYb1uwT80+IhtwIUBMwS+LIPNCK9Tn9//zxeD26D?=
 =?us-ascii?Q?3gk4Okz9Uq0mvtfST27xO1QneEbPclqogK2TplZVl9jIwvHtlgitqGMvLlLZ?=
 =?us-ascii?Q?PzFrH5zrtOki8vUpBLHu6fIVMTooUdlAsOqFEZGdq5ZEIo1/apburDOxrygU?=
 =?us-ascii?Q?gY3usGWn2sF5S0M/PwYG1KCo12MSm7WXAjiqybw8PV+SEe43ArReHkfgwyvs?=
 =?us-ascii?Q?tTrLzz9kxqqUZnfBYt+f4VndXklXxDHP01eAnTb96WySPjQMFzcvgXf9sWSf?=
 =?us-ascii?Q?8ay+EaHkljUpWYdUYoXC25tJHujA54HvwfP/kRcUJW3BRLay30lZfZyYM5RQ?=
 =?us-ascii?Q?+cttVo2ddo9+BfVOTRtz7wCTRSHIeP/DCxv+POQ9p0GKdL9CE7Ni/OY0Sp1T?=
 =?us-ascii?Q?l/1ZFLv6LOafOkvEab7kN5TerMA7lhNO09GDgSlzS7trCCpIkn3ERSUJrgvo?=
 =?us-ascii?Q?7T0Vv4jOCDU8XsC7R0D8qVKzrJZyQE66DX31UcG8tWWzw1uTRdObhy0JiSf4?=
 =?us-ascii?Q?w3IPMDI3XtIOJR3iDw/ruVt3viz/DDEcgYLzB5TA97OotwIwobcemPFULoek?=
 =?us-ascii?Q?0L2ZarDb/uzlCnxpzdpS5cwz8de0fzK6AU+0oErdgl09JD5gbsXMl3rJrbCf?=
 =?us-ascii?Q?ERdBURKFPiESAFpgDFf3PNBAcVjVPz/P0x86RHbyboNzOSt2cWBI0j6W2TOu?=
 =?us-ascii?Q?XwVOEdjh3G4BorTd+tTA83qAeEdP7QIsq018rqiYr4uWWJaw4QF1yA99tw7Y?=
 =?us-ascii?Q?HwKFmYQ+GpmNzSwySG2+EO5LIlfo63qjV5PJVtOQUfCFikks2wlbIGmflTgA?=
 =?us-ascii?Q?MAcVwjMimnWYlcHd2I5K5fEMMgHiHzqrjEcBU2OYxqGfW43383qtPqZFb7rq?=
 =?us-ascii?Q?vqCpPzWOs4uwZu0kOuUXezNI1LCUXzkj8oZwRtpoF0AYBkYTngi56o71kw96?=
 =?us-ascii?Q?VaTZUACRDEnoQ7XaeHP8A52/w43sYzgBbicSX+YITSuwgbw0tiq3T0CcIycD?=
 =?us-ascii?Q?KE4fDnMxXsrZueKK0sBUDsk2i8563FO7yFqLFwu67fg3osJWnhnJaGLPXYB8?=
 =?us-ascii?Q?wisbcKXm2ocXx2Iqy6eHkv4NVOrgu9Nh8gKVA1VIUzYBPoJ56EIffDyiSWth?=
 =?us-ascii?Q?3M0cEx7y2hrvKoEPNZAta22jv9qBordlb63krKDE/w/eS8I4kjYmCpLziKvy?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: XzAPPc6mcivdyZZxdKaMw/dr/7ey4f69dt9XVD/H5nmXR+mM5bHJNNfgw/oWXIzpLaJJe7bkoymoTAkBUTZnlcBfFUfrSba1jm7MhrUpS3Z0RTzJl5UlfW066mW7PyWnt7mpvl+UcmmZ2TvxjbYi8ob7t65Ahlv8oLLQP54hEgpeaWidIaYEXecG3m3RFE97WEwdFDCKwDetQgaCOlyed6T46waWwq0tFSXWR7LXF/2GAByOKWAC+RpMSTL9/+wCw3tdDslAs3KjfbVHax8ZssX9WdJeVnf8TAQ8rUFfCy5GXWc1Qdy5Xf5zty0pelvWrBklBzjrI65fiie1tFp7gWcFoN8QIdLoeNfRgwkCg84=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:PUVrN1YCef830nUu8YrzYxZteoalioDbk50kRWQ44S5CGt5D+1E7SQe/C3AqBcyUtY0HVZPsWI1qoVQoXQ5d+kmRuyZHLLZX//nTqxbj3TXGQWb4hAgFNlrpCpkE5V/pr2kszMh0tdi3uxSJc2hmRqbC9pCUm37lmVNQwV3xgux/KwEUTXyyZBEboB82f+txLc/X4qrFARsayDqZMxPy6IuJGC5f9W8v40KZR6l4OSpbGQwBf7GVR2bnpUytnbE/VLSKHwGht+b6DOkOIBUJ9BtStyqPkU7paFd4WmyirGs+JmfdX79ve+r4b+zsReIkUni4TU0RF1kKu2XpPOl3+qxOqS82OVHu8UZkl0QkuVwf5hUQ1N+fOTT2S7uF+FM94cz4vPEJx0UgUGiz9iTuQ8pZxzdl1XJ2KvxQtQ3tc3dcGBJURnQDTpn9QRsUTwUu5GKCHBfFJDDvlt5l3y15fQ==;5:A1I4VKX6tUKXXpeaeZM30nPbpvMwOlcYVAeqRGZIfdyBtv2te6W1wnFeF/55Twv0arQPEU+elR64Gt+oP6CTpHOPZhFGONa/9oCwRqKKxSLA0JZ1TkkOdvNvvxb0Fa89XgZLPDA8T0+L5CABKkuqIesrWU2bBkYP3HkVwTBVwB8=;7:RszeeBKp/8mQ3HekrPCR/2Nede/+xtbNxJG1ytbKfSUfF7aoA/FVPpPLt24L9bG81oxzvqF8Rd9gDnqomxpdlAMnq8MQRZfvfYcJuL9AEthdTE3XWMzGP68olsdC3cofwWosmEuQtTVXXwcpRfwhpuOpR1aAkOgYU+eav6FPPqz9r5rUthbpWWv3OzNbok7JSKFT2cF2xDB9Pw8pFNMqLpRxaMejNbVYPl7KX+aE1N+5IX+WhtQmOrK3nN+g9DMJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:qpxAf0GPBKpCL0e2cfpMmwTdZO04kna01w6GPrDFyZa5b5alp1jfXh2UJtGS6cBDjuEsRNbCkng/e7ObWPnQuDzTudD9Zp6E5G2zXBJEO9nsOhIFJ6m8tGn+WnVSPbcX3ddgVbSk3DRSs6zTWqrF8OKWv+2jQPcUHmkY2CRCPvk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:26.9008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0c07ff-fd13-412d-1062-08d5ee68b82f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
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
index 2ecd27b670d7..7016fb2964a1 100644
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
@@ -12418,6 +12517,19 @@ static int create_map_in_map(void)
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
@@ -12430,6 +12542,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog1 = test->fixup_prog1;
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
+	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12497,6 +12610,14 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
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

