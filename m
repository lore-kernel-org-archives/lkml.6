Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C608C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEFC2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QzShGxVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEFC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJJNpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:45:32 -0400
Received: from mail-eopbgr700041.outbound.protection.outlook.com ([40.107.70.41]:33920
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeJJNpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+4uheSqqu4jFlwIuBO0qRScp1mbRLV0pvd69og6tjI=;
 b=QzShGxVu/zcuMy8DDGRVddbVMmcSXfIQQrdxkX4uLCR5lbaKXjYj36plrEWJAmZcCU7pxEQU+G6qajiu1mgslzPXBA5eYqGLWykVyFInt/r2QKYGA4oqc76jBatHlTELunUB+m33y0IBWCqbIU/bccU3NJRVmkzSqsKuNhCEWdM=
Received: from SN4PR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:803:2e::12) by BN1PR02MB088.namprd02.prod.outlook.com
 (2a01:111:e400:40e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1185.22; Wed, 10
 Oct 2018 06:23:47 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by SN4PR0201CA0026.outlook.office365.com
 (2603:10b6:803:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.21 via Frontend
 Transport; Wed, 10 Oct 2018 06:23:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Wed, 10 Oct 2018 06:23:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37851 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gA7uH-000357-3g; Tue, 09 Oct 2018 23:23:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gA7uB-0000HG-W2; Tue, 09 Oct 2018 23:23:36 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9A6NVEX012842;
        Tue, 9 Oct 2018 23:23:31 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gA7u6-0000EN-Id; Tue, 09 Oct 2018 23:23:30 -0700
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file
 generation
To:     Firoz Khan <firoz.khan@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org>
 <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
 <CALxhOnh4__SMm93Lpr13eHxBTvDnocHzdh3YDxtuogEKg355Vw@mail.gmail.com>
 <440fc4a0-cd4e-c8fc-9278-928cf5b7cd92@xilinx.com>
 <CALxhOnhFyb13YZTRFNsvs9FWD7OCzPtbmdzn+V_YepXACVOxiQ@mail.gmail.com>
 <CALxhOngLfXNvnxXZZJuJVbUGW7peoo3=Ss8ToVWcDCm-g14GTg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <841821b9-6223-ad74-7558-3b456f498317@xilinx.com>
Date:   Wed, 10 Oct 2018 08:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALxhOngLfXNvnxXZZJuJVbUGW7peoo3=Ss8ToVWcDCm-g14GTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(501624003)(199004)(189003)(47776003)(76176011)(478600001)(336012)(8676002)(65956001)(65806001)(54906003)(58126008)(81156014)(53546011)(356003)(64126003)(26005)(316002)(110136005)(81166006)(2486003)(23676004)(14444005)(4326008)(36756003)(44832011)(106002)(9786002)(305945005)(77096007)(36386004)(31696002)(5660300001)(6666003)(2906002)(229853002)(106466001)(93886005)(186003)(230700001)(6246003)(39060400002)(486006)(50466002)(126002)(476003)(2616005)(31686004)(426003)(63266004)(7416002)(65826007)(8936002)(11346002)(446003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR02MB088;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT034;1:utMwQ47SNkOk2vKr46RXvlLlJdHRSmPnn4W7kMzvv/+UUn7sg6/iOO8dDvbsxPLVVi9eGXYzzvAQmIAbLXuFwWKEz0fDxvQNMirIbPbViS4sLVgleVeuwZVbyOnEf/1B
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c87ae85-82dc-4d9b-f10e-08d62e78ef24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN1PR02MB088;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;3:PyaxZnGU6SgoQ7uaoZLXL9eBxtmR2jv7dhWgE5dg09LHSngi7LoLqck5nvcMlfYnKNpwkBjiTWwJbH2qYIOIdLGEEcrZHtloy6HoVTKkPFYky/+1eZKm1NgjgjqVsTle8pTM85C47/Mm42iCIqDO22VpwN/mdn0KHR3BVeqdzMzJQj8jmhIWhQjoy27UWzNiznp/Go0+7fTwFttQzDktrxpRN+mpNmoJog6oou47bgMn3kpuwbCQfagtIzivSDD9PEROQcUWzFIkE7bavusiNYO6/6Qk79jcNjJEPvFO+wQ5pOv3TC4No19fMF9Vu6tYMEBk84OvAhsafyIS8WQdFlGwNCp5OQ/oui45CjxddKk=;25:ytJiOsqZGo28KRCeI2W6RfaYP4QLpEQdR4THYpEhD66neZskzP2a8RMgwTvJUNoS36ifR7mP9Yho3b2Dbxn45WRo/S8Qbn2Ph4m/XFiFW3FZaGKGobU8Xn9VjeB18ZnvHs8WejBhBuvg1HsLUE5EucWkcAFJWEAQfIaqxFCNOqOHvuacgwXVrgUZ5UL2lQ7zW+JKJAxqF4CWBcwSEUdQ/y8WBpl9glom/0rpE05G/RMg/9ymqKiI8HX+Qr/0dk5/b3PdN4XFhVjWeeuuS5DHiDEKtR1JOPIdUQjQOS9HcYlmPSs3DyoXWbhTbTojcCnbHmZEPjuewD2H/Ah+AcS+ww==
X-MS-TrafficTypeDiagnostic: BN1PR02MB088:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;31:o5QEQyPSW9FMAT2BB2N/EeqjykYCEiAU6dm37HEZzouv8keEwEWFbvIccJxvYxOrAdpZBYwGTmoLBdxldNRHnA/ohoQXC/0VNlThdq//JM58e+XFRb8J/Ef7HSkvYuKm6bC+BrpHJu2FSD6Vld1rdQgRdAU170U99KyVKHqo2aEYcf6fq0/hbQPwRQuME0zWDWVEf1bNRDHMW7sJztBtjzhMYs+1pFPQqUsgdqKbMIE=;20:nVY0Z4n+/pOmeIvFR05pmj8MbdP0vqRqO4G7dMCOAZgmICSLXlEUN2p9HerYsXrlImjdQYdPSiZ5Cq+GY53OLank3ApAV3UWh60U16Le8YaG/XY1IlCI3xrP9bkXZPcZ9m0VqgeqzrsF5ubWbECpMjEfHFZ/gjZPRVY5DgwLTL/820Ki/VLJNVYCYIiwqP1tR6mSqYssjjwBAYC/yExWxDGSdEjjQg8hSaOgUWxkTgDz48vV8yga1x7MHKy/OwA8Z3tKFJ5OBcLcivgVPuOfvp0BGhcOMCVUJwrMDoRY8FQe+rU0VxV6Mf0C2zm1U2Gmz35w3gyFaNedYBL4lVgtg3By4ghXPqva9CnQzbQOhdrJSB4QvbhU2BfSZg4szsabJf5njBz8a0bdsv8Yge/IXnzoguPCcsGZ8HUhYuuEnur/ODBrGTHUxW7Kw3r3fvK6rJ8IiCRGvykFItjKloStLp/AH0c0w8wJn49VA2SPdpCb2zGVmCCj82WvGTfotbTC
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR02MB08815A0A84519E32CFE328CC6E00@BN1PR02MB088.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN1PR02MB088;BCL:0;PCL:0;RULEID:;SRVR:BN1PR02MB088;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;4:vUfMT5EHbzLXnK1q83Do6pnwBpN89TFZQc4cOAdqmJNeNeBTFh2ofYTcHwc0WneeBtEFxgOyvtGDLWhfuHUKFKaO0en8OvtDMDsgaUvTTJUXFxosge5tTm0G6waypXQDFinet/bAawnV51OAimCeKYTpOtxsqYRYkNnehyoXdtxqiaLpHhNwz7Q/ILPZriD1ZFH36qwkRxvfCIGZegColIlyMrawAKQqYtpXAXoFmfoBLlKwHKFmZ571cQGwRoG6jjTYPdKHtMKhiO9d9e1BiW9eNkT3oNVLqntIw32g9AUiMjO1wgKTIGX2u8mxWfPZ
X-Forefront-PRVS: 08213D42D3
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFQUjAyTUIwODg7MjM6RVhxRlpVWHNtSHZHTFB3T09YR1JXSTNpWXJt?=
 =?utf-8?B?UDBqUTJiaXlILzN6M0tsdHBoN3VWNE1BUVhXTlI2SURXaGtidWJGNGNtaW4x?=
 =?utf-8?B?VUZEUlVrWnVsK1ArSkdRb1NMSXgxT1JIUlJhRVFTUGZURXpFaU52NGVDK3h4?=
 =?utf-8?B?SldoMG02MXE4Y2tpMjlCRG5kWUJBZ3dYcWZVY2pJYmFlWUNyWE14WnE1L1lS?=
 =?utf-8?B?T2VDcGE4K3Z1SWh2dXU0MjFXWkVGOE9DUUUyY2wvOE81V1p4ZE9ndldpcUtY?=
 =?utf-8?B?dCtDQ1k2ZUJHQ3VNeFluWVFvZE85eFQvMzNQdmI0b1BGN3k1aTc3ZXpRQlVp?=
 =?utf-8?B?aVhnbk9LOGZQZHJ4dHk0dFd6RDJjMkhBQ0M4eVQzNkZjNzdoWmZKd0ZhQ2hF?=
 =?utf-8?B?N0lhaHRpcEdrVUI1dmpHcktHSFBYYmxVVFRTd21XZ090RkdoUDZHUUY2T0FW?=
 =?utf-8?B?RW1yQUJ0N3FHN0F3Mm02U21SMTJPUkM3eHk4VjRrY0N1NkloVTU5TnNDQ3pj?=
 =?utf-8?B?cG5LYStIcW5ma21SRVdBSDdTakUvNkZmNTlvQkp3djk1RXd5WGJCL253VzhL?=
 =?utf-8?B?V1JwUHJqTTg4RnNZL3dVcmF6WEo2b2dZTHRSZmJBNm51eERxYWFVMHJwNjNM?=
 =?utf-8?B?M0hhd2ZJcm1LSkFoZ0Y4MHpIMEFTazd3VzVWQTVWOURaekxJUnp4UzE3N1lr?=
 =?utf-8?B?L29KUVFDUUZyNjhLS0ZnbDN6T2UrZ1Flc3k3TTlvTWp5aXlPcytTa3g4N3FU?=
 =?utf-8?B?cVNyV1ljWjNCUDVYcm0rUkRWblpORTJEUU5veFVtTEhDK2ZwOGx1bzA2ZXgr?=
 =?utf-8?B?aTBtWkx3Y29EKzJNTjI1N29jS1Ayb2ZkQU9BVGk1L2Erb0RRZlQ3d3QwdUlF?=
 =?utf-8?B?dlhBM2p2MlJucUJnSFZrNGdLUVUvQzdocHhKd1FpRmVMQUtCNkdvOXpMRkYz?=
 =?utf-8?B?ZHpEZzJMdUhwZVBFOVIyb09yRHlMa2VaQW0vcVpyM1VHVUJqbXNLbTZOZmkz?=
 =?utf-8?B?b2N3YlcxT3hvWlplOHVBVWlaWGtWR0FnQ01zZVJrcDBiUHZGZHFEa0M2d29S?=
 =?utf-8?B?SDYxYWlHVHV2TWYxcVltc2NpZkYxd0MzSUNMWVkzVWJiVHhLcEE4Ym9rYWxO?=
 =?utf-8?B?eFRibzE4cTZLVUQvOS8wWmVMYWNBLzZ3MnYyUVZIZXEzdGkvZHZWbEJpL2Nx?=
 =?utf-8?B?QXZZYjhYL1ZlNHkrc20wY0NINmRlYlRQTmptRy9pMkNxalRvUFVMMjBNQ3Jr?=
 =?utf-8?B?bGxUNXBOSkt0TzJ0SEdZZVFuUDNDRFpkOFNIeUlMZVg2aUxIRkppaVdyTUNp?=
 =?utf-8?B?dmxjUzQ2bVNjK291KzJLRG5LbmJZZ2lQOXJ4V2JNcFNFVmtubFgvKzRURzlk?=
 =?utf-8?B?dU1QOGx5dWxleU5kY1Vwc2dGTzlBS1NheFQ0bkgycUR6ckRZQVI0ZFU3cVh1?=
 =?utf-8?B?cjhIRDlzakI5bUR6d2JqTkFqLy9OOTN5eGJkUWovQjVUNGNFYWJ1bVFDbkRv?=
 =?utf-8?B?aUx4QTUvUTlXeS9TQmYzMGc1K2haVXZXUXZUbnFlU3VQTkFqMElQZmVaRG1y?=
 =?utf-8?B?UHlBNk03TE9oZjJPeTNVb2hUeWN6cTRFUVl6eVFQTVlTc0M3YU43VVd4Zndx?=
 =?utf-8?B?VWhNamRJTEc3WW5EZ3FJZ216QTBnckk3M2NISjgyeGczMU9aSzlwY2d5OThn?=
 =?utf-8?B?K3YvbXNiQ0o1M25RemVLVjUxK2pvMnduVUwwd2dCU1pnNXRuek1IN095VGRF?=
 =?utf-8?B?REZSbnRSekhsTXdHM1ZuNThOdkxFMW94WEg1WWdleTBJcFVsbTRJUmVTVWQ5?=
 =?utf-8?B?MUtnbnhsTTRZQ0VXUHdHWkxmZ1NsQ0VPSnlyUXg5SzRMMTBpdjBmOEFCR3Rw?=
 =?utf-8?B?L0RneFFzVVk0VVJ1TzhsV0d5QVBSZkN6cVZCbmxrR25PTmtIY2M2MmdWdzho?=
 =?utf-8?B?cTJtVGJ1bkE9PQ==?=
X-Microsoft-Antispam-Message-Info: +RsrcQ+st/GWRyNcorCxQ77JbOh8C8ZF/Vk4v4A8T1e9m8TPWgyGCqjPvVm8tTodGvaUyVKX2z0tccz8fiSPT3jj/N4NT1WZyU8kzkoGedIO7ted+R2TlCrdA63TYqFHXjCt/rSe/fQUwtuz47NfCnI6C4qRRHZWh9aYX0VqUkDsAyRa8VD+3DApdOuzMSaBxr5g/wE2ym3lKTQZB5+JfS9poNfThNUADymdbRyFlosJyiK9KmMP/PvDNXZPM+cTgwMPBgAtwaFtc5aKL3HyCfuUKql5OKQ63B9f2THtzowUKdhbEo+FxxPRD3l9w/+ByLDthC4lhb84JqjHlYV862NpsR/1VqyN9mo8ahW56Jw=
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB088;6:0WjFT7MMZ2fZMbMdRZaRmUAa9sS0TV/80ecTnKeRI5pQz4Z0tpWr4iqeaRjEa4Qr7Mi/T3Y6asVlEI47cROTr9Xh2EgQ1X2XHq0n8e++WV9GvnZzwzERqE3Z9cEy+YhjxJ745wVtCSww4W5vhtEJvAHD2Ha2kqjeAIhISeOdlU4srPdhvn5hB9esCK4FJ60KAxYM4NHUrg5ujodGlq6FoXu9ZxH+g/mjOq5tb1GOANSpvtDQhMNCyZx47WyY6gPg0hg7ID1L62CFJ9AQpvf27uEb9gagdD8oVYVUm9Wz08Cq8e7AAln9r8J2tVu99QRHObukQ8YeudXnvmQufkgFTe+UaW9MZKdt8dNB4UTIzSl/ZU/zoS+msSgN6TzQBc+R6b1RZpyfPtFGyRm9bUdYe8DjzhbLQ5CsGzUNhP136ZoS8VGLobOrbdGPLkEOv83k6FRFVyjnMyR04U9NhMY0Jg==;5:JyrUQMq3ZRxDwwyDFFwAW7dI2BMgCrsupprYlYsZ58XkqpQeubxu48TF6sNCJlxHXwweItSSLn7PDWucVoHbyDVt4fVZwumXbXpe7wDacxV6Q7GBko4+0/M9fyAqo1PkNk7CjEyYkyfmxvMS9XqcqjkABq+ytdYNppEdsZK10p4=;7:noERhxrtv5aXEtR3XJaLSgM6i+k/wQNywl0YdrjQLWm5I4MlL/f4wjlUKiMMcupWQWmfWUUYzvoSq4nHslcvbUcGLHmERqNjEiWw064HCra2rTEz3rxAgriaJiZFEIiyQT32B78mlRE6tYVCY3lk+aFnp8LxAGM9kx/paXc8GcR2Euz3/im9dfBerWeSi8A9N65xzDyuq3+ynsZI2lPINdhdgYemNVTqsE3LvfftDGeHN1W1o4C0OlwTDKh8gY31
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 06:23:41.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c87ae85-82dc-4d9b-f10e-08d62e78ef24
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR02MB088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.2018 05:14, Firoz Khan wrote:
> Hi Michal,
> 
> On Thu, 4 Oct 2018 at 16:05, Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> Hi Michal,
>>
>> On Wed, 3 Oct 2018 at 16:56, Michal Simek <michal.simek@xilinx.com> wrote:
>>>
>>> On 3.10.2018 07:08, Firoz Khan wrote:
>>>> Hi Michal,
>>>>
>>>> On Tue, 2 Oct 2018 at 19:37, Michal Simek <michal.simek@xilinx.com> wrote:
>>>>>
>>>>> On 1.10.2018 14:43, Firoz Khan wrote:
>>>>>> System call table generation script must be run to generate
>>>>>> unistd_32.h and syscall_table.h files. This patch will have
>>>>>> changes which will invokes the script.
>>>>>>
>>>>>> This patch will generate unistd_32.h and syscall_table.h
>>>>>> files by the syscall table generation script invoked by
>>>>>> arch/microblaze/Makefile and the generated files against the
>>>>>> removed files will be identical.
>>>>>>
>>>>>> The generated uapi header file will be included in
>>>>>> uapi/asm/unistd.h and generated system call table support
>>>>>> file will be included by kernel/syscall_table.S file.
>>>>>>
>>>>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>>>>>> ---
>>>>>>  arch/microblaze/Makefile                  |   3 +
>>>>>>  arch/microblaze/include/asm/Kbuild        |   1 +
>>>>>>  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
>>>>>>  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
>>>>>>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>>>>>>  5 files changed, 10 insertions(+), 812 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
>>>>>> index 4f3ab57..cda5e03 100644
>>>>>> --- a/arch/microblaze/Makefile
>>>>>> +++ b/arch/microblaze/Makefile
>>>>>> @@ -81,6 +81,9 @@ all: linux.bin
>>>>>>  archclean:
>>>>>>       $(Q)$(MAKE) $(clean)=$(boot)
>>>>>>
>>>>>> +archheaders:
>>>>>> +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
>>>>>> +
>>>>>>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
>>>>>>       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>>>>>>
>>>>>> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
>>>>>> index 569ba9e..d64f5e7 100644
>>>>>> --- a/arch/microblaze/include/asm/Kbuild
>>>>>> +++ b/arch/microblaze/include/asm/Kbuild
>>>>>> @@ -31,3 +31,4 @@ generic-y += trace_clock.h
>>>>>>  generic-y += vga.h
>>>>>>  generic-y += word-at-a-time.h
>>>>>>  generic-y += xor.h
>>>>>> +generic-y += syscall_table.h
>>>>>> \ No newline at end of file
>>>>>
>>>>> Still the problem with "No newline at end of file"
>>>>>
>>>>>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
>>>>>> index 2c6a6bf..3a40659 100644
>>>>>> --- a/arch/microblaze/include/uapi/asm/Kbuild
>>>>>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
>>>>>> @@ -28,3 +28,4 @@ generic-y += termbits.h
>>>>>>  generic-y += termios.h
>>>>>>  generic-y += types.h
>>>>>>  generic-y += ucontext.h
>>>>>> +generic-y += unistd_32.h
>>>>>> \ No newline at end of file
>>>>>
>>>>> and here too.
>>>>
>>>> Thanks for your comment. checkpatch script didn't warn this one:(
>>>> Hopefully, I can fix this one in the next version.
>>>>
>>>> I would appreciate if you can perform the boot test on the actual
>>>> platform and share the result with me.
>>>
>>> I see one issue there.
>>> Run
>>> make mrproper
>>> make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/1/
>>>
>>> And then
>>>
>>> make mrproper
>>> make archheaders V=1
>>> make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/2/
>>>
>>> And compare output.
>>> What I see is that in the first part asm/unistd_32.h pointing to
>>> asm-generic/unistd_32.h
>>>
>>> But when archheaders is run before there is expected content.
>>>
>>> That means there is incorrect/missing dependency in Makefiles.
>>>
>>>
>>> Time to time I am able to see compilation warnings
>>> but I didn't find exact steps to replicate this but it also looks like
>>> on missing dependency somewhere.
>>>
>>> [linux](next)$ make mmu_defconfig
>>> #
>>> # configuration written to .config
>>> #
>>> [linux](next)$ make -j8 simpleImage.system
>>>   WRAP    arch/microblaze/include/generated/asm/barrier.h
>>>   WRAP    arch/microblaze/include/generated/asm/bitops.h
>>>   WRAP    arch/microblaze/include/generated/asm/bug.h
>>>   WRAP    arch/microblaze/include/generated/asm/bugs.h
>>>   WRAP    arch/microblaze/include/generated/asm/device.h
>>>   WRAP    arch/microblaze/include/generated/asm/compat.h
>>>   WRAP    arch/microblaze/include/generated/asm/div64.h
>>>   WRAP    arch/microblaze/include/generated/asm/dma-mapping.h
>>>   WRAP    arch/microblaze/include/generated/asm/emergency-restart.h
>>>   WRAP    arch/microblaze/include/generated/asm/exec.h
>>>   WRAP    arch/microblaze/include/generated/asm/extable.h
>>>   WRAP    arch/microblaze/include/generated/asm/fb.h
>>>   WRAP    arch/microblaze/include/generated/asm/hardirq.h
>>>   WRAP    arch/microblaze/include/generated/asm/irq_regs.h
>>>   WRAP    arch/microblaze/include/generated/asm/kdebug.h
>>>   WRAP    arch/microblaze/include/generated/asm/kmap_types.h
>>>   WRAP    arch/microblaze/include/generated/asm/irq_work.h
>>>   WRAP    arch/microblaze/include/generated/asm/kprobes.h
>>>   WRAP    arch/microblaze/include/generated/asm/linkage.h
>>>   WRAP    arch/microblaze/include/generated/asm/local.h
>>>   WRAP    arch/microblaze/include/generated/asm/local64.h
>>>   WRAP    arch/microblaze/include/generated/asm/mcs_spinlock.h
>>>   WRAP    arch/microblaze/include/generated/asm/mm-arch-hooks.h
>>>   WRAP    arch/microblaze/include/generated/asm/parport.h
>>>   WRAP    arch/microblaze/include/generated/asm/percpu.h
>>>   WRAP    arch/microblaze/include/generated/asm/preempt.h
>>>   WRAP    arch/microblaze/include/generated/asm/topology.h
>>>   WRAP    arch/microblaze/include/generated/asm/syscalls.h
>>>   WRAP    arch/microblaze/include/generated/asm/trace_clock.h
>>>   WRAP    arch/microblaze/include/generated/asm/vga.h
>>>   WRAP    arch/microblaze/include/generated/asm/serial.h
>>>   WRAP    arch/microblaze/include/generated/asm/word-at-a-time.h
>>>   WRAP    arch/microblaze/include/generated/asm/xor.h
>>>   HOSTCC  scripts/bin2c
>>>   HOSTCC  scripts/kallsyms
>>>   HOSTCC  scripts/dtc/dtc.o
>>>   HOSTCC  scripts/mod/mk_elfconfig
>>>   HOSTCC  scripts/sortextable
>>>   CC      scripts/mod/empty.o
>>>   HOSTCC  scripts/dtc/flattree.o
>>>   UPD     include/config/kernel.release
>>>   HOSTCC  scripts/dtc/fstree.o
>>>   HOSTCC  scripts/dtc/data.o
>>>   HOSTCC  scripts/dtc/livetree.o
>>>   CC      scripts/mod/devicetable-offsets.s
>>>   HOSTCC  scripts/dtc/treesource.o
>>>   HOSTCC  scripts/dtc/srcpos.o
>>>   MKELF   scripts/mod/elfconfig.h
>>>   UPD     scripts/mod/devicetable-offsets.h
>>>   HOSTCC  scripts/dtc/checks.o
>>>   HOSTCC  scripts/dtc/util.o
>>>   HOSTCC  scripts/mod/sumversion.o
>>>   LEX     scripts/dtc/dtc-lexer.lex.c
>>>   YACC    scripts/dtc/dtc-parser.tab.h
>>>   YACC    scripts/dtc/dtc-parser.tab.c
>>>   UPD     include/generated/utsrelease.h
>>>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>>>   CC      kernel/bounds.s
>>>   UPD     include/generated/timeconst.h
>>>   HOSTCC  scripts/dtc/dtc-parser.tab.o
>>>   HOSTCC  scripts/mod/file2alias.o
>>>   HOSTCC  scripts/mod/modpost.o
>>>   UPD     include/generated/bounds.h
>>>   CC      arch/microblaze/kernel/asm-offsets.s
>>> In file included from ./arch/microblaze/include/uapi/asm/unistd.h:14:0,
>>>                  from ./arch/microblaze/include/asm/unistd.h:12,
>>>                  from ./include/uapi/linux/unistd.h:8,
>>>                  from ./arch/microblaze/include/asm/seccomp.h:5,
>>>                  from ./include/linux/seccomp.h:14,
>>>                  from ./include/linux/sched.h:21,
>>>                  from arch/microblaze/kernel/asm-offsets.c:13:
>>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:1:35: fatal
>>> error: asm-generic/unistd_32.h: No such file or directory
>>>  #include <asm-generic/unistd_32.h>
>>>                                    ^
>>> compilation terminated.
>>> make[1]: *** [arch/microblaze/kernel/asm-offsets.s] Error 1
>>> make: *** [prepare0] Error 2
>>> make: *** Waiting for unfinished jobs....
>>>   HOSTLD  scripts/dtc/dtc
>>>   HOSTLD  scripts/mod/modpost
>>>
>>>
>>>
>>> When build is fine system is booting fine (v4.19-rc6 + your patches).
>>
>> Thanks for your support. I'll work on the same which shared above.
>> I'll update you asap with the fix.
> 
> I'm bit busy this week, working on parisc and ia64 support.
> Hopefully I can update you next week.

no worries.

M
