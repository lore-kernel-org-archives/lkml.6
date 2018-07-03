Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E08C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AD421A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dYL6wTGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AD421A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeGCPLL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:11:11 -0400
Received: from mail-he1eur01on0109.outbound.protection.outlook.com ([104.47.0.109]:3270
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932458AbeGCPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txwkAKdBy59g03p4GHZKqBNwyTpYnLav2Bg/yLyXDes=;
 b=dYL6wTGb6nZvUISPPLeO6wqCn3O/D3cgPmXWCpXtSdShCiORbB3r2AgyXvgt024T76qFZFAyl2//SLQZtEAbpVTC4E/QmRRfiRDL7eh2zR+1w/ULehLF0AaBUXhRIEG2kaeZQaVH5gNGavj1Ey4GJ8wg560QZWGzdAtqP3yrJM4=
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1332.eurprd08.prod.outlook.com (2603:10a6:203:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 15:10:59 +0000
Subject: [PATCH v8 13/17] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
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
Date:   Tue, 03 Jul 2018 18:10:56 +0300
Message-ID: <153063065671.1818.15914674956134687268.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::35) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a43f3546-d9f5-4a3b-ed6a-08d5e0f73027
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:mNSnryEnTQXpnKhSkZbWWsOX1qv2/kikSbt5PgRaM++nFEFShCVeX2pp8mRm22XgwYysTCwXQ1S23WPArennNHCLgxTzBOBDJHHH6Zn/MgCRNolu7f/KoBDiTO6svfAg6UFfyXcdq9V2MrYcpeTPOd8ia/Zcmuili6GaJGZyBigyIsCVgQiyMfvd2vF1+LTd4fWpB2qJp6BZj1tQjBJnK3EevTEvznef2Tw+aFavG9Y1RRR8eEfv2p2bVpJFzosF;25:yeoWq0Sv9pJ8EX7mLIRIaG2Xmw+8j4T9G0M9rdF8+F3secVEeU5AfYPVYLV1G3EblPc9F+vma53yzB9wrXua7sRbV7PyVEalVrV4/sl7OYCE6G7+S8CCMJ5GpB2/i6HS0RF2gzeG6g6s1tSuVwicK/AxuGL3iKw37PWLWmsOovzV0zwCkDAulYoZTnV4ulfMJVuT38p2ynD/noDqkG0zAZ034EiXVH07bvBWSh2dh8rGiDfqqE3y4euPxp0gvL/SVb+j8/a4dpdeyUyH779sFu50OV1ZOPJXNC7SdlvnyQ4St+WuKXYa5r8Yb2QH4YtjYC4vUEaSBX0TzL9vYO2uuA==;31:P0zhlwB9g+zGZbVS4F6OpqmPZ+hLYdnLnbt1Ke6cqQFn5svcB8uDayzyL60LR+33ab8YAGy1f8g6mVv1F2jTEJnMo87db2Y7FrXb60dH0HLwaeusyHvXfySvppC1YGDQqoxh4W98sH/aY9PzMlsTMxG9I1otuZtCgz9vUI3q3ExtGgFAHqTdQ7McYaT/7BHyTCLlQhyQ2sKPRUHoZYdAnqtp14CEgNhfnCO1SvOlg2w=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:IovUWvEzVRAE52AV46GxLkerNGgRbpXDh+Hl43mxfEPG+CzTqcmI0XN8eESQaWeU6mZVweplDmJrzpfO1N/k8HHVTNDoFREmtLiprV/GAaIXOrMf0EfHEFOO3DMPN96K6CNpmqy3wQ6ZCWZVuc031xd7YRiY2X4CnbGeyOQXmcE9coEa1mOnrfspLnSIIFtFjrju79BIAnErgTae9OqU/1EPgi4Mrh2rTsAZO2IXEnLz7F/Hyy6pUb2PASJFxTVCO4RvWN875S4/eoyNPsWlO2cyyE2+zdx6RM2BnrJTPGwon36e3Aq2Il2ixaYnItYmcJIN2iTualYpeBrF5+pT/U4/ohUDYoKPkF5x7SIG4iBA+N4m1YDB1EzAFBXqlN1f+po1vyRWGWvePN1an4kTxzC/yTe4XA8ZsXGt6Obr05VxikjnVjbJm3KIgzEFH2wCj+rbS3YNbgpTDdi0uu68bIFAnfRyuO1GPGjUBydEHuFceH/QbAjt1jaXmb5l+IlU;4:zpvOAIes6LkYUEqs9yyvYTqWMDdpR5ehYS2A4Ieu191VMROqrpqWG36AwqoPAiKu7ACzI2p2Uo03AiLubtCpzrblFTx6cKRsW70zswDg8Qgs2MRWpkb6wIJC610cXh3PbriJyXvxdysMcHilv96DaD8kx+0eiGDZpztfKAmYg5Rb6TCd+3AYYZrjrPPUYPnR/abtt+Xl+qsNBQnx8AcrAlLZb4XUAPbICfg1G3CWM5cAE5cANuMU1GBPc9irDTMiBGgEtLGsszOHiAO/SBGEmKXKo/nRScxyzBZ/PLPVl/WL5EmP9YJRqU+aC+tPBrMLe9T9pvw/ym8x3RjG4XF8yVEaXZXEfq96ndJm5/pQu6LeZxQTFSVpofTDOgtGzMmd
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133202DCE42844F05D308153CD420@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(136003)(376002)(39850400004)(366004)(346002)(199004)(189003)(97736004)(478600001)(8936002)(305945005)(2906002)(8676002)(81166006)(81156014)(50466002)(7416002)(7736002)(25786009)(39060400002)(103116003)(53936002)(23676004)(11346002)(52116002)(47776003)(58126008)(33896004)(316002)(186003)(476003)(446003)(956004)(6506007)(105586002)(106356001)(14444005)(86362001)(5660300001)(3846002)(386003)(230700001)(6116002)(68736007)(6666003)(2486003)(7696005)(61506002)(55016002)(9686003)(486006)(16526019)(76176011)(66066001)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6UmdjdHNjVjV2TjJxR1NMeHFjL1o5Mndx?=
 =?utf-8?B?TlVjZS8vYWVkMjhqb2M5TUtGUWZpR2l4Mkw3RWZkM0p6SjBwZkFGWVZ0bEFs?=
 =?utf-8?B?SDN4UitkaDFLcGZKRFByMHFTOHoxbXczci9ESzFhWXJRdWlhOGlIVThFRnd5?=
 =?utf-8?B?aWthS2Y0bWZFajFlNWdKQ2x2VE5RRXIwZEhhZlZZWkowYmNXU2FrZ3pXeDI0?=
 =?utf-8?B?YmowczdGTUdGRk1TYms0REYvOFRHdi9tZnJmOC9vQjhFb1pHMTJxa0FwYXR1?=
 =?utf-8?B?b3k4SE5IRXZuMWc4ZVBpOG5VSWVwT01aSW85Q2tuVkNvbm4zckc5MzVBN0g2?=
 =?utf-8?B?dDlxc25INTB0aWlJalprYWw2ajhac1NIdE91NjhqN0N5SVNCdlZuRGRKT0hz?=
 =?utf-8?B?ckwvQ045UHp4cmxrY0x2V1FWdzVHbG5YazFXQUtxVGFuNThCKytRY05MOUNs?=
 =?utf-8?B?emhDTWdIV2pYZzF1VTdBR29xeE1JVTRLMGZTYUJuSjRESWlWMHJGSnFRaUlj?=
 =?utf-8?B?QWk4bkpMa3BnZjg2NHhkVXAvejlMMjZPMnErUXNkL2RFRXdQbW9aODlhRUhk?=
 =?utf-8?B?OG0wVWQ5WTFUOVYvRXJpc3o4d3NVMVVzWkNocUpBUDFKUlhrVjdmUENRRk1x?=
 =?utf-8?B?WlBkN25OWWwvUFRQRzhkYUxtdE5HYms4d2E2QUh0eWZWUGg3K1lhMVkxUkpU?=
 =?utf-8?B?cHZiSElsU2FXLzh3ZXM2c1JHK1Z3Z1BjN0cwVEJVcWdrdXVxTDk1MWw3cmNz?=
 =?utf-8?B?SWFaQ3dCNkJqU3dIbTVIRFRHVnhWaWFhSFk5aDltUm1YTlNBSnNVc2lZRDZq?=
 =?utf-8?B?S1diV2dENnhMN0Jsem9JVzZ6dU5ybDgrQVQ1QmRDcjJ0eFllM0lDK3lzTitR?=
 =?utf-8?B?LzdYM2lXbUhQajB4Mjd6QjQ5TGxKS1NWanpibkJpLzhHUDNuSWxnMkpxVlFl?=
 =?utf-8?B?OTF5QTJFOFh0Z3UyMVpHUjBTbkx6SUtJSVdWT3kyZFJWQmRPREo0dkU0eXdP?=
 =?utf-8?B?WEJyeEM5TFFWaFUrYWUwZmIrRzlUKzl3bkh5TmRVckdtUGtVWVlmQ211Zytz?=
 =?utf-8?B?MmpmT01rMVViRUU5dkM0eThkWTk5d3hUQStibTBSRTdaSFVvcXAxVG9OcVV4?=
 =?utf-8?B?bkJHeWw1N1hHbE8wUmY5bk5ZVEkzUWFQYSs1V1J1RHdVaFV5MkNndVp3K2hl?=
 =?utf-8?B?K0tDaUgrL3FRQ1FQSmQ5bmtwVDMzMkk5SGdQd3hIaXBsV1QvcHRqenNKb1Bs?=
 =?utf-8?B?dHF4M1F6VDllVzZ6WDFvd3JNdWgyZ0FJWEQvMVFXSC9GeHBXWFZjUnZLL2RF?=
 =?utf-8?B?RmpMemwzY2NSRmZFc3cxZU44RlVsK2hhWkE5TUdrbzBWU0dTMVM5bjcvYnQ5?=
 =?utf-8?B?SUdjbCtMV1YvTzV1M3RQVnRCTkdoS3k4NUNEcmlkcHduaE53ekFyRmNYcGdx?=
 =?utf-8?B?WGtrT1RTV2Y5eUVqbHVmZlBGZTZGUGhBSkYxQVpPVlZ2MHByUmxaT2ZIMkpP?=
 =?utf-8?B?RHVRd0pqcjdoRmFkSDlqdFZEUllsRTdJeTllSFRtMU43czcrM2kwVG9yS0FI?=
 =?utf-8?B?dWxRZ0hFOUJxUEo3Tituc0k4RDhqU2greGF5amlKaU5sMGhscGNIUGY2bjlo?=
 =?utf-8?B?UEpGT0JaZFJadVI2eVpKTlZZR2VyWHFyZFJRSTVYcDVLUllDSGh3dmhDdWJl?=
 =?utf-8?B?Q3pLRnZZQWt1K0RzMEpxVTAwUmt1YTZIRXI2bXFKdExtZXExYklJZnN2VXRy?=
 =?utf-8?B?V0d3TUo1NWpua3pzRWtwaG9RPT0=?=
X-Microsoft-Antispam-Message-Info: SmyNzF+RCQRHCA9TDZy0IXPEiIXrFkfxXjJdYOJn3qbeooVGMdMFrxi70eUi6hsswLPeUD9Khy1foYOye+JN6YLpYXiNHuiSIo2BRCRPGkCjpos5VxDwSQsYXn8EiNMT43gZHWLdixwlkV4qC0ZWF6bDIcF8xfHrfn15epJg4FMsKRcfxdN19dknVLFzoRyJXXbmw+D02louKtFG6O+I2dMJQJBk7GQ3037AlWh7O6E5hr23Zg2+eOCq4iH4ULpNfTmMFS6RHxA09d/GQ+ALHy6YrcxM+5+LTCrCysbnoVYEP5QjgEQKxwcWojcMUyxI7vWN3qf3e/exV0QHk6gVGCOP+ZVBQuFXL4TvyQROkmw=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:wkpEKS7Jb4ETd4yILU0/Njt3OGP/InJHSoObXdvJwquuARqRuMtwiR+Bxmd0XsE8durnLWm2/oghrQC2SIuKbJe2+vdVInJUleq2Us0t61wHXFZqlyPbs4QYkqOnmYZX++a2imoIthg+A/3UsroJfoM4aH+sXVdPgk+Kp6xzR2Ts5pIEugLNYbZCj8I03foYEfBXQmO2DO8C6wafDlzHueuuybvP6I9t1YnMdy3O/TVf5uIwEAhNxeF8SRCZiA0X6XPJBjATXOkLMnd/zdTJF4OZbCej5Sip1xn2T/JKT1imQFmkwJ0csU6fIAAhyfr+fBlx+fqVsCv0BBA47oJNRWkcuckM894xhJIthM136dNJdKdZ1E7jJkeHKQYpq7UoGr8SGSGHwYJwuHOcWzB++VBGyKB9Qf+xJfXX9kvx6omoE/tbUgwNCaRG3VBOPmQu7+IeXYZjD0cbKCsdPEKD6w==;5:fJWUuiNsm5iHi51u0WzAQXNNGGzY+dNW+2NL3qDvsT1borqCdMc47xnfGBk4UX1hE7Vz85RmwpG6VXgNGiiV3iv9DgTbUsjym23j86pBj83n/XOHb1W5hfpz1UnJBjQ2+54mtV6S2l8aEO5N73BQNgwjydf0V9jECaGe7EXf9DM=;24:5uprbD6aV1+tXGtl2k55141f7B2jcq7S1bRlw75m0pX36azzUBAYExL9FjhKyZroJeI6nvEWQs+7/8LZDyDEHXxgMidFz+0HkNVsejvibic=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:0/E2Tz6tBSWvOyvnD/vW6lfxp+TNYUdnQJiWRX/1QVy1R4twcSFYObTVRtuXPuvrdOvlErFBqLBOqyg5PK7qOnAZcmnhca/Zw8GE4YV8i/xdbeAw6U0VavSQLk5qcez29DErh1tV3COWkQi66i19W+WW8RBuB0YdByQ8qGu254a2MZr4/ytLB/AOOOlI5vLiKgWRCmYYElRhpPoGtqMVlr/msxfI7XoBt+NWvOmkjTFiRVq4aODL192glFMA4KmH;20:HyLpxEVrx94D2m64nZYyRUJ19FRoOGK9K7MXflQkH9oL9AAYYB7vfUObFNYhJdywB+JjovuOPZSkANDokR9SVW2utK0gZN3HWQKBgEJmEisBngt5VauvFWjaBWUS71VHjWIo81N6iD1aKdpzO5l10Q7lUON/PiAM87vj6MOHBT8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:10:59.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43f3546-d9f5-4a3b-ed6a-08d5e0f73027
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |   14 ++++++++++++++
 mm/list_lru.c              |   22 ++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2c52b4313117..c6ea182ca54b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1308,6 +1308,18 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 extern int memcg_expand_shrinker_maps(int new_id);
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id)
+{
+	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		set_bit(shrinker_id, map->map);
+		rcu_read_unlock();
+	}
+}
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1330,6 +1342,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index fbda35ac5c17..b2d8be96e267 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -31,6 +31,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	mutex_unlock(&list_lrus_mutex);
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -94,6 +99,11 @@ static void list_lru_unregister(struct list_lru *lru)
 {
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;
@@ -119,13 +129,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			memcg_set_shrinker_bit(memcg, nid,
+					       lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -520,6 +534,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -531,7 +546,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);

