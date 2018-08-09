Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E1C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D407521A5E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bG0RAYiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D407521A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeHILqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:46:12 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com ([40.107.7.127]:28416
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbeHILqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSzvySRpLU0Nyp3YRv+jSAaIAgnuIAh1mMVNyVj5vag=;
 b=bG0RAYiPWF6o+lhBECdgMR5tfHOZf7RM+1wz8Ew/6P0aWuZQaXhHY4rceGg6kqCdTr7ABt499wi0lwzCB6qOhr5kuUoCrfsziZuBi9s7BoBmS133AWG8SZ8+P8SGVseIdamc/4/SHQ3TAOpe40/b2ViUc0Noh6AuM5Q8Si3Bim0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2021.eurprd08.prod.outlook.com (2603:10a6:4:76::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 09:22:02 +0000
Subject: Re: [PATCH RFC v2 02/10] mm: Make shrink_slab() lockless
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
 <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
 <4ceb948c-7ce7-0db3-17d8-82ef1e6e47cc@virtuozzo.com>
 <20180809071418.GA24884@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <cf7ba095-8be9-ead8-5422-59fa1f3bb07d@virtuozzo.com>
Date:   Thu, 9 Aug 2018 12:21:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809071418.GA24884@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To DB6PR0801MB2021.eurprd08.prod.outlook.com
 (2603:10a6:4:76::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baefd80d-9928-46bf-5cb6-08d5fdd992b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2021;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;3:xGb2P91jnCywa9rPJf2v5eeNwx/3wrXQGS9UAHulbgR0PZXjPi2VdzV3/EfrHxx8b8wQo/d9lmYYpQf8YbEz9Od4XJvj20iSjdGIPqREo3KspB9wCNPV+xdv7OD3uUhdokZNk+437p+/bV1dKpBYLXN1tyUSif6+j2vYmcNTHxlzQRG0GC4UXM2yfNmrgSs86kgiZQhLkyP2VLQa0aovQvqo4ob1JEX1LyIidvKHOOwQBqfu+Kd6Y0dD5v0CJ67c;25:NmFyueSl8fjclux1KLknlA7WqxuvPE9DVyxL+RZksq2buYqA4DQGy/OjxMttGW+CNHssJETyK3JXiw/rcM3sMcezik8DGfjR1xZJqpCn5b8tvvLOmxQx3jgs5RXDfl0K/qMchyJrQ+fs0zPlQCZPlVHDEX7SYIoVafrj49NaXRe2DBJQGoSNC1NXEg8zX0kbaDHHfwhmFZzNfLLSstkbdGg3xaoYixoaFDTQvqYZ9Vue7xjkOoW+g4MQ1xovdfmVfk3V0+EikKsa6Nsz4b1zWYVKUvcECkUj3xY4NYFNooRQVThL/caLeWZVwiWJMOU12OImvn6k08jMJbFdACIe1w==;31:VaVJMGTeXfTKYgoIU7O3al5L7WN9lo20R8ehjxKQmiT0AzZ3H5Calcm4vK9ZSh/ifs5ebiYYCAeZDVcbXwJVdokHTqxMmBsHYlrOM89EivIo7+qDfG5ScpgDvybhQPzg4Dbp8dDJTA6oYfFPzMsDxPXPhcZIwO6qACPBeSSVT67og1Czpw+xUirRb7A6V7leStUur9cZmAmihymPkoiXmGXF4pfJla4cpvLTLj53ONc=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2021:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:Tpt6sggr1Is1gxhCtl3iZLqIZQfLB09uRnzqzI3k2qtP9qON+9sIbtcJSXgPh0Z5/MlB9379OZa9k1Fo58L1n58Lr7FvVfoXCOLvZamAuxaGOvBr6GlzFMgq2TKR8c5osAlMNsOb2ik01c7w0+HInVBp+uYZ1KSodBNbAbtc0vBC6NyFFapj+wJhyQfiZhVM3NErFymd5v8uLO93InQvrfC2NdEYR1D0bfL59FrWTY4i9lNfiA/ZRhq9oOUfx+QEQK6xvUvjGNs1BLO/PkhSw/Cek6E2+tCcQg/qTuJz2MtlDREDoBPH7dgRPLIuup0ARSAuTlNYgk29dyPE+vcUJ7Fq2ARj6FGSw2mq5JyKp+hjyspYIvGdasiOt9aKujK1223kT+GIGdb/UmY5J5lHxovACS4x29oA8ZHHHB+Y4phlPfYZugDqYwbhUZK2DprwJr3i9xuY8wnaGUJ66wDoTlhd0JIhcAOYPbC3C3N1BTj5IFRmLcWxDTScJonIyh8Q;4:JXbAEPpyFMRfsQY/TO6U8vp/K36hdZ+w4d46yruUBrubxc51hHokX6EVX/o/MSS0CW0NfSf+tElsUYaE64kQU5is6ovJdB1hd1pk8cX4Q+SXKwrmeqf/EitHWWw0ZfDp7OYLo5mGDb7V2TuBbmRTKc2FUnSFQ5FTHSrYE30Gx8UWxdMx8gko1U4dnXPfaBi7Yxwiq1UxdngIN6i0mGlUMxDwHc0qu2Ztbo51eJqSSdyscviyAAknAWrdTGA37up2UFuep/0w7HSkYWsxNi1g8w==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2021EEAC0BA2B3422308A929CD250@DB6PR0801MB2021.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2021;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2021;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(31686004)(956004)(7736002)(305945005)(7416002)(230700001)(7406005)(65826007)(106356001)(105586002)(6116002)(5660300001)(3846002)(93886005)(25786009)(50466002)(2486003)(23676004)(52146003)(81156014)(8676002)(53546011)(2906002)(53936002)(68736007)(229853002)(76176011)(476003)(2616005)(81166006)(446003)(36756003)(11346002)(386003)(486006)(6666003)(52116002)(6916009)(47776003)(186003)(16526019)(478600001)(97736004)(4326008)(26005)(39060400002)(217873002)(86362001)(31696002)(77096007)(6246003)(65956001)(66066001)(316002)(65806001)(8936002)(58126008)(16576012)(14444005)(6486002)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2021;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjE7MjM6a0daNnRBQU85UHNTRU9ZejVDdGRUM2gx?=
 =?utf-8?B?MW5FSk92cEtwT3Q2d0d1UTRJK0dYR0drMWdOL2N2cG9GZGF3UjcvQndKQmJ6?=
 =?utf-8?B?Tkwybmszc1YweWw2c0JLZnpJTnY3dlJ0R0dNNjlMQXdzWGxtLzBnMm9NbFNh?=
 =?utf-8?B?dnFlZXlPV2s3RWRMVERrTmdNL0tZa1Y2eW5kVGYzRmNqRXdETHh2ZW4xNXBG?=
 =?utf-8?B?NXFTaU9WVFNtNjZqS0RWOGdWeUVHdWVuQ0dubEp0TjRIY2I3TktsNTlvUytE?=
 =?utf-8?B?bWx3b3ZDVlkzcGp5bVlQZkROZXpMQm4xdnVCbTNUSktZblZOTEkvWGZ5KzY3?=
 =?utf-8?B?RlVnSzZ6SWhXMGZQaDE2MTd5WUdaOFF0YlUvMDREZDgybWE3RDdtRW1mQmU5?=
 =?utf-8?B?cjBIa0d1aFhNRjF4UXhyN0RpL2FYWHlrU3psWU1Gb25xS2taN1VYQU15U3hM?=
 =?utf-8?B?cFFPTUFPT29tNUFUQzExMyt6aE1NckpPKzVwNFpsUVdxVnArNVRRci95Rm1K?=
 =?utf-8?B?bXhUbklyMEVCYjNzY3JNb1FmczFpeU1oWnBjNGJVaFVsWjh3M0oxakNJVTdR?=
 =?utf-8?B?MzhlQUZHSWlPZGNnR0JpNGRJT0pibU1iTGlCOFFRYjE2eVRDc2xJL2ROS1pa?=
 =?utf-8?B?WkF1M0RoYktuSEwvalgvMGl5b09HMVdPZzV5Y1NCSmd3SnRzQ01EQTBqSVJ5?=
 =?utf-8?B?Y0RHNjdZZkYxdW9KeHFuR1JycllpdGE0NDdpVWtaSU1zdWNyZUtqekJyZ2lh?=
 =?utf-8?B?Z01zcFJHcDdUUW5xU2FTVmVTWWxjMFdtNzI0azFjU1duTGN1WFkzdlVtYkIr?=
 =?utf-8?B?UVBzd25zblgvV2h4bXltVWNubWhGQ2c4MEZqVGY1WURNN1JNL0N1UTIzZGtQ?=
 =?utf-8?B?ZjNxdTFwVWFiaU5mb3p6aGJsbHhtTHFKTW9lTUhxUUd2N3c5SVZyeEg4TU9x?=
 =?utf-8?B?T2I3TGpBNnUzNzNiWFhTVmlPZ0xFMU9JZ3JTQUVDbWV6WFpMbEtPakJhRFNi?=
 =?utf-8?B?bGJ1eGNMblBoMi9yTkNpQXU1V0JtMEJoRWNqaUFWbDhwZU8zM29MeHlpVlk1?=
 =?utf-8?B?cE00eSsyalFDTVlrMWp5MVUwRlhXVUhUeG5tY1phQThPT25HZy9lN1hBMFk2?=
 =?utf-8?B?VVVULzBSZmNHZFpkanpCUXFMUlNhZUpXY1JkZFhwaGlMbGVIQjlIUU9ta0Np?=
 =?utf-8?B?KzYybUpQMjlLaDBaMFhaWWllVnZSUFhBN2JZeTBNWHpydFY2U01sRUlkaUlW?=
 =?utf-8?B?SFJKUUZmVlRXbmpPNkNwVFhzM0VMNnNCdmtVVDJjanFYTURRZFZ5Vy9mci9Q?=
 =?utf-8?B?UXpCVW5lTWJ4bWZWZk9jUmh5MlVrUTlKQnpGaTdnWUM5cjZwMVVUbzFhTFBC?=
 =?utf-8?B?dk5WVFFDWTExekkvWGpGL05VT0FKcHgxR09Hb2svTmNubVRYbDB6cVQyZHEr?=
 =?utf-8?B?TGlzYXBXTVl3RUw2MUxPSGhyU0NUR0ZzbEF3cFE4WEVHUGNvUmk3RG1hNXRa?=
 =?utf-8?B?Rm5sY1VNTmRRT1p4bHg2eWt5WFIraWZQc1VpdnFPOEYwSS9SQlBpN1d1UHlv?=
 =?utf-8?B?V0luUUh0Q1VGRXJRcmIyN2FNRExkZE92a0lOL085SHJUL0gvQm0zSEFXKyth?=
 =?utf-8?B?MXZJaDdhY3h1S1c0MWJ0Wk41UWZwemVSTGJ2Umg0TTFiYkg2V3ZsOVNnRy9z?=
 =?utf-8?B?alRabXpVcmJMVUhVRUNNWFRnVXorVHpEVlNwT2QzSk9JTTNhd3B2MVNYQURi?=
 =?utf-8?B?N0EvY2ExWTdpOXZOdlJ3YTN2cEtnTnl1elo0eEl5MGk1bU5sU0djRVFYSzRS?=
 =?utf-8?B?UXVwTEl3MC9Hb0VLRy84UXI4bHNmdkoxRS9pY1d5dVVlNkFrak9QOWRabURl?=
 =?utf-8?B?U0dSSW5PQjlPMlI5TitLRnBocC9UUnFPeWJPZTFtd1p3d3R0OTZpOU5oRWMr?=
 =?utf-8?B?YUt2b3kyZ3FoQWpSWHZYdjArR0xCTlNhUCs1emY5YTlSNVRYM1BtMHozc1dQ?=
 =?utf-8?B?NExOMDA3cWVPMTZxVWV6QU9OM3h5czdQVkFlZEptbkxMdUZMTXdaUGg1Zm1E?=
 =?utf-8?Q?czeFi8x9WAdm4Iu7PLjOw2WxoIH?=
X-Microsoft-Antispam-Message-Info: OnCLOBDkJ+HnvwoHDIx+1ISLRfRaujv4t/AN1Umk7Fk6OTwNc3BFrYZPDGtLE3GBXdwsz1ZZeM0RnOjAB9TzOINt+FVt1k2BN6LF6lLTId1RGNr4bCpVvibXWei5WYGHSfNJoCUiVW8B4j7jiVNjIMwtvuXKBLl2hUPqmTk6bYzoBe18bjTDpal8vyc+YNOXXX2l7Oz6E/7gl4lJyhm3BdL0uZRIGu6nZERQniCkSQia3AP5+s0r3G8IBWTiQo2GSPS/jtC4AshjfsGORd4Fw8jSqABpPEXne4UXfpok0/k0TMNXNWKqA8qCUmKdlCG6/67T9Jf+apYQFP5C1HwWgE8bqtWqYtMY4/CyX85PWms=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;6:6U3j925EmK/NbnO89HfMGDo4F0onD2mLnMI1e7glrBQX7Koz67SOyFwx4e0AEyjnalSt0Aqh4Wc/kT9HGg3hyYG6HfMqHP6Nzm7H8EGlF0pIJgXAE2rSGGJTHmBsfVwt8lTussE/Fr3Ef6ZjJxbViAzsjljwm6gyTW/MrOwYeey0Y/6HEfKcMNX+XF96eREpM/qt8Jv/2kDHWWBBMEBMN5IwVaGdddLnUX+qq0eANEI5Jfqs4WS8FJhxS6fAQCVetXvPA+rg5F1o8Larf9Jq7u8HOF9wsrYTiZrOrhYyL81tWmkmgWSsOwEZYdQ/HqNcf3Cd0whNjMQi84UOkGhh/OjTA9Limvjixcsxrdbtv6z2WwJ1ebXXdsuPqPMDjba5AgsfMvlEGAB+bIagVl5+VbvEFeciSGwuk9zi2LiNj1Q9NL6Dqk21B3ldvxY8YIMsrJXTQ8k7etvrVtX6iAS4sA==;5:7Nom+6VsB1nXV6dmBzUHEJqbiZ8X+DhLJDR0eHoKHDLRZCQHjOi/TmyGuZOK2jWr1FNNoABfsrQVb8A9aXOxbQxQeJjuL7x1EabqW52O6zKGd/0geRITi85Au0LQ1ul9obE3YU0dUyJGlqAV6ZF2u+RE9jgLbXvg+masdhsL2kg=;7:2ETPLgoJq7TsXsHTSZrhoCaAdia+DyQn9apBn7O+IN3c8ND5LSx/IuiSlL4hxscx+jn7unZQtvIzR+pMbDUqSRwUL96wTqXAxilHNlpVSPzCAhR1abx7Qyb6qNJgDiPNezdzfDk15nJRjatu5aD6PfQpGxdVGNFAHNf3aIoUfC1JyX11Nbi8Jp8fW6XEP0wnjtNTnr8oFQVX7CyCi0QImwE+Rvj7RNybfgvC5U+ar6rbkSuH3OSmmCoJh2jus4Az
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:+6g5fYAtg8acXngz+rgxGFO3EzdkI2NVrgX9+v7o9taHTOGWWc7AxmuVR2WNMANNUyK9o7rPg3z1YoeFhRTPAL8y9nioySSMq7pZMnF46DUkFRcLxbjSJVTMBQDKzkdRJFyAhnytF0uQWSJZKPzQUNLkaS69jH9qTV2u1/+03gM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 09:22:02.0667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baefd80d-9928-46bf-5cb6-08d5fdd992b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2018 10:14, Michal Hocko wrote:
> On Wed 08-08-18 16:20:54, Kirill Tkhai wrote:
>> [Added two more places needed srcu_dereference(). All ->shrinker_map
>>  dereferences must be under SRCU, and this v2 adds missed in previous]
>>
>> The patch makes shrinker list and shrinker_idr SRCU-safe
>> for readers. This requires synchronize_srcu() on finalize
>> stage unregistering stage, which waits till all parallel
>> shrink_slab() are finished
>>
>> Note, that patch removes rwsem_is_contended() checks from
>> the code, and this does not result in delays during
>> registration, since there is no waiting at all. Unregistration
>> case may be optimized by splitting unregister_shrinker()
>> in tho stages, and this is made in next patches.
>>     
>> Also, keep in mind, that in case of SRCU is not allowed
>> to make unconditional (which is done in previous patch),
>> it is possible to use percpu_rw_semaphore instead of it.
>> percpu_down_read() will be used in shrink_slab_memcg()
>> and in shrink_slab(), and consecutive calls
>>
>>         percpu_down_write(percpu_rwsem);
>>         percpu_up_write(percpu_rwsem);
>>
>> will be used instead of synchronize_srcu().
> 
> An obvious question. Why didn't you go that way? What are pros/cons of
> both approaches?

1)After percpu_rw_semaphore is introduced, shrink_slab() will be not able
  to do successful percpu_down_read_trylock() for longer time in comparison
  to current behavior:

  [cpu0]                                                               [cpu1]
  {un,}register_shrinker();                                            shrink_slab()
    percpu_down_write();                                                 percpu_down_read_trylock() -> fail
      synchronize_rcu(); -> in some periods very slow on big SMP       ...
                                                                       shrink_slab()
                                                                         percpu_down_read_trylock() -> fail

  Also, register_shrinker() and unregister_shrinker() will become slower for the same reason.
  Unlike unregister_shrinker(); register_shrinker() can't be made asynchronous/delayed, so 
  simple mount() performance will be worse.

  It's possible, these both can be solved by using both percpu_rw_semaphore and rw_semaphore.
  shrink_slab() may fall back to rw_semaphore in case of percpu_rw_semaphore can't be blocked:

  shrink_slab()
  {
        bool percpu = true;

        if (!percpu_down_read_try_lock()) {
               if(!down_read_trylock())
                    return 0;
               percpu = false;
  	}

        shrinker = idr_find();
        ...

        if (percpu)
             percpu_up_read();
        else
             up_read();
   }

   register_shrinker()
   {
         down_write();
         idr_alloc();
         up_write();
   }

   unregister_shrinker()
   {
         percpu_down_write();
         down_write();
         idr_remove();
         up_write();
         percpu_up_write();
   }

   But a)On big machine this may turn in always down_read_trylock() like we have now;
       b)I'm not sure, unlocked idr_find() is safe in parallel with idr_alloc(), maybe,
         there is needed something else around it (I just haven't investigated this).

   All the above are cons. Pros are not enabling SRCU.

2)SRCU. Pros are there are no the above problems; we will have completely unlocked and
  scalable shrink_slab(). We will also have a possibility to avoid unregistering delays,
  like I did for superblock shrinker. There will be full scalability.
  Cons is enabling SRCU.

Kirill
