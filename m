Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC9FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F4B214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PiaUqNSZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HHD6Rx0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F4B214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeIZRqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727555AbeIZRqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBX3aH019774;
        Wed, 26 Sep 2018 04:33:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=igZ2gcZwx3O3PodjvyCaG2JOuK57kvQtH5t9RZidYxU=;
 b=PiaUqNSZAAYyPvMMw32AOKvHUDWovrOR7+yAeO7DefYE0BZxI4C7y/ZgVnAqZYUp84ic
 aE6DioE7NHnsvR8Jm3ivNPULsFYyp1tKH51IyS+EMrMR/tZ8/NjS2t2a4zm0XjX32u/z
 /Mu/HxEokJG5DFf0s8mBgg96p0tB5TS+rH4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr4vc0njr-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:33:56 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igZ2gcZwx3O3PodjvyCaG2JOuK57kvQtH5t9RZidYxU=;
 b=HHD6Rx0cXoyRcosPp/S0NX05fff+9dK/7fGXQ3ZzjchbVK0OGA1jgn/UGBU24J7reNuWJvVQ1sxBZdmzmRFavrFm3UWqV2Jo1wNrGsFJ7Lu9VcUkY9FqPVLeyw+x5AGwCl8OJ2Q40ZNjhBCnrfiFmhYYUmFwlFOVzTRE1TIJW9U=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:51 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 03/10] bpf: introduce per-cpu cgroup local storage
Date:   Wed, 26 Sep 2018 12:33:19 +0100
Message-ID: <20180926113326.29069-4-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9bce4a8e-ea26-44d1-e320-08d623a3efb4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:1O0bJ/rtdTUJ+ya9Y4xKLbpf8sTFSBQO8CPgg/aXopsw1NBKg3a0OINslUrq2nxKbBsHUKr4e+smsRFCtRBendR3jedvinUPjUfZoUWm9fBsuh8oZH7Ld49+qb5U8Ax3QFRXK34xgL794zcUqryF5BWevFGM0SNLMI0KY0dtDJXqejqo07r0cRdPdFOwd3N8J/gpdaUsQeWW/aPbNhLsvvUy3ryi3f7NMoU9gzUK5B9a0u3BMXjmZqMoE1fKChGr;25:QQ2GHbJKyWANrENVSWjysHoFqFMRIILbLCTNywOYWYFCht3tcGvwN/c9r1HQxpOZQaLelXJaVjz/UeNyeMYT+7x1Aa7QICz3E87uTGKZ0fLRk9lhVEXvZQ3M0GnLWbM+w7Xqr/OEefwa64ZgS6JChXBew8rks2fcsgURcP+YoGFZALxZxRC3599Nlr6o+TDg7YVAm+tOModSbUfsMX3rbG4iPz0vjJ2MG3q9Pr225RZ3ofSuKNykvq4nrskeQnQC9SVlKr8Us+DcB3zldVmjS2YQep2WJCXsjz3aI4MohNwbiiyYBzLeQL5fX4lXhRXVIKWedgBXGv5KHZlzX1F/+w==;31:KqzzfsmXkN8/3lH6geJoYDl+ub6y6pY0PwFd5aDPXltu9Wju7gZ+kr+xx9KcTdNG/30z1etrZgWGoUp/is/KnKlhyE4c4Zcd1kREY26EFRUUzddipmw25awhTmEj/u7SuClXasJ2vFp0/j3YpaAziJ+Kpu53d6D4v8lK3hlMtol3fBGWazMFgzCrYxaqSYB8UF1hRt/5wOHLVlD4q8sfKTAxWPu+K0s+u8UzQD0BVBU=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:IRi8wEeFTn7G03WfQNFCqh4/ELl+RnaojM03tPE/kX2JON7Du34kfNTZ64Tt+hWq46Wilp4rysB7qwTj76rhopA12VAcbGgY1yKQld2SFq+q837vzPGzKkFme+ixBqzYyZix/VHzmjD8QNa2dp6YUBBiO6dvOL5pYQKbh8nfsZrSlASDdNTa1+kr0iFLGzs4/65p2FLLk3raa8nwBPnaTzXo5g0DjTddRjRNKbpXeTVTrOih/5k0Fa5p2RXysZob0HAtJHXTs1O3riXfbQsGqPZdI6LW2pc+LN8mcb6bFFnOagpSkr8U3jHm3rRyJtyeijnFHsidSFZrGFVbkNnyrYHqJGqq6QoQWX850ssb4tpucZi21d84t6eZVzJxMiK8At/A0i4nOxZ05asoTOjJYMDqiXJHId1mf1J5rUWqvFHIp5RBzmg+yIv3ELm7yESy/DnNyyRsy1XC2I6vsxo8/i8z1ecOPFEPCV9cm2RvDBUSiqVJHT09FDQIsgJjwsZu;4:hFWWhFSuRu/c4ltb1LVx9VAkpJ5/J4kGfVxSWvrBZLq5tq8rGqg4otTPuRfz8A7xxo8yM3l9B2aCTKCXZ9gwQTjC1w+uC53kbdzyTkh23eJMp2UPOvvdRdpSQ5kpnWHWitbvcmcabaUkR0WZUzpOpH/cH8ON/P7+hgZuxV8dj1DcsrFihinS8tveVNEG1Z88ckcM1WsVZq1JcPvNlTcj0/p2GwrdW5pG0mZ/RYIZOeMD0lZRzp/v/ioMky61m10Y/t7Y43mOVWFTgQfriKvJD6gI5YoPgr74ZtDCFI48UgxoYM/m5pGqhYJY55ZxNdq0j2BJNHJMTLH4Y93mExdsyA==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162DC7B915B8CB6594BDDBDBE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(575784001)(14444005)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:u4PxoMGbjgL5+HjdDuEcHvRygv0F6+rnIlT93RGvo?=
 =?us-ascii?Q?X517xayNDH0vkD4xGikBBpX5Y+pRRh7nuAQAhF8FoGgEGsKsmjDQ50jowc9G?=
 =?us-ascii?Q?SXptY5J0yDqmaQuXmjFoZz5avv16oZWvi3CCZPW1p1Iq+gx0yHss9MM+2NSn?=
 =?us-ascii?Q?dJgt0dFxlkaS60ZH3O4p69quU5CuyfbXXbIKX+XHG+zNuraqJ3mV4qB0o13L?=
 =?us-ascii?Q?uYhUDr93D2yNfNQJ+XnSdJhhEU2rXT8aTCFBBhUgF5uUAD+JP62FVSY+gjC6?=
 =?us-ascii?Q?X90hazkqidhSvYrC350zYfPkaA6TuPMbQTp67IpuRUpzQTZWoTzUesgsqpjC?=
 =?us-ascii?Q?ip/bA5O3sqv9tnJycNaF9jyjxhqX1uZFDr/ZBfXUTW0eJcujFyTIxgGWWzpx?=
 =?us-ascii?Q?tZ1jIZkpGVlvyayshvtdrbYYROjSnc3ltct5CtxkGUyfAV+uE+ExzqGiEJoT?=
 =?us-ascii?Q?8Sr1DpB+rslqoyI37F2A3CNuESHd/dwIR1UWN+/9IfqMME2DsQPJTAyOwS1G?=
 =?us-ascii?Q?04u+bntVlObnBDlf+GGMXQt281z9uVbRVDCT/ueoBkbpy+IcOWrpaY/CNGvM?=
 =?us-ascii?Q?UhoDAq+bTvpf2/xbktPEs2kyjP1MiFWDT1ZmIJSG/lzl+BBzrHH7fCGdAna5?=
 =?us-ascii?Q?W4RZNwKcj/Q71nyvVgeLDivCXMcnY2eD2CJEoU8FgomWYSxJUIMwITk+1ByN?=
 =?us-ascii?Q?D+ihSptWLIwkVIkl6YwIZhzT1HXXGlO6/CJ5UX6pgvwcbVUFIXHgdvHb7Rue?=
 =?us-ascii?Q?V79Ov/GzaqQyE17FPtNhdVbZc4FH3gNNIrBjungK5sG8Lw1SP1+2wwtRZHsS?=
 =?us-ascii?Q?L9YuKvm3+Eu9isUOMLGgq5M1wk6QOwoa1xwmWKvmDlPv+c2UD2dCGKeilRci?=
 =?us-ascii?Q?Gp7a+QxG/G0+gadc0ObhX6Z4MIOIFLxUBAwPgXleBzOB+Z29NtNdLV3OOAZo?=
 =?us-ascii?Q?jISbR9aaMV22hKP9boyr1kjWleHicFDSHGgLtO/k30HBfEHEvZ9W6Y8FUJ0N?=
 =?us-ascii?Q?nSyci/RMNgMuNzwO3MMW/8DDsgjz4LyshXwEMmAv0s8kKLUU7uheIBphd/BP?=
 =?us-ascii?Q?PdFAbH29leS5JVv/dlqGMO0PWnVcFdd2civfysN4GrBHLF97JOwchVrbK6H8?=
 =?us-ascii?Q?2hgaGMqMtNLEzkWlOrpaxVZxkfpouIbwIiXce2QaVNsInuRUPfts81qfHWIk?=
 =?us-ascii?Q?Zch6ZOkMTX6JUFFKKrlpSqSu9Awsa8EVKqvhukn+2dAFpRMz3p3SRgpmbRx5?=
 =?us-ascii?Q?d5NQMZ+TA+ESfWWN3e+GQiIL5cYKwPqj/Zda+hGgczpudRg5oEqlQHGJ2UMB?=
 =?us-ascii?Q?u+aIGLuQ1iE+ahitivY6DqG8xc8Nt93TPJUJgYGe7Fh?=
X-Microsoft-Antispam-Message-Info: d/dHih4LaSzcXnEH+fINokZXYGeyDlGEIaOX7h0QZMAuTounlUIRaKS6jwrKDzw+a8v48ezzbqEsoYxyLtRB7IPtZ9GKPBl1gniH+HkoSjR710MchQSI5BooXzzTT/JnyCT3/oNC1jpyO6hv9oDHrqPFQ64vOdhA0yxguO1spDIuwaNyjXR2K69u13C+N1/KW7Pn7ORjeYr1XpgOdRa3L49rWQt821LRQ2YkdcbIh/yEIXy/atIOr5PGw+HimkszVgSIvwXKdcrbg/rWGHdmbrHpPeYj/UoJstI+oeUYX/tGz2Q2mBsuI6QON6lBbWpL1WNxZg0GY5cAXNLFBEisRILcdB00dR9XJE4+AkV13JM=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:o/CQGdTUXQp/rHpmmJ1wbp+fCOQYvXeFvnLFGnNK4wnrOSQoh8Y2O9+NSwoZm6+J+kp4Nhv9RZ7celOaUWR2w0WFYT17DzRL2AsySK1JzhrJCU6IVk1rYa4HMqYAeXInfoliAa61Pcrgh6qPnXxbXsz5UL2bXuBKLwr9VZKcVuLJwzDBqt2pVPfNxS6NjVkAQnijD7oy+j86qBnTn0PduaswNGEsDH+nLjL4PJ9FDUxWQXYr4JMPJUga7Xoi6A/pG+EWB1jTfUKqERKbroac3tJg09yFzluDJKXFBCyRp+uBYGlesYlI5mKOOZ56cvRMfV/by1Pq37JRjBp3amdctUx8EUCrr6DTkyaf3rHYVpl9yXqjIitsRa4LAYlzrudlwQicBxOPPofx29FbbmJP5lCwzwHzsQe0xufrtpp/lNifCqAus4QKLyS/ijG7ldWlWfhtkuxmjqoHGoW0mizwKw==;5:v9ft/iPrrS61NKTfqxPtphy4g7FbniA6uYQR6Bb5ftBPMJU+8VWqjNbuEK0uaN+Xc1Yu20HERmiTcST+W+w59dLhZf4fWbKmDeWbrVC6AKG5RfkiIvxuSXv3hDlvT8AyFuZZKTyX4iaX3I3hyccgX4h26a37LQm0aZoBcgg/d30=;7:U7XCqI/tZxbxHjzlhhyxZIoryO/so5p8Z9XIpQlxly0+EITLAsv99VD8P71GBBqcwu6MSk4cc2kPWls7jAmPuEbAj8GrVjEldRVFqETtp67qiXjWfLzltspTwxrcWr0ReVlFlaBI/yQR54Bx5kpUx5EQNSJJxEevJQrM3N2cgX1OQiA/SumzaiG6rZiifveUs8eXqGODB9rTBYzkJaudgdYDH/uK8cwAwtZI7wA83dfno+d5yRVZ3+OouTIA0D6a
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:fta6GKtKpM/zw5zGABMpBZqUn+V28a7UIm2osO5RUCPmeafrNgj7L9vnF+kwImb67HYMHqfX9piJ659+taaF9iFYwXSs54PBqzFRp25YRGXiYPRuO9XcnewuSTmDEB+3SF/mFKqmNbqtvAhpUO7APwKqQgpjA2cQwTZqDmlmVlc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:51.9027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bce4a8e-ea26-44d1-e320-08d623a3efb4
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

This commit introduced per-cpu cgroup local storage.

Per-cpu cgroup local storage is very similar to simple cgroup storage
(let's call it shared), except all the data is per-cpu.

The main goal of per-cpu variant is to implement super fast
counters (e.g. packet counters), which don't require neither
lookups, neither atomic operations.

From userspace's point of view, accessing a per-cpu cgroup storage
is similar to other per-cpu map types (e.g. per-cpu hashmaps and
arrays).

Writing to a per-cpu cgroup storage is not atomic, but is performed
by copying longs, so some minimal atomicity is here, exactly
as with other per-cpu maps.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h |  20 ++++-
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   1 +
 include/uapi/linux/bpf.h   |   1 +
 kernel/bpf/helpers.c       |   8 +-
 kernel/bpf/local_storage.c | 148 ++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c       |  11 ++-
 kernel/bpf/verifier.c      |  15 +++-
 8 files changed, 177 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7e0c9a1d48b7..588dd5f0bd85 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -37,7 +37,10 @@ struct bpf_storage_buffer {
 };
 
 struct bpf_cgroup_storage {
-	struct bpf_storage_buffer *buf;
+	union {
+		struct bpf_storage_buffer *buf;
+		void __percpu *percpu_buf;
+	};
 	struct bpf_cgroup_storage_map *map;
 	struct bpf_cgroup_storage_key key;
 	struct list_head list;
@@ -109,6 +112,9 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+		return BPF_CGROUP_STORAGE_PERCPU;
+
 	return BPF_CGROUP_STORAGE_SHARED;
 }
 
@@ -131,6 +137,10 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
 void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
 
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
+				     void *value, u64 flags);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -285,6 +295,14 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
+static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
+						 void *value) {
+	return 0;
+}
+static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
+					void *key, void *value, u64 flags) {
+	return 0;
+}
 
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b457fbe7b70b..018299a595c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -274,6 +274,7 @@ struct bpf_prog_offload {
 
 enum bpf_cgroup_storage_type {
 	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
 	__BPF_CGROUP_STORAGE_MAX
 };
 
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c9bd6fb765b0..5432f4c9f50e 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -43,6 +43,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #endif
 #ifdef CONFIG_CGROUP_BPF
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aa5ccd2385ed..e2070d819e04 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -127,6 +127,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SOCKHASH,
 	BPF_MAP_TYPE_CGROUP_STORAGE,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e42f8789b7ea..6502115e8f55 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -206,10 +206,16 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 	 */
 	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
 	struct bpf_cgroup_storage *storage;
+	void *ptr;
 
 	storage = this_cpu_read(bpf_cgroup_storage[stype]);
 
-	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		ptr = &READ_ONCE(storage->buf)->data[0];
+	else
+		ptr = this_cpu_ptr(storage->percpu_buf);
+
+	return (unsigned long)ptr;
 }
 
 const struct bpf_func_proto bpf_get_local_storage_proto = {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 6742292fb39e..c739f6dcc3c2 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -152,6 +152,71 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
 	return 0;
 }
 
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
+				   void *value)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	int cpu, off = 0;
+	u32 size;
+
+	rcu_read_lock();
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	/* per_cpu areas are zero-filled and bpf programs can only
+	 * access 'value_size' of them, so copying rounded areas
+	 * will not leak any kernel data
+	 */
+	size = round_up(_map->value_size, 8);
+	for_each_possible_cpu(cpu) {
+		bpf_long_memcpy(value + off,
+				per_cpu_ptr(storage->percpu_buf, cpu), size);
+		off += size;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
+				     void *value, u64 map_flags)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	int cpu, off = 0;
+	u32 size;
+
+	if (unlikely(map_flags & BPF_EXIST))
+		return -EINVAL;
+
+	rcu_read_lock();
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	/* the user space will provide round_up(value_size, 8) bytes that
+	 * will be copied into per-cpu area. bpf programs can only access
+	 * value_size of it. During lookup the same extra bytes will be
+	 * returned or zeros which were zero-filled by percpu_alloc,
+	 * so no kernel data leaks possible
+	 */
+	size = round_up(_map->value_size, 8);
+	for_each_possible_cpu(cpu) {
+		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
+				value + off, size);
+		off += size;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
 static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
 				       void *_next_key)
 {
@@ -292,55 +357,98 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
 {
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
+	gfp_t flags;
+	size_t size;
 	u32 pages;
 
 	map = prog->aux->cgroup_storage[stype];
 	if (!map)
 		return NULL;
 
-	pages = round_up(sizeof(struct bpf_cgroup_storage) +
-			 sizeof(struct bpf_storage_buffer) +
-			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	if (stype == BPF_CGROUP_STORAGE_SHARED) {
+		size = sizeof(struct bpf_storage_buffer) + map->value_size;
+		pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
+				 PAGE_SIZE) >> PAGE_SHIFT;
+	} else {
+		size = map->value_size;
+		pages = round_up(round_up(size, 8) * num_possible_cpus(),
+				 PAGE_SIZE) >> PAGE_SHIFT;
+	}
+
 	if (bpf_map_charge_memlock(map, pages))
 		return ERR_PTR(-EPERM);
 
 	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
 			       __GFP_ZERO | GFP_USER, map->numa_node);
-	if (!storage) {
-		bpf_map_uncharge_memlock(map, pages);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!storage)
+		goto enomem;
 
-	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
-				    map->value_size, __GFP_ZERO | GFP_USER,
-				    map->numa_node);
-	if (!storage->buf) {
-		bpf_map_uncharge_memlock(map, pages);
-		kfree(storage);
-		return ERR_PTR(-ENOMEM);
+	flags = __GFP_ZERO | GFP_USER;
+
+	if (stype == BPF_CGROUP_STORAGE_SHARED) {
+		storage->buf = kmalloc_node(size, flags, map->numa_node);
+		if (!storage->buf)
+			goto enomem;
+	} else {
+		storage->percpu_buf = __alloc_percpu_gfp(size, 8, flags);
+		if (!storage->percpu_buf)
+			goto enomem;
 	}
 
 	storage->map = (struct bpf_cgroup_storage_map *)map;
 
 	return storage;
+
+enomem:
+	bpf_map_uncharge_memlock(map, pages);
+	kfree(storage);
+	return ERR_PTR(-ENOMEM);
+}
+
+static void free_shared_cgroup_storage_rcu(struct rcu_head *rcu)
+{
+	struct bpf_cgroup_storage *storage =
+		container_of(rcu, struct bpf_cgroup_storage, rcu);
+
+	kfree(storage->buf);
+	kfree(storage);
+}
+
+static void free_percpu_cgroup_storage_rcu(struct rcu_head *rcu)
+{
+	struct bpf_cgroup_storage *storage =
+		container_of(rcu, struct bpf_cgroup_storage, rcu);
+
+	free_percpu(storage->percpu_buf);
+	kfree(storage);
 }
 
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
 {
-	u32 pages;
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_map *map;
+	u32 pages;
 
 	if (!storage)
 		return;
 
 	map = &storage->map->map;
-	pages = round_up(sizeof(struct bpf_cgroup_storage) +
-			 sizeof(struct bpf_storage_buffer) +
-			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	stype = cgroup_storage_type(map);
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		pages = round_up(sizeof(struct bpf_cgroup_storage) +
+				 sizeof(struct bpf_storage_buffer) +
+				 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	else
+		pages = round_up(round_up(map->value_size, 8) *
+				 num_possible_cpus(),
+				 PAGE_SIZE) >> PAGE_SHIFT;
+
 	bpf_map_uncharge_memlock(map, pages);
 
-	kfree_rcu(storage->buf, rcu);
-	kfree_rcu(storage, rcu);
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		call_rcu(&storage->rcu, free_shared_cgroup_storage_rcu);
+	else
+		call_rcu(&storage->rcu, free_percpu_cgroup_storage_rcu);
 }
 
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8c91d2b41b1e..5742df21598c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -686,7 +686,8 @@ static int map_lookup_elem(union bpf_attr *attr)
 
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		value_size = round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		value_size = sizeof(u32);
@@ -705,6 +706,8 @@ static int map_lookup_elem(union bpf_attr *attr)
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		err = bpf_stackmap_copy(map, key, value);
 	} else if (IS_FD_ARRAY(map)) {
@@ -774,7 +777,8 @@ static int map_update_elem(union bpf_attr *attr)
 
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		value_size = round_up(map->value_size, 8) * num_possible_cpus();
 	else
 		value_size = map->value_size;
@@ -809,6 +813,9 @@ static int map_update_elem(union bpf_attr *attr)
 		err = bpf_percpu_hash_update(map, key, value, attr->flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_update(map, key, value, attr->flags);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err = bpf_percpu_cgroup_storage_update(map, key, value,
+						       attr->flags);
 	} else if (IS_FD_ARRAY(map)) {
 		rcu_read_lock();
 		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e90899df585d..a8cc83a970d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2074,6 +2074,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		if (func_id != BPF_FUNC_get_local_storage)
 			goto error;
 		break;
@@ -2164,7 +2165,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_get_local_storage:
-		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE)
+		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 			goto error;
 		break;
 	case BPF_FUNC_sk_select_reuseport:
@@ -5049,6 +5051,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
+{
+	return (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
+		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+}
+
 /* look for pseudo eBPF instructions that access map FDs and
  * replace them with actual map pointers
  */
@@ -5139,10 +5147,9 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			}
 			env->used_maps[env->used_map_cnt++] = map;
 
-			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			if (bpf_map_is_cgroup_storage(map) &&
 			    bpf_cgroup_storage_assign(env->prog, map)) {
-				verbose(env,
-					"only one cgroup storage is allowed\n");
+				verbose(env, "only one cgroup storage of each type is allowed\n");
 				fdput(f);
 				return -EBUSY;
 			}
-- 
2.17.1

