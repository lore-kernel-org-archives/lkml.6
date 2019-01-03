Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ABBC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E19E214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ix9N9Ut0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfACLUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:20:08 -0500
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:12266
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfACLUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2hb8Gtl8/Mf1IjK4Tih8S9snYLC48W2npDMR2EEW+4=;
 b=ix9N9Ut0neL4tLXK1pAuRudRE3wwxv4BwEz9bbqoZBpKmeuISpFBuCZK/sdG7yjbtRHYyGNtGQBeeJNxopI/pLYhhHNni3mxE83Vn/BN9b9uPyM4n58gffScM9yZcY8NOSOg2QcwjSdOcUV2GVBjO88UCaJG1JOSGvDtDDR7Kq4=
Received: from BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18)
 by BY2PR0201MB1894.namprd02.prod.outlook.com (2a01:111:e400:58b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Thu, 3 Jan
 2019 11:17:11 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BL0PR02CA0005.outlook.office365.com
 (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.20 via Frontend
 Transport; Thu, 3 Jan 2019 11:17:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; umn.edu; dkim=none (message not signed)
 header.d=none;umn.edu; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 3 Jan 2019 11:17:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gf0zp-0006lA-V6; Thu, 03 Jan 2019 03:17:05 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gf0zk-0003jd-RD; Thu, 03 Jan 2019 03:17:00 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x03BGqux022033;
        Thu, 3 Jan 2019 03:16:52 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gf0zc-0003hw-5y; Thu, 03 Jan 2019 03:16:52 -0800
Subject: Re: [PATCH] iio: adc: xilinx: check return value of
 xadc_write_adc_reg
To:     Aditya Pakki <pakki001@umn.edu>
CC:     <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181227195454.26344-1-pakki001@umn.edu>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <bfd90c61-233f-b200-a8f2-f1dc2bb4c003@xilinx.com>
Date:   Thu, 3 Jan 2019 12:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227195454.26344-1-pakki001@umn.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(3190300001)(199004)(189003)(229853002)(2486003)(63266004)(23676004)(106466001)(446003)(9786002)(76176011)(8676002)(81166006)(81156014)(230700001)(36756003)(2616005)(11346002)(305945005)(476003)(126002)(31686004)(426003)(336012)(26005)(65826007)(186003)(6666004)(356004)(77096007)(65956001)(106002)(316002)(58126008)(54906003)(44832011)(486006)(6916009)(8936002)(2906002)(36386004)(50466002)(5660300001)(47776003)(6246003)(4326008)(65806001)(478600001)(31696002)(64126003)(14444005)(2171002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1894;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT046;1:Ffw50lsD0+8h4b1DPpRTAiWuzVESsM5H85bDbXzhZmQM57/ItZGHaZ33HrPH9RUh5FwuEzHh8aa0AGfEhVzwvKaSSq9bve51/lbmUHRHy0d/FF8s23PzVfYWrxRlPiH9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3a7b54-2b2b-413e-5bee-08d6716d0109
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BY2PR0201MB1894;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;3:vBpXLFp21RqFgNuDcpdq+V22aja+MoO7nWYv2LRpZ3Lp0u76Z13FfmAoBtugWt7me8RljwRKuDHR5LGdLVqr/sWRRMJEgL7vI/Ae7RU6SSIthNczwQRVv6nynPr+f1CdxTT1/iblc4o/IOP8IDF99ZEEbzYcWk1xKvQn8HN35lzIyk8GAOJhgNVT2zEDxiK6n3Ec2TjrQPsqIEI2Zsj4+Vd+aWAFPqHI/Eb22cL8l7NgpmA2w+DGz6BD+5xfBgBn0HIAFvnkBA8QqSefA9MUD+N6QZQWkvBvaXU719YV+qCBD8p5z3q3jp5o5VKWGhBI/aKxDHYkqXICf8KCPYoP/L6eMGe81+7LML0J1uRZD2nl60B5QQJXn3VKivkfCr4Z;25:xgo3gSNewgUSs3lUXqMYVybQ1xRuubL9AQJ5bWIvevZ6tKw/JBktPZDOO5Hv1KLtVQPm93xME7UMwOwwjlqOAmHk8zo728gKiDoADX+8E8wGYtAQgpfMVtNIO0hae2oeVSqlgQL+HE/+ab+3AzLaiqp7xtj30uRTHUjGKCpTjdnFLi/yL9npjbOX5n/EU8DSgauwWhy2rJ+Yf364EYDock0QOINzFFEew1OMnKTTGC1BkbzIFoV86MzNcimHNA9W4FmsYXViFpEy5j6wOzZsGZFUmz2KNrIvsPtCXYeN6Fp9kyLAFbULyRw9AxPZL3IfBXfdeRmGn7kq+mgNLXZadA==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1894:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;31:PJPS4w/S9G+UPB629oXJIXFvjsvtObwloouQgktp87hdy7pL3AlQTwpgOh6i1y5QpcomibfQ4+YLwfbklB74JXM0NAkt3RhMofwI8wLtMB0g/t14Bu0kk4rrHKogHixGTFgfDKp7JaASLffMUygN5ixjjVT8OZufaP5Q/XXcAjfmVmdCLkb9qrT/DiVSQB45nFF3yLmbyh6kqtjfXgF6L175B9RL/G1L/GYfNHicbys=;20:mpZsKT7u0ChNTnuYzH2GzTNr4Zv0SZRbjxO0NDIoT6LqjT+dnJ9lXiDZqeqCnryxeIT0yTAAIl0XK4ZdPzsJ3q8ZhbdEmFUVH08ExzvlrdbLjzmZZqtTxFjfy1x8MIdPnNxzyw1x+WzAtNNqp9RCg8PBokMwbkt+DCICfcXKT0Rk1h9dlVwkbYQYPdzgvn+7PwmCpK8VoavOi2rvmaQOoMvoqSBm9EhhcElBcuWNSgP8soO69is4tvi+tEL84o08MRniUKQEafeMu84rYfMfWwtukqJXGc7fAK9eUYMlA5fACUJrzgTaT/55hIynH0Z2uXlzkyGW7+/SuO6eh1ArWaaaSjkjJCfPeWBz4fZ0VKAc+8o+qho7jwaIj4GvdLaQ1SMVeBESmRoqDHC0DUWkHqGJGriAJSeVxcIZYwrBS4L+4eZpylzaeJmPRbP7ewFrVQ49FF129a/+4ccMfCxrD3YxP3RKj7UhzAifgLRoffIHgHLLofFHNTPDr0j61Qx5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB189455DCFC4A9BA0BB7FE515C68D0@BY2PR0201MB1894.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR0201MB1894;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1894;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;4:suULPK3h+qKdGqNN/DE9n92ve3cGFjVC/pFxznzvXvpIlcnDbSZF4NgTtj+7QEFKmUnSqshhLErnWVdZ+RRmBvFAnkUfAnOF8jRkXojZkysOlrKSNpzLQA4+YI0Nww1Az2aVkVHFFyYg2JXjx1lErqTux0joDZIrdm6TfF36UgfrjHaj/SKNwQ3bY9jqgms0gO3LqvZAirDsOh+6Q+q7/1WELx+Bstmaqngb3/pzMLUMjZQC+1Cex0HUi929zvJ8k2r4P1bFumzfon8+/KgvIe844Cg31uivsFmn8qJdWXcVNK77I2UWaqwcG13uryMs
X-Forefront-PRVS: 0906E83A25
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyMDFNQjE4OTQ7MjM6OUFyTE1YdHJpempvbDJZeHJxM2d4aXpM?=
 =?utf-8?B?T0F0Y2JyMy90Ym5EWGdILzRSV0N6Ri9SVnl5T1hlSGJpWjZ1clgydnpucS9I?=
 =?utf-8?B?L0hMTnpyZWFLMXd4Q0dDVHd0Nld2UUF0VGNMV3VvamxQd3RjNS9oOGVsM3di?=
 =?utf-8?B?Q0c3TFRQT0Z3VGdhRDBmZ3hHT2tDRVRnblFKVTR0bTloNUlPY2tSejhVMUVC?=
 =?utf-8?B?K1lXenY1aW51ZkxDd1N1cHhMNjNLL2VGYkgwZDFYdDNkWWoyS08zbnJJbHlY?=
 =?utf-8?B?R2ljdUw2eGhiQUV5MzUyU1FpQm5XbDFvckNJQjg5b0tVWlhKSmFPdGkzdzg1?=
 =?utf-8?B?RUxTbHY3RTVTWHQ3ajhaamhzUTJlajNKV0pENGZhUUVRK0IrVUozaExNVVB6?=
 =?utf-8?B?b1ZHek5BTE82MWdyZlJqcytIdHdkT2ZrM3VSbzJGTVJnbk1uMDRTSDIxTHVh?=
 =?utf-8?B?MkVJWFoyclRaMmpnQnRMU2RudDFFMXhzTXZGWlFzVU84TEQ4cndZTWVtZ3hj?=
 =?utf-8?B?YUorOUVKR0x2NFJHeWhVd0g4SjU1ZWVjNHo2cFNHeXBnQXNKaFpIQVJ2bXdH?=
 =?utf-8?B?Q25ZYTZ5SUhianBpTW51a1ZvM3pJK3RlV2NrdkdTYlJZNVgvTlNPQW9NTVdu?=
 =?utf-8?B?aHdqUnVFL2s4b2xYVkVuUTl0QVg1dHZsMm5KZVdmRlhMMDVuenpWNTFSeWxh?=
 =?utf-8?B?R3BYdTZlMnpHWDF4ZHVwTUsxV0FvaTRvNlV5cVlTSnV1Z2xzdE95czRhVlAv?=
 =?utf-8?B?a2p3UnRWSUNJZnFzSDE4Q3BBUzVOR2pYeHY1YjFGWm9wS3E1YVBxWmdTTmM4?=
 =?utf-8?B?Ti9VMTJDbHdidVhjRnd6Q1ROTWRYaVhPS3VNd0htZGhxQytKVDYvQ0FSaDV1?=
 =?utf-8?B?WmtvUzBXOFl2UGx2OUJCcW1VQy9nZnlJV1RTcU90RUZKZEhNWlorbDNYbURH?=
 =?utf-8?B?MExrQmQwclR5MER3eFFTT2xGVmMyU09XazBnTlhyd1BRNWMzNHVrUEFBRVlZ?=
 =?utf-8?B?V1FmTjBpaDk5cTczZkdDSllUcHc4Y1FQKzcrdGl3Z1NudUV3ZVN6RERWclJK?=
 =?utf-8?B?SStWWTlYbTZyRnBQcG5FdFZ3Ymw5bHdoTERoaHNIYlUweUtuZGpVNHQrekNF?=
 =?utf-8?B?UnFubFkrYll5UDZORWRWKythM2psOWVTMk4xaEo3UkUyaExxdmJOYkc4TC9F?=
 =?utf-8?B?RGVDSE9sZ3RnVisyOUtaL0VDTUpkaEFoUTh0NjJFUDl0eTU0TjRkM0FTWUlG?=
 =?utf-8?B?TFk1QjlDNFpSUUtkZzBEUnk5bEhETk1ROXU0cHJraDZnTHQrZ0NJQUdZNjNh?=
 =?utf-8?B?eG5EbWZMMWlNQkczeVNKM3hWMFlHZklTTkkzTFZPZ1FuTU55RU1ta3FJYXNF?=
 =?utf-8?B?UUFZOGx4Y3U0TU5SKzhJTmRRS2M3QzlTbWs4STBMcnI5SVJSUTlBd0NTdnhT?=
 =?utf-8?B?Y0dDRkJ4bncxZktPT0NiMVJCM1dHd04wWFRrdDdianVkRFUvSTFwV0tSbzh4?=
 =?utf-8?B?aThUcDZlVytQMnZTckUydlB0WHJHUUlLOTVYNHR3YkIvblRDVFhISVBsWE04?=
 =?utf-8?B?VEc3R3plbDl3NVkvVzF6M3NCMDVIODJFdTFxMWhXb0YvU2taWHVwSGpKQ09j?=
 =?utf-8?B?SDlWL0lMelh0cEE3RDR2UzEvc2wvaDVKUWl2VUdMU3gza044RzluTHExcGNw?=
 =?utf-8?B?OCtYUnViQlhjRGE4RGoxR2hnaUZ5cktxTkxvbS9DbEFtc1JGdDhKLzl5dGp5?=
 =?utf-8?B?WC9RSFZXcXBoZ2JubzF0V2ZnPT0=?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jyGarg/1tUGG/6LXdKmYjbDOWgZIfSapbnF0doZfJCf9OPUrrrij+O1GARYUdAoq4Cm2S7luJ/B0W5hVAz4+B2KzG9MzOWV+zboqM8qtQzS/tS6rTRGpqAalPLUg7vEKaMzL9vnfkhMCJmCICb+gqYH93avuwYzuJSHiWH/NLNWL3p6Y2jkwk6HuzgXEmSGU9SwRDf4NXW7UT/JT4qO6yT2/Jogr3Csrp/jmDpUX/5bQogSVMu+jSF7aCVrJsMsuOyxHTi6ftSSRjmWhN1rfAs6MC3LbMBw9JmPt5b15SkEABJdHV2LTFIwjosB5lCjL
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;6:BBzTYT5B4bgCeoOQi7x4pZbkMYC2PFaxd2q1LPpvWLB7/R6wzAy1DWOk5Tjg1r2Hwd0yGVWqNXfRUTzgxVUGObY7IL5+pIvqU++LijApldJhDr3MASfNuY5fSy49nMIuzGAgTmpFOLcujC00vzIaUFZP90LwRyNjeFFmLLHvSe3LuIqsMXnGlHTgvYFn5DncyG0FozG0tp3H8JbP9OkasbO9BK6CzzMMmqLDB+Az7BsEUIbO8grTODtM1JivSp+kBOb6tJBwSG2XNqsKSSXAP0S9epvz1cLgIlMYTjnQnCrfQ+URU9dwA7CmWTjT4/ScC5biSr8Zx799sVeL9LtL5l4QA2LqXapriB8dBWazMQwk2hI8tubwxe2MmBxRjhfx2XUkejg/mti7OD/Z+M5OhCk94gAIK/pZdHAoscC3E9KAXgYy6MqEa/BoH3UFQxzRDeghlwSfkZTyRKG0k1AZUA==;5:4f/+67Ibh25m41lMpZ1Y6ZzNsyY00JYtENq4OiEbzQFwG3eJFrKSeTKjC42Up75m2bukXdFN/kTR6Zxwy98U9RhBPjKm2xtE97BivSJS1pCknUO+QmbXFpme+LaFADUHFSr16WSMCJdXvdEXJdMKEuQxrItUCfpGFgYjlh+1LO3bVMU+3ACwkzNK5ZpPDswKBOoq3LsT9glWAfQE2igrRw==;7:jhf0MsRwkNvKlqi7kDdwVYUrsMBWMAXa3gqwwceKyJPDrqBjM+MUDhOQ0yf0ZOeJZgncHZHRHNRZKYwD2tRkTKdOBFve1H4Hm0e8NhjvxJ+4gqx5Jwtw6kkY2jil9diilpBLgy6LQvZsoUlx2uczWA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2019 11:17:06.8673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3a7b54-2b2b-413e-5bee-08d6716d0109
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 12. 18 20:54, Aditya Pakki wrote:
> In function xadc_probe, xadc_write_adc_reg can return an error value
> when write fails. The fix checks for the return value consistent with
> other invocations of the latter function.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 3f6be5ac049a..b13c61539d46 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1273,8 +1273,10 @@ static int xadc_probe(struct platform_device *pdev)
>  			xadc->threshold[i] = 0xffff;
>  		else
>  			xadc->threshold[i] = 0;
> -		xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> +		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
>  			xadc->threshold[i]);
> +		if (ret)
> +			goto err_free_irq;
>  	}
>  
>  	/* Go to non-buffered mode */
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
