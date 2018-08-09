Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3CC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEAE20873
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JK9aUcQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEAE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeHINWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:22:55 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:35260
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbeHINWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9le1J8UQ74sM62jqDJ7uvE/rFNiqkhjvOkRk0KjxewE=;
 b=JK9aUcQWHZCV69QmTiBEjyax4piBivEWaFaZxzvCiWZHSx85TfAJI6iFamr+Pc2kD0GOEqwY/tYqAqG3babmGnwYFO7aXEwhsWOEIz3BE40ZkJzzYLeLUuqlnQgWI2pf23o91lko8cGursLHlfj5PA86phorSvVXmOnwalZGYIw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2018.eurprd08.prod.outlook.com (2603:10a6:203:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Thu, 9 Aug
 2018 10:58:20 +0000
Subject: Re: [PATCH RFC v2 02/10] mm: Make shrink_slab() lockless
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, hughd@google.com, shuah@kernel.org,
        robh@kernel.org, ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365626605.19074.16202958374930777592.stgit@localhost.localdomain>
 <591d2063-0511-103d-bef6-dd35f55afe32@virtuozzo.com>
 <4ceb948c-7ce7-0db3-17d8-82ef1e6e47cc@virtuozzo.com>
 <20180809071418.GA24884@dhcp22.suse.cz>
 <cf7ba095-8be9-ead8-5422-59fa1f3bb07d@virtuozzo.com>
 <7b746367-e4bc-0e64-4e27-14fd7f06ba8f@i-love.sakura.ne.jp>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2e1cdec3-5133-67ec-e929-8bc174574b3a@virtuozzo.com>
Date:   Thu, 9 Aug 2018 13:58:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7b746367-e4bc-0e64-4e27-14fd7f06ba8f@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:803:14::27) To AM5PR0801MB2018.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5ab1ea-6de7-4f61-0e66-08d5fde70688
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2018;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;3:HoNXHtnEbs4oZ3dsVf6C/qf957Aaicv4T1j0YwiR1OHaVJXnNmiwVaB8cN9TveUNQCM384DikUBDUZWyn/yyf5hRC2CZDN310ZdNHJ/YJU/wvkSJa7dVjmU+IgvdkgkYEP0aD66eZ9hy2fDC+7tlNvYAPcBi48Of4eChW4SM74Pl0/AMhJ0R6l441sqEsshGgUM0ltCZxPmFVdT9Ac+CFt9odOlnbAOgaabFKo3oqIPhbIKEwNy3Npd7Ua9NcBSD;25:U7Iwmg4/cMcefHh5BxEXyttQQVLZvVpkB8wE93JG37xr3JUUWSn8O+NiC2AZGO6lF9Vt1N1ELOFErnilPxGOrdstTbFDO+zlyecACNE1Hy2x+UgD8K24nCzHxsUCKxn6hRhwDk1Q68XJ/ZXyJF+arBI9o3KDogIFc2HCpVfij6NX97UAj40XMYfMCjsvsceXdFVMAXgOApBkcdzjR8koFz/MANwmeDPG9S0omsmJ1I8FnI6iHQQveVKcYQwxl0EuRoq4chXTPIHOEz2z9zcOrysGCtly55915/zYoNdAbUk4SwbAQx1ym6hFsGWa6OzFRFungD/46/Os/7M/GQE9xA==;31:2yBdlTi5Pgp2KTgksjos8LtJuOiTwlKXlURRpaOXR7XrO0vSMrB9BY0x9Lve86F/gykH6RwtAMCLIfQDGgqt7MsIHlAswVvLjESzz0bhSOvVYcadvc0KvLvHHCAEiYKGlCy8uNpB/JH5sKiUpOpLTHxv3qmXbuzfZYb7FLSNuibWMU86/cxy8VM0ylG9U46KH03VHq6WJ3MXGLuwZBctKP5G/JhwZNsgH17qkoANNNE=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2018:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:j4TIS0GwUq1VdFwzizXSnPFODJSa/xwI7G4fTzAlN1b+CQlUg7DNVPRRGMVMWJQOzDXGOrzuonfkG7NdMgQYGFKUiX0ZAIt5W9cYXMbVgAOf3xJ1f5efacaAmd9gs/7Aogs/CUcigm6zOGT6bqeodP7viDQR0gFWw+uCkTTKAx0L8qoitQbAev0V6FjNdMhBRgKs6son+XWHVws/8+k1sPnHkDdcwTShyIls1ZKBCakTnhRrdIDRkkS/UfUltt9+vLPY2IDfwg0q+LwGjomyJ0dqUhHknDiMkVKaRk0tx94uzTNwKTmnJFmQe60PpFQPLPD8BGbjNxlUCgV5UJS/YutRv0su0HFhwAfypsVAQZ/pEVXWRDIXnz5xefrEmbRyRdFkZZHlSnHe0cVcxkCgAiGd0C2L5fi9x97OCRlhNF0x2ry1EjUI4NMdAP18NIye4fGpbK1ySnPM0FdcC4C2Xpfy9aRUHypuv36qFGFEMzTav/W5oMlh7Vyjg55YxSZP;4:iyHp1pMeDB5D7J1PmmFYpkO96e+CDXXxCSc8aDVZzcL3vz5SOL0mlwp5BzvzIHLZblQEdTs5QzE3RZC98H9S7hRMRKHe28Bfn04GtxFWCyLXDntRl2LxgMQ9vLfrpIGrN4G5noveHLMbgRkVtd8mEBQ3bEl8kaaTWO6SEudkuH+BuY/N9ulR++3OQFzVn+bWMJAoc38jlyVdem73AbhaYFc6CNdvpZJLSoMBn8Y/dX0QV+JObYxDRBmOtylYsHPNy/bCSseeQi1ZAcnW4WqE+g==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2018508D37B01104F61A0D0ECD250@AM5PR0801MB2018.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2018;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2018;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(39840400004)(396003)(136003)(189003)(199004)(105586002)(14444005)(478600001)(31686004)(65806001)(65956001)(66066001)(106356001)(68736007)(93886005)(6246003)(47776003)(486006)(64126003)(76176011)(50466002)(966005)(229853002)(7736002)(6486002)(36756003)(7406005)(305945005)(8936002)(230700001)(5660300001)(6306002)(6116002)(3846002)(7416002)(65826007)(53936002)(2906002)(52146003)(2486003)(26005)(316002)(23676004)(956004)(77096007)(446003)(476003)(4326008)(2616005)(217873002)(86362001)(11346002)(386003)(58126008)(53546011)(16576012)(186003)(97736004)(6916009)(39060400002)(81156014)(25786009)(31696002)(81166006)(16526019)(52116002)(8676002)(6666003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2018;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTg7MjM6NDdOalpYbWRLcHNqSkdBUDNkbXFydTBT?=
 =?utf-8?B?djkxbUc4ck9OVzlDZzRIQklKU09pc255SWhkWWpNbzhNQ2VNclpHZmNtMU5w?=
 =?utf-8?B?WndsYWZxeFZLaURhZUpBWjhWY0djM0hXekFYQnh3aFNPeko2L2ZpckIxT3Fm?=
 =?utf-8?B?MFJ2UTEzMDNVZEtIQmJMaE1WNGp3SXpnTlkyVnMwYTZMNXFoa0M1SEVZaDJE?=
 =?utf-8?B?VVI2bHcrbGcrck9uNzdSMUFYVkVYNGw5c25URm55QUR4NEtUT1lFT2lMU3FH?=
 =?utf-8?B?OHhWc3htb0JmZk5oSWRVOXB5cE8zR2RGMURQTUtna1BWZGNuRm04d1VMamo3?=
 =?utf-8?B?RnozRnJxM3JqeWwzbVcvTy9peVdJbGluTzY0RW5qWjVnbDMrS0JWRFk5ZkNK?=
 =?utf-8?B?SDQ0RE10MENJdy83VTl2SWhKanI2MnBWS2lYcnJTR1FwR3ByQUYvY1l2Q0Zi?=
 =?utf-8?B?aEVOOHFJc2NYR3I2RU4xcjRuZXlHVDZpV0pzUEYybG96Nk9OdmxScjc3L2dF?=
 =?utf-8?B?Z3hjMHJUTHlvRVBmRjczM2JuRUNMK1NDVDBJZjlmc0I2RXc1WmxtNVl3bjVJ?=
 =?utf-8?B?SjUxUHcvekF0WVZ1d2FFMEovN0lXS1poaGFqcFBBL2dLTUtrU25HRkJyWEZQ?=
 =?utf-8?B?ZGs3alMyQzhGaU1ISmEwdTJESU4zQjU5RmZNaitUclZDSGlnanluWk1sQU9v?=
 =?utf-8?B?akZOSzdxcHFtWlZySjdYTXU1alBCdXUvbER2aVNyTjZZZjByYmVhL085enA1?=
 =?utf-8?B?ckVmN0tFMzhGdmRKaXhWZTYvQmpqQjJLeURwVFlCbG5aNmEwaTV5QW8ySjZp?=
 =?utf-8?B?YWxsM2ZQQUdSSDROVnhVektza0VwQjBBcXRUckdGNTYzcnV0dWhLalBEcDkv?=
 =?utf-8?B?K1F6c0pWc0g2M1JCZlBRL1lHK0JlTUkyUk9XcVVwWGgyYWo0aUpNeitzdUhK?=
 =?utf-8?B?eWJ3SC93UnVlQ1JlTVhBb3RzYXh0TGs5bTBSUVRVSEFEc1VvY20ybkd1VTFM?=
 =?utf-8?B?UTdEQjNOVzNvbEVjS0d0SkNaaSt4YkdHZFR6YVVQUWFERzVSOEtkR21DUkhO?=
 =?utf-8?B?bnJBZUg5SFo0QTJGMkJjSWprOWx3REZPWWJnVlBaMEpINVRlWEpQS0FueStQ?=
 =?utf-8?B?TFg0Z0lJdndYY1VsNndudC9pZGpCRGR0d3Z0SzRCM01pUTlGa3JvbU8xcVFk?=
 =?utf-8?B?RUVqbU9JZStrb1M4eDZsN3V3WmM4aFcvUkptRFRzNkhMajVFdHZhUitueDlX?=
 =?utf-8?B?SU9YRUdvNTlzdkNxREcwemJVeXZsdXJKM3ZMbVNZNDRjT0NmdittZjVjYWo2?=
 =?utf-8?B?SUQzUzJaMkplOHNJUEdvKzhHOWVEVzcvNHdtSHdmYUVzMWdZQ0xNdnoyYXpj?=
 =?utf-8?B?azQ1WS9SZWlUc3JwOEkxRnRIYms1Z1hzMVFXKzdDMFJWbUEzbi9hRGFETm1I?=
 =?utf-8?B?d0tVTm9jLzNBVWhXMEUrVHJyOEtEZUZPckJwbWFSU0V3bWJEcWp6OTF6UjQw?=
 =?utf-8?B?QTc2b0lMZVhKVVBBVE9PejI4bjl6SHBvc254MlJuVzZrY3lyOHIraXhPbEZJ?=
 =?utf-8?B?Um1BSlF2amhTNzRtdXFScmtkMEJITkFEbUp2eGo1aGprbzBTdDhCYXpYQ2Mz?=
 =?utf-8?B?VWczM3I2eXZWaFNSVk5IcGpzUlVQdjNVdmtoL2VYRjFXcjVnTzF3V0NQUTRh?=
 =?utf-8?B?N1c4dmJlaWV6RnNXR29xa1BtRkpYV1Vrd1VrRlBLYTRPejhNOUxuMjd2VWd1?=
 =?utf-8?B?aWpSazhvMFBvUkVzaEt3TklRR3RON1Y0ODEydENzV1Y3RklYcU9QOGNKaWYz?=
 =?utf-8?B?OFhoYWo3bmI4WEw0MVZyUDM3MENwQ1BWZlZrNHZkVVlLWlJQZVhoaEwrMisr?=
 =?utf-8?B?QXlGK003OUg4Mzh1anZsLzh4bUp3Tmk1OUlwZU9ja1dXbG9uaFV4NDc0YjNI?=
 =?utf-8?B?WDVhNkVaNXhwNG10eExDd1dTSVkwM2hHcmR0dnYzREJNdDZ6TVFBeXJQZUNH?=
 =?utf-8?B?TmhORWdNWkRWVzZRdmdDeDJXdDd3NWNJRHpFZTRiNnBWNHFQUGxMQ2NYRExY?=
 =?utf-8?B?NWdZU3JPN2RDUXZOaFhlazB1bFUwbW94SVVrNHdUbWZPN0NTanF4aGRZbys2?=
 =?utf-8?Q?yDRfGEKOJsPjLzTXWb7Lh+BxiO9mfKnUKqx3ZnrD4aEcGU?=
X-Microsoft-Antispam-Message-Info: sjwLyUBXL1I42Si6buZcbIst2gBN2otNJNUmoud0Wi9HubtJWF2lWgcL1MIHTyxAZsgSLPy46WW0ipu0zGLrCCzkSI5euj1q1AcE9XEMNGUXlfPFn4rKOBVn1++9mK8skZs/rdtOUIOfI0IBB+tIbC2VGI7SmxhYl0G884DVEZYDj0YKGrb1vF15xB7G3bk0PnngtaYhA2aeCmSD1olMP0oJz9mjesE1GKd3lSTRLwRhN/UXHpBEASgSODwe1RIe8ig+2rOT/3NTxhDkpBaSZfSRvikYIixag3LMhqhE9dZqtolhlyYklcESP8t9z8QlbqPq2P8PBl/eM8weGaZ0m4TRjoOwDU8yYq9s8iPHX+w=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;6:2h2V/XCvjGz51jiFQbVPHVo8lG1a7uEObCeqQ7e2Hd1FQerFcfOYeZKqH/6pWskG2NBL2DSZkLL2vwhMztAmXI3eDsNYIaAml98c4Y1NaYdd3xbTNrU6VaelL9S/G8xbJZrxroVvZZWIyjJeTDx7+Pn5hctVqspd4Pn4tC+IcpNBbUMx9QTWf96kPkn/T51KrADLrwlM1lWU9PrKg3I4mso0PHIhn1x39DX50zZ9BFgrHenWq/AXc25PszjrlwKB+Wb6aSTthmXfsOkD22EA1AwqJ0f+vi3Ukz56QeKuLy2+g1I07ZvMk72A/rCNpk4aHK/9NlvuCWBS5O7/c+6QeDH2ngIg+0laMkXz1C9TsFbzXXmRmie1T6Q9+ME4GDZbOX/uiZb3gdfIJE7/y2+COFFMO2OwgdFZOQRn26Kcw57Tg3iWzaLojQicYogCy4n33YD0S7ZITe6rK+74awsW4A==;5:MI7gTbdgMBmtJrq7m/AXBi72p6z+P5VqThVyt4G64V92VET/Rh/p5B46X70R49RQXVJFMt9zLr789qKdsxG0nEo69HPq9WOLSyFYZQ9dGqmsssQGvHqYizq67duVvFGN87vSdv1dOucYyf46KYhJhqsUSY0YAO9y0D9cpkh9nsY=;7:O9BUrooRIBsW2jMHoFl2XrFNfGwQwkrhSqdKgYu/BydnnUaTjVGsCdOoAFaNK9+2irpUX3Qyrd5OHCoJOFr4KUeJbLnoQiQ/iBoZM56oCfG6Ukof3W1SOgtNCm/nV+DOHqPy8H5hskVEeOgKMD31DprI9xTkT7fwlOga2ONyI/Dtt4SN9fbBNeF7wBb3hO/TgYM7SIg2BvlnCLRLKGmN1kxiFY1EusiyOznJkQ+UXWiGdQXUWZioGZHBnSVTO5Hj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:FGe2FsAO4/4N7qnqlvWq40a0XxN6zWHPxBHredlJ8FnQxndanpeSbiNQMiVOUiQFkGPGEVE3TLw1i0X7Xl9ugDMgQnLR2hKohQkHMAmaaGtWQwyk60afObQvBJskShmhvO9CfdzEFhts2c+T/iJTr6O4egOwhGAn0c3qAj3+twU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 10:58:20.0551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5ab1ea-6de7-4f61-0e66-08d5fde70688
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2018 13:37, Tetsuo Handa wrote:
> On 2018/08/09 18:21, Kirill Tkhai wrote:
>> 2)SRCU. Pros are there are no the above problems; we will have completely unlocked and
>>   scalable shrink_slab(). We will also have a possibility to avoid unregistering delays,
>>   like I did for superblock shrinker. There will be full scalability.
>>   Cons is enabling SRCU.
>>
> 
> How unregistering delays can be avoided? Since you traverse all shrinkers
> using one shrinker_srcu, synchronize_srcu(&shrinker_srcu) will block
> unregistering threads until longest inflight srcu_read_lock() user calls
> srcu_read_unlock().

Yes, but we can do synchronize_srcu() from async work like I did for the further patches.
The only thing we need is to teach shrinker::count_objects() and shrinker::scan_objects()
be safe to be called on unregistering shrinker user. The next patches do this for superblock
shrinker.

> Unless you use per shrinker counter like below, I wonder whether
> unregistering delays can be avoided...
> 
>   https://marc.info/?l=linux-mm&m=151060909613004
>   https://marc.info/?l=linux-mm&m=151060909713005

I'm afraid these atomic_{inc,dec}(&shrinker->nr_active) may regulary drop CPU caches
on another CPUs on some workloads. Also, synchronize_rcu() is also a heavy delay.
