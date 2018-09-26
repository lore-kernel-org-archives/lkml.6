Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD85E214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jHrsBGL3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VJ0fMl+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD85E214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeIZRq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbeIZRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8QBXtDG019791;
        Wed, 26 Sep 2018 04:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=02iaS4sIx2z3FLNb2E9gVORzLEKYv+Y553T9d9BaGy8=;
 b=jHrsBGL3ADKoah/yNW2i0EcqmqDmEjJMAvn3wxreEC/CE+PMTyLRIhu79Vwr4vzPNNxG
 srmGtoAPI8jm/WucBPTT1bZJxEPMRbmZpdpl8kYfLZx2vJdSk0+KDXyCobsDKUT9yz09
 vXSOPDGIeLA7T7TdvDYU3SOPSMLLXb3P7jM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2mr7s008cw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:33:55 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 04:33:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iaS4sIx2z3FLNb2E9gVORzLEKYv+Y553T9d9BaGy8=;
 b=VJ0fMl+nFAz1X4yyskZQUwMOd/etXMvLkFBEM55/tDj6TQLQDx9JQkGOFKs5LNsnweefI+tHWoXgHFpEa8d6XtKBoGlGUMWCvNLbKa84mnhfgb3cnEyK1cMfGg5de1yDIgMrm/4uu0zP5wUGTlm5fUicCFg26B3lAQdUdInsiJY=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:47 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 bpf-next 00/10] bpf: per-cpu cgroup local storage
Date:   Wed, 26 Sep 2018 12:33:16 +0100
Message-ID: <20180926113326.29069-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:15cb]
X-ClientProxiedBy: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0449a8f-40da-4c1e-e31f-08d623a3ed27
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:e1jZqL/xjh3rnSWRUheQs9UTfaIMD8IebSwLslBYSkIT5P+IRToo2OMhpAzDVuhkRWLMeAkDIldjMWZDFaC4iFg8QPLtrYnURbhCOr5gT0sYO5pBRjC+zQ2Hk+SS6uhd8KMBwCD9Q4dVP7Q2fn9UyUliF9pdmhYHBWciXpczUf+ZymjETRgSmwEogkiRX04P+Irv1+XAnxPBIbR+Xi0p4guGdZMcUA8SJ5DhTW8B4kd5hPLOzrTLWMvsYHil0Qmz;25:hHzKm1wxfaahsZAgxVA4w/Hvxtz2q1f7GXJeVpQvs+tL4XzTVHYafwRpX1N9U1JjgCMgiG3HyU7a/Vhdd9QsPGrc2rn+4AqdQl35oK9ovYqJlaOlxjnTW9lJ/dkicpqLiejR3oemtAezSzv88m15cjlF+1hMcYEINj52x9N0/gY4AWdbXsS9qER2nrC2NRS+N1EnGdPMkSNAwNeR1Jg++isg84mXpybbYCOrFVj+W8kNpun9tumHtmWE9wUqrV5z9IN8CiazeCuP1gTGlMj7yGZmzSNiYOT3/ERjH6Kr4Y89ywl6u5myCCjjuuVPf9b6vtT9tj5b9+llfNlrMgKh6ovz6u8fjXCw1GC0ESTmYmY=;31:UOF2u9nfbzT06VQIFqqtiX7gEzhM2aO7j6eGRPOV4N2K1Bp4SQm4JWqZP7z+Qk1mCpgh+SvHK3JLyRImiRn/dv7qccz3FLHu2nS+6xYm3TVWcCZenbumlrZoFn6+9MDsJLnBhOZWOKyGBzXa9RaxtJYq1JVY3hr/wr30G1FbbIltkYSOpMRdUm0u08J6vfoDU5kXX9+No9Y8Cf1tMklDFpmX9zQYBJ6qNFmXoo0Oxi8=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:+LTa8o6SpSEiVAvkxlbPDvCEIFZPQWGl7FabbpObrYM927XwzMfDyiZYV2odHeeKfIF0YhJp4Gc5JT4+ByqF+Nz37Tv7zmpf8N14zlEpHMrQ0L9TwDoK5RlLHByL47U1ctL78blencb5NAVqGRzARlB9hQD8tLIvQYSgwhJ1cJ8COKMdRgNr0zoVvWsAXeCiZs3mW8MwvN7new5Qnxup4aqsgYD4X+1Ml/YJLHOjJm3D6uIjLP0EziHacBo04cKTufAkamuc9nFAAtAewxr/P1mBQ1hav2i3h/LSsee72MAWwjecXjwhQwYt9/Vv68HMdbftkekbpHmz/NNwpfv9tW5/ejCmJkbEvsL9F65wjqxIRAsozod4Uf8OIFDdIclTjb0IRYCMeymHj4nY+UKDGn46apmEI2iwvnNa6C8tDFh5MDH0BilhALgFvNjSmqedoZUgxFRDKwyruStrAC6WRsGGcLFp9UhEzSvE1MeTYSK90WEHGGXYVFEihn5hq9YT;4:HO5ZG+M9f17ZjKi3nBfiMN1iihqGd9XLBSb3do5dh663fkAiQz8g7yACx7JlpsC8ql+dX7iNPlrX6T6rNxr3ksGtZGenEkmKkSwvC/h5ARfbwLsTMo8Nz2fm4Z/byxsCuRYq1AzHltm26v5aX2amWDadU60ivtH0ynOu9w0k+mn2DslHqXabGO7FXlV5JpLq5RgZtyBP1xyrxrLf4b64Jg1yl173espb+s42qUxCk7ptad4l+N5txf2aJnfTy5BtpGwraLsQkKCN8i9Nv96AXQ==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162E439681B3DB5EF4D60CDBE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(16526019)(478600001)(8936002)(46003)(186003)(36756003)(52116002)(51416003)(52396003)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(450100002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(14444005)(5024004)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:VwX2pYvRTu3Zc6KQt3eRY6PW2cr0rWeNuaQIPTROr?=
 =?us-ascii?Q?HMf7tG/Su8IhX3oF4mJRfBmbWzDTxGuOAnTKygLfEaL0fjsTu/Kx/LhB2a3Q?=
 =?us-ascii?Q?nAQ4aS/7wDCKqTH6NEGIbj7Ez2XNHkDrBQM6zKU4LNfCdbMvmQ7ecOw78ymQ?=
 =?us-ascii?Q?PsyqBdYO1eZf7H6nf0aYSIWLKTWVEx0/brwNWc4t/zxACBh1pzLzSU2CVrE9?=
 =?us-ascii?Q?XJNt7m1fH5kijxyaJlzy30fpG6pYQwQqQjoDnrGZ9wRo0V4/HmiZTQ4yo/nI?=
 =?us-ascii?Q?yYHv2mXmOzeGwQYB9RLMvgOwY5XHgxXNUMKXDQybLY1CSufeoUOEcsw0ibAw?=
 =?us-ascii?Q?BIC5oZan43w+54ZUj7czhW1aflJyg+YOeTBO/dyjZlSRN2DaSwMnqnWcY6be?=
 =?us-ascii?Q?XmnXgF3ng4KgcD2r81UrxwqKoXA3DPdF9TrUF0SoLfqfKd0Cpq8FMmKDdF3c?=
 =?us-ascii?Q?FKxY2LrdW976wGplMcDbS+pA53sSvVKfV/ydruJ32Q0BGaodaT9M93CFrYCO?=
 =?us-ascii?Q?m5naGcPsYHiPeN38C0/W4l6rD+/fH9JM6Bkxs9KIe0oWnBl8pEYyB3sfE1GQ?=
 =?us-ascii?Q?vZHYVMmOts4VHZ9HvRh5CCGz71h3kFfCaRGeM1XFBZBRjsieW33Zx6Vp5qfY?=
 =?us-ascii?Q?/BvuK8nb9mPsbcfr2yDFM0LntPvk8Q/PBsoUyb7kDP/s3H3SDTnS3BYdkRBy?=
 =?us-ascii?Q?/R1uvSpI/jymrHVjIn3VTjoJhljNDKaCi/2edxwlsQpeVWBXyOjOTt+pkg8U?=
 =?us-ascii?Q?Ff1QAyCtqEH6jI+BSf2aCxSoZzsf840r18dT+o7ELP5oqPOR4GyZ8JGg1ejL?=
 =?us-ascii?Q?CcZaNtrmrHg4rMGOFrtYVPvVpKnbNq9r6/oadYTbj2EZWcyfTBANo2yXYINo?=
 =?us-ascii?Q?D2/OdTuStBVi+DhoOQnO+DNapGxkkDNUQGXbpljPltv/JdhK1FR28j/1ixfz?=
 =?us-ascii?Q?ep0bXmNQ2jfwzjP22H0uvJqBko6T/Sw0ECZ0oMtyY4O6/ncdNcq8m0gW84mk?=
 =?us-ascii?Q?4cvlOtCuMyyuU/WCJNOjNnzdRfvjnOOxGZYx0f2k6PDZWjYBJbpGJD4r8etz?=
 =?us-ascii?Q?Q9NRGmBImkmcBtIEZnBNGz+5fCk2awduQfM/FR9fZ8pzQ/5jFjRzfMqjLRXX?=
 =?us-ascii?Q?mu/oXAv8AGSPvAeqMO/gN2wqHvF0ITKlvgZHWxsG8KVNKkXi5bKM0l8jvdpa?=
 =?us-ascii?Q?ZDbujxEzFQQqhh6ffo0IQdYFwD/x/1UwE3h/Tjteh9Mhpw2xkzuc6Fc9MZkh?=
 =?us-ascii?Q?M/AJINGG+nIvelFmlLsid9ksErlh/5WsxoKoECLVMINqMlO9C8kLek83y+cH?=
 =?us-ascii?Q?1nLLkqX95nkGRjrnhco8EI=3D?=
X-Microsoft-Antispam-Message-Info: WvGEdsZkEV345mOZri+kBcAcvDkGFEhQqJ7RloLcAskoYO/oMNhwKgzaa03BKu6kBIML8xnliTya6pbYtB5iGVmPNHOUQLRNgT6kDuvApKUoG1BlYX8oBW3LttIllwQlkOUhQX602EpPQRI+nPpNEpn9reDoI7qH2NerHxUOGDEg4iVVXKYRoP5KtzcaiP9Y5J8KrkgtlPCROMnfRtIRRABM4v3z5IrVAQBcoL6JgFzlxLOvfNu6w9xB3OwMrtsrMDHn3o5e08OJyHOi1dO129UOpq6Zwqo42eZgpoy2dHtzthtRS1swB91ep5xyQuvSGA7o4+zBKfF67QbLSz/+1lnQzbxbdownxjgGbFm5GGg=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:cCHJXThrP/4ZsdizpK8eL3mAt9TPUYC3ie9ewiG6HdxLIh2ks42DFyCOAnY+Oyn34pEv1VVlD6plfd3HOogxThtvKFjAqoXS2e8n62eJh3UYOPAyVGq3LtCfT6lDudSvUrTc3qAMt09oo9msZKKWfPcfwYSs58OV+O8U1hMw3MVdeaZAN2dXU176WYjHctV1ubdpaxVceBzRgdAL9ErpLYaw7uDukOh7slf20aoeSC8ZFkPo/lTpA0KkGJZUHtXWIkS99sZGn352DzPitbdUgfgiG9Lj0gjRlfWFukoPRDjpCv2PwUuBXWqcyDjqmH8rxC1WqZoZ3jWoQS4HWuvMPoI1QJtJRLhv5BdH5XoOvAe1OAunfpRxbnr/aUs2f3rHXxObCAejKbIKno3SCNFktDV8GRbIFTzMNhRP15AQ2xW8cyvijH4cpONb2Xp795SS9+cI8TI0pDeXRuMCS7jNjQ==;5:LM/cH9gFL/m+Skg6WvKqIkenGZDoU1R1sEAtjajtk1QHj68uWweph4XSbRZN4z9AQG3+GyR4UocJe3xf51hYZ3cUykshP2FdfmcC1saIItY2hvWMOk3j+pvwE9jb4OkRtY9Qmyjk49vLExZMM1ozhznAikjbqRzbrryt3yKKSD0=;7:sUP6AOHdCrE8MDJZazyahoh04GO8W0x7l2gvuEZP769QpNewTt/8Rm8nZdSQz2Z0wt8upGkHrnxAOdGMZDL3zOqYWA7JzYfL9ZZAmUA4qzjhcoJ7NBkmd3kkGBRj979NJoPM04AExrqxGn4QVxqy5onEx/X+bqtZ2NkwUfmKkXSnV5fopJGBEu/YaRR7oqpAuZkSOZEyzXekHv5gwEIEWnlEKjmqZTRU1EYYTKS+cZNTl75Zluz5X96yCvlyi2Bx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:M0GT1w4wkBe6WfBZeSp4NaVDkhpotdbygWY6AUyTP76yHbEWHi5Si1d7w9TgBWPtpy0FsA7XuLDzwTX1dLYijktgN0haxIi67yNz27V9a3daK2CX/wzXv8dLR/neMTfoIYcIs1OQLHCa6serpNqSMrMG9Jq5oATweyGxQ/azrOQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:47.7533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0449a8f-40da-4c1e-e31f-08d623a3ed27
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements per-cpu cgroup local storage and provides
an example how per-cpu and shared cgroup local storage can be used
for efficient accounting of network traffic.

v3->v2:
  1) incorporated Song's feedback
  2) rebased on top of current bpf-next

v2->v1:
  1) added a selftest implementing network counters
  2) added a missing free() in cgroup local storage selftest

Roman Gushchin (10):
  bpf: extend cgroup bpf core to allow multiple cgroup storage types
  bpf: rework cgroup storage pointer passing
  bpf: introduce per-cpu cgroup local storage
  bpf: don't allow create maps of per-cpu cgroup local storages
  bpf: sync include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h
  bpftool: add support for PERCPU_CGROUP_STORAGE maps
  selftests/bpf: add verifier per-cpu cgroup storage tests
  selftests/bpf: extend the storage test to test per-cpu cgroup storage
  samples/bpf: extend test_cgrp2_attach2 test to use per-cpu cgroup
    storage
  selftests/bpf: cgroup local storage-based network counters

 include/linux/bpf-cgroup.h                    |  55 ++++--
 include/linux/bpf.h                           |  12 +-
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/cgroup.c                           |  74 +++++---
 kernel/bpf/helpers.c                          |  25 ++-
 kernel/bpf/local_storage.c                    | 167 +++++++++++++++---
 kernel/bpf/map_in_map.c                       |   3 +-
 kernel/bpf/syscall.c                          |  20 ++-
 kernel/bpf/verifier.c                         |  23 ++-
 net/bpf/test_run.c                            |  20 ++-
 samples/bpf/test_cgrp2_attach2.c              |  19 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/netcnt_common.h   |  23 +++
 tools/testing/selftests/bpf/netcnt_prog.c     |  71 ++++++++
 .../selftests/bpf/test_cgroup_storage.c       |  60 ++++++-
 tools/testing/selftests/bpf/test_netcnt.c     | 153 ++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c   | 139 ++++++++++++++-
 20 files changed, 778 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
 create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_netcnt.c

-- 
2.17.1

