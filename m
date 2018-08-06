Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90902C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A41219EA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gu8cXDn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A41219EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHFLDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:03:39 -0400
Received: from mail-eopbgr60094.outbound.protection.outlook.com ([40.107.6.94]:45334
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbeHFLDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLmNu4dKem3Jsba/6scNhAIdjRqBjScMOng+29Y/mmg=;
 b=gu8cXDn08XISu+wtYBWzfs4tn91lfCWRYzwGpLGrhdSxXTTHw91CAlYluAFkwVl08nbAox8RXMm99gNBN/ih8JQ9sArb8pXvLc4a0bD6ffqgpY1uh5ORBd4JZrOFnXNOnzNWtygPqFVtBHVwZhr/52mvWNCGdVAGVif1lPC55UQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 VI1PR0801MB2032.eurprd08.prod.outlook.com (2603:10a6:800:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Mon, 6 Aug
 2018 08:55:29 +0000
Subject: Re: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
 <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
 <843169c5-a47a-e6cd-7412-611e72eb20ba@virtuozzo.com>
 <20180805000305.GC3183@bombadil.infradead.org>
 <e5d67774-a006-e533-d928-64a4407cbb16@virtuozzo.com>
 <20180805125004.GD3183@bombadil.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0e7f6e2b-621c-dda0-ebd8-c9b4e7e7f04b@virtuozzo.com>
Date:   Mon, 6 Aug 2018 11:55:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805125004.GD3183@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:4:29::16) To VI1PR0801MB2032.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb3a233-8575-44bc-7e15-08d5fb7a5d0d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2032;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;3:/gxi+pvenzgUB1TEm3qXerbMjotxnjGhvLQgeMaaOTzWPpl6EvjavyTlv+ja69G6AcU5S9/LKSNgjrfVHTWaBv/cnrUB59LotHph1Q2SmN9gRxL5c+B171pTKk63xWrDO0fC+hgMwHQSiozYMeE7IBDXw/Do1EAhciaGma62yzIt9fTlYowugCcHOVxkDCafEttmWxjMNKO+vxfSIjTeDmdI6qov5clZlFdtCuWhFoU8lFqYNthYAI9eO2Pym+Jg;25:GPwSUrGKu8JmNjekb07geKCiQ9EOPaUhIgkL2v/eEYZQ5HIn0f+1wKMh8m33BCOM5QwE+v9ed2x0s4ObV20Nma5TfAkldOXeskFAMyUgZMriudbN//9wfBp8FyabxQH7qWchqOMLRBxy16h5VJqAkGVQtAV6VJZQRudjlx3/V340ZfkvoZL6drXmOm82zbJdsPGolZ9fDfGLIIHR5k8AwFzmQeJlKAcbTPPXmRgMWaqT74yDIjlTPBrrELvSHCzO1uYjzbUzqX5DA9daifwFJjKbnxXkiY8KenuZKQymj/sDMM1OYxq6yO4688hqejPkfSQtNSIppAjD2SRGQdzYdA==;31:BCIsDLGzABME5iX8TKyXWhr/I1WdXAIKTN1o91InrfFWjNN+fTuiTkK/shc/z3S6Kt+XxZv4QVe/giQj/etri0yT1r1XXin3oDejqoTgLSjVgRZKFxwqLeAreCeQpoghFOC2G+JF4UVru+LCY2WNzfxVDbklKGgeft8MnHCyVz5hSnJbKR6miyU8V1txoBl6Nmk/b5b84D907RK0mQWaAeSOYWRCVZMUPdXxxJ75Q9c=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2032:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;20:2PuvIb0Ns/0rcAmXKVBubA5pt7AKesmNRsb1PILQN+/7KpFyDH3T+0Jp8CX62XfYnwK6sFWQbcrwxppVD1tiVhGuUXTcPg4BE6uBDVrRivfMORw1VtgYipDb7v0upv8ZbIglK6qfY10NvRJQhmn4oi9o+pWsPr90zSNXBFWsDxp3VntGMQkJjOJwpVo/Kiferym7qpyvrYe2ZNg4HUYGDcjx+gr58kKEtaYk327phg/RuVHFgVpl8rwNHJSb89GYh9r8y0VojRgkSfU+ePPW8kVuO31PWWDJ2AcdpfS9SeQrjsKeBm0M0wotsdm/klfjLJ2QuNg+XB9lW450U8B1tqYMzfY87EG/l38Up/E7x9Lqwq1Tm2QSpGENYGF8mjhzR5B+jOtpCUDvw/Fi3e/fA85emzsqeBLLdkLErjuUvKCXx6p079kao0tBIJk2E6LNEvYbVhEGVXXErrLTnn7bO7j+i397R5k/yRCgtOJ7Obm2DIBU/U2GC7ZTBJO22Umj;4:0V07Hbt4uKTmX+o8esIuhSz6oOA2VFYLf/3SgF0pQAS60K0nEefNX1x7OcYPgrVVG+p/5Q0cEtfBGB9xQcd+NuimQmZZhgQf3owZqW+z58Yf1QyBRVDpv8eB8LPkgVKLmOquteSwgXESk+oG1/Kd/5BGqv4CMNm74gzL+JiiJcCDvm/MsNvNgJpBmsZi6UlFtH6MK9iWoBX98r4acQaeSz2Yr8PjPhLLmTF0mLw4BreDmm6jvlxfTnwZNofN33ArjQ1ohGr4qqGboCrwiJ6/vA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2032F4976DCEE82D5A226357CD200@VI1PR0801MB2032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2032;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2032;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(136003)(396003)(39840400004)(366004)(346002)(189003)(199004)(53546011)(7736002)(305945005)(386003)(36756003)(53936002)(76176011)(93886005)(68736007)(6486002)(6306002)(58126008)(316002)(52116002)(2906002)(50466002)(47776003)(229853002)(81166006)(81156014)(8676002)(8936002)(2486003)(52146003)(23676004)(25786009)(16576012)(64126003)(6246003)(39060400002)(4326008)(65956001)(65806001)(106356001)(105586002)(966005)(478600001)(31686004)(11346002)(446003)(66066001)(486006)(956004)(2616005)(476003)(3846002)(5660300001)(6116002)(77096007)(7416002)(6916009)(31696002)(186003)(65826007)(86362001)(26005)(6666003)(16526019)(230700001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2032;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzI7MjM6NWJOK082TngyQnovN0MvZlFKNTRMUWlP?=
 =?utf-8?B?ZW5HTmFLSkp6TkN0MVlpVWp3WkhQL0h2ZGNJcFJWSDFuYUZibllEVk5jVE9S?=
 =?utf-8?B?dURNamVDeFlyT0lMYUg3b3FDZ2lweklvMWVaOFlaSUVOc0VLdjB4U2RtemRs?=
 =?utf-8?B?WE5WaDNkNjl0SFhQQWJENWUzOG1lWjhPdE1JU2tpVTR1SmlPZFN4Y0llcVkz?=
 =?utf-8?B?ZFhyKzZ4ajd4MEtYd3ZYemlGWXpEVEcxRjBIYkFXMDFUd2JvckRsNWRycmZE?=
 =?utf-8?B?ZTJ1blhCekgwUzg0WkF2V0h2eS9reXg3OTB0UnNzVlBZK3QvUWN2L3pLc1pm?=
 =?utf-8?B?blcwMko1RDV2WjduM25GMnluVlRrR0JKc251TE5CVzhEOE8yaFRMWENtRHZ2?=
 =?utf-8?B?dE9vWjZGMGdnY2krRVlmKy82QlhiblVwY0RMOXFHeUFtdytraW5ZV0JDSDFa?=
 =?utf-8?B?UHBGY1NYZVl4cG1HZlF4MzZOb0krRC91a3IwdWU3QU9jMHFlVzJweWR0K1hz?=
 =?utf-8?B?V2c3cTZ0OUdTMUFudFVlVC9UdWdqTXdXMGNMRy9xQlJrTnFqOHhLRGQ4RFQ2?=
 =?utf-8?B?YldQZFQ3TVBRY3NMRWE2SFgyRkRPbVBDbFNtWW9oMm9RTHlHcEw0andFS0JQ?=
 =?utf-8?B?ZWd4eDEvU3J6UGlTalNLUTYwRUk5bHptazFNMVprNWNWVFIxWlVRVnB1c1Ir?=
 =?utf-8?B?YTliYnVqSjd3eXJwY0Ixdm1qSm91VEJQaHprak1WY1dXUEJiRDQrVXhmRDd4?=
 =?utf-8?B?c3FUODcyOUowQlFkUHNIWTVVR1lLb2lsRDhibklyOEhwSkRsamJXSVgzTkt0?=
 =?utf-8?B?MTd2ekRXbVRya295T2RlTUpDWGo1VlRVTnFmbWh4TEdYemJNSjFXclgyWlVo?=
 =?utf-8?B?dy9JRGRKMTVHN1NiUkpiTytHZUFBajBxT1puN1N0NU9iQTM5WHJhMXNvNkp0?=
 =?utf-8?B?Z2dhenJSVW9oZ0lISFp1VEhUNHVqL01yc0pPMFkxenA5ai9INXQ5UzdUdVhh?=
 =?utf-8?B?QjNyTVJyQWwxSlJvcEhTSGRrRHNVdVFmVXVUejhDd3dyazV3ZHh1S2FObnh2?=
 =?utf-8?B?bVBCcjZydlJoZ0Z2bzZpMm5ibmxudEIrdGk1Qjh4OVJQbXFIamNwQStURzE2?=
 =?utf-8?B?dmN3ZXZhRS9FM3NFZEFUaDhaU0xYc2Y3YTg0eDY5cHpPVkVaZnoybE42eGFw?=
 =?utf-8?B?czFocXJQZFdTenRDaGRNeGFpYkJSRDkyM3VDWjl0aDhjNUF1N2dQckpxd0cz?=
 =?utf-8?B?YWl3QkJFbFVXZ1dzQnNBcmpLUXRLZkp2ejNaNU10Mnc3ZW1FYnBZbnZTQllk?=
 =?utf-8?B?VWUzVTY1VlFFU3VvMHp6aE5UNXZuVy83R0NkUTBlbkNCNlU1ZHYwMGdZUGhQ?=
 =?utf-8?B?T28xbFpxbEVJQUpwRG1DaG5xdXRiWWRGMVNJK2FKS1F1TUZqMVE1MVZQb2lx?=
 =?utf-8?B?cTF5dFhxWGtZa1FBbE95dzM2a2FWQnA4UWF2REdjVlJXYWtkYzkvMTBpeHlt?=
 =?utf-8?B?VnRWdTJ3NEh0aHh3UnBSNlhMOGxWNDF4b294SVBmWjhiOFNkYVVreDFvNTlr?=
 =?utf-8?B?N0ZJZUplVzJ5N1krR2N6cnFYNllodEdId2Y5aWNVL2xqbW1uTXEzVWNuQk9l?=
 =?utf-8?B?ZFBEUVBqaWFrcG54MCtRc1I3QnNleFpvT2ZHa0MvMENCTENvbzJDZHU5UnM0?=
 =?utf-8?B?QXJIRGt1eDZpZHJqY2ptTHBTd21OZ2pkSnFiM05wczAyUkd6WndMK2tlYzVj?=
 =?utf-8?B?NDc0V2ZlWVdCMlRIZHg3dlRBeGFBUjZkQ0RCejR3eXFhYjJKa2thdXcrWVA0?=
 =?utf-8?B?UHdkTXpVOHFOWG1NZFhCaDRSZVNPUkJPTGo1M1E0eHdWL1dMS3RIUWNsQVM2?=
 =?utf-8?B?T0JkeWlkUjUxYVNkSzBPY2FKeG9TRjNzQ0I5dXhwci9GMnlMLzV2VFIvZjZz?=
 =?utf-8?B?OXZSNW1laTlRR2Y3WDdEK1Ztb2dCYTlPZ1ZVYVpCaEtjK3RhY0tXbGVyZW9h?=
 =?utf-8?B?ekREbVhGaldLa0NRN08xNzUrWllUWlRPeHN4SStxTERmeVBCbjhjL0s2MkUy?=
 =?utf-8?Q?jhJqew=3D?=
X-Microsoft-Antispam-Message-Info: +d1Diu4ACvqSaoLPvgMwah5J36XSfN1tkOoLZrSrzPs+3g1c9NaoDjElm8S5jogQiME11zIsTWCTsbKPp/4o4PMtj4G8z9BjS8/ovEhALx+5k7g4ZRUL4L64vx6KwXB+SHOQmuHGrtPFSzqkGkhtmKHFFyVTVLkYI0cUddmfH4L8iLfNVxy4YWwdh6P9t7QTg6ZPYV8NRQu3rKCnRe6RXx/rSCxSrUqFqomKP7rUqUiKXZ+dZpvgMKiAOG3k4QSfLnJeS9QXurEB0prW7y9EzaFjNMKoc4DPwzUL7LokNkjhvqVTbldhPCJiEwCpKxlsIl50j2cr2yj7e9q0G6xE7CZYma+HubXPMPRCP0yTJOg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;6:XwRn9m+8i1u5BCt8TvxOxJFmESVKNq6/x/LgUCian0idqclRFtkEVAzgOpJJyk2ey4hE27GH3qxWw37TRG/SzefRTC+UkUzgz7jqOc1DuVuiYCUuViAtSeA9WUDkrfD33cJ8z3MabLfvcw82XGm0Xa8FIQYMsViHrsruppqINBj6F8AVwP75Foag7BdKKVE52iE7h+5s3MjZ+Zryqm9TZq1KLKUeuI3jelbqnPqrkw+H6NjA+lnDXY9Q+Glv5CBDc2Hj2828y4cC+PbqgXtUO3wrRklEexohIbt2R+bQNAlSh0+XGQOSHzNT8bEr4lU0Q6KWUM4abXFJnxtTFaBLo0vOESmBVsJMUUd4RWL3HP6jb+KBkYKbxhwgS41xWssuC2JDbWHRnZNRkeot3b8aFapBe0htsYqR30wwDnAINX7HntmeqphtNUbN3bsHRr5MjPsDPWtAVBOOZFHRklGvyQ==;5:H3aPwC8qo4AQp3e3IaOENnAfvxYYpoz9HbXjtfcO4JhNM3zqdl1BPCAoSzKMqy6KfWx7mHN3yegHVJLL5k6iIW73QFedQ4jyS2HRSFxe3j17bxDJKYhQz9bF+TBauaIQHwyPh9ggK5Ky4UgKAIwq2BKQxF+SzsbHemyAPlD7Cjs=;7:j3CgQCh/Qvq6l80PF/usQQaefA1IkRfbtYapNBlEaaQtSMfsEuh5Cr8Ywz8yU2Ocf6F2Fgt11jO9aseJ3ouSFjLtegll0FBMiEessLQNtEg8camLixfXSxAYxiwUWFTPoWPD0DWmFmebmcRmvCDeM+PqIagRoXxvzInFLTEUyeRI3lXb8GIThWFwfTgAhS0kULofYy7oIF/hBBowk4GnAjxLqyID6PsBH6PXcBxF0OZc9xXBSHXqprNSc/lMnqwc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2032;20:4heXrwUXCe9F1xFbuz8LnnEUE0EdBgxqxaVT69SLqI7lPK5kpPVOQ9oRr2/Hau4QLvtEZ1jUH4ELRca1/8d0jKXTtzliolx5F3E58ZhmnrfgXT2QpgP11fxXatDVvdJ3z53FBjEmZQnioVZO4FgEpiUDC3f70mtkPf+tkeE6/VY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 08:55:29.5088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3a233-8575-44bc-7e15-08d5fb7a5d0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.2018 15:50, Matthew Wilcox wrote:
> On Sun, Aug 05, 2018 at 08:30:43AM +0300, Kirill Tkhai wrote:
>> On 05.08.2018 03:03, Matthew Wilcox wrote:
>>> On Sat, Aug 04, 2018 at 09:42:05PM +0300, Kirill Tkhai wrote:
>>>> This is exactly the thing the patch makes. Instead of inserting a shrinker pointer
>>>> to idr, it inserts a fake value SHRINKER_REGISTERING there. The patch makes impossible
>>>> to dereference a shrinker unless it's completely registered. 
>>>
>>> -       id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>>> +       id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
>>>
>>> Instead:
>>>
>>> +       id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
>>>
>>> ... and the rest of your patch becomes even simpler.
>>
>> The patch, we are discussing at the moment, does *exactly* this:
>>
>> https://lkml.org/lkml/2018/8/3/588
>>
>> It looks like you missed this hunk in the patch.
> 
> No, it does this:
> 
> +       id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> 
> I'm saying do this:
> 
> +       id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);

No, this won't work at all. The patch introduces special value SHRINKER_REGISTERING,
because shrink_slab_memcg() needs to differ the cases, when 1)shrinker is registering
and 2)shrinker is unregistered. In case of shrinker is registering we do not clear
the bit in shrink_slab_memcg(), while in the other case we must do that. This introduce
a generic solution for all type of shrinkers, and this allows to not impose restrictions
on specific shrinker registering code. A user of shrinker may add a first element to its
LRU list before register_shrinker_prepared() is called, and the corresponding bit won't
be cleared. This gives flexibility for users, it's just the same flexibility they have now.

Before the patch, list_empty() was used like such the indicator, and this is the difference
the patch makes.
