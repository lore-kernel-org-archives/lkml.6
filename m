Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A45AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7702064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FrA7jOXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7702064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933106AbeGDJbM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:31:12 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:55752
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932517AbeGDJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24PjnSXvTk6ZzOIMXR3iX0K0DYFyd/CQYzVrgMzV1v4=;
 b=FrA7jOXJzOlN9THQuLiDj9relDHzSsvIFWTQzHvy1bA2cT8/9TtU3eJXgBvcs7yDyjmhL06k9RqcwKnFGtOczCQmvYdCCM0GxBXnoGrE3medxvpkh2oElsyC0QoBNIc4GuxY4YJzJiNWetvh4VnIrTck/ipGNIMI1okb5wkU66U=
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 DM5PR12MB1722.namprd12.prod.outlook.com (2603:10b6:3:10f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Wed, 4 Jul 2018 09:31:05 +0000
Subject: Re: [PATCH] dma-buf: Move BUG_ON from _add_shared_fence to
 _add_shared_inplace
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-media@vger.kernel.org
References: <20180626143147.14296-1-michel@daenzer.net>
 <249b84ea-affe-2e27-abdd-81d61da9cce6@gmail.com>
 <f6100513-d31b-b7a2-cc9f-104a60127277@daenzer.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7fdac4e4-0d99-049e-6eda-58b766448e55@amd.com>
Date:   Wed, 4 Jul 2018 11:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f6100513-d31b-b7a2-cc9f-104a60127277@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: VI1P18901CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::14) To DM5PR12MB1722.namprd12.prod.outlook.com
 (2603:10b6:3:10f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af1ca71-589a-48d8-bce6-08d5e190defc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1722;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;3:fUHTAaW/pPnQ1qwAnGgxRDbO8pPMuNUIN5fh40e/4F6etRcXOXcofNso7Md3Eh9jGq8bxhw4VZ6fug3cUS3C5sI1f6ChMmu8ow3iLRrPr3BGKpuBwWTdivpoFG0m5HO4lqpmTqa5zvMbWjRRPBpiDtLKKTdeYBDeIFTwCmnypolEjsLjRBTiOUfg4V4zX+F+J7QinBX1NSx7rBp2MXPi4ZrWUibnrMyhH8q8becvvLFTsbhnLh+egOCulVYRjNEq;25:RrYWo4Qzd81s3TF1tsUnG8o7UMFxp3+1NJRQTtnKVb5su2vJBYUJUwouPHXrRsNqFxRp79Lu4SC+ynH0KT188bc4F+4zItiKKfSkR8UIG9YBxEupAodEdCdVnmWWmq5fUjYr9LmU0ottnIDDmDW9+KW63IR7LYxeTOEI14GSZATYrw5w9lJSEy825SAPZDAsmC+ShcZfVOPrCp4by01/d4fZgV21NqDbrfwm07F3iH1MLU7xI7CEiJIu2IFRyn2rTLiATfCW/bS2WM00iCa33aJCSYv713apfciFiaQIb+Tgh3nEopXml3AfC+/KsC5lQxHxxs1hmLJ5tm1Bn54HIQ==;31:f7Dj1rZ3Dqghwp/s/tVfjG25Pslu3udpIIfWEUyxyyQ6Ke7nHaxQUt1cPJ49net3H3i2hJcLR5+yI52LKOMw2Ku7cP71yrrtIqrAIbbdvG6xYXJON8CsZSWIJ+3wlei0iHyNjYCWhJA9rNjtIYApI/ZTmOcoc4ZGRBdEqujW79DFhvxlUKLDZ9d3h3lfqjzzQdrHjzFQ7d/CKqEGON2G6V9dg4T8O707lwUldvqTJP8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;20:OlEb1/rCStBvwm5EodWgl+lhkzOSyaPlKba075TRNP8d18YKCpFf4jJR6LDEYdnbix2nxfu7cP8pG/DbSuLsXkVP9B6Nwrlgm5D2gScitNXq1I28VZhVz7ANKsFUmZ+Sjkf2MIlr7cem5+ypziG1n50zwsvn/es7dVjy625bbO7UlwL/iCeLuqmgULzKbcgdVZvv1qiRAVZcM3HKpdK9lGSN9nXS/+RU5QbojiVDUm1h8oEP9UOQ/r1nxuKtUMhPk4oZHBYSO2JUQkDZN9gePT43Cte2AnO1emvOX1U6nQfJSuazwpTCvBNkQNzUKmndrxkAbL0zC/EIIf44R0vm4EtB4Mvb84ObdWNZh3xl7pQrKkOhcYEaTCmOLC1v1++01tJQYdQZ3qvOYhyBqSMSXDvYhHICnFRSdU+Cv8jyfEIQGZYOPZzAIBn+ggF/1Id6mJ3X/PdezU6LxhrSYIQ75DvS5zSV0lYMqSZboQjfUoc0w5skClUycHlWuX9tDvEe;4:ddebgPF8pDXbDRBk0+6EC5kGuzSBdhBrxkTjf2bnuLa6M/+ehmO+50WXrzeY3IWu1RUBb610Va47In/ywBVOTZCYA1tmhrTFS3hunrPicuZsGbh85UnyPRcMP2uK1vjGTO94hzQeg8FHE4f3cdyXyNao2JDZ5hmZRkmnZ/kFvExgISzccJMp9AQm62yPY3R1eXlEuyXSu3txy/GjeXIvCIxLIM28B3H2Gm47h7iN1gbQXwcPTu2aIBtT4hgUi/iOdfzwz1nz275U57o2tTLzT9RiLYNvP55ZnkrE30NZ7hZPknpkC/yTO/G21rXWwvKl
X-Microsoft-Antispam-PRVS: <DM5PR12MB1722ED209FFF9E274CDAFFD883410@DM5PR12MB1722.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1722;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1722;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(189003)(199004)(86362001)(386003)(966005)(478600001)(72206003)(47776003)(1706002)(65956001)(65806001)(64126003)(2870700001)(65826007)(6116002)(2906002)(7736002)(110136005)(31686004)(58126008)(305945005)(316002)(8936002)(8676002)(6666003)(81156014)(5660300001)(31696002)(52396003)(229853002)(16526019)(6486002)(76176011)(186003)(14444005)(46003)(97736004)(68736007)(106356001)(446003)(11346002)(486006)(25786009)(476003)(2616005)(4326008)(6306002)(53936002)(6246003)(53546011)(52116002)(2486003)(23676004)(105586002)(50466002)(36756003)(52146003)(67846002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1722;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIyOzIzOkMzVWhkRXZkOGRiSzU2ZnIrUytSTnpJY05q?=
 =?utf-8?B?QU0zZmJKWkhNelR3eVVtRC84aU5mMHh0aEY1ZmdQMVVHRk5yYUhvL0lBakMx?=
 =?utf-8?B?U0FBY2RuRlQ2RHZ4WXJLc0JuaHRocUV6a2tWdkxMeFVYeGNWa2lhNVZ0QWpG?=
 =?utf-8?B?S3FpM3FiUXJPQmlDUUlNWGlTTXVxajd4b0loTERqb2M3SVIwbUlQNWhJRzN5?=
 =?utf-8?B?SUdrVnQxeDI4aUxYekQwcW8wY2R4bml4VUZXQXFqWFJsWHRuK0VZb0RZM0U3?=
 =?utf-8?B?ajExNThlM1hMM3RYeDZNUjdiQ1p0UW9kb2dOZFd6RnMvRjUzdnVKNkpVbkVt?=
 =?utf-8?B?Z3lUa0hNNXdXOTE3NVZrZ0RDQTNwRDlyM3NrbFZHblN3M2Q0a1k1c3VUemhS?=
 =?utf-8?B?RHF4N0VzN2xOeldRcWU0a0RpQkVJTFhSeElENllNTEQ5ZHhrV0VsUDBDZmow?=
 =?utf-8?B?aTQ3RUJFdk1TMlh1NWtUQXppekJlckZUV2dlMHQ5RVVUS2dIOFFCYW0wRXh1?=
 =?utf-8?B?SFRGQzNSQnZCenY5WnptbEhzcWt6a0FxQSsvdVYvM2ZCVENkMzZkUFlGNnZp?=
 =?utf-8?B?VlV3RElLNUVwWmd0bkQ0b1NhYldXOFBIWXdBTnZIbWl2d0hSa2REcU5QQ1p3?=
 =?utf-8?B?aHZaWm1qY3pyQjNWNm5NZENCNWR1MUZUVzU4N0E4blJMWlRuSks1Rys1cmJM?=
 =?utf-8?B?STJXZzB0K0lIazZlUTJLOEtVRE9NT1V0bkU0VEhnSURzUVloM2Y5cUQ4d3lU?=
 =?utf-8?B?SStEcFZIZC8xaThseG5hUDdRVTBEVURXbmxJekVUUnhoakFsNitOY3QzaURB?=
 =?utf-8?B?T0FNOXZMVkh5TDZkN2VwcXhhdGhiK2E5ZUl3TzhFWS9sNit0a1lva29vem43?=
 =?utf-8?B?WEQ0YW1sRDV6WVBLYW1lcGg2VWVqVzRneEd5UEVzUzFzMUlWcm5aazVSbnhX?=
 =?utf-8?B?eWtmbUJWVmw1Z3JDeE5EU2gyWVZSRzUrUWNSWTEwM0UxVjNlZjRBMUZVT0xW?=
 =?utf-8?B?TllndFA1QTBrWHVnd2NBVWZPUU1UZlFnYnZpUjROVTJZK201Y1pnTWs5cHQv?=
 =?utf-8?B?M1VOOS80K3ErMEVTZUZaeHo1TzFiZnRUbTBFR3o0NjB2NUVibCtPZjhGZjds?=
 =?utf-8?B?MXM3cWFuaG1rNElwbDgrWFRIK0F3MVVSR0xHSnJSVXZ6aEc4SFhIL3Y1OFo1?=
 =?utf-8?B?VVl4SXFXZ3dLc05LZkpiN2pVVlY1eFJYYzZlQlBxaTZYVko4TTczdkJDWnAv?=
 =?utf-8?B?OEJlNmpkR2NKNjZFWkFjVFVwNml4bVRsSlpNTER3cDlRb0tqOHh3ZDJoalBh?=
 =?utf-8?B?Zm00alVadFIrc2xyaDlFSWxCNjdDZjc4OGQvRjhPMi9rQzk1UXpYT2syZ1lD?=
 =?utf-8?B?T0tLRHJpV3RpcGlCNzA1UGU0VFlxbkUwUXVKZ2IvdVd0OWNybkM2RkQxNXhY?=
 =?utf-8?B?REpuVzJLY3FIWWhLMnFtemlPNW8rL3ozampOK1hUZWErbGdLVVdVWm4vVDdk?=
 =?utf-8?B?SFE4WHhlZlF4UGxZajBTRk9nMkZTZVVLRmRjSDZMY3ExQXk2YThXVkJlZXRa?=
 =?utf-8?B?RlNzSnNEMDNtUDlwR09HRDBGYkhuVnQ0S2xCS0h0ZGQ5cnhRUnJybmgwZU5s?=
 =?utf-8?B?dCtyL1Z6K0hFb1ZQUnRtNWdIVk5VL1NCbXZLZ0Z0T2lYdFZRVDVXS3EvS1pS?=
 =?utf-8?B?WkRVUUpMczRUS1lKaEtHbWVCK1BmdTJIWkpFbGxYd2NxdlZoTGZiZ3NYUlpo?=
 =?utf-8?B?WkQ2L0J4V3gyMlIrSVk2NXRJVHZMVEVNaXljMmdiUkcrWnp0YlRNM1VucjBv?=
 =?utf-8?B?Z1J5eHUrTXZUbFUrS2srVnFweFVqT0VZMUJqSzhYalExT1hIV2JXdFV3ZDJ2?=
 =?utf-8?B?RzM0d2oyT0hYTmU1anFOZTJYUERCUlVqQnl4Ui9hWE9Ybld1S3c2cG54K09F?=
 =?utf-8?B?b1hZRWF0cnNBPT0=?=
X-Microsoft-Antispam-Message-Info: J4ecyG6PyoSRXUjxOVNwFCksA/UzSN/71s0RWmr2swfLer+p8Gvi1Lt6UvsKUyj3zCV0XGE0CxL7bUOtC8TPIWnGdwgQuNpINov+Br7rjqJtrxkFofpLHd3sdP7Le/qF3/Kxs6MDgX8D24xL6fWo0K5kAdMRvUDHgoAEfoHdolOfriAhH+2c6GFZuG5SQ7xBoxWcZjPvX0JaZKXswUlINQVTUkZSHZ8YFlEBd1y0LrnJj51GlatKyJSi6G4HyRCBcKcMZUwYbLNzOQ2k2sIk3gozQ0pJYpwloNPQxCljnxyuxfx7Ksj2NHjiCboM+rqtH/UKm4/FNW5EJVLfNnnHodpk86geHzujNi8sNbb9JP4=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;6:leOJf5EjYJSv7zSDJTXJp2f+0lZdtlZ33391qFfsCOayDGv0XL6vAsImn8NXG7TrNXmqx3tbRuH8TXVwy73jjhBS110L256jis9uWtRe3pubFF7KM+no7wc/afkpxh8X6Agh0q0deQJVThDc7BZcYnXotgakzgFitgx0mgYQFX05sLnaHh1PdwXq9N8reR+MNVXFrGh+Kx9QD4oBqd/EzpnTsWfUdmgFNV50gWEYlvu72IKObiq40A1h0eEc09QtlpSL9W+UVJWw/nFwU06aenqQJlVmq54DKnVoD7366/aGMG+J7+RoONHyHIH530s5rE+PR0D1zYGh65pWPBDcU3f0jg5jAtvJb/BRvfo/ziY4SPz96d5ybAN5BrokkaxglW+HI+x3vauTOxIBao05XzIJ6KgUKyoFfQfAUj+yVgzbupd42gAFaYimi+JluQxZqmui5u0JoyGT9AXUjri4yw==;5:uRB+UkAyEdc7+BVOALQ2NHp0WU30+YQuLkrWEjxCxOvs7YnryrxjmMbdido0eqP7r6JNKJkgI8xvoMhvHcq+BZpqfRPyppjtA9CodCYdm2tRfow61Cy72YFlvN+96kZFl6bV+WxE31uNpI5MIiU7k4tt/XanZJzuiGsoJH8Quew=;24:it0uEjrMu+nakcfLb6fEm8CiR+n8LT4Kn2+jUnRJ9+fF/OBk8iY72RiiHbOSH4fHWNF9RT3TypJy+eHLFD9c0h4oAD7L/YbvmoIwZ/m7vyg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;7:3nn98o/4k+Iv9DBmfLRlBN4K83svqqOG/3vRMMJBdYuhxx1ruACEChbQvDV5ObXhwdSFOU3boxd2o+PVDMV9zAiAPXgbxtfczNiL5FKUINnI+DjEMyPcff/eg8bv7oJwPgQAwJcYYEcLcI4CX/6QzNHmOpkSHCOTIPIYBcJ6lVOTYh6puKHOqCIbafjb9dbtKjrcNvmJz/4XclPBtW5UBxMgiWs1h5X+oFThas15zUBvcYLiMbCnL+4Qwa1ODt8y;20:xzECjWVnoaORNWVDRpWYyaNqM+NA52fWgHKTfQAWVssOlHDv3ddFUxKg7E4VFivQCt+BN4+ooqezuG/kKG/JA7QExEhA7LoQ9dxaCJfZLDheI0JBJhvaA0Ho0rYgSecYIadOfXBKInotrYdFcv+nyazzFiBYL7V37Kqk+squISfPZW+GQyLAfbOR8hvqeDSCBmUmgsEVv/y/ikMKbCow/kiqgmStHc/YGq2DElmF89yMMETrCEFfoYJ4SFdNQkrk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:31:05.2626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af1ca71-589a-48d8-bce6-08d5e190defc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.07.2018 um 11:09 schrieb Michel Dänzer:
> On 2018-07-04 10:31 AM, Christian König wrote:
>> Am 26.06.2018 um 16:31 schrieb Michel Dänzer:
>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>
>>> Fixes the BUG_ON spuriously triggering under the following
>>> circumstances:
>>>
>>> * ttm_eu_reserve_buffers processes a list containing multiple BOs using
>>>     the same reservation object, so it calls
>>>     reservation_object_reserve_shared with that reservation object once
>>>     for each such BO.
>>> * In reservation_object_reserve_shared, old->shared_count ==
>>>     old->shared_max - 1, so obj->staged is freed in preparation of an
>>>     in-place update.
>>> * ttm_eu_fence_buffer_objects calls reservation_object_add_shared_fence
>>>     once for each of the BOs above, always with the same fence.
>>> * The first call adds the fence in the remaining free slot, after which
>>>     old->shared_count == old->shared_max.
>> Well, the explanation here is not correct. For multiple BOs using the
>> same reservation object we won't call
>> reservation_object_add_shared_fence() multiple times because we move
>> those to the duplicates list in ttm_eu_reserve_buffers().
>>
>> But this bug can still happen because we call
>> reservation_object_add_shared_fence() manually with fences for the same
>> context in a couple of places.
>>
>> One prominent case which comes to my mind are for the VM BOs during
>> updates. Another possibility are VRAM BOs which need to be cleared.
> Thanks. How about the following:
>
> * ttm_eu_reserve_buffers calls reservation_object_reserve_shared.
> * In reservation_object_reserve_shared, shared_count == shared_max - 1,
>    so obj->staged is freed in preparation of an in-place update.
> * ttm_eu_fence_buffer_objects calls reservation_object_add_shared_fence,
>    after which shared_count == shared_max.
> * The amdgpu driver also calls reservation_object_add_shared_fence for
>    the same reservation object, and the BUG_ON triggers.

I would rather completely drop the reference to the ttm_eu_* functions, 
cause those wrappers are completely unrelated to the problem.

Instead let's just note something like the following:

* When reservation_object_reserve_shared is called with shared_count == 
shared_max - 1,
   so obj->staged is freed in preparation of an in-place update.

* Now reservation_object_add_shared_fence is called with the first fence 
and after that shared_count == shared_max.

* After that  reservation_object_add_shared_fence can be called with 
follow up fences from the same context, but since shared_count == 
shared_max we would run into this BUG_ON.

> However, nothing bad would happen in
> reservation_object_add_shared_inplace, since all fences use the same
> context, so they can only occupy a single slot.
>
> Prevent this by moving the BUG_ON to where an overflow would actually
> happen (e.g. if a buggy caller didn't call
> reservation_object_reserve_shared before).
>
>
> Also, I'll add a reference to https://bugs.freedesktop.org/106418 in v2,
> as I suspect this fix is necessary under the circumstances described
> there as well.

The rest sounds good to me.

Regards,
Christian.
