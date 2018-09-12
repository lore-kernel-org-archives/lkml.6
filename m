Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA775C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF9B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QmBL+MgL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QywESVAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF9B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeILVbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:31:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55924 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbeILVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:31:06 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CGMhCe029613;
        Wed, 12 Sep 2018 09:25:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=4gzP2aHca0/ckgemEME/1FjDTzocxVlACcL1Bq+Wkh0=;
 b=QmBL+MgL/6hALD1WKRK2ewgn3HZ37wZ8MeKtWMQbTlvxizRqwXNIP7VG/MtsXRp+kUbh
 RGs0HamtLLrIlKxnQy+IlU8x1F6NaYhi1Od+r1brOBx5RBWSgxNl4usuQ0ccwQZ8HlOw
 8rx6j/ooL2SI1D30mpCpWTWE1m3fggJGWmU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mf2wprm75-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Sep 2018 09:25:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 12 Sep 2018 09:25:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gzP2aHca0/ckgemEME/1FjDTzocxVlACcL1Bq+Wkh0=;
 b=QywESVAFkjjmg8qBiw06DfZ9UslRN+3Tyc8A4QhGJg3/srPVTtXGxOgW2VCQEfBjYDdIEnJIh2lvAQPf8vQvQB1r1ju8d89iU7T28POzhSMQrmoMEeb0bo1Ntouowpsba0RSE4FMVe/1Oq5mvob5U4xxogz4PwDbhedUgWDMCXs=
Received: from castle (2620:10d:c090:180::1:3f6a) by
 BLUPR15MB0164.namprd15.prod.outlook.com (2a01:111:e400:5249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.19; Wed, 12 Sep
 2018 16:25:35 +0000
Date:   Wed, 12 Sep 2018 09:25:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180912162526.GA15119@castle>
References: <20180910215622.4428-1-guro@fb.com>
 <20180911121141.GS10951@dhcp22.suse.cz>
 <20180911152725.GA28828@tower.DHCP.thefacebook.com>
 <20180912123534.GG10951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180912123534.GG10951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:180::1:3f6a]
X-ClientProxiedBy: MWHPR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:300:93::16) To BLUPR15MB0164.namprd15.prod.outlook.com
 (2a01:111:e400:5249::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88418f1-4eb1-4947-26af-08d618cc5eda
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;3:G819DYW7neBO6kO676i4Hfh45N3Mgf4OwMZoOHoiuGc3i50f6LrQdHUMcytsrsrqYACDLQ0nC/aQnWQGPpRHFNlkzNYvRkpHOisqfEkEg8wPYsuj1LcouJIfisVy8iWL4yMZr2YJMoFQM9787YvX7OtmllgeJAlaVBM3L61MuZRGnDWQUyNKlpjpy92hkUtcE6hdNUYSVdeQMm5y+WWa4sHoBFmlAGk+GtwLe+ea5aNJIS71KXmRacXDEgTyDYao;25:GYJmZJODwumEEOqLtQ7YYWK6IGwKWgmGOkLrKpqiTeNYwSFEJmrE83E9yQoQtCdfEylhzk7KciBq5n0+hQguS+f9KTU68beVZFzX9wGRB9Lh0T/rqZX8jB4l6S+lZu7byiVeLMhC6R4Tau9U8qAY7whyINDvPwkIOux8CiVfWYOCo4m3iT0FVBTLbfoItNoRSxjVR9P/tb7NV6NppHdeI3aE3brHVFscIIGEk1k6SWa8XFaAENKj1hyuj+o7ME5+OriiMO3UZ5/evG10Pf3qN4bc7UgOkyg8COfoQVl/PuGxhhyl2yTp46o2EYHghIOqXg9OvTMpUWtKuCWUT2kgcA==;31:wek4gck/UIx5uZF2uyt1Z74HnvKay7qyPX7GVWuZ3BSbXg1TSLGVMbjgbxZYtoik3ehEW1CiuvzhiyAFmNqc+NI+IhycHnm92CHFp//Qm0aAu/Ii6U1FNoTu2KznVj7YxLcS8/bbXYOEUZoGWqr9JPH2+MxZ9BMsOE+6/fiu38/e5hVMf6YlRDNER02sMk5FfTWmd0hUyWtg3S+nSRCTrGjdONgn88I644I8RT11sXA=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:EZsuPFK9u0cIp7oY3k78PjOdCJRnMVLe/lO5FiKaPUVA6Sm4U4IkGcq5F7EkIUylE5G8AiFUJMfX/ULOtPGOz6b802EeBkJCbu1E+vPSO6JxJNMSukOYRrwbEBY4XBN6DMGsiu4jPkEgxRpHQ8kI4cz2fK2Ud+SkWIznq5ZuufVr5RYzQtfK0ZCdJhqunIBvowc8QlYdI7ouDdARksY0GpV4rfUx5hCoUcxJs6Yzfne29e/9MwryuR+Kc7A9DnixkzIQoA+QWJ5GTRDgRzshPEEaG1TbBny6OwBb7CTiJJbCoD/Rmiv13aZMVvpts7EYksEGz7F7MvXLYbB8fqglqBi2jZJA8yBTafIV6+pBVqesNE068QPx79Wsc/QtjFaSpGb6KP3otuUl5pFwcr4toiKDBrmeRRcR8xrWhFnim6852HG73vaUyuw0vaHzz+6MRBGU/PiOKcx3qJnm/ee72SF0QGONNa8nw8veb/tV1LMs6WgLLPuvQPeKosBlRRQJ;4:cjFI7mZggpTUCB0Rl7sVnL1bkSn0Xb2lmvXysfKcmoYm9qM2M0yOskufLFzmPofS49XaDPnj46kHDcCIuhO6Q9P0HZDpcNesD/LiCJFNyJN94YKwNtbz03/X0BoY+IZn7OqP6L5lqG1MMACJe5c3Hn/2Nn2SbgJlDpKZnSrIyIhbRCL/MQOc4wAztGPRn/RoyqHLT/h+tu4w7F/26X9Zl1N/WtahSlVK+Ls2WQUJmDAQVz5PdYGA1SDtcGse6DCSsQYbk9LNhcX1CoFON5d1lg==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0164A6119DDDF2F6B9F69F32BE1B0@BLUPR15MB0164.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:BLUPR15MB0164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0164;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39860400002)(52314003)(199004)(189003)(1076002)(53936002)(47776003)(7736002)(305945005)(6246003)(186003)(16526019)(105586002)(46003)(4326008)(106356001)(14444005)(39060400002)(478600001)(9686003)(33656002)(476003)(55016002)(50466002)(446003)(11346002)(486006)(33716001)(6496006)(33896004)(58126008)(5660300001)(8676002)(68736007)(16586007)(54906003)(52116002)(386003)(81156014)(76176011)(6666003)(81166006)(316002)(2906002)(25786009)(6916009)(8936002)(6116002)(52396003)(23726003)(86362001)(97736004)(229853002)(93886005)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0164;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0164;23:gNc4AavGO1chLi2UfjarSSno4xemePUUXuNJ2Nvhu?=
 =?us-ascii?Q?SuhfSZrm8NDnZJJ7l/TtOlai9wtL559O7r5CaF8WiWmW57PJu3o486AHlTm4?=
 =?us-ascii?Q?OaBRAn9LxgOvjBtCrU9Thmboryhehg4ZG0GHwiphtVm2Gf+NlzcWqANq10rG?=
 =?us-ascii?Q?4neEMBHUmbFlJcSjV8/ppyfKOJ2pCpeZl/Ft2jZuGx9cBApVvDWX4Vj0UhCt?=
 =?us-ascii?Q?trK4+aNKBIzrbY8t4pwgK+JTsgiPa3fhpRJcxs5/8hSpFTZOuK1/GnAOwBUB?=
 =?us-ascii?Q?dUUJs3Hk7dDBaXq3H7g3IFZTdaBp270+DJat/EbW3HamIexzTYl6OJOFgB55?=
 =?us-ascii?Q?Hau1xR4LTYta3CI1mpRimbXufGcVBSqOtAGeDQLODJW6bzn2hw7FBKIfh6lm?=
 =?us-ascii?Q?ESqgGlSu59OhvLobkQL55csmAOnCm6mBdKCCtK6so1D2L/BiIn9HgrMKlgMX?=
 =?us-ascii?Q?uN04ENbMR5D9rSMEc7TJQ/UL0ZNuq5J6JZ1GCQoWZ8gJdKkV3Gu5G2Vd3XbC?=
 =?us-ascii?Q?Vl3quffMnAYHqBLbCLliK2FJMBvkyemVozed4bJCiy99JFl3CuI+OntVyF6m?=
 =?us-ascii?Q?zKcp2soxdLheKIVEUuX98uTXuwBnc86j6+F7LPSLIq9kaeBtuL5TtG3gxfbF?=
 =?us-ascii?Q?GT1jGHzKj/Qrq/lER5gOWgOfNLH3St7RZ4+o7NOwAjhqzhGz+RQehdjY4ZBC?=
 =?us-ascii?Q?1zR16AyCxh1OsrH83pyAmbIBry5MFe2BLFHWioXAmFxWPpzeAN5bvRkLDt44?=
 =?us-ascii?Q?UMtNGjnsmjZGBw/1vL4fYN4N7YLn98nLkAHS/qhK11ITu8LCHGwZN3iOmO/X?=
 =?us-ascii?Q?n09sZl1Fbeh++ugp8WuQEZWB8sqbxtQJMpx5jzY4+DUP9V/zAI8RSmfGc/qU?=
 =?us-ascii?Q?mHsIeCIjLUZeZY1rHX2mYo9fCGb59Wu+N0EMzKjlGWj7R5fr7BJylySxS0r3?=
 =?us-ascii?Q?5PFgwvzo2WTGJRgZaX4u6shR/gK/JBlACu1jbTOphe4nl3JjoR1TZn4c026s?=
 =?us-ascii?Q?eDv/pgmZ7lWzR/8gBXHjeol9u8xzDwGBm6yi4TlUAUN4maXoHqkXtHlDRMgj?=
 =?us-ascii?Q?WCHEjV2xUYYdvNR/gO3GF7byKyOxjGxPLIMiliJ0Cn9wdG5m/JjYbOlYohmf?=
 =?us-ascii?Q?DZ6eO6PpjKpMy6Z74BZx0+if/2HiggMCknFh1oWa7CtiiZkQfRYpkmhaCxsu?=
 =?us-ascii?Q?7gBJi2ebmMdvmaVseFslbr8j4YxlvsBt6HuKq96OEvHeliCbrCR0XRhB1QR0?=
 =?us-ascii?Q?6Plxwr3hiC1Z1hyaXDgqtwGQDMoLMm1zYxpT8fIPoc625fAgKx1aW6yfAKGh?=
 =?us-ascii?Q?twFMGsc6cA8CcccZrul9QtsRrp8ZX4J0Un09v+16ZqII55ged3aptv7Cg2Ca?=
 =?us-ascii?Q?HhYKw=3D=3D?=
X-Microsoft-Antispam-Message-Info: tHTptKUf6uUbqpEkVpPyjqFLj4/OAbR/R7GLexh6atM6vYEXNeuZNmF+Z5138K32nfdaaX/LB69RKi9ISdPKEoPhFEPN7UacqJZymjnrn8j0sTjNNhLIGoYB06b7XRMfPlemRGYAP/LaRBYjBTT++Ibr2Km//RpuFf7lS5gSc+ixWwoqtkJlWrbhgWc6c+D5GLW7uGBG7ln9liY9ZKpkUOrvu55Qom4F8gpyjoFkWsEH9zhVyeqZVgyRIeCBOxSRPzKtcWk7euBkw5j43sa5HNKJRRMTphoEZyYiTyW+I/1WmaYmZkfziTW2Vuzt5uSEayTUToEHd7jTHivAFnoVicITlYYCnT4CwOxrUM7ZmVA=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;6:K5ujx0S7UofcMNS/GUvj1blEn8aTCbYM7tc9HPNv1jwujK05y8K17b+87730gWdWa5QyRjJI+Dij08rVlxvAjaRKORIS43LnsIEj4mpptZSMdug5OVQwJ8IbJfxR2RlSmxFfX6QACzU4WkujvBpN2F31EFlXLJ/IfjHd1KNm32qUZzCGoWnm55xZWaj5bBG2REnNkTDN5ito8+vH8xUWbINoqaZQ5+ejUiq9KMn311Rbngn9A7flfTPQaxXd1R1xmn+5SkxhWOJ1y2fpSx7VuYIAo3HwAURyYifs6zVXWb1l41DY1YglxP4Ef2iDfkwtqpzCsgevHG5qtfDboC/U5tnXA5GGaU0anfz1E0Wdh5oyvpKQooGfoTVfdFtcc7RFdIfjyQD+z4VgXAhTtvvF5kOGprphvF/n1qOvKnfAqP2z34VjUHSVPXWc9gsREtiYmpqFUOFJzSbnOlm6SOH3mQ==;5:73sQpMh6z1HcBPCxC+/C8brILD35Zfa7X0mSc0teg7aYA17W02n/4T2VBKXj1f13JplV4YffrG+9VUi0hrWuLThSJNnMmL+OE5LVysBHH5zEUDOdXufQViM4VGnmJNWnV2yOdDaHS+YgiN3DPsK+fk2psBMZ/IgktWbtdhwXJWI=;7:k4virHjqnrp1Mnp3iIg8xnEFWl+PKpe1EZ4HHnt29Re+jZpDeu/z92NCkE/7dZlZuWdwW9rD6MZ7S7wGiDioT8RUjY75niSpXBsUueGiixHTTKnwS24hpGa9uSa/uR+xSxLoa4d/LA1411+l07WTAOYRuafSCQ89FvIrJhTbzhUGF5wpfmmnJ6G/Ekcs1lyOvdcljnekGbBzFbAdZIh0GL6JBkmYuQs501TwqNahJkaVekPUgaD2qA52+YYV+uJp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:5LqejWlkD13Mqy+UKg3aryp560+hAmAgD1sdMYYgaiCaFL6thr6nTJndKNYXLkEBVpfNYn77mnboCIYvat4FfXPJdNpC6s9v3XK6mMgbvaUIN90DT9N63G+62ws8KlLlYsTzHS8C1gEfgLZ8+0WW0sCHh3OD8SHkMdSAVfIgtCA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 16:25:35.3835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88418f1-4eb1-4947-26af-08d618cc5eda
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0164
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:35:34PM +0200, Michal Hocko wrote:
> On Tue 11-09-18 08:27:30, Roman Gushchin wrote:
> > On Tue, Sep 11, 2018 at 02:11:41PM +0200, Michal Hocko wrote:
> > > On Mon 10-09-18 14:56:22, Roman Gushchin wrote:
> > > > The memcg OOM killer is never invoked due to a failed high-order
> > > > allocation, however the MEMCG_OOM event can be easily raised.
> > > > 
> > > > Under some memory pressure it can happen easily because of a
> > > > concurrent allocation. Let's look at try_charge(). Even if we were
> > > > able to reclaim enough memory, this check can fail due to a race
> > > > with another allocation:
> > > > 
> > > >     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> > > >         goto retry;
> > > > 
> > > > For regular pages the following condition will save us from triggering
> > > > the OOM:
> > > > 
> > > >    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
> > > >        goto retry;
> > > > 
> > > > But for high-order allocation this condition will intentionally fail.
> > > > The reason behind is that we'll likely fall to regular pages anyway,
> > > > so it's ok and even preferred to return ENOMEM.
> > > > 
> > > > In this case the idea of raising the MEMCG_OOM event looks dubious.
> > > 
> > > Why is this a problem though? IIRC this event was deliberately placed
> > > outside of the oom path because we wanted to count allocation failures
> > > and this is also documented that way
> > > 
> > >           oom
> > >                 The number of time the cgroup's memory usage was
> > >                 reached the limit and allocation was about to fail.
> > > 
> > >                 Depending on context result could be invocation of OOM
> > >                 killer and retrying allocation or failing a
> > > 
> > > One could argue that we do not apply the same logic to GFP_NOWAIT
> > > requests but in general I would like to see a good reason to change
> > > the behavior and if it is really the right thing to do then we need to
> > > update the documentation as well.
> > 
> > Right, the current behavior matches the documentation, because the description
> > of the event is broad enough. My point is that the current behavior is not
> > useful in my corner case.
> > 
> > Let me explain my case in details: I've got a report about sporadic memcg oom
> > kills on some hosts with plenty of pagecache and low memory pressure.
> > You'll probably agree, that raising OOM signal in this case looks strange.
> 
> I am not sure I follow. So you see both OOM_KILL and OOM events and the
> user misinterprets OOM ones?

No, I see sporadic OOMs without OOM_KILLs in cgroups with plenty of pagecache
and low memory pressure. It's not a pre-OOM condition at all.

> 
> My understanding was that OOM event should tell admin that the limit
> should be increased in order to allow more charges. Without OOM_KILL
> events it means that those failed charges have some sort of fallback
> so it is not critical condition for the workload yet. Something to watch
> for though in case of perf. degradation or potential misbehavior.

Right, something like "there is a shortage of memory which will likely
lead to OOM soon". It's not my case.

> 
> Whether this is how the event is used, I dunno. Anyway, if you want to
> just move the event and make it closer to OOM_KILL then I strongly
> suspect the event is losing its relevance.

I agree here (about losing relevance), but don't think it's a reason
to generate misleading events.

Thanks!
