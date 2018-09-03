Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C728BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD4620843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="rToID73k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD4620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeICLMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:12:03 -0400
Received: from mail-eopbgr700061.outbound.protection.outlook.com ([40.107.70.61]:63162
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeICLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiSZmMpxp0k6ydc7JPLaUm0TDq6sCuNHH9t7r5E2vGE=;
 b=rToID73kNGx1rk+wfshd8nW3MyOcpYJ9hIMvWSiy+21wPUAUiEp8M4A6nylxglCGCY+Y7j4MyjbzcIpTmQf6WJlmOyy8xrnN2ZjZcLxcTK7cgKEkOk1Jl/aCN57l6Y270hRcuWXQhlSrTZmmduzjTzb6CLMtYKCr6QBVnumhOXI=
Received: from BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21)
 by CY1PR0301MB1225.namprd03.prod.outlook.com (2a01:111:e400:4c5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Mon, 3 Sep
 2018 06:53:13 +0000
Received: from BN1BFFO11FD019.protection.gbl (2a01:111:f400:7c10::1:188) by
 BYAPR03CA0008.outlook.office365.com (2603:10b6:a02:a8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1101.13 via Frontend Transport; Mon, 3 Sep 2018 06:53:12 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD019.mail.protection.outlook.com (10.58.144.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.11
 via Frontend Transport; Mon, 3 Sep 2018 06:53:12 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w836rCuB001925
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Sun, 2 Sep 2018 23:53:12 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Mon, 3 Sep 2018
 02:53:12 -0400
Received: from [10.44.3.40] ([10.44.3.40])      by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id w836r9UK027280;  Mon, 3 Sep 2018 02:53:10 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] drivers: gpio: gpio-adp5588: Fix sleep-in-atomic-context
 bug
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <baijiaju1990@gmail.com>
References: <1534168664-13034-1-git-send-email-michael.hennerich@analog.com>
 <CACRpkdbw3DwYO=W7m5AaNkg8QZmCf+7yM4fNs7tBVDZgVma2wg@mail.gmail.com>
From:   Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <e8df3855-6380-697e-5ce0-37eb1e6bbf75@analog.com>
Date:   Mon, 3 Sep 2018 08:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbw3DwYO=W7m5AaNkg8QZmCf+7yM4fNs7tBVDZgVma2wg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(229853002)(6916009)(106002)(58126008)(54906003)(53546011)(6246003)(43066004)(5660300001)(67846002)(44832011)(26005)(36916002)(2486003)(23676004)(39060400002)(76176011)(186003)(77096007)(2616005)(336012)(8936002)(126002)(476003)(36756003)(426003)(65826007)(446003)(11346002)(486006)(47776003)(3450700001)(31696002)(106466001)(65956001)(65806001)(31686004)(2870700001)(50466002)(316002)(4326008)(7636002)(2906002)(72206003)(246002)(64126003)(356003)(8676002)(305945005)(86362001)(478600001)(31853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1225;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD019;1:T8yahgj/wRhuuPpkOXXaGn62MGkx63FUuTh8po+uJGE6EnPTbhDYPl3qLkuKJifxBTpg3j2Zn9aII/fvk248+ZpTnOVLni0ZHHT4GyeLsvMXpDEmsXdThERpJC0Mjk6b
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c04dc8-b229-48a1-614f-08d61169eaa5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY1PR0301MB1225;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1225;3:gdKE1krLw8/453X/I20hc0SM9zxioDBK8yjMZlLVo7YYUD6a0xkPn3KZj8URrN1rAo01qt8bSGYU44+3Q+Q4RRjKQpHDW5BQnMvQ1swdhj28CV6IuvHup3wlBZHAOY3R6o9VPjDo85Dtyuvc2cfWdBWQr0bRBIFPWj8FsR7XTcnpdkkGDzztG+497x4rE+P+DUvz6OYDzKwZ47Pfu0ey/5uYCEzlxR95rYhXwRv0MzuPbtFKm3Zrd33yhxeJ5oMbZr2qUTs9sIbvlK/XMFVU4s7N4Wr4oMOcCVqnmqcXwd18GvMiOPeFKo3BAfrF3xX61520K291HlCHDsLkpi8O8rtlRF+yUwIhYmnwhvmssYk=;25:ecul4PvFHRBwLEo1lfF8aoPdn7/yT5+ZPCHfQoYRgx2Cazq+4zLnstcAeGLhr62xtATIzfvcDEJ6eZor9CPjG+JDvcR+E7F8R2/O5H3i6v2vv1jvPpGAVZqbWwmlr7etk0v/GpHDLL5ec1Rpi7Phd7jro9iWSZTSrwFxIlv0i6QN60XYeT6TesVjoz1EqF9W1ZFJJ/Ae2b6xbs2d5O+APO1fntTA7RG8+Isglcntym1uzCPhcHmU5/DaK5Q1dh9skaDKiX6q1aC8PxUpR5CZqv5hg53I7OnT5Pqp8GW6M1LhS0FsiTYDtddVolsytSvZTbb709UGAyLNgVn4RvHrMg==
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1225:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1225;31:VH1CR8mygsovSmn6BKSdP71b574e1owoDCB7qXeukqD8zFj0w59nD2W/KvMSfC5x6d1ZEE5Bnx7FYf2+MsLu0jk4dZLB/rb4gSeJ9ZH9DiR3uw/zC49mbWiDgFGhN0DZIkgLdL4VAjCic/Hq27ZJcuMwJknUdgQokusxoNCUn8CibimztodPmu1N2ldPWGnjQlPwQS/Sl7urqTrqgOvqyoc1Ubumoi4veKwyUTam1xw=;20:lhfKQJwopISkga2kxghY5I4nD4ezkM1/66cW6oeVstR8JwMc4dTPBHFZea+S07PcEosONqog8NGZbac0c3MOYJahnFIa8Fy6kooC31wNpd+NiZwHsE6AgaqAN7uoTctRsC/ghD8tbZcqan8t0fg2Wa8H7BdAeFhyZFa9fjMXeCbnrTH4FjMferbYhOL/eQMyefFnk4OhZOFS6ZNg+ly0TuyFKFrzrFLOT3Cz9MKs1UVYnU4DipFrRG3Mbv3I1vthCIhklkwmBQ4U8xyC+iLk15AtiwQ69fmvoz+D7QY1xEgNRflTzjiX6GSIWuw5WcRZp4sik2yC0lKwoXqCGHTQWlRfPcBZK1EJDvsqSqwLvPPHLBIguWYa2uIrbKDtWAezvL/o2dkXY3d87rcu58xgzzRTe8y691yMpxtkvlKznsZKQV24YXstOZvWuaQLbOjIytQmb65A76WKenLaAYlY+LBG7QC7G7CJ2UpZYng2VR8qhhjVyDRh4Fod6QAsfd7d
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1225EC5B4F691CBB106141DA8E0C0@CY1PR0301MB1225.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CY1PR0301MB1225;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1225;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1225;4:1tX4KE09IVj4dfowypHD/eSSi5nBw7E3BAqlFu3699o45j0cda3LlBkW0Jks0pF3ChKP/0DfWyN90vrHowi5aXm5Mhm9fIR5552BSBElsvf+pgHbaF9fmz0nGuukqf4/bO2MWg+BWF7gG+jmfG09SBE3okzu0GvekNYToCcHJEo2ZeY+rAbVxQYGJo2rUSVLnr9YTNu9ts2wPkcA5oUjWxhDAsu52gyEniC6/OgRLTSVBceS1+1ioUrJGcfuRIqxT45rF1ZIf7uIpkukg/Df2fH+hfy/s9pCKLHi9ZLv1q8eOSM2SFyk4MwYCuccDASAiAyYI4QH1dEgF2vOOg5BEZ0YW8bw6z3u38B3HQCJqiA=
X-Forefront-PRVS: 0784C803FD
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAzMDFNQjEyMjU7MjM6MFgwa3JKM21iWUVtZ0hLMlBqa2VOYVhF?=
 =?utf-8?B?cEsyUXc0U1Nvb2ZLbG9panQrcHZHYkJ1Wk4vOVROUytWUEZwajlZOE1LMzgr?=
 =?utf-8?B?aGxHS2kvemNLdWloTVNWZXRYd3ZxSHVWcXlCb1A2ZXVHZ1VObi9lWW1mRlVB?=
 =?utf-8?B?OVF6dC81TGphQ0JGcVNnK0ZncnpJRW16cmFBV2R5RmFRYVduZTNXVXJ5bzVz?=
 =?utf-8?B?Z3VsMW5lalF6OVNOVlVEMkNIb0dmUHpOTmJXdFpCbkRIcVp6anJtR3FuTlk2?=
 =?utf-8?B?Tmd0cmNmb3FYNkU4MVF4NENIZDV6S3FWemVVcG1FYW9DYWVxdHZjbGovUFRs?=
 =?utf-8?B?NWZRK0M4ZktsTEd6ay9mcEFUc1gyalYwZlFUTUdjQVBEb0Q2RGVLN056WkdU?=
 =?utf-8?B?N2x3S2YybU5XWmptdnVCQmhsL0hibVROQ3BRTlVYVWhDSE5GNnBkNW1Nb2JD?=
 =?utf-8?B?VVpuOXZGc3VoQkdyNWxUbTVVdWE1OXVlM2w4eDRWUTNzbmR3bkhvY2V4NGQy?=
 =?utf-8?B?MGRyRndtdHRaTzF2M3lnT3FYQTZuUjNSQlcvSXJYMHdZSklaMzBHR1hOaVNN?=
 =?utf-8?B?Z1h2K2lFZkRGc29TVXZweU90YlpuWmM3cVFJeUNSa1ErRmJ4ZE56VE1Ydlo0?=
 =?utf-8?B?RWVqMm8ybU1aUHQ0SWRiQVBZTGw5M3FxUm5ZWU9uekZhek1sdVcwZUhJR09s?=
 =?utf-8?B?dEhrOTI3MnRmY1VVUlphc3VnS1NRMFVwRDlSU0xCdDJLQUR2QnZqdlk1emVJ?=
 =?utf-8?B?dzZJNGMrTTRiREdmUm5Dbm1JRFNWSEVuUWI5bC9JTE9kbEZRSjMxTENlNHRv?=
 =?utf-8?B?bmt2MEQrRlF3WmNZYWoxY2tMWFpUYklvanlZOGdNcmdJd2FpU05qVmF1V29P?=
 =?utf-8?B?UWdOWDFaR09zYUhhRmJZMnlQMTVCUGtERURMNTNhYmpDK0xjbnk1M1Z6TGhN?=
 =?utf-8?B?aE5NL2ptR1NQcXR3ZVJVYm5RTHBMK1RmUHo5MmFRSWk2WXo1bFJUQ1RkSk5X?=
 =?utf-8?B?RTU4OE5rM1dGdGlSYTV4ZTQ3a1FlSzc4RVozV1RjanpCRlpHVVp6bVJmZ2VD?=
 =?utf-8?B?UGFYWUdDY2hoci8ySE56ZWtrNzN0VkVrSVRPbGI2bm1NZ2RXN1hLV2xubUN4?=
 =?utf-8?B?bmx5aWF4ampuNTRjalhkWW1UbWFnY0M3Vk81bFArZTVxeFRMd2xOdU1WenlN?=
 =?utf-8?B?aFZjRksrKzI5djZlZkJ0UlNzdTVuSVV1ckhqcGU0MWR1SmdMa0hXTGJkWG5W?=
 =?utf-8?B?UTFpdjBJMHpCYi9kdkp4UDdVZUJPbWJVVlBtaFIrcDdxWE03bjRvcFZwTkZa?=
 =?utf-8?B?YjhSelBHOTNKUmowYjRzajNTUUFseVFkNVo5eE8vbWpJUzFIMFdsQlBGbE05?=
 =?utf-8?B?bXUxaldMcEF3ZjBJT0pZUnhxZVFlZXNPSnBST3pjclNETFhJNkIwd05TSU5l?=
 =?utf-8?B?Q1RlOVFxWFRkUlljaHQ3TEZhLzhIT2FVellRWTZmZE9JR1ppZHZTMlVndmU5?=
 =?utf-8?B?b1o0NERJWDJUK09wVHA0L2FTQk5TUGdkL2hUSTU1clAxdUFtclhFUGRXWlR0?=
 =?utf-8?B?bit6Q2FwNktKeXdtaWRVajhRcjJoeWhtdmhFblU5ZEZqNFR6ZmdnYmx1UFc2?=
 =?utf-8?B?SVJiMHNmMi9QNm01V0I2WXRXWGhsc1B5aWROalAxbS9PSzJDQmk3Y0h0dGVw?=
 =?utf-8?B?L1BYYVdoU0hWNU84dXhMckcwdFdUamUrNVduUGw1Y1kwMG9HdzJ0NnQxenNJ?=
 =?utf-8?B?TFVQMGlrQnFqSmFWaERGQyt4MTlmZzU1c1ZmUEw3Y041UUNTc1BTZ0RqbVZB?=
 =?utf-8?B?ODNrVDlMTkpYUit0aXkvZXArRC84eGFjTXZmK3hWdHpiL0dsQT09?=
X-Microsoft-Antispam-Message-Info: /YT1JczM63chXbcYEnmkCYYqacJl0T9wL6e5eavzcz0wtpfp3DdFXTtTBubZS0nvtvHcdaV1Jf8h8RuXKNvacWMqI+3YHMHnd0Wvp32v2jZmTrfqEOyc2ZrhuwQxXPbxCWnHW/i6SU58rKRld/dawzJEW6VEThtkZQZXu5rR/3ST9HRjE8GLATmWY0tEtNUkhALq4pxYlukQjH6lLSQ8Pb5rBLIQeYPW92fGjms3xAQypqbQPR8iQmJTnQezqcvdvjrwhNXoMBGElkfv1kOGYRNHYEOLISQ5xx/RJINAPLOVifzRqJQ9Z1rg8WDqRVU6ZJweHEu2lL/NQGxonBPBqa2sM2WPtSAeo/Mtbinhvt0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1225;6:bPu3wtBwpusstpYAzKHRcVXayDXRj269relfFL9pgFgZdvlFtYtXZZLcB9t+u+g1B7xV8D+BtvwxaY6n7RDSa1uSnjbPb31w52H0zTVKWSdsP1ApDyNDUGlnTTK6gMoS57TbvDQPGgXl7BJA99PGagp8C1tM5waRPscYUnZctQTAtvhFcE1dTaBtvnbk5qyh2oJiE8gjokIZ+lun5c+iRcNoCz/diw2EYQPKsHfvgxJcJ9N5RPduFbJeaTd96BEUYQmUANICKGkGSgprCSDhNwtc92TjivXIKVpEcPW1oSUY6X3zTyWxw1jLW829V6ZOfFy4uXI7lIXLL+8u697radt2AbYCEufRe5lDs6w2DqjDHKg1gOzNKrszjXOwPcE1Y8A9ftbgAkh2/ds3jL33zbYqwYJ8zvMZsb+kIWZDGbQAFjGqd1jV3GSHPMDVR6CZx7/f7+O6hklgXxIOnjL7qA==;5:/qq0HLxs3+rKpxVx5Zg6eZod878/GT6EgHwtoRZagBWDoPhiwniRtn+X6yhdJJp5IshDPUbAnymGtfPUt9MDixI5N5gKM8WQOr0ZyQqcNLBg15cuaWIW+La0HWFhQaVL9g1HlhkD0Kp3bb2MAQFk74GhKAS6Lew6YkXxQBIChCg=;7:7sWWWDjfBr+g1477LnlBQb/IDy7icuEHqHRid2VLJkha/Ycgg2cd12qe4QKZl4NrBtwoJwmu+wCm3Lfsiv+vnO0qThgXa8yrGPuhonrnWWCarFbGqnKABdV7yygkBHi9aSx/mFxsSqx9KxEb1LRjbdmJ/XWTkxX+zKyCTWqBUxChf/MVGMY+aLo7OdXNRJ/gdmy4Ty2ZOtm97RCBrEAewXkswYZl3F1+kbKWAAXq72lwkTmRFe2IcsjvE7RWFpCT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 06:53:12.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c04dc8-b229-48a1-614f-08d61169eaa5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2018 10:55, Linus Walleij wrote:
> On Mon, Aug 13, 2018 at 3:53 PM <michael.hennerich@analog.com> wrote:
> 
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This fixes:
>> [BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
>>                            in adp5588_gpio_write()
>> [BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
>>                            in adp5588_gpio_direction_input()
>>
>> Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> 
> Thanks Michael, excellent and prompt fix. Patch applied
> for fixes (v4.19-rcs).
> 
> Should we even tag it for stable?

Thanks, Linus - Yes that would make sense.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Stefan Steyerl, Thomas Edward Cribben, Eileen Wynne
