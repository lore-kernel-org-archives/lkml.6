Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562E524357
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZazaCZz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562E524357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeGDPvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:51:23 -0400
Received: from mail-db5eur01on0115.outbound.protection.outlook.com ([104.47.2.115]:15438
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752019AbeGDPvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM23g4HvrEm9OYSq2tlzTHrsr8n+3MX5Bw7OiixP+54=;
 b=ZazaCZz63K3zNF9Ct4U0dUT9KNcr6krYYdVII/oYcWGtFGnENqjGR1oPYxcOEPMKG7GnuEHV/k+kMzxgpUPQ8DUyY4AFq+2yWwutKajcKAUOL6or5wukX66TtrC43xcUs0Hn37rJyoNDMLO9BBIX5wvnbH4CXHqa9Q6QFXcDns8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Wed, 4 Jul
 2018 15:51:15 +0000
Subject: Re: [PATCH v8 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
 <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <aaa98988-29e9-fb81-1d36-6b8bd7a371be@virtuozzo.com>
Date:   Wed, 4 Jul 2018 18:51:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::17) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd767f33-16b4-4f9f-e7ee-08d5e1c5fade
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:rmqs1+nEtut/lW0Yyh8kJHPs3/H+ImCrY47niWgKoJJi61YutPrx0WBLezTL4yrP3euY3DXJ35WNMMICdnNtDntqRM2G6w2lPLq4l+dr6ZTMt84K6o3cDLlUg/Nqwkb0/8/wQ8pR1fjNyPLFDEKdYIzVnfO0qTgRyBtYGMklv6J0eV7ixnZ7ArfzcZB3dHVDXkNhVV0ZN34xilweFXI1XgdRwFyny3fVvMRZz7WkKUE2+eTtufUqvbQcUf+D/M54;25:9JAYU7GVr2YOeTjCSIiPNhzxRQIipVY06lJ8Swlx1icKsRaCS3be1ugo4Uo7UFi7V7AkYEFUE33vZrm+pJrMzgm4xZ3MIy7vRU/fAEpaJaLbDIP50MqxD1ovVlwMQrefUm4aKt6YDVQIaVY5bCxOjFKpRWkaEkPWtyvVDwxtiC9KRnD84jzdZkCBL798TaxT6NVNLw/jC2p7K0h0anGq+ij13SIOXcugN/EP4bXmecFX+VSaEpdTo4Ljv10SvMrrkxY8YLWDksHkORlTVpcEE9E3AntleFJr1rgxGb92yQELyfeXRrTxwZMSbmgSVjTFeXAOd7lbsLGbWuBU10ZIGw==;31:6Cvpjzr/gT4542ueO+1KC1QN/sV1gnNPV26gHnui2zBA9Ybx9uQ4bzB8FjAMmvpKA1NzjZWAtApESHlFbWJmKxgToOxQhk5DkSQIh3yAxKKd/ek6LtJgmpmYla/6sqOna0izenR4Ys1whnoqWo/zIHp2bw4vIp/LNjTTxoQvSuK8XQd3A242wrnzHA+veBYT00TYWaur7QEPxZnnDFPrvh5Wgxa5v1UhYv4dx0tHmso=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:awu0IiZbE/H5/f0hfSqW+12vOb6twkBABwIKGSTa8U0Xf0llzPDP51KD6SqUNLt0V4BSNMAu3xwGf/NbFhfNtzMlyPw33yQWpm3kuV9BZNjNxnAXOgYZQyEQHKTrnIEf2vCRG6hXDyZn4GBOVBRBe2ehhyHO0n+nZPPY/wqhZNfZ3UClAAxTcuXtT66gEmE6HiYTkyWPLnb8uBUaO5GrbNhOcaOPxqnGSpW/OKTso7jVCFH31/noCXjMJhZpp1XRrWcOA/UrWWD28o7QvXFQMCFpN003VFDBD2r+TdQT4Y4iPlw2F5JBD9bZMqlVzXL8U/oEUuNoWwFyP+W7q7f2jjAt+ZihW8oESebttbUh0voH/h7RcaSOzF1KmtDm+dtfaRtRqdwM5bKDQ2oKYdq9q4GJTlr64PhMOnjQzi4Esjajt2KeNLti5ER3AtORViif3yvE8jEcvhplIZYQ4JQ/7zACp7e0GYLV48qOVFmLbqJbL8iOF2UKMn243rRr81Jz;4:hv269CE47hYMqpVcr3P5TfmeBJf53XdTueZAkiVyaHhEELq8pkr4COvlxt6XquXckGgHujjcAHJFoiB1800GviVQSoqgSTEa1KTwBMcZST+bGJLoQoW99+GAu2ivV3mHemH8zHdALLDkfGDBZCligRsJTQOK3sgsj1OvkIYXAzibVvaLRLJpKiwuga2FiJ3HnOmXz0l9bNNjJnK1XeMXGags5fvILphFpcYbCdTVhwE0HZMmGnbPIay+N4CmQwF7L0Se0UipP30SukN4E/ZPJw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13310C1E959015A134A656AFCD410@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39850400004)(376002)(346002)(136003)(199004)(189003)(23676004)(305945005)(47776003)(5660300001)(8676002)(86362001)(52146003)(25786009)(14444005)(2906002)(16576012)(66066001)(97736004)(64126003)(39060400002)(50466002)(31686004)(65956001)(65806001)(230700001)(58126008)(8936002)(4326008)(316002)(31696002)(6486002)(26005)(107886003)(106356001)(6916009)(65826007)(52116002)(76176011)(81156014)(486006)(81166006)(16526019)(476003)(2616005)(53546011)(386003)(11346002)(446003)(6666003)(229853002)(7736002)(956004)(478600001)(6116002)(53936002)(68736007)(2486003)(105586002)(36756003)(3846002)(7416002)(77096007)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6QUxHTnlFemFTTkhwYjhlemZDeml6QVBF?=
 =?utf-8?B?OEMzMS9ISWRxbkJJbFM5azVSb25PMGw1aW1takdiQytsa2ZyZTVNcGVzT0wv?=
 =?utf-8?B?cGdtNm91SGlkUWNlZ1ViNFNpc3oweVkxZWFjOFhGL0hmd1RyVlppMTY3N1B4?=
 =?utf-8?B?RnA4TjlVbzA1T3FZTktGbkdDNWRvMjZ2WXBIVWgvMmRDaFZSYmE0dHhlanNK?=
 =?utf-8?B?b28xSGc2YktiMzRXTVZUUmZPSUgwV3FrZ1ZKWTJhNkRVQjROclJrSDdsU0ww?=
 =?utf-8?B?Z1ZtVHJDZWNTejRMeEZRTkZwNVMwVkY1YUZDbDk0NHVUNktjMlEzOEFweXdu?=
 =?utf-8?B?TDIrTnR1TC9DVzJqaFQwNGFnQ1l3cGxKWU1aVDh0b1FRWUdqRjlvRmZDZXl4?=
 =?utf-8?B?RC9MRm9IR3M0MUtseVlBTmpwalpYNHpDaFFlcHFwS01EcmRUTGQ1NHVNZzc1?=
 =?utf-8?B?Qk0rZE9waDRmdGdsOG90N1c4cXFtV2NOU1B2ajlyMTAyem5tc3p3NFFkTFpk?=
 =?utf-8?B?UHl2K2U2YUlnNkFOMnU1V0w2RmZmWkxtdHRXN20rTlJaVmFjcEhXV0RVN0ZC?=
 =?utf-8?B?SlZLSGFkZzRLOFR6a0lGK0J1SS9zeG1iN2o5dTczaWdHN2xMYTI0UXY3bzZX?=
 =?utf-8?B?eGxRTXFwN3NBSjB4bDZFSVliamdPUjRXTHBpRzI0bW5QeDdwUXozUWZxWjVj?=
 =?utf-8?B?cHZhOTdOcjVGd2JZc1RJK2hBWU45L0dXV3hoOTBkRGNoRXFuaCt5czQ3bkJh?=
 =?utf-8?B?S01lUDB6cUVmbFZodXA3T25NSWlZWFZNd3duZVZqb1BCeXArVVNyRlRjVWFB?=
 =?utf-8?B?emJ3YzRqaEZ5c1NwdTNUY2VpSUZMcDh2VFAyREVubkloYkFKVUozTkc5OFFo?=
 =?utf-8?B?OFlreDU1bTVkdnlKeVFabHB1Z0ZPYzMycTBOYmVXT29wTGR0MWU5aktzeE5x?=
 =?utf-8?B?N0NhWTZoOXAvWm9VQmVVMjFCMlFFZjh1aVZSTUY3ZTZYdFNxVS9uaFVmYk14?=
 =?utf-8?B?NWpFejMzajgwdEV1c2pzTjVSVWIvdUZNWTA3Y3ROQ0xNMnE4VzlycDdGcWxV?=
 =?utf-8?B?YVEvc05aa3dDckR3SFVQM25MODFpcC9iY25uTE9SSzR6YytSOEgxK0dGQnVm?=
 =?utf-8?B?SEpUeldzdFcxY3dhWVg2V1p3cGI1d3lUTEt6cUVvZmFQSGtBbG0zbHN1Z0dQ?=
 =?utf-8?B?VDZOdnRxYnYvQlV2aFdHVlB5M0R6QXNEa05vbzk3c0tVSjhReVZPUENXZ0sz?=
 =?utf-8?B?TTRjMjRnNmZzYkloaE5VUlFIRytnVTgyLzJMcGYzMnJvMDJTeE9NUVVmMEQ1?=
 =?utf-8?B?ZDFjYjhqWUxtNStwU0tQbmVoSzRmNEdFeUVjaDNqK2pPbmtPemRGWkVIQSs0?=
 =?utf-8?B?cXQ1bUpVc05nZjl3cEh1aGtuRENzamsxUDIvbm1ObVpRV1JCeDhXbjZmdjFL?=
 =?utf-8?B?anV3a1dwTzU3blF2TzRjVXJMbzFBaHlETUhrZE1Kcm12MHlXcVZnd1U0c296?=
 =?utf-8?B?cUUwekpqNWxGbTNhVENlczZycmdkcU8rekE0a1R6b2plNVJ2Ymd5OFR5cXV3?=
 =?utf-8?B?MXh0MTdvaWVWMFhYejZqdldSRkU1d3owUEdZL1NtaFpFT2k4VG1CVWR0dGZv?=
 =?utf-8?B?MHBGN0g2dm5sZWgzU2FYK3pSa0NsU21MajR1QUZVZ1NGclRWZUxpbXlpOUhN?=
 =?utf-8?B?NGFTd1R5NXA1UnA0L2ZJOVVPY0xSRDBwOW1VWXFQYkJTT1lrN1o4MXZBY0RS?=
 =?utf-8?B?U2hSbUZaVjhyUmpzL3FwdHhaL1hCaTlFT1N1UlpSL210QVlJVEtNamp0aGZU?=
 =?utf-8?B?Tm9WQ2dxZGRvaFlpUFM2ZVZNbURSYUNtSHZOdFdqRUNOMlFVRUdHNUpqNVBJ?=
 =?utf-8?B?Yk1jZ1FJRFBTbWlQYnhYM3ZDeUtpTU5UbkNhRDZPK0dkWFFVMTJOZlJaSEpI?=
 =?utf-8?B?dTljZUdWbVZ6RmpRRnpENWQrbjNybkh3REpEMlpjOGxOTzZ6VjFXVUVXZ2xB?=
 =?utf-8?Q?y8IAwc6y?=
X-Microsoft-Antispam-Message-Info: Pf+It1Vtm7JiNX1qCLdH6qHfLsaKrlNW/sONS5I6aA6e4685IMU0/j+9kMqm5XzkBlvmiE1uYfcjyU3rTzTPd4ZhbTai3b3zbtM9xZ49WIOOOTjbj4U50RWtU7+W63XFzByC++vDtu1TCN2Xli9cfdgf36QR+kW5xnMsJVEOVWLI7BkJzp2KA3UnoyGme4guetYSs80pJoK9ewMhnXXxkqb1glJ8N2hLUu5NvIDqCcQqW+xGThGlf1+pTnmdyyFCEtSrMili0M8CzBmYfLON8U+k+YV8WRJJUsX/xuFjjoWKpO/r/hywjXArRyyF8ik2Co7r5rVePUnfdhwZRZdTIknbGBMyT1PNbvczSKRMn18=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:wjgfTUwRNswufpe3Mv9OD1jJZBlz2++cB9JZXSaxbSVfA93hTtXvijnSLrjxyJwVTR62aBbvK8051WqKSgiQ3WGYxIxvjM6qgWcg6wbySZuoKuqbZAan0QR7mKwwP1YcgkYORRg0TAm2/3ddY8G6FkYrU12RSv84sezpx0FpyyIFZOfnt4BFATg7V0tvnu5XF07M+NV1KTWU4JvE17Yn2DLInGALCXsSPliudN1+x0k48mHlEublZDElFYZwJtztM6jPAmPLp2QnLAx2KVLgxrn+cH80ZwhaCJ3C2SEtWBDscuPsh+5ZyD2GAfy1GdH0Hjqxh6EX01u2JrIdjarDInl+6OLID6ssW6UP3A3YyH4OQFnpvj8TY16rI0oonBEVSe3Yhs5yihkDGWh3QSY7LsDuxWDpbw4uaOu9M20AAMd2LRW+4oKiC3CjZnWTbnaiS/ihDkLE6nA7Hinch6MOeA==;5:9y1UnKvruxPZKA96rTN0PEKhwgtpg8BtWyvI6FOntG9BHg3aVj3/lps8AhNJKiBCxV36T/5so0bIIg2ILian0vr43pJKFYy09vOf7Cpd421DCRu72v94ds8yRyyEmL6qwLmpyzQcK8iDiqM7ytTzzZ0vpE706hgeRB8ljdOzbVA=;24:+73idr4LNdPII1Pg8YDI+7nfI39FZB6JBnDn0564Y6hVwcrv4/pBy3Y062BPLy8RvKwO7j3iGJgyE5sFBPWv2NuJq9yDp8T0hAEktW16Zr0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:AepgoM3rYOQrzsNwSijoq33RUjpsQ3Wf+gtVQZHZiBY5N6lmZ3U3SqRA2tZpEHy3pct3yLATS3hlmuCnWhV3dUvgRZFARYHTusyMb+wx2VjdHhmVkoyvIyXLyZwWVCts3GB2Yofx4wunp2YcFsrn+jSLkAfpIm3KISprSWSyC3lpwVMT457qxXYQSpcj1Pusod9cUOKkNY7cjIprgkLFZrZ++e3nwCGNEJ62jFyGsmB2MMNgdP2X8r+ASoAEQaAQ;20:M/JPLPmZRpOD9J/vTbl4B0LSqZ22GfkPlZMT4OtZpde5I5K69AXblkWPRF36exKerp3nEfeMjU1fWdjz1Yh9tsyqVsO02vmCVkXS8EVc89yhjttlCDFmZhX+eGEJhV4ffqVzi1YXZ+Pc5ZMT6Wq3bFPilkZ0eKf98XDmJKtgmS8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 15:51:15.7737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd767f33-16b4-4f9f-e7ee-08d5e1c5fade
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 23:50, Andrew Morton wrote:
> On Tue, 03 Jul 2018 18:09:26 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> Imagine a big node with many cpus, memory cgroups and containers.
>> Let we have 200 containers, every container has 10 mounts,
>> and 10 cgroups. All container tasks don't touch foreign
>> containers mounts. If there is intensive pages write,
>> and global reclaim happens, a writing task has to iterate
>> over all memcgs to shrink slab, before it's able to go
>> to shrink_page_list().
>>
>> Iteration over all the memcg slabs is very expensive:
>> the task has to visit 200 * 10 = 2000 shrinkers
>> for every memcg, and since there are 2000 memcgs,
>> the total calls are 2000 * 2000 = 4000000.
>>
>> So, the shrinker makes 4 million do_shrink_slab() calls
>> just to try to isolate SWAP_CLUSTER_MAX pages in one
>> of the actively writing memcg via shrink_page_list().
>> I've observed a node spending almost 100% in kernel,
>> making useless iteration over already shrinked slab.
>>
>> This patch adds bitmap of memcg-aware shrinkers to memcg.
>> The size of the bitmap depends on bitmap_nr_ids, and during
>> memcg life it's maintained to be enough to fit bitmap_nr_ids
>> shrinkers. Every bit in the map is related to corresponding
>> shrinker id.
>>
>> Next patches will maintain set bit only for really charged
>> memcg. This will allow shrink_slab() to increase its
>> performance in significant way. See the last patch for
>> the numbers.
>>
>> ...
>>
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -182,6 +182,11 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>>  	if (id < 0)
>>  		goto unlock;
>>  
>> +	if (memcg_expand_shrinker_maps(id)) {
>> +		idr_remove(&shrinker_idr, id);
>> +		goto unlock;
>> +	}
>> +
>>  	if (id >= shrinker_nr_max)
>>  		shrinker_nr_max = id + 1;
>>  	shrinker->id = id;
> 
> This function ends up being a rather sad little thing.
> 
> : static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> : {
> : 	int id, ret = -ENOMEM;
> : 
> : 	down_write(&shrinker_rwsem);
> : 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> : 	if (id < 0)
> : 		goto unlock;
> : 
> : 	if (memcg_expand_shrinker_maps(id)) {
> : 		idr_remove(&shrinker_idr, id);
> : 		goto unlock;
> : 	}
> : 
> : 	if (id >= shrinker_nr_max)
> : 		shrinker_nr_max = id + 1;
> : 	shrinker->id = id;
> : 	ret = 0;
> : unlock:
> : 	up_write(&shrinker_rwsem);
> : 	return ret;
> : }
> 
> - there's no need to call memcg_expand_shrinker_maps() unless id >=
>   shrinker_nr_max so why not move the code and avoid calling
>   memcg_expand_shrinker_maps() in most cases.

OK

> - why aren't we decreasing shrinker_nr_max in
>   unregister_memcg_shrinker()?  That's easy to do, avoids pointless
>   work in shrink_slab_memcg() and avoids memory waste in future
>   prealloc_memcg_shrinker() calls.

You sure, but there are some things. Initially I went in the same way
as memcg_nr_cache_ids is made and just took the same x2 arithmetic.
It never decreases, so it looked good to make shrinker maps like it.
It's the only reason, so, it should not be a problem to rework.

The only moment is Vladimir strongly recommends modularity, i.e.
to have memcg_shrinker_map_size and shrinker_nr_max as different variables.
After the rework we won't be able to have this anymore, since memcontrol.c
will have to know actual shrinker_nr_max value and it will have to be exported.

Could this be a problem?

>   It should be possible to find the highest ID in an IDR tree with a
>   straightforward descent of the underlying radix tree, but I doubt if
>   that has been wired up.  Otherwise a simple loop in
>   unregister_memcg_shrinker() would be needed.

Kirill
