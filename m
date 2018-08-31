Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D23C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3932B20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Kb2VCbYY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JzLqz45+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3932B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIABlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:41:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52538 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727248AbeIABlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:41:21 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VLOZZF020628;
        Fri, 31 Aug 2018 14:31:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=CJY8HWfAVZO4+AhYYZZQh4/ZXTH1Yo0+W2HEYsjh/7A=;
 b=Kb2VCbYYzD+xQ68g95V7EGxuaBKCyF7E/ApR5y44xl1WJc8nNAfuawAaDHvbmvb5KtRp
 mpD28KpI5M9X3n4gGGV7KFk6ek7fa9ffX9XtlkrWoKW75924VfDs0/tJuI5GYaNQv400
 +eWwp6xiMaAw2DU1j83XgfntiEmsq5zNxkw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m7cc1r74a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 31 Aug 2018 14:31:53 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 31 Aug 2018 17:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJY8HWfAVZO4+AhYYZZQh4/ZXTH1Yo0+W2HEYsjh/7A=;
 b=JzLqz45+G2JUmwKCO0wl9aXJJbCeBHNF33c/5BSuYE9UwNNLeTnCj5in5UoOaJOT55rPLALjK9aPvtnwm9m8YWmwvvL+EGUNgXPE6XuFzhh31NWmbnPH9bBl+0TGGenrNYQYLRbFwMN9I8kMHWYbILXtRZlfETJDx/7pj4toqG0=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::5:da36) by
 BLUPR15MB0164.namprd15.prod.outlook.com (2a01:111:e400:5249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Fri, 31 Aug
 2018 21:31:47 +0000
Date:   Fri, 31 Aug 2018 14:31:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Rik van Riel <riel@surriel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
Message-ID: <20180831213138.GA9159@tower.DHCP.thefacebook.com>
References: <20180831203450.2536-1-guro@fb.com>
 <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::5:da36]
X-ClientProxiedBy: MWHPR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:301:15::33) To BLUPR15MB0164.namprd15.prod.outlook.com
 (2a01:111:e400:5249::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d0f990b-c992-49c6-2e66-08d60f892872
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;3:tQoa4OeJ+tcjjMYcT/Fyiatkpq8PMKn3b2ftwdTA0Re5x0NOBCS8DKrAJwMwpHdUW7Lg1ji3ht/4nVtzIc0sjxZEpCbOIANxBEfoyC9agghhbjWg1hcJQCl/9QBpczzuEhzHOawUJu0bhWAm8pc5VGF81TuMoLDJW6fC3R/4XfBK7rIJ3ZOU/7j4/Y/0/kl69M57K+If88ZkL6HF2LAPC9gt16xRD6yCJV+zJiwUpU4VcFS3Gsh3eLwlVKnHSlTt;25:lhU/E4ecxgDAq9nPbfamdzcOoVyD9H1RBn83UJFeX17s5eJXyiaY2VgMY3ufM5FryyLUw6yBVzF8UdVIesNii216+pRIiMvbNL6fuNM3kPAVb3jrWRZnFZHWhHgbeJqyXDQIoLVSmSg8xfbMi+4sszjpM0NE4cYJa4RSfhAL8Ywq8zzcoCazbdRHtFEAioWyc0nUMo+X4o7Kf9ECaJq+hEmS6dRjxta+JZpk2NLoJ09eElkXZvTkQS9rBmwfaeC41RbzKmUJUwCJlfLxdjVmkF08V4PCPvOMFlf4FKwd1drQ35Db0Yrez2fJIAsVNi2/r0sPhnj+p2IC3gd7hA5T6Q==;31:xwJ39xAqI1FLY7il6QbyvFB7AzdSAFOWo8YcwYIlmaNiks+DCorSWWFQOdCPGCottDWZqe+szk/lp88UXXGQesSFnAHpwsTwyuRszc6XQdD42By/MWp0tH/9HgzBCA5K0+Y4OhqBBygEKDMah2prZwOO84HYE2wAwOIBHNswkV8F1nsHYUvc7cl+1P9XDJSH9zPfPau1L7s+TZaYwPNPvPneczs1UmJYGGjjK2bPFQU=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:WZAb4jOE5PlLVL0DlXBdr1Y73SzwdreDhAl6uv1TgcLp1DJ/35qDHWeDs/Y9A0LLLkWDOAEg9wh5n1sqvETh3TJv2p/888e8F423LKn4048X+R3m+2Djcqn5/7nPACbpBrJsxtuicTOCajVQIDyvvS1DNQhzIVLsNfkc/q43IHVwoDgl8DWP87obZGAdnaF5IlHgb6n/8sROqtqRjCG8oLUToOLudsXIY/Tr0jUn4TjpE9lH0vyCqw5bM0DRBAsvRuS2bCeYq34h0WIfNwuCf7XJnovHXhe+uAAuol9ogK9cp7fmGhN2SQcmgRJSTyx4K8Raais1NKZHyiS4nFkEeQG7KHjsNoH20U3/B29boCBkhQRH6j2hhnm+Dm5kMAaT5h3WcHnYH/2T9d1ply6BNUuigT0PKCVhoeYQLueKg/XeFKl1tNEgTlC6i92mPK+d7tmqtacXFWVjlCqdf6iq9gqBD3QUpzgw3s2waVRLCczxpMrV6iUBlBH6xXbxPh/L;4:w8oyaeY1+GfIPNypnyic3L9+i02tL9ld97SrzGEO/pj5ProaQ3nrZbAeW+M6PYovLuQ3CBdZoI7t5w9oCUTtjcvHk1zyM/y7zJhf15xn4KE1bp0En+a0W8N2JwgLnXgBkGgH+J3tsis17k9ie+i6uWdd0GUAEG1hhRPq894DLiMbDKPOBGLAP1+qKTsJjrHSkdtnYetx9ILXNjlXsASeWMGLm0iEcnE2jjimN1Zwhp3jkYdGJrQPA4rrZXcYkF5pyUwLhnOKOUC/oe7DGiTylA==
X-Microsoft-Antispam-PRVS: <BLUPR15MB01648EAD42C880F50EE8F0EEBE0F0@BLUPR15MB0164.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201703061421075)(201703161042150)(20161123558120)(6042181)(201708071742011)(7699016);SRVR:BLUPR15MB0164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0164;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(6116002)(229853002)(2906002)(446003)(68736007)(5660300001)(486006)(55016002)(6666003)(11346002)(476003)(6916009)(23726003)(8676002)(1076002)(8936002)(86362001)(498600001)(33656002)(81166006)(81156014)(52396003)(46003)(186003)(16526019)(14444005)(7696005)(52116002)(386003)(106356001)(50466002)(97736004)(7736002)(54906003)(305945005)(6246003)(9686003)(58126008)(47776003)(4326008)(105586002)(76176011)(53936002)(25786009)(16586007)(6506007)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0164;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0164;23:qqq1ssNnrQtFTHSW/6eDzl/R3XhwRl8+7mQiSBokt?=
 =?us-ascii?Q?ibvy/jUdMNh+c7WZB9jKcu+7w4vGf537YdvluKlN1jYf/dxB1HFmcVLLZ8ct?=
 =?us-ascii?Q?rX4HRBaRRrVwuNeHyMwdEymQI8Jv+q3pVaFtAC/U+eLdarCAV9wO0dfCHeSn?=
 =?us-ascii?Q?D/V8qwQ7hCbO4cNcvDw49FZqvHvAJ/9IIm3JKcevaEqcIegG6LgoW4V/AkPB?=
 =?us-ascii?Q?D3Zdq0IvZhEdxptw0M2BnXY/xP0GeD02p6obe+WfR85+FugIvuTUx4Hhoibp?=
 =?us-ascii?Q?v6zIxnJULyToNDypMkykTdqiObayZmKPzskuitmDTavKtDdeyBWBJE6tc3S+?=
 =?us-ascii?Q?jOLhxkBh5NNsi7QWa+fDeIU3aLtP93BURCvT87JqriKAuy04mk6V/b1v4mGV?=
 =?us-ascii?Q?dArwd3s891b+zWqaLdewCeUVpFZgzFq+mT2A852uxorOZq7kgLb9dpwj42yY?=
 =?us-ascii?Q?45WRpnEWArDrjx6n06+GoXS4V84WTXrcBlpryhEIvC7X/ZyzfVnZStVZDTub?=
 =?us-ascii?Q?+PVtry7QNXVXlKDiOmE1LNsZpEXmD3Uk8Q87xyeE0gyO1LNtUxZMYABwI4Pm?=
 =?us-ascii?Q?Lb38QSLfMsce9Vl1exPriUcDMYvUSI67b8Euo1pVFkt8JGgnM7QfES6iubhr?=
 =?us-ascii?Q?T56x79JdAFKt5pou/FUFq5iafhnf6Reu4WAFFqpweqQak90ulCshqFCEka7n?=
 =?us-ascii?Q?DcMCtUGtDI46yXZq+KpmMPmkO653cdycFUcPTBQfJEAzF1eKJcm3yASo1O5d?=
 =?us-ascii?Q?9+796B4OR3XFcoYU/NDTSohHjdG+eHameYcSXIdV+eBeSskzoPhZzpiMDKP3?=
 =?us-ascii?Q?7ILzBPCSNa4zBSYG01wHtSPT21qjKyBLX+d3P029SXbIWxR0BXzljdvZ8qA4?=
 =?us-ascii?Q?fSsHX1/jNWLCI3JeNEtxnxvZQ5Vc1oRrR93GY0TI3E1KIBl25c4sVtt+otiy?=
 =?us-ascii?Q?OaeRa7yx2oDUK58xAXYxeBnG+Vk8bY+HjlTQRnyGUdh1hKTmdzBLwg+jLgLV?=
 =?us-ascii?Q?2aKIzzBou0cmmdOd0sb/GfuFnBK67jG/iP0V0OGk4oisPIFkWHyzFUD09pb6?=
 =?us-ascii?Q?NSzi/gj6DSYchovMex4HwkboTCR1MeHRWz8PUOhHRu8cVPPDGAG+3Uhm0GTg?=
 =?us-ascii?Q?lEfBMwL4qsp4bcf6a6rV57bXpUXTEJ+Sn/XArTsBBNK0VGKbLtdxg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6EtVxdvbyQzIqH6qoEhgi+5dT0yNFQ6xmKypFiSiOMEHtbUEwNanNKIV/mXZxNiiqkC8mf5cgptOjYxYIDohgpvq1hzeN9OPWFii+011Lz7rhc/ytqFVV5JNgWpJD7m4+6wKLXDWQCkde+IUmS0ikjlA79zex4isZVB0nHLGqgNha4XlQxxhW4xS1dKTlk8bOO3Lnp+kxJuTvRKPomsLmnN/vvvkQGMrAq2Z1yJnA40PxW15kEwewPL+2NU6OOweMf9HKsXVR5XPjPkxnHUl5eMDR4RPV9vSzWxzL0GtMtFhjGQM+IWtHPAtLL3BOeb6JplhXsG78gXWDBUWy4BBHczOqwClDuyTfWHaJ9WngUQ=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;6:JEcEt1cwgtTHFKsAymEDOx/6xZARAK+ImOacFyC+3fZ+3TCxRx7Ai8K3E4hgV78IXN/KkTaLlU1cfktlFdpVdtBiPZrcG6T+kkN+ITRrEsAklhGrYsKgDiYP20iEjoh53N+iCpz+/ty/J1JkgGRiMc5FeCt76GpU6PAzthsOwFQvnjPSXFf3/vSaSeUETX7OKZSqjcTR3lIh0MI9NecOo06lqjSt6y6J8w5wzxGkd7uiE7VLWCK5+sldkPSyNt+/rqQPDIhP27KyJ2Sj15hlniNMk6l4LXxhR1iPgpmdB9ReJn/LXu2Z1XqTeH1F2KiSgTXGwZQN0264QRsDs836rovTBLGaI6j9T0bpby5oNQ0RbF2C/qHAf4guTCYEBZb5dd4xhSdYR4iHlwLR1R1b+Q7DeeFhLzj1O039LqzLt3l71/8e5qizJQQfVIw/nNTboGoMSdB+UUBIraqF5JA6lA==;5:umU7A1Jwfkv/W9rsqB6BnlHxc32YzBoWBKIb4pvCNQgJYsi4HupS4R52sok1mIfoP9fJPN7LTxLLJJ+jk76rFfZjV8tCzHPEY882BXQqcQajEupzwT3/+x0lupqNQvmBEPmmojidMKwLSvgqlTIV2IqrO0s5jvQd7tElBS6ple8=;7:hIk82GYFgBGTcgCPy4buNDoewwyDX3AjS4n8UmvqkA4WSYfAffzPYWxFdrVTrft17at7d9n6t7uhtAYzNbWlkXZjapd8P7pG36oALsRmzuygj/xqBpusv+G9G1ItQSnXTn45gWAS4+vgPX4aIOKcl4/0H6BeFnWz4EJU5+bbJYAnUkWXVcHNvXSA4fwFsK6qVI+XFc8Uy9zldcWAPSgcmoTLSwPoabayhsE0S54Ftv6Xxo251ilGWSMe0EZedJM7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:y24BKjfr4gSOunY8AAmFa0duAw6qWNjqBVxzzGFyCZNDhtsVFCbIVl7XOPGROgMojfPynPCRl2ehd4G9Y6KlcoewgG/+cIBPIIsYcEDAZKimNV381USwGgNFt7DSKt27BgSqclTx8akUGCS1uvm61kAcjwbLREcV+/fadeH1nRc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 21:31:47.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0f990b-c992-49c6-2e66-08d60f892872
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0164
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:15:39PM -0400, Rik van Riel wrote:
> On Fri, 2018-08-31 at 13:34 -0700, Roman Gushchin wrote:
> 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index fa2c150ab7b9..c910cf6bf606 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct
> > shrink_control *shrinkctl,
> >  	delta = freeable >> priority;
> >  	delta *= 4;
> >  	do_div(delta, shrinker->seeks);
> > +
> > +	if (delta == 0 && freeable > 0)
> > +		delta = min(freeable, batch_size);
> > +
> >  	total_scan += delta;
> >  	if (total_scan < 0) {
> >  		pr_err("shrink_slab: %pF negative objects to delete
> > nr=%ld\n",
> 
> I agree that we need to shrink slabs with fewer than
> 4096 objects, but do we want to put more pressure on
> a slab the moment it drops below 4096 than we applied
> when it had just over 4096 objects on it?
> 
> With this patch, a slab with 5000 objects on it will
> get 1 item scanned, while a slab with 4000 objects on
> it will see shrinker->batch or SHRINK_BATCH objects
> scanned every time.
> 
> I don't know if this would cause any issues, just
> something to ponder.

Hm, fair enough. So, basically we can always do

    delta = max(delta, min(freeable, batch_size));

Does it look better?


> 
> If nobody things this is a problem, you can give the
> patch my:
> 
> Acked-by: Rik van Riel <riel@surriel.com>
> 

Thanks!
