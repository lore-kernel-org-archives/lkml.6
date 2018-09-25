Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB514C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD2920C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FrTHCgqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD2920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeIYP4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:56:55 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:41318
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbeIYP4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=errPTRzwL2KS/46CCvq5nhladuTP1QGtRzvLNU/vgFM=;
 b=FrTHCgqXijyfgM5tcJdMHFzAEul4M7WOZ+aYrmYYTmxAY9gXQR3C7oP7CdIffErtCom+67efe/NNcQdSEH1PdSMJ/Cb4suzopa3kmS4PMK+5MoZ5YvV1oYYHTEMFVyLLWCMSbMflmxKtHrbXyWd6y6r/ozpJOscb7TVBH6P7PAI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2018.eurprd08.prod.outlook.com (2603:10a6:203:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Tue, 25 Sep
 2018 09:50:00 +0000
Subject: Re: WARNING in request_end
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000006971fa05769d22f6@google.com>
 <CAJfpegu9hZjJOUa7wHAj9KiTpcUuitsqnEMYvQzp6Mha2Yat-g@mail.gmail.com>
 <274aafd2-5076-6b14-f55e-360411fb8169@virtuozzo.com>
 <CACT4Y+ZiVgNj6h4f7aNDyzCwH0e84Onvb6n3yZ-p690duJki2g@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f7b0729d-109e-09c1-27f6-4b7716d47684@virtuozzo.com>
Date:   Tue, 25 Sep 2018 12:49:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZiVgNj6h4f7aNDyzCwH0e84Onvb6n3yZ-p690duJki2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:4:29::25) To AM5PR0801MB2018.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcc9eed7-6fda-4bc7-53eb-08d622cc42fc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2018;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;3:hI0K3dveuelWEcs7i4pW6Q1IvPAigEzLcePZRj8fcIACzWFX0SJVSua+lHMr1Nr7UAFIbdQyduLZPO13ym5AYikHW0c+moW9PIfwqjoGodnLo/LMGOFEitGqcRe3zzphY57ezbTyeGiW+Y7bVzzJ1AwJlTgwitSOYkWgc3Asl3MQ/+sYuVjUohvwM5k3WU5N5bL9eOAQsoRtiOEaNht79iTeq4WHUniqxWDVFyM5uSvKXE6s5SygvPKtjuqHRSk1;25:EBAKwttRLPpPs9aVtKNaI93bPidyCq5wZRIr3EwaXtfMJtj+PleWc7/N5tE+LyTpKaImO35gnj7rLiMIHbxjxV+HMA0dbHfRFsfWmrG/Wk+nRMF8YoO9lvfSQbg30g9krmNO4vvgysuCPKQafcY39mGoxf04AMhqvrbxCPVh7Gtmytc+zoODALGI/UzphQlcyUwqGodYRm9LPiqvWIqNXcSCW/Dbv2LbAC4UjyWAx/v2EI8mfrWdvkm2hYKvaArfNmlUdHsnQi82owe3JWvI2KGTa4A0Q3jns+1PntlJ7ZJJTRSyWFRwVYBpovRKaAzZWZ1ZVmGxOF/sAsHvWqfGmw==;31:MY4iqUC2GJx9PTZ9MB+gygXNNHRnIIKzI517BsMFqlMFK239ZZCKCamhaFwhyMrN0GJxun5w/+0m8PvKta2H+I+ac7I1tWL0P4QROetV3rGz2Qvd5qoE1EMtYXcNciG6Thuwyndu4Dkt8xmCCipeI83S6yICRHKT0nIuQJiWK+98OjXpHinPddXp5pLGcg6UXjNocP9Zo4CTRl7m7JefVKU795VGkeycjvni3Ez0X1A=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2018:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:d+yIFDx6NspmW98N1VEdrmRkdcPx05dkWt8Mr0+Bo4UFQbKpx9BWomhYmrarJJibyoEPi3JK9MEsX+xul6/xTeumcMaUEDwWritqgQDSm1UpFBcNHdGs9CobaGyQ71cZJehpT6AWLtVGlNy/g84F/yx4anbneWP45xI8dnyOZMwT5dzIt7LURE5NQQ/LxbXrYNO0It+aDMURxb2iNXSEpHk44duRHDP1P00L+UAc2jgwBeaaqjwUg4jkN1c0tvs+6lpEhzcmoHHCRK6BzIfpIojTAE4nrEZ07Hq0odRRpJbZ8DnGIltszrvl8TECVeT62mspjlxIICqXqLciJaFlJNPYcN0vCJkuPcrWARHlufJBtu8S9xJzcfgqnYwqqwwnlDoawUiJ3AbwSwaI4eZnz3KBBE5RW8XtUD4TvvHzEcg+NlpcIpDdktSV2xO2n4JRTTcR4UUbsYYSqj7DPpTe7pxK0y3RcQY6H7i4svcNpNqlz5IAFCO+ImB2BcQRe8HJ;4:Xg3lbB6EBAnp+hW6NBv7BvUdr9ozAu6WxfdrIWctMr+uyvHodbLtyPCF2aRtojUVi10eYIpcvgU+7piRA2FLE62fg5Kw5KLtfjh9AqQwirC0N1sH44Fr19md2qudMz+D8bPpuQPECkmn5SzUe462CdqFEhl0Zpl+dvq1D1WUdHM58qpg93rnddcjLrmyVlekN8ufJux70UHaqkE01y/XsVLo62dZH6BtsgrnRb6DJ4ZjQZDHv0keRdUE+BkXorLopeKtyOQ3XKxMF3jP4NaXlX4/0qgSLhEcQ7UW9crs75uEhtYynMeB/KybMcVaeath
X-Microsoft-Antispam-PRVS: <AM5PR0801MB201825F8311ABE78EE46646CCD160@AM5PR0801MB2018.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:AM5PR0801MB2018;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2018;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(136003)(396003)(366004)(39850400004)(376002)(52314003)(189003)(199004)(11346002)(186003)(65826007)(93886005)(16526019)(77096007)(50466002)(2486003)(105586002)(106356001)(52146003)(23676004)(386003)(53546011)(476003)(53936002)(6666003)(6916009)(31686004)(6116002)(26005)(3846002)(81166006)(31696002)(64126003)(6486002)(8936002)(575784001)(229853002)(7736002)(86362001)(305945005)(25786009)(2906002)(6306002)(4326008)(14444005)(8676002)(478600001)(81156014)(486006)(6246003)(36756003)(97736004)(68736007)(966005)(58126008)(76176011)(446003)(16576012)(316002)(230700001)(66066001)(54906003)(65806001)(65956001)(47776003)(956004)(2616005)(52116002)(5660300001)(7116003)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2018;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTg7MjM6eU5RRXhHWVpoYWFnMjFuQVpIMWZyL3V6?=
 =?utf-8?B?Q3ZxUUszSjY1ckNEcFB5VUR6K1hOSzNObkpNaEJKTjhmMVI3T25VL0w2cEpE?=
 =?utf-8?B?dDJtekpmQjBaeFFmQ3Urc2hJUWE5UVNBQW5sekNUVmpycUJINi9DVWk1Z0Vu?=
 =?utf-8?B?MzZ3SmwrKzlYTXdkR0tBMzN6OW0xV3JGNEIzUXJwVFVQeGRvUEVUSUpJaWdC?=
 =?utf-8?B?a2NLMjEwamcxbGlGYlU4RUhVOTJOY3dZUXFsV1ZjOGEvSS9qYk5ZRk8xbnJk?=
 =?utf-8?B?UG8wUysxUmxpMXYwaFgwdzNKcWYyam80Zm1KaUtUaW9sUkVrNGh5MnlzUVAz?=
 =?utf-8?B?MVp5OGdBWDJwOWdGa29JQTRwNkdGTE9DeFZIdlFaT3VKN0FLOEVmdURNK25j?=
 =?utf-8?B?VUR3Tk4zWS9SL21pVGVGVXAvaVlXNG5qendteS80RlpObXBhQjVEMFN5R0Za?=
 =?utf-8?B?L01keHUxREhGenZrZXJ0MllzanFxSUZ6ajEyL2xqV29HT2pxazBMYmg3Vklt?=
 =?utf-8?B?dDJHR2lMWGxveVoyczU5L3J4MFBYMEpaQ2xjTjVTcFhPQjYwMzN1NEt3WVJh?=
 =?utf-8?B?MUVuNkptMmlVMlVuSFVJN0dYWVl5YmVyeExRaUcrSWFXUlNqZTZiMHdYY1Yv?=
 =?utf-8?B?c3k4bkE5L2ZqQjVQeENSOUVZMnNJcUdvVXdnOHdpMEhlblozUXhIMW1Qd2Vz?=
 =?utf-8?B?cm10NWRyeWFhRENtVHhyNnVUUVc5Y0EzcnVzM1hzdytONjNkOXd4NnRSb1or?=
 =?utf-8?B?MGx3SUwrVzdWVG1oK2VRTFJJbEhsdUorVW5RWUpxMmgxMmFvdnlQaDUwY0o2?=
 =?utf-8?B?RjU4V0NON3hvSS93L3ppVXpvRXZ6Vi9PWTU2VFYxbDBxMWZWS1Z6WENHR3Vl?=
 =?utf-8?B?V0N1NEgvb2EwM1U1MzJsUi9COEZjOUNsbjM0dkdZOXlwSWlJQUdTVzRjVHdQ?=
 =?utf-8?B?VjZTbk1TR3ZLRW5QY2ZBNkJpNzBmc3N2VkVSbnI5ZUhZYWdmS21PYXJJYnhS?=
 =?utf-8?B?OFY5UFppNXZFYXpqeXROZHZZRVlRUjBHbzlDRkh0SUYwM2JoQjZzOVVmY1Bs?=
 =?utf-8?B?bVUxVnIrV2hCbUdpY1YrQndacnAraUNmc3pMdCtnZWZ0U2dBcEcyZjU4LzhG?=
 =?utf-8?B?ZTVDSTQxbDJLUjU4SVpSTnJjanJJN3kxVjZkb2l3OUNIanQvQ3FEZHRMVTRa?=
 =?utf-8?B?NWFoTXp2elZrL3YyNElzQzNOSnhnVUpqQXdkOWVuL1BTbFhIUm9TbXZWMk5K?=
 =?utf-8?B?cVI5Q2Z4eitQMHJrb0hqZlFTNGVwTGRpWlp6blB6dEs2RStHM3Q1cDBheUY5?=
 =?utf-8?B?NGt2YkNYQkZJRlpuWXpIK1hFc1FBZEY1M29YZXYvMHhueU5NdUNsVzM2SDhZ?=
 =?utf-8?B?eitCVEZjVFZuRE1VRXFEZjhwWS9HM2R4YUYvYjBGbnRmQUVlSGtBUFJiVHJH?=
 =?utf-8?B?ZThVU0tZOG83YmorUytpdEVCRGJGeXc2dUpTalR4d3hVd0R5blpzRTA5aTZx?=
 =?utf-8?B?djNuajZteUpTQlV3MTRRUmhLTlhZRUVsTWFvNjNMZ0hrUERaemJ4SlVnYnd5?=
 =?utf-8?B?MHBxU3JxREE5d3ZnUk9DS3R6Q2FkQk02dE5vS0txMU5QSWovZ01MNHZjcm1K?=
 =?utf-8?B?eDBQaWp3YmZMZGNMR3VmMHZIOFh5cWEzdTJ4L0NtL3F1S29nRWM3NFc5UThx?=
 =?utf-8?B?ejJZVS9kblljZnhhVkRwTkt2UCtlRDRubnFkZnZNWTVCMTNYTE5lN3B2Ri9w?=
 =?utf-8?B?UW5JRHROS09KTVVmZTQ2R0ZjV3pFRmtBcWU0MXYwaVBxaVVYQXRYbW1IVmxC?=
 =?utf-8?B?U0lqeXNJUWRVSXZEVXZ4SjRuNFZabSs0a3ljem56eFRiOEdLUytYT2hKREth?=
 =?utf-8?B?RnZReW4vU3ZYNXZRT1RHRG1JVWZMaHY5bUwzQlE5NUJCMmtWUVNWUlhiYzcw?=
 =?utf-8?B?RG9TQndMM1IvRlpHQXVPVVZiYXlWTzZReU9NY3owRStDNTlMbGJkUU5GVnE3?=
 =?utf-8?B?VEdOT1V3Nm0xRmtSeW1vMm1jbXF5SEFHM0licnZSSWlWSVJkVERBOVRVUXlo?=
 =?utf-8?B?V1VJbE16YU8rZ0ROajkxb0hOVkVwYm9ic09RSlVpZHVBT09SQXBmaEZ2SGlS?=
 =?utf-8?Q?OotNp25RsQZJG50/9HqfrNcUc2m1zgRkC/pydnRXEemaZL?=
X-Microsoft-Antispam-Message-Info: EIWjSF4EEvFIVjuaDMqsKNk5U4HiJMqtXcfF+dVUB+sg1XtM7rC7VxQIrl5a9wWwRPISonhTG86bvJUtgapPoAshNIeVxyQgoDZ2yro8RU5xPe1gQTSJYS4HHCzCkqgv+H+kCh/NobTRlZ5VFhKIAGfBsaVTVykYLEOLk3m9ODtcP4OW77a0AGYWj1LmUj/0h4r6/ZuFNOmT+80OP7VrB9SwEGCtH0ZbSe2A+uPZly70prfrSNr2ojcPB2DI/WMjemHxyOt6oQBWwoniSBrKkjyiCFApumr60Bq+qxs4HVIz79hhfBrDpSQkkjR42D0FIw1UexDE3x9VWFHCxFGq8nHI9tLOxEbd1uin32u+nGA=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;6:1yi6TP6HD+urVLhEXsXJVfdIq1XEp9zIpBnyQk8KOmSZD5Dxx72z/qEW0XWfYU9DIbNgEewxoni4vce05Y7QbyK6LZHjS43HQ6f4ooTUZk2yWgdta8HJFqJ7xXwhrxviMN34iKna3qXcsY7nhROmF3q48zdXC1GIV+esAdOfGImcggyYsRIkcWC3VufTR8i3K/+YvHGe94mZfOP2FDuaXi0lZ4rG8XHjd4gSFgjQUJM33dUd1kBK/x5G/YxmSiKRcvXPxfjHMBaYuDD359CMsfSgZXv1tRXMQuvQcjs+zrxDKgQaBDifSyF5kyfSkOZjORy9JIQlT9nfpw2DcSr3EnuEeeC9z8qkjBIxj+gKXeWSWbDxxJe2gpcmGctmiSray6UADZ7WS/2ibqgJVRrxr6W3PgLVXY78jkZqqoGPFQAOwWlfNwuEXyWB/Jqk/aIPIlOgh5VedwTCv05I6xTFXw==;5:/ICHMrL4N8RArTa9rwiUYSDVeuhGWB2DRSTtdb3zkSDhuvAB+QcSr3DGDsD/WhewV/jxw1lb4i4I0reUTdVQAUTCkh1KqCT0QEemqSIl5+qfouvjnlPqv5ZqSP0OwXmmXdAgLmXECeOf1OpRMr0XXzbvOn0FjTVaGWeHx29rfTE=;7:I7Qvu8ZWhpqklGOsDRQ+v74p2uc8YT3o+RlrIvb9eBwztAnhFbm5u2a2yWMC5BNo2wO6xA+SJUYZL7vhcLs2pe6T8fI53eDrml5Cg6S3AraG1jJZegwnD8qz8Li+7dIrw2Lvg5IiK2GCL1YjOb3o5f+YwygcA6Pzpn5Ex4rkoEZtg02f0XKs1IdcUf9qLYvvdze7Ckr8whCsbzpRlJO8CcVBumuA61R5A0hwZCOdXePPp/qW0eI2x4O1rcbGqtFR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:KW7CmyxDm9XHKeJdXvmwTdgDAF7uYDjeec6nBrlGnSOgK3MuRyHhHOMPIY/tg0bTtesNzDJEzgoPAxxjmUQ6oY0gZ9Hl7P5Ssdxdkzd8S8slLvrg4suGyxz9jo/zQjb9uFko2owdKkJsPkUHSbEVYd9kKzPg9VRZhr64AvtoS90=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:50:00.5483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc9eed7-6fda-4bc7-53eb-08d622cc42fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.2018 12:38, Dmitry Vyukov wrote:
> On Tue, Sep 25, 2018 at 11:18 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> On 24.09.2018 17:44, Miklos Szeredi wrote:
>>> On Mon, Sep 24, 2018 at 2:29 PM, syzbot
>>> <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    6bf4ca7fbc85 Linux 4.19-rc5
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=159149c6400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>
>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com
>>>>
>>>> WARNING: CPU: 0 PID: 9445 at fs/fuse/dev.c:390 request_end+0x82e/0xaa0
>>>
>>> And  there we have the bug likely caused by the set_bit(FR_SENT, ...)
>>> not being inside the fpq->lock-ed region.
>>>
>>> So that needs to be fixed anyway, apparently.
>>
>> I can't confirm, since I haven't found yet the direct way, that set_bit() results
>> in this stack...
>>
>> We have one more (unrelated) possible use-after-free here:
>>
>> cpu0                                       cpu1
>> fuse_dev_do_write()                     fuse_dev_do_write()
>>   req = request_find(fpq, oh.unique)    ...
>>   spin_unlock(&fpq->lock)               ...
>>   ...                                   req = request_find(fpq, oh.unique)
>>   ...                                   spin_unlock(&fpq->lock)
>>   queue_interrupt(&fc->iq, req);        ...
>>   ...                                   ...
>>   ...                                   ...
>> request freed                           ...
>> ...                                     queue_interrupt(&fc->iq, req); <- use after free
>>
>> Something like below is needed:
> 
> There is a bunch of open bugs in fuse on syzbot dashboard, perhaps
> it's one of them:
> 
> https://syzkaller.appspot.com/bug?id=19aabec97cbf73dd0475d6e599113a7861c4b306
> https://syzkaller.appspot.com/bug?id=24aa489e6929205e40ec4aa52cd8f47897f2ad63
> https://syzkaller.appspot.com/bug?id=400d6a977a0dbd8836d7c7ec8481782a674ee855
> https://syzkaller.appspot.com/bug?id=ff9ab4a23afa7553fb79f745a92be87ba4144508
> https://syzkaller.appspot.com/bug?id=d0f258de27b6d7ccecbba09385b3376cc4a12ffe
> https://syzkaller.appspot.com/bug?id=e8077bce636d52d9c40e1ea904699c27b7454354

I can't find fuse_dev_do_write() there, but it's possible this race could appear
in another function. So, Dmitry, I won't add reference to one of tham. Let's
check, which will disappear in the future.

Thanks,
Kirill
