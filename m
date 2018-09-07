Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70217C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD3120844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XGkgq5Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD3120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeIGU3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:29:34 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:46045
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbeIGU3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjX6A3mjReav7typzG9U5R/Qz1mi46xghs19jdDMlnE=;
 b=XGkgq5WqIw1lNW/wZQ6Vo2FbEjlGfDh5QBuG3bY4KWadtemHUZPQrigo+7lrOGxRfwA/1GQrdLZvYZ2zxMHQsjKOC988h7WEgk+NDgs+oFdH/IzowhPH260rdHooDh1jaHO/lBz9YO2VJjxUTuvvh98sWwumoPVn2XYVHFJWG2c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 15:47:59 +0000
Subject: Re: [PATCH] arm64: lib: use C string functions with KASAN enabled.
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
Date:   Fri, 7 Sep 2018 18:48:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907145605.GE12788@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::25) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d40ab8a-ee5b-4e11-fb62-08d614d94a68
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:1BWstToubBgHu4vqCqv2azVvlGmUqaGUC49ezEzsccX3xxC/J9/qpd5a2C0xAvfrS+SXTpqUI+KC6ZvK8/3T9UFJAnLiJdvtBpgcZBttEt77VCKvyIuQbf4qBjxq3yqP9vTW5jGvXa5WPFFlhnq6yRnlH8NIDWAoUjl02TABt2a7JQLJ+UPHzdyrNn5jSV+OllgzODaadma/K2uH9eAwFyuU3P0qyyTziqq+o+LJ89kIU3EDtHTiCD9KpQeZCjKh;25:xu4KotpHkeJrEOt3TkyDR0bByWAlFfxbAHG3VrZGpbBBi+pnhLHU/YVivIE72dX+V6eMQf9F+TCK6vO3fw3NIqHnEnfOfhEcS15lZXijPFaB52BAScX7Rb/0VgJNEkDebgyrMsi0aIZrB8Y0Wta07K28k85JaBYz+iYl8hilLertTz9+ZCEziiYunBEHCj1/0zZnY0uaxYm7CGpeca5TEg7kdRhiJHLqLsQlauqpxTxtTScb/5RAgZspAZU5OX0bmw98tGn8/cddGzM2xLkq1wLA1nhLNKsYl3dSxk6Tdt+w/FDdx+VAULMqyEbWufVBHyJ9M2AhPh5Mh49RKaE7Rg==;31:BV3oJ44Y8MlextSZeOcEGdR8mVxXs31J20vLpbpo4h/I1SNb7XGEgm76t6ViCPxeamEyvxQO9xfYeLEYfw9PeDGt0kkdHr3o7dy9Rwrd/Kds5udrZwKskmlf2SO4HGKUc6Mi1Dn2jHtQNkXVAE+Dl14bgEkj8tFAGsepnKgppw51avc1qhZce4COvs0P6CRQZaIsIwKYIfBBUEelb9iKcs3BAXd9E5+Lk/kjkMtB+mA=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:dbHQ2KA828Ue6at6qCEutGO7mG2enwHEISIlW7k2B6/oJ3H3XixOHn1mN33u3NjWPTIvf+LGEwYJGY5IHvrIU+PMd3taNz+4SiofmgNNdXIME2xEv4cxAxWFhFFO8DCWwC9U5/6q7cTjJS2IqpxlIzieGTbYJ2QMtb8W0/CAwTmX//EqlTGQHpYdM0jitGWQOL6HICd1oc1UUnwMLqJgtonbuJgmHfzuzRIakw69TnrZDW8b29BwB7rpb3WvgnpHLPLU1ycBl5TPahEey7fk2P1X4G5+NFYLe3FebtkAT27QNHgPNEz8AXyq3KebPOLnDmAqW78B4OOLfqi7bJG9rTrTe5g0/PEVaaqwy4qtN0CYA/ZiGwmQ3VU8m945oH8JfwzV7fJ76Mk0yzAGkYFSYV0g5GCkGGYKYHhr8TNgIwQJYMCtVUmvyI3+DdoMwgKY0XDyqGHp8H1YacVKDnjheGE/BbFWGoxWldR67wpGx+y0XqKG0Rx1kzuSmYPnavmI;4:z2fjdaFBDuTwkIHaT48b5ETtShKM2ecuHBAJpaMZ3MaT8+ZtjAGbkmcNa9Si2eHOlu1nYdAzACHKQp+yPekDmuuhOchSv03oEMzQ6ipMb4SsQJlb0v0rUvsCBYcjXoZmZO2uaqlo2njrsYu5AUV+g+hr8O+7pkFLWxTVHLhQlP/tqCvQmlAIa5yl8t/pOMHMcSNpGKAiVapqonxOd/hFvROT5g3351W/YwCOCIw1dwtMiijAyjSOZqWpvsiyMtJ+6RQTBa9l6t25aYkqagHpNA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3264D0A74BEA4360A770FD70B0000@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(136003)(376002)(396003)(39850400004)(189003)(199004)(57704003)(65826007)(31696002)(25786009)(53546011)(386003)(54906003)(105586002)(2906002)(50466002)(486006)(2616005)(6666003)(4326008)(53936002)(11346002)(97736004)(476003)(6916009)(446003)(956004)(230700001)(6246003)(8676002)(5660300001)(106356001)(2486003)(229853002)(58126008)(47776003)(65806001)(478600001)(6116002)(3846002)(76176011)(66066001)(68736007)(23676004)(52146003)(7416002)(77096007)(6486002)(26005)(16576012)(52116002)(65956001)(31686004)(305945005)(16526019)(186003)(81166006)(36756003)(8936002)(86362001)(81156014)(7736002)(316002)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjY0OzIzOlhFaWZ2MDB0UWFHMEhjUDdCamd5U3JLSEs3?=
 =?utf-8?B?N2dBajlLYWhBUUxHUDFKcFd0Nll0N25xdkZEVWdNK3ViRFNDdFFnd0lUczRt?=
 =?utf-8?B?SngrVnMxVWozcE43OWJFL05VNGFBYXJ1aDYzSnZHenpPc2tidTFucHpRV0FI?=
 =?utf-8?B?aTlIL0lPaGhyLytsaTVCNEk2aU9iTHVQOS9xWEFHampxOTltWDhiaGlXa1Y4?=
 =?utf-8?B?TTIxR2NmN2hTdkJsVC96cFJEOHhoRXlRRTNxYjN1S09zVTdIYWQzSFFycFVC?=
 =?utf-8?B?RUJkMkEwNnhjeFVGWDBrbnpyT05kc0RFU0VtcDNIcGNyOTRZNHRaUEhOaHBV?=
 =?utf-8?B?NmdFNFFZaFlSNTR2ODIyU1pUODRleDIzZFl1VnR6czVKWlY1d0M1NjVxSHRy?=
 =?utf-8?B?SDZZWlpCSG53MlcraHVCRlNjOGloU0RuZzVjMCtDYXBOTC9hSFhzWVhzeXZO?=
 =?utf-8?B?SWJxV1l6NFZLYnFNa2JmOUdDSXQxNURJWDYydG45am51L291bGwrR1I2dmNu?=
 =?utf-8?B?b2xZR1FGem9lS2J5UFhGaGxBaVl3RHEzUXlnd2FhS3YySVIyNUtVOWo2TlJI?=
 =?utf-8?B?QkZqRlBuUHBXYjY1aWR4bXBZUGVxcHl2SFYvUU9RSnFFZHlaNDFnOVNCVkpF?=
 =?utf-8?B?MTFsM1pyTllrNytOK3VWd1JWZE1BY0s0WlpwNUlvcDlpc2RvUGs0dmczb3U5?=
 =?utf-8?B?ZVRab0lGTC9SSmFPSlE0bzlEZGx2c3JyV2V5K0pUNDF6alZtMlhVQjFpSnpx?=
 =?utf-8?B?aTE4UERtakZiL1UxQW5ZTjEzQWpuZ01sUnVCWDNKNkROaHFEZmNpOGpvVlRt?=
 =?utf-8?B?SGp3Qjh5MmRnSFYxWFc0cEFNOVY4VE9tUkh5TnlBaXl0TFFmd1ZDVFFqMytX?=
 =?utf-8?B?aU9wQnRyZ053eGJSYithcHNaSjJnNmFZcnd4NDFkaGRhK2ZZaTFTdjQ2MlFY?=
 =?utf-8?B?R1A1R1l4Y3M4VHc5eVE3NGsxWVJnMDBkVkk0SUt2cUhaQUgzZUtpelc0dCtj?=
 =?utf-8?B?bzU0b3cwVlhYNmlHbmxJUWNMNUtvVlAzcWRUYTFaSVltTnFmNit3QnZ6bUY5?=
 =?utf-8?B?bnZocmVtZG5IMDgvakIyRGR1N3pKOHRXMWtYTEptdUtlakgyTVEzcnoydU9R?=
 =?utf-8?B?Ujh4UWRWUmVmbE5iQ1paMlVXblBEV0NLOUJabkJNZE1YMXorZ2h2dy9URTM5?=
 =?utf-8?B?SlJRVnhQcDE3ZUd6djJoVXh4WFYrOWNhMFcwSEJWdWxZSXdPYUxpR1Q0NEhh?=
 =?utf-8?B?d1BTOWoweHRUVENYSk1RZU5CWlQwekJHdm5vR1pUMjc2dk96NFpCblRSM2VO?=
 =?utf-8?B?UmR6VjRNWDdoTWMwNmYzNXBBNGJLd01lei9IeXh6dW1GQlM3bjBSMUZiNTc2?=
 =?utf-8?B?WVBaRE9xYjF5aUU3anRoUW0yWjBGZlUvN290US9MRXRVVXVkZmVxK1dlRHpm?=
 =?utf-8?B?UEYwcDM5Y1lRVG1CQ0RGNHB2dEc0WmNLbjFLTS9TdnU2STZVb1gyYWRhRHJN?=
 =?utf-8?B?YUxFZVdRUkFKbk8ybEJtNkhkZTJVUU1UOVJHNXRkWDM4dEhmVVQ1ZkhXQTl6?=
 =?utf-8?B?enNPU1V6aSt3MS93TFJaQjZBNTc2Um15cGZkeE5uTi9pNkUybUhkYnlPc25s?=
 =?utf-8?B?QUY4eDd6WWloY0JBYzFnNVdVYUFaNVVhTXgyakN5R29wWU5uVnZxd25VdWxp?=
 =?utf-8?B?R2Y4OFVjZ1hKQlpCVytHZElCenNyZUNQYlJWRFErRWpxMndsUW9mQlkrV3Zx?=
 =?utf-8?B?cWs3eXN3S0F5enNpRkVwc0s1RUlQckpRMURyWXFpc3JtYmNSeXdwU3QvUnRH?=
 =?utf-8?B?ejY4clpzclBteUFkUGpVQUE0OFUrZE15QnBYMkdiSld5QUJpcytFTUdpRmpT?=
 =?utf-8?B?anJLR3VYaHNHam1KRmpZd09wY3UwRS9oQXZpSUVJUnFrT1ozZ2RCRkxwd0w3?=
 =?utf-8?B?cytJb1NEU09xM2pmSlQ5SnhIYUdQOXVOVzI5QTF0YlVEUEJuYk5aeVhXTmpP?=
 =?utf-8?Q?pdJOzM?=
X-Microsoft-Antispam-Message-Info: ZEyORmpiC6L0M5SzttsLTqjkH2tvV/ZYD7WmiQot7Lrna1xcoRyApPx8oq3q1q1KBdwwGGlrjkAwytk06ohkWrq+5d1N2TOtL2Xvxuogqg7xDkAbJzy7PmLA8AnnmdvRHUfDg3LHDO9RvweWmL2S0xsK1YenR1NJe6LYSt0GtPU1s1HFXitixMMv+w9SfyKmVj6ToysxllsVz4Pg4H3QvZ2RO0pOYnNlH3BkD4RcrSTCKPfcapzgvEJ3xLsozcVjfJU0drikRLFM+zjI/fDdBUt/yPLsAUOFFqKCY6bGc1LnxyAEuQqkuaOV7qtG5Xh/OnMwZzwTDZYHv4xlAuHMrJ5H94cEezULVYbcEUDsiLw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:iohUNsrH6IxBa20WMi3coP+pRXlDMq1SE3TndjBwW19RpvA3rlMyWtxk8OT2P2pYJ/V8j4g59kHuAUt68Sl+DUuxz3mJSWLXU9ng2Dk1iCJb1zxGYbJhZLtvlow3AcdNQgG37oTZQ9u2B5qWfi9haNn6kBuuio9rG1LxlDjYsgDmWRdAv2lfmrM56JOmrhK5vAGM+bYyCLNWEl4vdjTpYxXUU8zOgkpwfa0NNMSueNn1DFhgLgHiyS5pBiZYbEYUSRg/18gl+4alz78IOmJBW+fZ2iXpEZQZZBhkvvmQ1KpbB+Pe8MngVw5EbbTHH7AXAfX2ROwc1/FjYhxQcMA/Yt0wRXoZcj8Ce3kkvxgD8COdtapX5/u3ZQbHijS5D6Mdw4aUnrCIolTdzzO/QcThn9ZuuM5/w81G8itOcVI9mQBheElKy6/BCMXKa82gWYFUdPoh9Batd3UAXlYYnRTtDg==;5:t/bYIDhNgdTPjYGaEeH8o+unCXFxYYUid9oAFNDHSyc81PjX/iLK6F41kYNjZ6xQ5UEPhzb29OaIJLPn7XNoOxRO+HllOT33kSdCfaEpt+M2rOzkV2yk38C2hcZIKMi0cGtTtTnHuJ9UIx1C+6fBlms668x/+bPJ8OvkzzwqQfQ=;7:6SIGjMq6Q4VLUxWX2jNJG420YWGstGD2GeJO4G1XgB0kNjHTN/JTWu3pHF2ge1p/ijXkDubxH95oM4uW4GQbg3nVxdprK+jeRNQp5lUWJcpkK85Nbo+frJd2XlxVmFr3GISPVRsmZShoJqwJRMGky4RYMOyqfo3oHcLYzHegdPL9uS0LLWHjhvfrhtkWkDC5oujOb4sYlzdMoZixrNRqYXoiNxj++S2T4p7nYuj6OhibaGzWOVnSfSeit7v7fyoz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:K8baz8lVa+Z7LQ/FE74IBtYu4c0psGpn5O7dFi6FEv+xI2VlGy94vZbvSnWOy9+19R0OEFkRkCI3/BN+oHKFl0nXzLVjJpLoToHDYk2c1udlEGdyHNqTpNd/MlJftvwdqKm/2hVhBAhoAcs0f8qBvgNCSDQanBnxa/JqAhNPs9w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 15:47:59.8109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40ab8a-ee5b-4e11-fb62-08d614d94a68
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2018 05:56 PM, Will Deacon wrote:
> On Thu, Sep 06, 2018 at 08:05:33PM +0300, Andrey Ryabinin wrote:
>> ARM64 has asm implementations of memchr(), memcmp(), str[r]chr(),
>> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
>> code, thus it can potentially miss many bugs.
>>
>> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
>> enabled, so the generic implementations from lib/string.c will be used.
>>
>> Declare asm functions as weak instead of removing them because they
>> still can be used by efistub.
> 
> I don't understand this bit: efistub uses the __pi_ prefixed versions of the
> routines, so why do we need to declare them as weak?

Weak needed because we can't have two non-weak functions with the same name.

Alternative approach would be to never use e.g. "strlen" name for asm implementation of strlen() under CONFIG_KASAN=y.
But that would require adding some special ENDPIPROC_KASAN() macro since we want __pi_strlen() to point
to the asm_strlen().

Using weak seems like a way better solution to me.

> 
> Will
> 
