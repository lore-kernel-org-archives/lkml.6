Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6660C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE4221A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EncDQrvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE4221A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeHFNkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:40:09 -0400
Received: from mail-eopbgr10095.outbound.protection.outlook.com ([40.107.1.95]:45039
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbeHFNkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hbpd0djh2sua4XO4TxRr3oAHqdHV0wEZMXfIJTLdIo=;
 b=EncDQrvKZMvtTyIeZi21dGpd2lsc4ZudnS5AVxzkyaELZVqiAUBpXf6gtU3/Sj6CTE16AkA1LZH+T19PtiC84UJV+ya9+Zd/GFneeqQrtLJGu77KY4Kw2jIpJHPrGc88GzxZWJFW2bOdy6la5ottWQI1YM5HwEdNnM/MFmzlRdk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2028.eurprd08.prod.outlook.com (2603:10a6:3:50::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 11:31:20 +0000
Subject: [PATCH v2] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        vdavydov.dev@gmail.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        ying.huang@intel.com, penguin-kernel@I-love.SAKURA.ne.jp,
        willy@infradead.org, shakeelb@google.com, jbacik@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Aug 2018 14:31:16 +0300
Message-ID: <153355467546.11522.4518015068123480218.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::15) To HE1PR0801MB2028.eurprd08.prod.outlook.com
 (2603:10a6:3:50::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b548cf01-724a-4ab1-7f75-08d5fb9022fb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2028;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;3:WQmCJS4WpCA8Mb5UD0/f8tqtQqHTTZ/Zw6KJmwtE7EnGpLgBWvB6L7Hr21CU++twgzwsF4DvouytL/V/9/nMtHZxhhfKqxIqyaAoyK8KbAR36CcOHqQM/ZpIEp9MeTIGmCpE4nQLhq5DMuGX9Qk9e1ZaZFVda4/X26JW6Bssnv1733cwnThY1CG7U4Ra/znIlB8UjINrzweKwi+8kx1O9Bb6PtVvE3XIu7ixCY1imGDfcB+dcQgF2QUvBVRZ3COT;25:mw7VRq+70aDzWjIp7fiJluxr8pvMs7n7gUUx68diD9Uh/C5+Zksuqyin6DzvjW1Y0/wcw66LvhZAWsNYAZ3dMbaOG3fmvX2NamSjikNcdTNLxa7BOQkaPSP82x9QjxJkyFoSUS8cx+ZDFEuxNen1b7fXZ5wKU+ewE0N9hfWl21k3xPM3iTa16G61YY6cxAqbz7vfsspFrB/tM5SIE/BrH6dTQ17CEbWdPSpxA2zSCbUWAYUjsKmC1vqNQFpmUc7lIClv7sTzDotnc8rgOLmoVrzBTTFbEGv/+1ok/tUVJcDWWKxyHBgcf3c08zlupUljEQ6n5Iy+4ai7r7XQnT9g+w==;31:9S5ie7F4MCMYQso3XgNRAOCbmbdA1/h/Q5Ogd/DgG5OI4APMQ3/+Pm2s3Y6KmRybgFEeiDPRLZAUSpmts8/CDyDXyIbFCQzbINpUjxDMeZiw6qGP3dwuib1daGz4bgxDwinFoL1xw0gK8hpNAvPBDyy8fLK7a8NBedNMv60LD0TiELYIy1NuwbiCdSS0OooxQNoEJEnNI5LTy7XB8GgbrGGVe2M7sztFsdL09ZOQo54=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2028:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:Tbt5+FZYr2/GOClZ3Kn7qAlXUEGW9hMbFZwPHeiZSZGwPuzENyZ9KMZKaKUPcPkEWJCOgveQkKBIDl3uBmPEygMZm6QaNHo1nClsDiK4qChP2gcFnZXhrFKvitc27HQmszttZhSvHRlG8hxNAqK+7AMpzid2P21nhyi+ua5014DjukFh9b4UNvoIip0v02X9VeBLArpz5Eph3aFL9iVgiffe1ziqk/TRyHZxjGkNJThRChGWS0LTSwzzxrOUjtxNUXjbWDhB8u1bYttxUvT/zPBR8L3hx0NyAAetxFHR103z6sWGlIzPJaeW/sNhfUCI2kBjpq/ZGEIA5Y4J+V+U3xoEaqbrvBiis81AEQV5L/fBshNMmsTbqctg9pEZmvNOXjql2K+Zvh5xnXPQ0DhRbKO+YZxAAbXyAB0rdQuFoM+XShoqrl183BPw9kvBmcAsPQKz0+ByjpfZO+zKtvDGruf6DB4layGqeThuciVG+C65Pb0hvNcs+D0xrD6a6QZn;4:yDKb4jEgLhUehvtlWdsTKfziqEe9IyMKyxOvJbMTkEv4kYkQttpkocTiCOsOUExJy6X8EdswDh+sAdSjRXP3Wds3hmqbGcSNIwHKP71ygj67T8fQ4NwVaH+Fn3rOVqzcvaRkMra/Cfmf4Vg/1m9CKrUUfSBbNSq4D8dUUzUM/PgkGgtB2BHIRjk7vlITRsmfVnGO+y9V0Fe4TnJdgHYGgUdU0UtzF+GC3VYaXsd5boVDTbCliL5XLWtq5q1z8xzj68c1nD4Ka1sJHJppppjGhK20T+2tKEUfwnh3sohKXpmm3iM1IUqH7Nsll6dcusr7
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2028ECA8E223A7496E5C1ED3CD200@HE1PR0801MB2028.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2028;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2028;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(366004)(39840400004)(396003)(136003)(199004)(189003)(7696005)(68736007)(386003)(16526019)(186003)(52116002)(23676004)(97736004)(8936002)(81156014)(8676002)(81166006)(33896004)(305945005)(26005)(6506007)(2486003)(14444005)(50466002)(486006)(106356001)(105586002)(7736002)(7416002)(476003)(316002)(5660300001)(58126008)(6666003)(956004)(230700001)(6116002)(478600001)(3846002)(53936002)(39060400002)(9686003)(55016002)(2906002)(103116003)(25786009)(86362001)(61506002)(66066001)(47776003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2028;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjg7MjM6NC8rRlRLZWc2N0htM21ldm11RUl1dWNB?=
 =?utf-8?B?bjVyMFMydU9Od0JPZWFGcjhZVDhTczYyeVVabzM5QVRrdmhWTFl6SEZDVVdu?=
 =?utf-8?B?azB1NVR3SFU1L3lDaTl5N0crVnpCVHVMckNjZDgvWDRqUHdHSWpWQjRnS3Vv?=
 =?utf-8?B?b291N0toekFHd3AvOEJPc1hPUkhEZVo1VEo3cUlLdlRCQU91MlNjOS9ockJR?=
 =?utf-8?B?dE52dHZUaXBoSjFsOXhFQkhiVHBQOGxsUW15Sm42VmplSHhoMmJONGg2REYr?=
 =?utf-8?B?T0JBckdvRXdIdkVaZEhaYVczQVlqR0hJTFZzd2dRb0pwRHkzUTdUR2tzZmhS?=
 =?utf-8?B?a2EvWjltNGFTR0ZtMXJNeXJ0cTNDSHV5UElqcm8zL3B2VzFibzFmUE91ZTdr?=
 =?utf-8?B?VGNJZ3lhYWxXSDVhSTRhZ1E1T1FiRHIvd245WDJtQzFFYjhRSFpOYUkrNkRh?=
 =?utf-8?B?ZzNYcUNGMEx6Um14UFJvak1hRzllbXd1ZnUxRmdZKzg4YmR0NVkzQnR2c0Qz?=
 =?utf-8?B?WjN5T0o4R3EyY245RUU3S2dPdWFhQkpjRzVmYkgxQXdUMjJ3Wk10RXVENnJZ?=
 =?utf-8?B?d0VFYlFoZGxxWHloclpNWThEc0JYNGxpeDk3bjViaTM3aCtxeTVmcGxCQ0tV?=
 =?utf-8?B?Rkl6RkduUzdleHpVNjAvc1dBdWpSVFV5WnBDTFBJdklkb1djbERqRE5xdXFl?=
 =?utf-8?B?Q2MrU3VDaWFlWEJKZmpEMjFYaW11RVZSRGllVlZhQXk1ZzdhaUZRdmNZYThh?=
 =?utf-8?B?VUM1WU4zZG00VUtiK2wwdmYzQUZUd245d0E3M3NNQWZIUUM1d05Jbm1rZ3lw?=
 =?utf-8?B?MWcvS0RRSHVIbkJXLzlRTzh5RGRnZVFKdnd5c1poR3g2bUVNS3JLQUc0NkJC?=
 =?utf-8?B?ZG85Ym56RklGRjBRalJRTUY5UHU0VGZDM0h1eHpjc3pWSjVGYmZ4ZmlaRlkv?=
 =?utf-8?B?RFY5RUd4Zk1wR1VBS3ZSYmNsWGF4K2pqbUdlUDBhSS9zaDVaNVZsam9lSHM1?=
 =?utf-8?B?VXBENXE0RmhSNjFmanVKNzRmTnY2Z3ZrMmcxaW1iSUxTSlc3QnkwZUkrK0Yr?=
 =?utf-8?B?bUZBTmU1NmJ2NlpMazNiOHFrRVNlRFMzU3lqSjNGbExDTEJadDZNMXAxQVpM?=
 =?utf-8?B?YklDRUxNNi9sQzRiS3pCZXVXTU93czVQTWFmckRjdVNIcy90K2NRSVE1cytx?=
 =?utf-8?B?b3dTNk1kbHRXUXpVeHB1WjdiK09xWDN6Z2gwUzFEUWh0YUoyRnppZzZhaFhu?=
 =?utf-8?B?ZW1JbGc0WFM1WklmNXBiR1Erb1BVNDh5RXFQUVgyU01odnFhbkRVRTFGV1VN?=
 =?utf-8?B?R0RDWFJsZzUxT3lzZEl3N1dZOFhCNC8wK1ZEUU1sOGNLREMwTDQ5eEJvUi9E?=
 =?utf-8?B?RHU0dFArMGpJOG9PVmFyME0wcDI1dkY2bjFscktoL1VObmlzWEJzKzBROHAv?=
 =?utf-8?B?Sk43WGhtakN5cHVVdmJmeGw1UHpMMVpnZVJjK1FOUFdKQ0MxZ2k3MmJTN0Jl?=
 =?utf-8?B?TU1SRHdvWnZaZWozYTJvTE1IY1lLY3pYSWQ1UW5obG41YytjOUtLUEhQRmM0?=
 =?utf-8?B?VC83NkN5RU1lS0d5Nk9teEh2NXNkVXVHZWR6K0YrU01KRkJ0UHl0SHk4bW92?=
 =?utf-8?B?UVFQOGNDby9PeUFEYU9LcGRFRisvYkh5QmRXc0R1Qk1zalFHNFlNdjcxRkE9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: tl76/yzTh1dXegfkuxIGzxE4ol9ZJuILe3DZSYnQqovGr5GbupMMhX7vaprrVYpHQMYj4bIKvnZfVehFgD4NKhV9CkO/EEuUjwcKXOudOaXOs0AQcrOIC2yk3PTJTigpLdkC4PJCfvdcr3o79YwHwgIRc7NT/U0kxAUE08maGSuUnczGTfEvq/FnzYolggeJoUqBRQre3H+xKkPdC73DSmwWYPXuFb6dlWROTXKmRgcCfeZre4Dj/x8OaRzCsnFE2NPY4hvnWCM+lN5qsHOHKFOm/EaEt5K1T2Vxy5ByzX/bavszgmtyxKrU5Uej982iAKkbg7gEv15XxMvLSonHhF7wM2vKOXtTtKW62FL7YK0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;6:Ybt8BH+rh+SRNnBhxb9HNnKbgQSOAdv1Urs5LAS/85mJL9bXAk3lwK5GbpEobRfc1Pr1oawtPhNpC1KSdSbVe7R2H/ufVN0+bIhkzzUoOzHAFCxW4Sp5gucaI//TMuxKBINiFS4GaBIveXTCCsrolbBp/8BtpwPQNKBbFov9ZvaBX8GW9NhmwvmFpQ52DeCeu8d9rU/oHl3oOqpvmL6NxIEysOiN2iXvYH3+NK7FxTkMrDvCZYysGtJ2g9ncVtOMPTUEdRcfALIP6jRZ51+vet54g1IDy9jcFzfq6xtVQLekL54fhb/3OM90INHqh+4h+db9OnUHab85k55N0vU9yAQKVCrKPZJXWiwLzhQqrVXlZl4wwbvON58WGVsCjAfY+w1oVdCpj/RU3FxYGYYu2KP5e4m9zZbb4Ep/+vzXZosQ+lAm+f9ljDUoKQgU5vwQRdOdtJkuqSE3GwyTjlKT0Q==;5:VMR4jwEf3WZfQopKrgcNQ7TMmKBFlhUMKAGRVQebgKWOmApmYYEEDzpww1Ukq3wLqvfYDeeMdMxqw6hz1LPNOpbQ9Sb9sGzFJq8sVft6rcsomN02rz/IMz7MCK3fIuGZd9SM5UnAd+Iw8un5rvpfaCBDCiNIMKMApFZNRU+YNmg=;7:9bT/yStwvUQNpdMOUb1ka090n0waSSDxmR91txREsRpjYjy6+42DX5KnOgP8Pf5xSiVYMzsRUpmVA9BbkqJMVTgEqFklMD2Hp7GwWWtKhIQDmtSCYHUzr65BVC1+anxN+Hle5JnC8P9WHWyvPlfv7zjQl5uVKs3Dfu5OdKsc7u4ysoR9dTpApsJdLEFXfP0vgELjA60CdTSHVBarxA9W57OOOtM1SmEFkW2Cv5smzRoLqv5ybILFZfLhJ9ahpEXJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:bJq+MKgk83LWnBy28LgWoGfFe0cE6Y/k0Nh7uNU2S8iT/x4Yq9U4vHUNAFoddLSkMWuXnQJU//vxarMTp4b78NbmbcgH4pweQS4WUcBN9Oaw2DNnt3JvaiZ2mGKc551ydZ76e5RyXQQMXkiIKzHgb6BmFwCTaKCbJ5oefwyxiyo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 11:31:20.7920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b548cf01-724a-4ab1-7f75-08d5fb9022fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Improved comments to SHRINKER_REGISTERING and written
    long description about all the things to the patch.

The patch introduces a special value SHRINKER_REGISTERING
to use instead of list_empty() to differ a registering
shrinker from unregistered shrinker. Why we need that at all?

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
   the shrinker is completely registered. Internal users of LRU lists
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

We can't use NULL instead of this new value for this purpose as:
shrink_slab_memcg() already uses NULL to detect unregistered
shrinkers, and we don't want the function sees NULL and
clears the bit, otherwise (a) won't work.

This is the only thing the patch makes: the better way to detect
registering shrinker. Nothing else this patch makes.

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
 mm/vmscan.c |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0d980e801b8a..da135e1acd94 100644
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
@@ -408,6 +407,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
+	idr_replace(&shrinker_idr, shrinker, shrinker->id);
 	up_write(&shrinker_rwsem);
 }
 
@@ -589,15 +589,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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

