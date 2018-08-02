Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FAD21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Rt1W0o5d";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jK9ek7Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FAD21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbeHBXW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:22:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49822 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731995AbeHBXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LSxYi015349;
        Thu, 2 Aug 2018 14:29:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=wN4b03mUIjFj1mVVo4b5WEqpVw8p04Oc4S833N9I6CY=;
 b=Rt1W0o5dofsMQZ142Qv6ch23i0ngfGwWfuFdDOLMA02AMiEf51aKg4J/tc5mREyh/1hH
 8MsaIUxKmDP9sdDXVnOOCDMMn+JMtXHDMZuNjMd3ZQA0atEQ0G635NRF05RU4e8JlkB3
 arwAepj2f07LLZfESHrJKUspyt+XvlZzmhs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2km91w0510-11
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:29:36 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB15.TheFacebook.com (2620:10d:c081:35::27) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 2 Aug 2018 14:29:30 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN4b03mUIjFj1mVVo4b5WEqpVw8p04Oc4S833N9I6CY=;
 b=jK9ek7RmJzfZ6aGs37tlh1YCeEFolIjJnsY2d6YBJcBrWEuTcszxF55RhC45qO6fSg3JV0NZyL84gxjGRCYxjO/GzA5D90f5SyCY3aR7DKWz1G0WuodYxixMMc8t5A67EN5kJIrywzCC6v82ntbzzADQUlUQcad8lAMZykX0zzE=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:08 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 13/14] selftests/bpf: add a cgroup storage test
Date:   Thu, 2 Aug 2018 14:27:29 -0700
Message-ID: <20180802212730.18579-14-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8020663-f844-4e8c-0543-08d5f8bed79f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:/9AM+8n2QaYVOJ41Vg3qkOa2V6Cx2Uw4fskVRGPQORwJqcmRalL5D1XkeYKbk9J2v6idgcSOwUN3A3fP5USSGYJbjvwCx6NaCtBEqcnT3tc1P2hSjch5wbloEbtGp28ORgjlTezKCQwIq2nj/Ie90pLkVyFr25ZI1tkjLUhZozleT+mqAD1Gf6GQ22zOulNN4eo45cIxeXgMZDZJL7vghsaeplyP4LQfq/itWoFlOXTbsdmplhDV3qHYCD6y/XQU;25:ThGvi/3sIRgmnjiWmenEtnKFcdVoFV8HRQ7RBBQmsmiGmwvyH9der67uFDj91g8JpkKJzlCxnY94ltY4VR+cZu/4WoC4+EkYaziIVOMQFJ2JzSvLBREtV6V8UTzHoA89byJbA03ewDGwoTCXJdHd9yOFV3Mt8ztGrLYS1fn+j8lYgdKSvnhTsket9m1g8GldoEumim0V0I6TE1KDiuyb9tMAwa7J3QxS7R13EvhxqngvKJNjBSrFx3SYW7hOY4x89rZ4Br7NtKTX+Txyq3uIZH0ypoCMR5msut6wUXjL1IzlUvcegvJ5Dyf1qIvPpG7qMUkMTp/I8zN6CqJrw8or2w==;31:5g8hupDJJC/UAAUVHx8E7BrD3j9n8kxcO50tzfhlIiIaXbE1GVr3Dr2mdsdxoAH3UAoKPMYyqG1g82HPql6CwHfzQBoppGQAERE2nfKxuf3bYvXoGJE68+3cK3+GEUYVDDu1DIGtL8KF7iaYO3450E4rg97czn08Zi7j5m/2+GggP6OxhYLtMsaf/HknTSAS+0BO6N0q/jUOEje9nk4BmAupF7H7j5u5E9MThmC5Gfg=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:TDOqU0Xasryblj9PZtz0uGCfr8sD7Am1YYqlliBtjAdwfo1ZCh0dVr10XdfNg5Md42G74tItphF5BIXBq6mR+TV5TbrIAkB48+y4h4VFA5pIhwq5RuUOYPU84a1+ETuV42j7kfBNr7Pv/7ouzdurRGRuvIioILDzvFF6Yecs26b0w9vT0Xf7fsemdh8IRALAKErlE/l6gz/6pX0ZFF09CPWwMivmtrb1ApZEILbiXf4a7bPYu8oD0qEALKGvD14JETEofFvwBr4fQgxSV2anLeJKbTZ89/Hi1PY3oSkPFzkYOViCwaSxtwfGrBhsfUVXWMGMn35+3yqTHJzrAIUdii3TIg2RGw4Hs7gE1eBc9pJSHwPTob8hRisYBVlTx3AmXu85xIfi0txVzxDt+YZAGxSPqT95vnVkhFujxRkw3JegDheK//9vIThpZfHWgrZgMbTolSeNawBAg++W2y3Y39QZds2sAypXrRCILDrGUU3FyHybAwG2KlDdOlkPdU/B;4:1tHjKdyzsdYsmxAImV9C6b5ruPpZj1HGdK1QUxJ7jQlGbJUb/ioZoQ24UUqgvaAKWe8ap/1T5OCyWG1uTLlOmcJ3cwM4lbcmMe5+ObK2ca1KBi1sY+ujPQKWTP4tM/cdIpf4OwPxSlCSkDM3VL4cTVxeRG23ta9EnyxVezT+gJ3nGRtCaF5xRl94wfjCtzf7nwEkNwS5yjoDAZ2If7voTUvEufrCzprHkhvn6D60gefcdbgxFk2D1AgIl2sfwd3oNwKgmgQL/BlE8xsM0l14sxNVlZcaqzx6hCgkj90yWUu5brUNLmGfjsJ+k3guxuZJ38UnTuzWO7EhB9vNg56FaxkKCAedrctyj4yVLxPBSz4=
X-Microsoft-Antispam-PRVS: <BY2PR15MB016725A8468A8E7D117F102EBE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:wr90zmpG8yVVmNN0BrbrZuETICsNx/4DAZETAOHGf?=
 =?us-ascii?Q?di6QnTq+kwuS74YPmenxcwPpztyaSlm6+0c0FCh2Hld4eyh3Jbn0SmPnrfGz?=
 =?us-ascii?Q?YktjgBBMLGlvtbmN78t4l4JNmMelZrjKQo5IqZA8eTjaGszZckRaz3YnlzE/?=
 =?us-ascii?Q?k1AnmJ1ehbSotqinD4uGnuvAE8U7GntMenoSVppb22UAIyi92PK8nn3x/KWd?=
 =?us-ascii?Q?sDqSMC39rduje3YoiV5vug/qQjimEW+XItgdXqvOAzRh+A1SutYSe/61d33/?=
 =?us-ascii?Q?5yjqdx1D7N1XhqnLFG42GCsTXPtl9KQL9QdAFubfgZRge+mEMpLD/D+pFuO6?=
 =?us-ascii?Q?+90IIxHdPwJckjWOSjz56ClV+ochm0Xw3xHc48//XtBTBvy87CcN/f7aYy9m?=
 =?us-ascii?Q?JpPggEe8fTgFLzYnMSrOM6+KojzBXbOqtAxmAzD+MX7+59+JmTZBNNclHN/r?=
 =?us-ascii?Q?N/0pYNNxd7Er5TSpNNaKbMto3G392xlcfgoL9izkU/g0fAlUWrOKygM4oXQd?=
 =?us-ascii?Q?g6I6wlF7of+PXzXAsITVIF2Wwo/UgsYa/gA5jg+W68z4vD5AHj902IbzPJ3Z?=
 =?us-ascii?Q?/ijQsnLFDzwNR6WUSAx6veLhEgSvfHg4yADzx4+f0uMO92bxMP+/xQuJbCzy?=
 =?us-ascii?Q?+BhmG7EzSw/cMojYgxxQbiPkghlgYsg5MtjFbQhWJYcori20KBPleMUAkb7z?=
 =?us-ascii?Q?HmaidQIbJZCreFsoQ5bp5cLElru1WvZ/gviJ37CQz9ocidLZ8n1sxcgFYphX?=
 =?us-ascii?Q?WtswyMzyJaps8DIsY2TGFhb/q2laYCDq+RGi+8iTr2sU5szxZ0XmOGe/eh1W?=
 =?us-ascii?Q?JODcyryJ4ABxfHzuREcringWj6gqNy4mnonKdHwL8ofPfDjmACFCDjuk98vJ?=
 =?us-ascii?Q?YSYG4WOIeSbr+5naMl5vNPwL6/jSlSG5uuKAszSYeU3EIDf36ZCTfgLnZNyO?=
 =?us-ascii?Q?wTdcIBIQR4wkQ3+PoYelwk6goDvijpkyhgPyMjJDM44G8K1RGY1ufc/C6XWN?=
 =?us-ascii?Q?ePTyyoJnazzdEgAwDGu4RUZ9dHIj12EeBQAuVFkek4ftkijl3hP+1x0qGx1P?=
 =?us-ascii?Q?Z8VHVD22pLAJTQAtOQEjElgX9yEBkttRS7wAAGlBLbnvuBLbnzIC2GVd8IyA?=
 =?us-ascii?Q?afgee9yC1ZL1rcEFF6sgmg51iHetbwGK4iz2wzNEbjJE5GXNZzqO5z/GeOQx?=
 =?us-ascii?Q?AgigJBA2vj34YWmrCDGTFOj8EHV1DZAnnXcRAnDlFaNv1gQrNWaxHA5nfemA?=
 =?us-ascii?Q?eUqzJV538KZKmw/rafjsXLfeIst9+La7ZmGYyZp8+++/a0c5eN8148U8N4ok?=
 =?us-ascii?Q?8v3mCOiZkaAxMv53HGNoB7ehbfGtkZ8nK2ikoJrKbtF?=
X-Microsoft-Antispam-Message-Info: 6EJpyaUhJlBtBLIOXEhAr9Z9vQ1vKifOMzHGn1qfY7NKOUY9P7MpI4Z8SYzFQ4MByQcFjSH5/m3Dkbg7e3hT89z+vS/PDHXTdGY/ZdoWyyIYViOgNGpfeiLHWJd83gKsugpbyMGau8ckQKFLdlf9aW+88YhyWJH1EQtrUiNAjLNFVo9DFaCpuFEmjv+GhTkYKzOdSfaeKDYGZOxBcIGy6Kbi35QKJzFf9iEJY0FmW6F+un0lJ71M8yxYCfNvV2z1HyFpObD/7EtIFJZlcD9ctbO5w02g8bykYtmWlAO8zxpw7+PhHryNxLWCcpHJP4KmUHOyo97gDlUQUPAiKKIZw5Rmw3pZWg6XxMNcgh/ryFo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:dgr2+A1r31eIiBrOGP1k0WtxOZVkkMCmKAcaXsVE1JXBmr3E2I8ON1e68ATPqUHFcTvL7pNfualoYyy2Tb7HZedW8AVS8Z8q7qJHW/GQ1hB9KuHbfYkX3l2P6ScB+INE2ACZm9TxIa+ZXnBjPW+rBmFOLPdyBvRiqDuIf54HwKWm8bLfJ30HfR6r5FsKj/M9+QnvcDYI1rlNVohXnb1Xp2Me1FQ6kEzVXCkLYUoV1Ztl/k+3+qNe1pRlunCroFzl/ULUflo2pR8jANviiNilP/o+M3Ch9zshgvXB4zep0aqBoOcNBeFKEj5/vifFTVF65Kb7tV/JcOF6W6ED4LA2zuPbRLthQd2M5K2B7zixdfgABu4KnRBZrWyN2lxBOLirRuKRubHQJQ5HvAjjTzNzPkxaEz+Q9B3ezn7LMy+HmKby18nxjmIh3BrZzzWFW7B4epF/fBewXR5aamYuuB5/rw==;5:AeOxTlEkTV2sLodCJ7L/v1AvOYfH8BSs38Cy6I39nLoxNaO1c4XfZDP7IQo1mikewFlIp8lhUVNUBt7Dn1uIpHvbN2BBHsAw/S2fwPMLa+8kFYm6Ye/C5nhs/piiemWvYGVn5wifT6SSr84uVHEe0k0fXh61tY+T5HcLwj4/nP8=;7:4cWleTt6V2Yl0YhMyKjtvtnK/Aeo5wbhlhKPniBlHe0kSoTZA2Zb6yxeB7NzFzUGGA4KTzaoLEfdLk5RutoEp2srqg1sPolOglTksPGBJLbL0eXZ86L94Ytl/+BOHO8p/4hC4He5hVl2MI5y6tRp7L3TExYz+Elz1z9bZdEgV1CvvP9eL/HQwKDewCht9wt3KthDB6K2eRWEyz6ovswEOS629MwEVxD48mkG9UJdOiV7QzqXMGMFRPR/S1bUC1by
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:Ce0JYcki1WCQG8OWCPVa9Go9Kwc6ly9VtM7M0CFgfXCmPsy6Iax9YnCJKi2HxP6K9r52JaMVGC6EncEVbNsSBLjify1H47644EyXmBLW6VPJH42Nrmpi/sdSXWSDqRpY5xqAltdDN8MRjBh0B4MtTB0DpxzZ23yCD9iebRGWrZE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:08.1004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8020663-f844-4e8c-0543-08d5f8bed79f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
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

