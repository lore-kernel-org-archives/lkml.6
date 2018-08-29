Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9924920652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DWhMUE0Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Uj5IB4Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9924920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeH3BdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:33:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727179AbeH3Bc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:32:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLWh56007153;
        Wed, 29 Aug 2018 14:33:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=v5YQUz5RIcpnw3wUx+J4li+IiGnBN0DKYTqBTuFkzA8=;
 b=DWhMUE0Qd0iUhVNwFFKvQ94Rg7kkH+JxgsAS7SF8bHB2EYrZ261UWJ/b2jnn+9b5Z2lT
 HYK3ziY1Ve7TVw1vI7KBivnviDVx7jvFEmyDW1M44RNzIVvFi2n4lWEs+epPWuz6uk5l
 DBLuMi8sNiNcaHIWLJDb6WiiMrl9zQ5LFSA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m621308cw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 29 Aug 2018 14:33:40 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 29 Aug 2018 17:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5YQUz5RIcpnw3wUx+J4li+IiGnBN0DKYTqBTuFkzA8=;
 b=Uj5IB4WxLo1kos3cFg57b4DFVHDY8eV5Ml/5LNMrKdEGa9ZhlGkmb2SkbIN21lmb9v/AnKhIb40S6kUC3qShjju5Fvtb/wR+tfL9yVRMp4579XYijWF03r+eSRqdoC3OiELgA9a0Q1zA4g8+7Enf46srFyYZA3SMAfLDKqSWvUA=
Received: from castle (2620:10d:c090:180::1:38bb) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 21:33:25 +0000
Date:   Wed, 29 Aug 2018 14:33:19 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/3] mm: don't miss the last page because of round-off
 error
Message-ID: <20180829213311.GA13501@castle>
References: <20180827162621.30187-1-guro@fb.com>
 <20180827162621.30187-3-guro@fb.com>
 <20180827140432.b3c792f60235a13739038808@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180827140432.b3c792f60235a13739038808@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:180::1:38bb]
X-ClientProxiedBy: MWHPR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:300:db::22) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca44117-5657-485f-318f-08d60df70e1e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:70Nq/upQquYC9wgBo+LdUjhFOwGqzPGytQNcOgmLmj5+oLbSrbR9WDP/VDIlLFNdAJP9Eyw5L7WP50xvl2ut72bPz0K+Neo2iCs0U4T5Tf+KY9Nfq7XxkZj+QQrdLn4K1edt5GOUXebE65OU1bMuYQxglXruUXNaj2jJPD7mT8fD6wdJArVcrySzC1PJXqupnw0qkYPy2+YgoEOq3C2bDcHyofK7/c+S+sJV+JYqR5F5Cpe5w+JUBHndzBwhWjin;25:LKRaTYOc6o5yIeTGEIWvdEVtEBV2W00xovq9xmwYHim6xTccPJmjVC/oqATYBYF8MLLQMxo9SZiJHKK12Pkfdy90GjhvbZBCtaJvSJE8S0V73fYo+P05j4umdhcph0W6HKvK9gUT/wUzrGixr3gqLfCZfPKk8rmzXpl0xw7AJyCYRdTj5/BJ4Y3v1daBC++LoRdISJyn4Td1EimYgQ+sOZoOnmSMnZG25wmzHi05xxNBugwdLKwBww1rxm65xU0AZ4V1ISqEczsn+xnfyVaVG6yAZRVhe6DMWOgJLcSn4cHLRL6bRXyW+9kD9uEcVIgfBMDW3KkvvRRsKWvEV+b6bw==;31:Ifg2DZnXjU5wy1I8zfMYfq1UilpwyoCOHeBuePurpZRRJ3swy/9pAwjT879no70kx+utQB8DcehU3+Fmpu5eGAjnDdnfpAoT24wF9RogX7H4k8j4hFSHCkn/cuHbPt9KatgMlwRRxA3J7zhFYeTMCuyizrpk2cH8Frx2kwyMp/Pyh+dS0e97GRnVIBT1VfoDuXOdTKuGmZ/oWHE14sFHXiFn4W6RH6b/IUWZQ7KoEVA=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:OrL/SIo/ilAVjCV2ldtgIO1G+vUumBrmhDDCovxmcf7dJI6QyYgEsrmavXEr/ilbTgPxDICYgvX6Idhfc7frJQnc0I1GR+RFg8uN8BAQ27nj3Y2Su7JXs81mppmZ3fK2c9eXYEJSiUeNZUPOfgiGqrgsR4LHNxkDDiqioscg/Pw/anMyuCJpO52LMeLmbaqFVYbxzvEKE+ZiPDXYn4zGwkYCjVbZtkWDoUUEcvQvizFCMNkFs/T3IHGNIGmchbHwGLoZ67wYAx7tSkd6vnFOSuBNmfyqGSRIg/+AWER5mxXIpeOmlWY1JYhJ9KpZgT3NnokYoQ+la/+bU8LqONkvYIzqJwcoQwfhsLe/ckrBqg7/eIEbzaRZje/Yo2XZT/LcO0WJnKbtQl9yZO2jhEOpXQrSeZ71Kw7b8ANAUbAOWKbnxVtZp6aRZmGrPtxEtwKOax5HjOvFj3DpI5j+qA6KYqc1hU4fsoyKMQ6XF0DVWbXMsLcqZl9t+oBOIwrYZkwJ;4:y27EI15YnH+THHljFGBqPBFxagZhZO6d64YSB+Bg5PXJxGJ9wSXtMQ+QkJfWEqDxHCvgxFeyBukBW8NIe/SkqIDN/0DhDhHcrl0hrzK1ZOMkxi9FB/tZVKmYUhtUSgfkQdfSvJpc3H/ycZtUhB5syKr98lpziTAqTpHOm8a3uaR/IrF78pOFy/u8MfSZg+efQVjq32Kb7Kg5n+aNEIYba2K6Sjld7gn6boPk8oTTF7yjmGiOkcVd51INYYn8ndxP0jnWzDjj+cjEq4mk7i6T+TnKH8lmqRvgzp3mkPIJ/THaH6cAwYs2aEk/Vs2Ur6jt
X-Microsoft-Antispam-PRVS: <BY2PR15MB016737CCD0F42E3139887DE1BE090@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(14444005)(58126008)(105586002)(81156014)(5660300001)(4326008)(11346002)(55016002)(446003)(47776003)(39060400002)(23726003)(1076002)(9686003)(6916009)(6116002)(6666003)(305945005)(46003)(229853002)(68736007)(6246003)(86362001)(476003)(2906002)(486006)(7736002)(81166006)(54906003)(97736004)(50466002)(8676002)(53546011)(386003)(478600001)(53936002)(106356001)(16586007)(316002)(52396003)(52116002)(33656002)(8936002)(7416002)(25786009)(6496006)(16526019)(33716001)(76176011)(186003)(33896004)(18370500001)(32033001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:GzYks1BCeq5PBNXraRhZbFLOZ27Nx7eYudfqUktSq?=
 =?us-ascii?Q?6L+LeZjxzBrKPZslK3QBNZ5eY64ZBKFcAoHMz483tfkOiwT3+uDfCmF33dNC?=
 =?us-ascii?Q?nfVpQ1BxraRdkHkKXwUs6e+uhdW07kmSkIxicyrqXj7jRdohr9W6cqIK5cL+?=
 =?us-ascii?Q?NOhogp36XXVdJ4AZi5fwVAnM/DtKfN5T10aba+U0cpin4mFwSBejv5t+V+1r?=
 =?us-ascii?Q?P0GUtyIJzA536LnxfSx4QYpPQK+gLPS01j91mpmSMNGOr3YQ4w9jfef0Xz17?=
 =?us-ascii?Q?tkCKcIxx0uJ5CQdEbXjyeeiJClHC+Q1/z1mClO0rmbeet5MOYjveiMyrdpeI?=
 =?us-ascii?Q?VbXU57e1Cq2ANMcX/ICVZSn4hy2pFZ2WKRv6uXykCDl9HMzBUz9zuYApgz1y?=
 =?us-ascii?Q?Z66bfhDnPFWXMgqL5soHd4D/d+5eooJXyKA+CcgggonAeFH9UPHmKwfIB4w1?=
 =?us-ascii?Q?n9poJ9/cBntGbYPEQtGU1d7V0Vl4tAuIkr5bwcCC0nWOs35sieXHmz9gt671?=
 =?us-ascii?Q?5zD+mJiHqJYHSexNPKzb8mmOdHbqPdUp0jWB1+lLze1oXaL2nSbEei26mG4m?=
 =?us-ascii?Q?L9HDqhW5Hf7Szc3zWI1CYXeQ3UoS4GFtpALYqXli1r3d5kAL87ZsKz2Z/lPc?=
 =?us-ascii?Q?sncooYebJq1HCdHXJbXy4J7zvVXD02pO6LkwZNuwFoI3I4oD18XUIo/toEv5?=
 =?us-ascii?Q?5X3+INRTJjYFrgzN/be989Q5oejrndA8hon6zKxb00Jp6d3EiPgEJ2qzgWti?=
 =?us-ascii?Q?oni91Znpq4PGG7uIH1uv5GrRudefLQoAE/+Mnu+h0TLdKUg7qS1VRHKOJGBN?=
 =?us-ascii?Q?dTNn3l7JnLLKc8U2O97smnPK0egVFGIfmwkWDAqwCXP/ZsDF18Ol4Ww0Erlg?=
 =?us-ascii?Q?0qaQCvG2YQOOuTRHDjBxsflBw5Knm75eG9WKKrS4Z+FUTGr+xeXFUX5KOO5Q?=
 =?us-ascii?Q?ltyp1icl4otzoc0LBLif/Q3pwtqMqQ3SDrUH/W8q4DyJlBcnACt9VvFtBPEb?=
 =?us-ascii?Q?3fyZUK33elSUh0aMmWOKgr5jgolinOWol2x9nq24Oew/91V3I+E4n3Jln4RH?=
 =?us-ascii?Q?duwTwFc9F4SJvWKsCCgTLpPK3QKsjbkNAoRd6ijN9BLAutB5wbJl0gWwYeHu?=
 =?us-ascii?Q?YvJwrRKajdxSMoB5qV0WsNctMECdzzs5ZVTyzjelVmdZqkmpQ7ccqO1v5TM+?=
 =?us-ascii?Q?nWs/cKmSXJGmGcK4uHlXTeel0WQBK0no8p5SPK1RFHbXEA/0JoQv/B0PdlAW?=
 =?us-ascii?Q?ajJPdAuv/L/6s6Mbn6r0eUboxrgFA1CU0rw2GZcNcIl6FVyed8dLzRrRkMJb?=
 =?us-ascii?Q?I9dLC0geyxHXiZPZybspwYnPvY8SaNq9m5V7kvmJ6eGitj0fZjLm58sbWemP?=
 =?us-ascii?Q?rkAfKxclKts6l+8R8C16F3VWU0=3D?=
X-Microsoft-Antispam-Message-Info: XcJcmOBdahEnmigzpzx6KUGq6gL44rggCDrSm8qETnzxORYqLZdVURHTMQaidiRO/FNkPB3BOYxdUqA3QM1lQg60g0B6fbDNI0dDSv8elmcfQeRWDy+/GDukJY744ctax9ldsc4F7DC0YcJWrP8cqTN/F0fUMIU6n1YlOMO8NAk7B+tE0hoQXcAT5h27Q4O1vnsXeKlFaXBcj+weXEN7q6qepR+WngowO8JW/JdlVg0mb0brtovzJ+6p5YUZg7N1CREm1OJdW3X3SNqnR5spSqmh8zUlCNg7RtUKnl3VpO44hwLHXAeCcHdfZhasxS1uoof5ZwCkbqBqoOmkne+TwvIFa59aax9tchObhK6D0hU=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:e62NU1oimIeiTlO9OoJ9dUlQsU958wAALcPma/NQXHooCIF34/yzTsJZ4Tab6h5KJsLumEeN/1UmcnrpIAwf1kI2aPv8UCQzFjwTS2OWOvbC0z9Y4kyDQYH8cWWqsOod04z1bfx0UMI2AYO7sIriz3+35nYeQN2Dh1TLhf1lkkHbW3kzE5PD6dEe56hKdRQ3H23Y8AnoODwy7oUAEWi8BVkZK9gb017Mg1ICrguv1X4hYbUa8WbIlCOgJi8/3sotrsor66tC+gpXGDfnhHIP89+9TvbyouY9L/QeyxUoxTCtDGiJMe+vUImuEHojfqAX6Ma15Sk7ox33pSwqQvZrDyvuXSXhhqAPmzE3TgX6UjSSc5YmAVSSb886Y3tfdBxghWPpDmyPd3W142rbbmRsxGmRxS8+x4Fse6rbSui6JquBpQuL/lDrlWsV93eckaXi6gUun2wQ8vmw5THvHc/JIw==;5:lRZvkumFIcSyYbiwPB2lXEqXIYnlJ3tzydcOmLhL8b5EjosBk6dFwPBuixodq81Q5PEx2IU+4enKroHnXS7t9q1jMcizxPmndGRkGqb3Z2tOvld4zcFGFg60qIe4DsgkGFQtxgDY1DikTOy4k2eiyY4+KhEq8uG/kWCJvWXiSVc=;7:YFzcgvUTChg8k4IX0ZEPw+Mt/2S7bs5him7Ml79C0/oPGmvA23cC3Ux39QEesrEDQMDx7ON0XlhvcUlHnSE5Yp9cyv7Ah1IGNrsKozcJ647H1wDFgIpxG+WsHqf8BNlGaNg/HatDwo3E12sKQ+pae2qZGcoXsrJYtAY9e0w1aDOsvONwU5kjK+Op4SJM6KWejzhDyb9FbSFjnSxvWMKtlzLcccoWOIX/U/urDkiznHDqij2lzOHuX4DUsJyFtRFS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:BiWG8ySzpDhN/BstWJ7TW8OQ3QVjB8HWHfbUH2WR2d60DSAUQar9gXPcT1fpItdH4tgifjm/24+a1VPE8547pQeWHc+DbZl0JPZX/qNRtKJVZh2aXPUTd88sacCHYBWNWzBFhksS0woE6PQyGymd6fS/2DTTrUfGcZb7thv+6IE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 21:33:25.4828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca44117-5657-485f-318f-08d60df70e1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:04:32PM -0700, Andrew Morton wrote:
> On Mon, 27 Aug 2018 09:26:21 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > I've noticed, that dying memory cgroups are  often pinned
> > in memory by a single pagecache page. Even under moderate
> > memory pressure they sometimes stayed in such state
> > for a long time. That looked strange.
> > 
> > My investigation showed that the problem is caused by
> > applying the LRU pressure balancing math:
> > 
> >   scan = div64_u64(scan * fraction[lru], denominator),
> > 
> > where
> > 
> >   denominator = fraction[anon] + fraction[file] + 1.
> > 
> > Because fraction[lru] is always less than denominator,
> > if the initial scan size is 1, the result is always 0.
> > 
> > This means the last page is not scanned and has
> > no chances to be reclaimed.
> > 
> > Fix this by rounding up the result of the division.
> > 
> > In practice this change significantly improves the speed
> > of dying cgroups reclaim.
> > 
> > ...
> >
> > --- a/include/linux/math64.h
> > +++ b/include/linux/math64.h
> > @@ -281,4 +281,6 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
> >  }
> >  #endif /* mul_u64_u32_div */
> >  
> > +#define DIV64_U64_ROUND_UP(ll, d)	div64_u64((ll) + (d) - 1, (d))
> 
> This macro references arg `d' more than once.  That can cause problems
> if the passed expression has side-effects and is poor practice.  Can
> we please redo this with a temporary?

Argh, the original DIV_ROUND_UP can't be fixed this way, as it's used
in array's size declarations.

So, below is the patch for the new DIV64_U64_ROUND_UP macro only.

Thanks!

--

From d8237d3df222e6c5a98a74baa04bc52edf8a3677 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 29 Aug 2018 14:14:48 -0700
Subject: [PATCH] math64: prevent double calculation of DIV64_U64_ROUND_UP()
 arguments

Cause the DIV64_U64_ROUND_UP(ll, d) macro to cache
the result of (d) expression in a local variable to
avoid double calculation, which might bring unexpected
side effects.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/math64.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 94af3d9c73e7..bb2c84afb80c 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -281,6 +281,7 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
-#define DIV64_U64_ROUND_UP(ll, d)	div64_u64((ll) + (d) - 1, (d))
+#define DIV64_U64_ROUND_UP(ll, d)	\
+	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
 #endif /* _LINUX_MATH64_H */
-- 
2.17.1

