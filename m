Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E7C208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hOyVd5Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E7C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeGCPO7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:14:59 -0400
Received: from mail-eopbgr30124.outbound.protection.outlook.com ([40.107.3.124]:8064
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932747AbeGCPIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHTgvwNcEz1UMo0tHfHk7Ou+OelPDIrwNG1onEdIKqA=;
 b=hOyVd5BaVJuarGPEGOQQfAAXMefyTHCl91Fp214RXNQ4bRUMZWjKjhYngMYfAjVUBXtzmEq0a6dssRHkcqOrmdmw9DayGCAqivdfDjMhJWhQdGD1RyIRCROc3AKzSH7Cg1g3qZxbX+jUCCIkAXUVczIiAWQ8xH68U3uMP8+sr8s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1343.eurprd08.prod.outlook.com (2603:10a6:800:3b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 15:08:48 +0000
Subject: [PATCH v8 01/17] list_lru: Combine code under the same define
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
Date:   Tue, 03 Jul 2018 18:08:45 +0300
Message-ID: <153063052519.1818.9393587113056959488.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0018.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::28)
 To VI1PR0801MB1343.eurprd08.prod.outlook.com (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a91cd87-8e30-4886-d997-08d5e0f6e2b0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:myGW0fF/MWCHHxy/raWTrktUMR+VW0rjUiw5jYoaA/Nc6yqpmoJstj6EyRIUppZCz63t3DC8cnNpC+hmYgN0yvIIXINAXnz2Y452Xa6xsU7FDml/xXUnBQxo+InYM/Pjf0oiOTB1+n3h+NIdSPZ90CEN3mpkxdHHgbmojkX5TAm9VvrYr2wqU9v0mhoGEAjocpGAlwS5NDznsTLdfcpemBE//Nl23s3OSQlNRvdKOF36O5oh29ldQ5VDz+V57jmx;25:MUFtAqWk5+eP++7AIjhn2NlgSMeH8TqP9ZMDPklgv51M2yAIVF55DmuzMFBM9ZZkiMqOgOU8VAVI7xwsF+cqSCpj3OWVqUY6uQgGVyjgdyjojuRFBdbL+8X3TFMjCLc4JNmR7CscuIgwO9thzQHO0hzhWoqHfxHXIBq37qVWGqee7CE3yfjzCI8a37IUD2OMFtucjtUCXd430EumBNV6d3D0+PfU87NOVBY9+SGsFqPjECyRUELBHmg9puVv2+/v0fzz/N/HguhU2Qo0Wk0EI3DJu9dGag8EbVgv+V0e+LSyAiU81R8Usom6OXsbWCyddAf9zF1m4zsxQ+9itlamfQ==;31:nnOiQxvoi79/Hge6/xAe6lRZ2hxAuWssTtCxJffJnTzoSrr5GSMP0nj0DiWKo5e7nu0teezY7+ZgrXSzySBLNm1ujx7KZASNUvhSxIY1X1XJsQhhii2G92pW3M342h/UnwJz3m/6BGdPcOgc0H8rKjtnkZuK0CGlQn+jDfAJf9CZlavbEm8VneB7bWgYv7AuemAWy7ix9q6VTSnocfT8OphbD6F/t8t9D3B6n8GKJNA=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:ZXVbsb+XMOLVQ5U7ZdfW75zTJIIiFL6ty5j4VXLZKr/eqsvz7m2eoeV/gnO2qkhg2UpcBbsy3L3+F7ml1jBA6GCxlLFnfsCTw8FVzhTbqTUb26KujAtIUD2gd6eSIhOKPXAZXq0wQQwEBrsG6/Xq2k139jO1aUtsCxI730/VGa/XGbt2in52tZmoYtD/484kkC7aEDQfaPxzApSNoD9hpI8no9mjal++yrsyoEfCjoJta7gj3XQJzZgCWVempPqwgPDzcmhd0xSkRqUIPIASJTKq0Rcnw7A2zFU7B3eFpR8WN9XmNPi51eOzyqoViTkNALjSzX6y7xwAQs2dIyL7qQeECoCAg8CrpGrS0bGCScIvf7S1V5nsWXh8dsMx8PRvP/wPIhNNe6onFBJvy0wkoBJ9TsetU2sjHw9VEr86TBir30rIdxBYwBwxcLbeRbNXBu0MLkXtwaDpdPEclJxBx906ds6D1fw2wunrfabZqwoww64jXIllcLofQdXd95Q7;4:iWYic+aC88HT4kI+gZqCrGcaFtEkCNL4ZG6nKOkgioMbOpZWigdm5DfAIvkaGd3IHUAos3qWbnnU+oxS6aaonhIPwoaW24RhTXKinZnZQsvZmwGofPjtIcIJrJzNVK7URWxbowzrDLS2djGP4DFp6/hgqKk4W7MOcCES8XHjX0HFgGSqQ5v+A3NBfMyybxYTaKpUbOkCIJF/uCrxjdWRZbQbHo0ij9KO7kEUCxILlaOFuD8a9uCD4FVIKT7HDLfTYvRwY73RPBWYTBcfi/WaKI6stfBNIVosyjnBm1JjWvWKNA2tsImC31oxOuH0hPNZp7kF1zHyk9q5Zw4lLpHUrH95JvjJ2oSQmHVvdtCNMYAA+y+pCI8+rYuXn+0/mkT/
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343ED6EBB84B068306F57C7CD420@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(136003)(39850400004)(396003)(189003)(199004)(50466002)(186003)(16526019)(103116003)(26005)(11346002)(230700001)(23676004)(53936002)(39060400002)(3846002)(7696005)(6116002)(76176011)(52116002)(2486003)(33896004)(6506007)(386003)(68736007)(25786009)(81166006)(81156014)(486006)(55016002)(8676002)(106356001)(6666003)(2906002)(446003)(7416002)(66066001)(61506002)(105586002)(305945005)(5660300001)(47776003)(7736002)(956004)(316002)(478600001)(97736004)(476003)(9686003)(58126008)(86362001)(8936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6dXltcGY3c3Z3WGp2cFBnS3V3ckUrczNX?=
 =?utf-8?B?ckh5NkNXVUlXYWhtMjViT0tZakRnUk9XMGJGNG5CUFpEWlovRXNFWnJkRGtz?=
 =?utf-8?B?N0lQYUx4TFFieXNKK1c1bXNicXRmRmpuaVZTNW0vSTVyc3lLODhEOTVQblZF?=
 =?utf-8?B?V043NDFUaGJ4MzJOcjh6UTBhK1BTYUJqaFZDQjBEaW1vU1RDVkJrcmpUc3BK?=
 =?utf-8?B?U2w2eERzWjNBTXZyc1hMMFdMY3ZWRjhWb09ZOWFjWUkvMlU4TUJwVFJHN0Jy?=
 =?utf-8?B?RTZBbWpDRkEzRW1NL0ZrNWRuT00yL3JUNzBhaXNZWTVLWllOc2pqNDBtSFNS?=
 =?utf-8?B?SEpNMXlTZGJTNFBFck0yQ3pXODV0VW9zbi8ranVuajY4Q3JKWVJKWk9vQWFl?=
 =?utf-8?B?dkdJWDVSMFB0VlhEdmpkTEdEMTkxcWRFTk9kaURFam9zWnRpWWFvcEJsMXlG?=
 =?utf-8?B?aE1LaW1aQmg1eWlQelhPbFFoRncvaEVzU1liNFY2WTZTUmJWN1g5T1QvL1RN?=
 =?utf-8?B?YlRMVHpzUzU4N0M2WjRUWVE0UnJuaFZLNEhrVE52cnVEWUdBRzN3L3F3ZndU?=
 =?utf-8?B?OHg5dFJaWktJaVNHc2RTODZZWmdiQnlpMCtXUThhNkpTZlJpVkJHQ3hUSVJv?=
 =?utf-8?B?YXlhYU1RQVlnTGRyZ0I1OTRXRDdOQ0xmUmJ5eSt2dTltQTJQL0RiaUt5bG0w?=
 =?utf-8?B?b1JVMnY5cE5xQWxCRml4TkVvekVhb3daNURhaTQ3dS9mcDJubitYNmNyd3Uw?=
 =?utf-8?B?VEJMc2NyMDMraEtFQy93R2RETlhLUXV4L0E1RWdMd2dMRi9ybzZFLzdXVGgx?=
 =?utf-8?B?elJPY0FybWhwSDJMWTFQbSt0eDNXU1BNN0s0YmI4VWh6dStTejZTRGZhYjRu?=
 =?utf-8?B?clc2YWp1TDFtN3Z1SnBURUF5MUlOemJEZUJ0c2lTQllhNUJiQ1VObkxUMWlS?=
 =?utf-8?B?VXFRaVcySHlSbmh5bnNMRnFhMkl1YWZHVTVHcStWRDBNVGk0ZlBMOEM3enVm?=
 =?utf-8?B?Ulh6Q2QyUXgyWHVnb1R5M29sd005YXFSNmdCMEdwYzhvdHEzVjlzL1A5RXNu?=
 =?utf-8?B?VU5RTGErV2FJWm1abkh2YTJQOU5mWmE0UDlFb21TYjRzV2EwK2VtMVpqayt4?=
 =?utf-8?B?a2k5ejBRcldtT2hFZ0tpaWlRbitPcGxZRUplTmNneW5qT0NLTnZJd3hYZjkx?=
 =?utf-8?B?dlZyVzBkTi9uU2dmZGU0SG1nNHUvcFJuVXFHL2dnYWlPOGNJcEV1MVZsUTlY?=
 =?utf-8?B?aXU3RHhTVzErenNVdEJBcEdzbmdyQ3FyZnpoaWtRRVZWTmxpczZRYm4wdkpo?=
 =?utf-8?B?ZnF2K0FrQVY1TzBvODVKUFgxUHFGcmNSVlltOGREUlBucUtFelRrejAvRkhs?=
 =?utf-8?B?aEpzcUNWRHYvUGJEZWJlNzQ0b3Z2Q3ZyRUJZYzFCdUNrcUV2MmlxYWhQK216?=
 =?utf-8?B?UXA3T1h4d1BRMmpFRnR0WWtuQS9waFhRV2h4SmtFek0wZmhQaUNRNjZKTXI4?=
 =?utf-8?B?aTRQQ01ncVVHMmp0bGZ0cTRxdFlNRW1ldEdZU1M3RmQzUzZMSnU0MTA3cXMy?=
 =?utf-8?B?dU9HcndMZXJ0T0VLT2xjME1YNmx3dS9RcHNRY2ozWjFsckhpT3N6MmtxWFFq?=
 =?utf-8?B?Y09zaEhZZ1l1YXNJNEJwVjh5aE9MdDdCdWZpUjVWTzlZS2hzVng1dzhIc0gr?=
 =?utf-8?Q?eVHjdIXwvqvZFHa/rO//SImUn3rfmK0kJ231vEFv4?=
X-Microsoft-Antispam-Message-Info: /dZSFLPnfdZzLN5mSy3vwgegdAkbwkKA19l01nKEGNoUyW3lioGLm+x03ygtIfUSCl59TTZWtqVklvo5DvnS4WdOvuhGi2zrxI7FqbxvzYfxjdxt0CRsUvoL5yPa86QoAZjYF1br1zZ7QX7j1ZwBSibnunU4Lu9WByBEH1EVcNX0Xy2ln73GATb4YeWUwYqYWQuEGejLXJL524H0tmq9zrzao8epbMJx1oSFhgESggL8TA4zSAvUFdYANyBltYYj6fwHiEOYvtdTUfZNXUM8aH0CD+t5cejKrMmrffa8nTKJ+cO2fo3VuL876uSkdc8eYk+/8IeBnvoZvo90Bd02HNkxGsi1+tAyCWqySYFLc/Y=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:Mjg1zIY8zQCXfxvGz7gUBbqcQCDas4+6vHoB09yAo9p2502k4tl7TgP2xdxqzpBwcSH+Iswo2cv61+qAVrdwJi9tDvKQ1jYIknCScZGupJwDxnnS1tl8k9Are65WDcFo8p6ukKYfWEVxsTCn802WsBXe6T4+vyhwF/t9fPUgVMLjV+hJrJFNkpjWupIiBfjj7pki/IVHh6FKzpHfaNc0CnQqRLp3ehyoSq8JEkJXwc+R9hOgsrfoJ+lv9802yNBUAzljm1n8Zw91ITItky3ltYbXZNs1mn2oJ/44rkOkRm7j6828KCmi4TFe9cMj7/mcnR/nGtSEyAo9Lcbfh7mkYcmDnBZZEvkLoMWBmrP9xiJ/N3uM6GUYQ2VsujNpqKzrZJ86T3uWv8Y7pG1m5Fp6Q/4cElu1GKKTJSChqOg+xBGj0oAnNrpo//5gRK4fPuLMWA95xeFwqSDQFvl2yx+UWQ==;5:nXooCj4jjW6h/43t00IQXOzdrEZomBGjmm4dXCb0525u2WhW5TfoXUH4CGa7fdp5gYP5Ze4jEu4VZPX0vtBSdRkrsNf6TyN6NlAg8EYr6TQ5FXpWJCHQ+doLAdw/cuYPBybOxevRzDG8B056z7yeS3fLgDtvJ2EF+ucqauxYbhc=;24:ty7cTtNPT1FUBsTFswWF56qux18qIWEkG8bkvHvS9gmCmHkUTrqrTEyoUCRWz1oeW0rMumCSvrdaG6eNqDONSM2PxN96x3gMG+VYmFQ2LOY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:fUqO9QH+bvgpl1PK3ft1nqHNoO7Z6wmOV6FNz+p2kVzXUsUpQZ1/Ub4KhtVgkEFYV3Cblsm73QW6EQ/GBD4C/0ON9NnHqIeUio2GXQH1Xhk1NUfCfLnES5Yhtg4fvd+fsYXNjqXQHPeqMY2hXbU0KkvIEWR+gYXh3qZwQ8ukDJExNs4awG53qPjJs7Dxyptz7dZ2+ou/1k6MVVlOPnB+NC+REoe8OOA4aUQ+OME4onLfdMrcAs4PTR/7sj7KxKlu;20:WwYWh0e7GQB+Ovz3vHSezWe+qfUdaMMwmzPVeXv8HbKoFOV9/HGjLo6X47BAZ1NLlklroGzK65vOQ9J5Zt3IRY2ORT507DaG5BSAJOo7YDY4qgOMG0xUEyhVq4AwfcclR95pRqe2p4qovt7/n5ihucrX4VWFvicyEQVRHZjuz8I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:08:48.2556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a91cd87-8e30-4886-d997-08d5e0f6e2b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two pairs of blocks of code are under
the same #ifdef #else #endif.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index bff3f6b615f7..b93f64f25414 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,17 +30,7 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
-#else
-static void list_lru_register(struct list_lru *lru)
-{
-}
-
-static void list_lru_unregister(struct list_lru *lru)
-{
-}
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -90,6 +80,14 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 }
 #else
+static void list_lru_register(struct list_lru *lru)
+{
+}
+
+static void list_lru_unregister(struct list_lru *lru)
+{
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;

