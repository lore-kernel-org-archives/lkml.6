Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D583220684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="i2YBity/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XjM6zbEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D583220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeIZOZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:25:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727335AbeIZOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:25:48 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q89xvC012221;
        Wed, 26 Sep 2018 01:14:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=UN6OOaq0QE/fCjTD5O2o8w+2XjX2ZGmfeZ7aDZWAXfo=;
 b=i2YBity/eVjHY29UBHTcudDkh1hBk85ZHoQUbJfGFLLKMjcOaVWsL7KwVKhITDZlDpjV
 FslOkNAMBazKNCKNaMhpdSe7xzbcXn2DhjI7ybddgXIpO8D5p7b0EpzLK87n58rAMgZQ
 WrR/hRKQZ4sx5qRW1DhbmdRCwFWtMG/L1y0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr5dfg4ef-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 01:13:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 26 Sep 2018 01:13:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN6OOaq0QE/fCjTD5O2o8w+2XjX2ZGmfeZ7aDZWAXfo=;
 b=XjM6zbEurNzAej+lZAh8pYRCQB5PsiEN61/bM5jmCyF4XEj6S15Zs8xHgIPvHeHXaXNwF39CXhpWBp+gmkdP3feOC4tW0BwEV0qDbatar1iUuNoiopjiF/n5+BQ7bNCaasUrmY2E4s/LR5wF2+FQHTYHmZ7kDFw9jSvzimsfi6w=
Received: from castle.DHCP.thefacebook.com (2620:10d:c092:200::1:4d7) by
 CY1PR15MB0172.namprd15.prod.outlook.com (2a01:111:e400:58bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 08:13:54 +0000
Date:   Wed, 26 Sep 2018 09:13:43 +0100
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RESEND] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180926081337.GA23355@castle.DHCP.thefacebook.com>
References: <20180917230846.31027-1-guro@fb.com>
 <20180925185845.GX18685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180925185845.GX18685@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c092:200::1:4d7]
X-ClientProxiedBy: AM6PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::29) To CY1PR15MB0172.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9388d24-ce14-4ef3-25b9-08d6238800e3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0172;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;3:89a7ts4C4rqwj5C8YBLECmWht4L3KG0hhxRkftNVbmnkSjt+5QJPY9qlXZrZeNbgsGWxEABF0l6LUUP+LVxlIR2Y+nFsYYf3SktxYsHMOF2Ofv88AgP15ylo1EEC8j3Htf5kZf0cs2r8AOQwTniPz7nzCyE6vc2mPEwbRgAG7Pnce0GkMsrQLNgDRpdM0Pgrf/+X2fsFGPSdERQSotEF7Xyd93xTczZ5jwkWL/WTpBHqLUXq+heeRtgmGR6BcYLL;25:HiJZWig034mclaN5VKSNQ8hhzPdsmjdMvJPoM6woMeLqIZwRoLBIFY1b1+Q+ocNcbpYWcFVmQxgBBN5a0z6Dtq3T0ClZARnzOcduAeCa/9jhiAB/9E5vSqWYRNb9tOyNt0vrmeOHzIVfjXT4j3Sivf5xDQYAs3X9UubiZ0TEbolYmBGL42VFAQnjG2iGztxK4y/Apb4hB9fIBsWkoTdPDzkxkdiUkzFfmOhbw/dSWDwTRNySwLoTX9PsmBNmJmSBFQ/SMkCC4lq835J9AxrAWyOgOiZduJHeBJ1QGZoR7EAk/A/CIjlAsFCX95HHb65McwSLfvCvBVndkCkuzvy0zw==;31:B1DDmlQZ8I8qU2xm7aNe5WWjJX0gWpkjCTr8dl/yZsR89XS71N5gMl3sYRcrnPmUbWf2wVuKcF+DRqhBFxDeh+DMMJ/OHxijSPVWJn6UXtKT4B9FHvB6ELhP9fp7aYjnIH6OASH8dZBGxBXPzo3dJO04Gy4bffHTXp1E1A1QwIFLFoe6tkPNUB/k8h6MXpuWa2+v6Lk40B7bn4Bd3Y50ZMx4WAv4Y1NIyz+qdjRgXkI=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0172:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:kBSdMysuCoxZkOBZMsG1KN1A2eRWdjrp4Ie3vKFzk279m6mUe9CI9ZmJuQn3SmtLmWgpefUPxUQYiFpzErUaFSWy1lDmLUFyZ6v32QYiadMWze8+DjVEEYeJ6tlNOnqmF5+VEe04Wy8QV7B1Z0J4jnX/Utugwrnc9+q+QF5kRNtjWyAYMBrrzL3KZ7asotZzwB05iBI7hWwl6WGfYcMAsy3n0CYFX5p6Ft7UxS0rPqCfU5eRrzZHwcos1TJPAVeMwcEASHS7dyR0z9Mv4tJ/H5C5h9BOUu/5XOhGi0HOX2NW7K9dezSNQ4EswvACPbRTULuWFPdIXx2HzUP3Yt4XqWdZaB/SkeH2iiF28Q3aK6WN/Vgj2zP6Wr4yHGB2snTULQQHGV2KNizYQiiHBw6JOjBNrKKhsbZRLtvjUSr3PL943njlBlaruelc7KFWx0LqjFiwLa6nAVNWna/+4bFsS38/LS1DAJrsb71pykV/HSj5GRJpwsbQZKXWpoaT+B76;4:bg25QPszfOFnihGCKK4MHujcEIiQ3/kOwPLQCB12ZqHlEcn35rhxtFKA4l3PCZpg+ajIIP72TgeaSYYFxEQ6/SA5UetqUUeezQP0VxLkc3QzoI3XhzMsn5Yypk343D2QYk/kOYHVqJHRVCWnOgIQWqFOGBilYFgjLgyPzC/3Zxi9gmXgTF6WnYuM0W5JCgQzxfFmdYJZP6O4nCwhMuq8JrHjSNEVnOZmGZBLRjdJ1F/gZPR2teYO6aSFPyE86CgLlsV2NtGsrRIOdHtPBlMnjw==
X-Microsoft-Antispam-PRVS: <CY1PR15MB0172F89D93D976198C8C9858BE150@CY1PR15MB0172.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:CY1PR15MB0172;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0172;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(52314003)(189003)(199004)(47776003)(6246003)(486006)(6666003)(14444005)(105586002)(6116002)(34290500001)(39060400002)(2906002)(106356001)(305945005)(4326008)(316002)(8936002)(6916009)(7736002)(9686003)(7696005)(52116002)(50466002)(55016002)(97736004)(8676002)(58126008)(386003)(81166006)(11346002)(16586007)(81156014)(6506007)(52396003)(478600001)(33656002)(5660300001)(25786009)(23726003)(446003)(1076002)(186003)(68736007)(16526019)(476003)(86362001)(53936002)(46003)(54906003)(229853002)(76176011)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0172;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0172;23:bMTjEqo71w8DhVAhQ9TSvc1ajKKbqEOOjLmOmXbKq?=
 =?us-ascii?Q?a81JhglvysAV2Bg3VAiTYGyOCwCUZmJm5dDVKPSXwFSMdpVEHzQqvWxwXsu+?=
 =?us-ascii?Q?XDQ4Znhhac1O5IQIKFAG78VpR1hA2VRRgDqzpK0im/Nig+gAFuUkLrztscaJ?=
 =?us-ascii?Q?XABdJ2ytx2WK0loXREx0fnS7RKVFadKIGdqjadTZtanwdEG5q//DaI2uZXaG?=
 =?us-ascii?Q?UBOwg8LhEGHLMl9bH6uNlJNOMlgoQXk5KxuiqLMcO0tbrikAkMuLyUBg7xaf?=
 =?us-ascii?Q?h2+1TGk5HNKfUpFqDq3QY+xd3GYPc1+d4Xq5+WKTosZXGxVcFB6xeqf4mdNe?=
 =?us-ascii?Q?Svy2GdxlcOxPjo7FmsUztvPvs631rPktoRhHNvP8ySfT51YIK9bb7qoreEwV?=
 =?us-ascii?Q?Ulkg+PdI4HxzN7B/FplpWYagi8KHvp07wx1EPnaMn/P7wnyftptvsipYjtSy?=
 =?us-ascii?Q?aY4kMr9adIO20Tfii1ZPeDvExrravIG+EHEl5v1F6zsEL+a/bq8JByfkFewZ?=
 =?us-ascii?Q?H3Aa9zYPrin9AHdxVCGkZUof0+6x2OCo7fXHeegb83klAk3llHZUe6OW+dQX?=
 =?us-ascii?Q?jSyjJbz/9KCZT4DcxhQ6y4vPa0kjsRclYHJLS73TrBw99ZO2Zhno/l1wkC0f?=
 =?us-ascii?Q?czF7pHDzO6KYQgcne+dFbLgujhb8k6oKwMfaJT8DJmxqNkzo3ErwkNFpy/22?=
 =?us-ascii?Q?hhdHdwcs66Jh1M6TVgGzbxLQ2FMjIwN2pJ3FL0l/G7sg+H0Qi39uOlFj4iO9?=
 =?us-ascii?Q?CsgICTsuIxfKmuNR6wDrYZePtnZyfm03yZrY+McI3VgWmZSWZiy/hm95TK67?=
 =?us-ascii?Q?lnvFf1p/xySQVEqYw10GxUqVVpFkVlkDwuTag8m4w3tT7xZ2Ykek6TGzwaKf?=
 =?us-ascii?Q?MhUvyNVqo4ioFFOdgtlFD7lN0XK5mEsFrWOl3jmb7sMDdrhAtikSwZKxMhSz?=
 =?us-ascii?Q?vfayvaj11sHJxC7uSMwPMf+5ZymVnftwdL7zvmAdZ28sPB3V9exkgpGUsXDg?=
 =?us-ascii?Q?S5Mvh40KaIYl6TT2ho5CIQzEycR2hpYuSnUflV+T7gszOZ18OuBfcI/dPV8p?=
 =?us-ascii?Q?2WBb6TuF6n9VeAmGrOSoKgqgKipbGoeWWPop2JdE0TkzjIg0sDftAogcCWU4?=
 =?us-ascii?Q?jKUWWNeTV2pMaAcixmzBUUCTLPMrloilM8sZNiq1bJIwaB9FBSnk+xbFeniu?=
 =?us-ascii?Q?Psp/cMrXoizd5zJr4T4YFAaKt+2UkurkuUd36WCe8nIjpHtpwQXCms2Q6r3J?=
 =?us-ascii?Q?kcSXRxSfUMt21wCZ5SB25WjzT/YOFQ7S9E6gKVmtKxpNgiXh1YLb7vkGG2bq?=
 =?us-ascii?Q?tsVb8OqmiyAdUJkaSTe2x4XYRrvovfB+1jbpfTM96dh?=
X-Microsoft-Antispam-Message-Info: M1RNn25xHv0AO+3O9yvspQB/4BvVDUbvwmy9VrmNysb4P9LfZbTlhiHs8NontliF9NEBtKkCv2mTBwZk0HEj1j0MV+0EboqzHoM7RYxwjo+keGDkqBR7jzobb8nb4ek6N90R4OzNfB+aBKYM84zuASZeYlp/Po9xozSGKXcXCq2824GuAnhVA3nyMAs4q4Ru8L3ut9krLOhbbP9mt08eOicyR9wgwj5Ihomw9eM1h/D8XWeOTb7bkL02GsbLhzBX+reAQn9kLBSYRbhljpT2IuFYPXUzgxRe9YxAimWcpqhps+Xo3lJ6K+/mBo18GvSKxPw4GCqv6tgl157+CvJrLjgohePAoMxvF6sP387t70I=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;6:lbKM14dAlYHNP4+uNgY6lg4cjWjicjhgyj7QDBJwMOZOik/bbeYHPF1W9ow8nByj896NPDJ4uRsee9n2tCFqYreQr6sdCpaXZijzJsUcMeHUQ9zJiz5bD0lLOo7nBw1Z6iU26SVo/zxIbJcYzLmsCZPoKeVGnxd7yd6NETsYL8NMUChP5sZMAPWx6jaKGOeiPzujwp8/1V/V+adLSNRtRwtNUZIHXoY05TxFC6zruHwwuVEzxJwqXwL7cAWFl3g0KeKjckwu3vN0+5XDONwQKyr0FBzxyvIpPxpeMag7XPSZvORNAlUsmwsgrgZqj9REs13z3n3HC3Zwnkgjp4/yu26SmaOXVlnCFV5ySiZxMOr7LU3pRvHiq1TZcRAqPbHSy6Awwt9N9fzUORBOGfPmNKu1IQ08ZjNs7BbpLyJurR8BWQFSr1F3eLheHeCwL6PSHd2fpaaB8jr/RqAmepM0OA==;5:9d3rsb0WhA/mOZwOSFz6xIcurBEfySWnUkWpNt9MwokcrWp+32RDHDjme50gbovHYyDeDoTicL89IO5reXOwiUe9+8ueo3+V7W7y/pQH1k39JCOXzTaw58rtNjPVxxEC6UtBLD+GbjhUdgrtBPfBB+GWgcqffpHVK54KkUPAaTE=;7:xFIIKuQdtZ8J7XG6BY/dfuTGYU77RoSUdYbOo4Wig8sdOjDkv1R5wUn0Vs7JMFVibh6CdbtIUdqJPB47UVmFpo/R+PdlczBWe/FxMWTZ1a8zVwL1Bh6KAno/zQBgUzFQJVj7f5EWwJCeTILEOiWk4g1xEAjX2ZKfJ+SUA/oESBNwITLDpPeCu4gvS2QCKQscwQE/dh0IMINvqaAwVYCMSyzTDICCo82CRzh/97upJLX9fv8qC5Oiep/1vrA+Q3nj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:1lT4kHdQkJJak3qvDTGvKwd6VXsnb3ox5pNd6ptfFY82b4CpoIzvCeuFvZ+ZYTqWL7P/r/Di1orxvcSGeSRrnWDrdBHpYxiGnzxatxpFdXFqcwloIhpEHsPEKuE1zfbAFOGgIAocJe60lYDy4VdXufb5ucI0ykqgaRfueBB8Nqk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 08:13:54.4414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9388d24-ce14-4ef3-25b9-08d6238800e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0172
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 08:58:45PM +0200, Michal Hocko wrote:
> On Mon 17-09-18 23:10:59, Roman Gushchin wrote:
> > The memcg OOM killer is never invoked due to a failed high-order
> > allocation, however the MEMCG_OOM event can be raised.
> > 
> > As shown below, it can happen under conditions, which are very
> > far from a real OOM: e.g. there is plenty of clean pagecache
> > and low memory pressure.
> > 
> > There is no sense in raising an OOM event in such a case,
> > as it might confuse a user and lead to wrong and excessive actions.
> > 
> > Let's look at the charging path in try_caharge(). If the memory usage
> > is about memory.max, which is absolutely natural for most memory cgroups,
> > we try to reclaim some pages. Even if we were able to reclaim
> > enough memory for the allocation, the following check can fail due to
> > a race with another concurrent allocation:
> > 
> >     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> >         goto retry;
> > 
> > For regular pages the following condition will save us from triggering
> > the OOM:
> > 
> >    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
> >        goto retry;
> > 
> > But for high-order allocation this condition will intentionally fail.
> > The reason behind is that we'll likely fall to regular pages anyway,
> > so it's ok and even preferred to return ENOMEM.
> > 
> > In this case the idea of raising MEMCG_OOM looks dubious.
> 
> I would really appreciate an example of application that would get
> confused by consuming this event and an explanation why. I do agree that
> the event itself is kinda weird because it doesn't give you any context
> for what kind of requests the memcg is OOM. Costly orders are a little
> different story than others and users shouldn't care about this because
> this is a mere implementation detail.

Our container management system (called Tupperware) used the OOM event
as a signal that a workload might be affected by the OOM killer, so
it restarted the corresponding container.

I started looking at this problem, when I was reported, that it sometimes
happens when there is a plenty of inactive page cache, and also there were
no signs that the OOM killer has been invoking at all.
The proposed patch resolves this problem.

> 
> In other words, do we have any users to actually care about this half
> baked event at all? Shouldn't we simply stop emiting it (or make it an
> alias of OOM_KILL) rather than making it slightly better but yet kinda
> incomplete?

The only problem with OOM_KILL I see is that OOM_KILL might not be raised
at all, if the OOM killer is not able to find an appropriate victim.
For instance, if all tasks are oom protected (oom_score_adj set to -1000).
Also, with oom.group it might be raised multiple times.

I'm not against an idea to deprecate it in some way (neither I'm completely
sold), but in any case the proposed change isn't a step into a wrong direction:
under the conditions I described there is absolutely no sense in raising
the OOM event.

> 
> Jeez, we really suck at defining proper interfaces. Things seem so cool
> when they are proposed, then those users come and ruin our lives...

:)


Thanks!
