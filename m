Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFB420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WWCEUbky";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eEfHslwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFB420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbeHBA0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59476 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732388AbeHBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MZQcY003965;
        Wed, 1 Aug 2018 15:38:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=WWCEUbkyIMHHTRFQet2WSLk9ev421wNkI0vTTiSyYlODW1sVh6FoZJJM1aL2ESJN4o6K
 zDwobwymIDEcDepyodAJrREpnbVKnSMSeJE8bnKUN9y5BfbK6kBO23ZLrALQwzFEdXQh
 7DEJ+SRs7lY+azVGOdZDy3OwC0cVr4GmrvQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknssr07t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 15:38:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=eEfHslwRbJOnn7LDnRzfnVkjHnZOamEm3+8Md1dqKOsBgb1G4dlWGd5I1BO70ckcVmCg7DRqzECvQ27INM2ffLLYPzCJfyYC7fQmFePxnYa44R+ILgsiMrMRsy9+/EAtPoVfqFGDe8HMA+yU3Pl+AcUisa1oWeDKg4IIxsI8X0I=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:28 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 14/14] samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage
Date:   Wed, 1 Aug 2018 15:37:40 -0700
Message-ID: <20180801223740.11252-15-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 09889d42-e745-4b17-58e3-08d5f7ff80b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:jmtOGqVFhu/cObbAZLt0YC/arlDPULVJn7Sv7iKkGv2bbQA9PU3GfBCcfsq0Wj7ssaZ4UI/jJ7FcW2X17FEkbpiRa3D4tg+PfXuWqJ3CLEL5GtIH7v9nnUNf28rXTrm3MsVNBkYu5z0PqpYzHC/it6k7jd4RyhonRjlbLtXVvwREEoxO4fI9QTFheqf7nang6MpqgFHVJaL7IXzXyhklmLZxdmbcU1kK+16lLfDnxEWkg+lg6qoTMzLnXKt1eNGy;25:upG8GZseTSjkyerEtKO6PTIyUuWEBjSplsHcEkq5hgOoi64NCQDp209LWRBWpvfyxWfmBcwxTiYWLz7yGs9ITrZOO9RG4WrXiwszwCYgp52JTvQ4ea9+OMlkaROh/k4dtnUPgG2e8VI4wkMrVR4j4ppBNasoLixGaiRgTBTZ0VmNMdH0fxPCKOWMuzu26sdM2jkNGC4//kzv7WFSaqZCPOIMQbHYUgg99+Yx1EN9cCjpaQh9cnRURxDwofWIZEnJlR3PRJbz1QijgkxeJRIp7zF4Q0XizmxJEXy67+rpFglGXpMZA9XZgrKhNa3YL7D4xizDzP3eDqHh72kLYCua1g==;31:+Jm9ZSquFQw5ai6eUvfLvV+rzlHAeTu9diJZHxrcHKjqa80nAkStaZNz5Pk7SD2Lg62Yop4ZhHJgQOeLhA2MzwaOne+t/rvk++pe8gSkohLnNv8RcKq9F26H6trhtd5VJsUIIXSYl3KQrbFCocZDE/nKkpUE2yqn2KJrwTcq85EL5v/YJva/81upggKKeqxgt84Fx+nOp4l0SLysSXAW1n5tbSpK+u1O6erUB6oP4EI=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:hEd48Lgz0DJAb5CZxYfclTW6VUq91pTpdYJ/uVr2bdWyWkGoUJCoksXT3B3iQsyFWK7AAHnzrCxO/Ny/gBFYbe3kyix12HNIjoa30nOzn0a0HVsIaaZR5JUQBehRuPjghhQCrL0PtjMR3XCcn35y+5O8sfJGQwsdcGnvLG6iG4RZEQkEFUnjBQBb/0xa9rUH9AlSTDhy1GesfXzaIvjXmOm0nOXKvUlVCkHIM9+bncMsEAc9FDqrS3he1ztqMq2S8/0kdhDUCavfSW+btgNcKghj9q/t6kbxBrfF6Bqvm+lw80973UVtjOeCweUSkJXv1Vu/1ojqfBqtKPyaMhMKyvCm3SlfP145WniL/Fi/GDKMtW2gB3EKOnq2Eb1tomDNcCs6tjuvDOC7bc48CSNJWbZi0Em25QFa7aXF9cYbFlqiPg/ZnPDVV/w9reQjFHOAnJuerAiJ+yDUSuXEMnfuV140G6YbjsdZeGXWrRcTSZkGdNQSCNbZeNzedH0od91u;4:WlbCbwQXmxKS20t4ew6ibfaBvaMYOLqb1b2alK2VyNtAPYHMCbiGFSrS78k+4vyxtRlTFkb6xfGHDMe+WguNuDfIgTzzqsstAwolI2GAhY8Xb2lMYnG5mOpo3XVy5OW6z1hnwYkV2B78MsSKWN8v+eZNteISOQ2QS/1Ue8b3H2y+K0nVy4SoK1lYAIlUhYM+/tXBm/CNTtb9FLDaET5PoJcIDIwktJVP5pdmvCrDkWjg28u1hn34GQGtn8Uuyw5sMVcVMc3JB4dWNflBt0SfaBJdFZXJi9uIMmAi6/ZQAfbzMCGaAxCintihIN3KgSSY
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176F81D6A949F1C7E3CDC2EBE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(15760500003)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:Sr3zo/JhQiPnFYOUhI2MSIcLVT2mfpWXCI+inKV3P?=
 =?us-ascii?Q?JifrKtM0g9XvmN43hMCnG6r3r8fRpX2SeOcW1POObhXNROQf0KABivAoOWMx?=
 =?us-ascii?Q?ZEnXf6i5fYwizoIddftYYF+BehgI+H12zy4CBilC2y64wGR1qVk6RbG//NpT?=
 =?us-ascii?Q?/bMmev19k8Exhxcriq0v/wq3hjuirMALG3V4sTCbBh6Kb3ojQnxj0sDhXEJa?=
 =?us-ascii?Q?e0KVbRTXbKBHIOirxXu85dxUaR+/bQZQOrRHqELSuoNUrKSstxHWoP9ydHwe?=
 =?us-ascii?Q?2ONzu15zIaLIhHwzQ3t7Vn98SvqkR4rn110/aqtPVSREDRh3FoICPwvhjZuE?=
 =?us-ascii?Q?Za2umOHKlxlEFPdto+bJm4jwQbkf9FxNqdrUaRXez2VPURQMAwF5cqXBmScx?=
 =?us-ascii?Q?DpLVP7OC2Cdh8Dh/fPDFeoOvol2UD+8IIJolvWok/3WBzpbP5TxCo1ZcykDk?=
 =?us-ascii?Q?jLr71S+sItgceKXyj/1I3PwmwyGEjD2Z+p5PEyW6T/9HESlvu+Smq+w2jB5c?=
 =?us-ascii?Q?/qLd4G1Qq6uZ4nMW6gLhP9g9z6RKjSm4oOzSGRRu9Rgppbq3PJtmQA0Anyu2?=
 =?us-ascii?Q?yhmgk1P6Ed0F9mdgyNFQr6WIwYOib5g/ss+sh0/Et74F+/Lr8a4YOqMdMBC5?=
 =?us-ascii?Q?RE+vdMrYik6fgVH7Xcv3UMt2OnRGqNbAC7sOXQLJF8LrddoeMOu6eyNHQABW?=
 =?us-ascii?Q?w7yl8mb7qMqLUwBSsQJRsJgm7k3v8czxMese1Ltx++h0BcyXnrQh9DkxV0Y/?=
 =?us-ascii?Q?nKOx2JKf++RvjrTyEKz5S/9sxSBSzgTGMhDbwQwO4vVCIG/mNuhOnx61FCK0?=
 =?us-ascii?Q?asIKkpQsDEMWtTUTFxM3JUDhffxxe0AtRx+0/pMhbzz1hBCy+f7+YyzfNwjt?=
 =?us-ascii?Q?G/+fox7MhvCcCr6mURFGmCohLjZ+KECc4mEjAT9RIMBjpkJ0LwAnMkxIoXUF?=
 =?us-ascii?Q?pyVN4Rm4FdoRGhNxMjYpot/YtVpJM/EUi922AVf8njMV+jvpHooWMNdgerXY?=
 =?us-ascii?Q?TomlYXdwC/MFZmlQB4U+79ItyhmvRSmVOXkJNC0W4pQhEcN8WkyMJG+Dua7V?=
 =?us-ascii?Q?O2AMvB3tT3dKen6HiVXGsJavLFrqzrk4TEPZ2ijw10/A4eOLw6kHUdsnVh66?=
 =?us-ascii?Q?tHBSinjX8RIBqR7uke+gphaOd+NYTrqdc0iiwzIkFkxfRo8f8i7fC9xlwyrQ?=
 =?us-ascii?Q?bVnDMeHG3eHtjO2VTL/VdkFDGVYIY4zW+u0OqvCSw/hXFfQAHawU8xt5uh4s?=
 =?us-ascii?Q?MT3xxvhePaGgGkG6TtCKiikeAM+OVhnuweKBaldj+6Ccq4Ec+CIfcaXNhQue?=
 =?us-ascii?Q?3t1Q79verhwl2bNoNfKw1mqvOal9ULxIBlvND6hONP6NPpoJZirPYi7nRJPa?=
 =?us-ascii?Q?qKkbw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ra+6OC1g09EgjXdm0iLV+BuS7BNXzcoVmF3fn7PiM0t5GHhz/PoeYSnQU0BzFd1oPgTGwZUnGKPPdf1yY+O/yNH4iGX9XbB0JePBJ/xbQdtar1nxFySP4J+IQk/HC5gWTABYtRbDhPxT1kWEwmQItm8vjs5MDiaKD+GiZnNgnAvzR2Fbpne+2iUV4oB0USGVCQnVmRS9ZWuCDVDPGW9QLd5Xk2+mJnrqIkexHu2mfYqmIRLur0Nwfcl+bxObc85mh5s3PEpbICMXvF9YYVZD06bETWhKdn5Yr5n6p4C2GtnPgbyr0GXTZpKwEm1B60/r+/7TR0J3N8VR9yGzfP11njQj4mV1dJfSDVRAhf3LRXo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:yS3PyOJEjBPQEJ+5RhigUgfSx5wqTk8f/XAEETAiuvtTaOoc2K2ro9ge0+tYBnrFPdj0Qyd0H4RmEZ+qWG2pgosLCM8SL4Ytth1d8qd0gQe2O5Wcy3N72g5WeLiEFXFKdiaDZ1GQCqUsLe/scm/iaU1NvcgKRdHuljEGku4Uc1Ce18/mGnhxI9lcQAJdZ7cMyjaZXIn67SHmDfilssQxsFWeGiy6SbGkbGXtD2L17mP3rn+eRg+hCV2nHFoX6MnFqZgNmU5KdDJkPpHwA0eSZPukZYTXFjIvpv61LzlUDS4Ok+qIKECevAZJIIXaQNaek+Y9MGRpXcylVTY3ifAxSptA8gAY2w4nlb1Yvr4VVY6sUYY6vQoCSJvICFdf0amDsUR2qado1AaynlGGR3jzgy1kzYuFUuXnuzgtlBxZLJGrnuHLRfBG0rzOC5MsPmZi8S/++FztlJTMhkB7Ss6FyA==;5:crAPKkD120oB6naB3+XgRhfCo1GfiGAPnLGLVCy7Hi8pTUBfATUCW682849dskjHZdtvsHsLzGHKuEUIXPKQ032WlmwlbAD8VjazI8rNztq/8zfNFzTAxX4PCYrUrb9yS+ZIm0jfdrBfe+Hk7ny2JTOpbE/dzAknsnKyp0i16Mg=;7:aRBKZRIlFZFojJVADbeM/oYR+zCUdfeiNNDBJGVoOU3hik0OPh0dyP6hytHcNvUttdlsdpaDC9xsrOQmJLyFfyT9Sar4ErsHXEJ8IiHZIM29C8f3QqDUwloet2gGLy8yFLdewqlzmXSoOqOucN8tnFps36bCTtVOXEyrosUxnujp04xr2nkKHvTuEHyx7lzO5dqcWZa7KnoepTJKYEy8MhNTWg6x4bdJhdK4X7gSBjIxa4ere+ydsUKMKizCSlYY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:0n90ODKjJ7MTvgcJa3yDDRTDC/aNiPH572Wea2sMg0IW/Z1vqnIdPtrXIyaKunMIIPrQqGr/bL7aMYrES2XR8EXrz7K+qFtHXGjk2bIiDJyPBrA+W/bWOLYE2He8BaS7XwhYFUnW+dFnxRxyvw+PQsnu0bmEXMzh/WLSamztNE0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:28.4797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09889d42-e745-4b17-58e3-08d5f7ff80b7
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

The test_cgrp2_attach test covers bpf cgroup attachment code well,
so let's re-use it for testing allocation/releasing of cgroup storage.

The extension is pretty straightforward: the bpf program will use
the cgroup storage to save the number of transmitted bytes.

Expected output:
  $ ./test_cgrp2_attach2
  Attached DROP prog. This ping in cgroup /foo should fail...
  ping: sendmsg: Operation not permitted
  Attached DROP prog. This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS prog. This ping in cgroup /foo/bar should pass...
  Detached PASS from /foo/bar while DROP is attached to /foo.
  This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS from /foo/bar and detached DROP from /foo.
  This ping in cgroup /foo/bar should pass...
  ### override:PASS
  ### multi:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 samples/bpf/test_cgrp2_attach2.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_attach2.c
index b453e6a161be..180f9d813bca 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/samples/bpf/test_cgrp2_attach2.c
@@ -8,7 +8,8 @@
  *   information. The number of invocations of the program, which maps
  *   to the number of packets received, is stored to key 0. Key 1 is
  *   incremented on each iteration by the number of bytes stored in
- *   the skb.
+ *   the skb. The program also stores the number of received bytes
+ *   in the cgroup storage.
  *
  * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
  *
@@ -21,12 +22,15 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <assert.h>
+#include <sys/resource.h>
+#include <sys/time.h>
 #include <unistd.h>
 
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
 
 #include "bpf_insn.h"
+#include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
 
 #define FOO		"/foo"
@@ -205,6 +209,8 @@ static int map_fd = -1;
 
 static int prog_load_cnt(int verdict, int val)
 {
+	int cgroup_storage_fd;
+
 	if (map_fd < 0)
 		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
 	if (map_fd < 0) {
@@ -212,6 +218,13 @@ static int prog_load_cnt(int verdict, int val)
 		return -1;
 	}
 
+	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
 	struct bpf_insn prog[] = {
 		BPF_MOV32_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
@@ -222,6 +235,11 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
+		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, val),
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
 		BPF_EXIT_INSN(),
 	};
@@ -237,6 +255,7 @@ static int prog_load_cnt(int verdict, int val)
 		printf("Output from verifier:\n%s\n-------\n", bpf_log_buf);
 		return 0;
 	}
+	close(cgroup_storage_fd);
 	return ret;
 }
 
-- 
2.14.4

