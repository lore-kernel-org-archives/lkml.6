Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A937EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551CA20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MvwHxpCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551CA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936370AbeFRJrb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:47:31 -0400
Received: from mail-he1eur01on0127.outbound.protection.outlook.com ([104.47.0.127]:54203
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935855AbeFRJr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOO5z1NyFbus+gGFcrexHHvjuhNsT6cuoMtO5yiqmkw=;
 b=MvwHxpCxZKFeNKmyqr+1LeCX9c/IoTOMKGRlKpNo/CY/tkZxe36iMFbGntgcbcIV8yi5AD6rrUJib0cDTV9i6dngeAAbv7fAm/wGetRhDNW4Kn2UQ9TV/ZgxpSrpg0CO/aOlm3DlswOHyf5r0hXEIKOhOqmfCGVAYG2mLhF7UI8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 DB6PR0801MB1333.eurprd08.prod.outlook.com (2603:10a6:4:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Mon, 18 Jun 2018 09:47:21 +0000
Subject: [PATCH v7 REBASED 15/17] mm: Generalize shrink_slab() calls in
 shrink_node()
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:47:19 +0300
Message-ID: <152931523944.28457.4508842730369838542.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0070.eurprd07.prod.outlook.com
 (2603:10a6:3:64::14) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4056894-1d74-4c36-8200-08d5d5007e44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:jIxoWABZX8vwpIhBp34Xar7aPGPtvOeIIJqiPGtCcvjRppb5vVUm4cY9cLA/cXwUBhu1viCsRel1aI8emC843UcNZ/3OhPRnZ7asoWKF/8Ffi93WD8RH7Gp8HqvVmWtktVandlJGemve1cXcYmyvwK2YcxJZWnTThTkqNvUD6rLNdBdYZ1fccY//atVf8kGl3qhE3nbrqdR6hxIcyl9yU53kceumC6aICHWs6vc0c7/u6P4g0+zvL84M0yjuhOA3;25:fPXdY43wz1r0byp/cDH/gEabEX4yx8w0VzGY86HgUZ/ZEW22qSwZ1kvl/iyTXhNf+xGGz6fvMGNsF1cvaxdc/SbyntPAB4SCA/ki8cjL0SCfhTohWdnYxKreWVRzMQYfvh9zQ4MighAv0K3U/UzrQ8WPZf2DwG0TB/73ALaTkwJYQIe/1Ak3i+W1HvauFukKuCOCCahpeTK24H965UBwEvWOj5pED7lGsunklMMUSY0uUptALVUJxAoa7MH49svyfkakparTA/YrNEaItPEZ/TEnzjVI+8w3jWT0fdDBqkQWAkk7LwPWsWMWpmzNbrQZsbK3sQaynSN5YLYl5TqTaA==;31:l4hiM9+pi8QG/jvy4/RR78WDbWJj/wqKZev/KfwOkTlftssAmCIach2g47EBdYgN774UVByudj0kD3F/xvshddcJzK7fscXRzg2ygkNmxv5YxphdDbRGtnjTUEnoHDegHwS6arGs9ifaDOlGrvfhJv1F+Bgne8SjJwCHVNUR4gh9n3y9HelCtgjKxCg/WE+38estfLkJAwCq+KfxhQCnDFePdIwvHAVg8EyzAq6lxow=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:hf2CftMj9HNZHVKuLRiQXcealkE1b4jqUF7zznaHM2NllcY0MeWhyQl0uAnK4szdPHbdT88qY4BTseGsaI2zu0hgz8ckfCIMT/0iVOWvVmOvkW1zDqp08w8V95qcYMJ40iSfUZckTRpRTv9PUiDDZxlGxiXMuPT7OslX/ger+MeHvteZQ6j25gVNo3ZHuCUlQUJl/FvvWd15g2DwWeDEH8hw6opy33A4gutCbMu0s7EVKNK8tqGXu99A/qc5OibZm7JlYKuPCt3nQvJ5mToGTUjlwy1AkKdvKvNvTSUC7EglpfI+RsLjF005jww5E8B4Awz5XV1so7ifR2hdEqopA93puRaOt2CX+QlE25vVVlPOqHjo6blLVlR9toCKBWdDlfJUBRyP1nuZJ175O9p+no0oqCbOW70cORv8KC5TlnBCuB3v2Oh1clTypYWS3grCji6Ml4Vh31IIWI+TfuHE9dcrJ6rG1BTmj8vh/9AfnWkWkasmuXp9ngBzHTEqXyoO;4:EXYi/1wFQnCxFu0CIiVAb+5lgwUXW4u8SWIdNY+YoqQNHU8slZ6xVWh0IA5VrJdZkBFu8mhdvAbVRPU4tkzVwEpUdL/v6AGeYLHYv6WCDN8uzK0DjfT7XRSnX9OdjQgf1hpR9HpqMvxoaJPb71xrjiwT+9A485mTlrHLxNxwz8ohkEsR6MX8iyfvC0NnqeHXOPZ7DlUzeGZhYE89nkIq3fh9O3tZ6yCsNbAueeWEYhtrO9WU/GZAYU0zjxQsuCW5H0A+z0N6w979P01QVHASxRLdV2dQjRc71g44WVjwcewDxOvcRVtRZ52JLMxs3Rc4ChEfKvI163Ok2p68yt6oGQ7gCAXfG1LVUWVmy9GyBke0MLu6r1YMee3R4ymICHOJ
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333E2202DD85235093CBF8ACD710@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(376002)(39850400004)(346002)(39380400002)(199004)(189003)(55236004)(26005)(7416002)(305945005)(97736004)(47776003)(66066001)(53936002)(25786009)(478600001)(8936002)(5660300001)(8676002)(9686003)(59450400001)(6506007)(2906002)(386003)(103116003)(230700001)(16526019)(7736002)(186003)(6636002)(81156014)(81166006)(61506002)(33896004)(486006)(316002)(6116002)(68736007)(58126008)(76176011)(39060400002)(23676004)(55016002)(476003)(50466002)(52116002)(86362001)(2486003)(105586002)(3846002)(106356001)(956004)(446003)(11346002)(7696005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6ZnpYemVTcStPMkczTVRMcUg4ZTQvQldF?=
 =?utf-8?B?Zzg4Q1ZyZXJSSEJWSlBoWExpSkxJQmpIdHdYMllnMzI1b2xBQ0gyR003dzlJ?=
 =?utf-8?B?Q2xVS00yMXlVVHVCbjFVTmlib0Uxc2hCeU5wYVN2M1BhYVlNRUdZTndaekJy?=
 =?utf-8?B?Ym0veFNrZW5Kc0JTd1QzcVlRaTJKcSs4WEFvLzNqZ2tMM2x1Y2pBTlRHQ2VI?=
 =?utf-8?B?dFErYWdOTFNqK0Q5VWdpL1pKdUZ4YWpsdGhRS0lyOXBqMXZoOERoMWtBUndM?=
 =?utf-8?B?SGhtUzBHQnhCWWsxaCtyVzdhVFM3aFpnWFJxOGJQWUJuckFZZUtYQ2Q2cURz?=
 =?utf-8?B?OFhoNDhWV21uNExaRllseFFUS0hRMWNZRUJiOTdjRzcvdzFPMXFUdjJlVzdK?=
 =?utf-8?B?YnVzR0ZQT0hVbytEdU83L3NnL01vS1FDcWFtRlRmUTdpWnZuRkIrZEVGRExI?=
 =?utf-8?B?Qkw0SEVseXhsd2hlTzFDaDd3a24wTzdRVzdkT2ErTGl1SlVSMDV1QTRDTC9N?=
 =?utf-8?B?b0lJL3RnaTE5bkRrVk5wNFFuZE5pTEt6cWZIZzdHNktmaUorZlBMcVQzV1Er?=
 =?utf-8?B?NFVlOUFSUmpQNFVOeG9HeTNxYStxOWQxNDIvS0lUVlhUVzMvYzRKeWZSZWVi?=
 =?utf-8?B?bFZqNTMwdEtPbWFDcDdaZkNRZ2hkcFVOZHNDRHpjWEt0VUZ6Z21BT1dDMHNB?=
 =?utf-8?B?amFkNndUaXJyQ2JvNDJhb3ZITDJ3TGxMWmQ4YkFLb3FBeWJRTGs4YU5Ocmc5?=
 =?utf-8?B?MTZ6WDVpWFJrcXF4K1pRaUZwTGl0M2twYWJjWVJPL0Z3MmNYMnJUcm9walJj?=
 =?utf-8?B?aUZlME5aMFJPc1lscURnc2Fua21JQTR3dTROeHYxRVo4OU1NRGxJelZJeHZD?=
 =?utf-8?B?aW45SDZndjd1NFBrZTI0Q2xWMDNQREVUYXNxMnA1blZoSUYwNzZwQVErMFBZ?=
 =?utf-8?B?YkNUc0I2MTB5YXQ0UC9GSHBNZlVpRGRYWXpzQkZVcTlZbzFmWGI0WXlCSXBk?=
 =?utf-8?B?UzZ0UTBnV25uOUlZbjk4Zzhmd1Y0Q2U5dXdMMTdwbVc0QmN3amRaekgwT2Fl?=
 =?utf-8?B?VnJOTkZQVmF5SHRmRVlZd0lEeFh5Mmo0cWtPb2N3NUNQaTFSdjFnS01Ua0h2?=
 =?utf-8?B?NExNaU1VV0tVL0xCeEJxS3pUalJEM0NrYkc2RUJONWJqM2p5Q0xGYk1TT1N6?=
 =?utf-8?B?dHorSGlUQ0hJY3BMWlBqZGhKaE5rem93U1luK1ppTDZFenRsR3Q5SEhHQXZi?=
 =?utf-8?B?UUVyQmF1dENKYmpqbmlzTkJxSDFOcXh0M1BoazZPV3U1dmlZMlhLMEk4RHZu?=
 =?utf-8?B?SzdaZlJ2TU9VQnpQYkszd1BRMFJocFVFWllpem9DOGFoa2pwanlVcnFlT1Q4?=
 =?utf-8?B?YUZUdmdzblpYOWxjQ3pCUmNvTTVzMTlzdmQrdmo0MzY3ajBkSXNpcDhJdjl2?=
 =?utf-8?B?WWNLRnpZcUt0YVUzRlIxNE56MllRU2MvL2ZFNkYzMEt1QVBEZUE1cGMvMy9x?=
 =?utf-8?B?YVhCL3Fnck1rT0lMOU9Rc24zNENNS1UydGxJNFZGUlBDRzRmdk9xSFYyTkFm?=
 =?utf-8?B?NmtMbjFnakRQdnFaTE0vTEtWU3VHWktCMThQUUh4K1FyRnlybEU4VlpUTk01?=
 =?utf-8?B?TUZMejVudkVTQmxkRWlmemRZQmN6S1lmQ0VEVFJndzRhZnlZUGk3U1hlNTUr?=
 =?utf-8?B?T1FEeEpJaCtoTEEvaHRmbjlZaGxJNGpmSll0QmJPd2F0eGRRVytZU0duQisx?=
 =?utf-8?B?ZURWdHZ4OXc2bkRRV1lkeE91WEhYcXlvVngwL3F1WktYaHF3ajQ1dU1ScWJh?=
 =?utf-8?Q?sof5d108qi5FioT?=
X-Microsoft-Antispam-Message-Info: 9SnBbV4yYxtvW1mGX4lJU74zmr3dJoJRmzEAeukdHucR8v2YWXfvFW/8J71SeSq5dkdCsSfFa/qYZvIQupPcLarWnciJKQbdAzXqZs2hrd+Sn81XGeHN5pGCO1y12sFrpL6gPhIAKWo1V9yj9whJCFz06m62ZpsyxLAPpmDqjt3DGt3RT8HlF9UnLXI/SWqVSYB8f9V2CQoadeXe3LuTjImUogzv+dHSzBO6x0CVx9CjbbsRYFW8JY56Zx9ntDUJDmlCHEVQrvnD4c+fx0CRF9zMR4O2XtjFJj1Vh3bOwoPqSN15SJyjMny/J7S5jMvWMb8ahk9euaKeD8OzbTX7Pg==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:RrnEUvtJ/FbSmixL8I1moM1CKuK4eE8L9nCjMYf2wI5xJFpUiQUzS/747WKqCHcHo14Hx2qZdzUOT0p1HdS+EZjFV83YoJzh55Y1elpF4KItXflX5Gfg0PACFbh3sfo82a4fwJyzYBjgbVBLIqLT1/h3UGx3DzUnDaSLJPtCka2VaXOxQCBggS7D094T+NJ/3ViKnPGSKn30sN2G8rYEpQsvUXrzb3AwNRjC7Q+qg7QjjIPMxhJTmPw9L7BHpN/1HR6+8E95CknbBB62fp/EbRMsJF46yhM9XZa0HcVTCIc51bGVCn1uHZsYKbtCkPeL32idSjldyqDAisTGB3N4WsFlWzCCUXsLwgmVI8h7gL4IwbBHcMwFcAPC/b3S8s1d3ZlOryFJES9zub571yuP/2r8FqNl3fHVB8rm9gcuhq2+1f2hLXU6DJYE7QUPvbGMile+auX0FjX5noPxlSJBeA==;5:+D3pRkH/GIliJDIdkg8NI3CDsdo8ZzX2pSZ0IBx/eFbib0a0snILPVg4YIH95WvAD3qbljMOAw2Fm4L8dV32aQoJmi2wNIML9e8ZpOkN41h0N01IhbYvZjnpXJAg4JuDcVRdO4IahL74skpeCjEt4WlrD1S9WdPddN7pvuVb1J8=;24:pHciAtic2gb5XZbBvhewwyzhmPnwjfenNKEOKR69TuH0XA5+PSO5XhCcXGyEPf3hLv3eo8SJLe5LYppxoXMo0UucdMSP9wkfup90bVYLP9c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:vOz1xn6jF2tWeAOKrOVtZqz32kWavdAoqacPgTPgZTC5XNeXv5HiBWpbeRe9Yc+aQfeM+7yiwmdhsg7TMVe3ZUTEOILSNHhxXX9Wbw57TxBdisUIapcaq9AEUJ14/PzplJKkW5DvKiI3EJdPj4C0wIARVSJYnFX/VfHPQbc6T1Kv5lgRAm4f0y0A4idVBDCxxf2wcMuhvL3wMqqI5dKHZhBBEcual07tApCkA7q3J57+5LLxLzlzf9wWbZXLZElD;20:bfm09RfmJdmJvwUh6D2TAq05ZQeoFXfKWg1nL3yLqYdYJ6VuuoxfiwboQvKWW1aM93W/rAOjIRXvA9VU2uBmeAkC8Z8XNPQTDlBLjBWITyTRV2ezQAN9/FvSSwcXBdoRnR1K0nxz2KcKzL1U+7bKc0/Wv03SkaoWpIwirFyqSmQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:47:21.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4056894-1d74-4c36-8200-08d5d5007e44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Davydov <vdavydov.dev@gmail.com>

The patch makes shrink_slab() be called for root_mem_cgroup
in the same way as it's called for the rest of cgroups.
This simplifies the logic and improves the readability.

Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
ktkhai: Description written.
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 07361ac766f7..1518f3c613f5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -628,10 +628,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
  * unaware shrinkers will receive a node id of 0 instead.
  *
- * @memcg specifies the memory cgroup to target. If it is not NULL,
- * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
- * objects from the memory cgroup specified. Otherwise, only unaware
- * shrinkers are called.
+ * @memcg specifies the memory cgroup to target. Unaware shrinkers
+ * are called only if it is the root cgroup.
  *
  * @priority is sc->priority, we take the number of objects and >> by priority
  * in order to get the scan target.
@@ -645,7 +643,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && !mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
@@ -658,9 +656,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-			continue;
-
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
@@ -690,6 +685,7 @@ void drop_slab_node(int nid)
 		struct mem_cgroup *memcg = NULL;
 
 		freed = 0;
+		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
 			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
@@ -2709,9 +2705,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
 			node_lru_pages += lru_pages;
 
-			if (memcg)
-				shrink_slab(sc->gfp_mask, pgdat->node_id,
-					    memcg, sc->priority);
+			shrink_slab(sc->gfp_mask, pgdat->node_id,
+				    memcg, sc->priority);
 
 			/* Record the group's reclaim efficiency */
 			vmpressure(sc->gfp_mask, memcg, false,
@@ -2735,10 +2730,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			}
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
-		if (global_reclaim(sc))
-			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
-				    sc->priority);
-
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;

