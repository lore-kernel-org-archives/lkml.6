Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD68C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4881324F40
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cduwqoSR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eC50mJrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4881324F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030258AbeF1Qsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:48:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54826 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935838AbeF1Qsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGmNvi016262;
        Thu, 28 Jun 2018 09:48:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ahiCRYw312q4k7xC5m2Of6Ga7JY8tCMounxNSQKpudU=;
 b=cduwqoSRy4fdDMDeY43H3pRSQkm8jC5v+IntSRnymgwG75Iw5wkMFGCLtxZbMDBufzWb
 YKyh1uHfNY/mRmX0qZHJhqkKkB5kNGXLJ/yPN2elaz/syCc181Mm4Cp+qiw868dDWcVt
 W+cISY40Dqz1CdYmlbTJm2mUV/QcZ+iWm9E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jw2h4r8jp-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:23 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahiCRYw312q4k7xC5m2Of6Ga7JY8tCMounxNSQKpudU=;
 b=eC50mJrSj707x7DzKYIL7zBR7IwUO/ay7zqzB9zu1ZHMHloQsGM9zUNMzvBeptVdRgrTnbtFEWmGiLANHvgL3lJgIYS23xA5s092KiTaDh/3YikD3Zprbv83fJ9cv0u0dqDIvpNWCQxwutb7JbSIC79MjUlzLCSNYdbe9pbRA6E=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 13/14] selftests/bpf: add a cgroup storage test
Date:   Thu, 28 Jun 2018 09:47:18 -0700
Message-ID: <20180628164719.28215-14-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ed3edfc-dc52-4a64-f91a-08d5dd16eefb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:BRu7LIK/RX6MeLN56Dm+L9XMrQ85qsFIrOwHKoSDK3b4RIwoPSYwzY7WWZ1RvpZzeQpyA7EA6UVPSHmf78kDQ/y191huu8J1/n20W76amQK9IQkG4TBX6/Udqt3/qkTBOq0Nenz0jv1i3HSSnGJGt88Hx0iV0tqADON+grlE9QH2u2dozS5IJFYx6RhEcc8faMrVUXYK0lyLhNngG9kE6bhwQk4iT0W7QVxY62iqRWyNS062C/iW//MSOVEvSKLx;25:NWWIlo9hPzmv6zBi8n1k3LSEtgDWJm70mTouZ1iqAu0+cRLNK2+jvqSpkOGW2UZ/TKEvBp9YKFIkAOcpTGw7vuX7X7yZE2Wlu8rNdQ0uHplrImviUMP3b4/Q/mikW+3leA39kkxA0aYQCE0kD3ivin09bHNRN2lgf26OtxldTjKB2Nktgq/6P6fw7O8g86iDSaGrIg/4qpmFxopHdTcIRGBT/kGRmuz6knJp9f18keHUrYXiSJnb48+y5KSdvvBeJbjJ8pSA/7wITXSmR4E+fGbkI2rFb810hYlRu4d8kPw2oQrILP6zszFzNR91rXS44jLwsNLtHH7kjmU1NwST3g==;31:Sofu1849NNvGbc8cb1wsxec1BW7q+pl2wuo2LM4cu9X3ttrZ1dmgtI1iXCyaPi2i3wEkjNy83W3jkfK+zybOGrlVTjZWH7IcUHM6vmYeUlk2PGmbnQq8PH2Zj7SxZgyZDfYJ9WlssMjgsObXweC3QCkljJYJV9GehBt+2Bwg9cKOYKtxgT9h19A9xvs9tDHJW5GEJvxVMx81I2hCGzMU6RJHwDi2bldZCTXFbaTCMEA=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:la1abs2jBdtp9rOynVa3uurndBLrZgd7Xb7fh38xZpX9EaALhZEH4+fbpdzFkKoKESPMak27JQx1FoLY+XmgJJOf8FitZobdD5dUPAOAS8FBP+kLW8HsNx1p6WvxgYibZ98iTLKRkytrlqIaujgRg4F6HqHpciA6qGY/Llw4HiKUvEmWkZROqK2PlX9SJ6dRTI7pzQhTHAN6FRVwnQo/XX/wbXPQuAMLGR9UHl6wwtynAtHHr5uJJG0Bt8ZwaQk74j6I4W11/HyyeSH6k8nGFmX45QZkOagYUkNIvcmD9uiAbmonWWofrgdg/NfainEFU4LYiYtZrv85zoUELVDIvxwD9ZW7xEZXAxwncwJL1GCZfMIKXgURSVcbxW4++FLHyN1W5/xK2ZfnxhPrK38H2xluU5HbKP8Nmadt6gNf/z+nc06pvnwV0zmSAg16baOsxmPprEz0NckFMfuAGUg+X6Durwemx951N62PKm57IAqeRjZOVhBiCanqqgKAO77m;4:uW8Irnu6QU/DnsrM7viM6qlLTf5mTAgT7szq0TNgxrsMdnsoM9DekZwjjzF/KxNWt4v9OFHENdN6prPdaJEDohcz/GC8lVPOotBOSXij5INADGAqBrniVGQmn/ZT2nFqFXZcUTavpufgoMROScT3oENpaRLpcQgvQTMn2BCCkIxFIjRmTNC0yHQe3iizySlecN9uesqZCSI3J3Zz0m83LMT1nsrNSCq5aVJpOQJWZjpFBhL9QKFsddx46UtkyyX1sir/LSRbYPvkeJD4GqZ7UwT5ObCSJ3Jj+zuwfCbaFl7x9tcY9ogM0M/F+6ulfmktKdHkLlpzBPmGkKDT4IMiCahz5s7cDORkDNhn8ALnCkk=
X-Microsoft-Antispam-PRVS: <DM3PR15MB108182FDE66404E45B654641BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:rMnq7boXaoiBem7zfCDEnXxj+aRe8cqsSDKiVzqes?=
 =?us-ascii?Q?OAO9S2pbDn7RlDIm7vencTBA3xG/o/+LoiiwYpJqQKuhobOuHrKmxTluF1vX?=
 =?us-ascii?Q?M0Ce9p0qmg/f02ozOd4kvZo4n3xOmL4ptdeEYNdYrmAkdnAN8zwhRo0CmzKO?=
 =?us-ascii?Q?AQ1brP4DQ1hN9Ks22cjc4ujzK5VcS6tQSaiealOqPoMDGpFFz2k4zbc0oDgy?=
 =?us-ascii?Q?rNm2Aby7qHDK4y/FkoZXturl3bIS36wyTUFw4g/5a+/Lr0/MQdTKpGNqEiGP?=
 =?us-ascii?Q?07fqhgnpiXLzG3GHgC1CifShD0Kvh715PPe4Lq8EWTWl9oaWmRn03+KKWTJ0?=
 =?us-ascii?Q?zme16AnUPKL9buWlUxw1tCg+KPp7i/6+KtNW71YgeJE15utwrUYY1NnjVkZv?=
 =?us-ascii?Q?BkKV/CjVPAqsJP/dyHb7BPwK5yU37GB4re7tANoVE+3pab/+Nw7SHnU9hoPs?=
 =?us-ascii?Q?h/ZD76lYhVq3KFEet50ocPoSJkPXX4X7A3yOBpR/9jXwBq6wL4Ben92g6Xrg?=
 =?us-ascii?Q?xerYh2Nx1jA8x140eLNDWDKz+LAMM4dmdNU/Wtk++t+memf/mW1rIah6uLer?=
 =?us-ascii?Q?ma86aAswxbNWPr6zhTh+TShcTvcTaz+Y0UfPGiHe7QRv8jv1ZY/S07iGsxs7?=
 =?us-ascii?Q?MtnjT6lq8nkyVQjee9ia2008BGSkGiCUEI1Zxrj06q1udjyw61CacCUjToJw?=
 =?us-ascii?Q?J5kR63jhJwxufsTzvdpKW+4fQ0gPBHz+GwV3oQFtUGTwQwje/FCAx9NhWUPR?=
 =?us-ascii?Q?F2WLnKJRzVRTiKfuIKNcTAxIxibYGf9C3Yljz1E2xFv4Gq2phEDKTDI55LNe?=
 =?us-ascii?Q?KruvQWEP3MVW+b5NMLnc60Dbu67Quyd+dXwCBaVI+h1PL45tKlXLllu1Nc9W?=
 =?us-ascii?Q?qwGWPoAENMAbf4QBs8dytytDL60+uXWvB9WnUcEJwd9a2eg0dWKwm/63OyVM?=
 =?us-ascii?Q?q/6zLZKuKRkTaNB0htBYiq42hpmYB110sAR+Emqnh4bg1lk0CpQWKBi342tB?=
 =?us-ascii?Q?p5/hf9EoHapx6Tcg32lQHEHe8nohE0BnNAgCB2RGx6rBZ8Et2a2eT8u6pmB9?=
 =?us-ascii?Q?Ua5VoYc0/cUglo9XtSg1uP4jj4dbr+wwfOCm2zYgIi9JDolEKe2o9fUrRKvM?=
 =?us-ascii?Q?ef9W+LHD3yxkZHKmgOtMyKb667UzBfRmzhofMYf45t5luDKC/gQJyp9ljlDp?=
 =?us-ascii?Q?SdGKmXQcq7Jze5hYVrXaKdyTsO3P0fotthmWJmxFm4GZpMEpbOeExlDHKESg?=
 =?us-ascii?Q?1XhGw6jpKMoRmdxAeNYz2025VyHHxFo5wS/q9tT5rVZ04NGlF06HDTS42nRa?=
 =?us-ascii?Q?a0R9xZhidQPJ+kGEtz2wis=3D?=
X-Microsoft-Antispam-Message-Info: fqlR6kjE4SkkxIfeuBML3aS89nq/WnTutqVmNEOLN2/j+qZbQ9loXgMXSUda6AJF2Zz2WTtEplSCueuYAnjGjLuriyIO+cKpRGOonm2fhWI+y4j3WArMJ3zI5HlpZ2kV/dXdYplkCjOFv9TvzZuUFfQ/v/I/xJUuODaADkBkKPNczm4bOcaG5RP8WRDhr61StnBb1fXUrkAhBWKMuc9oRLPLPUtoypljnSXol354caVn9mq3HV7xOLAoIZ1u6q0iAec4YzpbXDdNTuDvdiuHfUyF75munJT2rOTAjC07UViWdvoxUTZpcF6uIw6MqhLMwedPBoE0pKq3XfKIoJnJNyuCapDhPoFnDS6BXR2+/gc=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:O4khCVWBnbRS8vYi6kf6sd86xsB7lMTO3oaficmaAITWHNWGbJS5w6dSSba2670N3G7HHTyStrkEJ+TqyUHAK8erPnathnNOBZAYHCjSCPQOOkcxBQVJetJe9ECrwOyOnQ8nXUU7B2zIiQ13pOWL1GlL4ng8YAFvGLpRMqlMrNCpdhmknU7Kvn7u2iJTtmkMoH9O/5yJvuhJyVjJUm8f+C6idkXkoW+r0skP1Nb+0WYoeIBN1YxdHXrcapszlgxGLBPwDt9ip0uOCfILsaGDbyqqA55lx7OSTgANAnUhdxy4npV5pYEAwnpFQeMd3HfHYmub7SVDACPNL5VErW84uCFwbJDmRoso4l0yzrh1o1ENIc8XTRukHLeS94dE4GiiOCH9T+jTciiUlr9kaqYpeKcMQW/i2YEERVHEzN57I1EvhXo3YpBqi1xl/yaL/0QXKEw+NB0mzb0nzRMBQkQVbw==;5:8g262DpFrZK2lTMngkME16Z3BbbZRoU18aAWEhq7WWaJOZetjGLt8ZXY2zTXyMemNRYWm1vP2nyIezW33HAA1K/E7mjjwDOZW46eB9j3HnBiG++PeAiMoKHRX36sGd9w7i4O0nauh6t30HzoCTupKst4JDLgDKgdtLlba8WxRx8=;24:mrw4MFTOHz7CMyQ6GuQ4eZ1wTaByn/CFmr81cEPwijNibpDjniyilDQPU9XmFXCViyVHFntYycm0J73BQ1Hvqhc/CXIXj5sNSaqhUaQklq0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:Kl2OdDjbL+8aqKMr9wmf0nftrFm75uv3ghX7r28fu63j7ABA8AAafoqAcv4B4Nt+T8Lo24/nPxC84YJzcxtXKCHYSI+aXLC2oVSVutSqFpYG319aFQIjdIN0X5+uiiQToWGl+a86ePvmoWMIArq3ghJcP2efDKSnNu/CZ8PkQZJKunNUeex8pzj+AiNcSU8A0h3QEOujKb444sLk64Mm+Uq1xSqvy3I2y+EckIW+MhYCmkN5IvRu6jHgxolPEGDP;20:S0C6TU0vGSje98ou+DvB8I28zKNW2N7DTjho4sQvCa5+thiEqeT3C9FusKx+4QwuTAjMJ1G+PEaGGBARPtogTfbliHHDwss3F6+vWD3tPvEKHb4YgTBCxQnI05smTNHiRtAHKH7P1NNHAxArsv5RdIXdgouBL3DOfLWVEKQtYiQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:10.3958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed3edfc-dc52-4a64-f91a-08d5dd16eefb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
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
 tools/testing/selftests/bpf/Makefile              |   4 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7a6214e9ae58..81f38623fc9f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -22,7 +22,8 @@ $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
-	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user
+	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
+	test_cgroup_storage
 
 TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test_obj_id.o \
 	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_prog.o     \
@@ -63,6 +64,7 @@ $(OUTPUT)/test_sock_addr: cgroup_helpers.c
 $(OUTPUT)/test_sockmap: cgroup_helpers.c
 $(OUTPUT)/test_progs: trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
+$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
new file mode 100644
index 000000000000..0597943ce34b
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
+		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
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

