Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E3EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB772083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UapOqpfm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TSizru8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB772083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeIACah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:30:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38892 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbeIACah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:30:37 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VM9oaf013195;
        Fri, 31 Aug 2018 15:20:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=T5bJtRAw0I/LlJVBVV1CPV6Zwc7kWL3ui6skcdyWyQU=;
 b=UapOqpfmXXVRkT+X1GJrIWwrLwviWEMajCn4vtHHtbihusHzoAMFCbpkd0VDiCRZtfDQ
 QLXDhDUPeOkWh611Gdc+iSkWODOHzignyzv+FyMEMnaVx4wnMq+3bnPJjyF87hHm1ps/
 vw/F/1Rmm0OP6YKI3hFj/6bk9bC04FVGK7w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m7dpu039d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 31 Aug 2018 15:20:42 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 31 Aug 2018 18:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5bJtRAw0I/LlJVBVV1CPV6Zwc7kWL3ui6skcdyWyQU=;
 b=TSizru8YfiRJ7byptcok1iVVpiKtWJFsKK84RjojSUpujPDG2JCoyMdIT4mKlbCD97pda1ijtQ0NNiCbSnplWf/V6g391axssJK3a5dldPw9SrNXHIGVOFXCKE6R0ud19DPsEr5xaJP8ZudXLEd2OPozBZHkE3a68N48dvKwnck=
Received: from fb.com (2620:10d:c091:200::98f2) by
 BN6PR15MB1153.namprd15.prod.outlook.com (2603:10b6:404:e6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Fri, 31 Aug 2018 22:20:17 +0000
From:   Yannick Brosseau <scientist@fb.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Yannick Brosseau <scientist@fb.com>
Subject: [PATCH v2] Optimize lookup of /0 xfrm policies
Date:   Fri, 31 Aug 2018 18:18:38 -0400
Message-ID: <20180831221838.25597-1-scientist@fb.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c091:200::98f2]
X-ClientProxiedBy: CY4PR0601CA0038.namprd06.prod.outlook.com
 (2603:10b6:910:89::15) To BN6PR15MB1153.namprd15.prod.outlook.com
 (2603:10b6:404:e6::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc826d6f-27b6-4b9e-eea5-08d60f8fef34
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1153;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1153;3:vyeneLIvH7FanlGCaaAm8gXzVEZ6AE+1c5XD0XMulDL8mpI66cjn75JLAAq/0c53pxp8kj5UPtatKkIGReR70KQajL/BJp6qNqVbs2TGleqFBe7x1+Ao/jZsXWwAo27wSkOYU6chX+adfFAwOMkv2zH9TDGcJTckDpCt/zVyY2cw4o7v86rHQdNlfWAvmDTJcg72FK00Ryrx3FHs0RyjZ8maAlksmBXsb8CSGFhUNU6AkcxOP6q+OSe87SMo0Xx2;25:cQEeNAmAXYkpAyiHDFgPRA4Y/AafoZkfij7qf6zGD5HDm+GK5uHETOq2DXMrfhuD0rSjpICXhuN78ylQHs3TRdj4LayPyCClcMkLjwbaD6fQZa4ze17Vb+7zPLn2fzipkbsDrE6kmnGYrt8CR46BmB8TBcjOomsPoWHH4DIYe2r0/8ximmuSPCj4k62SqOXMPi8jiDftGmFoKaWReuj1HZpz7RMxq5ihHOBPCqEN0TOCgqmYc8c7z75HnNApC9KIjVyy5ptByFHOpnjp/4QiMG/SA7rmY7kVv8LAHmY9bgROjqyPeTyfv1CTAkR4Z0o+5kLqF2+5ez4yuZxDxKJMqQ==;31:A7OftsqdKDkq/92c9fEzi5znlS3JYzZRhEzo9R1Fkw8vr1QJ8ayi7MLZHrldARcCSYk2d4/tg+BCoSyFi/dFMAym9G4TjJDaIMzNlnE46IkQKJD67bBogsiH8bMwwVB/8lHYDsxce9O4VfCr/hDY6K6cN+XJcKS0nVjyvGKQW5WRCCUzN5RKCcbF1jUrSZbaP7vXWoiF5k3ToGaV+4hbMd/NbuEACWJ7t503tv6+ZNQ=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1153:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1153;20:fhH5KNjUJfQnvD5df7y+bfcy4ql1kNO0odKoKKLEh73ITyXunOFLeFeELvk8MJGZXWmEbgGuiUNg8T503Qkgu39cLCuTTXVF6Dj9GhygZg5jDMujNiPR765zfahC9j7vEAHFskXDqBu5YxeNmcZRZPuSFI9yAXuJoIxs0C97SB1f9BU2CIrC1Jh6FAOPDlLQ7J0mR2OD2+1Y8sZ/O1hkdpxVfFDtj0D2c4PhxFD307Wmrtyxl8TzRg4E+iKmKWZ6Ecp9T2/ntP2OOE6QDVEya/kAexBrbfNRg0KxB+ShoA3Ot4+vzK1icGrAeqdtSJoarDV2XKHx7u4Kpa7m7j7Xfox1Nvn1IKTguslKYYuq+/NerZZMTIZ3u3ZwUl9vZioT1P8bIjL1e9lXjVLEnuif13dOsmx23cD+YagxfuGNZzx5/b9A8bnysssR3aN6tED9tMuMqcrb4q3+o5ZaMEM4rCuTLlVdh7a3iSBnK1zX4eB6zHovY/spns+nrYQXFe0c;4:Bm7nGP0FydjLSJYREMaH+Fs9rK9KEhSX5K2VNm/wTEj3zcb83K5glnOQ15YXnKkC+1pEwYs4ZPmmei2K0B0ih0ZrowYRLAFc3K3tLu7vCB9L9TtquxAmfzX7mfzAJ8zma4ceY+a9kmUyTDn2kZOQ8fDcqikvVCGZYom5xmYfd3hjP+XnOMtwr8XIanayGHbPp0OVYrFJ1AVNpMjLWbh5T/W29VABdMeHoEd/7SE0aL4MvhPP2h10+FhMDaopcw8KBtrNouqjmmSiQJBcmdchueoTAi9JRgkZ+I8OO473WZqagKcOkI9scoGLzMwwMHPR
X-Microsoft-Antispam-PRVS: <BN6PR15MB1153E830EC3C75E6525DD6ECE80F0@BN6PR15MB1153.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN6PR15MB1153;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1153;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6116002)(50466002)(1076002)(386003)(2616005)(46003)(16526019)(476003)(486006)(186003)(55016002)(47776003)(5660300001)(6666003)(48376002)(14444005)(21086003)(53936002)(106356001)(4326008)(36756003)(7736002)(478600001)(105586002)(51416003)(25786009)(52396003)(7696005)(52116002)(8676002)(81156014)(81166006)(97736004)(16586007)(316002)(50226002)(2906002)(68736007)(305945005)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1153;H:fb.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1153;23:oLEN4YX643o5jt4rAPIRTfP5+SrtqTuFqzj7lVOpk?=
 =?us-ascii?Q?AdgxmAhgZro50su8PSaSrtNpxLXqNLdWPPG33jNxtF/9nMHdncKzpMFOFugn?=
 =?us-ascii?Q?oVNteNcTzwamEn+cV/qzVf9wt4ifYc1394cJ0CpGoYXjCHhMOlNUFYpMbvmz?=
 =?us-ascii?Q?Aqbn/NlZ0tGVYoLoFAjbQX4Yn/iTPsjVssqnArCyjiSjq50jo+3Er6plt8LY?=
 =?us-ascii?Q?oWS/5L1nLW5pEAwhVE/1e/cs/lRyGa4TqNC86Eeyh2Twz4TK+K3vAOX5XVfj?=
 =?us-ascii?Q?8Natne/FwKMMgX/K9/XARRPMYyl8tEKNUqGTeEvV0M48wBEhPyyUsTqjRoJa?=
 =?us-ascii?Q?PRCSQtBN/7WQfBjY/8+TD9SUATP+gsVREeS7d/f0wDaS7znbRuHMLjMEqs1b?=
 =?us-ascii?Q?x+Um+9SfHDwHM5To84O+MVXaOXxo+/S3PH0MrzUROjqTv67hk+zqc1VzeXCf?=
 =?us-ascii?Q?SE7WNmogZzC0SxBN/AsRdiWh6mu9rrpMVYE3ha/iHT86MMbBXy7iNYqdcMeh?=
 =?us-ascii?Q?wk7oZDTuHePjCjIz/GdS+Am0JiOC/oBVdZeUgbQRUqct0BWr8tnB37ZibzCT?=
 =?us-ascii?Q?mXwd9KAffA9/Y1vbWvGGDujYeW0eJhuMycBm4oJH2Poj4kuyjCoh4o8zy4Xb?=
 =?us-ascii?Q?WxI+Gw1MPzMTCQ4i0g3zgalhsPH6z9sajOpDkM74sUz5rvdPPMDrWoL6FNgx?=
 =?us-ascii?Q?PadaE0Glo//rOsNGO98EDj5zGF2O1xxzejsGCzDmf0m7LggDZ3DPm5CPag7Z?=
 =?us-ascii?Q?h73x4cDWjq5cGzYh/vIUzj23RlH2G4r6bopiQykf1HlFR7RWRCNy00Hxxlqq?=
 =?us-ascii?Q?hdCgtkZYZsITdh4HoMTt/2m33rU4t7dwVXIqT7VA8lKy7JF6B3biO56gAc0a?=
 =?us-ascii?Q?EO5HTVQGxEsl9lpw0qfRCVCwrdzcXqZF+6nkqEI0DKFD6GNQjtMiyogtUMDB?=
 =?us-ascii?Q?uO4Kw3L9UNdYu3c7Ga0BxP/wKerhbJ0BstbuA8RodCBoWS5YFk7jsjnOmbjR?=
 =?us-ascii?Q?MZo9dzaCVRPvq424qCcBWBzqcU50TG4bXkmylwFPv0N9n/Rorh2dANyy9n3D?=
 =?us-ascii?Q?z7MDNde1QdJzVqJuQJAuxAeRB1S753m4o+lBif/sWreW2ZplQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6nwm2sl1DNF9va7mlIN5DO0cMl4x0aoupgiNxbb8AFcHmiL7FAJ77JtezVxeczfykfsbfBghbwsmIlsiy60pLCCaYh8L9OxRxvIL+qYgvFipTglh3ApfHa2bGX1is1dQ96Eb7hBmTEKyFyyWWxU3L3zHUIgmDSYeqe3yIEcyVv+2vv9TFZDE5JpK49J7AgwxZwCfd6AzXl0ECCCyXAV33TLEUbUpIq9f/QPovKid25jg7DM1lCuAQ4KOS0u8ERMZjH1uKIVDEzaaFSFjKX90uG5yCtxgVzpqp6BsIbjuBRQ68llzXvIaKitf6WknAqFGDIJctdFNM87c2v2ixCn7dDe9zvslYIJM3ibSEyQMLMc=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1153;6:IlgBVHyy9T9CGPAxjpRj0KKn77DgwSusMQg0pktYC6Yh6tzw1TKXviPlcGHkBKUcdVvjOVGRNoJ0GpswBy0GiwKVRv61GBQxERfw8aEPXunvlfTytrciG5IKZSBP62ef0bKTMh8oJ3sH1SkbBRslZr/dwr6SuAZnMqLvfUNM2PAovMxA3yf4Bn9rHcHGIEqhnggHZtPE9fTlQEdyyHXaImtb9wGF4gx4plUz7Sl48TX+XfjnMgbrCwIhjthc9Zg6V2+d1arc5CpnTai7M/BRhHnG7FLV4SL4GtEkAcmsNohVqoIVkrYOTJfdVJ0C1FYRQ+ysdlU2Rr/S8tcnUPljLvbZeDPkRbvOD0Y/I773HKNTHKpQU7nk5oxAzzEzzLcIMCMt2G7AevC2a6vHysYFw9NXvf+FJ5y+98PQ80qLk5wmoTEO9SzGV1/9BONOjmDuBYuxS8KlAobsmYFTIBA1pg==;5:4VUf1wTinI9HdCgHZI8QxoQkEF6NoIO+j7AXTeofuNyJ9jn8qrbhHj6lmuzfLOxWAWTwBpBFtYYm6AVPepYX1kB4R8WZHkzSQMECeppaQlCTsuT5OBAU57yqxS/iQMdl+fe+HhApK75djQi6K+HKUgejiltNG8Lkp/wants8PYQ=;7:g+0EZRH2nSuHaeMYf9Gx3tTTx+CCLULdd68gCZmST/M0vy9/5SFtHqgFMvt697PSTTXerS3MCSXC9rFtv+Hs5pkLntn01Hop6cssC5s9z2bjac0DVGSZRD32Z666I9bwLbPvbAsijI2uWQml+hKzrzw6GT42A0qDA7e16szJFrzzqV63eBSAWP4AcpdWWAorlfPCxq7RrVpRpU4a02yT5K6AS7D4mXPGGwK4MiMkm+uO036Qf9R5Aa4hPhd1KMOL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1153;20:++tSRjyrll+Gir305WUSjMhOal/vn4j84GBDv3Olw7fzGkNUOigF+s4ayw5cE/4FiG1eGPYW4F4gnrUHSYh7nQEEzlkrGHUl0r025GrpbjKgRt6LMMthgab7xKZ//fH1QP9/LZLgqyF46Cvhz13ivMARb57beqrj2enN0MnRoSU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 22:20:17.6608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc826d6f-27b6-4b9e-eea5-08d60f8fef34
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1153
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_09:,,
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
 net/xfrm/xfrm_policy.c | 87 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 2 deletions(-)

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
index 3110c3fbee20..a1ca78900ffc 100644
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
@@ -1129,6 +1132,86 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 			break;
 		}
 	}
+
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
+		err = xfrm_policy_match(pol, fl, type, family, dir, if_id);
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
+		err = xfrm_policy_match(pol, fl, type, family, dir, if_id);
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
+		err = xfrm_policy_match(pol, fl, type, family, dir, if_id);
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
@@ -1148,7 +1231,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		}
 	}
 
-	if (read_seqcount_retry(&xfrm_policy_hash_generation, sequence))
+	if (read_seqcount_retry(&xfrm_policy_hash_generation, first_sequence))
 		goto retry;
 
 	if (ret && !xfrm_pol_hold_rcu(ret))
-- 
2.18.0

