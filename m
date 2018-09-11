Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21FC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7D22086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="RxBJhVo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7D22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeIKFzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:55:40 -0400
Received: from mail-eopbgr50131.outbound.protection.outlook.com ([40.107.5.131]:14976
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbeIKFzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0HPootfb31yPzJlvGRhDvHAg2smYnJWldnkFHllpjQ=;
 b=RxBJhVo8S0c59xhKH84RI/oiF2FR01ddwGWULSZAroHKhsiszUnmYBZnezNqHAHgds0qfDDkkg7LfahlS0aqICXYTP5Xq/xVJrl1a0WZzd/TP+lzy/B8QZRjEZ8btu59mMIdeGMgnN1R/GLWHIg/8nAT4w8AHIGNfz+bLliqFqs=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Tue, 11 Sep
 2018 00:58:55 +0000
Subject: Re: [PATCH v4 1/2] rtmutex: allow specifying a subclass for nested
 locking
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
References: <20180720083914.1950-1-peda@axentia.se>
 <20180720083914.1950-2-peda@axentia.se>
 <20180910232712.fcpdfaagm4xdb24n@home.goodmis.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e85878a5-a5ae-59ea-0101-20361f49d32d@axentia.se>
Date:   Tue, 11 Sep 2018 02:58:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910232712.fcpdfaagm4xdb24n@home.goodmis.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::21)
 To AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419217f6-3cc8-4c77-f5d6-08d61781c0d4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:UkWzDl0Luh0f2bqYzZwjAz5NJ3bpZ7vMZLUUOntdo8RjAMzEx91y3Mc+AxQZ65iCgSUTOFHfrSDE3sLJQMWFebPOXE+xs4DZmw7jBCUXUllhFzc1snM7/jTIoHkmF0Q7AFK8dlr3CE6On9StaOLJr96nPn2BHFlKPEjVNaEFH7qj/ppEqjPKS0dc6qg8bG4GTMqzZLjt7gLgwHShEUpANSAqkRX5usfZnywiH7B2t+Qu3ScoiqafYkoOhTKvpbiI;25:i4ZZi89f5Ic4cXlOa0ldqDTMzrVaPbyWDc65WVwa94xGiH1ixZBwQJKDzpu/FH9L2d5WlWeWvOvpzlWY9VTiYFHFAhRX+R1rfJD0dTwtuY6b3XBnt6mrFAoOq1wjTsxSEEYHD8HD3LWnOBHc0we8a+Sb+6iMdrzs9VRO4s/C08nRmL7wLtS/En8vRIC6UXltTp6dUET/1DJyqRWOo7uzs7dRnmdhKnLiDNhCIHFDpMi6FnTc6Q247ZmeMvIDYJz2ODedf2CQ0hdjFpTFDpNj45pDu9XKcI8bfrcw777TYri4SffA7YYis5W2KEp0bKDay6uFsP6e3E5JAbxWGgOrOg==;31:6YMn9Bpdayz1e0qS3l6hXsT1N8aBVM6PzuZEmwo71z7Dygt6He2rYaD9oNqLWOQKizzfIMH1MEZwY5KIxqg1YVk3y/se6bPT7nee/KorMZT9tcgVPBZUUdeSFzlG80ueQTqG9DhoWL1aerP53qsxj0iO0PQN2KIw6Z/WRT66N/YT2bKMrxUa5QVL5qnxTMlO246+iFTwA/HWZi39IoEmqD77Hr3twt0eiM7m8AtLN2I=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452B2C12E1063386BA0E2D1BC040@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699050);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:qIoMFCjkprbill39ZufioCNcQn1Gu9yXY7mda3Sj3fuin3zSQBEohyRhP6BD8moPDaq0NEW2CGeFORXsrbIm7M1IrBa+KqvDJB4OBzTDkY0U4v3WyvbYbDquwKgxdM0UE1HUO9QNBWrRgiBr6UJZ36nzZR2UX/0EudPquRoqY8imaRITN+BSAJxupKoppuZe+cixJxWXJh0fxQ2afKEAIPJcq8cdB0J9Cy2Zb49MrRZ2IzTLPd/LnXjWhAByfkJPGrGed3sqjXQR7fVaqqauBQ==
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(346002)(39830400003)(136003)(396003)(199004)(189003)(117156002)(25786009)(31686004)(2616005)(476003)(486006)(11346002)(956004)(446003)(6346003)(386003)(53546011)(74482002)(26005)(77096007)(4326008)(186003)(3260700006)(16526019)(53936002)(97736004)(478600001)(5660300001)(229853002)(6486002)(6246003)(64126003)(6666003)(65826007)(3846002)(6116002)(6916009)(50466002)(66066001)(58126008)(2906002)(54906003)(47776003)(16576012)(316002)(65806001)(36756003)(558084003)(106356001)(105586002)(230700001)(81156014)(23676004)(65956001)(31696002)(81166006)(86362001)(52146003)(8676002)(76176011)(8936002)(36916002)(52116002)(2486003)(14444005)(7416002)(7736002)(305945005)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6ZkZYdGxPZ21nWWw1M05WZzdpVkRUVTlk?=
 =?utf-8?B?eFM2NGlXZkNmdHkxdENXcFBBVlBXOExKbE1CVDR0OU9jcDc3akhMaUx5YkNw?=
 =?utf-8?B?SnRqYmJ0VXNiSVh1US9YSEZJbU5Cb3pVd1RxbXFQcDY1YXp2TXZSbFdJWVlh?=
 =?utf-8?B?RVVwUGJNUTRxU0NOdTdVQkE0a0lIZHk4akE3OVh3TjJrK3hBNVJJQUNGelFv?=
 =?utf-8?B?ZUcxejRlYWpvNTJCU2RXY016VEJUVjBDcjZVOEVVN0t2SWdHWmEvbVVmdGp5?=
 =?utf-8?B?S1M1KzdyVnRvMXBRUTdsM1Z5RkRxZnZVN1lpdWJPRzlMcnVZRDExWGVnK0M2?=
 =?utf-8?B?MCtuZ0wrcEJSZFliVjdsVmNvaVdKU0pEdDJ4UDJVeU4vUVNVSzN5ZGU4RTRK?=
 =?utf-8?B?SzFnaW5JYnR2VGY4K1JIZzY3dUpUekpwOXNtTnNXRGEyNGVKUmkvV1gwWjVn?=
 =?utf-8?B?N2xzMmJiaEdrZVBnd21VTmJUZW9DZFFDS0txcEk5Q1pVNDU2QlRuMjZOVnZI?=
 =?utf-8?B?KzZZaXo2Y3QvN2ZyWkJxcERJaWFiOWNpMy9BRjA4RzBISUMvdWtHSXlhUHdp?=
 =?utf-8?B?aGljZzVKNkhGcFFUUnFlalVGU09rVWQrN3hsQ2ozeGY0S3Z2c3RyYkdGTXoy?=
 =?utf-8?B?bU4xbFc3TEJVT013eVdQRHNDT3h1VklnZm41c0RYN0lJQ2RNeW5HUmpZQVli?=
 =?utf-8?B?ZHowQjlEYzIyR1ZiSlFjUXA3d3JDaW5FeHQyMHFlK3B3enExR2Z2VncyQkly?=
 =?utf-8?B?UTBsanFwcUt2Q1doSTRlT3Z4Q25jd0ErWXArUDluRFdNRklITG1GQjh3Uitq?=
 =?utf-8?B?M0JsT2E3cXZZZkhOU3QrOFhBTzg0VnMvWDljTFIzYjBhM3ZNUkNEdmE2czky?=
 =?utf-8?B?V0g1VVlYT25GOTg0SlY5a2l3YjI4SnNiOXRDRlVlVlhBT0ZkRTNDdEIvYWRY?=
 =?utf-8?B?YUxIOHc4NEZlaDhhL2VRb0dhK1ZEZHd0eUx4QnU5bkJMTDl5M0g4ZjhudmFI?=
 =?utf-8?B?RzdUUFkvSCtzR01zajZsNU41NzNKckcvVXhWYVgvM0xpY2pweUc3Z3NQcVJs?=
 =?utf-8?B?ZG91Ky9kTWY3aFRWblZ1MWQyKzYxbU5OaWRkdEdVWWxoMUNjNDV6R3plSllv?=
 =?utf-8?B?bG9mQzN6OWNwU09vZG5VcDVHRmhXKzhRU2VlZWlla2RTWXlVVklJSTh4VHZD?=
 =?utf-8?B?RkZ5SjlmNllCTG5lN3VQM3hxUWMySS8vbHl1MmRuSnhkcHk4Z1hlWUZVNHY5?=
 =?utf-8?B?b0U5NzUxTkJCTkVBd2kwdGk1eDJtNzhNMm9tQkFGY3NGb2QraklHWjJXbHBq?=
 =?utf-8?B?dDY3K1MwRU1nNnlwV2pyd1FxUThHUDFObXFDU3JzWnlmdjNSSVRZNXZZSUlO?=
 =?utf-8?B?Z1FIbWFFb1dPVDArWHI2cXZsUi83RjFHbFhqSU5SK2pmZWYyUFIxRnBVUytM?=
 =?utf-8?B?dDJUZVVwV3E0bFg0ck8rMXRIakFUR0kvYTA2YzFnNkVSWS9CZXcvNm45ZjhK?=
 =?utf-8?B?V1JHMGpYMkE2bmM4VGhaYUtZZFdvUzZvSjU3REpGZCtpZ3F5Q1loQWJuQklm?=
 =?utf-8?B?WXUyTCs0TWNJcEZ1NEM1YW1BNEd0eFNTVW1ZMldPZDRwV3pIWE9LWi84WEh2?=
 =?utf-8?B?QmUrM0NPUE1oUnVjT2UyVjZhRHJNWkNueVpNR3pzVjN4TExrSzZsVXAzc3dv?=
 =?utf-8?B?cXB4NGN0cU5ia09PdU1WeThFVmVSMWtFQW11MTg4Y3Bia2srNUZYTVRUTUNs?=
 =?utf-8?B?QUxDTS9YVFd6UktFWnFVN2hUb2YwUDhERE82ZHhvUHZDUUdyMlhCNitqQ1ZR?=
 =?utf-8?B?b1J3REVEUjg0M0FQQXVhL0FJTVZ0Q0t3OFBISEVrcE5WS0YxRVhhMG9DdGVl?=
 =?utf-8?B?ZHgzU041TEkzM0lramVTVWhKWDFQT05yMDZvcHpnVkZIeXQ0bTd4NEZsak1O?=
 =?utf-8?B?by9EdTVsWXpFeWdjYlJBcWNGcjRBWlVpRUFhU2ljdHQxYk9LZ0FJYUx0eVhm?=
 =?utf-8?B?L255Q0cwSSsrZDVlM0pyRnVrTHo4YlhCUkVHR2lBbzg2aTRQejJNSUIzSFRW?=
 =?utf-8?B?ZzV4Y1RGSlgxMzd3RWZjSEdMY0JXUEY4dm0wWVVyaklrVVZ1VDNWUHNwVStE?=
 =?utf-8?B?TmJadmtHRHFOQWoxei9ETElIWlRGVnFEN0M2VXBaNGRZU2RsUE8zQTVoZXhV?=
 =?utf-8?B?blAyNmtZZ2xZTGJ6b2JtenlXd3ZjdXc9PQ==?=
X-Microsoft-Antispam-Message-Info: 0ekJCpQ/xHgZuIecnDSIP24ivucTNagPz6ZR0RoSD/F99Cvzn4z+G+eIKbkpa9ivqun3YXNLO+Ff3j9kIil+z14BgzD/upYpfbESUlKfVGrlk4hcb/HqCxOZrIqQh37qIAgYQ48Iq0WBkz24zNI8wv6czMo7y+DcBSdhloBz9Eej2Hv9UfxJcMdiyNyBI/TeGs5Y2XzVft3rQg105ziUUdno/pE5iVnMX+EC7LbwuVVucqNZun7T23DvcG5nkWe5faMu+/FCpv4YGsCN5He+1QUoH0VMu+MLy+3hfgH9f7KWGWc5/Y2GxXPnCXQB1JJM46wVRezq5pSzwCbk8C4koFXK1VXVUHH6O2o//cJVP4o=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:sBpJUta79bgTbCUO4ejYRZQaymZbEiMEqAl3kI0H4NrVGLMSWIDQMHW2YzxM/A8gDDitmIH7qYuJ9XqjAVJQRwHi3MKP14tJMmZARKjaxzLtaZyOJ7aBdpqiuOlV9OSPVHu4mSpaLpTla/uV/fR+zhXYTmqS1LdgwlVHRJBF416fixuAme6ampEhlFwVNYZNjlRLa5njeG34lD629kKWjyoeiG5go4ozCLS9LarMTK5fjFUvfJ0RPh6CFol5VeFR6ErmW7iR5wAjgHQcES1hl7xaLbk3N45darlrDIW/dIHV2Txf0gzTtODh3zhK63P0GVxk4LEN69HA8SSjtpmV8/sKP5ovXesOiyuCfhlx9xY7ftMVGAdAoMkP5qswrpibthZlTlV2v+U44kIaMq52FcPcDxkVUrrPpNYN/+UtUyHYuDDbd4kD4vG5cr2/taIJFNJxKqPVr5n50vR7z7qkrg==;5:4GWXc6Q3Cn2dJtXB0iEgbLkMo7VrJ2poC/nWOGrwSCr9jfyPyJPm7FrzIvJeBtY+qBR73tkmgPCLILRSNhDN7OuRJrWS9Kld1EExMG3u3MFQIpMG/VDRnAzYHpT/IR4jho9ENIqTOLdEg6Q9LU0/THpBp48Qoww28iQH6B390vw=;7:D7XpF/YetD8L3QYV0p3MpVLED/1h/TKwn2sbjDvQjRVBCjU952NbF4SE/INHEhavIhJ4L/nc5VRlGfWZ7LiJllOYL2hKdzqhS59BEYBqzdIwePGIKVN3IDvZJgXjSFehbL0SXKiBzZSZYi4d+jaPDz5z1/LbWZOCTft2IEp+CX9qoZ089WfUkZTBnT2sA8jo72OW+jFTb0f+0tC2PfhUdbvjAEa2yTty1mnBsU1Oh5JYq/dgE6oCM5wpQAJoLtMV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 00:58:55.8687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419217f6-3cc8-4c77-f5d6-08d61781c0d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-11 01:27, Steven Rostedt wrote:
> 
> Why this:
> 
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> [..]
> #endif
> 
> #ifndef CONFIG_DEBUG_LOCK_ALLOC
> [..]
> #endif
> 
> ???
> 
> This should use #else.

Yes. Water under the bridge...

Cheers,
Peter
