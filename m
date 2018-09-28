Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02774C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECAA2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZikFhqGH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ImCThyHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECAA2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeI1T6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:58:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3339 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbeI1T6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:58:19 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SDWnT0008834;
        Fri, 28 Sep 2018 06:34:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=JAltMuVBR78ZMFN03uQFYFrclIm5hJbSUPpMBFpRLOA=;
 b=ZikFhqGHzE3kOc5Yjwc7pwL9Q7xlj1sAh8U+F8ruiSLPqVbndKnWktS51KB3DMowlDnm
 vW5O6nwJHz1M6NGTyWA4oz/cCFBsTUtv4UTH2rsNJg1YAq9uOgEaqW2N5zwEritc1Rqx
 /ixWyOmZNc2+0PJ3RfP7ijN0NTV0COyLQg0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msmnn847g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 06:34:09 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB16.TheFacebook.com (2620:10d:c081:35::28) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 28 Sep 2018 06:34:07 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 06:34:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAltMuVBR78ZMFN03uQFYFrclIm5hJbSUPpMBFpRLOA=;
 b=ImCThyHx3zYx9673+mfC7osI+kjcVvtmMiAsBTjB53qu6m6EBQLrCQFhh3ip0ByFOE0mVMobG2XChd1L8fYDu0xZDqzV0Y6gkLbecfRBG98IYPBTr5Md3yeTz216oxEGhRATGIBwG9qyA0fMSL7vIeOVHrOYkh8isURnJ5iFh2Q=
Received: from castle.tfbnw.net (2620:10d:c092:180::1:baa) by
 BLUPR15MB0164.namprd15.prod.outlook.com (2a01:111:e400:5249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Fri, 28 Sep
 2018 13:34:02 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: harden flags check in cgroup_storage_update_elem()
Date:   Fri, 28 Sep 2018 14:33:21 +0100
Message-ID: <20180928133321.31121-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:180::1:baa]
X-ClientProxiedBy: AM5P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::16) To BLUPR15MB0164.namprd15.prod.outlook.com
 (2a01:111:e400:5249::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47ab09b-5edc-4ea5-3113-08d625470eee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;3:dtXxGhJ2abR7vuu1lbnki04mGZesFSw/DzF98OdQpbpr+gpYL+qVX7LTd98dYF1+FQiPo9rYITCY0xpdiE9A3MVnZPEo1ebVhW/+6iE1jN+Bi5iiJnUlVW2qCcR3lWcmPzZoPEey0UerEiNpnfBjb+VRH0IUeM5Cz1PJ1wxzmFS8YcwNr5Ya1grpydCczdH+W/5TknLUSUnaWJMmJkI4CHbiVKlekczfNbYESwabb+YHNd5TE+88KK8pqpnS0ILa;25:RLxawtfAs0fGWQR6Sd4jmrcPh9bVukNIJ7iDU4TuNJJETE/SP5Z0UdabYeyvNqr6ofcqGDVbjrYMboIjhjUwF5iF8F/i9krSXhEjutei1DPK4UW2GWcifniIwoce0zlR+ej1wR7M4m9NI0acSRzkcPhUHrWgUFeAMKJ9qA3CE172p4z67tfcqGOhkEIn5G+nv7dG3uNh3qH3clvLvmfRyt9KRYEkdnK5WG0F8zf5DEeiVwfzD91X84sroOlH7Ywczl6OgF/c0PLO9nsISmzwajWoayfh6A+1jCU4bytW9HjvZHfZ/2A6kYDLHrCx1i986nvwCvAgmw8P/eg9lGxQtg==;31:w703kJbGcGzAoZLFwuGNgyrU9lEBMzXlDbbXrJTbgEaei5Va5C6RgnIlUEkctcbVrp3pFRFep1SA1G4xZZpAKcw7ugTJXmj+rXPXWfJGj6X5suKClTnJu6CHB8nE4YaHWVTmX4RaGZN+Avgpu/akPL3pdctZui81h2Z7lD+dZl/g/W4NptyfP2y9ehX7nBFmVKnTva5s5bNQL//BDw55MAcAjae8PCGzGKjk1Sb0LPw=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:O7yZriOwAa0eaNVWKr/X0pCzIEA+Etw7p+dpggadRArEjQV21nTqZ1ClhHrowku4exJ0oXK3iWmqjeN0fpkYiQfAlrFSGDUe9J7AmX1rgdNoJr1fLGHntgKhoym+rlILHL7nET7Vl1fcDs0TCoVXoJlOZ0YEbeEfsmdP7fJusDx9q8PJL+rfSvw+I/bx+pFXZahudvnZjmVrFL87T1c++zrPSTJUKGhX7Qxm93mcGYe8e2JBkn6sZSDPlZqvW4tVImw4XUmX3m/vQp5ADyR3DZhQrUoHQylI9N/xB1w9N36xAy9z9VYD2VzUu9Y3/LxTTkc/h1/uuQLPcsybfgHpVdGmC5lg/kkUOFtMwowlXM+/EjTJKspsJzDU2gZ7GtayfvsTczYW0QmUUdRKdwHB7FBPocN1+PQEuYtYYdSJNGsCOGToUi2wi3cH7LlZam3hRKQRgGPzXjU8FOjWhos6RdYOp1c2E1dLL9J6NHn4yG+xK1HmrCnBmM3Je9gSBE1r;4:S79Pv6RTaN5qTUj8hBKR9ig6eJ/ez/f7Om3eoBENfmwRuWWltyE+y9ONdgGFcg1m6WjQN3tj6femxEyCwXhip2XmZmNq+WykzfC+cLCc7yC8HyERmMof/uA0XvJr44nkni/7w+AEmSXOQ5Fd1BGRNIgrjpPEd+bLZ1RzYOU74EHayaoqVc1ek+Tzg3/xILi4VAPFxqKTMRcsR2inJGQzaxxmrhfYOiiUjDAvKOHIRb7pM3XvCo5BwbJo9o6iYUau8poTYWDsnZwgn8RWMxqoxA3we/n9uEPEOmQ6pkInPX0zyi61syubSA92EepWaO7h
X-Microsoft-Antispam-PRVS: <BLUPR15MB0164DCF8AA51296095C91C52BEEC0@BLUPR15MB0164.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0164;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(68736007)(2351001)(478600001)(53416004)(2361001)(106356001)(105586002)(6486002)(8676002)(81166006)(6506007)(386003)(81156014)(6512007)(2906002)(36756003)(52116002)(6116002)(51416003)(52396003)(50226002)(50466002)(48376002)(486006)(54906003)(16586007)(8936002)(316002)(1076002)(5660300001)(16526019)(186003)(2616005)(69596002)(476003)(25786009)(46003)(4326008)(6916009)(34290500001)(47776003)(14444005)(7736002)(86362001)(53936002)(97736004)(305945005)(6666003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0164;H:castle.tfbnw.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0164;23:ItoJd9GeoiX7VmoxPKbJCnRG08WpPqlsoxzjMRHrU?=
 =?us-ascii?Q?0SG1AY5Mhblk8PJFKRlgawZXi1wcw01DRn/Zr6mVHUeXf9dxSYw68sjHI4En?=
 =?us-ascii?Q?PsfCstC0T6S9b2xPwBjC4OmY5VMCODJQBTIIQfxIdMURes90J4NmrP+N4GtS?=
 =?us-ascii?Q?bFTtedjcWOGXSzT1RQAJvRBM6IR1hA0d4EF7LX9Tlj1OOn+GXwkuPZSg4H6e?=
 =?us-ascii?Q?Y3UvN2ULy4sDQ8/BKfiA619655VouKXA1FonqXSWEQX94Ba9sZ0qHupk9eCA?=
 =?us-ascii?Q?KZUdMphRcmIH65lo7ch0oMy7QH1tW7jD1kaqX8Fp7g4o3cgLnaF79fMDfCPo?=
 =?us-ascii?Q?idRdL3MEjnbsnWGH4UZTHqwQz+7Fik5sPBGkxw5k1Au1yxDPL/Clv4DG1ypC?=
 =?us-ascii?Q?VtG0270owEaQQJ8ETdDQxrQ6mpVwWtA6D+io8ySeuTFYRCSzgn7bpbn5ogkl?=
 =?us-ascii?Q?heqBfN5c9x8TcTyI78Iy4ROY2EGH6XFO7QS3Lr8ZjayCanK+wUYQ3RsWTr6L?=
 =?us-ascii?Q?hSixygW9Bq8z5LaNIm2f/o0DiBlIdW0q4i3wnN0m2OsHQ1OalItPbUvs3sv6?=
 =?us-ascii?Q?zpw4XVdknTyP1Q2EKqHSlPCYSwtDqpooq+rIn+luvwjOD/zfJAaO0W9+PLYE?=
 =?us-ascii?Q?Wnby+CNfWBND2ITXBUeSCz8MeYN36R2bUTlnEwG0WOd9jPIAN+Wlu05lv3Ag?=
 =?us-ascii?Q?z1cAW9ywU4mvHyX8w6+hHTPdb4c1uzIbESCeWAKPGVzGcfkvPtG0Q+62+vmT?=
 =?us-ascii?Q?DX/i9GD+4fz95R4KqKP7O7QW22gGmW7sCvpvn4QFkJznc9HLWYmpQga/cm3N?=
 =?us-ascii?Q?vV/jsFiuvTdFl4qFYi1N0pEtidIdpS7F5a0OJNcyR0Jzv2xGPLG0Q/aTOeue?=
 =?us-ascii?Q?5vifb7BZ2bLqxGRbY2pU1ExKRS/xin4H8yh++s1WxPchaFTQs6PrZ0KeXzMM?=
 =?us-ascii?Q?FEFS5tuu7YyAZYUYgrPazqcT+lyns9lOybKiWdfaMYVA8WmouOsppkCAqf0Y?=
 =?us-ascii?Q?LWwZzI1wET9b54LJXrl0zbMfTiUhokSkExoaATAhG4MWiaf5YvYQxOzSgwIG?=
 =?us-ascii?Q?tG0MMfqfiyhWMLzTob+weNkuHofn272bOYeOv0fW7VENzUNwF4c62RQ5U664?=
 =?us-ascii?Q?srFfosER4SwYZ0wwyzCEQgW58R+jt+hNt9j5gDW6YzUx29IMhPB2q/ES43AM?=
 =?us-ascii?Q?hrwIlLSpAV6bF+X0cP30SbQltGvFHIcIch+HGczb1TgGjHskW2AMj/Ej8GTh?=
 =?us-ascii?Q?tppB8ow+GjIAtzqgGT3R8zB+eE+TJGK7OZ7cclY?=
X-Microsoft-Antispam-Message-Info: e3BwoqV9jhrmQfn4cAO1L5ZFa6axsyJeFykjk4QPU0U8LFX/nTNimGr1t1QpnQJzzbrF8hqKmUhMvrVw2p7SuVT15dgLlnBf0Y+WcjudwJw9N9oeU5LfIIwcsaufrgxLowoE32qwKbFu7DS3w8Nne+tv/RI//olArSMf8cFTL0MfbLkhRbvHLa+ky7tlMbR4u/mBlg9SWY9mzY8YJXBpCDvEgH96RVD4jqYZak4mSvMgv+tljHIpB+cFiLFLfoXzeIrc2W0IqiSwgg0TrUTivvv40IQpM/TnZAqEX+ngEVBWl/VfYNIl+XxRSaHy9vpy6JntWAGgSXD8Nvmb62wmtDiAP35jITc/bNfeHCiUnAU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;6:5efiey9l9bwwVTwnstUusi2Fj3JSndMLbbep5x3MKp1F/eRtQCYc6/K4KichOR3GVQcORITSjgsq+GRDZpmesrZEaWdA/mTjdXlisOBUFarRu3V03rXUYcq9c209H6pzjcTzDs1aOro/WZOgZaMsmKuNqBvxow94GJ0uo6xZKmQfP3UQ/F+3vGAn0FjnbRJovdRnyUopMhOo1StdQQXmt8Q6iOZ7ARsTbJ7xgXaXdxDm/qsofvC6ocAf2d7Yrx7iyEalP1rEqpEkp7G1QRK60GtmjYhyp2GsWFJOrQwc00qBA/nm+YAlXbXDCNR4NFlQ3N7K9nMA4e+Rd7OgD77vhFmeH39hSFOS/MGD6y2nhU7XrXo9NNKkT2yanY5FTDilDjAOEOyckbSmNWg8jOEKKcS62R/65T3eL+91IAvg3Kmfw7kO0mkNPxWUXiTC5isesWX7IZZ8x5aJz2W6d+G5gg==;5:5jD6UdgrP1TX/DnlhYYvMZGEgc3ZUcb5kqnNXGvmSzmRbQR/lp5tTBmtuu8MA3e50dAyRIpq+hF7NIJ1O55sfb0pofU55SZJETx/D4LwnD3U4qdaZIl4nVAmCVVUmARl+d4wv0eVlKtCkdM8iOw64kpJz3PAetmD0BDghGzRnYY=;7:XJVHITO1asCBlx+d3EKkbbC9ElNoihAflFfGiZBIQ/iRIYmWNG8iYYnNinLQleeeunRWnwb5o91+i4TfxEZljGCxZULGVdn91ndALGp5kSBbwYkYrlspHMzD3iv5LJAo0RplQYVKyzT5ns9lNHV7XERzeHtObezzyo0QXwlMPJWP13yasboBfYi1veyCdGZFX8ooPxHtAzIuuHlOEmxQnHwJcQl6NIU18XX8pjG2SJTBZuHluFse1IIIhK2VtGru
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:+fCSDgWDhcjjzdoWzKmpesE9e+LzgeZlDtctcHI09EXkqeJSIjh136mLucNQf/ahrglinIWnJcslv38FPKQV960V0lxfqtrPpXTdX9lMHlqqZlel6TNtXetwXv04X2de0xwqXEQV1CiWlUb/BhuGmwgDQuO+zW/pdJ4yLS4+g38=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 13:34:02.7546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47ab09b-5edc-4ea5-3113-08d625470eee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0164
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroup_storage_update_elem() shouldn't accept any flags
argument values except BPF_ANY and BPF_EXIST to guarantee
the backward compatibility, had a new flag value been added.

Fixes: de9cbbaadba5 ("bpf: introduce cgroup storage maps")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index f8746e6a9a35..2a7680106320 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -130,7 +130,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
 	struct bpf_cgroup_storage *storage;
 	struct bpf_storage_buffer *new;
 
-	if (flags & BPF_NOEXIST)
+	if (flags != BPF_ANY && flags != BPF_EXIST)
 		return -EINVAL;
 
 	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
-- 
2.17.1

