Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48F8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721DA20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TkvwxTzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721DA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936261AbeFRJrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:47:13 -0400
Received: from mail-ve1eur01on0100.outbound.protection.outlook.com ([104.47.1.100]:35072
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935855AbeFRJrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgshiDlar6LEDDTF7ZTJ0rDHZzl9+2WJMnaH8hVXVbM=;
 b=TkvwxTzSDCjDJ67rR9IylxTNKCBn7fzKcQ3c7MR0qJvDOaHHmt480Zy3OFHiYvspN58jQTkBsAvYn3Gz0Ujk2x1vdIoFzKa1YFBDTG97/cjRrL5R19wI+yWKe1lra1GfBOvnwO5iIxT4Zj0P6dqV2tNA2FpK9Y1MFQBngFMlvnc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 09:47:03 +0000
Subject: [PATCH v7 REBASED 13/17] mm: Set bit in memcg shrinker bitmap on
 first list_lru item apearance
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
Date:   Mon, 18 Jun 2018 12:47:01 +0300
Message-ID: <152931522144.28457.11688383753444980791.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0249.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::25) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1390b07f-c182-4e82-a47a-08d5d5007309
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:wjwYYhMeTD0/paqPXjEulocdl8giQsRlKsJveka7jh9Q/lAl6iJPBOqo/5UyAiK0HNth3XBvN5KJOZUGmR+pUyigXSVDOF3goFxHu1SkcKCoUawwTSfoeeYmT1zgJy2kGB9o+oTZc1U0WcSkMOaEFOoTn2TwsqFpeS34mxgkmLwsq04ZjTpToIOIunGDLPRD0i2YNBwnXkXa96z68c3neBGqE6jOYyTE3kUVO0raG5s2gW4aK7xKAY9kA3/pkKgT;25:oF4248ytRB3F4Ng3Zb/RFyXleHPapeAH60XtfMkSfHxyAakZol7hpqYBtQMfDMmsF4JXLCXwloohcWKjNixwK1TFYiKiz2bPIQ2vFiHlfaCZ3Ta8gl+P6niXeZprZA7Il3d+NgXfH0HtLLpOzNxbOH2qHEtukXN0/i+XI3N5lcDcSATDfl+wRUL/FZpgcazDAsGI4IbUMyGrhOvEJq0ex0/02U+61u6+E26UkqF9kezw5Xdsy3MuAGejsTPRVzcDudPVz6qq0Czz/fBLlX1Fz71djYuQEK6HF+hoemcXSMjiLjf6uz9JcAEBLheT6VOdqouC/N6QpSvy8LHMxarYKQ==;31:FnpHG4nw3NhD0NdKxjeY/ohGe4IX0QV0E2R/+dgZNUC1UNTzAUTp2MXqNO42KirHC1YTC6IO21UG3t7evZFazizEgNoKOHtVlkyeDq64/UU/la8SWN1ba1uNkVm3I7a6ki8Lh62cKgUqZPfrRBO1i83rdhgJtew2mjfUppNlfEdYcj4b5/i50PDR/kYVJsmSsz107p6Bug1hjO6PdJuCJgaKNfoZmmP4bbMsR3QJL9Q=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:/TSOQL2sR5rFWtRC02eia2jHKOZ3BuN8GZ1ZjDbPf2RtywYdN68vx612qzNsyUjEu52esn2sG89psivro9bhx/QT06QvamvEc+RIvDjSAprREcK8jd5+Ij0b5MOkRVZdDS1u1dQeHtvcO+B5Zoud3wnPwTHLkBVcazAdM2oswGzooEh9+JAZPRHVPGkbG3KwqVLLm25g2bvoHPbq+wOOGi9pKjkpp6J24HYF4v3tdkZ550DX13eYBxite4+Ml7sY6A0cdxeeAEsCiajTCBnjcCd3rW+J8nPOLYYXxgC5KjL8mX5tD8Z6QoWbIIAAGVGOaN2K6lWOzqRYeEsYAGbkh63mYyhlqOIoP9qWn1LILOsECi1uG+P2dKUe+Ee86gFOhqbxy5rgAS4HuTAtSkstOFHmzRRJR/sStpVFAkImEoAlAgFVfN+1gWd1c3AtZtfUuMrVjUVeioQb7cqGwmHoTWWQGnK9Dw9XsARz3Pnt0Z8rVsFw355qLsNSnSBPa7me;4:dnBDSR1CTL54y6uDaeVgqoZdYOr4Qx/rT4eXROUQMhvI5VTxmO+DkpkBm2vKOrrZzaXTsPOUrseueDJsTYNFGr/njpYfb/Gx13ETyMgQS76ppvM/bAyFDYzVWuqkzurRE8yprif6lLtChOT17Z2KJqnPKv5EeqOxwZ0ZafnMR3eHDT1lXscpE1bHVS7pVvqScKdKwLuxUpoLEoeEd464JgMN6e2RDiaHwIdZw2m7JxwbjBBiDLiSdt1ZsTwwCoKUZbJ4q0TLi6fh0/aArkGaDFVfxw/oZvzTYNztaH34OCZT/WvzZXsD9D4DgGknyyZRgKmqrJ8OP+zWzc/LwTV9w2SVjo/7TtryRP3+oH/SB4uanii/n/tePJsYxj3HSCtO
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13310DCAB0EB1BB3972F16B7CD710@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(346002)(396003)(39380400002)(376002)(366004)(39840400004)(189003)(199004)(16526019)(3846002)(6506007)(6116002)(386003)(53936002)(11346002)(186003)(55236004)(230700001)(486006)(956004)(476003)(39060400002)(81166006)(446003)(25786009)(9686003)(26005)(478600001)(106356001)(8936002)(81156014)(8676002)(2906002)(103116003)(59450400001)(33896004)(97736004)(305945005)(7736002)(76176011)(6636002)(68736007)(2486003)(23676004)(52116002)(47776003)(7416002)(7696005)(66066001)(5660300001)(55016002)(50466002)(58126008)(61506002)(316002)(86362001)(105586002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6eVRBcVBiM2x5ZVlnc3R4NStVSjNEK2xF?=
 =?utf-8?B?ZTJEWHBjVFNzZGZkMGJ2aHdyamJPNmNwVG1QaS9GcWJXUFY5VkJDR2dqYW44?=
 =?utf-8?B?bWpRSjBlV2llb1p5SUorYXV6U2pWc0Y2cFd1UktENzd2dTFxVFpnYkZ0ellT?=
 =?utf-8?B?Ny9BNkM2Qm41aUo3YS96Rnk5VWtnSGVGYnpLZndCOGt2QWp6Wm1SQm4raDJC?=
 =?utf-8?B?cllLb3dXRVdTb1dZTFcrcUdTOTRwWEE2YlJxSEE3eXJFV25qbVlDM2FaVCtK?=
 =?utf-8?B?ZmFPSXZleXgvRkhRVUxheWIvenVrZDF1d3k4OVgwNGJCL0xneDQydGwzbjQr?=
 =?utf-8?B?QkFIcFZ4WkNxOGVUdExIa0xvRDdVZnZUWlNsemJnNFhHQU1XOHRIbElYalQ2?=
 =?utf-8?B?UHlaMFlKUHdaeSt4ZzFJb1hISGl1MFFNKzh1MENBZ3pabS9JclVHNjkvdEty?=
 =?utf-8?B?YmVzbnUxdXNqT0d6NVlOOGlTK0dCU1RxYkw3dHR2Sm1hK1FsaFprV3Fpd1F6?=
 =?utf-8?B?RDBkOXpYOW1hU3JtMFVzeGhRZkJPOWtqVDREL3cwR2Rub0cyaEQxUTQ3VHVh?=
 =?utf-8?B?WFFTR0I1bngycW1hemZnbXNENlVWVnlnc2tYUE9MU0NueFBGMUdzK0QrTkNW?=
 =?utf-8?B?bGRIWDdtWnhIWDh6U1daM0dsSmdBb1dKRktGd2VrTVljOXJBM1IvdGRSYTNh?=
 =?utf-8?B?OTVodkdZWVB0clJEZWJlbEs2ZVJxNDB0dlVJVDAxV2JNVG11aDNlRXp1VkpI?=
 =?utf-8?B?dkx4enpySjIzR3QzVlB1OXpCYjZWYVQyMjNwRUx6R0c1Y0lGbVVkMWZwU3RQ?=
 =?utf-8?B?aFo5WktBSzNJaGdIRlFoSlY2YUMzQkxQSlhpR2xBUnZHd3I2OFJuL1ZQUlE5?=
 =?utf-8?B?VW1jRGxGSzJNbEJkbjd5bVlzb2F1NUVMUmk4Tko0VEpka1RFcm5YcGdPc2tV?=
 =?utf-8?B?STR0aUgxeHAwM2IzSjNVeEhYNzZRTmt2Qm1aMm5XOU5uQkRGM1NWbklNbWgy?=
 =?utf-8?B?U1JDeXdkN0p6Uzk5N0RSQ2hlNjBSVWZUQ2xDeW9RbkZTenNrTGtBckdHd29a?=
 =?utf-8?B?VkRabFdtd0tTL3hyWDUzQU5sdnlPL2lLWWIxTFhjREtBWnhpVGswU0x2TmZv?=
 =?utf-8?B?VWpRWUNkcjV5ZDRQTXR6bFh5SU9UbmVXWmJLNWNwd1Z2THFBdlJ0ckhPUGJL?=
 =?utf-8?B?YkNCS3loRXhnYnRJemZrbFQvTDh4QTQyY25tR0MvK3M3WVA4a3AwZy84Qm5E?=
 =?utf-8?B?cTQ1NXA4QlR6V0QrWHlZWHZ3VXk1L0g3WTBwNEhvbUhTeUlCMjhRTUNCS1ZW?=
 =?utf-8?B?NkdMVU9OcXBNTm9YVWJhZVI0TElsVUlaeEY4SUdqdC9oZmRhQ0RXNC8rSnN4?=
 =?utf-8?B?UWk3cGNtT3hOcTdsYVhaZ1QrS1ZONm5mUGZ3UUNTbnZUVTdWZHcwWlhRUFlL?=
 =?utf-8?B?a0wycFdVMUozOUJLMmZmUmNUdFVwTllJQmI1N01LQnN1QzVsZ1AxZHIwa0lZ?=
 =?utf-8?B?ZnlHekFnRVhncGpDZXpNQ3ZLSUNPdjVic3dOTjRDWGYvRnk2VndVUFJHK2lY?=
 =?utf-8?B?MExWVU1tOTlkdnJqQnhVb1grN0tuR05YdFVITTNnakZLZnZRT1lEb2xWKy9E?=
 =?utf-8?B?QkZXd2E4VFlUYWl0OTU3TllKeFVObXdFTFNOQjc2ZjY0b2FOdkxIWC9DOHht?=
 =?utf-8?B?TytZaUZzMFUzWk9kWjJTdldHVHJ0TjdTdnFVbmQ0UW1PaDJySUJHWldKRThG?=
 =?utf-8?B?TCs0OHJQS2dxNXluTjBpaE8zTlpFZ3NRR1lsZXh6N25QaktabFBQdG51R2NN?=
 =?utf-8?B?MDFGSGRpakY1a24xOVA0QzlDTjVuWVUramdtRDBrYW1OVWF3dmpYc0p3WW52?=
 =?utf-8?B?SkdNdUE3YnBFMWlRb1VYTThTc2ppY21KRG5pNGJXYXBhR0xtTi95eEEwaDVz?=
 =?utf-8?B?V3BlWmJiekU4N2c9PQ==?=
X-Microsoft-Antispam-Message-Info: 0VTk9KP40UGUz5SU1dz7m1BQsvFarSWedI6ORjNMH4AvdOhakDX+sYLN5Pl+4U9t2LloV9lboBKG9QMPnJhMgIjmiNT6Fk6OCkUlg5iR8VZ+FwqEYV0jD0RAF3KIe5Bx9dyFtrkYU9UNy0YmmCDqvMcrSDpUc8aSTOKcZVpHSPLiT+uCguKxDNevhWb8DSFK
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:H6jcaPWLcbyaorUBRvm2SKMnQo3TY6kTaxiQojZ9wBk9kOFLexBESd4zBL3NMu0iJkubvjXbk1U2pwyMrAGuYqifVpxBzYegFI5p2Qzp6ure3JHhTj5y70Ibde1qSwDv/vf0wU94TYmvNdYhAl4sfVLwlCYPT0xRh13afu639j/zg5dl8fh3hTDwEzawo8aQ6ot0iTLo/iDb4GmjvK4k6WaUscajPLX2IZk8vYbwfwv8t30+YWAqM4CzLrxDDWwNvP2PccwkY38vAWqdXTvFbCZhk1pq3cTR/aYN5s+YuYGbFsz11zBmeJUTADNr6UV0jB+FDehTgaxTlsxr/VrFy8J/16ix2PL2+I1Q2hnDR4TNeefaNFhVHL9wRXeLQqGO5SDEMnR5gNDB95Ft36BELuylH91YqFHFIyKjZfR0jNeSJTOWGaFKA/0zs8hJfPLY+GGJM38mfDrwDpeO+sgaZw==;5:y9rKjRzw3Muy+bk2UNxE6fIC4MtEvDNXkUhLbnBaCD+V9OpfboCiHeRr0lBIHntNPrHUvONNHCwmQk8daUGw1A2qi2znvwPUIm/K7HIJbh/Zc+iC/vEiTYm/Le6H/UucrrWEGJ1FQjAoWmvjbmr4zak2XOqiv1yK+yr+ht/GTzA=;24:+BRT/V/SR79U3a2ZrYaP30EMi2VJsqgd6HMCqIANk+nXgotNY6LXKD4agZ3txqN4VHwywgJJ3HDGdITUjRP+8SawEhjggJLH9rhNAf8x7Cw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:CwWUtmdtJ0C0D/16qIQSGudaQkUTerDFBJwTNm2R+Aak4oM2t6exWN2lpy5nxfmtU9SH9zwXSy1pz1c0Zjl8TUB+YyewheACWvRKw3+Rk4oGEVVPbybRpsNxLIwyKAM4lS+o5tW2+LHh1lK3josVBl3Pw3zEAaPsjLGOTqj/XGUUtDVrDDNondl/FpoOdYqmmPZwkVyzqAmq3Rm3pIjR2v9KgmkEOqagYh1Ks+uDwdBCkY1iTSTASqDMgAt3/qH9;20:8HfPUCKYEmiziYX2PJ2JSb6EAT1ZLI/+N4OD4TlQ7OA0QU/3WWpb8u0Aok1vKfAp0EzsViXS3cETzZz8mp0TkK+bggtPF2YVL8GbCQQVMqCulrjdiVp36ji4heJ+MZsRsPFvlX7tzLEjaXFjvoJzoFRzWSuHHdc+KN4lTy+Rn4Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:47:03.3988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1390b07f-c182-4e82-a47a-08d5d5007309
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
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
index 7ef004c4f4af..f2292ea7892d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1249,6 +1249,18 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
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
@@ -1271,6 +1283,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 79a22404464d..976d634a479c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,6 +30,11 @@ static void list_lru_unregister(struct list_lru *lru)
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
@@ -93,6 +98,11 @@ static void list_lru_unregister(struct list_lru *lru)
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
@@ -118,13 +128,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
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
@@ -513,6 +527,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -524,7 +539,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);

