Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B47ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698F3208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="BgkpypXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698F3208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeGMOxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:53:15 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:47636 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729643AbeGMOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:53:15 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DEaCjX028862;
        Fri, 13 Jul 2018 09:38:00 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0052.outbound.protection.outlook.com [216.32.181.52])
        by mx0b-00010702.pphosted.com with ESMTP id 2k6t2pgkhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Jul 2018 09:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXYKB3wwYUIZV8Zpwfz3mRcARGRg8gofZmwJnIhfGPw=;
 b=BgkpypXIVpcB4lCyij1NwuLM0VTA1ifPbReBGnqC2LLtn8IoBT1V5Q/NRNjgGeAjboHlPr+80X+vX77JgVJJZVtvl7xJJkNID9slFP3I/0AiWAXwO0IQLorhBt/pUnb4QEt81CvSo8G+UsY8GwM02feKKPZvzq7LvGS/0/qloXk=
Received: from harisdt.amer.corp.natinst.com (130.164.62.167) by
 SN6PR04MB4639.namprd04.prod.outlook.com (2603:10b6:805:a9::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Fri, 13 Jul 2018 14:37:54 +0000
Subject: Re: [PATCH v5 1/2] timers: Don't wake ktimersoftd on every tick
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        harisokn@gmail.com, bigeasy@linutronix.de, tglx@linutronix.de,
        julia.cartwright@ni.com, gratian.crisan@ni.com, daniel@bristot.me,
        efault@gmx.de
References: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com>
 <20180628164036.27378-1-haris.okanovic@ni.com>
 <alpine.DEB.2.21.1807131354560.2242@somnus>
From:   Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <cba32de4-7b04-52d3-a068-909d675604f0@ni.com>
Date:   Fri, 13 Jul 2018 09:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807131354560.2242@somnus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.164.62.167]
X-ClientProxiedBy: SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) To SN6PR04MB4639.namprd04.prod.outlook.com
 (2603:10b6:805:a9::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cefd708-a0c0-4420-fe42-08d5e8ce3859
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4639;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4639;3:0Z/r5n7oefdBrbkxyumrrQADjHc4iOIQ93v7mZL71eSwVNDSt6jgysc07rFXZWzqpTpdczhDel/MylaRquBdAirjykefkUAX57l5SwJond+eqDQ/jzqrKHMxLcbHBLvTIT6GN/J4fNCr6nIeqnJe0oS/Vj/jg2aYsCrWHVOCOIwaois8ujScX/xwZxWin90dK04DRWi3XYORpB7PvzwP8bVSRei77/GBRJdGUidJR9D2vebLMNqO17PE1lAA/KtS;25:pFe3A1XOqDFODdEKE6EGp6RqQLuaBm7DltCvZzW8D4xp2EnZIJ807zTcNRVTXUp4Ck6Kbo8HzTSHJ6Dj49aiht9+OOu7Yp2UaUigXmnwbW9eknQ5KHRxRMamwH443wbdUtBsqUuqa/ZmaOq+WO5YXn1cg3eTXKXcYI8CELeyBXXUbz1twYfdBa/0J6epcpWXKtl6ggRTxbBsYqmGIt2xOs3xhmgK5Ou/g/p7Tt3x+nTKRGYX/aVza8K+AtbPgClZfGAaO8ow6YTR15+3boGqfALagmE+aCpLjPOI4SAf3sEQSAqgbKUZPBehU8LoVQSCAd9QShr3ch9wgFHA5vvEdw==;31:RTrKphai1FqKu0lgAtROZ6waKPw1qIoZ9Q5YjTayw4cVrURLEaTHhP6Ws3mA8FCd6RNOyoXTWja0bFz9cqzItlI6qi2E2PV5B6/dF7JM5nuo/r4PA7CxssryB7EEBhywfLcj65Z5ERBCyvIG9wmpcm7uF7Pkl/JSTtLkGQINurUMVbv/uFmX0qqDOL9Nr3TllDYQNrSYA7kmEdo2kKTAi/ToxSPmpNBhHEwHEpVh0dA=
X-MS-TrafficTypeDiagnostic: SN6PR04MB4639:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4639;20:7DL/HEGBYcT1LTNNvQo0v5dOgkCAWNaqj6zfAMgBk0/GB9/aIF2sIAM4tOrDIaOKygJ8d+CPQ8HhuzGMy87x0oZQxDukCLM0Yfc3Fhl7KWlSQA2PdnKScbWBB9eV5M9bDzCjpeEjZgVcZVtT/GRL1p83u+0uKiAUl/6cKKNabTflNLC05/Ed6HIXWrWT4mAgTeHwFiHRsW/GMmMdwkHZpFCMxf2BdotfEDI1HLBzKRYSEhFvFzN+lNzdLCrQtfwfKcuf4bBBAbDWG2SjSHqPWzcdLBuzosQWY80UOQvfwpCFt4xvvq0QWkP04LNNfHxr5flv5Tpr1VZK+mjmfOCzToVQjTxhKYgUS1PjMJzITDYd29HW7lp9o67UAEqzs20M4MDuASJFj2WtyjKk32gMTMg+kt5bKkKnQaFYAF71F9trrEq3usmoky+A1Zzha9EmesKiT9mAdymNgF6k5fcemmR6myZegNLC3Gye5TKivlKGuqW1YXX44Mxh0vYrZSK2K1O6GMxsHVV41KLwm3oS2SPl6t0nXMcIZRV2qpmhprEYh+Z4gom49P8+smF0C6GmtwxIzs/evVIhUuWtOpKJaTOKieH1E5LP9J518N7OARw=;4:K9B0KUgyyS8NdgQg3wGiyU+AHQmZBzuUy/oYjbtxWNwM/zuRTbF5wjAd5aZ4KReyPdM5GM5U7PZ2FZW23Ti8eZmD9k8Ng/d2DYN/1E/PKy4aiNHwZnAOhkHlwVpwT1Vm+wEqCFv/t1NRFgbgETMcnL34Zo5ZKLGuUomeX3sr31Q9fJTC5DlYiBvW0m+A6qsX7D79LcebY8BQsQl7JCMMOmdA8l8NN3D06d4gJ2biaz1YcK//SC3rPueOA8Hhn28lzW1AS71Y//k2WOfl4Cne4w==
X-Microsoft-Antispam-PRVS: <SN6PR04MB4639E4083DF7542DD3712610E5580@SN6PR04MB4639.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR04MB4639;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4639;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(476003)(2906002)(446003)(2616005)(316002)(11346002)(3846002)(6116002)(486006)(68736007)(478600001)(4326008)(39060400002)(44832011)(6246003)(386003)(229853002)(53936002)(76176011)(6506007)(53546011)(956004)(6486002)(23676004)(2486003)(52116002)(7736002)(64126003)(5660300001)(52146003)(97736004)(31696002)(31686004)(14444005)(86362001)(16526019)(305945005)(65826007)(186003)(81156014)(105586002)(50466002)(106356001)(81166006)(8676002)(8936002)(67846002)(36756003)(58126008)(47776003)(6512007)(66066001)(26005)(25786009)(65806001)(65956001)(6916009)(230700001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4639;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA0TUI0NjM5OzIzOnVSUkp3RUVOMEtIU0NuZWI4ZGZmYVpoNVZX?=
 =?utf-8?B?VlRkL3JyWnowejd3UmZNeWIrVkN0VXNlWmdIelZORFF2cHZxYzNCT2xOYnE5?=
 =?utf-8?B?dW01cFZaYUN3NDJwRHBkU0wrdkFIK2tqUFpQUU5GdXp1Rml5Z1MyK1lLa0Fv?=
 =?utf-8?B?dU1xblN5LzBiUVM2S1diRlpaY3YwSTNHdDdkNUVmUE15WmpmK2JtclVTRC94?=
 =?utf-8?B?cEFGNGV3N3BGaE9HTUhzN1lQdko2dHdtRE9YdHZUVExzN24rclFTUnZKbGla?=
 =?utf-8?B?blBPVkk1ZHp5U2JOcjh6eDVFeXZPMzkwTFNSS2hmNE5nYjZBdEdYTTB3dWRj?=
 =?utf-8?B?NXhVSndOc3NjYlZsNHRweHVjaWo2dnVodThMTmdLOEkwSm5Hb052V0h1L0pH?=
 =?utf-8?B?amdFbFM0M1hYbFJ0L1ZBTGlPc3FOR1BYWSsxRncvUnBEd05vZXJLM3dpaGpW?=
 =?utf-8?B?ZW9FZm5jbFNsN2w2d2gzZEtscnJ2clV6dFUvQUZBWlJxTlZrWFV4VVFUMkNo?=
 =?utf-8?B?YWdnRWtIb28wb2l6ZDgrQWw2M0FTL0VFaEtSbzRTQVVSZmZKTnF3eWNqdm96?=
 =?utf-8?B?eVNhNXJPdG9XWUJSSnkzVGlnWlFFK0ZqODBDeTgyQjhVUDJjdFlraXdEa1Q2?=
 =?utf-8?B?NGpXMWxZL0wxczFJcjNLR1QzSkNseHJRbmlvcmFTdEpvS2I2aVJ6SGZmMUVT?=
 =?utf-8?B?OUhLSnY1MmJkSWxzNHM1THNoLzhGZ3poaXg0cjF3SXozU0tQZ2FqN3ZORVJk?=
 =?utf-8?B?S0xZeG9sOE9TN3k4Uk9HeXhrUTg0Nkt3NzJHdFNHZCtibG5LY1UyaDhYODZt?=
 =?utf-8?B?MWNhYnp3bDg5YzRseUtnQmFsM2FxbEpCSnEyM2xBUDdacWVZVys5ZStwRjVD?=
 =?utf-8?B?enNqVlFUMmVTOXRHR25oM3N4QkpTL2U5WEpoeElWWWtoa3phQTZnYlJlOXFo?=
 =?utf-8?B?Q1E4MjlyU21UaElFNS9Zak5aaGs2Y2w4cVlZbWdwWTRRaXRvVXZiRHhFYmx1?=
 =?utf-8?B?RmJMenFVTzNhekJZV1owRmRhUWlEUlBpaWpMaDFaVVg0YytKUnVudzh2MUJj?=
 =?utf-8?B?MXBaWm1LMHJBS052cFl6UG9QT0U4dm1KQnlNQ2dPNnNGTnNFZkxkaUk3NXU4?=
 =?utf-8?B?NWxBczhBUVN5VnU3NTB6OG9XaXcza2p0eHYrSVlyNHRIWnhtaEk4elpOWDhr?=
 =?utf-8?B?K1lYU3NCUERtT2NZUjJsNDViaS96emlNOVdjL3pROHBNODNPS05NNnk2c1Ay?=
 =?utf-8?B?NGxNcG5uWmhacnFZTmM1eGZlR3RPc0RWQ2trNWJjYWtPeUkzeW8vdHFrNDFp?=
 =?utf-8?B?cjFJR2NicHRpend1NnEvS2Zic1k1MVN1YUEzbnpYYUVvSjlPOGVvb0VGNHht?=
 =?utf-8?B?SzN0c042cjhvTThkWGVDRURxc1lESjdnUTZxR3F0MisrVDJVd2Z2L3lGWUta?=
 =?utf-8?B?WWJ6R2NoSFhiSEhYb2cxMEJJb3BwcnVoaTdqcHozME1ZaWVJVm1xZ01tb1hH?=
 =?utf-8?B?amUrbWVEN1dwSzUzSWRoUy91clVoeDcrTitmNi93aUVzOTd4a29sTFM3WjhF?=
 =?utf-8?B?Z1dpendyWkxnLzRaeVFLME40d2Uzb3pMdUdLck5wQXQ4WldwaCsyTWZmY3pE?=
 =?utf-8?B?OUU3cjhzczU3dHh3a3kwVUp0Rlk2endXczJxY2c2cDl6T05vVENXZVBIaVN0?=
 =?utf-8?B?cElmeVFBRlJISkwvZUlnaDVwTU9iSTdiUndxNmo2L0FFLy9aWTVxM3paUUMy?=
 =?utf-8?B?RG8yM29STERnVTdvbW1ib3JLTnFIQysrczJOSUk4UDdsUjZYVUtvSU1JTWk1?=
 =?utf-8?B?V3JOSHFER2haNW5nb2pWekNxVGExRGxPdWJrbEhGVUFHMlBGUTJ5dUxaUWp0?=
 =?utf-8?B?K3E2M3B1Rng0L3BBMFlqZ1k3eHdNbVFpdVR3VDJqN2tLWW5tb2dzSkVpLzRH?=
 =?utf-8?Q?kPXjrpNdf5ziF4UDXV3YtGnONdceEc=3D?=
X-Microsoft-Antispam-Message-Info: Y7AXu9FF34NrwjQ8o6pQ/7hsbv6GnBgF288Fxz39ZHOEoZuL+A6jku1hqvInBKFKZViS7HndNyERzGhTpEUuwBcWcerPOrN4SbI7MTWLGZo1f7Xxq+xvjPEcxcMa+mi0fzzbkJnqkHXE5Xf96VpztHNqsLK5zYkvD+y3GflDZDx0ZOWJrwOaCPy45ZeHWzqzqM7LzFpS3fwykuPx2RkcN6dDNd5YR8K75oEPlsPcyPnCzBQt2pYkHrl+v6HZYEJ//Z+z65wY/yDW3f7h87Yepd7BTupzAu7sgwTi5zfNVO1HZbp5PYjjDtluKRdtRA28qZh5WEdBX0MLktggZbicUSgsYHc8y8vKPaCofmJabaY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4639;6:6BeO1telvIiJXKc42dLBkE2cMNJBvbmVPCCJ7IQuCamI+RTZos6C/4/DgDSn6UjON1JxyfWuK6xB0SwvTOqML9X9g4GY4OcvWk1DY+zU7lPeT/zf4SdPB4NGK7+FoRPOnBIQwfsDNHf/v9p7jHmaKTP4f7hSNeolqMU/cl1pmEX2t3X0tWq/etaHq5Fh6oY9t2WsDtcEwwTeBOewroJyfvbOAsdao7+hFy2pgq6+POMcFDWcp8WRB5J/4497vJLsiFWkKcTihuIQ4ye2R0j7VOwCxSO7gZG6VHN92Fx5QDBm1WaAR1Hk+ka14SYHCFa34vOHQ6VBKLHCtCx7SGHOC1jqGQcZNzt2eDtOGLPQcDzzLRlvSSF4PiJzzK+CdMsbgb+IkRpC6ErKSSUzD05c4a8IpV8cwHtRN9J4TWhNA1u1bqW+BLYtJDV9USPjGM85+OSDlmHy1oPaKrbe09Jy9Q==;5:S9HeAujRqR87/q08FyI0QjXVSCOGKsJyVnZg2oQLAJChBruhmwO9I3xy5FRPS/HMkSVkrUEENx16CtZFuRzx4JOMGCXoWaU6RvNsE3BkF1O3T7ZTnZ/9yIkgNrvx95nEVEjI/1xnegfiVggh6jq+Hy7MUXQsmRtVBw/qYx/h49k=;24:kfUsiAT5APozZHbzvrk5fSkO94Tvobeem5awqazNuGUdSjqfl7HSXRTvsz6LxyHL//J6x8gDeHwvE+pSPrS68XpOgjC+ORXqdrHlxgSxh+Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4639;7:j/wzaPDyrUbnngx2CRW+Ab1DwSgrdyKPQkR2e5heNulfkEQO/sGK9eOGhOdbVX5rz0107UxGKPkb7XJEVtIDxSPzeGw61JpKpNQF1aOIAYPpSvmLr1UtuWE2kduiUt9gCNYb4DRpGsaQsLhsDc+mitx7aMHDgcOmJCup3lCww13jtslVPS6ng+J7xGlCeBMJoUIlXTwIIJJHlNxbTd3k0wVGDwKzSrO0sJvyIGS9Fz7UqcDcZ7ixYS93XRSwXSe3
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 14:37:54.6490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cefd708-a0c0-4420-fe42-08d5e8ce3859
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4639
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=358 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds good. I'll keep an eye out for your patch set and try it on my 
boards as well. CC me if you can.

-- Haris


On 07/13/2018 07:01 AM, Anna-Maria Gleixner wrote:
> Hi Haris,
> 
> On Thu, 28 Jun 2018, Haris Okanovic wrote:
> 
>> Collect expired timers in interrupt context to avoid overhead of waking
>> ktimersoftd on every scheduler tick.
>>
>> This is implemented by storing lists of expired timers in the timer_base
>> struct, which is updated by the interrupt routing on each tick in
>> run_local_timers(). TIMER softirq (ktimersoftd) is then raised only when
>> one or more expired timers are collected.
>>
>> Performance impact on a 2core Intel Atom E3825 system:
>>   * reduction in small latency spikes measured by cyclictest
>>   * ~30% fewer context-switches measured by perf
>>   * run_local_timers() execution time increases by 0.2 measured by TSC
>>
> 
> I'm also working on timer improvements at the moment. When I fixed all
> my bugs in my implementation (there is a last horrible one), I'm very
> interested in integrating your patches into my testing to be able to
> give you a tested-by.
> 
> Thanks,
> 
> 	Anna-Maria
> 
