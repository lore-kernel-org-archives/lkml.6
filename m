Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62585C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11DE20C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QWfVc7SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11DE20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeHBJdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:33:24 -0400
Received: from mail-eopbgr20106.outbound.protection.outlook.com ([40.107.2.106]:20848
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHBJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUoiGG2saAZ41IBHgmUNAC0Yf6pRPVDpV8Vl3vkImYk=;
 b=QWfVc7SOcS/3eHQkHHYFOhb86aWamT2kjaQeo/F4JwhW4j7DCJft0fIn9jmEdtMYQK0XOEZKMxCw6TJIFMLoEauUVuq+4fCdpVNvmU46SHbAxH49NThp/iCZd591c4Ohwgl+P2oSv/7MMGXqkKsxufkVuZL5T91uMR17T/bvmQw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Thu, 2 Aug 2018 07:43:24 +0000
Subject: Re: Commit "new primitive: discard_new_inode()" introduces a problem
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
 <20180801151937.GN30522@ZenIV.linux.org.uk>
 <96e3c195-aaca-9214-0dcd-5c2b970a72ae@virtuozzo.com>
 <20180801161151.GO30522@ZenIV.linux.org.uk>
 <20180801161648.GP30522@ZenIV.linux.org.uk>
 <31fa5f9e-6378-2345-777c-7deb6f9a2d19@virtuozzo.com>
 <20180801163408.GR30522@ZenIV.linux.org.uk>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2df86b53-3db4-6ca8-2b81-8b4d8fd78628@virtuozzo.com>
Date:   Thu, 2 Aug 2018 10:43:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801163408.GR30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0010.eurprd07.prod.outlook.com
 (2603:10a6:203:51::20) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d29c8d-39b8-4afb-bb51-08d5f84ba0ee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:lmaftpqGEwqIo5WHVXyDoISzEkbiJnluw/H5m0WSvUQeo3AyIghV82r07d0DrCBznychJc40cZnE1D+eWoTJuK2dc7G4FF4KcYCLSf5SGIGNC3nUvvSiLI8ol89+cEzehnxbfsLvGZ0KC+Yr/shYp6ws+HtoizKYK5skPVd5AhaUL44a1BwMykHitdXMYU3JJwmuJ6MhnouppbLUjcZ8kzDgUfckp1mn3SNU2MOZAAoShHqwiMB9VdLvZr5aXuuh;25:xy6iTIpPl82qpjY+XVExId+5XjU4fyssnGHJ91O/ECk93k5za0RzbCT0OXQcEyCwWH9gfJBhr9LUXw1DUh4wIQHLyN3LPLhWw33CMGoOhNuC4+H/fjICPHKbzodpKC/Qp9k5kpwnMiUKPzcOinBmkQbyNj87IXf8BceGGqtyVkV+6aHlWU9wtFbu0JT4X6aOJn1Tq9IYC61yUmJejWwQeLBOK0/nrFweVlbZsv+NNs+rexqlRUASFNOmz1trxCS3Gptr1nGgCyF5u075/uabGzh0BCGoUK5u58Vuul6GlS1zhPxRBgac70mZgTSanCX5ahAP9JBGdnBLi82vXvnULw==;31:wQKD3bOMqSK0wriqoTqE/f9YlOqzClIc+spHMlgJ99nNgzqTbudIjkZKfF3gafFmRODllAyXtbglWwkgvBovy9WYnz79WB3doE50GRnlLDzpJ9p5EZmchdlP8bxlANNAyUgeaXMfbmxbuU08F0HwXLMwil3nijTNC+7v1f9vSY8oF93yOf0BJpX1EqkFloqVJqvqBx9EsaqwcUcW1A5P2IkjbAecBE0r3dub0tBpEJI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:onldceHckzQdfydXiN1MweQq8PUEbRPOmZzgeW0tId2wdQW1OYOP2EwKceX3kDmgvKKE66tQ3ogGxe/pS3DKn+C5MkeyC4rvaPMTNpcckDs24NNgQJQcNWXK2j7Nb7ZVPMoVzPTdB5JlEXKEtnxePktElWknqwdVcH3JgRiP/CO5M85PPxLbagmmW4Obm7vLQg73uOQvcmDVRR7X0w2ghuQ59Z7kKqh1g5V9a18Mq8MH37cglpZceZCTg3HCAHD/M6KbwRxiANnhb3kvEXNHwdqjT0RXqEOgxsT5lNRpiQbUwo1pPHb2ttAU8+c5uquizRULpMuTEuvm86DtQIzNV5GvsZQrMseaX/C09L7wdSlWrx2pXS3f28LF1wLv1eLOw3H4VVXlJQHh4x2ybo8w/TNyF5wTwmSft6IlBaOMhSYJDE8dtCTPtKPbYqdz4qDa0mlIF0yBt7xfmKaHG+2gCFHSCKG7eKhluQhoyI9PgllbzlawZywfP+77Wb9FLHVH;4:ux9aoejX8TThcUW25A1U7wEh+kimGsa672haUtJEnIB2j98cjGmJMuDcxtj+dqlI3jNxPGfYnOzWcwaiLH3KLOJ33Qs31YY1whL4R3HpUkJBNgO2ljFEtijbAreqxONyjQF5r2Ror2Macj6ksgRnVWpxJDfB0SihzH9hTiTpLiI5c5ahvTqX9xvw5bd9/bmYXPs/j+RkUo27P8Ts8iqMetMAm+4tF9dTxWo9rBdKXIapEzXDGSiWxVXUPDwvr2jHw+C184ZVH9K5jkAei4XvBg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2026CA89564C4F547220D81BCD2C0@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(136003)(376002)(396003)(39830400003)(366004)(199004)(189003)(106356001)(6666003)(478600001)(5660300001)(186003)(446003)(77096007)(6916009)(68736007)(97736004)(36756003)(476003)(64126003)(65826007)(11346002)(316002)(2616005)(486006)(58126008)(16526019)(956004)(2906002)(6486002)(16576012)(105586002)(81156014)(386003)(81166006)(8676002)(305945005)(7736002)(229853002)(53546011)(26005)(3846002)(47776003)(4326008)(23676004)(6246003)(76176011)(31686004)(52146003)(50466002)(66066001)(65956001)(2486003)(52116002)(65806001)(53936002)(8936002)(54906003)(31696002)(93886005)(14444005)(86362001)(6116002)(25786009)(230700001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6VkhnYmlpT3YrWTdEYTBIa0wwS3ZBNEdm?=
 =?utf-8?B?cW5LK0kwc1BYbFRzRWhTSDgvbnJvblJ1elZzaHBaV1BETVkyL1VvdGN6VG5U?=
 =?utf-8?B?Q0x1VVdjVU1MeGlQSW1FWWsxQk0vVEIyQnZPV05FMHhRbVBiUHcrVXVNRzFp?=
 =?utf-8?B?aXByTHhxcnhXeTZNalI3TjhGdU5RNTBqazFtRk9LKzV4VkIwdU1INGRYNHZR?=
 =?utf-8?B?dGt6THQ4MzNiT3lCOVZ5S1prMHJpQUJIdUMrREJqcGNITHBPV3g1U0hTdlB4?=
 =?utf-8?B?SlYzWDRqN3JnRGoxcFN1Y0ZvZUhuUzJFcUdUTDhIZzdCZWJjVERFMXh2RnZs?=
 =?utf-8?B?SnRDTE14OFdFRndJMzVQWm1zV3NFZ29SS3ovWHorSUFaNm9Xak9IWk5jMmxo?=
 =?utf-8?B?YUlVNWRTdCtvRjFZelBGaVZzTmhKNmdkcXhKMGxISjlndEF1SzgvWUNxT1hO?=
 =?utf-8?B?L2hGaG51TkNRVVpJbjk3LzFHQllhb25MOXhKTHljajdsalM5WW94dkNZVHRj?=
 =?utf-8?B?V0VxcFBoQmhQWWo5ZjQ2M1Z3MGdPNGRqb2JRRFhOY1BVenBSa3BYSmZaZDJs?=
 =?utf-8?B?b3hnT09ZR2tmTFhjMlZLNW42eFZzU3lLekx4VmEraVFMdEVYNHg5cHVlMkJv?=
 =?utf-8?B?cFZpTWFndDVVL2RYakVGQWord1JsRnF4WVFRamNmQ1MzdS9IeDRENk1XUWJ5?=
 =?utf-8?B?bXBUN3FGbjhQeG4xKzY3dDVrRE9ucENSZVhXWGk2VHdtYWc0anU3b0lWSi9S?=
 =?utf-8?B?UXVyVExXVGFycDlRTHhjd3BubTQvZFN4SkM5Snk2NHRuV2t4aEFZMC91Nlh2?=
 =?utf-8?B?ak9HNVNHVmlmaDBNblEramlqOVRyQmY4aTFBR01WeDdXTlNxMlJySWsrVVFB?=
 =?utf-8?B?bEkxVXJId0pNU1dOYzY2NVpOcEhMQlJ6MDlJS0prUzVhaHBaeVErcXpsd2NW?=
 =?utf-8?B?QkJnU0FEK0pqaDU5SnlFem56cTkwa3FzQlRxbENoWmgvUzR6WDcxZmppNHcw?=
 =?utf-8?B?a3BXaUNYTFlVMmE4dDRJRTRUeTJsRUJYYnl1ZVZWdjc3WVFnbHpQSG9MRmVp?=
 =?utf-8?B?Z2JycS9XaXdMNHk1YVBVZVo4cUVLQ2tyQzJKTCtERlR2dlNGODNlYkVFOWM0?=
 =?utf-8?B?RGRubjk0MERVekhqZG5qYlBkVUI4eTYrU3pzOXFKRjNjRkc5a3ZKemx5aThB?=
 =?utf-8?B?OW04dFB3b1lGWTdYK0V5RWRHWVhaOG8wZmpoajY1d3U0aDFDaHYwZHpUenlQ?=
 =?utf-8?B?aWpoUUtLc0VEc2IyTTNzTTJXdG0xQlhDN0diRzU1MkNoRXdMb01Xd0lEWCtM?=
 =?utf-8?B?RXhEUW13Qll3TTgvNXFuVnc3czJMQXg5ZzE1bHc2UlhMZ0grTVlhRHROc2Fr?=
 =?utf-8?B?ZlhzYUV5U2JUUWxoZHdualFWR2lhSUhpYmlnR0U1dVY4OWZkT0wzc3NzbCtT?=
 =?utf-8?B?eG54UFMyTVJqUTJPRUkxZmU5RWU5UUtnc3JYajVZbm1kTGJzWVh6NmtJWXlH?=
 =?utf-8?B?bkcvZWRZMTlSd2NkR0E1bFVPTXYvMDhtMGJsZ3lpOHk4d1c0SGNoeElFZ1Uz?=
 =?utf-8?B?VjlsMVB2Mk9ydnZQMmpodjkxTlNHYktZc2hoRm5YNWt5Q2ladWk3YlZocjBw?=
 =?utf-8?B?dUZWaTkzY1VZb2ZQVTM4U2dvY2s4VmVkampZc3FXVW93T3djaEtjNmtidUZH?=
 =?utf-8?B?eXpxRW84SUEwQUEraWNxSVJ3L3RvYWFNK0RPWHhBMWJJdmxXS1NwYXpFSDM3?=
 =?utf-8?B?aVh1UERyc0ZjcU5yQjh3MGMwNHp2ZGEzRUZ2eWxTR1V1aDJ1TmNvVmp3NFB3?=
 =?utf-8?B?bWgrbS9ZaVJuSHl0TFpJaDlaZkZIVE9zSkxVaTVGQzg2TzdaanJhM2wzMGc5?=
 =?utf-8?B?WER2SFd5OGZPaFpEeFFkTHFVa3BFbjFuYXlycjZIVVZoNGJZTkZjZHh3UnVE?=
 =?utf-8?B?UFNJRGhZMjc0Y2o5MjlFUWFjYXZkV25MY0FpLzNsM3E4cWVZeEgzTjlPTnlW?=
 =?utf-8?Q?EXoWSQ09?=
X-Microsoft-Antispam-Message-Info: +7Wrq1Dza16beZBqrsKICA0RYtDox5VuHaQsDfrwD7M9PjgLTsXtL0VVEZQgyWfIMTCnVKiOEBy2F+yBsfNUUVXgfz97AwRh59ORtAkev+e8tdx+DEeHHV7U75dPe+KpWylEGA4XQoYiCrRANsBTimiFVmOcQgs0NWq3NIohQmQsJt1EO3pGpei+s1osf1XHsXGQABR/DWOeNZrMowJvCycN2FVgT/g6Zp6XSUjGxag2a37UwE3irjRHPBdc/X5Cym61sTtbg0zJ9c/xOpTYfQ0m1nq7H1epLjc3fQWi4kfLcVfw0HPa4b13BiCBrFtCljUXLKaYmtw1tRwiCyxNrCRPu+pYCsE5iOQJ7bcIOjE=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:j2zSmOj9G8QbNMZAgJsCvq/T2rWXKa8jP6rh7SDtsyu0FokWAxY6djPRvLUsrZEyI5Uz9W3+LCgfmNFTYVMIgVumtOlaP7GuInmIGfm5/dkfamRmz9oPDkHJY68mRXPrhfirPqj9bWzDa+yzXZB3ACkP7k5Qc1TUm7FS0bInylQEtf2rMgt5SVwyc+YtXSkAiVdeoOmufnWsoaITt14dziSCyOqbT8FFZ9egE+XBJUlVZNiCC3eXK3EMAtz6w/sTB8glzpAJ0PnwR2mn5iCxpiiPQcuzMZAZmO7qRqvMOEQeKwBTDQPxhtRTyW3ReKq+8M7NGAzOHoIC/etkPVoNMmLiq4/i2/ylO7+0zO8oI7Wqqir9/ZSbGoe7orjzfigiq1NEot2GCQz1r/0wgiONil5jxMrmjwtuUMJZ5Ds0CCAl03FkTOIH8tjpksNdr4CXPW2uRVudfPvCU7KD3QoQAA==;5:vLD3xubO9QQhaTc7WgCsKG2kmTgkptxrh3nsLkk0cf4+pUq600qlvQH7J5prUrtgAgE4sOPFltBHMQCGCNLl7kFoFbpve1m80hFii1krBf5YWU66/aZR5pDUH5UG/+u4YNqeOuMQ+27Z1LW27ssfb+1PBfv82kzx3GArDTZKCrY=;7:VbA6mhpub6wEBcPIYhbHEj745z5169K5JsQFe6Xi0PiPY3lGdeEunYvy3s59wIQW4RTRvZXZ1sMGkUY3a2ZlTxmcEwfQOdj962os3+6framFZ+Vpf0YvCZKw+V6uPTnh+KfMFR6wJdPHUPrAuWPq402moqlW+S6Ao+Cc4EF2g9nQ3IWlxwbGFooRHkKL54jOtybJdZPZ4cpBxFqh8B1ZkDjb0HYdij3ML7fGeNOlk8jraOq6g/IEu68DLxQ0iOcD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:9kjDFmzkrR6LPnHqRMkYJHm8HBJ5S10Rn3uLPDcGmUns8gE7awrKye3Y3qE55WEQWVarVZjhesKuaH3oL+XdpKBtaSDdQXL0t4i+S2YCe9nWd/P1x3V36as/LYyEcRsRxF/l1DuNGRUQihXesapXiVRXfFH93PZ7UI8QubI0qy8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 07:43:24.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d29c8d-39b8-4afb-bb51-08d5f84ba0ee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.2018 19:34, Al Viro wrote:
> On Wed, Aug 01, 2018 at 07:19:35PM +0300, Kirill Tkhai wrote:
>> On 01.08.2018 19:16, Al Viro wrote:
>>> On Wed, Aug 01, 2018 at 05:11:51PM +0100, Al Viro wrote:
>>>> On Wed, Aug 01, 2018 at 06:43:56PM +0300, Kirill Tkhai wrote:
>>>>> #git status
>>>>> HEAD detached at 22dc9a168272
>>>>
>>>> Wait a sec - just that commit?  With discard_new_inode() not even
>>>> used anywhere?  Then any of those -ENOMEM is disguised ERR_PTR(-ESTALE)
>>>> from find_inode()/find_inode_fast(), i.e. an inode found by
>>>> iget5_locked() (your /etc is on ext4) with I_CREATING still set.
>>>
>>> iget_locked(), that is.
> 
> OK, I see what's going on there.  See if this fixes the problem:
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 0e8e5de3c48a..b11f566bcd66 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1892,7 +1892,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	__d_instantiate(entry, inode);
>  	WARN_ON(!(inode->i_state & I_NEW));
> -	inode->i_state &= ~I_NEW;
> +	inode->i_state &= ~I_NEW & ~I_CREATING;
>  	smp_mb();
>  	wake_up_bit(&inode->i_state, __I_NEW);
>  	spin_unlock(&inode->i_lock);

Yeah, this fixes the problem.

Tested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
