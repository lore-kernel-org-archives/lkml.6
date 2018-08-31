Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C23C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570B020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GRYuzrFq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NaKJtpDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570B020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIAAo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:44:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727245AbeIAAo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:44:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VKLfFX027542;
        Fri, 31 Aug 2018 13:35:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=0blCr1ii/BVavaAvJV4Yrg734i8h8nbutQIIPDVXq6w=;
 b=GRYuzrFqt1BNh8+whNRfSwh59yoolTOrkEdCRQKtqhQI1VSRnJ+5V1Aw0LC4yelFGfHq
 UfgdAZhj7vWk1LlveWED0AZJoEI5oH90RzbUw4TIpq5GkwnDEkO+dc1/zEEQZ6wP0htS
 vHePei+ctRLvpVBe9s/tj7TujzxFGrU9K7o= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2m7b1w0bjx-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 31 Aug 2018 13:35:10 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 31 Aug 2018 13:35:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0blCr1ii/BVavaAvJV4Yrg734i8h8nbutQIIPDVXq6w=;
 b=NaKJtpDe7A8DiOrZCkFH6t+oWhcmjfongFm54ESq4prnwVjLZAyNYRLqqVjqPg5OSe9O+xbpWGgtll6rqW4S7Ur4R9VF67Yt80o/D/zzRzYo2IzBy9QGtvKSuF3JpAJ4HUK+ijuKy2/IGYvXEygftyNgHlgaG5nP4T8IPctGbKI=
Received: from tower.thefacebook.com (2620:10d:c090:200::7:2c8b) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 20:35:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: slowly shrink slabs with a relatively small number of objects
Date:   Fri, 31 Aug 2018 13:34:50 -0700
Message-ID: <20180831203450.2536-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:2c8b]
X-ClientProxiedBy: MWHPR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:300:ad::27) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a89e06-edc5-4582-f4aa-08d60f813d37
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:PBQlfuQyELZ6oM/lZqXvwtbcMgSkMxPxaaHx3OgjI9AsJS5V9Dst8XGXsHlgR1LFVZt7L3lgmjzYoJmrmgQxX0nRLNhZpRi1sWRdTxGIkSyab+o9gUgJ73o0PiRw5DNUMh0He7YTYQ+37jMckHwlAGUx/EaVKHYcEXxZfj1y3b7RfKeNcXOzv4VRoaYxVK7YGwqLBpl1Bet3Ds7sW4lPi6WHcYTsoiqv9L61ZDm3VrUEyAAJfp3BTu/fNoK1JNUT;25:9O58YtpVj757YqCKjo2s0LkE48TWznxx3z/brG59y8HIAIkt0yGcg9p6Mq8RFUWk51Gtn+ovo0wyc1PqIXIoY7tVzI4cAkjYekxI+//r3OGbAfylxofHUKHejCC1fzNB9VR9GlVhxxwkG/eSsrMSLPu0t43Zyakw52S8d9XrDHZbRBz1ek4c8f767a7kl0zfNkljwzXc55WFuqdzwex9VMsAExj5vOk/UW/dOZrGWhrcBflRqSg6rMdnAtZBUKcIxKHh73xnSfLboFuWgKBh+v+JQxzfK0O3GNB5ErJC4xMcbJcaLRHtMj3KbZYbh/I4VfpBIwn7Liz9JROEJSznIQ==;31:aI7A8Zn99d5gFc3+miniq/WL5uS86peoATkyj3A0G6J5h2hSyUMGL6dMXtA7FWcEVp1EqVKYQ/PVJ0IjwjviMGXdI51WWstCs1V7qxRS+Io1G3+NfIvv4jyJbkJ4UG84OEqKM4QRCBB4y+mDdUVjXH+uy+EG/AhrimGvTxf15zYhQ7axtewuiugahDfHq1YCwZuT+Xqnx59GPk8um2XetLwKhmvpiKNFMJKPi+zBAmA=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:Q5UvnujvXagrHzQaFndK6UdRITC1MTz4Vzr4xRuT2zoNAFmGzzYk843ypkK++ovIZIl3tafUJminoYV9QOoSa5zeEFi+IHP1hRTvEhqhadYAKzD7LOOZlUAt5NlzCP6h6rLNEcvyZjsYV7ICyb00KpON6r5ObeIdQhY5REMFgxB/nZBWjx2sbxQdjktebH4EeAWFGdDWSefOsY5HHcUkoC1VkRX4kohsftrWKUfxEYgJ3JtCRZyPN1ozHTFOcPYS2K6HVYUFZNzCtI2kE0QXVs8bIEmDm/a8pwDGm2+g6/3FJDCOSFJlVpril5CaixC952BQeZ0UKKxl3cXUJe3B84kPXezN3hjHqjmzHaQKBiddZO1h0o4gr301s3aANJpSYnc8muWHf9Qz7vvzYmC85kWk3qhmncJidhq/CmB3s7orAHNTJuURGhPFksR1ZEucxyQPPlKRVF3wlMP+uXIDRpjzjlPTa23vVJJ46EZClLN4AmGXTFoFCmlxxR6ymXBj;4:sUH5AUrYnTtE9IBVIT3pOdE8avRLDxfrtld/Et8JAXn8AqJPhWvkilfAn+1UIKXsyJNOaYaLy3lyIlIdXHt1mjiBt+7uuBhnm/tYO6o2eHg/tZ8bDjrfITn2z6IocJDpCQW6HSo7yJzrriAGeEx4m9HdEkbnV93G/HImSsH24JgwaoXUJqrK0cswnLPDr+s2HRGqWuPtWtcChfHfVCdol8vUxI4/8gwJ5/zNFZT9Z10OKtkVAx6FbLVjMOi8umbOiNmVmCxRiwynYJmmYItmcOBpFi6YQOewE0bUky/IqWUN6xFE3WSizL1Y41kmOZK8
X-Microsoft-Antispam-PRVS: <SN1PR15MB01762101B527873CE720051EBE0F0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(476003)(46003)(2616005)(16526019)(5660300001)(6916009)(6666003)(69596002)(316002)(54906003)(1857600001)(6506007)(486006)(47776003)(52396003)(16586007)(14444005)(51416003)(52116002)(386003)(186003)(86362001)(7736002)(2351001)(106356001)(2361001)(53936002)(105586002)(305945005)(6486002)(53416004)(2906002)(8936002)(6512007)(8676002)(68736007)(4326008)(50226002)(1076002)(97736004)(6116002)(478600001)(36756003)(25786009)(50466002)(48376002)(81166006)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:788Dqy/2QgGDi0HCeOpxz4oj1t4JG3XfStwcFIlPJ?=
 =?us-ascii?Q?ivlj8f/99AADj+PuJR1g7rBT4tpJWDGIKBt58sbL9W1RuRdBN3RXR9UV3++f?=
 =?us-ascii?Q?tjsNFmBvCJBZqW5DnS0Ab84VfeWEGzJLSKwX6mD6Yr6/UhnMWqROwvMwVpNw?=
 =?us-ascii?Q?WjPH4GchmBZZS2mRgyNbO8jTKhdTCurw1b8exLn2EKDth5kQr5OmP4BdjRkm?=
 =?us-ascii?Q?BbwJaW4NPHxhQJDu+hXYF+RLyOg0fbPCobq51mpEFXdq5xe4XLZP4ptMCPQ8?=
 =?us-ascii?Q?plVt3dqCHTvZitK+g/oOVjbGxWUkj7q0ukIqzfMu1G43Fwjc/B62sxSFWYri?=
 =?us-ascii?Q?Bkw8arlWQIY+olQaolJwUmXiTL6m5jRTaPyJ7/0WvjLUgYjSeb5i6H5jiXif?=
 =?us-ascii?Q?Z630maZMypJzpQIcYhbaePI6g+PTemg9qakv1BRiT0KKsxy8+GXqxH6KLY2W?=
 =?us-ascii?Q?O2fgqG+pmvuu2UNKlExK3V/f2HHlWb2ZrYUZ29wR6h5H5LvaVxhtIyJPYqYk?=
 =?us-ascii?Q?nNqr3YwTKngLl0lj6h2nvVa6j047mR0ghTEk9CYyJjyN9yUhif7oZe593r5d?=
 =?us-ascii?Q?vG+eOV27IxoMINkz3cCeG//Gu3JkNFWbVgZqbswtnbukeug+YVIftQte9LDj?=
 =?us-ascii?Q?dWA5+lExgtIY3XdJhP63wtFRmfsGbRO40vTs1fMtiE/3Y8rhRdlO9tEcxJgl?=
 =?us-ascii?Q?WeJiUW0BvDNIFv3Zj0jn+jUReMWuKeqDmZMmCbPhJRxqyBOggb0J+nhuqbO1?=
 =?us-ascii?Q?6r81+Gv4lNwV1ZKAZXFLV57Ev5ralHKxqeMtdnjtLwj91x3oyJV+eF9WErFK?=
 =?us-ascii?Q?4oel4B9I8GYHN8yqNPvzmsDSCXXxMnYgrCzDOqX0PPrq7lRNw2vaZ3nh+IBe?=
 =?us-ascii?Q?cUirDzZ4uAVmygQg90k6ukpRNxL9JsgthVHCxSlbV7LEF6VuXVYzKoZ+LXzx?=
 =?us-ascii?Q?bb98lgcpOmkVL3qdkNcrh+UsnVYApb+jF33GTgY4G5CYhd5Xk6ScRbdsiO8G?=
 =?us-ascii?Q?dWlko0wGBNaLCv+nkx93zJIeVwPB/nsE7GHlziXkQ4THMDo4CEvhsmUdZe9B?=
 =?us-ascii?Q?/bspZxBw6tt6grgxRMpa2PRr5uZM3/BCjHsxfsXfa0ZRxe0ubVrkWVbDg+PQ?=
 =?us-ascii?Q?76wD2fBLVBXGtV5/epmrzRzGT4A7NsQRp0mkAKZnwVzSQcJOHEIgsLQ/Gmao?=
 =?us-ascii?Q?GNmCT6O3+zhQTGAI7JtGdUlXUvfQ8qbKeenWR834xa2TvrZMlCLsYKyztah+?=
 =?us-ascii?Q?A/1wXUIalOJfVhTPqOqY2rUYalT8QB67eRF2Krs?=
X-Microsoft-Antispam-Message-Info: h6YHXwjo9bvpZIyPX3NotnOC5ChOSDeBn7AdtIeKAA31RQSfgHEIqeEazRo/sbRiIxXMPRoB20/qemsA1r8mA8ofK42atyL1J2wUt05UObMsI8Zy3Vz2MDofyuSa3TsQRevxuju8+0wP84NIn/WKdIIxM4I9dBjRgOUFBNcDuMv+kDkRqATupaWSjVaLi6k8e9qmavcr/2ve0+eRzPt6QvZERvbqGssmj/AS1QYzH5qa5xdF3Gwv5Lpc0lwxFvZqXkMVqb/GvA3NwxMtQ9Nc5TUru9rBB0pYg3rBjHkTLhkZNWSBOcoP7SSuU7V1VnhOPudHpy+lboYTYpMq3QHTsNqYpbhv05ObJrm40v/gg6Q=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:REK6mDtAY8eZ+UaEt/vfkorw9MvPkzxRo11M777a45YnDzu0T7GC90drEXLqp0tRgksWyxwtQPHZ3YDXGCDC6Mr40kOQ7rqBvDVctEj2PYAEGt1RSKXrJxiIi3kOUELH2uw4lSBOiraEHvgeHGjRJ0gR8Kjkg1UzSKxF3EzCWyO/cAv/kjFkuMZw+1OKLFUuvev3wI//kNeWpUFpHM9tTLNgeieS9xatbxvWumZziZNBg7OvviY0+muxXrzMDZh+V89cLlQVGhJMol1Hrj7JR8oINoS0bAx6cWtfYo3HZoZmsWF9ouVnRrHHu+4zQKqCzMfQTqj3Gri4ZLmgIwhnU+mnHImQPDlB5sQFD2RB/0kA50sBQQ0bpBadtvDBlGHMUI+mZ05RyfYmghZ9oRHjvh7yd5o0lOQTSOUHVN1yndD6+7rz6YvylgmsegC8G4a0GYAk1ttAmh3hxC8KN8fnsw==;5:jw2zg+HbnkExiitgnd0CoPZmmZIr199JZM/4IebDc13gB8pxQG8Qz/Z8w6oVGtgOV37FGf4r5FSAXUrld6YPiMIu9POJBSejIyxDlmTNFo8dXYc3aYQaq2hQyoHgCqXI5EKdh8lSvfHNGwoOpLNn3+tsXSWOhf+3eoqkxrvWYfU=;7:1C47Y/VvqwIV6hJjVVndKoxqWJiNciDUfAifmHaHEaZ74X85QteboSXRflpyXvNr886mStGX5OA9AJc7txE1FNXgdU7CXBTOD7rz+BYwjZ7SbNnHhpSiLrXH+t48HebuycYB29CtqlFMJ/ZCeBML3xcDgcebg7dYZSVR2ffl+djMtb7Fl22xzypU7FEgUHhgxIY20Sd8TNXi72ZZ4MONMteXHixtqG7ORd1/JR57XdEjhqUtmm5JBkNvM+TEnR1T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:XvV9d6k19ocTXACBoCqdEhQa8bBRoeEj5lJA5xrlWhAw//bwUBYd4jquGeAjjVVgAHtPn5KdstGrNDJxpqDLg3OwsvuyPR90IYevBVlJ0VM+/vJ53j1XAXSdjgasOpCH7LHPc+mbcBfo9TxT054cOF8cgKbKcBz1qpv2orCIlsM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:35:06.4152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a89e06-edc5-4582-f4aa-08d60f813d37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
changed the way how target the slab pressure is calculated and
made it priority-based:

    delta = freeable >> priority;
    delta *= 4;
    do_div(delta, shrinker->seeks);

The problem is that on a default priority (which is 12) no pressure
is applied at all, if the number of potentially reclaimable objects
is less than 4096.

It wouldn't be a big deal, if only these objects were not pinning the
corresponding dying memory cgroups. 4096 dentries/inodes/radix tree
nodes/... is a reasonable number, but 4096 dying cgroups is not.

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
Cc: Josef Bacik <jbacik@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fa2c150ab7b9..c910cf6bf606 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	delta = freeable >> priority;
 	delta *= 4;
 	do_div(delta, shrinker->seeks);
+
+	if (delta == 0 && freeable > 0)
+		delta = min(freeable, batch_size);
+
 	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",
-- 
2.17.1

