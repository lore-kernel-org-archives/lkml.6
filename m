Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12262ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EAD20858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A0oG6w47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EAD20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbeIUPNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:13:02 -0400
Received: from mail-he1eur01on0137.outbound.protection.outlook.com ([104.47.0.137]:26051
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeIUPNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWOHv8srcQQ69ozPjE4d5C43VJZ5tud/d76FX3YiWuQ=;
 b=A0oG6w47tgJrvJnC6S6DeDwbKlX7A+3BMhdD/2LjtHm3VaOioUrDPpW7KIUu6yr1xWzTGUYr9ZlnY/5hUhQUDfdzFWv0bfmb2d2JIOkLZMqdoF+T0FXFzJ28ZlizwZfcsrN1f0hCpyTNuDGvyLat9Nqu+EsXio5cCoRW0nmBNZM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 09:24:59 +0000
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180921001513.12504-1-Jason@zx2c4.com>
 <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com>
Date:   Fri, 21 Sep 2018 12:25:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To DB7PR08MB3257.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13fc6c31-3a12-4c2f-42eb-08d61fa41ad3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:TW1dSRW8+lZLk5NIetDPJe11YDvIGVr+lNFC2L8gwPYJDPy19bMhkRFfGwgUshOHefKguI5J+Pze3P3Gzjx05cgfG5DFD/N4u5/mQdMLXtbUOjmWZGgtnRUaSkCE9xbZe3R7ROvIZakdWSPcNkfAC7/by36ZhsEBZMSZKPlUo8EvjzOIUb5mwDp8miSefwQJiEBTvaEb289rt559nhucBdBSy/48dudLRQTatL8I4GhaM1DO1IehX8opuLlB2H/i;25:hHo3BWdy/vbP92wYj8RVkRqbhSDGqg9S2qEmlru8pDX5RtXKAYs0wJcKc8yao3+SfAvAuWsQhouQesHqwuCUifhA2SwaSLwkYrjaD3pE579NC0Y5rtn5mcGVe0EZ3855WGGzG79mhtQAndljjAcr78UFKrsaop1DkrFAQd0TtWBoQBSaneKDvgGlspHKtXM7g0eSY55M52stj02sWLzb04Oj2QZZQHobekhiOqz3F60m8NiDKq0/meLnNJHSumfiEE9FV56jP/2go0VyfZtiYuhOc4RY7SvStc4lkHG9tRlXd/b5BJYdLCIICkbRPepXQXcN9wHeMXjWM1JGHFAGrg==;31:2p8nBR+jChOBqmLiloWRcSBoGeOBAXa8sMhCzlF8W/7vMPavSufhgfOyVDueMflWeSrfR6VuG8L2ETzKyK+WdLeyOcDZ5yQ4halFUKDdSEXKpMAC/TG4Ci+gbyd3tMMaoC7Q5aXFOkZelWhiwJlH0nRGj/UWuPobAx/tjJ5g2Ig3uguSFKSw5jJsJj06PiYEUbw1pzpdwc59ovFMBWp505SAYI+80/JVFWWAlU7ESQ8=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:eFzQ8TIhujetsK483O0u39TUAtlMVBRUBF/fReQASuTF6/LlDKkHOBfVHSxDoKD/kmfRY+KZaHGcZsqvdZxsn1iQp4MOhVJFUHIztuUhIsQdpCSemUlpLaDqmo5wg4anzkWM3dT8aSc7HhRUHZbVbdKPsWOGDVbLHEfxP/JwowAe4ILuy6XRTm2cjMKeBRA/D88daXxfTbtP5kXBvF03eqPr6wHcpJbi+vGakejj65bjg0Fc67726bdnYRcewvKeGZewHChNDT5ezIY9lIT1drKfsZEo5Erq8GeW3HIAJzBQspRACHkG1d0njr3N/Kk9qXeZhLmjKxfcXuWdV3xDGWODKTWT03qdQA9rOkOy46hqOCZMC6A2MWgxr5D+kKbFw4qgoq6BeN3y+6K2cJA5JUuPmCo0od8HztbZ4en9ZPJpYplcSNJwfmk/Yp7piMNJM0uLz0ywKU+D39YuO3M5uJomRspfm9PV9QbkmIV3TcuK+Fslreaictk6djy/UVvr;4:1n9sghJgzBGRvbQhZw1yoQmHv/7e1mYW9p7kqYAskvvjN3AoZ4Rx2lhGzEPABH20eltEs/fMj7BK0BnMxxWE7CjZednxkJfCv2m5rsYxnmk8sLda9ucKTYyHFQd/9Tudxu0wSdXEkQ7qhTmB6EfPQXzkzJPHgPrq8zUOOSsewdf480TI6qO//gAq1kaJ9SLlI6/Pp8/lRRapoiKsvvzPPDUInkX6K8jPFjtnXRXypWDWc2ZVvg075cmklZqQtW4VvUF09mkmiebJ9BzrOtqMJA==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3257D13190A3946DDBFC0711B0120@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(396003)(136003)(39850400004)(366004)(54534003)(189003)(199004)(16576012)(110136005)(8676002)(486006)(446003)(53936002)(4326008)(31696002)(68736007)(3846002)(6116002)(2906002)(6666003)(6246003)(5660300001)(956004)(58126008)(2616005)(86362001)(50466002)(229853002)(305945005)(97736004)(65826007)(65956001)(66066001)(2486003)(77096007)(11346002)(47776003)(476003)(64126003)(230700001)(478600001)(65806001)(31686004)(106356001)(105586002)(8936002)(7736002)(16526019)(36756003)(54906003)(81166006)(81156014)(6486002)(26005)(52116002)(53546011)(186003)(23676004)(25786009)(52146003)(14444005)(76176011)(386003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU3OzIzOmRxQURuNy9GQ0JxTzFRS1p1NWx5Y2N6aWRr?=
 =?utf-8?B?anNaVkM5dWRoNzl5TW4zM05IYXN6MnR1aVhOazlmVEJBdGVDSitYaTZoOUhj?=
 =?utf-8?B?OGtMMmV6dUUxN1ZKRmhsa1pPZXR4OS95Q002ZG1QWlVESVUxL2pJSXVoQ3Fr?=
 =?utf-8?B?VmZnYThWeHhQZXlTM3RXL0dhVzFIWTNkS3U0TVN6ejNyYWFjWllZY014U3NX?=
 =?utf-8?B?ckhwV3IvQitqa0s3YlNzRlN6cWJidFJrcU9kWlUwTExqOWtqMWJvcTZIQ3d1?=
 =?utf-8?B?bTJoKzJjcklVSGFMYmU2cmQ3VXZTRjdrZ2NVNzdsclljZTJBUnBlV016ckN4?=
 =?utf-8?B?SjUyRllsZjA0RVovQnFCT3hYUDRPYlZwWXdVTERmM0RnMjV6ak1CSXUyRmht?=
 =?utf-8?B?a2FqVUh5UEhEUmRrdkF0a0k0S091T0FZc0I5YmJyd3YxeE8xYTM1WWhHN2Q0?=
 =?utf-8?B?bTdNa2tFM1BHaWpmNzFaTlEvd09FZXZSQUFqRnZLeWQ3b05ob0Q5RTdZN0Fw?=
 =?utf-8?B?UzRRcEdrWmdIbXlDdzlleitvNDY4UlUxaWZUMGJQSy84WWRhRGlXZnpkUDVs?=
 =?utf-8?B?TXBJajJMOTFYbmxFNTViaVhMblJHSUgydm8xSWN4V21OK0JybHJSczhydThr?=
 =?utf-8?B?NEo0cEE5NGJEV2pkWHErZVNDMG1wRUxlTU4xMnBLcGllbkQ3T0hRU0pWb05L?=
 =?utf-8?B?citXU0FHWDJDdkFzaHFxODhTWlFnbUFhRUhGUXFta2Zyb0VkMDlkMUhVWmF3?=
 =?utf-8?B?SFd3S01vMi9mTDdOVGgxU0I3MzczTEhnZE1Fbk1UWjdySTU4b2lQR2JVVUJz?=
 =?utf-8?B?OW1Xd0N0RjZQKzhiMW83MkJyYmU3SkprdFlmY1dBSHZvZ0tpRXVQSlNhR1h3?=
 =?utf-8?B?QnRuUE9FeDlaQkxUSExuWkZraXMyLzRldGgrR3N3Sm9LVjZaTEJ2R2pIMDdt?=
 =?utf-8?B?Tng3MCtYdFFXKzErd1ZNVERNRW1SSDh0c2d0UkVKcDliamNvQm01N1NlQmF5?=
 =?utf-8?B?bGRMalNBVHhCdEVjVjVwQXpLa1FrUzk1dHFMUTc2dmZHYzltYVMrZHhXQzJH?=
 =?utf-8?B?YWE5SmMzTGJ5TngwQmQ4Mk0zQ01ZelFGSFZMRDNQMk5BVWFyVUtHSHVxZ2hC?=
 =?utf-8?B?ODdJQ0dIV2V0ODUydzVab2h2aGxHdk9GaTJqd3pMaVBWMHRzUE04Q3R3N0ZP?=
 =?utf-8?B?UEFSQmJ6U0ptVE9zVHJFd1ZDNlRIdzhVamNpVGkrSnQ5aUptTHBFV28zTXBt?=
 =?utf-8?B?TkNabWsvakdRTU5MQzFsclhOZzVYWmZrRzZoNjJFV3J5VEYrMVoybzE2eXBq?=
 =?utf-8?B?bGhxQlpMYjdXL1E4V1h3Z0pUQ0FXUUpRc28xM1NoY1R5amJxVkpvTElzdlps?=
 =?utf-8?B?RENwK1RsVDFEUGZ4ZDY5eGRoT2tTTkVUL0s3NkY3Qm9xQjZnOWFQbmRTRzdZ?=
 =?utf-8?B?MkUyZWpoR0t6V3NuaXlTWUpHK3BPMlVoc0dyeWM5K3NWQlFWY0hKZEp1VTRS?=
 =?utf-8?B?alBacktENy9xSnJsRnBNZzg1K2x0WEVab0w2VStCM1BrU0N4dG1IVldOV3NV?=
 =?utf-8?B?bzh4dG9LVmFHRFJhazBqWkMxeW1ETGhjOElxVDhOa2draVo5NEN0di80Z2U5?=
 =?utf-8?B?VHhpZXlNSXRoVVpMYlB3Y2R5VlBQOW91UGNQbW51SDV0a2VUQ3ZoVWdJTk4r?=
 =?utf-8?B?SUJqejkydlpwUVJaZjQwcGM2NFZkeUk5ZmhzUEYxUCtMSnVYNlU0bk53WmRt?=
 =?utf-8?B?S0tTQnhmWGNYTTVWWDB2WDEwaG9IaXBLNU9JT3V5a2xSWXZXdGkwU2grbUFy?=
 =?utf-8?B?Z29uNmJYMzlxeU4ySXJqQS9vODZFWFJBNEd5UEpSayt3bkp0SVc4K0RnV3ht?=
 =?utf-8?B?K0tITEZYdzF5S0NuRkZ1QWtPSVU1UHRyMk1EcFNvWkJCWDBOTXhJR1RGMFBW?=
 =?utf-8?B?WWp0dE5pSzhGT1Z6LytxMVVnQ3V2MHpldi84Y1ROOUlJV2dVUDRsc2VsZXN4?=
 =?utf-8?Q?l2A3+7?=
X-Microsoft-Antispam-Message-Info: Usi4h1nkkIiTTPoC+AiCQ6p9ZsorgdFHG84NbXw14FEdKgVp44OtS8nAQbo/jHaW1d3duMuVlKTVJxwH+K2xAVmulYu0bgqxTFTa/zvyYJ1OtrmmUsacW/Q+11HWlWD9+Lsa7WLY8c0JwOy/GQNgr82mDJ85UTqbAVvLcbO5PDh2gcEADDqoie+oYnt2nMbCK/x/QZ7O9DwaTZnd2C3InFCra9M525nwq2flvre6I2O6iQR+Q2zTKuvltNoYYCHGtkvy9SIoG6EclKEbavkHPFrTt2zzRnMaqq2L2mK7nhz4ODOvVrVY6+4EQiUZq91zw9dUp+k8LxZdtOhhbv1m12MUKB2qz+B0+9oYebpc3ko=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:SwEjGTURyFOO7xajUUJ+nKiERQcWNkeZEtdWD/M+4dAocxIHSUc16iSjf25OrWcOzFRe0b84TYRfy6i8Zv/4Wr8tfMs+wmbyAmYoyv1nIOjxKUg8LQf5DxL8r2wWD3byncA0Erb89veP9cmtYKLaBs5Psfsv9M2gQwKk/TVUw+WGX93MZGsJ6LTMBtizF9C9DAKFPO0i6xa4PqduezpG4N53/JkQ5wH6OzOVmePxbm3pIpvD5HYfEOmRatkWhiO/6ArjSuZ1uiB9Q/pxWBxeMm+2x5UGULHnH2Upo2h9X1jsH1VkyQjb+GJ8zSVuzBiAi29lHgzAS1jUDUQr/noWoMnZh++cEJ5SLu4IC1XN8YrH2yFwBKAqdumMzAziZP8/VlBnnDwCjp32t1G5THVxrhGMUC4mBAKQyoNUo0xi2qQaTysKF8NzFQGOV6r6U1w/asEcz5ffreXx9FUMgie4iQ==;5:+vGhQyTAc/HjeA21O3+k4ml6VhAVsquzSpaQd1CPXlp+IHquVBKUCFWKydSD0Kxzt0SFRxvojR3CvSB9s66ICjSo+tGNbWInJEQ13Sb0/+ijSMErw4E4n/A4tolTeWFc6Wk2DWh4rQ8AncvDo5yOx18jg34gMiQd8ZHmfvC0cLU=;7:8NU3bGf3037beipfBTcwJrfo2eggGBOd/gUe5ZS9HDL+0tdMB3HDRkCZHtMcPMCDfHtIplPDQjghVM/7n+qmshPBznX/cJt6ha+ILbcizZ4E43kH0dBktzF54am+53DNxa5YRYfVUV+cPU0surrpeV6qXn1ODKmtmWi91+mgHo5I6YiaGlDnRGrTcWi8HPw+yxbezL03kgyjaPyA5oWZSo8VkoBUOvavigKDf+y8YPR+SOxg5J6FAAnJOKj+dnWG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:f/rEgFLgHXzLULI74lKh2hgcpdJIMEj3dCs7u3HWSsYStiSBG8ql9nQ/TDy10DKjxtYFJxf6l3lZ4vo+CfMT+w3DxMN6SymVoKVcvq5OfFp7RBvpoM8ctACSK4lYdhy0WXQhSDddzblGJb+zXkKPCJoGlECrcGPI5uYQ24Zz/Cs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 09:24:59.6088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fc6c31-3a12-4c2f-42eb-08d61fa41ad3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2018 04:50 AM, Andy Lutomirski wrote:
> This patch seems reasonable, but you emailed the wrong people :)
> 
> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> It turns out that KASAN in general will bloat stack frames in unexpected
>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
>> default to be associated with KASAN instead of KASAN_EXTRA.
>>

KASAN_EXTRA bloats stack more than just KASAN, that's why the limit is higher than just for KASAN.
If want more details, tead the changelog from commit e7c52b84fb18f08ce49b6067ae6285aca79084a8

If anything causes "stack frame > 2048" warning for KASAN we should at least try to fix it,
I mean reduce stack usage.



>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> ---
>>  lib/Kconfig.debug | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 4966c4fbe7f7..39078a080e29 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
>>  config FRAME_WARN
>>         int "Warn for stack frames larger than (needs gcc 4.4)"
>>         range 0 8192
>> -       default 3072 if KASAN_EXTRA
>> +       default 3072 if KASAN
>>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>         default 1280 if (!64BIT && PARISC)
>>         default 1024 if (!64BIT && !PARISC)
>> --
>> 2.19.0
>>
