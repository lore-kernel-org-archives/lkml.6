Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9745C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6DC2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lfNFK/hT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FwjVR4Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6DC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeIEDOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:14:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52062 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbeIEDOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:14:50 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w84MlSA5005144;
        Tue, 4 Sep 2018 15:47:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ktMtlDp4+9he2eMHhMhkZU9POjaLOZkqUgYfvpDtsV8=;
 b=lfNFK/hT3Ii8mVQU58RRIBL1QSzIruZ/fXhO9r0jhmDC259lzM5uQVDtElXGfe+oZLA+
 6NGXMaAt92PsduVdQVr7Q6nDspdt/+HvPQncIH0ouHsEFBn+HAAPg2DMe5G38WnPZ2jW
 2NNhujJVVyp//7qIENbmM5BFCsO58JarByE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ma1p7r909-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Sep 2018 15:47:29 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 4 Sep 2018 18:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktMtlDp4+9he2eMHhMhkZU9POjaLOZkqUgYfvpDtsV8=;
 b=FwjVR4Tf/LlXuvlA9CvIu+kU4AxZhFTUFmccQVfit1dJKup38TpYpX+7SgmMbx225HDh/8qXI5/wD3ZJejJGnvYK5zJx1GmIfA9Jch6ZNOkOCdcWNsC5zUCnfbVMfRRQ1jfJnIgObi+1AO/IU2kudu0hm2/oOfun0v0A9FmO6L8=
Received: from tower.thefacebook.com (2620:10d:c090:200::6:bb1b) by
 SN1PR15MB0173.namprd15.prod.outlook.com (2a01:111:e400:58cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 4 Sep
 2018 22:47:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm: slowly shrink slabs with a relatively small number of objects
Date:   Tue, 4 Sep 2018 15:47:07 -0700
Message-ID: <20180904224707.10356-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:bb1b]
X-ClientProxiedBy: MWHPR1301CA0001.namprd13.prod.outlook.com
 (2603:10b6:301:29::14) To SN1PR15MB0173.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead529ae-d9a0-4c20-965e-08d612b86210
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0173;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0173;3:1dfnj9cAQAbkfBY25XEg5WdHw8bBGO9kYLemeA5P2RRfXHx4bH9YdOsnnONZnyRC8ZVNEridd85nzPuC9BZXswkJf2N7fBZ1f5pjmb54pwDkANFbhr44lxtUPUi7O3f/so1YOlEK4LkI1ooKGKTuLjNIqiQItcId6Z53B8XXlPt7LVL5rjvwvuXUyWk+TKj8eX2ydT36ESuyv/9o/PvenyXVbN6GAAXOlSNgaXB3IsRxlwrgIKFfKuvSOjJJroHb;25:tDeWY3Wr0+GnoYeAqfnJLAcGtWvVjdPBBgSHjY88EDn04Dq8Hrt2islLtwyVkqxwp195gNi4oEwU1JprJvG6DdsIZLIihjshCI49oUgC7+jiy7O2TYVuZ47HGBUB6zHS3qMS5sKSNSHv3fqoBLhypC5t9xWbBwo20x5AyKip1k7qLc/baO/NFPnRn5XUyhs3Fy2HkfQAajfFlQDaUsT3/FddBhQNoOKcKOiwnXAgSokZqoQCFate9x20d5h3daUYu8zCmbbqGeaJSv89102GEwrrwezNns1afhtYsYL9HTEmm83F851PrZWxf2Ms5doI1sklMlyGcJbU3IfQ0PqnrA==;31:p5lROtsdlqA+zkKIj72R2DVmZIQUtRpu8SvkTf8dqwy3g+/O80vNGmG/4xErxl05bs89mydxW5tjmDaJi+eoNQRqH5IvsNEJE5/k48XOSCDMec7UL65+9Z+gE4er7OOLgDQ6Cta6g2K9j738Zw9i7YrMv72sQotB5qktZ3RvbDjedpbXr1TFstAWjcO0ga6CV8wp9qI7iB2ZH21x7xNvZqCyoLlxdSMOiNkUxoac3ao=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0173:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0173;20:MjIPSpzs7Y87VXUAdKZKOSHgvKEnUWDa8AzMyeakslMcY2EpJK1O4KdlzqFagljqxS9dEAVbeZSmdfi4w5MgA9Y3UflgT8J7S1GlPc+H3NOkrHL/jJLNjFNDaqbjU3dSMZRL0tKVnFFRS5y/iKA0WeD+u5Aizp4eLlgJMs3/ImZVi4hoKvYP6jMBvNPmVl5ihulRhEhpb8GumjEaa7dkwoXJGtCsGg2ErPo1tyG9tkFgNfAth/2B3xJh3Rl7BxTRZ/5WrgPePYSWG8zRMLcWPtzRTOpXNCJNt4TPgUIJN4eG/VgYA4TtrtVO1SrPB4c0weaXk5iCz6GPXpJZSAkQiWqug9kLkmlBPCS7F1rlkoNmGr7r1u87vyvAz9/tI6ja7HQ74d14sUE4CzfkqOhPziN0pzAG0W16lMYC3X53zs0MPKwqipxjHNXwOBlp4JC1f+yhiuWAfWyBanWsIDNd//TndINBPeLh/FJB2bZ+bx6rGbIfPHvKBuszpmlgn0yv;4:/+txh7JFofCYsCj9N/Jkru5wwBnp+F1yLqr2GUdZYFdWUfqqe7X5wvJtY0rO83HhN4PUXYPUoRIsKit37qEuZA5ma1JiVOL/O14GmPdrqXRkiVrbU7lP3dRQG1xq6oiDJBaEygkkt6NLIBAMzwf9Fy3RxwQs1+ds7PDnBBpkVV4ZEvqJcpopB6G+B0nejgeABouoqbVe022P3Tkgt7ESyvqa6BEk6G17o7deWP8S/O0jSyHe2Sbgsf+SAEwi21z9JFiBcnftgM3pvxnFj2C1BUY8pLArUyjoQwRW4f6/iOUseDXUxamcJyGqiY+3t03i
X-Microsoft-Antispam-PRVS: <SN1PR15MB01738B28B9586EAFFB89624EBE030@SN1PR15MB0173.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:SN1PR15MB0173;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0173;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(47776003)(4326008)(54906003)(6666003)(6116002)(6916009)(52396003)(69596002)(1076002)(51416003)(52116002)(5660300001)(16586007)(36756003)(7736002)(97736004)(305945005)(8676002)(81156014)(81166006)(316002)(6486002)(50466002)(25786009)(46003)(105586002)(6512007)(53936002)(53416004)(2361001)(106356001)(476003)(48376002)(186003)(478600001)(50226002)(8936002)(68736007)(2616005)(2351001)(86362001)(16526019)(386003)(6506007)(486006)(2906002)(6346003)(14444005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0173;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0173;23:3vUXrR4KA1w/JTYOTVPQHP8PQEUDLgV+vqqK8F1Bg?=
 =?us-ascii?Q?Pa7ZF/2XHUUkLPdhzt4qW/Mzw7Af1HTobOWciakulXXbi1kM2pmA7ZzhCPK8?=
 =?us-ascii?Q?2AhvOqv+02hY42sVio3Vv3Sdqsx2pDsM86J3EJT/eTEAaDyiZR3ALFnbuLge?=
 =?us-ascii?Q?DeKj4Mj8WfDSC8Wi86Y2i9GL8gedvGT0ZpovLJTz3b6E3nIydmcueMLLUgLp?=
 =?us-ascii?Q?KZXyJrFxfJsHFYHbGQdUbw9FlfQuulOaFOYF0j8XesCdl1GSSncNG8yWt5Ip?=
 =?us-ascii?Q?QpY8h17Sv/BNGQj/GrnEEHpCljaVDB1hrDttJqUtTiaZxn3//7aqYLOfiJOl?=
 =?us-ascii?Q?6ET3toQt216LfN71pHHNLWwjSm5De7c9gAfdHERRNdAPaJYwR/fCK4ZIGrXr?=
 =?us-ascii?Q?SuWcvpZ43+vo/qoxVbaWJ74Rtsa9c0vtVZmv+9fuJ1cpQTcyPB1a5z/U+Cnx?=
 =?us-ascii?Q?My7wGcfd3Lq6kuxpdDe7RWjThIuldOVLCAR6fjo5ehvaxxMuFIF+CdKm7mgZ?=
 =?us-ascii?Q?fAR46mVlzalotTFl5oI5zonCAO/61j7Z2yNGFvgNpmF7nxaJCLIXcu3eMeCT?=
 =?us-ascii?Q?eUIEB65XQLqzA20HY/Bw0I4uDTxEoBON08k2sYyuFuL5YXDmj7WmC/JHT0LQ?=
 =?us-ascii?Q?Cq5SsZoM2SKPNIHPsDVc04HtggDn4gMxjAmtjj8Mq6idKtRD1UtWsNZbMCcE?=
 =?us-ascii?Q?X20aS29ecDEODHIiqLpDDjA8GimQotHnT395eLq27lIbhkaV6tTv4KfTZkhg?=
 =?us-ascii?Q?O2vfQ+6zKXT+EZvC5GuB8t5LW45Uj282iyakhXQCLaJa9AA/ujLmkbo9NRwN?=
 =?us-ascii?Q?owaittrA3CZbOJ/72U5P3li5YccVG9gVQeVQ/RU+NvlVy2h77KShwCklWCuX?=
 =?us-ascii?Q?qfcwqtUtugTNesOA4zJmJAiWZ1gklyBFqv4ZcdVn3AYXzYEA8tz2lkcPvhsC?=
 =?us-ascii?Q?dqEn6v18qQgHypgctXjMJz6g0j7uMm5yCvQVDlSacxv4ciQU0FSdEOpiC5Kv?=
 =?us-ascii?Q?Ah32eeeEORnIlTiIuADaUoSRGXT4IdFqRb+MSFnUoVN+YR1qhqZ8G0bSmbR+?=
 =?us-ascii?Q?2QSb/CKcmkCbtiPUU3MYAZjhDmg9DZtNXJwYf47hTOT6G5ibYphWmhifZc5z?=
 =?us-ascii?Q?SNh/MJqquKvXfUK4KQnyWJos4iAb6cmX0ZbEArFxz8powLloA1Ew4MXBWtVk?=
 =?us-ascii?Q?t3+tJSgffOauiV6amVHUIzYR7eXYbtLMaY+Pq85oJQig3mkmbpLaIWB6RNZL?=
 =?us-ascii?Q?TGT8u7jsJep53vmSuM=3D?=
X-Microsoft-Antispam-Message-Info: QGka7lq5ObTfygXlsmOIn+u0RRjfjLvFnztY/my/dUEB6vKVTcGhDRObs3PHSsuAabzWfm7X2Yg0twED28GkV3GNN3DvHZQqhoF7vIEO+rmlOwimjPDNF7dzmshVE5I2UqdrbEMZ5X4pdDfEJkyLM+P+xMAm2OEMVq+NEa3ELdtxj+LGLvLBQKVlp1kYpa02oxgRbhCcHvydcF+vaZggzlz1lFFEMDz2yXXmUCAp5juj2RUWaFPbEU0DcO3KrkoLwok9+71Y3CYqlk/eKxm68kRS0F9SOQ0YYi48VRQRvWvvKSWWz63+271FSO1lZsHVuzhEeVsP7/VX4fU5ph64HEp2OFAN7aPS2eNuRzplP9U=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0173;6:UTLH0LsXM2B4jrEmK3kKGkcLU6v+a/S2bwTwckcBTAVrY/XoN+GtoW58hiCgI8DWR3ILnEIcB0UwaOZwxlf8DeYgbKPRBYZnnbYf7vXZcPa/kh00sJM3gb0H3qJvfC3saBHlkti3suttFjgSZyKX3YyhR2Wtd4Bhy5u3GqwaatblCTmcq9Rd256Igv7Rz7g6uz6VoRAskIczmYWrstbIuOuWIVV+JH7DB5LAtk+w/DK7vHLlPlxr4AJDoxVCTG2EvCAPnM76WRkZCSTMk4kwbxMiHZpWlPKE8fbzWI/9fO9AlCAAQ9aiDK/3mNijFuQsu09oLLPuszg3vA6TIWfpvkgnXRyT/xxK1vJ6HN3/v0jabtoXMFSGl0tFvNzfrhADOE+JRdF9SLmNrxhU4eoN6wRVzizT7Rtvxhq5PE7f7VJpsOFEm6ZjU6nddlIY7U1KuParcWNrNl3dmpZ2/VqrAg==;5:Y6J66gU6TL54FTPcYPcZ8f+gUGZBaHk1/sxgIrJ5dwBePamWvjacnOOPCyUYrhGm7LXCzi3cntrBEsk6KOhTwBmWWUAPvgp7RShRFEvPtMDAs8L+OJZAJQYL2XF4wCWyWGwHyOBLwoanON2is1GprkzgCjVMwfV/T//X7oIDP+w=;7:W3Ba30L0O/iNGG1nJ/+CCJ3rDUKXv7EmuvQ2TRisqPhxUCx/wZoR42EZwWY3Tn05XqttTZly9lHuEaqsXRgZoNLPDeI3TCeKeFoRlli0SMnyXyclV22nc250nZYsvTcPOxqS8ZCxu8t9xMwErKmbNxpN+BXWuQWiYSMmw+qYvataZET4xcVGOaaUs4yYGsJsuCbg4bo/J5qnGId/By03rNJvcdMISWIpe2iuBWYervAW0ZfwakB+kAAuUOuLVcoR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0173;20:vaNZxijh8LuM4qMzJFx2amBPtH6HyFGO/sCQHBoE3Uo2B9S5Afip9Y4HLgwuG5le/r9yqgsvNwy1vjPjKAnNulm5TN9wYlIy1F9cX/hNBFPl5mJQT3OFxTHFbR3e/aXmGrQ+yQbPQ+0xyUY1ywCNMaZLukNcEJTIbzsa6Ujpbg0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 22:47:24.0293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead529ae-d9a0-4c20-965e-08d612b86210
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0173
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
changed the way how the target slab pressure is calculated and
made it priority-based:

    delta = freeable >> priority;
    delta *= 4;
    do_div(delta, shrinker->seeks);

The problem is that on a default priority (which is 12) no pressure
is applied at all, if the number of potentially reclaimable objects
is less than 4096 (1<<12).

This causes the last objects on slab caches of no longer used cgroups
to never get reclaimed, resulting in dead cgroups staying around forever.

Slab LRU lists are reparented on memcg offlining, but corresponding
objects are still holding a reference to the dying cgroup.
If we don't scan them at all, the dying cgroup can't go away.
Most likely, the parent cgroup hasn't any directly associated objects,
only remaining objects from dying children cgroups. So it can easily
hold a reference to hundreds of dying cgroups.

If there are no big spikes in memory pressure, and new memory cgroups
are created and destroyed periodically, this causes the number of
dying cgroups grow steadily, causing a slow-ish and hard-to-detect
memory "leak". It's not a real leak, as the memory can be eventually
reclaimed, but it could not happen in a real life at all. I've seen
hosts with a steadily climbing number of dying cgroups, which doesn't
show any signs of a decline in months, despite the host is loaded
with a production workload.

It is an obvious waste of memory, and to prevent it, let's apply
a minimal pressure even on small shrinker lists. E.g. if there are
freeable objects, let's scan at least min(freeable, scan_batch)
objects.

This fix significantly improves a chance of a dying cgroup to be
reclaimed, and together with some previous patches stops the steady
growth of the dying cgroups number on some of our hosts.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fa2c150ab7b9..8544f4c5cd4f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -476,6 +476,17 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	delta = freeable >> priority;
 	delta *= 4;
 	do_div(delta, shrinker->seeks);
+
+	/*
+	 * Make sure we apply some minimal pressure even on
+	 * small cgroups. This is necessary because some of
+	 * belonging objects can hold a reference to a dying
+	 * child cgroup. If we don't scan them, the dying
+	 * cgroup can't go away unless the memory pressure
+	 * (and the scanning priority) raise significantly.
+	 */
+	delta = max(delta, min(freeable, batch_size));
+
 	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",
-- 
2.17.1

