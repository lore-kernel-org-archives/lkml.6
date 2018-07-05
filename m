Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1CAC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095B02404C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="F6/l5uVl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jJaBrC55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095B02404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeGEUwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:52:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44096 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754074AbeGEUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:37 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KmMvQ015385;
        Thu, 5 Jul 2018 13:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=c6UKRjwJ1siNdP2ioO76Bf1tZPBBm78eVXDcfxHho1Y=;
 b=F6/l5uVl9a4/V5JfuPs6E5T0sZEIkXJGHvTskOvFeu2FP97TtiH/CUqpVu9Jm2xxDXrv
 IVgKYJjUNOQq1wdEMFSIphqZG4CRFkex8xiY7djx2/A6hAg180Wmfx7e0xldkjVM8C+A
 hOIEeGF/ZA/l0x7QCeq/e28i32gesAApdTk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1r3m0eue-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 16:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6UKRjwJ1siNdP2ioO76Bf1tZPBBm78eVXDcfxHho1Y=;
 b=jJaBrC55vgekuKkl24uViY6ZQn2/J4Z6brCGdqlcCbWIH0sbJDny8lgLCorA0jfXnCzm5tbnbLphKu+34re2M3luwbGlSgvP5k9WN2ST8nVlzF8BFCAR275rNKGUV/3FnOiEJWN9Tjwh7fGE9kfWd33UjHxaUdR7XsAesJ4wpe4=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:08 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 01/14] bpf: add ability to charge bpf maps memory dynamically
Date:   Thu, 5 Jul 2018 13:51:26 -0700
Message-ID: <20180705205139.3462-2-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c8f88b5-b807-4f5b-6f49-08d5e2b92ca6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:gOWdTC8XDjYhcezstqlu91gWC1PNrchxtUdaNniNh6sMHuRs29iOsiVH1MUS+KqDFNr81YTXoKPF5W6z4LhZ8rjMbbbBJSc4+vQlJvc34TNKWQJbNLXyl43VRs45HIgp3njJZlJic7TioW6CfA2v9+/QSsovjg+o6Q3yGUcCmvGokCFVSsKUHsf3uVPOR4Lt9DLmfpZnq55q5km34IgR2ou6e+1jVNSkg08GQTPHoSA5sKVGqsEuiCS9/vRA61Mf;25:rleb+7DFEgQ/cKjINb3kOsXgp6ZcuiZrc1yEIXaHC5Dy1uX8u2HERzu5V3j5WUdRVTzMtylZ2Ec/g+2KLH0iVkon2O8w/QRTo0YpQa4yS4dyT4oQlThdQXx6SfDrqPULIvj8HLDPi8skRdpn1BwaY+Sz6ARjslu0FxqnHRXCSyD8N4/R3TbbNXVnz7Ih0YA8DxaVKi7u/7hPjDNRsVG+yhZtTg6Vbj92hr7NMKasvdaKWWSjw+e9PandSilINMFWFagMnYYcGBSLodGLHlku0xsLKT9+tripgvCC6KK2lzMbwjbOC4vaWZ/oFQMtLIVL2jbS41FB0Y1lFy4q7Red5g==;31:NTXwUFnqOg6ShaI2p3sot0Z984fsczXFju6s1mXBrqxB53+tlYMJutABxTxx9DlSK2bZoUQwAVJi1H2az+UohenD0nS0DG89/UiI80EDOR+aP3dgjq5L1ASXgOD73i2uFJbV6OZJzWEAie1qAZJkIngvXwNPp0I3/tTF+qMThyoXn+T/4XDWLcc4n6LHho/MtRD2VTCNfuEcpmZtzRqyOOvxqjw2nzWkCa5ToV1VNwI=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:c9TPYlvhclu6SKemUo6hv4eswWA9BdBAY4amAIaeKC99Zw3O6GPZvjVZa2uf+J4X0ZuLEOHwf8meWifTYMx/yoddXNGZqCWL5emE9MEfbQM3kLx0biJEJ8sRchLh6T82KAYgTpXlcSJNUhnxjIM14nBjGinN4cPqBnRKZdV8r2LJu9Y5lAv/COqVP6UgJPAe6FU5qrtCwivW9k6Ba64vfLDNk6d1Ateh0+tKTWOmGy43k1lUwiP5QcVCt3ThrSxXYsarSDbC6Y3JPZr/Aif7RlyYU4ig0ItJvwH/orUE1g8GpJ2cNb0RPp7ZxpStXxV6oVFI2bUIswknnSpEOmc7Rm3jxB+HBnjWPalTk6hh85iLw7A4vb3FO8tplQv4CKRcLjOUdbaNDC+DqQlNj0px4fUDZqKiB8zT78fpnBqT5CvMGRUY55rmT4atp6vSbRkzSVbr+zlb8Ze9g7y/bPipOkkZE0gHmtvduYIHdqbWlgXXqa2oxl89gQz4stBqvPnb;4:tJliCydMT3YdXLcDbZkNchz9msylZnSVvtiQEH2jriW16xfwfnTpcBVu+/mV8VINMI3nIEV/EgzD7VvmQe1g+VvuaxTztFAO18clFXu3pbHOf2RTgKPNN7lrPaC/Urs8wem5j0Y+rFiJUSZOdxLG0rnL9B6+6ai5IKjQBXaOn54PWh2bhbAFtbRhhgb6jsZ1k59J0IW2Fi6jj636pIX1Bzcf/KspTQLP1hyVoKUsl4b0+PifFh/BgR2IpCGpHd/e/3EtOvR+zncDDaocQc9L23GQMYM+G9HHSOAmun2zzBpMNkmjIZ5LdU7DQIMR2swL6ZaH/6ZPP5VCDm3+b8NZLYAj9yI9h1t/1hsPNVs2r0Q=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166925E5DFA89AE1C96BD2CBE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:vA46Vw0keMzxn3hTP2Iky2TJ2gWUoOLqZb9ffHvzO?=
 =?us-ascii?Q?F1/CrlKnPJqbVrDnzItAUI319jz8LV2LgEKWqE4r82ZQY774gcfOoaNbboHk?=
 =?us-ascii?Q?hq5+qGaM48wByaTFD2hcLRGFndLp66v+p2ZtqQ3CALO2+wuBPoHmqxL/OMgB?=
 =?us-ascii?Q?FGz3Jf9GsORHXKK7tzr8eXFvaoKH2k2Hm5xMtEYERvCkWn56wizsqNYsdPdh?=
 =?us-ascii?Q?2dWW3wK3vlzJLTmpOJkWHxtZE294CM30gfnCI8n4Zx7ojmkLLUyr1z0I1osM?=
 =?us-ascii?Q?3MqzoYiq0xEWA/2oGSmKj2tJavANfOA+llpLziS725N03BQ4EQc5PJ0YX5Iq?=
 =?us-ascii?Q?6nbmLsMHAkEm3/X/ahJqxd4BoLdfjwA/DXqpMw66PhtzkQOi5Ws4pemUkM/o?=
 =?us-ascii?Q?/RqIKtKGAzWJgmA80zcvLUunx+ZTDl/7qEaRgClykKMolOfOet3Ubs5PTCbE?=
 =?us-ascii?Q?EpTwTUBpoChBkZFUM5NnbcpBhR67WA/W69mOge/y/7rCtv4P2eRhQQ2Gx+c0?=
 =?us-ascii?Q?CT9oedzVFjm6mUNsZnU058qM1t050fcOaAqcRcFw5VGIx0mxDIdBxAAkqOqr?=
 =?us-ascii?Q?C1UoxgDdD6I11q3ljZZeKmdCFhVilK3hzJGdJSkt/FZGW6GYdwAQDzonr02q?=
 =?us-ascii?Q?UNGI7pCuprlIUXWPxBbnaqhXabl4cW8LLaCs2mA6aHt5yfzwYSxsob1tTkUc?=
 =?us-ascii?Q?TBTRV/o/TyYbNuOVdW9H36dEYNCNvXCfGAGey4+dcR7Bf3sPBkz5s5TGsyU2?=
 =?us-ascii?Q?8BjqArJovjc0KocHhoQ/GELy+xCKDh826abwLoLrgXEdSRnmzqUA9MJiZovv?=
 =?us-ascii?Q?iN2ZGG4sxUrHmYoN499cDeFFj13dwHW6j+gcM5PKzTgDzwAY52lKGCnKhqqh?=
 =?us-ascii?Q?AgJiB8kCSrw0QJxui2QuO8b3p/8bCs5jKerU2ozAElhG1k7zH5WYbMJeV31i?=
 =?us-ascii?Q?rnILYotivCFroCWY8m34hUVzjUqu+X8SLwg99BeMFEH+GWNgyrdUI05E3RUo?=
 =?us-ascii?Q?tTQ4UMxD4vdEppiJXDIpuhGmHsEitM+kiZdUtvMjuXcSnkw+Q/oKL4FRMkHC?=
 =?us-ascii?Q?g4VQ6vgQxTB2Dobc0lkpRgDar91ygpzew04vTkVlt8nYkv0ybXXREFVpuq3O?=
 =?us-ascii?Q?Y9NJbawcaX36ze8CgRUOa1aOhZy4gV0TMJUgmZOL+pWngS5bMTbc1sukNPfL?=
 =?us-ascii?Q?Wyc0Y+pW0WWT17UTtsU9UgWvc3yxyr0AbKgFXYYeTS7qLgLtuHmUdO0TRuhW?=
 =?us-ascii?Q?c1eRUtyQPML2xV3pdPswTJXb+Rs0vnFoVdAbMmuOsiljzXlW8BUmWshgtxvR?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: HpckVIubJEDOfxYgaBRUMeRQw2JYHlt+ixWxrRpVYGd/gY4VU49QuabcNdqkBMAhKHxbaSmvFumKcz1bEEe3ESwEIlsm4gdwY41KLJuZ9hdJMiK4Fp9HVMmowTJ86WVKavg0gvwF2999Fr4UJ52wGXAiYqqD/km38ge7aSM/9kYCgn11rTTPak6I57l1uQKRkY3kp8v6UBO02kP/7Sa1XUSVusqy+Y7rnWaT0iGRB1NKPU6xodpnb5ZeXkyDn0VUtI1Rup8An3/TgKd4RmPI5bcaQ0XqSbJX4dObakjRFvoOfhVztMx8ju6K4WTOT6QPhPKf/2DoX0H3c7/eweELtw1l/hJcCbtkrD5ERwQFC34=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:Tr4NPU9nPfqTtuIEePcGXTw7ZfZUBOsWOnR2/ui1ZrPrLphgGZIcChSinXwBMp6OccRGizCdKrlN62fWLKOQ0A/vIJWJwTP4UIgL+uGHD/E8KTDlXn4ZJdHy5WgCN+MG+IcoPGlxCCFSmOOA66Rghy9wexUksTJ9ybrIBDfHjxeiIqokStHzgF3rviKyc6IvP58b4QooOHxD36jytGP0r5rcJYZgnZ28D3dQquNU0r45Qvb+QO7gOxhGEpRsQUEwd5/lOTkZcYzD0FoTCOCX5glIqCF1w1qK9Cm3AN9ENvzbtFt/IOZRuQqtY+UnCUJWF0F0R3JIspDaVMz0LK7iD9eFim4Y+M8kXCpkSnb58jAlgAVcqe9LynxAhvT5uWxyhtXzx+C3umNIt55HtvDb9mMxHRdjKKnPZjkCuObsBit0amGiX65sxA2oa1TnEfA5V4fzm09lhyVDiN+yS02BuA==;5:q3nTZbSq9SPByk6LoXY6jsghQPvZa4jcNmMPDOSVbqp1jpvQAltQJzmcXbU2/YnaVZWwMikIBeku/Z7Vi22gISnFdSEFZ2G1Nxun96wF5bZMuuqzJ3/wHlLrXq6Dytj4RPeZnF/69aPkwLsqBEx06t9loZ+XY4oBgoAF3K7LGeM=;24:fPwxBJ+Qc7JDwOnlRaJNm5DZ3akj3gzjiaRB0HCw1vDt5GLF2zXyB8AIx7qJM0QwbXopfHn7VnRXTCmlI1rrpYLTGQjBF/Ih5Wdp4yHd0S0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:lig3u+Nj/q+CgWA+Yv7ijvirjWC7uUCvsrOs0dZNNGklyu04pB5r+hYs246lOOJHfQ47sCBnEYHGsdA5HbbGrud+99hSCjSxVByXBhZNA4FQtfW5YmfsrjfpR5EC3aii/G/WN8zKqman5K/wwKEDpH1ojQDHwe+5zFi98i9OU7rg64MK3jHFfnXEdrcJ4uYeDo+xJ3uokvcUfzPJsWgzfQb1SzOVa86beT0TtmmjyiCpL1PViNbNjKnl6XjyQhTQ;20:iBO6IDJ9ZMXjm60mP+0MUN2Y96mSiR6eImD0Y0Ppx5mMXO37UApkQ9MVFfNm3eduprzE1qemYiIMl0moAZwSnP2pYs3zutafW5vKXCmKQXUAG2apod1vVoT1KZKE+WHPLNlUezWbXXN0u3jEf2hBllmLz5OUKQ531NtPVyv5pN8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:08.3050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8f88b5-b807-4f5b-6f49-08d5e2b92ca6
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
 kernel/bpf/syscall.c | 53 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8827e797ff97..3d1933707374 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -434,6 +434,8 @@ struct bpf_map * __must_check bpf_map_inc(struct bpf_map *map, bool uref);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
 int bpf_map_precharge_memlock(u32 pages);
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
 void *bpf_map_area_alloc(size_t size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d10ecd78105f..cee452a19538 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -181,32 +181,55 @@ int bpf_map_precharge_memlock(u32 pages)
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
+	atomic_long_sub(map->pages, &map->user->locked_vm);
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
+	atomic_long_sub(pages, &map->user->locked_vm);
+	map->pages -= pages;
+}
+
 static int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
@@ -256,7 +279,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 	security_bpf_map_free(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -492,7 +515,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_nouncharge;
 
-	err = bpf_map_charge_memlock(map);
+	err = bpf_map_init_memlock(map);
 	if (err)
 		goto free_map_sec;
 
@@ -515,7 +538,7 @@ static int map_create(union bpf_attr *attr)
 	return err;
 
 free_map:
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 free_map_sec:
 	security_bpf_map_free(map);
 free_map_nouncharge:
-- 
2.14.4

