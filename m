Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F62C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07C320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QBOI/UM9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dq3IV7lT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07C320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeIDUAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:00:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727721AbeIDUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:00:46 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w84FQ1J5020440;
        Tue, 4 Sep 2018 08:35:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=tdFOzAyIjyBliz+cD4/U+KEo0ud2gCKGlS94SJPiRI8=;
 b=QBOI/UM9Mhl+nPmB4BYoKdNPzKKhEVYBcVuacDoDPKQPRnHu7e2/Ht7iYaTu94+qZsgd
 FuwnPszYFiMb8pzy6I7zjUj95Yj0JPfheVUyF3kjBUGcOPz3TkTOSON2pyZ+i253pVKO
 jkdtwXqwlxvIJbttrJyanTe+nQSW3nIvgFw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m9r2j8py0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Sep 2018 08:35:00 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 4 Sep 2018 08:34:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdFOzAyIjyBliz+cD4/U+KEo0ud2gCKGlS94SJPiRI8=;
 b=dq3IV7lT5Pqo56KITSlHFYxY2KzWRbBZsbIYbp+Lg0Sjlh/bpsYlPqlin/t9lMz33Kujjb0wD/kP6Ez0dAzwdHZtszYVIedz1m2A/irJ2N9LjgQh65t/IXJmkxkvOS51TiFb86DfxeCOwFmkazDyp6mzM/MJ3oB61XlhnmxUdrE=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::6:d497) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Tue, 4 Sep
 2018 15:34:53 +0000
Date:   Tue, 4 Sep 2018 08:34:49 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Rik van Riel <riel@surriel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
Message-ID: <20180904153445.GA22328@tower.DHCP.thefacebook.com>
References: <20180831203450.2536-1-guro@fb.com>
 <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
 <20180831213138.GA9159@tower.DHCP.thefacebook.com>
 <20180903182956.GE15074@dhcp22.suse.cz>
 <20180903202803.GA6227@castle.DHCP.thefacebook.com>
 <20180904070005.GG14951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180904070005.GG14951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::6:d497]
X-ClientProxiedBy: MWHPR22CA0049.namprd22.prod.outlook.com
 (2603:10b6:300:12a::11) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73dfbbd4-c9a9-469d-31bf-08d6127bf680
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:d/UxLI/dlhrjyHo2FiZAdEL7wZ2AzFWMxJhS7jkzND0t1KyrlgIuAvHNaYmdXHBEabPyNKDRb2uNhPLne6XVPSY9ZVlcfWVNS54CvMPVRSDl7KpzmNHLf06FbscsvCibXuuWqjZWQN+Z9v3tmbDDUvjg/emmWxNegyjfdhU/wH3rjgOffXEj2Vwr/+Cw80Jz11i6leAoGjI7wky2R5TtHyilBcHYjG9BBrkEcOql2JdmZdFsjkjsIi2BKzfJx7Wl;25:GYQT3qNkp++kPaksV/Zm11PWB4eIblS+8d/hOARjwvhUa7bTcp2WtksSiLY13aZf095NtX7YSCEZUCtOCmpONwUQkYlJ+cU9LdQcToR3EBDdHmuQOfzKLUYYIVqKaO1rqC8vNagoXEFTLRM8fF61jZ71Rqy2zZEjVqf8rJktOWV00vhwCVgOdBCCh+dIt0mybC15orQEaHVr8ZYarRlgwUep0hQ4NXWxabDSa16aagi2uBV+kLfAtPbNHblCIjjjP1S8NGsYGkeCK+fS/FWAs1sx6aQ3pU1oUFhw0sGYKFedeY4g5gomi9pUOyj9fKDXequgoB1VcoUFCsRtc5heWA==;31:h8muPw8OdEcoUiTZ2TAssAYp/rydXU+H0MdwuNPy6Izl+xqrvH+nPex6I2OnBPUSbqEMahB5Da5nJXB+p/lD+R0BOLYaG2aCtrhw4UGW2Kw/M6K8vde4JsF1eCNR+FqGJVnbdttQVITFEfBhfMAxaEnUtaYGR3uPCzY2YAPxrfT0eXYE5uJdARdxfteeKhZr2Oe+aLzeZonQJYQYkWIxjDVD4+u2nyBpYEFLCQw2vTo=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:qIGCWYaPuRbSE/Ug+oVXNP1Epe/ZbeH5dQq35osj3cmgH4+kFJXjfOgjKd8DkMiqdAHTa8ikwcTaPeA0Cwh5S0nerAsucLVOdMW9nvU03gS9OGhYNWMFQ9iYYQS2TBwOkOFUZXj9Oy3+IIS+wD8Q/WLE+YR6ZeO7SO0M03Esj1z955XkwQnR0smpO096lPdyh/p6FiODZpbumorCvqt6EnnN6rdAOa04jZIQIaaVtdFw/MbnkCIxomS200uHzCPDw0+liHLIOxqubL/gVxLY/OWe9dU1aNwvsoznhKg/by/pBS7lqdjZ+o5HGrCmnmcoRfypZK9p/gBO491JrlLknbs9ZYeq+QZC2VssjiS70FS5tlmfhkIZS53RPt3z3Km+9EuKsanH8fEcHZWiMQ0xO4RCWHbd7h5+LohS6htDgiREBk1OFDZJKYp/z/92lsy606ybQvVfJcQDfh2s+YsydLFvRQiEhXkVsfabUAbsAjMGWEqTF7FkS36E7acpeUhw;4:mVKlGN8uw0LQEZwX/MLV2dBgYKu1F/Un3eJikbHMq4x+Drz7zVnaLbwepTfh0NaHDLrhE9TrEHNqyscW3FZJv7RUkpLD9zrHSj9Pg/oqnTnwXa31/i8Tcy/9EToPfmUPiJsPEvvwiDP0XW7jc4+G1pqJfJ8drSEn9Q8hrBO/fBdYNTpOA+0fUmgcm4ziKWPPX/kpFZcjUS388pk8RXYMughPE18oVihJS561WfjTq8lDbdWg7RUdYAqt3KfjZkltZ3GvmAPkwzwBZyhtPvwPZg==
X-Microsoft-Antispam-PRVS: <CY1PR15MB01706086019AD1044C2E07E9BE030@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(97736004)(4326008)(106356001)(25786009)(76176011)(52116002)(7696005)(52396003)(105586002)(86362001)(229853002)(93886005)(478600001)(6916009)(6666003)(53936002)(9686003)(14444005)(5660300001)(6246003)(55016002)(2906002)(1076002)(23726003)(81156014)(50466002)(81166006)(68736007)(7736002)(8936002)(6116002)(11346002)(6506007)(386003)(8676002)(16526019)(476003)(486006)(186003)(54906003)(47776003)(33656002)(16586007)(316002)(446003)(46003)(305945005)(58126008)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:UB0BHd/neszbv0ecUntU+UFf37iSgrP8xSD+etQxF?=
 =?us-ascii?Q?oxhtuQPiao6BozwE853QgI/oqnzw20PXd6ELytYtaQUzl8u2Rxl/F48s7484?=
 =?us-ascii?Q?zVNPXpyPVh+ZqXcdJlJIkHWO7C5/hCWsAlL18+b4iyJTmryqS5dSDoz+0vCB?=
 =?us-ascii?Q?eKcxfQ16wZhJFSuyA4IqicT4Li0TribTBXJbnBvSoaXum8YfYSR0dLyzIrca?=
 =?us-ascii?Q?TYCWtlS23cSi0NSWzIP7UTy+u0GepMQfFo3ix3W6ZuQzWwmGGxKuBVHhShga?=
 =?us-ascii?Q?SYUf/sqX5S5MpaOSBL2Pifw9Z6hNt3zTs//LVmsjjk95GuaoQw2gEy094vyF?=
 =?us-ascii?Q?O/mpJxbZSdmV/uNgDe5WdU7yeJtAjBJLxnrSA0ZtHdpuVEVkizejLKJRQSZ2?=
 =?us-ascii?Q?0thpnbt1OAsOuPgTSTiYvHK+tQf+ZrybcZTYeA1HG0QoaN8+s+bn97iAHE6B?=
 =?us-ascii?Q?Fsimj3Qv13RzIWNI1uCaTEG4FRl07X79Ij59fKBC6kpuk3jTW188sSl78g3w?=
 =?us-ascii?Q?4vMw2Z/DIR4Vs3IefVosCjlbBAVFlypmx2g5RUj8Ptt++FFFCtiJM64vmXxO?=
 =?us-ascii?Q?wYrSpPtqL7TzwXxpVEFkgcdPuyn7yi+L7fGy+Bl4Fp0XJNcqgr9STwa4G0zt?=
 =?us-ascii?Q?sd5FT2ENzwcoqb417LyID4+MalD4dqdqndWwet3LFNrkRFTWe/ZbKT+HeKkj?=
 =?us-ascii?Q?AwIWwdBd0/xtz+l/qtPH2lLdVKU0SRw4d2HwmtymVZt54Q25pJu0HMupHYIj?=
 =?us-ascii?Q?FCCJxeJGyFAEzlSPn+Q8Z9UqedeRzPjVWju7ikPHkyzFmT9GMXOr3+doDzdY?=
 =?us-ascii?Q?4xM0djv3yrWZfhkd0vTyQLZtz17Na+bc+b4ljFP7DuSkTdV/AEg2yWiOY4W0?=
 =?us-ascii?Q?/nv6lO6BVqEBFD0vTjpc3ESOOCHCfoFklZeTnvKVjJADYA5i1LPVaLcHiF3B?=
 =?us-ascii?Q?JgYiad4hSGXJ3yaStquIYCInCnqRbFGdGht0TsbZDa/FYmusgVuslZFjjzje?=
 =?us-ascii?Q?QQNqHvdkW61pBzOiAZOR+hRincTUDm8ZVb9HHJ5XunolLIct4SU1+pkaAuBp?=
 =?us-ascii?Q?pgse9UL6XJYjI3+omxiw7KVz1WwpwiFrnZtFSDyVB7JVOwmsMSOzs3LvJoA7?=
 =?us-ascii?Q?nOkfr0IblmlzdCc7/tBeJ/RtCtChDbbiOplYQGz8YwkU4ACJk/il5QKWJaJ9?=
 =?us-ascii?Q?MgW/bbwRpkDoD5wQuoG3jXp+VeveLMJ8LrnL0fvPCCdPoI0aM0B7iC+s9/HS?=
 =?us-ascii?Q?WQFiKYDXQwaXi7jCBXre3FUWd+fU9P7bv2qUYXYMWINlp0pUz52EuL+iheTu?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: eAqKuq4EEGmhGqoPyQpNEuNhVAIsq5Srh+S8uDPM9T/kphuxBM81XQKs0fdXIZJgf/s0IyofAZZGnAa/1ntIvOwj6VD0iusWO2j4q3arBIpBckFLSv7HJ6bMv+oGOgLNMMvwSRWvrO4hefgzseS77QtcGb9g/tZXs9yTCssbhfoGp6uxYfUzbq8WcEyo3VIV2gp+1/oGgsYdCt173JeddeFw2FAwOQcm1RqFefrbu7vpsoNRIuFFHha1NRn6nHqWoV9dN9XlTFuxbmRXtGamfJqKWtDn6zJVe+fbloMDkZfPjqzM1LmMCTG07LUXlscjN4CggJFEiP4g8rqOH56VTsAMGIFMWjG7vYJatyVc7ag=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:HlCWKGY4ayIlFbwnshtuqpWRLEnIaAqRAZMQdXe4bs0AeEUc70IAoDS+QpXioj7R17LJ8F8L9eMfgSf6Q6ABrV+PXL7GN0S00MAWf/NocmmAp37OqTD+girqnUxIOLx7at7YPDeFQCXOXDoSWlObsKUS598GriUFOQ/bnmVYNmaMCQUmdbSmshFhUlycSIizggoYiJau65EsXMkA+nWelR/X8RoJscVrtIxS3IvjaggyJQKmMvh/A8q9L5H724S9w0HMHcXRVPeEWDSUyW0vVQspMgoqbMgJZCK/v3LXgk8h1Py8zH9TbExneT/1XUhvMTyR16PoYXeoS4QzXr/I+q8LC9FopndJoFcUTGse+ZAa727KhUFvtjlO0BCFK4NDuNSVTRKmCpZYOQqkhhmfeumfM6V2dkG6t5MGWMv2Uo3PqrO3WydHX/3urgvcc4GSkyOBcQo3PlQKYEzFV9ML1Q==;5:++My6TILwMWYgAUTQUZkN0DnW1Egk7BR6OPq95B19yF+SMivPXn9CWBy0n+Ikm/uzdvYkCLMAcU7KjNOn9D4FTa9vCBy342rzXzlmbVVUQ3ezQvFyddwWcv4ghMBKuJm5eTrGxqIILS+DSfZBU3MKQY4tmjqre00/c0hA7W/7oU=;7:j1Fg+xjW3LaPu/r4UTFiBUnkhOl2hmZDjmqG52a96ucopsUoozAuvAOLyx/3HQl0QRJruxOLSWobm0CPER1a1p5qfZ9r31KumUZ7FgSWKlS5X3o1cizFSeYY+gZWW6lX/N4T0Lkl5r0IXM8lA4obFVKlIy6rXjs9LqrBBmKdVeRuzxh6mrvcEP8BdiXQ37qrz7wuCSpOKqrOCYlIgNms+PZOgDBXICuV6TtpxVE4NWqnwKLxAeC7oYspOU3oUJEo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:B42dIJ+VcyVV8ZG5lqhG7EGAox1QDFdwSj8+3DTC/lHxOF7YigBcN3E859DlIa7hmzrFyETq9nMOUtWzTlqnCteE751aonNZFAevKRdaPFL0VKsyHYmjuLwy7N/VeFbLmq1zaYP+jjCatd/gXhovuMt7zDyRZvip+PmzEr9SAUw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 15:34:53.9733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dfbbd4-c9a9-469d-31bf-08d6127bf680
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:00:05AM +0200, Michal Hocko wrote:
> On Mon 03-09-18 13:28:06, Roman Gushchin wrote:
> > On Mon, Sep 03, 2018 at 08:29:56PM +0200, Michal Hocko wrote:
> > > On Fri 31-08-18 14:31:41, Roman Gushchin wrote:
> > > > On Fri, Aug 31, 2018 at 05:15:39PM -0400, Rik van Riel wrote:
> > > > > On Fri, 2018-08-31 at 13:34 -0700, Roman Gushchin wrote:
> > > > > 
> > > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > > index fa2c150ab7b9..c910cf6bf606 100644
> > > > > > --- a/mm/vmscan.c
> > > > > > +++ b/mm/vmscan.c
> > > > > > @@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct
> > > > > > shrink_control *shrinkctl,
> > > > > >  	delta = freeable >> priority;
> > > > > >  	delta *= 4;
> > > > > >  	do_div(delta, shrinker->seeks);
> > > > > > +
> > > > > > +	if (delta == 0 && freeable > 0)
> > > > > > +		delta = min(freeable, batch_size);
> > > > > > +
> > > > > >  	total_scan += delta;
> > > > > >  	if (total_scan < 0) {
> > > > > >  		pr_err("shrink_slab: %pF negative objects to delete
> > > > > > nr=%ld\n",
> > > > > 
> > > > > I agree that we need to shrink slabs with fewer than
> > > > > 4096 objects, but do we want to put more pressure on
> > > > > a slab the moment it drops below 4096 than we applied
> > > > > when it had just over 4096 objects on it?
> > > > > 
> > > > > With this patch, a slab with 5000 objects on it will
> > > > > get 1 item scanned, while a slab with 4000 objects on
> > > > > it will see shrinker->batch or SHRINK_BATCH objects
> > > > > scanned every time.
> > > > > 
> > > > > I don't know if this would cause any issues, just
> > > > > something to ponder.
> > > > 
> > > > Hm, fair enough. So, basically we can always do
> > > > 
> > > >     delta = max(delta, min(freeable, batch_size));
> > > > 
> > > > Does it look better?
> > > 
> > > Why don't you use the same heuristic we use for the normal LRU raclaim?
> > 
> > Because we do reparent kmem lru lists on offlining.
> > Take a look at memcg_offline_kmem().
> 
> Then I must be missing something. Why are we growing the number of dead
> cgroups then?

We do reparent LRU lists, but not objects. Objects (or, more precisely, pages)
are still holding a reference to the memcg.

Let's say we have systemd periodically restarting some service in system.slice.
Then all accounted objects after removal of the service's memcg are placed
into the system.slice's LRU. But under small/moderate memory pressure we
won't scan it at all, unless it get's really big. If there is "only" a couple
of thousands of objects, we don't scan it, and can easily have several hundreds
of pinned dying cgroups.
