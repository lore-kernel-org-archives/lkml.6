Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8DBC4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FFC20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C3eQ3F9L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UY0bk8D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FFC20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeFKXKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:10:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752975AbeFKXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:10:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BN4pQY001512;
        Mon, 11 Jun 2018 16:10:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=4Nq/HyweUf4Vz9t3kabg3JmihT2pxhhIm5oRnU42f00=;
 b=C3eQ3F9LcT5datFwoew/e6uXGthgWwoZMeMc6NHZhpzHtJyGwi9Za8ThTW72BHLkeYWR
 pZ2hZRK3nwQiL9TY1lyHCEiB6tsu0dmjsrgXhKUR63o5yPfY346LbUSmmzkVjGcoczLO
 4OAKjOdZO0VC31iKerZcVhwdrsYCk1K6zfU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jj2cb00vb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 16:10:17 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 11 Jun 2018 19:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nq/HyweUf4Vz9t3kabg3JmihT2pxhhIm5oRnU42f00=;
 b=UY0bk8D4CjLksqo0aR36GikTVI/Ioibc4yYmaiacK0zsR/x2ukg+85mUs5yLxChH+kCUBu9gcgBLGmbQhwg2nop41d6Zu5wJuTgrWJkanZ//alCR0AQxUUCvqcwBxVPu4/8fU2d90SM6rBZthJBuEADWajkIvVzdktlcWLhoVQQ=
Received: from castle (2620:10d:c090:200::5:1fca) by
 BL2PR15MB1076.namprd15.prod.outlook.com (2603:10b6:201:17::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Mon, 11 Jun 2018 23:10:03 +0000
Date:   Mon, 11 Jun 2018 16:09:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] memory.min fixes/refinements
Message-ID: <20180611230955.GA3202@castle>
References: <20180611175418.7007-1-guro@fb.com>
 <20180611153621.aefcf17a4d4d0b939eb35f28@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180611153621.aefcf17a4d4d0b939eb35f28@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:1fca]
X-ClientProxiedBy: MWHPR2201CA0015.namprd22.prod.outlook.com
 (2603:10b6:301:28::28) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:ibRgANdRcP9XqQbR/NmbGR1MxCXtNjvfQv92uyecmjfwbfKmcB6HG4HNZf0dhO2jCV5xITOxPj7EZazM/d9s8wf31GzXTXCXrOPPIiC4nSgLW3Q0wIVElM+ULa9ym0jB5Xh5mCNnZVRImgVv3AnUzE/I2E3wA4cC/Et8PyCgjUhGi3FcE3c4HLG1YqFu0Yt4BFS6JlMLH5wRoMXV1phgNN1gZC6YeQu8B0oL3kXcIySRLcT/LAdPMjHGlN/8JgNa;25:OhP8g6dZk6HCUu2q2MY6584lWGxjvuo7rRcl54B7YevCZD12tTtG0thIySH1wu9j9kt9ipH5fItAr5VCBIp8FxpbGroVRFSDFicbAdhTz8Hiail1baDOu9/oRFfsbwxrXI4QwTnrLFzuVAk9YnokDS4NWlcQNzZWRBga6iw2t8WPNornxk/APn/fCy9uEHwmFbxHf7wRzk7TRU+TytzQN/5gvxOGj/TgzY06T26+fULGPySQxlK/gKd1LLUyi39Oka2TNfrn9DQp1eyDkBbhJXLyHfCBhrKmwftJBcAoA/Unxyt7BGsYmlWWqynlw69EzQ5OjZ1FkUo0m6kRGd5vPQ==;31:Hqq71FThQkE2SEApwQ08JA8m0w6dDKgVmx2PbCNH9BXjSSvY+6Q0TW9ANsjnBDLJM6uG1zqfG1+DwwOG5e2TkB+Bh6cgfcfAY9YR136+Jb5O+WImuYrINwqxeMLwnKdrdVOfc+6pfq6i2hpB7qtmw+YR2uWU18JKYgPj7wZ2biLy2GLGoWl0UhHtwvhPZiNVS2CIFjxQlrIAz0ovVYvdseNmRzIYxHlQCWNbV57MhCw=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:Iz3Gld+I6V1LNmKBqHDPUlymgeVhy8cmiMruQDcPfy+9c/lL4V0vYBNbi1iiHaUF+qUq5buwGayUBOE2etgGeIi2MYPWPQklg2HGagYeoxncbyDThcyrxHZw83UprGgljZGhmLvWK+/bT1iDzdlgMROz4Q84+CxokIG7Lj/XjtXos+MpVaf3PGC00ePmc/ZzXoP2EWQMX6fKXR7RZrkbXOBjQvHoJ0mXcis7e7+hVpSkDBqco4ISgiwlOplHZo8ykv3xUamL4FCt7TMRSIJy851u/RUWjvnbCFU1kVCbaAo/aeqDHRwozLmqQ0xYU5ijl+iAWxfJTP9cT94VIvGKKP94uUqX7IpfTANqUojPVOgM7dyQ76zH/SxBJkDaeJloLgai2DKYhWY1/RlRg7cy9O8QHHkpz1gbGBlmBmCkthJs9we7huE722I7zjCdb4JOflGzAgkFItoCYLR1wEqJQl5bBhdI//0ZJCRSMFbYsuCGIBuDATVy9eS/fgTfaHCt;4:F/qKWgBggx+cC4Cau+gEhlb1+SFQwkgeSCgBzqBXr8lgb3p+VhAVP+kXUOjpByXNNlyI4d20m5/Ga1mz9u532erGmwV2EREOfE/TuJUyFg4wuClg/4HnmRDLL6UbHth9ZbhXCMwrdCBvlZXTReo9xjpLpZt4aeTpgnA0qR3xFSAugjMsesIPErcRokMACcps277QhQU8Tq2n2JUvDpHsPa8Z/p1Mw/YbpIky7/3MCpW+uCSPrqC/sSHM1VhTxvyUrX3QFNK5lfN75Jpo4XyemZJpeqkx3/3IAOPEY262+01kAxkVSltNKtRPbBNV8wCo
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076C8AFCDF00A1CE8CB8215BE780@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(81156014)(6246003)(53936002)(8676002)(25786009)(4326008)(33716001)(9686003)(81166006)(86362001)(316002)(97736004)(16586007)(33656002)(5660300001)(54906003)(58126008)(106356001)(105586002)(229853002)(110136005)(55016002)(6666003)(68736007)(8936002)(11346002)(476003)(486006)(47776003)(46003)(446003)(76176011)(52116002)(6116002)(386003)(6496006)(16526019)(186003)(305945005)(7736002)(52396003)(23726003)(33896004)(50466002)(478600001)(2906002)(1076002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:lAgAp/+PMSZrBZuHtw3Zw9WJGYpm+zoRwcz1JIIh4?=
 =?us-ascii?Q?mM5bNuPBvRtP44S7xcNjwc+ccuwBYDIFbsB+Q7IJ+EDQZE7Fk4qYXv1Cu/3i?=
 =?us-ascii?Q?jUMjc/72yvOSmfQmOJ+fcDHsRWepfIkC1yts83b5iV/DFlvwlNV6XJQRZ8X6?=
 =?us-ascii?Q?DTgRH6z/i0kyrn01nxmeoQMZg+VRG1/vVl4C21Q29Bbxtg4tf5biTqCQ7OoM?=
 =?us-ascii?Q?BiCgdXtcBiINhjWiR9YcjZpQhxSCqvODbHaQs1A84UD6IrA+7LMHNHC4oYwv?=
 =?us-ascii?Q?tN6cqGhsPjU1pzQMgzODaijT/F5PkB+JXD9F7jrdTD7NAM7cvbf+iQRw1ORI?=
 =?us-ascii?Q?kNh5t6uCowQXJwvsl7F2wTIHcNYOMwzYa2IhFzZFLbutW9IOJAn+S91rhSec?=
 =?us-ascii?Q?1ypKY4VYgUOt4CdV8uibIuSN/cgQaDd0G1H8dXRS5WktMSbxOcDe2/khL0FM?=
 =?us-ascii?Q?JVRSUupdN5ILSlWaRXBsvkBN7bE7pqPprR1FyrSmcLnSHGhSXTkgLWHpWK6N?=
 =?us-ascii?Q?K2PnDWl0tz+7JHt7oVtkPCuBDH27PmyL5+Thxa+fZVZKLs8/RJFc2X1VRYVK?=
 =?us-ascii?Q?4Z1wYHfnC0KUcWqayHQY7gemGNSQ1WXXXNkknNkpbr5ANsCb8V25UL9wt8LE?=
 =?us-ascii?Q?veUES3KjT1zUeQAuNDryvzSki+cXz7VzCwD4IRPB7z5E3FAQauWTMFCYhX5N?=
 =?us-ascii?Q?T52jpqm6TM0C8ZiS5T8CNflTcUVzqPjmmY1ShLWQSo/wWJ6uljyWrOQfSjIR?=
 =?us-ascii?Q?8w2yFSrHlnJ6xnUXhy5kRPNmjjWF9K0PlGPy8rBsGQvDeCq+e+zzEczTsKM5?=
 =?us-ascii?Q?Q9JR+Rsa4/Tea+kzXDhqClxL7ZiJvnDkxm1FYmZJJRHt9x7WzdepVv6fkw47?=
 =?us-ascii?Q?oHcsM3ag0kDfgM0JElVSPxqVYpRjDw7zWux3q9QAd1wn20oOQqLVikigxG2q?=
 =?us-ascii?Q?SMiTAShWTQjTP1+Oxem9AD96awwYc/JP5GWcV0d52KTbUOwu04KHNVHRXNb/?=
 =?us-ascii?Q?lIrybw/iNwbFdxnxIboxU5OZnUK6xtJa2GPT7oJSX9Bc8qeaBfxl8MeHZ/Yb?=
 =?us-ascii?Q?Frsukp23+m/4Vf4LxBxzi9YLOwirl6d9Am9fbg1nEx5hKFl4Kc+xekwf/NaY?=
 =?us-ascii?Q?aktvCFKPsOkqBIw53ZuzlKFyFzlLE02/nDijjffCWyq14mNpJCKp4ZBohLr+?=
 =?us-ascii?Q?uqqMv1OFZEmiRhWYM48GSr+K8vAkyzpTxqTrdiO5s3IADnGLdTM3qKQCXNYp?=
 =?us-ascii?Q?ylikTxq9ljUmb2ctpL8QnhW8ARVuSufx7RPYvEK?=
X-Microsoft-Antispam-Message-Info: l9/+3pWX13h4RLWYG1IvzL2VLifJFMY8eaLvzph8qICxs4W85gnv7WvWwdmFvSmMRGLBd+bNIJdqZV3JFQ2yuZrbAIqAbFAkTTDPjnuI1WmzFGQQDR4eCg3MO7azQIqeGrRZUE56QVnL18Q5DAVnAVq87Y3JSIc/yvudeIEFPavXA3seZp86UpU8fBMxS7bO
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:5P+ZLJO1Ovi18vMiUSzh9i6ZLIzOBtECSlEd8vzRQcL2cVI9c4p0axERHc+4Em7o1UFsA93Yvyrf6ikZiNu2p67E9THpDajXQ8hmGYk2v5X2vCHcZSekTilKwCCEnkpEUcilpSxcOypOxqRr9E9K2gkcMG5LsNIl1+23MGm3oEha1CJTykaI20s1pu89lqiGJMTX4bNGRZV+uravDTUXfW8jvatXME6WrK3xB39+ovPeK2AnI3w9U//IcEuk0tq6xQihb5xXi74ADpFZeGGoEr6AL+A90sYxjOOhnadIgHdfYu8J7tzP3RgcRAXhd+kgG1qRrdzrxiK+gtB4iX/G9ooqM5rHzCD+9Kd+MutiEnYzzo+J3Jdq9im+u3MDbDh7oojoaWi2w0PV8qf9V/0FOkARMAXM3wDY/LZyi2/XSrA4y9e1bWboPdbFXaNBFlGenxoYdJ7YPZ9OAk0acLd2jg==;5:Z7NA0AoSQWnJhsKlNqFMaVubt17aB2WyJio5TEXx1ABh75Mu8jp48BmOcexuxINE4kyMXAjbYodZpKf7j1UFlzwPpPpIqmu/PiPBP/lRcR+7acJELox5HtPPxTn0awfHGcwv5k7g2c4oouY+4s2+o9l/En+U6KqSJ3KzZ4iXDoo=;24:odwy6xvtCCBoDBZTBBvxJyBmNFbPyjFGhLr1AiAIfKEff3u4yzxJCyU2YWjQbWMQkDvVAkpJURum1yr3ICHe7T1OVWcNiwL4cIhoAtFPWk4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;7:iEhAu9lLLakqZbKiBPdqT57Xa5eceJGq1kFhjx8B2YjH9/QAOtebxxi5OCHM04fni+G2zQXASBKkBXXKepTYbqsXw+7YjLyVnwpR73WADr5VXYK7Qys0v8K5nTxPJJry9iXpTA10GqHVzP7x1L+azWJTtUxqMopBvtmMA195KGyPRs8MJdzRZTlj8ElygNTp9UyGVZ3MCbupM/bky4EjQgIqYisTTLuruSm1WlXpN0mtgQUdTs3nr8/TxsxZjLZi;20:fR5xNviCrWmVTVMeAjz1MxZgOyezCaCVJAKtF8sRJIs20VrgcnxALtLQxt4ny5HyJV4/vlWQRpw1k8u+KpceP6X7kA5dUpCeFodBGpoJBwTmcCd7ef5D1uvJYeF98rsqcN6hzfXls1U+cpvYzGodt5rPRg4Wm9hJYshJ0bgEPUs=
X-MS-Office365-Filtering-Correlation-Id: 19a3b3e3-e2c3-435e-44dd-08d5cff07aec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 23:10:03.8194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a3b3e3-e2c3-435e-44dd-08d5cff07aec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 03:36:21PM -0700, Andrew Morton wrote:
> On Mon, 11 Jun 2018 10:54:15 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > Hi, Andrew!
> > 
> > Please, find an updated version of memory.min refinements/fixes
> > in this patchset. It's against linus tree.
> > Please, merge these patches into 4.18.
> > 
> > ...
> >
> >   mm: fix null pointer dereference in mem_cgroup_protected
> >   mm, memcg: propagate memory effective protection on setting
> >     memory.min/low
> >   mm, memcg: don't skip memory guarantee calculations
> 
> Has nobody reviewed or acked #2 and #3?
>

Looks so...

You took them very fast into the mm tree last time, so probably nobody
did give it too much attention.

Johannes, can you, please, take a look?

Thanks!
