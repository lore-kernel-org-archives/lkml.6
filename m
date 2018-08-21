Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ED4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CEE2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DGg+vclb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Lgq7d7uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CEE2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeHVA6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:58:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50328 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbeHVA6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:58:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LLYGVf010571;
        Tue, 21 Aug 2018 14:36:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=AtNuxCAd7TECN28SamN4dQlQrOCShOwPTHfKehhUkiY=;
 b=DGg+vclb8Efw0NXz5xBuHbfrNiteeGUPQL7H8PG02tFFC5w/1by8xyc5mw2N7GhzJvVH
 LCe3Q4Q6cHDf/4ll3BlSd37urE/oJBQzSZHgg8UeCSCFmTnCurCcvLcGfHCLsB2g/gPw
 WUU0xDVFfxZJTLRFJBJZck5ZvSg+qnnH7J8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m0ssj05sg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 14:36:24 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 17:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtNuxCAd7TECN28SamN4dQlQrOCShOwPTHfKehhUkiY=;
 b=Lgq7d7uWgarELyI34TnUPnI2stRSMm4W9mKIh4PRGBJjiLf5hLuMGIgPc6Yer3kPKdDSLXc5ZI6f5KqFh3BKdWEcRbTaCHvPi21Hkj8Euu3i3qLNe1tWtVGBLa9xSadZMAYh+wCEGjIFCE97roxL3bJR9gF08WXNtdNKpTwHBq0=
Received: from tower.thefacebook.com (2620:10d:c090:200::7:b0bf) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Tue, 21 Aug
 2018 21:36:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 3/3] mm: don't miss the last page because of round-off error
Date:   Tue, 21 Aug 2018 14:35:59 -0700
Message-ID: <20180821213559.14694-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821213559.14694-1-guro@fb.com>
References: <20180821213559.14694-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:b0bf]
X-ClientProxiedBy: MWHPR1301CA0004.namprd13.prod.outlook.com
 (2603:10b6:301:29::17) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d642fca3-da94-4a09-ca7f-08d607ae2110
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:LIBr+b21RooN9jRroTXs615jOiIuFKiW+AnvWZcTWQk1CZM8WocHJde+ADyH39Mm7+bFfWZmo7gcY3VfEy6yacHVHLh0U3zmQNDOYvpHAmNC20TYufAFxo9rRAFxKSYsx5PShqRaIVOwOZ9Rkc1vzLuyyizFzH9IMJ/g9IH3B2okbITxvzeYeak22o4myQAObGjlRWss6CUubQNkXA+oNgRzFsFpGyHuUL/bDtCJctwOfpHWQaG2J9Svf8MRyWQy;25:XWtKi1pOzsSvDscwOwVf21Ar/6gs1YH6QC9s6Dc2PWr2n1tqS0czPmaGtmcGqlELgcFY7i95lEdrrghgY6L3JysrtVcKDUJu2Mpe/DJjGGMmLXeUSBVALAuAje08A0suCXaKmUPW+DNZWp6vDlulVn/sSOqfeA5Uww8kX1Tyav1zwTXouCc0yqq1nJt5C5AVkT5y5xmIlZmkBtdbZwx+Q7TgKAu9L46FIGTmJjm44mFCfw0sz8lYGYxr1KSkksP+wXvtklUucscgxvYoX64yT3CZST52dloDdmYeSx1JuVRyInSu/OGc+qigAXdJD9b8/foKmJYmQWtWT+NEIusBag==;31:ZVL8h2o8SHYz40lFhG6k7z29gRsezh9UhvaVA940Bhi7aE/VIFdicJf8JSHXB490f9uFdKccTrC6rPxs+g4fxryZrcvnNWytrO9h5NTw0KAxg+Q8rMOpTkhUBL4BBr6yW17grtx9H0s+2OoIRYaURHalYA1a4SW5NGETqkPHl37/fMp2xK0tSb42i663p+5BVT8EqsSEy8ak+E+SacGZZr+YAe6gUdbYDRje8l1L9p8=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:GOgscW/zu+6S9gsbsw+9Hy61JZ50qxlxt6bYSIWgSf94dxTUWx4tj1IX3I+xPRonC4P5441QR5ed8rea/Orq5ormLWU19+iZQlR0bRi9CQt48EfnuuSLJVsS8EKtAQgWJ+It+aTEEE7jyYcD+0qP88EE8LfSQU4kzN+nrZ5WNr2XQ+dl2dUtUNMSAyCDp3sfuLx0+q/K0zbKYh+AXVF2sIJd4QYyE/Py52Zn4eOPuU84nHvMkn3H6rjt9pKPwthhK3sPR2rGd4lJDgtw6RnqlBP9ZqtgVaeW4jzToXQv3w9Q34U/PicCykyqyOIp5x3YkS6XHRAVh6ddutvx571ZikgDBESRcMkcdK530U3yRmnpRaDujyLNICg/LG8hFLhbtuVnetNL+mql2/tILn4DBC/mfmcSwqZNB/Gb6IPUptTEfJTvtPawJcpgfOwtOWuXZqZpeGbdL2Cms2FEhEiduY2cDTZMP9n8t+pG11BY3w8bO0lbDg0Abne10nSkCKwH;4:EOjS/smeJd1k98sbq9ecI8oer0bxN4DadOT2HlQtXGoF14dKeDa+x8scsGC/BAhhug8uQWycw3nm96imIg6pgBwYO/iebaF6u48u2L6LJpGd3+Gjazl4dGIxt2R2YozfeYzQ5/zR7G/dexQQ/XhJ4aklRoCBdHDq6VHLHz2Gda3hJ/YScm34cKr89LjZs4iZuA07mZMdIAU+zfIxGHg9Gul8d3mjjlodhI7pmfbJFL3eMvpD/9/daNox8K+YzeZFsMS/eYALywaaF8zjNAoF0SllGk9TuZ5VNHnXttkqh8nUIOxM8c0UenuwOJgkKRgPlyadQCpez5Mh33px6K7OHuEbjOTi+E+CEvYTHjMHDSo=
X-Microsoft-Antispam-PRVS: <BY2PR15MB016688E51E52A893551AEA36BE310@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(53936002)(68736007)(39060400002)(50226002)(8936002)(25786009)(1076002)(2906002)(6116002)(4326008)(476003)(486006)(86362001)(16526019)(97736004)(6506007)(186003)(386003)(46003)(2361001)(478600001)(105586002)(48376002)(50466002)(54906003)(446003)(106356001)(6486002)(2351001)(2616005)(11346002)(6916009)(76176011)(52396003)(305945005)(6512007)(8676002)(53416004)(69596002)(36756003)(16586007)(81156014)(47776003)(81166006)(316002)(52116002)(5660300001)(6666003)(7736002)(51416003)(32033001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:y0hBRbMJzP+aNudL97O3T5kyvLzHJjmpSEXCS3DcZ?=
 =?us-ascii?Q?ALUZJgzhSCgQg9j1mA7BlGBEngDRouKde43EdX8k4oRLvCk3yY02i+4HrXwj?=
 =?us-ascii?Q?471NszSe/1X4hT2hkSMM+WdaHBG1zqYUi4uMsZLyNeeu2is7w/ZWMfQN8bCv?=
 =?us-ascii?Q?aLHJZSayEdxt5YwiEDNLUp4V5Ieg3xZqMKXJVQcpX8tz0zZYx9Yqct2QF5u/?=
 =?us-ascii?Q?GdtbSgQpKffccad+uZfC6omSv7rkreWBcfKdTE4tjgKBffR5x00PJXS5Wvhb?=
 =?us-ascii?Q?isSw89aVLdjdjqzovMXdE0Pu6QJ8jALtBHBDqlc0WEob87G7shprWHiJUFtM?=
 =?us-ascii?Q?A81Pg8VcDETtYps+uJNnu5G1bfGNrG5wqnxRCSKyvXyvsfat2YPYoRlfYfrM?=
 =?us-ascii?Q?FDjcUPYYdC0bWoEFs+e3YhQWIe/Es44B6bGy4/dlLaIK6U0vaj3IwaCwtGar?=
 =?us-ascii?Q?EbbmXh4qnOOISJcxDLtDN3NY8EXR+4q2/HO0pFviiqbNRWg+6KtkBxnILN9J?=
 =?us-ascii?Q?Udm7utGuhuANvM8Bur4Ppp9dBzyFlzUNjjq2doXyOi13tdCBAk6jfw2/g/ts?=
 =?us-ascii?Q?zozbLpf3rfDRabZ5Av49pI8v+c3e1M7h69P1SpxC7i2G8Md/s1IHwmavC1gi?=
 =?us-ascii?Q?bCN79nISe3Iy6WXZGnEem7O/PbCyjjuTt4AD0yPYAI5rih3tlqfifIvJ4K6C?=
 =?us-ascii?Q?b1fPYD/KmnGv+7y+ienOHlPFGc+bU+d+sRPvrt8I0jathsE0xwGxJ2cbobnh?=
 =?us-ascii?Q?mZ3j6bfxLm4r6d2uEvHJ2UtMPRkv8DuFiAQ4MNEC9Zb9Qj+MfSS54HYRd7vS?=
 =?us-ascii?Q?nQWfePP0/G09wOS//BgWbGkrPsTJIdscHGUFNhZSksQnRQQEVB+xVcQ5l9cK?=
 =?us-ascii?Q?PQctAwmK93kKFjes2lQQF9i4xjFxSTuaU6JHOkKsrVAVz86jrny9lfvMVPI8?=
 =?us-ascii?Q?AbwqgNzB325JWOyVQpjtv1dF13yw3OKWDQjnRwYJtVbTrJ2p1czC5nj8bEsu?=
 =?us-ascii?Q?usxru3OuboQWN5iJjRHAQBmi9Db/RF023H7Pw4rsrmVHOc1abQZ3wjnolJ9W?=
 =?us-ascii?Q?j7SrcKTefPg4U9ytMGwMzGj96rZ1fkIyE1vBDAueQG4sPKHrbIL1MKbT0dZS?=
 =?us-ascii?Q?m88rvzbrH/1DxygudM3sTDXESXofPFyCxkp0RIW+Drd9MeWMkrqpVCYElBfj?=
 =?us-ascii?Q?HDFOVXZ5iL5ZVL3TJIp5r1loJG7nPEufYIY6XRhIIJUYD+OxkwMlHZIsxCon?=
 =?us-ascii?Q?ST7iOSZ6KcEqk5E6f00ofIiKBPiD5588I/eqmf+hABEJXetN/az0G5jwmnHZ?=
 =?us-ascii?Q?HhiZYn+OCdCMSlIuH2D5uc=3D?=
X-Microsoft-Antispam-Message-Info: lLZoO6CUS+IvXEWqzE2a0QtnqRqrK/nGorfQ5fou4s26qViR96FmMqLF637os8uC19GKDDCkzy7MrHE+ngFIvTGFlOdT7XlErSBT1QDHWJSfjzAGPhg92GeGG6IAoUb6Z5NLGCx2qxFR+adnmsVbyRej6j5CAyj6riCE+YIo7bbpdd030e3n84umvSO1aXku90LKLpLVO90b6I6sqjXilxZv3LnzIwn/RLN/2W+NeS5aszqCuQZ5Oa3vY0BFKCexTZWUaB0qNzaTfw2sAk/PLNd7ZHczahZh8RMf229RcXV71flOhRauDRb/1w+R/VLwzcPWlzP//5Yddh3IkHGwsiyQnom9WcpX0PdlRt3EbKc=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:Pja/BRbYDsCuHlrh3yJ1itmlY4CoLbSganc4Cx7ckF5U0hlqoFG5PbP802ndAJmUmvAiirCrLXL9JpK3WGWN6zx01tcgy9mxYvdoDx+gmpZ8J5FkP/wBy1kSEbBmgdsAg73Q+LQ6aaBoxdA7aS9u3ziHF7qfRfHNPDlH863xm3nix4ohS6IZymJ/izp/u4tBjkPX3h8tBg0XryCJd+ggb9Ex4wv9hbJmR0lVhBY98Ab/zOs7y6vS8K1Zopcvb2S/YlAIU+mx333SE455BUvx4tKTOWYmiTR+rxw/Km0SnJPOPMAj4RFZtdrZpdOtA+be7y6PVMBUMkWxamDtScWk9XjcPhqOiMYZCukzmhHE64TCD7x7RpHc3d8eVj9SNtvsdd5avZTY56+UgdtHdhT7BQnT7OrZKbW7wV8iSS7v0lkck3AT5Yo3aNN0+un5dLRMCBYN4MVAVcWclMQieWYkZA==;5:/KAa5zBKS9g8U/2n0OB8vVd2y0iQnsZhzY6ooXa9HBafJJQOQUPRZue9SCzjJIFuYYhs06EB32EYuu989QHUvRIa3JB402RzNC3k74M4MF3RPFXO9U/sOEA9zspqqVFk5M06W8nLc+l5l77ms0L6LR3ulEO/0vFA2biSssEVu7M=;7:mrS+4dl9ehYoUU77B5pmLc3SbxSj6zHC72hcf8tGifsM9da6LMAW0kD1o7hbXXfVHHxvOOpkHTocnBRcAFquO9UssvFaO4KYBibDWY+1ciKGnPvAvkjmZQj8O+6oGPxz/pzMoD1kUd8IbLyXZmJI6ieDZFs/qF3BXyXMmthkSJHZ3UfzI3uh3jUYtqI4GEER+bgi+VfZU5VwqfenZKCmfxRZnCv5Sev9uv6qb/DA596IRR9LJHUunRhuvuemVTwx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:EWokAItNE4ut026bbDHsbyZ5DRk6mePeiyLx/68KdmyPckPmFrCGm6Gzk+un71kunFzR48SxJSU5hEkjyOPhVf164cPbhKuNJtMRIQfqRf6jAoidczWnNproN0ITuqlyn19+WvS44sd+bnLyFmOkYo2cH/Ryzs1/5vgLMUD31BQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 21:36:17.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d642fca3-da94-4a09-ca7f-08d607ae2110
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed, that dying memory cgroups are  often pinned
in memory by a single pagecache page. Even under moderate
memory pressure they sometimes stayed in such state
for a long time. That looked strange.

My investigation showed that the problem is caused by
applying the LRU pressure balancing math:

  scan = div64_u64(scan * fraction[lru], denominator),

where

  denominator = fraction[anon] + fraction[file] + 1.

Because fraction[lru] is always less than denominator,
if the initial scan size is 1, the result is always 0.

This means the last page is not scanned and has
no chances to be reclaimed.

Fix this by rounding up the result of the division.

In practice this change significantly improves the speed
of dying cgroups reclaim.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/math64.h | 2 ++
 mm/vmscan.c            | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 837f2f2d1d34..94af3d9c73e7 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -281,4 +281,6 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
+#define DIV64_U64_ROUND_UP(ll, d)	div64_u64((ll) + (d) - 1, (d))
+
 #endif /* _LINUX_MATH64_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4375b1e9bd56..2d78c5cff15e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2445,9 +2445,11 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			/*
 			 * Scan types proportional to swappiness and
 			 * their relative recent reclaim efficiency.
+			 * Make sure we don't miss the last page
+			 * because of a round-off error.
 			 */
-			scan = div64_u64(scan * fraction[file],
-					 denominator);
+			scan = DIV64_U64_ROUND_UP(scan * fraction[file],
+						  denominator);
 			break;
 		case SCAN_FILE:
 		case SCAN_ANON:
-- 
2.17.1

