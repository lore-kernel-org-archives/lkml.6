Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783BEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE4C21C2E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RYNQX6k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE4C21C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbeHIKqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:46:35 -0400
Received: from mail-eopbgr40123.outbound.protection.outlook.com ([40.107.4.123]:31648
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728712AbeHIKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv68ZVe2pvUU5m3qKQ4nCJPQaiwkllu6QVzR3t1QjJI=;
 b=RYNQX6k4fFf0SfQ8IaeTSQZlQQJoA9aNDBVOaWgkPUYSOF0VF/eaT/JnKIBJC3Pac+kWcoFTeRnh11un1PFLebQwNCNkncyuE9LpQPeqNdqmAX6dSWmd0TZl78k6jN4C5UZEQksqp94H+6pUizFYlQ0LmffonYgBVgHrgRjJqHg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 VI1PR0801MB2031.eurprd08.prod.outlook.com (2603:10a6:800:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 9 Aug
 2018 08:22:27 +0000
Subject: [PATCH v3] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
To:     akpm@linux-foundation.org, vdavydov.dev@gmail.com, mhocko@suse.com,
        aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, willy@infradead.org,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <153355467546.11522.4518015068123480218.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <758b8fec-7573-47eb-b26a-7b2847ae7b8c@virtuozzo.com>
Date:   Thu, 9 Aug 2018 11:22:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153355467546.11522.4518015068123480218.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0151.eurprd06.prod.outlook.com
 (2603:10a6:7:16::38) To VI1PR0801MB2031.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27afda5-19df-48c1-9e53-08d5fdd13f07
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2031;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;3:iDfSbuc9Ahhe+DbhsyQ9Vs6BP2R0zsoh/f0XbHrx9fJn6A01Yqirdcxy4kdgf0mTFQHPbWK/Cq84soiUjtjfVs5wjtuKg3RkPw9Q29VupgduU1Dd+VLFLRK43LHJmZklSqHiRc38iW+1GINSXWrqIRb5+qIQ5Oa4F6I9Wle4suVvr0IKqMwkFBlf3A4AuFV/3H0Q1qqSAwYDV3XOCU37jy5vfOJT4Twih8NvFzj9E4IIcVXlf7D56HmxuUiSszSB;25:CEwdzAXp+Ihlen6DRuuBfLIJYxEuE5PhZTEs2e5CU3XU0TXgZoUBjWscR/4or8UrjTBb4jizNN5anBkU5EcGi4GTZaIUkjZl5DfR3e8wmTSTBzmn8gtCuwYaC1iY2yNEBikfcdy8BdKws6hCml5a8cJpiB3FkmjALinFNctzXiQofBE14IqiBuDLGb0RDA4LQJdKe30SgC5ogzcj/Q4DHhplMyBVMksnj3DUNRK++2GHGs6nxnuYBoO6/1rVoZZkNzI+IEi0sZbuFmA9Z8s4oxACOZT5unmq64DuQ3MsHBulgioYNK0XkOrTCfdhHYqbSXOwwyW2GPr8P3tMqPchgA==;31:LvTKvJxGsAwFmBpaLeY3zNvevjuDmgzteGUh1YXrzO8TTcR965VydefTvebILTS/47kz7yf9LFx4FE/KqxLCG1Bzfy7+/etThqlphqdZ9e0w+HscGMeING2N+zOdjMJVHJDDwBUrMqVotU816PCY94QjKBGSKNs5xzFMob7tBgBq/eP3wP2oIDYQMxDEwoHE93QnVbu3JiUQFBJvhrq0aruY7EJ0E2u3aYABRCPMCWQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2031:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;20:HdLhu8RX3Gq299CKMxKi4Yhhb1q4q21azg2DwaeK9fWXd5NWbvDy/+CgV3h3SMWGRrxxiyNB28XoteQYtpfbzU+iLmbjwHq6OOf4E3mtI2ZiMLYKlLs/oszENZBKX455BwXNqZuQscfZXb9pAWxgWmRNMdzFFhEcBQBhSRxGzi+ZY7lLsNnSwfjF/t/DcXTjVb9vjStd45ngxq57cEK/AgLaEUOZMS2QpDa8wpLHGL2TxMFkSSSDCgsnEJ1e124k9eOFuLC6iS880eB5qpx8uffyx7T8Y1MG+2jRgTvWHjzhTS+5ilB1862cq7Zwwo2RtLBhS2g+EmT5c5IdbyPc9KWlIR3Nl0YxUtDhlK0rO6D193jEn5orsCcKVGDhlCBaaOCNLCQbNn+hOpiG7lbDhfpjqL8MC+k44nmkzXgHYIMQ5CLZgzgUD24klMjEAaA/wBacxtMNKxlyfl8drOrw57zrdn3WkFWxD8Vccjg/HflFkY+eczBSTDUEo5apNrDc;4:Rw2VF8IT5H12Fux1g0rmDEtVy9yiIWksxqPtC0tgKfdL8li5JWRaBWrBDcftMO90umncy2/y022XwzJuCotX0GXAQRUxHAW2dWciG3Jd42n8WWH1Lez1EJn1u4unOdoeRriLdp46OZAU35Trnn0K1jzhhw2JYotIAVFWvHHlMbZ/iB0AiMkmGMopnAZQTH6kuy/B8aemJCgyWK9B1kIMitSHznX5SONOro9gEi0gKT4mCTGAXbYa9AKMx8uYp31eUTzH6qheMhMFyH9t8iSUR4sz2oxJ9hrWv2i8axwFhCWWL4iDokfECa56c8lyz01F
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2031E74509F005F579C1A641CD250@VI1PR0801MB2031.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2031;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2031;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39850400004)(346002)(396003)(136003)(376002)(189003)(199004)(7736002)(305945005)(65806001)(66066001)(6116002)(3846002)(65956001)(47776003)(23676004)(52146003)(2486003)(14444005)(76176011)(52116002)(86362001)(6486002)(31696002)(53936002)(36756003)(65826007)(6666003)(7416002)(39060400002)(68736007)(2906002)(5660300001)(25786009)(64126003)(105586002)(77096007)(106356001)(16526019)(186003)(486006)(2616005)(476003)(956004)(97736004)(386003)(26005)(8936002)(58126008)(8676002)(81156014)(81166006)(230700001)(11346002)(446003)(316002)(31686004)(16576012)(478600001)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2031;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzE7MjM6anVuYU9aU0N6ZnVBM3diblpyOG80Nno5?=
 =?utf-8?B?M3dtTXJRVUlBUG1GdzZINURlQUhxNXJ3aDF4TGZON2F1SG5DYTJYQ2lKcDNC?=
 =?utf-8?B?VWNXY0lQaytGdVlBYnNPbU0wb0hPUngvdTF4WlFxbjBXVkdHK01GZWJmZWtl?=
 =?utf-8?B?RytYNkZqSVZjTUJiOFpGY3VYejF6WUdhOUJmdml2cWxrTEI5SHNkcnJWUXRK?=
 =?utf-8?B?aURUNjdtVjlMTzB5aWMvak5vaW80UTdFZlh6NHVFbDBDWmd0Z0ZXUUZHVDVo?=
 =?utf-8?B?M1NKOUdGdmlqNzFyOHRrMGhUN0tKUGhYa0FSQjJNSE1McXFGb2FyME9FR3kw?=
 =?utf-8?B?ZGFYdVFHTXNEZTZtenpIQVJNemtCeUxIUnV4Tzh1RFFzbGF6TUIweStXMTk5?=
 =?utf-8?B?dVVzbGRvazY5UUw3ODJ3YUVNak1WMDZ6RUg2Z2l2UmtUVWtCRlNxc3lwMVZ4?=
 =?utf-8?B?KzNSZms0eVk4Z240dDRRa1o4RUVpemVhelBYT28zc2ZCbGNTVnFsNnpmN2Vn?=
 =?utf-8?B?UkNwUmlMWlZ6cXJVeXFMYlRnd3BQVnNrVml3TXhLZytRSEpOWnRDaTRubXly?=
 =?utf-8?B?SVA1M0xVdldPMUk3UzJMVEVXMFN0QVRqNnNKMFBpTEJITDQxeG9EWDJiTklS?=
 =?utf-8?B?Z2xQVkxFRXIrVU5iR3RVenFMVkJxYkJRdkU4Sk9pYXJRTnEyaWdGZTVURzU5?=
 =?utf-8?B?NHhUcGYrZkFackx4KzI2TW1XUnZEWDFqTlIxTFlvREZqSHMwMXNEcDdkVCtz?=
 =?utf-8?B?emlYRTF2UjNZV3N4cnIzc1Z1MGpXYW41amJzdnhPQWpSWW1BbDg3WTJmbXor?=
 =?utf-8?B?UkU5eWl1QkRLWXVudlJTZUxSRHFDaS9IT1E2bnl5UHJ5bjVWZVdvQUhTNGNZ?=
 =?utf-8?B?WGY3N1FmbmFpM1loZCs3aVdFcG40ZklBalZiUEUwOXlvdjZtSGI5d2ZUMEU2?=
 =?utf-8?B?Z3hNUm96R2lCbDRVamsxOTBzUnh1c0loR2Vnb0lYc2pPazBzVi9GcG1RZDRE?=
 =?utf-8?B?T20wbU1NZlJQUWh3V3pVU0ErSzhVUnpGeUVwUlpzY282eDB4cEpCT0tTV2lt?=
 =?utf-8?B?eGdnOFFVNUNBYm56a2RRYkNPSUlqdzZibkJOY2d3TGFVUm96ZXMydVZqaWg3?=
 =?utf-8?B?VC9zWTRDOEFrcUFkRjZJTStGMnZtSDFlZ3REZUIvSTN3VTk3WTZZaXovcXhP?=
 =?utf-8?B?b3psOTdiek5jaE0vdGNkdDdPdS9IWDgvOUQ3NVdid2VJeW9vRmlBZmM4TkJT?=
 =?utf-8?B?R2c5Ymt4UkVjSXd3TWs0QWU4emFqMnJrN0JuSzExUHVUTnd6R3RsSjZBTHdG?=
 =?utf-8?B?ejRUYkJGeUdJRVZ5eGIyL3NXQkRvTWZEbVhXMHl3RHEwSzc0aXVJUFlhUjBr?=
 =?utf-8?B?STdXUVRDZnpxVzlLZkJtK09nSHdxQlZvWXFJb1VZc3A0enVEWi96RW9RTjU0?=
 =?utf-8?B?elJOU3h6TXlZTGRMeGJ0VFZsVGJsazFqTVROY1lDYXBtS201M2t3NlovNk1G?=
 =?utf-8?B?YnNQZ3NkT21ZR25xbWlnSFkwTTRSc293cVZEanRnTUtZSzFMYWU1Um54ekdo?=
 =?utf-8?B?ZEp3bHlFVXNrTnNyZWRMMitHVk1jSC91WVVPWHZLdFRMbXJHVXA2OUkrUlda?=
 =?utf-8?B?Z2tnK00xbFpPc2VEYWpMYXdVME9ndE84c0ZubkxHRktTc08ySjV2dnFuNVN6?=
 =?utf-8?B?YTNtelg5bUxIVUhGTVVrd3Nud3ZIRkVMamJXRGdoODA5RjRKMjgwcnNTV1Ez?=
 =?utf-8?B?VE1QdDc1cGduSU1CRDZyby8xUkpmQ21PemJYZ1hObnJqb2JJZ2pRLzdJM0lw?=
 =?utf-8?B?bm9UZ2dWM25XWVMwaHJMblh3UnZqcTkyem9kOStvRGtUc29tZDZDN3F6TExi?=
 =?utf-8?Q?Wlq2BcvcTaqKG3gjuoZ+AvcWpNe3JQr2Zn?=
X-Microsoft-Antispam-Message-Info: Bj0LsaDdFXEJ92xGgkvX3utHTJqbeXklre+hz4K99YP2vB+Jb4NDxS0+Ke1nHK4BsIlU7/HzqMA+hrqXDagpW6GJpmxn+JO/LIKrP6O03Nhb+awu67OTTqWA2StvQoIiMdMeQdwljVoOs6K3NotfKO5erAbtjEjWPHRBexbp25g6aT85IevO4NHAl4ss3HkvZ+vX3GHr+oKW28TGGhvgd9+YMgpOa5ovXC/gxGvMmtbWrZXXb+xYlN9I4XbV/ldtBqxc3ZUtKNGf8lxJVKJx1NLKh5DuSs9NYzfw6kqwpU12b8eoqEzRdgEySISSVppYqK1zoYo8t/7c/1CXmZPzAuezXc69q5hRPlsO0vRR9VM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;6:Iv4aomyZxPsW4aj1iz7avSLbRdfkl3aX6WoNJwz8PrJMPsXHrOjveWiPhefg2SxHhIWF/tR7vCS8QKUEztyrnfEFCSGLa6wqmFvo41a3GZfdPf6J0vjyjlgaLeXx06vSECN1dUWVqkAhMYqe0ZhFFcFm4yik2AkrEVteSlAZEkCs3VUp3CDaL+l53NAzHTVwIwW8ac8qqUx5byCKVx8EHYoNW8Wrum2S4AFIxA1/oePadoyRwFuydS5+N+neTDXbeWZV73/4TmSUMDrEspOSLry77mZIhyeY9yKu1oDWQCy4TVMPaJ3eaqLe/QhOFGFg8awl4w+mZQ4CMglF17YYlpyFEqFaTZEM3DNLHSS+gyrgoh9dLpI2vLK3mdAi9tMZoiz8PCDszYP3BiBvUCrjG2uS2RqD92Z2qztCz9htoBXbSonI2TRXn5HqUENW72B/NeB/PVHvr0CcJ18Vr+NOtw==;5:MCiOmQOzN9IztNQCPQs5HWAigNP8HZ5pTs7DKeAwPUC1E10NyDhQm4s84aDxGP37jkbI4jQQLKGOF0qAwb2SL+ThMN6SaD7PMLpePY+CdyfjAgV4bv5lZ+bFCVIyuXydPSjYH9t6ubMwYd9iIT55GyRBclnqkWH7/L1ZINp28TQ=;7:fOvE2K0WDpgXsAoBE3O534WuO2L4901OCcGLknbh7pQ9O2C9dlvkrromI0HStK+WD6MIG4KYOcDrsyDv+cQEdC9sKlXF6sLrcJsQJazBlajISh/IUYyJiW7eEWIthbgfe4nRsZ4s80rQUPSiTYOzugE9WkVWXnRFt1gnA2I04CFfbcT07FzGTh8t/B5jCvxl7gTLfNeUYCBX8nri0IxKhE0ImoiZTMD7yCM/4UtZ7v9TWv/RRz/mTvYze9ycut1p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;20:xPvZcxSrnKYUeOER+R4Wr6jQ6ylbuIr42IQ2OGG0+ZyZZpyPnRFr8gYrBYMqq7x3O3DCJwbDIDeL3jpa1Xmkb0gqMbl9cuW24jrkvoleP7Hy08RwP8s5Nd0X4H+iYAejN6dIeoExtXkASKJHqqpkhbTCrrQARWduKI2xFx5ejyI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 08:22:27.8649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27afda5-19df-48c1-9e53-08d5fdd13f07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: Added missed #ifdef CONFIG_MEMCG_KMEM around idr_replace()

v2: Improved comments to SHRINKER_REGISTERING and written
    long description about all the things to the patch.

The patch introduces a special value SHRINKER_REGISTERING
to use instead of list_empty() to differ a registering
shrinker from unregistered shrinker. Why we need that at all?
The below is long description of all shrinker heroes and
explanation.

Shrinker registration is split in two parts. The first one
is prealloc_shrinker(), which allocates shrinker memory and
reserves ID in shrinker_idr. This function can fail.
The second is register_shrinker_prepared(), and it finalizes
the registration. This function actually makes shrinker
available to be used from shrink_slab(), and it can't fail.

One shrinker may be based on more then one LRU lists. So,
we never clear the bit in memcg shrinker maps, when (one of)
corresponding LRU list becomes empty, since other LRU lists
may be not empty. See superblock shrinker for example:
it is based on two LRU lists: s_inode_lru and s_dentry_lru.
We do not want to clear shrinker bit, when there are no inodes
in s_inode_lru, as s_dentry_lru may contain dentries.

Instead of that, we use special algorithm to detect shrinkers
having no elements at all its LRU lists, and this is made
in shrink_slab_memcg(). See the comment in this function
for the details.

Also, in shrink_slab_memcg() we clear shrinker bit in the map,
when we meet unregistered shrinker (bit is set, while there is
no a shrinker in IDR). Otherwise, we would have done that
at the moment of shrinker unregistration for all memcgs (and this
looks worse, since iteration over all memcg may take much time).
Also this would have imposed restrictions on shrinker unregistration
order for its users: they would have had to guarantee, there are
no new elements after unregister_shrinker() (otherwise, a new
added element would have set a bit).

So, if we meet a set bit in map and no shrinker in IDR
when we're iterating over the map in shrink_slab_memcg(),
this means the corresponding shrinker is unregistered, and we
must clear the bit.

Another case is shrinker registration. We want two things there:

1)do_shrink_slab() can be called only for completely registered
  shrinkers;
2)shrinker internal lists may be populated in any order with
  register_shrinker_prepared() (let's talk on the example with sb).
  Both of:

  a)list_lru_add(&inode->i_sb->s_inode_lru, &inode->i_lru); [cpu0]
    memcg_set_shrinker_bit();                               [cpu0]
    ...
    register_shrinker_prepared();                           [cpu1]

  and

  b)register_shrinker_prepared();                           [cpu0]
    ...
    list_lru_add(&inode->i_sb->s_inode_lru, &inode->i_lru); [cpu1]
    memcg_set_shrinker_bit();                               [cpu1]

   are legitimate. We don't want to impose restriction here and
   to force people to use only (b) variant. We don't want to force
   people to care, there is no elements in LRU lists before
   the shrinker is completely registered. Internal users LRU lists
   and shrinker code are two different subsystems, and they have
   to be closed in themselves each other.

In (a) case we have the bit set before shrinker is completely
registered. We don't want do_shrink_slab() is called at this moment,
so we have to detect such the registering shrinkers.

Before this patch list_empty() (shrinker is not linked to the list)
check was used for that. So, in (a) there could be a bit set, but
we don't call do_shrink_slab() unless shrinker is linked to the list.
It's just an indicator, I just overloaded linking to the list.

This was not the best solution, since it's better not to touch
the shrinker memory from shrink_slab_memcg() before it's completely
registered (this also will be useful in the future to make shrink_slab()
completely lockless).

So, this patch introduces better way to detect registering shrinker,
which allows not to dereference shrinker memory. It's just a ~0UL
value, which we insert into the IDR during ID allocation. After
shrinker is ready to be used, we insert actual shrinker pointer
in the IDR, and it becomes available to shrink_slab_memcg().

We can't use NULL instead of this new value for this purpose:
shrink_slab_memcg() already uses NULL to detect unregistered
shrinkers, and we don't want the function sees NULL and
clears the bit, otherwise (a) won't work.

This is the only thing the patch makes: the better way to detect
registering shrinker.

Also this gives a better assembler, but it's minor side of the patch:

Before:
callq  <idr_find>
mov    %rax,%r15
test   %rax,%rax
je     <shrink_slab_memcg+0x1d5>
mov    0x20(%rax),%rax
lea    0x20(%r15),%rdx
cmp    %rax,%rdx
je     <shrink_slab_memcg+0xbd>
mov    0x8(%rsp),%edx
mov    %r15,%rsi
lea    0x10(%rsp),%rdi
callq  <do_shrink_slab>

After:
callq  <idr_find>
mov    %rax,%r15
lea    -0x1(%rax),%rax
cmp    $0xfffffffffffffffd,%rax
ja     <shrink_slab_memcg+0x1cd>
mov    0x8(%rsp),%edx
mov    %r15,%rsi
lea    0x10(%rsp),%rdi
callq  ffffffff810cefd0 <do_shrink_slab>

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0d980e801b8a..0ff97e860759 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -170,6 +170,20 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG_KMEM
+
+/*
+ * We allow subsystems to populate their shrinker-related
+ * LRU lists before register_shrinker_prepared() is called
+ * for the shrinker, since we don't want to impose
+ * restrictions on their internal registration order.
+ * In this case shrink_slab_memcg() may find corresponding
+ * bit is set in the shrinkers map.
+ *
+ * This value is used by the function to detect registering
+ * shrinkers and to skip do_shrink_slab() calls for them.
+ */
+#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
+
 static DEFINE_IDR(shrinker_idr);
 static int shrinker_nr_max;
 
@@ -179,7 +193,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
-	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
 
@@ -364,21 +378,6 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	/*
-	 * There is a window between prealloc_shrinker()
-	 * and register_shrinker_prepared(). We don't want
-	 * to clear bit of a shrinker in such the state
-	 * in shrink_slab_memcg(), since this will impose
-	 * restrictions on a code registering a shrinker
-	 * (they would have to guarantee, their LRU lists
-	 * are empty till shrinker is completely registered).
-	 * So, we differ the situation, when 1)a shrinker
-	 * is semi-registered (id is assigned, but it has
-	 * not yet linked to shrinker_list) and 2)shrinker
-	 * is not registered (id is not assigned).
-	 */
-	INIT_LIST_HEAD(&shrinker->list);
-
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		if (prealloc_memcg_shrinker(shrinker))
 			goto free_deferred;
@@ -408,6 +407,9 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
+#ifdef CONFIG_MEMCG_KMEM
+	idr_replace(&shrinker_idr, shrinker, shrinker->id);
+#endif
 	up_write(&shrinker_rwsem);
 }
 
@@ -589,15 +591,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker)) {
-			clear_bit(i, map->map);
+		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
+			if (!shrinker)
+				clear_bit(i, map->map);
 			continue;
 		}
 
-		/* See comment in prealloc_shrinker() */
-		if (unlikely(list_empty(&shrinker->list)))
-			continue;
-
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY) {
 			clear_bit(i, map->map);
