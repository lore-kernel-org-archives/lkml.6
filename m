Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA77AECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7FF2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Mw1dqC6D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T5oOVQ7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7FF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbeGLWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:38:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733177AbeGLWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:38:29 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CMNNZd012203;
        Thu, 12 Jul 2018 15:26:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=8DizPeMm5PGn9FEIODUIJ4MO0QKSBtlYfNyYZwXWBLo=;
 b=Mw1dqC6DjBMBj5z8R6bT9uI5uzhTwk0ZbSKQCRCUX0WK8zZFsb/S/9yDOBVsmFFCX1nq
 VOQSknkaYCGVheeaCZrL67CHUqz4/6aQ8ZTknNRsi7ajPOx/OFUX88hb2oAtbPqK/l4v
 837+sUp/QFmgkoJzMP160pcqZI/hsGVLYA8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k6cdp8k1a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Jul 2018 15:26:30 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 12 Jul 2018 18:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DizPeMm5PGn9FEIODUIJ4MO0QKSBtlYfNyYZwXWBLo=;
 b=T5oOVQ7ytYQsviyEoRzaqk+LiYp2lwls9lI94nCVEuN3OIDZJyTJQzSaNAwvztu0AUqnQJyCIQ7WbNoM2IWZtAHppcnluVK+WMRz+S9q+lDJTLyfKLMDCr/EhjEt7bjvFKZBeCOTbd3iJmx9M9QICN5t29KZHsdqfE7B6xwI/J8=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::4:ee9e) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 22:26:22 +0000
Date:   Thu, 12 Jul 2018 15:26:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: fix some bad __rcu annotations in bpf/core.c
Message-ID: <20180712222613.GA9426@castle.DHCP.thefacebook.com>
References: <20180710015915.26358-1-guro@fb.com>
 <31c2b14a-8890-0ebd-bb59-01616e9d8d5d@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31c2b14a-8890-0ebd-bb59-01616e9d8d5d@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::4:ee9e]
X-ClientProxiedBy: MWHPR19CA0050.namprd19.prod.outlook.com
 (2603:10b6:300:94::12) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 264e6aa7-5a80-4445-d80b-08d5e8467f83
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:GBKHES7fvefESh8NVz7LPKIBW1RfHBW0W8NZ50t9AUICn7F+iJIXE34Y+1MWePgbp/PxXlnTa4kDI9nizdxqmDxcbko8iorjQhsVDablrg4n1Jhe1qssl7BLAvGECX3B7wEqb6d6Sff18+XDH4WQjCF28dokrU0tKJzSSnTpsLXhTJ+nad2Md4pdOyy09IaXtVXYThGvkKj6fg5E+G1IcL9GXCG3IZgGRSiuhc3vgqYYQU4gBlIAnh+/iyzCAjLh;25:o3V6QVSPXQ/+5Aqxb7uCikh2x8pm374nzvE4hdWnry2hIRQ6ZjWmx/ZFdzLI2bd3wNqWZZJLmL4ptlJvMJPZcXKSzqGOsp7uF2yZLz0LvUIWaV8YxdDj41xEtg79xq5DDT0vw/T96tQ5eiX7x8VjR8YbzATBToMQiuYnKja3yIId77OPWtPV/T/lVOUyMF3LjE5pCSylAxE+NBc5Mlg3yZVAMkn8hq1mUCvAM2RpbJWlLUQRnWyjsyX0Z1t00yTkN0bI/0Aj4/iHui7eJt4OlXf4GEWNkdhIQajv3+3mJ2tbR7nLT1AfiocpnAhcdqJdjnzbZIAC4qzpEnqM60VFjQ==;31:YlSC0F0nCu2zb6QyMlyL3FEONq2oxK1CFVt0qrUj/kjwTlVBCbq9uEWqqYAvAedJ52NKg9Vr6SSdipaNEfdbLkGSau+iszW+jKPyYFCk6ykujTlefib26TKDzk4JRVddcKj+vs81MGdgnnvodWesH7NM/SSl6XHn0KpWlZ8cnLcocPDzSKMkFJ2TWseer+OJlMw3lq2qBnqTXEfDE1qdCaun44+SuXO5Rb5YJXnXqrM=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:YOXwo9Nv0M40J4+Re8M0uXgMZiO6L8oqZem2JPO3ETQion/QmjhZ2gUO/26W06nVhFr+ORUEeV1QJ9qR6fi8nvvxXC94vEoTmPJoj+arEPXnW3hlO4uqzEY1Kwc9bq+jD2TOFxV/6O7n+hg3aqTJeRFi3gQFhe6iJMvcga/MugQVWT8n1VheJzlLW4WqzYBbwa0j0jsTa9NSwYFokFrjZ7n7RUczVRn85hOJstxWdbI1zUoeVNh7pyTFQsDz6QoUB2jSGJIjFcLixsSWO6V69vFNXbEULomaktpfRWsXqFeri543jgQWcTUvm+4HN8WpPybpXZhZSpxqld1gCYb/7YdNhOmPVORFSw85GjeTTtX4DkYJEkEfxhEFgLNqm0DI/P15dK0dgSHnwS1RBL39gaF3s6k+hq8cbVr7C9FgJVhT/XzW/IF9BDf51bKN1RQuqmmDBKFfkVfIY9tGz/v6hOHptyeO3jSH/tIkNBC1T6X4qVuN1PxTC2QEDm17SZlX;4:py+usyjdrkW7MA3Zs/BuW0KFhsdwxU3IuEJTRb7Z+iUmqVOrHnnaK4/VxoyUudb/HvCPe/mHWi8SOacQPTIOuPEcI5ZVia7piP2E8p+FRTCey5SnVVHMpE4jJwtbAKqKtxo1zNynngWmLXi+3sVlus+Dhm0sENEt4+iilsLweyxJ2Ks9sBxwH29N7U18Gl/bEPcrvKVPdCVd9KV759MHTtm3f+1tBFDFUGMLRDfbJVPJxugM1XNH6dOcUSquVbdHHvJnwUZ6PMT7hodMHmaZ25st8UIDOr5IHjjMZKYyR+dHlzDe2pZwIqtLS+qpfeHl
X-Microsoft-Antispam-PRVS: <BY2PR15MB01671DB762330AA3EE22D022BE590@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(305945005)(6246003)(11346002)(7736002)(5024004)(476003)(14444005)(16586007)(446003)(25786009)(53936002)(6666003)(8936002)(81156014)(81166006)(8676002)(50466002)(6916009)(46003)(5660300001)(4326008)(316002)(486006)(47776003)(55016002)(6116002)(186003)(23726003)(52116002)(7696005)(68736007)(9686003)(6506007)(386003)(58126008)(229853002)(16526019)(575784001)(52396003)(86362001)(1076002)(105586002)(106356001)(2906002)(478600001)(97736004)(76176011)(33656002)(53546011)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:pOdVNFOSnXet08xhTMhERcjDr9Up/nhN+gOJHgnDg?=
 =?us-ascii?Q?eLEqQIeAWwP9P+eTkw78ZqWkmyC+zV7llyf6YCrXBvqLCpmzr+0FLgPm9pIi?=
 =?us-ascii?Q?mM0xZppvHgZzt1lWbp5SHkXbBRJWvLBBZlj+9Dpl1Qc25J44YZTE92h/VR9L?=
 =?us-ascii?Q?nzprDyNtDUL/nWlhBoH+SKgfBY4pDfkKpYGq75MKq1XEYXJD6kHIPEdKyN7n?=
 =?us-ascii?Q?VAE760FJE7ggb1ziUWZFVWz9znawM7T8ttDeV/fuS7kDHDtFfQsOEM2Fwm/3?=
 =?us-ascii?Q?/sK3bYMY5288Spb9vo+brDIWxSc2JvWn3XFrUDNo+IbhQQzyQlMveOHrEXYr?=
 =?us-ascii?Q?13tO6h8kGUgdf+2DVwha/VEx+3hNU23+JjdwWkX2BAlv7OLFR0fZMZMfj3rm?=
 =?us-ascii?Q?m6E+iiucOtezX9DwRvZI+wFy8VHHrC4E8EdMhLOiDBZToCRUi3s509ZZOCdN?=
 =?us-ascii?Q?9KJTEG2gu0W8J0hQc6QmjaP1hjP/iJfJ/Np1px5pLdzl78d4DDjv+09DYu2g?=
 =?us-ascii?Q?pzVPj8syC4FK6osXvXMotZjx50CQ3A5uT5rns/q3ZyzlRrCoZ/Y6OeHYC6Sn?=
 =?us-ascii?Q?c21HrCGKuozS8FulZd9nqBG6t3BKfLoUy0rfNOiP+3bSEZ5YjxyBe8HfG20e?=
 =?us-ascii?Q?xxmdwVg7yRl6ZntTxp2w9hnyPlfwOpMTaFkE8LUdBHgQHtetwm3m4+K/XNVl?=
 =?us-ascii?Q?rOzpKkzVm5zCns7OWuKfRkpC69ICn2ixDPOD1j33YQ50bW+GAXLehcSDahrX?=
 =?us-ascii?Q?GwFgQvBj8ATvRm2CqOtMofePcmrj/WUaQQc0M779BeGQZWB1SrLrxNfLJ7B8?=
 =?us-ascii?Q?dABx6NDEwePABDq4N4l0DNgbOTZjUr+6ks8M1Ckf5DYrgFEDCw6qdVDDfkCS?=
 =?us-ascii?Q?ZSg5TIctJi9TShAeGrynui7mk8ap+Dg3rStXemwVIrlLONs6TxzhUSlJSwDW?=
 =?us-ascii?Q?4yyADOEIEfyXGcUwy6SFTgOnVSWdTZrSABSY5J6Ud9lTF/hiWgclxqxP3mqv?=
 =?us-ascii?Q?mjWKbCU7XGCeKZvtjdOPochn3nv4TFXk0VMKVWypfAqmTW0HbWsDAsA4Dj1n?=
 =?us-ascii?Q?iqQ3qe9MbQ1zqqfJ0vCrUeNrpauhUq6y43TbnqTRVX5etowd2uxFBG6Jnado?=
 =?us-ascii?Q?HoUjuvYs9uoFLaX8C9CR9kWrwBiwwilj5YbZ2LxbK6yOyGsfKi4fsqU4tfWP?=
 =?us-ascii?Q?FWcFIH4I0d5AYHiPxgrHQuKwScjkCuUtZkjzBm46G4wGCH6Z2/5uLTO4Y47w?=
 =?us-ascii?Q?J+zrm2vbS5FIfirE1trP0Hxqc+vbpJBVpQh6vSbopu0cMIIKW7N5Sv65yyyG?=
 =?us-ascii?Q?m1CABePAnkmAV3IIuRpso8=3D?=
X-Microsoft-Antispam-Message-Info: fW2YZDo+LNgaLvQy0ib7Fxi3ZN6/PuCQ3W0cLF0d0YcyieS0rKp23M7vx9LkDaiCcZfBpEnVMuzWMU8AYGxP1ZpBTAb4GVuXsBv/1G0eFEGH7upPu2yqIkxoAKYfJ9/os6vk4xt/ruVPXa8RyDn24sctFYDspLQ63YHbVPGzyLUGZCpDwLEo/KrvySh4ZphpwyOYJdn8X+ifhNxNUZhZi0fEWZ4+BoiMMZzS58ZD8KCZLH5y7GRFQe9oz190HXXVerYYYq/qGZMNsf6V3BqoRAad2MhJ4+lvSwANEtyP8hIL6nCeiWcn4tc15HDiPYRqHVcmJxEydSL5CZ8torG3MNKUObepbXz4rdMAf125DfU=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:Am+IvtEDP8oMdKrKTfvkPjoVAfBHKLnfiC5sQAwh2FIADDD0kl13BqPa062s7nTMs6DA4yO7ukqYmhQr+VpVwZT4Xb240l5SgkX5wtPQnM3pSYjU3WIYF9Qhn+lByo5923U67dn+WdqMPCNJwx72Ax6QtD3ULyGzRjUKU9s3FqEk5s7c66Kax8GgPXzhbUTTncpN7teqnfUK3oUVj2Wi1iLVnnL6paOprHpeNsbs+SMXLBkjUW56FV2FNPCZwKvLBnuPkJ8mk9lxkwlQJjZeKxnXULVwZMBiW1u5guLOy5iqcoO9rfTXhrMHQM7ay6K7TAsKCT57IUlgujeaVc0kEN4yn1JY4TLJQeqQBw3n3+wmgacx13ThF9fdw3KqPbW0gSh1fepOYCUEjGxIZF3TMTgMHEMBG/RwpelN1ILJkCFIlwV7O3B7yFqUsohFCcZ2kzisxXKMAiYG6yzaRLYgxg==;5:yPnppfIOXZ9UfpzYRzbkBYGgR+UTHEIodUg1sFeYQMgQ6Dl5oPmk7mqVjkorgYVC9FOw4rL51hIpYVXeQRv53G6n3gXila1DM5XAjTtcPVs2o52733njLWvnqMK0Jt4ka+tIQEycuY9riMuMSTNIlqaUEaN6wXy+oJncl//eeXU=;24:jN3N+flQl1aw+AduY90ekiDik011qK9B1DH+1Os1p8KbB5UpVfpO0I6J4PmZg/bqA0RsfqhPe7FfXsjUPEHCMyIzmlPAyzSHn65G+P1E4Xg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:dRSZmqEnGQA940FSS/NbKs+J6e4opktEN7VhcDPLan+CcNFDit2tICnbHjbAzgi7H8x+0dB0mHt9FPzkGnIbJluokFvUNb9uhlLg24jHaIP2TNeeQNSzC1C/34rFPE0y5aguDfdbpX5CZ0I4Cs9sTPniMDrvPf1SJwVa9mdxdBn6/BTkF9kTRc59sv7ogkPc4abe/3swGo4ak54xCa7IhIdszHFx5H+LTKaaL3TmLv9P12O/v6Qt0Dd1PeGB7QFE;20:k1rdZi4TVzzg9h61lb4ltd4/fu3Z2zr21VNMxQTL/TGKEyQuHEEcYD2+GyX1aaGe9bgUi2Zp2oOtMlEYH8RsyjkB6JOzdHXCfT0piN3ZGsUA3WMm+JdaKTy8rHZY/OtbJYD+KYwER6205aSaGTQrJLgPjxv9VkrjWrFdzsI5Dno=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 22:26:22.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264e6aa7-5a80-4445-d80b-08d5e8467f83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:03:19AM +0200, Daniel Borkmann wrote:
> Hi Roman,
> 
> On 07/10/2018 03:59 AM, Roman Gushchin wrote:
> > Sparse shows some "incorrect type" warnings in the bpf core code.
> 
> Thanks for taking a stab at these! It would really help if you could
> split the patch into a small series and fix each individual case that
> is problematic here.
> 
> Please also add Fixes tags to the patches.

Sure.

The only problem which I have with these sparse warnings,
is that my cgroup local storage patchset touches some of
these lines, and I'm receiving automatic complains.

> 
> More below.
> 
> > They are caused by bad __rcu annotations:
> > 1) bpf_prog_array_alloc() returns an __rcu pointer, which isn't true.
> >    At that moment it's obviously an exclusive "owning" pointer,
> >    which is valid for an infinite amount of time, so __rcu is
> >    meaningless.
> > 2) The progs local variable in compute_effective_progs should be
> >    marked as __bpf too, it's a local variable, not shared with anyone
> 
> Typo: __bpf ?

Yep, fixed.

> 
> >    else at all. The real __rcu variable is array pointer, which should
> >    be assigned with rcu_assign_pointer.
> > 3) __rcu progs argument of bpf_prog_array_free() should be casted
> >    to a simple pointer before calling kfree_rcu().
> > 4) There is a missing rcu_dereference() annotation in
> >    bpf_prog_array_copy_to_user().
> > 5) old_array __rcu pointer in bpf_prog_array_copy() is used as
> >    a "normal" non-__rcu pointer.
> > 
> > These changes remove the following sparse warnings:
> > kernel/bpf/core.c:1544:31: warning: incorrect type in return expression (different address spaces)
> > kernel/bpf/core.c:1544:31:    expected struct bpf_prog_array [noderef] <asn:4>*
> > kernel/bpf/core.c:1544:31:    got void *
> > kernel/bpf/core.c:1548:17: warning: incorrect type in return expression (different address spaces)
> > kernel/bpf/core.c:1548:17:    expected struct bpf_prog_array [noderef] <asn:4>*
> > kernel/bpf/core.c:1548:17:    got struct bpf_prog_array *<noident>
> > kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
> > kernel/bpf/core.c:1556:9:    expected struct callback_head *head
> > kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>
> > kernel/bpf/core.c:1629:34: warning: incorrect type in initializer (different address spaces)
> > kernel/bpf/core.c:1629:34:    expected struct bpf_prog **prog
> > kernel/bpf/core.c:1629:34:    got struct bpf_prog *[noderef] <asn:4>*<noident>
> > kernel/bpf/core.c:1653:31: warning: incorrect type in assignment (different address spaces)
> > kernel/bpf/core.c:1653:31:    expected struct bpf_prog **existing_prog
> > kernel/bpf/core.c:1653:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>
> > kernel/bpf/core.c:1681:15: warning: incorrect type in assignment (different address spaces)
> > kernel/bpf/core.c:1681:15:    expected struct bpf_prog_array *array
> > kernel/bpf/core.c:1681:15:    got struct bpf_prog_array [noderef] <asn:4>*
> > kernel/bpf/core.c:1687:31: warning: incorrect type in assignment (different address spaces)
> > kernel/bpf/core.c:1687:31:    expected struct bpf_prog **[assigned] existing_prog
> > kernel/bpf/core.c:1687:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf.h |  2 +-
> >  kernel/bpf/cgroup.c |  7 +++----
> >  kernel/bpf/core.c   | 14 ++++++++------
> >  3 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 8827e797ff97..943fb08d8287 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -352,7 +352,7 @@ struct bpf_prog_array {
> >  	struct bpf_prog *progs[0];
> >  };
> >  
> > -struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
> > +struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
> >  void bpf_prog_array_free(struct bpf_prog_array __rcu *progs);
> >  int bpf_prog_array_length(struct bpf_prog_array __rcu *progs);
> >  int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 3d83ee7df381..badabb0b435c 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -95,7 +95,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
> >  				   enum bpf_attach_type type,
> >  				   struct bpf_prog_array __rcu **array)
> >  {
> > -	struct bpf_prog_array __rcu *progs;
> > +	struct bpf_prog_array *progs;
> >  	struct bpf_prog_list *pl;
> >  	struct cgroup *p = cgrp;
> >  	int cnt = 0;
> > @@ -120,13 +120,12 @@ static int compute_effective_progs(struct cgroup *cgrp,
> >  					    &p->bpf.progs[type], node) {
> >  				if (!pl->prog)
> >  					continue;
> > -				rcu_dereference_protected(progs, 1)->
> > -					progs[cnt++] = pl->prog;
> > +				progs->progs[cnt++] = pl->prog;
> >  			}
> >  		p = cgroup_parent(p);
> >  	} while (p);
> >  
> > -	*array = progs;
> > +	rcu_assign_pointer(*array, progs);
> >  	return 0;
> >  }
> >  
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 1e5625d46414..f6e5b207a0d7 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1538,7 +1538,7 @@ static struct {
> >  	.null_prog = NULL,
> >  };
> >  
> > -struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
> > +struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
> >  {
> >  	if (prog_cnt)
> >  		return kzalloc(sizeof(struct bpf_prog_array) +
> > @@ -1550,10 +1550,11 @@ struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
> 
> Looks good to me to here.
> 
> >  void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
> >  {
> > -	if (!progs ||
> > -	    progs == (struct bpf_prog_array __rcu *)&empty_prog_array.hdr)
> > +	struct bpf_prog_array *array = rcu_access_pointer(progs);
> 
> Can you elaborate on the rcu_access_pointer() part? This looks odd, at minimum
> this needs a comment explaining why it's needed. Is the __rcu annotation above
> even correct?

No, it's not. But fixing it causes to use rcu_access_pointer()
for almost every bpf_prog_array_delete_safe() call.
Still better probably, will go this path in v2.

> 
> > +
> > +	if (!array || array == &empty_prog_array.hdr)
> >  		return;
> > -	kfree_rcu(progs, rcu);
> > +	kfree_rcu(array, rcu);
> >  }
> >  
> >  int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
> > @@ -1626,7 +1627,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
> >  void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
> >  				struct bpf_prog *old_prog)
> >  {
> > -	struct bpf_prog **prog = progs->progs;
> > +	struct bpf_prog **prog = rcu_dereference(progs)->progs;
> 
> Can you elaborate here as well? __rcu annotation buggy instead?

But here it's fine. Please, look at bpf_prog_array_length() and bpf_prog_array_copy_to_user().
Same applies here.

If we want to be more precise, the "progs" field in the bpf_prog_array should
also be marked with __rcu, but this is beyond the scope of this patch(set).

> 
> >  	for (; *prog; prog++)
> >  		if (*prog == old_prog) {
> > @@ -1635,11 +1636,12 @@ void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
> >  		}
> >  }
> >  
> > -int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
> > +int bpf_prog_array_copy(struct bpf_prog_array __rcu *__old_array,
> >  			struct bpf_prog *exclude_prog,
> >  			struct bpf_prog *include_prog,
> >  			struct bpf_prog_array **new_array)
> >  {
> > +	struct bpf_prog_array *old_array = rcu_access_pointer(__old_array);
> 
> Same comment here, this doesn't look right. We even fetch old_array->progs
> from it later on in this path.

Same here. old_array->progs field is not marked with __bpf currently.

Thanks!
