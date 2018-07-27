Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35434C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C9820857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CWXIV/0x";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MR7AIao1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C9820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbeG0XRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60018 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389889AbeG0XRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:23 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLiF6t032150;
        Fri, 27 Jul 2018 14:53:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yctWBOVu0zjQhPi5ZGQ/e6bTCSXmwWKAzTUeVIJeOc8=;
 b=CWXIV/0x515J6+gnSeQNOCmm+sL4ZNiGINVi1/DPizw6poiFiYL3JhJhffkMekfItm91
 ZksHKRUhzn1ODDcLSKagu/vYnhPIkEJxsNoH6eWTny/wsYyMCg2Y/KHuPJLa6RAjrQa/
 m13/DjQ1kP/k1oerK21pi6ikNleCPf0Xc/0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb52r2t4-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:10 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yctWBOVu0zjQhPi5ZGQ/e6bTCSXmwWKAzTUeVIJeOc8=;
 b=MR7AIao1MqhL/u+gcvsLeamO+OszggVN/hH7MEL0uoVu4df9Mb0TsFjd9V3RySV3DgoN0Nw37U+xmmhvLaF8U3Kq4iKL4j+J9GP67ZHKmEvOs6kUkTuTCpbuqbCq/AJy6kxBO1xWfmzlfwZFWMogHwNidj7MAiB7nrl8EBcxXtU=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 08/14] bpf: introduce the bpf_get_local_storage() helper function
Date:   Fri, 27 Jul 2018 14:52:37 -0700
Message-ID: <20180727215243.3850-9-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 981ea07e-bcf5-42c2-9c7f-08d5f40b564d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:IiyWO3Wqgy9NR9Qbvnl4dRryLY4Wnjtogj5LUgqc225Ml1zOlirOC+bY9NNO6bOC7cf4EQeNBRy083Bb81KLrFWXmf8RMnOWvxWF11lhYNTEji+nDEtOVKT0HcyhJw0300TZ1914IkIHSWyVRBiojYq/6bqgFlxBm8+hWWBjnwhCezG34gUvWS4kO33yZ88eXogsvzN+265QQI9h5w0DW9xwsGj9dzUxJfdZDJDFFiHqIczFPmJCr6/uoHiotOIY;25:a65mSWmKr6kYpvBlB+lJL4Tcmr55/qKKp7b2gGmD32gQ0p/G/lynDpgldtGp23+JnrFX0EiusKEZPBTxqbHrNkJJwnVtznKKhKQx52OWl4Fp55Mxt7Y6JfQ8AEJZQvHAbkkOf4pCZNwFX9bB2eXWHsHCFRd8vNUmGbcNj+wpuBnYml2MqI3h4t1aTjM5V5jPY81xYPqDcpkhsA7F8ShSlPr6UWI7rmXrmwgG3Boqo49duGNv7QprsCHN6Bq8cbJckuve5Mr1FyJcaCr2PcUIxSAGz/cv3JHq49pu05OAC4sdZ3E2cnZJME/riTSG2sr/CaekH3GSrIMJYGVg+otoFw==;31:2JVqdbbEPD9rWn+V2F7afFSC4BS+PWkBXVaVltHgu2BbxWTwORrfJOfplUkdRdwRHEYKitEBznt4fUeRJNu+TxQr/TnLBKl1/7jXzIurxBuDD4Q2JL+2sBbXoVGuoWZqB5d47bcpzTW9wctDq83FuIq+nZ68ncoQtUN1yO/aTwI1wF+8uqWpv3XYLNZVHvm4jFQRYL5ys0wJsUwAJuEpxx8jjdf9fjHKfQNxFLPRUhQ=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:/a+lQoVUvB4WqGQfhAcpgFXC2BvllI6yJa2o75vsdjdsD9/9bKr+65MN+OZeIDxiLUvyoCLfZYkcPmz4gJ8FsVgu2qWSHGHgSA7riPpCRxZjdGgcfCe6ucWq+x6P6xuvQYHft2ukW1NmllItiEGVk0jnW+7zbtdnCuhUNjLWyhmTNUA0fUMVewq+3VyhKlCBX+sASAvrC5ALwzs6BH0fUGiRtCjb8xO1ZIbRToc/mA7HQjLFZgKKmUGPFeKPiN+hqEgpbtaIJLD44ReeZv/ujLHLq6Hw+hu3VCzxbFGugkbNNLtn+YEyhuKV6A/wDoQGTbyMV08BfBUdy1nrx5gJs3zU6DIgnWopmBXtw423MGi/LuFUW1lU40z681rXdp4BiLUV80FStGd6G9iccBsuKi/QscOPtZSNmUwcNPhrZFv/202GYo7WikYS83Nz90hx44mfHKk0Jk3KUis05EUGq677A+dGHrR7EjIIDUatIm4G+cgnNIbCePd3HYEh7CVR;4:VYsRK7KY5i21SLEdcn4q4zgxMifDKeU1ycclSg80h+VdwR1iGlpQbeXxUk9sLh9UMr93EYpTPcQlfjNpyJ3g2xHckE+6onHcFfCMQsPxZnF1AAS+CkvPkEPR/Ren6A4vO8wnOV/ru54xkgSlmBHoaffLNDmCbMY1vM9GFksqY6ex/my6y9wM9B4GuU32RKohbvxZdTerB4SRVvTSQwUaPQoXXag/UVDv9CFFoX7GoP661Z4aKRKs9XrhS1miAGi9njb4TqgHfoB4QecTSLSIyqRHVhTjJkgrczdZ02KqFq0Bdcgp1QQ855nePVeb3qhWibb1qSSFz8d2OaiHQ4jEw4t+MkAnCar5buH2f3GYMOk=
X-Microsoft-Antispam-PRVS: <CY1PR15MB01710FEE879F634C7CA0BCD0BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(86362001)(575784001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:HZ65bMB/McyO7faNDv8/52pcwrOwjJEtG0IVkbnGa?=
 =?us-ascii?Q?p+hEpRg29tDr1RmMlFhybzE4VymmlQe0iffpwZ6ULZUdGo0Dw+MycOZSYaYv?=
 =?us-ascii?Q?YBO6uqBGhQMPcvBpNGadilYxb4pLv1lYdggBx9AjFUTKCQ50JxUQ/tP0BVkE?=
 =?us-ascii?Q?vXrej9k7YD/fwDElga6KpajjEsRdHsMdAdOVAdFtftJ1vnDgldohFKze8pWS?=
 =?us-ascii?Q?1xpn3/yREHUAOzy24sFs+gIKmQzDZflih46jdPsokQD9AXiZAsYo4Cu3AUd9?=
 =?us-ascii?Q?xhqtHWGlfta6tUisXG0tcXVeXiESZOiW4js8Qk0NRbc3UdegspU5+q3weXn0?=
 =?us-ascii?Q?n9qum/rAzST5Ba1cCE/ZTBk/C/PkAGrBo5pvwqRjItN1SGtiPsjKt1dRufCB?=
 =?us-ascii?Q?TDxCl8unLVGXFBukRK6UpKBBOc2FZn0Po6MMpTFm+tJz8U6OL+HAYecPoE4t?=
 =?us-ascii?Q?8g06kI3aqBTf654u/M9OqLTz6FiEBjPoS/rk+b4PXz43NSs1jGBeHebRttT6?=
 =?us-ascii?Q?hgUvhdr7i7dIuT/+MDAjzmRmWjD4fzOemEhOMDqsvaQNlj2K9G87DNuIfI2S?=
 =?us-ascii?Q?AlPLNjt8ciwXKW+tgoFFd0f5Fi/FBfQ9rn1kWmVnsmnd/42prd9EtSC8KsI2?=
 =?us-ascii?Q?el59T9qpasa6qDdy9XzvCDGbvoyiQnPScHdDdN7lpBBXZNgq+1wWzj4lHdHp?=
 =?us-ascii?Q?Iy8UUuHkhnSrMXa2bZp6CNaQDCWfVle1Tw498Yqr2hTl52c1KbEC1+sY3xOk?=
 =?us-ascii?Q?F1JBtvXQeAbtLdbc47ScwOx0+Hpea7bypho25UyaUuWSre3hQUlZc5yYNSF8?=
 =?us-ascii?Q?5HQAOS+dkfSD8Y/a0Y/QsYv3xUxdDIvXmdD/B0aSBceujxxzznhs6+VeJQBN?=
 =?us-ascii?Q?VfwISZrbjFuJHqq2KkLQGTEvJmyXOXhH4DVFytySmLlzC3QVbydsrj3Dyipo?=
 =?us-ascii?Q?Ow+NJjkHuzQqmgo5E62AoXHJdcFC8M/x00+Id3oY+vK+iPwQ342l0wHhbkB+?=
 =?us-ascii?Q?wnlf+9MlS+NNH/kjiDru72cUwMyKObUn6YnMVd0RCVF1kdMOxiXNz9tvCR8n?=
 =?us-ascii?Q?vDW9/XpJJ47V8ox34N9AlLTzwyDz+E29/g1+Tsyo394DMrgLZjXwkuySrW+w?=
 =?us-ascii?Q?SE9oWMS8yCpSG/th80LG7g8Ffd6V2S31X/h618fCAOUn12xtvSg4T4l/ELA4?=
 =?us-ascii?Q?bgsXJBlYntzNifKWztZd6lOkk7ZQUzZOQ/O+QnCSf5FBPJfgQYY+zzF3rRyr?=
 =?us-ascii?Q?j8OFA8s1ZzyV5395lMEN+ibKkj+L43fJ6zYd8UrzlkF18lkmFzMvKObhLaHt?=
 =?us-ascii?Q?odsmRLQPb+03LYjn3HLsCw=3D?=
X-Microsoft-Antispam-Message-Info: sBy/AczlyRURgiGUSmdh/g+Qz1Tax6eNhtCq1rR+e0JkMnmjiKyHkVzbqg0hi6T//TtX0Egy4AkZk0yy5AjA2tMXl+K+/G921OzMFuUdki208gkA3hyF0LO9BrayhZdtz6iidIhBCpmhJ/7D0Xog7U8F4aw3V38Pdf4aelXVZ7cv+0VS9ikD1WPRlwh0oU9M3WTLYlnjgERnr6NxPr1TKv8/QXkwTrrv4Qip+SkstJ81MHc4seNiT2imNujlouPQ9LQGYb8DlvJ/UQNxUWSGx2r8k7fUY1DDvkJg/CwyoG1qXhEL00uhnbOcH2m6fgDqCxKmUyI4rmwuI3FCOjGG4yupX6Ho3E7HQMKLIzHZzaU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:YTq+brNpPz1+tKdzMJiXxQe4cGEXlVRmONIJr0xHglDsctkAvZV6DAlqTwJuorLfogOJhyjx0wjRlkl2k04lM60IW0u3ZAqFe2PTG2yPPlxU0c2Ge/6r3WlyNBOEXLfIrnevl2N1wYSMsZGlOLtx1Jf7PhMCapj/Ar+qZjt43R5WRIX7fZLTIgmmbfWquSELqO2sn2qk9EOqJ+5/csxjPbadEcPTH5Xu5EwREm7crAM9xKBosQHLyFFWYyta7XXPmSJfSh/wTfR0aU6N7Dh1xx8ls5jpWf68l0P7Gca6PJZTBx1rlO23BlBsRB0iiL33F5PZgfQKZeygmyhX/7boZ/RZ/T2P71dfD00NGwoKDT6lvDRrt19hWpegHS0ITEnqKKyIq1paoSFmXTZuPt2k1C7X6KZxIK70Egql80Zp4tY0vil5Kht1jNIbUujmPH4K9H3iUrjn3NK0v5g6orzhsw==;5:8KYa8vTCJLyAZO9IcgrQ4HjTPLbNnoau3SVtDs2QYSHl7FJTj5EZgr+TA7aZI80Ezy+hkjxHhBmP5ZtOeiIZZqzTbV1hZOmb9P/JALUKUHVPSLqyasEYys64AWMO6f4kLT7ns64PR36Zgb4I5DCMSxRlxPjlbkYwdUTWdyAN8HA=;7:ip7ychXiSB6BWfdm/bbJ3gnTVz3ZacKb2RQ0uFCrgkGQ0zvE9j8EXREzU461lbnArVT6HdQT3yPzrK2FpDlhx/GSkUAK/BvmkVnbIkzGFLf/OPYR+RfntWytCa/TBrUdEimQ8l5teiBqZZPqdFZEo+0b6KcGdi352n2kDGFuxk6bX1R2+ggzJ+In5gxKkEQxRs3b0RSzK3JfA7w/X9j9xqeD+hdFtmOv09O7MIPrVidHKENqRgUwd6of6GhgaI0Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:HvsczQMVuLjRXd9XsnuxSZhcHAvGObCGgZ9FJuKAw/ZoolKgs2MBA4Lh1dQGf8R3NkNyU69X8V4HApvbaPMTaDWzSjUJIW3fr8plGBtGhlpPK4t+yQxUwHOCJb76bqI0V+ebIQpgnzcSKJWgGSRd+K0unn4IJ7EcXZC5B+H7t+c=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:06.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981ea07e-bcf5-42c2-9c7f-08d5f40b564d
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

The bpf_get_local_storage() helper function is used
to get a pointer to the bpf local storage from a bpf program.

It takes a pointer to a storage map and flags as arguments.
Right now it accepts only cgroup storage maps, and flags
argument has to be 0. Further it can be extended to support
other types of local storage: e.g. thread local storage etc.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h      |  2 ++
 include/uapi/linux/bpf.h | 13 ++++++++++++-
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/core.c        |  1 +
 kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c    | 18 ++++++++++++++++++
 net/core/filter.c        | 23 ++++++++++++++++++++++-
 7 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ca4ac2a39def..cd8790d2c6ed 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -788,6 +788,8 @@ extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
 
+extern const struct bpf_func_proto bpf_get_local_storage_proto;
+
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a0aa53148763..495180f229ee 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2081,6 +2081,16 @@ union bpf_attr {
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
+ *
+ * void* get_local_storage(void *map, u64 flags)
+ *	Description
+ *		Get the pointer to the local storage area.
+ *		The type and the size of the local storage is defined
+ *		by the *map* argument.
+ *		The *flags* meaning is specific for each map type,
+ *		and has to be 0 for cgroup local storage.
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2163,7 +2173,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ddfa6cc13e57..0a4fe5a7dc91 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -684,6 +684,8 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_delete_elem_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9abcf25ebf9f..4d09e610777f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1795,6 +1795,7 @@ const struct bpf_func_proto bpf_get_current_comm_proto __weak;
 const struct bpf_func_proto bpf_sock_map_update_proto __weak;
 const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
+const struct bpf_func_proto bpf_get_local_storage_proto __weak;
 
 const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 73065e2d23c2..1991466b8327 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -193,4 +193,24 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 };
+
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
+BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
+{
+	/* map and flags arguments are not used now,
+	 * but provide an ability to extend the API
+	 * for other types of local storages.
+	 * verifier checks that their values are correct.
+	 */
+	return (unsigned long) this_cpu_read(bpf_cgroup_storage);
+}
+
+const struct bpf_func_proto bpf_get_local_storage_proto = {
+	.func		= bpf_get_local_storage,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+};
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d8d50b6a73d..0f69f827ff9f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2127,6 +2127,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_current_task_under_cgroup)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_CGROUP_STORAGE:
+		if (func_id != BPF_FUNC_get_local_storage)
+			goto error;
+		break;
 	/* devmap returns a pointer to a live net_device ifindex that we cannot
 	 * allow to be modified from bpf side. So do not allow lookup elements
 	 * for now.
@@ -2209,6 +2213,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_SOCKHASH)
 			goto error;
 		break;
+	case BPF_FUNC_get_local_storage:
+		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -2533,6 +2541,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	}
 
 	regs = cur_regs(env);
+
+	/* check that flags argument in get_local_storage(map, flags) is 0,
+	 * this is required because get_local_storage() can't return an error.
+	 */
+	if (func_id == BPF_FUNC_get_local_storage &&
+	    !tnum_equals_const(regs[BPF_REG_2].var_off, 0)) {
+		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
+		return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/net/core/filter.c b/net/core/filter.c
index 104d560946da..e681148e9c25 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4766,6 +4766,8 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	 */
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4788,6 +4790,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		default:
 			return NULL;
 		}
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4810,6 +4814,17 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static const struct bpf_func_proto *
+cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
+	default:
+		return sk_filter_func_proto(func_id, prog);
+	}
+}
+
 static const struct bpf_func_proto *
 tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -4930,6 +4945,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_map_update_proto;
 	case BPF_FUNC_sock_hash_update:
 		return &bpf_sock_hash_update_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4949,6 +4966,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_cork_bytes_proto;
 	case BPF_FUNC_msg_pull_data:
 		return &bpf_msg_pull_data_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4976,6 +4995,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6780,7 +6801,7 @@ const struct bpf_prog_ops xdp_prog_ops = {
 };
 
 const struct bpf_verifier_ops cg_skb_verifier_ops = {
-	.get_func_proto		= sk_filter_func_proto,
+	.get_func_proto		= cg_skb_func_proto,
 	.is_valid_access	= sk_filter_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
-- 
2.14.4

