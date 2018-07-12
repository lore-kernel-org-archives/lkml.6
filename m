Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD0CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A81921479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aoWnaaic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A81921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeGLLW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:22:58 -0400
Received: from mail-ve1eur01on0111.outbound.protection.outlook.com ([104.47.1.111]:45376
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbeGLLW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rDVh5IcJf6uliF4its/YMvyf7zi9MDINxmiKnxOqvo=;
 b=aoWnaaicE28GSZ5SN/IrbZCtpO0XCWa3j+ADKulpfHhBr+VfZO1k3YsZ4pOO/7WIWCh7+6CHeTwsMTmB1Q1t4AAcDk7s78ZjQwFyXhVWQwxTcDuEPUjWl9XFypg/liBlgD7HNWlZV1tR4xjvccukv5rbBlOLEcaz8Zx5pvs9IQc=
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 11:13:44 +0000
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <CALvZod7xAP9AjRWp2XX1uJBkuOprYKCf7hzAXNTdw89dc-n4OA@mail.gmail.com>
 <a9fe3e9e-a1b7-ee19-35e6-af32b5f25a37@virtuozzo.com>
 <CALvZod6eomn1Mt5r28tMthq4b+3MWuWJKgishf_N4UjortzvHw@mail.gmail.com>
 <ed6a04cb-6164-bfab-f2ff-8813068e2e95@virtuozzo.com>
Message-ID: <d1fc50d1-8a64-a118-7040-8ae5606d411d@virtuozzo.com>
Date:   Thu, 12 Jul 2018 14:13:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ed6a04cb-6164-bfab-f2ff-8813068e2e95@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0097.eurprd02.prod.outlook.com
 (2603:10a6:7:29::26) To HE1PR0801MB2025.eurprd08.prod.outlook.com
 (2603:10a6:3:50::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3306acb-c11b-446d-3a4f-08d5e7e888c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2025;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;3:0xs32H5yEcVWHZf4XleP4Rc8kqHOxLqdzzXgoDh7cra9pY1rugbqsjigI4NA402i2+RYDu93AtAkU/3Wjj8XGfiz3yANB5PiMBGhyKYCTVXBQse3Zp5y3AidVPa9WxGdmVbQ7Z2WTefc8DudRdA8oVgCv6d16DHsnZoMWSGAL7T5AAspoXobozlm8FJXV0DstYvf+ajrElXcB9QxlJTRcuhAVptxH5uCcx3LBaK1J0tZqq2D0jFBFf3zjkFB11/y;25:FqUE1yoUFzQOIFpZcwG1PQGTpnJdkTlrQmIzzmUQpE9Ijfg7HXIGQ+1rU+qs16uI5Rg+cPm6bEqpqneEM3gacP/Xpbo1n5FPuwcDdNPnlwtij5UVJSrR/qfGVhLYDCeHg9jPtHsPYucCv/4ZOEJ30JTW3A15kHCXC8uo/ChVhUVG2G1ren/HeYr4IXZgtE3+XCQrlYs8HfsHKjNa/UOfurg7ia+F9rVWjw8J/nwiA0lCbNh4wfDLLd6i0qhNtIZd7zNc/PjldgkqNcEPXgTLUspldTR6kmgJnJifnJeQrI7iQnNZPXAaiTpSUm/H2N20WZ2B36N/PwaxlARD2U8Sog==;31:+KwrAFabZGGygz22jXyDs8Z+ha5PLY5qqTBHmg+elUJgMpXfuTJasb3maxm2n4x4pT0aqvENVq4MZ4AU/JNiPnHVVlfhDJ7ufdUvwuSG5zhunf5BRNOP0wGUrfQDmi83UZgAwYbzaTn95iDC6I/z9qqaw4o87G5Cx1hDACPeZf00NEtuM2f0MBpL5a/PsSloZZv59QoJAay1AZ+w3/F4ImXgRyuRjk1PI2fugdPIwIE=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2025:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:sHhTDmqwIQXWZ4SpDVAdOBGAxfNd6zXypSuedBfVoioAPSddPNuRkQqUEAaPCQ9yUl0Ozc5SwqvJPt41Nj2i10A/e6rlVRkP7f/xWylDELsA0o7xzMUMblKHJOT3O1y8IL6Q94wKJE3Ock4vwaq3j7n9cj20cOi7EqgERSugFRulgJFp4n5Eo8ruudPbjGqkEzA8VwTJTgWoL/DImqXHLJHK7cvkVgdJMGN5hhLtr9PDSmd278M8nOeqTjJIcx7nUsMxEtXS4Szi1hrnXrQa9UJ89kIqyhM6e6XT5ZrjRKORFwV8hRBvd6vxjT+Ar3tS9x243SyGrZiMMAYJp3oFke8cMDEv5Q1Kx/Lqfu1P591k7Ob2XgYw7JvyHn+PWiEDxOnru8C5Q/xfwRWqRVM0TfsQfTBBfCCd3ZXOZgjQoeaIYRTb/3wP/LkyZ1EukcFmHw1hnHif/qC3KcJp+7Up6sSJQRVhOnXA80kuDqsYl5j7kMkSZHkFnQg/p9L24quP;4:hNfplT7POLmoiRVbiStHZJd5t0HCItxxa1hU+qdc7c+KGa7Vr7yKsOibrxEe4Gez4N92JSzEKwUYIdg2qbjEwdp/TIHxoR2IAjkiSS2iBXUS02epWSWLHVB4s0OIugJGIWIvwYydgRKFAT+yMx57o43Qz/QrygrhG/JmXObTu+XpI+oE1Wsm1fsxowI/PuMg2zv1HPSgBzBIj1RRMTDUR1YvKOKuFQ0QZLl7y3mCzvaraF3tNJh04KpHysN2EvxvenTcsHGatyj2PhbYdLPAvA+V2me2yht2GvA+dySTOg6j5aktmtKXhOR9CEWHelRH
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2025C4FE0132E8B7510E8A2DCD590@HE1PR0801MB2025.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2025;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39850400004)(366004)(136003)(376002)(346002)(199004)(189003)(51914003)(105586002)(31686004)(106356001)(77096007)(68736007)(230700001)(8936002)(36756003)(81166006)(25786009)(81156014)(3846002)(956004)(486006)(476003)(8676002)(2906002)(31696002)(2616005)(39060400002)(53936002)(186003)(6246003)(4326008)(6116002)(14444005)(26005)(65956001)(2486003)(52146003)(7416002)(50466002)(23676004)(97736004)(6916009)(446003)(54906003)(86362001)(66066001)(16526019)(76176011)(305945005)(7736002)(47776003)(386003)(65826007)(53546011)(93886005)(966005)(6306002)(5660300001)(11346002)(52116002)(6666003)(16576012)(58126008)(316002)(229853002)(64126003)(6486002)(65806001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2025;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjU7MjM6bjNsWkUvRVE3alQ4U3BHa29xaVV1VXQ1?=
 =?utf-8?B?RlUxUGdPSXJrcm9qMkVLTFk4MldBblowbU1iL2ZlZm9iWnZsRWg1bUlNREMy?=
 =?utf-8?B?VWt6K1JWZVJtMlo1M0w2MG5Ia1JJTTRUNkMxdTd6OVI5aGp3bE5RcnZIK0Vz?=
 =?utf-8?B?cCt1QVRVZnZINDh3OFg3ckh4eDRtNjhEL0V5S2JrMzBXMllBbVRIWjRvaVFL?=
 =?utf-8?B?NXhxaXJ5UkVXOWlXeHhJRXBTdWhHNHhCcExnMUw1S005ekEyQkhlUU9DcWVJ?=
 =?utf-8?B?WVFweUZBWFQ4Q2ptM3dpVzZnVkx0My9XUVdaVDJyUk5rZTBQQkVWMXdVM3M2?=
 =?utf-8?B?cEJ3bU5qc1ZMNHcxZlkySnY2SWRzSUk4SU1qZUhPSS9CeU1oWDFZblBEZHhB?=
 =?utf-8?B?dGFSWEpqOHc5Z3lCWnlMZzdkWmEwMjBSUGJ2NlcrRE4rN241ZnRtcElxM040?=
 =?utf-8?B?dkJaRHhGUVRGRTNrRFY3Z2Z2NFBGVkllWHhOUHF6d2JMRnM2bE5ieit4THdt?=
 =?utf-8?B?dHo4WWphWWdVNXgvTWVyQlhINnI5Wi96bnR2UmlUWTVSV3Fleko3ZlRUa3dx?=
 =?utf-8?B?YXVnYys4dC9CTWdNRkl2LzZEMFNnS2NwNlNkU09VcUFmelkrNC9JUWRvSzhz?=
 =?utf-8?B?Mm1pUFd6Z1BtbFVXVVdJUUdZWktLZXlVUHhBWm9iTnZLNVo4TWpwM3ArdFR1?=
 =?utf-8?B?dTZIZ0JmS1ZHL0dWcEh2WHJqamR2ZWM5US9BYWZMbCsrSG5NOFoyTjVIUG9x?=
 =?utf-8?B?ZG9GUm5Vcm1meGVQZ25vZ3FyN2YxVWlVV211dDFFa3JwNTdVWWF5eUpibmt2?=
 =?utf-8?B?a0E3dGN3Rm9QMEI1YUZBZjl4N25jdVM2Z1lGOVF1VFNZczhFUkxpMm1mcDdn?=
 =?utf-8?B?RlpUTGNJNmRuVmhyeVA2a254K2ljZjVVRTBSQmVsUWRFQm4wRk9xRkhsbXRl?=
 =?utf-8?B?RERHOGFBV0hQRWtpUlJwTkFvYURHWG5oQkQ5aHlEYUNXVUF4ZWt1UXczMXR1?=
 =?utf-8?B?SHlJSTVhYys2b2xDVjMxY0hlclJhU21KZndQU2VKZnN3aXNUdGFaOXAwMlF6?=
 =?utf-8?B?UkV2T2xRSmo5Um9QQW8xekxNKy9yS2h3NjZjVHBlVTExRE9CelN5ZEdDeXVw?=
 =?utf-8?B?TWcvcHR4QnZQbXFHbS94cXo3WHRIcGh0MHBudFNuWlpsNVVkYW5YeVZQK1k5?=
 =?utf-8?B?TUREb0lHdkhUUTAwSFhxMnE5NHBpQ1VWZXRCcmRHVFdkTG5RSGhSNFh4b2Qw?=
 =?utf-8?B?YVhIdkV4MlVSd0VRQmtDL3RUU3lacDI4Z1RkK0t6NzRpa05nM1I1N21FWUF2?=
 =?utf-8?B?ZHlJKzZoZmVocmlqbjVFTHlWUXJHZ2pvT09YVkhXckY3WE0vYjZiUDIvd2RR?=
 =?utf-8?B?dTA1ZkhnMlBkY1NNZkpOOFl2MXN6dFF3eHJ3NjdEQ0lMZUQzSElIejNaeUpY?=
 =?utf-8?B?RHBUcjZCOHROTVJ3S1U0dXNsWUVxK1JQcXlja0Z2VHZWUUlETGlNeE1ZRU42?=
 =?utf-8?B?Q0J5akZVRVYxVFRJOWdKbTZkQlJ2TUl1elh4b1FSUE5OK0pUSHpzN2xwMDI2?=
 =?utf-8?B?Wk1VWjBiRnZYTWVtS3BUa1h1U04xenh4ZDFGai9VU1F3QnFvcEtGbmVhSnZW?=
 =?utf-8?B?K2VXRDA4cVY0RXNkaVJSeHE5Q3FzREhhM1cwcnFjYkQzbWwwUzJ0RFVDR1pS?=
 =?utf-8?B?d2lCWmJ2WGlNdWVvTjlVUHlPM1VRWkpNV1JmVmM0bWVnL214WjBaaHQ4eCtz?=
 =?utf-8?B?SkhUTEJYVzE0dVRhdDFEUWFYN2xuSVMxR1MrcEptNy9nZHQ1NVdxQzFlQmRT?=
 =?utf-8?B?dkpSZWJ2Q2FJcTloay9mR2VRU0llTXdDSUc4TzFVLytJT3V1L0dtTlNSMFFW?=
 =?utf-8?B?SkVPTFExYTEyNlhudHFKM3J4SDRVK1kyUGFPSjV0K0R5T3NyNU85dkI4Ynl6?=
 =?utf-8?B?UGl1ZFBpVGtFTkZTSEZYNHVFd29KN1E5ZzB2VVlYU1RqVWhhdlJFN0FGWWpL?=
 =?utf-8?B?UDRLa0pIODFHQktGNU1Qc2RIZVJaZXg2Q05mOGF3SnVwanpOemdlUHdOUXBX?=
 =?utf-8?B?amEvaWQ0eThBVmR3TkVsb3VhZnVjSUZWMWNQdGhYNzZoblRERE1OcUFGZWVH?=
 =?utf-8?Q?VYihNqJzxRr0dwmAyhGX/j1AA=3D?=
X-Microsoft-Antispam-Message-Info: ch6wpBrp8tPbFcTeB5er8l2h2jLMsjKB+qMccYHCeErBP4WLVe+JwvqlhO6QHG4XvtqCaDsp9JIy3/WC0UjKjj9cg+RubfffP/qdoh1/SPO+ffifC3rigJLQCkhvTHxeN59IKP7QihC9IQuD32LXBcVI3FEr2bCRjTT7dH3F7HYhXsmCacwGiSeRLsBwIW3/9fXWtUtaJRBzS2pQdy56KqFHr9OeYqY5YgHMjqYgJtijaSNzx5HGHmHHVOfaVNkx6ig7MiM8pId497sXyhl9ZMpJ3on+1NhemBCnTauyn6zv+gL/519G1KmDCjBHz/7VDW35JoTLS0vfV93ZKwqqbupZd02IgkgyrSA59Zpckco=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;6:TQQU4MSkY/15DDmR2y1/clHyV2E+87SpLMJBmzRM1znJU3NeAmuvDqnaTn9XEGjLNk4ohF7CLa1RKIXgiHByudQDIJGhJxSHc5c79qNVFrqWoybBVlR2Uo0Znq/UkaGeh0DKcvFE+n50esF41Y242AzEasAjDxgeBNNs1UznBvLtdt/3y9Jr5F6+UGM6XkJoabARqO2Q9CoZobxNcLzalDg30CpkIiMmzI/KxAhtpbYDAJqvNqHVSyTtAzXcai3o0r5Ms9BQIrM1bABVt5YzffmQeo2c6l9Z8OxzmI0ezLUvf+4f1ytNbdAl8BNHt+iFtPUV23Xr8O2mX+7xcojHmFqZ1DJQV5BrG17QhEosHBMzoRyCwdqyGr0i16Vpx1vxcTzutk42ICkkpKBsK4U+mkos5G0srWn0tkSAjUpUzILut+92vJHmP/R3QhI3wlluCSiiYJ7TUCGR6LXfdFJk6w==;5:G1SCcEQSKNITbket13D8qdwAtByRt4Le3gFwzmMv5J+9E64pau2U7l+qMI5hIMwwEXN3Kzqe2zyrUOFl9cSE0yZp7FkhnZn9dG5+VKlHBZ/1arG12trgbI9VdfQ3iA2IkQNmkk+ZCdjL5rKo4w9N00fWXu7UgHhTihRF74bnT38=;24:jvLGvK6QaFacMj3HMSPayz5vnfceQJvr3SuPzeiKtVTAcxCtLCodrmt/T8niRtZtw3TvPjqSbvCuesvs/Jr7zsYOthwPd3/womi4rwKFR6c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;7:6NFHlXvYXZE3nBXdjrm51XNyeL28IttSSy3ZF/5+cWaTFrjDPJLxNhoow/U/GckhM6QS9W5SLhEpGlsqjWuqW2B7hUfAVdh6Ei1fIyROJO/MGvhcDpJlvYCEgmkR1h11lh/XSDicaZ37qmbrLrlPsD7U0vFViBz0VDjibgawgyW4QAgkEq8mgwtKNtxdC+qqCfGSuL5hyBTfVaBlIiHRlw6Ec4wGR5+mTIWoHjzrc2vQEUZu29iq4fytDTwkKcDG;20:8io2vCcVsur8UxCbjGrLlOghm8GyxDV9ZgxePwo4gVGz0Osj5O0vmH+TF3frvWldeIYYzq1cjevc6RzdlmrHokLzKsNQtaQh3AUpMAikMLKqJxD1a1cw1tmW+vguZfcqHhmtltcdZsvokZNjxSZChRCtmvWi0UFNJjTQezVan5c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 11:13:44.0381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3306acb-c11b-446d-3a4f-08d5e7e888c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 20:32, Kirill Tkhai wrote:
> On 03.07.2018 20:00, Shakeel Butt wrote:
>> On Tue, Jul 3, 2018 at 9:17 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>
>>> Hi, Shakeel,
>>>
>>> On 03.07.2018 18:46, Shakeel Butt wrote:
>>>> On Tue, Jul 3, 2018 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>>
>>>>> On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
>>>>>>  static LIST_HEAD(shrinker_list);
>>>>>>  static DECLARE_RWSEM(shrinker_rwsem);
>>>>>>
>>>>>> +#ifdef CONFIG_MEMCG_KMEM
>>>>>> +static DEFINE_IDR(shrinker_idr);
>>>>>> +static int shrinker_nr_max;
>>>>>
>>>>> So ... we've now got a list_head (shrinker_list) which contains all of
>>>>> the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?
>>>>>
>>>>> Why not replace the shrinker_list with the shrinker_idr?  It's only used
>>>>> twice in vmscan.c:
>>>>>
>>>>> void register_shrinker_prepared(struct shrinker *shrinker)
>>>>> {
>>>>>         down_write(&shrinker_rwsem);
>>>>>         list_add_tail(&shrinker->list, &shrinker_list);
>>>>>         up_write(&shrinker_rwsem);
>>>>> }
>>>>>
>>>>>         list_for_each_entry(shrinker, &shrinker_list, list) {
>>>>> ...
>>>>>
>>>>> The first is simply idr_alloc() and the second is
>>>>>
>>>>>         idr_for_each_entry(&shrinker_idr, shrinker, id) {
>>>>>
>>>>> I understand there's a difference between allocating the shrinker's ID and
>>>>> adding it to the list.  You can do this by calling idr_alloc with NULL
>>>>> as the pointer, and then using idr_replace() when you want to add the
>>>>> shrinker to the list.  idr_for_each_entry() skips over NULL entries.
>>>>>
>>>>> This will actually reduce the size of each shrinker and be more
>>>>> cache-efficient when calling the shrinkers.  I think we can also get
>>>>> rid of the shrinker_rwsem eventually, but let's leave it for now.
>>>>
>>>> Can you explain how you envision shrinker_rwsem can be removed? I am
>>>> very much interested in doing that.
>>>
>>> Have you tried to do some games with SRCU? It looks like we just need to
>>> teach count_objects() and scan_objects() to work with semi-destructed
>>> shrinkers. Though, this looks this will make impossible to introduce
>>> shrinkers, which do synchronize_srcu() in scan_objects() for example.
>>> Not sure, someone will actually use this, and this is possible to consider
>>> as limitation.
>>>
>>
>> Hi Kirill, I tried SRCU and the discussion is at
>> https://lore.kernel.org/lkml/20171117173521.GA21692@infradead.org/T/#u
>>
>> Paul E. McKenney suggested to enable SRCU unconditionally. So, to use
>> SRCU for shrinkers, we first have to push unconditional SRCU.
> 
> First time, I read this, I though the talk goes about some new srcu_read_lock()
> without an argument and it's need to rework SRCU in some huge way. Thanks
> god, it was just a misreading :)
>> Tetsuo had another lockless solution which was a bit involved but does
>> not depend on SRCU.
> 
> Ok, I see refcounters suggestion. Thanks for the link, Shakeel!

Just returning to this theme. Since both of the suggested ways contain
srcu synchronization, it may be better just to use percpu-rwsem, since
there is the same functionality out-of-box.

register/unregister_shrinker() will use two rw semaphores:

register_shrinker()
{
	down_write(&shrinker_rwsem);
	idr_alloc();
	up_write(&shrinker_rwsem);
}

unregister_shrinker()
{
	percpu_down_write(&percpu_shrinker_rwsem);
	down_write(&shrinker_rwsem);
	idr_remove();
	up_write(&shrinker_rwsem);
	percpu_up_write(&percpu_shrinker_rwsem);
}

shrink_slab()
{
	percpu_down_read(&percpu_shrinker_rwsem);
	rcu_read_lock();
	shrinker = idr_find();
	rcu_read_unlock();

	do_shrink_slab(shrinker);
	percpu_up_read(&percpu_shrinker_rwsem);
}

1)Here is a trick to make register_shrinker() not use percpu semaphore,
  i.e., not to wait RCU synchronization. This just makes register_shrinker()
  faster. So, we introduce 2 semaphores instead of 1:
  shrinker_rwsem to protect IDR and percpu_shrinker_rwsem.

2)rcu_read_lock() -- to synchronize idr_find() with idr_alloc().
  Not sure, we really need this. It's possible, lockless idr_find()
  is OK in parallel with allocation of new ID. Parallel removing
  is not possible because of percpu rwsem.

3)Places, which are performance critical to unregister_shrinker() speed
  (e.g., like deactivate_locked_super(), as we want umount() to be fast),
  may just call it delayed from work:

diff --git a/fs/super.c b/fs/super.c
index 13647d4fd262..b4a98cb00166 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -324,19 +324,7 @@ void deactivate_locked_super(struct super_block *s)
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
 		cleancache_invalidate_fs(s);
-		unregister_shrinker(&s->s_shrink);
-		fs->kill_sb(s);
-
-		/*
-		 * Since list_lru_destroy() may sleep, we cannot call it from
-		 * put_super(), where we hold the sb_lock. Therefore we destroy
-		 * the lru lists right now.
-		 */
-		list_lru_destroy(&s->s_dentry_lru);
-		list_lru_destroy(&s->s_inode_lru);
-
-		put_filesystem(fs);
-		put_super(s);
+		schedule_delayed_deactivate_super(s)
 	} else {
 		up_write(&s->s_umount);
 	}


Kirill
