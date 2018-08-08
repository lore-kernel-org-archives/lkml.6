Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F5CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C64F21729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SUmTduri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C64F21729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeHHPkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:40:55 -0400
Received: from mail-db5eur01on0131.outbound.protection.outlook.com ([104.47.2.131]:20054
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW0WOLFthiKNMQomc+zu4rJAI+6PA5dqVrsYRoLFDfY=;
 b=SUmTduriy/ZWlX/dg0vUry7PJQpMQ02lRshhY2Ef9fZ1bna1cpgMAGgyRMh5TgNy2LigaxGeM889FPjj7w3BU2JfRoZMxL/I+yjhqZ1Ezz9wZSlcLZOGW2gnAYTC8Hs92Wv+ynlu1NV+3rQxBsdy184aEab5M3yID9xh73DZ0bQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 13:20:59 +0000
Subject: [PATCH RFC v2 02/10] mm: Make shrink_slab() lockless
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, mhocko@suse.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
 <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
Message-ID: <4ceb948c-7ce7-0db3-17d8-82ef1e6e47cc@virtuozzo.com>
Date:   Wed, 8 Aug 2018 16:20:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0016.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::26)
 To HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84edffd3-7187-4dd2-4d2b-08d5fd31ca6e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:w16ffdMt0MlHNui3JiMf/6e0xp5d68XA71Fa9BbmfF+k1BonhGpO4mryymUyJxVP3tag8Nry3oCbfN3VlYx2lwDrVJyyt4NoZawLpRqQXbrfpCzvrDi5hDqPUjwwFZ2ftht1eQK8f39wBNNkxP1obG4PfsS+TUSM8X9vbWlllZsnOEBL8LvsK6J4y+JCYlZ5kTvFy4cXEn3iuyYoV5E+rQU/q56J8YS5cdF1UNKWqnLIYosGG/68sR+W71pzrXDL;25:oM28E5BuuJD7q0KmIZcC0/keKpd1Ub1ylPH8jvC+RwoUvOFXU/FGWfDBGUCwWcX7Tea+nE5EdRMoTLhwj3m2ueNTZtFNQUXhH/ebRIrOnMYS8S0WaqT97DRkKDK6Kp1i5xiPlJztrgcYlVpwLNW2HWAEMQIb18hjJyuSuGaz/rmCpNDWkf3AOIw8wFbHU3Fa6rBFbO3q7rdkPvqSY33c3QfFi3sOqJlhKk2HRUD6hF3OXLLSMJ2NhRtLwXU0RZYLLCrWzz8CS/DaE5AkLTAvIxIcL8bPfglxItMjYU9tcS85mp0JpoF8O6SUs3iABhWmg5wHRUc10/xJK/xY8TgSCg==;31:qSFmQE59yEJozo7ZI+SoF1TjeV0Ge99Kmc2EvG7RqLgjBqddz22g1YIy10MQCsCdIIYGwRQbyY7DZTztzvaloPPyHeyLm3C3YJncHR+38tjXuI98/utoam01sA1Y0/IjOEbTsaSqQm5UQNHatULO5gU59NykqsDyzr0Nt3g1TfYoyYn29rmU/fX2R5vIrcf9nTCsp6uXFFCzthVgMzShoWo4C0eQLdXIElxBlRvPlB0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:uxSiRbuNq9g+t+GGB6dqbT7WCFaVjdi4FiBx7kgQIEmlewVJmB/UcLlcG9P6CXjiZfr28LPuk5c4i0XEo17jRISs/vNGtd5UlXNhHwOn3LEF8k/s1Jm0Ondxx8y5ixOqW4KQrRgAy/dF8ibeQ9S5QTS/TWIOjuaDVYM8cq/qTbqQZB+hEfU6Zzse2aXTRC6ZDNw8V3oUfn11thjTRWW+A4RNCktJXuwK5FY6WgNl0Etv6qirmjUDTnY7PFlT4sDkemO+GNNxsxH2qqkB1ac28wdV0xrJ1KW28nzSuA4VKgnxTIK9g2OTng3nMtz0Re6cCuuZoC8xTzGGUVrGtnNte9w8X2v/yDbVY5E0Rj/hhtz/adJDzte7l2zdp9U9yXLpUyFSWf2iLTJi8tpOrHh92omtnfnAfoMUO5Jhgnt1TbmB2nNq60PvArtLuoVTorS8E4to7/wxtM8vltg/u0nQRaYJV8Ji0hpGRfEsT53IP+UhW/YicMu0nGW3lZyie9z1;4:S/6o0zpfGWREuOGYy7IsOo7kpt7CpP/3ipPfCvMqt3x/MGK51GKX60YNdVd/IrIO+8viiUj8YoxODxcDDYMjxTLuhGhWM8VdtRnetZxB1sWAFs0CyXuhTlLKviEv9W7gHKmasb2obWr+Y44bdP+kPHi9bxFoE2jbzKhdSFPx3tQ81o6TwrNFS1QkhB3rFs+HJajTZ1BQRZGkU/3o6FJzT1A02d2vfVXAXx54CCAQGbsDBI2blBGLAXXj8ITsMBhjhu3VnQjXFA8SoHCxJsN7/Xdibv4PdGb0fxdXaPMOT2ESYzFu+PWZmFpWQVsKrb55
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2026CEF14976D47FD1663FE1CD260@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(136003)(39850400004)(396003)(189003)(199004)(2906002)(39060400002)(386003)(6486002)(58126008)(26005)(478600001)(5660300001)(77096007)(16576012)(68736007)(305945005)(476003)(7416002)(36756003)(7736002)(7406005)(65826007)(53936002)(186003)(16526019)(956004)(31696002)(11346002)(2616005)(50466002)(86362001)(486006)(446003)(25786009)(230700001)(66066001)(14444005)(47776003)(52116002)(97736004)(3846002)(31686004)(64126003)(105586002)(23676004)(52146003)(2486003)(6116002)(106356001)(76176011)(65806001)(65956001)(316002)(6666003)(81166006)(8936002)(81156014)(8676002)(217873002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6OFlnWnloMHcveGFJM3VtUlBZSlFEenBG?=
 =?utf-8?B?NER5WVhNN1dXV0JRTUlqVlUyUHZkZ3l2UCtEelNQU0RFTUQrQjFURjNQVDlP?=
 =?utf-8?B?OGpjemNsQXlRUXdSd1Y1a1J4L0NVUUZVN1RNczhndzZ4R1g5RGpUQXYrQzVJ?=
 =?utf-8?B?ZkZCd2FPN3htaHVEQXFsVFpCcEYwMDdTQTBkQVdxd29lV2tEZkU4bXZjT3Mx?=
 =?utf-8?B?dXlleDJzekhxVW5NVDFvVDEwQUJCUGZybXBnTWNiL0VIVlkzUkFlMzBmcGVt?=
 =?utf-8?B?QzhYd21WZmxONXY1clFhazljVDAyQ3NremZHSUhrVWRwYnhxSnFSZC9oNEYy?=
 =?utf-8?B?enRhcEhDZlJjUGVXOGtyQ3lzSXZ6RTJwSXkvbG1Fc0l3aWYvaUpncHJ2YnpW?=
 =?utf-8?B?a3VoaXFGeFBhaXRmeUhLOThLa2RtZ0lMVlNPUmpFWlRmSkx5VEFyWmIveHpy?=
 =?utf-8?B?TDM1dlhOczYrcWR5aTJNeG5zN29aTkgrZmdXajVUUGxUcFpjN3lrczFvNHpk?=
 =?utf-8?B?WkFiaHFOQndmcXJDK3dOUmgxZDlER1JpWjcrd2syZjgxUkgvUjk5TzFkWTZw?=
 =?utf-8?B?WHd5T0NMa3JvRFZHbTN1cms1Z2pFOXlzT1F5SVFqRENIdmcyRXdhVWN2QU5r?=
 =?utf-8?B?SkJxRStKdzRvNkdZWTE2Zy9yTGxvTVF4RFZlRzBqUGNyUHlXVE9FSXNRR1ZE?=
 =?utf-8?B?TXRnRGVCTGttS1dHQUhib3pSK25sZ3FMemtLVHNmbzhMNk5tLzBIRnpCVmQz?=
 =?utf-8?B?WE9UMzR0WmpPc1FZdVFBcWw5RzNVbFRYM2Q0THlUTGpLUmcyWDRZcFdUNXJh?=
 =?utf-8?B?NGFGMnE5ZmFqQkNMbWFwTlJSM2R3OTRXOEVNak41VlFqalZMR0ZrTURhM213?=
 =?utf-8?B?YVpBczRuMDY2eGN5N3NBZFFBZmduNXBEb0k1dzdBVmxGU0RiVVExUVkzaDcw?=
 =?utf-8?B?VWo2UmN1N291RVBxVFBTZUdXVElwTnVDekJVdHppT2xac3gyQmFUYlB4N29p?=
 =?utf-8?B?T1cwZUpMTnBTeE94NnJBcWgxQ3IyMGNMb2Y0TDJkb1lHck95K05Oa2xzRmhH?=
 =?utf-8?B?ZHhBMjViUFJmZTVneHlheWUxMkRZUFRVcTUzYjI4WFVXaEdBT0p6eHV1VDJG?=
 =?utf-8?B?TzI0VEVTNmdjVFdqMjcwR0FEYWMweFF2SS85UWNVWjBxZS85UzhkY3RVb3pm?=
 =?utf-8?B?NEgxKy9leDJGditlQ3dMKysxNGxCVDcvV3Uxa3VqcXdGVkNmc3AxL1F2S2FP?=
 =?utf-8?B?MGErM0Z3dzRoanVaWVBhK1V5VWV3SENSZDVkclp0dU1TcHhXVVd3Wk1US0x1?=
 =?utf-8?B?R2l0aEVSRUtCaThIeU13eEsrRmNraFdncVNrZmtGb0hpd21HRmhvZk5Ta0ZP?=
 =?utf-8?B?SUFxdnk0bmFkSVZZR3ljUUhIeVZTVi9UUEo5blNtZE9KWDFCOGpuR21FY2tu?=
 =?utf-8?B?cjFpYjVWblhpVEN0bEZqSlRIVitkcWljS3M0eWpYVFpCbEQ0N2ZCLzcwaVJO?=
 =?utf-8?B?amtobXlmT1ZTUFR0MHRCZm5uSkVtVXUyMXdhOFZuK0ptRDhoRW04Z3gybGpi?=
 =?utf-8?B?TmF1eVRVKzhqNlNobjhINHIxMDJBRUNnTlZQcmhKa0R0bkJOUEJCOHd0M0pS?=
 =?utf-8?B?Qi9VMmdjYmFsdTJUZ1ptMExZZHY4UGtFNW8ydFRCWEg5eEtqd2JWSTBtdzJx?=
 =?utf-8?B?d0h5RXZVM0lJL0tQY1lPNjJGQjFGS251Sm4yaDBKdHhoa1RsSFlXdVpJUzZV?=
 =?utf-8?B?RzdqU1ROc1lTdnVjYXovZzVobEFxY2ZUZDZhUG1DV3N1eWhXOVNYaDFjTGNX?=
 =?utf-8?B?N0JjM2IxcmJ1SXNUMlF6RkI2ZlBiazJOUzY2VWdYLzJOMEl2TU1DMDZYTHdK?=
 =?utf-8?B?NHc1NXUwOEh6eGQwekVuNFE2cUZxWEcvTmdaRHliZFVreW9EL0ZCc3E5MEI1?=
 =?utf-8?Q?4xNBTzSrMalqVNSWYKIZh4e12KD7Arc4=3D?=
X-Microsoft-Antispam-Message-Info: QoOx+IN5vc8CkkwLStJKHimWnvrAqWUyLNW8fipTabNPyRrspvD3z+v6HYnX9iXUC3WyO/0vGCoOuw754pDIS3PQoPXn7A/piXAPhQAUZiIAgrGHiirE5xlAKD2w28AmHD690E83CcZ95A0+HTl2HPgU3reGztMmcqJEfQe12drpaJFW+hng0UDg+3opxPjqEB4whkz7HVegut7IMR/kvv/khYHgBcMOFN7Z7avOKebHcJnNrzPcBm0RIck9Jhg1uti1kH4k323vPCDqvCYoz7IuBJVWHNP+hLRmp/cAzggO9IXV6bl8YvT5tslrBX12JwNE/RKmBgjgEkATewqaOt6DFdP6v/e4G/oEYwf2Cg0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:wA3s3743zdOAnYioCNHsBKaS+6NYIy8dnUqh6m+NLtxavQpJPvxME3bZSH3Y8WChqW+WyRmXTJF/X2IHoPAFMkKK2BjuKbv0e3YcHsj+xXFZrzH7gBJXtC9/d/bQNQZ9ifFsP8djDj/wlCNO7flqWlzIL5QnSjMAmFWYWAS/RlarxoQurEJmKHocHxYS6SU+6UEX3QzlvUMIS8ilzHqqqO2Pw4SoaN5T6FrpiAk2OX37nwwTGDWiV4FwgZopaZDYjpoQjTxxxUtRQiI+5oGOC0Gl3KEg62nYtv0ddssir7pC4BNzjyOUl5TxaOPHJ0D0+nDRmw0XbVGo+d/M/qQVEuFyDpnlR19uUmhSLqLFQyXFNJsevvCoN4rOGn6kPh0c1sO5LVWjC9h1SbxoGgKEOuZIXVlWaSt+423+dmivSQE0KP82GlhKkzpZjzVuBdRBuwsi7UoHwhimrtRrkryDjQ==;5:+LwSBVsO7JsfcuELBqb0Kgd3GgVQGa7iQjUeZWBq0fDg1x6t+NIjmr/Gg000FE9SnrW/SlewU9J55LTJx9mEkyr1ISXSlCFYwHqGM3ykYEUUAI4Pp6Ej0Sci3JLItkhYjYkxSqMxfaQClaChhK3thgdleHBwzzfCyqU4OSdtBCk=;7:D+kKWM/4zt8A58Cm5KPsdPrBnGP7T5btQZ+nFZKYnpcZZATC+9N+1aWo5MhUiFl0BeEopQWnF1j4146H3cksh3+K5UF107EerfCOR4+kHtUFX4+zLeyF24OS2EbYhYZb2HK69laJ5RzS/wio7w+vlC40BMT/SpMzLBN8d/Yh1vzpvu2qTCAYz0ZxgLsCokLbny9HfXxKtbEWDXwZRZwIfPthk1ZOYEgGhEpoItplIktMOvowvMkbqAIumkGv1Sla
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:CFid3tb4mVyCAr34YSE+4DykIZZ4dpEHhEkObqiBLZ6AWIGhb7uDbhQrx1Jo4o8GcVer6ugOaCxUG5KWUr1UWlPp4pr7KrO602j5blcd16M7QhSTazvqMOGfh28VyZkbbtADHjf6KZORnB6lSpgR7aPdwRYW001RVe4anM8nWjo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 13:20:59.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84edffd3-7187-4dd2-4d2b-08d5fd31ca6e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Added two more places needed srcu_dereference(). All ->shrinker_map
 dereferences must be under SRCU, and this v2 adds missed in previous]

The patch makes shrinker list and shrinker_idr SRCU-safe
for readers. This requires synchronize_srcu() on finalize
stage unregistering stage, which waits till all parallel
shrink_slab() are finished

Note, that patch removes rwsem_is_contended() checks from
the code, and this does not result in delays during
registration, since there is no waiting at all. Unregistration
case may be optimized by splitting unregister_shrinker()
in tho stages, and this is made in next patches.
    
Also, keep in mind, that in case of SRCU is not allowed
to make unconditional (which is done in previous patch),
it is possible to use percpu_rw_semaphore instead of it.
percpu_down_read() will be used in shrink_slab_memcg()
and in shrink_slab(), and consecutive calls

        percpu_down_write(percpu_rwsem);
        percpu_up_write(percpu_rwsem);

will be used instead of synchronize_srcu().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443cafd1969..94b44662f430 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -82,6 +82,8 @@ struct shrinker {
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
 
+extern struct srcu_struct shrinker_srcu;
+
 extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
 extern int register_shrinker(struct shrinker *shrinker);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4e3c1315b1de..ed40eb4b8300 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -332,8 +332,9 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 	lockdep_assert_held(&memcg_shrinker_map_mutex);
 
 	for_each_node(nid) {
-		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
+		old = srcu_dereference_check(
+			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map,
+			&shrinker_srcu, true);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -347,7 +348,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset((void *)new->map + old_size, 0, size - old_size);
 
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
-		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+		call_srcu(&shrinker_srcu, &old->rcu, memcg_free_shrinker_map_rcu);
 	}
 
 	return 0;
@@ -364,7 +365,8 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		map = rcu_dereference_protected(pn->shrinker_map, true);
+		map = srcu_dereference_check(pn->shrinker_map,
+				&shrinker_srcu, true);
 		if (map)
 			kvfree(map);
 		rcu_assign_pointer(pn->shrinker_map, NULL);
@@ -427,13 +429,15 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
 	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
 		struct memcg_shrinker_map *map;
+		int srcu_id;
 
-		rcu_read_lock();
-		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		srcu_id = srcu_read_lock(&shrinker_srcu);
+		map = srcu_dereference(memcg->nodeinfo[nid]->shrinker_map,
+				       &shrinker_srcu);
 		/* Pairs with smp mb in shrink_slab() */
 		smp_mb__before_atomic();
 		set_bit(shrinker_id, map->map);
-		rcu_read_unlock();
+		srcu_read_unlock(&shrinker_srcu, srcu_id);
 	}
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index da135e1acd94..acb087f3ac35 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -168,6 +168,7 @@ unsigned long vm_total_pages;
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG_KMEM
 
@@ -192,7 +193,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	int id, ret = -ENOMEM;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -406,7 +406,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	idr_replace(&shrinker_idr, shrinker, shrinker->id);
 	up_write(&shrinker_rwsem);
 }
@@ -432,8 +432,11 @@ void unregister_shrinker(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
+	list_del_rcu(&shrinker->list);
 	up_write(&shrinker_rwsem);
+
+	synchronize_srcu(&shrinker_srcu);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -567,16 +570,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct memcg_shrinker_map *map;
 	unsigned long freed = 0;
-	int ret, i;
+	int ret, i, srcu_id;
 
 	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
-	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
-					true);
+	srcu_id = srcu_read_lock(&shrinker_srcu);
+	map = srcu_dereference(memcg->nodeinfo[nid]->shrinker_map,
+			       &shrinker_srcu);
 	if (unlikely(!map))
 		goto unlock;
 
@@ -621,14 +622,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				memcg_set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
-
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_id);
 	return freed;
 }
 #else /* CONFIG_MEMCG_KMEM */
@@ -665,15 +661,13 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
-	int ret;
+	int srcu_id, ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
-
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	srcu_id = srcu_read_lock(&shrinker_srcu);
+	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -684,19 +678,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the regsitration from being stalled for long periods
-		 * by parallel ongoing shrinking.
-		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
+	srcu_read_unlock(&shrinker_srcu, srcu_id);
 
-	up_read(&shrinker_rwsem);
-out:
 	cond_resched();
 	return freed;
 }

