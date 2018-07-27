Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD0CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BB920842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BNtThLrR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MvYn83sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BB920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbeG0XRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389766AbeG0XRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:15 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLiZv7014706;
        Fri, 27 Jul 2018 14:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Lm5UDjv5kAeqcMnMtPp6SN2lmQfKo3EH37qPK/WCPM8=;
 b=BNtThLrRafJ3kNh0/gYqEiEdibIB1ZJ0HQfgvZXb7s0uNRJRy+Div82zwNEy+LKk6oAt
 CtnX8MHFUpXa3PVJ81DcFE9LhSpwRzX3IjaV/EkM0NpG4RYLWHLkZ/s/17MbcGZj/a/d
 eN6OgzvEP02Cly108kGl1bDgnW/rSwXpyBQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb59g2n0-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:04 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm5UDjv5kAeqcMnMtPp6SN2lmQfKo3EH37qPK/WCPM8=;
 b=MvYn83sKwm8zP9KaQorG8kPVV6URwFZLDLaGK//KDs2FERHRfIo1/sQOmqSzpU2wAkSqLAWA1YBVo4Gv9OPUgHsedaFqs2yyDvrpGodqkQVZTwa4xZl8SOkCMeLYNs6BTlFfYq6d02bfZ09wnldgyCnUHQWIEND3xNDHMgwX7b8=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:52:59 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v4 bpf-next 00/14] bpf: cgroup local storage
Date:   Fri, 27 Jul 2018 14:52:29 -0700
Message-ID: <20180727215243.3850-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b421243f-7b2e-4232-dd76-08d5f40b51f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:MMvCkCatGpvK770VZmsKSI8Mo+FnaVoUqbbAFZKXvgKsiezlgcy/9aJmIgr4XRdqjpDBtOCcH83YKXxwXIXmk8EyCrEtYbN6HphX0cpqFBJKRKIGTKkOBAC2ElxOuLBQOninECU4XFJyu1MBvKWi129AHbIRw0ly7+RqnMxyVn/nAEdA89m3Wc+WTmiOceRDczlbXw3aVt/E+GybcD2yJZ5fXe1VPqzw4RTzCD9u4LVJnDQfFin9WWrUsw2CyCuM;25:EdPoBwGhTIP6p8/exnXDlWEB+w2ThjcMkzw+T67Hqb/SqEZrVqR73ho8wgBuJ+zS8vHdNqIVfTO65Nx1LQAERPdRgAPtvhpA1aifj9mRl4Rti7b8uoRvWrcBZ3PJ/OOPknBBn/8Ir8CCulfqUr9vM1Zb3kjV0lZDF37qsslCVlplXCk20jCZVNaf82yjIivpOQ/dXXP/iNWVcxtQBLCkJcCT3NCw2dmcAwz5lstYwakrBfmXxNvgWoZcscAqotcY2znlE4ik9XUN7SJtpiL4C/XoQro7hR63by2kfBDHoJe/Yb4ZlPcPq5orR38BsrJzOlW3tvEYj7O7bi//9fbQmg==;31:elPCv2l44fSIIhWw5JbIdwr7C6K3iN1tNB9wr96HijV6QyHUzAUQ1JRD2sz1FgNZGol3Tw41gXlnhgZTtpnFW+zJVafF5IVQmKTC4rIc1xpkXmQeMqGtGquHt7YNbvo+Nl2ojmv7v324puCHBXsyp2w+I9O0YLVk31R0mWI6QE7UVwPtrhN4T7PjXF7UbUAQvSg5hHoY4WQVlQsG2EzHgzm3eumGVMX4jJ7ooAtqkFw=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:I+5POs8wRrweaDQDq/OTnyxht/X2/gax8GQFfBU0FtlPsgMA6x9rlrRCk+lXpgdnpgroE9RMIH8bOl//r2AkkR5jjHeubmrs3wEdAMtQeNYBQlqhSWdPU5bJQu0mMbchrDPqk7TmhAzjEsq7MOrlLSTiM/a70v/jtHkHKuyRtvijhsxEEKPNVWtcRIlXd8irwNbfCBNw03+aFuaMvkT4xn13tq2jj+ILywR5oToi0n2ao8IiVcbtVSmCpxRxYvNFqRgiUX4wlC4Mw1SIwY8Bskq5IeGl3gpbGqVjdcqDQMSnpRxOLOz9Nu/9vzO0MKfu2LCUem6vjdOYtYtKcnp0ywjpTy2vGrCK1d2kh1nr1UrrweQ8ZDaIj9sEvJb+NoSLericZWkRgLAS6DfOGz35Lck6GKxlyL4u02v5Q2U3frboV9a5DMr9hN2ToWGXaKdghX2wnH433MobavmFgH+OhPVmvsVksJNVeU8JWgzWv6gNx1UbNuw+7aY+btjHBwI7;4:b+xcl2Lomwd5tpEAFQiQB+0ukOKnDB6LHNUU5SDvz6nWjnkqkzk2fj54YMTmci6otNUUsIGodu4jVWDPSPWFhFAjEKxP110Uqh/m9Dp3eGg4cPKjAjbg8CLVRAk2Byludn6WBGKDojbv0o1wwU6/LgAl36yR1IrMipJtPwSbMLXe7PW1UL/++MONOOarTsSYvFpMnYqIFyCzEqW40GkuopfXP0qNu4LEVJs/Y2SoHySEviRwuQjhYyTElLMDpMClU23/wzECkGUkA+M48l0FrWpwbtKqEEWgeTDnP4skdViIb2Cs45gh74+n2MDVHbjW
X-Microsoft-Antispam-PRVS: <CY1PR15MB01714B71048B6393A7FA9961BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:QMqpE7pdAFP5O0Ek2tCMsD4RT6x4toRjxAfAT8sNH?=
 =?us-ascii?Q?oaL82oBPf7y7xcqWmeu9adkdJPQx/u4O3X3Oak8d/b+JDO3YirOrxlzlmtpF?=
 =?us-ascii?Q?K7/WqEAKNGyhnvOSdFXIp4SDLEWhldrBPc4vh8i3TN8R+VwxZozyM1CswrOG?=
 =?us-ascii?Q?wY3/LErC/vOErBLe3Kuabo+HYhY65iFsEjxg4mICGVBcTK3mX+oouvPmNm4c?=
 =?us-ascii?Q?T4+BIMrjgnVMInOUylRd60zz9m4TTAPgsLbQI4maYFMEfPFWKDDrVmredx1w?=
 =?us-ascii?Q?r3F7qJ9c+phIa6fsw2khzQpu7sxeHsDLqc3/gETwl6ZDE2ZeuI+LninMwLUz?=
 =?us-ascii?Q?NHpC9TwCijJKE128DC6a9nhllLObR3rj1LfaAn3y/rSw5FmOoJZiT5YT25rr?=
 =?us-ascii?Q?uKTRU59ivkyQDRPAMVXq5ZB7yeJAF5gPs4KrmAJkjOhnRroLx5+/1RXm3TDz?=
 =?us-ascii?Q?bgk7Y5cTFHa3S+F58aJ5u95gMHBgXbE8DBL30AeFyqF2GtKIhINYKvnhNKOl?=
 =?us-ascii?Q?Kz3ZE0dTVVzV3vb9Y1TRRoBSPfjr2HLMNMlfLYVhCMZSnQm5/i785cEUPfJs?=
 =?us-ascii?Q?zkspBU1CRoNOQXdgNmh0ZaC4w0v8DOCf8ep3V+7bLYw4D4nf17BYYQsuOjY9?=
 =?us-ascii?Q?R+QDycQBX0G7292XTUM0OdipGAwy65bao+HdgN3LsiUqNdc1MnQUaOdVAbPi?=
 =?us-ascii?Q?XJrl7NS6J/KKSxBtdIFDfmUzfDCpZuJuaZKQA0SaQXhTxxyNMG4dG9m/vMkN?=
 =?us-ascii?Q?U6r8nxN1acbOCmDKt09IL7e8n/VDKa4i2K16uWxF4n9chZCMojHIgrgNhujP?=
 =?us-ascii?Q?xcwbyTLeQTF9FRTcbBujhifR6RnZmRUP2DEe2Unb12bt3isIHkHbfqOa9G4z?=
 =?us-ascii?Q?sTVLC+xFWaOB/qpi3zG5TeRxRNvlseIDd6cb0V8a2FH3iOv3zrkX+ikAMHuM?=
 =?us-ascii?Q?GRSyXf6k5ZG58hYNeK+thHDARb3O7Mov6L6jd+O7f9wesbQAvkzZu0Pu+ib6?=
 =?us-ascii?Q?Ab5CaPtHRjXqIbB/CFtO2jFiJld0fU3Saw20wbeJiSkSmhv8Swuw0Vd4EVL1?=
 =?us-ascii?Q?CwUxRfw+tL+g4Lwopv8i5+R/dq4uBFI9PKeRuqA44NSWtun+PG3fr8mxioTR?=
 =?us-ascii?Q?igRh9w1ECZLTYBJrKezcqMJPqSEGeIa6KVZggNb7baQnY8Gjl4mBj4LsDtZC?=
 =?us-ascii?Q?IltfhlcndXbyvxuxeE0Ci7glSwgYhsX1J9sjEO+6U9u9Eo0F+aWM+FZolV0W?=
 =?us-ascii?Q?xhuHfvflA/bWk0k2lQ=3D?=
X-Microsoft-Antispam-Message-Info: /w+jUqh0ocQd3SyOTVBChj8KB5PanKGVLHuzQKR/d+rv3oMo9rbwQ9fJUnJD2Oih/RGN4cGl9Kh5amH5sGU0tykEg8MiGO/fqeTu6aKA/HCnq7YnRQWrtl88RKtEmetT/ybQU0HNPlehVmn3xsj/uEC5TIaqc8PFE36qGoRMhZDB8U0GjVevgr7jXRyGF5mGtZeElB3PGolprru7oLE3MZGRlgnsDE0rfCfXxtWBeEdNdSm8XStStZHdVvoGnBQzGsazBK2/TlbZJ5cGgwIcWldeeVkjbRX4ijoE1PCnjiOuxjCjiJZ3NrhTdZ3zZlZkxhSzoviNlr57iS6CWv9mAkn8UWGTEQJZU1A7heBwBxs=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:3V1gRh081KqOuSluWoIAz/BiP5W2kkWRxJIKp6CZfiweJ3gMzqH7gWt+8ngWF4POcAvgoznSWJj+8Q4hDMC8mr/B+7gNKs/YSK3FxFq4SK9ozDxx+mBY/pCZDgfpfC3qRaPG8AoZHztbF1sX4YlkRDoMAtMDjJsEEgbJquMhU4AKL0e38xkRRFuyKP3lOKXf69vUma+nM3oHP95VxLx8EGljl96/Sqt5LRlvfPK1RjyrGUWb9asPHtDnFJz5cETYIR7Z4dXBrwY4N4TDcA9r6zzMZz8uuHQPR8g/gNCg9D6Yu6HE9PL8aQblWLynB9rSrVOPZt/isMvgoqWjBhQ1kIoeqpWsZ071fXyA2TXKFw/MOSJj4RcWr5IsaDnDpeHNpTAtD/zBocL9yZUANA4S4DXH+Ojlqgpk1jrTOZar2oPToVNT29kLrtVMHanp8h7as4SzwnI+DfsDlSPw5SRZvQ==;5:looi4hLagPJxTSlEbkfX5F7H/B5qof3iFC62MGynMvQeykucPZK0OdYud2AEvG6nYMRrxLO1hBjrH842E2BEse5b6XuGiZBK9xmNRJJRmLtecAieq3R1xrwt58nAm54Ir1W/gdJi5w1fWi/pdbejQe54QY6bTuzW5MoxUSdcmQg=;7:eMr11asIOpJU76qR5OM3V/yBGDSCFKzxSfV1mAlRhJbmh5UV+8RWQPaJJQbWgoVzuhTN0lF1v29QxX516Jh0tBGhjC/DjfQNWKXMPsFpfhfICNMzOXkbO3+1m89CdRSjYg02B6jtnR92VCVoBLZTgCGZ0CKUBC1QdVToHWfn1ORZRqHQHCs9Or0iqVNTYO1Y/z06tVzG0h7xQss9UYuCMEKw4oEDIGU/gjHPKo9eEhgTYcTw0Q2UI1nLtERIJW13
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:GYOTd91q5qXWz2F9H/elhPR5mhOiR/wpLy9yhcdVLV7MmF0LG7tTspgO8cGAoBnDZX2YTLPUnex7mq1Xw6VaItYEFDx04iBTGePpKHzcji5WTfbz+Q+6JqzTuMyqO6AAheJ+zR3eZiTG7o5fn19ywJwRz19vUmZkMoow4q5J0Bs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:52:59.4624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b421243f-7b2e-4232-dd76-08d5f40b51f5
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
 include/uapi/linux/bpf.h                          |  19 +-
 kernel/bpf/Makefile                               |   1 +
 kernel/bpf/cgroup.c                               |  58 +++-
 kernel/bpf/core.c                                 |  77 ++---
 kernel/bpf/helpers.c                              |  20 ++
 kernel/bpf/local_storage.c                        | 366 ++++++++++++++++++++++
 kernel/bpf/map_in_map.c                           |   3 +-
 kernel/bpf/syscall.c                              |  61 +++-
 kernel/bpf/verifier.c                             |  38 ++-
 net/bpf/test_run.c                                |  13 +-
 net/core/filter.c                                 |  23 +-
 samples/bpf/test_cgrp2_attach2.c                  |  21 +-
 tools/bpf/bpftool/map.c                           |   1 +
 tools/include/uapi/linux/bpf.h                    |   9 +-
 tools/testing/selftests/bpf/Makefile              |   4 +-
 tools/testing/selftests/bpf/bpf_helpers.h         |   2 +
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++
 tools/testing/selftests/bpf/test_verifier.c       | 123 +++++++-
 22 files changed, 975 insertions(+), 86 deletions(-)
 create mode 100644 kernel/bpf/local_storage.c
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

-- 
2.14.4

