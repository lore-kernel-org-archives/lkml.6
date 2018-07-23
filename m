Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616D7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E4B20647
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="D0AKXUko";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L0eMmfdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E4B20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbeGWWcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:32:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55620 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388077AbeGWWcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:32:24 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NLSnPK018645;
        Mon, 23 Jul 2018 14:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=NxyWxfg7dmMBXy2NFECFNYrgn5Jc0nDS444OLRxx2eQ=;
 b=D0AKXUkorB2HF60OCTMtA9rb9IzeEMl/XozrY9mXFKMZZjzL+OTRR5JOjD+fXCys/ElL
 VOCXxySBzMEPMOUqDUfL/CfakAsyDSCRqL0rqGKNl3CnBvVUoyaaO3eF118O9MCx/ACH
 /Dr5/QEtowH92hoeuKLN4QcHlz1vlSksI4k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kdnx6r5jm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 23 Jul 2018 14:29:10 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 23 Jul 2018 17:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxyWxfg7dmMBXy2NFECFNYrgn5Jc0nDS444OLRxx2eQ=;
 b=L0eMmfdmzSL8O1uZy+nopHmt8ax56m+XSo8KmKDHb2I6sVQq4JtOpAuCF5e+5ZHgRWP7wOJ13Y/lZso6AuoITmr6MmwqzdMFEHzvF74QKbevywBrPux2tc39brqWD8gMeha+DK9D58YMISp9qoQ7tPFYyMRxxgb4hqk+NY+0Fgk=
Received: from castle (2620:10d:c090:200::7:cc78) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 21:29:03 +0000
Date:   Mon, 23 Jul 2018 14:28:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     David Rientjes <rientjes@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [patch v3 -mm 3/6] mm, memcg: add hierarchical usage oom policy
Message-ID: <20180723212855.GA25062@castle>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131605590.217600@chino.kir.corp.google.com>
 <20180716181613.GA28327@castle>
 <alpine.DEB.2.21.1807162101170.157949@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807231331510.105582@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807231331510.105582@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::7:cc78]
X-ClientProxiedBy: MWHPR1401CA0016.namprd14.prod.outlook.com
 (2603:10b6:301:4b::26) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4d93f02-0e32-46c1-c18a-08d5f0e350e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:0+h192ZqLj2oBieqln81XZ8BF3PW67PY1HXg8UYeyYQN63kTyxLLYo1ATwTi6LUSnkkjdeRK7xVRnnC5kQnI1GgKcF1O1l67pa2wARO84YKyJphe5EQv2c36dAGltgqA1hjO3cqf+fI9pWD1Oa8h5Hm6G1zFY5R7qjVSrFboXGdvn2rMkFWBUwDopSeroqJlUUJwjcisBmlkGzqB4elEOsCXN15bsgkZSfH3b+5xiZf8Uike0PgdNmqvVm57GSVl;25:7YP4UauTAU94IassQeolAmQvZSoZTFz87z/ews3xR5zSpFb91h+YXJXuD6MkUZO4AaWqre3HcYDEVRgJyKc1agdWJallgBhbXOADZVVFtoWtVrikDZG4sfTKfC+W9MYWrn39Ieo8JUQZ0RMB9+sOwY797naU3wk2xCr76yIaGAVICF5cO4qKQiyC7WUPkoURk3H7y5Nog9WOQL7V8NASil1fLG57bCr7U8y15iY0F5OF0R/12+X6S4zNZyG0pvwwC5AXEiRNlQeBY+7RWedlhrhwhC05KMJCwZWokBcCnbBgdj5RzSihgDMxodUeqjt2JVrx3fLg41Yj9wokQBFt9A==;31:DiaCj59GzHPwBv9x3TwDqvM6FyOUc53sYUFAOszVNajffUIGnpFl6AFB5/VaSyJN1Q3HSwCT+12/TJs6NXguslP0Nh8cRtO7R1K1/sYN/CyUXRznw6nJqYNJesjN8SG14cJVONyFvzBTYc4S2KEx68bFgUec3qTPCqzdRpM4prCLh3aLfsumFAy8zzSVgtTFgHtkwZbIUukBA4j6CTl65weKvgMmfty0FyE/kS+IvEI=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:wnKzdfIyXzeDCXYVNe5vbqBdzmkq+W3nKpmLS5DMlACK4lllYtatGGRDZlheqPjK2xRQeFp9ddskenEwPCcZqqMd/xqpmqQFjMDawbKMlpHgzIyqEOZn97p1mUU4YuXNiqX0VZFjPGPOU2y8ebadGb9NHH41n7TY9tAjjj/EQ8osN8AB3Zb88DzaWmKH0efOKR5jN7y59LP7oUk7jNuwF4Z9Fm10lH1BFgR3DYj4pRl3V5pyyVNAK5g82sFAXEoUgvZD4StwSwKKfUpXEsCq1wm9JIdd5BZFHhW13YdTtniCThyG4Q6O5m8FMOWljIi39iFQcnCs+klDelYnShK442XEmA211LzN2R3eBKJW0vZcl6rPKcs3/6dtCeAUWub5gv42g3VsdhM5ct5UzNxCN0P99fbHEF0YjWfW9AiWLo9ADbIJdThFwqR/e5KnGvNI1Y8VZEjcfJibwy5KIcXz2QIrTJF4bd2p71J60LBE/zKOLlYZIBPNRnsgQBM8j4ll;4:+65P8L6xERpbJ6uLSd0kKryd5V1AbMHQhcqfJ7Xo2cFSCrRgb9vHtTbOJchHONmVHDQzvrW/nGdcd5AdZ08bj6O+apoEj2s/O0A39UyLeEiNRAdKzU6TKixTxwLxB4CTMxc7Wml9l3mt4QwqhuKCDS9fykk5W9rlvSxZDBZTGcuALb0OmyboMeAgZmW9FjerSVGuQWJjuuuarMk+zQCdSWf3aKL0Gt6Izgjs4MuYAkhLd3UpKE4HD5Xta/zfCgqf3Jy8bOTwOxcfk+hsxi5Nhw==
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167BAF48C76CCB6C70972E2BE560@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(5660300001)(229853002)(1076002)(105586002)(106356001)(6116002)(23726003)(33716001)(68736007)(53936002)(55016002)(9686003)(4326008)(6916009)(25786009)(50466002)(39060400002)(6666003)(97736004)(33656002)(6246003)(478600001)(86362001)(8936002)(76176011)(47776003)(33896004)(81166006)(7736002)(2906002)(8676002)(52116002)(81156014)(6496006)(186003)(386003)(11346002)(446003)(46003)(305945005)(14444005)(16586007)(93886005)(58126008)(316002)(52396003)(16526019)(54906003)(486006)(476003)(551984002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:7b+XohvnC/1eq+upiTlJEDsvB9M/XCGOvFrO2220n?=
 =?us-ascii?Q?dwJP9ZzhONxpkFd9Kgj2R6GUHTc3YNG9duPGkqlNnVqO4AWlcBwVClkn/y1R?=
 =?us-ascii?Q?+an4Y9BN5u1QRqgxfkwcDRwLFK/FDGp1f9MgO6ejUArPKuYy/tKSjulWgaYX?=
 =?us-ascii?Q?29FYQW997tYUviag1dwlxf5nBcyc7Kmdhnpe2Cbsoh75iOrPMfm2mtVXQI4v?=
 =?us-ascii?Q?rYoGSYJWysMWGI3vAXfP7xytxO1OAZDMx4TK/lKMXpEN21rV/TIuXEG+dGKb?=
 =?us-ascii?Q?3Rx1xffsN55BJrD1gZHykxqdFaRIKbbEniRlzWtaiO0z5UYfNCtZtMilbr9c?=
 =?us-ascii?Q?XUnahieLQ8DdbdQ9JbeHdWMsHQzlsLPZQgx7b23Bl9uaVT7HNmymdsyHZu8C?=
 =?us-ascii?Q?EaGJ2bRRwkr27RilBTv9YUrbGBEC/KIhjEIbHigf/j+4f6a5y364nlT7TGoE?=
 =?us-ascii?Q?yqyQRvOMGw5Jn52p4OuNfNsph9rqNq14UXnOxiI0oPh+DGq6nOnZr6lVuxed?=
 =?us-ascii?Q?WiXKILQk/Mx+453T8gRCGtukDtmAr4G04I4IsqaGk8cpr2/mQVrQB2XZudWN?=
 =?us-ascii?Q?f8S5xmMkQL5k7F3sVRN+DY4JxGODFwtM7KDSLAPjR5E2ZpQQckMqsCC6XR6f?=
 =?us-ascii?Q?XYf5cc//IZF481k8aF/DxozptIMkOPPnXilF4oT/5RyqNYCFciWaB0TwlbfT?=
 =?us-ascii?Q?Jycw2U2k9etCEFLSqM81VfJEpxJIEA7JGmKvwOgwjaNZvR0dTZTggu2ELzwl?=
 =?us-ascii?Q?t78oNCt3pBgJ1E40CFIYefPZlQDX8EVdfT1WNTYK/aZ/+JtuS3uGex9H7ONx?=
 =?us-ascii?Q?u3GAxA3G5tOqgBEn0CBKO0ojdLn9iHiu9lbyj9dAkm4D8j8RqnqJrXbT2RPv?=
 =?us-ascii?Q?XUE/5JNWL3LuBZjeliAULGAwwZqSazbeRyD2BAlXIZMCkFViEAPS6+CrtX5h?=
 =?us-ascii?Q?VJnrnVFHSanzfqrm5oxBdhfa8NrdSpXIs9Sp4ZPsjU+nrSKU5E85C7JC7uBw?=
 =?us-ascii?Q?l7NO7zcW59KlzNsO4ZxgyG2TeY0U1dqFsO2GKogMqBQ9WYmxnKSI0y1uXs2h?=
 =?us-ascii?Q?KqiXiCKRRIg5rKE779K4VrpUY4LICKLTafKmKmEfQsGLeEER851tllOaCTk4?=
 =?us-ascii?Q?XZhguoAvSB3KiNrn+IWrRD4Zq6TxPpPDoEpTcbhGxwtYsFLIh7YptwaYQWuV?=
 =?us-ascii?Q?KXqsAH5MLbJp93UcA70z4uxznuYkXKZptSPZVk0IJH684+gKkPG8MCpHEQjH?=
 =?us-ascii?Q?/BjM9ndya84LdF2OU/Aro1KHt0d9j+9v9yTPlXV1LAY3Do7tqFKGVBqRTqmu?=
 =?us-ascii?Q?UwfruKPSaLhLKU4XfI8ekvVN3BmxN+xStIx3IfJwCJsJJFShx52sJlavt6Ja?=
 =?us-ascii?Q?kaxfg=3D=3D?=
X-Microsoft-Antispam-Message-Info: Zzt97gKG+I0zoFVRF0Rx5ZUsq3//g0xDg6qf1Mrtr61ce+6rBVOr/8OwLISu6SxFwWu3mqxsyKsNSury1MlDFtniAdrfVEum7drYC+Ahq6obn9sZcbyXjKpFpyjliSk0CZcvZyOsnEricQ5FeIQU+LMvxZkX00RKST3tvjBWE/AbAOllS37BPmiXxKpt+5+Bo5WsbGdnvQOYpK/ZmsX4AWB8+4TVWj/n++UNe7qeqZVZE0VrkBAopKgiMOxqjDuETf22SrfM/cn3WMSo+SSSTK3cvmUJkYEkCJSmPJkBW8ZbwjdmUtEuhPZudgPvlHVFV4w1enrBZozg82FvZYJVE234Lw9YVMLI4eG4rAKKUg4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:/eN/XZ2A1sG1bgzC4J92Yt8WvvAFebLMBeleaVIOd6RfvzqZFiiJuch945v5o9NZvIDsdeJBiVwf8N0WRIGmscdIHdY/Gw/TytjDiPFQ6NkMMsviFotVe5c2bDLmQkCd9Fjgt/zHSO/n7SBO16pY6smKJuscSyJziEJERS/HYYdPblKpCRaK5cOrnieiaWyFGnv1A5Q7PsLpPgeCgzpdyRq/0DdkOGTWJVQMbrXnNj46KFGEItr+dhoTYil5S33RHqZ5j7c2GWdCyNGFt8gQD03Kfa4WVhORcpGwbULqnSgM/zSaMYBWhPxkqlpLM/sVgtnsnsbAyGRvj9L3Fyn+qs9cf4ArY2mLx1v+gNW4CiDjaZz5XQO/bIZSegnHlTMI4LbtP24JUu6xzLiK0Shsr10Khezz72QxSWWkap4x0KUcuXeDz3/RObDRvxHiBTI184Fwamy+1Mkth3u1Bi8iJA==;5:iUhqZ7WZUs2FowpnN47u3ciPBvoV//qcJr+I+FRShQ/JxktKgUhjkYNFhdgzjd1MDlTGnPVI9eGFAwtGVqCekMy0x5RT0z62vnCv7cVUnaCWYTyjJbesvHcFDYj0gAy2WHgSG/ryb+9+StHCFOuVOdwrYSQuyxLObSR4+iBol8o=;7:v+S5xuVYjrA2P9+2rQIGaV4vecw5O280ckCIVXTBqlGCm2IpTH7L3AU3lz/7tilWZ8i1pYtDFV7SQEkxF1F/E7Al6jL3EnNzvUYesd+Rn3H6LIgUYx9VYIHb8B+u8xORwdjOtBh/GzvCPxFpDdJnIciKJpiX7zErrXJWYVUYzlpokZnEuVyzz7kpugBLY7SD/XzPED8QradLEeBr/P4oOIPHp8GVhRljSzlpzs5civKw7aTr4GXmndW+yAN29CyR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:0pZUySmtOECwtV7EYMPkeb6gEo9BtbRkCc6HKmzRIsCyWmy4R+fadl9BSRrR23FKKF6p8HnkO2sVv6m+dpMh1tWLTjRDPh16o+Ee1P1SBhmIuTlUV4aeeYrxk5EiYYHzee+zjAMp782G5B3mnKnyNkPSZZ3TleRwP+a7WJ0I0VI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 21:29:03.9116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d93f02-0e32-46c1-c18a-08d5f0e350e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:33:19PM -0700, David Rientjes wrote:
> On Mon, 16 Jul 2018, David Rientjes wrote:
> 
> > > And "tree" is different. It actually changes how the selection algorithm works,
> > > and sub-tree settings do matter in this case.
> > > 
> > 
> > "Tree" is considering the entity as a single indivisible memory consumer, 
> > it is compared with siblings based on its hierarhical usage.  It has 
> > cgroup oom policy.
> > 
> > It would be possible to separate this out, if you'd prefer, to account 
> > an intermediate cgroup as the largest descendant or the sum of all 
> > descendants.  I hadn't found a usecase for that, however, but it doesn't 
> > mean there isn't one.  If you'd like, I can introduce another tunable.
> > 
> 
> Roman, I'm trying to make progress so that the cgroup aware oom killer is 
> in a state that it can be merged.  Would you prefer a second tunable here 
> to specify a cgroup's points includes memory from its subtree?

Hi, David!

It's hard to tell, because I don't have a clear picture of what you're
suggesting now. My biggest concern about your last version was that it's hard
to tell what oom_policy really defines. Each value has it's own application
rules, which is a bit messy (some values are meaningful for OOMing cgroup only,
other are reading on hierarchy traversal).
If you know how to make it clear and non-contradictory,
please, describe the proposed interface.

> 
> It would be helpful if you would also review the rest of the patchset.

I think, that we should focus on interface semantics right now.
If we can't agree on how the things should work, it makes no sense
to discuss the implementation.

Thanks!
