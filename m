Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C92C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AE920862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CRVnqz1s";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KrkDM//h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AE920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbeHBA04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387713AbeHBA0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:54 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MZ0oL020865;
        Wed, 1 Aug 2018 15:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=wN4b03mUIjFj1mVVo4b5WEqpVw8p04Oc4S833N9I6CY=;
 b=CRVnqz1s2XhjNvCgdMSscKl233PXGCipH4HO6E671GQyVnXrfAzbFqAxVamIyUp6tZxv
 omHS9/yrK/q/g0bPIDvZWPiAwWl1IjmPbQDKy/JNbj+xL4l80MLOeop8EvG/COFFpNMY
 EC3q2R8k78zhi+OlTQwkSge6CBqOFXWgFqY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmqb05qt-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN4b03mUIjFj1mVVo4b5WEqpVw8p04Oc4S833N9I6CY=;
 b=KrkDM//hnQtrfCy6rH59B0Ey5Hmjh34GHs7ivOeq6zhTjJKWkm5/ZF4CPvjJd27xIhk5I7TBfT8DiQpoz3ZMsqsENzJtZaAPxXc3g1rIkZCvY/CFzD5DcdUiJXM33rDxyIBfDdMkkWSUEqTlvL06BGqj0ONFBv18MdJIRuR1LCE=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:27 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 13/14] selftests/bpf: add a cgroup storage test
Date:   Wed, 1 Aug 2018 15:37:39 -0700
Message-ID: <20180801223740.11252-14-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc748501-b58f-4c9e-1d42-08d5f7ff8019
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:xfHdTgEygSeMc1si2Dm8USiEclbDh1ELvg/FKPl02ZA9c9At5oPtv/vwl4lPWKgkq7G6sD4G6Nh9kGFb4h1bZ4XiSbNfRQ8k7w0rGN34MBCamgwF1hduFaR+FjJZeDU9DzjuHVn/ldvDjO/k73lh1hMyaFEh8c+rKZ6wVSfUn6fdsjBmktJLV6fNvRxt1ews3Obz/SHZg2Q9bY873TkVEL1fGHN1eyfsNds/v3frxydB/Fhc4ybNHZ/dZItnQtpP;25:ibCn4EpxJt5ho0Xc0ngCevM+le3iZlSyldl4lzZMUEBS8DLV5HC4nAipwl+CPnPyJMTiwRnT4QTBQUbvDR98syqhc5usv/xMkAFEl69BLEO6ytjrFNq8kyKgzl51vFah+cfpFGtj3ipLn8xYt/tgWyJB5x48J0AC+bJTtQcD/L4D2mRsQG/7HBxGg1XZwZ/FBN/ag0rW3JnKyD7RWzm+QQpbBYY5H2rMyua1tsfBdgzDzOabHvbrxQ7fkRgh3OKw+YxLTVL9KI0312cx3GwcpFzCeDBzZcTQqUR9oAEqlC5Bu3mQZO51u0IJcrjJ4OfmnZiOjQJhwNyTZ1Pu/DQISQ==;31:RzRKLdA2YXGEMKzypLmyYFE9tupLE0TGN8oL0O6jxkxe2E8QePkDuA5WLYRp3XBr2bLHJXohqjgyrecTF+KSDyX4NEUWwf+85FArfxzzfPHqyvLaCMCbAn4s0weGqtJ7uwa1yKbhjDHVaHDiKWrxOA8hyJp0aOMuprmBk6t3DFp8arMF2vUSIYpRHDzFHo7E0FcQAmDxQ9VriMyUIEDQUv5bHjNp2kE1JV8sV7ZxTcA=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:c5QMyAzNAW1jdAzGdKQv/Ia9ppxJFdlKFWrgHYFFS1pMxPXx/nn3y9zz1qqMYLycNAqe1sjZQUBNz2sUb2nQMbZTyUiItWC/9J/noh5Uvl4N3VNJidhI8P/pyLqc+2o8f8DP7mmsQzZbggXlnJqyw3Adw/O+uv24O+GASoY5icnl9wFZxDZFtDk/k5/Hdc+UUIfuqrKmopVj8dIETO3/JzhyzBrVe/W2ZCCEFNmJWoyJSJH8wSTYVQRPEjApAWQIM7ERAB2huz7pVhGP2Djy9OqLAkJXqqQ14qeDcRCo292QhzWsJt7SSlak7P/U9uOy6MSAdY3s0GJba6vfXlzEQTNr1WaUobpvvV0Qa8xO68YT8sPdZNG3eezi/9ziIqt80znUaWKhf0V3Yy1TMT1PYPSeUZjZiPVZYhIaP0yxfOt9v51EtTG9MEuleSCQfEjb8HSj1Q/tDi/p5go9QdfwN3ZisZa0FxRjd4InaSZlkaHESYJP2AcOdC6ou/93kIyT;4:86vjGk4NSpkC8yPLTKfN16krmxdGQeE+5fv7qCPJ4sMhDrtjdg6iqH2iw57iE6SrHzHIjay324Mllb9wXCgklBHbl7A6jZXv/x0ayB7InoXMA8TkBbsvGjh84ZSSyQyqOcun9vNBVNPebmKFz8Nyb+c8Bnt7b38DstFE/6lXGetXM1GKOr5D8n1THNs7d8bxj7a9K6XSo5oUdcZPAgUttVfdn/2UG0BBN4vVa5W8JohnTye2gthDlvg2+ZuJHiid/2qC0UvS07BK8RdE8Zx7iZPc/Sw5xoMC2IVt9TCq/Iv0/AIuGHCPivzgqBtJA6aIrepoADs5bOW/J+cZutBvz0MeYFuylRrmJsNkujxpNcY=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176F81318E3C2E6B3B8663DBE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:wYVSGkPo24ggy5llkWCTUftXktff49qwwuOwG2Y8i?=
 =?us-ascii?Q?zzxULJ0T6hSmkUU1OEGHWPKajE4hGH+V78Y1VBO1UzfE7He1eBtlNeHvFfBG?=
 =?us-ascii?Q?+C3ZGvZIxcD17rbrKgw1GcAf5P8DMrOEvd8GSKbFAbmMa5Yh1wedRmQb8yEz?=
 =?us-ascii?Q?CdOBLPgTuJtRFS5h1LboMeOvRsd1hR7oAu4eAB+/H79RYErWSBGqUl9PKzqd?=
 =?us-ascii?Q?emcRGDI78F5dNFj4OR5J7EZ+ABKimGv/Pxgpc0r/Wz6Ko735zovyZ6gtNnjz?=
 =?us-ascii?Q?MzN6Knyho8256GOV3fGm/YQGHmbDP4j93tAhTdxMBA8G1XyTbIjdA9dA1lrW?=
 =?us-ascii?Q?QwVGUnFxo4KkYTzIW4liCHhq6YQtHQEeERiv/AqLq9dPDxQwLmxhBhO8K56q?=
 =?us-ascii?Q?OVmot/vu3oqmgWz/xBxkCj1dhq37q+v9M+583e7it3knLa+9RxaNo3WlzBS/?=
 =?us-ascii?Q?vWAQj8+U/soRM1BHsfXRULpn9yiGx2LjFs2E/5hohSzTVh82wXiats9SWzbT?=
 =?us-ascii?Q?TMy1GRxA0MxI8Ph7K+218LgXlfc5YdbpslwgMkwxtCba4sLAstRCiPetWjTQ?=
 =?us-ascii?Q?bEpqswG0pszJomx4v0NhbZYxresEnQX9g/MLYq0+JkWHCa65XgIbXLefn7If?=
 =?us-ascii?Q?rZYG0FeKWBjI8t+WCpUn26epaAZggCTrjLjLRbGXnU53EBEVd0BAikf8cMl6?=
 =?us-ascii?Q?P6keOqvNLxs5OzomUEtTVOxTLEWl4hnD9HISiNLh6QIw7q275FRoNI66EKVx?=
 =?us-ascii?Q?Tik9tIutjp5a2R2vB4pU4Motr03b1VeJZCEXXJ9+CT57tlJTswsdsS7VMvvn?=
 =?us-ascii?Q?TNIrjSzddOnsAulkoUfgn5Xop0D64xNcjsYzL3C63oULdxB/kP2r7YIaT8yU?=
 =?us-ascii?Q?TPPsnEf/9DsqGJEAE6D1NkwaXVxyxYqKxxRWJf6wHFJlLnDe/x2YOd49IEpL?=
 =?us-ascii?Q?fB98znQTimAGvBeOn8BxVvVILUBOAh8i9LJfQRE6VfsJTYj7235XrJvpdgCI?=
 =?us-ascii?Q?gtd3mox64wHSii5Mlj1CEPMb5VZVnDZJS5zNrx+9At5eq9WuoJlH10t5SPuy?=
 =?us-ascii?Q?SLMSA3mjuPwne+DSwewNNewZQIoMDvS8SnyeW2hI4Nom4gcOlYFzwvaodls8?=
 =?us-ascii?Q?p7ay8EFHD2HerRfoQZg4q3goNFa+8mOfIaK72x56p6+WAyLMOELEiqONLPcR?=
 =?us-ascii?Q?nrL+O5vEZ1+23ztOXWJQEEAJ27ZK0Pl14ysUYWNRZnM7e1341/yYAl6cDOUq?=
 =?us-ascii?Q?UfCSezapj0GjRJCkOZunrbSKMnrLOTUo2QK9MrNZqJKFq6vGfVatCBpRm/b4?=
 =?us-ascii?Q?zmsOws5f3JX2cwuofti4KlyJs5jy24DBDhZgKQJss03?=
X-Microsoft-Antispam-Message-Info: kBZm282JoMR1F8bEwiVLs99vlYQBTcE08gmiU5RIsBdKqrXXJnwwpGqmPhRm3VodIhx2JS0QykhRvu2rKWnmlKXnnTZLu9qePiTlEe2vsQSAh+CdzjCDv374GWR1lY3ElMYETiL0gGDIOXFOG8h2OpJOprUUMXudQ8TSWPRZqEtxsJpL4et3cpDCQ5GqKxw26z9raBIThkz8XW3U/78XsSFE19iYBuLaJyJiu3kpnJHixt2f6t65sBw4jESD1Q0AY1XrA+Ylbdrj1Hi2FF+LR1wm0Nac0qRZydrWyjfAvfdcrZRFJ90hk4FeNDDfdBrgyj6CwqjBXC/nkcqOLVSUyjcI2eE9Q0C+AQAOVTOYO0M=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:4J4MgZxxndPdCimpJrAf/d/azMmcn1HeVdcv+ZCn1OBIwzeopQifuDYHlcJKz6DrCym9h4alRnYwTsdiL0z0fVMAPzL+XCL/LmGvJLQ7wL38E7E7p8Ihg8vnpNeWGsfp6tgYcmF4iRnUK7FllwA7nuyoDiC1jYOJ4x8pQ+IuWQ5yBP0WEBJFEcBmSEZNGY1YQ7RPu8ZSo/eLqdWpJRhE5gaejBpIZUWuZmQ11sGilnxu6dI6DRdaiaRoyua5j31rxs3xPJHEz/uwweQi7IJorl7gTUj+qkAJShkmhcf4u/bgFGrzS4glFvYu04O+GtHnjw3YmkBcmMonKrAyq4bbs+RHMMbVttgUXMwkdnn8AkVEmgY3Sl7shGsjw7a6MDrUswgE5mGX7ZNbU7FNLbbChSyBLiXvJvV5HbTvQaxxt2669OStK0a7t76dRyQ82ow7SFr9LvZGJOBy+Q8Zo5pYHA==;5:Q3kQEvzfzoCkvgiDYuDuFSVLHscSdHEuAc4/O9SuayiM2/XUINaPbSjQ/EI/uzLJz9846Mc7+p+OEHpxip2bxXjzgDB3wCw5vmvVb6m31XIcM+ldm2XwQeIQzmpNrZnmPGcoZOS3aABc8fhUM09InBTf20Bqum8OOECqn3ubKyE=;7:kjXY2VGQ2jI8J8SN0AJfdIjXl8JOvlVbQxAkstFEgHbIfLWuO7wZOWtv+vAdrryZJMk1LjXAK34iHXTEO06t+trW9b6dWhuQpSrWRS6NOAg2VjVdw9msw/0NxUKBJzUH028KK3OJsNa/mGQQAQ3yu7NdIm3lmBUn8L1OVFwvnsMj6s83MvNuEP5hvXV1XKpudNp5n6H+IO6aKXu8IYpXbhb9GC24mzCLXl1r1eY8RYYNWVmIrdUL/IcpSCLO+jOW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:leA4KH/UuSKwNWFsN+UNGOx+wXl4dxeFTIuuZw+M3dXMjTOjX1TwEV9uXchjyEv4qxZQ7gm5RYrSvzBtfXJHkJsaGa2jxjG0kQBBjOMsmuJHS4Hxt3PRdYh/Trdl6IH/6G2cPvJH2pQkmM+OETbuZ3TxAnbY+OZYQ+Bz0IrAu78=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:27.3396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc748501-b58f-4c9e-1d42-08d5f7ff8019
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a test to cover the cgroup storage functionality.
The test implements a bpf program which drops every second packet
by using the cgroup storage as a persistent storage.

The test also use the userspace API to check the data
in the cgroup storage, alter it, and check that the loaded
and attached bpf program sees the update.

Expected output:
  $ ./test_cgroup_storage
  test_cgroup_storage:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/Makefile              |   3 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++++++++++++++++
 2 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1b28277998e2..ad241ddba350 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,7 @@ $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
-	test_socket_cookie
+	test_socket_cookie test_cgroup_storage
 
 TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test_obj_id.o \
 	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_prog.o     \
@@ -66,6 +66,7 @@ $(OUTPUT)/test_sockmap: cgroup_helpers.c
 $(OUTPUT)/test_tcpbpf_user: cgroup_helpers.c
 $(OUTPUT)/test_progs: trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
+$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
new file mode 100644
index 000000000000..dc83fb2d3f27
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include <bpf/bpf.h>
+#include <linux/filter.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "cgroup_helpers.h"
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+#define TEST_CGROUP "/test-bpf-cgroup-storage-buf/"
+
+int main(int argc, char **argv)
+{
+	struct bpf_insn prog[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
+		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_STX_XADD(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x1),
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+		BPF_EXIT_INSN(),
+	};
+	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	int error = EXIT_FAILURE;
+	int map_fd, prog_fd, cgroup_fd;
+	struct bpf_cgroup_storage_key key;
+	unsigned long long value;
+
+	map_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE, sizeof(key),
+				sizeof(value), 0, 0);
+	if (map_fd < 0) {
+		printf("Failed to create map: %s\n", strerror(errno));
+		goto out;
+	}
+
+	prog[0].imm = map_fd;
+	prog_fd = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+				   prog, insns_cnt, "GPL", 0,
+				   bpf_log_buf, BPF_LOG_BUF_SIZE);
+	if (prog_fd < 0) {
+		printf("Failed to load bpf program: %s\n", bpf_log_buf);
+		goto out;
+	}
+
+	if (setup_cgroup_environment()) {
+		printf("Failed to setup cgroup environment\n");
+		goto err;
+	}
+
+	/* Create a cgroup, get fd, and join it */
+	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
+	if (!cgroup_fd) {
+		printf("Failed to create test cgroup\n");
+		goto err;
+	}
+
+	if (join_cgroup(TEST_CGROUP)) {
+		printf("Failed to join cgroup\n");
+		goto err;
+	}
+
+	/* Attach the bpf program */
+	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
+		printf("Failed to attach bpf program\n");
+		goto err;
+	}
+
+	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
+		printf("Failed to get the first key in cgroup storage\n");
+		goto err;
+	}
+
+	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
+		printf("Failed to lookup cgroup storage\n");
+		goto err;
+	}
+
+	/* Every second packet should be dropped */
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null"));
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+
+	/* Check the counter in the cgroup local storage */
+	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
+		printf("Failed to lookup cgroup storage\n");
+		goto err;
+	}
+
+	if (value != 3) {
+		printf("Unexpected data in the cgroup storage: %llu\n", value);
+		goto err;
+	}
+
+	/* Bump the counter in the cgroup local storage */
+	value++;
+	if (bpf_map_update_elem(map_fd, &key, &value, 0)) {
+		printf("Failed to update the data in the cgroup storage\n");
+		goto err;
+	}
+
+	/* Every second packet should be dropped */
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null"));
+	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
+
+	/* Check the final value of the counter in the cgroup local storage */
+	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
+		printf("Failed to lookup the cgroup storage\n");
+		goto err;
+	}
+
+	if (value != 7) {
+		printf("Unexpected data in the cgroup storage: %llu\n", value);
+		goto err;
+	}
+
+	error = 0;
+	printf("test_cgroup_storage:PASS\n");
+
+err:
+	cleanup_cgroup_environment();
+
+out:
+	return error;
+}
-- 
2.14.4

