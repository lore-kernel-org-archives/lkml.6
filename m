Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E516C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9AD20779
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Nci7okJJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NZ3GlGyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9AD20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeGBQxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:53:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753014AbeGBQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:53:31 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w62GlNPg025503;
        Mon, 2 Jul 2018 09:52:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=jrRSD0BuegEppQo4+MByRsJIYrnG08V9/vc6d48Jusg=;
 b=Nci7okJJjtLbDVMsyQMlD+MCPcGcOMQWTU+qB9qOCgoLgQsNRlNw2ilab+m27JvrE23o
 Ek0DQJ4WgcpUzhUHv6YLDFp9FFQY4/CIue+xNsGrY8LE/te4rpQzLEhS6vId5SldS9fU
 h2Rkw+jAI7EsH5QI31O3BuAzsAyjAVLGYpQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2jykbd8r42-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 02 Jul 2018 09:52:43 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 2 Jul 2018 09:52:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrRSD0BuegEppQo4+MByRsJIYrnG08V9/vc6d48Jusg=;
 b=NZ3GlGyPfwjTM69U1ksgYc8iJjDGVI6svvegp+7YNQ3ROX4VORpzISBtLiJw4Gh67hXxbCLUJZO6jvCt+tVeT+dcKw8yZhB4H0Qf8HDobic8xuSHN+ebam75MVCQzlouonlwd30UX3OUCppLUVX89wd3RxqZLPGyqFjpEhKk3cs=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:fa6f) by
 CY1PR15MB0169.namprd15.prod.outlook.com (2a01:111:e400:58bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Mon, 2 Jul
 2018 16:52:33 +0000
Date:   Mon, 2 Jul 2018 09:52:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-api@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v2 5/7] mm: rename and change semantics of
 nr_indirectly_reclaimable_bytes
Message-ID: <20180702165223.GA17295@castle.DHCP.thefacebook.com>
References: <20180618091808.4419-6-vbabka@suse.cz>
 <201806201923.mC5ZpigB%fengguang.wu@intel.com>
 <38c6a6e1-c5e0-fd7d-4baf-1f0f09be5094@suse.cz>
 <20180629211201.GA14897@castle.DHCP.thefacebook.com>
 <ef2dea13-0102-c4bc-a28f-c1b2408f0753@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef2dea13-0102-c4bc-a28f-c1b2408f0753@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:fa6f]
X-ClientProxiedBy: MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) To CY1PR15MB0169.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19ec7dc0-3503-4beb-122e-08d5e03c360c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0169;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;3:NHKHFHJvYoxxsyK4D/oiCnxynYBzVg5UyDC4bmo7Us4VFBynq7VmlpvIwNqKdiug32U2qVTAXWTqhVduHRuJu1B8oJOE7Xvna0BUhDw72EKgGeyGMk9T5Kb8J41mdsQjKEvtoa4S6dizehC5solKrhYiY5EBuTH8rOKcAI5YU+s6ucFQzR359o0ppY5sn+nDn/c0cy5L7PVEq3qyuvjgKZcOR+NBVkiSMnnEvhs0jw5ZKJ2fCgiYkaJGbGqBj+hp;25:jhD6MFkt0nMPweewuFIzl+4DmGqPPxAhR5Q38x5dKUxtxYDukhoGBhPpy5kZ7ke1SFlYiLcXZWco1DF9mFac+IBMuywNFk6pxHv+HAiIxqur/akD4HRHfVD8KgFalMR0e9JYczfzGSIKwxVbOx5IQcrdLWghRInTzzYObv/Wq2+j5hkWs2/oauvHGYSnyRXfWbFCmJbucHv8QoC1HjwbZpO1MYF/zKNLoFTCUQRY4yYMTdN84YGkgSvdjeHqFYGUxzzl92vCm3fxP0ipG5idmWDMpU25pqHhDflLPMK4L+CXq6GPwfmIrhjKmQdeP8m9TkTxTRCYa9aomOi02pXQrw==;31:tiO78nBsqEFwr0wSn30TgiCpJ/kwaOxuh4VIZzANVk4bkDeSZ0oDyIwUqJfZT2jbMcvkQeI/AfSwkvzB1q9fxTJMce7l6RJY9UZEiWLKiNFSuliIjZOZ41ebhJBIAb55kEk77Vn7kYORVfQmtDFWsm+ftL630Hd3vpa/5E1O/5GD8vs0eMxc4yjmifj6UQ9Gypeg/ZVfOY+nXMEyYjCH6GScZGdMilqLninhG3dzIGs=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0169:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:cT8iUr//FJ67FbFaJCvvslQ3o8Agao5eeTJJZAIt4qA4pfdbBBuMYo4aWnES/LWyleVE7oq6lrGllKhaqRioIcqBgQWCVJmfoBQltfDOrbjbTocdPUBU2hxu9Bnf8bWrLKeCRhTZhTA45niqyPh68AZvgh1YqhY9yYNY1ZUL5c0eTTwvS3BU0Ub9CMbF3pmvJPtHOeeYzpJQz7ZDWwh8jbYJLbtnyBETCcpMfDs6AbR6G8FOowVvkcYJbXaKxOPT/L0xz9M9n5GLO7QYBbWzt7xZlNrmwFc30jIMix5FEk8kreEQPol1dWfLSJHZxrgmJjADZ+m6OYDFgq1sKd4dFEFAWUG/FtICgHbNkez6RTxDavBE/IjXZ4+USCDv9eFCpGyIzHipp4m8Rdq6cjegYhQr9SYv80P5iGQYUgq5WCGmUVdCEd7tEbzxtzFVxxnlOUfjMVu7jb9YQitop46TgSCboxtKNqLtKOhVnupMbeDueZQLkYhyqTMi9BAsRH2g;4:Eyxj1oR6jNNen3K974cbzM8J2vGhhB5kdmLlBhEKoZl4SwAO0Qy1VI93cd/+rkVDsPsUOH7N1s5nnd1OE19VzUIevpFF/uCziQXaxhr0h34TJtMGC827Fa9BixdYYZZJg41mPQkoJhdZQYbLdSeqenwtg6Knava+atP39X/zAmxIoPOK1A8qA5GjWhmA55KH9xf9NPLiFGUVReVsXbB86UGcGVJWmkpkXXP12VsWpNHoZBaPOUO8I+h1KcVo99a8fMWLz9GAUg7y3oH1Xyv3Kw==
X-Microsoft-Antispam-PRVS: <CY1PR15MB0169272B67AF76350395139EBE430@CY1PR15MB0169.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201703061421075)(201703161042150)(20161123558120)(6072148)(6042181)(201708071742011)(7699016);SRVR:CY1PR15MB0169;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0169;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(9686003)(11346002)(52116002)(97736004)(76176011)(81156014)(8676002)(14444005)(47776003)(50466002)(6916009)(7696005)(54906003)(33656002)(16526019)(476003)(4326008)(52396003)(386003)(8936002)(81166006)(46003)(93886005)(498600001)(58126008)(25786009)(446003)(53936002)(53546011)(186003)(16586007)(6666003)(6246003)(6506007)(305945005)(68736007)(7736002)(5660300001)(105586002)(6116002)(23726003)(486006)(55016002)(1076002)(229853002)(2906002)(7416002)(106356001)(86362001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0169;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0169;23:sB9XflkhPx82qZFBrjHZoWu+UKSZTwA1EtMGCN0V2?=
 =?us-ascii?Q?lG6FBJgkLebExwDpBXaj4A7J+1Tpps97KT2tJzqXLZGKrCQcdljRwjiQq6HV?=
 =?us-ascii?Q?syn6IwheB/VIJO7h4bsnEcpgGjjx515RyE9JyRAhWRymF8fizXq7L+ELJsix?=
 =?us-ascii?Q?MjO0wDwBTzlAuPN09rTpndaf9CrzP27dH1Mkl3sfu+IfaWa2I1pscdRu9igM?=
 =?us-ascii?Q?ruUsQ21B/6TKTjn1/WWGpo0AlINNk9gQvXYbLy3bolWlPVFe+h0Zhelld17o?=
 =?us-ascii?Q?8/eo6KE564CHC2nPX7KKUyDK0aDPb8+LXhaJOijCAGS7pVe3Vm+79QurzdK+?=
 =?us-ascii?Q?hglvEfOQVpSYp5Edgr3qaJPkmfgE2/5t5GkV+c7K/JxrMDnYtYukHUiVgxf3?=
 =?us-ascii?Q?z59qePA0XnGgitzbZVuE/HzjhLolxwjQpT+QiXQcQIivwGoazUJYf/kLe1Yu?=
 =?us-ascii?Q?YfRjwsoJh5oXfCkeTofCiCc7xWY20LhYYMD9whkxnfZSz5NicRTe6Ub5kP1q?=
 =?us-ascii?Q?H/cyr5FWWzyHEmd/cfA0G4ubPez2h2vwcb7Hl7Mh68J7GJkW/JmOdI5CBHFp?=
 =?us-ascii?Q?LdAoYIk815jgd7gvAyGYuSi9+t2wnPKLYMckWXhFlUay5987BvFuimMYgscw?=
 =?us-ascii?Q?tRk6KZkQwrGIQ7Nv9q3raCk+ciheUY/fjpJeqTh0u3pNgfH9kznjwmB2Gv+R?=
 =?us-ascii?Q?/uSsjQp9YflARcYxmOwx4UjXHogRy0q5gvdsK0Z99CDl50o0ugPP+O7G/CmX?=
 =?us-ascii?Q?x4WmRhvEsSlvUU4mwroOtJM6GW6o6qhMmQQBdUKJdAb8WlsY7YXqFIR1+By+?=
 =?us-ascii?Q?tu/AWqO1IAWY6Ro83B6KNJo7KEiS/hyx0EqqIshpndcQbm/jJjh2NDjgok36?=
 =?us-ascii?Q?VgE6Y7DbHzMSAXNHFZGO34PSnag15hk/YoL7439pTphk2ktkXY9lMueBQstG?=
 =?us-ascii?Q?hdjpa8SH9oGNeImQHkDU30OlNM2hRYgKadJmGpZUGDQIQLecLOKqGmD6sXSQ?=
 =?us-ascii?Q?HxlQSiBJrIbtXtLM7ZDO7qUNpxDcz8YmLUqkbNqPSqMKwvpwodo3uER+KXVC?=
 =?us-ascii?Q?5VJY2kRDiaSTRap27DZ7UxrqdsmwJgTpg3MzoKumGtVJU9JviGw959ZIMXsp?=
 =?us-ascii?Q?bLNXHIH+V41oE9wO3DNQ+W/XaB7LFdVC1azavjG4RkbUPlrnCrI5x+pi1b/k?=
 =?us-ascii?Q?U/+YAMGwixs/isoyln9FgZFQBegFJK5ssv0?=
X-Microsoft-Antispam-Message-Info: Kw9tSVr9T7QPCcrkR8i/NXVJ+PtcbViXuhVTNngbNpVWiOBP/VJatI4yQygOw8uej6C63/XGrLQ97ju8RG1i2tvh2jgf9cbxcZzAse1V3McfK9pKvkFLfmV3SCkF+Rtd7+owWBTcoiapNxhd+Xv49p7DbxQL2709LbQtiB3IhecHTcXPgSgx8QkHNuruN13h72iSD76SVbxC9Tiz489/uP41mgBuH0aw+hXnFEcL5OBYG8nUyk1s96cJBfxEtjOEKBR23QqcUmtrJSvSu93X5fLx6GhTld3GDUX/YTOQgHITQsG3vNJfcgsDE6lguLQGVMBlMLfwQMqDu4nY5QJU+dHqg4ZuNh4YAEPeP+agovc=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;6:FS7nGQR8K+YpOESPYeOnB/LMTLCnMpuNSrE36JGxpfA92CACiMy1XS3GwoseImuy5EyPU6WcO0ucZQrdEpFJP72F2ExBEB6H/Cfx6j0x1wJScE0BCYZU0sFY2KLRXjWuFRZV4rwdW/UwtqPO9xcFcWZzk8faPTIVd8vo18qV0KWRKd6rtQJBU225An+Rx4Jx2lu2+XRxtKjp91lRaKathbtvMOOp27u07QnUvlWeKAz6ceLJarR9cpPNU3d1dr8EBsjvpbJustFEFLahcDu8iFhELaJM2K2SgNn//fXGz/qhFIWWG80UQ2sZ5nbU/oWxMY8H5xkg1dAEEE/ybK5ffuBFwlnnDQ6f6eQBgs0CCvdfuZjuIGhWDP9yTCdrSRG3bbbTRjEGH3d5AnyhBmzkYVqBqg6KFCKxCm1QA6h56AFhGHX9OMQm6Oiii2hwBgIje8BzQedvVlfPoVy/cVo6AQ==;5:zNgd5rx/Aw5VF7cp2oZ7/pUDRyenP7cfaGwd7EqWSyg59ZmP/PFjebwltnJJFl223E8Qr+VUOITz8dAaQ9H2VZ7Dz7Dcj+MMw/adSgTOr9/AFxg5DD5aTKYxLUVaVWkQ1mu+vQVg4tpT3hPPTPdICncGGx2Me8KqBu+eXf+wWBk=;24:lSyX+gMC7BX/oC1Nogo8d15GG1P1twP4w5GNHC85RbKJ6rixv6yY5I4ZqSVAOIHiWu2tmVKQlWLHK1I1GzKr1UxLySbfxySx/Rg0dymc14k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;7:0w/p6eJ9TG8/7fipN8LaKwgVlPrmtPz64B5vERNMe6h9rH+dhDJfU/0fSvrGX4yOZNaL9r/25Hhy6eclGabNdNmiQv7P9G6h/dHucQ6u1a3vYJqE/N9v2fhWJbR+Mmb7eeh6li/hpskgpFZYyUhsjcBkqMG/G8073/PDVNA10SL3EWVrrpZc/XSkYmpAahucGutCO3N8LoaPadQiIViRI9lUK+BYgkaT1Ga82a1eh/fq+o6s8I1ecw2VocmOFNtN;20:Lkwia0jkRRX6RJCxjQLW+X7qRVyKDsAVCtNCs5qpUsyS0tcnE7hzHOINTmBNWdgAOqdEsTifOVCaRoHYCMd0ii3bZGSPDvvgAu9ysEWw3oHzFJDfmduy6/iObuduHckySBlQ7vwBiByWpJV1LilFAGQXBvQzUkInLhhFcMlCsuM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 16:52:33.9162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ec7dc0-3503-4beb-122e-08d5e03c360c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0169
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 12:09:27PM +0200, Vlastimil Babka wrote:
> On 06/29/2018 11:12 PM, Roman Gushchin wrote:
> >>
> >> The vmstat counter NR_INDIRECTLY_RECLAIMABLE_BYTES was introduced by commit
> >> eb59254608bc ("mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES") with the goal of
> >> accounting objects that can be reclaimed, but cannot be allocated via a
> >> SLAB_RECLAIM_ACCOUNT cache. This is now possible via kmalloc() with
> >> __GFP_RECLAIMABLE flag, and the dcache external names user is converted.
> >>
> >> The counter is however still useful for accounting direct page allocations
> >> (i.e. not slab) with a shrinker, such as the ION page pool. So keep it, and:
> > 
> > Btw, it looks like I've another example of usefulness of this counter:
> > dynamic per-cpu data.
> 
> Hmm, but are those reclaimable? Most likely not in general? Do you have
> examples that are?

If these per-cpu data is something like per-cpu refcounters,
which are using to manage reclaimable objects (e.g. cgroup css objects).
Of course, they are not always reclaimable, but in certain states.

Thanks!
