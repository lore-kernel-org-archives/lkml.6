Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169072088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZthGvTyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169072088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeH1Mzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:55:32 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:45507
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbeH1Mzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WZE6BkZDoTMa/Jx+/0OVaWa4+4sKOa3rabUHerJCac=;
 b=ZthGvTyTW7rUjQyX9ucE2+Ey+ABedGX1RrVNrYJqwWU+LZwRF3M/92oMI+kGP1p7eGQau7i1hIvYLu6aarguPNV18MyYfHhJZQOMQrTF9AtlbYvuJLEvE0PprccsNvODMv51VmigOWE6xDrQF8eZ/FeiNrTan+iXgPMTRQnqqT0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM0PR08MB3249.eurprd08.prod.outlook.com (2603:10a6:208:5e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 09:04:46 +0000
Subject: Re: [PATCH] x86/entry/64: wipe KASAN stack shadow in
 rewind_stack_do_exit()
To:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
References: <20180824235826.62741-1-jannh@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0897d173-6a30-09df-f16a-76322384fe0d@virtuozzo.com>
Date:   Tue, 28 Aug 2018 12:04:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824235826.62741-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:205::31)
 To AM0PR08MB3249.eurprd08.prod.outlook.com (2603:10a6:208:5e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 197062af-42c8-4389-16e7-08d60cc54d8b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;3:LDMOodHGpEJFAQE0cLABdrZjp4UEs83LWwPkUmUFcwSPaghXEr5KUjWyupEd4pKz3v9jEw/kDuTXPe3xjbtKu2WsP1DMpcyv6A7zq54YqUJtrYMcgCZjb0kin/5CrTfssj9tD17/jGSIK8M/j6hcPJMkt527sIKOBHgZVZSs2k7T+3vPlGHIzeDlb/2fm3FvUdS6vSTUIstUmh4VSY2DmIklS98V5WSENgO81iz4nFFzh0Mo5SCQDnjb0e3/JIQw;25:6DmtFLlksIyHZ9rXuZbK4BhcFVGnS3mBqFcQLFB5OlHA8p4z5d8kLeyt1pBkYwe8uynC2R+tk3nb0eP6AAIaYdRh6//1t1moJnvmYaVE77vGVegyPUbETu+59MF+vJ7tbF5DH17ca5qRca+VN3WvX+E1WG0ah3EYsZxJsjXM84c9sMEwDyBcBsptdLtp98LmUiK3qNiBdu3eJPvmtMxwJgVk1wrVH1PtweAzUu0nNzzmrvICHogICcS8qZcImVUX/OEzqLXGMTFNcHhZ0IgdL6BqMLuqfZQbH3TTci9vUWCvi+N+XGHM1BzikFIS4Q1Bd6GufK84mzC7aVYxvGT5uQ==;31:KYdQmt7OjJ9fPPtsXDDdSErvoq275i7HeeSN7kfa3Gn8nfWDyo9MbhCM4gSbqNfpU45DzYR9Qy9qSXEY5ZJprWxg5oI0GQ/uLBGezJjhfZLhkrkHTXPW+aMp9Q2dfNLISQq1+Z1byrkwax7eQT3k1Mf1h+UqWkC/fu2ciIJiwA/+afRGz+C36SkjpSihODXc0+VuV1SNtr5MH8NWAWZ3ebKnvT5WJz2u4A9MZj4ikJA=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:xFfVqQc7yaeBtjPRegx0iJR8eeFTleDHVvOw0D6c/lC7Mt2YvW7gsDc4DngoybuOQqCQSWGSBGkd+I6fyiU1FDByhQ/ecfyK5wzQshmen4jLfJthWQypDrefNcUKoQEx6m/G4ZwKduMcXtKF4pFQgT7hJFnkyPAPoNvDqPkYDuNmGHNoAQj+1vgwB9JVY/bcdXJJ6kGrKCwcCH2olj6PulBndpO2Lt4icXODcqBzjT5gh05SDuYGR9L+PeMKiTYb40ESWbHbsbJa32FKuYKoEHHxSBTqH8I65FKKZCQkVEqQHn+AnUfAWVRRHHkxxApA7XM5Wc2FcBrDw369ghEo96zIKByxvZWyaozGr0yloDO9l9nDs3HtChN2NTvjWT3l4wA6DRznkmn52bIQqCqiNeOB6IUbKFGgwpIF++wUO9FLcUdKRYbwExUJoZsZpIvy9uX/QQCuIgioazkviUSbe5jtG3Huc37gWQJyXXhH0UHaRN/HNn4cIIY3nJs+pI7u
X-Microsoft-Antispam-PRVS: <AM0PR08MB324990F7D1D901BA667EA772B00A0@AM0PR08MB3249.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(166708455590820)(211936372134217)(153496737603132)(192278398808882);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR08MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;4:EjL17ofCKkp1bZLuVNaAigpfFtDwjSIjDUp3y43aPhK2cwF8uV4TU/QVtVvwDh+BH39hBNphuPB/yPUnqFYncjUqXI0EG3rV8LWoy4HneJHQx1nCfENR0UKGXu3ZPBx0xVHFjB7lC/1Fpfhn8xnAPzEGbxG293K4YmbAVUD33VCBinYGFDXrxshu6PRhSSjKtvzZbDq32dUG/jgKCZJMKznRi1xGi2QqhzLOEAI/8PWkrdZFqqiHReKXBdMbgcxOT2hK6sJTmlCuq5SXgmTZ3Jyshie5xn30hyrMcGYElskaptBJPaCqNztuPgqtG5tIJHTY95z62O2be7WYvTvOPiwidV55KdY4ujl7Nwvia/uPXcRcQUuBAUEKV0vFx7vFsL6lwNWqH8wb3LLlK9mB+XkNbWjA558xBz+L0ZZP58I8NWYXqnCcxlz8KCuXne5Tl6JMEEAj3GXi9ARBXwiuOw==
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39850400004)(346002)(136003)(396003)(43544003)(189003)(199004)(23676004)(3846002)(16526019)(186003)(50466002)(316002)(14444005)(68736007)(64126003)(97736004)(229853002)(6306002)(47776003)(8936002)(66066001)(2906002)(65806001)(65956001)(486006)(2616005)(6486002)(386003)(11346002)(53546011)(77096007)(476003)(956004)(52116002)(5660300001)(76176011)(16576012)(26005)(52146003)(2486003)(446003)(65826007)(58126008)(6666003)(31696002)(53936002)(106356001)(966005)(110136005)(54906003)(36756003)(25786009)(230700001)(305945005)(4326008)(7736002)(6116002)(81156014)(8676002)(81166006)(478600001)(105586002)(31686004)(86362001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3249;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjQ5OzIzOkRQcUxOa2V4dUZBUEY2SjZFbFpuamNackg3?=
 =?utf-8?B?c0hhUGpJaFpOQlVNZ1R3NmRzN2U4UnNDbHV5RzlpK3ZIZ1czaWNESEVTdFB3?=
 =?utf-8?B?bVlVT2x5UnRpQk81ZnJtWDFDOEUxdmVTUm1MUXlaRGpxL25hdXUzQU9TTzR1?=
 =?utf-8?B?L1BVQ3Rhb1NCeWErR2RVWjRMUmt5S3NHMHpwSDRYeDVqNzV6TmZmTDU1OHli?=
 =?utf-8?B?N1NlMHYxN0VJTkZYOVZ2bWJyRUNCVDJJcWVaT0JFc3VMeTV5SmVXNFRmcC82?=
 =?utf-8?B?OUxITTR6WXhPeHp6YkFKU21nd2V4M1Y5UXNGSk9rcUNFcGpqN1dxYTZsaERI?=
 =?utf-8?B?bS9vU0Y2cmd1UmRuMmFzcjhWTHZBWFZIVGNzS0FhZVdnVU1DblVEQW02TUJv?=
 =?utf-8?B?WVJIdlRDaDdnNWd3TlVneE9tVDVvMjd5V2NleGxmeGF5VkpLdk5yVnNPd3hL?=
 =?utf-8?B?U0diS0FlYUVERFJnR2RmYlIweUpDT3RERHdwUXltb3dITnV5ZTFXL09TTk4y?=
 =?utf-8?B?UTE5c2tubHZQak5sTTNXcXlVeXorei9YZWVjSnRTdUxoUWNCb2VjZVpDL2Zy?=
 =?utf-8?B?Vk5mNHNlYWUrOUhxaTdXOEhzMkFGR0pLdGhjK1VpaEFuMWd3NE9uS3p0b1Zl?=
 =?utf-8?B?R3gxOGFBNnl2UTJ4bU1ucWtmSUEzSVZmNm5aaWdMVFl4L3ozL2hPNm9IM0dm?=
 =?utf-8?B?eFBKVVR6eHp0a1RJUUFDbkV1RkJVRmd4WUZpaTd3SUlsQ2VpWnozOTMyRGZQ?=
 =?utf-8?B?RzkxeFphV29WcHlwR1RteTJsZ0hsKzJ4bjk4M0QzZkVLaGM0Vk16QjNldHdq?=
 =?utf-8?B?RGQ5bDE2cWxiT0hvRjZKZDI1YWxyN1kvT1I0VUx2SjAreEFkeG55RHFMMzJ4?=
 =?utf-8?B?VHNTZVl5TFJ0KzFJelA2cGE5WGZoQWxXbkRNM2tQZERzWndqL3ppN3ZQZjI2?=
 =?utf-8?B?bjBSMFk1ckV3bUxqeG5hMEo5SFhaN0o2ckNtRFhSc2lhMjltU0hWS1c5bWFF?=
 =?utf-8?B?U0RIY0VOdGtCM3RiWkRTMTZNM091L0prSEdKRG9GNHc2dytxUUJ3OG1qaUFH?=
 =?utf-8?B?aGEyZzRLSmVVdUorV0o2Ni9JWGtoNElQU1Z5aFNuRm9lRC90K0J4ZUhrL05U?=
 =?utf-8?B?cmlUd0JwTCtaaDZ4dTQ1Y1BNSXVmZ0RtOVI1SDcvWDg0eUF3Z2dBTVhWRWRk?=
 =?utf-8?B?eFZObEppSnJyWGp1NjJJSmtIR0I2cUphMWVoN3QvTjBVcEtkR0Y4Umx0bTUz?=
 =?utf-8?B?MFZJK1I3TE9jeW9EaFBsWE4wRE56MTBvV2ZoOUpRWG16dWVxWm1ZZkNvVEht?=
 =?utf-8?B?QWZCZXdCTVlodm4zY0xLVElDSktkZThRa21NajltZ0hJSWtTZWk3aGVtL2h1?=
 =?utf-8?B?djdVcjNoQkI3cnFFZDN2Q05RNjBybXpER3FtZERvL2pCcWFPUnk2QkpMNmJB?=
 =?utf-8?B?ZHJGR1BMcEVWV1JXN0UwckVQemlvSlpCUjIwSkhqYklzUDUyU2hCVU5GZVdn?=
 =?utf-8?B?NG5Sd3VPaUdkSU9PVjNGcXIzRlpMME1wbDNYdVQrM09LeWdTM0JDMVN0bGpR?=
 =?utf-8?B?ZXVTWTRvMXNWQU82WjFwQXFqaUs5ZEQ0RHZKS1plNkRscE81NCtyUEVybXJa?=
 =?utf-8?B?TlZmK0RBc09tcVpIbzcrY1ZGMU1GU00zOFZBTU1CRW5FeWFuUkF4Qkx5NEVK?=
 =?utf-8?B?c0FkSm9qYXJLbFZOU0NzeS84WFJXS0Fpb0FSYXUyeHRqTmdKN1VGclFPalh1?=
 =?utf-8?B?cFJUcFp0OCt2UmcrdXkwemZ6MXpGeU1Db08zVUp4ME1WVElSRnlndDJjRERN?=
 =?utf-8?B?Q2NvUW5EYjRnRlBwL2VuUVFBOVloUWUveUd3cWMxZlpwUG9rY3JpZmlENk84?=
 =?utf-8?B?SDNVcFZvZ1dyNExMbnQ1bUpGNCtQL2owWUtrdFBlYVN4Mm9zYUNLVXVVV2pK?=
 =?utf-8?B?Z0FRdGxkLy9uZHYzZXZlUzlVTFRYeXBJQTMxcWRXSkxRYVd3eER2c3YrQmpk?=
 =?utf-8?B?UVA4Nk9NZnJHbGdqM21wQU9jb281WHljY1ZUQmNmT2l4T3lXVEpMMzVXbGsr?=
 =?utf-8?Q?gWxA=3D?=
X-Microsoft-Antispam-Message-Info: EqtzMM7YHjlYXY/joRb6MMd6ILwI7uRmzw/9t84wshekIT1ddeKFlxabiPXm08cRvZeIhq248hZvFhzWK6Bm32pwWDA+fnKGIS6zap/updQb3hA2znfTym4s3yap4q2X5U/JcWCO2bDhUc6pgKbJKrBT7awfiKwzaDDAqR81dlxR3KQFs6VGLc3NMv+QBF8JEo+7BTby/AmUIWuljFOGl8xaAt/RAeBE8sAfVvVdoMX+awnAOQmhwTHvdmwn8AVga8uYUmgLdUOBcFSRbjHT7JCRltKJjXG17nA0qoH8WhJaJUHZjGgQXbOc1RIz7WHqvEqZTjZkkWKxJ9VWvX7GU74BtKAJwTC7BDoM5EQZcyQ=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;6:8khru2BT4UM6RggjFlawoHmi0jEBHQDsaLldVzXedNjiGTi0vkXsL/FwVFU/eFkvYZEC5VKdEPGi6CzcBZGcmZGv7py6rTuNKEAfiEwdogZurvZClrhNKl+669KhG/6l02AMIPE0Fb0a3rPD7YpepRhRx58gEveABoFNCMPpcTuuPO+tKi8/TPkv2aoTqwK3HBJqufBSxTwdZ7r8DhxqO7qk5Gi06voDzmj31wT1qjepAEFMBdm/gzt6pF8MigYclY9Oyaz5CmwUbaaJuO/Hw9vX7bl+nZNeQh4GxN3aqdDD23L3LZuEDrMnRMT4WpToIJb5E3i211kmF1cepRz5wKkbcQDZL4hT1+jigXtru1s7182gJvDb+BeVEhyu26aprNUz0g00D+KbN9GFC1qbx67SMZbtFFm0lGDVJb9O2PwohkgfcxyLzeNdFv5m3bgQ8ElFB8HN31+vO4pVKfaTWw==;5:MlubBKekSc9ImV0cDCDjkYXhKkr80ZL1jp+uWGhxTkPkpXVnDL/sRL3Y4caUIYRxz48l3rfxLrW6EFOCdA51wE5fIkGoQpLSBmGSwSTveck6Xq7IuMZhTlWtEBVTsyg4uCzFoD6Yx40l8mwlS7cFEDtDt6N1EdN1IIJQJKJgg6g=;7:7CtRB8MFs4yG/DxPDPwsmtiZwnu3IUJChUH0GjAcg+RjoymMH1+f1S2EK/YYfEiFDuHp2eTyIzNhEeyWLP9LLTrQtpwtGxqEqqMaVQebB4lQzwRFMR+1rnKSmQXTM87sQE7L0TB35F+FMVtQ7684zWrwSHgMTgPonkCi1yeVI8L2MX9ry76YagIGUSU2DxWQEF0kdawkB9pa3KzAXyS/vfn2GZaICzLJCjOlFezzLN5o0z2zaCqqQdKpdH/Pz8gX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:i83TJUEQHSS+JHl474Ll9+3HvhSxloLEZPdeO0NtAI1542KTrVDbYMdz4KSGaglHdyJADKJtYEOpFZ35IGPCpTGtzEl1EYIj7wUsq8Nijzom3UCGg7O3EslInbpOyN+scogpmx0xzUMTQrX3pP5dxxKouAkXehJ9tBVoISz1NOU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:04:46.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197062af-42c8-4389-16e7-08d60cc54d8b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/2018 02:58 AM, Jann Horn wrote:
> Reset the KASAN shadow state of the task stack when rewinding RSP.
> Without this, a kernel oops will leave parts of the stack poisoned, and
> code running under do_exit() can trip over such poisoned regions and cause
> nonsensical false-positive KASAN reports about stack-out-of-bounds bugs.
> 
> This patch is 64-bit only because KASAN doesn't exist on 32-bit.
> 
> This patch does not wipe exception stacks; if you oops on an exception
> stack, you might get random KASAN false-positives from other tasks
> afterwards. This is probably relatively uninteresting, since if you're
> oopsing on an exception stack, you likely have bigger things to worry
> about. It'd be more interesting if vmapped stacks and KASAN were
> compatible, since then handle_stack_overflow() would oops from exception
> stack context.
> 
> Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do_exit()")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I have manually tested that an oops that previously triggered this bug
> doesn't trigger it anymore.
> 
> It would be possible to rewrite this assembly to use fewer instructions
> in non-KASAN builds, but I think it's clearer this way.
> 
> If anyone thinks that this thing should also be wiping exception stacks:
> I did write some (entirely untested) code that should take care of that
> (before realizing that it's rather unlikely to occur in practice because
> vmapped stacks and KASAN are mutually exclusive), but I'm not sure
> whether it's worth complicating this code for that.
> In case anyone's curious how that would look:
> https://gist.github.com/thejh/c91f9b4e3cc4c58659bb3cd056c4fa40
> 
>  arch/x86/entry/entry_64.S | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 957dfb693ecc..92d3ad5bd365 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1673,9 +1673,25 @@ ENTRY(rewind_stack_do_exit)
>  	/* Prevent any naive code from trying to unwind to our caller. */
>  	xorl	%ebp, %ebp
>  
> +	movq	%rdi, %r14
> +
>  	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
> -	leaq	-PTREGS_SIZE(%rax), %rsp
> +	leaq	-PTREGS_SIZE(%rax), %r15
> +
> +#ifdef CONFIG_KASAN
> +	/*
> +	 * Remove stack poisons left behind by our old stack.
> +	 * Do this before updating RSP to avoid problems in case we get some
> +	 * interrupt that is not handled on an exception stack before we're done
> +	 * with the unpoisoning.
> +	 */
> +	movq	%r15, %rdi
> +	call	kasan_unpoison_task_stack_below
> +#endif


Why this has to be done in the rewind_stack_do_exit()?
Are there any problems with calling the kasan_unpoison_task_stack(current) from oops_end(), before the rewind_stack_do_exit()?

> +
> +	movq	%r15, %rsp
>  	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
>  
> +	movq	%r14, %rdi
>  	call	do_exit
>  END(rewind_stack_do_exit)
> 
