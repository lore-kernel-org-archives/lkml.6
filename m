Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AtBfHA2UG1udEgAAmS7hNA
	; Sat, 09 Jun 2018 08:47:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 55399608B8; Sat,  9 Jun 2018 08:47:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cSbs/ihl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A10BE606FA;
	Sat,  9 Jun 2018 08:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A10BE606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeFIIrG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 04:47:06 -0400
Received: from mail-he1eur01on0115.outbound.protection.outlook.com ([104.47.0.115]:44464
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbeFIIrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 04:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdB2gyP3Buu4bAEDHmlvps/S2BQ9Ih+WCZmNpdXxaXI=;
 b=cSbs/ihlPV2vi+y9rVfD92/KOEhjZ0S3WdddU/JtSFughW7AGcjYeDs9j4cfPWyxidnBpH3JXkAU85fFu5s4rDAnDZmrWUWiVzWCPDN42Lcq1AON+OFFArjzxn0NYCPD+W9uW5r1FEFOg0YGRJJC2znPNKwqfZ78cC7TANrVdoI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Received: from [172.16.25.5] (195.214.232.6) by
 AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.17; Sat, 9 Jun
 2018 08:46:56 +0000
Subject: Re: [PATCH v7 15/17] mm: Generalize shrink_slab() calls in
 shrink_node()
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
 <152698379298.3393.3040399931339145602.stgit@localhost.localdomain>
 <CALvZod4zzw0f_q4a1HpMHWjhjfK9OcegRkAQb5ZSyfjAYpAfJw@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c9f0cf2a-5628-6d8f-662f-a381876208c1@virtuozzo.com>
Date: Sat, 9 Jun 2018 11:46:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4zzw0f_q4a1HpMHWjhjfK9OcegRkAQb5ZSyfjAYpAfJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0062.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::30) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:VFmjw3SXaIxONLo899jiu+NL3e/pjtc1Ld5PaZGaono8FoXAOLd4CRyDznWiz+VcJoj3XgmY4r+xAu8pfMb/pRf1QWfATPG3MudApiG2FHf8NlREceROsGhmyw3lf9kMjZtLEVZ73Xp97/LWQkEU+a4sVaVDdVoHC0gIXUFeDKB1OtC+2LJI5i6PuQ8Fs3RmVzpKwV4ddbs/sMvChl0OsMuLGBCbdYC7qF8z1tVM5BinBShJ9857oNNjJ8/8CS4i;25:Bkw78D6r3XXKnts3dvBp0GTRsxsBFZt821Q+rqg1XuX5ald+XXHK//+L/bn9XK4utx1+d5z9qoTL/SHH5c7uI+l2tvIPztFWK8YboYaoHd/UkvTkUXkngUkYVvyTCL6KB5OxYuhwaGq1zDmY7BA/tiykcgERfFguZZcJEDw1qJr+UiVpRDYYBIlNUUYbOdS+WfVNQzcwniuq/m9Czn1QXXfYLysGQD7eDB81CfPRQi/9TVbZg6QvMAro8ioHoEyXQix5YSdFCXLRVvAv2w3SLJnTw9T8KVHwVBhaE9COM/E8N58l9BjeKqcgZQhzDESEWgL3jU1fetNaFUZIpwFkgQ==;31:dOvLv6DZBtbYVzNlRogMVgPycDMpDBK3TzoyAfFgZqFJqDBE0U4HoeQ9nG5uxE0qNSQ/v70d6c/mFZvbnErG5RJaymigOuDqiDz7CWlh+mNS1SB1v/8PRJ+xl1d4E7Y0+8rVJN00uHji6vV4f1h9HFtFI60mlVGyITl9+h/tkSfeS/LPfwE1NTvTE0lCmni9s3831bumCYHKbJYyOVoocfIqF9Rsy6MKjGA92kcJ0Dw=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:ifw3oUnoE4herhS8kALv1eKFRyZj74Yxyn/ldBagmBzgtR6Gnu12Ul/5ruI2W4Vd1ndzF9k0OJT3/GlnI6dBIXRVMO9ixmE7PRe0MpLdSjOtVJiirb5/OE09HaQj6zKVPDFvJC1Wi4UJ7fdIM5T+UeBNyV7wCvPOBBTBuZu4UXspcRFq5h0VrJQHGauN90NdNOcKvpaOkVGMxMHRn6cTefRwikh2NzytHXgUSVd6o4DzD5YEwOCAQf9Kxb+X4z0KoiCk/8Ymu3PBO7FfPqopZzgM/gkzdlALjUfG0jNvdOkW5+TVTLXu4UC9oAvtlb3S55MAtkT/5rYiy9YptEhIPehBpEvljxdyGHHvRf9RqC+zoVJxIa/VP7KO48/4c5sgFW9zuvDc+Mb4bGJ2KPqTkrTsxLTS0ipAndI2LYK1w7wv8L1ckA98ghiseTdvYpKtJ6QHD5ITw0+lX+aJZHoDxqUucae3y9nM7DNSmAckWNX8DC3V0GLCX6sax2xrOu2v;4:Q/FPNWwzXhHtRvtXSon3NeSg5wXfGXO3fonSvGsbtrF0w2IC5/Da1PI+5jN2hxqev9SMPDPZcLSSLLomDxAxGZ42Hya/dkaIcJUyaLOsHaCp9XhzXo8XEn6Lah1TnD41eMUJO1L9ahg4DIh8IMfKH4KkVPvq9iew6kewiVhz8CNwOgoJkTOyp+Y7MOGBzfW3FrPeXMdShZM1w9A33X+w6KtQgadM+wOFWfDeYiHep0PqVqla2eeVTC+H8YRMIGnLGnyZ9YBb1engldVMVreE/3ADi3eVzR0heLe1qYOa21/cQNx0SgJBTCxz7c91RbyF
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13310DA00BB706792FEA1D34CD7A0@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 06989017E3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(346002)(376002)(39850400004)(396003)(199004)(189003)(6486002)(3846002)(6666003)(6116002)(478600001)(8676002)(6916009)(230700001)(81156014)(81166006)(8936002)(53546011)(386003)(486006)(107886003)(476003)(446003)(2616005)(11346002)(26005)(59450400001)(77096007)(16526019)(305945005)(25786009)(2486003)(52146003)(23676004)(6246003)(52116002)(4326008)(39060400002)(956004)(76176011)(16576012)(53936002)(58126008)(7416002)(31686004)(36756003)(2906002)(86362001)(7736002)(31696002)(5660300001)(47776003)(64126003)(65826007)(66066001)(65956001)(65806001)(106356001)(105586002)(68736007)(50466002)(316002)(54906003)(97736004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6SEtsdGRwUFRUV3JibmtGTGJXMG1Ra0xG?=
 =?utf-8?B?WW8vaCt6RTRtV01BQVJiSG16dVJjSit5VjVRRWZkeHpWekdOU3VtUzdVSlpk?=
 =?utf-8?B?QWgyUzdUeSs2dWo4SVhvSW5PcHdjRXo0QXY0dDNLZTRKVUgwTE5RNThVYWdE?=
 =?utf-8?B?OHBLSGxMSFdnVnd6N1lDYThMck5PL1B2OFh1MHlyUTloUmVWN1VPV0VqYnhH?=
 =?utf-8?B?am00ZGIycEdFVFJpVTJBTkcrbFdhMmExZGJYb0xzTHU0TDZIOE9DOGZvUzcr?=
 =?utf-8?B?amNIY290KzNZNFpmZFJzOE1JTWRrSDB4QzJ0eW1zdWJvY1Y2VE9GazBQMzlQ?=
 =?utf-8?B?THZLSERtTHZ2UkJpVUo1T0dIVFVkVUpmMS9KVkJmMFpyc0hlS3FiM0hJTVIr?=
 =?utf-8?B?ZGs5b1lxYnNQdk5yTkxhcExZdENLOHAvSmRxQjRrMU03eEhVVE9CUmJkYm9T?=
 =?utf-8?B?Q3NDOVZHbmFpZ05BM25HRWhNQ3kzMHBhMFZDQitwRHduRlVoTGtpQjFuOVZ3?=
 =?utf-8?B?a1JPL3hHbVpqOWZFQnh4ekJnWDVDY0wvMmNxR0NxcTU1QjdZTEFUeGFtLzhV?=
 =?utf-8?B?Ym92Unl5TmNJMFpkUm1RUjF2M3RwZ0RBR3FISHdHRXRWY2Nxcjl4bnpOQVFS?=
 =?utf-8?B?QW9ZeUNTSmM4UE9JamxNUy9vYmw5TWllUVRidzFjWmtZVEJDWThyaDUrV0Ri?=
 =?utf-8?B?MFlTbWxkUGRnOFUyeWdwaU1kdndBeVRGR1hjd3R3USsrYS9pTU9aV3Q2MXls?=
 =?utf-8?B?dUtCSG5rTUFsc0JGVCt1dEc3M1M5T3pHb08rVlBFSHhyQlRmQTJ1Z1RmRVdW?=
 =?utf-8?B?Nmkwb2dXOE5YNkN5NVZCQS9GS3Vwa0dVdjhkZ3gzNkd4RkxMTE94WTdNa0U1?=
 =?utf-8?B?YjEwTkYxNytFa2IvZjlZaEJNbHExbjNZRW5HZDdYWjFkaTdFMjhnZ1dSTnd1?=
 =?utf-8?B?QmpUWVBwNGJuT0pKbnBYNmd6Vm1xZUw3bWhFYjF4MlVhZXhmaE1xRjlTQ0Fp?=
 =?utf-8?B?ZXFIblJUTml3N01yMlpOUzM3QkI5ZDlqVzdQMWtIbGFtaU9yK09ORFduLzIy?=
 =?utf-8?B?ZnRpY2NWUERWeS9xQjV5UUhlMG5mK0QvS0tkbWovRGFydjJkbzlnRDFxNHAz?=
 =?utf-8?B?WWU0NEpUWldhM3JOOHF1TDcxYkNmM0srcVZFNEg3RnhIME9aUm84c0tPTEwy?=
 =?utf-8?B?Zld6RDNmaFRPSDUzVkRHbmpwMWpPT1ovNVgyWnhpMWNST0VsK2NONG5hQks2?=
 =?utf-8?B?YytKT3dnT0h0ZEZheEFuOHd0N1gzRUxhUjIxdkdKYi80KysrVGl3ck16dnBp?=
 =?utf-8?B?K012VFFwNHFMd0xORnR2Zld5UlFTaC9kTStPRk5TU3NFclNCQXdXNUxkcDlJ?=
 =?utf-8?B?cy92L1N3c0VTNUFQUUVOdkd4RmIvajFjd1loQ3d4RjFKQVJhRmh1NDlkcGFN?=
 =?utf-8?B?c01BbmgzbHlyWnRQVzRQTERBbDdRczU3SUY0WjJQV1UwS3VaWENHUGpDYmEr?=
 =?utf-8?B?QnQwdHV6S1BSWURtS0F3bTg4ZFQySVZLZThOaDQydWd4M3ZxVlUyemJNUXlr?=
 =?utf-8?B?bVJlRmpFNURRa3hWaWxYQWpUNEk3TGFDLzViUXU2QW45ZG1yUnNwdksxcXlV?=
 =?utf-8?B?ZkxXck91aCsrdFQyMmpSUG4yakZVQjlidUpBMWtEaE5ETnYzZVJGRW5LQTFl?=
 =?utf-8?B?Q3VQYUNFVmtVZmlTOTZUdXIwaHV2bWM5NnVEaHdESk5DOCtPVHRWcTIvOEUy?=
 =?utf-8?B?QmpGcWpzTEtLVGNHUlRwR3I5YXFYVUIrSm5iVFdqMGtBQWNjbERtTjF5bU5T?=
 =?utf-8?B?ZE5UNVVNMk1uVTFYaS9XN1hVZU1SZHplR1Y2ajdJNkZveTRyMVhHM21RdWpr?=
 =?utf-8?B?VUlTNVdkOHc2WExVS2ZNZXMwdm1ZWG1iQWd6YVljRzZ3MEk1c3hYQTJVNDdQ?=
 =?utf-8?B?Uk9NWWFmaVRjNGRZS3JBc0NxTHNKR2NLMDRwUzV0RlJadk5aM1pUWXY0VE5h?=
 =?utf-8?B?NjhjTmpkdjJ5NDNJS3hXS2kyWlNOVTFnUk9YclRNNHZVWEtnbHZMU0pjWndS?=
 =?utf-8?Q?SXikqY=3D?=
X-Microsoft-Antispam-Message-Info: pPZGOlwPwsIwiKJMU8Z11xUV+It56J04qEyiKcNM36cRki8oPH4QFLUaGFFcdQml5p/bkXe1oPFU79adJmz2zliPD8kPfMLrKzlGFwIroJt9720qXcIfZmVRoP51ZBeVHkr8gyS5tf1WyLcaiP1VNXFh1KvRzkhG1zLEZAHjzurkmy3CaDarj1T0the5ZH8a
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:YDy1K9nP0eEtJbzbQpLAHWPMUEKoO6n4rslOyiZrHlvVJZZ8+jy1ndd210fN2mIXoR03g4g+osvQYVg2CZWVAUyhM2DAiQIv/NSi96LP+mvcRrn8SX8Mn6g2HYs9aNF0zukOQlBo09CuMT73/S79JXo7Ui/JbwU3bpvva1xRgWsVndRloXjvS1C+51OMO8BzjfaLNQ12gdd/LlCq7aYwiDWr0tSt2abtD+AolZDtRBj4RiolkTZxJJLFPZYUc8X2ZZwcQwW59wjW3HDLWyQU7+9gtnVPzFrf+O0MZy9vsfUYFpuhHLnq8PtVnj3GXk2DFicUyLLBxmUF4070rviSeME/2+bhxmpIKZewlSxdrFFs3iNkdfotMk/k35taPjPA0XIlvLkj6ZF7SbdCn/DMqaKrc773Q6irnhfWRE0IJXB2Z6vVwcdjukuWkyqLiNGj1xa5zuyyYnUBOYjufprMpQ==;5:Mk/AEPr7i/o/55KjhdR7wPje4hWY/g+aCJisEVdSgvkYbXK+7+DdGx7aGB+vBdG1Wk5X+hFiGbgCELbMmm3uRIiXyyRUpdI66jazy0OBqBiezYjJinlcpSHsqt7gG+AGAB1zMWJsdN0ghh0kx6wM2Pjn9hhOb/4B9rErC7qnPW8=;24:vZcl78hxfB8t8lQJwuqa71inTEWJ8am4T/vlr1+WOKHTIrMfbRXDxVen7iRFOvDcNXwOzYZcbL1Mp4ZffVLszOH0OWLtQss/hZOM79zLRms=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:2n7xHxNZD2PeJT48McyfKmNReHA+6Hr+ROhvgtMwSby1RIN5689NHkUMyKKomp3yOnsasdM5fnHHKvBNpg9UTkZtCHAJJ43qvXIdg8zEfLTHZE19Gg87cxpN5v4CQPuSrmIJBdqf//ISwUWMAw/J0oIbsULgGkAW6E9IlI9Lj6jOYVUYhpoorZtssKurasHmaEJvrUe9bHHkfv8pwewiYNsWy2iCunDvx3CTTtPHqgNpH2PAXquzuJYL87n3umEz;20:P06xzJRmEbBJHHun6xMYK+D/5OzFqNeWoKMhpK+Ozr9myMndkQrbRJCFBkjLUasDNQ2NBArk4QGiUYBIvtp68GS3kaQ6zyKGkKdaL3a8vFa7jichD0y/DqZEmWXlFmz+x8DnVGiI2d7xijHg7p8adF4zEkuNKBD9VguulU9ih8Q=
X-MS-Office365-Filtering-Correlation-Id: 6af3b8a1-50cf-467a-967c-08d5cde58f88
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2018 08:46:56.4817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af3b8a1-50cf-467a-967c-08d5cde58f88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shakeel.

On 08.06.2018 22:21, Shakeel Butt wrote:
> On Tue, May 22, 2018 at 3:09 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> From: Vladimir Davydov <vdavydov.dev@gmail.com>
>>
>> The patch makes shrink_slab() be called for root_mem_cgroup
>> in the same way as it's called for the rest of cgroups.
>> This simplifies the logic and improves the readability.
>>
>> Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>> ktkhai: Description written.
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  mm/vmscan.c |   21 ++++++---------------
>>  1 file changed, 6 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index f26ca1e00efb..6dbc659db120 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -628,10 +628,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>   * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
>>   * unaware shrinkers will receive a node id of 0 instead.
>>   *
>> - * @memcg specifies the memory cgroup to target. If it is not NULL,
>> - * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
>> - * objects from the memory cgroup specified. Otherwise, only unaware
>> - * shrinkers are called.
>> + * @memcg specifies the memory cgroup to target. Unaware shrinkers
>> + * are called only if it is the root cgroup.
>>   *
>>   * @priority is sc->priority, we take the number of objects and >> by priority
>>   * in order to get the scan target.
>> @@ -645,7 +643,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>         struct shrinker *shrinker;
>>         unsigned long freed = 0;
>>
> 
> Shouldn't there be a VM_BUG_ON(!memcg) here?

memcg can be NULL here in case of memory controller is disabled at boot parameters
and in case of it's a global reclaim. So, such the check we can't add here.

Thanks,
Kirill
