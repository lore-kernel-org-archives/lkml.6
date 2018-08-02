Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88377C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8BF208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aJbVtiKd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MURVPopI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8BF208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbeHBCVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:21:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbeHBCVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:21:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w720TE4S011174;
        Wed, 1 Aug 2018 17:32:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=fNVyiAIBIt6KSpSIK4JC/LqIQo+P2P87Wx7Z0FrDux0=;
 b=aJbVtiKd2jq5d+v1V7GRFw+4oP7tVVEnyAhJY1UuTyAiW/AfC/D/Mx96DCkI6Zf3o7Gk
 nMa5WbIO2mQfUZpNh2dyILMYiIsRGnE/mdx26HpcZfpg12HXVkIOmZQ2qH4Iwi+hvojM
 KXdLKwuLaMMcOJxSrxFHL1Sz5f0UE0eXIqE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknf1g97p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 17:32:27 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 20:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNVyiAIBIt6KSpSIK4JC/LqIQo+P2P87Wx7Z0FrDux0=;
 b=MURVPopIFNsgtWco/55m/T7zVhKLD7IJlCCyPUi4fmz4xEL0oUy7aZVnAzi8WSTNcmh10672ea3kV6Apgh4Fo5f/wjFj3w+mqmBG+FkdAV/zkvi9tyYpS8WLTe1a295hAzamvIxytNYiL2pwTNjfT1OUqRulTMJvCvLR9EMrxW4=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:2fa7) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 00:32:18 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 0/3] introduce memory.oom.group
Date:   Wed, 1 Aug 2018 17:31:58 -0700
Message-ID: <20180802003201.817-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:2fa7]
X-ClientProxiedBy: MWHPR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:300:16::16) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f8b8e69-11b6-49fd-b8dc-08d5f80f67a0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:Mw24likUB9mSSUoAUBe3QBZYSy4BuCkif1yHMo74mdZaghOvb6V+AlcQNnaFq/ZZq2iGV7cWJLl3oreAC/cujHuifldn61SiLUNKdQQ87aC0gZ7HpjI+3BArQXk47bRpmAlCv4eT5IgxwuVGOhzLiv6F2x2UU7Xfpwv0nD3HA0KMVWcUs//4JN8NpAHgeD+UTZemTn/RBsl43shotjhTUcAq0Kv04D0A610NMk8S5LOxMEFHoCmdfPD+CYcQ71fi;25:Bj0bS5geeKS93BAVONBau6cBLlWPs0F6m/PQJ0xbAQabwns02wB/z+lHnVOyJ75EJ/vJEImfFOZI8Ex6BJUzKfiJczBcf3VQssv4dTiD7b+Ui2Hq7famr5+RnkSdGRLfSL1asHZgqd97yFKUz2XhZdf5YSpsgPOCEr+ypBL52Phm06qLFWi3j8o5kd7az/y5nIZG1kFfzT+4uSQielNiFXDbhSB0zB5KMKWtoq7T7luhHqczy/2nUQAIR332uZnmnNiTKi0wymC28w3meIasRD7z9hZwVAcTTbBl+az+yyMBmwsqsCJ81QSk4EDUa0R3BwqfrelVutQVZTuO4INm5g==;31:ncEoxMA4d8360zu9Wz7nCgfKR/6VMSVi6fna3n3CpoAXh/cmY5jPz87fgeJLtf+im9CUWRnlEoF9U3x+ZlcLMW7URUuAO+bPsvfe6ft+XfAwvw3HIvNO8VjQnExwXJuV4VjFttJk0R8zg4FDXOc8LU3UlUZzi0sAKHLDW6vgZ6/4Wvh0hA78MR3780hQuLIj0qPswpwO32vR2KylYbjyxmTQRwA/NArhyhUcohQmM3k=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:H2KT+IJluZc+5XBUWvshLlZkieKY2foIwDS9eP5pFLOf+rEFCIY/9aaTps6ENqzCrFsYlJwPdk8WVA29ms9mMDRlmevcWKeqwX9rW6SN625hNloI4XIOGhA+yu1U6BchwHxFcv4fZ/gUogAgYsL4qTdpVRadi1JaZH6aNHwbyxGJx3es5/digBzuppn8/ybl6WUVmOmdQrbyWY7xS9HR4VfE0yZr8gIt/MaH0WwwwhCavac0tJas9SHJVA/zh83vlOGsnl5Vi65Ap326cP2xWR3pEp0FSJsEV1HhFhgiuOqtTtDhYlFzs0CgBqltepTCPT6K+2R5dt/3Ng5VIuwo3YCTZ7PJ03WLMPrOuf4+NYTDKsLAlEkbnXtbPw11vTrYey9CbZTS9bGkOMjH/fIRLNwfIgIOSnFd1yKsQz8Dt8WR101VjDsIZGWHMtDH6YNXU0Eqj0IbuTXa088v99mYuVcdhIlOWrk/O+A5hCcVNyl+Wk9boTNPu8FoU6T2I2/X;4:LW4WC9hbUOPjrAquL5A28JtFUtN3RCTiLoPMYfIoxgAHzJiq3bnXQD31APMZdbDIN6xU2LG0xJBmqlF5D3hxA9N7MUk4QVO9wyPsH12H16sYCv13Qp0+XL9gWRXv9kHmWkEFFWOdgJD4N5pCCv+zc63AEo6aDQ1vvMAH2eQtCVQJ7xfeQZYn1XWFICh4GG2CTj2fMv3SCiJoH2TiJMZ3hKDpI3+d8KW7fEI+SEGLzJ/TRv+kL2Ga907gL4MZSr2HffI0oHbavQYSiUgHANSpY+rWBx+SZnbJOSZeln/WWCrzBMUWQinXMCi8oka6I0qS
X-Microsoft-Antispam-PRVS: <BY2PR15MB01679419CE271ECDE6FA0693BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(68736007)(16586007)(50226002)(316002)(53936002)(51416003)(6486002)(6512007)(50466002)(52396003)(5660300001)(6506007)(386003)(4326008)(16526019)(478600001)(2361001)(186003)(6916009)(1076002)(305945005)(8676002)(476003)(6116002)(486006)(2351001)(6666003)(7736002)(97736004)(8936002)(48376002)(2906002)(53416004)(86362001)(46003)(47776003)(69596002)(106356001)(81156014)(81166006)(2616005)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:EE0ZzODyRVrCVaLhjv+9asc+SRyl0utFTnojYgEdQ?=
 =?us-ascii?Q?BeViiwYN+JQAN4Gjb4k1JjHg5FvtgUsahhRQqLOZ+IRlFy4VxZSS4iPFd+Ue?=
 =?us-ascii?Q?81CpNXCM79yaKuMteEg76le/ZBM47NCqXgGew0SB1+9rdKwDJmOWTs3dUueg?=
 =?us-ascii?Q?2aPwi+ttIK1kdgFornSEtG72ncC40uTl/cKN6u5H0k2TAEDY+alm85B+vCBf?=
 =?us-ascii?Q?UoI+mgh7YGeGhzbsJOv74YShLDUvZmrJXf12SmMu1t1ZstGxViIKm3piOUf8?=
 =?us-ascii?Q?JsiX8r1SGdIgcqe7UozH6prXMqGTdIXfRmrTibMckyi5SCMC6pnIwWbN4PZR?=
 =?us-ascii?Q?5WBaMkWrstarrf5HORx86yCekK0RLSxLZyyCSnSI70Y2ObBCD1USljMPmX3p?=
 =?us-ascii?Q?YBbBQYbCHzvZbVLkJwBVbukVr6u/J6508j2M/eAnYpJVXCYmHw5cS2otjo9A?=
 =?us-ascii?Q?r0YuQwpMcBHzyG8Z1fQK+zeYBRzYsqRDNUschNxKtSu6ySFtxuqPASZCzPEW?=
 =?us-ascii?Q?kJboaICtcUke+dMM/f0iKuDhsBD/ieiLGeFF10TMArNVAo4497nkvWC6ZEPx?=
 =?us-ascii?Q?nlWAmpIFtCaECg2WhXz+bBMp1J5tIx8N6iHXlmvdil+ZrXh8rq0eVX0W3L9n?=
 =?us-ascii?Q?I+CY+YIV5S8QnN+LKGek7/NlQLQcdleE+fDg/iBBoTf/pmVtCuO24RAfsDAl?=
 =?us-ascii?Q?STmTSGTN0dNB3KYOAXjPR5IkgBiS2hQA8zqWeMxV9GT0CyP2T5MRgx0nHTFt?=
 =?us-ascii?Q?5V6IjO6S+boBA3v89NuWZxNpIGCpS0Il+SkF+z6Ski3RMyzTzjqGrOnxlANb?=
 =?us-ascii?Q?yvEBgPnUIXaxqVlt3xhNqxS145N4M6B1lAaVRIzW/6mLtcnqdIynKcrAgvIy?=
 =?us-ascii?Q?YQEUu2GNIDjNXMS4dNMAez+c91OGdoAY5wqISF/WT/oCp5C8aeBWOQ9WMS6P?=
 =?us-ascii?Q?V4vHdY9BW2UOAviUjQnCp4jNv8Qn5CVE70fsP/vquCNxXF7TJf23DV6a8zYK?=
 =?us-ascii?Q?Qx/FEDYihglYtKpcNjCKdJf3PIx77tvECRNRNUpyqzIbMjYs9jvkOIiL60Dy?=
 =?us-ascii?Q?wRzJd/nthgXA5kPlEPE6kL1cr3Vvgzjzf4wgk06iQlpMlswvWPXErWgBZ+sf?=
 =?us-ascii?Q?CeoBZV5gpNjmFrlmTx623Fjm5bU+oUZ/KoKZoxdAqNjKBqqOnBWHdAmDnPz1?=
 =?us-ascii?Q?mymQ67qWyxNr1YHD4soO+6KQVIFssSwnKpYoK+PjPJ0FDzgLT5sytxq9A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: FbrArtGS3q8oSn6jJGBFT+iT0BrErOJSoGJpSUMZxsqOzmbI+6b9K0soinaZmVuVIlUB9seOBa332E2tZrUL1aIooCUsJNRrbZpeBqD+MkLE/foMHD+uE2JPgfIiRhyqw17GzyR3s6WDxTkyat3s9E2caN9dYhjL8K5PFcl/tlxRIc6Rqt+fMOb4Gj3J1qCO6wucW4vqWZ/eEnvKPklM+9wB6nSaLCPoInHh3k6ITf2KZTQJ1d4PyF0xisPQ+bi0adPIQKJ8b9l+QLvKUXWqUhsqojkqAh0NdWRQ4m5mqwkT2nDTc592RY1P1XAYW9fWVnYYmbD4abzaYSh4imJVOsh8sTLzSGI+ROE0U9L89bg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:wjj5hnNDBWkStHSMgtdZ4Ze3aRQW9mEjy9CceTRP7dix7zIPEdUNSG4HEjbRFGD+o5Sdst2b70fHifU4t8fLtMruwK2leGY0IpmoC9KU3+MHTC80mCEfee1W7Ep40LnYg0znCPDDixQBFuKkUgz12SBPALq+WSAhrUE9KRVSsEU7hLJRbs+JOEA0yIt1VbjV9OqRCpyocia3JSHc8fT75Vuv+sHbqkShZ1dwYuuOzUerwNoQjhu1jjLquVNENnqef60q99HY4zrZIhKkhmnocXf4vMkHXgUttp4VZxRGb60cKYVctSJiFwieNPsHrdIU8bVVkkH3JeTd3MDoosy7CVDeys0jllHgqoR2G+5Fx1rjPLRPXXiYZRtI7ITpDCBV7KUmZT8ugt6PTXQDazqsbB5mCrPUsl/MWBTKt+6Vx1fI3P6K0q1UOiaGt/O1HbfdXbrt5PesId0/Wrxd5cC+Jw==;5:pmpUDxlelan0y2XmoPtJ+flAjYqLyxuT8LxssWRAri0UFDfa5G7UWZYCTkfbAjq+NCMVe4Uh8B8+1k7PRfnlcyOn3tEJ17/QTBnfKVHJk899Do/rDmyI8H++DyUlec87qDeQM8M0hNkiuSFML3Ft/B7sFqR5knEUBszINqvJhOQ=;7:yObhr96te3MEE1BJhHLdZ1rAn+BPYbvWqsZzGHOla5tDzeKtyCTW8uTC0SQqOnDh42lsylHdXdS6UquZy36e4QiZz38FyQbW/kST/bmmZuNxMZZNSwmyi8AE4Xc5gjsGbFCqZ24VBibZ+YW6O/es5no3bnC7h18jxJtprxMTb+DpwPHn7A7K1Rwi3xj4HZUjZl4yZVGXoQ13o6XfH3QWfQpP/kBtu3VCLBZXL4mqjBzKfF5kGJIKjCNi6dSjKMeu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:v819ghRwJay3TZsC9Y4aGw8hSKmT+L+6fg7244LAcZX4JEAL5Vn0YCRKCmB5PepfpXPN2vf2eXXHmCpZXg+ZHwa0iiXuVhKQSscXlP2HGPyOSdWwyR8/FTzRXzUpDkOgi82MTM4qYkD7Pm9BI1/QDqzhFW3dFCt3xF0G/YqhfZo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 00:32:18.0628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8b8e69-11b6-49fd-b8dc-08d5f80f67a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a tiny implementation of cgroup-aware OOM killer,
which adds an ability to kill a cgroup as a single unit
and so guarantee the integrity of the workload.

Although it has only a limited functionality in comparison
to what now resides in the mm tree (it doesn't change
the victim task selection algorithm, doesn't look
at memory stas on cgroup level, etc), it's also much
simpler and more straightforward. So, hopefully, we can
avoid having long debates here, as we had with the full
implementation.

As it doesn't prevent any futher development,
and implements an useful and complete feature,
it looks as a sane way forward.

v2->v1:
  - added dmesg message about killing all tasks in cgroup
  - removed an unnecessary check for memcg being NULL pointer
  - adjusted docs and commit message
  - rebased to linus/master

--

This patchset is against Linus's tree to avoid conflicts
with the cgroup-aware OOM killer patchset in the mm tree.
It's intended to replace it.

Two first patches are already in the mm tree.
The first one ("mm: introduce mem_cgroup_put() helper")
is totally fine.
Commit message of the second one has to be changed to reflect
that it's not a part of the old patchset anymore.

Roman Gushchin (3):
  mm: introduce mem_cgroup_put() helper
  mm, oom: refactor oom_kill_process()
  mm, oom: introduce memory.oom.group

 Documentation/admin-guide/cgroup-v2.rst |  18 ++++
 include/linux/memcontrol.h              |  27 ++++++
 mm/memcontrol.c                         |  93 +++++++++++++++++++
 mm/oom_kill.c                           | 153 ++++++++++++++++++++------------
 4 files changed, 233 insertions(+), 58 deletions(-)

-- 
2.14.4

