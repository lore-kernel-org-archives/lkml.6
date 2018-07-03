Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C462147E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KGTV7Nz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C462147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933661AbeGCQR2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:17:28 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com ([40.107.2.126]:16448
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932541AbeGCQR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+jc6afPIEt+Is1AyOvOr56rWn2CKIFrP63Y5YNXvME=;
 b=KGTV7Nz+HMp+wuuKHJNtbJP8QmQn2yt+z7OaNYjNM6w1KNvLjEFOiQ7wC7Kb3XuTekF8Ihe/xuzdKMRUZss3z8es8fW/Y9ZeFMQGPEKfSaTcSgOoLcDdBdl680gdIpM0v0okKfdG+yFXS7kmL0dp9j/1/klSc7LkG+zY8EFphjY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 16:17:18 +0000
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
To:     Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
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
        Linux MM <linux-mm@kvack.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a9fe3e9e-a1b7-ee19-35e6-af32b5f25a37@virtuozzo.com>
Date:   Tue, 3 Jul 2018 19:17:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84fd4934-4e0f-48cb-90ca-08d5e10073fb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:b7CEQWA531dbLixql18jy7kyacU2QuNWg71DGelC1IfWpH8U9ZnisA7MwHwXSyWq4eficlFnxmdoQl8pw4XPl1j5mSLPpaum6hthpjV89iloJl8ZjDYQ8VzH4ZAQyscnLrHPVb0MP3RfVhZJKuq+ixHbaLpbWzBvVN+2hTt7CwR4ELPZVi/QVqp2KSJWmI7QfWWne3varWCwktuIfGh9foCDikwxYJTurtcZ/2OvIrdpvQKZQ+Gief+4h3vJzvlN;25:86FpcTeF9XbX5NWe0tY+1W0VEMNbQIqu2kXF1ZExW4j80aO2kTEi4NLDwWsGuJKFj5uvoiTjaMEo/cAWzeitZjj7H35NDOU/k/rhGNPeYE3mygcDxr/e+OuMsmXSR+C7J0rnk+HFapMC3gQvJT9ytZp8RC7lQ5vLU9JF8EqI85xryufz2ID7iGeV0y9j5hIhKBPMC2t9yvgRSYzGTvQoLHbqAlU9x8LkdefwjP8LETznwwHdJVJTke0EQDBI93SajMgF0NP9MSWyhkVmi2htbAYor3T8qy1YJOxJkkzdOd/4P74Kw/xCq7C9OXpn9m3pivJ4VkvuVKQnvQhlOzA20A==;31:IH8fA4Mxlc2gCZFYY1X998F7Pbm3knkuAwATSDuqUJljjz8EeTnGKtCde5l8wGs5R5ah95XL4AeY5stlDEwKljpLdgtnePwwHejjuMQPkDNUbp8ZEf4DxcwwwknTXjSStj8EZYT1uTE1eR7s0Udegq9nJc8vJgvsx29dTpd3GxnCWjQQKRWy3t/tnkS11x3K7UwPWz149K9hLdbARKa6JLSQjj2Owmtgn2dnnYI/RKM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:dcshL7Ik910cQycULqPuGAwUbzcxhptXL3f8ej6HNaOoqpFEf5xRhMWtQEBr6PiYTj3QTVpAV+wofizOAVQseg5lxCM8ymsHSFMjnntdaBgU8T67x8fFBLCwqKMNbmYzD9nkjI8YgeKv2w06xzSGBhvSIuIGkt2DTyLqj10oXYMirOnjkwKMIEyjbOtno7C6gSABzeV7P5tqUQAe8kY61nbTq6RQjf1jH12eIGwjQRJcgYfOiE/CgZwj7EsYjXm/0g+DlXbT2NaAyiqBPcGtiq3rZnvAmCLcUrtZbeN1x+H3rfbkt6CCp/QwEN8GrUnLwKGwHCTI2Dig6MQB+myaAqO8MhMIQ901jsmqoRkBDJd7dCd34kAkQ1Rl6xDOOXSAe/889voV9tfDNj1NMZ++4vSSvNcAz4qDvH9e7SHVqBFrAocrzZU+25UTk+LJBko/V+69u+El7DXaRFm9q0C55huTDGH4bHMB7HiLiTeNGApZbZEtcLUvuB+mnSg/ctv/;4:6TgX18KWjlDQF+opqj3AZFRecX/Fr7qvR6IOdvRWOyylx12IU8dkXl6pmNDSqDNCu+bqkHIJh31dQ44MI84BySis4fqBCnXITASj7bwxg/lm3VUWB7RCZRWr4ayD20iBVrGtROh01oPGIGtiE/PecweLwhsIho2GE3e4kDSNglZvXPmamRYNYRdFnpNtUiREy2It8+rPU57rElUYyL8ijr9cUJRAWgoLvKVtnwpq25hQo/ijaf6bvZyUBCJ8Z8ia1Hc2JDFHX9jrxgC0o9HvnnJOLMsZkOnUmXxmHgzs7LsTRDcOtTQuDlFZLDKrrvCc
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13386E2372EBA48EED3817A6CD420@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(7416002)(93886005)(53936002)(2486003)(23676004)(52146003)(52116002)(478600001)(76176011)(77096007)(186003)(25786009)(26005)(2616005)(36756003)(86362001)(446003)(64126003)(11346002)(6246003)(110136005)(58126008)(54906003)(956004)(31696002)(476003)(316002)(486006)(66066001)(16526019)(3846002)(6116002)(47776003)(16576012)(2906002)(68736007)(65806001)(97736004)(65956001)(4326008)(39060400002)(8676002)(106356001)(386003)(53546011)(230700001)(81166006)(81156014)(8936002)(6486002)(6666003)(305945005)(7736002)(65826007)(105586002)(229853002)(50466002)(5660300001)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6bnJ6YnUvcU9KR3kxVVFOL0VEc0ZVVWtU?=
 =?utf-8?B?ZG5WczcyejRSaVNRVmtaMU56QjJJYUtSdEkvUzVybnIxelVDOW1STFk2ek1j?=
 =?utf-8?B?Zi9vaDJUL0JmT05NYU81KzBzUVB3T3I0WGlsR3lKTjhnR2RKclpoaHlSYmdr?=
 =?utf-8?B?b3E1L0pSL1FJQWpKYnVTTmRsZDNwY0o3VEVtSGRjZkM3c3kxWFNTU2F6Z091?=
 =?utf-8?B?ejRzaGZHYm1ZNFVDa29KWkh2WUt3VFIwS0pNMFU2TFV6VnNxS1FCdmdLWFVS?=
 =?utf-8?B?RkRudC9Zdmt1UW5jKzNkWmpLSWl3TVp1ZlFjVzJTRGtNakZGd0tnbHNJUW0z?=
 =?utf-8?B?a1BDa2JtZ0FhcWw5RFFVZVZKMHVzMFV3NEh1TnFSM0E4cFVxWlZpdGkyekpT?=
 =?utf-8?B?OWVEK0d5NlFWRDBSbWduR2VXYll3T2lXZGx6VUJXWURrRExEVjNWZDlFdzd1?=
 =?utf-8?B?aUN3TWxpTldNV3F6UFNKVGpvM05SYzQzemNSOXRoLzA4R3o0K0ZBUjhtN2dE?=
 =?utf-8?B?NmpmazdwUjFYZ0tOdTg2ekpubzFmR0x0eEhCeU0ybkdncWo3K2lLQWptbGMx?=
 =?utf-8?B?d0poRDBJYVVSSDdUM3BSSG9oMjdxTktRYzd1N3drV09JdGZRRmQxOFh2U09W?=
 =?utf-8?B?SE5qV0ZhYjg1a1pLYVRYdzRWcjlKbWVHNXp2dU81eUJEK0YveTJkMjJaQ2ha?=
 =?utf-8?B?VFd2S3hacHVqRFh4Mk5qMmt6Q2JHME5EVHR1aktLZnlKaHV6VUhaSmtZOWFZ?=
 =?utf-8?B?ZE84Z3EvWW1nSThCQVJTNWhsc0tJZW5nNzJKdlFxS0FLTFZzeUI5OXVleEdL?=
 =?utf-8?B?QUZNbTh2bC9EbHhyZjJNSUU2RUk3K2xKUU1nTVZDSlVQSk1TY0dQaVhSeHBZ?=
 =?utf-8?B?Z2ZjTUl4OUw0UWY0ZzRwSm9LamRGaHhsK3JlODhwZ0JqY3pXUTlTcmpLQkEr?=
 =?utf-8?B?TWFuUXJrcE92Q3FBUVQ1UVY4S2Z6a3ZST2ZOSSsyczY2N1ArZWNiQVpCZWhC?=
 =?utf-8?B?V1I1TWE5YVl0bThxcEo5akl2MXRJM2JNNExOMGxCZUNqN3RPdW5tRXhxRUta?=
 =?utf-8?B?UlRqSDRxcmVrMEJzL09yMkFqdXpZS1pUU1BqZU9Ba3JLeEx5RnJQWk81Z0Vh?=
 =?utf-8?B?ZzlpM0tSdTc3OUhnc0FkMkd2a0Q5Rk9tY2NlU1RVZDVwV1VzUDFzM29xNHlJ?=
 =?utf-8?B?bjlUNHhaUm1hY2dCalBlSm42OTNtMDk0Q0FOQklZcEZuT2QydXJ1emhUUEEr?=
 =?utf-8?B?UjBPWkhEQVQ3T0s1NXZFMElhVnRwVjlSUWRpeGNFUHQzUE0xZElRYlF3R3g1?=
 =?utf-8?B?NkpTZkZ0ZDdmVWFBQSt1Q2lpTFhHaGRycmJEZUZFeEhRVUx0QytwNGFJUXFV?=
 =?utf-8?B?L1Ftc1NMN2FyZ2JBMFR4dmhsbE9NcHo4Y3A4WWJGRWovcXZ5cUp4QmQwMGdx?=
 =?utf-8?B?OUZ1em9JcWZETXNRWGxRUWNxTGtWNnovVERXYU5tdkdySDdZZmQzUlV5MWt1?=
 =?utf-8?B?WWMrRTF0N0lxWGx6WmJJdW1GY0lQTFBMRXZxSUk2aTBpYlBCOFRQYzJPeXdu?=
 =?utf-8?B?MFJ5TE9LREpGQ3IrOXQ2RUgrRzQvcmxnTzc5dHpuKzk2TUlmV3lxVEZyc09k?=
 =?utf-8?B?NDFyaHROb25GMitoc0F2SW5JcEQwcnZCZXllMjllR0p1VGlPdklhVmNQNkgy?=
 =?utf-8?B?N003QUZZdTdKQTdXMUVuU1kwcmtWMENLVnpaTng3bEVjalp6bUU5NVQvNFFk?=
 =?utf-8?B?YVhhVXVXR2V5OWVUU2lwdkMweW1QUkVKTk1MM0p6OFNBWnZHM3MvQkFJQ21r?=
 =?utf-8?B?T3AvSXFIMm5qZjl4RVl1Qk9nYjVLWjlnZVBqK2FyTllNY01Pa2REY1JpWUNB?=
 =?utf-8?B?NThCdVR5SXNnMTFnQ05BcXp4dkduL0RyMVFOcldzWDYrQU44eXZrcWFyVUlk?=
 =?utf-8?B?UENPazRUemRqcHhNRWR5a2tSUUNQbXhuVUUzUG5RTFhTdFVYMjMvak5Cb2ky?=
 =?utf-8?B?RVdsbzhWYmJKSU9HTFFBUGZDSXVvNzJWSFJTTXNBPT0=?=
X-Microsoft-Antispam-Message-Info: 0eZ8OKsxf/TbNUvUBsZr0XnALBzpOxTMi4h7kxFhX+exsvnkViqt9rH4EcDiWJB/DhfYVSsuJ2sauDyeM6ME2gotI8KJTPYlRqQ+ihIEEJnRsVN1UsmmbJhf3PfQJQCXx0rNdWLb2iWP8yCndUcDLs80BX+c3tMogSJ1cD8AuEH1eaXd//OmRpQYyMm5IjHORNQYJqPSdJbew8xRScybnHd5juq4shiJpb26OfcZHk8uuGr67Bsb/Vt30xqYQFTUuqceBSpfTaPm86QG3N0runXfinCumM9SS6tYZAUTlHEDAusChjlgu3uiPdSL0Ssn3fk7H6KogP6mEWVrVhIy02Aob97/VyESiqLsDpjhQXo=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:7pxSy6w6IwCdV0hyavSaYWhyAqWnPK3sI+3nNa7kA3HxpT2iY59mGpm1cTsPCvxwRzTU0dUSEiOMv1GTo1lkMmKDqAl5SRFdZlCVYZi/DFkrFO/4cSJ31LWxcdJ8BtzT+HbKaM4vCKMVGybxJRphsqn+HDCIDcnbbiDWscqGGmTCWXnWQ1pPKVTRfPe4c/Iz3tTd+vtTWkymFS/E4S40kIsE3Q9R/tpaZrVHRTBJk6JPCJ84/PS/HpwE9hlGEo8VH0uPto1jbG7D3HE2oA8hpcd4Lt3Qgwb8sarB/SWRCJJoAkKtgnkezmOvXRQXVPf+SVPESxKUA7Fr1AFKmRLg+XDmJzwhbK8et1nhSjGuy34p6+z/zHAdZgR89BBwshtmskCvvyecaJsPKcmHibRUdpERCPJLluuXY2djY8fX2xtLspEtIIyJFMxF+T6fDGWFdG5nqVSM6lw3vmP66n32dg==;5:IHr6Elq6uBtiRPP2XF2Y38g7TidVxKXR3gdyXTOujrxSqicVZUxU2Dn8+mKB1ImwvulZMGWShsDlsaIE0QEpnrQ8Yiv4Lv+WfjsUkm3heuJk7ZF+bwfCL8K25fhifj2HsQDnzX977xs8X4WHe8iqqEHUwQtSWhzDLPmtQhNGHGc=;24:9dRJXBC0GQfvnWAXgTEUig5wdNirBbcJ3GJtJW9ZumZlPHAi0WMWcSbpU5qzBNIYyZxxhoI3FpUH7HS6N6HlCHjWuEIsPQ1RuhpaG1w1IcU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:snHqvhp7tWSJkI5utfRe2EXqMC/Pg8/roXEL7hPHfawANvQ/inUPnSGw3PGXBu9q8R3dRW63RSOYHmcx0ueJLN85O/ApcK4qqWdg4HVQYfBw6agIVqyHdw6Br+AX5IujuOx/N3JP9YDN5wBpbb5qIFsEmso0H4NLmvvKhuxD65NC2V+SFNILuf1BB+/E4SCBqNjnjU6M68XUUL54s7YDuSTobv1irvRUjdwtnIZuRUXfxc8uhO/lveGlRTo+bq2N;20:EYywe464kQwOBnNTLeJ0/wNwdTQd+IWIpZp91CWvaJywVonvIlZhDrPqFxxBYg2JwLDhjSZ69Q/b46ZCL2dUbB4vSgUNf2JQuF390t7D3QUUhPQOyUeIjq3CdF+LGQL0G+zXilb88a5LmTCinzMPb5rN4YfUNXW9T6yPr2LLypg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 16:17:18.1939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fd4934-4e0f-48cb-90ca-08d5e10073fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shakeel,

On 03.07.2018 18:46, Shakeel Butt wrote:
> On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
>>> +++ b/mm/vmscan.c
>>> @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
>>>  static LIST_HEAD(shrinker_list);
>>>  static DECLARE_RWSEM(shrinker_rwsem);
>>>
>>> +#ifdef CONFIG_MEMCG_KMEM
>>> +static DEFINE_IDR(shrinker_idr);
>>> +static int shrinker_nr_max;
>>
>> So ... we've now got a list_head (shrinker_list) which contains all of
>> the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?
>>
>> Why not replace the shrinker_list with the shrinker_idr?  It's only used
>> twice in vmscan.c:
>>
>> void register_shrinker_prepared(struct shrinker *shrinker)
>> {
>>         down_write(&shrinker_rwsem);
>>         list_add_tail(&shrinker->list, &shrinker_list);
>>         up_write(&shrinker_rwsem);
>> }
>>
>>         list_for_each_entry(shrinker, &shrinker_list, list) {
>> ...
>>
>> The first is simply idr_alloc() and the second is
>>
>>         idr_for_each_entry(&shrinker_idr, shrinker, id) {
>>
>> I understand there's a difference between allocating the shrinker's ID and
>> adding it to the list.  You can do this by calling idr_alloc with NULL
>> as the pointer, and then using idr_replace() when you want to add the
>> shrinker to the list.  idr_for_each_entry() skips over NULL entries.
>>
>> This will actually reduce the size of each shrinker and be more
>> cache-efficient when calling the shrinkers.  I think we can also get
>> rid of the shrinker_rwsem eventually, but let's leave it for now.
> 
> Can you explain how you envision shrinker_rwsem can be removed? I am
> very much interested in doing that.

Have you tried to do some games with SRCU? It looks like we just need to
teach count_objects() and scan_objects() to work with semi-destructed
shrinkers. Though, this looks this will make impossible to introduce
shrinkers, which do synchronize_srcu() in scan_objects() for example.
Not sure, someone will actually use this, and this is possible to consider
as limitation.

Kirill
