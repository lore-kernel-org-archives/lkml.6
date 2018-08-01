Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58295C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E196E208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ifP1R3KV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Jc/3p5Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E196E208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHBAff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:35:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbeHBAff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:35:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MiY29025003;
        Wed, 1 Aug 2018 15:47:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=7AYAukFdcneWJBU4zMC7XQTTScMKYN9G4zQ5SO9bwpU=;
 b=ifP1R3KVzLyKfGIZqoo8TeMVcXiWxTl/8b5br0TlOd93fWuD1AtmM5OB1wsHFw1ouZcc
 4qbZat209Zbk0TZTMJbXzVDCDTJ94PyNvCUVD0J7k+PC3fiLPYMJUX56MDO7H4u7BqFL
 w39KjMqBtQGppye4jyjCtqAVM437lhGNoQo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknrj80xk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:47:21 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AYAukFdcneWJBU4zMC7XQTTScMKYN9G4zQ5SO9bwpU=;
 b=Jc/3p5Zp5kWDAUUzLLvfokZnW6NS74/7kozoQAdgFPvh1aMsopnqQlRTStlJ3eJX4Sxt1XPfq5cG5on4flYSG6Xbpq0pJgF2biZbWO9O2Rtb4bDm3faw+in1VAQXDPjiWmHokxIZ1XFJoGuQKgsL/VOxLd7diSQqYX1c0dywII0=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:7cca) by
 BY2PR15MB0168.namprd15.prod.outlook.com (2a01:111:e400:58e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 1 Aug
 2018 22:47:14 +0000
Date:   Wed, 1 Aug 2018 15:47:09 -0700
From:   Roman Gushchin <guro@fb.com>
To:     David Rientjes <rientjes@google.com>
CC:     <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] introduce memory.oom.group
Message-ID: <20180801224706.GA32269@castle.DHCP.thefacebook.com>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
 <20180731235135.GA23436@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR14CA0061.namprd14.prod.outlook.com
 (2603:10b6:300:81::23) To BY2PR15MB0168.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b06a4b-da60-40f0-d0b8-08d5f800ba37
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0168;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;3:jflHX1ai1+RnLJtJYrammPyJjkrzuDkNdQrG2I76RxxK/ZBV51Po05BTQP2TmB09/N1KA7DIFbVKCrHdnaSOIrlsSYmLWyFuUGuKaWRccOVoZ0oacachSri36MQxIJOSYMuIdld4Yzjb/wies11dRzkgbhdMTHoe+0mksuqaAQmN0ISM07aqCoxSU8hjf3N9HnsXWX4EAv8/dotJ0GTymTHlj9nmPVxL6s50FNqeUGrAREyJmWYtbFcBB/Hs7xz8;25:Kq6OhgQEDRabuMuh+1s2t36HyM6DW+lpJHNXdXZW2W1SmnY75eWzKpqG3hT0qorjT0OLe1fK3w9Q2nMZT1QwbDYO2lXxNu032QPxXH+Cf/U3pljW0lBfjZr3bXFsi+d9bvIGf/B8p3geWEJQ4+R/zXsHaUXEtNJrEnqCMjnXQeYjS/XuGhuoGo2eHxwIXVhQ/48cBzPGtMdqzYEl9aoWYdwrSerOlCvhZd7pwuT2GnB940wDXIumretuqthHRvymPaq1Ntmm8swG8PWzIEmy2XKKPuaQQY1iuXyzxUhSwn7widarL5UuOPgdNcMsBKSdy/WdF8REn9BU+4gPi/EiUQ==;31:yPdiGKl56PTVyuz+TVauVFoo3Y1oSuNt+rNnNzCGN1btB9weqiaquPsyOz2qsb6Uo6LVPWINnr4CXEQriChvagrwoTjuIYGtxKd/CH+l50wKFnyShtpdzu/nYQ3mQDPl0PXIm1m2mvM2x2N3r64u+B2E8VGLdua8nOZx9wy9p6mznJNNGNqdwXr7XVoascw1f2lpYGAjLerdPW/mZ2C+6ravXD2l/sVWsaFR5D45ZeE=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0168:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;20:8mb1sVgD4r/f/o2eehU/kQYc+NQgcyF6PhQEGdIp0FraqFB6i5L6ofzpBxp+NxPFGUs6Gr03FsU2ewtn+L3mOB0gwv3e2/KTxkbEQOWeTxV/Eu8UdBp9ME0xsJdG+13WMw9qvYcrmKl50mQnWrngURzb8V2/2SjKRZJPtTOF03/0e39xMaUuq4rvsexbaIvSYGcsCwrBPouqFS68wyhV0Zy+IJczhLkvxrjD3A0wy6OZEWPbrFIkUcud+Y7qS3G8h59XtGBCUrUNEN/OHj3geHIo9IrCIXH95xa8cAJWvbL7Qq+jzqdTny7sUaNhlN933WZJoSD0F3LWjHF3UtbYNh70DSDpHYyj7hqhpDNbhfcG4JsTLM/p8zHBJpp5HJ/27tRAka0/2TtmAyn8CBLGvf5jaFDgHbuvbX5p3mRHLO61ldeN8hQO665aLbAdoXgyaPLRX+E6ZoDsxW6Cwq82dwyvoW07cmsWIrf5yef1MjeW7lv2z56iy0mFPWRTMh5y;4:X91XCBd17Ttp3EkJWLIGG1QFwPAZNC2A73+ChKZe+7klsEB0VHT8aQ8RlPkFDvJ1r9t+KwkOu2Dr825AizQwc9In9Cyzp/AEbP1axT8OsdFXiVaJ/GBvTKTuy2/DMZLYFrr+VQdGYv5pFd8xgwGiHt5mtEzwETP4NFQrH+hqaW4M/K7PII7QK5JIvN+64TWhaS18XXkfIxXnUtUEOKQSTV/DhDjbsF8qZla0r9GM1VcvNTrtMtXn/CYlUbX14b4RqqdzMlhFTnGHconVWL7W26RaE6MG2Z2UrRikGY/iuDlOqi46wrfcCW4qZy2GQfOc
X-Microsoft-Antispam-PRVS: <BY2PR15MB0168485F57DD09877901B36ABE2D0@BY2PR15MB0168.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0168;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0168;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(52314003)(189003)(199004)(51444003)(305945005)(14444005)(7696005)(54906003)(5024004)(386003)(68736007)(97736004)(6506007)(52116002)(6916009)(8936002)(6666003)(52396003)(8676002)(81156014)(81166006)(25786009)(316002)(6306002)(105586002)(446003)(106356001)(58126008)(11346002)(16586007)(23726003)(86362001)(9686003)(7736002)(1076002)(4326008)(486006)(478600001)(33656002)(47776003)(46003)(476003)(966005)(6116002)(53936002)(229853002)(5660300001)(76176011)(6246003)(55016002)(186003)(2906002)(16526019)(50466002)(93886005)(18370500001)(42262002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0168;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0168;23:e656DuRgBdXaFzDzHq+9Xj8LfjEfnvHAkgrQljhc5?=
 =?us-ascii?Q?Tnzq2x6P/5Gp3+Tcx+TRtcjDOhKQx7dmoDU7Il5VUgykA83l8d4B6iP8Oazu?=
 =?us-ascii?Q?jNvdQPkX+spxNyuB8ZTwuHdt6VltnnbH3Pnny8xptJYtRcSDL4wSvkUjqetK?=
 =?us-ascii?Q?eZ2jZpfVjzHnHLUVk840jmeOONRoPeZSSD2sHl/uzxgxQiF+UExr0lxHE18y?=
 =?us-ascii?Q?hh9Gw0KwPh5GHOaAmR2bYE7c2/sNOKggD5VxIvwuYbQJ9UXX7dZinUNQMONG?=
 =?us-ascii?Q?c8XnKycZiintO1Xd2ozINOYOYg9QX0GNa48R9rUaijrMU1bZ0RzZC0nXHfCy?=
 =?us-ascii?Q?s7Cmeb9bC8Hls4NboRNNfrVbUnNMLwtglzT45auruCVhd2oLQwVmO77zuvQ/?=
 =?us-ascii?Q?NojXgypwR1TKcVmYV0ZR0GXZ0lsvtqZg8CFzPgVUe0aBmXHAlVobe711cDjV?=
 =?us-ascii?Q?VldWjQ8/QA1sWEwVMGOkdhXvekm6jY0w9jblC+uQiHEdmwj3UvdVdZsfNVEU?=
 =?us-ascii?Q?S7Slb2PAbaQjG6byCCIQauHfVzir9YHPbTlaHUshWeH2TvpAJDrd+44QpRnn?=
 =?us-ascii?Q?AHdaQpN9kvMyaKzmTHp0slBP70FbfAw6DlC9ug514Pb6Q32JEZKEsgUPYfEw?=
 =?us-ascii?Q?k1h34GTXMmowTj1eqXOC7RksGOaV5+e2eD1d9kF2NRfc4Fz7rAWajyVJAyZr?=
 =?us-ascii?Q?4R+IlHRaN97NRQL7TqIQOHwgF9u8VVsvJcrsxn8eTR3FaI7wPYkfg6bU/IK8?=
 =?us-ascii?Q?zIen66frk4DSxr5NBV/buA/Fzwe/EUP8sqAnaIZa9TJC29b8P+qfM52rxobb?=
 =?us-ascii?Q?LKPn2YT45Hrshy6OUOjSjNmRUjHSMppVudl2FfCzi4dm2OPSzCUJr8uX2nGV?=
 =?us-ascii?Q?OQ3wGIYESA/r+yiUQmGPzM4Jz7mkwAp6fgqeyHfGVKjjVwL9cf43H5aOQ4gG?=
 =?us-ascii?Q?WXF1HtYcY/nFnmJWRRHhB9K8gYSoFd2XHG/QEmInO2n9DjzXH7ZYYCQiU0c0?=
 =?us-ascii?Q?XZf5QN61GfaKaT1a6eHW1UV0Ykrme2nZwufX628Rf0vsZ34S/SAJZ4tWclVB?=
 =?us-ascii?Q?EH15UsLhfhF2oR6/5rOl5ajxEbDrca2T2wH/ms03a7pV7AAgWIhHKUY4ufTg?=
 =?us-ascii?Q?NREguGDaQsMzryFra0qRIasYABQrVQYVkR/RaZpfturdHLvWVPIxx5+gmwgc?=
 =?us-ascii?Q?XOHUWx/+9F5o+z8VRkx2W1LU2i94Op9yYgxPF23g4GO77d8p/zuK9RRuwzrX?=
 =?us-ascii?Q?TAgKfaapq3731UHN2H+cdFmKxootp25WJ7vYqY2Rtg0bEytIsIHf3dfrATOm?=
 =?us-ascii?Q?USRtuQoSVGS+yPP0B6rlvh0LnXKOGKW2Yhwul2XOJ6OHL41kSfbXVPhQ6JYX?=
 =?us-ascii?Q?tV6/URx+W7AczUvPPobThLQ+z55qB1Bp0acvkwsH8eoP1S0?=
X-Microsoft-Antispam-Message-Info: JE1DHu3MxnOLb+FHDqmXBHIVCQs1O1ujYh0mr4/ORgBPvTtUIR+pkorukCI0gYwsduSky3SeC250uauTU/SwQ16mLI2QXVNQIJK133wpkI10AyqtlsrkUVwruqMzT/5dsV0498ONh0QpqVjvg8fGjI+39g1F73tKWZIZqH9KV8HzYzH7U/ePmAgxXiItC5A7P3yytjn+PM2f8k8f+GWBXLhA2NFKZvUIBAFK5LUxuWHkLWhx48N8vpwa5Grwc5b427Lm/G98nmHguxSWUxuVLLhgW+7KVJHP2BmGUvs/IDty12zYy+GpGl3m77UU4fZnqp4WcPzGct5fJOrg9WcGMIHE+kNheJqFvpcSrjhMp50=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;6:aNcMjtgB0qcDvpGdpNbYgX2YlbQHD9d+ULNQCJku//fkh/V91QaNv13Ob8EZjFqUMczMYCpgJxwDQwkf+yQ6k43pdsSVDCiz6yJNQlWMvex37WajFS3v7Bn/2EFghrPH5iD7Ep7FxdJBO43VlbFhie0O+EYEZ9nDhdtGLgc/tomeULy5yJcRv+RZwSiPSSkwirMer8XxvbwzfGdvoHvNg4A7D/wWi0sFGlN3sCLFu4RtFTWlcXChBxYqtGb7RtNmuwgmkSCPjiPYjtQeVYQwkqDlom2VssSWJT4fEQp1Z1awsAzImy+iUeoPocWWAUJSY444/jJZ4wq6bq5b1YKCeYR+MxnD5+d+pJP1qay+TTWXQ3mOKZMb07zn1asfQwUH4vMk2bIVzq3+yhGP3LQAU5mD2vi9gwrIwfdFXAXm8kw6LS5xXtQ6TOINnXQCbIwRWz2IGfpNi7d9cH6NeP/B9w==;5:hK4idHpYupW020wwNuIeELk5jvCRosGVLlAmlNTlQC3egeJqumXjf2+uSvCMHzC6I8Sq6DR2qOlRmc3mbDJIxbAi0X/9WR8G5ixj19A/Lzv1t1Ltx4TX5E+KkCFg40Z3gOR2Eed382Re5KpqYAbOWUS0AkdXq6LWkKhCwzsQhBo=;7:hDbXMZZ+uw7q1qiUCFfYWSv2h8o6ZlH570GYCwx84zEHXo7j4N4dfDmn3rkzcDvQSDETCa17n4/j+K1mSwYiJC9Evjwf0jZPjkrkzh/gzrcuC3VM0n5cQUka26Fe49qH3uIlhcICn9NVYW4sFgRvfCDGpkqOz8Oh28zmFLRU3gL1wr8vc3DjQKPVkqoYjRWidp9Wh4qJTVsuXJLPlggLA/NiipdbFZLWn9c+VPYclFLRYJjb3GfIJ6ZJ0q/tv/QQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;20:e7XX1/tdx4oW6CobW0oZomU4HgOq5/IdYf3vcHApsDLZ8fA4pAoIY/bNJQfL4rsZXLw2wrjJHWbn5GzznHCxJu3+9tLMxUtumM5A5zh0PckB1cG5P/aNePtIlPBZILkPPReRMOFnkRBUoxDZUml0VYBcvqi62jn4Rl40nL3vK7o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:47:14.4756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b06a4b-da60-40f0-d0b8-08d5f800ba37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0168
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 02:51:25PM -0700, David Rientjes wrote:
> On Tue, 31 Jul 2018, Roman Gushchin wrote:
> 
> > > What's the plan with the cgroup aware oom killer?  It has been sitting in 
> > > the -mm tree for ages with no clear path to being merged.
> > 
> > It's because your nack, isn't it?
> > Everybody else seem to be fine with it.
> > 
> 
> If they are fine with it, I'm not sure they have tested it :)  Killing 
> entire cgroups needlessly for mempolicy oom kills that will not free 
> memory on target nodes is the first regression they may notice.  It also 
> unnecessarily uses oom_score_adj settings only when attached to the root 
> mem cgroup.  That may be fine in very specialized usecases but your bash 
> shell being considered equal to a 96GB cgroup isn't very useful.  These 
> are all fixed in my follow-up patch series which you say you have reviewed 
> later in this email.
> 
> > > Are you planning on reviewing the patchset to fix the cgroup aware oom 
> > > killer at https://marc.info/?l=linux-kernel&m=153152325411865 which has 
> > > been waiting for feedback since March?
> > > 
> > 
> > I already did.
> > As I said, I find the proposed oom_policy interface confusing.
> > I'm not sure I understand why some memcg OOMs should be handled
> > by memcg-aware OOMs, while other by the traditional per-process
> > logic; and why this should be set on the OOMing memcg.
> > IMO this adds nothing but confusion.
> > 
> 
> If your entire review was the email to a single patch, I misinterpreted 
> that as the entire review not being done, sorry.  I volunteered to 
> separate out the logic to determine if a cgroup should be considered on 
> its own (kill the largest cgroup on the system) or whether to consider 
> subtree usage as well into its own tunable.  I haven't received an 
> answer, yet, but it's a trivial patch on top of my series if you prefer.  
> Just let me know so we can make progress.
> 
> > it doesn't look nice to me (neither I'm fan of the mount option).
> > If you need an option to evaluate a cgroup as a whole, but kill
> > only one task inside (the ability we've discussed before),
> > let's make it clear. It's possible with the new memory.oom.group.
> > 
> 
> The purpose is for subtrees delegated to users so that they can continue 
> to expect the same process being oom killed, with oom_score_adj 
> respected, even though the ancestor oom policy is for cgroup aware 
> targeting.  It is perfectly legitimate, and necessary, for a user who 
> controls their own subtree to prefer killing of the single largest process 
> as it has always been done.  Secondary to that is their ability to 
> influence the decision with oom_score_adj, which they lose without my 
> patches.
> 
> > Patches which adjust root memory cgroup accounting and NUMA
> > handling should be handled separately, they are really not
> > about the interface. I've nothing against them.
> > 
> 
> That's good to know, it would be helpful if you would ack the patches that 
> you are not objecting to.  Your feedback about the overloading of "cgroup" 
> and "tree" is well received and I can easily separate that into a tunable 
> as I said.  I do not know of any user that would want to specify "tree" 
> without having cgroup aware behavior, however.  If you would prefer this, 
> please let me know!
> 
> > Anyway, at this point I really think that this patch (memory.oom.group)
> > is a reasonable way forward. It implements a useful and complete feature,
> > doesn't block any further development and has a clean interface.
> > So, you can build memory.oom.policy on top of it.
> > Does this sound good?
> > 
> 
> I have no objection to this series, of course.  The functionality of group 
> oom was unchanged in my series.  I'd very much appreciate a review of my 
> patchset, though, so the cgroup-aware policy can be merged as well.
> 

Ok, I think that what we'll do here:
1) drop the current cgroup-aware OOM killer implementation from the mm tree
2) land memory.oom.group to the mm tree (your ack will be appreciated)
3) discuss and, hopefully, agree on memory.oom.policy interface
4) land memory.oom.policy

Basically, with oom.group separated everything we need is another
boolean knob, which means that the memcg should be evaluated together.
Am I right? If so, the main problem to solve is how to handle the following
case:
      A
     / \             B/memory.oom.evaluate_as_a_group* = 1
    B   C            C/memory.oom.evaluate_as_a_group* = 0
   / \
  D   E        * I do not propose to use this name, just for example.

In this case you have to compare tasks in C with cgroup B.
And this is what I'd like to avoid. Maybe it should be enforced on A's level?
I don't think it should be linked to the OOMing group, as in your patchset.

I would really prefer to discuss the interface first, without going
into code and implementation details code. It's not because I do not
appreciate your work, only because it's hard to think about the interface
when there are two big patchsets on top of each other.

Thank you!
