Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E386C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060A025E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CKdhEmxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060A025E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933880AbeFYQzV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:55:21 -0400
Received: from mail-eopbgr70108.outbound.protection.outlook.com ([40.107.7.108]:47776
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932315AbeFYQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM7ie3tf6cglyILKa/6gi8BDTKrh7N6/YdYUzQMd0yQ=;
 b=CKdhEmxk6Mx6bXgvx0Xdrq1CyxeS37L6U9nXu0Xxzjpa5aMDSfQ/tOyilcavkd0jT2Ev9kO7RFiikaVaLidLYUiVCGNBjjqHqMwHEbUVtOI68JMbBQN4YOz4bMFPQZ/56CefFEfdwOgnkG0vNsRgI62SKV1a/y9dIyz3Zfudni4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (195.214.232.6) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Mon, 25 Jun 2018 16:55:16 +0000
Subject: Re: [PATCH 1/1] kasan: fix shadow_size calculation error in
 kasan_module_alloc
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1529659626-12660-1-git-send-email-thunder.leizhen@huawei.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <4a19c76c-54b5-1a1c-0576-8222957d3873@virtuozzo.com>
Date:   Mon, 25 Jun 2018 19:56:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529659626-12660-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0027.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::16) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b033279-5392-4817-2588-08d5dabc6db8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:+GnwovYGR+kKMLoJHuoSe7fpLfJDTODOJnw7KLSpH3cuz5U9ND2gc+hzximMHs6on+F6J1MgDrCSEnZYOZi9AJusAQlCF5STgByLIFhhnRwBlewkbQnq13R8RFxcGemnJtEtaC3mTnTsxP43BJxwWTPqoksnW82+gEE24VgrCb7RACmUPOMPsH5eRVxpaclGBnZ5jcL2oOHTA9Q583pXA9tR4uIIk1yseX/BX0GJAPZ1J3Aoiipyq72TnYQymc9s;25:cozonLo1Ed7mo36LoIbsD+KKVzGbXzt6LnWQ42YfWNADUOOEc4lFNOt5HFsbUhH/D2OjFWUMObdmhaYDyLHTwvf3x0tefpgxC01wlqsVrhHtyUDpdu04VJmf48BxGuhrlw+lO+XHF+PMicslv+KHRPqTkSM3pW2bSzgh3ZtDJgVJBxh9YU9FDZPKlhMrboLQo86fq6ZNi+kyXJF5RekB8Gn0BtoJeKsr/k3WL62KTZbfh2hgfzX8fG+86MeR7lCR/6MSabJFwaOm6EwqAWYCnYSHWcIkPq5gCfREPy5Xm9fExMrKOS0ShttF6Cr4bmtBKR+jPKebiffAmCNFLnj8qQ==;31:tdQNzsIE3CQbm34wUCK9AY77K35E+KEmeVeqMZl6iqzSMAORTyO0pYl9CeKTgPDMNTq6RHTGoj4qPOGHm6tntLdSY1T8PGJN3l0q39I/LshBsHHi1dHaBAVTOMBQKxA8hYIPqxccJju0TXMiVvAqohgOrUKPyrsTV3JSB3fHQwkHEx2QP0lapGh3gcl3Hx6JWh9yIbJ7Kr3g6GHvZCD9uiTaNojvC0yz56qUraoO700=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:jGKleYUg6s8tFA11/dqsCPnjz9MSLqqBWZrHm+oErlSURtR89e8kLdVlCli+aBvQXP2xHn/mT9OfF/I16K6pUhGbrhsi64ZfRY4ID7GKmb+McW8SGd4A2HOaFdHV1sR6voBRfPNunYAR0V1mXxqCO9g6LfBkIPA/QhuwHjVQWZQ8rWBOft6t8cATuOY4VSLaS5l085t++7aq3/8R1NQ+/ej5GFgU1wXZST+y9cwg7iNLYfDt+3ZmYX7rlkdYfbE57n/CNrRgxY+hXLrX9h58cMgMnP7GyQFIHumzHyxccTPOwoOAiRZZC1XYvj9t/DpeVNOvX7AgVTxHyLhRssj7oxMXE7k4mBsJqJTYXONrSaGKuXuZF/CeSFOps/28Y5ldYHcitu7ylRW9o4JvzfVpHqLCbsnU207Z9b/SMgbdtKNz+5rvyxjDrTbwmxF82iD9VM++Cv/wDwmljcrBM5lj4mrA8/DB13FoLuHhcMdVIQpyvZtNYf2o3brJEkRLiBAn;4:QoIOYof7aZRlDsDvfMsrSEpDyfKeLmcCkw/247YTT5VbTMyuxMcNJzAhg+ehynRHscIXxDrq1+lzOM/9pWedgReRm2GJFS5vLbgijQ2Vw16KjpPkLsh32i+0MTLDLSx0Fej12unE0q1svOxgYEw01e0T1Mp/TNDNB9YBLzXgFMFyYs7Ld04VBri0z35aWIrPh0wbO/zq9n+4+eEsUttm8+BZ/+6aQ15aMmUkDmElHEDnvFFVNktEvQzkb1gBknS0zOpnl4d1330ooEL3AkV3tGtaZsiKUp/gf78PwroTL9ki2r1O3uRZk1ZwhEYTWPDg
X-Microsoft-Antispam-PRVS: <DB7PR08MB32585273FC24199564A466FBB04A0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(366004)(39850400004)(396003)(189003)(199004)(68736007)(105586002)(5660300001)(106356001)(65826007)(6666003)(8676002)(81156014)(25786009)(8936002)(81166006)(14444005)(305945005)(4326008)(97736004)(2906002)(16576012)(316002)(230700001)(54906003)(7736002)(110136005)(58126008)(476003)(26005)(229853002)(31686004)(11346002)(2616005)(6486002)(6246003)(486006)(31696002)(86362001)(65956001)(47776003)(66066001)(55236004)(53546011)(386003)(65806001)(478600001)(52146003)(575784001)(36756003)(76176011)(64126003)(16526019)(77096007)(6116002)(186003)(3846002)(956004)(50466002)(446003)(23676004)(52116002)(2486003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOkJBd2ErYW94TWUzc2xkanY4TFd2VmE5U1Mr?=
 =?utf-8?B?ODNvNUs2RmVYRVJYNHBvakd5TWZsWHJSRitTVlp3RTd0M0NjQkx2amdZN240?=
 =?utf-8?B?TUVXOGRsL0hWa2NnTlZ2MlpKWDhXM0tSeFpleEdUU0pWODM3MG56elJnVFVu?=
 =?utf-8?B?aWtYZHhEcFNYREJ6NHVabUZObTJjTDNPcTB5WUtPLzk3eEdQY0x1RWZxZEgv?=
 =?utf-8?B?VFRYL2g5TzR2ekkwNlBuOGE1eEtVN0hZYlpPUzJxWndSVDhnU3JDdWhQZTVC?=
 =?utf-8?B?M0U3L2VkNGt0ZmtrbHdTQmQ1WDhpeWRWVER6MzBlSU1teVYxWVBaYlJZY3NQ?=
 =?utf-8?B?Y1FoV3cyRStkU05DemlkT09BVUcvaUFXSWhlM05PaHBCdFNyM0ZRYURZRVF6?=
 =?utf-8?B?OTBPYXluODl1K3pEOTdDZWlQVmU3RzI1MkJOTFdvQWhpT21Ib2hLWk9qNEJl?=
 =?utf-8?B?OHpqVXdlcGxNU3hSTmxPRm8vcmZNQVZ4RDZqNVVyZmE3QVRpUEk1aTNXMmxo?=
 =?utf-8?B?dzFQWDlSWUQrb203NmRkSWR6eVpCWllpK1dHNTBwam80SXBxbmd0U3VzOStB?=
 =?utf-8?B?VTFic2UvdEM4Q3NQUkwzd2VXcEl6L1Q4NE5mK1lmU1dlOU5BUVBTK3dsVklr?=
 =?utf-8?B?RXRndUgzOGNYbzlrODRSWURONitKZnNybWVpeTZ3eE5lU0ZMeFlWNCtTTFA1?=
 =?utf-8?B?ZlFKWmVyUmtyNCsxVVRueUpublpFQ01aNjYzeEZKeWZuRGNoVm5rWUVMUTV2?=
 =?utf-8?B?V3ZvUXdPZ3dLQm12TjRTa1BXTnF3M2tabHhEN3lGTWV0SGQzL3NLZ3dYaU1z?=
 =?utf-8?B?dm8rUDcwYWxtM2NpTzhzU1puRFZuZDRlc3dCMlhiVERIWGppbUp5SlBRSVVJ?=
 =?utf-8?B?ellDRVB6ZXI4Smx4K01CZlY3SmpmbFpNd1N4a0V1eWs2TEwvbnEyOCtVQ2RX?=
 =?utf-8?B?YUI4OEd6dHNKQmI5dkZKODU4WmQzL0pPcVllNHRwdjltQndTR2hXVkNBNFdB?=
 =?utf-8?B?d3Z4N3NUQ0ZMU1VneGh1ZFl0eUtmM1FmVXZ6blZBeFpmeFkzRlI4L1RVVzhl?=
 =?utf-8?B?WUhoS2pqZXc3b1J0aTBBL3FWRmFvR0xwOStrcjhHY3ZaM2ZHelpLajVrQlR0?=
 =?utf-8?B?VjlPRVRhZHJMTUttVTZQeE92VUtFbmdzMERLak9jODVoa0xPaFdZanowQ0Zi?=
 =?utf-8?B?Z0RVSXlXL0w3aWpEemwvMTI5c1VLZDBzRE9lY1EzYWloNlh2Qmhlc25NUHk4?=
 =?utf-8?B?eDd5V29mcERMdlFNeWpDSXV5eUVRMmNIZU85STlQWGl2VU9ybnVsMFd6aXF2?=
 =?utf-8?B?emdock5GOU1UWXVxeVc5YU5kd0ptVHRQTlRxdnZ6dHlTMmFjSldvSWgzZHR1?=
 =?utf-8?B?bXpJa2JGQWdGMDRaUzRJV2lmOWdIQUVvRUhwQ0t4ckNEeG5jUkkzNGFwT29G?=
 =?utf-8?B?cFQvRXZCNURaSjZaZXFtNzRraWF3WVZaN1dRUDQ1RzdYbFpCVElzazdXZnlE?=
 =?utf-8?B?anpUSnFERHVWc1hVeTVNY2wxaUpBbDB1b2x6WUdhdFY1UktPZmd1dGQxcEph?=
 =?utf-8?B?QkxPUDhockljWStva0Iwek9ZMGFlTjFhMzNQZDN2ZDlFZ09OSzljaDVrRnhu?=
 =?utf-8?B?Tzh0Unk4WTY2bEZ3a1hKSjZzVnhUZENSdWxRM3AxQVNmOTI2R0RFQTc3eEV5?=
 =?utf-8?B?RHdaQnh3MkgzYWRBcy8zcG9jem5abUFqcWYrT1VRRVh0bVhWQjdmRTJjajBX?=
 =?utf-8?B?YWcwVDlkM0dqbWx3b3E4Y0xBRXc1NDFHa3Nub2NSWmxJSmxNdWZKQjJDNzl3?=
 =?utf-8?B?NkYycEI4S1pEdTEwcWpKMEFTU1Y0REhEMHhBNSswREE0cUFFTm5sQ0xkMnhl?=
 =?utf-8?B?amhhZnRKSThKRXRYZmM5azhFQVhhVE14bXpOS3RJNmRWY1I0R0h2MXZXN0M5?=
 =?utf-8?B?OEEwZ1hsOU1FVmVCSnFkOGpHbCtXMHE2V0x0YTk0c3R2emJVWHNuZExFUW1j?=
 =?utf-8?B?QjUyQU5mV3lFOGhGaHMyK2k4OThsWXYrZlU4b3UxNmlaZG43REx1U3VUbEll?=
 =?utf-8?Q?J9Ts=3D?=
X-Microsoft-Antispam-Message-Info: gl6orsb+kvS45RlydNwOUggdXg5gJqYfpBQ+qMmRfgYvKBLkhPd8iQFz/4JgTynlthqwxYw2dYfyMUyeKegV/JDNgSOEVjWY+5NZc3RMUAFHm4ou6YKwWDL1rJYE0mKupUkcoasnSjuKpMcU53vV3wIk9vKQLV+9DtCrAbB7bklq1Q1bDndW5W8Xk3ktsP1VCyXaOysp5zVHWCVekN68appYAjfTgJwyOwu2bMHUaBE3TebHdq4lTcMpTsRRSnjx1u3IMytj6iZLujj2kmHmK70njw1iTdM3VjXgA6rIdayZAhsuqXqDzlh7fpiEFlJTC4edBnfN2MDgPa5mIvoOl2Tr2sYiwJoqwFA/AfixwmI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:czFnNXlvm/tRfLOJKCJDN4y984Re2gsDLYTfu+BvHQOW5dpaoLckqavmXAz1qB3lL6Ay0b18P+gP8GkrSsgl0Zg0/0KChaURzr3nnVaOqGyudLPqOYwOK7Ar+LrE4hP7Ek8a9mbIgdhN7n5bldykztT6tDUp/6cmqInKNYcGikz4MavuZyBB26gE8bzRUcNbkZNBxehDU0RgaDkJQz6dQTH7E6qYP9ruHazjOADfAIoDyjECaTX3dHwBO3Sohxst/mj9tLx5H4mUfnq0fIdNGx7JBdWUQxhlnrR22eFzkb05b+qICuQR2DgSAiblxGEWRHy3oW2B2PXQ5VyxLhtzvT8rrR5We7QiSpFVJ6q0T6PdW1XrG8INaJ6MpXZWfvehhp36PowDa4bQfsuyWaBHvj8gzXVNYU/CI0t8xZ+4kVDwxy78ln8lxu5sJlwTy9uEtL4+zA9SU/rDK2cmnFWUHw==;5:6nV3TmfHzGyuQWPWy3fpqt89dPfRn15uZ05hPZps8NFZK7sD4AEAI/i/fCKlu4kYw4Bnf4OcZfiqI8k4jr68PYsrDMMesXfu9MoqBm0+IiTqK6fuxZ/omKbKccoD/AuNXNsSiCtrmuAO3lXHexd/rAIkrmOV/k/HM2lmwuqX3MM=;24:P/+/2V8D+9iHjjI9mQ3eGfQMQyLlIYOMVQDc372Q3XNmKwdW+i60dheYjhdw+tLfdaJXF0/0IhI4ff6UuNE9J4t0Sq0atKHQZak+wLyEANw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:A7DHPWZh0G4azGXYHZQk0V4TBvaMMaQUas0qv4OXj5D53wkwjVkOkyPQAriUDn7ng5TmRGI5I3uIGXvDItpbdpauAkN7bw1ifHcRYnM6c27Fd0qrMRpzFVwJh/EuMU2s+DJID5z5SuGCY3uuxxifycIO0awdtW1tZRPVnLXDEWlbGthXlhTZ2Z+O8NiJnaIUn3f1q5Kp0gtGeakkNyBeoiKqRs4GOqo/3pxzWJqa+LNYPVmY4xqL426vaFUdBcnX;20:QHXfFBxXDMtI1EnEGXG4000p7GLmOUtTm4mfu8qtmrICL6lne1AtDufTDWiQYYI2SJHrpsgUFQ5d7WhR/bZsACfYmOa1VoZQBeYNnVIJ1E322w9Wpm0wSib1JuXkpqdbGpbRgcdRiIKwUrXtN6K0t+CICnBE+e8/pjDEsJVV6/M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 16:55:16.4169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b033279-5392-4817-2588-08d5dabc6db8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 12:27 PM, Zhen Lei wrote:
> There is a special case that the size is "(N << KASAN_SHADOW_SCALE_SHIFT)
> Pages plus X", the value of X is [1, KASAN_SHADOW_SCALE_SIZE-1]. The
> operation "size >> KASAN_SHADOW_SCALE_SHIFT" will drop X, and the roundup
> operation can not retrieve the missed one page. For example: size=0x28006,
> PAGE_SIZE=0x1000, KASAN_SHADOW_SCALE_SHIFT=3, we will get
> shadow_size=0x5000, but actually we need 6 pages.
> 
> shadow_size = round_up(size >> KASAN_SHADOW_SCALE_SHIFT, PAGE_SIZE);
> 
> This can lead kernel to be crashed, when kasan is enabled and the value
> of mod->core_layout.size or mod->init_layout.size is like above. Because
> the shadow memory of X has not been allocated and mapped.
> 
> move_module:
> ptr = module_alloc(mod->core_layout.size);
> ...
> memset(ptr, 0, mod->core_layout.size);		//crashed
> 
> Unable to handle kernel paging request at virtual address ffff0fffff97b000
> ......
> Call trace:
> [<ffff8000004694d4>] __asan_storeN+0x174/0x1a8
> [<ffff800000469844>] memset+0x24/0x48
> [<ffff80000025cf28>] layout_and_allocate+0xcd8/0x1800
> [<ffff80000025dbe0>] load_module+0x190/0x23e8
> [<ffff8000002601e8>] SyS_finit_module+0x148/0x180
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>


>  mm/kasan/kasan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 81a2f45..f5ac4ac 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -427,12 +427,13 @@ void kasan_kfree_large(const void *ptr)
>  int kasan_module_alloc(void *addr, size_t size)
>  {
>  	void *ret;
> +	size_t scaled_size;
>  	size_t shadow_size;
>  	unsigned long shadow_start;
> 
>  	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
> -	shadow_size = round_up(size >> KASAN_SHADOW_SCALE_SHIFT,
> -			PAGE_SIZE);
> +	scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
> +	shadow_size = round_up(scaled_size, PAGE_SIZE);
> 
>  	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
>  		return -EINVAL;
> --
> 1.8.3
> 
> 
