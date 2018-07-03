Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D46C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DF021A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a5+8GVX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DF021A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934011AbeGCPMC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:12:02 -0400
Received: from mail-db5eur01on0109.outbound.protection.outlook.com ([104.47.2.109]:41376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933986AbeGCPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYMLxZz3q21wtAr0uqaZ8PHYehZSeLRe1kIlsfY4X3w=;
 b=a5+8GVX4WAAVqe5E2ULEOuiJINl64Q+P1dd9nSoGcgwc5m6d3oU8gAlINalD/bDQxOvcWt5iFrkP3aV7i2gYFAVW1IuF+oQC5yfHSy2KHk6k4IR+ggknfHmjbroQFFp6h2ZTkg1iMGKpPCQMM9PUxP+qiDuFOhdrOMPepUwbuDA=
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Tue, 3 Jul 2018 15:11:51 +0000
Subject: [PATCH v8 17/17] mm: Clear shrinker bit if there are no objects
 related to memcg
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Tue, 03 Jul 2018 18:11:48 +0300
Message-ID: <153063070859.1818.11870882950920963480.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::25) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae705b7d-532e-430c-aa08-08d5e0f74fa9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:ptEWlPhrNOfqxgSkO0q3HhIEonK3coAtoZjhjrZJT4xoONtrNrL6eJOlzjh101zyt4XLm6hDKr6RVbRQKiScbXrZmoZ7nTTKGCwFPpxCIxamSdYWzilFrNuOKRaWZK+5Vrpf5kv/qqdrpgUpiAVsQyoK/qIaiCc76I8sep5ZQf1icFU/n3Rf75TEgd8+Z4Kvu6vvv0Tfn3Rq0tE5bliAXd3j4+B+Hn1l8qAm98rJMHr+0l/hngImw0xP973HfPB8;25:oWph7baQrMRFIg6MpJNhIJtwh8+oWW5sa1uE8jh1I+i9byCZk8jB6icXQLDtAQXlV945kf9S9F/1eW7jMpLtuHOU9qd5J4AA1nj0wN3j1qPPUw0JKUh8wwxLdCcRY4xKONguYAhbrab6cdsAIIwyGuyiidDNtftiAmIpi5fqxjg6EF6evLgOGir3v+1guXR/MMdfUXobMz0jrdsg+AN13diQIgJrHy0FAVpZ4sr0bNbzM39wXXn8JRTAGtNeiMSjzgb0oVchYYEQ85T2GXytMMoE2N1XVfVZ3QdMZLaW2hpjmaF3X8nDUcaGHWPZNJI9EXqJY3R+KQjjRHsgXm//WA==;31:LnL3G38rRT61lWTwDZtK749xtAXgvgEu0zy3IkOT1N/5lI05AxW4T9M+6VnkKgB19HFSlxBRTvH6XuNxIqpYeXzMLsVcLLUbJZ3Bq7l1Vj27wRvQMSJPV86Ber5Q3I3RekgJaDY2wTa0jdC9Wb9a4QVKTK5MKiuryyWa4WRLgrKXQhLkiH/PlOlMxG7fXoXDZZQB82Q51f8WzwMANZk/RXKMO8QxT4eCaePVkP3JBS8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:7/eKlwzAwJHv3ghERPs1vF7yoX5So2WXbrP0R/GRX/yK3YQvHfV00kqSbzhtwlV8N265texzkMjjp1k6a8RBIM1A0FstYmFXqc3cBaBX5yCaKlPm7DFCZY3BWPiimxQpPJWaM6VzA2yEPNmizYSxvr1Br3f8cE5o7UrDYJjxgw4WUj0SXqvzAjRKK9QKjCVvJt4b5rzmIG+vHuGnGNP0e9Yt+/uMw9FIYJD2MPylsgpH3Z1oSWkHof2rsNkupzBlrZhQOnO5eXSTKa19c76wpav+BUYX07d3idFXz8GfVlQBiAnnhapzSR88vrw3gXjWPFquX/FrvztzV7ibNfJdshdZr4DlmvjtxZvEpt4tkv8oJXfvgLmWfKIFcApoADUswj/JzGPEYx62NQWVJ710Fg7M9aETGxZkWiZ6D5dfk6TQkK4KHInYwJfLGxzcs88yC71Cjtnl/4/jQne7f2WY5BeyqaciZ86qsPqLOHf5C7VFA1EkUug3peGUFfXmpaP5;4:r/vOYBMO3XJIs1JiqCgitJLfS522LEO+mxIB6BRPMVgSDzUrCG49TRJuMSBwjLV+95HGJfmmIUdDoC40LlW2MPWGsA1jahsXMKPvr7dMZ8XDx4ulrZMGHN9JaeKRUvBh+0Ya5H5Hbp8ebDSHMQqaZpshOaKORiesZPlYlYSL1AG8gNfhSjPsWK8X3XDaHK3nOf5YcqgcQfquzykGUJZxP/xHG0GGKWzRoHhcY85sAAtdF9uz9SByXBhUteoSYHU8TbixdseYEkKpWaklNasFNNL/iJoc33+wWCT9cIv1gZpJFyqrWL0ihQQvLCmIk9jMs3hgvCGp6AKQUehUY/GqOXreA88M2SnmRjDM7tkx+9qCqP9kibVv5e+HhTZ7GjtfZ5UgsrvQg4FNfOpT2/KcFxq8vKzHsxlTYci3nAOzKxw=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1334C73AF33E06A8FFDCAAD8CD420@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231280)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(376002)(366004)(396003)(39850400004)(346002)(189003)(199004)(53936002)(5660300001)(39060400002)(6116002)(3846002)(106356001)(23676004)(316002)(2486003)(86362001)(575784001)(478600001)(33896004)(7696005)(105586002)(52116002)(76176011)(6666003)(7736002)(50466002)(8936002)(305945005)(7416002)(81156014)(81166006)(230700001)(386003)(25786009)(2906002)(6506007)(8676002)(66066001)(103116003)(68736007)(97736004)(14444005)(486006)(26005)(186003)(956004)(58126008)(16526019)(9686003)(61506002)(47776003)(55016002)(446003)(476003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6dHhteXJ4Z2YrYW5xOXVOYTlpVWVZd004?=
 =?utf-8?B?eXRVRlg3dWl0RU5XdnhwR3JJWEoxc1FwSkFpSG4zem56UjhVbUNWUStvZ0hN?=
 =?utf-8?B?NEowdGNiUXd6NlJqOEhxNXJqVmdBbjAvTENBY2U3VGxwSjVPUTRvNnMxZGNN?=
 =?utf-8?B?UnJpdm10Z0JJcWdSNUxYcU9rRlZlbjNubysrb3U4Y3F1VEFERjUyOWw2Mzhq?=
 =?utf-8?B?NmJZdHY4eEU4NFlVWEdOWStRdTM5M0kyTGFFQjlRSmZvOWVCbXpGc25tZFhk?=
 =?utf-8?B?N25VcW5iWnI5akdQVkU1eHdBL2ExS1Mzc01KRkhQeHNETzFjN2VjbzdPMEcx?=
 =?utf-8?B?R3ZzaDNQSTVhMDdyd0FLem5vNnRhVGNPV0VDTk52ZHdSeDNvbWt4OHBhRG9H?=
 =?utf-8?B?cnYvajdYMUlNQTNYRVRaaUFGZHdzUG1RRjRNNnFMUGt3dmJUL1lZNk9LcU5L?=
 =?utf-8?B?aVJXMHQvdG9PN0RCM0NJaUZoZHRiQ2NkeXhBaHloaGhXNkhHMjA5ZmJFamhn?=
 =?utf-8?B?Vk0rVnIydWg1dlBmOUloVDdkV0psZDIza1l0MGtBdWkwSHZ4SGZQRHlKNVZI?=
 =?utf-8?B?QkoxeW5BRHVjZTk4MTc4RHo0ZmV3WFdXVnR3RFplVG5LSnZ1RVRiT1UvUlUy?=
 =?utf-8?B?bTYvVCtvWFQxQWtEUG45bmdkY1J3amVDZ2RISlBqa09SejR5ckVPdG1YcWgv?=
 =?utf-8?B?aERidXlQSmxOcHh5ZWFFeUFWMUJ3amE4M01NZ3RQYy9hVFlYRm9GdlJoQ0d6?=
 =?utf-8?B?MXYwNHZSd1VHeGhTTXlSUGFTTFA0ZW9yU09KL01md2g0dThaRm9mS0pRQStE?=
 =?utf-8?B?L2tEemVyQ1dwY3huZ2R5MVZlMG0rZzJLdmtlRG5TSTlST2V0MGt2Zzd1TjVL?=
 =?utf-8?B?bTdBaTRZY2UydGprMm5EOFJiaDhRRVhnc2k2dS9Md2RTUVRRbjNoajM2OUw4?=
 =?utf-8?B?NEF2RDRISUxaenJqdWlKc2hiR3R2SEN2a010bDl1eGZHS2VCNFM3ODY1R0Ra?=
 =?utf-8?B?M09LSjdVSzVPNXQ1Zm9hUVpwZ3NzYWQxSm1yc0hZd2lQK1hqODhyMTJhbFNl?=
 =?utf-8?B?R2MrZDhnQ1hwVS9kS3BGK05pbHlhcVdtbW8yWmdoNWdqVWU1aG1yVmJQMysr?=
 =?utf-8?B?UWhLeFgvYTZwZ280NEIzRVczaFdsWFU2VlYvTkJybkM5eDJYQmZRbW5lcDF5?=
 =?utf-8?B?bmdra2J1d2ttSzByMkgxNmFkZzBkS3Z2RDcxbmFUb2t3NU9mVUtrcE05Vmc0?=
 =?utf-8?B?ampud0d5UXoxaGNST0dEQVhuUzNlZVA2a1RVMTNpOXNSVUxkQ0xQV1RIVTlv?=
 =?utf-8?B?Yk9TTkF2ak13WmsrNlJjbzdlWWhRcEJmSjJSay90bVRINzhFdURIM1BHeU5K?=
 =?utf-8?B?Z0pJUUQ5aTY3RjZqN1NrY2RLZ09SZTNDSlNFaktiNkM3VjdMbXpTR3NaNkJ5?=
 =?utf-8?B?N2htTnIrVER6bi85b1pISXVuNWcrMHhNUGhuTTdVa215dWpyYzdpWERvRVJV?=
 =?utf-8?B?WTRLQTgydWFaUWdaemN5bVNNVjlEbXM3ZWdiTy9PUTVsZTBoTk5IZXFUeVAz?=
 =?utf-8?B?d2traWxUVXVydEF0UDMxSEgzem5FUkl1QUF5MTZEN2J2eFRxK0V0YmszNTRj?=
 =?utf-8?B?ZlNIdks1VEtoSmRvMjVKOGowQUNkTUtFQUxsbWw5Rm5IdEp1eXJubG4vZlFH?=
 =?utf-8?B?andSOWorUHU5RGRGTTVVWDdFU3ZoQW5waSsrQnNvZFNKcisvTmdpNzVXeVIy?=
 =?utf-8?Q?A4GAt0vo+WHSFGoYMKjgYCy4Jpnaw7VpZlyohz0=3D?=
X-Microsoft-Antispam-Message-Info: MRHUZXXKpdddOyf6z6knxIeff7VvpbwIAtd9w15YqymDOuPmFHQduEUGXYVtLFw+jsqz0/Hs9wmS9AuqvJ/eFkKydoxGN48mFL8ffeR9F54lknAGrTAh7J3HV6dpo+708zbukMnUT4833Ie6qv59K5DAyORTZ3oApCsZ3Kz5JvF8FrQnpP7vMPPwU7dpiJomHMsIchwbursQP4Tl64wGqSzpeJbQiN3IdKQpLFXBBaZ+UvnYZH/lbyb2+A2+8r+lefwiP9jNk9qEcenhf+LifRsFmPyPDYjrflsvr/pwoS4zdaloCVFMLXenPaCT37eenZeyza61esehXzbmkMjGK890nfLExnhr6xj9L/lG2SA=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:yj2Q9djzk9sSK7JSJ484AWY4V2e7ms7XSHmjSA6RAOpo4yJzIJm0oyeftO6Lbx9RwfTZC6H3dobjb0edGkSHfXejFBlhW4b7W99VafZYI1hpTJEYIN5VPDtUDGdrGHwH+ndRjopeFc+vs47UcNyIfSwtsRAr/dPNXsTvl4AW5/yJgL2ei/8+rM/lv81N4o/rOLiztCltP3S1kM/eY3IfvxaKLMw336AER7S5n8QGw+vXzAIt4dNYkIn2fqBmlrbLPQP3VeUc6j088pMe7+OgkdB1p6fgUak3DoVUDPqgOfL/z3jeHqr876g4cv2GKlg5TGzuXSl6/bwdiy4R5tErDcCY2K2KbmqGoVeeth2xknyRFnUPWlHvKWomVseY3dS76Z3QBVytDpwfw218PZGrtOVRujwHV8TEAkIipNFYS+iv+P7hTHsDuXofzQQmRNTJbM+nZtKzuC5fwlc/Fdtg8Q==;5:xT5Dtm+j/4z7ACuchydnh7+7nDrJChYbUGCWHvrIlTQqCiBzr9vbI5b/kbq8AS3k/M76vWNJR1Ipbs8GaJKnS6IntSSm/xh3MdZql+ONTtbDxeFt4B1UEKTld3YiNXmys4HFbFusSPNUCFTayJAI3aPR0irsarfLblS8G7I23XE=;24:0UYatsaLvjpGBc0ka1TKS0D4y67/e2bj2f+SI0ea9jw6E1WgWmJZBLejRelcZpGUxtS9O9qh3TrmkJVUc1BMwoIzRWM7nC5oWE8UiLwlaSE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:c6FH5Tw4WJ6B0k2hvCRn28HFo/Y41gIBbiNDfxHz0ibl+5lmb3L21gutKUBtVKyjmX+l19WZYfcN6Vi5dBjEk9IXhUH3pZksnyz3mwNx0lYjR0PuOydkBLuFsxAKReai0VP8ShWvIG9/8o30erbKKyCmk4okglvD2nlslaX3AdM+bv6Pjb8ioOzuuubd6l5YvumR+1UaJfpGL8KGoDu4Unw15cUQTvn6e7qfAvvrWXJSz57IYj5KhMO1ORBpjH30;20:ePxKjQ3ek0W1C10L2X0GsexW0hjO+94jUCUHnkRupnWmX5jw3oh9jM9K3HO7BtYupS/0CQfJFIfU6RWStLTykNDxyU5obJr2s4txfrY76g10CCs47pE6u8osXn5wpL3zpfOhlvfIsQHFHcfb3qPNalZM5G5h+fmN71bNVDAjiEU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:11:51.3143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae705b7d-532e-430c-aa08-08d5e0f74fa9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid further unneed calls of do_shrink_slab()
for shrinkers, which already do not have any charged
objects in a memcg, their bits have to be cleared.

This patch introduces a lockless mechanism to do that
without races without parallel list lru add. After
do_shrink_slab() returns SHRINK_EMPTY the first time,
we clear the bit and call it once again. Then we restore
the bit, if the new return value is different.

Note, that single smp_mb__after_atomic() in shrink_slab_memcg()
covers two situations:

1)list_lru_add()     shrink_slab_memcg
    list_add_tail()    for_each_set_bit() <--- read bit
                         do_shrink_slab() <--- missed list update (no barrier)
    <MB>                 <MB>
    set_bit()            do_shrink_slab() <--- seen list update

This situation, when the first do_shrink_slab() sees set bit,
but it doesn't see list update (i.e., race with the first element
queueing), is rare. So we don't add <MB> before the first call
of do_shrink_slab() instead of this to do not slow down generic
case. Also, it's need the second call as seen in below in (2).

2)list_lru_add()      shrink_slab_memcg()
    list_add_tail()     ...
    set_bit()           ...
  ...                   for_each_set_bit()
  do_shrink_slab()        do_shrink_slab()
    clear_bit()           ...
  ...                     ...
  list_lru_add()          ...
    list_add_tail()       clear_bit()
    <MB>                  <MB>
    set_bit()             do_shrink_slab()

The barriers guarantees, the second do_shrink_slab()
in the right side task sees list update if really
cleared the bit. This case is drawn in the code comment.

[Results/performance of the patchset]

After the whole patchset applied the below test shows signify
increase of performance:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i;
			    echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
			    mkdir -p s/$i; mount -t tmpfs $i s/$i;
			    touch s/$i/file; done

Then, 5 sequential calls of drop caches:
$time echo 3 > /proc/sys/vm/drop_caches

1)Before:
0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU

2)After
0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

Shakeel Butt tested this patchset with fork-bomb on his configuration:

 > I created 255 memcgs, 255 ext4 mounts and made each memcg create a
 > file containing few KiBs on corresponding mount. Then in a separate
 > memcg of 200 MiB limit ran a fork-bomb.
 >
 > I ran the "perf record -ag -- sleep 60" and below are the results:
 >
 > Without the patch series:
 > Samples: 4M of event 'cycles', Event count (approx.): 3279403076005
 > +  36.40%            fb.sh  [kernel.kallsyms]    [k] shrink_slab
 > +  18.97%            fb.sh  [kernel.kallsyms]    [k] list_lru_count_one
 > +   6.75%            fb.sh  [kernel.kallsyms]    [k] super_cache_count
 > +   0.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
 > +   0.44%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
 > +   0.27%            fb.sh  [kernel.kallsyms]    [k] up_read
 > +   0.21%            fb.sh  [kernel.kallsyms]    [k] osq_lock
 > +   0.13%            fb.sh  [kernel.kallsyms]    [k] shmem_unused_huge_count
 > +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
 > +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node
 >
 > With the patch series:
 > Samples: 4M of event 'cycles', Event count (approx.): 2756866824946
 > +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
 > +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
 > +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
 > +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
 > +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
 > +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
 > +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
 > +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
 > +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
 > +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
 > +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |    2 ++
 mm/vmscan.c                |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c6ea182ca54b..c79c4a54c0ee 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1316,6 +1316,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 
 		rcu_read_lock();
 		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(shrinker_id, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96279b5f1f6d..45d153508d1c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -597,8 +597,29 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * After the shrinker reported that it had no objects to free,
+			 * but before we cleared the corresponding bit in the memcg
+			 * shrinker map, a new object might have been added. To make
+			 * sure, we have the bit set in this case, we invoke the
+			 * shrinker one more time and re-set the bit if it reports that
+			 * it is not empty anymore. The memory barrier here pairs with
+			 * the barrier in memcg_set_shrinker_bit():
+			 *
+			 * list_lru_add()     shrink_slab_memcg()
+			 *   list_add_tail()    clear_bit()
+			 *   <MB>               <MB>
+			 *   set_bit()          do_shrink_slab()
+			 */
+			smp_mb__after_atomic();
+			ret = do_shrink_slab(&sc, shrinker, priority);
+			if (ret == SHRINK_EMPTY)
+				ret = 0;
+			else
+				memcg_set_shrinker_bit(memcg, nid, i);
+		}
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {

