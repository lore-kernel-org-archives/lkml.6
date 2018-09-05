Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72819C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156002073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="K0lcBurf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NFVIDpRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156002073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIFCUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:20:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727257AbeIFCUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:20:01 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w85LhxZb005148;
        Wed, 5 Sep 2018 14:47:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=g9kvSKxgNB8l/ODIUUqdZMEjl6xI48Zfp4WphJ06VMg=;
 b=K0lcBurfYUjmrbD6wJBxGIU+aPa59tgdz0/gIAb687FjhW9FRM3i2VaKcOR3on+4k4WR
 pyhThjwSFezuTkHbED9T4FNz4YOZK92Djf1YktlfpeMdFC0ibm49zZ/eM+P3mt2TF7pY
 6OS77gCImVoiLjXkqZpJhOOLgL3luJ2x5Ms= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2mapv5833h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 14:47:43 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 5 Sep 2018 14:47:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9kvSKxgNB8l/ODIUUqdZMEjl6xI48Zfp4WphJ06VMg=;
 b=NFVIDpRvF6KX/NyhTd3XxVhBZv6KNpudgeEOQg5/jSyg4skLcOL6fuheueglJ7zAOaalG+R5sjSu3TJhTlMjyAAuamfnwpuWXQTjsVbiUw3plOc+1aQeUg26O1MyWbJQlN+Jw9L3pXPSzFFIXRH4/W2cbxtPzd0/cEJAc+Hkxqc=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::7:13) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 5 Sep
 2018 21:47:39 +0000
Date:   Wed, 5 Sep 2018 14:47:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>, <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: slowly shrink slabs with a relatively small
 number of objects
Message-ID: <20180905214731.GA30226@tower.DHCP.thefacebook.com>
References: <20180904224707.10356-1-guro@fb.com>
 <20180905135152.1238c7103b2ecd6da206733c@linux-foundation.org>
 <20180905212241.GA26422@tower.DHCP.thefacebook.com>
 <CALvZod4-7cMOqYR5dF82PWuB4qDr5QKu+ScersCVgp74jhvvWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4-7cMOqYR5dF82PWuB4qDr5QKu+ScersCVgp74jhvvWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::7:13]
X-ClientProxiedBy: MWHPR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:300:95::15) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e19ce223-e5e1-427a-384a-08d61379342d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:PUQc7Yv7TZtRdgLUfK37eGyYwsaJX6EJDNIX/Umn+zcZN5cXOsVXoAZDn6O6dO8UDT4os8NFc+JDSEypCociM9BiyC2D+5pZ9/TGm4mPsp1eNfqhgaTIWT2hywwVFR6aLaKqEurHa/cuTmaI7MXuh1bE6Fbl37zvS0vRars1xjFr3/fdk5cKur/YDfBCmHJ34j2yFLcta80p4F0KzRscA6Ykr0rgsMAMecH+PJl1Kpy5tSCuKjWgWnwWkvW8yrne;25:BcEqjbSy9D9jq6k+bz+auF4W4b7BmCIOJlEsi1chy4lEC/ZUzJZiEiCxjKvQkihbDCbPQL8oV3bIQGOAnDvGLZ9ojYFRrULsHHVJWW3MJjJVxAlpXvCMsR+puZvWamsDNmhRgLzk8p+SLAhPL5+rgcwAwWTz3SSXx7SpHYH82ItzmZt0Aoo+Zo56ScWtr2FJWvbtv/HkWjh+Bd9VPnNZXI+7FXH0MmBciyv0w6DLVxtepDHbMmXu7mzoTfgp1p2aaFDeKrvfNpE2dvWUoWX/Au7hgsrnYCTr46GZifJjU2W9it2ChtCa0AR4Hy9y+S6NxTxWKe/NOG0czCDrLvxG7w==;31:CRqCVTd+O5FV9VoP5ELv6FbYlsDANhuZh8k8hLZiFqGqBFmZaZbhyzKp7hAKjLwNzueMBAFvatAdMoMxbzhbTOxen0oeU4PjxRtVRtm72q+q/ITskpzWD/lxRZZ/FWkXMLZWlkX79zadOPr6Q6pZqjfB1Zi8IqkU8Sl48UMF04P63U7MS8zos6e9KZswDXpwxlWrmh1ZC4BvrT5gh2TOyBeiv/+oOCSlDGwbtGGjwPM=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:fqKr93/WkfN3UQ/unaBkgdU367yYR6zfykZvwEWyHBlT0DsYX+Mdi5TOFR3iGD2DF8yGu6Und91gALwtAvR7Y+3gAkcMFsl0/ZH4uq8I7WGRBlaX1gmUPltVI7cwHKRTCoUy/7SI3f0ZvDJDXMs5+BkIpPnFJIERgjVXsGDPm8jDRiNOcfeTFaEJkBhNjZv4ATyuiBKGeP47U6oqcHsBkOYD3U3/eZIpSSClAyeecDBxqzPzQXheyfyNg54nYU84ElHXFSfW1BEpvLD8W8rrHfolRK2a+PBaoR2rEpmt8+DanJmySOtvmIOP7UNiYMhT6E7K8Jm3RQVDur2Q8gmjowSQlU+izd5Pe09QhqDUeR6Q6Gjr1eyBsoDoOb96Q+Jjt3ZQru+ALBy5D4uiNxO6mL+ShLPpguDLPL6HF2lWHrdScJ7rqxwkvMp+DyVKJ9e/USfyF37iFQBARCPnHGnFkjVZMUb5kikDFf/Qky8sLg6LcvT+hCWI6jRaoHcXVwUN;4:8e5QFKozlvJLjlvNw+jcGE6ZTbxvdQ+j6F99jdrdkRxTniCb3n1eV570QPBCyQC9P0ROIvFajYQXzeBJ8NVJwKgkKg4kOOdPs/glFudDUT2DAXe1xkciTf5jjutVYPxEDg7K44QFhiGnEKlksbxrOOwYd0RG+E0lKmX1ZQebmPXOXTmy65SaXm3/9GJjS2rGYuQwzY0epfG5jJ9fL5ME1ZqUFbpgM7vmFaNswgZdAGCrGnjAExuU/5FubUKoBji96ONHsDAiL2Rt+xOuxzcCEQwXfmilmgG5dxEwYaPDwFxwjoj3zlvSnAhUGZHKqpJi
X-Microsoft-Antispam-PRVS: <SN1PR15MB017531F35F40156C570B7A29BE020@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(16526019)(76176011)(229853002)(186003)(2906002)(33656002)(25786009)(93886005)(68736007)(4326008)(6246003)(478600001)(23726003)(47776003)(6506007)(386003)(7696005)(97736004)(52116002)(52396003)(8936002)(7736002)(6116002)(53546011)(305945005)(50466002)(1076002)(446003)(486006)(11346002)(86362001)(476003)(5660300001)(53936002)(81156014)(105586002)(54906003)(8676002)(81166006)(6666003)(16586007)(316002)(6916009)(46003)(106356001)(55016002)(58126008)(9686003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:9bjL7JTZnfEMD+YtglT2xqAyXjk6JlxJb9V8sfdr+?=
 =?us-ascii?Q?8g+de2zMFzJgaIC31DGUsQeUNNeDNtd9tapsRke+cRP+dvbSu2tYO/iYJ3tG?=
 =?us-ascii?Q?/vfZ9+LMLNWAYAVQ/tvdcP2uXxrSpSu/UKQmXaH88bQGX8F6Zv9QwsBAZnaW?=
 =?us-ascii?Q?Nu8tPyLY6rGaLofAGrEDf2LeWtbXU16qVsGJI8V+i+WKgnjyDld49NVQ0aPq?=
 =?us-ascii?Q?xasYmr8AJnPIA9piqVWScV5N2act+mt6MGCkvLs8nCN8lDDmyczWGTm1ldY4?=
 =?us-ascii?Q?OnKqjVOz21JAlCoRmY6tufEBYNSMfHTiTJuGY7f5AB2NhOi0rAfkrKaOb1QE?=
 =?us-ascii?Q?6XtEzE+apFNc1maulxdMcqFhAGjPrAok7/Msu03sR7def5YDln0WrMmucI/D?=
 =?us-ascii?Q?A+yZztpV9j0+/4qekkgPHRfq9k6eG57F0YMsPVT/ZZHJR2tIrxeRbqn6ireB?=
 =?us-ascii?Q?lg3BDwrWJu5tVXtS3HtYSdcnb6nQ3hzqsoZzKufbccotlSBFwLwonp9H5hbj?=
 =?us-ascii?Q?J15BYPVGB8yKqUbc5gQ4tPdW0W1qvVmZNqLpKTtx0cA0GODgfCcx2bzh/nvQ?=
 =?us-ascii?Q?Y8C4T/aKtrYcF4yUq23HW64bpLXht9FZVUmkgUzCA8KvRYL+r06jUp88HU+E?=
 =?us-ascii?Q?ML83QblovaGU8YgD8ZY0m/ZoOY9a6pKbkbVQjZDiTP4RHD8yvmuXvSJyhwLw?=
 =?us-ascii?Q?G2cKL29LFuHa3cNLUbHU8VoMhAh9NASe9onNBADUwKFLZ0+ilcwgALLtjj0D?=
 =?us-ascii?Q?AiUMTUhKvks7kq776uJS239C6kSF4MBLv1zvWBZfbT07lPggcsycipLaqrhU?=
 =?us-ascii?Q?oh8T+sKwpleEMa3svG0LXhNfB8WxstKQzIZ6fHv2TfRsuhZ/X8FxYdk58dkg?=
 =?us-ascii?Q?cwg7lqcmJ8PiQxQMNCiWD3w/1o5md6NRBFrtf8sKfSr0BzVBH+7YxcpqNv2Y?=
 =?us-ascii?Q?RG8bjtKbQv+n5GkcCnFnDc1QAjLT4kBJ5yAz7JGSsWuFLEN0XdwGyJmLRUS2?=
 =?us-ascii?Q?PPANlxr5wlUKRI5A+If5QfNuztxhWIzPcKaFC6XEw+iFWhYv37Gz/hZ9FOdn?=
 =?us-ascii?Q?5+ciZJWw9pEQVcZ1SoKztpHxuLaz87+8tU1AYsl+sDDQthQg4TTew4j/57Xq?=
 =?us-ascii?Q?BufZOtoanxu5zp/OsB8L/oqdC/upFh91r9M1FXgjjP5dfDhcr940P44+JDI0?=
 =?us-ascii?Q?JZqjAZPFgeeOQ9AAUXOLk177E+X32PlkpaEr+UTEtq+jJyhaX9z+dFBpY7gx?=
 =?us-ascii?Q?h/8c60E9H4iSbAM+e8DpyKbtjkPK+o5LFdgP9TOJBWl1NyG3SBXr6dbdeYRA?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: U+gF5yiQ/NnCOoRaeTsoVXC1+TBMdIxdGfh0TsPUm0sIlvuA+FfiZ4fcDYyMeumRZOZKNuYLk2T7vCK4FMqrqLeRgYgvtTMoEV7B5IsorFAZDqzzJKqqVn7oFplahFwaCre4HXiunWCNtXePyGZXP2G5z8jDCmOhbrwkcnw/Q8EZVdikZLuJt6BFoboKWe3WlXBHwBGCE8jVxjHqcwW8W35aST79AdlqMeqFoHofQw2oPb93Mfda3/w4XRL68RVF4ClMR/gh0Cj5BaAjN1MTDjK1FTR4AoOSpa4Qf23CjEGzzBgmXV8Irp6lTOvJSh9cUBiXa8jajsN92pYurTBHSx3AlqiXCMjC2n0YLsgdt4o=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:EIdGfL1Jfqi6B+4IxfHwnNWOOyG2esnBfMDshzQqAp0jlHb7YdQXyttJc3OlozXZuxUTTZl0NbqPlk1dA6UcJ2wkynCLfhTai9otysysTsQRNkktfO9TEF7cThvkCVhrLr3aS/b/tM7i71HS7zgYOwcKNoy6Ygfb+eu34q++s5x3xBTXVehnJjzJgrfAs3QvkDzOugdjT2af7A1t6geDETr6PTq/Rw9SznmSgCvb1KUHVcnwsz93RjzJMbH5RRmj6iwEKX7d0FWFb12H/lvENv907IlEK3vsc5F7MfMZyH2N1DxOJhYeOHtHuDzEabM4pnUTl4rEz6tEiezByDngAFFYG/aVa8uRbJ49SgBKa/F2H97x2MnIWJ7zoS/nVq6wyEPFiH9g5Jz3ZA+yrwO4cAYjxsieMBTreCAcCFINTsSsQhGhHQu/eFU2vS2mmRE8k8FjquTusrm5/KxyKy3DYg==;5:qTBQh3PDFBz5+v6/6vm/Oy4Ly84+ZOd5Xi0pzu8AFWxHDFvF/KYwYduU2yGUSjlrtqPbShD0TkmpTRxQVfVAhQiQ5oU+ekwFG4bNgYdnEfH9c4/QkQH+uUpKNMvSDeuiw9Mvsec3dOavwyjGJHJL/OZiIdpmZbFady614XfO4Ow=;7:uDSa9W/ZhudQdl3Y4yIcOOYvTu96C8xNT7+/jYQCP04OWxld8kna77kRxUHPEniScfDEnVM5LK1TnceCk1je5gH0ktIN3eXGIALImtAp9nOap94o5VQMy/NfiPzrxj84wVS5pPZ3APyKcZ9AVa1KC2IkjXHP6Haflnej4SiBViENDcWZUMAsO+DBP/ZL4D2cHq/J5T7DuGRsFusU4roddqPG8fF7H9DdgFVzS48eObrH8EjFGMx77P9xsZn60XDM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:6AtBIYtf0TfRXI86HUylF327pprSuuVGaVvnsMuemcMC9xSRtbTkJ3cupct+oUc1UrvG4hWR4XNYl3SLrriA60bqQEtLoy1nHPpxHJApBn2wHQVWQoWisPE3nkDcn19pcPu+ub1V9Kn97zHeG1QUJNKvj0qKKPyn2309Q01tl3k=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 21:47:39.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19ce223-e5e1-427a-384a-08d61379342d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:35:29PM -0700, Shakeel Butt wrote:
> On Wed, Sep 5, 2018 at 2:23 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Sep 05, 2018 at 01:51:52PM -0700, Andrew Morton wrote:
> > > On Tue, 4 Sep 2018 15:47:07 -0700 Roman Gushchin <guro@fb.com> wrote:
> > >
> > > > Commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
> > > > changed the way how the target slab pressure is calculated and
> > > > made it priority-based:
> > > >
> > > >     delta = freeable >> priority;
> > > >     delta *= 4;
> > > >     do_div(delta, shrinker->seeks);
> > > >
> > > > The problem is that on a default priority (which is 12) no pressure
> > > > is applied at all, if the number of potentially reclaimable objects
> > > > is less than 4096 (1<<12).
> > > >
> > > > This causes the last objects on slab caches of no longer used cgroups
> > > > to never get reclaimed, resulting in dead cgroups staying around forever.
> > >
> > > But this problem pertains to all types of objects, not just the cgroup
> > > cache, yes?
> >
> > Well, of course, but there is a dramatic difference in size.
> >
> > Most of these objects are taking few hundreds bytes (or less),
> > while a memcg can take few hundred kilobytes on a modern multi-CPU
> > machine. Mostly due to per-cpu stats and events counters.
> >
> 
> Beside memcg, all of its kmem caches, most empty, are stuck in memory
> as well. For SLAB even the memory overhead of an empty kmem cache is
> not negligible.

Right!

I mean the main part of the problem is not in these 4k (mostly vfs-cache related)
objects themselves, but in objects, which are referenced by these 4k objects.

Thanks!
