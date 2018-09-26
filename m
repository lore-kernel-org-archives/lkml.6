Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25090C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521B214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oQZxCagf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WvOOBKPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A521B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeIZRrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:47:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58100 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbeIZRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:49 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8QBR5eH007445;
        Wed, 26 Sep 2018 04:33:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ATjXr3aUZSnN4TX5vX449jQmrIa95OpNVGX5mIOm5pY=;
 b=oQZxCagfE9M6SUEY6QnZNpMG0Fmj6mnZ3Vd3eWmKdA3+e86cbx56921Wi5XkRbyQlIXB
 bM3fvlfs3QW0/AJjvr7CZ5TxD2M7GTZIDlrDDokSugIqvd1vY7EgIjxwzecW7GowzoYp
 eEpnim6YEHuC9bj4ZOqoVq0u6wK8o9/DM9Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mr01x1944-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:33:54 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 04:33:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATjXr3aUZSnN4TX5vX449jQmrIa95OpNVGX5mIOm5pY=;
 b=WvOOBKPlzrY28D9FxKq5iaijpwM2DU0GfBn5EC7M5Z/oh/K+5oeuExd47sYCkSdWcxPYoAGTvJJWpvz10FpHS/RCVlbgrCuGpLmwxMg1AomJQC4CWxfqHldSOLt4hhYCD3HY8M/fud7W/o3ESZe40pXZIGTRQr3h6Z3lgOwX2sQ=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:49 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 01/10] bpf: extend cgroup bpf core to allow multiple cgroup storage types
Date:   Wed, 26 Sep 2018 12:33:17 +0100
Message-ID: <20180926113326.29069-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926113326.29069-1-guro@fb.com>
References: <20180926113326.29069-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:15cb]
X-ClientProxiedBy: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 892a8f96-5986-4964-e462-08d623a3ee00
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:o7Az7yYzSN0zSRj2oR3Wvs2XOxU7i4AVPy/xgG8urcjN05gPy3SJINL9rbOzrZRxckUvDkSpQHOnIBe0wJH3Sy6H1I6Ecf8qO+GNxQWifHx3HMUnFbxdJx5IuvvMyRYACntskgXmmTgvQJRtGDDgoGzAZnO0mzMZ8wrNTLPO9L2Ts3iOxnJFbILggB05WuWZQqUoboqbHdbwY7vEBK+I9IVN+MweCP5nDt/6X/PFS1IAmLIAR5TNs3COOMA6xsqM;25:NFaDTKfhsrhR3N+KvBqsLcfdk8VU6LilG3tJWei23nPzxGtrKonnC9hEVNJxYZnVZSiziiQnu1Eb8GcCGoGVDGiUqE8/uAt1l/mUUtXQ5MTjIOXDJ3ujjTY4KIHHonJsqBuoicIrSK9v2cVJN1yypaCbahyM8gAKEsiTswXhOJIp93oRyZD9N7KOM4amm18DkJVBldK2axJI9i1KbfP25HcZd+5fb8vi6MsToaNeEBd56/l+SsdluUKPZ1jBEV2yN4E1k/FvqP/dRUp49CS349g4jPL2HXnzvkfhkUOSokQdgAVk2bLepCc/5Iot9x6Reir1jC/ZE06R2IHGPlkeww==;31:s5B+cqaeN2wAb4+Git+H/4l2Czj89q9qsbrjHkaaifzusPWJImcOEyT0UkU9Ysfb8iHplnJDS1tjRmQoiPDjvJKccNBYXk9d9t34Sui9k368aVINkL6OGJDOecNAJ3i3MqFpFsChqGUlSXOl2SnXO9nwtHsPBvpt9/dQoflmF/tYi8uQj9N7/tnLWITN4fc5A47CGB48/2TngZya80vhpQFHyHb/yHbx7w8Mzead/3k=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:yyfsE2k6OeMzJmkGujzY5/DuF0au6k/+uvOgYi0AZkgaI0m+tzs4x3eYhhxtgQ+KSmz7elM9vXx+3FqlWVJKWeFms4oByN/eghaJlRzoKKtWteA6Ue9Gj0VdId3ku8VqEKK3ETAPoEQrJi9bS9sG+laC4WVxq6WpRhVWrTvRaEhKHxEvor1jRdzRQ1p2pvFmizdP+qqVAuzJ2+OA09nDnNtxixvWiKk5TtFayQAO4P4Zg63szTUpQ4HqcT5aatUXgY+o0eVrs14gYCJg6ttv1tlyHcJh4giCHPlDetlSkEH0mCljbf9jJxwBCS8UzywCTegsNmpNF9DsivTwPeS3Zz+ETQRYwjsQaKhbNHUXVhJ+0F4wcGQsiRyzWPukz+ZpFYcMdOL5T6zzIMbE8GC/6VzY2402ywtmGSw11IysXqn+Z6tvYEu0/rBJjrZRgiKz5yiXePgm6bL8NLBTdt3qyKmTk63XAptctz/mUeo83ajVbDKiKDe8ctW4DLkry6GV;4:I/vKBjcZC0sn/Fmx1tUNjdVF3UegnPIzvGu8tflb2ls6JmMqKBCvdyev6fNg7oDC15XQ6vIOLEjF2ajkIC7bSKMwUX9DwpD0ayFN3+oi7sSA26Ym9JixYa0XPDhtzGPOWZzsKAySP6WY9w/FmR2nEQgwzutU3GCdyK48mzCP4TZXZUAn8RqMMWmkskiu76eJ/SzU9zp0tqhzogMrruQ3iu+a3pqnwp2Wj6cP9JXPIC1y6FmrIUi+hSb65yiGAn8rKV5epGsS36Dwae2dsrEQgvQJO4nSKZizHYP7NE/59QBCMf3y4La+uxQo+klMW7flDZEsZEe+ywfkc2iGKR88QA==
X-Microsoft-Antispam-PRVS: <BLUPR15MB016201CCF8135AF1139F9960BE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(575784001)(14444005)(5024004)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:CTaYxtFBSrEw0cfWPQyFZREFCHfBcd2CRy6M4bVh6?=
 =?us-ascii?Q?hpJ+NUuJeNiQCK8fGHy84Z40vAFDHSyZBi/SU8SlbPJCUoS3OZkwJ9TyzzMf?=
 =?us-ascii?Q?t2WmJJYtUC8r6rWiiVrJ2Tqsml7r9X7fDbwqS0Q46pCDa/YjZd467094rM7F?=
 =?us-ascii?Q?DOk2/hqe9UM9S0maqQjWYu9siwJFsJj5NCDDj95Nw8CLKmL1pSQaIK0+muph?=
 =?us-ascii?Q?MtJEbYq8DiMaiaMouVBwMulf6W34+D8AsGw9yNNFgib/VQIvdoYhywFk+z0g?=
 =?us-ascii?Q?2+nwUXF2bUf2r5RjMSQ2GUJxyBQi2DZKzSgKQl6zKINZYeWqPuOozAd94VhQ?=
 =?us-ascii?Q?c26eQ7rWt15KiT8Cr/gT7NoQTQjpsPvAgGe9lGECI0EwozviJRTkW8vmRnQs?=
 =?us-ascii?Q?H+H7THdG0qaTm75laOent1hKldlt2AUkX9Eq8PsSgBLzW6DakyNNBoyMt7Nn?=
 =?us-ascii?Q?w8+HLZqWgrthlm5igRaJi3rNYD1zAdEMfbjRdKvn634khJN2ayBUfvs46pRV?=
 =?us-ascii?Q?ZiUw/jw4DqSTzDK/mpG9fbXTxELpn4zd/igc49NBd7B5nDScDQ1mVHV17qI0?=
 =?us-ascii?Q?6L09d9tX3UeXOl9PPTGWLxOTMfbMRdSv44VqQC9Oa+9cx3oisoC42V04SOEq?=
 =?us-ascii?Q?BbzvzEkFfjpI+BOguk2MieYfu21Kf37E8VspQbCb6E6N74YsyvhE5GBDoYkG?=
 =?us-ascii?Q?1HKy2DWOIm1rnFwK6TJ28VCB5BgiuPb8H9wTEmpriBnoBDL5RVwb12ig8tQ3?=
 =?us-ascii?Q?c/3L4Cd2kBKFX7XHKCich4Np1a0k4b5Ni8SXflGerwu+3qUvdhGtNfgMEZ85?=
 =?us-ascii?Q?zDRCvzEHh2DoOD+pvoSJE2NntQuDmCwllxxyQcodTWufif3nbOVi8nAV/D8o?=
 =?us-ascii?Q?ywhASrWAc3NF8cto2zsORWzoooYoyodEUYncmGEZd2///Czp+rejyTEynMsI?=
 =?us-ascii?Q?WsBm0xEHXC3qAk5cPCM6tfgFzk1IVggt2y0kgzyWCHpwN4SufLXgtN7V9QJu?=
 =?us-ascii?Q?Z/XjyF6Uy7OhuGo5UKEMhu4oC2U4FGcsebO45CvUt3M7IvQfwA83vqtwnPUj?=
 =?us-ascii?Q?3wP/sOdQJhQdjruFrdFcbSdYM71HzofPqxjsnPyh/hD8iae77S/qJkP3+xec?=
 =?us-ascii?Q?UeSDLQAXF8noGVIYuKHUmkNT9Ljpj23lFhbBfaMWPg6DQDMyTu1axXD7eB1d?=
 =?us-ascii?Q?Lwta5XlTuzk9E4bc9or3+e67agvmH8CO4IC50c+hgqvrGtw/A9ZGwauzXFqk?=
 =?us-ascii?Q?zP5ZaZVzvToxfKXvuzfPls+TdLyqtKabsJspmCVqPELOqBaH9EFP6GyMblNE?=
 =?us-ascii?Q?JTpdDLksBVqEr9+Xf+9Zhi4WGB7YYDKtZEBLruCjEc6zOMiirMu35ONGxn5j?=
 =?us-ascii?Q?E3pNQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: XHsjAHAACd2eBz1Yr70BCkwLzvvkyAhEjC+S9QacrBW8Bmi3VvKXxFo31r4eJaTUAEPHHTY7ga7voevdoHeobqxYBsU+llkX/cFGzAiVu0pXxAu4275lz21MLztCxDexjsjHrIbBBhIrg2W7fvbNCFV2MoQRnFheB2NtDM6ybBhEmB3q/Ed/vrgGoLd9Sn6WlhKHcEAj9DomouW9320uNryILZTMcQDloM10nEl7GHzP9qp9cQ1WCgQQs70ieu2G/rwmwh0UMDIznNLm92K4MowFlo3JSjCInEfmQSDdn9UZLFBCk1Qs7V0EV6Z7lJsGPMNtbOQG/RW/x8ryThMM8EBDq3x0DLt8TE7XitV+QPk=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:3uY4QloXDSrmt9Y4c9vF9U5OkCj7Ro98t1fXc0MG4lB2qsuOJqGL53lT6bh/M/4ys/Kldw+YBPkOQoGuQ+3oN+x+VfU63/POAPf7jMM5MVVlbmuYzKFiLosGv83XIECfXn2IJtd5iFZnZi1rxfIrs9hHoANE9oBUx19ruw5m1D2elEjc14eMQJ7yiBdEFAc72h2ItKN4JJe9YgHR9d70ZzwKyTvUCuRdfUHKtTYRTmoJ2WE1v4XtG8fjappy93CcEx4pFPqhHq78OtP4BCZ8rS7Mwe+xRnC6hocrM5VMuSqLoSxsBVm1oeD7JuZ8PPqUN8XYBavwI4z8iYJ7KYhEpOYRheRw9AE5NwBdPPX/Dt5Nai8o5ZIWHlIA4+qBjjxNvU5TT/Ep/75n1+UOM9cGM0YclyVL77ytLX2EyFy29EC3zeZ/s2Pm4HZJHkX9kdbBRW3p/yHCSct3F+0ZRFk1Uw==;5:Ytmbl1M9Vja9toO76lF8718cty7Svo3joYNzpGicZe3T2BJV8zwWth8AoHs1uDrrqB87TISRVjbjEj1M6+Ex+AaDlzjxqarEBWI7NTR7s2kWYQC0+8NEubx5REfhxgLr8KH19duygIrHeHC8mhe8htZ3deTNcSQAMkunhd1IrMI=;7:pxG7cQFoiYkrmklHgB+Jj5F7r2m8yx92OmbhoYCxiQn5XSnIApDSZXVZ5DY8CNw6VajbwwcqWgDaHG6VtoF2hrUMF5d16xFYSgSOZfurA0xCuzVK9dfb5Etol858oCMpL0Q+A1RMuAeip1fddgDImO85AsaOcr/o3AOPqQi09wfYBIEm7aPWUliRLK6KEC9NJeOEhuHVZIVTNDVTCKLPOhMvUZ4EvoEQrvtfSzDDkqpouWBiJyDZ6kwHTh2/Ah0L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:z3iykuKse4qkr4Vwg+Aj3qBQYLNiNwduMz7xBA8bRdnJeiU68mi4tMpZfeSFEzc/s6ugTXkaaNtpYc+lCaM3XqIMsbJqNYVLmtMCbKDypwapRoaSACvqxMSZtBVhxI6TbqUmzYPoXR89Cr++rt/2aiZBK4v95ZKm6hTse4xWMIQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:49.0494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892a8f96-5986-4964-e462-08d623a3ee00
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

In order to introduce per-cpu cgroup storage, let's generalize
bpf cgroup core to support multiple cgroup storage types.
Potentially, per-node cgroup storage can be added later.

This commit is mostly a formal change that replaces
cgroup_storage pointer with a array of cgroup_storage pointers.
It doesn't actually introduce a new storage type,
it will be done later.

Each bpf program is now able to have one cgroup storage of each type.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h | 38 ++++++++++++++------
 include/linux/bpf.h        | 11 ++++--
 kernel/bpf/cgroup.c        | 74 ++++++++++++++++++++++++++------------
 kernel/bpf/helpers.c       | 15 ++++----
 kernel/bpf/local_storage.c | 18 ++++++----
 kernel/bpf/syscall.c       |  9 +++--
 kernel/bpf/verifier.c      |  8 +++--
 net/bpf/test_run.c         | 20 +++++++----
 8 files changed, 136 insertions(+), 57 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index f91b0f8ff3a9..e9871b012dac 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -2,6 +2,7 @@
 #ifndef _BPF_CGROUP_H
 #define _BPF_CGROUP_H
 
+#include <linux/bpf.h>
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
@@ -22,7 +23,10 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
-DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+
+#define for_each_cgroup_storage_type(stype) \
+	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
 
 struct bpf_cgroup_storage_map;
 
@@ -43,7 +47,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
-	struct bpf_cgroup_storage *storage;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 };
 
 struct bpf_prog_array;
@@ -101,18 +105,29 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
-static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+static inline enum bpf_cgroup_storage_type cgroup_storage_type(
+	struct bpf_map *map)
 {
+	return BPF_CGROUP_STORAGE_SHARED;
+}
+
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
+					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
+{
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_storage_buffer *buf;
 
-	if (!storage)
-		return;
+	for_each_cgroup_storage_type(stype) {
+		if (!storage[stype])
+			continue;
 
-	buf = READ_ONCE(storage->buf);
-	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+		buf = READ_ONCE(storage[stype]->buf);
+		this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
+	}
 }
 
-struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
+					enum bpf_cgroup_storage_type stype);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 			     struct cgroup *cgroup,
@@ -265,13 +280,14 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
-static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
+static inline void bpf_cgroup_storage_set(
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
 					      struct bpf_map *map) {}
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
-	struct bpf_prog *prog) { return 0; }
+	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
 
@@ -293,6 +309,8 @@ static inline void bpf_cgroup_storage_free(
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
 
+#define for_each_cgroup_storage_type(stype) for (; false; )
+
 #endif /* CONFIG_CGROUP_BPF */
 
 #endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 988a00797bcd..b457fbe7b70b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -272,6 +272,13 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	__BPF_CGROUP_STORAGE_MAX
+};
+
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+
 struct bpf_prog_aux {
 	atomic_t refcnt;
 	u32 used_map_cnt;
@@ -289,7 +296,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
-	struct bpf_map *cgroup_storage;
+	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
@@ -358,7 +365,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
  */
 struct bpf_prog_array_item {
 	struct bpf_prog *prog;
-	struct bpf_cgroup_storage *cgroup_storage;
+	struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 };
 
 struct bpf_prog_array {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 6a7d931bbc55..065c3d9ff8eb 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -25,6 +25,7 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
  */
 void cgroup_bpf_put(struct cgroup *cgrp)
 {
+	enum bpf_cgroup_storage_type stype;
 	unsigned int type;
 
 	for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
@@ -34,8 +35,10 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
-			bpf_cgroup_storage_unlink(pl->storage);
-			bpf_cgroup_storage_free(pl->storage);
+			for_each_cgroup_storage_type(stype) {
+				bpf_cgroup_storage_unlink(pl->storage[stype]);
+				bpf_cgroup_storage_free(pl->storage[stype]);
+			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -97,6 +100,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				   enum bpf_attach_type type,
 				   struct bpf_prog_array __rcu **array)
 {
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p = cgrp;
@@ -125,7 +129,9 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				continue;
 
 			progs->items[cnt].prog = pl->prog;
-			progs->items[cnt].cgroup_storage = pl->storage;
+			for_each_cgroup_storage_type(stype)
+				progs->items[cnt].cgroup_storage[stype] =
+					pl->storage[stype];
 			cnt++;
 		}
 	} while ((p = cgroup_parent(p)));
@@ -232,7 +238,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
-	struct bpf_cgroup_storage *storage, *old_storage = NULL;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
+		*old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {NULL};
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
 	int err;
@@ -254,34 +262,44 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
-	storage = bpf_cgroup_storage_alloc(prog);
-	if (IS_ERR(storage))
-		return -ENOMEM;
+	for_each_cgroup_storage_type(stype) {
+		storage[stype] = bpf_cgroup_storage_alloc(prog, stype);
+		if (IS_ERR(storage[stype])) {
+			storage[stype] = NULL;
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
+			return -ENOMEM;
+		}
+	}
 
 	if (flags & BPF_F_ALLOW_MULTI) {
 		list_for_each_entry(pl, progs, node) {
 			if (pl->prog == prog) {
 				/* disallow attaching the same prog twice */
-				bpf_cgroup_storage_free(storage);
+				for_each_cgroup_storage_type(stype)
+					bpf_cgroup_storage_free(storage[stype]);
 				return -EINVAL;
 			}
 		}
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
-			bpf_cgroup_storage_free(storage);
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
 			return -ENOMEM;
 		}
 
 		pl_was_allocated = true;
 		pl->prog = prog;
-		pl->storage = storage;
+		for_each_cgroup_storage_type(stype)
+			pl->storage[stype] = storage[stype];
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 			if (!pl) {
-				bpf_cgroup_storage_free(storage);
+				for_each_cgroup_storage_type(stype)
+					bpf_cgroup_storage_free(storage[stype]);
 				return -ENOMEM;
 			}
 			pl_was_allocated = true;
@@ -289,12 +307,15 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
-			old_storage = pl->storage;
-			bpf_cgroup_storage_unlink(old_storage);
+			for_each_cgroup_storage_type(stype) {
+				old_storage[stype] = pl->storage[stype];
+				bpf_cgroup_storage_unlink(old_storage[stype]);
+			}
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
-		pl->storage = storage;
+		for_each_cgroup_storage_type(stype)
+			pl->storage[stype] = storage[stype];
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -304,21 +325,27 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		goto cleanup;
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
-	if (old_storage)
-		bpf_cgroup_storage_free(old_storage);
+	for_each_cgroup_storage_type(stype) {
+		if (!old_storage[stype])
+			continue;
+		bpf_cgroup_storage_free(old_storage[stype]);
+	}
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
-	bpf_cgroup_storage_link(storage, cgrp, type);
+	for_each_cgroup_storage_type(stype)
+		bpf_cgroup_storage_link(storage[stype], cgrp, type);
 	return 0;
 
 cleanup:
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
-	bpf_cgroup_storage_free(pl->storage);
-	pl->storage = old_storage;
-	bpf_cgroup_storage_link(old_storage, cgrp, type);
+	for_each_cgroup_storage_type(stype) {
+		bpf_cgroup_storage_free(pl->storage[stype]);
+		pl->storage[stype] = old_storage[stype];
+		bpf_cgroup_storage_link(old_storage[stype], cgrp, type);
+	}
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -339,6 +366,7 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 			enum bpf_attach_type type, u32 unused_flags)
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
+	enum bpf_cgroup_storage_type stype;
 	u32 flags = cgrp->bpf.flags[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_prog_list *pl;
@@ -385,8 +413,10 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
-	bpf_cgroup_storage_unlink(pl->storage);
-	bpf_cgroup_storage_free(pl->storage);
+	for_each_cgroup_storage_type(stype) {
+		bpf_cgroup_storage_unlink(pl->storage[stype]);
+		bpf_cgroup_storage_free(pl->storage[stype]);
+	}
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1991466b8327..9070b2ace6aa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -194,16 +194,18 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
-DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+#ifdef CONFIG_CGROUP_BPF
+DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
-	/* map and flags arguments are not used now,
-	 * but provide an ability to extend the API
-	 * for other types of local storages.
-	 * verifier checks that their values are correct.
+	/* flags argument is not used now,
+	 * but provides an ability to extend the API.
+	 * verifier checks that its value is correct.
 	 */
-	return (unsigned long) this_cpu_read(bpf_cgroup_storage);
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
+
+	return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
 }
 
 const struct bpf_func_proto bpf_get_local_storage_proto = {
@@ -214,3 +216,4 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 #endif
+#endif
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 22ad967d1e5f..0bd9f19fc557 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,7 +7,7 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
-DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #ifdef CONFIG_CGROUP_BPF
 
@@ -251,6 +251,7 @@ const struct bpf_map_ops cgroup_storage_map_ops = {
 
 int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
 {
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	int ret = -EBUSY;
 
@@ -258,11 +259,12 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
 
 	if (map->prog && map->prog != prog)
 		goto unlock;
-	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+	if (prog->aux->cgroup_storage[stype] &&
+	    prog->aux->cgroup_storage[stype] != _map)
 		goto unlock;
 
 	map->prog = prog;
-	prog->aux->cgroup_storage = _map;
+	prog->aux->cgroup_storage[stype] = _map;
 	ret = 0;
 unlock:
 	spin_unlock_bh(&map->lock);
@@ -272,24 +274,26 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
 
 void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
 {
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 
 	spin_lock_bh(&map->lock);
 	if (map->prog == prog) {
-		WARN_ON(prog->aux->cgroup_storage != _map);
+		WARN_ON(prog->aux->cgroup_storage[stype] != _map);
 		map->prog = NULL;
-		prog->aux->cgroup_storage = NULL;
+		prog->aux->cgroup_storage[stype] = NULL;
 	}
 	spin_unlock_bh(&map->lock);
 }
 
-struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
+					enum bpf_cgroup_storage_type stype)
 {
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
 	u32 pages;
 
-	map = prog->aux->cgroup_storage;
+	map = prog->aux->cgroup_storage[stype];
 	if (!map)
 		return NULL;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b3c2d09bcf7a..8c91d2b41b1e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -988,10 +988,15 @@ static int find_prog_type(enum bpf_prog_type type, struct bpf_prog *prog)
 /* drop refcnt on maps used by eBPF program and free auxilary data */
 static void free_used_maps(struct bpf_prog_aux *aux)
 {
+	enum bpf_cgroup_storage_type stype;
 	int i;
 
-	if (aux->cgroup_storage)
-		bpf_cgroup_storage_release(aux->prog, aux->cgroup_storage);
+	for_each_cgroup_storage_type(stype) {
+		if (!aux->cgroup_storage[stype])
+			continue;
+		bpf_cgroup_storage_release(aux->prog,
+					   aux->cgroup_storage[stype]);
+	}
 
 	for (i = 0; i < aux->used_map_cnt; i++)
 		bpf_map_put(aux->used_maps[i]);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e986518d7bc3..e90899df585d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5171,11 +5171,15 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 /* drop refcnt of maps used by the rejected program */
 static void release_maps(struct bpf_verifier_env *env)
 {
+	enum bpf_cgroup_storage_type stype;
 	int i;
 
-	if (env->prog->aux->cgroup_storage)
+	for_each_cgroup_storage_type(stype) {
+		if (!env->prog->aux->cgroup_storage[stype])
+			continue;
 		bpf_cgroup_storage_release(env->prog,
-					   env->prog->aux->cgroup_storage);
+			env->prog->aux->cgroup_storage[stype]);
+	}
 
 	for (i = 0; i < env->used_map_cnt; i++)
 		bpf_map_put(env->used_maps[i]);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f4078830ea50..0c423b8cd75c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -12,7 +12,7 @@
 #include <linux/sched/signal.h>
 
 static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
-					    struct bpf_cgroup_storage *storage)
+		struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
 {
 	u32 ret;
 
@@ -28,13 +28,20 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
 
 static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 {
-	struct bpf_cgroup_storage *storage = NULL;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
+	enum bpf_cgroup_storage_type stype;
 	u64 time_start, time_spent = 0;
 	u32 ret = 0, i;
 
-	storage = bpf_cgroup_storage_alloc(prog);
-	if (IS_ERR(storage))
-		return PTR_ERR(storage);
+	for_each_cgroup_storage_type(stype) {
+		storage[stype] = bpf_cgroup_storage_alloc(prog, stype);
+		if (IS_ERR(storage[stype])) {
+			storage[stype] = NULL;
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
+			return -ENOMEM;
+		}
+	}
 
 	if (!repeat)
 		repeat = 1;
@@ -53,7 +60,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
-	bpf_cgroup_storage_free(storage);
+	for_each_cgroup_storage_type(stype)
+		bpf_cgroup_storage_free(storage[stype]);
 
 	return ret;
 }
-- 
2.17.1

