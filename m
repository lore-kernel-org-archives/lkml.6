Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A11C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6382404C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Optqphyg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cEwxXhWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6382404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbeGEUwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:52:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44116 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754329AbeGEUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:41 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KmLwi015379;
        Thu, 5 Jul 2018 13:52:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ahiCRYw312q4k7xC5m2Of6Ga7JY8tCMounxNSQKpudU=;
 b=Optqphygd+/4jaAsCZ3mg0372pD0o6mOQXrhWx9RjdPdoq9rhxMr2APWt2XY8i3E2NXv
 jVXKWSOT1RXIMWMe1BO0KhwoMXtwVINJEf1TcfbencZxAbWc7bnHrNL/0INRSfasjt0X
 b/sGjkY8bHO11HfdInvHz7kjiTviHxTJlhs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1r3m0euw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:25 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 16:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahiCRYw312q4k7xC5m2Of6Ga7JY8tCMounxNSQKpudU=;
 b=cEwxXhWBwN5b4vOOki9SVcCbONDG3MVu/XFcCHE1Vwh7GFAhAtMqXkAuQgEGoPh7GCLgWn73vRDI7CDl+9JENx9OaNO/LMqfY8IUu+0coDNFHk7Zy8M8Fc9p+4sU8J3Lrr+LAmfD0D82lKqrEN2Np9dcKDYub9A+MpIy3u5o0eA=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:20 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 13/14] selftests/bpf: add a cgroup storage test
Date:   Thu, 5 Jul 2018 13:51:38 -0700
Message-ID: <20180705205139.3462-14-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed7f1a8-d2c4-43fa-f32f-08d5e2b933d9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:GzSxxorr5AvvAAkVMKgAruRwYvVP1p2UjM1qd+6vgU+2BZsFN7K0rpgtzRHtcfF/7N3PMDu4KT4S69BHH6njktf1/kvXnES4xgs320CkoHxA9tiQFiPdIWthuz9syOtw5CcDDyeuXZ1y0z+OePJn5hrYCXGzy/4D6VyYwO8qnd/OuVPQxHN/BRtpe6d5wtHp+3JzGjJV8oSgTXRl3+JCy5QB5ESbRD8pV5u6Sdp/glGCHfe2UYKOK/pliYOyiLV5;25:uJDFUhzVkz7zYQ2V4hA19Fgpgm8O84nH6YgCMfQgKOV4aRZnGthK0Wdh71pXj3b3rm9ib89ZswZWO5mh+fDIWbvbMWwzgb6XuBGXJkvaCzpfndT0J0AgWGOJdR0EdpJYz5fM6UFU4MoMi8yZEUEQBBlNFVPM2tdRoK74TSwRgKujffbhwJVVaq6f7A7QSJBjFDSFaPgJQHD9KBQry0nzUGrf+1G82zzFly92+lOguRNFOeI1Oge2oxz5PqV+8/ruF1IncnjIKNwXD26jfhnUaCOSiFjyNFXMeAeqpZFbHZqvKr5HIKs0GOOIRRl5uTFt3K8L9jFt7Zn1uAHE188eQA==;31:Zudz/UTTVlIiMBLKkYWcVTApLeccW0isCkm9gK7SDySckrgWJI5L8/wFaT3KT07h9XwHovREn02UPjNb0muxhXe2G4jBHpBGJC8tj3MqINK25YXmPl5VWMez2fEQx9yjAzKvWsAaaGdV6ANBGUqIdKp0k/ko17dLgafFKiiIV/sWK+2VlmSei3jlV7FH5MOKQGB++2pyFh4oIbrd3uSNWoJiWe8wovl2k/qdpd3Q2DE=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:mw9bYdOEDWP6Iprlf1R0nSMO9boha3MF721EpsSQJ+fADbaEcdrSluCeSvCVojAh79HX6llpeT0jiUdggppYzuVBN3flvres+EJxvHnK846U2BJ6gBz7SPyqkS9FMXyXzlF4I+UvzUCKCeC5KU84quSzun0NKsLkz4eWVenSEUtAB/QiW9r3SU5VgKbGZ7JgmiQv2e9STKSw3pFz1iR+LETu0gXd8c/jrB1NxZDRUGjxa1jXT9aDCSuLWvFLS8LOkSJUxzgcviMn1H2G/sm377vYM+MQiMpWU21GpY2iyFSrh13eHEy3JpDD+PSxfuPmEaBrNM0gUw0xSI7G73aWfRX3j2Lq1PrXKoiuDjegtxwkX434ZBC3yttOguC0xQNYy5AvONnM9PWu8TusK7x59X5Fiwt1JJUMVsKT83iJ/oLLUN6Z8M2A6EkxawAF8/Z3QKhEn7nIv+rmWIg+jaqD0NrmKoI1a61zbUlXAVWewm9EInpF81BoSWcjVH3Sy3ex;4:01Qx6pMALCO6eqifMbYw327Zq8yN7Im2B0889fyD4pqs/PHf7wlSyUDDWG0OzwYlKeZGnmoVP7//xYz9aO5gTG50w8nFgZuvuxgrBnuqS6lvgXYzUKuctTBfpegE8j0nURap25J4VTIscLXql9D5lJauMpS7S/j39sHWY2gzovonrYK8Ia30fMdVIIQ9vta6YbpxNl+TyUtMfxGJIPtezZeTqeUvOxlD3nNMGaS29feLIDwwWRLPAjxCh1jg6jiMrk/6DOhKU0oYlVbNJfDP7lWelyTW8ep8qr5QqHCr2HXOj05lpbdH6H1VYwrzUX7ZTa7LOeYIudZbbJILtTin7m1MdJOI1Sqrl0o9a2utQlk=
X-Microsoft-Antispam-PRVS: <BY2PR15MB01661F8C56014FDD1D4DDB50BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:KXcI08RArbuUjlLwNa18wsC6m+hRgHPtJrHBB9NIT?=
 =?us-ascii?Q?YhWqyEkb5+BaK40eri/jiWhkBLsQPmWvyln9oRpBNRGMniP5uIo9ZS7SrhXn?=
 =?us-ascii?Q?XyuTT1Mww39tOmECckf6HDa7OLDzJhyD8vYZ5KPNXm/KWER3sU2P9Nr/iCYI?=
 =?us-ascii?Q?WEkNo89821TUxv3+QJ8p6ea42RbDlmlrGsBRGX6TtWQJt1XxHNHsQJmFXA+1?=
 =?us-ascii?Q?KJQ86ZGpVx2rHKpvFY2ChtkM8NsgUUixwM+WKize2JXlJylhgzvqP+kWSjhd?=
 =?us-ascii?Q?WPfZb2CRIIuEGDxzfd9KYX/cUu2ZsbuOsL2aWh89yB6exnjVmlO8GuF6JQ57?=
 =?us-ascii?Q?tYKZ359fBoL1pci++xyZb7CjCUjG0wdjgM6NYZG1ACHY/gBhtNCFNMmn2N4p?=
 =?us-ascii?Q?wQlTXgF3pAghpdTK9C1rPG6APQCDQX7w3o112cJ/zu9a+X7mW4b3AcrMs73w?=
 =?us-ascii?Q?PxV434sYe9y5JU485KsZiT8ipyDZYyjBaCPH6Jwe7OyqfBTMBjJp+udS2kzy?=
 =?us-ascii?Q?/7Dr3hu5X11nRmCYPzt13BncdrpR1JfsVFdHjZ8EyU+Ph2VCsjK1PE5O9ctB?=
 =?us-ascii?Q?8GYo0e2JyNsPxEu4N3ROS80ZlmXivE7xEbZgdJU+ZA4WnatjMAn8Eq2L7g0l?=
 =?us-ascii?Q?HGyUXbB+6How5naDxoqE1eotS1Udp1U+Bq5kcHYWlXq3jwvTElX5YeY2wVvO?=
 =?us-ascii?Q?MDzoBFOaPl7MGF3ML+aJpBWylrOYo5s1gSbK2mDEe7r8Y0iC4Of2vkX7kBcB?=
 =?us-ascii?Q?5iYzdOVq3804MLWm4dfC4iJa5SQ7HnhkZBD0KUk6Iw3c7Qwm4es+wnm2TRf3?=
 =?us-ascii?Q?kUGPFAJeKXdfS1F6TV8v4enwz/yhsOm0tpObdAau6g3RKHuou5XY47C3z43U?=
 =?us-ascii?Q?rZTEx61wASX0LFvcanUxmnEv029yhqSXLLMnAYyL+hig44ea5L7lfhs86ibx?=
 =?us-ascii?Q?ylOEPKaWHxAKFUic/l2aCdcoXBO8vyFxCUDzmGoqyJ7cRaklsLlsCM9d5rx4?=
 =?us-ascii?Q?JMZsYwbj4UYx/pcVMxRFW5FVdjfqx0YrTA4GBpB1K//CYgcGpnd/0Gb5hjXV?=
 =?us-ascii?Q?mrWGIVbrjrfPQ4bB9V6v/uUyFPC48zd8D0zGTufmXw2DAYBqoF7AbUkOm+cz?=
 =?us-ascii?Q?jkAkbFNojXqFWCe1pY2nEhPYCakT6GUv/1Rm+99qHbQLThRXWv9gZjsKaJrQ?=
 =?us-ascii?Q?7grbOwH8HUfoMt/wrRUEQr3oXOjXa+VejR4D0zyvtrDyvl5gA2yIEFBgVBsZ?=
 =?us-ascii?Q?pq8DwyT/bZZKH7aWFX1Yx04uRSoR0y+0oHvfPpOoT4qmzmW9v5r5nWnNonK/?=
 =?us-ascii?Q?qbslrIDel4LEQpPc9dGuLfkE2lyQY70evYVmoWA+MJK?=
X-Microsoft-Antispam-Message-Info: SBOvBmPQ+bR8oyIdwz3VF0bJ2qHC/4O0mVIi9VH76BE+aKTcIDCvV8T5kPb1U8ZCJSc8ypaW+fl1/FKDMkCqMnQTtLs+4t3YVFdne19aSSZdT/nPuCs93cGNLYQ+hn3rokgf6lCCCw1iKt3dSAJY9iDRz+5Ug82qlgF/Y2MjSTdUiWGP1PBuD1LLBICepXPPjmMqMzwT6UAbxhQADQyi3KbI3LFNNwfxdeMNGk/pHXZP+rCBLerTuQdJ+RGMuUqWYb3FjLH0I0U6DR4WCrzvkZolz7L+bpubfFJs83X9Oq5nEEsMBfZEb09Gjgt9CnK9NOGTU9fuEiyipqsRSPq+JCHPAv7f1colYXJHllQHgeI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:uZOGRg7Mg1RklXLYdXLKIrLrO/vBWgIPL2QpiHdeUpT7Kgxmmt5qUFLc4ip1BoZzn9Mekw+jmeHlxoopj/CDUwoosMMe1YJIJDIlxNLjZBef9hB9R45HkqOMqrs/83FTtxRlaylP50fgZx6YYt6eth0yiht7cqq5mdQeNHJbUqfy7YuOjrZXtOnzXnoj/9jgSQ+jkBGQ8XAJVe3LT1OqEDAENgQlxhn3qVL4jBxox2nYAmP/SV3zcgeASdbaurA7N9pVVa8YkZ1qzFe6LPUeXq2u9BGjGvVdgpMTcxn6+x4jmaZL6EGsUNEVKPccXH3yRvd7BetMfSVai3msXCDP83WGjxeozrxVFHeGWcG3lJ/ac+IsWay2D4mhzw5pRcU4kdINxIpv4ZJi1D11YmwDfoaeYvJ/ahwLuStwZK+92wENbp3TAvlrqFnhiX18LLCqLeWGamCd3L/1NXoWShtYng==;5:b65WFttl8qnMg5XBeT5swH0ggCVSHe4HiwTp9G20jvWOXJiQjUYQvWYknjuG512P0UYoRs5tkB55CRPAadHexfb8fArbOk+rfomQIS6CgJqxiIEDWLwACp6CEVyh0kub9jy2wy/bDbicsb+Sem7dFMHBOwdwsihX5mrJLwcR8Yg=;24:Ocmdgbfk9Aos3ZdP0nUtAucX+GmreVB/+2MGooD9Msf365CM11tlYlrZ2amIBHniTymiYbvGQ8BKens0uhUNvHdKmimdTqKXWylXtiw6Uzo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:+d2INUrsm9MB/bK8wV5iTCZnptWt4wchGOiizlYlFFuNn+Ldir5FMWq+kDTOy/tTKCv/KIbj5Hku38zRHsoZrd6MVLOZaWm3iDiPh2qWKDAD7a2+hVCyHr6QMDAo6enAc/QWO0AyHumGLfqN1cNw5fd8nzr5h713jtsVuf3/+XzQfZd4TgkLCTTeSaHuI3t/48lVr+J9alp3jhtWnDTg+gYl7b5smFtKo+/q9TQ/cYtJMVg9Jz/KgsLP48iWDD8J;20:GFMGCYOms9FCo2hPYTzrCMTsUe5+o0YH0uRA/JwPaItWPmGi2oeJKn8QrAKasT2YOiLh0tRoyUxkjo9PVZ0BztdIXmAEMwLWHIcIA6U6gqnMKpqJBcTDjoE3A7sCGb9fWlkq2Xn3PwTwIfFoW30SOIjxb7fmoCb+fU4+rdUcBbE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:20.3846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed7f1a8-d2c4-43fa-f32f-08d5e2b933d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a test to cover the cgroup storage functionality.
The test implements a bpf program which drops every second packet
by using the cgroup storage as a persistent storage.

The test also use the userspace API to check the data
in the cgroup storage, alter it, and check that the loaded
and attached bpf program sees the update.

Expected output:
  $ ./test_cgroup_storage
  test_cgroup_storage:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/Makefile              |   4 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7a6214e9ae58..81f38623fc9f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -22,7 +22,8 @@ $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
-	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user
+	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
+	test_cgroup_storage
 
 TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test_obj_id.o \
 	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_prog.o     \
@@ -63,6 +64,7 @@ $(OUTPUT)/test_sock_addr: cgroup_helpers.c
 $(OUTPUT)/test_sockmap: cgroup_helpers.c
 $(OUTPUT)/test_progs: trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
+$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
new file mode 100644
index 000000000000..0597943ce34b
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include <bpf/bpf.h>
+#include <linux/filter.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "cgroup_helpers.h"
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+#define TEST_CGROUP "/test-bpf-cgroup-storage-buf/"
+
+int main(int argc, char **argv)
+{
+	struct bpf_insn prog[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
+		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_local_storage),
+		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+		BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x1),
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+		BPF_EXIT_INSN(),
+	};
+	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	int error = EXIT_FAILURE;
+	int map_fd, prog_fd, cgroup_fd;
+	struct bpf_cgroup_storage_key key;
+	unsigned long long value;
+
+	map_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE, sizeof(key),
+				sizeof(value), 0, 0);
+	if (map_fd < 0) {
+		printf("Failed to create map: %s\n", strerror(errno));
+		goto out;
+	}
+
+	prog[0].imm = map_fd;
+	prog_fd = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+				   prog, insns_cnt, "GPL", 0,
+				   bpf_log_buf, BPF_LOG_BUF_SIZE);
+	if (prog_fd < 0) {
+		printf("Failed to load bpf program: %s\n", bpf_log_buf);
+		goto out;
+	}
+
+	if (setup_cgroup_environment()) {
+		printf("Failed to setup cgroup environment\n");
+		goto err;
+	}
+
+	/* Create a cgroup, get fd, and join it */
+	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
+	if (!cgroup_fd) {
+		printf("Failed to create test cgroup\n");
+		goto err;
+	}
+
+	if (join_cgroup(TEST_CGROUP)) {
+		printf("Failed to join cgroup\n");
+		goto err;
+	}
+
+	/* Attach the bpf program */
+	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
+		printf("Failed to attach bpf program\n");
+		goto err;
+	}
+
+	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
+		printf("Failed to get the first key in cgroup storage\n");
+		goto err;
+	}
+
+	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
+		printf("Failed to lookup cgroup storage\n");
+		goto err;
+	}
+
+	/* Every second packet should be dropped */
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null"));
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+
+	/* Check the counter in the cgroup local storage */
+	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
+		printf("Failed to lookup cgroup storage\n");
+		goto err;
+	}
+
+	if (value != 3) {
+		printf("Unexpected data in the cgroup storage: %llu\n", value);
+		goto err;
+	}
+
+	/* Bump the counter in the cgroup local storage */
+	value++;
+	if (bpf_map_update_elem(map_fd, &key, &value, 0)) {
+		printf("Failed to update the data in the cgroup storage\n");
+		goto err;
+	}
+
+	/* Every second packet should be dropped */
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null"));
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+
+	/* Check the final value of the counter in the cgroup local storage */
+	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
+		printf("Failed to lookup the cgroup storage\n");
+		goto err;
+	}
+
+	if (value != 7) {
+		printf("Unexpected data in the cgroup storage: %llu\n", value);
+		goto err;
+	}
+
+	error = 0;
+	printf("test_cgroup_storage:PASS\n");
+
+err:
+	cleanup_cgroup_environment();
+
+out:
+	return error;
+}
-- 
2.14.4

