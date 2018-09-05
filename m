Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AE0C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F7A20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b7lAR3Vq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jAIWJ2yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F7A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIFDle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:41:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46472 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeIFDle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:41:34 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85N7k0H002256;
        Wed, 5 Sep 2018 16:09:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=LHnXMt9r6p3UDkWVq8+KgOW1v4IFa1nEzXJQhP6wP8o=;
 b=b7lAR3Vq7LNaWJlZST56ylQgLUAFMWSDuQKc7nSinIyLzw9IhE83JI8r2Ig2L4l+fMdi
 kX7qF03k3vicxoFxaWiASoHUtuuyEqrdfyGaiqMfnjFcdptBC7ioyTHuSsgFSqcHNFXN
 pm1Gdw+k72oQV69NLnbTXrHA/i7d8YX6lco= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2maq0589mu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 16:09:02 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 5 Sep 2018 16:09:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHnXMt9r6p3UDkWVq8+KgOW1v4IFa1nEzXJQhP6wP8o=;
 b=jAIWJ2yCQPxAHQQ0WJFT4wbTV1hLiylDsZb6NH8weOSpBccILUiHFthHolSQgfra7o101UVLDlOwVV652Z8Y/D0k+3nH6BwxBdzhwMwBQT0diLdYZogd3nhMqjdd1Cx58IWvXbw7nyl9+W/wEnd9DN6hOScnyjKNVbYCjft03w8=
Received: from tower.thefacebook.com (2620:10d:c090:200::4:9bc8) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 5 Sep
 2018 23:08:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] mm: slowly shrink slabs with a relatively small number of objects
Date:   Wed, 5 Sep 2018 16:07:59 -0700
Message-ID: <20180905230759.12236-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9bc8]
X-ClientProxiedBy: MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b69d4fc2-73ec-4b06-07c1-08d613848f67
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:kbe10d8cLAApzS+Sqx3gsd1WV/pBmMrBoUW85neApETg0mztR8vnqChMMHewdgcDEbdF95/cViDrUhLK6+RrwutgEVf1rjYVxQpqWBDJqTeXGJwzQXypN0b47XPBHEs+15RzRCQZub7S2B1lajPK1IsFPxohpn19Enbr92mIEcyKlYarail1XXhBb6Pk2MU1B1lU2NOwe5aIUr6QZU3TIAdyRGYhkUdBviIqxDtD8yy226ok76NlsqEBE5MViAjB;25:gKR+QN/4KyYtdmNELFmKcJvNc7TcQsuuqOBRIoE8x9CbBq9h/qKsH8A+mznVcvGsZn/w4S7OecGThSABz3z59Snj73npFuLb9ZfSCjyC5Wcj5hE6/t9Rv8zgpE3/aQnw4Mkw+UMRzZhcVUltGCrI9sFNPXqn7FWFBYbs+dfdT1WJQCkiHfR9csLurfGKI75BN+OwTQNy8ZNYM99IL2gL56HwtW6Yvo5e5cv3ju5YsY+UWpjkfKBs/A4kRyH5hVvLJXSlXjxH7qChfsi5JUrhLVN0SAAH3NTZfnFDnXfuejrpU/Oa82TZpr8JqXRmVsgmSIiglcLiDRmqlcBR0cvlpA==;31:i/0PXcI93t/JhLaVdzMEOmWAd1ivG/ruDlZ8egeIOgAE1MdaW9jc2cfujQoXzKYy3FIcDnYEfd0GVWnZ1/T31Ca/cRcst2Ef9TbmjFohBt1HBA7Y698K0cAhhJw7gksyAAWrR5y0N52F0caf1M/Dv0gmy+KTOgGp1oZYxOt0kfgu7uGZqqvoKvo6PgUIY2eOaqKWkzOSLJsk9txNtdXmeheBXqQ2wtNI7pKXcdtLuD8=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:DlUpdK0bkOU526w2C9geNaCWf1+54QW/syg1GjrM6/TCBhrCcFJbC3rwZxCjNRjvrVCnxwxPgEmyEziBGWyYITQwhX5Ro/9/nf3z6IEvc1sFJ7PdqzZEvULHbuYs9QxktovaHGVKXePK9Ecjtt48Y08189YSpPIhgZBsx1kKz247sUJDyYif1GCc3TY7smWsl6JzSSb+Aw+dYPATjX/+1OVqd0OCuN+iLG4FssmAEutzvBBKdKHaIbgoiPv/WYLfLFHqA7qMevMr8p5R4xg8PLTYgQr5vkZozK0B0R9M60d7fQollNN98PPlphZjVs72bmc2wd0T0dyiQ4CNAAIb15TB3Xj3g+EdEWfmmcj6kFdTVkUy0rkLUlod6UDWETDRnXdbcJNiHBjVQW+Dt/6UL1Wq2eT8S3bjpPvGypoVwXCU371il8PwxYcqcBMtFyeOB5qp+x5nE/UgsSP7FbEU8CYqeag17krx/yF6+Eu4XxiXb2F7Vlf/Up7zPbIPcOz0;4:PCuGwhulp62bnMk3MnLauHeD8PS6oQwPn5E9fY0fSTKTMUf/J/r3gHtzovLvg8DNwEV9nTC5x0rW7v69DhYJWya6pmJsa27KS8cF+xXQJtTy+Z2odehPp1t42OJSSWvMogH9SFpfKl9u09PwOeHF+8/fc9imuQe1BXrbhcpN3u3b84NukgKnVJxn3F35gbBmNcav7jIOspIaWJ4XPtFxDFZuRDNK2Tr0cHI4z0lunUVnF7izTah46EmsmCO3TD9CIssEd6FbtJHRwsLe30Y+IWzwt/iF2qlkDSm3QdVFasSlZOihQLjcA8Tlaoqc5SVweHS34SO4tsI9mt+j+oPvTvoVjP7+inRNsw7d2RxUlRcI/11RES273daGivJPvyZw
X-Microsoft-Antispam-PRVS: <SN1PR15MB01753F5FDDEC2CD2EE3F3FE5BE020@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(346002)(136003)(189003)(199004)(16526019)(2351001)(186003)(2906002)(36756003)(25786009)(68736007)(4326008)(69596002)(478600001)(51416003)(47776003)(50226002)(386003)(6506007)(97736004)(52116002)(52396003)(8936002)(6116002)(2616005)(2361001)(48376002)(14444005)(305945005)(50466002)(1076002)(7736002)(486006)(86362001)(476003)(6512007)(5660300001)(53936002)(81156014)(53416004)(105586002)(6486002)(106356001)(8676002)(81166006)(54906003)(16586007)(316002)(6916009)(46003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:ruigkUc+dVk9wKGlN2DT+FUMHKMZcKhBQyWftyv82?=
 =?us-ascii?Q?hqDTX6zWXCfmxU57JWUWfyAoD6IbJKAsy2WUg41tyItQk4n3ivdmp6BP6nWQ?=
 =?us-ascii?Q?76Q8uzodboKgocf0NTI93gJhfClHhAGF9lhi74gegAZEE1jsOPnPen6voqBQ?=
 =?us-ascii?Q?lk8x2LERdtRhYXg4Y1U33e06ms2TA2H1axvuacDY61fBGPB1a/p+a5E9V6WM?=
 =?us-ascii?Q?baTqQ6f8MPnNFGU7ejlMAp2U7bZj1I63mgOoKDMDEl8YYH9Rn/HWABcGBJhg?=
 =?us-ascii?Q?hGj3xejMdSpuXsriWnKrLul0kjvY+ZJTNE0lQSji2BOYR0d1FJw+f3+uk8Ly?=
 =?us-ascii?Q?al99u4y43i+h6Q/2MnjKU3ThlXn8nNbamewrvPEJfsPoEhQckme+DujkzuV/?=
 =?us-ascii?Q?/0UoNvFcJMStKRo/PbtLJzyRKnaVFiloCtIUHn5VXg+31NY3zejZPRvTljWj?=
 =?us-ascii?Q?ctkpFi0iM8LezSUtOJy8KJsK9fl06QtqEpTo3PVcV0vfRt6YyZ70x1oHIEq4?=
 =?us-ascii?Q?nb0kmX5vQNS/lauwIjJEr/I5n1C/CSgbqWd54nehGoLavLIwo0XjBkO/XT9p?=
 =?us-ascii?Q?vdDSge6fobcRWuDMxN3CB4avxPi3vlSHlhq2Q3txVwTA9N4w3GdtoGoViw7K?=
 =?us-ascii?Q?nhK3gkvhUuT7TrykFjmIwY6uSx39sdGZbIPGlnZ1JqwJYjOY8aF+oIipVbi3?=
 =?us-ascii?Q?FFr8WWCWloWwJMqLJCIGfjN0MEC3Pc1uogsjzOVnestSFRkmAXyxMiAk4DqZ?=
 =?us-ascii?Q?qpI8GBLMpDkkB7GyjxFM0XsdDD8HUO4/VGfxjUkccimoP43JhibESQgwCLb8?=
 =?us-ascii?Q?7oS43tIpS+s17oFbEXlBRmSBejxz534iXTXT7Ibv1+WVnegGQ9QdtYLAEhFQ?=
 =?us-ascii?Q?aOwFysaxThWYOqR0JqRlFhY4ripVZ+1RIDdFu3s0LfTHVkXtQJjsg+qmwI0K?=
 =?us-ascii?Q?mYCZV9bfei5XBdB/GClXhF3wqi+up1uSZELLJrcwDsn9FdBHKnfNx9ZDlBXM?=
 =?us-ascii?Q?lYJOISq3OEvMMaqG9e1zba/Nk61XJEzu4+fNF9X/D3VlXcZ9YNXsNAc72dwB?=
 =?us-ascii?Q?xJv5PwEza5rVsjCj7itW8CUaQhYuV8VvYuXdpaHAH+aYRzWMU2QishKsL03f?=
 =?us-ascii?Q?sf3BIzt4PWVP3ftbGQ6+ESGuJW71uFhslhI6mvOH/uEW6uNVP6E43I/czE4t?=
 =?us-ascii?Q?kEb3TqQ4Fq5ierb0d4MdS9vdm+ftubQfpxm5p9ih2gj+wJ+hYJg7pPdEQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: oS7oVTwQhupjNfpirFwwG3+E8ILs2DlJD+a118MeomxZ1JXeVEBHS7ke/LUbfGZ+OF2Opp9/iaM0FAxneKREpURmX7juyFt72NLxB/ftYw/Ovq9yRRaDAFiTN9ce1JC411/FdLNWRXubvAswE4yBDqM8kEKknuijZwTY1Yys0HGsgcjz6I81XFOUSk06hhBBKRB1jig7VOshmjIVdJs4uEN6FfV6LOhzUuELZG+mv2hYhq/ek/x/ULMl+HFm+mXSSA5p8pG9PsI1vzuR4/iH/hEBHq0L5E8EbUVowDP9XWDqRgthx0nkEor4fK3banttB7lzQcNIqTRRamWHZpN/7xXdJh/0ifCtkxfi3Eg7dYQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:f5uzgUNiVvtFDMNUGmHniiPsDt/0IWMY6saGDU3E6se4vaYpVuqBw7QsT0/jTibIhABae8WUtKRJ4//mSjeLWA0Yym7vT9Dc7M+PcTMn3pOYVxS9iJmQX+giyfaE2dXGRS90Ny9jsqA/7BhIF0iq19xUpgLswcgK/Dp2NgWpc+EyfLqFvcSvY53n2Bujv2nSdpkd/IHijAjARZjjAHePw3DjozdMwB2lA3RgglaBkDZH5N28eZnzYtWQKWYmGsbBhA0ommhgI2jtHrnn7+Fcbg26chsrsnqx5RdiouJbPkUaQqpTkE4yN8l/gZlKCHEgdIe9Swr3IEymj6h3d6ZYu06lJVkknMrNSRj2LMHE70/YN0bVeSiPbXdFLJagNbizG61bTsil1fnsjSGArherVbv4pX13oWgQppan/IVd60nDOeeaL4OOq6bYLc8BEutOLgonbb7ahHMrAtWfHBWWRw==;5:c+QIC4IuN9qfVGn99qr6zOf5BRZAeYTfBlonksYflPzy4OT1vTIslCyHegtjLqpY1PwSnNzXjQe5SB+cQBJtuJHbAiTWmrnkzt0mdETqT4hR0IzrPxFqogDL/IAm4HIhzmWfNr9lbgaETa0skWjxosd/Aer3+Y4QN+SJmaZss38=;7:2XcJZ2ERrHjUHhc3W176fpHftFJ+5ZEWlq1fFK/XkqLmwDhn+nl4MTvAhQFd344m4R/cvNkQAcWnLO9BOshT5JwjlPt7nk+FXInbUPAaLhujSvaqt3Npv+jSfhXFicfeacIuuGkAA8WpkBWj2AEFy5z0eSqyKtJU7sVj+gV7qMW9uj0WYZ89yScRlyKE92OdHsey70ZtfroSBv//VgjLOkyOr3dg2yQqs5dLgj4+3WE9pO4JKjAF6/f7DIL/vMS3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:+LDg+S2F7vjYBux9a/GXN43Z14OU9wpdHrCjL6gKRaC2fbUPs87TbpSk+rhRBZOOg6XfzXH1yNos4/3jBPpbH2va78mvCNGHcMWTQV7mrnQYw/qRNh/g8an3f7kE8gtlsXOe7fcsThV78u5fF78yYn5mI+gGzSrGwvPtTKtnZTg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 23:08:57.3611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b69d4fc2-73ec-4b06-07c1-08d613848f67
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
changed the way how the target slab pressure is calculated and
made it priority-based:

    delta = freeable >> priority;
    delta *= 4;
    do_div(delta, shrinker->seeks);

The problem is that on a default priority (which is 12) no pressure
is applied at all, if the number of potentially reclaimable objects
is less than 4096 (1<<12).

This causes the last objects on slab caches of no longer used cgroups
to (almost) never get reclaimed. It's obviously a waste of memory.

It can be especially painful, if these stale objects are holding
a reference to a dying cgroup. Slab LRU lists are reparented on memcg
offlining, but corresponding objects are still holding a reference
to the dying cgroup. If we don't scan these objects, the dying cgroup
can't go away. Most likely, the parent cgroup hasn't any directly
charged objects, only remaining objects from dying children cgroups.
So it can easily hold a reference to hundreds of dying cgroups.

If there are no big spikes in memory pressure, and new memory cgroups
are created and destroyed periodically, this causes the number of
dying cgroups grow steadily, causing a slow-ish and hard-to-detect
memory "leak". It's not a real leak, as the memory can be eventually
reclaimed, but it could not happen in a real life at all. I've seen
hosts with a steadily climbing number of dying cgroups, which doesn't
show any signs of a decline in months, despite the host is loaded
with a production workload.

It is an obvious waste of memory, and to prevent it, let's apply
a minimal pressure even on small shrinker lists. E.g. if there are
freeable objects, let's scan at least min(freeable, scan_batch)
objects.

This fix significantly improves a chance of a dying cgroup to be
reclaimed, and together with some previous patches stops the steady
growth of the dying cgroups number on some of our hosts.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fa2c150ab7b9..858d7558909e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -476,6 +476,17 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	delta = freeable >> priority;
 	delta *= 4;
 	do_div(delta, shrinker->seeks);
+
+	/*
+	 * Make sure we apply some minimal pressure on default priority
+	 * even on small cgroups. Stale objects are not only consuming memory
+	 * by themselves, but can also hold a reference to a dying cgroup,
+	 * preventing it from being reclaimed. A dying cgroup with all
+	 * corresponding structures like per-cpu stats and kmem caches
+	 * can be really big, so it may lead to a significant waste of memory.
+	 */
+	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
+
 	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",
-- 
2.17.1

