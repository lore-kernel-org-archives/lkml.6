Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1AEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4854120857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aqHGpVuF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IHVwbKYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4854120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbeG0XR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52382 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389889AbeG0XR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuK006591;
        Fri, 27 Jul 2018 14:53:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=29NOACPFayXMg25FAWiA0pHV/s5tN/evpNO4eWkigbU=;
 b=aqHGpVuFQdBZ7BtSzQQoneboSAl46mDn+/XzyS4vpOoAiOW7AVly35r0TzUX9EgM1BCu
 HTgYnQ/Hu1F7iNAYnzF3wcui8ct/D3fcVqSr2Y3gbKaS7Sy77+j6tpp66SxFCwU/0E1A
 jQ/Fq7tEYbqSDNmbNZIw535kIp8DqPCT6UU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2mv-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:15 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29NOACPFayXMg25FAWiA0pHV/s5tN/evpNO4eWkigbU=;
 b=IHVwbKYUqdzEr6bsPXJho3YhWO/1SkEj7KIMIBhptvBnhX6Gxt6nQVkEcayNx9V6Xup/NNxlGricCZq2JQA2d5ybaNbtdIVn9kJtCwv9/x36J3EgjYWjjK96qe/ne1yKb5YhV0NqlCwa36UpXJb0mP0Tiw7TzgSkTagxZMKJ6aM=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 13/14] selftests/bpf: add a cgroup storage test
Date:   Fri, 27 Jul 2018 14:52:42 -0700
Message-ID: <20180727215243.3850-14-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: d956e3f7-e1d5-43fd-896d-08d5f40b58c5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:KXZchSulSFL7B3V4GkdOC2nUM71z4QivlHwHYtk6WpS6GBpAMkytLSRPH4NXRICr2g+aNnb/CYa9s0faV6uaYj32SFaTOWvEAc9B3N2wBkAGFqP6ZgKdEufqgaH7chx7NnSKwYDO8naZLjW5UIQWq3GxGvUKNG8cg4SHSaUYlCOIPdtX+wvDgd2YzsjyFbvgTAQ82Ekk2gDArK1+jCiYyJDe9oyzf7QGbs0IU50MFdqrzLUpJEBPNug8DLYwl+e/;25:sZBBGM0e+de8Mg6NAAQ+9CZa/EtWJwe2aA26cxg3K2SfEg6yEuqsEGkeAk+f5PRnyYmVdrmwClvK3UZomQgwbfCbsCdX8VmhchxU1L0+PE9kj6OdZ3V3/oL8zGC4CyQB+V3ar5FdINjAlzd7ov7APGiZcx6T0E+8x8bWjPRO+M54/qtDwY9MgWbactQqzcgZkB2FhOMxQR9+8VKrXtzte68tihqT2nILcNy6RquL3LF2QXSLCufwX/euj/ckEfTJ7mZf0V6KAhF4aOClhHNIdJiwE/9hqNgZrfalpfNPfYDxPUv4HNAA/F4xjKfdgjalLWph0BXQiL1mMkblze4MFQ==;31:w85uY5x9tZj4VImAlP1cbkZxiVW1T+8sjFdf3KKt6cFO3QVg0WbA6nRZWTy/pjk5vSMtDmOROXYKExKo588O/0zUjpyewZaSExgNplKgflN97/ixKItSdjT2P5D5s2M9W+StFGdL/5lLBId4MqMDu+bD/1w22yuUZuTs5Sq2xeuYL7SK1gwn1mvewhc3GbvH/cV0CFPkXgxtpxyc4vzDl2/r3JiKR39I9KIUJQ69zDg=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:J5zAFgRxm0FCMBbWFaGgFwgfa5hpFaXOGNHUB2n6OhLWhV3MOItOvzcunitd6jiVcLllNK5amdf+hu1SzY6YOZ2q0jleV6eoLhmKx1R4RswpPb5lYulqa/CB4r25UdFosv2F5gfpE7M0KZtjlyNYnCEANCbStz2UclG9NbcgohS9NwNUvHZ8vt+mRAL/hXg6TQ+e0ZMeyfwoOVGmD8V3mSg24ieOsHsnMl4bNorxVPved6WaXtcmCQhSe0Q0zusejx1pawAzyz5h+2sVJGVtdC60oHhFHFhM8sUzglTFI+Q+nEWAZpF7R3GNHfUZEp05fJ8xppDZzJelyuiEfzPQp58//obtn+L0bGCbg1q5OiP+8NsOcpM6BAstAfg1RTSZ8+yeiTZ4bWvTKtA3B6GEBMXIg6EJD1gzIU3jrtH41WhA9tRNgUgy5cWi5PRlpGSJRirOHjN6zrfeAQd8lddBHehvRtvgVgpflZS11hto+sLkO5if0iFRRHp2WLi39+V7;4:+4klrZSRIFtZGD517XQlEjw5kB3jUb8I6sWbbYktjw8PPZXLRwmRbYdqBt78pUnHIMe/23gPmGnoov6+M5MkOGze6eG6prbc+Spu/8xQ7hEwKbTXs4SBjOhMc27WdUjX42K2bl+aUKbkqtDj+QxNlct3HAwuh2E6vxntbbCJ0Zu/cu74vRgsboM1lqc7bg1qzWDlLnJufBYCR46OUjJPuOZ0X/jJ/GgbjP35eM2xyyQpsr0gHYXaO7TUUocuNQYiwpLKKdj/0osUXLLAGOSJokaPFxfXQcy+s+XYY31qjhTlKfJ0xzF/BZod0Ynyi0Q4YEh0oaak1alUlbTVnzBecRl7bDM7WooHvPCoPL8dIBA=
X-Microsoft-Antispam-PRVS: <CY1PR15MB01716556A943072672523AE6BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:ytrPa8qLyOrdlK85qkuvxSsk4ptdUuAWEz7NryTel?=
 =?us-ascii?Q?rQ/sVA0pVcvrpQ/bwfOUy+hpbf6wbcIbxFCN3OvNp9xSIBi0B0NFC4dV3A+R?=
 =?us-ascii?Q?pcIcjWpWbECOeUfmTkjSrAMLOkIXQVDGoaXGrCxFheEcj3rb+2/oG8dDki/i?=
 =?us-ascii?Q?EGCWqRM+hC8G2iAZN0OPe0+aH+y1onus6D/JuyHGi1Y3NihAhIBDb1t/AoXj?=
 =?us-ascii?Q?F7dCF5+wwLCl5WsOGqTP5JwTykvU+Ljcl/fjQlG3raSjsp91YKiA3Ztwelne?=
 =?us-ascii?Q?3Z2dHW2sIyVnAWDslStCq+HvCnU0TLZDEYJWTPnx9Km+ZHhWC3A5UIKn7dPz?=
 =?us-ascii?Q?6xmAP0kthGQQM2HvIBz4It9frxaCkkd9WnZAHjiV2elFOEB0H8cFt6oudIwr?=
 =?us-ascii?Q?2Nbr7iOdoqN9DbYgeoGK685Uorw8XhL9ntYob9moEw71MZWBEThk7Xhz1bPv?=
 =?us-ascii?Q?AOkVeDG/n3tL48+t94Vf+oQbA7Ds2dS7l2+l5/hLmFudOCT4qdoTVGgPAUEO?=
 =?us-ascii?Q?R3SIAwpaI/RJAmFGAbmQkZTgi7dLylglT/BWFne5AblEgWaYmpk5sK432wV/?=
 =?us-ascii?Q?ePzFw/ec4Vp+sIgxFxDOAvjtI+1LdbX3ZJU63c6aEp3i6toYE5dwy5hZZ0s0?=
 =?us-ascii?Q?ziZXoucuExrbPDRLAhHXCKh4Y49WSvdbwbl5AZYpC9RABS0miq5qmBzsdVlu?=
 =?us-ascii?Q?HGD289X4S0d6jziGRmsk4nFW3YB67mPgA9nMowXBkJ6uuhOcuAYAiwdqrm+T?=
 =?us-ascii?Q?ZQ4XKIScfVIluIf5Lx8N0UyxYuJt8T4apBhaexrCG0Mt7ixZ7egMNlVYjcJ6?=
 =?us-ascii?Q?UBUGLg6PaslYMIRCdtqweVHQgiZ+BURSqOp1Z9WBaS4RqqC4CYdlhvaggoyU?=
 =?us-ascii?Q?tQ303SQEMTreIaQ371cAJK2ulPIX45Tddj1jTx304uniDDr77gg1ik1dr9Qr?=
 =?us-ascii?Q?VKcUe3YSJPg7xTgFTgoW64iHBdaeAVUksHy/0BtWjjIx2iIM33C802LtaZia?=
 =?us-ascii?Q?WKlh17PGYd9t8MY6JFa8RyNUmcN5dfzoNJYOOt5W4ZuTdQoYaFjlcmdpb1PI?=
 =?us-ascii?Q?tiiRxRIYywQEVN9Or4pU82pC9lYUMOduX8RSaVw6tzV5SlKRSP38WO8Lp0vS?=
 =?us-ascii?Q?2of8OnGHE95gNrsLYstnN0bHsFZiUWtYZzDykZBHOUlQyDro9MSuJBuYcHeb?=
 =?us-ascii?Q?/X8U1eiWHelFYdcITZw4ieqphlJL5PTILiE1aBQ384sbqtwFKwMWvVkflQap?=
 =?us-ascii?Q?QpjX4xqggQAJQwt60XbaO+IB9Jcia9sc4xVrJwAxrrDIkG26wUJYBdCzNk2m?=
 =?us-ascii?Q?roixe6eb3/6y5lXe+xy88AZi4DWFEc+cfiUR21cqP/J?=
X-Microsoft-Antispam-Message-Info: ry3O5+f04GtlMaHCzRH+WAEQ3Szc1m4Fpl4/0nSRQKDnrDAYBKT/SI13cfAKV89pwY9PYj0V+tmnnflV5dgPNQ0UITShGslVzOnF2VVDg4RjpiVAewfP45IWXnL8qonz/TISZctdsx8GywpGg7fpuQcfm1g2DE+MTOrzIhVz41sukD3krfylvxygBC80s4hZHLpCRbZSDp/u+1UwSmhbtLmLNybbk+dtOQ8XvWWg8BjNCRC+EpITL5LrhXzRVCDM5UM9svj+kllqJgR/WhkeK127UUcbwdfD2cn5kAcd8fYYv4WPGa2gl+Q0Xls56VvbszvsbZ8RiJE9iwLVSOhhq9/exojdtocG/CxY1r6qXAg=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:MKRqcCgFNTgNGxQj/XP42RIIgf8PsLoV3LyBai4OEa0v8omX86B5nguDwZ723sOAHSLBpVutfTLdzDFgCEhae2QChR+Soij4mw1CByXBdwGSSBhAH4Y99ywbRtGFUPBQCDGckrZ0pY52rX8l0T7ds187l2l8RhOuDjyAdyvaFXkiBsRUEA5iEXBxruFZ1+ZxrQ6FMhwOEJu74KJ8+sHsHnk3Xkj9eOBY211vjqLTvmO877I2JStw5Hk6aKk5whafM+2DQ/9i3UD3eTD1t+Nrsph/VC3H8g5f4NGunQXn26QtD9ZGrytfXTQWqj1vC+1Nfg6tu0Kj1Df/dlaKvD51pGdKHuYcC02fExRhY84Xxs8rk/zOQHJvim+PZwQmloglHoa8d6Q1u5AAweo0FOqWLkJh2/YN0AXgIiCNcaZj2N71zMRDzZuherSOR5yI/rXFgqVmGWhGXPPrERJ1cWPIUg==;5:0dQaYleuw8zS/2Obabc0VQU15MjrVHJWPmhealAfYjm3Y10uM9y8hYU+P7UDQZHU7O4iN+YT43b+/a2Re8KC3hsOlwmfUvpZl0rOKbJE0OGFBNRSRItoryYoE0ExOg2m1SomYNC3Ce1iqvceecwJ7bY4ZkvC1m2UAlb0Bgcy0t0=;7:6+FwOMlV7jwAbr/pQ7+8VzyNVMjBDHRUW1JLrdFgNzgZvyrCaXecX4gxW5nL+AcU00hqbE2Jy2mOX+5CAnrK2301zahrcXEuA5zU2bl1+LNO33CRa/XMyeY7JvI+SpePu4mQuHUdZNxCSJw8O7Yk+Bk48EU2v/J/MxJfOHl9DYkETGIK+G7GQ9GEsGEsy/QXyaJT1FJXRaqn5cJG664MCLUePGVBUsNvdNtBNjtGeXQU4gN6MjyOGKG8srr4eYPh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:8wWv6mBBvcSlRtw7vX3V5owClGBpabkWFLXebrl5Clc8OkCp7MhMV6BFprn9ic5ZQecV54TK88ypMCgw/B/1PxzYGNNeFSi1YlNMOopq/hF9MF8SgoKPSdpjVQ4uGbIdOfP06ce3LgGZadMe6vmJnTiViqRqgwmnwri9TLkQZJ4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:10.9477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d956e3f7-e1d5-43fd-896d-08d5f40b58c5
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

