Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A14B2482D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d+lfGGtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A14B2482D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeGBRVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:21:30 -0400
Received: from mail-ve1eur01on0092.outbound.protection.outlook.com ([104.47.1.92]:45334
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752069AbeGBRV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMcOiwRVQd7nwJ2imUpAohWBJTZ/iUFXQ1bOpMrEYMQ=;
 b=d+lfGGtnPXZJd8dJc3FioPTOZBH1WWF7K9nrD8RtVJ0bY40pAv4roSNQAkXjAFfDIWl/eNBUwtDcW6FJ9epIJitTiTzowGZO0DaIJ/EFojvk9bDvs2ufZNlPbIr5R/KA1ZHJkOrWs7pkE6f30iVFSPFPNMQGQArbCd49BJH97RI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM0PR08MB3251.eurprd08.prod.outlook.com (2603:10a6:208:5e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Mon, 2 Jul 2018 17:21:24 +0000
Subject: Re: [PATCH v2] kernel/memremap, kasan: Make ZONE_DEVICE with work
 with KASAN
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     david@fromorbit.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, dvyukov@google.com, glider@google.com
References: <20180625170259.30393-1-aryabinin@virtuozzo.com>
 <20180629164932.740-1-aryabinin@virtuozzo.com>
 <20180629193300.0ae0f25880a800bd27952b15@linux-foundation.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <788aa605-94c7-f730-6ec6-0eac53cb10cf@virtuozzo.com>
Date:   Mon, 2 Jul 2018 20:22:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629193300.0ae0f25880a800bd27952b15@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR09CA0051.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::19) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbccd491-f3ba-4318-2523-08d5e0403d03
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:JJYcE14JRQcUvFvfEUliZfbjFq+aUdWhsni0Anlcf5ZasycV0wN8kRM79PCyEaQ93puq7KW+4nTIEXtsoF8dn6AS1xWXJLu2+qG+Qc0bzINYdWz1BomXNbIgPbljYbqC3ls7+B9bSB9D59RcD+Z3PrgosefEUlIDDxP5jkYo//leMmYZ4z3zrzKxL8qssWsW92a1qf8+wWPgrTl8ETpP5PFLIDd4WPh389UVh2PBDZwTM+H2ZXYCDIVOJo2s34aV;25:+UvKKJ7r12zZb3hDVs/mwPB3F6XnSM7TJzqwg2sWtrrxB7G0qZ3T7WGPtRWMnyXZcl54WXspcyf2OHF5xRoHjPIzWp410F9rUWDhD+EDCbzPkfWzurmYCkqRK3rnBdme8QBxVACyt/R4NcQX6nLdVAQzBj9rg1ZkahFJaK5XIM4/LkP1MH37gz2w5IV+JgDKgmiyeMmglUj13h1zRYfYxcG0V6ZuV6WDzgnwUTBlJ8GNhfMP+E1Oc311hOumNJx6kM2jGB7yI2BZ2Ts3P7uPqy+Vw9xOXQ57/pMEUyfyaOStk5MLavtpP+a+h6hzTRIcRpLO9YYQWHqFTR8RTM9oxA==;31:HEwWAy9QnXMka71V3hd1YrwZ4P/05sQJVFG8vacUktzLC0179DosNnEFRpv6s0CJvULJfR2g8sbRrfgWnNwb+jfDF/W3Y1lBYaZEnmwLzD6tYXOQ1Qq2R1S/ojK3gYGtlXpJ6P7lMm9hk87b2okn3pPMMq/EnxJxnqpIHTEq9xfiMspdUU0Z6+o2TLHPZSxchQZQ/HYn2laMFOcbzfuO05pvC3cMs6v0T4NkDUQequA=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:3rurZOdrLv0zBPKVx3TCfvy1MmvtBUsGQVzWc81Yp3DPDeF8TnV4ILrqrJjekBKycP0Ca0BkcbbgVhs576qkEuhWlepLVnvfzdQCKvRdqo8Gra1hR0PDiJovT+OfDBapOsoP2EXGXSTTsx+p7/u+PqB+KXlQRIGB5Jnw5R7AXSzIlBgKBL6ACaF5D/GmnSwpX3ClSPAJEhAf0GHFeHFPkD7DM4FGx6ReqgsaH6lUEhgCI1PQN6QZGVQbOxLYsynAaaJb96eeLtvlWMsvQGEPtvPiVgVZ4aGiBFvx+5GLqZqbP31I+KI4s7wyJlLjDXNTMxl6LktI5yAPw0gnGUptq96k+n4lCXqnI5OwalEmoDBBt2fc43GwmhEDk/NMQnOIHk8/aESnQYl4mhRkCShG9loUSKQM0wGC6L640jENsuYoi+oHIVkEQFzFJVKiONCMrm0Laij0cqS18Mn4c4QWd26zCpczLwoyYgMzFSian9lfO3xGzA1GwO1EIJkk2yKB;4:Rr49ZLsuk3dZ5DRK5GPvZyvP2wXLw2JFRU2jX3LqNj8FbON/7U4vK2BVgiESx/bzYVc6Dv7o9zIUWA4YxZx/CXEwliHU54X7lopKAFlhSW6HSPeYADpPOyJt7rX+BtnsCFouy/lugnbJr1vlusgWPctlTXznlmi9MFOggSrLlFBxbDkqPY6jjRY9fZhaXovPJRHcAadiK4lRBjBRo+WqIs5v0t019uYANeHPg9d5ZRsgFDx/lxaGnBW5htwqyuoCh2pJgxRphzZRL1mRyWwnypp3tCzoRsQ8xqOzbIPtkjlk14adJGYKQav9s/a/hTLPnSRbjTHLXRfRjZRCC9LIPLTKYU7k/2VK7reSI7dJXrL3SRpOaWzJiTdjUwExxOwv
X-Microsoft-Antispam-PRVS: <AM0PR08MB325134D2388CD6E9117FBA78B0430@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(136003)(366004)(39850400004)(396003)(346002)(189003)(199004)(50466002)(86362001)(64126003)(52116002)(2906002)(23676004)(52146003)(2486003)(31696002)(14444005)(5024004)(65826007)(6246003)(305945005)(76176011)(575784001)(7736002)(53936002)(53546011)(386003)(6916009)(6666003)(36756003)(4326008)(5660300001)(97736004)(81166006)(81156014)(106356001)(8676002)(47776003)(11346002)(446003)(26005)(25786009)(478600001)(58126008)(3846002)(8936002)(68736007)(6116002)(316002)(230700001)(77096007)(476003)(956004)(2616005)(486006)(16526019)(31686004)(229853002)(186003)(6486002)(16576012)(105586002)(65956001)(65806001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUxOzIzOnNtdG82ZzRkR3lEajVUa2VLU1Y0OWhsOVln?=
 =?utf-8?B?a3ZoTjZlS3VzbXM5Sm9lSXNxOTlrY05RN0tScE80dk1DRDNhRjByVjVXWlNS?=
 =?utf-8?B?Q3NKTzRFaUU3OGFwalp4Vmc3UkZvOXBxNGo5QTNrSjVUMkFEZTF1N3BFSHRJ?=
 =?utf-8?B?OURkSk94SGJRNjFkRDJMZ0E0cXlKelFMeE84YjI4YUpEZjBlaXhiT0RyZUxO?=
 =?utf-8?B?OUZMdWFLNm03Nm9VeU5oOXVRZ0lZMU9oOGVvd1FqTFZGMzkweEJtWHczczhF?=
 =?utf-8?B?a3paMlliU3ZlY1JNc2FYUnpsSlRDaGdBV3cwbkxIT2dEdmx2Y1dDWWV2b1I1?=
 =?utf-8?B?ay9GTlBBS2RET1IwYVhkNmVBcmJTS3Fqa3BaTGJKVHFPazlyRGxrRUl3SWg2?=
 =?utf-8?B?eCthN3lkZWl5UWJMMlNTUE1la2hOcVJvWHErMy9vNzhuVW1KWXRxTGkxU2hS?=
 =?utf-8?B?UTBIMVNGNjZxNkFHYVl2UHlKQjR0S2h1QVdHdERxRnpuaE95WDkzdlNDWG5t?=
 =?utf-8?B?bUwrUXViMTdFU0g0SE16RW8vb1Q1MzNFODRlOVRzNHJ5N0xUMXBsNXdoS0Fo?=
 =?utf-8?B?U2xTdDdJNXJreE9scWo4K2puYUN4aFZaME8yOVdJNGJGVjhHUDZOU1ZwSlNH?=
 =?utf-8?B?QXljSlJDT2dTYitKU2N3YUtLRXhiLzJEVFg3b0VxU3MraHNPWHMvOGRYRXFR?=
 =?utf-8?B?RHErK0dNWHp6NzJacjI0Z21MSHVQQ092QjJTcU9XSzdxRTFMMFZSdmpzWEE2?=
 =?utf-8?B?OGZGK3Z1bHVBWHFzSlZLaWlhaGpaWU5MUGR2b3RNSmhiaGw2bW5SYUZoUlhw?=
 =?utf-8?B?dHg2VzZiVGg0K01qS2lxRnBySHFiVENzTVgvekN3REJjNzhYRGs1dWdlSmxQ?=
 =?utf-8?B?ZXduUFNsQUpuYVlPaUd6VEEzRFQzUTR3dzJpUkhFN0NzYUhyUHhMY2lpalNL?=
 =?utf-8?B?NkljeFRmK0x3M2RpaUVnT0Y4YldNdWdqWDF0QzlURmo2dUliMnMxLzBmRERl?=
 =?utf-8?B?VHdKYzJGNzdvZEh1VlN2MlI0VFMzMHdRalN4cWkrdzlIejJMVGJFR1l3c282?=
 =?utf-8?B?RFJrMExhTDlEOVc3eUpKbXVDdFZ5a0ZrUWRrZXBXVEh3VUNGSDlDNExnVkhZ?=
 =?utf-8?B?eFNwem1VOHRlU1FFV1IzdCtEaW5FRHFEZlZwUXc1eWpSL044RTlFSnI2bW5s?=
 =?utf-8?B?Tk14ZFpGSHBLOExRZ3VrNElMcFREZjRiTlhEMFFVMFRpZE5KeHE5K091Y3NC?=
 =?utf-8?B?Q252cVhXd21WbWxrdlBQWnBkZ1RLU3QrWjEybnFHRmp6M2prTXZYRDAvdG1h?=
 =?utf-8?B?R01xR2RUdHYrTCtsUURDWDVjbHh6cTBPZ1N0SW9jMjZiZ0dXOWdJTTRsZWlX?=
 =?utf-8?B?Rm1YcWN5M1BBODloZlJ5SjFiVU92SEQ5SlpPZjlOcHBicXdsMW1TMFVKU0Jz?=
 =?utf-8?B?b0JNWEp6MW9qUG5NS2tOUmZhS2VadzdGRkxwaXJDMnE5T0lyKzRhS1pjbE9E?=
 =?utf-8?B?VnBMSmg1ZFc0Q0k4QkJ5OHIrRjhFU3Fsb3ByZlQ1cVRzanBlbUZud0l1UXhj?=
 =?utf-8?B?Zk9TVUEvdERDbmFsSHlsT3ppaTVWVSthWXRxbHZ2cFFCSHZONmx4bFJRbXR2?=
 =?utf-8?B?UlBVcGZNcmtKUlcvQWRkT3ZUS3dqdGY5OTFjRVBTS2oya0xGWHRVZ1l4dDBr?=
 =?utf-8?B?WGppcHdjT1ZNQzlHSE1tMlo0MGtIbzBrS2JIM1F6U29wa1lIWDN5NENwVUhG?=
 =?utf-8?B?ekRZNi9Db2hwcmw5RzgzWFBDaXRtSldFYlBaZTJYZ1kzcVJ6aGtHNFNJMWY4?=
 =?utf-8?B?UGRsSU9KOWdMVHVxL3VrSnB4cFlYdXo2bzh0Mit4RStxak42WjdjeUQxWmxm?=
 =?utf-8?B?YzRrcDlNUmJES0NQU3ZrTDFuTU5BSSs2SnlZL0pKRlVCbk5EY0cyR1YxZW1q?=
 =?utf-8?B?TkVZbWZGdGp5Ni9rRitGN3pVTHpmQmNaVWtiK3oxSDRoci9PM2hEdlp1VTgy?=
 =?utf-8?Q?+FR3CG?=
X-Microsoft-Antispam-Message-Info: 32IsKnm9b62AsSTgZnr0BljCuk4wtMfUm3CbmyXCTR7YHydJglETyCNqLB4n7Q/RnEx74WjTMxWeAxIUSoL1fC42SsX1zwKJHi5YYaqcYXW6OuYz/25j/Q2uxQ0nckhVLVRoP7qyOcwDizMQ8QyXH9lWlS8Wqkp6SPBAt1tTEbpz7BUKXp1yfFaAnpg4J7emlAr5bCZYZcK5t7u0rJHSI5L+7mreg2xry9LZk/7q7x6uBfDsJutzXV9IIV8/FMyvp5qvBs1jGR/QE6huBFOCdd+RviyDAGELnNT4YptwPYjCygrPfFKJkAU2OGSY0qo/ozaXPHglngicsrP+jpaiKaAAwQ/9Gg70+ROZuEodwiQ=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:noYusZWNf3iQE8S/6WCntCPziQ5H6HIZcNkmL8hIyrbsr98HohLPQPHXXu6HbZboP/0ux9tswyqyMZC+nD+JAOphY+d9GevCwKfPHwKkGkUc32Cwd17Xygf4skTF6EikimC9JuikkoPm8CA/owp/umIHwjPRlzfnWmrAC9xJMfXN64P5Hkr66FhGRslKSXi+n84SAlDBxP0CDywnRPfFqqHgQQWc2hClkf41Jzrr2RTiPXdosUwGCPfZbnQO6G+70ZM4hiCMQx/knk7EZ0JHXuW2NAiKVBMWkk0fleTffUosG9WldfWZXXoUFogtT2RD5SRQPpC/f9vxQyVxRYflT5j+diRHgohpp7rpBd194kehPCurDGPxi7HGiu7UHfnEYjEfy28WZexJXGTTJIQN8ooMaDmttL4zuR2WyrIAEQAUbiZbjNq487krXzLtdn9plnTqLG9f0DTSM4SBPR6Bkw==;5:DelObcHSNSITfLahGurxcV8Ti5NbsI8wlJrgv44q2puk+ybyP3+qyEUAvX8o7Co79zdJL/HwbztqY1mP8dZ2afXgljHtetHaXUT9TtaXv4DXVMcSOXVQyCV1CO/z8lF8Z6UxhIyooTpdiGs1zKUSrukiJj4UrkBY1VtJJC3yEgQ=;24:IwhxzguqjHFzsaOxjcHcD8VjjE6nwP5BPfsRLmxe02LM5Je0n0eGmPN9L79hEGf8HbYikvJZXCLb1EzsvFEnL/iYbYaqqaRzS/RDmOTOF10=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;7:oAUQuj04cM7uD7R6IjG5ZqpohyLfO5DAEZkFyM/uWN4IZhPlSAZB0+KA6N9fVZop/izItcnVG6YJoEiclDTQt7kb7f4CczFD58zUn6rA5dGOyWd9NwhThHFiMCs4kk0TEgIrLaKrMqZshhIqYyLgTRXt3ymRbRlAzcMUdQz7eTMneJOxL7zfGKec1brZhKeEiTG0cZontSsGnuieEZ6c4ScYDtPwYTKiVTjdGvGx4Rzm1ItKz7zWKIDZg/OEWUoy;20:DXbBoQaK3HT578PytKL+KaIB6R2Y1WUlGG3ulfWKaXgYUwHYA0+8dDtaF9kItg3fPWVLJjrvhB0N3sXCcesKuvHwl/FzHdnEDl/IyB6okc+reb17LRUqZpIvi85W7fNTog/YaJyYFCWaMYomMDLPn2/g5BsTKC/cT2r5LBDWY6E=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 17:21:24.0822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbccd491-f3ba-4318-2523-08d5e0403d03
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/30/2018 05:33 AM, Andrew Morton wrote:
> On Fri, 29 Jun 2018 19:49:32 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
>> KASAN learns about hot added memory via the memory hotplug notifier.
>> The devm_memremap_pages() intentionally skips calling memory hotplug
>> notifiers.
> 
> Why does it do that?
> 
>> So KASAN doesn't know anything about new memory added
>> by devm_memremap_pages(). This causes to crash when KASAN tries to
>> access non-existent shadow memory:
>>
>>  BUG: unable to handle kernel paging request at ffffed0078000000
>>  RIP: 0010:check_memory_region+0x82/0x1e0
>>  Call Trace:
>>   memcpy+0x1f/0x50
>>   pmem_do_bvec+0x163/0x720
>>   pmem_make_request+0x305/0xac0
>>   generic_make_request+0x54f/0xcf0
>>   submit_bio+0x9c/0x370
>>   submit_bh_wbc+0x4c7/0x700
>>   block_read_full_page+0x5ef/0x870
>>   do_read_cache_page+0x2b8/0xb30
>>   read_dev_sector+0xbd/0x3f0
>>   read_lba.isra.0+0x277/0x670
>>   efi_partition+0x41a/0x18f0
>>   check_partition+0x30d/0x5e9
>>   rescan_partitions+0x18c/0x840
>>   __blkdev_get+0x859/0x1060
>>   blkdev_get+0x23f/0x810
>>   __device_add_disk+0x9c8/0xde0
>>   pmem_attach_disk+0x9a8/0xf50
>>   nvdimm_bus_probe+0xf3/0x3c0
>>   driver_probe_device+0x493/0xbd0
>>   bus_for_each_drv+0x118/0x1b0
>>   __device_attach+0x1cd/0x2b0
>>   bus_probe_device+0x1ac/0x260
>>   device_add+0x90d/0x1380
>>   nd_async_device_register+0xe/0x50
>>   async_run_entry_fn+0xc3/0x5d0
>>   process_one_work+0xa0a/0x1810
>>   worker_thread+0x87/0xe80
>>   kthread+0x2d7/0x390
>>   ret_from_fork+0x3a/0x50
>>
>> Add kasan_add_zero_shadow()/kasan_remove_zero_shadow() - post mm_init()
>> interface to map/unmap kasan_zero_page at requested virtual addresses.
>> And use it to add/remove the shadow memory for hotpluged/unpluged
>> device memory.
>>
>> Reported-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Alexander Potapenko <glider@google.com>
> 
> No cc:stable? 

I'm just not sure whether this should go to stable or not.
It's a gray area between a new functionality and a bug fix.
From one POV we fixing the bug here, but on the other hand, ZONE_DEVICE and KASAN
never worked together, so we add new functionality here.

> Which kernel version(s) do you believe need the fix?

I'd say the fix needed since fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
Before that, the combination ZONE_DEVICE=Y and KASAN=y  wasn't possible.

> 
>>  include/linux/kasan.h |  13 ++-
>>  kernel/memremap.c     |  10 ++
>>  mm/kasan/kasan_init.c | 316 +++++++++++++++++++++++++++++++++++++++++++++++---
> 
> It's a surprisingly large amount of ode to do something which KASAN
> already does for hotplugged memory.  How come?

For hotplugged memory we simply use __vmalloc_node_range()/vfree() to allocate and map the shadow at desired address.
We could do the same for a device memory, but the device memory isn't like ordinary memory.
alloc_page() or slab allocators doesn't work with device memory. We don't have concept of
free/allocated device memory, for KASAN it should look like it's always allocated.
Which means that the shadow of device memory is always contains zeroes. So, instead of allocating
bunch of memory to store zeroes, we just map kasan_zero_page.

The most part of the code to map kasan_zero_page is already exists, this patch makes this code usable after mm_init().
But we didn't have the code to unmap kasan_zero_page, so almost all newly added code in the patch is to unmap kasan_zero_page
(kasan_remove_zero_shadow()).

It could be possible to not unmap kasan_zero_page, just leave it there after devm_memremap_pages_release().
But we must have some guarantee that after devm_memremap_pages()/devm_memremap_pages_release() the same
addresses can't be reused for ordinary hotpluggable memory.
