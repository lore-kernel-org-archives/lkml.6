Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC15ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6752087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JW9kFXcX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZDOe4bCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6752087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbeGMT61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:58:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39658 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730038AbeGMT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:58:00 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DJcpc8013895;
        Fri, 13 Jul 2018 12:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=gECjGceX+g/D27H221wy5ZSl4ETKuQtv1dD7iGug5Ug=;
 b=JW9kFXcXUvA/bfPdSNRwbT/Kf15NBCptpmdQUfv7mwQN9hpnRDonDgsDb4PFOFfg8Tnh
 ty7xhRSEJNAT2RkIgB2FBnF7pV1KJvMDpNttphFlPoMlTL5TRp9GOqv1ckpsRnM8Opyl
 sWqe6tXEkCVaZWH/HFOXzyrIVo34Gd3wYv4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k7075rd26-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 12:41:40 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 13 Jul 2018 12:41:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gECjGceX+g/D27H221wy5ZSl4ETKuQtv1dD7iGug5Ug=;
 b=ZDOe4bCGh4/SOQjhR/ToRi/xrtKS4Xfw1+HqXHLaoUmXcdXL4wYiVKgw1AX87UTMxm1EXxf1gBoeI4aBVdgWUFHMuyRomwHhPMF7tvgMzcM/Tqpnod9r2OTlooNQQ7p38z8vGcoWJ8X6xtGdyEjdGObkvIfLCCkJzoBZ8FGmNqo=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:1cec) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Fri, 13 Jul
 2018 19:41:32 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf 4/5] bpf: add missing rcu_dereference() in bpf_prog_array_delete_safe()
Date:   Fri, 13 Jul 2018 12:41:13 -0700
Message-ID: <20180713194114.2711-4-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180713194114.2711-1-guro@fb.com>
References: <20180713194114.2711-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:1cec]
X-ClientProxiedBy: MWHPR14CA0063.namprd14.prod.outlook.com
 (2603:10b6:300:81::25) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bef757c-6858-4b07-2bc6-08d5e8f8a33d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:+VuSixTirp6GK4zwd3SB0qVS8AXILsPnrcS7z667imHTS8pIdk1xPUonKZ9btZhgj0XMULJ/RXtmf6rJR3t2L5bOWca6bCRPOT9o1PYvmBla7+5p7AK2egsuNnJxeBvttl4FsT6CIf9GD5GLh68HpH+oYPPigkJpEzBu+dSDA2lrRDmGS1rApkhkrqhKCG3MuztHrIX6ED274pZI1YPWWESJA7M787pqK9aQXmpsT2MaFz7pq3K+sLZgPqDXeguQ;25:0x4AUG4OI66dtiLq/fMAkJ4tn21W4TJ4jxtzzTK5+ultboWVcYzSlZ3dpzorM3eGHWd6oy8eLbINeJi9HpgGv7hHrB46bzW9aQHQiz2xXb6gXlsJP+ljpHT7LEpltnQlYIVBx5OhLcwxT3SMXRVBLUBGsVuLejyOBXsB7Py94KW1LwXsj7Mn8bQS6b/3FAk86a81tH/m48MPeOPybG8CzCu88PDLpO2vtt6smEb6fAS6dcw/D5KbXgVwaXibRqXnQfat3TT8gttMj5MtCVZ/im/8xa9fwACEB7Dl+7enFsQO9V+z6ww9o524RyXmX6Ln6qQCjIWyllfCvX8pmndd6w==;31:TzJVDhxVUcYF1BOG4/i03Vn0ugPGJimSjdz1boaC+fwD5Xf4iR2zphY9sZo5NrFpYyGfJJwNs/AgNFM9TIOUY0AH/4EEfFtLjjh4mchFLdvCXwSF8PbIVa+ID1A1Lb3YYfPtgKmAvVeIUr7sooG0OVxJ/LqQApJlKXN8/XkV7qZkKYxhGbnjZp+qdkZrXUYfncY6tqQGz0N6ThnCOmt7oMoI4oHA/tdn7RXdwhUtZuQ=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:vdD416grKG/XemRU4LEfCwKYWfvljxSPs0HytyvyeY5JgM5kiFx5Nh3QGVgXLkT2lb15pRHzTB1baxMNFMonD4PHtRwJXCJ0PnLW5Fhp1TB5DqdK1epjgjC0p2IGJx0u6e85W8TwrGvBjaDrOwZ+fXsfXvOAhRptLtfCPrPaXMw4LXXVPZVPEDY3bnjxx/iQlYDubQ12jIHqHT4/VHUMMLBVbtRou0zad91PYJUBop3Maq3IXHcuFBjoEVBE5MgMeFZZx0RwHvfrEqmwJwEEP5SRVidp51Ql22cgTJp4sjr97ylckzMrFJFxIK4AqPQlY5Dk1kXThe/SdUjxzGnhZ59CjU3IUqvHt2JthydFrMMwK1CdfMtkU4Xx6RKLmLw1bOabnkhO4qcjjBKAZRCjLnAlGLuhxZLU8bampkbUCXLWh1ON1NopfGrwSmbUv4U26D+McN8C/q/8IE9A+g6Hj6vM3BzB08xeOtt9wVNCdJRqEuXSQWvjapCJKhCSE4rL;4:GYHfWEM2yz4QHM2Z75pHChzLXn9UJiMlLBqlqsxCcD4d6sgE4hBl40heCzivO/YOFlMHwzuvybSYO/ly/olfO49y+3lAT6xwXbtBbyHajBUKZtp/q4qDF1xh0QR5PObA+qTW80NdHnNKnqWd4O8IiEzza3h9qhg50n8KR2LZayekuOw6oNp36NmRJcUvOVKWuVIQ4+B+3A+0XlpWCbiVrvfrmrNJwU7zoPy3jPHJcte2712KVd47OUkQ+k5qi+EFRkgzwQlFoFvBKyaP8/MB2Y4Flf5n3pS2W5bUjjMa0zRXUqbn+8SBvn9KOYSscvV+
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171074B8A10DECC3C4F49A1BE580@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(53416004)(52116002)(16526019)(6506007)(6916009)(14444005)(50466002)(48376002)(386003)(6666003)(1076002)(8676002)(46003)(186003)(86362001)(6116002)(5660300001)(69596002)(8936002)(47776003)(6486002)(305945005)(2351001)(7736002)(478600001)(2361001)(81166006)(81156014)(105586002)(50226002)(76176011)(68736007)(106356001)(11346002)(54906003)(51416003)(476003)(52396003)(446003)(2616005)(25786009)(16586007)(316002)(36756003)(4326008)(2906002)(97736004)(6512007)(486006)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:jDaUjqmr9PqAdFO4SgMm2oL9UJLUye1v8tP+NjLVm?=
 =?us-ascii?Q?uoMmQ7EviJ19IallUfk/IrhtgDE3JFhIEhdKd7VmolhBXLkUCczcY6tdhhjJ?=
 =?us-ascii?Q?bX/Lyey2z0vzXMKq8HT5w4DOhPSIk7dy3IUSsSD787M3oiUBwXCbhR3sq8p/?=
 =?us-ascii?Q?XPQDV2VdHOIk+CZBLg49KkCQd2jvenTGn4T1ORaQniTIa9oK4slovqyuPK4H?=
 =?us-ascii?Q?6ZSbg879yZp3rhGTDelLUoq+j3b67KCE4GqdxPKN4IduMa2M587w/X9dTXhL?=
 =?us-ascii?Q?HOlVbiWALcih98pLEZVlXHy0cKGKan8g5XbnZ9ibvuIdST0DjWFs3ZUAyU2f?=
 =?us-ascii?Q?/tB/kwv+qSrurin0qUAQdti4MY1b/+8epQtlIMvihP1HIF544EfJuMhBC1Tu?=
 =?us-ascii?Q?cPkT7F8B5OOl3rMNZKXYHcCKosEn0OpabQFKkEmUcAiVyVGN/T+NHTB90mXO?=
 =?us-ascii?Q?2eVXTYhr0coe5/QMJcMGe/HVv3yNx/rMfZmKXQ5hIEGI77Yr4Hv6IR9SrAhS?=
 =?us-ascii?Q?IpffivjFdxCJO49Z2/p9bnKFF0PMAToVQSA32uUS6Mw/jZuwxKDI+dyIlqw3?=
 =?us-ascii?Q?/Qcc5HgPGqHv1IMUlmlji2W/Nw9dcfJ2FXWktMCcJoRBrA7rTDCMfrYgXuOs?=
 =?us-ascii?Q?FltVB2sD+HLWaTuwsHYmvG5qfsHcXX3ejPn0J7qRvN6oFCLJzF7P/79VJ2IQ?=
 =?us-ascii?Q?zRpAki4EORM2R46VN7g+DnH9zdtMZXrcn6u9nr70QFpFBVcP7d0154c1YPNg?=
 =?us-ascii?Q?8qiWQziJzE4gGKhP7bgI40hGp6zmuk1b7ggb+ljkmJfEOG5RUqBsBKQ6w5CR?=
 =?us-ascii?Q?xWm661EwNeBMbwOvS6v2O4frgtvf11OdK2Z/P3wxJJa6/nr70WV3B/HoBz2P?=
 =?us-ascii?Q?U0uSTzYUfK6tPILKEgfe5YAiES+dVqVwZgl15qxSS/cy+7sL6lWbV2KaGu3Y?=
 =?us-ascii?Q?PqY1XYMgWuBZqzA1yvl69KEa68mejHlWipCYV7/o2kg0yyRIeI4OIQ1nMiEe?=
 =?us-ascii?Q?fLxVRSRRJaUpQGS3vwSWKXPz+UTzvvzYM3QNjcFYNAYmgmGO64MFgax6HeNB?=
 =?us-ascii?Q?PMLm/YO+nImpvdeWadQbRRYAbW1KB2v02O7sy+4BIQ4J2G4o877Gypx8dMGE?=
 =?us-ascii?Q?Buv4A6UuJ8Plz5f4x70W63fkH1wN7INiIOfwCqiTXQ5ICDc/raX7f81IR1yw?=
 =?us-ascii?Q?t/HwRc4ZFQB3IprMlgITMQyOEhQ2uVdKt4d2PL+s40gkJV/2UNnPsNp4G7sr?=
 =?us-ascii?Q?q3JH6LpDVF5RuFMs+s4Ta7B3oY202SvlWq051Mgn3LHIa6ehEx6fCl5G+/uW?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 07tqZMWJlvoSF2alcoU1rcH/8SxVsVyhgy5E6QllkN/JRTmpSTL4mZaohFwypcQ4LgIWDBeN7P4eFS8I62utj1lpeTFr/H+z962H9U6OGT/CcJk636H6QICcSULt2vkHtx8uFHMPFXTePGM6L5GB+cIvE6hwQSRBieo7+M2PfE/tGp50mBOqSxSYtaeB88V6NceJcPhdiLAI6pCPSqByg+pDLNi+ndX44otu+EfMMx4RB8tvnQurkVTuRFvhqyAZRzLj7Ne3RCQK8fBiCW2pQsvXIlj/rXJJ0SqI/oGokOOGXKwayKWcKBIG4in+zlKYF3IEWSbpidEk/DV2p1Emwt/l+10IEMOKftYKownsYP4=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:QtAR8uipvyUdC34gsw30Sp4nZYpexxKMUoJM7oDBScuDda69KmbRJ8GSeGuZ8DZVLeIC+ip3LC0hGKOEDWsPlTV0J6JmhHS1APg/sotVFlJOGz32T3SCws6Hm+CADXjgTMC5YJiXASq6n7O/PkQ31q/qvrk77KLDT8q3+qX1F1e6meI5QDsPT38q6VxUTAGjIs4/VOhtvS9VgmWudlFIc7Y9Cu7l7SWs9sKtXZrBBCPkdJ3qRTiw+eMXeH8unAxE5lV7Q9KV2m9ERxsJXcW8Sq0uJXgv96Fm3fFsgnzh4gP5Iv/2RS5kUL58et9NVrTNvk5RdEu7pqDvkWQhX4/IsQ7AXBs7lhEQB0TUrGTuNDRaHkc+JgpEwdCwk3OsSb+6EIW/6Sg/KIt4GftB5uX2RnlgbMGywczlRHoasYEYldAb9UxR0JE2/kfK5wUBwSipiFcEH3pTV2Zu9Q5v1EiFpw==;5:Cw2efLxgnY5/qHgG64irkczAkig42sk46DCRmzP7479Gz0CxKRowSt2vMdvxXjMiZ8p/3HpbvlwJvdqazeRyy9WsU8naJXUI0WY2BgDTMvv2/T8vQZE6KVThgXecjZGDGxk1bn6NDqkE+iXEU8kE7bBVlYr6wNO6jd7+FCFn4ZM=;24:X/i9k/ac4ORvTXq4+FNRfQene6PiVbzIuTfcB0ztux/9rU9xB+A64xgjWQBCONIYpRUbBUdVPnIR0lXYPhbVUoFD6XwX8SYiMtFU52J9aX0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;7:FlRyQ9xaHsBbmOkS3JCiLxFWtu5jasRs/k+bjASzNgcXsv1xxGIiq5eeYFGskzEnAzfzckT/0zrRZwv9cfKHjjZLCzoUVWsuLdT5MBo1hDQOq107NgE6hhM5mzkllvm7pgxVGUOxLuS58YhChPpEQfehRFk0SBHPf2Vf6GZewXP699BGHfvI7RdtIJ8cHKFaZGWBoFPudaYkAH5YDiR/F34BEB6KW8jl8f0uNJSc0lQ5rh9RLpVwlkmuD1pNobkj;20:jTmL/wmtPbo+540OXmvLsf0dTn7i+vt+H7ZA4GB88s11aY7WuuxzU36la8AGCF336tRDJS0YuFRVSh6FrWWM9JBAOz0mFC50iKmEkxkjHJEDUle7BVVJjQGGFtf/X/8cDlfpLHVdbxp4WMh6JGIQ3Lbz5ongssoHZzUNDtVZ1Vg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 19:41:32.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bef757c-6858-4b07-2bc6-08d5e8f8a33d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing rcu_dereference() in bpf_prog_array_delete_safe().
The progs argument is a __rcu pointer, so dereferencing should be
performed using rcu_dereference(), as, for example, in
bpf_prog_array_length().

This patch helps to remove the following sparse warning:
kernel/bpf/core.c:1629:34: warning: incorrect type in initializer (different address spaces)

Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fdf961f70deb..722ae6913dc0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1625,7 +1625,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog **prog = progs->progs;
+	struct bpf_prog **prog = rcu_dereference(progs)->progs;
 
 	for (; *prog; prog++)
 		if (*prog == old_prog) {
-- 
2.14.4

