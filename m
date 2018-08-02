Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B248C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40D821580
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bHRzuTpT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eo+l3ywR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40D821580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeHBXVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727260AbeHBXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:15 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUY012185;
        Thu, 2 Aug 2018 14:28:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=SS3hL9y/Kz8AKahUGvBHEw2nIAlhiKXXnDeKs9koJN0=;
 b=bHRzuTpTn4aPV3eE6FNIFTBu8+YPprg5vLk8Vgt3V5LS2mTpAPTjhxbt1fvpzf+vtlc/
 UuGPFVOFsIexnrpvg0nVvdhSJOJLWir+mbeJQos4sf6OUhOTAg0/+KInsA6BLx8frLZL
 w04xm9lERWaMoX+qABY5FxYo/TEv9C9gMQE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:04 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS3hL9y/Kz8AKahUGvBHEw2nIAlhiKXXnDeKs9koJN0=;
 b=eo+l3ywRi+JusC4W9RWXxq0yUmFO58CuRS2pU5Gk7SUUytYrzFFgjcj4IsloPVyyZasULjFAKl2TYkXiogB8NHQ3sIcgwpQvazBsjQV5V3IA2BCur29U6Kfz0p7KUKTpVaiOeUHQ+cFu0fywkx52zgLj3LxUuC3x5DsgjK5HtZ0=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:27:52 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 01/14] bpf: add ability to charge bpf maps memory dynamically
Date:   Thu, 2 Aug 2018 14:27:17 -0700
Message-ID: <20180802212730.18579-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0952631-e815-4d9d-e66e-08d5f8bece89
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:8pwBfkHZIsemPN9xdHMS5zPb0I9Fh9R8uh4vsI5LsfXAYwd4Cj0aFE0KWJFC0tHRn31TPLFfa3ru9qhikTp/bMFO5Z89OGtgVoLBfTrCwHE2n+p1BR06Q7yW93nMEvB9tRBjQPJH5HhjsNtrTircSzwYliIURkb5ZIURlBVlwYMXuv6yxf+MEla/WSdBAUrjA+Z1dETYiRpW7h7WmTjUiLzZZ1Wc/KyV9UBdrGwrMJOIEH/XLFYIw921CrfsSLk6;25:hAUC+KAL/gNB/YJ/fWx0FymD8iq+Y5qP72M/vla0NiIMjRhrhTUcpGk8n9Da3V2jFIJn8qsUMe7Fb3QEvLFX10xgppo6NX0AlY8uMFxSP8fvsBT9su2RBn2Pf6WJwOUqCG7ZrAz1Jx0FHFXcUOXb4eXy/IHBotwfARCFf3xHmYl4sXPHKlb7nCe5TwwO1ujrgWbtDQO24IlbWsldOnbsNVsCCBXvwsGqYzxMtHCJ+21VwdeeC7DeG7ZgMzQHyMGR8Odr8MwKNRBT5eYSXfDfeH8pJ1E2N58RFyewOKvG6jf1635rfRNRRCs/04x/5xsSh0uBSmXVabQC5j46FOu1gg==;31:IBcKl6is1hTWzDUqmE+JNlRTY/UT6DLtEMH4UwFjy/Iwsd46JLuG5F8kZTkHN1E5q1UxzU8T9zTyyPCF9KmzsZXZmnJmvL0OLxG3Ve1O/N806pZrhPrX5993PLgv4NPd0g5aplxXW1X9s7gIahuLdzU0vuzdU2mjGPADHz/hye3eHH7QhVDL19fUsnuTcClp6wKYytV9PKlYm1+VszHZltHVM3JoA+KPumwOypfolIc=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:VscEg4bQA4TNOQAhw/4nJl3mimUkHGAHib5mIOtW9/NyWHgOQaKGUDk9EFqMFOKfTiaDDT9sMijXC3Z2jKCQRfVbH8TBqshB/nAw7rI0T6vqtyI6VrnyCHW8lERRhT125XB0TgH3nNGMAC7rqVVLJW4fMh+PgzF6Jg8jLniRBqS6zz0hMz+/uqL7vqxFkBwIb7pJ2DdOSs8DhwkIgxypb2fDpiaA6pV7YpzioxEhd7v+4rGSeVBcmSr3dyRuxrDN0BTGItLYtW9Lm19/fchmYsn3Qgjn9xzcny7U+YCDKRopRrN0fCpT9vTAYGnFKaNiEL1pA/JE/G5PoIkw9U08cpv6EfOclGP8JvejWZAgrfynNYMWkC0uVu3pivaxpb97TXDEVcm59Ijy562lHJ8t3gYAK5VQWB6Ood+2Z15AoafP5ToRO1oTdJJBGeyKBhj3Fay+ZInqMB9AYnrZ7JHBMOBPVG8JH7cL9wbZZYfez1E0G7HMJOGVYulxOCenukGS;4:RM0qvgVG8aCSvfT65YHhldOTDNXWfIN/5ptprSYmzg2Q2/NVDEWrI70KTYdRiWEHjPk8mc4bUtWdw0HVHg2RAD82pp8hMuVisoLp+N/fXWswCwXzdcdwDZCDuq5AtsF4dDUiomAIRka9OKVLbbSpN9IQvWJZPErCQVIaha36P4rtQgawbgMqeTKvOsjCgf1nKaOWwXMecFt0WCiyC6wP8lyoLnFTALTZeNjyy3Kn9gokj27Kq3jgNm7E2IxeqPr5U8z57jwYg2sc9kFX3TaNd2Q8rtiOmB/wzBc9gxY7Cztw8hJt/u13MweA6AmwF5ucw2h3UJxRY9A9onxVwYJdH9uu+855ocLzLkPA1NUZ76s=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167C7B86E690A9693871C90BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(575784001)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:Ce3ZiYJFtSb+zwBfVrF4RPyXNXQGqQA0nFmcYarZy?=
 =?us-ascii?Q?ChbJ+3yHT+V9lzN1/OYLrBkENUu0Fp2IObC/LuV5wNw2iJo3ecGQlCC8kEYu?=
 =?us-ascii?Q?XGXnnO8Nyxhhl9HMyebEXfClMxf7FSHKiGWRfjLuxHHWwj4TcP8clyFwIT4z?=
 =?us-ascii?Q?nCYOe0Lm8z+DNh5He8WI5hnyoq5VU/4CzT+hijRdeMWMfiZJD1GHlDGOCwue?=
 =?us-ascii?Q?9/y1ZQJWxK47iiMFDG8SID0i1ThoKHZCRhoW1j07m/+mmNpupN+T3fFAsfw9?=
 =?us-ascii?Q?/9HTdQlH9irFXhim9d7mWryb/SeBNwn3hvSkTeOOJ9SlSDtM3u3mT+Tis8Si?=
 =?us-ascii?Q?+NT8rhNT3Psk7OhrTOKiuaHpL0BosDB1mg9f+6r0xxFjQBq6Pf1quAZ2vVLE?=
 =?us-ascii?Q?4J0bCdHbqglbvA0RND1UNb69+nJGcVUeVEe0I6cK9O+e/gyp9IaK44XPVJ83?=
 =?us-ascii?Q?UkkH6UFhLuvEFl4ULJOrWU4qj8xetAtIPNHPg+khn7iGDdK6zqhSrazrbZpU?=
 =?us-ascii?Q?djk5acu4Iy7DTPxfDGRSgNdQh3y3AqLUP/820vG0Zan1pwyhack9cD937+gP?=
 =?us-ascii?Q?vzhUBJGYZwVU2XH9xryHLYBaRKLhpGN2KwWZp3zc4Tg2/bHb0lc5kZdcVOYV?=
 =?us-ascii?Q?2Cy5G+0muGhx53REjqZA+H0XNZrjGmEZRPKwPddLU7Hbh97swGTxwBo17OAf?=
 =?us-ascii?Q?u/MGeYcKyX6W0cbKD3zh7LrX0LjprD31muOiT2+kv/7Ck+hs+waiCSXhSA+S?=
 =?us-ascii?Q?3SfRk/lT3bJwiGGg+7Bt+BLZf+oYi2ey6KyoB+PS+sXwlCRZexcJ0Lj2df2I?=
 =?us-ascii?Q?x5Ak2sgEn3AwmClDroDG5CBT9G873LvAD4US++uxHRVEl65M0e8HmWPSlou2?=
 =?us-ascii?Q?KCvOKQ0zd4YHmlhyfELtU49qu4FhHcjuMrmyuSZrkguRohMessCVwPQCcMAZ?=
 =?us-ascii?Q?u0UOe2VIIqP8GzBygxEh8MoJ6e5/fKWudCXwNqoqt1WtBg6BaGWL8ynWBM9Z?=
 =?us-ascii?Q?qUYQFBaSeAZfzyeB2ulPIz0gpEW11PnKbPt1/fVADpcXVrNcEfuUmIfpK9Hn?=
 =?us-ascii?Q?sFtIyEQeA4H67J6ljG+Zq+KuCO4RWthUqcFx5dGivgT7Ap8xfPAUY+uqSzIr?=
 =?us-ascii?Q?IJCh+tGV0TXv1z1t8lrBLOYb2g0V3cZF4juNLrkqYvjmsvPnOb8dAog6sf2B?=
 =?us-ascii?Q?VvglPH2BBogXxUJiv1SfKiDrOvY+ujoWyvCxnN7LEo9VDya9EtyG63Y5gYyc?=
 =?us-ascii?Q?EFgGFwjXr4+ymogk/aw5Ja8dT+ZWN86Mg+S31j85EC9Lqu2FCGUaAfbIPVXM?=
 =?us-ascii?Q?nJR7N7lpvfAy5gJZN2Z2ls=3D?=
X-Microsoft-Antispam-Message-Info: glh1xPJsBF3jMCPHGMYdAPx7L8EOLAazmo4IaPpG60hL6ns+maqIi7OS91buSNY4s/KTPZZWURCbpyUjeiJWZ2AZ1ShQqMfyUkXmCM9pPt8i5kY/t2nhmVRX3R6X1yp28QIliDQLCj//8t9qzJHsvu0roGeKhSDzfVdb9RPMA+nntjCV2IyT8R2uSYnRDTvWkxStqDXan77+lMI5NiaXyDiBfSQFnRoOtqxAM/4aSiWPov7ayvASC+6zdOvSLqNmmXNP4Yo5cMREfHsa6X6vWk/51vt/PLS/bmZdl0D/Dxz5I9h2bRGPLRDabI8ENZwiufMm/0v7v4/jiCw79bA4llcmKFcSsfBBD9HeMmiN0Ys=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:9QSVrLy66oiAuKmgz8xyeUz5IpBd2q+3887MaBkQr9JZud28e0I9WFApsbzLvOdKFMXyMuwY556k6uFORXqV4fiLUN8vn9KyhWApcR4NJz+fTwTjYRffC6C1GL7O7KGdGiC60YamLN+LDG6aFZ5ezJp6HNvytqSJ28NPk8tuo4Zio8I7515aZm0vCVnZXueSM6AqFhX1rLoTwmgfFeBraKm3vE7zKwWr7s3Q5MRus+pFMGWThfgJT7LHaB3QD+gG5yK3OQqnJxlTz7X3jM8MDfYaZOxNd3gACkFMDZDswnFDUoywNFFfAFzYL8G6ERbdT+7o1yURxAcPqgbG1PelguTlh3oasLwdjT9sfSIzWj2CX/d5E+lJXwGHdRTkJ4ATQrWH0bgh31fpLYnB8i0eSM6aoquQT8gDjicXdZEOQ1WvStytS4Fn96TH0sn5iosjDQ0LYIflwmPPpIvwWWtbnw==;5:ADfJIbhkhC7rTPBqYl5VWwTK5sKR1kHrgdMnBNxMMb1NTpRWnrFF3kfPZ0rJJa8Z2if75WYW/WNsL9vEi0Rr7+Xk/9Ez7V+aNUe6PILF+0rL5ouyDSd8VfUsyT5HcBh1FhD9s4dUbmERiIGwENcr6MOBIHuMmTiLSu2hGCsRhMo=;7:mP3VVBSVradYM7j3mIKQFaUF9B40Ws2yvvgFyhXQNjERF86lzCEcqL70iqX1nlLkKVNMmmi9d5QcHB6G7TLzwsBIABmVjjOBr2j0iLaApvWtD1luOijvAbkWlw5YYcDWBNKJAN31qTol8cCAW4v6XHnFU8CTSNvpqCiM845N71hua3CqFz1YVYX4UkFEv39OyRA2pQ+f3N+t9fVMTsD7g7bnSLaMUzH3n52bzHfOaKMENbV45IqqT+unp6xUq4qJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:YBGk1jMScvgOvbXUdbGhaTJpA0vBfLE52K0SBmDN/2F5Rx83diaU4PRu6mGOk7ySoJgNIr8quKwJY/ILJwcSNUBZm0S3JerCX5J6SQShlbeVrCXwC1uydSXq5+ZFvfN//qOLIh1MmZCEOo2iOd4lslUa8Dh4LL6QcTwCv1z6VnE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:27:52.8695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0952631-e815-4d9d-e66e-08d5f8bece89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
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

