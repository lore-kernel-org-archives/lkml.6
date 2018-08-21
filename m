Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F80217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CinW7ykV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="h1hWlbQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F80217BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeHVBhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:37:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbeHVBhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:37:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w7LMDGCY023627;
        Tue, 21 Aug 2018 15:15:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=xCVy/Bi2kWPm7FmW69Y6qBUIatTV6vtx3Y23Wd63/lE=;
 b=CinW7ykVrqTWUKemCpuRdNLBOlbdsj7xYteIniZsRvGx8KFIeYtDO8bBwdluXKLAmrZS
 IsYQZfV+xHQFGq/ybSJfsP0v0bZa7gg+LLce9QnZ67ODQdEPHe9MHMG9qE4B57g43bbg
 dajsZ6LNgL6xT/edrWyaYIFR5ItxxDQdpxE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2m0gj7hy8a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 15:15:41 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 18:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCVy/Bi2kWPm7FmW69Y6qBUIatTV6vtx3Y23Wd63/lE=;
 b=h1hWlbQkA+K8xJKp6Y9CH0HkfG4FFqvUEEi7meiTm4A9IQYMkOewFo4hNKWLeZrD4RnPTmeWM71j0QuGglgy3jfGopTXsINmgmKnxnBZS6L6zmcD+jVjJrrHUkwQUKViY814wAAoGxmRury2a3am7iXBvauvEzQBYLalmspD/dY=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::7:b0bf) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Tue, 21 Aug
 2018 22:15:37 +0000
Date:   Tue, 21 Aug 2018 15:15:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180821221529.GA18627@tower.DHCP.thefacebook.com>
References: <20180821213559.14694-1-guro@fb.com>
 <CALvZod4HAf+iPXQx1v+dwJkTph3ySAiYo4kn4d2jRFNQS59Tgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4HAf+iPXQx1v+dwJkTph3ySAiYo4kn4d2jRFNQS59Tgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::7:b0bf]
X-ClientProxiedBy: MWHPR2201CA0008.namprd22.prod.outlook.com
 (2603:10b6:301:28::21) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d83c17d3-e631-4a47-b900-08d607b39f7f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:oIGqyoAbczAgFT/lvnuHUhPUyFtNoVfgljOvkBhP7TnvjwLgeGcFI4YYf7TXPxi7AzmVmUNzEyENKFdMIRhNDuaUgmK7e+MyUbzsaGc+jq7nFsmFvvjthreqim/Mh694BC2Yv7xkVIiRKqylqQgzXSyCwUItYUmVWMQuS+o0+VWQ1NY/amC75A49F9iA5iYdZhi5tGk4FOX8f0bXtqq7ZNaBq9vpgzgG1c/wiAYlcpiZL4+8OtMtOUEDR2LzfSp7;25:k0h+OFEHs7HaMYcL8v/FcG7WIH4so3VCue/2LMpiyrS9M/TZdw41OU1eO/1NgmdmGknBcklo+eL+k5dX3YBEhSeJu5RNteq+Jv/3NAkc/SgveDEq4b1PW71KLT9gh2esilSPNdjk8uFlQDNql0aBVPzhc9rQrUs38uCNelN+hPkv6mCKVOTbfxaW9ewkxIQYz6vZYIP0hqiDlpDbDACXqOK5eVn63s3GUmnhklWO70Nk2ZgXv4EEERQxUjT4HheoL69yty9aPQ7bbgSRzKzc6yPQNsE5maaswT156EcxyAEo7OLkwio6sARdddQE+dfvAtKgCeXxNFVxlVdO98RcJXwlkO+r3PO53RSrEWl2j/c=;31:+t7n0qQ7V1NetbAWx+qlLQUD0LkZjjzby5qfVxBKZ3k9nkW53xWml0OsNeU1GTRrhyTotpIB99Zxg4Jcjv2+xIsd/YnaU2qiC/Ll2+jYG6bVkXpn2vYUfUl3PmHeqAGnAfGkNRvubhFJb1ggliMfJeyMVJMPAiy70WuS7DQ2k0H1mFiZYZ9ostgYjcjGxG4rexllfjeVeSl5BVPqLZBKM8okq17NKDexgwPdLlfT9l0=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:ESIM9qNrmrfkZoJNeB2g0y5Env9/3/ELZnsNoX6TGDLHtIGq603Y5eXePD+ClErAk1CfPxZTPgYOWtodp2VSokG01vXbSyA5lRy3onZiCq6LOYWWxvXp12p4RcWwLDVag6ofA/7rIKuvXxvs83tfAfNJJfmc0Ge4xw+t0H5wu9Z/+6yZi0vBEBVYAX3Xz/7JQ689tlNPHBvAVvEf4bflYg9j7FwCiBtOwIzf6snCbsDlc0+BENNwUQZL0dgMSZ/FpjdLNs2xH45W7QMfKHJfn+t4LkqGZD3wKT5dz/mB3JqDhtPDiBlbBaBsdf34Sckzo7aoWSZ31g4MVYRJ2xln+GesU6qXckeMUlquSNowxUSlmJ8NCWXTr1pWFF6yc7xWhJ3lFSF7+PRHylW42+mkMWOBGkNQk3izqUjBT5rg+iaqLwOPXeZpHw3NwRzXkR9FulIxHRe+rlFuu2WRXY9qYAcjoONUwptJOAYIVuM8NGMWeB52DDnOpWVn42qj5ikw;4:JRD0tj0T0Q5ykJyR0ZxSKdihS8vNnLnRmgG8GQ4JkBYK8kSFhdxv50YNeLGmQs/5q7cLQC6SKFfR/cRCCqiApJ4yzFfZKugR24aEHt0ZLVvrax3TiNkaETpnCagz7Fiz9MhOzEG/4qW5tInpJ13a+qEOgZRoF3DdWGXC/T/CbDpvM3a4C9FnI9h0ubZcIsorFQWPyOGwG8wtPPsgTF/Wezy+DNabsvmyVmFag5dS78NqFcCfxtdNbQo/J4l8YlhzvmNq3lddVPCJBprbHEcQNutA4HveR88RmU4HJhBxX68MyiMxZT0AHM/wmRZh2j/41TRDVM/eQu6CNMTk+cea2c8Wsbah2T/nbXZxaUkuUKEC78O1/x9EIVJtXlbW517U
X-Microsoft-Antispam-PRVS: <CY1PR15MB0170207F8398B3941C08B72CBE310@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(16586007)(11346002)(476003)(486006)(446003)(47776003)(54906003)(478600001)(46003)(76176011)(14444005)(52116002)(186003)(316002)(7696005)(86362001)(6116002)(53936002)(68736007)(9686003)(16526019)(52396003)(15650500001)(58126008)(81156014)(386003)(5660300001)(53546011)(229853002)(6506007)(81166006)(6916009)(97736004)(25786009)(1076002)(305945005)(23726003)(6666003)(50466002)(2906002)(105586002)(4326008)(7736002)(33656002)(8936002)(55016002)(106356001)(8676002)(6246003)(39060400002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:WL0I1ZF3g6lwayKU3wOL/CXzJK6T6GHaAxkamOPG+?=
 =?us-ascii?Q?oQ1eMJLmJ82/Ii2Rn7yTAPA+e8RfPOJ3uAms0rRFeLk5ZRfXTREonRiqDdhp?=
 =?us-ascii?Q?X3WY4OhZFYPC/D9uUwZwPf4r5KZ7LtrEmpNKvsQut0E7Xi7/Ez9zJhSLko2K?=
 =?us-ascii?Q?xgol1/aZ4B+rSOIVYuR5Dkvj+2YgyNjhetD9/NJJiR/XqgPJt6wsJVvzSnAi?=
 =?us-ascii?Q?w/OQrDawz4T9nDN8aG96gned8Rs+vohKcSEvJ9PYNElx29M/gLiwB/sXsW3L?=
 =?us-ascii?Q?j+ql26Ey5QzfVbODhHY5erzfyyifGkhU0/tt0Bg7PKYCSThkrMjEuRTeSVyb?=
 =?us-ascii?Q?FMGk94qcUhmqx3uMSa+NhnrKsdBlfxqTKVB/lRmxupFs0KBYniwybPlEEcSW?=
 =?us-ascii?Q?yRx1jTvYgV+LA8t0kVZFcljS7RuUPxvzLxpRmibDSWb+xBA4KxBwEkQ6s2vr?=
 =?us-ascii?Q?WN03YaLFHpOuYnXiVRL05OhnRdBzrG1+Re+95Mz2ZxtrEg5sJYQ1MK2Sfr3+?=
 =?us-ascii?Q?VyylRdk1laB8xgP5AZ36R4fEquwsjTW4CXEW8OpeUzJuRZWQebh/hrFlA1vg?=
 =?us-ascii?Q?DP+EK1GNz3ILwE22LznC39odH4YWYysxNEe7ArcKV+Roq0nYEGLaJuBdtNgi?=
 =?us-ascii?Q?ku7NgehePVshlaqRemTfDiL4yCfOO/mp9xMmywSbrm2ZIo3BPK0BcbMEyziP?=
 =?us-ascii?Q?gj5F1wQGB20YtLEUnEH+UOWXxQTda1RzV3JPxMdCSfzrBFRkRFk61dvLSLgd?=
 =?us-ascii?Q?XAS2yihmE7/Zb1QvckcwHEENmnyy+7LSvBMxhXaD3E2+k0JvY3zVjK88ETtg?=
 =?us-ascii?Q?c5mQAvvNQowOlvlXMSTCZ+Xx3RJ3dxlAIo7O6hR5Sa4Q3kME711aoNzWtPNT?=
 =?us-ascii?Q?uUpdkg9QsYXdT3tu83aO//jBfesJoVeLcjTT7HACTdQZd0ouNnq7U3axEyQM?=
 =?us-ascii?Q?drgBEH57Xu4gvs8QyaCQVcuGdGKssTsQHpwNOCtwIRsGxjLiNOCjyXW+dYiD?=
 =?us-ascii?Q?fM+r+vgzBt4phq0V1ic/z02GPV3OwQFgM9PBNjKSTeXtMyYfbJnhpMHZuIKx?=
 =?us-ascii?Q?XKryD1fMRocLad65kBlnccNAN6k5YMI4HbL/Hu21nZDHTB86oDwdsNb7Xb6P?=
 =?us-ascii?Q?mvNp8HhXocWkMqDLiOUtPXoO6GBIWOH+tqg3x1OgB6bDpyw3m8AWhjmDIA0F?=
 =?us-ascii?Q?lQHHEFBV1x/60SzqrP/MmeT6Tmmn87C0LM1OH3fPxrgmKXL8CAdUCHJOAm2S?=
 =?us-ascii?Q?twYAcK6KnroSSL00CZ5Q081rK23NMRhPSSfjHutCQdx9F229L3F1bHCt10Aq?=
 =?us-ascii?Q?5cHQSlt8jUAsM499IR47bCAMZ7ZRm4BJFlHE84WAtpI?=
X-Microsoft-Antispam-Message-Info: pC2YFONvHwjt0tlCFwd0VOsd8+ItR0sjluiykkjd22Z4xm88y/ClUc4Ipqs9Vv6rQ/7/MUfS9zRQb9/yFKtIFOF1xOtKWQFxHebA2KPfSzn6MRt+8BJ5pTc0H4lkXIsnH5+joToPNkzgWzzzB09iUpKVqHDDKVj8qiCTz8949ax2wMTNfMdBVFNs9Vz2EdkQKmtF59TM6EqxqzjAIetSZHXYdlEeJCt/deND3ywjUN9Glwl1WFvtaqjHauRlVuI7p8tHhynu5Hw61gT+ZmOM55OVD2A2zPepJ/ThIGeFIhAGLbUvCpc9gAFQCBCXR1PCVtJZESa3kcvXY5/LCp9olJKdfofyquZREB/QXJcq6t8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:bR6ze2T71b7d8FCMT0gNVrJzQ1eogs1REO3RSoMQ859SP3yCyuqF52Efz9BHHvg5eezXnGJlribVDLR9XMSwUF1JgyBFsNCZ12gO8l9y9QdB2o63ajUpqKmAMjPWIOXxWHqxb5cvy7c2JaZaqwrgWLUdyJtOIrNHpGcAGrjl6tR58FdXf9alI14GhhLqSIhVduW7wyfgtmrJrgWjxWyyBAM1M9/NgboOTl1BLbA62jaDPrCGYTUsM+Hwfb24tWQf/MtswMQQFl2L6AprS7LViK0K0Zzf/r7NlkMYXwiqwgNZxcw5Y7FeMhHuhPh5uZ4wmkY44+vItmLnTfliWmxgL/izBbkDSMHzz589mG4euQAimd7nk4QzheYIu1urJ3jRiGQRdbVW/LZGAB6r9h/5snWBWNPCpHqzv/TCzsSy2q23d4d/aigfiyVtOHvitzkg2attRjrh2G545F2jaRtUdg==;5:ZjtsxgMXlTjqcjiIe+l1PRC6tyPJKBIL3kbdJwY+DeCRKmZFl1mitv5LToBngnP67CjfLxfvKCWMSf6i13kuu9uZrVHFb//R5f9NcLYmorkEJbleFxwUHxlwfqrwmUNRj4Hs7ZzVyi7kRffngKEh6+ZKQYyjO+3t+YalpDZ7W+M=;7:V5mjpnXBsHtiYZfVH7XPXIUfzzwn7/RNVgrEGStLhdOqkwWlSkAsSn05rbpvUsL9ZAwbt8wWI0stHYkiQb6M9XJpkhj+8Nda+5Mc7gfg//VSHNpe+obSOyAro/rVHUhSLpNK1AgrRfGhVKGF0HQexK80z30gvprLSiPDSGpcJMCxQN3UpFsb4oE5J1HtYCPwCGXwOFimlyuIhGkhSoITl+w9VQLv0l8yrgu4V9BTYD6e/VYKJitaubtqYQQ9v3VI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:DG1DwIbM9tRyA2N4p/d8fYTWACId1P2OY2ztLKbrJNh6sHSzj0YKrtwgGA/sr6KQt4+EH6HJfl/4pHaaMmKZ8HjGVayQhBW7PjJa6/09uKjdXrqO4yCj7stuYFGzal6QD/okz38oKkF37NeAhJgWz5GX5vnkSIAu6aVHD4LZx9Y=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 22:15:37.0054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c17d3-e631-4a47-b900-08d607b39f7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 03:10:52PM -0700, Shakeel Butt wrote:
> On Tue, Aug 21, 2018 at 2:36 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > If CONFIG_VMAP_STACK is set, kernel stacks are allocated
> > using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
> > stack pages are charged against corresponding memory cgroups
> > on allocation and uncharged on releasing them.
> >
> > The problem is that we do cache kernel stacks in small
> > per-cpu caches and do reuse them for new tasks, which can
> > belong to different memory cgroups.
> >
> > Each stack page still holds a reference to the original cgroup,
> > so the cgroup can't be released until the vmap area is released.
> >
> > To make this happen we need more than two subsequent exits
> > without forks in between on the current cpu, which makes it
> > very unlikely to happen. As a result, I saw a significant number
> > of dying cgroups (in theory, up to 2 * number_of_cpu +
> > number_of_tasks), which can't be released even by significant
> > memory pressure.
> >
> > As a cgroup structure can take a significant amount of memory
> > (first of all, per-cpu data like memcg statistics), it leads
> > to a noticeable waste of memory.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks!

> 
> BTW this makes a very good use-case for optimizing kmem uncharging
> similar to what you did for skmem uncharging.

Good point!
Let me prepare the patch.
