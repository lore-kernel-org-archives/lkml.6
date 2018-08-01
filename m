Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D151C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECB520862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZKv9P8PK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YoM5gNu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECB520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbeHBA04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38814 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387659AbeHBA0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:54 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MZ0oK020865;
        Wed, 1 Aug 2018 15:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hvvgO2+GdmjlDs6eeS84Pg+svLLlAWUss8s2fLdl/IM=;
 b=ZKv9P8PKmwINUTlxe9RPnn9AwDT6tgOLnW8WKo6RaxEV8eXd5BHyiCdErYuwDE26dN9I
 gCrNZfM8oYxnVXjs7OkjdD+g2OalIFcg5Fr2ezUA/Yx5XKqDuv7KmjYcFaSxfEHqQg7r
 0F3HR3elqDtxWJV8TqJNXSDsENxsYpSGq24= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmqb05qt-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvvgO2+GdmjlDs6eeS84Pg+svLLlAWUss8s2fLdl/IM=;
 b=YoM5gNu9DZbgwwVtEQi5EyHAz9v3hMrKF7tO0AuR6J/HkVlJN8+ncDkZkB/Sr9UX5eeGe+fGiko0gMs1U/FXTlVPXwrsL9ex8+nJ4JjREhNJMo5e3hloKg1Rx8iJ1Z0gg9M3cY4CdSZ6WbHMkx8n7RBOyqxTLlWFgAHO9+mLREk=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:26 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 12/14] selftests/bpf: add verifier cgroup storage tests
Date:   Wed, 1 Aug 2018 15:37:38 -0700
Message-ID: <20180801223740.11252-13-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54d6c4d4-db88-48d5-a029-08d5f7ff7f5e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:XKZuU74gBXdYbkmYYPfwn9IzTdr9jv5EudOtt1j8Pekem4FwwN1rVPwhsmsoMmuzRsvIILTOinDNwXY0bgC7l5i3agsOGaYjlMWAZlCoPI8yWnydntSceUjeNkyAWZ7BH981wBM1e3kVd2z+yFQSUzh/W7x1uPwzHkX1U361YsRQmgJS/oQXsf8kPcEor3kDjz053XfypO3Wz8M9nWZFXOrg0T0QDTGAcLWD9tP+o4LZ9Ia/ZydFGSCtAZgbtWNL;25:iV/sgf+6UmMFHZxmsFHyW1Dkw/fTIZxTLYbB8FDzEW5qlxsBp1ctUcmGwYY0KsO5haucikuQsQO9Pl5dXaYUgfE5hwlBrcScVgj0EWOEzeJZQgN2cvIW/SP1WBtGm4QFbI5KGx+jMGJTdPms3lGcAZfAgJDJXHwhP4CIR+Ybzx25n906UN8hQgT5PgLvt3FFOUotw4cFHuE1ysyvXByyDFGlGvR+iag+oR95WWMiIGij06NJQ8JKJIsf4XLpNcmqsGzJHwF4p1Kgjxp1uXIMM2xEnzeDFv4YSyAdJvgRry+vuRJz7PmgO9ZFojM6Qtn1OWFsGvQHqtlDKDagavNjZQ==;31:TvgwHIgOA1RvBHCnDA1EtgcHgIEVJkzn+oJQSIfGyBEGR/jUf1jYW4D7F+3TtxvnhUMVeaxqZtJMos2hN22ULKPqWIdRuLj/73XcbkuL0ymSKyySFgtPotxpziEPsv2lF7q99yNFiiFw1gdiWUgHa+z5p3wTkVST1GkAiHSGpUhXHbd52NO8wPnaArHggUM4HGGm5SyFjXqEvtWAGtCIhSHACmm5aTM0XtRJQfjSA04=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:mQ4bu7ZDvOMQ/INgyRD44m7kTxaESXzlsVkAROLBEMUOGDW+6bEchW76YCzO3Pl4iF/9/zzFSlt42SkfaOGiX+1mxS1TcYSEO1W2DxL7C8dvzUzsCiSf270oUgziyTNOGx9oXEt+WTxJliy6KTUvon60Z61LHr9SyVJXuqOSIEldNCV8SukZi1rEztfISTJOHeyLe73tZLOLBWMLmwr3MbLWVzV+Zr43jio1cAC1bJTx2O/F5JXhHmGrlGvdLROqMP/yjJLhd0BXSLFO9pVI7vSDG4/g6R69+WAJsNqrtICuAxBNf8ur4YeEaN7lLi8BrCVcg2m4/IMXfnreUp0Y23Ze/crRCecYQfM+wYY7hZjJK5tGYJbDTn+cHN+LTE4A/YbsXLfcOcS1Tlp9vvUPHxQCDeAFhIBUDFSH7SnBgfR2ahkRRaa+XJ4iZ7WJ6CKTIZ0Gp8CWPvk2jf8G8mzJTeUWQj4ETi5jVJXNXOV/ZzV687A4lKVulWxTes3zZHyo;4:/EQvjsZev86nJX9phoS9GgM3gbM6dOAjx0Sq5sB2FOKFVxV6JMNWXsznIaCmCHNuHdYUZQM021lzacB4+C6i7LYYvQaqGj+CLfaR1n+COZlGr7JPcVeand8rvH0yNaC51t8+dB/r1wWn6SAjFom7jN624uPNWuyROfMjiFUU4587c5W1xum/FEmq7tpWhTWNhNabWDFfdw3uIKcxs7Dded0vL6/Mf9Md2r5aZNz9UD5Ybj/oUemc0S8oKheilXEe5Os9cneSFaw686H5ZBJok4QH87KxmP9OAToS8dWzegMRvYVDQc5ftHM1ri/+SaX5
X-Microsoft-Antispam-PRVS: <SN1PR15MB01763CEC97DCE6B2F0F1FECEBE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:NXosNKAPcfhXcEZTazvZRcS3yWxgI8AeGjme3BtMs?=
 =?us-ascii?Q?242boj70dkKbld9tHjjenPqALkQS+yBmwttZetNtjZ1GT+EspB8XZC59RqrO?=
 =?us-ascii?Q?C0BEvpfLyJh+fkkWP46lyLTcNisuR33+xU5SDNetinZTlHvJ9SEShnbjMlrh?=
 =?us-ascii?Q?f4keNRgvQH8HXMTnawNbXzJL/1PFvDNanabkkn+8M67sKDG/Hbrxryphocd9?=
 =?us-ascii?Q?BjCbMpCRagINoaHMRrb/wB1go07GiO49uLzioJg31BjOiHXGbZSq2cqc9sM/?=
 =?us-ascii?Q?2FWqk7KPjOiuTO7yV7Js+uiW5m4WbOn6eMUETL68Z8jeX1Xp3OkpmezqWWc9?=
 =?us-ascii?Q?/FYxhrYF1auzM7GFXOe8ckfxECHh3uEOp36Bmrlfjfoxa2GkQG+ZWDf5jKez?=
 =?us-ascii?Q?fqWWLJ8t/LDAzM0WkPkSFZpxbECOBaLXtwygpbEnaZQJ/CcAbQwcpJNoDiDm?=
 =?us-ascii?Q?ZXzJ4F1Gkh8Z38hkOoVDgjxM7a+Wg9U7da+SBc8qCqnUA+YShhvzYsz+qaDt?=
 =?us-ascii?Q?drIvXbmQdu9cj9dHzlvfcOlrlyb/zsWneraaWR0yqU94h5/iB4luSnTXcYvS?=
 =?us-ascii?Q?4droRVDRkcH2DOLO5DAdQg+vjDh3nyxMG8hnpUDPPJHDhIaypESOvyLtetay?=
 =?us-ascii?Q?3IP37TPd9AHVwTlLVPwoJ511EOtkrb9g7mOV4bXuyPNjWAtBpjzGBSYVkLxb?=
 =?us-ascii?Q?tAD3y3zkQMMtBB+tGbwqqUEcMh9JR9Sd6hpwAtNuJB9wK4DChFNwHquzIDAI?=
 =?us-ascii?Q?TTfDY5RZAIt+on9K8VyeRDDapu8A5egM84TiofytAOu796yvTXNFux9Ang9B?=
 =?us-ascii?Q?s9kfXtPhQT+GnjUWTe13Zf4HWaLswSiCAX1Htbux9IpBTb/2APS4M22rkKeC?=
 =?us-ascii?Q?z3BHFvNtPigMsnfINuURjnZJ6Jp01swjrobJmQSUgsrwqvI/IoIiCt54TDpB?=
 =?us-ascii?Q?rQgKEtNL+W6sjVnK/v2Snoi2LhnVTz0N1EhHO3j8sKOrgAV+ivO7IVmtmsqk?=
 =?us-ascii?Q?dwN14ys1x15krvTiHGteCXny85oIFesEbEuOjMw0bleK+UyM+Dl3vCRkenVB?=
 =?us-ascii?Q?HUoohJ9Y30DBGDZELti/iO8P5X53WJUNzFCu8f7SLYBB0ztjGCk+sZ6uD9Pe?=
 =?us-ascii?Q?er9aT4sNLsMfKEMqLphBcySq8yV1ofv2Z7KW27fQNKUmBLRG9JIplbIuhRBR?=
 =?us-ascii?Q?5pAM9cGDf/uQR/H2TLOqpIFEfp6hqyGGKGjvHcrxJ9aPb0gJTjlX+OQXWaEW?=
 =?us-ascii?Q?+XWQtj1jSbj8Cq+XyPqv0BptPM4tbdI+ISQqR3YvYXcMI/L8bzezrFBo//dO?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: NHvtLBBaxrzJp5g/4dDUii44N1+fHaYOC/agzHe8CtK3IHIX7na+xWU++XgY8h6FOGUE42u7+AMCWJhFvwsJLu2454Mrtm4huxVQwxkCzgma3Tg/FwYMVoWFulapaE/vfMnUii/KpcnTgqLOfHV+e2k/euDz+Xc1RnBuPa842u5voJntCGm0BEnhvUyo6MU3NlhrQzOMPdsQTI899r/VZxTuCWtQQtR7AMFRVdaCOIFPGgR4LIn4Zevz5sGAcw9rtvFX8rvnIhAeXEwKUlpxqJpDdP6frJoeiqod0Q+tLVOglwAUuNws1eOf3GnByKw2UAZwsZQ+0cZa39F/HZ0eeddrjaBLGqC24GkT+2JQxew=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:nPyEUOstPCgy0a0NWBuLw2MhsNk4Jsor2yFiPhEXq//HBOC7HmR8NUDjOMkjjxPhSTQXgM9cJgNCQ9pbzDf//AELUYh8VY4oqefP3mfdsIwRZb2nJxqma++DuK7PfH/i8K50O7enIRCXc2QSBVFELiw1wE2uqyotoc7ckUQcecT3vK6moX9FljoDFbVJGCUxf2a6cT6GGrFexp6QlJg5dwqQxEEkfO3qHzop50M9BE7b/RmTkx4T/GutTo8gRDcijJHMkkNimVon0wQXzl9YB7QVv8XJlxm+Q2JreWC64IZTx2O2YJmTG3uklbckDTgT/junDKZlAmVLP60RJVsEVNfpVGG1TSB5H7lKug/hHJ4ODGXwfHCXpJAqmY29IlA7gHJEvMYwUHTW9bCLnvjXI4pn4k3T/aM4oQEChM4hxbeq2oq5vKyeyZT45rCZpUNOgLpop3fGrYxgX3BXNiGzrQ==;5:1fltfpc/q6YKE/nL18k1ykOqJ2eNrTwbCUBiJYxruM29kFJ7J544hwX+uEEY1AoglEHdFvxU4JGJKDP+/GrhnDTRwPEYoGjR9QZC8WIrw0Tgn+mPhI0k9nK2BNGPZKxgBoNIaaFI5XEZmuhBhKZA6KD/MKi3Qski0miJBums15s=;7:HdCzeylgyrz/NFm8PIZerWqfHOEPZd0+9+dUvBbipWKI0LSkcdRxwu5PX5GV5GPgjGNSsnzsaj3vLfThMqQcmKe9SU2ZRBJwrz7snydsvYPStZGgZPIG3ru7VFhRBvFzBqkIrZyDra0AWXTyMC9bEwwCAIa1qkeXYtxN6I57xYxC13WiFIZW+zwd9Q6Hkg21KrC/BjN3CVhXG+PwUd5/Ku68lrK+Iod/URtlk/XGvnlMr8r6MQtoHO+8PfQkHKev
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:X5nZqxPEgcelaUPQbw8S8Dlf2swHUAXuqTVpsWpdeVHEfYL4VBNqBy3JthadswX3V42Y86Rq/AuTco3Aq35AtEy/2x12XFy7l1vWm+/gzl6r0BcxWe5C4R74vPaMAgKo64Nvpthf393cVK/kD0FPj6+scR6obfrAsUtV3G8BzC0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:26.2216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d6c4d4-db88-48d5-a029-08d5f7ff7f5e
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

Add the following verifier tests to cover the cgroup storage
functionality:
1) valid access to the cgroup storage
2) invalid access: use regular hashmap instead of cgroup storage map
3) invalid access: use invalid map fd
4) invalid access: try access memory after the cgroup storage
5) invalid access: try access memory before the cgroup storage
6) invalid access: call get_local_storage() with non-zero flags

For tests 2)-6) check returned error strings.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  #1/u DIV32 by 0, zero check 1 OK
  ...
  #280/p valid cgroup storage access OK
  #281/p invalid cgroup storage access 1 OK
  #282/p invalid cgroup storage access 2 OK
  #283/p invalid per-cgroup storage access 3 OK
  #284/p invalid cgroup storage access 4 OK
  #285/p invalid cgroup storage access 5 OK
  ...
  #649/p pass modified ctx pointer to helper, 2 OK
  #650/p pass modified ctx pointer to helper, 3 OK
  Summary: 901 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h   |   2 +
 tools/testing/selftests/bpf/test_verifier.c | 140 +++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 19a424483f6e..cb9fcfbc9307 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -135,6 +135,8 @@ static int (*bpf_rc_keydown)(void *ctx, unsigned int protocol,
 	(void *) BPF_FUNC_rc_keydown;
 static unsigned long long (*bpf_get_current_cgroup_id)(void) =
 	(void *) BPF_FUNC_get_current_cgroup_id;
+static void *(*bpf_get_local_storage)(void *map, unsigned long long flags) =
+	(void *) BPF_FUNC_get_local_storage;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c582afba9d1f..4b5e03c25204 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	7
+#define MAX_NR_MAPS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
@@ -70,6 +70,7 @@ struct bpf_test {
 	int fixup_prog1[MAX_FIXUPS];
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
+	int fixup_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4630,6 +4631,121 @@ static struct bpf_test tests[] = {
 		.result = REJECT,
 		.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 	},
+	{
+		"valid cgroup storage access",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = ACCEPT,
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 1",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_map1 = { 1 },
+		.result = REJECT,
+		.errstr = "cannot pass map_type 1 into func bpf_get_local_storage",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 2",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 1),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = REJECT,
+		.errstr = "fd 1 is not pointing to valid bpf_map",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cgroup storage access 3",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=256 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 4",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=-2 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 5",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 7),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 6",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns = {
@@ -12462,6 +12578,19 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
 
+static int create_cgroup_storage(void)
+{
+	int fd;
+
+	fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+			    sizeof(struct bpf_cgroup_storage_key),
+			    TEST_DATA_LEN, 0, 0);
+	if (fd < 0)
+		printf("Failed to create array '%s'!\n", strerror(errno));
+
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
@@ -12474,6 +12603,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog1 = test->fixup_prog1;
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
+	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12541,6 +12671,14 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 			fixup_map_in_map++;
 		} while (*fixup_map_in_map);
 	}
+
+	if (*fixup_cgroup_storage) {
+		map_fds[7] = create_cgroup_storage();
+		do {
+			prog[*fixup_cgroup_storage].imm = map_fds[7];
+			fixup_cgroup_storage++;
+		} while (*fixup_cgroup_storage);
+	}
 }
 
 static void do_test_single(struct bpf_test *test, bool unpriv,
-- 
2.14.4

