Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD83C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A986924A34
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="D+ZLyxgi";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UTnwUp0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A986924A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934324AbeFWAGk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:06:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933839AbeFWAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:06:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5N001pe004025;
        Fri, 22 Jun 2018 17:06:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=xmEDg8Y/Fy2Hd9yMQzjXE153r55+tK42ZjNAlc8Vvjw=;
 b=D+ZLyxgiX+HIDBVvboVu52a80Yhrvg/wUcbVbGWxARqtagyn8qy9jUFB5JmDudYElTuP
 FwTs05hpc8KE0iEvs+b143B15wxrLYvEJ5NDeLcqP5IupBpCNDuMWCkdg8A7QZa1iMJ7
 AVo3x4hbWL0qJhrQhvQ/vs8Omr6Jf6/+5I4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2js8ww0aqg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 17:06:25 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 22 Jun 2018 17:06:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmEDg8Y/Fy2Hd9yMQzjXE153r55+tK42ZjNAlc8Vvjw=;
 b=UTnwUp0xp9/Y4HNA5a2bSudZFPHb95Lx0Jkc6X27B0si5FGRa7npXzBN2GFpYWL0Tpqbuw+SSrsRds1ydvCopM+s5+Ez445hHiB5Eomj8OpbLzY/rOldBlpJuYTOViAB10QNXXiZfmP8hy2LQa20LuZ/w3pOtijf54Fu79azvIo=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:d066) by
 BL2PR15MB1076.namprd15.prod.outlook.com (2603:10b6:201:17::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Sat, 23 Jun 2018 00:06:20 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <shakeelb@google.com>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 1/2] mm: revert mem_cgroup_put() introduction
Date:   Fri, 22 Jun 2018 17:05:59 -0700
Message-ID: <20180623000600.5818-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <CALvZod7G-ggYTpmdDsNeQRf4upYa34ccOerVmEkEkLOVFrBr2w@mail.gmail.com>
References: <CALvZod7G-ggYTpmdDsNeQRf4upYa34ccOerVmEkEkLOVFrBr2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:d066]
X-ClientProxiedBy: MWHPR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:301:14::31) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edc90738-591a-46a6-7e65-08d5d89d271c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:t7pfl7q7Tx6F/smcDoQntIziiOwW36G5b+q9QBl9ULrrcVU2NHADQyQJ6JAr/S6nrVjsCNK/5uyw6DD7WDPfB0tZpH4Bc0wpKvkvZSN8vO+r8HP4y6c7vMh9kw1RovdqrnyuS/8H7Cz21vmC8OY6G5M7XP699tuIaWjZYMDvwH7D9dZ4NOBMFRpP+oqVd44JRWzoN7MLBs42V84kNJ/YS+cULpF3PYueCS1ocQ36Tw3jke9gFY132wvOiXfFTIuP;25:sP5GjDr6RwuPd1un/MPDZFTyOgePLALe9yAI8gXZPQ3+6NOrzZY0xFF6yyt8mdUCXlzCJKBcfrcKpxjIJaBO+ShTrP++QbDrinc7dvdyJh83MhMjdEG8qXPr9ttyihYuJJ7S063f8ujK/yrbi/hKH6Nov+JG3JjBqgXFZEyjp81B7MOHUAu/kWuvVJ6jBYaR3TUpL4Z2v86wbpn8Zorvxsqqi568SK1BiPKrAikSj37fQCrjNxIDU5Av7TkfwIPSy6weH9eLxIe8m+EqKcONxWWu4/RnwUoQIUgDQcpecfvsHnTpxk7s2SovAB53QG1wBmbKtJ0BLBdNrtWmTRG48Q==;31:7jWHOPJ5biJkPXqQc2wAB5sg0zWDgQIQydx7jDVkXILPpPSFKviQuKivQHUltmvMhfIGw20iimx+CbVlnZ3KjBqSCNZC0yzpb0kDO8ibcURFcUxsO4Boqvalm2pq3L9SZPetKcME1BoFVHqhfgQP1bCH7S32BgB5Gy8bBaHYUbB8RMrtUW2F3muLWwUIHi/diGa4uUJFdMOVjSvBnHM7LborinD10RsU9aJL8Yk6Ddc=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:QN72JlLB6XvhPOqeCzwdV9jZdAYS+xT+Nt/nQJysixwnR1UEP8nFRq/b9bXp3o+RXqYyKQoUAeevFHYenCyon1DafB+KGQdLg88Z4aFrCr0wO3btVby2Q8ViTiNF1RBB9sZIhBH7T6AZ2ODj6FFf34U/TLTE/vEKmqlSKJtXbdOMtuDYjmytFy8w2OWis8sCsIldr67zC1oyNPS5XVgUAy9Ea7s2RSJEmJ1PwoG4VdmhP6asI7PkQt4oJTrcxBgfcMZ0FFj5ZZfmbGZZ6d9gD9rvyF1ZqXtPWSkBYMxvwh/aCRqXtfRlbG/8tYRaw/F0OWCHBMGW9zj6vAQqD7o0jj0BxCQQwSnA0VlJBMGBjNvbuH90CiCzpnM7GWfpEMKzJN4GYO9AxEEAoNaz/mYOwP9KZMCeQE7OHH8aXC+f3Tt20W09etqEMqo4CAN+wq1IFTXO6IOQV4RiRF7RzzRgS0CgQXDv9lkDYzAlKvWDP1L2+szmsbYEclcs3qoFRYoC;4:J7HMR3YiZgsJ7AQ8IN/u8CGobq1jvaIvBvOofXj5eB1xfzN4TfcHml6iMGmIEKDO7y7XeJW4+UhIgtCPWhiEOt+L643IV751bxqs3mv3OqLvVVguDE/RFLxAg/pV+K896TzqOkJH960PovPJ1VR0YTF3zv60J/KZsfs5kPpSz5mgJxidWXa8kJAXh4fDblpunQU6I5Bt2UXWRRGIL/AkdQFudlfWyepqPZDEJDxaLnGn4w2V5w4darHLrfLw1UZYy6SKqliU++0QZmlqoOdj2mbk4kS/Lu6phVG1A4XgqtH9TbLq2jeUAyJHRuNbRxaR
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076F39681352ED38A52F17EBE740@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(396003)(376002)(199004)(189003)(8676002)(50226002)(446003)(316002)(6486002)(86362001)(2361001)(76176011)(69596002)(81156014)(48376002)(11346002)(81166006)(8936002)(4326008)(186003)(53936002)(16526019)(47776003)(25786009)(50466002)(52116002)(106356001)(6506007)(16586007)(7736002)(51416003)(386003)(52396003)(2616005)(305945005)(6916009)(5660300001)(6116002)(2906002)(1076002)(105586002)(2351001)(6666003)(68736007)(53416004)(36756003)(476003)(486006)(46003)(97736004)(6512007)(478600001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:yed0pJCGSxdpOw1D/o6xCy2plN96etwNCvfLYr6HR?=
 =?us-ascii?Q?bJ5ilnBoA433yCHDJvtsU8y/Q06jnsWWZM0qb45ckAgneBF+X+qPsXzbxwF5?=
 =?us-ascii?Q?68wOJrSx6R462qI5eELsSDbSVxRJc3HQdZoKQkytKQDAAKCPSVJNCp3YZOUR?=
 =?us-ascii?Q?Ey+i1MroOi18iESrw8XxKxUUanxaMGBLbxURWr6m3VeaumLt5/Ayxs4ueV4o?=
 =?us-ascii?Q?2N5ZBF3NZKa7CMNuRMre/cm2wyf+r1m+3lfVerc+6Mv0KiZjP619EXm21zRT?=
 =?us-ascii?Q?mxhd6n9K5crSNce+JkL/oAZIXC0LnmPOJ6HCkIy10wMo1+yMSQV6BNwYgv8h?=
 =?us-ascii?Q?2mJFxxSWHdyMOuhbhl9DXGrrlpKVigFv2o4FcZJ8frsBkbqBmm7MYjiS8wib?=
 =?us-ascii?Q?k50G23BfXzFbnHglI/znBKpy6HOSNCkV61PMIdTsr4cp4aU5I88gnavellcq?=
 =?us-ascii?Q?tp1uM509eBvQHIOMOA9NLhfAT01zj60T3d9lNpqgEKGWiBLX2OIqWDX/x+i+?=
 =?us-ascii?Q?ypySVCN74gvIaSuOBqIDBA2a/0SgrNpP8qk+AXQeYvLO8NWyrKJdClC1JNCF?=
 =?us-ascii?Q?Um455jTTS3riAE7V67ASbO/DAxdQXGFkf/isj1LzA0Athr1+TqSv4zUbrn2Q?=
 =?us-ascii?Q?lTrkSY3q/VLrYJW8YAayBwhNavjxd0jVsRhPIgz54nhar/vohk1asHvf4H6j?=
 =?us-ascii?Q?6jwQyi211mleUpzSG/q2HkRTNoycN6TKAaAAnaj7W5XVP6UT9SRog2DuFC7X?=
 =?us-ascii?Q?6YtW3apbih7Qm5KnHY6IzFBP4JBhcCTD8nW2sRjqfuoWBW3+HO+lf9aYD2v3?=
 =?us-ascii?Q?gdlItUoWMseau/DWHZmzjlLSO0rZHM8UdwQt9wMSdK+GBD/H3yRn+nYn+dsT?=
 =?us-ascii?Q?cPxyIFLdFa6a6f7J2ExMJfwHXbNPtgeu3++/u7tpukHZQRwn5cA8BEolXYng?=
 =?us-ascii?Q?8m+RgE50QQ3i3FCY8+9/Xfv0NJ3xGLMEgVT6V1V5+UAfHgLxaZT/n+d9+gK1?=
 =?us-ascii?Q?cjnYd0e+2z3cj33aQLPY8U+mQRI2dKM0PDS2+JpFOCuBMe0HG5whoqX978Z4?=
 =?us-ascii?Q?183MQN0grj22y8jOdUElApbYjCsflhbiQ8hjk5FG8Ed9QowWyJIxO7kXwzk0?=
 =?us-ascii?Q?CuQtAdkn+hhWeBI2lv/YUPTa4kfK0/Dt2PV3UPGjV308jK/4mrk9fuxOTLGw?=
 =?us-ascii?Q?4lBOmYn7lXvXH5gstYuVnOLMr1UwAf5t2yHoV7vAf2T/MuJ5J3QjcU5VaedS?=
 =?us-ascii?Q?K9IbvGSdvAoDVA4840gAndHE0TaLZ9pk0YNrXt0?=
X-Microsoft-Antispam-Message-Info: ngB75O0rr6Q3e8vl74ah0EEE7vnX7exK3uRm4aCWwFXSc1ZlnoOnQ5msFZTey6nbjv3gr6fwpbO0B9GZjzu7B+PpHYgqaQ9xdxoKay50vHSAskETamhGxgBfjUVm2Wj21c+ppEDEuKiizDtSJc51tha+xXgPrPEbWbJRD/AtS4Atac2rp+53edty8Dg48Zt8Yumh+NQY5iEz5YGo6R6rAsXCL3oX0WYnOVXusoiQNuuWNrFh14h3MGaSRKGemDu54beHddPTzeQPR40fb+732PUoO/qoe0sO5BmtzNlNdGjjk7Dw/OazYETWXgpWQww4Pmd160vK7AcqzK+HJAd6VSrxCyuE97w5FYVuD+Zl+nw=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:TVqwRHzrSY1luMg9+Wk80oZkIX/5RXYhMwlMXJsUX7YjC24sJtACW378LWlKZ2kTso1AzStH+AopY5wKZrdvltLdfQzLom7YdiaEtFTt12+e0rv3+Tib895mV2zAtdB5ay+RnLKq8jTzCc8r4p9SvHtlAmThYWVmnZjnMmbh7lYbFJfhnHk4DRHMn+msIuIpKD3yQiEfwAPTtlqeCzlPDS/QFSt5LP4b5mkQHbk6bp+LwpxNUbih+k1osCiQLil9CpETXth5H6nCz/I34iqpgsfa1mXLiqbPNy+F8VePq96h+u6wdglEsyO33fUAud7BuBDNA9APpP123IR0LyHmwxjvKdC+PfoswD4/LmJQLsgaj7RjTegwBUUaMysUedgsweTQKuJZMDL7hXCc1HWrgN4pX9i2EvwcdQ526NNxJP7jyGHFE18RyvPDY5LsU0LWwS0VCgAUF7E6JkdWnDvRZg==;5:KaqqiYSHgOMgTkJUzZG02PF7WdwEM+265ZOygqjdMXuOpONtC0VczsOB6AHJ5dwZW0XOVEiJZ6OCdJe3yGpiYGnKxdQwgwsCusDzf7R401PzP5W+yuJ9jBFX89ueQDl+oYUrmxMwjjJ7QXZ9cpDRO2oxhIbaueKmOAEi2vUMm1g=;24:6nDU+5ZFecS3FT7Fe++aGYaksWHzXzvCXm2ma2zpQpDOKL4GduKi2/R7KzUhIbOwpDWuJ7LONnJqRSiyDow+0SRaaN69i+AxDGW37/c+AeM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;7:imbqzJxuTE9zSC2ArKdxXDAs9OGRl1Qx3d1Wza7+o9hw7qjOlp9tt3m4X+0oJlPE8L6ICFoDMyiVegr749yc9a4Ksp8qfek1HRo1rSjQgpBsn7PcswZq1BJ0wRK1ZKhbZCNPtlQvEtP4CGlnH6qjbd6CB1y4UCy2LJAuTNrXt9xovZjQ91wFJBq24fzlORnd/yoeFoErrIdl2SoxxDF2lcZrmqbxiTGpwln/RJdPfWb1iXhVk6K5f901yU64qiAk;20:p4LM6AgRO4YiTvv/BtoMwWJwSXkOc96jHc1UFhym8MOJPLpPuLrjhHCtnkRknpHmpgMScNtNpU/aqdByRd79SfChtIGcydzeVLvO5QNRvrRSpgJig60CC2agMss8rtyUQXr3ChrWhSPiT+HmFzM/xgA+RpM5N1xdp2V/woRi5Uo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2018 00:06:20.7467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc90738-591a-46a6-7e65-08d5d89d271c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should be folded into "mm, oom: cgroup-aware OOM killer".

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3607913032be..cf1c3555328f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -383,11 +383,6 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
-static inline void mem_cgroup_put(struct mem_cgroup *memcg)
-{
-	css_put(&memcg->css);
-}
-
 #define mem_cgroup_from_counter(counter, member)	\
 	container_of(counter, struct mem_cgroup, member)
 
@@ -857,10 +852,6 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
 	return true;
 }
 
-static inline void mem_cgroup_put(struct mem_cgroup *memcg)
-{
-}
-
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
-- 
2.14.4

