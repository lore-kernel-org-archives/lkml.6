Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A98C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5F9206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ct/KLOAm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KPwPXEK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5F9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeIDWTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:19:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45762 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbeIDWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:19:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w84HnRRa009710;
        Tue, 4 Sep 2018 10:52:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=FWDK9Io8mHB67Y0mqzu8u4vX878HF9Gao0c7ZpxHuSc=;
 b=ct/KLOAmPpu6HYA5kGY/cSNUXz3cUqAbdM+8pvkp9kFawhYfxVNuOqpoWx+MnRdfZesU
 9rADU3q5vK2qFiwwVdiRcWfuszE/aFXNo4xBKvnM/ZOsd76XinC3nowGgwruki+SqgRD
 YNyyIst4nd1qgwS2J+NZtpvCq3KiVp6Q5GI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m9uw1grfv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Sep 2018 10:52:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 4 Sep 2018 10:52:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWDK9Io8mHB67Y0mqzu8u4vX878HF9Gao0c7ZpxHuSc=;
 b=KPwPXEK0WTVYcuRCAfekOphMt3oX5SYwg2EtqaCoBoA5sgkWe/b3qgfrRLcXtYZOtV431uvTS1d53PcddQZ+pG7dQQ0ONWEMWmN+b+KaaIJizds6w1Z6j+lxfvX/v0c9PUehoGzXamP0hsBCKuWhUzW0eP/IwUaNE/y4ZETBgQI=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::6:d497) by
 CY1PR15MB0172.namprd15.prod.outlook.com (2a01:111:e400:58bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Tue, 4 Sep
 2018 17:52:51 +0000
Date:   Tue, 4 Sep 2018 10:52:46 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Rik van Riel <riel@surriel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
Message-ID: <20180904175243.GA4889@tower.DHCP.thefacebook.com>
References: <20180831203450.2536-1-guro@fb.com>
 <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
 <20180831213138.GA9159@tower.DHCP.thefacebook.com>
 <20180903182956.GE15074@dhcp22.suse.cz>
 <20180903202803.GA6227@castle.DHCP.thefacebook.com>
 <20180904070005.GG14951@dhcp22.suse.cz>
 <20180904153445.GA22328@tower.DHCP.thefacebook.com>
 <20180904161431.GP14951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180904161431.GP14951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::6:d497]
X-ClientProxiedBy: MWHPR19CA0057.namprd19.prod.outlook.com
 (2603:10b6:300:94::19) To CY1PR15MB0172.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e790bfe8-7882-442d-1fb6-08d6128f3c80
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0172;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;3:0j5ojXjbUjIr4Fk00W4iBA40Ghr5xNgoWyg80oAacfdaEvgzVXvBeHjlyDuhsAfFpGLJclrnZlvpmpHbDU3Hn7MrG1JVwAaYB/TahgVkJhfsb76A6KE7V8/CJ9EdfXgYIHsZ2UI+PcCYqj+AO1z04bVq1rYM/zSXoKmw4DtMF6d9UePcr/teRfGO/seNlfj3QSdynpDuY/NJhhvALg+xzzjQZFXIiOMuESkBivsZFJqJvJVejh/262ZN4omWysd3;25:nM3BeVf46XK+h0p/LL5geKuYrLIcI2keVLQeM8+hp7clBKtgI/PuST0+BkHINiM8I1TBMSIX4vOBYYIdZUWnOMooWpUeCXgh8P/Fzo0F76e8Akg46lHdrqMbVWsMz6SckZXk01yKAJXTCI9G5QpK32E1DgB9tiJGCCLePjgsxVypOs/PpOLK3iUGscyEVgTszxebgPkxdqZXQZz0Afi+vWmP/CV8U0yoo73BrfTYBlFD/kaUPyhBuWJ4NPrKZZvgzm7zMujXUzKOYxdzEWyuz6iTmrqPoNxhDsOitkG1o78qHVCE65ZW3+QtT9SYHf6ImacrcH3058rebPvXB/28bA==;31:2fB1lTdZqvH2wNFGcn44jtOHtIq/GEDI6S1ajDkbyOxqy/+k46NIw1mNXdXQcB5udmcQQbhjX3qW/DuqLsyQ+M2Bz9+NIsb2RVqi+6QP544wX89SxNaje3fRuA7DFyLm+rSsVBl0c1SPzv7wz4Au/yPRGkqL+U0fnpeGQ6O+RTlFOrGB936SUFsOnp3E7JQuVsWCWRW3Ba0Gd7eL90h3B5nqn+sJWavitnEfVtRw/Ys=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0172:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:lZkc8qSgYLfLguMEo5N9t53aCaDP9gWt/pum6khH74fbRVJPuyNel3QQVyxtLJf6s4qk1S4No0Sk+x2XZZpj+/vE2NO4ob5ZnJ36FijuTQy3CF/sZUDjB/ejM5gHq06mgsFqeDR6JvvSFIVmCDaKQ9NakHVTjrVUu08CJZbz/pZA4v2hj02HgEY5Dey//K2nYzBonmMMhWzot4zog/U5gQA8tbrYrhu5hdYpJDZy/9vqZhoOx4ciQZ4f7K2U/4wblMfk9lRdVNpOZwBVg0Hjt4frQZnJetDedYTVyHG6txv3RqfZNLMGEFDEetOxCzKJCNM2ZMd4HEhiz9w/qcug9o3MqmK8D34bNbtWWOgL9SR5lBokryBTc8PP6HmvMGxWHazqK8H+yAXLth87LWm0pekcMI9njYmbGU7M29zx5l+jIKWXKglxFPv5X4JjbEIlSurjFckeDAdmozNW9gRdBOgFrWKkC7/7Z2jZpsracnP/S1c4lRMJtq5dkYrdy7JL;4:4LRFjV804Ab/gzyysngMmGvL7qFtvs3flQhN103oqMMQiBthbGt1tcWvataZ+v9s8t3tFpQK6dJxQafKPX5Qb+1jgaZOmd/zX5rzeWtBQAJCHhTsIAbQFf34wg1M0POEDS8qzfqarF9yNg2dr2eOnZ7h5ygdB6mNUTt3379wTvd2BKr225pTVWzdXVcfDDpg6B+X56B++5Em6lTuvALE3vtzeK6iYRrimOYzQB7UyvlsRH9TBfsgbI+XcPKKtM/k5uLREBnn284/D/pTbC3JVg==
X-Microsoft-Antispam-PRVS: <CY1PR15MB017267B3289B26C2EAB847C7BE030@CY1PR15MB0172.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR15MB0172;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0172;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39860400002)(396003)(376002)(189003)(199004)(386003)(52116002)(54906003)(6116002)(7736002)(186003)(16526019)(478600001)(8676002)(7696005)(23726003)(52396003)(47776003)(229853002)(50466002)(46003)(14444005)(305945005)(476003)(446003)(11346002)(76176011)(6506007)(1076002)(486006)(316002)(58126008)(16586007)(6916009)(86362001)(33656002)(53936002)(68736007)(9686003)(6666003)(93886005)(2906002)(55016002)(25786009)(105586002)(81166006)(81156014)(4326008)(8936002)(106356001)(6246003)(5660300001)(97736004)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0172;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0172;23:e2XV3Qw5OMvN8gzOIgC3CBZ7oRO6qSX2cx/g/r12J?=
 =?us-ascii?Q?x9LiGraES70w1XfChWg9n7fyAV2iVv63cemq6/0uH+67RMq3f64hl+ui5dIP?=
 =?us-ascii?Q?Nq6gbAyVOmjulrzkj9Z3flP+Z1zHQZgt6BeTqm0TdKu3icJ9MKM1CSQPDqF0?=
 =?us-ascii?Q?6gKEVcFl+uK68GJENl7T03bkscYhY5cOHHZrNQW0IdOLfYSJN1QkZClBmMMs?=
 =?us-ascii?Q?Ok/XEXyZW+a7JUawlFd7tD5aEe3P5NZpX6iHirxT8WJ66fW+vyTAMad6P/PS?=
 =?us-ascii?Q?8HHYd4Mi8ZvuW8oal8lWpzX9sWBpS+DCILoFlwLSJ1ZWiZeAgxD9V1n59WCw?=
 =?us-ascii?Q?DhgXj8nJCXx7g7XxxoZBarhWrvaQPXN/gMdmz94mbNSsBZS3ApF8e/e54L/K?=
 =?us-ascii?Q?bG9sgafGWAnraNbFDxYT0KXhh6+79krb5MHzyrg0/bkUx05uVro3Y32zOGuD?=
 =?us-ascii?Q?OVTFvum7bk2HzPEtyO7+jzrfeJi3Pu3e0J+oKnH+HimXxSWwi30tgSMLzijl?=
 =?us-ascii?Q?/h+mq1sfX1H/fj+4B+ilccMSeFaSgc52HEgHiyoodqsNsyRnijgpHwUv+m//?=
 =?us-ascii?Q?3ckdRZPOUceGOCxiOEDlSbiOjh3PAUIsFr2WL2SjTjAbGZBYgKVQaUv4tK5j?=
 =?us-ascii?Q?DsnIf8LMUbkLmj7p6yv5jIWx9IsJVp7Fe6IVUippii1vFfS8ZLB1YF5uaZ4O?=
 =?us-ascii?Q?FRfdEPv77BA2LDmXbN1E46AdiMhJJeP4E7RTivBQSehaSq+yYrPob4x4T9KC?=
 =?us-ascii?Q?O58T1Y3SFxKrlvmBgoWrBgtScDqmm6sMd7drZJrd2Z3M469tFVmc80LFNhhN?=
 =?us-ascii?Q?pshaNO4g3g4SEKqhUZKEeNLdXYatTUNHvpIEivY7EWUunRu8/wFFrtgoGxD6?=
 =?us-ascii?Q?SKuH7w6Do0cm+DsXInqP51TB52D7QtvGL30kuz6YlDaNLH5a85JTewBvePDC?=
 =?us-ascii?Q?w32ZKLu59iyF5301KlszU9WLTnjB2vy6MMq1+FCHgX4lHSW+Js1b6sRkxjRe?=
 =?us-ascii?Q?ZhzNBuiWb/8VPXYmaArI7ZXpVWPeKz3UksQ/mwXRJAWTyvYvpC5dwj5Ow8WX?=
 =?us-ascii?Q?XW5aZFHkcssHXwfWLf5FGU4Ubr1f9G6B6cTMItvQ2ktEvnpHNHZnlRLvE2Hi?=
 =?us-ascii?Q?XFnpInyj+yOZ2WcY6RLlCheRFJ/pkgifRGGfukG+g2xbvINqLF3e1MAt41FH?=
 =?us-ascii?Q?oySGEX5RRI3I391X0j3FuIT1tBvotAFnQofCriU8h5FPPYSdO6dVorKKUrhk?=
 =?us-ascii?Q?mZEbDyugu+lt0SktWvkHFaQoVv4X/H0sol9uy/nzo3Kz/ukINZyoRhXRrZWH?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: zVTA69rb8yFfvkSMWKhinB3uo3U01gXeDa9lxF6IpqfeYrC8DHKJup5HsebQXPddpFLijTYeM7F8/4AqrBzlkavQoJkF1655nDUIteW47772SIf0L93YslaI69oHG2BohbTOxsXg9JF4FIJBZtmpP+RxoSmvLc2vt7kBF/+Og27NZGkfgjPQBsgaxr6jy43vhgdTXx8IkPZAXYK2QtGsSFE5k3KB4v+e5Kbb856w4OwQsrufW5jUk8dLYHcuowm0Axok3/oq3tCYHR5q2BPNJxdZPVdKqN6I+aOZ7/YTl196Zn3H68gcm9axWMJxFJPsT9cifcKB6Fvixpf0WdNHfiX+gKeqIiwc7bDTyjSJJtw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;6:QQpP3Fkyo+ZcS7/Ktmg9gYz9Luo3ZvNH5Mrd2AiYVy0IzbVt7qMTwNSoFAiF9rhPF4JeW2ZyKzZsbhxXNyeiqbOBXja60FBRywRWPhSciSE8ZqWcGk94OWV/GkY8EcyCzBCiv24TMae+m+ms3DjOZpH48wbhVOFvHE1iZ69tQNR3IpqjN1KoZFeiqBwg0tBl1H6E2rUqTpjMgilRVtL5j1ObNaUAqOhD9X6Vlu8c1rdJGnvOdD9Krss1WsvnN0g3VwYMvWqfRaSXgdUycrXIj360fqluWDxfkFw6X0Lq6MeZJKyOK1RlNXuSzZJP0EMAXcvF+OG2JNx1EixvGnXJKzLIR3/xXcZhlnilMhe7sG1cnWRa7/rDuXxAVvxzSmC+9rC+afb3OeAf7PgbaqDRichYA4POVdRQGz66NR58IQnuRsl4zRk4kM6NSOEELbWWcff0wl9fWUOJsesNzTEkeA==;5:kE5i7uJYdD941pKDAzvh4TIxzTui24sWsVdG/nS2Y5fS44UGPWxn6O9BuGMFNyrlMtr6VLLWvsIVrnpv1Knt+fpYbCwV2B2UrMhl9mX0TTe/IEJmwWMk85Cbah4dH70lbkm5sgol3hfEVbpYvjpUxbta7EB0te5Azv6bL9OJvWw=;7:U5OYSiANLZJhOxZHLqvPl5OPkoMXAY9OTaFkSqXN2O4itEV/enVXswKSDiKTn/ZXk9oTt2jVANQI/UnihWU4+Zus9zijmIizM5RWtnyBtB0q68jp+Rii7Nm/alZ2SUto6ea7nLwBMQNVnIIjc5IgKYqvft9gTcdnK0IEQ4aRmD2s64ku3TVPvHx0MGzzJVpzfrPjuYFtQxLiEuOwRi0/DKM2/xYVc6Mg9ZuIUvs6kBtURxxnuyYowIuUi7ImK8Ff
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:8tzm9jYtsN2igptHqQVxuY9pukAgDdOCKuQJnNClCZt10+HYjJdsEEgCtqIdvp+11tMpjY/K3c+RhtZEIWXBndANpvuzslSbaX8OfHRj+Wlj9/mv+/E6jifloOdPpn1hc4eVfthCZ5XL3kDON9BS93lm2QdL71mbPZOpDEeGrXw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 17:52:51.8742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e790bfe8-7882-442d-1fb6-08d6128f3c80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0172
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 06:14:31PM +0200, Michal Hocko wrote:
> On Tue 04-09-18 08:34:49, Roman Gushchin wrote:
> > On Tue, Sep 04, 2018 at 09:00:05AM +0200, Michal Hocko wrote:
> > > On Mon 03-09-18 13:28:06, Roman Gushchin wrote:
> > > > On Mon, Sep 03, 2018 at 08:29:56PM +0200, Michal Hocko wrote:
> > > > > On Fri 31-08-18 14:31:41, Roman Gushchin wrote:
> > > > > > On Fri, Aug 31, 2018 at 05:15:39PM -0400, Rik van Riel wrote:
> > > > > > > On Fri, 2018-08-31 at 13:34 -0700, Roman Gushchin wrote:
> > > > > > > 
> > > > > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > > > > index fa2c150ab7b9..c910cf6bf606 100644
> > > > > > > > --- a/mm/vmscan.c
> > > > > > > > +++ b/mm/vmscan.c
> > > > > > > > @@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct
> > > > > > > > shrink_control *shrinkctl,
> > > > > > > >  	delta = freeable >> priority;
> > > > > > > >  	delta *= 4;
> > > > > > > >  	do_div(delta, shrinker->seeks);
> > > > > > > > +
> > > > > > > > +	if (delta == 0 && freeable > 0)
> > > > > > > > +		delta = min(freeable, batch_size);
> > > > > > > > +
> > > > > > > >  	total_scan += delta;
> > > > > > > >  	if (total_scan < 0) {
> > > > > > > >  		pr_err("shrink_slab: %pF negative objects to delete
> > > > > > > > nr=%ld\n",
> > > > > > > 
> > > > > > > I agree that we need to shrink slabs with fewer than
> > > > > > > 4096 objects, but do we want to put more pressure on
> > > > > > > a slab the moment it drops below 4096 than we applied
> > > > > > > when it had just over 4096 objects on it?
> > > > > > > 
> > > > > > > With this patch, a slab with 5000 objects on it will
> > > > > > > get 1 item scanned, while a slab with 4000 objects on
> > > > > > > it will see shrinker->batch or SHRINK_BATCH objects
> > > > > > > scanned every time.
> > > > > > > 
> > > > > > > I don't know if this would cause any issues, just
> > > > > > > something to ponder.
> > > > > > 
> > > > > > Hm, fair enough. So, basically we can always do
> > > > > > 
> > > > > >     delta = max(delta, min(freeable, batch_size));
> > > > > > 
> > > > > > Does it look better?
> > > > > 
> > > > > Why don't you use the same heuristic we use for the normal LRU raclaim?
> > > > 
> > > > Because we do reparent kmem lru lists on offlining.
> > > > Take a look at memcg_offline_kmem().
> > > 
> > > Then I must be missing something. Why are we growing the number of dead
> > > cgroups then?
> > 
> > We do reparent LRU lists, but not objects. Objects (or, more precisely, pages)
> > are still holding a reference to the memcg.
> 
> OK, this is what I missed. I thought that the reparenting includes all
> the pages as well. Is there any strong reason that we cannot do that?
> Performance/Locking/etc.?
> 
> Or maybe do not reparent at all and rely on the same reclaim heuristic
> we do for normal pages?
> 
> I am not opposing your patch but I am trying to figure out whether that
> is the best approach.

I don't think the current logic does make sense. Why should cgroups
with less than 4k kernel objects be excluded from being scanned?

Reparenting of all pages is definitely an option to consider,
but it's not free in any case, so if there is no problem,
why should we? Let's keep it as a last measure. In my case,
the proposed patch works perfectly: the number of dying cgroups
jumps around 100, where it grew steadily to 2k and more before.

I believe that reparenting of LRU lists is required to minimize
the number of LRU lists to scan, but I'm not sure.
