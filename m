Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4064C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5DC2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Hcq7a99o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XmaTdU97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5DC2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbeHMUh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:37:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728661AbeHMUh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:37:28 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DHnRh4031745;
        Mon, 13 Aug 2018 10:54:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=mkLvR07c0bI3mkTQ33poWU4P0Ee5dwtb9G6VxjlMce8=;
 b=Hcq7a99oZslzJfemRBnVbi06lVIfT6iz8sZrzcyXrlOB9QQwbg/YOSVJtZqXOwcXTWVC
 EA2Mw/kKAi6XSp1XeqG5gvmmOQaa6+IPA+t9z7xX+SIumCF8wj64i1u9rbsdTHNz2DGI
 WoOi1Q8+mZwSWm3jDF1ciuDCTLuP/FLO2sY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kucqbrhcf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 Aug 2018 10:54:08 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 13 Aug 2018 13:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkLvR07c0bI3mkTQ33poWU4P0Ee5dwtb9G6VxjlMce8=;
 b=XmaTdU97LUl6IpzFoa01WuEWSGfAbNDUQ+VHMdja5lSoVzp5DUqpZm9xXWzY4iHjT41wOb/aEqNZEiaugmg/9bBClz6SNqN7eYKG5UUxX4yDXY9Fv/XC4V/YuJSAhHKkMIcSXK+9JNuTE4dlEo3K+n4tcRrclLH1AOIhhBj8bFs=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:eaaf) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Mon, 13 Aug
 2018 17:54:03 +0000
Date:   Mon, 13 Aug 2018 10:53:52 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC 1/3] cgroup: list all subsystem states in debugfs
 files
Message-ID: <20180813175348.GA31962@castle.DHCP.thefacebook.com>
References: <153414348591.737150.14229960913953276515.stgit@buzz>
 <20180813134842.GF3978217@devbig004.ftw2.facebook.com>
 <20180813171119.GA24658@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180813171119.GA24658@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:eaaf]
X-ClientProxiedBy: MWHPR01CA0040.prod.exchangelabs.com (2603:10b6:300:101::26)
 To CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eefc59e3-2f26-4a08-172b-08d60145c232
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:S/cM+usxjLdPZAwYdU+fB2xpLYyQ4krFEBjfW1k3+mwoqY+4alWQREzkuFdssqk/PzRWbdi/FwQrA7ETm/w7N1k4v3yqLRp+0jmZ65jCvzE9L27zyGuyP3eBviy7rSK1SMrHrRh6oadLNWeqZazCFzV4qzX3bbKnyHBTsGjtknF2gMsKGTEFy4nrrOtPVnHFUGTqdk+PDgwVp1udWe2Z1CDpckz/18cK3Fx8msC1nBkIrK5et0YJmyrk1HZGod1E;25:eIlCB3HNKyafBZhVjRef168ASbzHD2XyzNxMRyxN9/nRbofndjAtDfBRjN16/gwnDEMAVV1XtPD/29b9Rw+PIbgZhZzezo6arD8jqt9wjxFvYAlhyMntuRkoZG49XZnptXH6AV5mWcOQUOacIlzORtKNWJRLqWvX9lavW6Sdb61xrOunD7k/VPDVo7GKWSEn9cmMZSiZ89rSCJlKMVn0XBOzuz8p9/8S+U2efnoWgAgZjracVI8OsyN+1HNraZc2PE8VJBj/fmaQKCyCdsF6Bg1WtfsGPfUU5yT7ogHkrSVWlYtZFEB89K5I3X8Rg+YpVJIWA5BM8qUsRqDUEtQP4w==;31:SwtoHTi4RiNz/x+W04OwfP8gORLILxrJrx8jGbiri+A0UoTNnxmZdJlXE6vncNfV43zA6y1igBFK+RO+EqM+YyPbt2yT9bs066I8KVJ+KeKOnrWaOW8JiCAYi6NqXBmJofBYiT27jZI67spls1X6lwZs4POyphr9Ca+X67llkVg3Jcgso+QTiDQGBvo9UUhg0jHri79dJAO22tAsw4q7dhWRlXsbvXo6tY04949M67w=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:wWUEofJV6jtbjURQt2cjrMGduHA9UssTyVDqilSnhQSzE3pEzeD/NqwA085+8CUB6qNLM9O5DTaJbJCISe2p5b0/fTay6gXGDUc3tUTdHyh5JKY1ww8YZwmGjNgvxwcr0UDM+TYWHHrn4mP/NXwyf5pah9cmPJGYwy4JyZ2dzLZF7Wspy1/URtzxoEReE8luod+ZKS+uPKfrar5aaJ2y7VEuP7hBh1vGsgtmM+/Yv8Cd9xN0sSOOdk1o0NbOq4vhFzMZl/tPEsoAhqW+eyOJc6Uf4YQWEMOTi1gH0oC9xqJGv1TodHPP3v7Fs4utJb6AFArV0XIGnaPnnkiZG2LW+qDupUxI/dOaB15TQsoQ3iM+Aac8ZzCFaxuywg9MXmCxWZKjct3MXMSmYbV63T1By/IJYNvqTgW0WrEJLS/Gx4t/KeLR/xvwSv2a/gB9g3AQJSA7QiqADzrz2Hvho/KE2NVJv0tRGlAeWbvvQD9r43t493JUQJs9r8Ub34Jp4ExN;4:Z6dVbU3ieHqHsUdR6/+ywXYsxILCr/q0LuGc1fAL3KNR2JDQIt+4duWitkd6CUahd7W9tWegvz3ie+z+Di0+BfyRFQdenWbiZBDkyddbKxei3x1lCQy7ev04sn7rFnU6CeE5gJRp9o3AXlGn1ULmxb5bew8SvQN3Wzki2diLZdDoNP53suepuNmWqYgX6WILBJrG8zTmQuN9kEqYChjKUe5uEKwKHHBBa1DF2VQ/vnGh/Ai1/JXHG31z9GrhMt65PTy4V15ZGNflqDoFym75tjJcr+g3wuozYMmGCZmET8efPsOnVrOYYa2Nvnvo/dME
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171EFBDBE48D48863ED0F21BE390@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155532106045638);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(54094003)(106356001)(97736004)(52396003)(105586002)(16526019)(186003)(446003)(11346002)(476003)(46003)(6916009)(6246003)(50466002)(486006)(386003)(39060400002)(6506007)(53936002)(7736002)(305945005)(6666003)(76176011)(47776003)(52116002)(478600001)(25786009)(7696005)(33656002)(4326008)(316002)(54906003)(8936002)(16586007)(58126008)(8676002)(229853002)(81166006)(2906002)(1076002)(23726003)(9686003)(6116002)(55016002)(68736007)(81156014)(217873002)(5660300001)(86362001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:KT3LZinAAqy9KjutkSgZHkwZW1oeqiuQZ5n+nzUc2?=
 =?us-ascii?Q?cRdySFe7+KuiWu6KMUqF9mjDab/UmpdWXY04FZWUDP9V8o8A2AqSZiCD3dv+?=
 =?us-ascii?Q?NRK91wz9B2eXLzzrYJQDIiQ3rp8AB9cdTpChl58m7o1IhccnJKrsGvj+0H2g?=
 =?us-ascii?Q?anIQ9bR1YLbM5OI3QkNxmvc68TZzzPLA7K9HmdPxIsAX31JNpqbpjm1DZL3g?=
 =?us-ascii?Q?Wow1XDyjh3reFMICa0tKfLXi/KfrDx8eJ3DxDW79TqWhEkjMhd+hHmG1vngY?=
 =?us-ascii?Q?2SL6kDM1xVMNJB0TFmjPyPxofZA6kRXgOiNETcHK7B4V+UcDhziGUajWeQ/g?=
 =?us-ascii?Q?igakbakOrYt4sqMEIRTYg3dSgwJ6ZrF/EQggUYo6cp54cDp1spOTXwxhugJg?=
 =?us-ascii?Q?fs7nN4XHgwYJ26+f1LnDQj96SzY4i7aOKFuMuYrYVxNS8HYmToumrVresnwg?=
 =?us-ascii?Q?W1RI3XLjEtvnj/hODTWIWyy1fGU3JOhJ6+beA8AoB5OX2F8gGBEo3d9Dtxf1?=
 =?us-ascii?Q?tRWu1ZbKiUp67jrgBj8z8Pe5SP6ywLKa/eTp30C+h0nuzbSjoPVUpE0IKtUz?=
 =?us-ascii?Q?gSRIxUu1L/OXsaSINIOKon7tsL6pxENJ0SINo48wCde38sDin1U2Vplz+HJN?=
 =?us-ascii?Q?X+f3EawdJrdKjdVUfJ8Zk6ZmabaccFjnPaH/Iam+6ZeE572GiCD49HKj3pgD?=
 =?us-ascii?Q?LeQYNd980tOZ9eA9sBxMxaTss8PVZa9I3qCBUHJzHwNEi6j0AQH2UNa0498A?=
 =?us-ascii?Q?Hh4TFrwLhugam1gbhoshsVR9edrFU9AYBEXRbJECPwWFVFEifLoenpiuLCkY?=
 =?us-ascii?Q?0P3I4K+RTOhM7e1yZuQii0zaqI1RChPik4EUFV4Ac9JfKyYTIizU9cnxKK84?=
 =?us-ascii?Q?DLqKWlPmWghc5pRDHG55hu1VBNtwf5nZn9U1HrCnGTBrh6fYfmAA7b1R/LMI?=
 =?us-ascii?Q?X6M9zfow+jtoJtK0tNSiDmHQwaOlnOc8L/v2EBvVnzeorxCxye4YnlygMIX6?=
 =?us-ascii?Q?OShy4LYVdJCOHBjmHEQESXBNpbMro2uIF01QjiUEzRuWAF37ZFr8aF5/UlNb?=
 =?us-ascii?Q?VKncImZQhJs3uLaUe8Gs1WIK2NH9HOAvhUsoZqZdKpOnb/CzEG7UXg2AGyr1?=
 =?us-ascii?Q?xbmkg1FEdwrMGRINRn7Zr1h1Kozl/LnEgyPHjNn6Z9RfizQQv+85jvEK91oK?=
 =?us-ascii?Q?CrlziuRMWrBctH8LShi4mmJROXcTWzJ64kCPtaDoMsBTUx1GkYHmuJOFcdCc?=
 =?us-ascii?Q?KzYI4Wi1AK5Cs3KXj0JAIUp+Kpofv3UpNQjcVQfDiJSLPpYOYhrNpI4h9SGD?=
 =?us-ascii?Q?jN6bBt1fDsiCU0H4VuYR28=3D?=
X-Microsoft-Antispam-Message-Info: PSHxXOU3cXipM2pu/l4Alj827AcPRJb++Il+9NyJm+CLvK4PxlmrJVKofqkrTbgG8fM9f14Mdt0hqXt3m4ZRt56sNoHPu0m6rnfTU6+0dznod6eViQPDvwbIpswDU+twlksPQdxUolegzAOccisC0wwSnPAH49xFv+APhuw6/lWMKJMqE2OSBi0VlVThVf24unZCBmTM5BGhPc65h9JnYIwsGAXmahQfNj012CJ4z841uMvQXgxTdeDy7R4Btnvk9d1uGlSlT60sF4y4LcgZvwyUqT9Zck/cGno6RRoRY2LD0dzxMeROEWAuV20YP/SATj6Gc1bdy0arlHAD45FUVDcyANRQe6JHx2rpjy3C0k8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:9RmLrbHY80aq5RfJbyJ/ojvojtxcEzfcZAQq50mJe0vpMZ6Rb4VeNpnxQ9caGanQPuK3+2xG6E+XKeyEWFkesy0VGC8DUF6qZvcPSNG4NrQ9CJwxC7jHjZtTmcdo9rLlE2u5BZw8/p2lUqTRJ7akEgY47GdzbWQCPiaFqRgnFUfy44ElRocw6w/TwJy4wKSRGT+CuN50moAAn3rgAGcQAnUhNR1YuJ3PrW0qCYRB5totd1e3XluNlZudLXwHRF4FV6V7WcDhMO3pJm3RMD1Wyn/IePrn9/8pWNHr4OhmLfnRMv3Q9okW/EKB0IEBzuWLWbxoJQaGppStFS/X7VtYMzuHxEQoODsqR9b0z9vMgKaLYg1hn9HziSJb2d1WgXiDn2CUQx/lr7c8sYEeZtDeL5AlfGU+oW4jAwMV5nfGPk9tv9rxAk3A5GfpadjktivunCYxSKTQPEc8A/nOqlCM9Q==;5:Kp1Wd5TemZJPpaCdsN/dPPclBbCADlnb9BnYQM7NoLGK/Diyu3s2VYU7uCMyjx+MY4Icb4Db5sI9t12a5qk4H+MGOtyu7BG11IUre2Iyj1FCZr9vBOfC9tNJbzcTSDt76LoUZam7yazenCERb7AESUdRwwJK5ybPons/gqMuOuE=;7:F6i4gpN34on3fVOs5fQp07nEn5WvxAq6K4j784tg55jEFs4ij9EWSScn3hN9s4RuD6A7XspimQN+TKXJfG6bbIcCOgInIW8vdkGWfcR/WDSFN32mV7SQ541f/kWzPu25SoYS/sYINVSnBDYt/sHgs7a5XIVoBarCARGZ33fYLpUOoJ55L3VkKg7pCWtA2ca60dQDuKjQIfvfkg+fciNtGFe/lMkRTq6B/mc2S/4S0KY474MkXTHPjJ1/ijj7N3I8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:qSHJV8odaSUgGHJ8M6uRT9J2oMG25yKupMcA7hhVDRXRKwm0RdCBU9zrYl/xNwEClBVQ0tdEk2gZJcLBi70fMGeEP++bd1IYAxIgQJwkZjDfbmi9UnfC7ua+oh3vYaIKXK/lIXUPOlQO+61ETo8C+JsRI8m4Rp4S8Njf3IcmJD4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 17:54:03.4981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefc59e3-2f26-4a08-172b-08d60145c232
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 01:11:19PM -0400, Johannes Weiner wrote:
> On Mon, Aug 13, 2018 at 06:48:42AM -0700, Tejun Heo wrote:
> > Hello, Konstantin.
> > 
> > On Mon, Aug 13, 2018 at 09:58:05AM +0300, Konstantin Khlebnikov wrote:
> > > After removing cgroup subsystem state could leak or live in background
> > > forever because it is pinned by some reference. For example memory cgroup
> > > could be pinned by pages in cache or tmpfs.
> > > 
> > > This patch adds common debugfs interface for listing basic state for each
> > > controller. Controller could define callback for dumping own attributes.
> > > 
> > > In file /sys/kernel/debug/cgroup/<controller> each line shows state in
> > > format: <common_attr>=<value>... [-- <controller_attr>=<value>... ]
> > 
> > Seems pretty useful to me.  Roman, Johannes, what do you guys think?

Totally agree with the idea and was about to suggest something similar.

> Generally I like the idea of having more introspection into offlined
> cgroups, but I wonder if having only memory= and swap= could be a
> little too terse to track down what exactly is pinning the groups.
> 
> Roman has more experience debugging these pileups, but it seems to me
> that unless we add a breakdown off memory, and maybe make slabinfo
> available for these groups, that in practice this might not provide
> that much more insight than per-cgroup stat counters of dead children.

I agree here.

It's hard to say in advance what numbers are useful, so let's export
these numbers, but also make the format more extendable, so we can
easily add new information later. Maybe, something like:

cgroup {
  path = ...
  ino = ...
  main css {
    refcnt = ...
    key = value
    ...
  }
  memcg css {
    refcnt = ...
    ...
  }
  some other controller css {
  }
  ...
}

Also, because we do batch charges, printing numbers without draining stocks
is not that useful. All stats are also per-cpu cached, what adds some
inaccuracy.

Thanks!
