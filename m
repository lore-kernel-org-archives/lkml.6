Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED0DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67842073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="giYKCIIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67842073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeI2GZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:25:21 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com ([40.107.4.134]:35656
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726804AbeI2GZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9Tq3xx2ai2Cg2ONq39thznVpnP86LNJsefkwWNur+g=;
 b=giYKCIIHo7xOpqPVKrW4L73WsthnLJNFueQHQiJRW0zldN7PlAfVHZo3y8cqgJ8GvDp21oUDf26Pa2Sfh+JrLEHAk4c9UvJrpWo1ktQ3AXrjl0jdCoVl61HO7eWaNgZRhI05TcidtbCaWdqvSZ/JAGOs1JzXa6YkgX0XOuoNGmE=
Received: from localhost.localdomain (128.69.177.17) by
 HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Fri, 28 Sep 2018 23:59:06 +0000
Subject: Re: [PATCH] mm: Fix int overflow in callers of do_shrink_slab()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     gorcunov@openvz.org, mhocko@suse.com, aryabinin@virtuozzo.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
 <20180928141509.fd8f8ac8c0ea61f0cb79d494@linux-foundation.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ec297f1e-529e-799b-b98c-51472cd64b15@virtuozzo.com>
Date:   Sat, 29 Sep 2018 02:58:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180928141509.fd8f8ac8c0ea61f0cb79d494@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.69.177.17]
X-ClientProxiedBy: HE1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:7:15::43) To HE1PR0801MB2025.eurprd08.prod.outlook.com
 (2603:10a6:3:50::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b45354-a68a-4796-d2b2-08d6259e6062
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2025;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;3:926+doHIZ9w0uwIjyZCPPG1jIAV8qbPckYEY0PkhpcdWd5TUMtgR9TxO0GkGAgTRWETsjmDMIrzlmqGyUkEku6donyzL8CvDC+4TBLQPCcNffRVWn0tBwp1zppB1r/EomfxTC3ckiWU/E7WPnIww07UcyaGHvlBqREmeTqJZKUSmjgMk8UO47O+AqGLGF3Q6C+rnf72efh4OwvzbE4hhg5CyHxHqHOiBfYF8Rm7bLTThYJoHEDhrxyJCt3LX0R57;25:jgGv1Go+4Q4XGT4Gqykf+NMAByTblTQt/5JCEb1Ay4DtgCpfGNs335kBoKmy+SpjcpPTRIynQKrvSYRv6tz0mw9E8sHW7X5pG9HThIxk6PLdM74z6YJzkuxk9D4wZAQ3HUdvL2Uo0ZNXd9KP8xym8LVRitvYs2M58qAZcmGO4lmXEkQ52nbWqPvmsc0BQZEcLO427PcvKg4ddhW6fKRJWuXmMc9t6hndyWbIquj8y6SEl8TyEQYNR6qi/Xze1565FsO4adssOPt1IoGj30GjQ5HR04Hs10e+zdp+nqKz3DVbobvN9tZ/CfrR2b+qBeso0UVKebuvzLeZjDJuXcyMAg==;31:XaIzyJtqXVZwi22icSvMSlCEu5ALbgtd5ksQhNgBof4pjLkggLwH2SqzjXY2J2SrzxacYZO60puaVaLdd+Ew0i7Yde/GFmbgCqlXK+ixDhkknS1Xo4niPsJh75WrJaQDA08+98HEhqCNKa6qgIxqSqqQowFDWS5z2kzpu55Cr3nuJrngwdj3x8PJLQi4C72r7XTSM3Q7lMZLqK2bpqa5xpEp+IcjE+aINtlwuqRPu5I=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2025:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:KHcN4rlvhH0Ei/uPzisEyYa4mPsexM0NjdSe56ecML3H8Fz4Esb1De1LKdCcGKEPrymwLkftw8rgNmu7yF8XTcHBLAWaJjmIW8yr4J55DwRyxr95BIayl1yX+d9krqc9qjjUh+dO4IeqW/2EbrW9a3xjj2wX/T5BVu8LceVhYvUnx7uZer0Mw7w+NMMwsIR3/a/2Acx0eIUwrXr97Vvnjeq7gn+uxDNobcgJ79DxotFqZRt7YOa6ctpBEimB48xzh9aemKxbXL0ifB/sbbFxQOapp9Scn3kQId3LwXeITrpHePWUclcUYrdRSxNvM2mcrTmOVVW12EMr1vcRlvo3HEpUPY+963sOgv8yFYCrT4sO+7x7J3I5fGc4r0ycAY8RU/i0fyRXCPC4fjE8qqoZCWfLa4YiTfapWMa8ctCxQ9qg4sHlqqkTQo0IgTdVqKag0gA+wxV6m4bDrojaVEW7tlJNVmcGCxxAi0uutKDG6fs79i0r9zZrxieQrQuwkTJ/;4:helDhiqSQcamtgFFjt2Z4WaavMT+o8PTEQWLL98qutPGAzhoh2FQ3X+j5FZbU7jgCWJZXc4cR/cRZci3nr1fm1ndtRbnRbKUcyjdUzlCQqeKHNhOvTyKlsshvJKP8rm8Nn6pk6/NY4S4qj3P0xK9yw2nzwa1YlUeMkDdxcGlTqXd7vP6NXS8+rJaUn7dHEeLex1er3gX5smOPTyAoai2isFQBNx061lLSAewTlPvYQKfV2KW4u7IafalEYA1v1zZKBUmG8+o4nUx+9+Q3sGqPA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20250AAEBAFA7813667BEC06CDEC0@HE1PR0801MB2025.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:HE1PR0801MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2025;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39850400004)(136003)(396003)(346002)(366004)(189003)(199004)(6246003)(65826007)(81166006)(8936002)(6116002)(478600001)(3846002)(81156014)(305945005)(34290500001)(26005)(7736002)(186003)(16526019)(97736004)(4326008)(2906002)(36756003)(25786009)(68736007)(55236004)(230700001)(229853002)(5660300001)(2616005)(11346002)(64126003)(53546011)(386003)(6506007)(50466002)(446003)(476003)(6916009)(956004)(53936002)(486006)(6486002)(76176011)(31696002)(65956001)(316002)(65806001)(6666003)(52116002)(106356001)(31686004)(58126008)(23676004)(105586002)(86362001)(8676002)(47776003)(52146003)(66066001)(2486003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2025;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjU7MjM6bHFaR1FTZk95RVlOQ0VyS1ZzWWJ0MjVD?=
 =?utf-8?B?OUNTUWFuelRkbnllcWN6WDJHL1JtMTN6UElLUUp0ZVFma1FTTDdMQW1Id0Nm?=
 =?utf-8?B?M3U4a1ZnVGVzRUpna3lxMHkveTNQekx6eWgwUVU0V2paQ015d1c4aEJmd1hl?=
 =?utf-8?B?WjFWR1hBbzBQc2wrRE85Y254cDlpZ2RwRCs2RC9ZekUzL0Q3U24ydk5wMmFw?=
 =?utf-8?B?R1NQaDZ4TFRaWkpkV3ZFcExyTDh4S2g4WlhnSDZnZkltMldRYmpzMUxOeG5F?=
 =?utf-8?B?UWs4bWt5N2NVT0dOYzZkZWphbGhUa0R0NTM0MktmUC9vSUpya2U4elQzd2w0?=
 =?utf-8?B?WUh1R1ZXclR5WVBjN3VwZ0FKcVFvVFZHZGRFczFOc2ZKQlFnbjF3TTFZSk1h?=
 =?utf-8?B?V0JjbmliMG5oQi8rdzFHVUVUT2hlZnZYaXFNM1lxOFBIQjcvam9vSnNFM0Vs?=
 =?utf-8?B?MVFxOGdLYUZiWXRQWFJNdjZ4ekVJRkJkcm56c1ZFeVBEWGVBNUZTVUd0Y0xo?=
 =?utf-8?B?M25sbTZjZ2tLVmRNMVNQaSt2WnBRZS9qYmRXTGc5U1JlQU1tMkxQQjZnQkhT?=
 =?utf-8?B?aUJqYlpJdGNTd2VkTkZhTnZDM3BtV01Qam5YMkFOZzY0S3hpdjlySUh2SFFD?=
 =?utf-8?B?Rm9ITFBvYU4reHBPN0Y3dUFZZ0JtOXJwQjNQRk0wSE83WlU2dEYxZ2pZOXdI?=
 =?utf-8?B?Rkt1c2xNVXlVOURBWmtWS1NueTFzSEcyMGNGRUFSM2FmcWp5d2piNkJNM3d4?=
 =?utf-8?B?bVlNVExTVTR1S1V4VlZrL0I2NzV5YkMwMTRSTXo0c2dCL0JSQU1vUTlKNTl0?=
 =?utf-8?B?R3pNdGxBdFZkNU1yTUFKTDlBQ2l2L2I4MXd5dWlCUjU4VUVIYkoyQlFSbW43?=
 =?utf-8?B?WTdxaEVJYUI1K3o2T3ZqVEZxRkw1dDAzeS9YTEpTT20vTXdSY3E4WnZ4MFpv?=
 =?utf-8?B?RVJGV1loQi9xK1E1S2NZMG1kaWkvNlFhNVJ0a3lXd3kzNE5rVHh6VTdNNDI4?=
 =?utf-8?B?QzVlc2svamZrazNSb1I5MGdrUzJjRTN1MVNIOWVmT3I5a3FjNUwvR2xWbm1Y?=
 =?utf-8?B?YmVzUjV5dE03OG5VbXJnbmFLd2JmbXhTWE1naFh2WFlxeC9jT1ZIL2trMjdz?=
 =?utf-8?B?UkgwSFBDQTh1RGNLOWJuSEIzalFGQWVzV05hQnYvMjlVM00vNTlBdmVlaUlm?=
 =?utf-8?B?MTgrOVJCanZqeXdDRkV6Sm5XajZ6bk9kUW5NUWRLR2VVZkJUTGxUUlhvMVp2?=
 =?utf-8?B?TWRrVXlzNWdiL0NldCtueHlNdkswR3dOTGdtQ3YrSTl6OFZnbHJCUGNQejls?=
 =?utf-8?B?YU83c0hUdU5UM0tEWGxybXE1RDJtRHZzT0hDemZHUmZsMzZ3Mk9ENDVZN2Zp?=
 =?utf-8?B?UTVoQmdMSXhkYXZHY0hiVVRRYXFXUE9QN051RTFqMTJoYkNjVUdPRlh0ZEdH?=
 =?utf-8?B?L213UnhLS0p5aEpVQzBKd1pRanZuREdrMFIzcS9hUlhORGgraysvdTJkRER5?=
 =?utf-8?B?MEVXQWR4dERZLzRLS0VvcjBsR0RVSDVvb2RKQjdEN1FaOFpBekRickFMdHZ3?=
 =?utf-8?B?ZmQ4RU44WFhZbUVJWjlBbm4yNlBqdGlLSHlibm1rZkxPNHc4U1h5ZXNyeFQz?=
 =?utf-8?B?NjJWV01rRW1FMC92RmVKRjVuVkJLTVdHemRUbUlRZHNrUGVEQ3ZGRHo4akZX?=
 =?utf-8?B?eWtWM0tiNjFEcHlkaW5odlBwNzd0VEtKWUU0NUhyejNyWEhOdWg5RFVpRC9Z?=
 =?utf-8?B?bng3RDdtelI3aUcydU9lRHN0Sm8vZ0R1aC9wT3pCYzNUMEg3c2JxSGpmdkw0?=
 =?utf-8?B?UlJkcUlmclpvSXVINUllVy9YU2lpSjAwS2pSYjZZL295cnlqWnRPTFZ4QWFS?=
 =?utf-8?B?RHpteHJiZnZBdFdyckF4YnFlbStOVGU3R29uSzc3WGNyWTNHY1RnbXJnOVU5?=
 =?utf-8?Q?lemwVeil4Z9lSptnsxB7QPAGGKEnhaM0=3D?=
X-Microsoft-Antispam-Message-Info: /OzWy3sHAp+XbIZiROQQmk6q4S1n9EgFUIoLfQg8ImG9mUHtaRlqMZwpbMXguLicGXsCoc6a8zy3bFf40U4nTCOAOR1dvqI9DKGPHlDwjGciPI/I0Rpftl7RIj+rM0sSZbwc4xjW2a+NxFuGo/UKydKKk3VCMSuj+AOuyv6PIDWPT/V25tdpZ8yC9R8f54QZ8kyLaK2JBKrd2V8u5ZwNBJ3ROouUopVx8pTtccmoO36uq5KGH1Qwptf7AXPdJraVfjrYiZ6RNy67tnjjDzpbcln7HKat+u7dlZJ0fxDckT57YVdaLlubBb5e0yFemcSoQCJTfsEWA3UQy/ZNOBBvENYdambOfkozKKdrsxrl/U4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;6:O3e+FAsyXEgI3jLVf9OPiGAP2X1kvZYcyfOKaXmkkPpqVX/Eu8+B2Gh0c9OZz4+js0N8r7cMfVll9iAOYF8PHh+l7oUGrnxXOOjZenh47EZssd2E+d1MmJKXLYJunAnNnYPX+iSUs1Ir//PCnK6gRDHKc48ZLQamUV7VWh0OGPtPbVl9f5Tod6bnMECY4wM5DCbW33j4LhkA8Q3WkgoFmD1nhV4MDbAoCEd88ZxRxuvsvEwACYVfLiukyKENI9lhgQPiOvZRuvRfLYkilXafoz14ZPMf2oWWgyQFZKAb2WB7Zq4iQ1K0SxwJr4qOBOBbQBM7qIdPmljtkYdiw0XA8gageg1zGjMG87Jk7EhHSc6IY3dLJuWp1bHvc7jLSsgztuphdI7HOVqSjdCCBOWeXWPG1gKdCqoqvyTJWgcpYyIbYfD8CPulA0eh/Pb3WuLbYcKY4/yU1zcfI2cPjSJQWQ==;5:3MmjB7NMpmXJvXXw/WYi1f/eGPi7vkKEV88IV1vubFwz0Ulv9imkkB98fUvtRt0OQccvauWx4xMropT+7DNJZhNR2n92Kfz1FmdCKq9MLEHS7qEMUKIwJIAzlqRoRMmhChWa+b2XtELH59c7vaXobhkeH6zqpydr4epe9Nm6oP4=;7:VSB2lguMC+IizYNc5g1sEq/LvZKxulUJrumU+wrxLzr/X62np1OFKhRwtZftwwipHvibiMtYVr6CNbeNKoN4UDfDtvFbAABn+xMfYv/dGzd0iHHAQNX/ugo6drHLpgDaE1i/XJTq3IORBJ3BglKEHfgPPtjIVI7Ba3LxYkr1oNZAIv4uUHZD99GtmRCPjiMbJV7VBOq0hmWkDktMQXsBCsnB9NXf9eqHX4FGf1zGGdxbH755ahFnxVDxQ+hvGJYI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:X3g84frfjSfNNFixS14ulZ9OzzVAZJxHNiaihdxxeM48INVGtakLMtnxF9fmJCu++kYC07ZuUPmL2KhljS8mPFCxVrbOJNC/QL+7fnODB2EPbQM9T/iMwJl1zO49gujklpY1lM5tqXGRB1RN6s8LzJ+jVO8jf4ArtARMJRbYHpk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 23:59:06.5403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b45354-a68a-4796-d2b2-08d6259e6062
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.2018 00:15, Andrew Morton wrote:
> On Fri, 28 Sep 2018 14:28:32 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> do_shrink_slab() returns unsigned long value, and
>> the placing into int variable cuts high bytes off.
>> Then we compare ret and 0xfffffffe (since SHRINK_EMPTY
>> is converted to ret type).
>>
>> Thus, big number of objects returned by do_shrink_slab()
>> may be interpreted as SHRINK_EMPTY, if low bytes of
>> their value are equal to 0xfffffffe. Fix that
>> by declaration ret as unsigned long in these functions.
> 
> Sigh.  How many times has this happened.
> 
>> Reported-by: Cyrill Gorcunov <gorcunov@openvz.org>
> 
> What did he report?  Was it code inspection?  Did the kernel explode? 
> etcetera.  I'm thinking that the fix should be backported but to
> determine that, we need to understand the end-user runtime effects, as
> always.  Please.

Yeah, it was just code inspection. It's need to be a really unlucky person
to meet this in real life -- the probability is very small.

The runtime effect would be the following. Such the unlucky person would
have a single shrinker, which is never called for a single memory cgroup,
despite there are objects charged.

Thanks,
Kirill
