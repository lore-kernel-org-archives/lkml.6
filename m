Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15489C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C1721EFB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EGWDrrxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C1721EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933912AbeGCPLY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:11:24 -0400
Received: from mail-eopbgr40099.outbound.protection.outlook.com ([40.107.4.99]:15578
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932440AbeGCPLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRh30aXUuYSNi62j8dagIYPTujdTh1UqhBqbhgbb8H8=;
 b=EGWDrrxQ6HtQU69E4rGnb578U0CVbaoEnt8q6IlRRNqEvEduImuu9rxM95Jsi89q8pmZ6o8GtbQLCslIQdf+hKiHXHSRBd2Q62m1CB+MTYgSvvrzsalF4wco6RRE/o8odMxiL6M6eeHyE61JWahBiYlZw1/E/IFCR1g7lopheFs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1330.eurprd08.prod.outlook.com (2603:10a6:203:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 15:11:15 +0000
Subject: [PATCH v8 14/17] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Tue, 03 Jul 2018 18:11:06 +0300
Message-ID: <153063066653.1818.976035462801487910.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::11) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 043a0641-ca12-4276-87c8-08d5e0f73a2d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:ocdvo3jBnLhSleeMCvVDCMB54BN94PoFBvQOqhMJ7ae9j00YHNQbqiS6Lqo366vITjIfhYJcKSxW8v+8OTHviuIHkFwrvTuCQO6JQqolUdmHizYLtu5lZUroBgDAO2xgDdzK//ShBbiT+BRX3z7I+kwxHmvv10HRs/BikYFutji8XXZ3InLTBbmzdidi1N7A4X3c0XXsL+lWR6W9J2Us8gESfkg40WnHibDi9L+nCy0mmd4Kri+1bpjCyq8acUMS;25:SfqF9Me6yrElRWB05IDH6+IPiO7f6wUVqfk1vcrkh8Vt7QIhAutQG9TJKbiAhOibek6z97IyUlSc4tJknu4JacpJq/1E6KK8S2T7Wdal24GtO53ktOnlBOXxzoarW0jp4Z9mHmLGRVZWuOKOGOU5CmIIqoQ7/OA1JFzBGev5dsKn8nGPXgJdtlzUWI+PChuw1zVkH8ymiFn5KmzroFTRdMymee8LSN3VBVR+DBJ2nEvOaeDoReDdgR/mkwIK5anzxlYMIXMHZ3IiHzn4KYH9vbOjjoeRn88tMWCYECA9u6fsFuOUj8XDIjuXvAacNen6J+QSxS/5T0lpnS+DdM1LjA==;31:sJ4L6euZwjHsK0aU980+Dh5u57TWV5ucgDsBcEmA/ORLXYiz3Uaq101NlofD0t3T/njCl7pUfnGVxgsIPeCcjBqC0dhLddkpmCIidaNFyL014PliO/5AgQ7glsgfDflQXM1xK5iBr/is/axxaYv/+QL15vsDNOViTNvuYCs+Muqb9WEm3GO9/isg1qJSDcWh1wtRkHTIKL0c7z/dmi10C68wFEpsBvr/oLmnyEYzSvE=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:c+zZ5bZ3VwCgHJY7hDsAKv1p0bpDoItURPgpytjLP86w7KQRyG5BKFcFCqBVDuhgFfmyJfNMhVqpo8mNIQ1ncU0WgyQa8EgVZnzRhhBk1XMy5VOpuuaXzOli2JJrA/m2++nvD7LQi2XKXMIISl0IhEAVorDhhiTpmG9WUpGzhMMdUeR5c4SXCmNdsv8JCLxiCpCQhlTU12cTU5M32lzbdRQri5M1NjMBfe1j82zL+pv1NXNbTZx7UySkfhIMDF4+8FmT/gvyMWYgHSAH0pkAk84IvKDLP8Rv0d8aPCP5clSI6ljgXFPEJjARyvh+UbUZ+iOvMIKlAxNS2WqndFk9elm+mnCFsG+vno1+odqzSMqW3t9gEgljmB6gs88+DwDHH/IWcmf20nT/enS3WG3bj1igLTNynAf3+7lLcVVIE3qL7A04jUDHb3XUwgqyNd3Sq7r5PATkqwtbOLwN07vU0twpksnPrBcu2wgT3Yw1CDrmw9MeXAtxQUjRD8qBFZU+;4:G2MnAlC664sP61j7AtYQ8SgkCzmKDSSMuMxBbbs9oeD9W5sgOOuGhOFNpoZBsexNM4Byoav3AnbZ81BjRUqj0D96ZN55FzHEcLYpPsskfz/2Z4qwn/WW4aWfKnZi0JRSrF0NQ9n3PuULaJ9+tARkMklBa1vjOOZY9vXCOauSLqJC1Y8JYitoizojeT2yViwFq+id5tQuzC2HQdJsFzK3JXmfRoIITA4IoGEDsqzy5zJqw+QF7zZXjlUJuMsqy8r3940Q7ecxh3ZTR2Pq5oO2h7n2XTHmNwVV4qBnXgpDfoCAKR4Rq6nVhFS/dOxlRQEEThCKHzO8WWUTyQZmOLm+vzYXt6EYj2eY37GdP36K5mAceUFSX8hGj6dfXOpI6MKm
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13304171E9358DE7C1F7F0FECD420@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(26005)(61506002)(6116002)(186003)(16526019)(305945005)(86362001)(68736007)(3846002)(230700001)(7416002)(6666003)(97736004)(2906002)(8936002)(5660300001)(14444005)(25786009)(103116003)(316002)(956004)(7736002)(39060400002)(105586002)(55016002)(106356001)(9686003)(66066001)(50466002)(478600001)(47776003)(76176011)(11346002)(486006)(52116002)(7696005)(23676004)(81166006)(476003)(33896004)(58126008)(53936002)(6506007)(446003)(81156014)(8676002)(386003)(2486003)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6WWV5WHN1d1hsS1VlTFRUNjNpZWFDaDhP?=
 =?utf-8?B?cWlqMXJlNzN4OUR4RG5teWtiOW1LRk8zMXc2K2ozcU9LZUhoSXFCYTdpcWFq?=
 =?utf-8?B?bHhKYzVtZHQ1anFZcVQ1T2VLT3JYSHUxc01scyt1ZkJia0U4dmFpVUdjbmk2?=
 =?utf-8?B?bVhwbm94QzBWdlVRb1hKQVAwRnV6dGlTUWlxelN2TS81bmJIU2dWUFlXQlR0?=
 =?utf-8?B?eWYwR1M1NmNSczVZK2VFRytOV0c1K25OR3VjVktEdzJlMEQ0RUorR0NSRmFr?=
 =?utf-8?B?dzNScDNtNHV1R3BKSFRVT0owd2g5cDZ5NGFab29RdDFTNjhzTVZWVTZCaHNP?=
 =?utf-8?B?WjRUdGtkTE5EdGZrQm85djZTZ0Q3c1dzNEY3aGNoeVB6UVd4Y0hteGp6ZWhu?=
 =?utf-8?B?TS8vK09PckdUamh2eThoSkRaSFBXdWlmaVU2MFdjWGFWQi9pT3ZRSFFpaXZa?=
 =?utf-8?B?dkg2SlhkNmwyU2QxQmpBRkFvVmIrK0ZkdGJaQjcvdnFTUjB4VkgxVlVqcFd0?=
 =?utf-8?B?ZVR1UW5iZXIzNjUxSmF6VitLOHBNWEVEL1BqNDl2V3N4eFB6aE51d1crU1Az?=
 =?utf-8?B?dGoyTlArN05OcEFzQTZOT0ZMS25HOFNEc3JoVXFJd0NGRUVmVE9uK1BHa1hN?=
 =?utf-8?B?ajlGTzdkMlpOeW5OeHZFQkZNUUhtaXBWWGdsRVBoQllOZWY1emVPN2djekpB?=
 =?utf-8?B?WU8raTNhNGlvZU1DM09MYkxyaTlsMmRPdEs2RytqbFNGMk5MZUZqWVFrdUtI?=
 =?utf-8?B?c0hkMnpBN09MRWROTFJBSk5Qem9TT0YxYmplM1dtMndTQXBvNTQzRmRDaUVq?=
 =?utf-8?B?LzhoUE50STdETUMxV0FkMkgvWnFpSVdRV3pLU1hXb3d2Mk15NmkxKzJSWFo1?=
 =?utf-8?B?M0xCR0NORGFWSWh1MUtYYThvVE5zVEsrWjVpRkpIejJENXJjaGNUdTFOMUoy?=
 =?utf-8?B?aWlwRGY3U0twdklIUWVzVUdoR1VjUlZIekorSEFJYm54Y2M0a1lBNHMxRVg1?=
 =?utf-8?B?MGUyTyt4MXY0WnErVDAvOVFFWW55SkFxVExXQzFxQ016Mkg0clVJMzN2eDJa?=
 =?utf-8?B?bEhDbWpDUkF0UFdQYTlkNEhJTjd1c05wc1BSbVlGeElsZUs2aFRRMkhrdVhB?=
 =?utf-8?B?cVJYR0RoVThzMWludUl6cGkyY29JcDRuZWV3QjZvaUlmQTRWY1A0V2VuWHc4?=
 =?utf-8?B?U1JPeFQyUU9Fb2dVdkl4NGJhWTBaY05zd2FLWjRXdE95S2VXa1JySDBtOUhl?=
 =?utf-8?B?M2VNVmpxN1VxWU1peW1BaU9aYThSVUNWdlpVM21BWis1TnVjOXFlMDFmUmNt?=
 =?utf-8?B?aDg4ZTZ1RldERldFb1djOHBPa2dNMTRaWHphOFdrWXd2MWFJdHJDVlordFB3?=
 =?utf-8?B?TXEwZUlTbU8yQ09FMW1qSXdtNkhab2NGeE5md3g3UG1lQUxFVlZZQXBqYmEx?=
 =?utf-8?B?MzNQbVJYZm5nSUkyYUlMU2ZKYmJtK1VQN2VIUHNuVlFueWZ2L29vSXJzampj?=
 =?utf-8?B?ZEhCajRsMUVsNmF3YkEwSUlObjdXTmhBeHhrUGVzN1FHWEdSRnJKb3pUMm5U?=
 =?utf-8?B?eG1zd1JaUG8wa1N2SVVvTTdSUGJBSitFTitGZ3c5TDFQZ2pYek1SQ3dyRURE?=
 =?utf-8?B?QmEyYXFDTFRsNUlWbjdNTG1NOGZhaTRUOXpwNVJreW5tRVdxZ1ZXOWtZZ0pw?=
 =?utf-8?B?eVVVei9Pd1hMZzBKbkxSYVJCd0pSczZ4M1o1ZitnNldQRHp1OWFFSDdqd0lE?=
 =?utf-8?Q?MGpaFmk9zTVKxM766TdCEKrqdnpbWqXSc7LhLx0=3D?=
X-Microsoft-Antispam-Message-Info: jrvXrqoUuWpUDGV/Gxbwi+SW0Ee3r+rODU2Wl/C+tBHVpEUz92YMXREX5cvP1GeWvqaN+3Jk21StkqZP6HGgywfWbc7PKgC2d4wwa9vS/M/x2speTljE8iuCkzSueBb1h+KSsP0OXTKaiXe1y6/mVU3/4Z0kjyDbK0mwK+6L8+7/SlqkDcvW0+2xeDp8bwEdkmlP7iEThWVpJ2N9Ph98EXNKVucsEtHlYjwzN+1YYNw2DXt80NIRkO0yc8mJ7RagkwMSSEJsLy07FWG7aAwICXiOCnu5zdfSyruULnsZriNVgHMsHxPzKReHF/BfjLPvxrgfvMayICYsIJXILGFHSXrHXoA+bVqth0qQu9RkNiQ=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:9ZB0VDMn8INw3sHCAfpQkhlPohuH0jpNXMoWyk+YaUfI3l5z8XZeFvG+Xq4whpfoFdxxwk7GwRiahGtUVCvBKwWqBinD3FNbJ2o9HokNA/eXfTxhLCeqcaYzRbHyy5tw8Ik9f6AAPYL+dpyxHk7dRXpVEvVOowIFIt6dN3iR7yAq34CFIfZMe8kqqw3FIHgP1NzSti0sHPXkKMFMVi0N0GkYtVdZYa1f9RIKfSfp0ruoCSE2umwlJOYgWjYxW1R4DJdnGr1Afb5kHkWGjb5c1ohvNomuMOb0ddFViQPiFDA1iV4/oqM33sP1b28QxFINtYSKC9eMS/fUchnMB5m5CLNtGqUIKjtk44HcdhUyuLKKotKjqTQCblWQv0qJ9YEt79xJj5k1rXMk4sbloXIyPxi6Hqw/QuZqGpfYosND7xf91JCRQ0hGQ+YXj9/LHuG1W6fc0G3xa1wDE17vmxGggg==;5:jJCHLqbCH0yfN8+UphYIt1SCSeqOW9UypLCVxzBXQKBDW5pwm3C8YbDz1H8WDuPh3N47i0SG/2Nsq1lZE+4GCs+9+DkkZ+T4dKrVuQlZ21VkIVMnULXj1w512DvnTbYG3V4NOt7Dw9eFruYpshIF3HPxpLN5NBn2564V93nc7Ms=;24:ETb+Qr8a2b+Mhez3M/Ir0Yer4rFZ6T+pR9NmpFPDPl42pV8Q8MvUNs4TdCRW15T7zOpTsNER6C+B4Goo1qbrlzwjDXjIvKD+3FjI2t2cOzI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:tM8CYkfXgmSfsUMA/o8pFcY+ISbpv1r3e1PrIJYkAcc10BWjw6dgVknOVF0R+S/MdbzvEfI2Jon0JlfqZnUjijWsI5zAFafrTv94TJH8RGSYMq7zsDJIcmQVC9L+h1Xg0IUT1ewXwuhYk7IbSDMBnX9zu9ZEiXhSBu2K4ieUyYPOHQJ8NWUSFEOhzOyhD1kZIbzvD315y2/u7iZlC/VFRHdYNamzJL2Ukvlh2y/fQjZRdjv40qafqiOBOrHIY6A/;20:yt7Lz1+jOv94q40stwiKpNTOJtIo6YlD0w71/iI8AyozwFg6T2Xyb53+DyXhCXY/UE50bj1JehXMptv49bhZpyZWHbfMvOqpgZKyTk7kpBKx3GUXqXRigYKC0sHX9vxuAAYGZKBeUZgcP/28H/YOunCCxat4ZLJqPvGOwj13jW8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:11:15.7699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043a0641-ca12-4276-87c8-08d5e0f73a2d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the preparations made in previous patches, in case of memcg
shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
bitmap. To do that, we separate iterations over memcg-aware and
!memcg-aware shrinkers, and memcg-aware shrinkers are chosen
via for_each_set_bit() from the bitmap. In case of big nodes,
having many isolated environments, this gives significant
performance growth. See next patches for the details.

Note, that the patch does not respect to empty memcg shrinkers,
since we never clear the bitmap bits after we set it once.
Their shrinkers will be called again, with no shrinked objects
as result. This functionality is provided by next patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8b1958c751d..d4c40ed9ec5d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -367,6 +367,20 @@ int prealloc_shrinker(struct shrinker *shrinker)
 			goto free_deferred;
 	}
 
+	/*
+	 * There is a window between prealloc_shrinker()
+	 * and register_shrinker_prepared(). We don't want
+	 * to clear bit of a shrinker in such the state
+	 * in shrink_slab_memcg(), since this will impose
+	 * restrictions on a code registering a shrinker
+	 * (they would have to guarantee, their LRU lists
+	 * are empty till shrinker is completely registered).
+	 * So, we differ the situation, when 1)a shrinker
+	 * is semi-registered (id is assigned, but it has
+	 * not yet linked to shrinker_list) and 2)shrinker
+	 * is not registered (id is not assigned).
+	 */
+	INIT_LIST_HEAD(&shrinker->list);
 	return 0;
 
 free_deferred:
@@ -541,6 +555,67 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	struct memcg_shrinker_map *map;
+	unsigned long freed = 0;
+	int ret, i;
+
+	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+		return 0;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	/*
+	 * 1) Caller passes only alive memcg, so map can't be NULL.
+	 * 2) shrinker_rwsem protects from maps expanding.
+	 */
+	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
+					true);
+	BUG_ON(!map);
+
+	for_each_set_bit(i, map->map, shrinker_nr_max) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinker_idr, i);
+		if (unlikely(!shrinker)) {
+			clear_bit(i, map->map);
+			continue;
+		}
+		BUG_ON(!(shrinker->flags & SHRINKER_MEMCG_AWARE));
+
+		/* See comment in prealloc_shrinker() */
+		if (unlikely(list_empty(&shrinker->list)))
+			continue;
+
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		freed += ret;
+
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
+	}
+
+	up_read(&shrinker_rwsem);
+	return freed;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	return 0;
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -570,8 +645,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
-		return 0;
+	if (memcg && !mem_cgroup_is_root(memcg))
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
@@ -583,13 +658,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
 			continue;
 
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))

