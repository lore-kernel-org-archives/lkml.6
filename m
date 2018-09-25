Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093ACC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A210D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BzJijJHU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GgeQU0++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A210D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeIYVaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55116 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729761AbeIYVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:08 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFJSSH031178;
        Tue, 25 Sep 2018 08:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=p+dVjbAFlbbxfTqgTz9vWYZXVkx6zfSI35GpH9ssvmY=;
 b=BzJijJHUs9eljwmcfwCNr5pQHK16FxVccuY3jpj0IWUB1o25lmXv7VH5Jy8Y6r02vGZw
 32t3S+LO+92kqeBxDmJjpSe7k9edc7/FxEmqmxwnQuQWRq0DnMEQfVO+wK/enrexu0ku
 d2tJK6N6g/aYYJPlWOnCqKVmOXUGLLBZH+k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqq0g86r7-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 11:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+dVjbAFlbbxfTqgTz9vWYZXVkx6zfSI35GpH9ssvmY=;
 b=GgeQU0++sYugSatbzX1SMzKNLbnLI+sSDLeByILxCfzHcDf38xfYbtww3ow06GLufNrWCrAgECP5jLTA4yuLyn7325Dq4d+xBR71o5oG40ovuqldhSE5EwR7Vr8qRboEZ6a85qitRPjteWvdkeY2F983sCjfdP+Jk3cohansFAg=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:41 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 06/10] bpftool: add support for PERCPU_CGROUP_STORAGE maps
Date:   Tue, 25 Sep 2018 16:21:10 +0100
Message-ID: <20180925152114.13537-7-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f86a282-98d3-4ca3-731b-08d622fa9904
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:r+DHLcGLmepZMFyIE/kigtl0GOOBRECIFlkFcHjlh3NbjSRryR2MFaANKG/3F73ifctCnOT8Bj+C7ADWbsVnGsOXepYAGkZdw9V8Aoh0NLKksoU5xZs1xE0r7Cg1zL7u0Tcjtf14diJVipaJCcd0N5K8eRbJs0FvPC2iVuZ5EIMxJNvQd4Sr+vrRqX7HhmMmJOSfJcveuA7/3wek7lQLQOC1Jo/TP4PMlg5BuUOpP9U/sypETcsqmAi0yaYozLYA;25:TSGg/OfQutztsM/1GuB6AwFGdJNsbukz+IUUoz39ic3aq/7eyeO8JyuFw03ebCFdJyPUAT+wVJtZQiMpVE3O+/IG+8lYx1XIRc56BOZ7ha71NBxfjWhWBu/Ql0ijh+SFBZodB8FpNsrcYEQHPPK0QEsR62x+B3yxfs9JDCMmiqubvHRF4oEC4vDiTr/X4GhTiytc6FAjZ8w8017H+xe2BfrlV8h5V01Llzf10xSB36R1R3KsxhBhQxOm5uFq2Wq6hgENJ1wqRCrsh2+jWsseyHja5HJXii5/QvJmEz46ll2j7gsKeqpcI16SFq/Y1UoAMiUUd2D87vG4tP1NM7SzJA==;31:DB4XJe0ut9kkL3EOTkgtvcQlsUP2x96sDatNUp70Kh2eb8i7+K2s2zA9TN6OJ4j1QK0mzUEzlchkgqRpC0VQsC6pUrZJEycE5hyA03obpGG58wyU5x5VGY31BSLXry6iI8TEFNZu+kjALA1syShAcP4MxrIC4Jh94Ly/84nZd7W0a2JJJ15GpxbR27N7sYaPeLlQOhTf2lUs5nJZyJgmMpwpKDO57f2CziV8x44U6a0=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:mawzyQAL4+HVslRcRLp/j3hVJk8tMBEZ7wSl3psFhD+ncOYDhElZgfJM7wuNZkQ5dRkKmdSZ+PXgcS7/emfi+qfUvw000GaAv8UicGIxT8U/zWPxFV6mRkeDiNz1zCcxTMTmR/HUenqZ8gVh9f4sJ1fyAOHajbIzhfiMYI2T7QCxNJ94F+U9zT8fwHMh6sFr4/0V9yzGnrFp37Wi7367/jXVIMqQkMgnBNtpVe7+UYNX3IK1gTKOv6zVc/fYjfYL5YHIA1mRF4Mn+w2aRE7Kj6WS0QrbQanYzPP2QK8+ssbQ5hjI1J+1ktvUPsmLFlGVNDGEfCfIKG9nID37U6CMIEdWBPTrweZisSvQdMQEgB3WFM8UV4KFtUkTKt107NY/nVpMvT3aU3xN4/kMEfz/oq2A0m/Dxf5KRNWn4/xhFWfdBpcocKHDYVadX3nPE18bjzv0fxHHsQdbhY3QiIJrx7zmDrcosYeIzyAkfpEc0onViXBhXiKbwBEKOscNM/OG;4:0XFMdppUffzsV5SkEwpHjpodGJDJPiXnde2vAUFWGPC00KJon/FphaxH+NrA43of0cySyQ//85763GVIWigZ2DvzVMV3aT5vAj3AN/U4r1AJqYook8xmhN0UOclO59ly2idN2TD2ppbs4csuntix5HUsQb+RCwBCyg2ZKeGT1aSBI1S+V8ePxG4mtX9/UzoLdnQSYgZaNCscIbN2Cdl3J5l7ZTsp5upgBylLkLXvMbwl0eyIJN29YI57yW6yM7jyfShelUCFei6QRO+WW4aaPabk7p7VCoiM+xu/wNGPm2XTGc+YGL7XnQtwTa+VHjqv
X-Microsoft-Antispam-PRVS: <BLUPR15MB0163E4B70FF53CBC034C7F6FBE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:3/CpXSRMYhWBjFX9Us/zvG7PWmSsFAcJKynB5vW6i?=
 =?us-ascii?Q?UodFsCvWpM+H8VbN+QkbT7ABk4xlVF2au0OVZNPK3F0+95fJQyBaYOPOgMhU?=
 =?us-ascii?Q?V6gpKO2H6TGzBtQ89CzpFjJaZE1rsYvtZb0GiqybzvChdTcX5Dq14EjQjJwH?=
 =?us-ascii?Q?sUYHpAttq36WvDiYJOyNYUaNhfqdgMEH3bg59g9b5adGEP8W1IitBh5T4+5D?=
 =?us-ascii?Q?zgm6lurg2PC3Wwb7tOSbmPxzaoXm540YAqA/umGUJ4oDL/jjk+LVoEZ49kJ8?=
 =?us-ascii?Q?59RLkGqdZm0d8RPHcznyDxrupc94GtiFNXKyIFoi8njF9wAtKkRxlkNX7dsm?=
 =?us-ascii?Q?EygU9Oe4iSgR7BggBbzVuZ+WVzDr31fLcLotU5q+8VAaGjQVIdPZAEeDHLfo?=
 =?us-ascii?Q?jMDq459qQqs+96vM901kKL/exXVWhhqhu0HLaGyqLnLtFMumj9iN8p6asnsE?=
 =?us-ascii?Q?EW3lwFV4CEdmx/eKDhLAqjNQE43WXdWhiwVaVwOQkP7OTI2hAV7pl6idYsuQ?=
 =?us-ascii?Q?mC0Dnllm0HgTIOEe0uPumx60GJyKmqL/+YvENrN3c588cGnJxi2B6w1FSOe+?=
 =?us-ascii?Q?xhGUmiI7rC332M8POdJDw+PSNrv8HvAL1Rk9lCAPXsoeacDiKz8xtLLWa26d?=
 =?us-ascii?Q?MnxW2gaXfwZ2rzEFwHfqrtAfOcmKSyA8oa5kvYYF6hb99zSwHjH1HgTtOqAQ?=
 =?us-ascii?Q?edTz939nPB+XBRW++EB+78r4PcxdbWdQYeSkPqzeHdUVHdoqAwhUwxXn9EwT?=
 =?us-ascii?Q?hGpYac2XtLGGOi56TKw91rY4MWBI+F4thmH42DFhWtROX0u4Q0xfT/Jz6Zep?=
 =?us-ascii?Q?fmI1sBZrYG54WLtQhIHuBvrBH2WcGy/nOWoWsIQjS8L0Uybdo5eccX37JYpV?=
 =?us-ascii?Q?uhUsUej9Xygcy5vw0AzwJxgoDqMcaWb/koClamhf0rNeCTYpx1nv6e8sAOzk?=
 =?us-ascii?Q?qekQR1rnkSa01tMebAw+AZsJ6u+BoJgaEYaQjFChl8PKPk4lrmT1ujK09Hfk?=
 =?us-ascii?Q?fgoz3x9+d7ezXCcuo4Gu4dRqJsecG09oCr1cv0+aUcfTMPenQ/FcUZw6OVGK?=
 =?us-ascii?Q?weihRQcUAq4LMTD6fejmCtzJ01IBbqcUYfXtS0E1ZTzyuavTZkQq1ZROWrO1?=
 =?us-ascii?Q?6VWk76e9HfOMZrZsI589EhrKVWpO3FPp7wRnvvVAKWz8L57s6qZaSrIOAB6d?=
 =?us-ascii?Q?DwGP0YiUpL2UISKDse9nMrhsE7DuNeF/sX2SBs4ov1po0b3u80Pxrs5F4IiU?=
 =?us-ascii?Q?NgQUWH3zfQK3mz+xowqjbaKKzHo91bsDcpgChym1rgTrIOp6dzNQvQI6TOAH?=
 =?us-ascii?Q?FCu7Zz9fzhPLky7ET497jI=3D?=
X-Microsoft-Antispam-Message-Info: cNg1JOMgGn97jSWcwGiIXuiw5n0796zjwee7/ygVce7ldt5JBOohmcO16s2z6OAmr/35gzdHe/sPNughZd6GckSeEfcVzu/IHlmW4JjUVOPKjUbd1WxUj3x/OuqamZY6JGdzb+3tqj/WFDh4a+/9Lg64D4yDRwCWVwKS9HXyja4AfrZdFu2lM+SDlKNw92toi4/TYITVGlSUUJgHsg3AzvZWMXQtT1Yuu7YB6DxyuJu0fYLMa+rKQZOXOOsCzJBrNm2A4obQL+HUfFX1AzWxe6Cw+p7eXXpZKUBVOKS1ANXPz8wu1CbhyawuQPUGaVV9MviwnJE/JyPyHdp7Lx+YAc2+OZGKO5XadykoZbHlDjg=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:4gGWHlwzDtm5OKPMb+ikghJQOr4ct10yEFu+GWyVQ65maSoZo+cMka3LcqXjRBZvUlJ+JsJ67DWHZ5SSAzPiR80yG+ZOV+Ed6HTFh4DVOwylGJ/D36vhQpHOK80Jxal/g+mbNLwuy1B1PuGODsK/7eVuXb55USLSsNaMIXllV5wknxSTfhkE7wtyKUXrqnTXKFTcH3mZyrYh7p9b/hsP68mU39Y/FPS4XP6DBYvMtldfdA0zkcOnecGwgGEKFi7ejnQyt1Aj7kD+qB55T3TIXFCbaRWr2opkFIyng0xDE3/wVG0vxC2QCn2IqI7nMfxBaS7eh/SlRr6lOO7pbjiQ5W5+P/JnuMqLYBK821Dz5MvTW49VszfTSUhEp5QUUfDzG58xN9uWZyIioPWq0aYMsj/bTGK6bWAzf50SxMTHHxofPqoJflq7MfYrFpI6aqSEgtY7z2Bu/1s/30bNdWR76Q==;5:snOg+/HS/caEtN2acDHHzV2MaNAI59CquW/1CzylEdCBBhwgkX5vC1as23tvjPGs3bBfaoOLpELg3yhrAludrfbSXov9QMlhC2fgtAcYeQ6U341WtTaDNlIEUUKgK7bB2ArYRuDKL29H05NIVCT2RMyVWZb16WPDoVk5vtCyECw=;7:qBn6upNVNgLjwFPIrz8w0hyHTIQWAgYerYM9/h8h17qIWn6rEt+uClVoYNBsQeP9HFJzUdLo5nO3jAyN/B+ZdFoZNgWVqSpr0NOreD/QqgfW6H+xUyDiK0Fdf+3a42WrB3W1Xzd+9u1FJM4EE7aQ8yRSZs2/75saa5dZERCklH8TzGnmdkxgsQBj/ZArRtGaVXWv9tnQdwMcHjEmg12NS1nulRylwX1eiX5GkzPT6xHzVDASYWwxR2vuWnXrmrSz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:fxG/W8uMMUcHJeckEYw+z7bhe1qVAO5glYJ3CMcgiey1iwmM0M/c3WOrSCRAqIUYUsM1SZ7CmEbb5Zwt7WnjjChup4ubVWPK//M5TJzZ61oVOSa8jevowXYsYqhtmHYyUlbjeN1eJzAv7AyQgNunnSMjmg6WfJo2LPdfCjC3IJg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:41.5289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f86a282-98d3-4ca3-731b-08d622fa9904
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
map type.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index af8ad32fa6e9..cb8177593a9a 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -71,13 +71,15 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_XSKMAP]           = "xskmap",
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
 	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
+	[BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE]	= "percpu_cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
 {
 	return type == BPF_MAP_TYPE_PERCPU_HASH ||
 	       type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
+	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
 }
 
 static bool map_is_map_of_maps(__u32 type)
-- 
2.17.1

