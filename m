Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924D820671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BSSI5aYw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WIf1HRVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924D820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbeGTSh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:37:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38674 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731305AbeGTShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:37:25 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhhGo025819;
        Fri, 20 Jul 2018 10:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=29NOACPFayXMg25FAWiA0pHV/s5tN/evpNO4eWkigbU=;
 b=BSSI5aYwPx3ZNBSYuf9WPaQi1HEELJCegzKcZw0qfj9i7nP2zrpzgmm5pq/qFHXRxIOg
 6ZWvjc/wo+9VmbJbMgHqqp7AemV/VQhXAL4+c5ZtSPuE0EqxmlA/wa8kv4njTSDDeASp
 HGvcY6hUkXAAXNX1J1VzPZqCQfFtszSfdMA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80h7-12
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:47:45 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 10:46:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29NOACPFayXMg25FAWiA0pHV/s5tN/evpNO4eWkigbU=;
 b=WIf1HRVqFL+p+9U2zrkQcRMUmqdQr4wApO6lrYFRgCSEDBbQ758GRCgBFoPBZzVoPewdLM7VFnAznPRMLWd/A/Vy0OnXoUwZdvZa/YO8ltEbExlu5DzTliDfVf3xBEYOgR/u+sA/VmMOm4o2BNZ+lGhuhw0hNvb7JXvUZzEwv4s=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:28 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 13/14] selftests/bpf: add a cgroup storage test
Date:   Fri, 20 Jul 2018 10:45:57 -0700
Message-ID: <20180720174558.5829-14-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f794d1-e054-4b17-175a-08d5ee68b8d1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:HsA2Dec7oC06zmJ8DwxjwTPIQ9dOJZseRI3mShhtjY5CEzOhQ07Cs8DGivn2T/ibgCOZimqG3P+f4ejMS0/UbHJAIDzuNK3KcDBcwgHLHPxBPfsVgE4LOEvWqW/S1XS6VFcbgJW+WtEYqcPfj92o9F5FeLw/nJymcI2+XxVO8Lnunx0s/zssJFOT4XNo5bJqXk2PlEXAwY7I3NYoNqwST3Oi87vc9w2XIb7AbGd5O/fcJSFWN8NE3BENL4oJcRjp;25:hvmEFpIzcULWP1mCYSnrAtx9VMBc/cH5FU6LbCvDsiLhcr+mY1bhlPNEJDE+pk5nrmOySKwx9EK+t28BPnGlqxyH8zGzBTAbSxNqOaEzjJdu2sX1rcVOG3+AcYMQs4ScDRGUfUqo1/Fg92C4EoIBAv0eQK+H04iA4RAhQDQru4ylclxt/+bltgRCSROFA6CMiW1NkqGhCu0pKGbrGl57PnZoUMEVFKQvuK9v+MT4y9OO1HoAmBafzNHs8xSOFd9/5ZjXUa/uowIQqHu2pygj/vdc8s2bsp0pRkSwggP4MqwfjWxmQOVIbBwA1yn6ByUZ74hU1LglOSyC0IntJvqxPQ==;31:8LdNFVnx0V3Mh7R0CeUFjAK1kFDvpUY3CZAkJVNWrqQgOnn2yoG2M0boiCEpS84Cdbud3Er2XwqtZaYhwArUZzS1aAUUtv8zazJD65O6/n2h/jSjQuPvrjCQNlV9w9B7MUrZtbl4qOKTUr8ctxpS245FyWRq1GOA4nOqMJB/3e//VQ1bEdcYJuf5aa1NDDMDf5sPIeZLgqsDUZFC6FQk/pHANNW7prc+G7GrkRciNik=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:inoL+lOOjmz7MoHCnrlFv4hxu2ZYUiMhnXSQvh+r0hpTmasiej77NvaV+48Sye1KqmWRqCaQUfMdbj/b8IWkN7ncmepy6Zx/o+wumlYjQW5+cVV+SR6tgzbZlPOXWN0MvqtxNq/jMSx8xdBvbt+DXVs6+iwnSgXzwu2rKtjslfSv/XSl2vmW5bHmRpByH6GE4FZc4bD+b+Qudd9sb7RhwgmlRvzMDPKszZotp6m9wNlS9v3LTFWKf7EPN/zcCWMHXfI4cXHpLBQfoqzDUlJyP/EDwNAoYAUJ0EfvgvzA6nabcS/2VYfGoMrH5ahhEsCbAcU27XGIhJwtPFRC8Lhr/TImvPNkQhyPApImdDTdeXUAhFgFLsnGTbmcqcF0+ogWWEqjWM4uuPVrCCY3vV6cMVNgGn0jGfhuiVyKnwiYq545W2b4hurLsE+r7wrT5qboJ8QYQcrvv5KDczaVG7nmAdt5UAungdLceuQGo0XQaprVFpaVH1LHiGM102UqXr+X;4:GZueefIhFOIXrX/nc+Y/ZtnTkkAeSheAPIH8rUIpxG+jwIFZlPpBQBb27bQrQO+ExjrVLuKLlUlvCRSE461l2bAmU3owQveLG2q45Felcfz6BDhNyoL/E3a7Tz9gnN8t6mcJMQM/UzU8PXXP7bKwkeLf0PLYt14Zo1qLIcP+09ekqjjL6TSfg+9MUHzuP/AmHcAr6bnbB1EfvPOLxBhgsjlRsiutawY9uhraGLnL/J5/WCGKdKcBm7pFJ4Q3LenwvrmsUUQVoJiJyf4hHw/zZrh61lztsuWcxPXZP4vW0qtSuWU3XvbW5NUVAwtKaYN6nAFdcADAo59ymN2IvHgWgqLX5kkfZXEt/aFOhZkFJYw=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175B371F786CFFF4BC7989CBE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:hZItyrgJbKAFeQRtAYWAaoXVWn+AwNTOXb07HRC5h?=
 =?us-ascii?Q?oawJKuhwhEEXsLIwVP/M0fl73klsjg7p9yn8zTXEAK9rnK9FRN4cKAIhJMkV?=
 =?us-ascii?Q?t1ys9p/0YvPCd7gZ1Fcpxs/SetGg/Tqc00mHA4qDD+VeKi2uBvTq1nOvv03Z?=
 =?us-ascii?Q?A90qZCohz+WTGrVPFQWrmI6IG4iTZKoWVzRrqf0IY31kIUMSwA5yuvwgl66k?=
 =?us-ascii?Q?JAXnUjpQZ7MRE9SWlHcRjZuLtBhGAzjK6PuwZMhaPttZ/13Jxj7Cow0xN5G0?=
 =?us-ascii?Q?yXgChLWRisTdNbpoVI8wwrrRULNd0vrZv6W0Dc7A75uQuGt7TmOfMBoEzYY4?=
 =?us-ascii?Q?8wcn707tP/GNRnovHcbQhK0wspEaSdanr4YG4AYkN2YLaMCCKTUeMD4gSjpr?=
 =?us-ascii?Q?Gj5dEldvyWDcFuWdcUCrb6p0eQTRwtkAx8qsG3RHhQFm3aKnunEqHfEigu5E?=
 =?us-ascii?Q?CQqDuUVCs2A6ux1SU08aF13m630SX4sEWhZ2VNBavSgy7ktLH8g9PAYeSbWe?=
 =?us-ascii?Q?m9uytDGFcOwTW369a8jvZt8bxBlsxIrh2WkJwDmgFKrYrybrWg8LxYnDv5bi?=
 =?us-ascii?Q?q5srlT1ZWhhFHM7TT3pNowX45aVaIN3rNIFcZ0ypSEr8f5ebKPKvjLWiUtYN?=
 =?us-ascii?Q?lAYggoNSpN+5dFlrJGDIORW0Yo566y143dex+ZZaFiXwimtBwOcE2CGVlWmp?=
 =?us-ascii?Q?dofK+Ee7SK+wV5ISGMhaSxz7Z6d/2K3fANln7MmH81jDZ1ZICGQOd49j651f?=
 =?us-ascii?Q?KxS9xWWcDlCVqGYBqPGZLAFA+1QcnBP8F/xVGttZSAnLaaOlFwTTKI68/YRl?=
 =?us-ascii?Q?bQvFk0zxAOlQvkk93swU1jkUPZS3NQhw/S8ReclA65WQoRyEe7avZNJlSRyv?=
 =?us-ascii?Q?d5n90Jhe2sns+A9mcS2qZDEzyBAERUTCZWZNdScdqprFlvlhoP9pv8zaUYgF?=
 =?us-ascii?Q?jWOCmz54vqve26U+0/Xa+AwMWjwQhfteWowXUQubgyEQuPM9o6sbZRivaosJ?=
 =?us-ascii?Q?FayvjIiwvzc5qKIhSAeFOC2wChiHyENBsR2tNy/Onx14txDoEnNmXYmiCF5b?=
 =?us-ascii?Q?9s5FFgj5RTmbKuQxjc5bMfLwqg/YcnyPm1kCdFDcsLeA2x56qZD7Y9BUzj+n?=
 =?us-ascii?Q?lXmGCGrcrjnjsUQp1sAPXJ1CR9AqjowtljpkItzUvvybOCQWTxnJia1BWtXm?=
 =?us-ascii?Q?bMzGUjXmQqsw1mLEkvIWu0SuSPhqHbOzmJBdgqdIC7JEDHXdu3ybt2l40ITz?=
 =?us-ascii?Q?z5Ua/BQiH76KzWJsVrfFAWZ/r75NRsc3N8WOdnOu3QzDB57PAw19NGvION4J?=
 =?us-ascii?Q?g0o6ynK1x2C7S74COHqhzPDkOLJ7g/t/lPIqmu2Gq39?=
X-Microsoft-Antispam-Message-Info: GzftWolC43t8j2WrSuv64DQC/FfMKQxFLIUfdtGNDJ9ZkNWy88pgZ/cbYJmVuComanCmd56H1opQD99S86Mqky2EMU7QqSgALJElmP5PGxLPMJ9nkanbZN7+kV9tkIKJFk9SpB6bM96kxmF5OwdbmRw0vHiPlxheQrjer8DHT7CiNkQ8rYs4Q9ED/JtuGhSBOXcB0brWNvB2qYUDH+QvJ91dO5ERR/kSXYXfckCav/nNJR7DEZOqnTMvg8jE9y+7FbU2g8k5fIk3IjkdtvpgvzvY8RndzKgnkm1D7OjYElR7sX8ZfbaiRtKSYSC5EUWQQhp+iN2v7I78tP4hbjSNJ5Zqx0UEW3NN7Zv/8br9M8o=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:T+OUkRchLiapUUrTPBc4eHKs5rmpl2lf4CcLpTTsajIf9SHVZgl98sq0EGj9SLHItiDClybx2eu3pKtg8AnJzdARjsEBkSTznCLz03yiQ9wbSUXL46i8oa+CkoagX828y+VNqq8vnF9fYmdCg+Qy3uInb4tKK/QrWm5dV4bB2PtXPklTdpPbVBF2Wy5TIaDFArKCrgBNcLbzE1a0SN0V/bRl1IjXOx3pMrDwwdDS2ez4RGkrRaPYeEpSMXuW8DJynbKb8M8wvfZp5Elsz+Z2Y8eJZyPE09CbSIS/QK02tW8imBfHb2InHP+k51EqCnS8PYuxfU2nAekEHTblrJbE9GergiVjJbrwMcoBE7WQSP0TitLdP5XWhDfQKRB2eSFIbp5589lo2WeUwxRX1vZLBaxYCNcxIqPQuIgq8GThEt9RYkiCcNmbiATHYFM/cp78ZZ15HDprmhr62UVeOnaEAQ==;5:5tOWxsZQb5dXhh3l/WWIXC4Mbz56GpvmQDxvyJ4RFwMsKpvQycQ28sApd1pqdUufX4rsii4q+9RxoxJxEnW4Ni/45pkhsjHYWkyS4+9u1tHqYy/agyM6lUVb1lTBfosFIAgOkbg+/RHmKCmCGSdW9nfZeyeDz3KZQK/tPsruflU=;7:i2RV/IDCIvQ2Zd2tsJrGtUdmy6rC4IDnsvzfi1N667CKBV1f0cgo5MptnL4hG+0Z97SfHd7We2S/m527QPQSPzRu2ACJaRjsnj8AoezqEflDsyAhTGqcvC2cywa60LppmD5INdhmVFUyujeMiWzs/BHDx5H9znHT1gOpD4kmN0MOn95hfAY52YPOB2x0iZKLrWLvJ8unAk1H8DLiblk8zW+7s07HJhLOoJ3JCMm9umu+xQKKVVflQUF1CPL2Evxf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:/Fhd/tqG6PvHhYRCJsjiPy/PRpHZ39rrnzSToWg9CX4ayLLkBkfBvt4LRn8j8AjkSdXHlcyUGolnNlzSL+W+HhIMd3v2jspAMFqiY/DgT5EM2p3RAfmlhvOuGhoFwRFRzADdAL8lmJSAO8IBog1D57kZf1rlpAH5O6Htr2H9weI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:28.0487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f794d1-e054-4b17-175a-08d5ee68b8d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
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
index 478bf1bcbbf5..8f466af33e09 100644
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
@@ -64,6 +65,7 @@ $(OUTPUT)/test_sockmap: cgroup_helpers.c
 $(OUTPUT)/test_tcpbpf_user: cgroup_helpers.c
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

