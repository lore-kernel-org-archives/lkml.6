Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B4EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79B420661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Fk/ZSGrk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ey5yxxfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79B420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeH3XjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:39:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50898 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbeH3XjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:39:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UJXmC0025648;
        Thu, 30 Aug 2018 12:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=1xR0QVzZIbu5RW0pmncsuV7Y8wxpZjEaISi42fSC0jU=;
 b=Fk/ZSGrkzCC0/o0ZlUV8v0+DZhvpTnwx5AxzJ90MaJgVqA123wFVbBf4Q389EFdKJvnK
 S9OA/YO43GTr97ha5qca2SnmS1TvuwZ6XgtPLFPjveff0V/vycqmuePewrQMrCMiXyL9
 yrTY4jCt1RMGISzDpU8EXiur53pjmU8OXr4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m6pcv834g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 30 Aug 2018 12:35:19 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 30 Aug 2018 15:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xR0QVzZIbu5RW0pmncsuV7Y8wxpZjEaISi42fSC0jU=;
 b=Ey5yxxfDEUTBe5vmUAie8fO37Usp4SzDhWW4+dRNWAp/AvY35q1+5tKte0aClJnjMvelgumGMF6uT2dPZelx5/W0TjWUsa30B/22dgj7kIUL9W5NmSckNl0viYFYYPQQ7KtR4uIrMLEzuk8/9RCRduW0nCJub6O5lYrSt1o3enc=
Received: from fb.com (2620:10d:c091:200::3:ab6) by
 MWHPR15MB1166.namprd15.prod.outlook.com (2603:10b6:320:22::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 30 Aug 2018 19:35:13 +0000
From:   Yannick Brosseau <scientist@fb.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Yannick Brosseau <scientist@fb.com>
Subject: [PATCH] Optimize lookup of /0 xfrm policies
Date:   Thu, 30 Aug 2018 15:34:59 -0400
Message-ID: <20180830193459.27622-1-scientist@fb.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c091:200::3:ab6]
X-ClientProxiedBy: SN6PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:805:a2::28) To MWHPR15MB1166.namprd15.prod.outlook.com
 (2603:10b6:320:22::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1e66920-e2d8-496d-c8dd-08d60eafb53e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1166;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1166;3:6N42ROap33m5zp4+6bKJ+EeF7mrZ9wrX/d9d8M5cm2+lz7IMdWd4A70DcEiHNyZ6F66c1BQNTHrYsdfI4pIanBKUYAgu+uwVNNz7GcztsW3mzmHFjSTFWbulWbqIkzgoI/LhSw1OijUP06szEufnRg1wi2UvZ9h0p8W9wFGlWcOt8wtrJr5T3L6DsTV8qXnB7lyLakMECnyq/3KppFM+HDUN5aW4ejI/mP8bhdHDhnoZH5HQ5YVy30VlvkFyDWcy;25:/dzIUPkYyGlfXFRVXSXkbtajZ4DhCx7eV57V/lfuDJgdzI0ZQGf90pOQ8mwxfTTzW/5rDBdmzdBaXwtBEbvxv30Kl11unH73HyaPrrzwZt5fQWgaQPiADQ67WCejskWx8ricSrHZ9vs1yfamQDZgLOZOf1baLJc516p4S342xr6A7w74n6Z0YRI3PG/dIvIQEos+IXUtFO/0EagHQMjhai6nTOKG4IxTwOs7drfwq9+bfDT8YcdIWOxmInRd+SvpMaa3NYtaUJ26gS14tKwUr4MF+ai16VA78nCOvzrgo0VK6sLYchXhYhAm2X0mELurNr1ZWSjO+T5qRgtnPhV7uw==;31:cgh7eMtfF2LBwkrPWZuY25QxauuDIZqhWzKfdMhHLiGO0/b9eUrvzEj6jy+EQvZQKrUiSRMesXdlRGxnJqELbV9YHbmqioFX9Q/V9UcZzKfmmUx+ueR4Y2xa2M23qta34pXQ0yzQagtQz379UWCiAvMvEWdRJqw+jWkaoquk6Jamxc4mjf1eb2b78ilJtSMVQRxPac8/L+qvDtMGDq/JyW1kF4fW0HynmJ9e1vDIUfU=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1166:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1166;20:OevWrCmUyrnnJfdhgy2vKHd0M8DugzPucEbcS45lWUzIoy+ezDI8zLUQV4FvTRpNHBvJ5biXFYVSndJ0WxII1v8dymWuyzjrepHWIszk+eazsbh/354XwmrDgFoyo6Cj36Rkllz5suO8olbij8v2mGZ7Bv8PaWd4T4k6FUDYmqekKmX25J5kiRmjeqY68TG3XNmJj1TmZ22Xv0nMYb+zc2T2CsmET2y//hhkcQ88910bVd01gah6IMgCxdX29cowadBhmdR6099efpk3lskS9R1h2JUK/9FXiwBvJqT+fwSvGXP7ZivSlc5zPommi12Qj4Z+k3s/sBiXHmT8Ph7DxqPD20oo3lp5zarDi53up65wGJjHpI/jzwKuJROK4qhkA5d7LbkHCkPSHjOG6FCgjg631fA+cLcGJfVyyURx4ugSrioGPpq95GxyBFGjPl5I7MwjII+b+oU4ADCAAyphcjW723WeuJMDghjsktMX+gBqB/We+1K5eAJwcrZjugZ4;4:cwJiPu55/ImSPvVpnYZleYWnWIrsQyGw00B5zk0Ir26/D9i/bVv5y22gNOQO4n+VnDx6XwEteD6khnxux04oQJw40fKNoGV4GgTgKB9YNCZvXkAo1g31oAvi0BhdjTdrzGwOojcrozc4Y6os5ZQBf/w/VzTaTqoU64lweW6PDzVWFwgMaTScxOP7UY8mLT/5pROHXF31jv86phWrG78vFLRp9RgQs4fd9FURMrV4UNzwZrOGwwZlWV1uaFyxbpRWBHd5lfLqKEntvDmh/lAtRl5f9wj+Vw1QTOS5a5Mgmh4IQVw41p9i8JlppBQgeVq/
X-Microsoft-Antispam-PRVS: <MWHPR15MB11664E9EC9151D183DBE64E3E8080@MWHPR15MB1166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR15MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1166;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(2616005)(316002)(186003)(16526019)(476003)(8676002)(386003)(305945005)(14444005)(1076002)(6116002)(50466002)(7736002)(53936002)(52116002)(52396003)(21086003)(51416003)(16586007)(7696005)(48376002)(486006)(81156014)(97736004)(50226002)(6666003)(2906002)(25786009)(106356001)(478600001)(4326008)(8936002)(105586002)(68736007)(46003)(47776003)(5660300001)(55016002)(36756003)(1857600001)(81166006)(21314002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:fb.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1166;23:uAtrv1v5HJwQXhN5uzazwlUfejEeXKvd+D+xeLP/r?=
 =?us-ascii?Q?lUX2/Rh1nfQ/7edA2X+qYaBIkqUDIus2cJ3xFH7iH5Zy9aYOAC4cLpWkVoci?=
 =?us-ascii?Q?zGROiFTCZe+bL/IjzmRDE31d4QkHIMmqmqZHHUnrXtUXMkhESbupbrveRk+V?=
 =?us-ascii?Q?rVfyickYg/H69e4E0nzDmFtGPhojp+Nu6/gLMbssesEWjjL8B3Tp5DqMmARQ?=
 =?us-ascii?Q?Dtp/TEmjvBCBRRRzfiPlSGhUbKPIStOxy3K+E1raUeyR1ooYc+O2NnxziYns?=
 =?us-ascii?Q?AtwmBldwla6uIBXR1B3oKuRFfClWDe61USN+uW9l7admKKNsI7eP8HLn2TCj?=
 =?us-ascii?Q?ir7rkv6D6w71znA8W0To9tIAIR6beGeu3j1VhAN32I0Vq98APWNBRP+BUJQo?=
 =?us-ascii?Q?AwXi2s0po8+npwb8q9ks4m0Ble9Y3lMWOr5peBT+oEMg++48cnG7PKOWz1Ht?=
 =?us-ascii?Q?csSlyQ2mKASCNeA86BY+JFTdrk5e7eBmsK3AoLL0935S2GqyRSYGNmurtYzz?=
 =?us-ascii?Q?dCftuyNJAE2bCR7X9SOLQr1e47KfAiBaff/XgR8imEPFf2Z8cwd7DgnHmcQ7?=
 =?us-ascii?Q?gmER61FEgCZXbfzDH6QBfdCgD11ndaMZpzDS1aB2FCRiJ8gxP3oOpT/Taqwe?=
 =?us-ascii?Q?+Ma5hfOzO4vEpoZ9LG6f2SwjGY8xJr7ZaqF6MoQm13v76KFDDfsJJDFzMeEF?=
 =?us-ascii?Q?Ls3OTcrwCOHmeCZdNlnjDnqxNOYbIcZUy7okR7+Kea42TLQQxkN59Td8SncJ?=
 =?us-ascii?Q?tQCoHo9gvGgRVSfk8OvvENpQyW0AsGWRBtU3BmIg2YdnWfsgoyvrOS5cKTBH?=
 =?us-ascii?Q?dI8au9gbdUUrUhCHEGrddh6fqJmxSh0dVD2ccNuayQLGcYvKSqy3DGh+zqiu?=
 =?us-ascii?Q?dfEuR1T07bXW2JOTSRjBrxmQOi7l7DJ1YegiB1brs6tD4UelJlftCcX4NsBW?=
 =?us-ascii?Q?qQt7FxOB+WYkuXz0F0JCrjrIJwYs+dZChiHIDp+R7e0sTbhViiAnx+K06B+N?=
 =?us-ascii?Q?NrsIQIr4JB1WIqhCIJFMsm1pHA52TBaeD02JFb7CvF/Y2kDvAkcW+hDPeG5J?=
 =?us-ascii?Q?eUvnijO9X5gYLHPUI5/YBYkGy0MI3H785dys/ZGd+wKW6VIVXc8D4HCsHFMV?=
 =?us-ascii?Q?GhMG3zDUXsEWi8gnKb/tqJlwgQ/CmVK?=
X-Microsoft-Antispam-Message-Info: 2g/8Wvd781mYmlQCMPJ3+FDZVMp708nJpxb4Jm6kGZ5TG1NemCUqL1zrRNe9oPDnPjUQOe7+Oq/zlYzANE73tT/MWIH4zD/FiHwaIt9Gd3gWXIDrsSS06+S5tJw1CSuxuyY0zLPjdCQ+eoV3+Kq45OPlLRbv7tLuEtlRrCBrNw5WOckpRjNSGrhK0IRaFYnoNCqt51ACG3/NfqnG7yEoiMnIzNIfwtrEqQGVVgOBcz5kdxo89VLZ6ijE/FFtKhC0MirCwO2Kvj7tuJnv6QvdwtpHR/IJ/oW8KtRoHlHqS4sBk1GHFR2JtFdsByb6Pa0bIztFMrrykekaWzBad/W09NxOy8aczNSwlmbcadWn6UE=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1166;6:OnLsLRvjaJMXr0VpFUN4mjulmAcrAoU+DQ6NcPKA82WMtaisZyJzN8mFvF55VP2OP858XpxuejoV5W3Ltm6X7fh3psUsEVF7KnHjMgnf3nHB2FeA7jyldrSb3ihtjBWMQ9GpxlHetGUG/qKGgcUoizARwefE+lzTHGc5a0MlGAfyp7NoD/fdO/gjjhmkIeaEO2CVclAs19ELAuLk9cj7jm5z63pkmmgqoz1OQ6A+j2L4f57+P+R3dXbQHZeCh1+vWxYAsEe8rMSkP/jfW47neGXOYLSgl9KpsQ3rdYyMJYQI+cHMPTnXps0QKvViTUDAM8GME2p+sJwxpKSpgCXYmvN0bAaJjwMPZjVkCzEMPryOS64arcbB3EeGFAzBDwxqnC6Zmrdq9leqOeOgMHL/ghdkZag/DdfmIsCEJfWtg3cHC+HxHO01JaJzAc+9pLmbJ3DtYYqS+m/bSfbILlhkIQ==;5:HdgK3LwVepUaJ1xijGX0Z28iIs5pF7TGQMi1MHf+chqGh6IppXeiwkb1+ZQsTX9cJljGNN3r8A1zXQvHIjE2nTLaaZM3iSFfBK7sbQkO+jrV/QU78s57KsY2MT2DbgdM4rDT80Mto1zzBLgOTH2kgV2JjvraYu2nzml6ylvCVlA=;7:7afCsM0jLNnFgo+xaaV5DnHz2mjFC7lQmt+3F3fXsLfbTgTnPrTTWqEoIBEaVptzclHFW4yhYY08nlAjDtKKJ4t1lo3WwCPw94+YbPumkjhZlXt89Q+mP10W7L7CxPdUzyh+m3eDY3peYN4oWZ6kAeQCJzVVFZxqiZyCXhYPcUcRASIizLo1a3FUoNFURBmsYXtU0SSJjfm23seo2MfCuK3pKN3MyFWJU0z1BYOiJqwG4+A8diWxo5LaUU5rTwAn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1166;20:LneDQaEQWwcDj0Eiv5EniL7TQRmwjjgxv5Fzb5ocK40oP+awj8zncJZwVsLQju6nZ/wBmMMMGOEUP+KDRo+cT/mxFdZW6NMKlzPDK39IffBqF7T62kuGQXdMIOm9NziPec0g0avg4Poom0sXtTcnCSt2CFXW79CUDWJ0sU5hwIo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 19:35:13.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e66920-e2d8-496d-c8dd-08d60eafb53e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all the xfrm policies that are not /32 end up in
the inexact policies linked list which take a long time to lookup.

We can optimize the case where we have a /0 prefix in the policy, which
means we can match any address to that part.
We do this by putting those policies in the direct hash table after
zeroing the address part.
At lookup time, we do an additional lookup with the packet address
and either the destination or source address zeroed out.
We still call xfrm_policy_match to validate that the packet match the
selector.

In our tests, with this optimization we reduce softirq cpu utilisation
from about 40% to 7% with 3k policies.

Signed-off-by: Yannick Brosseau <scientist@fb.com>
---
 net/xfrm/xfrm_hash.h   | 10 +++++
 net/xfrm/xfrm_policy.c | 88 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_hash.h b/net/xfrm/xfrm_hash.h
index 61be810389d8..40997fb5336d 100644
--- a/net/xfrm/xfrm_hash.h
+++ b/net/xfrm/xfrm_hash.h
@@ -145,6 +145,16 @@ static inline unsigned int __sel_hash(const struct xfrm_selector *sel,
 	const xfrm_address_t *saddr = &sel->saddr;
 	unsigned int h = 0;
 
+	/* A selector with a prefixlen of zero can basically be ignored in
+	 * the matching. To speed up the lookup, let's hash it without those
+	 * component. In the lookup, we'll do an additional check for a zero
+	 * daddr and a zero saddr.
+	 */
+	if (sel->prefixlen_d == 0)
+		dbits = 0;
+	if (sel->prefixlen_s == 0)
+		sbits = 0;
+
 	switch (family) {
 	case AF_INET:
 		if (sel->prefixlen_d < dbits ||
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 3110c3fbee20..7c2259f140d5 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1096,8 +1096,10 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	int err;
 	struct xfrm_policy *pol, *ret;
 	const xfrm_address_t *daddr, *saddr;
+	static const xfrm_address_t zero_addr = {0};
+
 	struct hlist_head *chain;
-	unsigned int sequence;
+	unsigned int sequence, first_sequence;
 	u32 priority;
 
 	daddr = xfrm_flowi_daddr(fl, family);
@@ -1112,6 +1114,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		chain = policy_hash_direct(net, daddr, saddr, family, dir);
 	} while (read_seqcount_retry(&xfrm_policy_hash_generation, sequence));
 
+	first_sequence = sequence;
 	priority = ~0U;
 	ret = NULL;
 	hlist_for_each_entry_rcu(pol, chain, bydst) {
@@ -1129,6 +1132,87 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 			break;
 		}
 	}
+
+	/* XXX FB NOT UPSTREAM YET T12762593 */
+	/* Do an additional lookup for saddr == 0, since we stored source
+	 * selector with a prefix len of 0 that way in the bydst hash
+	 */
+	do {
+		sequence = read_seqcount_begin(&xfrm_policy_hash_generation);
+		chain = policy_hash_direct(net, daddr, &zero_addr, family, dir);
+	} while (read_seqcount_retry(&xfrm_policy_hash_generation, sequence));
+
+	hlist_for_each_entry_rcu(pol, chain, bydst) {
+		if ((pol->priority >= priority) && ret)
+			break;
+
+		err = xfrm_policy_match(pol, fl, type, family, dir);
+		if (err) {
+			if (err == -ESRCH)
+				continue;
+			else {
+				ret = ERR_PTR(err);
+				goto fail;
+			}
+		} else {
+			ret = pol;
+			priority = ret->priority;
+			break;
+		}
+	}
+
+	/* Do an additional lookup for daddr == 0, since we stored dest
+	 * selector with a prefix len of 0 that way in the bydst hash
+	 */
+	do {
+		sequence = read_seqcount_begin(&xfrm_policy_hash_generation);
+		chain = policy_hash_direct(net, &zero_addr, saddr, family, dir);
+	} while (read_seqcount_retry(&xfrm_policy_hash_generation, sequence));
+
+	hlist_for_each_entry_rcu(pol, chain, bydst) {
+		if ((pol->priority >= priority) && ret)
+			break;
+
+		err = xfrm_policy_match(pol, fl, type, family, dir);
+		if (err) {
+			if (err == -ESRCH)
+				continue;
+			else {
+				ret = ERR_PTR(err);
+				goto fail;
+			}
+		} else {
+			ret = pol;
+			priority = ret->priority;
+			break;
+		}
+	}
+
+	/* Do an additional lookup for both saddr and daddr == 0 */
+	do {
+		sequence = read_seqcount_begin(&xfrm_policy_hash_generation);
+		chain = policy_hash_direct(net, &zero_addr, &zero_addr, family, dir);
+	} while (read_seqcount_retry(&xfrm_policy_hash_generation, sequence));
+
+	hlist_for_each_entry_rcu(pol, chain, bydst) {
+		if ((pol->priority >= priority) && ret)
+			break;
+
+		err = xfrm_policy_match(pol, fl, type, family, dir);
+		if (err) {
+			if (err == -ESRCH)
+				continue;
+			else {
+				ret = ERR_PTR(err);
+				goto fail;
+			}
+		} else {
+			ret = pol;
+			priority = ret->priority;
+			break;
+		}
+	}
+
 	chain = &net->xfrm.policy_inexact[dir];
 	hlist_for_each_entry_rcu(pol, chain, bydst) {
 		if ((pol->priority >= priority) && ret)
@@ -1148,7 +1232,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		}
 	}
 
-	if (read_seqcount_retry(&xfrm_policy_hash_generation, sequence))
+	if (read_seqcount_retry(&xfrm_policy_hash_generation, first_sequence))
 		goto retry;
 
 	if (ret && !xfrm_pol_hold_rcu(ret))
-- 
2.18.0

