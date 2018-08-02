Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8899C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FDA2159F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bB7A4Grg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CAAmf80t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FDA2159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbeHBXyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:54:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40920 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731763AbeHBXyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:54:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72Lvb20013646;
        Thu, 2 Aug 2018 15:01:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=T/SwXMROCJb3VZQ1uCPt22S+QO7mGODtaAkqDEmfJHI=;
 b=bB7A4GrgM1ip7PrPNWcxRCAEIO+1VuxIWWX7945z5eWFYmbOoGiQxBpqfowsw4Do3RXm
 DUewPf058dpuNA/Pg/8CBFMa7pxQjEg7b91y1pBKxDUZC+gB3bVbTCm9LUPmlw15WShB
 s/xO3/QwBghPd+q2mJY88tXr60B4tefwCOc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kma0v0243-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 15:01:40 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/SwXMROCJb3VZQ1uCPt22S+QO7mGODtaAkqDEmfJHI=;
 b=CAAmf80taefcZMEoCiNxFY/JeGQqRbR/coORc3Cdm22GJ4A6M0ZhI5qNE+zDZuTe/fMXxYDK0Z0rKSNVZ0Q1dYfLIOAIIO+ZUmcQYFM9d1Wtc/r5Q9LzSpqRFgf55wYy2nrDzLNkwpekabhnrY1kj6UrYLzWdc1HkGiF1jYNr7c=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:27:51 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v7 bpf-next 00/14] bpf: cgroup local storage
Date:   Thu, 2 Aug 2018 14:27:16 -0700
Message-ID: <20180802212730.18579-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5a4159-cff2-49ad-f548-08d5f8becdd9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:T/m40bxxrC2IRQhVAYvxL0XpWbXDg1uYpvxKxQoZWIfIwlclF7WRl3NjeCkuNWzdYIm2gUT3Xfm1Y7u0tvxYTCbDulPWl/zoLGSLLNZyg/h5FWDAqaG4DRHoYZE52hyvEr1U9i6psKfKDJK64d5u5pYA0Vg4WMBvHFz5+qTevSv7der2/1gGVEhs15h5XbTyX1lrfooA0tk5nhy++bSZ48LodVJbhA/thRfECJIZ/a0umvZ/a+iVXgH35FlaD3CD;25:KZ4RihRwpItwKcgaZYSqHi3C0oODldTeyrsGeBtxxaRtaz/gWGAo3sDJ+IrgH/dqyw0ahy7JGGZfMQVSRLunpWmcPt9WqbYZcdg7iuXBTXaAMVQ0Pf2Bdng6+mjom4tTS3abg21eRaSrLkHa7tzkXQIXPJcXnp6Og8wOqkMud1bE1gBPHqsXlk5f1sRrz4OdGmzTP+JobPUCBAylw0Q7JrF8ZSvJLK3snJYjwZ1lUum5Mz7RCHtgiH29aRA2Gzq5vC4IoXDfLKZcdItU/nme1PdijvtGirjUPB+5fY4tJkoEpRNaW+g1H5MrG0NBayUFMD6aDQH/8K3h+BZox2UILQ==;31:0yb1X6oW5ENKwpvBTZXje7zZ92j/Xixm+YOYi7MZKSIrpaRWyloAAdjIMZ1C1FSXaHJM6g9VKxfGm4DlbDC7O6B/BOilRNKCjDk4jzlD78jJ5gTg6umvKpwEbk0Oe5us08sKVamtjcgQqL1unZrkUVdgsCAP22F6kx1ogJDANqMvJ02Jn7pCXaUwzfmVmfdH3FNNe5qQs5AUy+xVRdMzSS7WibPH0XkldKp/ArcSE0g=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:HD7f0Q813VHD4D243hDLprvfC0MoZ+lPMgDx86aS0MFTf6QGv0LBd5d9repSv+YKFzj6+Y4iavJZTnd9gWge2L4PedmJcAi/EBjq3FNNLY774YhANRiAmAKawEBH/EpLpSV4Yf1lvZSvyYZv+IISzWO/CPaWD8mueQNk38NEqW7gGJqif2M1i0jFgAHwRCnarBHcr+Vq7bqIxKnpMBk2TXzMNCr17Vo50RK9vQJIpEOgHYx+RB/1cQ8q5iGORLuBfku1y8LTQkcN9S9B9ci5Tu1FKET/zqTr/ettA0uQO2hQQI9oYjKi/1jnvtYKzVPn5A7XQIep8RzOZrvc/TMx5W07fT0PI/7Cd+JJBvCn4oUdlm58hI29hpizTsNkp0ZQCBkBbm2w/uSx5lKyhGhjK6ST/57wd/co84r9+RnNszSAxsIEU4XNzXZYKX7KKKMKvu48rA2fDEYWuY0SmTwidBAW48NOodEcUyVa/Hpmj+G8UGviw1oFSq0yB6GzxyMH;4:Z1N6Ytns1p+3f9NPQUNT4ZaueRUwWdhc7KcoShJXUd1QxGuVzBWT22bJjYHdgLNXwrVlWzM6craZi5axW8RQTT0joO4ohaVWlJ+FZtRU6z+YCyUuqLuzZ4hlfPxj3mPDLws028BwJKIs3nKsNdRM+SWCdnXV+nUj7naGjuj97fNQ4rO7KgR8Ic4HeVxvhxmQpTxnbJyGfeVAmr4dPQmF0B6m3g1H7XKJ82Detj8cuMuWMlYdBtCEtexjBFZIfftFz61bUBROl02CVB2FrDu1hnxW4DfJzNA8w5q+K8iJJg5gp4uHNChv2x3RJ/79sBnn
X-Microsoft-Antispam-PRVS: <BY2PR15MB01672367B31CB0BCA6E2CA64BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:wB3uAaQ5Bn4i9jnHIOVhrUTEULUhkZlWnCDFwmKqv?=
 =?us-ascii?Q?GdXVrZmGnSRPSGmjbA9zimzcz9C2ukfYAt3RD+ws6kRNVin+c7bBOrvi1GWx?=
 =?us-ascii?Q?nxTsAUenmx9ZBoQeAWX1L/Hme0V3sK5HEcj2+xTirsp1GTZXO7wiuC8gD5LD?=
 =?us-ascii?Q?Q/LUQqmlqkebtlO4jPLOkJ4j326aUJb1IY9ZHu3TUlkxiQ0HQl/R7rCIAZgk?=
 =?us-ascii?Q?5TGhLjCTwMLUgqiLuf/J/BnSL88wM0QhlKoxz+Xt7+o+h9EDePyVQXuDX+jq?=
 =?us-ascii?Q?+7ZzJj5SF4RViSlX6CrwkapaAOUWOhbPp1Fu3G12yr7esrdC0y7aM1u1VDKp?=
 =?us-ascii?Q?IdvjYBmQpndNZCvkqnE0HjQJ6pRJ0lH4qZvqzaqcK9jIE2tHfZB5gJ4JEKlz?=
 =?us-ascii?Q?72d7XIBpFz2Khl5gbdSElvjoOw1DJyM4B++stnhSlHyy8SH8o0rtkdGRpOHZ?=
 =?us-ascii?Q?iqzcwCNgPoA8lwe4LNp8YWdkc7nuK2Q45+J0VYMXf5mow7axg7HWmCy+IHMO?=
 =?us-ascii?Q?Sk9voJ00byp6LIZJwOb8UiwPX3zhdlVZ63lT2wKSEz6GKBAiy9SPc9cXQXeS?=
 =?us-ascii?Q?BMte0CouuWaxTsLO18jeCyP0LVQsabmJusr4dW08hdmu/BZd8TSwAd7tIJeO?=
 =?us-ascii?Q?yvH968hRnwtol4rQLT/MFCNhxEI9okugXd1+2BcFVoAfAz10tLPGPhLMen7d?=
 =?us-ascii?Q?sW+/3LGlHAFF/HAeW4heezUwHaASEY/81ZclqmnhuwF94ts8eCgoK/VR7ZQu?=
 =?us-ascii?Q?MaM888+q3XX3za1EIOmaso31T5+/eQ3wa/DgazYNmac871e9J3Way8C0VN1E?=
 =?us-ascii?Q?ctgzSXaGx13IVYDX/beZwuDf7ae8qbuyEZ0TC9uDk5U4cc3MmFSp/BoURmbu?=
 =?us-ascii?Q?/PKFqC3hzYv7bSA0W2WH2/icaLFVs4lE22mEeWcSGwHoiGOLR/K0Q4b0+9eR?=
 =?us-ascii?Q?AKGzRjz3FAA5pCwQ7ydG6vRuwOzPtOAAR15ZX9YtrNGFuH4Vf0ZZmzZR6lNl?=
 =?us-ascii?Q?GORujyM32tg4CKhjZ9/Gbd195hQWqGQyKNdyDCWsk73lLORCwQlm2+GVnRcT?=
 =?us-ascii?Q?I2P3c82DN8VfJwytKonyW5aYkR8186pK+olnb+SmG/NLD309/T6vBZv2wIgN?=
 =?us-ascii?Q?rft/qZCyA8wXaQBZZXSVIffedhUMfStb0Q/iGteKxAHfuTuO/wkU9/qHG5S0?=
 =?us-ascii?Q?OKLMN/3wqSSJB68EvQGfO/BgmXAXj9Z3OrLgVHZALDfnFlvy1KP/t5cwwtbV?=
 =?us-ascii?Q?1sYNuyp/r1umS7XmVc=3D?=
X-Microsoft-Antispam-Message-Info: RNNFkPNyyCrYYM6Eej2WNp0eiCbx4XfSHA9S5rPZ80uOTKw9vWF52EGNfNWbEqfCWxf5KtNJzt8KWazJWtn43ag7qm/kxxRzGOBpW8D+j30yMi3nf4AvnXdgDJaBWJzkh/isun+vvQ9B8koEzYn7Zh3VdmYZri7fzLicojMIeAwmVXQFjCsI3XCgNwES+8R8hMtx5tLUb0777/HLxGnizmCG4tIi3GzxtG6WrqZMFIPIE5RQM+PdubopdfxJaaBltqE75a3hFYnY2wTSljkZomC70WB8G/d92V/7qIzQC7PKPS/h1ypl/H2bwuOLT5oEZVmvN8I0I2kmBETwKoOTuMOQrWHxt9WJcJ6e9bcFj6M=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:UYbnwfgIUIdF8U969o4QtxPO/T1YnZaT+Rd4rk8mQ4tlZ6d0MeGIk8ChfXpL52CDFgdzdIhRIBWEuezWvBG2PusEQw1VHP6swDO4aBsJId0NqscPDnj2/Zoroz3DzE4ItYyEt10olvB66dkxpvm0gMpXo81xHH2XJqSouhqkgfL/mCKu71kRFlyhlpIbd3Q2CX5PKgH/24XwikJOR/0L694u3UmDHP9HxebvjPi+6zMgC9YmuVfm5lyVFN1W+7zf0hdc25x8f1LI4np246AVbaOboxApkjAw5i6rag1JWEQbZGfD/98SFE6HacF3boa9b/kZkycn8VhMRJBc1wdcrop6nwPpfIYuUsODdbE3JIIPUZn59Tw7xnlCsEX7fEP0FN7CBHwDcok2NlcuMMXPI0tOtaUUFS9/PWjXHkmDmETAc8cURG9M0zG3YWuw7isLmqEAMu36MQ6pcba1AhCPKA==;5:ZrD0/XctPUllz0wToN8uZQYOAQtb5hw6haFzOnPi+kgNvUb3GBBqJzlQJC4XrOlSTMJqqkhjmzXODkvUrQMhPyCvIHS7wfHKLqGmm1zf+ckOE/jykoA2E+U2HsXwj93jWgZSNLygcEwRDT23IZ35LhYqA1WVdM0rMazK23DHbtY=;7:KJgP1tyHS8znAO4q+AhJUgPyjaTWxOwF+9rY+zq4v6w8DaoP7reKfapc8vXextqvhpos096fTqXqLwBtvla9wYSBFzMPsOYjJ8CtIpmU2PsvOkIq76VhvWqrfRdzPKEKU7unJr2qhlhMtaLfJptXx9Jrwux5EjYlCB3xclvvcq8ZF+7EaQG1U8FwSZJX06olhhOzgZMqgFWJwDvqw3fK2Leukz8M0FLYTAtTAvxeVcmnyGnRUFnm6uRsLhwg07qG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:hv2hWqe5mL+58diUnc3wgL6H23uBDRUSaJ1xpNY/siK4L7RwFjMslApuwj/Ty7q7GJ38KEnPVb/Pl+lMgFguOH9PUXyM32w9w7zc3MnMh1zgpxWHiL6RyyiLsjpZ+km0NYinwyjSD1rR7OYa1IHpaXkv//C6WmFOSITeiI+kc68=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:27:51.6814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5a4159-cff2-49ad-f548-08d5f8becdd9
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

v7->v6:
  - fixed a use-after-free bug, caused by not clearing
    prog->aux->cgroup_storage pointer after releasing the map

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

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>

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
 kernel/bpf/local_storage.c                        | 378 ++++++++++++++++++++++
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
 22 files changed, 1029 insertions(+), 86 deletions(-)
 create mode 100644 kernel/bpf/local_storage.c
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

-- 
2.14.4

