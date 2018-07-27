Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8BDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B26D20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Hh3mr24H";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZLnFLcwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B26D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbeG0XRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389963AbeG0XRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:24 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLiNiw014649;
        Fri, 27 Jul 2018 14:53:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=Hh3mr24HJvqBaav5ZaHDO/K87X4DbJtLMklOk3kb1pxxx6EnE6Uz8fQRETzoq9+Ok9U5
 H8kPxUiAhH4jYhE2KBIj+Q0NOwgz4UAbNhmHtgwsE92dLKJ92f5mLH/+2GnrYyv5c6qP
 YvrL0pulolBmyJ6OHkbFeDbYCZwEVMsfu3Y= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb59g2nd-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:12 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=ZLnFLcwHJf2ldOjjyOrcKxQeCA/wpAOAUVUUK2emdYIUEcDdVqnrOmhQETsoFHTBuHzVN2svTBRH2lo8BImUg6RElpm8wXw2cs2YlyiBzi0znSaKJi5QsCNHOKNgFtunPrO4IJI8K+/LtwJXYBFfWSYcAP8CQItlGQMwgpZuvmY=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:08 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 10/14] bpftool: add support for CGROUP_STORAGE maps
Date:   Fri, 27 Jul 2018 14:52:39 -0700
Message-ID: <20180727215243.3850-11-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72863fc0-6f37-4d3f-b35d-08d5f40b5744
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:qHCSSFh10GzO0IEHJ8ixZFMm9sTVL09LL9taOjI+SvaSZwHIkEdlFTxHkzQL/ye3oLj38GwBy7az/GaEfPJwfcsh8dMrVidmOXLeASf19wApBWPHvJ/tuLeqxo6JHfk1EZVo1ZzOkjb9iHPcehGdVsS/39N7cGpWu0wLSv+/wKGDHItP8yyvHh5aqPcubm9MfSNqfRVu2lPrqTH75X3vh69ddCHi9RaTPvnhvWHgeEjrR+fZd6gRonlNpOaUfiGe;25:DBL0ZwqLQ4TfZ2X1v1NsxVAstDAPUKWYenrBFOo0fJz2S0ZIwc5uXNqyU/HoMj9iFJ+b36ZLeTlFFtTG/33v5lbUBH93XJ2KYdDk6oRKh61oZ/Jn2nc2/MpO35X5/FvkByswYFHCOvVvUejO4z260O3heigC+yd/utUiybvzrrhvfryRh1o7nCTSa6WJXzlKV9Q43vFRVej2suqksW4fU43IWTn7B4QVvCxAfo7zl0Lci7KscxHFRRJloD35F1Du8RdjRpuhvS9gj4PnX8UAKcWl7qYf5CDbVy8/xF7PYtFxOnPbO/D8bDkqjbiYqRBt1g2Xct1//fngFFYbe19dvw==;31:exiVOab67nBPolhv0scQGfMMsP0ox+GDMfCAW6eHnRs7zUHyNBQwdYShFUhEFtFAA62JWaXtZ7pm6d9RPdI6q1tFyFnjOBpn8twR4C2GXYnwAczgvajJRexjW9Mx105DATWiTnxDxjjkE19tdXHYfiLS05PGPwx3VYDIT9gnnpZIq45wChSJ8d4BK9sE6VxVv9NKq5ZZ5SENxfXMwgSr5ITQ/Fb8KEladSX+44fyb2M=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:NeCRztLV2TmJJZwsgqFJ6SEn2seLPeUtnJqKvxWkfm97pxwIZ2RJZp1qjlGq0HnDpUPidXxsz5h94DnDtuZxKvWR1LgqD/n6fLUIrofEXlahziDk3xdUaV/nRSBJyhnyx2unrufpzcFR9k9Arw8g8prMv0RAG+/ZHGXjzHWEypgNN6mB+k5SM0FuRF5qL0KTgZER5AH8DkZSkEFRMC01FIBWqCnhrbC3l4z/Y0JF+YvKnPqBs08h+jbqofudCGajJobtNSQiXoPjlfoRtIE1YInRdbgUxtT9GqTvGl6sF6t/wHngf713CfSf47l/p9w8sdJDJ3m8LoFfuVTjPt7dSTFkhVGGEtmmeOWvZ/u81iVygE2aOIoZtxV9F1pdzsVF+XQx+iFfhUwgdpAVHFCdR1xMr00jgoS8ZmNgHU8sLHd8NMRJR/+GVnVv3PO2p8gYSE0Rbyy3Gwtp7LrXFHIr98t/TxvE+1uwEGlqyjcdPt1NIdjhu5fMRI7PC/SmxnF8;4:OuSsJdjuGh1x0NTzYoXsKmjFvk0rgv6ermtZUXuRlPXJYA+Ix5B9f8k5w7oaV3XhxV/5AaokWzs7eYETjRpOSE9nHbPNX5RbZH+V+hZ3ljfVSHj2/V/2+xPKGSsNyEp9JFy86GlQVjXI736BQBmh5pFyP4pECuGo/rWZaXd1gkD269/hO6kGBExA76PyIBdiHvCI+OzT3aS4Xrob4CaVVwzcli9AHT91q5kRb9A6RK7CPo68ySoQmNCQZQqyyAfVPXBuVZE+oLAxIkyoRP+l9vLQ9gyXZpZxdS1/bmDujR3v4p8Qj6X04X7BOXuqRDTX
X-Microsoft-Antispam-PRVS: <CY1PR15MB01711D9B38352C83FF825F8EBE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:j0CgYSWYc/+tQPqwGugP6Qd6EtzIuGjIkhBmWW4FG?=
 =?us-ascii?Q?lQDQGYtThtuh4BaQR/YxkyKsu5uBLv7EBXuXmyH7vSYmGSGz0Ok2bRPzyN9C?=
 =?us-ascii?Q?Vbicnpko8D14gf4EH3I0orukI/TyizOx3Daux+j4W9rtZjReDTKVbJIrfNbs?=
 =?us-ascii?Q?L5B67ZGEhIVmzn4doJ90lO6U3eIUXpv0uRj4uH3q8xuwvbG321wdbLCeY8+v?=
 =?us-ascii?Q?iBBZhhRw+I0xN0TdqmjGxbCsx1TE4bBykw5cgQfefPAPaO+21inIaFxbT+wS?=
 =?us-ascii?Q?2mJwMUkQQuUhVHs3cHm6zrO6atlBwX/v7ru+Cxr2Yh986UEjOXzEQNswdSkv?=
 =?us-ascii?Q?GHoakKsipOW9szrkzV4xeGQYraYWQ16IZdbqSCJFKLBcDEeqa0O+/B51Dp3Q?=
 =?us-ascii?Q?2AdxtfEnySrYwsCNpMoCas73d6RdSL3tNcYopZP7mjPk4NRB8s8oEtTov2wg?=
 =?us-ascii?Q?BfqBx+PgA+yCpxhccZ3M4/fYHCcgb9IoJBCbVgyyYuRXz93pg5FxZyzS7Xa2?=
 =?us-ascii?Q?BH063tsIYBME9SMAAdIa0GCIAZ++pOdMTEb671WnnQyEy6ZuiXXPRIa76Tow?=
 =?us-ascii?Q?lG/V8mES63zTJmzZ7FGy+TS4GfTUPA39NkD/762BLBhSNd4MHPBn69vUBDGh?=
 =?us-ascii?Q?fRy0l5ntniX51awNBEJHEoJgtanKBPb/rO3PQrEGbGbZl7mSswX+R6m+dW+5?=
 =?us-ascii?Q?RAw18R6Xjib0fDF5XZsmfRYBWgn7eIgXeN/d+GyxZ6N2BP2cDt2oczUa+CHw?=
 =?us-ascii?Q?ZHVnXjctAdsQTlYGS7h154rJbrTmQPg8zgngPWaJWosNAisVR2Ir6tMYONj5?=
 =?us-ascii?Q?fkIWJbGbBNV+aNEODo+1nmVSIid0S9L440gIzuxl1Lph9omZOvyotJmeQLqb?=
 =?us-ascii?Q?EkyhbdyEwYJDsFmpeqaaswaBrFa5Am/HiZFA2HQLRdUMGoUwMxURitwgxsKT?=
 =?us-ascii?Q?7I9JbPkyLVL+l6EMFVcDI0cKK7oJboYi3CC3z2GSoraruhBA4I24SoiVNivK?=
 =?us-ascii?Q?ARuCRUrEtKI/pivLGo/QXsgeyuIqqpfX6A13ema5bbf8O3GeYx+LCbvTW81o?=
 =?us-ascii?Q?1oHsxna8VXhNNe1D/6YEdyhQgbbQRcJz2Sc8dEAtOPiBNVRaUIm+4MXS/xNx?=
 =?us-ascii?Q?jkKTcTZXU1AyRQvmIIqMZq4GNIyuV6ov88zUks4sb3Hlh3rwZyIAvTdnJx9z?=
 =?us-ascii?Q?sEjncM1FPU9KOPbOABZKmNrVrUl9vXX4q/HeZFB1F1hnG3Sr/IeTEm9KlKRy?=
 =?us-ascii?Q?HJIMWrnUB95rcR+Hs2Kew+PlIDnU3NtvLTJFUGeIR3vc22QlCq61zJEn9MI3?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: R3l8y2ivhnqu+XwJzCOmve349sa5P7YfpJr9NZDteFngXj2jh+agImNSH9nQVf51vJZx00pB9SEAGnzfqBFBNIi4UxkHaFavuJScbQwqEZPr4Sha7ROI5HoM/t7KKUzWA321eCBOlRrEtMnP5wheJtJhlQv4mTpNy2coEcTXO0F+WZ7CTj0dOBFpgWqAF9jz2ndf3P/SY6ga4K9vi66Weuvaiqr33VvtH7pNM4PvFfcv1R6eTZcN2PJpspBheOY6VDvnf2b4DOrBog1EAu2vsfa/vwYO72YSsZ6xgkOppiz9XJ+ayjWhxO5Jkqfhw1eE4PQghaLbAGWEBlKpQ76+zRO00YgztlLF1amRWWCdAOs=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:2/8Hitq3QC+fMwFH4fQ8LczzpFI92EhZdlecRcSNUPJaNZXQMiEet+LpPYRBsjvE8Wbbg/IjrujdjHr6wBDPPAXivuV8Hv1NAMXWz4rEbOtw7Wz1+XsjAXbszydwWdzHCA1kkDL0rUvIflK1IIZowugll2XwoUrQsrvTNkGuTkrQUQtivOtwo40WnhVfeMf8nXkOt1UI6i0SppftIGKGfUPKSf8CtOv1CPOd8wMGQKuOr+N+QvhQn17ikxFDbJiZdktrNVm5vrjO3WBcuPJm+XsVZf+W2dfKuzKTCqFfTZMJB/20/0ML236VMVAgkPgBdWNndkUpjbhLsBP1udPFZ/b6K8d+xxeh74O/JS1hFidmaU78tVTzuOMJopCwK/z1mxcN8JbCUIKjOb14B1AKsYYrSydUUzVOa5vuaHmLEzDRz+0xg5eaqGSxz38lClQimhOrhG8/psKfH3hPRm/yFg==;5:DQrPokLe6Noeuae4vEyhmSA3r19RKEgn72YYd3Zp1j9jEc6m2ER/xYBSrx/lUA2xeJOkWjHrVmXzVI1lpW/uYSXEcMAB4Cvq2s9Hj2VMa+I1Uw7OF/OSLZGRLrfM9gIoe9RC25s1jtKdS5/rNJuCo1ZQ48X8fPzuf0J8ZSZScl0=;7:wvbZx8pCJlKsoo+zDuNhtKw0XGFzm03BoOuBGU3bkScxjkZ3FioiK6RrFNyRGpWbyNwHfMC1qC0XC3YEeWXxpLemQRgDlGc+9wgQY+jKLykeYMbWNW7vAoIRoiE2q0b9ttYINu2n6wXpXLk9OBRvNNCEm4rZ6xmFDNgT+DPd9ZWgiX3sWKu0YNm7OWTIcw1srWowDMSRvbWdnkkf1HR9UmY46v8mTsJyp3vaxZqN7lZcwsi0R2tcB8REBNkpX7/R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:cRrLY2lfV/SYtvaIsYGFFO9tjI/ZWbOiUg+pCOSg9T5WGs60OE4q4PJQ7qj50UVui0WGjdKU1dbpWJ0rDwUNHJlhPtci7IQTeyAHhFkDmX4midXv3jiY1IFEM0zNFo7CrBeyXZ0sE0f3Q+L6KH8RrR4764NmdKcvCjQUpVYNdfQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:08.4357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72863fc0-6f37-4d3f-b35d-08d5f40b5744
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BPF_MAP_TYPE_CGROUP_STORAGE maps to the list
of maps types which bpftool recognizes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 0ee3ba479d87..2dd1f8d9cc2d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -68,6 +68,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SOCKMAP]		= "sockmap",
 	[BPF_MAP_TYPE_CPUMAP]		= "cpumap",
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
+	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
-- 
2.14.4

