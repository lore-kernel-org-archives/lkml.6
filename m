Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40988C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D392020834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kSgvjUHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D392020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLDGkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:40:45 -0500
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:53216
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeLDGkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oESeI/KFKsvE4xWI0O1H2ohbsgzGizMtxzn6Xma/Y5I=;
 b=kSgvjUHZd4elUStlv1v+2B5IQ031iBM7GfkLP59I9R68a0AHpBeTNCYWxHXemuawdDGzKTQ7jB94wjx5FhNeOMgQAcZBP6rsZoMDrAtnonmGCxErXJEG/2RcSjXgQsCVWI8stXCjGb/J8Ww/ka4FH5iqxTuV4s61PK85Okm67no=
Received: from DM3PR12CA0063.namprd12.prod.outlook.com (2603:10b6:0:56::31) by
 BN7PR12MB2628.namprd12.prod.outlook.com (2603:10b6:408:29::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 06:40:01 +0000
Received: from DM3NAM03FT051.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::208) by DM3PR12CA0063.outlook.office365.com
 (2603:10b6:0:56::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17 via Frontend
 Transport; Tue, 4 Dec 2018 06:40:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT051.mail.protection.outlook.com (10.152.83.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1382.18 via Frontend Transport; Tue, 4 Dec 2018 06:40:01 +0000
Received: from [10.237.74.158] (10.34.1.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server (TLS) id 14.3.389.1; Tue, 4 Dec
 2018 00:40:00 -0600
Subject: Re: [PATCH -next] drm/amdgpu: Fix return value check in
 amdgpu_allocate_static_csa()
To:     Wei Yongjun <weiyongjun1@huawei.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <Rex.Zhu@amd.com>, <Monk.Liu@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <1543905576-38015-1-git-send-email-weiyongjun1@huawei.com>
From:   zhoucm1 <zhoucm1@amd.com>
Message-ID: <fc2e78a7-d739-6e53-864b-75080e124585@amd.com>
Date:   Tue, 4 Dec 2018 14:39:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543905576-38015-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(428003)(199004)(189003)(16526019)(67846002)(65826007)(26005)(478600001)(186003)(72206003)(6666004)(6246003)(11346002)(446003)(53936002)(356004)(426003)(77096007)(4326008)(305945005)(65806001)(7736002)(23676004)(97736004)(3846002)(6116002)(2486003)(336012)(86152003)(14444005)(47776003)(76176011)(5660300001)(64126003)(65956001)(50466002)(31686004)(2870700001)(2201001)(6636002)(31696002)(36756003)(229853002)(58126008)(16576012)(110136005)(316002)(54906003)(81156014)(68736007)(81166006)(8676002)(104016004)(486006)(105586002)(476003)(2906002)(106466001)(8936002)(2616005)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2628;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT051;1:hK/xc+ltiKzdg/7uzPu3GcTyhHAmfRnm18tY8inNyiCQRnSePoIOtnbkpWPIpGeleHMztXwzDUJjlhP9AX91SsTaYQZ4PJCMxsFMxnRn6VHNzYSobz+jN9JZnwYLIvEa
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed89307-2e8a-4ac4-918c-08d659b35125
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2628;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2628;3:JRfx1rkHaD36jhp27cV0k4ZbqczIpWfSvK1sFMJzIbgJ+KUEE2t9qs8ISvHBZEtjbTGmvgOkDgsFh0dCak9WZi21OAnCougEXqRq4dOrl3TkGTyiDyhWZ2SDJi0atHFxk84Wz2JoNukZpE2q/jkRN0TAZGQ87LWvFpQFeOufPT5TlPv1OLcef3aAkj8Us5BiqkteLIkkKnoKGPm9KOMK7Qip92TLcf+lJCKcYTt3r6U+1FTAdlgbDv0lB9wlTiW74/31Fih0rthoNXPm+lBRunT4Lg6oks3WmdRjhyZalK5dyoQtOStOu7vQjJaOv+7fYXFHTKSN5SVOtA+SbiHqxCnd+64A/G/av2Dbn6pV5Ug=;25:EvfBDW0xHpNiBwwDpGrYCZ6uKgvOHMDamGtofNhJpnUVR8p68++JTYCOgsYlPQ+JCZmzJkLpTv5UIGQBKOBRAJM4r8UiB6WPunFj3HED1DfFlD82BJbh9U6UXgpTetg2Zg/ZxLLSDfV5puKMPiCYYJOzXF2Jt3jki3nx7ZQF9hZphSOvf4hMBauH+DOWmndrMRlscGWMnJubHYdDTarvxfksnoCqcNMIEjcm79yc+6nAtnady95aosTahhm+hw4tFpLFnrMGVj1bgdZar/3l4ECZRRT5oJSSj8MKFx/bMdUZXN6bFauF5ppIPMqEQqTt9lLjTuqb2ayivkcarYCUQQ==
X-MS-TrafficTypeDiagnostic: BN7PR12MB2628:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2628;31:4RY5R7nzSiV983IMfBEsj4Ptv7RTTmMisdD7pY42HnvOqVu5oYoo6F+z4xoQvjKbTgcCeq/JkiShIixeC3yXdmSAWwaImU6l7Q0hsoBUEl1/6YI1eJRt9H6YcTHAu9pZk5YDQ42AKNe9nKC05vQI2cQdrik8e8jF+Eo41nOGZPwnClDpd8C2y4o8z+dcVm9t8z2j68tRzl2sIiQer1XwGI9v5WgfAP4dXPhPxHAxKHQ=;20:DCc+12cyaj9NjASyxWfuGKK+P77hwC3BV17mss+phY4yByAa08vNyVxYfgisCDBDqm0PFce54YvuIlNlp0I6G3ERISgdc88EHXybX+fFmTLd/xfZtOIgAPqMVKXAI8ZnkkkihFfvzGfB2SsBKXXrCXd+P1l1VV8RnkrG3m0Rgs6c91rK2c6Ly9Zqv1Sf3SOtyU1B348vswD+qKO02JuYlpyRVjjDDIObU/CFEFRRG4MAL2wJavu8TqZpKhBjsij0WI82JNAZMsChiJe0KCEzprxZgFgi3kBBrmxiFCabSWY1uSFrq1zaVDBlXAnqbwILbD52t5Sq7GjcuU43iu28TyrDnZknxMqA3xKYVVlkT4PXBIdC3DHzXZXOn7xmfCRDZEtLg+ATnQZ9YKH79A+vdL5iYJqKehl9UfyqJ8rcq3uiFRLjf+I2ABNeJt7o50HpfP+4PscPHLrW/wKdROxbjG8Tk8tvVRsvhz4DS/cDpOPo/nIkIgq7CQIU86w3VXk2
X-Microsoft-Antispam-PRVS: <BN7PR12MB2628D2ACB953C13D9576D6B2B4AF0@BN7PR12MB2628.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501493)(52105112)(93006095)(93003095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2628;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2628;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2628;4:RqrdZbUU/x/5N7F+cF46cndAGWcls9itrdMZ6z0lPZ16Liw5SJUNo2KCcuS6oxQj4ewI8Dfwbxs9qMzWT+riaayTO1m+p6smAsyss6QjOqU/nSgZmz0N3MPKlCMZZ5N84a/dRxwpuO1q2d2GuM8XGHu7pT8ualNZ+6GiBelq9cRArTw3fz5sRJDHl0pVjAAz80Rl7I99PDuU3a9fgiOV3gNFjZ6zRZnHjISUMEQqDBrpExq971AEinNX7/2RkmnueNSGXycE5jvkn1gOAkvr2Q==
X-Forefront-PRVS: 0876988AF0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjI4OzIzOmJiY25FaHV0MzZhRVpoNU42ZkJ4dXR0eEpK?=
 =?utf-8?B?ZkNOMUo1ZVpVSGZXUGw4dnVOMlcyb3Zka2NCMUV1UVFSWXU3dkErMndXdERi?=
 =?utf-8?B?UnpjMm9UNDJPTFZCZHhrSW9xRVRoZFJIbElUMXY3M0NTbHNscyt5OTBlWFNG?=
 =?utf-8?B?WGNHWW9uWW5QalpJZUxjZXVSQ2xZZXl5bmFjd0RPSThWVTN3SmVUS0hlUGl3?=
 =?utf-8?B?WTBndTYyL3ZQbWxxQjluUk9lOUlYcUQ2Z1VNeVpKd2duUzBBTTI0TFczWEpX?=
 =?utf-8?B?am90VTJ2dlA1NUU4Z05oa0wzSXpheGNQOHhzZDB5bWtlZ1pqcWQxdXd5bm9H?=
 =?utf-8?B?djhyVmp4V2ZUMUJPaVNEWTJTcWFvSUlIYjdhVUNJNk1RMDFTVXM5WUZGUXRw?=
 =?utf-8?B?TWcwMFB4SnpjQityWXVTSmlCZnRjbVk0NVhFN0xmcWNwRWhTSkNkeHlNdFE0?=
 =?utf-8?B?TnBZMnZWQ2JyZDQzYi85T0JsT1h1YXFSK1BuN1pmelg0enNZZExtNXROOEtT?=
 =?utf-8?B?Vm9ObTNlRVRYWmQ5WUQ3aEtpanFNbDQ0WkFZYTNxVDh1Q0RLbXR2c3RTYmNj?=
 =?utf-8?B?Y1JrNWlvVVJnU1d6SHNDeUd5VTZyTlpUdFhYbTFsTVZYY2ZuNXFuSTN4bWg5?=
 =?utf-8?B?TnBLLzltVkxFZDFVNDMyQ1dSb3ViSit4bzg5TGx1Z0F1T2t2S0swd2tNakRG?=
 =?utf-8?B?aytjbnVVWGt1MFZaRTIwcWUxMzhYRU9nMXhOaWpZalN0K0JEZ3pSTnJqcTVt?=
 =?utf-8?B?RnpHMXlwcmhFS21NSWxjc2t6b2NXcHR1eFdCUmo4YzFEcWlJS1Zvd0FuUW1u?=
 =?utf-8?B?aHFqQytLNy9yNjNzcnJheHQ2WEhWTEhDVlZXcHhUYytnQVg4ZzRhUlhCcXpt?=
 =?utf-8?B?UXBNSXNuYk96N1VVZEowUGV3dUdVNnMrNXV3SGJYTThLSkgrQVlQYzZiZDd0?=
 =?utf-8?B?dE1sN050NmtCTlFjODI5WEdFZ0pBdG9waGVsWG1nQkJGQUYybjVYejMvVzU1?=
 =?utf-8?B?QkNILzVrc1JWNHg2K0xsaTFQdHY5RHBTRWZzTzZIdkFQTE1valI2NTdrTnZM?=
 =?utf-8?B?Nk9ubXJxQXEyNlVQdTR1L0NzSEE1cWZQTDZMVEFGOEpYT3dlU3pCSzFzMTht?=
 =?utf-8?B?TVBDcVNrR3VtSFhsVTVXQ2VxQ3oxekhYVXhCZ1hoL1NWbnFod1hmU1RIV083?=
 =?utf-8?B?cEpVTVBpTlNZYjFkZ3lOQVV0aU5aMkFDamFLTVhyRTBrdktMUXY1dGowY2cv?=
 =?utf-8?B?S04zTEtzT1dQSVByRmlMckQxZUN4REdDQjEzTTdVSFEwZ21KMUpPcSs5OHR5?=
 =?utf-8?B?cWxaMkczQU9LY1hKU29YTktHTG5GVWlIeGIwb0lhdENPOHNRRVpiQ1BXbUox?=
 =?utf-8?B?cEVlazNCcW83RDNLTjBLeHQzamxHOUEwalVlKzRuZTdBNzBNRjhFM0pSWGFK?=
 =?utf-8?B?WllEM2hzN0tWV1l1N3VPdHBKMjhXczZZeGk1MzlQUzJOcCtWR0U3anJPNFZa?=
 =?utf-8?B?bS9QZmR3TEFFK3Z2YkpSVjU5MzByY3JlQ05QSGRNeG5YeklFYXBkZmZodmtu?=
 =?utf-8?B?RDdkWVA5bzhUZFVFa1EzVGh5U2NhT0dEbFhYWXFJb29BMW1pWWRXZTNmdTNn?=
 =?utf-8?B?OUdKOHREUWEyQUpuSlhuNzBhUVFiTU16Q0FBakZOeG5sWWRDMEp2MmRWY29S?=
 =?utf-8?B?dzlSbVFvWnpLQ2tHOTZKRmZlNWhJSXpVRndJZ1U3ZzZWc1g3R2ZUajZ1ZWVU?=
 =?utf-8?B?dkh6TzZab2ttQXBBbUo2V2tLMEtuNVMwWDhWRmFmeFV0MjBZZXUvWlhnNVQ4?=
 =?utf-8?B?dTJSTC9BQ0Nvajhla1p1WlA5UmVidjhBMEFaR1VnYnIrejBvRzEvK2kvN1Nw?=
 =?utf-8?B?RjZWVFZiaHpBM3lHc1d3bEVHYkdvZnlkTDB6Wm1jbG5wVWRpaFV5dm55THpK?=
 =?utf-8?B?N0dERm5HM0w0c1Q4VzZLZm53NVlXZlFpMWxxMEpyaVhUL1BsQmFZWExvWEh4?=
 =?utf-8?Q?hIAl2Q?=
X-Microsoft-Antispam-Message-Info: a9qTmtAYeaj05swRtTuRhigRtk30WxN5LIZl8TE5VoeU390P+rsF/Ctkq8h80XSbRQQWsvB/6gE8f1ozqelPa7Nq0ognz4ODuTlFw9cMQlVHGMExHjh18mJHEhHSKQ6IVVFnX/DLMi/B5lbLJQCaSoIenxee6ZaM5TuMlFQHXA2/6F/Kf6+GTVynY6iK0nOlu0OnzEHNEQL9AK1vyM0Oi+8rs3atuaGqpTwIoM6x1dSrf2/tNrxI+Ax41EDrGWEsgxJeXuRvTpAMK8x8SqgUSOZYJKolLSjIvn4W9qXG158FjDbRvCtZDV+8sby1Xdk6vIGOgktpM1b25bSB8tXEvIEgBlLaSK+/jCtxc39Ni8k=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2628;6:5lc6B5OTdvl9fUGA1vCuEZmUBj+7dsplpUHm8NYutuowSJTkJYCAQPOreBd5R+Ugj4159jw+kJ0d/OepHnYRm6Jc9PaurotJdkJJDzMQ80EKjI7FCeZVYJP/6DxnVNjppctsmpmzO/1eNIVFo+HmfxDCHwSb1159/U3vtCHk3Ymi7GwTH06epkjfac4woC1ZZ2BvGVq0e0XPvZgTlSTrMumFBi2ATRadD1zF5sUWnNXVJvp6iltiaoDmHl7n5e2ncJtxibl60cKPfpdUvtXXvQ59/NZKgw8HuLBjSOjYEsOCeI9pkle07F5cIzgj8Xw0y18hGEroYsRPsD3svxbcIjMhUfOW91VEOeNa1MOQO6sUAGscUlAB/TTrcCja3hSw1ZAU7+XftE3Bx3/FlAlyki192Wsz8KLXdIzRrTcbByMEuiFWfn9dHD/1ieC1j+UVYPybtq9ZJurs2GbJ3Wjl1Q==;5:DovRbN7tpkbMUEw8U9ES/jLm5T89gqeCp9c5yROvQgb5cBQCgaeCvBA/baCb9NNZNarA/JoyFUFcDHnh1L2uJ83iIxQjA+2ZmYArwtC//XL7NjWB2LXozj+/Iid70wy/FwLFNumUwA7jAyD4n+z6sNEQ5HObrKGi+aIitKVIOxE=;7:txXqFa6AEdxO3d8ESpK9Cc+sqeZVaWLVj+nyLe2tbYRwrWWgVNec6bkMpAz4zQ60hm7EeDX8wPV7zvYUPv9II8UOiTDGBNDwQWDOibRXVcXolQyPLwbUJis6+p3K/OE/fkUURVwNBAiNZITwsygrKQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2628;20:j4PnHPR0pMV9K0gl67pKav3By9rLn1f1hErj2DB6UX8cwdwuNKAznfukKOSbDkGakvqlN1yP58exwqJXmI3gKskWigfW5v63abkALfk86xDTkcyko57+FL7r2ayPWmUuD8y6xrA/UydYEyLJp6DphtqDXbIgGgNJD2Tfnfrikq2fbzm6fxegc8kCxV1tL0SGbXKdUQ6NhWcYfUF6C8o/8d9ihrsLMchyLSM9D85Ay3oS0pSAwjlS4DA3zzWUrfJn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2018 06:40:01.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed89307-2e8a-4ac4-918c-08d659b35125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年12月04日 14:39, Wei Yongjun wrote:
> Fix the return value check which testing the wrong variable
> in amdgpu_allocate_static_csa().
>
> Fixes: 7946340fa389 ("drm/amdgpu: Move csa related code to separate file")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> index 0c590dd..a5fbc6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -43,7 +43,7 @@ int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo
>   	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>   				domain, bo,
>   				NULL, &ptr);
> -	if (!bo)
> +	if (!r)
>   		return -ENOMEM;
I guess original is correct as well, if you want to change it, you can 
make like below, not your 'if (!r)':
                 if (r)
                         return r;

-David
>   
>   	memset(ptr, 0, size);
>
>
>

