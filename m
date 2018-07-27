Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB892C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53ED920857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hzBMZFDP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NaLoaTKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53ED920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbeG0XR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390006AbeG0XR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuN006591;
        Fri, 27 Jul 2018 14:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=hzBMZFDPhcNMR3YN49a/Xw+XrcfNUkg1xu3sEOG9jDJDxzpsfe1yPi5zNoUlKTjQ+P/7
 iawImlBpWF4HGu2Ht0/bUc2YNInQa+p9ZUVXGYRC4piM2ElFwRsFRi+ftS90giPpBd7p
 nMeNpNhLPmDFYEIXsKVD3bQTWaIjjwxKDEk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2md-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:17 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=NaLoaTKwraxMyzEdm7r1OtTEj0huj6ON6gQjpJOLNti+SHkrwE9XV0W06VjJikdU/4FKHb0ab7BrHi7pmguA2Eau/VU4Lm5ozZahGdmFTGEvBIT2xYPq3kAm1Syr1dcahOP9RelXGw/Jasvgq7QRwv64z3aHtQhf7BF4KBIhy6w=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:03 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 05/14] bpf: extend bpf_prog_array to store pointers to the cgroup storage
Date:   Fri, 27 Jul 2018 14:52:34 -0700
Message-ID: <20180727215243.3850-6-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9790822f-58ec-4e78-535f-08d5f40b5497
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:ufcBTzXV8+UkqCX9HDaFhUbCyXpCMUcfMjS3e4SzxUqD68QXXWNiSehuu/6muHVgMTC0YEzwx/APlFjQlGJOtZ7hIyASj/h+QCCRnV0c9RAOyFsjOBp8d0NcYA65wDhHXX7w6Mtc1YhEoBduLoNkXYNm/1IrO47aF9WwF2MgRfPBGCadY4Z9T1U5MMSK7LXmitEy6TU8HJt/Kju9OdTTZi+DFngp/AY3IcQBDnzGTL47WeRmPbtL2kpgXJIVQ9jP;25:AB5b9HCFjGGsJSYgQv4Cup8qKz/37IBt/qlsW4BLTAgTpfRuRuRyVu3NmRdxgeDoy3J9DPo5nFCP1q93ezJaL3BqSnO9UH8xZJkDET/vp/xBBNJoLwKqDbX40TH1KOZxh3ZlzqgRLbRI79eGh5rO2/9JvtcsE/BHD8s12uwVCJd8pXG2+jTLj41Ob1mKUvDTEpvs11k3xBNml1s002AMutHRil9OGNN5/QXnIdUSdWAayuLapnQADB+2SV30R2opdyy/uAfNE87xobgnyGICJZ5H6hJfE3RKy186evQT08w/uaMHXd9Itk3WC5TLVCPBLQiGjllrNIJpS3C6CFTm4w==;31:f2NLF0lmhTwlC6aJFQdIBPHwsAJHQqPgBTo0TVIT8hP37h56FwhZU0IbJNdDVC3eHB5JjzxCG+JP0b/DMSlMAydYQglm9gZ6UawyRznP3HA+iKMi5fj3bPf8TaD7vKVWkaUD1cj+i0V6sGBEXK/QY0qGluQyZFJ+xkKLqDX3OEOiSfhSSvUUITHt0yIO7olczc0eJFfq7MpkN1LAbFRBGrIqvPnYxWt/tFNvIggqRco=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:RKwiU/IXIczXlevwdOK8hmX6Ebnq7VhnGdHCmTQ4kwuq6ledgb94Xdi8DwnzWKJWcAetWuJP8EfW5ZxPsSzMMdRxUjbCRA2p5lcW1IUnlKqEpuV7m1w4sIQczScEgX9NkNQtitxFqeADEqMjZ8jxPimdubinopyGpKQkClJD5UPWoNVg26PjgKHS7yaBZzIpMECIrATLMP3050Qc/omnKGwBnhrxKIgL84xORamYOnnKCWwzAv2AGfyoZSpyulRBQZoQ7yd5bqbY+FH+bUwf0jslcwh2b20fB/538Mlgu/MNtMQ3p0+6sWKBiry4CLK5hKPmVS4jQBrGy/UBJvKkTpWDHLZS9dvhu/9Kob1WsokB2AqPDQ2Tu/WpS93IdI5/PoSlbAcz4Fucal3tFIlPc4hN00lnj8TFrFcCTFbj4Pip57ncKigLi1rScCu75BTigFAlVKn/WIZ22rUr7lpaozgwb9VNrRxaNh5rgpbqFf7nh6bupWY3NtCnVgeYavCh;4:UXFXfdAqULvGRgG6USVkIMvvHL8NR/Oce3q51AQN+DJ+flQsAo3Z9EdHClSiZJYQrLEpyhWhIkReW5QYtc44zAFqkrdG0VYw8pBN8xj4Bj92+2VXE/RRrxvnp2v39aex0//i3xp/CNzrcqVi+XdyWWsTqE3tnPtJxROfteMdKH5SFrzj/VbaXjU9D6ez9W/DTxvW2qKnHRm/qqdscVowbKPV2Qbqa74uADvK2HAauiKO5pATTJP5XBeBnLu/wOIPMGE5Bbc7qk+efPik6VeoWd6NVM4Ln9gr/yEGYp2aDoIZH7Lcbg9L8D1RMXW0z43y
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171969AD903E58C57B754A1BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:gVf8X3DeBmonEq107mhWIMaVodX54aDL0VTlNq2TC?=
 =?us-ascii?Q?vV6vzoTMiL/NA6ihhdR9l59iQ+o8ccBHH1GcXWsfev9LnuaO90JgHBPmJ04m?=
 =?us-ascii?Q?5EnZJdN+V7sM+DfYjcdO/GpLmsHX+LDbUtoguQkCg7t3VbHkhBUlCqwwrddp?=
 =?us-ascii?Q?WVLNYcTd8NUHtUu3U4naqMDKsDe4dtapsBdHwnKrP7+9wtcXZCw1Q3mjlCG3?=
 =?us-ascii?Q?u1iKOkMTaIUAvtjjCehiHCCMYSgcq1pgXUmiSenpGGeNGX57ynOnv3E/Zlnl?=
 =?us-ascii?Q?io6gCIVUPHS5rIOTl1QjBoWh7JEeMyS/ahnJIC7nClatw2fwrCFsMIpjCJ+H?=
 =?us-ascii?Q?TAVR91fBMapN1OA3QbBH7Kc84VkfTdQeTlAsRKii0UmPUmIrnnpbsP7z+U6U?=
 =?us-ascii?Q?z3A6SdZzxtqBiZTd1Mbu8P8a4iuJWL/bLJZLASjBH+VbTpNOX8JhzRu1ukQh?=
 =?us-ascii?Q?48qYp37IxEitUzdxjC/LzPyW4Qy8aK11eli4k+iW5ez3OJT399K5ryHt3n5U?=
 =?us-ascii?Q?pb6TraG1Avedw65sVREkmLyCNOc2y3lvrB/BDCCUMAh5GR2hnHEOpBtzoEqu?=
 =?us-ascii?Q?pszAtO2qgnI8TcRaehXXlehhkPweWNuktnPAqMMeN0v57LCl7iLDoELb6Kqp?=
 =?us-ascii?Q?pac2hlEdPxKrlGMc/l9wzSrT7QgMpH9dphgN5ZtNpGFVpUJUDWsQ8ILI8mw+?=
 =?us-ascii?Q?oNbL/I020KZRPpn2FhpcLm9rEYDYkG6Ecyt0jZeDLP1j8w70Ab7uwirxbtM1?=
 =?us-ascii?Q?PvMu2NOF8RF4nWsgzEjdLjfpx0pZx7HiDlPD5VwEP3zhYgT1JcjJ5bxi/xa3?=
 =?us-ascii?Q?gxa0wol2J7+1YA5jBX/Guf7aU7j/zkr0fKlUoyIIbVIR7KyaUveCqDjjH/Os?=
 =?us-ascii?Q?BMFbP4GZsoFiEV4opM5JeXtcLtUBInvzrxAhSz8M1DIsjoBOZAIePTzwXXji?=
 =?us-ascii?Q?anWCMZbih71PAIFUk90XujP1hoqp3+pyFIeHVfIU7JnCuhq59K6W2gqCI/Us?=
 =?us-ascii?Q?t9VXktmxz/GmUekpl8izHTlq2Zg5kM/p87epWd16an8HkEvE6qYwQo3Jxz88?=
 =?us-ascii?Q?ee8rik+6Yy9S0LPutU1JNH/6JmWGf6VviC5STvcFYpDAwY0zFW9avWTNYpyR?=
 =?us-ascii?Q?FxI4O3XvFDUJENf9O0Xqhab1D2A3MAVnC1fd1B0SzKFHY766nIG8XgnlJXP8?=
 =?us-ascii?Q?6j3GIrwFv5DnetpH3yYlI2lh0EZFPu+0xEr69gnPwzL/Ud0IfHEC9nNKUM5g?=
 =?us-ascii?Q?Z0S5DXJSKyIDEu4N3ZAzLwKkU/9hTjOZbS4QMZWqh9EeqCe3P78sYk/DJ5KZ?=
 =?us-ascii?Q?Wa7bWlkZ2LIUbTTGHO9gxU=3D?=
X-Microsoft-Antispam-Message-Info: /5XqZfctOUilz6S36G81CLIeq6o0lLsVEQfowdvrsAofaouDzbOhcwhwVS01cuXcW+zCFbfYwHCNod0mEFFb1f2UStrtOXTIXFAQluNBj7aIZ46rs4hFYCigMYncij4Rj74aAwwlhqoBskf/AtLRu6Tl9o1OUvG6yuv44SOms0S6hlaRNFFekEiJX2/NrwM58hI+l2SxVkAC5y+xaQAV7yp3xOPqFdiRuqxHu1g2AWC5mDew0d4YDOLj8pjHimWX/ae+JEzAkh+setqiAtsPVcpHU9hv0jFnBDcrz2qWpEMw8HM118hRlF/aP2rGy2gXiBznaOv92zrhi0iY1GE1+/Xpyo55SJ1kxr0T93/W2TY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:FDLgljg3KjF66DZaWn8/qmy5UlgaMuB0zmLz9sGZP3ARmgDqxgRODldCzJlJ5NEAr1gPf0S0mDxDROUAVkGO0DeWqv8kLZOZKS4bIAWLo+lqbffo/OzfKZvPXvTNCuz0yh19uztHsTcI/d8zUx4zM42U6zW/riMsUOE885I8BRPENVLprCeQ/IfYuNtvSa0CVEAiv+DaQu+OMQP2vSpW3l9Utip+l+fhdcUIDoBtKT/FpNhU8cyWiQH4r4bgc+JQhrXtit6/iqmMxunOdragCHblB6bVDtjF1YE74renCEo7b0sfm9ZViSWz+MSHfGJKSABw00eu5ilUMDJUZJVk1/AOr5uKBNVz0icduNGsKk/mFkU/Uu6TkvUYgyIJHibu35+t3kNrA6MqlSHvD+pJp0IAGIGAdm8VfLw6losV5tnM1RgEQMpBhOr1eaRxWjNPhhU+jMvXKx24QIRWY1+DwQ==;5:MVKI4IkqRWzIWoyBwzCcl2+upgQpWDOfI6cxm83RplWC4ZRgM6tL/4wwgBlG0HBu3u2E2hkwfojQc8mrJ4umWOGsYS45G0lG+bpLNrw9WbVnk1x0kZwDzyuEcMpBdd23SJjrf84U1CbmPvSQW5s3XsK7IK6ppVz1im/Xqk/y/PY=;7:n3dmVpMAFUDeg3IsgNbQHl6oRsCYzhJj+hHbNmgjVO2gPl3Kurj8wFd2X71v/6NJP6bHFV9CPmg1zmPdjVPJQNG1BMES/9mIJCmL8hkouAsDECoj7lQKJzNl4pSYOsHkFkhP8K19k34h/yOo6qat2babuimWpCFNv2mRm5DFd0YKOCdeNPWABNnDOo6w2AaDeyYVn/r3clAdTglokUUzSMrPXZ9p+WkO3BkUF7u7ggg1ejWtnIRIoKHBSXLPY2uw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:QazrQg5lghU97AlOvxKBqJ1Xhc8HiPdUwgRcPEXGelzHf+tdZUECu2OfKnS/EgBJNfgFgqh+fWovR070nb+wQnRGVQrRpNtMrC5DY0OhLPUYBgG0odQ5zrg0XYpBhNfrU/Gkns+STUiX8u6nOJikTFTRY1x7N9+SNQris9Wz6TE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:03.9310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9790822f-58ec-4e78-535f-08d5f40b5497
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

This patch converts bpf_prog_array from an array of prog pointers
to the array of struct bpf_prog_array_item elements.

This allows to save a cgroup storage pointer for each bpf program
efficiently attached to a cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 drivers/media/rc/bpf-lirc.c | 10 +++---
 include/linux/bpf.h         | 19 ++++++++----
 kernel/bpf/cgroup.c         | 21 +++++++------
 kernel/bpf/core.c           | 76 +++++++++++++++++++++++----------------------
 4 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fcfab6635f9c..8c26df9b96c1 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -195,14 +195,16 @@ void lirc_bpf_run(struct rc_dev *rcdev, u32 sample)
  */
 void lirc_bpf_free(struct rc_dev *rcdev)
 {
-	struct bpf_prog **progs;
+	struct bpf_prog_array_item *item;
 
 	if (!rcdev->raw->progs)
 		return;
 
-	progs = rcu_dereference(rcdev->raw->progs)->progs;
-	while (*progs)
-		bpf_prog_put(*progs++);
+	item = rcu_dereference(rcdev->raw->progs)->items;
+	while (item->prog) {
+		bpf_prog_put(item->prog);
+		item++;
+	}
 
 	bpf_prog_array_free(rcdev->raw->progs);
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d1e4727495e..16be67888c30 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -349,9 +349,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
  * The 'struct bpf_prog_array *' should only be replaced with xchg()
  * since other cpus are walking the array of pointers in parallel.
  */
+struct bpf_prog_array_item {
+	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *cgroup_storage;
+};
+
 struct bpf_prog_array {
 	struct rcu_head rcu;
-	struct bpf_prog *progs[0];
+	struct bpf_prog_array_item items[0];
 };
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
@@ -372,7 +377,8 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
-		struct bpf_prog **_prog, *__prog;	\
+		struct bpf_prog_array_item *_item;	\
+		struct bpf_prog *_prog;			\
 		struct bpf_prog_array *_array;		\
 		u32 _ret = 1;				\
 		preempt_disable();			\
@@ -380,10 +386,11 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		_array = rcu_dereference(array);	\
 		if (unlikely(check_non_null && !_array))\
 			goto _out;			\
-		_prog = _array->progs;			\
-		while ((__prog = READ_ONCE(*_prog))) {	\
-			_ret &= func(__prog, ctx);	\
-			_prog++;			\
+		_item = &_array->items[0];		\
+		while ((_prog = READ_ONCE(_item->prog))) {		\
+			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			_ret &= func(_prog, ctx);	\
+			_item++;			\
 		}					\
 _out:							\
 		rcu_read_unlock();			\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 935274c86bfe..ddfa6cc13e57 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -117,15 +117,18 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	cnt = 0;
 	p = cgrp;
 	do {
-		if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
-			list_for_each_entry(pl,
-					    &p->bpf.progs[type], node) {
-				if (!pl->prog)
-					continue;
-				progs->progs[cnt++] = pl->prog;
-			}
-		p = cgroup_parent(p);
-	} while (p);
+		if (cnt > 0 && !(p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
+			continue;
+
+		list_for_each_entry(pl, &p->bpf.progs[type], node) {
+			if (!pl->prog)
+				continue;
+
+			progs->items[cnt].prog = pl->prog;
+			progs->items[cnt].cgroup_storage = pl->storage;
+			cnt++;
+		}
+	} while ((p = cgroup_parent(p)));
 
 	rcu_assign_pointer(*array, progs);
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 253aa8e79c7b..9abcf25ebf9f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1542,7 +1542,8 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
-			       sizeof(struct bpf_prog *) * (prog_cnt + 1),
+			       sizeof(struct bpf_prog_array_item) *
+			       (prog_cnt + 1),
 			       flags);
 
 	return &empty_prog_array.hdr;
@@ -1556,43 +1557,45 @@ void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
 	kfree_rcu(progs, rcu);
 }
 
-int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
+int bpf_prog_array_length(struct bpf_prog_array __rcu *array)
 {
-	struct bpf_prog **prog;
+	struct bpf_prog_array_item *item;
 	u32 cnt = 0;
 
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	for (; *prog; prog++)
-		if (*prog != &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++)
+		if (item->prog != &dummy_bpf_prog.prog)
 			cnt++;
 	rcu_read_unlock();
 	return cnt;
 }
 
-static bool bpf_prog_array_copy_core(struct bpf_prog **prog,
+
+static bool bpf_prog_array_copy_core(struct bpf_prog_array __rcu *array,
 				     u32 *prog_ids,
 				     u32 request_cnt)
 {
+	struct bpf_prog_array_item *item;
 	int i = 0;
 
-	for (; *prog; prog++) {
-		if (*prog == &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++) {
+		if (item->prog == &dummy_bpf_prog.prog)
 			continue;
-		prog_ids[i] = (*prog)->aux->id;
+		prog_ids[i] = item->prog->aux->id;
 		if (++i == request_cnt) {
-			prog++;
+			item++;
 			break;
 		}
 	}
 
-	return !!(*prog);
+	return !!(item->prog);
 }
 
-int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
+int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
 				__u32 __user *prog_ids, u32 cnt)
 {
-	struct bpf_prog **prog;
 	unsigned long err = 0;
 	bool nospc;
 	u32 *ids;
@@ -1611,8 +1614,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	if (!ids)
 		return -ENOMEM;
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	nospc = bpf_prog_array_copy_core(prog, ids, cnt);
+	nospc = bpf_prog_array_copy_core(array, ids, cnt);
 	rcu_read_unlock();
 	err = copy_to_user(prog_ids, ids, cnt * sizeof(u32));
 	kfree(ids);
@@ -1623,14 +1625,14 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	return 0;
 }
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
+void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *array,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog **prog = progs->progs;
+	struct bpf_prog_array_item *item = array->items;
 
-	for (; *prog; prog++)
-		if (*prog == old_prog) {
-			WRITE_ONCE(*prog, &dummy_bpf_prog.prog);
+	for (; item->prog; item++)
+		if (item->prog == old_prog) {
+			WRITE_ONCE(item->prog, &dummy_bpf_prog.prog);
 			break;
 		}
 }
@@ -1641,7 +1643,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
-	struct bpf_prog **existing_prog;
+	struct bpf_prog_array_item *existing;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
 	int new_prog_idx = 0;
@@ -1650,15 +1652,15 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 	 * the new array.
 	 */
 	if (old_array) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++) {
-			if (*existing_prog == exclude_prog) {
+		existing = old_array->items;
+		for (; existing->prog; existing++) {
+			if (existing->prog == exclude_prog) {
 				found_exclude = true;
 				continue;
 			}
-			if (*existing_prog != &dummy_bpf_prog.prog)
+			if (existing->prog != &dummy_bpf_prog.prog)
 				carry_prog_cnt++;
-			if (*existing_prog == include_prog)
+			if (existing->prog == include_prog)
 				return -EEXIST;
 		}
 	}
@@ -1684,15 +1686,17 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 	/* Fill in the new prog array */
 	if (carry_prog_cnt) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++)
-			if (*existing_prog != exclude_prog &&
-			    *existing_prog != &dummy_bpf_prog.prog)
-				array->progs[new_prog_idx++] = *existing_prog;
+		existing = old_array->items;
+		for (; existing->prog; existing++)
+			if (existing->prog != exclude_prog &&
+			    existing->prog != &dummy_bpf_prog.prog) {
+				array->items[new_prog_idx++].prog =
+					existing->prog;
+			}
 	}
 	if (include_prog)
-		array->progs[new_prog_idx++] = include_prog;
-	array->progs[new_prog_idx] = NULL;
+		array->items[new_prog_idx++].prog = include_prog;
+	array->items[new_prog_idx].prog = NULL;
 	*new_array = array;
 	return 0;
 }
@@ -1701,7 +1705,6 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt)
 {
-	struct bpf_prog **prog;
 	u32 cnt = 0;
 
 	if (array)
@@ -1714,8 +1717,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 		return 0;
 
 	/* this function is called under trace/bpf_trace.c: bpf_event_mutex */
-	prog = rcu_dereference_check(array, 1)->progs;
-	return bpf_prog_array_copy_core(prog, prog_ids, request_cnt) ? -ENOSPC
+	return bpf_prog_array_copy_core(array, prog_ids, request_cnt) ? -ENOSPC
 								     : 0;
 }
 
-- 
2.14.4

