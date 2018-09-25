Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C01C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893492098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nfwtgeyq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aUp3y9sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893492098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeIYWHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:07:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728598AbeIYWHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:07:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFoJcn004745;
        Tue, 25 Sep 2018 08:58:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=X3duM0X9sST1tgxkRKaspCYbp0k0cfy88zLF670AxtY=;
 b=nfwtgeyqWwZfKIHIlmr8okUmp7aRHJ+tAK+gxP8VvTU2MHCWbltX3hA5Rlca0zjxNITL
 Xsrp+9DdOCOuOBzwxjYTVEp1ApgYIO7TIJAEg+HuD69uTjlHFt1iInS4wsx9u/sERBZ7
 EJIP29oqIgz66SCTzy68Z5feZjMbbGOUGE4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqpp20dmu-10
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:58:58 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 08:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3duM0X9sST1tgxkRKaspCYbp0k0cfy88zLF670AxtY=;
 b=aUp3y9sh/FEEexm8aMykY3D0DPxDRs5WYfc1ADMEp1HkbSqwr4QjbEdKGG6P96mgmHUJv5QY00vzvF6bFFAnkO/oRQlRr7nkteJIBh1G5VV0xjhcq+d9ghnIZq4vjRZhVlWg8Jo45GyimuQY8h0YB+Cg7NiVK4qMSM66feVqhY0=
Received: from castle.DHCP.thefacebook.com (2620:10d:c092:200::1:82fe) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:58:37 +0000
Date:   Tue, 25 Sep 2018 16:58:26 +0100
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RESEND] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180925155825.GA11552@castle.DHCP.thefacebook.com>
References: <20180917230846.31027-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180917230846.31027-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c092:200::1:82fe]
X-ClientProxiedBy: AM6PR0202CA0050.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::27) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96b6e20e-c901-4487-72ba-08d622ffc260
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:9o+5P46/cViQPK996DBG1OSYhxPCUKe100vgNZPJ9I9brzFMnHdba3RH9JPUy/TvlnZreoeNTB+MGshSGx2xyQsCa6vKqajjFeNQcDpwEPBpTBJv13w2dkX5ks5pVZjS/jUqX1IaooRHNgRgJVO9IB6mGWAYmNTHbL744HSicAKMgDuM3yjztHHIRcg0bmO3uNyIn+n3nMXZpoUMc3SYGOuzhDBA0CnyQoT3lSWmwQUyZQ5EBR5GlM3950Cd559p;25:7Yp9diplzZ2Wa6ZK7jmvDnxaCqUZDU9seY587fctsuIF1aaDZqC1c+3kyPqEUrNOfUlN9zfUCTj8dVINzc9ssIMdmCA46HUsJSHOKUMrlZuiXW0HsZhcvDwBP1TmV2vIyOTp5ngYL0BfDO4fOgPX04B6yJaUGRnIg03Q3snZmBBXbHSWOWn8YD2CXxrTZmm7mrz43PXr30LNX2kRzG+3mlhbcLNYBVxdaXT3/rSeSymrIGjqlc0ucTfhrzzQEEPhjpg0v+erYHFEPUdHnXqbSW530VwZvPuYEl96hByZ8oU3JmQDAKcBAsBTrIHQOeDVwOfj8zwAi+ZJeT+aWKwYZA==;31:3YkSSl7jEZ3idzUQFmkW+OxcgJr2qVAQ/Hm1rFXwlXJflGs5Iu+iBiyWh0JdobBlud07ONukZHvF03oX3LMX+cMhabrIttgO4YA331ABuj8PZM00+L3RaFNgZZr6EvLdroZSjkrNDrEygYhwmiyrunNy9Sy4ve3quLzi5rAAnw7V2Agmd27oubc5hQP9X9cQMtoMAyRngsUI8VhUZACZ3PJEFnIEUO4lJmcHJkfpm/Y=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:tQJ6JoJKNx4CylaQKTS9ctw5SEDkK57zZe3DSr3DLIHT0ah2nqLDczSHId/fe+2DuCjCQqW0l/obUt04Qpv+BpX56smJjrSjkPEwH2cGjoRNo9C+LUiGofcDPXq7njfXWdBvBzbiY6CNb5bse0Gh++G0m5+2dKhutjz6flBJVOgWYfOc1ZCQbTicVj1TJJnDfwKZJO8eIPYUV/T8hon3X/SNV+VGuqsPQ+kdcoMvC/m9Ygd0DSFWXinEcjqbzR5IUGP7kdZZ7zVqZ1s5askOpOwLgkM1G/8xEBeQ8vCpPYKrP/4F369wF8t14hS2l7aJ1wQSO3sc+c9PPQfmw+83nFDyZfX1Dh6nRQujEZM/pNzLP1qCbF98tvC/PKBkxY/FOgxH7tnm0Ek+mD9YrT6450PmBKlEtZxO4JXvwTGcYGd2P2yTfWnHHrni4wZQJb08cMwLdGqTaTdCNejhxFo3qnG9BOWtEIMH9arhiIdp4N8FJ1bWM/dVGpvQw086ewOu;4:5uAjdE/us1iMiuHm+2YQNsP2fPVOvSr1StZds1aK4wymCIXrcOUrJ1jmTOC07kY85Y7SjT4qhJnPTGWRlqCKFOvD36WV+vIVSc1rDM/HOo8lV0Y46sKSB+oKMDBVCZUQAJaxNrHCBd2BSpw2v13vo3an1iCY/mbnsIaqbqRwjcSBrDXAirO2DpupUzEMHSa6csukl96ubxlmvFoXOTHjMypzzVwh9VnReFYHL+3ZqNlKAxid45bPlw1V/Unn08aZ7k9NcAGGUcVg1MtU9vr3DGJSZipY1wMyYbt10bfVK8ebsO6+V0TL98sIK685ImCja4PofkWLHj928U+epDHU7fU4OVtkWf55xv8fTnHEGId0Cd2RmoEKbOu4euOfuALNJGiUlHdbV6hebGMS96l7Gj/wn4xxe7j9BThUyRT8DBM=
X-Microsoft-Antispam-PRVS: <BY2PR15MB01672F5B0FA07D6CB204A539BE160@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(52314003)(57704003)(54534003)(189003)(11346002)(6916009)(97736004)(55016002)(2906002)(1076002)(86362001)(6666003)(23726003)(14444005)(5660300001)(53936002)(50466002)(34290500001)(6116002)(7736002)(16526019)(186003)(316002)(9686003)(305945005)(8676002)(105586002)(81166006)(81156014)(229853002)(33656002)(16586007)(58126008)(39060400002)(54906003)(25786009)(47776003)(4326008)(6506007)(486006)(386003)(478600001)(2351001)(6246003)(2361001)(46003)(68736007)(476003)(52396003)(76176011)(8936002)(106356001)(446003)(52116002)(7696005)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:bjTmpUB8bmH9or165i3/84Kg4hyxKhjohE+KF+Xls?=
 =?us-ascii?Q?TcrXtwSgREVxUASZT5pKqlZ7s1xp3t400W0hs3b9ILUl2JBbtmr1uwqz3s0/?=
 =?us-ascii?Q?D/psKRiqZFINhptAA9ViemIaoluMDGXXReHonJhVkb99eCGm+iiEBVUUvhxA?=
 =?us-ascii?Q?heyyeSfFn+5xMnNlmWqH5AfV6oY497mXVREuilHdxrvZX/JL3naUdZxqJb9c?=
 =?us-ascii?Q?Gph3+KwFU9li3cTnXv0j+/iSFOLLN5klhLegmNXS1xLeJpNbwmmmwnaYSOwq?=
 =?us-ascii?Q?3YSE7ASpYrvRPJLC7MiRwzNBJtFgC+LE3j0X8/CZkKSSeLDGyzvHNdHM2Yo5?=
 =?us-ascii?Q?M4bHM8+os2f9h4lc3Z9H90xBSCnY6VsLbw5A9hy/FrvgsOx9TmqIsmJ9HSXT?=
 =?us-ascii?Q?6x+edmHHOIY1oU7KhGsHIByTdc6p37TbQbFMhZ6EydM3nBWER8XVJdC2j9hy?=
 =?us-ascii?Q?lP+PTpWZv7Mogd+DaedzBhJp/RHt5gRlVd5SZiWOQ5BDcRHN9mRx1esg9TlQ?=
 =?us-ascii?Q?ySgrkUM++10cw/QLD613LKVws1/+QOXR6kcpjb6UO+oW9KUbgFPdxL0p/DM2?=
 =?us-ascii?Q?Rmd0OJW0Qb60JyrR0Lk/opTKh/pIOKtS2xGkrT2Q4sL43UJM4BaVqvmHeVjH?=
 =?us-ascii?Q?NQqSTg8kt13pTA0hGd2fBYMmLx/xxCqPSqp6rjBtNH4nadGOEDTVqHDZVAhI?=
 =?us-ascii?Q?XE+xru5o6+PFGVP86KxNAu/M/ZwnwsfUCyaTyMq8sKocZS0QPgAjoHpNqZoU?=
 =?us-ascii?Q?j37H4p/XoIbfU4gBf98Iq6hxjJvgHJIwr7zV9nqS38M4SF3yN931OjKPt29W?=
 =?us-ascii?Q?3lBfqu7ge3L4SjYQqtCfDnq26SKXuff4bF/+yPer9XDJseiqbT06ohFiMWWq?=
 =?us-ascii?Q?QECFL8NDUwH5b2Pn05+xwQ8RBD6p7ylm0Lt2/IeA3mdBLwRX8uxorbvSenCu?=
 =?us-ascii?Q?5ikOGd5b+F4qtBwIp8VPQyBDCxNlzTUfRhRbDPKMVcWlpum0z28eUkTsIoO4?=
 =?us-ascii?Q?Bqg5hNR0CMejIl4dEB3bw791TcaV7SDduuYhmCDsbVcggS0d1Rj9h92CCxKe?=
 =?us-ascii?Q?P2dcAWUTugccoKBMpdwpGVLBoUQNBRGlItzQ2WRs7VNc0yowzHD8lLAaeaVi?=
 =?us-ascii?Q?PcG25EFMCA5jefja0tsqHVofEVWzBjIqeEpUn6e1Lpc2amJTIc+dPxwZHvJL?=
 =?us-ascii?Q?l3i5hvV4VfSPlkeJ3DKWo8Y9fgwampjcv1P2cnUL88FQEBTHUvsgEj9i5VoO?=
 =?us-ascii?Q?sPwpog/YzYqC/xP/QkNiSLdMROTAqeM+xjEHzY4t26i2Nde3A2BAqWk39ZqL?=
 =?us-ascii?Q?Ez3qPykl7Fbv2gjSCLTrt6pSQc5WvpypK4cBBjDENqjt/fQ0x6tliLdKVD2B?=
 =?us-ascii?Q?83axt8AQJpNpAgeYm273WokO58Wo7bUPRlkmN0McXdK0i+N/hH77IvA5jvfK?=
 =?us-ascii?Q?N6EkJgzOA=3D=3D?=
X-Microsoft-Antispam-Message-Info: v6hr8iC41JmSXENpXO5XaIk3vltNKCkD8vMYvLscW1sD0/MNVrCZTjdawwBUWq1n00h+2gKoouuIJM6AQkzvTknKEjee+OOQsRH3usL4G3pdnV4Ix6f7gf7zTb8aE83/CzQpKcWBSWfkPspinSQKf+K0tjiShr/lxVWZzO1LC09y2KS2vYFfku/I75hv7rQCod62Q8SLurbfQ8ssE/StumPdyt0a1NNZwpJjefBxs0SlbugtryBypMrDgo2zIa1wkm4ae8e5t/nv/MM4s/QZQDgzXyEe4HFILREpVxDNZ7+pE6dJQSzLbgV5bfcUQyCiheKHJPwmcai0BMohhin5XY/WE5z+Jrtlw+my+ataMZo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:1ktjm7CdEhVZkVi7BjgrVZUiZSjLfOPcVIElOAVJPzUxRkm6HYFZwk8ZlVjqTfVEVx/hOOaoMUioBnwHCcmhTF9qiuwTd2foQNVAgUP3/qIXMJ6S3oR75DjGUeatcW1fBak8YelalJSjeT/j5O7V7FbwtJ7amegu97FPj6BrhScrXkAmttr1/7c7Q94xbhmHqq68qsoLcwCG8h6HKxoYP/dfkkrSLXOs2p3wjwHEU2/TJ3+RmDqUa9GDytqJoGkFtY6+gS5wk/U2YN5oEVqGXGTEHMcDygidEzUd99vt0KdraILufhLJOUGdhATE4+Wpcj/ApRip0TNX/a0U+Eupms4v9pB57W2l/ematGbjAp+O1LHoIUx3M2oGVmJCYxifqsL1SERpCDQuM7n/CDAZi+dmAzAdalmqJDXVkOgsUCblL0lY7YE3FoIEzvRAZE1cagkjAYBudUPckNv3R7/xRg==;5:lf9bOHQivI0Sw1ywO/s2Sfy/1S5V6DBpZf+qlpZToso1DyBg4hD56UWLIktrVxq+Z/CQ/LTRMsMEsW2avz/d44NuJFkYly73JjZEXDmi6NCJ8QDwyMsGRJv23y+QVmYUKykKhszKExKvzMLtWyI9cdMpcKDEAdc00wbLOzO03d0=;7:VC4Vm3B0iRbOrobjKfqeaBVSGmQNDeWN9Bw0g17YYhYolJhKfPz8em5vFt6vQG5N2r+Ze9WHkcNBfnwEfoDDlEAHrJnyvZqQamdgUxORKtuyr1zdpoHULOpoQwv724FRI2Vo27TjjL9s8sXLkOlnyHawDS8rppgDJIzg3hLO98qSxJKbHXWG4vtLhdmhNsDwOussxFDOkW/4uhTXugdKsxl3wH6cY1zJXVQa42JS7F72kNbBI+rDyJkEjNpOUNgR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:LSQ00eTUQi2fPH1Tk3dmwFC0qWcW1yesqkzsK6mev+olWT8Draq1FiaSzs+le1FymjJ7s4M6IraKBEpdmHyNFbi4T8mQC1/hn5VqAls49z86e12V1Q2vyXUxCi+7PmRC6HVa5W9SUJAqnRW6GHo3ofOijUgDpa1yFyTdgz4SvYo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:58:37.8416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b6e20e-c901-4487-72ba-08d622ffc260
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:08:46PM -0700, Roman Gushchin wrote:
> The memcg OOM killer is never invoked due to a failed high-order
> allocation, however the MEMCG_OOM event can be raised.
> 
> As shown below, it can happen under conditions, which are very
> far from a real OOM: e.g. there is plenty of clean pagecache
> and low memory pressure.
> 
> There is no sense in raising an OOM event in such a case,
> as it might confuse a user and lead to wrong and excessive actions.
> 
> Let's look at the charging path in try_caharge(). If the memory usage
> is about memory.max, which is absolutely natural for most memory cgroups,
> we try to reclaim some pages. Even if we were able to reclaim
> enough memory for the allocation, the following check can fail due to
> a race with another concurrent allocation:
> 
>     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
>         goto retry;
> 
> For regular pages the following condition will save us from triggering
> the OOM:
> 
>    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
>        goto retry;
> 
> But for high-order allocation this condition will intentionally fail.
> The reason behind is that we'll likely fall to regular pages anyway,
> so it's ok and even preferred to return ENOMEM.
> 
> In this case the idea of raising MEMCG_OOM looks dubious.
> 
> Fix this by moving MEMCG_OOM raising to mem_cgroup_oom() after
> allocation order check, so that the event won't be raised for high
> order allocations. This change doesn't affect regular pages allocation
> and charging.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

I've tried to address all concerns and questions in the updated
changelog, so, hopefully, now it's clear why do we need this change.

Are there any comments, thoughts or objections left?

Thanks!
