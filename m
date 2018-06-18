Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E8AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03275208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ag6yp3Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03275208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbeFRLfa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:35:30 -0400
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:27969
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933381AbeFRLf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5L+NM0ItaN6egVC0VDvKRaLxwvl0WoYVKlN10TYUhg=;
 b=ag6yp3UrUZTUi1iLWVAyL3Wm+ApjmADqy5M6ineSFyRSZ4EZbeAJ+TtTAtDsvFBBqe2UK60aUbvi4yyjmtQlj8J2LaeL5YU1Gc4sc6Bc62xxoFCxrfTHBUqVP2sgYfQ7eWraneYsot8XYvWsxc2wp6/dn+A4cIo48bSfcyiyXvo=
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4577.namprd05.prod.outlook.com (2603:10b6:406:f2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.14; Mon, 18 Jun 2018 11:35:20 +0000
Subject: Re: [PATCH v3 2/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, stern@rowland.harvard.edu
References: <20180615120827.3989-1-thellstrom@vmware.com>
 <20180615120827.3989-2-thellstrom@vmware.com>
 <20180615164604.GD2458@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <88ca74e5-0d26-4e18-7596-229d12f4afc4@vmware.com>
Date:   Mon, 18 Jun 2018 13:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180615164604.GD2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:7:67::11) To BN7PR05MB4577.namprd05.prod.outlook.com
 (2603:10b6:406:f2::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55dc153c-df01-49fa-c9a6-08d5d50f9466
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4577;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;3:vbjD5pJMwsRDeD0aN4mf/5nZn1fjI9lGBzC1Utsnfbhxdc0+VcGVK+C37krJmzuFYeI0u2C6Diex5k3ktKxLX0mv02L7h5rEHt3CVJxRpvomSjCrA72PjZUsRdsb2y8kfE4eyxeW/Vq0maATLsrBLV+QAmfk0vF2Hqah6WdcCdr71m0c+S2WMDNF0tK5V8QUEpwv5SObVV8pI24rqzTrLiuWnOAOwo9BdQSpuGMN5ae3pgAjEnJgiGoD+jOFn1nN;25:8dykBVp/43KO9bdK4DT+Hn8Xdf6yDz1IWWJXSMhNOdVQX1HIfhw93PsN4ZvQTccSCrZWyLnAxL7wniEFFeCsZpYZ+c8fyeFki9rEJ/CJcmW/bA5Na7GcQMs25wPMXHPcKxXKuk6Gh+14P5nFU54JxKNTeMZVka7ieuj2ozrHXMUpR6yivj+D2W4iCHtoT17cD7pL2edvNjZWnvYeBu6qrrGi9LmT5aEIONHlVMeXHioD6nMHQNoyzyr1m/O9CxPk49qx0x33Yi89n5FfoYyhpbBOpeJzEUmIp0g17ThZ5qrClRDnl+OB8NnnNXFAP5jPMLaFKXn74x4jEuIiPYiV3A==;31:CJCwZOejSI7pwmhnFkuohF/D4KIJ23wtClJKlK0P2ddewp1eIuSl20ZZ36/4XQrd+xMxYBi1UxFAlHwkaGdUQcNV9s5SEFzzCRzsQeZHpEIRUCNntWcUFUmpj8GFwHhKfs9Tmu7lo806pJmn43wJAbkHEokFQ5f7rdSCV1ZQsQhqhToYMojr7bZ/ZU+AeQoamBG7OGEqHX6tNuvlUrgRJHczYw33gNkSc9k0KgfbWW8=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4577:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;20:WpZAYQ9totHVypOOK3hkYHDMyaH/a6EESOyQBNLhHqaKzjIhP8n2HIGlFD7J0TeoJNBrubgWr4pTmvHRDE2RCIFjjhS0kBtce1IbbrLYbdsy6ofUwWFokTPj1FmqnDtNtIIkeg7I3dqyHV9EzRjumSVY9eGbtVakpG42+0ZZkJmTstMz7cWrJITApPE7Z3scHbgCwQYv068TvLtrvun3Na3ATV5RvOfVgvzPcxkhKubM3h0LJgmMYOH86Uhi+u0L3Kz/9/to4MMnuFZsUbSC8o55Watl0UL90r/kX3S5T6RccdRZBFt2JTs12f9vdXVmjxUNfIBz2+zGV33DnnQmL7eNCm1/oHmPYBr8Xh03CDYDAJN59Gu3fVmbNZnMxyXrBpeW8e+uGNLkqs+JzCUnjz5RKaVFxp6rwrl2LQWev//r+kBJSXKU4ClqaJD7tMxKYpJbjA62rMlrRIhWIErha4YM+4xgVTVtU1eIESl5Twr4sN/sA//FGjpPdbSpeMFb;4:qYgApuySlKNk1+eNU5epnqhzDh+mpBGRqCJjkzd2rqm547w3/HBCXiN6HdIiwNSvbSp3YCNAfg6LBZ4UgqDAWngCed+SKpVZgg5ypdTqYniDee+pLg1gAgOQmHfrsrSaJ8gxgP32F1A/uiO2zvitQ5T6utSUK7GSNzH6WF6rs9kfkXrJ85TZw9P29V4xjk2UOPs+aqxVewp9/B/tFBN88knOw/kJ0CDs5eEkVxs7OaxNdC5I3IFRFEnrtsk96Mxtc4eJleqYaNMUvhVEEKfEeA==
X-Microsoft-Antispam-PRVS: <BN7PR05MB45772DF260C97D23F978AC6DA1710@BN7PR05MB4577.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4577;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4577;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(316002)(52116002)(23676004)(52146003)(2486003)(2616005)(476003)(446003)(31696002)(11346002)(956004)(67846002)(47776003)(105586002)(106356001)(86362001)(486006)(65806001)(65956001)(26005)(58126008)(54906003)(76176011)(6506007)(59450400001)(53546011)(386003)(66066001)(16526019)(186003)(36756003)(25786009)(65826007)(305945005)(6246003)(2906002)(4326008)(478600001)(68736007)(3846002)(230700001)(53936002)(6512007)(7416002)(50466002)(64126003)(7736002)(6116002)(6666003)(6916009)(5660300001)(6486002)(8676002)(81156014)(81166006)(8936002)(97736004)(229853002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4577;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA1TUI0NTc3OzIzOlpPWmwrZFZIRWtwWVBwNGZnTVp0RWlIQ3d6?=
 =?utf-8?B?N0ZPSWhPdnNVVVNndVZzamduL2IyUkZlNlBCNmlaYUZMSGZWUWE4anRNMUV4?=
 =?utf-8?B?TThsTkFnMlpkRE1qYUdYUHZEVXhZYzRmM3owQTJQOGk1WjcvRzZTQVFEaDZr?=
 =?utf-8?B?TitORTJUWEh1QWtWREo4ZlN6NWJHTnhkZWhRczFCckdzR1Y2RFVxU2pOYXRn?=
 =?utf-8?B?SWhuRlZNWStZTzYwaWJjdzNIVGM2VVl2eHpUdUtuQThiVE5IeU5QVFd2WWhs?=
 =?utf-8?B?N0pENHFTWTI3TGJVQUVDMWNXRTU5Vkx3aXdIR2xrQkx5cnJvQ3N2dWx3YXVK?=
 =?utf-8?B?NjJxUkRmQTBTWG9TVGJBVFNsQ25vYWc1ZjhKbFZiTXFBRVZsYm1hbmFOdnJt?=
 =?utf-8?B?Z2tBdjYxUFNId2t5U2g4bFh2dmFKUjJpNXJJMUdMbkFzbmcyQmVTejJFTUpU?=
 =?utf-8?B?MjdLb25hV0pQMlFkRE1VazY4MDZLVWxuMmJvbjdmWnorVE85L0loZ284aWo3?=
 =?utf-8?B?NW95QVo4WWR3R2ZVeUpsb05Yd2lrUThLeTNNS0FPWFJ1dVNzSUhlcytpSlBU?=
 =?utf-8?B?OTJ2cVFPNWtDaENpU0grL3VYNnd3TzMyMjNWeGpMbUhxR2RlaXpJUDlLZ0Q0?=
 =?utf-8?B?NjR2SGdNTS8xTjY2K2ZINWdWM0NYWEpOM3VoNC9yTGhwMyt1Nnlhckx0YVV4?=
 =?utf-8?B?T0VNRWdEa01ESzI0N1hmeFhSSUJPS0U5VWJISHdHNy9jNmpUdjViTEJEWVdi?=
 =?utf-8?B?YTlqbUJoRWtrVTBjaGhkQWdxRHdHWXVkWklobEIwanF2YmtZVVZ3OXVjYjFt?=
 =?utf-8?B?d3JOQ0tPMmRIaDZnUExHSWh1ZGhzTCtPNGRibldDbUpxQWF1eDFQS2dyZG5t?=
 =?utf-8?B?ZnFrbVU0b01NNUNnK3I2MGRTeFVWb09MK0Z2RUVyK2VUS0o4bkNVWlZta1dM?=
 =?utf-8?B?clN1dUswd0VHN2Q1SzZzRnI5TkdoNExnOFRTMVVJd09hWlNYeXgyYnBHWEpG?=
 =?utf-8?B?b3hzb0dXSjdlYWpIT0U0dEx2T1ZYZytPRFU3T0E3VDRzeWpLdVdaa3ZOVVNv?=
 =?utf-8?B?eHZMMEx1SDlCbTI0aGVrWVpqcE5KWHZSczMveUdCVXNrQjV0b0s3V3Avejg1?=
 =?utf-8?B?cGEwUjM2RDNhM3VNV05tYm10VEdxcXVoWEVBaE0wRUpZenRiVHZpcnlZYmhj?=
 =?utf-8?B?NXp3NklKMFI3UGhjY0NhMnZZV2FORzJrWmRlZkVybjE4Mnpqb2UyS3ZFWk9x?=
 =?utf-8?B?dVpFYWdkNXdPd2Q3TkNmU2M2YXJmWjRQNVlJSFNpNm9BZjZjVGt2OE1OZXNl?=
 =?utf-8?B?RzVIVlhQb3Z6dS8vWnhZbCtYeXBJanZJRTJkSDNwaGdXZDJLWXZEcms3a3p5?=
 =?utf-8?B?WTg0SEFnWkhTaExndHJaV0Y4V2ozdUhUWUxWZ2xYd25jZGFiMnE4QnRDaDN6?=
 =?utf-8?B?aXF6TGllcnpBREdpK1BDWmJ3YmY0S2JGcmt2VUVvL2dQUXRZM214a2QxbklP?=
 =?utf-8?B?NFZqMFgvV1R4NW5JZjhLcGo2VXVnRERiV0hSY3BpWUY2dkVJMlpOK3A1ZGU2?=
 =?utf-8?B?bzJ5YmpxNFNMeG1OdnA2b1JsampodmVsTDVVVTNpdmdFOUxoMVJycnJzK2dh?=
 =?utf-8?B?LzFqSWFSU1BwcktSSkhvb2dsRDFjN2RsSHZrOHQrNU9hQ2psVnFESkZVRFhn?=
 =?utf-8?B?SXBoYk1pUURGZGk3eUNIcEllVVZ2cTAzM0NkVzUwaFQ2R2toTVhndG1QaTlr?=
 =?utf-8?B?U1VWYWxhV3E2dWd3Z1RYTldUdHpIOTd2YmZnTHJwN1ZSaWNyanc3bG5RejRC?=
 =?utf-8?B?UThVOExiTmlsWkpFU0VqM1UwQUVscEpPYUlJWFJHVmt1Z1FPcW5KTzdvazY3?=
 =?utf-8?B?TnM5cmlIcVNCdk9xZ01hV0o2MUlITVhHQ2U4Sk1jSG9idlFSQ1UzL0ZIcmlL?=
 =?utf-8?B?eElKMlFVaUNNbzFWRzRwNkdPWmd0M0diR01EWlhFVG5QVXpHcnZVdUJpemZj?=
 =?utf-8?B?Z1FQUkxHSlR0K0hWdjNkRU1yME9Bb0p1N240VVdlMjJMVG9udTkxQUJ6bGpz?=
 =?utf-8?Q?E09I=3D?=
X-Microsoft-Antispam-Message-Info: QmvSBXbrRzI2q8fdTd8gha4nsS8cSPJm7wiXcrlyhw7aHwSajJLG5FZBpHJll5FXMfmptYK6yLI6LeGOINTfrl3vBUpwAVvFB6WYEB6opaM7HKEaA0+UInc1ECQOT03GKmIJQbXKLMLAqRu68REQIXVNf2VfcLF/6cQyBdCl9Ra17u7YINONNSKhGMQ/rrmdPew2BadHBXqwz6Go54A0TvWVb8XczR/bEhFAiQccGvFhnpeLsM6m40TXdyWuiWUGz98tfox6/GMY7kbr6+ynyYhXI9uxXcfjG3pmUvaATbVzQHsiU8gPq3SvHyrMpUDv
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;6:hrepUufG9Zwt3+rC03eoPrSXqBVhhg6185B4QRp634rI+2epXdEU9B+WDgYwllDeDyuuLxrYrD2TxZfVbsA9/sNA5UNoZUEbZlHOjE2xlt9xl1+NTOcDkOm8StyGgh2rRJ6umidd1W0UCB9GbTlnoTFJ3JaufOkF1mCD/vd4DD2yMI+585kez0Mcc3QF3N8MxN9KPqB7GJGEPa35/b3Af8p6uOHTww7JwQoxgwqv9XyrkalzUcxsk/XJteID6I3VEqRVVGXJgbH9tCX5SQRzZhBrQ5A27Ow0EUaMs6rU+OamADLs3tlfYOo4Fil3YGEij8H41tbjBbPf9aeR6ou7DB5TObXGXWJ2yamMPNnO4vETUwm2sF7W5CGtKh9fFecmVe2zFTrZEJjPR4yKFTDcaPvJ+1Jl0ZicG7UG82kEZ/CCGex7n2dUuDS732UmPUccbN6jPvaR9JHab3Eo+nVi3A==;5:zx3Pgn2Z0eTqd+rCSVyXjyxq3neIg4uTULV74KWMP1gDbsxOnZslG1XslGPyjfj8E8KBcHmaNe6bgIzinS18ajFDAa6oP59Ye5PbvILvYXh6ct9u+O2Nw1PO0TXrRS4GWS35Ln+tifo/7sMRU8oPV8Gfy6Zi0V7cUd/kZDE1qCk=;24:Xoi9q283wLTg2nJx8HPTnabV9C0/mDzuERxcCTwgbQcIzyaj8dACLW28f1ZUYCq7c8ou166o5lgZDHJDab0ddx7sGt0B0lYPf8v5dgnCeaM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;7:pRvSeLWG9obANBGB+VQEu+GIJUp0NjjWvwwJ9xU/EOCBMw21lJZU401yuUPtQZmbF3/Bq+QqPMqQj132Y1dsXNtZJrMKG5j45ruOZ+4TXl3E6MF1xLndsATEHiwi/EoeV2IpunHQfUkdF7FqxrFbKRLC83r1RJ72e+ceNzciqmv7gvejCJlOvwCrlxImB5PlyDafQtL5itEoocnwAW1uArAX+v8mEV+Lv/k2fwXntAVbbfkObCmup1ZTIzO6expV;20:GXZlN3gKxocmxZEWZOpG8nDcOOLinyxgu1SemY7PkMRbLd4hyFXeMnTPSmUDG4qr5H/ire4HISjDbqFYM2Gf7zOV5Rffp5j0p+fZvibJLZZUXDozbda7FmeJkXa3+9czrZOmNKTg52bHeyx7wnE9edt1nsPmOD3Rv7v/ub6dXf8=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:35:20.0699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dc153c-df01-49fa-c9a6-08d5d50f9466
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 06:46 PM, Peter Zijlstra wrote:
> On Fri, Jun 15, 2018 at 02:08:27PM +0200, Thomas Hellstrom wrote:
>
>> @@ -772,6 +856,25 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>>   	}
>>   
>>   	list_add_tail(&waiter->list, pos);
>> +	if (__mutex_waiter_is_first(lock, waiter))
>> +		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
>> +
>> +	/*
>> +	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
>> +	 * wound that such that we might proceed.
>> +	 */
>> +	if (!is_wait_die) {
>> +		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
>> +
>> +		/*
>> +		 * See ww_mutex_set_context_fastpath(). Orders setting
>> +		 * MUTEX_FLAG_WAITERS (atomic operation) vs the ww->ctx load,
>> +		 * such that either we or the fastpath will wound @ww->ctx.
>> +		 */
>> +		smp_mb__after_atomic();
>> +
>> +		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
>> +	}
> I think we want the smp_mb__after_atomic() in the same branch as
> __mutex_set_flag(). So something like:
>
> 	if (__mutex_waiter_is_first()) {
> 		__mutex_set_flag();
> 		if (!is_wait_die)
> 			smp_mb__after_atomic();
> 	}
>
> Or possibly even without the !is_wait_die. The rules for
> smp_mb__*_atomic() are such that we want it unconditional after an
> atomic, otherwise the semantics get too fuzzy.
>
> Alan (rightfully) complained about that a while ago when he was auditing
> users.
>
>
Hmm, yes that's understandable, although I must admit that when one of 
the accesses we want to order is actually an atomic this shouldn't 
really be causing much confusion.

But I'll think I'll change it back to an smp_mb() then. It's in a 
slowpath, and awkward constructs around smp_mb__after_atomic() might be 
causing grief in the future.

/Thomas


