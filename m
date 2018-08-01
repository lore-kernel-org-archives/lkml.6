Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8066FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2391020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gmiL/67n";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="D4/VdlFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2391020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbeHBA0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732356AbeHBA0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:49 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MXJYq025470;
        Wed, 1 Aug 2018 15:38:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=+JBeNTZW6yPmNkHkffn0/qgQk6o8a+HdX4w10NgZ25k=;
 b=gmiL/67nZeOchRY874kcrJNyziIdyxl73Opo7rdsA8+ydch+tj45HntJWuoQg8b8055c
 jTY7I6uyw4shKKC6IQ9468wjHG12CtMSAwQQv0o4P8TkvvgBgq95yu0uaFXl13BYeUkq
 XXN341GV84Lv5E8Xid5+5wbNlzby1JI4nAw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmytg4e0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JBeNTZW6yPmNkHkffn0/qgQk6o8a+HdX4w10NgZ25k=;
 b=D4/VdlFcaDTPYaZHT4thdfII0+JOKCzWu+PU1uQl0AU+YzBv5GUOTdCZRfpi/wZHzczXWfY5Ve9o0Ea3ItwQVqllg1MhRFMEJrxLtEVGmAa2BscXaIFmyYRvxNqsAAOqwJJ/f4xUrPkDzC6AERJtMXQI39fkeFSd6yMJYMpdzRo=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v6 bpf-next 00/14] bpf: cgroup local storage
Date:   Wed, 1 Aug 2018 15:37:26 -0700
Message-ID: <20180801223740.11252-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2047bb-9a1d-4f48-7c69-08d5f7ff77cd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:92Dc+nWvHwx02tuathyQirIfhsfQ49jEjWuEilw1CStvsxuwyf6OnWLoGM8iWJ43W2jkg/z1tD5IA17Ht+lL+YUj5xHHAa+49Pmy2QJuH9aWpW87P8KiJBZDwg+g/Gu9jGaQlDqT54wWlbLAMYk7/YjgW87Fo4fHXjde5GcDzVuLDVaSRF/Owxi5XmNIF7gGEvAm8HESrsbfvOTV/YLVmlTRiM/QXjHjWV5I0yE4dyrKAsJN9BAVPk7Bz1LyZMfZ;25:cN8Oom/66QaO+RcKaDM05UhK4UZ+wHlTVM3HB2Y8wwhrCxU5NgJ3FuYGsqnolBIEn6u+rD5X3kbtNiDyeDPJetpzXIjq+Dyi0gCT8+Fdc2mB7fBrBCOJ1m4avvjLSbHMZLh7PkZMmUgLc4vPjUhqcM7G5InOHVZRH7veIrd2/4s2tJ+8wxO7QTzAxDp1c3OaIK1bWNPWaF+bY3jI6oyg+QRh5TMq3ZwICvJDOpNgLKH8Bormwc6BlJnJzYFqI9KfF40/nz29jbO6DKItE/k7PO5edxszI6+Ih3HBtDn+3c1Ci88PhSGH/F/Ioxx0hJ/00x2vBrTKj5Q5iUX+08HfyQ==;31:RCHXOweMjltJ7YDcv8UUwtLke/ha4y8ZXkFd9gdDk3I1ZuWKAkopLfcyxX2qtnpDMSeHh7iMNv3LLX4ieWNaQs5R7HiW3vCa0b4iGB9PiMBgcPd9O/SUxf589R2k9GF9C7Js4rXnmfZlPsg72cHWj3sx0D9JE4y5lLwWkzJmk2edsnWj+wE9Cw/ZEmFIsgjgndR293Y2nbL0/55aoAO2aQXNnvSQbidHIgXJSPEn6oA=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:crLaX1dfM/r7igvJIGHxpj82Wc3afchl1yvmsW17tDunc5g+CXjM+p/2JPdJg6lrFjzWUvfN71Dk0rSzUWwiya0qChmpBms6+B8B7foWXMZmtvgNgzmiNpXvGPUP/gRIFQTFAZEse4pM833hF22kpBFUnaArmjigr4Zva4mvzB2oP4/8s/t1UEO0SgbPy7cNcSIKs9csRojwuMy4+Uo/B2EQPVmDKhgNlIWil6fn+V+bkx7wP7aA3WNRcxp+apnw2ptwIn+mxp6QRt5EuklEGr6Rog6kb9rPdsC5hN99xFe0Mv9o1ZMfXR2Orbs/irNbPFunG18Dnjfs5WDfbjSYwnw8gVzA5LFaX4sy+fweuCmT1mu154KjVTXkrdKyNqeeWEFnXDwflc9hXP6KM5xO4GvPuBexj62zmhaIIb+er3oib5EZ15iIL4JI59EoO5P+ZHvRoruwAds/uNpkcnrv6sG2zih/c4OSS3TFEY3Y+CzssXgl1QqQDpKw9g4YzVia;4:bTcy0vR4UeEGbBUd5vSfBMYeaiOFge/YpeEIrLah1Fh6et7UGSotELb00kO05zM901yMf/Qre28AW9ugvdBHf9433iJfbN0wBtAyQbCZ7hh85MIkP0FXCLlSTFaNkpJAYdvkDPG8ol5yuU3uY/P9eybv+HWCxJ7mQ5R38aB/KQXla4cILbd6NGfvTxZNrtZhChQiKS8MZQ/AWgPaHCkVbiERHWUDuI8MeMA+QM4vZEl0WrGFcZmGvRq9gdbpyHwR/saeIS02q5pjOCkGlCgBgiMy1OOAcUkfYNu57ccvyk1/ZsrQgZ74GVXTySXDHXTl
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176A6469B90D43C5F6F17F8BE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:W1ce46rlGTm2KqCZFPjQR646XZYH4LQYvZDN9+A5D?=
 =?us-ascii?Q?rmQ1mzzrXNUvWm95MpLYLcHvHGtMR5BGCDcnyZ87CuOTDetN7ZOkLtylayka?=
 =?us-ascii?Q?SLZUYgb7BtEc0ArcgBzBy/koum0kaWa4yMD9QtrJDAFv2cd7OSQ3ZtgMjsV1?=
 =?us-ascii?Q?v6DrcMSZMK9AaFruiELk7pYCXCFjOAtxHCopyhjS1qSihA3+SU8VyzVzvlAq?=
 =?us-ascii?Q?J1oqgPYuzWIArH63Uwrcch9ukxbzgbduwIOHH71hHq1EFGhHgwjcF/xUiOvG?=
 =?us-ascii?Q?bymT+j/RX9E8RisO9Kfz/Z7DwKlz218y9s5k+EGBXE5wqqbN+yF9NDLWwDuJ?=
 =?us-ascii?Q?F0ZsjG1DNO1II4GX86iBjn0NS0/uJUgq96ANJBqwv2yqcrBXz5W+0oFghAy6?=
 =?us-ascii?Q?3TwpewCtGqD98yjNgob86o41plsEbSII8jQHc6eUzQNN4GNfIQDUCYEM/GEZ?=
 =?us-ascii?Q?/r2rET0rpOfQOgBf2i3ovKUuObUsiCOoN4Dcv4fwDOYwJhfa/KZ2IJnrzYVC?=
 =?us-ascii?Q?tQaBKaYadE+Ctef7O5yegBN2XMHQE1iVnQPHgDCqmESFKnjV8Lt/sGtWDOKn?=
 =?us-ascii?Q?mHEwdifv2x5GkpqNveRNe3bdnUvuCjJP0ZM2bzHjiif747vDFMO5t7XI9x1K?=
 =?us-ascii?Q?NmsYUgxreyGmRK3nt5u/2kqfQTh4rs5MRPOa3m00nuRHBCEHKKIYn6YSZJbH?=
 =?us-ascii?Q?BGKIX2k+8RxfxbOsGw3apuD37clgWv/P4EeMJaG6zzgWpJ+1JR+JomAvdVwL?=
 =?us-ascii?Q?0UFJyqa/MdAGIUeXK3XwiYSRsjqA1wDN1x7/QIfWxfQAwMp5G9yVEroFDqD5?=
 =?us-ascii?Q?GHR1Kst6XEmjrUEccnfugGsetRwQqfb7AfOeLr3cFGEyl/iwZi9mq8AhLDiR?=
 =?us-ascii?Q?ARp/CuqSa81urG701KmzRmykfpYP39rC1n84yYTR0kfh0CEz4+RZ7ucOUylc?=
 =?us-ascii?Q?pH1yqshR2ZLtKii3BluWRfrldMwBiJ2dJZlTOdDUWj37yXV5Ww9bMynPDwXh?=
 =?us-ascii?Q?UE4Jy7XQFtZKwwsQjPk8dC0XCoetz5wDssMt4zWuJl8CDVYPXn2UGz9txHaf?=
 =?us-ascii?Q?L5r0OJWbW5nd5qhNuC8dmlOT6u9lfTDz+c823Ls7QGqb+OcQMJMELgcntOEQ?=
 =?us-ascii?Q?ahO1v1hAXYBu6cZMOcEG+/f5L0okIOXkxwLF1TWvx/Lbgdq/0Q3eeNQT/AIi?=
 =?us-ascii?Q?Rz1zFKHg+gmvVyCQ8OOB3fpLmTyTBZ8piVkdrXUWM1ZVNVCtAJnjPX5anRDq?=
 =?us-ascii?Q?WJs3osGGSE8MSNxGac=3D?=
X-Microsoft-Antispam-Message-Info: 9GW+kG5uwftFgVJTwfy3LqsavYIV10bgePMrj4vviYiK+jH2otctpQfbs0/9pyMSHTVxOLkX1hOXHO2voYNxwb1FXAzvEW8UYct0pCvcAtOTYv7Y/mIu9kZ5Und48Ro5cGl8eQeD/YVEEmmAWSvL03I5fWNPf6SoEDu0WBxsVXjmUC16GRXnDbuDolbpg98LAadqdPF9NM9Xc26b9ap50oMl1c5t47dYzLB4+vAwYFPpygMv/sjepJ4ljAKAy3t8iNJtlEzMP3LwlvKPlm9oQTOYt3F3humMMVYfFkglQwW5cF0HwOoTYS5YabCJG0ioEEKMvGZvYsAJuwcIqhvEdpTXSvBYaZYVXpUYZyKmewk=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:/0Q7VMfbO4XJ7CXwClVKmuUi6bNWKTjina5KfmrmvjT+WNIc8jl5Y9uJ1jZmjn+mGXdbrN7VjNx7f/V37RctcY8zKPONDabcqny+wwfRlqz0QeguOAtLpUWbpw2kEw/ZwrDoDugy4c+mK7SrexU8r2U2OVKEjYnKp9Af/S95p/gA4IN3wcaB/scknIkdTIz0lRUoHS+Je+YCGmRp23KOZf646EC6u0wiC6eVAgSgtCb6qrv64zqm8zpMu1FDar6sbBFcE4khnx3B8c7xEXhT40phZcO53d4vCv6zRe48di8m2kkImXOfg+KekzU3m9xQ+GjSCF7h25yhLswQBCl3K8W3/QNeR1lnNsUHfEmyAa9ksB8Ay5bHzuJGWAeUYUTrNZEEIMBDCy8h598OtoC+FWCFuOGgQIIpPs24ybD4Uyqks34HI3Gy5+E668ldOmoQJaJ4IC/cpCKmME8kAM4B6A==;5:QKJeLPmY9sxQWSoKzQalti/qy6Pm9tYvFXQ9kizMFdsKWekmLCmEL4AgTfZejxSOUjrdScsbCzkecZRZLFDfiv/UlOzp2BXtxPELm3lOi0hhvFDHqSwZ2b653kujU70j6Ph+xvNobtoulOW/tXnp+PlZrOlpdlMp7d1MgOInq2A=;7:XYGjUU0k1NTDtXaoWQktYuFcwGODqK7Uvyo0Z6UWg0Uk7YIFwvXKA/JKY9dV+7OfXkYpNacKjAOINrLMgSE1QEudFdBO68cRVC+cQrCp3i0cVyZ1/8rWgZ22O7tnP94obhsGnGTe/eEEyCFh5Bml/SI868qk5XEkc3+kMilboKDv60vDIqRIYimw8WaMXXKxGcrax4p30J8ryP6NxMzGQ/SHdw3kyAr3lfv4PUyIZivSuirq3hxoGCDZImQLFVKm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:meRI5K99rFHfd2D969BeZOlmJTlby3/HSr6YNkXSu+CZT92oG568Oo2/8FbAoUmJQdq5dRtPHxmkN6n22gLtjSSBIDP6gXiPJd3T+39yr5cbQLlxwptt2oU7xZXVT2Ji4qCTwe4yPw1JEYMb2Vn6iWldXUUk7YvNg4MHk70HQq4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:13.4432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2047bb-9a1d-4f48-7c69-08d5f7ff77cd
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

This patchset implements cgroup local storage for bpf programs.
The main idea is to provide a fast accessible memory for storing
various per-cgroup data, e.g. number of transmitted packets.

Cgroup local storage looks as a special type of map for userspace,
and is accessible using generic bpf maps API for reading and
updating of the data. The (cgroup inode id, attachment type) pair
is used as a map key.

A user can't create new entries or destroy existing entries;
it happens automatically when a user attaches/detaches a bpf program
to a cgroup.

From a bpf program's point of view, cgroup storage is accessible
without lookup using the special get_local_storage() helper function.
It takes a map fd as an argument. It always returns a valid pointer
to the corresponding memory area.
To implement such a lookup-free access a pointer to the cgroup
storage is saved for an attachment of a bpf program to a cgroup,
if required by the program. Before running the program, it's saved
in a special global per-cpu variable, which is accessible from the
get_local_storage() helper.

This patchset implement only cgroup local storage, however the API
is intentionally made extensible to support other local storage types
further: e.g. thread local storage, socket local storage, etc.

Patch (1) adds an ability to charge bpf maps for consuming memory
dynamically.
Patch (2) introduces cgroup storage maps.
Patch (3) implements a mechanism to pass cgroup storage pointer
to a bpf program.
Patch (4) implements allocation/releasing of cgroup local storage
on attaching/detaching of a bpf program to/from a cgroup.
Patch (5) extends bpf_prog_array to store cgroup storage pointers.
Patch (6) introduces BPF_PTR_TO_MAP_VALUE, required to skip
non-necessary NULL-check in bpf programs.
Patch (7) disables creation of maps of cgroup storage maps.
Patch (8) introduces the get_local_storage() helper.
Patch (9) syncs bpf.h to tools/.
Patch (10) adds cgroup storage maps support to bpftool.
Patch (11) adds support for testing programs which are using
cgroup storage without actually attaching them to cgroups.
Patches (12), (13) and (14) are adding necessary tests.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>

v6->v5:
  - fixed an error with returning -EINVAL instead of a pointer

v5->v4:
  - fixed an issue in verifier (test that flags == 0 properly)
  - added a corresponding test
  - added a note about synchronization, sync docs to tools/uapi/...
  - switched the cgroup test to use XADD
  - added a check for attr->max_entries to be 0, and atter->max_flags
    to be sane
  - use bpf_uncharge_memlock() in bpf_uncharge_memlock()
  - rebased to bpf-next

v4->v3:
  - fixed a leak in cgroup attachment code (discovered by Daniel)
  - cgroup storage map will be released if the corresponding
    bpf program failed to load by any reason
  - introduced bpf_uncharge_memlock() helper

v3->v2:
  - fixed more build and sparse issues
  - rebased to bpf-next

v2->v1:
  - fixed build issues
  - removed explicit rlimit calls in patch 14
  - rebased to bpf-next

Roman Gushchin (14):
  bpf: add ability to charge bpf maps memory dynamically
  bpf: introduce cgroup storage maps
  bpf: pass a pointer to a cgroup storage using pcpu variable
  bpf: allocate cgroup storage entries on attaching bpf programs
  bpf: extend bpf_prog_array to store pointers to the cgroup storage
  bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
  bpf: don't allow create maps of cgroup local storages
  bpf: introduce the bpf_get_local_storage() helper function
  bpf: sync bpf.h to tools/
  bpftool: add support for CGROUP_STORAGE maps
  bpf/test_run: support cgroup local storage
  selftests/bpf: add verifier cgroup storage tests
  selftests/bpf: add a cgroup storage test
  samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage

 drivers/media/rc/bpf-lirc.c                       |  10 +-
 include/linux/bpf-cgroup.h                        |  54 ++++
 include/linux/bpf.h                               |  25 +-
 include/linux/bpf_types.h                         |   3 +
 include/uapi/linux/bpf.h                          |  27 +-
 kernel/bpf/Makefile                               |   1 +
 kernel/bpf/cgroup.c                               |  58 +++-
 kernel/bpf/core.c                                 |  77 ++---
 kernel/bpf/helpers.c                              |  20 ++
 kernel/bpf/local_storage.c                        | 377 ++++++++++++++++++++++
 kernel/bpf/map_in_map.c                           |   3 +-
 kernel/bpf/syscall.c                              |  61 +++-
 kernel/bpf/verifier.c                             |  38 ++-
 net/bpf/test_run.c                                |  13 +-
 net/core/filter.c                                 |  23 +-
 samples/bpf/test_cgrp2_attach2.c                  |  21 +-
 tools/bpf/bpftool/map.c                           |   1 +
 tools/include/uapi/linux/bpf.h                    |  27 +-
 tools/testing/selftests/bpf/Makefile              |   3 +-
 tools/testing/selftests/bpf/bpf_helpers.h         |   2 +
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++
 tools/testing/selftests/bpf/test_verifier.c       | 140 +++++++-
 22 files changed, 1028 insertions(+), 86 deletions(-)
 create mode 100644 kernel/bpf/local_storage.c
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

-- 
2.14.4

