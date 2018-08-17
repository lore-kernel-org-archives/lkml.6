Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90240C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26451208DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lLoJnYgE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c2Q5Ddgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26451208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeHRCZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 22:25:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725967AbeHRCZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 22:25:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w7HNJ2k3013162;
        Fri, 17 Aug 2018 16:19:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=JwnQ//iDGj/U4pEq62LtaL1J9jgb7d7UJC1X/cTmk2I=;
 b=lLoJnYgEaCYeWdLMapt+RLtkeeywFmPRn/ojvxlMX4sYkwViAyL2++Vl1wBAEBgbREKt
 cSCOg16ouvLhOcDSnRpUiBH2aRUcM0fGFVqo314HeM61ksIPFh65LvjWUxalRYaj1nj4
 kxTtKablojA3iLK5MCxlEa7ItPrzGmrAe10= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2kwxebskvk-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 17 Aug 2018 16:19:28 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 17 Aug 2018 16:19:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwnQ//iDGj/U4pEq62LtaL1J9jgb7d7UJC1X/cTmk2I=;
 b=c2Q5Ddgf9+DboW+u04cbtkfJCocZ/4jYvi0RhYTOvSdNTlYBNvGiFPN1yia/GQkN2quHx2PszyW0EhbDD4iJoEErhebkZjTqBPSo9PQGnShZ74Eo4USurQpd1hWBhNk6fEpRyJa/gkx7XtMfFo+AMb1NgBY693nREUJRt0S5XMA=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:6176) by
 BLUPR15MB0161.namprd15.prod.outlook.com (2a01:111:e400:5248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Fri, 17 Aug
 2018 23:19:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: [PATCH RFC] mm: don't miss the last page because of round-off error
Date:   Fri, 17 Aug 2018 16:18:34 -0700
Message-ID: <20180817231834.15959-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:6176]
X-ClientProxiedBy: MWHPR14CA0044.namprd14.prod.outlook.com
 (2603:10b6:300:12b::30) To BLUPR15MB0161.namprd15.prod.outlook.com
 (2a01:111:e400:5248::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab94a184-28fc-4220-00b0-08d60497d452
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0161;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;3:LOzCmJGOUUVeODJfwUHdeF9KDIWsSHwNjlMj9Xf60MOQB5htsU/RU6dnzdOa8rhh1S7avDpWQJkJUg+agHndCq5HsSU00eIh5QEvtD+3nhrqlo5a/gweHJAW395BSFRof+3NPhAilCAeWToTuoL+2GDTzJvIQqc+//ndnQstK8URmg9rJz/HgsumIvyJKT4QztshRvdmy4rpd37JMNocxrS3IswDmgjZ6nrGKoRRmDv4euMv+iidP/MpxORgfV9y;25:5PoMWE2QcB14pIoiCj803guytv5dintKMW4EZL+wRS6X6n6vYWS+6RMum17lCEoIFOfFuYcz7le9oMorzdxW8/A0FqltUsivq1XlfNwDL64TGB8PM/a5B6HM4jqhiikAiPqAbiepPFGrM9mLt2JEu2l4t8KTBIdcOV+wFM2ZXAMWwWsrtwaV2wieTEviZOHsWLm9QanxGXRDBRUYcSjm/Mh4Y3FMxSkz/FLJGHT9bMmqGyyVqfq8t4X0XiXyrFoles9N6lFdMs1CoIOu6HSRPAikNvnBL+pPftb/O3BaP1xOIjyUlCPpptozVX68fmHtj6AGxBJE67aOls6mDbJhWRh3dvOrsJS1fIKlFh8HDCo=;31:yrypMEVoiwiKomiM+wimHxiHJ/bWfZC7Wk6W5sA3DRZ1q/rh44gXOx4UIrsE/hsmCzd7LNIDr4fsrfqY+Y8z5vPPxunX+dvwUUJ7S+X9QEove+eT89xJh6mNwznk/Xqrp0FbgoubPMyMG9a9rKoVUtPKCjNFtUbAOhj4bplpjW4ZA+e6QfdOZAHgaCI75V+HA8tB9JcPZUpjLDWMNLVJ5Kk0BjOgxIx7KLlEprdx+nI=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0161:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:th/OhqQDrSm/PTu0nNvYd6tkbyoz34UCNU4Yp/9htHneZ9y5ozHqvVqkTwgc8q2kaoI5et0BorM+dfXKfysoFFyzzYQUS2KDNOLN1joT45mnoLDMld6KghVcA/TL4HFS/FIHazng1HAe5VIt82rQ9Dg112Z3GOISthCoMPWQl5CZoWl+qP/YHNEZHMS526iGV4qDu1DfEci3v/U3EcvL16J0QtqlQLzufAEsSRagIQP/o0gsVeb+EVrCVDyrByIHADQWXclI93AUCwjxuFtCilWA3OljRUITIg08gfPwyxFG6YJoxb3yKQeyv03QjUg3uMe0vfa9y8x1kUUlYZuebIjxR7z75iPIztWDTsyg37FOW8gt2SelD2uBLrPRSRvswvEuWzUgFrfNd+AuQXjCcoUhYcNn4b/SQNSX+DXSiTuuPKbZnuzuPQH93cG/Fk7c3ObMg+CTdPK3p/NCWeul9tyHPnl0Qi72/7bzsMSJIBaBVfbkf+Nai7ft5gE3IpO7;4:IPfyI/ROKB/ac7zE7rYU+ELowIVoMHRAR8djQdatpBDy3TqiEZtrxujGZuffOya/fFP6L6T5iI4DIJR3CyG3yakyUREGIjKVu9jCtAIOuRfF6dVNwbkTOMDE9JsrMozCLGeMZdvltgtHkmjKtmENOZZyTWYtdmLfw6odcsn6MsgA6dkRU4Ddkx9ZNgdINRixKOFX/rA9ODw2y2CZ/q5eHQKIKzswN/52QNuApdQmBtBVW2t241kH0PG3JySRHVHM/+C8Cy3oZk+FxmNharelICv+GddcuH2jmbmutG6b1Cz5Lw9TxphZqwgIvIb3r8J/6dSv1wGIzjgQVfqrvkfMxPx1iBn319Ymh98xOqYbac4=
X-Microsoft-Antispam-PRVS: <BLUPR15MB01619F8D4BDD7F30631AA2C9BE3D0@BLUPR15MB0161.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301068)(3002001)(93006095)(93001095)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BLUPR15MB0161;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0161;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(86362001)(39060400002)(6512007)(4326008)(53936002)(486006)(8936002)(2616005)(50226002)(81166006)(1076002)(81156014)(8676002)(478600001)(476003)(47776003)(386003)(6506007)(7736002)(25786009)(305945005)(69596002)(97736004)(2351001)(6666003)(316002)(2361001)(53416004)(16586007)(54906003)(6916009)(36756003)(48376002)(5660300001)(186003)(2906002)(16526019)(6116002)(51416003)(52116002)(52396003)(50466002)(46003)(106356001)(68736007)(6486002)(105586002)(32033001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0161;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0161;23:sRowkWS/SuvKD+yq4pgo4SoJ9qhkwA3+H1rHA0I5c?=
 =?us-ascii?Q?E7WAwDcAjs+qar7XfYBzY+gnKncX3u8lCMn5H1gvCsVDEvv5hmZPU6vLPAwy?=
 =?us-ascii?Q?Js9S/JpiRvhKvVIvBaAkl3hBbsSy+Qmd554KpkOv/J3gyv+oN32+ehBO3Wds?=
 =?us-ascii?Q?8qCASCPs49luH/Xg7DIw2Wj0q6mxE4xkJCspEzDh80VHhDfoU9fs9FbOKRE1?=
 =?us-ascii?Q?EPOV2NGcU7K5UI5OVrAhrr3VJYSTeDMqsT6bH5yJSq8BxwtgrXpY4JUhy7gG?=
 =?us-ascii?Q?/SZGsQYdiaUr0LsESmiUQKd1xJ25B4Nr1dxsREv7Md0xwn67G44zfSCfQ2Nj?=
 =?us-ascii?Q?Hl2k8pgP2W2ajhoqeYmxgquCpOIETc0nZ1w/GwRZVjdZdL8IqM6i6QL97qiv?=
 =?us-ascii?Q?iREDr3S44WoCwkDD/544Okkj/FIYUveZmTsvv92iZZIGS6bpSX8ou5FZskm1?=
 =?us-ascii?Q?w2gKX5B513HY+9erFluBq3fEUpYGFGyNrJNFrpf/uwh/P+xxghtNdKSpkNif?=
 =?us-ascii?Q?dok6cy8cwSt2On0KhNimVOyBiYd2g40Ls19w0GBgb6Jxq4bOpDIiveR89EZP?=
 =?us-ascii?Q?vZiumFcOFXOQjZXMAHxPUM+DGUd07v5mWtKvywM/vdeoO6zwJ4OvC3rgQCJf?=
 =?us-ascii?Q?VXzH2nz7XUOE4d309GQuLp7QTdfBQPqNlOchgpCqWKIln+i18SwjSpeqcNYu?=
 =?us-ascii?Q?7IAVpqFp+DaNtZwiCAAA/9KtUw3SlRhmsjfgIT8JJZKNYlogx4kW7AfKWBI1?=
 =?us-ascii?Q?3ILQkBigigcQpoJ+Q5skqBPtKOg7xcJlmSaYc1xUq5yQglA7H3V00lkfsNTH?=
 =?us-ascii?Q?IZYr6IsVNBxsRXods8MzGoO+/EaPEhRtqknZaNI7qr/Bu743RAUiuLC2pJyA?=
 =?us-ascii?Q?I6Xjn+7wf6ldrNXDLrYHigACFvkrrHLa2NEsl2Tff1Z3nDg7a96AN+ms+/Ft?=
 =?us-ascii?Q?6hZIjx59HXEBPe90i6SHlz9YcoAYle7uozlS8WZ5K1fC8yI7S7E6qprxDHle?=
 =?us-ascii?Q?XTXuuCsP3f3jppMnRMU29+CEDr0A7o98JwGKnmvrA4XYtl8TrQXN2gzo1itP?=
 =?us-ascii?Q?S+9pfjBx5EsoXokjEZ1ftvAx9SKggAzYSyIUoBid+DpjxA0vO0RDWSpMKr1N?=
 =?us-ascii?Q?cFG4mIXFnuEwwJ3QTv0OI8WfnIwy4xjIcfidDwI8JKgVdwyHdEi8uv+sOefS?=
 =?us-ascii?Q?r1sqUiqMBRQ2CCG2AnTAaPGlMdAGfyklU9JKxmNWzwkgYasRUJ3em009b9/P?=
 =?us-ascii?Q?K44IonyGW0urt7XOA+PjHsoL9dJstQBcXqJgMYG?=
X-Microsoft-Antispam-Message-Info: FRmPvDRLRSaMlhu33ulF1AUjEq5KNc90FsrrRyjCoPUcadhFTpkHkOr8NS3j1pcYk64xMgVWnRm2C8FjmaUR9uie8SZIdFNDmW1ePJtwfjxVaFf1XxKuvWr8YUcJB6e6pM94CYkwoBEgaXxRdzgZyi7p0asXQExq0wm8zsof5FFS3StszHFegjJbL8HPhNyEsDLIaWMz2M3sB9SB0zRbiSH27VX12DWCagRfZNHyXRjVER/3l53GPohas9y+y793kS02XXTt6ayLv2/HzLKoGVt1i1J6w8LQfhd4nH/LcEFOg89pvpnB7MfQd+wf2YvvQEGTH03kxER6LcqCHnubtB8FuE8GJPwybspxx8sTWS8=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;6:6QgByZFWe4S6beWLskbdX7qq4iHZzVpRxpQrdKNnNLJqZ/66LIeY2zZQkP4J8uOS2KfOVvjX/GMtqFYViK+szx6BCdMFDpB3tg4LPQlgsdFteSWI0037/fRcVqkb4TBjVCZ37IaVMhQLMPw66zKZ+1I+hYsjUX1X7uxMJBEiGk5NzOUW0nMlB7w2+zqDKimcpOec+pxh/XauzF4iq5hCgeiLH8wGKhbHQTbxORv5NPsx9UHUQuvo8MRsHxRz1hY5Zh8pcTJ5o8DjRzW+rPryfQNkDwNwkQvKI08kQXzNhoIoXQkPI2SWKdlmnomojsbHXkoZgO0qIVEdU+I5jYypiLqsKG4UvfQIovbp4yJ9Nry6kqq3P1UW8n3Aq+0mgOroXjJsHcEjc1CIvg1pag+/7jCuLWS/rf7PCpDgnQ4TjxSWeavyokIKx3/vc7z/FXaFbxG8eJjHxUjdVts/e7ywRA==;5:vOUNM2ulB0+pL6eSzpBAy6FqltV4Ns0IOI4Lx7cQPSII+X99PSXbqYmZW9fhgZv1j9FBrtuRAm/Bqcp55gBww6U6RPhB5CmEsMVFIZYUiGhWwqYX1GFt35IgJ58aRCFIQjE3Azr2KZm5vuJAR0nNOslwwIlytmi/KmZ46307cvU=;7:hrQjGZywCfNuudRdFv8BKLhd8nSIttGw+XYLS5ebCpdRBYXZwNodj5ReyO9WhGWPNzjHllpUbchCv2gL74Qdk8j0dt28msVthaqMV9dq/6rhU/Ewj0/MHDSMd5SUM9Hfxy6v+wCYQ3UVlBDb+D3UGcLiyb1bJmUR0hEjKaLkrhn9SuNHcsESfYjVsaEjP2smJcLGMms6XMLy+Gc3cJBVV1qMxvgm1EYNg8V32kYvvvL58b/Q5LNcvPOOPfAbqaXH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:+YI0IY45h0VOKbf46BVlr+o+42nBfB2ctAJUL8j1kZPvlcsTBR+a6VXQHncCt5MPTioamZPDhQtJKso/jcZwIN/WUlZwK/hVnBn1fBgqiQ5Vq1D+opiVJElZcF+NnDWiYtuvxXlAo8wn1lf3jlN1ulo2kvEeJ9T9FfrJq0v0tkA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 23:19:05.5959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab94a184-28fc-4220-00b0-08d60497d452
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_07:,,
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

Fix this by skipping the balancing logic if the initial
scan count is 1.

In practice this change significantly improves the speed
of dying cgroups reclaim.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
---
 mm/vmscan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f86f288..f85c5ec01886 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2287,9 +2287,12 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			/*
 			 * Scan types proportional to swappiness and
 			 * their relative recent reclaim efficiency.
+			 * Make sure we don't miss the last page
+			 * because of a round-off error.
 			 */
-			scan = div64_u64(scan * fraction[file],
-					 denominator);
+			if (scan > 1)
+				scan = div64_u64(scan * fraction[file],
+						 denominator);
 			break;
 		case SCAN_FILE:
 		case SCAN_ANON:
-- 
2.17.1

