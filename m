Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA15EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E80D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UgSnZ61H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Xn9eXw4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E80D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeH3BXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:23:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727507AbeH3BXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:23:30 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLOCex005535;
        Wed, 29 Aug 2018 14:24:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=H7+9ofGwzEYycNhsq9ddhrfKMeJyIukEAGwijh3Lt+Y=;
 b=UgSnZ61H12veyY8BQduJEayDZBVZCArTKLX8AGts06vpJL7KZZJoxh7dRssvjuBYRfJa
 d8SSdH8goM6eIVGA3zBvbt4ObYncGWN73gEg5Y8mY7CDUyHMHl6SsP8bCIwSn9AFoBqV
 uUY4t4UWI9BWD3Yx+OaWJTj46EEXRABd2js= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m63cd801g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 29 Aug 2018 14:24:39 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 29 Aug 2018 17:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7+9ofGwzEYycNhsq9ddhrfKMeJyIukEAGwijh3Lt+Y=;
 b=Xn9eXw4H9K7Omc3qQJM+FALwAco93IgCVUZbaZ3WyJlKdH2d0r1XgITlf+YepFQvu4CbB5Oc190F/xdkSJ+YpsB/vCO4KG8w1XIHXSDNNIqZ2qPjxzkzNwNwSG/Fh71SXkHRKOJOU7KcLE6AZ+5Vp1Vis3dzZ56aJH8zz91CQS8=
Received: from castle (2620:10d:c090:180::1:38bb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 21:24:31 +0000
Date:   Wed, 29 Aug 2018 14:24:25 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180829212422.GA13097@castle>
References: <20180821213559.14694-1-guro@fb.com>
 <CALvZod4HAf+iPXQx1v+dwJkTph3ySAiYo4kn4d2jRFNQS59Tgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4HAf+iPXQx1v+dwJkTph3ySAiYo4kn4d2jRFNQS59Tgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:180::1:38bb]
X-ClientProxiedBy: MWHPR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:300:12b::28) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35f5f8f7-f032-4e77-753e-08d60df5d01d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:FuQiVzMLurjd9g6PnaER7DBdyLtHjg6+jW0V7A75MP33OlITDqdvbUTrdpbPdHVXp1NauuwzaI9JUZpdCmhPVSuzXHJg7x5yIGimt5WBzQVCbtQ6wzdMisYRJiW2nbaBxXIoa8jcw+UccwJe37WTk0ou+XYrzKW1GLkJlJFl2Mop4dBP8I8x1LQazgD1rNSjyDLHp+gsDIXpXGHus20RSqtYXKH+dyeEZtbGeJ4UXF+xZMVtWO8oHQ6bKKTNEAnC;25:CyYT8/YoF40BBkD2+DizHCeZ5tDrqw6lJHEmTObkO/t+aM6akv2ER02EldedGxgANOqrDuxC1BuqpNIY2PETL/9GuKYS9DOJzJNQk8UrBEAye1GNlQFvi8oCgNscl4BCLWAm55QWz2GnCzym6mX/5m9vOm2KXkvxQRrhkSuWfsRRyRqWUPUSicIZYHd4fEFwPwKHJjVOyZXC59hEWWTDZlSsEviqAdOHH4Sryx2F78qo1UgVQrb8StDxQuxcME5Ef3sTGr9P7TVzfEJGSMYe95hwydVtGg1t4sjW9fDVDk1ZrSTUgy/+p5O1/tdIv5qhAmoJDKxb9o2xxFlzi7AXsA==;31:+rnIM7E7fDTkULCPwc5uIOu2qiucgsL915BWWjgY9krwojRQAvWylIKU6LVRQsTOrZ1KbhIfGVkhJ55Wvxzloz+fPwLrGWvybpWXYb+Dxj62OzIC/nzP1q7q02WdO7qXSGEyZ50e1ZxnIK1NxeEqln+bBHV3ucmxhqLRUNS3jWGrFSKcsBsETRgc6uE2y4VmWdE4pbgcXPITPf4TDPZS9QujhQ/32VZBscBdT0Nlygc=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:0OvrLqSKn4DWsNM92enRPPPlUq4zx3oaRiHstctFVTmrh91paKhChqqB9iAL7ForssTgp7aViHx5mA5ZK4iOCpGjVeX15Nz6YhMYHFUoSBlGWsYY1gvhoQgaDSuEwFAZcAbNm6CZZ/PRndL0fDPwckRV8/9wFcx0/EyA/DcAd4dNTcvfUcTdxapn+tw1zUryIc0CUTG8W4kLN5VlKRQKF9nFIznrSq5RggHLZom85sAUPH0B7GAM1M+eH5zTXlIa1+Le2JI2AUXw/8shn4sMr8/vJ7p8z/q7dnJnf2Y7+YKxy9hRYAvGuMwmT0Svc+afW2GJfavH8bE5WGkfpT43D2csrOUHE+kVDr+vCrnCsgb4Hxt3qgbehMQXcovB36KJIMOKio3p27aUQ+yqbDEyRi8/q73rt/VDwsCsSEtLU0u2+JIsYdSo//C4raJtyk+O33tE7KH62RT54qRUK+lpVEhAbdUIx7xvVttNixd8mWJ56uKld5UtRaxm6E2ywdvO;4:LKkYBN4UdyBfYKYNnlGEJYkA86rIKQmSJuTE08thQVt9F9e03UoqvraOXrjSO5VKdw+NhZ13P1zwKn/sBz8Ma4LfvaIgz4U4U7Vq0WlFRi/F8Id2hspkCcd/nkOtEcbrg7PXtEOSmdO4qimP0WbLGS30YO3XjPrPPudjgFu3VcFmMM7F73qVFbSYotBys02Z48eCVHdye6F/0p/sTlkaLAxCBlZfIWUM7Jewh+ib2OLpYNi2rj8R8zp71NMJkgoF7BJdizPoUN8aANnJYofpxh6bWazrCpYpnQ9K+S6KRT7QB91qa0UPrlsoE0QH96oUVrjgalPMfXsSzxTMAUVI8c/U1bKOwK+R7u87INeOTl1wq2MWGndXRVbPOD4k+kdg
X-Microsoft-Antispam-PRVS: <BLUPR15MB016265B0FC665D705AF1002DBE090@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(376002)(366004)(346002)(189003)(199004)(55016002)(15650500001)(1076002)(54906003)(23726003)(14444005)(47776003)(316002)(6666003)(16586007)(58126008)(106356001)(105586002)(2906002)(6916009)(4326008)(33896004)(53936002)(5660300001)(6246003)(229853002)(86362001)(9686003)(39060400002)(478600001)(305945005)(33716001)(386003)(76176011)(46003)(52396003)(486006)(6496006)(8936002)(52116002)(25786009)(16526019)(476003)(97736004)(446003)(11346002)(6116002)(7736002)(8676002)(81166006)(68736007)(50466002)(33656002)(53546011)(186003)(81156014)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:lpwhzZj4l5KB7uoyK9oF+H2AOmbqJkgCAVN3LHa6y?=
 =?us-ascii?Q?3OZGgiMpMOY26jIc4pij0XEKOfdOicJWAq0unGOyiQ1/rBlYgBDhHTNDQmgY?=
 =?us-ascii?Q?1CpzLK/0u9WCtL5XfD866sTEJAyOzwj7JOYgglYFJ+wfTiEzPoV783DxC6oh?=
 =?us-ascii?Q?PHAFdXbHR0MjjtaCkoYTGfRzmqG0Lud+8IMP0/e60s8fwrgQOpKlUi1HVPud?=
 =?us-ascii?Q?kQ3jLQ+OJb30lCaj8J0HoivPvxtDM3PN+nPXc9AF7/MBMXzDKlLhTiDKOvLv?=
 =?us-ascii?Q?NQs6D7nbO/ovCflj1+Sg/brEZMcLLXluGSDfUZCx0mpWnK+/zliLGN9Csg1A?=
 =?us-ascii?Q?a9Rg2XZ5bI3p+LbGi3yetcRBcgDKuK7n0U3wRZDDbYEUvlPav7DJKE8RQDip?=
 =?us-ascii?Q?Yfr3KENB02JIm4rPyc4azZJxj64zmpqEArd0yYKpdxZJkP9n9iZ+YQSNhJat?=
 =?us-ascii?Q?+fv/0Z8psRnffydSrDKBGPSHhunA+jw8FO025j7rSZbNI85JGooc/16wq7wC?=
 =?us-ascii?Q?Zty7vGaDhdhAfQWsQK7rDny+gdeTVMviW8goZiUEbuFBp2yeDpJg6OixcK/0?=
 =?us-ascii?Q?WpocFLBcPYgUnyBm2brVcWIv3I/TvthdGDJmzsRF9lmlvt7zCQh/0PmILOZ1?=
 =?us-ascii?Q?SW9JHYzIANg4pUnLImtEEccIrvRLIIGIrAILuiErLHRATLyIDUN1te08ceW9?=
 =?us-ascii?Q?esoa1hAus2lv4UbPWq30NVV6zigadF48CVPOjXZWr+P4+32QmbW9G2yT1Ana?=
 =?us-ascii?Q?6YF+cAoZJiyrU1yjznkuBc2e56SyMkPpRFeztl+fm2ZsLONgVSnf3eXirvuY?=
 =?us-ascii?Q?oOP79PYG+l+RCBPcPPN3kr4/gP2xx062hKYs6sFvmTG9FLGkdMhJaWm6Dqdd?=
 =?us-ascii?Q?RQ/UUKeniLnVem3SnNGuGaITvl6GTnriiPRD5u5fTkYPkjUdWoC9tU4MZp9Q?=
 =?us-ascii?Q?qC2P5SkbBt7m4qjEChgKO/IzwkjGaIjeKf8R3spfDSBjQzlhNn1hntodZY8q?=
 =?us-ascii?Q?aDESSRC+gim9KXm96GkGM27eouZy15F8jOYc1YYPSRWDxVC5y3GIZtTY4VSa?=
 =?us-ascii?Q?alVpl8djcu2IoaX80PUanmN5X1tIH+kCRlVhdIH/DxNkFRWVP/59L7uvUKsj?=
 =?us-ascii?Q?E8jp2jmbMfqmhVDvLYcKRT9sfxtbZeeh6EfeqP6tTCVjHtKdYsrJt6xAfFLO?=
 =?us-ascii?Q?8M7S8wZpgpQ8jAGCcy82wq9r7mVZ9IsW6XrCO6QBHJu16wZEKl35Ktg547p9?=
 =?us-ascii?Q?SKh+JDg62nsn+0k7MaPKPD965u1ZmVVkXzJ5xHwJ7xSo8YuJeD3iuUVgUS1r?=
 =?us-ascii?Q?uENtRQ+bpxcSwITm+ERQ9uMnbwDeGYcRrXD72B09WiBKNA7uChQNWiHKAv45?=
 =?us-ascii?Q?v2zaQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0txjlUWlCc6mqyuJnDU8RpV3pJdo/M8UNIlmfAwfE+n2YoNFJvYP/xZv/3L+E4+Jrfq/dkQluo0QP//4nA0U6Q06lGN6bBW1gpxqdglf/sFv3CT4aPzaHf+CpK5003615RDrz9xZJAuYtvsCX0RmGuVjYnIMItnoJcb5PvyrH7kBE1FC9q35c1CALUnYN68pMIQcSXa1bhsypBA9LjCylcLXc9MPijGzWZX2rOzEyrEP7HQDAyfICwbXNzaWQafHNB1I1cbIpwClCYOG9gRMPE10YDKWHP6xZb1BOQ6WEfF+cHLOAXhRoXBpW9UUTnXQgqXUGpdVI7opFZUmsE06hoscZ8Y1wtL7xlrT5/CZX7Q=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:4gqr/pJy6ISZmOh7chSf4Ufpi9FrzMjwA33Bu+9xX+Y/Sk6pBN7RoqsskNnvpD/aY7CJmuYUjeMS1Y4P14y9SxXCq0xR7tMqgvrL0XQiTOxvASqdfQQjjT3FxmyLRNMwbpWz0UP3NVmZwjV7bxQpAAdr+se9kYAL92ao9Q9dgRhkk2CxYuXTkq2GxRl39Z9UdhzGR+VVBLyWNHU4q2MCkXkhdIutSwjkuRpZ3jbDWWp2vOjiJHQfPD2q65gsWGQscO3Wg6YvfMqtMFo9ROux/AckoRkWU6plmJflCLpsQezcB4uMZJKe6V7rNJTMV631omnaHjsI3argmiuoAtq2SaGrVH9h8WzvveIfac3w2IcLt+y1hPqDpKEG0G0fVUNsBIto/x2F/yq4AFFy8Hj7mS3llq5nfbtQpBag2XTvyVCASbA++tj5RMEwF5f9eZNk6kZ6TZTI0yNML15DxBi7lQ==;5:azFS/IK8mcvsLFDBIqcUPzy4+i4B2vVcODJZOtheA841sHpNgy7QScYIWUBoSmDYYfpFojZwA+iChCUepbNsiYX5fV55bsq+g08E7ipnYb9ZAiGdAwRAeGdpJ2uULCNvhvFCmEFCw1/7ljcJQ0X4ZlOvRzLWbGdiFcwgUENAS28=;7:QX8xOSJooTBjbuqBejfwmmDFD3EqvtsTSJqv31aVNxjpz8NodnqCGrx/VQvmrrLOliVdoY7qLJCvG8b6FPOWpXknS1y/fybaCZy5cadPrTHAuYFuNqUEEURDSCTjyrGeYusOnSzqT/90sMBdLdi5LLg4uBK5rxb6KfNxs6DvQpDKqrgyBjLeqcfENQDDcUFmtAGdnHDxpJoI7vQ2OH4nY25o00omNELqgn9Q/v4hlWJKATUwCbDx/NKjoXft3+Qu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:dcI19Ep3pGIds5bJBENmqaxAXYsbZvIqhJV6b+KajKLiHD7a+kmVIJCpkfcqyFXVrrSrKAnShH2BNPwbAVGn76CGpex7+u12R8vT/E2nXyMmUoPtFUuiDCgfM2aQVNa7xuFILwQ39Htg6G6Ro883UXLqJfc2DHeFg9PhQ0K8Xk0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 21:24:31.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f5f8f7-f032-4e77-753e-08d60df5d01d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
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
> 
> BTW this makes a very good use-case for optimizing kmem uncharging
> similar to what you did for skmem uncharging.

The only thing I'm slightly worried here is that it can make
reclaiming of memory cgroups harder. Probably, it's still ok,
but let me first finish the work I'm doing on optimizing the
whole memcg reclaim process, and then return to this case.

Thanks!
