Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B27C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C56C20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kyUB/WEx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SO4cisS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C56C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeIYVaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60799 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729764AbeIYVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:08 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFI92h003006;
        Tue, 25 Sep 2018 08:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=OrTmFFzvvZFqSC3cgopmf+G7fiqGaqO9f4jjSM2KKLI=;
 b=kyUB/WEx88P+LwmZnecl5bREnCYXFA0wF1f+mlJHdst4tHGgSFQCM0xvdV0tsRVVXroO
 8BY8tSoyTVuu6j/VngAXThg/n7EsmLWBtXwU9+FVHxVad4e/XkFCdUt4Jthra9SM7fJO
 CFuCXM5b3qNlJSYh//gm8Hl9kReZINojVgg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqn800gqq-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 08:21:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrTmFFzvvZFqSC3cgopmf+G7fiqGaqO9f4jjSM2KKLI=;
 b=SO4cisS1Tu0eXb43XGpjuuylRqmZSWDPbGcewy3hGcTGOZEO5m6btttxDkwUUOKHgfDFROWPlpJrDYIFarVyUDg1mpI1ShLDN4VDBox0gGHyP+lSgnj1lgeOgypR0Ok/K7zNDWjgaA4T0NrQBIrUZy90wwtOqaswOe8LRqL7AP8=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 07/10] selftests/bpf: add verifier per-cpu cgroup storage tests
Date:   Tue, 25 Sep 2018 16:21:11 +0100
Message-ID: <20180925152114.13537-8-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c02f348e-b16a-4edd-a9b9-08d622fa99d9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:5XEg4f6sgHnl+5uGSpd4WzAxP+jOAb/mnjENe2Uf+LMmVCu7+ZJCqlb1RJiwZOOiHkcyRsMmTAFx6IlBvVzN2siHYvCrvBFJ/Jp7pp709JM3IlHvXySXVtLZcEQ7F6OXP52iqc0AQJrk5DP/jDtNsdzu7lU+uuXxSAUS06DzArIwdSiOH+gSA1K32NutJQW7wEszuWYawaJO7QR+i3OEo4L2Lac9ani4QouhhsUMyhEoCTwiqgENgBBXUv0RN0G/;25:T/2BGCGjriOaU+TORB8UC88OLQQA3cfgfIiSs494Aj9mx5YRbdbvlrsD2g08Y6XeFtE7PrGu8WRcbNkIPhuempOryBUsjNRc6eVgZfEU11ikhKl+k6M5w2ZSOfIgUe+LnBXms5yAKqPabag3YmSIweAM/iS3nfVySCNFFVPIgE0z36iphy+WKYfcpSZK4LF7AUAWh2z979zu1vwlotMgv+aP81CYI0FpatuqycK0EPY7S746SKOa7+dIggUGAm3ep1vIJq0XXOSgcGaH5iei1Gp/4dFhfoWt7X5cJSfwxnN/uUUTm9x19YHl+pgOAMLPatBmkqgdza4b9xBH3WvNHw==;31:030qJM4s4/pwTRAAmrUkVOxVLdo8qXP9FItxX9lGea9c1ovA4PhqhR91avE0ydKqdDyUqCUdXumkYqbS22TcIS1BAxolNeK6C5czkIQ3DLmuPwEFy5y8YM9ZQQnzN/E94B4pehSR3WYaF1RMRcMaYln2i9hA0bFxRpcWYZNAWubWdtJwx/X86+2ZWBz6+l+r7zBl4hgM+ukmNVoP5e0Dw/d899c9/BD9eGWTrA0GzC8=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:bsTSjU6cZFGoCUqqdS8eByJ78lBs86y8F7Jvp4ufS6FbGrDoaUQYOx9yuSm8h5cDrsI3Gqh2+Awt+ZbjrdxG0xseecC45sAOyKiQOLxbpCQw6qUZdDYf2zSWzmhKL0HIdb7zjKvd/MyQOVM2lJ+7KFA3prB2nN0Kwcf2dK0t55APefBb1Y10E2P4fddnMUXtL1jzsd9pPDmKCyPKcmNvnhknRvel6v5PK1IvidJgTC6HXrp4qsZmJK24qgKIfMZSvOe2CjnSVKkQSQUBFU9i6rW9q2bxRwX8kBKZkO4pE6Ran5b8HvbhZ+xKE8b/KmWcyDf01SwHlmUit4OzgyqEbqwW4t3aSE6mSAiKNQjAUgV+krpgGpbbr1ekRgEYfSKzWd/aW1uecSHhLuRK7FzJq6Utn+F1XeFDSoV7r6R0galUKw0R1+YKoVF/jbwgkgKgACtM2x2oh94t/V9apfZNVNQI/58P4VMiBU6NU9rDP/UPYnlbJe3yv3idz4nwGSGM;4:DfK2m7IbmEAfKepFJ3k63+rc+8OUNhg6LElyexfy/D+xVKYmnJaylt/LYHWKUI/TjX60KdhA2rFG+oAwq/llr0alsdmLLVLbLQLZU+rg0IGp/qayoGXqvZG+PS+7AKxHZTlKCIlGVYcpW6ac3TK+W+lWANy9TRNRQndMYRX5+omxwtJtRW84tAXBTbapOqQRH/F/vSSIxEr8YA3DMUR0F/MHuBcXpFk3XPhoDG+naSNq6foZhMN8dC/qaU5g3WGzP0ebjArNEmg1Lx8EG/zF9gDC+mWF0yVuQasfvbs795BHpXs4A2wqBeDvDxL5LSzv
X-Microsoft-Antispam-PRVS: <BLUPR15MB0163E5E6FF56CF64394AC2D9BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:XVoMPbQO/nsrQZMhMygmgIRt3GuwmEgT2CEDhxWM2?=
 =?us-ascii?Q?2li8sD0zl7dXPopD/KY0tNi1gCxruzLjIz2oQNvn+GA4TwBpzMag99drNIJj?=
 =?us-ascii?Q?Ur0spJGost4+A/AnSswHCjaTO85Vbe+cYoidDc45H9auB3Cg1RsdtY/bWIfv?=
 =?us-ascii?Q?GyOyyn6JqYxzq2cnNqP2eGkydcAAJVB5MyestKebrJbRvzto/0wgO4stbD9c?=
 =?us-ascii?Q?7VtJbwrp1KJJ3ZsBt0Scyp7MEA52VJEbTXg6CJG0kTl26OBy4GjKjItfEqkX?=
 =?us-ascii?Q?VjWyx/+CqagUxDWudFIxAhoCSvVERAyEihuIOiL2rlHV/b/wb+vo9hSJt9S6?=
 =?us-ascii?Q?wbkZD7COWlY7oiA4LBMxz2C7/w2qCVWjRgsalL1f6zJddIu9ZGJtxpJ1q328?=
 =?us-ascii?Q?YdXYUH0Prid4zjFoNtzsAcr2z6PLdEC7jybh0/yjTRJ+CAKWTFkylM2J4Dqj?=
 =?us-ascii?Q?IKfFT0WdEp/v+0jI2o1WzB0DnKlWwH47X1P1+EjzZNPUeV+YrY//OU59b+yE?=
 =?us-ascii?Q?8vAF1IP+lqfO1OfqKIFWbX0Q5pYjf8WFDdauOV7oWzmiOPIG5009831NFAQD?=
 =?us-ascii?Q?PU65AEgs5meIFj+wssWJZy2Rf1ifmKgyV2hyIHTfaSR6afNA8fVDLjPWDslQ?=
 =?us-ascii?Q?+5d54m+xCKMDc8P8RIvB1o8K6xsf47HtD3i9gMGLMf51opUgat4YArD+OwUp?=
 =?us-ascii?Q?SRPxB5tuPJFO8MZKl+7IlN6gy3UfqsBNuL6CyimBPfq6+NBihYDy7CdE9W1n?=
 =?us-ascii?Q?/TIdceNapB8M6mSWgrABNces/8De1CcqEHqseLMC8WV+xMFzapT2reH4k0Md?=
 =?us-ascii?Q?eS9q1tCfolwGdahVgDTBUvtUsV99PxonOaHPLZegVsoluG3Fh/Sq3BSwy09b?=
 =?us-ascii?Q?jITAH1bcUwL1k6CvfpLasv5WWGPkDu48ikwa/aQ7LDBcbapZ86w2jJbUbTYj?=
 =?us-ascii?Q?Q+Hudiktf+uk6ICMcTyoL8qnNjPxgirdD5MBonNxxlF98FU1XaU4tZsHfOdV?=
 =?us-ascii?Q?tbOD/xYXvwNi0NWFjE3wT+lMWDOvFpWrZ6pUkvsLDlXYoUL6yqUEuBzZdbrx?=
 =?us-ascii?Q?tj0pm1+pFhIcKpAfmWP5YM9pb3L99jJbX1ZzpeEAxFAjuiGBHGqL29i5LB0r?=
 =?us-ascii?Q?tY8Tcg1oIQUrVERw/Mwx9ek7KNDx5DopBdndUVdocKBekT2ou8UanNzwD+Bu?=
 =?us-ascii?Q?nlcB/JfqoxMnjDz0uvjhQ5AEIovNoFq5hr6pYGQsyVxhr5YcjAH+gFHC1EyX?=
 =?us-ascii?Q?GEHUHzAX/jC+4UNvmka2todEzEE6/JemfAyo8onxO4041yYhOMAhNtVQjZ1j?=
 =?us-ascii?Q?1NWEb66kZQkCDnr+8sh5P0=3D?=
X-Microsoft-Antispam-Message-Info: jcZjit1YAtw/l1SCstoeowRXgXPaiVplUyVXi7buXir5Gl/p8ep3A7IExLZNiDXxKpinlFC7xuL0UHciZ23I57VZXUJofXL3J4+AyCun56/tXhwJH6p8MO6sMcfTi7jTvTA0cBGKw1fXCWi5Gws9Tz1LzIiYaLm81EnsNTOvSEZHDrHrhzNuvsREeJ/pHyYr00rY1SPDA8S42sOQHrkpi36Zznz9wFFkAP5lOz32IcTQKUr4DEl8rKfjEZ0yxr3b0CMm+FxkVPoO5NX3K0O11+K86O1c4TerduFHVj2x3PJ4NP05q9Kq1SjTcSV9tVekK4K03Emz+PvtSgdT6QWNR19P1DfIYsX9crwYF0GG4so=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:zxxGnXGeBnnW9r4uGb5TfDEhyBggJ5SCaES0Fza3wn8ayPssuDtUovFMZXJJUnXcIrzIn+/7jWp8avxD1F28yxdpAtXF+vN4dEM5gnTY9F/RKt1fuwvwfVS6GhhkqxX0A80LGUdPuZXSmo1ywdUfGALG5VgMctV6klEFnldxrBwJCmCz+/PgQA0I+Fu2raB5rFpZMwOXPT38HUZU+YIYdbf7jT7V4WWad+bF4FtwBIXniIjLxpoqz+GUSP0qmdnTrT5WR3TG+QGW1iEFKkNEKG4XvJNXePWFHD8oi45T+XWs95tLnDf9oIyw7myrBbnEKgybAxsPhWGOxGWxZgYNxuXedTdn7EVNvwirZU9h7dQOYWP8Xy1PsoPiXscNC/5ur5lD9dA0zfG5VI8xT4Oee5bqs3LB9gUMS0eKwWvzPjYGmd5lh2kPiZjT7yWhepUNbl3v7AVvP+x5SC4cclEyBQ==;5:vrAn3mbJowdwyrjYQ/OAVHMLKMtXRlTZr43xqzBNOw+Clw/bTGagvJPQn/MXwp3cGCo16kYkgFXaOnYUPm5C8J5mfwGdwwa1UOi0TzsKaWU7JEMq+xmtULCkMbM5aP495NXfVzfKFefj6rwbN2CHypoidWqx2zYulPVOixtKiXw=;7:J2SaUsbiCQ88o4wPUKkwv0ilRWgHP21ORO91Yb+fk58i21RTgqUiuMpdp7VTBGBeKlsclmjevGQfN3qgNbHnbz/R+98LodRPXsLFdeVNjl+lsqwnyR4k/lTPIcLL2TZUcDlJnoHwMg4faHgUHRKqnv+Qv/EIc6LQdSy8r9549Cu3BI5HmCneZIJyq3toC/WzEuvPL6q6oM6DE+0bwjc4+T55y1YrzYjtDDME8ZuxQ7jOIpJCyKcttwl1gtRg2iCL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:MGIftW/J9ZsWlUGcMTXqKgmogrUeup51JUTWqlTdo9DnzkpvPZ7i7rU/CBSeOyXYpzGE6zl2iARYsqIoDTPnDPzI/GIi438iw7ELfVeTi8EDTq8lSLVw/ii+BiZRryeRnVWLSzfp9CJfUZNt4qFhGaW/LwAq1gSW5Ks1wRn+ZoY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:42.8962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02f348e-b16a-4edd-a9b9-08d622fa99d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds verifier tests covering per-cpu cgroup storage
functionality. There are 6 new tests, which are exactly the same
as for shared cgroup storage, but do use per-cpu cgroup storage
map.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  ...
  #286/p invalid cgroup storage access 6 OK
  #287/p valid per-cpu cgroup storage access OK
  #288/p invalid per-cpu cgroup storage access 1 OK
  #289/p invalid per-cpu cgroup storage access 2 OK
  #290/p invalid per-cpu cgroup storage access 3 OK
  #291/p invalid per-cpu cgroup storage access 4 OK
  #292/p invalid per-cpu cgroup storage access 5 OK
  #293/p invalid per-cpu cgroup storage access 6 OK
  #294/p multiple registers share map_lookup_elem result OK
  ...
  #662/p mov64 src == dst OK
  #663/p mov64 src != dst OK
  Summary: 914 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 139 +++++++++++++++++++-
 1 file changed, 133 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 67c412d19c09..c7d25f23baf9 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -68,6 +68,7 @@ struct bpf_test {
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
 	int fixup_cgroup_storage[MAX_FIXUPS];
+	int fixup_percpu_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4676,7 +4677,7 @@ static struct bpf_test tests[] = {
 		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 	},
 	{
-		"invalid per-cgroup storage access 3",
+		"invalid cgroup storage access 3",
 		.insns = {
 			BPF_MOV64_IMM(BPF_REG_2, 0),
 			BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -4743,6 +4744,121 @@ static struct bpf_test tests[] = {
 		.errstr = "get_local_storage() doesn't support non-zero flags",
 		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 	},
+	{
+		"valid per-cpu cgroup storage access",
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
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = ACCEPT,
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 1",
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
+		"invalid per-cpu cgroup storage access 2",
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
+		"invalid per-cpu cgroup storage access 3",
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
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=256 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 4",
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
+		"invalid per-cpu cgroup storage access 5",
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
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 6",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_percpu_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns = {
@@ -12615,15 +12731,17 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
 
-static int create_cgroup_storage(void)
+static int create_cgroup_storage(bool percpu)
 {
+	enum bpf_map_type type = percpu ? BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE :
+		BPF_MAP_TYPE_CGROUP_STORAGE;
 	int fd;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
-			    sizeof(struct bpf_cgroup_storage_key),
+	fd = bpf_create_map(type, sizeof(struct bpf_cgroup_storage_key),
 			    TEST_DATA_LEN, 0, 0);
 	if (fd < 0)
-		printf("Failed to create array '%s'!\n", strerror(errno));
+		printf("Failed to create cgroup storage '%s'!\n",
+		       strerror(errno));
 
 	return fd;
 }
@@ -12641,6 +12759,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
 	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
+	int *fixup_percpu_cgroup_storage = test->fixup_percpu_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12710,12 +12829,20 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	}
 
 	if (*fixup_cgroup_storage) {
-		map_fds[7] = create_cgroup_storage();
+		map_fds[7] = create_cgroup_storage(false);
 		do {
 			prog[*fixup_cgroup_storage].imm = map_fds[7];
 			fixup_cgroup_storage++;
 		} while (*fixup_cgroup_storage);
 	}
+
+	if (*fixup_percpu_cgroup_storage) {
+		map_fds[8] = create_cgroup_storage(true);
+		do {
+			prog[*fixup_percpu_cgroup_storage].imm = map_fds[8];
+			fixup_percpu_cgroup_storage++;
+		} while (*fixup_percpu_cgroup_storage);
+	}
 }
 
 static void do_test_single(struct bpf_test *test, bool unpriv,
-- 
2.17.1

