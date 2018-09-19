Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3BBECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE722150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YzdzGboO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE722150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbeISVh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:37:26 -0400
Received: from mail-eopbgr10118.outbound.protection.outlook.com ([40.107.1.118]:21584
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732492AbeISVh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiOF7ixpQm/r73fCn/deRNrbOtx1l/vk8tHNn3Ge9kc=;
 b=YzdzGboOTFnkjKnyyH/XOcNHPi7K9WdoFseXGlOUkRvM6GXd/2I2NXlYgtucbffzmn1zD6Gu2DDHUFx4ixnEAN/JhWc8TmRrva/zIqv0EWEfdIyFyVXvLIAQWRXbjCsh0vymjPyM6gXpLkZze/KJIKu+mSweb9r+2AKyOx/PJiE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2021.eurprd08.prod.outlook.com (2603:10a6:4:76::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 15:58:46 +0000
Subject: Re: [RFC] net;sched: Try to find idle cpu for RPS to handle packets
To:     Eric Dumazet <edumazet@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, tom@quantonium.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <153736009982.24033.13696245431713246950.stgit@localhost.localdomain>
 <CANn89iJ1UnwLFv5+AwXgeb1BUhYg8UJYTJLtiipavJee+2SWxQ@mail.gmail.com>
 <2fdf2bd7-1cc4-a1e1-15c2-e2badfcd4d59@virtuozzo.com>
 <CANn89iK8X5cW3=YnNRrKo=BVCFJkJ0D22YY_eJFLyGCX+5SxsQ@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <84d38f11-2133-9d34-e468-d2ef16715f49@virtuozzo.com>
Date:   Wed, 19 Sep 2018 18:58:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CANn89iK8X5cW3=YnNRrKo=BVCFJkJ0D22YY_eJFLyGCX+5SxsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0102CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::49) To DB6PR0801MB2021.eurprd08.prod.outlook.com
 (2603:10a6:4:76::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 379f37ea-68ba-41a2-a50e-08d61e48c8d7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2021;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;3:P2S+0Aixxh2RTBE6jHg7U0Wf60npqlUHRyyiTDRnUaeicowl3I+ESjKQh+65gqLnHIaXMcQpGBzQpH1ggAEN1HzuU5hUp+LXxF+sYeFtYHk6h46FNVsJTSbqUItnnXAtSqxTZ+fbp2GtXU5+Xca5TE5TchcLZX4om4z7E/3Ifw9w75vjoVHofbv9WZsK3rctWolOS5d/62qXaUyRAQokT1mZcCQD4WnJ4T55we5KRQMceGFs0fWRvPjqcWCPkQ6R;25:cURfdq6kBRZDHmq7mHMVGxb4v2fJa5VpE+pMRWcy45ALFvmSRH1MS8kyBcPeBDGSIVmWohyCJexAfO25MhO6YaDIKMG0kxWPo+tmfycIy/hBxwCDypKrYbtN356hKA+wNwR+1xxAf91trHerKcDujo85LiETT3PIZqvPcsJUrfB2KsORDvKX0WZI0+QpoPpOJ9hHlXbmoDTPcyADy6Sc+xzIH3GPtEdv6AY1pLxBfVAzIkm/HtegSmK/yaBZhNUAsZPl81lG7ILcnE12zEn6FygFzhQtnaBxNEY7UGSQZbdQYxjj3qCaF7X6oFbRzoUzOgMOOmkt1Kr4LrDiedlG5Q==;31:j+kdRxs4d1QvmYsYsaTjMgf5q6vFliGiaMdZUbUnRe9bkLpte8oEGLJt4cLmNUDFnT90WKNWk1WiBxUF+2ra/uKtevmmTszOEQoQGi+sj2Ywowa2FlfhAqBqMSJHclI7fjEQ7MTslXCE7g+gbD6kp1Ah0EjtqCypVXle6+cLVdFiW0FpOaOJtrF7rPE7Zumw3Z6rEPdjlPn3KYF0LLbke/fjz8/ra7jSi9l1kGe+h1g=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2021:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:k7EyjsZbEjN1ATT7Grxcf79R1VujXdrnRFkM1SxQYvZ7lo6y0vXMrrGUGnK39i0c5eZt8PF5paUjTUhxodxYRu3vo/42Fl2b1cVJlus3ys1MU3jDEERX4NiUV+ZZUQCTuFiascFuODnWf/k1OGbhVsVt4HJWEFb69/6QXCnUk18Z06lbsnzxCxI9lEFMOpIIN+CaEJEq0rnVcpMsOVj440/HFx+poWQzNUENbiz7iSTKY66fxKeuBm/qVqpGHkCSxxOCzjAivZPxJOJs+tsAG4sUv5BYnRBe8KObHdvG3YpXYTcfYew9zaspNYwZ0/ynzjfNRSyAI37JUhWOCFg9dfYJjxJ0bnOnxoysyBYnbfSXlS7AVv4hSJ3mbVM2zHkRO0HFIzd1Ehu5q0gclXIrbQLxnqHX70XxbMxzYLcVur9fTEIE0SkND9sFHld4oO91xUML8r/MMdvNYwSr5JYjMmQ5GnHWvIa3gqFxZqsTZykUckigsb+K703vtFDhSUQ9;4:TDpdakxZUg5uNjoIPKWKbcJci6o4Z9n5uefhoLCxaZ0iWpknXHFEFWHUu4TdFGlHTfhSGvY3HEnTxCmI5WigOjr1C53xaheYVwZQuTnZMPr2PM2+Q0wOtFSpjcYoAOpiWdv3ZI0WER5DMqOPTb0K9sVyPKxNh0GyL0TfqTD3ttoclSwlReUUJ0utPsWmXoO+a5IN+Eo4i2FIbwrrotM/Lv+JGZHn3zT3BhEDCUFS6dtIDzq1uSs9tNsutR+3MpzsDbTBAUzacIiu1KgjEAUFtUZBDoeSGhj6ja6EDDxWhWuPjf7XorGBAMOFhVPLBBrwx7ib7oy7ioyxn09LOHIQM/K6EjMZAVQRtmTW1FXmU9I=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2021719FC5044F40F691E7EFCD1C0@DB6PR0801MB2021.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:DB6PR0801MB2021;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2021;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39850400004)(346002)(376002)(136003)(199004)(189003)(64126003)(4326008)(23676004)(8676002)(47776003)(16576012)(58126008)(54906003)(93886005)(50466002)(6486002)(77096007)(26005)(65826007)(3846002)(305945005)(25786009)(5660300001)(956004)(229853002)(52116002)(52146003)(53546011)(386003)(6246003)(446003)(6116002)(2486003)(11346002)(316002)(2616005)(7736002)(81166006)(486006)(68736007)(105586002)(76176011)(5024004)(66066001)(86362001)(186003)(65806001)(31696002)(53936002)(97736004)(36756003)(31686004)(16526019)(2906002)(65956001)(478600001)(8936002)(81156014)(230700001)(106356001)(6916009)(476003)(37363001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2021;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjE7MjM6WW9xaXRFVnNzWE9CaWlDL3VSa2tCSks5?=
 =?utf-8?B?TjB6ck5ncHIzKzN0SXhwVUVUekdwQjQyZWttMFVIMjdUeWZTNGp0YjdOUitl?=
 =?utf-8?B?UU80LzNsV3A0L1BhMFdaWkZnc0RDWktXdFE1dlQydjBUVFJpUmZ6Uit1NGpU?=
 =?utf-8?B?R2hYTlJvOHhnQ3hBQVpsYWVRMytNbEhDOXZQWjc1eTdhQXYrb2RnZFRyaU92?=
 =?utf-8?B?WFc5dXNuRHl2aEloMUFBeDlSRmR6bG1mcm1za1UyZUpWQ3ZlNVduZzZkRVox?=
 =?utf-8?B?YmthUzE5Z0h5T0w3b25wRDBzdmJhM0RwcDQ2RlAyRStES1NtTzIyVWtHQjdC?=
 =?utf-8?B?MWQ5MEFsOTBxazQyQkpIODRMWjY5LzZBVW4wUjlaaFJBL3FSWUw0YlM1WE1z?=
 =?utf-8?B?MlR5citxYnQvNy9xblpUVmd0clloVnluQ2xYd0ZqZEV1MmJFVE05VjluM1lU?=
 =?utf-8?B?R1lGWUpZcUNjOFZjaHF2ajk1WFhnUFlHNC9ibUttS3RxZEt0TDV0U0k2QUs1?=
 =?utf-8?B?cGgweWZIeXZNRUZQWGNxNTNXeEx1Y1MvUGdzaVZxcE52TWkvSktZSS9oTnJa?=
 =?utf-8?B?WkVLcFZTNjVYcUFxaHorT09aQWI0Q1RzbjFKZG1ZblQ3R1FuMXdSQVJISVBh?=
 =?utf-8?B?VDVqdmhyblFpRWdpNGFoYk5vWTh4aHc2MlloNTNtK1UvZlhJU21CdGt6Y1lY?=
 =?utf-8?B?VDFZTWw3K3FUYVY5WGV1STdJUDFlb3JXbnBPd3RHMWttRFNUVVhreE1aUEZC?=
 =?utf-8?B?S2JGWUNKT0EyYzVSaHd0cUs2aVRwNTZEdEtKb05LUzJnVUJxd0gvZUdYMW9I?=
 =?utf-8?B?dFhQSHdrK2N1TXVldlNZaHNGaVlBTHpmZ2VsL0RHN2pEdjdLdTZXbXgyL2xy?=
 =?utf-8?B?MjZySDV4UEFNYXRTTjdXcllacmhmdjJjQ282Q0hzTG5pQ3pKcjVTNTBHR0VP?=
 =?utf-8?B?b05hb011cHZHVC8vcHRZVldGRFVaR3dmbUUzMVpmMjJQakhrZno4NU53Tm9H?=
 =?utf-8?B?eWJJVU12eUFrczdveVptZEtCR28rOTh1b0M1aDFjT1k3OGNnUWdyNzQzc2hj?=
 =?utf-8?B?bUtnYjVRamwzZGhzMzNKZzUzeFU3Ti9DMG13bmYzZkcvSEdaNW9oQ255L0dt?=
 =?utf-8?B?aW5ESG9yY0ZmMUxjK0ZjcmllYWVGY2l5alc5TVN3NHN3ZUVsOC9UZzZwMUZR?=
 =?utf-8?B?eS8ycVVjTUdwNG96OXhUVWNnckFDL1VwTXlFS3J4c0xrZUVNSGFIMGlEaEZS?=
 =?utf-8?B?L2tXcUNMWXkyRHhpcFE4YzdLNDFEamttK0ZkcnQxLzR5NUZvVVd5WDY3UjR6?=
 =?utf-8?B?UG9YYlc2UkNHRC9zdFJ6NlhHYnQxdzZ0d0tGVFk4RWowK1N1Zjljd0I5Mnkx?=
 =?utf-8?B?b3l5cTY3eUdKcTYvcEVvYXZGcWo0cnU3ODlndWk5SHVlcC9oeWxSdjFPZlN6?=
 =?utf-8?B?Rzh0SWJVSlFWVnBrS28wbHRuV2RHOWo1VXdGbVlBVU1vNTREaTlzcTJoSlFj?=
 =?utf-8?B?NHkxNHFiRU5RN1hsNkFOKzA0MjlNb29vY0VWTjlVWnQwSEJ3bGtuM0h5alVi?=
 =?utf-8?B?ZEx1T1BlY0prMXpJbGNkT1JUZ201eHVtU1ZIL0ErWGp2cytzY1A5YTZjRkJk?=
 =?utf-8?B?VlFlSnA1K084eFVIcWdwSjVOdUlVbnVLVHJTUkNWa0xaMFE1MnpWajRkVVBO?=
 =?utf-8?B?aGNwM0VZbjVhUEl6bG42TjZsSDVQV2VYS0d1KzNqd0hodGxHUjl2VjlybTBh?=
 =?utf-8?B?TGZhZGk2Q3pCNUI3WUU2akRLeitvaEdWM2cvdUdZL1A4S3lXRlJhZE1VaUFG?=
 =?utf-8?B?bE5Obm5RYkx0YklzQmhTMDB4YWJGbzJzWGJLLzlvTWFiYW9abWZDcUU1Z0FJ?=
 =?utf-8?B?ZWlaTEhEaUpzRGdCTU1XS3hSRUg4Nkk0ZzloYzZjeVJzaUJCMitjM3VDczB1?=
 =?utf-8?B?TnBhMys3Y2xEdzcrSnpPR2RWV0hrd0RmOWozMHhqSUNTZHV5RUJxVTd6ek5T?=
 =?utf-8?Q?98T4Ob50?=
X-Microsoft-Antispam-Message-Info: DV4lCZTGwMzIsIYrcSBOqLY5IQI4OqPiGMPh368xNr7sb1SlI6CI47iAZ0yR0KXU7qYiNvCZoHHDJoOH6/TVQHCVog6gVMnMDtAxa+SMvO22O/lgv8gV2hs3tDRSTZNAIrFwEaZgiC25G6UL2BaWWhpYdSTysIFFbmwhIUkgSzw1IXgSSjF0u3AbXHH3zGNfb1uX4fTlYZ3o7yyuClpQQDgvngzt/7U4yqIfCGtJm0ATzqHB5J0qWMlckdJJ+z0+heeellvqJtWYcgqGJJITFUbK08osp3kAeildxFF/R8UHBeoli9Sxl3uzhYMEuEeEvFvPlevxdTo2TH2DsJnOkIpBbvsuibsHZ2qMQENbtVQ=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;6:bTjcU1FCD/aBn6jUxBSWFnAnT8Le/nuY7POTcwVN6VpKZos70VGP/aRuHzo4mvEM2rUhG5ikmpDZu24iZNVBCV+MNL616KjVvb1Dg8XY4/6hXooC4G2IlGkPdMb8ylvA723yvfNDHjiHSEj7PDkz7fseg/nH21zUdj2LDn+CZIcV1UCTvhOdplny2h9SuDFuF/2u12NUSrX3+vhjrxVMs30ghSUmFldArgpjikGypPa0vxVdtZcereGMNfGV0AiXs1nZ+68enrHzsW327+hWhWB1uRpcs+IE5AvSgeYhGOFohedkjZ+U69pLGhKIdPA22W9FgtPxW0efpcKpapBF3S++3C5VN0Ylx9ehtUOvitvdzJO1BXXI8G8Lrf6ufqzTe/ojZJ8OVIv47Cb+bAcYF6vCYlcc7E517/ch5IQMKaev7nN11K2X6hvCyAwn/U82W4iSta3V3sLKIpOHIhiEvg==;5:xulDizGCyvEBOm4KiqJXm0TVrBNjSNAL9G7sX1WSs0BGOSepZzv6s9GussBT2vr8i1olMYXSkMZrbAjbfQUBxDuWhfigg5PlazqFbAJQbE+V2Wtk5XPMdCFE+urJI9atzIEocV3A4oRjDZDl3SxVGISd+09a4R+Yc5yGjhwLmI8=;7:IAIgIJ5dg0N0V9nzI2Yu+hpegt8yCsuXhX12oJ/aDn1SWyM0yljhBe00vHhSfezFhAzJ0fkOqA+cGHgIiyUKutoSjC0MbQ4GD1x7qO8muA5AR0VyYnQ+NsgY7DOOClQmgofc5lxKaEqEzWS0Q0209+NHoCBaZ8BBPuFLb4mVJk4ECLnbz1STPQp7Y8nyV+saMHmb0qXRsFGarQ77FPUMBasVXswkNaMz9u5+d/shCx/hu8ixhBJBWvI+pskr+gF9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:/4/dtXdLTnF0Tiqktb++BkUwXQ5IpRo4p0R1jBQDhsAdD4u8NdXH5hH5I2nTjbp8p9LQPcfQFo6TdfqWsrrsiaEA+hbji0xTGx40sFbvQFF0pyn0aHmfncsBTYz41uD7hyV9PWd/Jz9o12cBA5tpmbNIasnxevm7TrNj319QOcs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 15:58:46.9673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379f37ea-68ba-41a2-a50e-08d61e48c8d7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.2018 18:49, Eric Dumazet wrote:
> On Wed, Sep 19, 2018 at 8:41 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 19.09.2018 17:55, Eric Dumazet wrote:
>>> On Wed, Sep 19, 2018 at 5:29 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>
>>>> Many workloads have polling mode of work. The application
>>>> checks for incomming packets from time to time, but it also
>>>> has a work to do, when there is no packets. This RFC
>>>> tries to develop an idea to queue RPS packets on idle
>>>> CPU in the the L3 domain of the consumer, so backlog
>>>> processing of the packets and the application can execute
>>>> in parallel.
>>>>
>>>> We require this in case of network cards does not
>>>> have enough RX queues to cover all online CPUs (this seems
>>>> to be the most cards), and  get_rps_cpu() actually chooses
>>>> remote cpu, and SMP interrupt is sent. Here we may try
>>>> our best, and to find idle CPU nearly the consumer's CPU.
>>>> Note, that in case of consumer works in poll mode and it
>>>> does not waits for incomming packets, its CPU will be not
>>>> idle, while CPU of a sleeping consumer may be idle. So,
>>>> not polling consumers will still be able to have skb
>>>> handled on its CPU.
>>>>
>>>> In case of network card has many queues, the device
>>>> interrupts will come on consumer's CPU, and this patch
>>>> won't try to find idle cpu for them.
>>>>
>>>> I've tried simple netperf test for this:
>>>> netserver -p 1234
>>>> netperf -L 127.0.0.1 -p 1234 -l 100
>>>>
>>>> Before:
>>>>  87380  16384  16384    100.00   60323.56
>>>>  87380  16384  16384    100.00   60388.46
>>>>  87380  16384  16384    100.00   60217.68
>>>>  87380  16384  16384    100.00   57995.41
>>>>  87380  16384  16384    100.00   60659.00
>>>>
>>>> After:
>>>>  87380  16384  16384    100.00   64569.09
>>>>  87380  16384  16384    100.00   64569.25
>>>>  87380  16384  16384    100.00   64691.63
>>>>  87380  16384  16384    100.00   64930.14
>>>>  87380  16384  16384    100.00   62670.15
>>>>
>>>> The difference between best runs is +7%,
>>>> the worst runs differ +8%.
>>>>
>>>> What do you think about following somehow in this way?
>>>
>>> Hi Kirill
>>>
>>> In my experience, scheduler has a poor view of softirq processing
>>> happening on various cpus.
>>> A cpu spending 90% of its cycles processing IRQ might be considered 'idle'
>>
>> Yes, in case of there is softirq on top of irq_exit(), the cpu is not
>> considered as busy. But after MAX_SOFTIRQ_TIME (=2ms), ksoftirqd are
>> waken up to execute the work in process context, and the processor is
>> considered as !idle. 2ms is 2 timer ticks in case of HZ=1000. So, we
>> don't restart softirq in case of it was executed for more then 2ms.
>>
> 
> That's the theory, but reality is very different unfortunately.
> 
> If RFS/RPS is setup properly, we really do not hit MAX_SOFTIRQ_TIME condition
> unless in some synthetic benchmarks maybe.
> 
>> The similar way, single net_rx_action() can't be executed longer
>> than 2ms.
>>
>> Having 90% load in softirq (called on top of irq_exit()) should be
>> very unlikely situation, when there are too many interrupts with small
>> amount of work, which related softirq calls are doing for each of them.
>> I think it had be a problem even in plain napi case, since it would
>> worked not like expected.
>>
>> But anyway. You worry, that during handling of next portion of skbs,
>> we find that previous portion of skbs already woken ksoftirqd, and
>> we don't see this cpu as idle? Yeah, then we'll try to change cpu,
>> and this is not what we want. We want to continue use the cpu, where
>> previous portion was handler. Hm, not so fast I'll answer, but certainly,
>> this may be handled somehow in more creative way.
>>
>>> So please run a real workload (it is _very_ uncommon anyone set up RPS
>>> on lo interface !)
>>>
>>> Like 400 or more concurrent netperf -t TCP_RR on a 10Gbit NIC.
>>
>> Yeah, it's just a simulation of a single irq nic. I'll try on something
>> more real hardware.
> 
> Also my concern is that you might have results that are tied to a particular
> version of process scheduling, platform, workload...
> 
> One month later, a small change in process scheduler,
> and very different results.

Maybe, but especially that function logic has not changed for a long time.
10 years at least. The only change is Peter adds idle core searching
functionality recently.

> This is why I believe this new feature must be controllable, via a new
> tunable (like RPS/RFS are controllable per rx queue)
> 
>>
>> How do you execute such the tests? I don't see the appropriate parameter
>> of netperf. Does this mean just to start 400 copies of netperf? How is
>> to aggregate their results in this case?
> 
> Yeah, there are various 'super_netperf' scripts available on the net
> (almost trivial to write anyway)
> 
> ( I am attaching one of them)

Thanks.

> Thanks.
>>
>>> Thanks.
>>>
>>> PS: Idea of playing with L3 domains is interesting, I have personally
>>> tried various strategies in the past but none of them
>>> demonstrated a clear win.
>>
>> Thanks,
>> Kirill
