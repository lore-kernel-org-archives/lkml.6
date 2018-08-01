Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B804CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4A820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QzLtBotx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ad5qTzLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4A820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeHAX0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:26:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46918 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388729AbeHAXZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:39 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LWdEd016685;
        Wed, 1 Aug 2018 14:37:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=wN4b03mUIjFj1mVVo4b5WEqpVw8p04Oc4S833N9I6CY=;
 b=QzLtBotxU/zMQAliOz6Kh5hHXe8MVoDU+12lL2gsIWdt/nWr6QPAYc4m2FBb/81f3XaI
 bE+balAlDPC1+OqAIyoBfNCKc4cMJBBgbZIbQ6Ppmp0IbraoUcd71DM2qGFh7ZuWaMGA
 Bh/VsvPCe+EAU/+gXnKcNg67c6EsP6NSnwE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkj980fag-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:31 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 17:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN4b03mUIjFj1mVVo4b5WEqpVw8p04Oc4S833N9I6CY=;
 b=Ad5qTzLae2FOuNScq1rA0QljdOcOKWhZWp57WiTSwZkTALEfixw6B2ArYgvpTfg/GQnmB0KNfDQNiQjVN88xIjXtwYVMY4fzNfeXE/BNpW3sX8QKISMkLn6eRaAYYd1d0rYJrnlJDbnJQymIckRIafs5UGBexYdp0jnZs9e75WY=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 13/14] selftests/bpf: add a cgroup storage test
Date:   Wed, 1 Aug 2018 14:36:48 -0700
Message-ID: <20180801213649.30751-14-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9a1b9bd-6161-4fca-f343-08d5f7f6f90e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:zQ4QLi3gbMQOYTtu83t7TNS5ynJI9cE4QrZ3p/vapdrLL5Mfs3T3b+Y4w18byP5NSRAIuDj1nSXm/d9q8hG+/qDKlADhH53gSDaRN5WdD5O+pCiG4zRBej/eq245VBOMbUkJd+SBAVWQ3Cg6c7oU2HajxWInoyG5XdxKDdswaEUEUHkXfhRiRXFOmnoncBi3WehHaoO0dfgy0LaJMi7nQI1yDRwsu3iSWEikbaEJF9Px/rrlnvng12U5STul3ZxW;25:jZFFqmpFLpShUlKxXrt43aipJL7RqEQc3qM5egxtYkh6NkjXlEgxYJPOdzmX4srMjdCvTwhYHb+kPO8BE/gws73fRlG6Kgv38gRxChRAD2T1QNqHu4Y3t3oi3PtuGzBMbSOMK3dV28dAUO4ordeF/zY7Il4TS9AdV4L5n4YeHIlEHeKB8k+Jgx80JQv3O2+xypJFI1OYkS3ccBBAgPb5nhVD1WOSXjbgCyq1RoL7j+K+ERbndLfQeGxIJCScU0PSWoLNTZX3XCd/JoV112feM0nLT4Yqp49nr5xNP3I84N7wzombnYoGAVynaUhj5rD26wrlpVgBqRxvap9vLMjpMg==;31:sJ+U02MTAL72qnlfp87EQ+coXqYtyLxfMuo2Swb0LjPr01XcoWLZtbP/jaZT1vpdQ0IY2EaANGUwyFF/iAxHPuoMJlD2qfO/2GULa/p/Gi6n1m9+CDUxxSCFyi2fgTFgckGjYgRCt78F9LGLdJerzuj62OOgmAYQuisddnlse56q+enOPDsW6306hIUHsGP4uTjX7QgDQS4WNEOHf8X2xdGack0/ILu85lm6T3gta8c=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:W37O5FgfMJDzTWMycJLhIP3IkQY+u98UbtEuVwvGVGVWUTNQgqgiaDG9o/wGXL28QzlZwp35RUMUn8SHWkCHZgPLSOYeb1h5W79XEG4GNj4yG7XorZkyrz7EJXeHFbvmUK5scD/wo1XodUxfveHlqryacm9k6ngSPppM7ZTcIJNRB5Pw4hkugbNpLgJ2QPL9J1RjGTDXVrWGGiSTNXRIY3X1jOfjnOlx1dpbcFuArrtRq2VTZ6it2ANs/9tlPEmSd9mXrH4ri7LcydlK1rq7HVETnKyQ9nVVDkr4cN07KK8cQwdkqTOhB7QH/lH2w+SjcaV5/JNBsaWv14YZw88BDX1lEuGnosx8Z1h+219sXxx5djALQV+nm1IfxVsm44HN7blhka7xLyuPT38Pj7Isy/WS82jfNui9Iyr1VOh3tNrl2M9d1s6wp7+8e3AyN2AaGUi7dWecyTlFsUfmrsh3R07ZanVgyf+HcQeUXTe73E9gSVKOcIiZMgqNFBtOS0bc;4:LX/cLFT49da7Qni72xllRB65MnnCrSoHP3tfE+ZxG5EoP7iTZsjSp8Qyr76c4rItlWYWIG1TU5r41Ue0vequH6rCq36n6CBpjK5RR8f7yLBemmXPHcURIZCmqDAfmZ87Rl5n9D6GKU82dyGWj3ob0TccB4PxdDPSnGmWZhtR+BHBuytDckiUknPv6zCuunPFqakF4nj27gQOtqvz4vwRRImJ5TB0JRa3/mWamrt2H+JMgT2CSH9qrl3grDIhweEffnLj19NudQ/Oau4ScHU6fVG/pfL/SpnYzANwEBE1XFaiU1bmfO4zu0aq8Bb8YDvZTKofCzit2HvROKH/RChLKa7uE//msUs0Dn7AHxMoKMI=
X-Microsoft-Antispam-PRVS: <BY2PR15MB01672EE6E890C24A178F5567BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:ScHZdlwKIljfHBYHxCSsUx7/xnSy+Z2vjGFpCZYIq?=
 =?us-ascii?Q?Iq8yALH3ItdWb1eyloxbrsG1PpHGucqHeoKjIuGnaQyVOJPj4Sp0amH9lIXx?=
 =?us-ascii?Q?rKcmKteJGa8N3qP19cZ0DvYiWFvMflRQzV3xmrkLprr0loBKaA632bwn45Mz?=
 =?us-ascii?Q?dP1+rIiB6O9cKIow0KGCrcuve3Lo1bDy3hqWkiiPQZAqigM6udqMcUIlAV8Y?=
 =?us-ascii?Q?kFToFc06E8b9QqquyB2UqvwFmfFYR7MlCqI1EhDyllcSBr2rkgre4jpEI+vr?=
 =?us-ascii?Q?P7v5IqfAUCrcRUE3M9x80nOIBOBUMUYN3wO9akVqL0jwhDPlCKErqDWXm9NP?=
 =?us-ascii?Q?CfaS3OJEksW9LCs+bG14tj1M1/yjfQqtcEksg1jqDWW3nWOovRTZ0m7Fw2rF?=
 =?us-ascii?Q?yLh/HulN/9JNykv0IJ+f+P75p+vsmW2EC7GOTxMeyBgVxDVndn4XaT3KizGQ?=
 =?us-ascii?Q?j3S+e/jxOT+Xr2giHtZ64jfLq8J5sht7AW97JcYgBLIZiyBo7Vg9tpATZqxX?=
 =?us-ascii?Q?3qU3BIWcjuge1dz1hC9esNuhBu+X51lTAcF14GAWNupQGuw5uu2SAeex3owU?=
 =?us-ascii?Q?fR+AxiP+XOcwW0hi+McS5RPwcU3MnbttRo1UGiwSI+KZXCoM9rEGmKFU9BcI?=
 =?us-ascii?Q?TuAkXzKLGc7lURDf22cz39u8WEcZg/V89bZk+Y3hmOJDFR2Pl3ZnBAO3UNTR?=
 =?us-ascii?Q?EwNra5X3gAB+sIxTJDM89ePpDcmfxE5n3h8dIvR0dyc2X+d5riEZ52Nz+11t?=
 =?us-ascii?Q?cZsntXvMXsAu+I7vIwA8BN5HLBAa0ZTZIjsPpR69n1X7yIzagbNX5aUYcaC7?=
 =?us-ascii?Q?r0IGzD+QjDBJ6dCQKuXfM/7g1lMhl1ozX2ClQeIQ9QXikW2MqO7dYCayBsuN?=
 =?us-ascii?Q?1XoBUyQAx/PL1jbiIHetu23ZujQFzMrUnG1AvdewKoevVualAG2RInFIcN+H?=
 =?us-ascii?Q?Je3FBO+5sb1Y3YuyhS5k2V0mwGLhi65giQ9NoHMMIPBqDMYHfFLBO07nTs0V?=
 =?us-ascii?Q?hL2srOXZ9/EVvYONdNLzbq8oB4pHPfqG+QXEgWgFtz1B9wgDWKTnWBpUOXxw?=
 =?us-ascii?Q?QmtdTKorkt6oV3cwD4DXunjHil/lRa7Zj2yuaTuiEvRy9eJlKuI4FBfc9FXU?=
 =?us-ascii?Q?qRTiWkRfWC6PgNIE3RLR7343glMdaGdFs5RvRhrwTJEDycMo2Ui4kGnUzTP+?=
 =?us-ascii?Q?rQ/B0XQGjBhApEuJw/yx6MqQZ4ynG02iMrtasP3u2iqn0GWHrYN9iTd5GrEa?=
 =?us-ascii?Q?7jZoWqAynymU5MVhc4i4va6zdKgMZ7UN1g4E/7Y7f5Un++zifu2PAPPvqa/J?=
 =?us-ascii?Q?2tiLfsCKiEgPUrkC9q3DKVIrRCJcdNcO3iEs0ISya+5?=
X-Microsoft-Antispam-Message-Info: YmAEOarpif20BsKasdZmyrc6KA6ylfNWyU/bb59LTIdRt2KoyhXHDxmC6H3l7IUxErBMR8no8pGUGadtOSLi88zGeEqnnQNN7+y2xNhBiNtIIa70qyNsQIjm8DyGMAdWBuEfSMTGWUXTTvSedWYX4R5zo7hwSa/nhK1r1Xn6LYg7QJOqY/aHPC0Q0JETyjpkxb+bNISTOYbwc5GqXWerUjSwj330Iw6yl7kc0IcyFGaZp2JFRRLW8XVfEIkZCJX688UVK6cgLHXAM77HAHUS9XdFrjl+gXoIyfkBwF3FgMs5ELm11JDBp6x4CI4S8Ex6pXpQd8MCrouorVJQLp5AnwbdTaYv/LIR+l6nV9ABKIU=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:pZM4m0Bkoa4sLdaQYy4UDRHcTXrzDthBDujzDfoCIhWizaygHj2QWiiKYDzfvsaHhkuxJaUhC6zFM1RE10B/eys+3Gh6Uy+hjnyIe8YDoqLlGWvM6FtEXI3mgei6QJwmjc6bEQftpiIs3TYrstjWGbH5MSWjdcxtBOEY2N3vko6kEFmJazU2TnN0qF2Lzo67wcn/OwEoOoAa4t6C092P9Oj5IgHS+4LUfgxE1/WW0LQdpLWNAzjK9ElvkDn3we/spKrwcdKJkBGdF/3WrwVt+XuhFRLjxXez3QqmpV9VxfM7q3rKvu249SL4TKiq4VHIhoK4Y2+Gm2dSQsyOuvd2hXwy1vz7ZAveqRfaVy1w/p/jnHl4SRuW1ALtkA5nhqqsBmjNlKMe7x/gOYaetfLronXd1hUqUgtTByv0u5ZRFT018tZfwWEXugg+gELvsYuNiXMif3uOtlC34esMvwSRmg==;5:FirLpAEL8bOak4fEbCn+iuJfSI1Z1dfIUP69lOgp046322am5tQcQ3biQzcozfDj1qA4qxV+gpmIRe6UwLoWj/EEnkwpErfM+HXhzPqTD1YgI9NUdk12irJyArjWlfZSXbZn6hBtmdPqpIq1XoE7afz/jrgtwiLrrcSqBLlrJrU=;7:cQNkyRZ+ITsePWQcZEUGC7huTI6LbOgGT505AYkrmHEsbB+g+gkkL794hlcsKsMu14KBtIJu0xH5tr+Dj9rZFO9TofSOfKsOdXBQYHOY6ubuX5AQAwlP2jV+aoIIJXOTIsGn+sDXv63r6RVA/V1r5+nZ97L3pDOrxviJ5gV2zv+qdJmJK001chJx5QbZ8yLrdcNgQWkXheeqfMwGEfsREGbZHUkT773g+tmIXeUEEf7tQnMQTrylxHNCVzrhxkc7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:gApcVMVUZhu68sAn9Ig/w3kmEIwtppg1Nep+8QzJmMeSEFE+hNBLUYO1IvCfSHq77Lda0t/vFVQWX4ralZNUUObqjZeICsPj2G23EkMDRYZSTxArbJ+dubxkloVUNOgniRBaCLYdle8elmcXV6g0JjS6jm6U9rr/NnsoyM9cafc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:25.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a1b9bd-6161-4fca-f343-08d5f7f6f90e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
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

