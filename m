Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A966CFC6122
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450A820894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ji6nxeAN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YSYF4zns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450A820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbeG3TiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:38:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50296 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730671AbeG3TiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:38:04 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UHpdtS030163;
        Mon, 30 Jul 2018 11:01:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jjQDxH19kVIiM6W25t2mvZ6lYn+GWixHhSdAj2O35o0=;
 b=Ji6nxeANwQld9btMYdAobQsibRZfxY6qHjnm9Ufdcq1/eZu1qjOddNGeJ9hGWkVgcfYc
 /W18QdI79CIH93dKh1D+NTx7mUXywfBQuLR4mOJGknJtanNZSn7dwnIlJ2+MOlRdry7Q
 CRAohNxbVVUP0cv3suki6+ZAqHeA2UIlIgs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kj6yy040v-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 30 Jul 2018 11:01:39 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 30 Jul 2018 14:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjQDxH19kVIiM6W25t2mvZ6lYn+GWixHhSdAj2O35o0=;
 b=YSYF4znsOJXSuq6eb7RA3Z9R+qDHczs8/3N/oGH2FP3kHmXSDhjlxBuSQS6nM8Xtglteo2kFjaOTBg1UM9D2QD2vHbbpLw0l22CIFuIYqWFLD7eenVfcDyu6wQ6L7GDKjGLV/AqWR/ZBV4AFtBHat2Xzzy9bHIC62/12afdmZAc=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:484b) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Mon, 30 Jul
 2018 18:01:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 3/3] mm, oom: introduce memory.oom.group
Date:   Mon, 30 Jul 2018 11:01:00 -0700
Message-ID: <20180730180100.25079-4-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730180100.25079-1-guro@fb.com>
References: <20180730180100.25079-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:484b]
X-ClientProxiedBy: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 547c7b7a-b56c-418b-65aa-08d5f6467d74
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:zgufgtInyxTjXDizR5/h+XZLEgl3EU3Pb0uCd4ESW+otWBrKVje91k8pwK+gD2riOagTVbfPVUVSi+WEWbtKH/7ln6OU0ZVu4GvCW/2iyCy/HCi721nfXdxHIslR+N+ojrpG3c9Ttl3xPLxvd04BF8ZxgofYGwt0c7LAkXqfQTNhkyGXdXIt7fVG/ouIBDILxB6Z9W10aN4/foBELOvJe5Py9eEgBV9iJAaUvkoykeaBHqmmzHoRGM+vSlngtVCN;25:I0+w+loOR+hPinGuoYmHtZ3xB5rzrvvzSpI6jng+TWLZ4qEWs9fpHigezXF91D+NTYwRJPVO1FmJmrBIcwBeY4FVEOTnUwzr0tMJVNTcdGbQX1CsaIK72A/cE8L1mzGpnuGKDAOboNhkGwMRKfISQMZEEWyWd7uhFFADz21GtzJ6BgDfrNs4/CnWUVGB41sAKkS3fD4enyUBIRQ1meCwcob5GyScIsj+1vu0S4lO8YQo4cfQJVrMrbavbwWgz9w1fJQ9Ghl9rPgvXaxtKLEMLcTvahPsA71hgXAlbvn9HhfEIQ1BtjDtWp4D6V94YBWVWxcooKHuAmtnJta4HVCwlg==;31:VCn1kUOzk8Lb/9N/uNcF+SnFDjqz0EVng4gQE7ED3Tbjvf8+d14oI3w1s9ozQZj2W8CMU4R0nlvPCCDMZAOGY3QWgQ8xDI+QtnyKDenvVUYBD2wygpDUlAi0Lp8ee0ScngM/eaRAV0C0xmFxt7e1u5qPsAk+qfojKcGKGdDKWacPW2zrd3HXw+EB7XJ+bNcHDgQziYVvEjUG6LT4RqoJv6uPL3wB0b24ij1T1vasqIY=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:860WIDtG/UpAZLKw0+6k8sh+bLUBegcQmNM8ougELaVT9j9CjcEE7OGviVlxPwMtpDHa9n0Id5wE4OHYyj7GnYcPmtRLkprFMW835Yu+j6B61+wb5fw2MgcKkpoRMUokmcOqLcbfdCZIAn/d9MWeeSHyrcmCMeZhlqZrAihEQDVmhIIH/gr9Q6FiyIyCSWbIxaDLW8fDHp1JjuFHtdRIJy1xKKTTVhUEG/MNbVwxWlodk8Y080MDa6p/h8LNiyvws/iCQWoSb3u/f8sAXfU/I1lj4ZQA1U9uIS81s0fHkFP14QUAyZUmGRfpP3BLhVgRX64tDcrpuzC2F6nS8AY63N0Zb++zy5YW6qrQQ90EzDE4p/hqAj5j5mHl1Wa25fIEBhkjxZ4GqvliNmfdtTgwzLVR9zUbr/VUldln9U0A372rkt79ZppmaX9LGmyqPzeDgCVZyrb9M7A2LNo43pEacYAz5Nnv2YQsrSlkLilZnnPqV5ngMiZ2qPCuvByjTpfJ;4:Kjowog2MJ/a5HzVF1nIbjZZnoMbE9zdMXMdciyGk4RKmvjT/hwQJ+V5PIiWkA5yiDDO7hrk4wsY2kIacwh8x++QYDzHKquTMSKHC2MkuMfJuR4ePy1BZX/aPHOHovBh7KuUDVNQ7OLmxDGiufgIMy7E37TC2kTpQYVhAgy6BVor2RfWOZj0bhMg43cKQVQTphSonap37HctTGU8vs9WT5I7vUcJJ77jSzm7E3TTMheLssQt40/+BaR+R/BPKpUEYZUoZpGPiWWMa2JMqeC6Th9Fd/EV1eI5WssPf8CGzpG06Ac1wPMhW3A61CHOWCA+0nWcLd0aVRERVX9pC+4ly2Qg8Ag74nyeo13yiz+t4nb3N2J5Yzn8w1Rf1sjDowd8HVqqJizsW9+a3uuwnJt5vGp2VL1Qn5bVHDUN4sZ6SGZM=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175F444769D2FA0ED0732E7BE2F0@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(274141268393343)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(57704003)(36756003)(6116002)(8676002)(6486002)(16526019)(6506007)(386003)(186003)(1076002)(86362001)(69596002)(76176011)(52116002)(51416003)(52396003)(81156014)(106356001)(2351001)(105586002)(97736004)(8936002)(81166006)(305945005)(7736002)(53936002)(6666003)(50226002)(25786009)(53416004)(478600001)(6512007)(5660300001)(2906002)(6916009)(14444005)(54906003)(2361001)(16586007)(316002)(11346002)(446003)(48376002)(50466002)(47776003)(476003)(4326008)(46003)(68736007)(2616005)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:o4r5UjjHWzzC695YOvuCiEuK8UK7ZY942zzLMKiyu?=
 =?us-ascii?Q?5bHuENhV/VzUrdiue4TBnFW+sPyDsjzo4BYMSVuPHZjJTa8w7+fzozgddgQB?=
 =?us-ascii?Q?7UxEkHTaT2CIg4PAyjiIsM51AjovMwuceX5N5lJ7oX2HwCc5zVlUsXFfwjH3?=
 =?us-ascii?Q?kP+yxmedyFgNMSpBB9c1o3kBqcEwug47vMz0+lpROh2ImeFCNtS8aoDikald?=
 =?us-ascii?Q?MguUsIuj1gH1IN7M4rLICqD2FWwq/RE5dBeleIw1hgReBH7Swc0veDo/Mc3z?=
 =?us-ascii?Q?wwn0Krk2kihD/R7K51Q1nb3HP9jQzDqlTYEDtKgw3Ft2ZY27iOORGFmRuL78?=
 =?us-ascii?Q?HaPnsO5ia/3seiEN/21xbNFuQgN9NOTuxHHw4l+LDovcTGoI5ecp6KKHeGGb?=
 =?us-ascii?Q?EPVIDDQyZVJeM3bxnWAGyij0rghBDXY8vCuTkam8zd6iZfP4sSLkvxhyOdJR?=
 =?us-ascii?Q?TP3kVqLK9Qttf9rv/OCuSnoIifqsWeSobPPT6O+haq65UptPwz1hsNFgTHQ1?=
 =?us-ascii?Q?nJb4/K07XnkqxMA/LAtO7vyTYJiXUW7gZ+WB3v9ELQX6zCCaxfDfYI3nrlZH?=
 =?us-ascii?Q?D3lL7qlItUgDWA7LpMwOrZOwQ5IB8Ga/ESm2NlSGYMFyCmwyB7eGif+L9kfE?=
 =?us-ascii?Q?htcsjavSkQJ+1QmZGG6EvgBt3Bf/XA5Wn8PDWO1o/A2AIJp2OXUaddpI9jHp?=
 =?us-ascii?Q?Khpwk2Apd0iDw/jek5TyRtT3VOgZfA79LPysPKfv7dKOLUkDS2lO0+YgXdFK?=
 =?us-ascii?Q?pAaxu6UTzHcspDJwmBvNteosOf5o0oLKHlI7VziWk8Dtei9QmQUq2ZZsdwDx?=
 =?us-ascii?Q?XfFSX93DdV0BpJE/Uz1WHHl1awl3/p72RNMKd1rT4KGEEUrhikOb6yQ5Q6Qq?=
 =?us-ascii?Q?wmetbfkhJpTOl1oAOehotvVRtiL1DcD+iGP3DrbOtIb+1+UbkY8mDNxLZOMN?=
 =?us-ascii?Q?ApJPPvU4w2eFDiZzs53UOQwRSYfry2+opoXvQWaHJFxucbKOWQHcJBwBSagC?=
 =?us-ascii?Q?SuW+Qh5EdIFJKozDytYo+XDukWxxauRrB/03PWZHBo7iNlWjwTIIubJvf18E?=
 =?us-ascii?Q?bfN0WVoKYv5X2vuhzahc3tHaIGshLueTmARxR2/zRWaixvs+8spudEFJyLB/?=
 =?us-ascii?Q?lFdzmMWI6pVFiCkRF9/lwwBXck5rcUUJEgIBbeOBEMuTi6ghi/riGep74clH?=
 =?us-ascii?Q?ZatZ8rMHiQiFjnvAwj9Hv7FK0S6QD6z/FiImIgAfgNwnVUuvTp61GdihNiZo?=
 =?us-ascii?Q?BQefsmmL7evwNc1r5ULnyfhDusmGtb/A38Lu0L+q7zCGLfLG9qmS+miKrriE?=
 =?us-ascii?Q?6fi4/w/E6J4y73fCUHKFOQ=3D?=
X-Microsoft-Antispam-Message-Info: B9ZZjynnytnsdY7VwfTOysbM+FZkB2VwexVrtw+GiSW5iH3EpMvP2GG2uzyFiUNZlHCIdjbgH08WG1u1UnaCFZeIZqdHPBTzUp0+r+17C+PEnsYNlvkejWUHL78A+wx69udziLd+3nzMiiL9trXKupH+zwiaBxd2ErHoUlCv+GysJBQxKz/wW/rDWLcFskrlUKyJRn90/r5wJeTe6mZU2O4G1XOGyWh5yyAwOqJRZJgCHtoB1rU3nKSkS8DottqZtSWV2yzxUET+9WfWoYx8dQMvrqkken6YZEZR/QtkFRG0xuTLYbWpOP9WoIyX1JsinrQq8HWBx5vx1jVGL+be7YcSm8Ro3QDQ84TBjlBo0FA=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:ulQYMdMpJ9kroD9t1jj7z49To33EMupnzKLSQbs8YwR3k99bUeM3Sv8Gep1LWAJ3LXjdrjAH8n9KMmwYT0VlzWjRmflgQiUKfomA1KvEjz5aN+/AvjbpX/4ToSMuLkltjVFp9zXm3Ddehz5NoL1rFxiet2VvanjMky4UMaIXP6XNXk9Ts5f94qVAs7TiPI4Oixngf405LdVTYoZB2trqStmiAAFJcvc3bfOAnwhz/n/DrevzNQoyM2qWGQ53GYS0Q1AoyEXzNsQjPsCieCchNs7sHJY8Z/yUwVA1E/G1lzfOmkAsnOCVTpI0+EynJNHLURTJyoOy/M5A/kQTQnEtbU1yRAveormN7+yrZO5C5cLrBC8B0CjujKDHjk7rc/nT05o2Tg9uwTYPc9KfFsTt6SmL1/4k43B+/LX89+wAEeeJVtKrMxQc6AzZ14d6NBP4vcFEIQq+/FtWKdRHmnVY2g==;5:8GWXatIc8OUazawSDWjWp0Tm9YFEhwaweTYB0j8ES8IgPkId5Fp2o5QXH9lz7v2sh3IYzB8rumgYFsks6Fskej3q7zzrDq+0qbNcb9WJUjvm7L6OsXMU7b3bhCgp+L/XG+pyJ25jr78Dt64IX4/NfoATm+mmHqCDhdild1iBlFU=;7:ZWSqt2W1PfwlUJxwbbf/5tDRLLSiIZdmyKbABoZiYzuEd+rlcCf8FKgEJ9FtgRPug2u53wrDFZ41h38XQGxCS+c9VuPIfvlSuaFuqmMQS6pSAULRJCsP6W7eCGDpELNteJzlumhb0bT4TFRMx/RwxVNb/dkzzpl9BipWJ2n9/zxr1XJjyRl45thGCs7IzpfoJsbdSwk8DwunHU3bO7M2pdoukEFy0Xqei7G71Pg2IxDCyBQgsgbN/qvoLwWcTSLD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:13HiqwHM4zJxqVcU5T/02cMpCKodW5WqmYC0nghDV1p96OkU8tYWv0dDE9W4N3WdKXaRPZUEl7NnqHIcIkwHCa1Oxe704SBLVUoM59EtrHwfEjxwdCZUVXUSnBq0sxHKPlS4dmg8uRM2o0TXaii/TRSo1I2k1uPdwX+3Lzp3Hn4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 18:01:33.6401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547c7b7a-b56c-418b-65aa-08d5f6467d74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some workloads an intervention from the OOM killer
can be painful. Killing a random task can bring
the workload into an inconsistent state.

Historically, there are two common solutions for this
problem:
1) enabling panic_on_oom,
2) using a userspace daemon to monitor OOMs and kill
   all outstanding processes.

Both approaches have their downsides:
rebooting on each OOM is an obvious waste of capacity,
and handling all in userspace is tricky and requires
a userspace agent, which will monitor all cgroups
for OOMs.

In most cases an in-kernel after-OOM cleaning-up
mechanism can eliminate the necessity of enabling
panic_on_oom. Also, it can simplify the cgroup
management for userspace applications.

This commit introduces a new knob for cgroup v2 memory
controller: memory.oom.group. The knob determines
whether the cgroup should be treated as a single
unit by the OOM killer. If set, the cgroup and its
descendants are killed together or not at all.

To determine which cgroup has to be killed, we do
traverse the cgroup hierarchy from the victim task's
cgroup up to the OOMing cgroup (or root) and looking
for the highest-level cgroup  with memory.oom.group set.

Tasks with the OOM protection (oom_score_adj set to -1000)
are treated as an exception and are never killed.

This patch doesn't change the OOM victim selection algorithm.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 +++++++
 include/linux/memcontrol.h              | 13 +++++
 mm/memcontrol.c                         | 84 +++++++++++++++++++++++++++++++++
 mm/oom_kill.c                           | 29 ++++++++++++
 4 files changed, 142 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8a2c52d5c53b..f11de1b78cfc 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1069,6 +1069,22 @@ PAGE_SIZE multiple when read back.
 	high limit is used and monitored properly, this limit's
 	utility is limited to providing the final safety net.
 
+  memory.oom.group
+	A read-write single value file which exists on non-root
+	cgroups.  The default value is "0".
+
+	Determines whether the cgroup should be treated as a single
+	unit by the OOM killer. If set, the cgroup and its descendants
+	are killed together or not at all. This can be used to avoid
+	partial kills to guarantee workload integrity.
+
+	Tasks with the OOM protection (oom_score_adj set to -1000)
+	are treated as an exception and are never killed.
+
+	If the OOM killer is invoked in a cgroup, it's not going
+	to kill any tasks outside of this cgroup, regardless
+	memory.oom.group values of ancestor cgroups.
+
   memory.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e53e00cdbe3f..05c9c867a3ab 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -213,6 +213,11 @@ struct mem_cgroup {
 	 */
 	bool use_hierarchy;
 
+	/*
+	 * Should the OOM killer kill all belonging tasks, had it kill one?
+	 */
+	bool oom_group;
+
 	/* protected by memcg_oom_lock */
 	bool		oom_lock;
 	int		under_oom;
@@ -517,6 +522,8 @@ static inline bool task_in_memcg_oom(struct task_struct *p)
 }
 
 bool mem_cgroup_oom_synchronize(bool wait);
+struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
+					    struct mem_cgroup *oom_domain);
 
 #ifdef CONFIG_MEMCG_SWAP
 extern int do_swap_account;
@@ -951,6 +958,12 @@ static inline bool mem_cgroup_oom_synchronize(bool wait)
 	return false;
 }
 
+static inline struct mem_cgroup *mem_cgroup_get_oom_group(
+	struct task_struct *victim, struct mem_cgroup *oom_domain)
+{
+	return NULL;
+}
+
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg,
 					     int idx)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c0280b3143e..ade832571091 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1577,6 +1577,53 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	return true;
 }
 
+/**
+ * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
+ * @victim: task to be killed by the OOM killer
+ * @oom_domain: memcg in case of memcg OOM, NULL in case of system-wide OOM
+ *
+ * Returns a pointer to a memory cgroup, which has to be cleaned up
+ * by killing all belonging OOM-killable tasks.
+ */
+struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
+					    struct mem_cgroup *oom_domain)
+{
+	struct mem_cgroup *oom_group = NULL;
+	struct mem_cgroup *memcg;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return NULL;
+
+	if (!oom_domain)
+		oom_domain = root_mem_cgroup;
+
+	rcu_read_lock();
+
+	memcg = mem_cgroup_from_task(victim);
+	if (!memcg || memcg == root_mem_cgroup)
+		goto out;
+
+	/*
+	 * Traverse the memory cgroup hierarchy from the victim task's
+	 * cgroup up to the OOMing cgroup (or root) to find the
+	 * highest-level memory cgroup with oom.group set.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		if (memcg->oom_group)
+			oom_group = memcg;
+
+		if (memcg == oom_domain)
+			break;
+	}
+
+	if (oom_group)
+		css_get(&oom_group->css);
+out:
+	rcu_read_unlock();
+
+	return oom_group;
+}
+
 /**
  * lock_page_memcg - lock a page->mem_cgroup binding
  * @page: the page
@@ -5328,6 +5375,37 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int memory_oom_group_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+
+	seq_printf(m, "%d\n", memcg->oom_group);
+
+	return 0;
+}
+
+static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, oom_group;
+
+	buf = strstrip(buf);
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtoint(buf, 0, &oom_group);
+	if (ret)
+		return ret;
+
+	if (oom_group != 0 && oom_group != 1)
+		return -EINVAL;
+
+	memcg->oom_group = oom_group;
+
+	return nbytes;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -5369,6 +5447,12 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = memory_stat_show,
 	},
+	{
+		.name = "oom.group",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_oom_group_show,
+		.write = memory_oom_group_write,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8bded6b3205b..08f30ed5abed 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -914,6 +914,19 @@ static void __oom_kill_process(struct task_struct *victim)
 }
 #undef K
 
+/*
+ * Kill provided task unless it's secured by setting
+ * oom_score_adj to OOM_SCORE_ADJ_MIN.
+ */
+static int oom_kill_memcg_member(struct task_struct *task, void *unused)
+{
+	if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
+		get_task_struct(task);
+		__oom_kill_process(task);
+	}
+	return 0;
+}
+
 static void oom_kill_process(struct oom_control *oc, const char *message)
 {
 	struct task_struct *p = oc->chosen;
@@ -921,6 +934,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	struct task_struct *victim = p;
 	struct task_struct *child;
 	struct task_struct *t;
+	struct mem_cgroup *oom_group;
 	unsigned int victim_points = 0;
 	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 					      DEFAULT_RATELIMIT_BURST);
@@ -974,7 +988,22 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	}
 	read_unlock(&tasklist_lock);
 
+	/*
+	 * Do we need to kill the entire memory cgroup?
+	 * Or even one of the ancestor memory cgroups?
+	 * Check this out before killing the victim task.
+	 */
+	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
+
 	__oom_kill_process(victim);
+
+	/*
+	 * If necessary, kill all tasks in the selected memory cgroup.
+	 */
+	if (oom_group) {
+		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member, NULL);
+		mem_cgroup_put(oom_group);
+	}
 }
 
 /*
-- 
2.14.4

