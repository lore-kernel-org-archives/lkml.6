Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F922089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vG77FgsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F922089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbeKPSwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:52:23 -0500
Received: from mail-eopbgr700042.outbound.protection.outlook.com ([40.107.70.42]:32520
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbeKPSwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJt8qmsDyuQ4ujJkHTxqomWeWj/SL6612z+tFFK5ZjM=;
 b=vG77FgsOFTOtFi1lOdmq8yT/LJdP9cGYDY67FKxfaLWPUQrzsM0I6t7aCoM8GdLzybbMzERwGZtGARBQrffxHRFLNseuM4v1dSC+zdG1Uu6YiL7mLgkkFRvKsuCWnkJrpm0QHf+EB0K1pnd1iPqHcRjmC/lIEN7dwsvpyVS0KP4=
Received: from CY4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:903:18::29)
 by MWHPR0201MB3515.namprd02.prod.outlook.com (2603:10b6:301:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.21; Fri, 16 Nov
 2018 08:40:56 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by CY4PR02CA0019.outlook.office365.com
 (2603:10b6:903:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.20 via Frontend
 Transport; Fri, 16 Nov 2018 08:40:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Fri, 16 Nov 2018 08:40:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50270 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gNZgN-0001a4-AC; Fri, 16 Nov 2018 00:40:55 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gNZgI-0000ff-6X; Fri, 16 Nov 2018 00:40:50 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAG8eln2026777;
        Fri, 16 Nov 2018 00:40:47 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gNZgF-0000fI-4G; Fri, 16 Nov 2018 00:40:47 -0800
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
 <20181107085503.GA31517@flashbox>
 <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
 <CAKwvOdmkC1LqMokhQUebpEZRoWWWwtQnbm8xGwiwdBy9UOMT5Q@mail.gmail.com>
 <af717713-9e51-139d-1206-1682b83ae434@xilinx.com>
 <20181108150116.GA2830@flashbox>
 <40a17c3e-6c81-6f59-cff6-003a91e10b29@xilinx.com>
 <20181109153626.GA6494@flashbox>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <fd608da5-c1fb-ed55-bf74-7ed476d58c12@xilinx.com>
Date:   Fri, 16 Nov 2018 09:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109153626.GA6494@flashbox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(199004)(189003)(23676004)(229853002)(93886005)(6306002)(2486003)(186003)(77096007)(26005)(65956001)(53546011)(65806001)(81166006)(76176011)(81156014)(305945005)(8936002)(478600001)(966005)(9786002)(230700001)(356004)(36756003)(8676002)(50466002)(36386004)(47776003)(31696002)(106002)(31686004)(64126003)(575784001)(5660300001)(14444005)(44832011)(110136005)(54906003)(6246003)(316002)(39060400002)(2906002)(336012)(446003)(58126008)(63266004)(426003)(126002)(106466001)(11346002)(476003)(4326008)(2616005)(65826007)(486006)(107986001)(2004002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3515;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT030;1:MAQ0xItKARedy2zCgGkHqFiG5AdFwwWm/R1D5AMQgHu3vTp8DimW7Jv+JQiElc92QST2YUV5M8FC2eErYkPHUogzUYj3hjMVtwWZXntQmB1qi3mAb4ljXlFSigceIDAY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c267dfac-0306-4661-1646-08d64b9f39d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3515;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;3:6xHqvf6sLbpFqYbMD9BOaduJUTSNm5OJbHnUabUEanRwd+kvdgHKnFJhHRQKXxM7fW490B601opDlJdKRY+nG10At8Cu6CzjNX4pOKTKilHjxuwLVgRiED1gQRD0cldAKCpmePpghjtWZGeApkX0NAO8eEngfOVQJR4aL+cEGl3UmfuR3Wm3VmQ/NKx62CAopBFvFz/8PAZYtM2ryaH7rKctcEvp4le93XefCZRGH9DhmQEbl1vuFMI5y3O0klVvY6sG4G4arb44YCGDnpcqAMst5sWl4Igu5Wt/bdhX40rEGC+FOoGQn81U/S8GOz+S/vYLUlDFy+BP0d+Y7abN/kcnJ9kEDEaFwrfXyQCBMUs=;25:/z+s+Ifd5QObrXmZMnyJwwTzij7TLznhO/Gj2SSxqeuhMK4mOnqAk4ovyTslN8Wa+RD5ycOnaE2tUebxyfRVOR1N3RVOeg6nYU4o/GB7xetxIBOzMLPJrB0vf9JE+2l3PSGQQoITwPDyXNlRBHb2bFoNv9fjdR6Sl69j/agdEAVlEsfpXa8215PZ87tfine4gA5gWx2ZK+0irq5nrgbxA4vsRAuv2efA19YKBhDC5Kk/PSlKLGk5jSK9ckLdUlGKbBE+hiwHV7K4zrKrQ6FyUrQ1t5SzHMTYTa1Wa/wT8HsPsbXLdmL6mO03f0XIeNQJ6TSdMd4gekM6ziq8ppI3Qw==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3515:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;31:bqBExQAaKoSOJ/eVnoOG5lqzpDEb3dXJxj14dBxntH9PBwPQobmotk8g4P03b+fvZme7ZNQY0KhKh9x/0zI83JpX2d9GJ85GKeCiut0LCUOsvRyFygaY2W3luUXXhhZiQnvsadgaHoi1KTOKUtMqJxFaypZNkZRqVk+BNpF/xzMcHPWs4dhcqQ6rWGutK+IPm8XYRQcatWdJ0vFcYpPlW+xYsK6v4MmVMuuo4r840tI=;20:GfAfA9XvTd3okiR4aNeNHzKzIB5bgm0X8oYMfZYAO63WoonJHaF+fQggyjvLjdUAF1nOJt2+AXlu3Eb19PtQ7wdH96HSgRpWx2PIwKsJqebDKRivMGtK+6/Y7J1+Xq6TTHtyK+2tDUH4mWgGaJStfPdKwiic3F97tbHqWRUK8a4fPQr7fK7mQ20B3BBTorlzZTMaBxG9UwwGbgv0ADN5ZxQ5ek99kuc5GWcVhi0pAJyp+6UpKrLHE+XAIJjqdrnlraDF+ZM3xdvlVuMVhtPofhFDNHDc6bm/WrpVj/q/onABAI6emyL0G3BRBjJjUQ69CSmfug8qefAUmOCtmnTTwjoOkRr9OxdvJmJtgFTutujguURZkDm7bT4WfiFOB6d0ejOXFxLEelUW5UhZRQrEcPQzcEcqi7uzRJje0R+6wahmxEWnv0M6Rts+jhkNw3LMhFowxLVZBgsrhOckt1k4OSgGoieeF0getW0nRXY7CZNkkT3Dn5tk5dX1hhVq5w6l
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35159FC2800FA5381A31C47DC6DD0@MWHPR0201MB3515.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231415)(944501410)(4982022)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3515;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3515;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;4:pwWTBMB18ALeMJQtUI5Wv1Or1mqhroplmPrLXipNp7yJMtaOXaD5cfL7rzsEDV8cp6Pa3omhzKvB/mq8i+DguLsJYZTyFCpmK+Aqe9ACJStohj5f4VcdwNJR1/Kt2+hsBkjgnfuTpW1zc4m8UCmhx9KGhh98c7gg9p3GUB2bNCaB0Cms+kPto0IL8Yl7Vswdnin+Zfm+GVpfVM/NGVVrei3lpXo7a8bkqr9AyQRAXZXL8zEMgt8e/joBIMVk4+xmBnPA3xo8vGhkTVPSiGAu8A==
X-Forefront-PRVS: 0858FF8026
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyMDFNQjM1MTU7MjM6MmFJRVk5OUsvQ3pGKzNKZVFsbm9BWUQ4?=
 =?utf-8?B?OS9seG02eitEcHc0OEphajdkdXZuSVZ4dytnV3pOQ1FSdXRjUVY5THFIdVdz?=
 =?utf-8?B?OUxKaXI3aDNRM0thQUFZYUlPbEYzYnF1Wm8zYXl1eTR4VTIxQWN0QnhjNUtm?=
 =?utf-8?B?MHo3SHlvK2o2WE0vR1B6S01OQzByclYrNnVJWG0wWFdIanAwYXFWaWFiNlR3?=
 =?utf-8?B?b3BZakdlNzgwQzdCOEhmZFVVcHdzTWNzWEs1OUVGc3FybnI0UHFtZXU0cUp6?=
 =?utf-8?B?akNjSUdneC9oWERwMm9NRHdodTg4dzdyeEVxcG42WlNBeXA3eVpleDA2SU9Z?=
 =?utf-8?B?cFpyLzVoZ200emxUVjZjanQ1U3lveWp2VTNQaHBQV1djNHFYNW9nYjJ2M0pq?=
 =?utf-8?B?cHpTQlQ2RnUwQnNPUnBGSHJORmhseDZEQnFyc2JwTlVBNHZhRzc3MC93aUFw?=
 =?utf-8?B?NVJwTUhFUjVEYmZBL2xzdzgyOXhEU09OekE4czJVcUJGaTRScitDemNNVmVD?=
 =?utf-8?B?NkxtSVdSUzQ1ZU5HeEljOHhVdFlmeDFOczNucWNJb0JERWVTVFpJSHhybnlk?=
 =?utf-8?B?d09haE5jZEFSTGZVZ09laFArdis5UDVSYXNOREJJcElLL3BXdTM0UWFVOVA4?=
 =?utf-8?B?Zmpadit6bEpVLzVwWkFOdUthME1PcTRFZkFoTFFUdG9WNkpTSXAxT1BkdzhF?=
 =?utf-8?B?bnhmRFA2aTdsaGliNEhSekNOd0g3NCtzMm5xU2hud3h6ZHUwUU43NkZCellE?=
 =?utf-8?B?eGZhVXRJSGhrb3pWSnBLQ2padWg5WWQ5YlByUjRJK2VrbUh6MVA1U28reDlX?=
 =?utf-8?B?WTVGMHBHdTJ0VGFpUVBEN2doRkFSN1A3VmtRanBJM3JNS2NhckpuVjQ1NmJT?=
 =?utf-8?B?STlwSUFJRGxuZW5RTXF6STJ3bTVRQ3djUVNqczBZTVJvREhZSVJtK2pqbWkz?=
 =?utf-8?B?S2ZPeEZPOFRwWURnSmtKbi9sbGtXZ0JjTnRwVjAwYUhZZ0d2MUpURjN4eG8w?=
 =?utf-8?B?eTRneWx3SDdQWGJYZ2w0clUxSUFQbGgyWitCLzhPWEFxM0h2V2FHZGN3RXcy?=
 =?utf-8?B?SzNBdlhzYVJ4Uy9pcHNDR1ppZ2NNQ0dCaXdaeE8zTlV6NFhDL0lEL1FzR3pU?=
 =?utf-8?B?aVljYWlaMFN0WTh2Vk0vY29OTDlEZTU0eHc0eDVzNGg1MkZoQU02ZmcwMHRP?=
 =?utf-8?B?c3l6QVBReDRNbGJpYmJhMWZkTkJKSUhUdE01SEtCNmcrQ25TYWxVOEZDTEJU?=
 =?utf-8?B?aVd3WEFpUHl6Y28vNGtUOHhKNFQ1RStwaHBYdWkyM0VPb3pkMjQvYlZWMkl0?=
 =?utf-8?B?WkRWeFlSTkg3M1FEUnJFS0EybjJsZlU0V0dRcWdUMkYzdjRzMTlGMVVDeWVH?=
 =?utf-8?B?VzlMWVlqcTFiQXVFaU9yRTM0eDluNWpFZ1FucFpnMnlzVU82anFvN2RwTzJl?=
 =?utf-8?B?WnVncERRKys2Z1hreWFwNE1JZlkzcStWajJPNE9UM1ZhTXFleHlOUER1OW04?=
 =?utf-8?B?WVhtN3E2alJzSmw2N3o1UlJzR1VlbVZJOWlkV3JTM0pnM1JPVmlRcTNZSmEy?=
 =?utf-8?B?aEtZdlhyRTF1YTl6cVd2VmRxd29KMlRMVVE2Snl2c2s1Y1pHNE5LVnhGdDJJ?=
 =?utf-8?B?UTV0RStBcURuUzQwMWtGUHBaREs2WlRvUERSVU1jNTZUdHFuaUloU1RYNnRv?=
 =?utf-8?B?anJla2Q3bHpyOVoyQUpKYXlBOTc1SEtoOEVYUDJmYnJtZ1NoK2MwN3pYRUlZ?=
 =?utf-8?B?MllOc2F0T0Vibzd3ZnZSL3dvWUpuNjBmc2JpWkRHNzJpYzUva0dJNHlxY2RH?=
 =?utf-8?B?VitsVm0zZ3NIM3NWYWZZSWpKbmJEVlp6d2szVDk5Y09yV0xQbW9wbEkvOCtV?=
 =?utf-8?B?TytrU1FJZHJCWlJVeGZBUzhkeXZVVkNsZWVUajhnR0dVUW1NM24xTi9VWGRz?=
 =?utf-8?Q?0ZrQk7DtAh9MJZBzOtbOAiwpDQb338ZI=3D?=
X-Microsoft-Antispam-Message-Info: ZT9LmBALMYoig161NHlxci5EjpOnyaNj20Rxi73GgXo4RKVVpEfZciX8pvtkAG4ndM4NM1TOZCEUhqJGySYk3y/OMCj/NLCIx5xFvakViRfwTVgNHGjSIxMSa8S2YHZqPxPAuR6TDNU2QtKj5xbUOm9wGcUiiF9jD2ychLzEwxUf0+wxX14PTFoxH6dGeT/npcPp5uuRVd6JU1uj86cqhwzumMxS/ttgmYJG5cz7A8sRqZvnTX40FltqNnbFWXg7gKQPDFjdBf7NRjTKVaRLF0q3b9UpgeHGLH9cu9LAq99lDV5MbZKz6mHgux2NmNHyavWsQIRtCEofNk0E4GYslFdmJVYiTxLbJIrlzCmYbZY=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;6:nZaG0rBTEGeAcsYS6wIaZpn/LMXA2a78FouuG4bzNKgDRFKWQW5evgVV/JL+iPJAac5GusdeotndxR9cM65P7rsDCTqBnpS3t6Vg0zyDluMbEAEnNQfjjvllTlHRfSE7zFNTtVqYDfRyIw7WIwLTbDssZysib7sBOkfljvqW83sDGcIN5qmDGN2aeGWZf3V5sBPWXo3QfKCpUXOzjpLPPyAU5TzcUa/F/twQ9msD64+c0u2D8pozONnkecdceWQSTm/9E+Cesvjtl32FjfDQPMqsA6FomBOTwwV23FTAkTBBdsa54iO9ZTOMtqbunAc5tG3H0Ec7Tzk3WRcuKSViIqc7ZwOofbZ0VBEtJ6fcG4TaPlX4OU/0hBreOQmvJGB5rR4aYqQkeeUAA2klc4pyBDdYnLi0dg/RZM5VRu4SPOXvJ6SaLxGk2RPOd3kNMBDoM9UZnpGpv7JCrot/zHT8eQ==;5:7o/AapFCh6y033MnAmCRAOM39v41oCi/6Dxo2sHHytQCXgrYIygvwfHE3YXPbj1FRkC4RNMvCmW3EF696wAPan1D68EUTa2HsoNqvO8rNpv5+YGepI+zs91O3Nm5PTxUsDAonTnyieBQZE6XX3oVVV0duJ1vh1t43WGpQOBkNso=;7:P1ooUh4CWAxa8Q3xF/PScvrdkrenC7g1F3JSV6C1M4aoihHf9XSpNCPSBfaQhc3/lxoSrCu1OyszPvsySEgjFjKpDXWNV7PBs63Apn+RMEEyURnNtrw5O6PlGUR2To5s4XHIZDiAs0DNSVIHdqCokQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2018 08:40:55.7419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c267dfac-0306-4661-1646-08d64b9f39d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 11. 18 16:36, Nathan Chancellor wrote:
> On Fri, Nov 09, 2018 at 10:33:00AM +0100, Michal Simek wrote:
>> On 08. 11. 18 16:01, Nathan Chancellor wrote:
>>> On Thu, Nov 08, 2018 at 07:45:42AM +0100, Michal Simek wrote:
>>>> On 07. 11. 18 18:48, Nick Desaulniers wrote:
>>>>> On Wed, Nov 7, 2018 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>>>
>>>>>> On 07. 11. 18 9:55, Nathan Chancellor wrote:
>>>>>>> On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
>>>>>>>> On 01. 11. 18 1:57, Nathan Chancellor wrote:
>>>>>>>>> Clang warns when one enumerated type is implicitly converted to another:
>>>>>>>>>
>>>>>>>>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
>>>>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>>>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>>>>>>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>>>>>>>>>         ~               ^~~~~~~~~~~~~~~~~~~~~
>>>>>>>>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
>>>>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>>>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>>>>>>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>>>>>>>>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
>>>>>>>>> macro 'PCONFDUMP'
>>>>>>>>>         .param = a, .display = b, .format = c, .has_arg = d     \
>>>>>>>>>                  ^
>>>>>>>>> 2 warnings generated.
>>>>>>>>
>>>>>>>> This is interesting. I have never tried to use llvm for building the
>>>>>>>> kernel. Do you have any description how this can be done?
>>>>>>>>
>>>>>>>
>>>>>>> Depending on what version of Clang you have access to, it is usually just as
>>>>>>> simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
>>>>>>>
>>>>>>> Clang 7.0+ is recommended but 6.0 might work too.
>>>>>>
>>>>>> TBH I would expect to download container and run this there to make sure
>>>>>> that I don't break anything else.
>>>>>
>>>>> This is the first request we've had for a container in order to test a
>>>>> patch.  If it comes up again from other folks, I think it makes sense
>>>>> to create one.  Until then, its nice to have.  It's definitely
>>>>> overkill for this patch.
>>>>
>>>> I have played with it to see that error and here are some steps I did.
>>>>
>>>> docker run --name test-clang -it --rm debian:latest bash
>>>> apt-get update
>>>> apt-get install gcc-arm-linux-gnueabi gcc-aarch64-linux-gnu clang git bc
>>>> build-essential bison flex make llvm vim libssl-dev sparse
>>>>
>>>> git clone
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth 1
>>>> cd linux
>>>>
>>>> export ARCH=arm64
>>>> export CROSS_COMPILE=aarch64-linux-gnu-
>>>>
>>>> make defconfig
>>>
>>> This should also have 'CC=clang' because compiler detection happens in
>>> Kconfig now so compiler flags get properly set. Other than that, looks
>>> good and I was able to build pinctrl-zynq.o without any issues with
>>> those commands.
>>
>> For arm32 I am still getting compilation issue (arm64 is fine)
>> Below are my steps and version I use. Do you know what could be the
>> problem?
>>
>> Thanks,
>> Michal
>>
>> root@1e15921e6d15:~/linux# arm-linux-gnueabi-gcc --version
>> arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516
>> Copyright (C) 2016 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>
>> root@1e15921e6d15:~/linux# clang --version
>> clang version 3.8.1-24 (tags/RELEASE_381/final)
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/bin
>>
>>
>> export ARCH=arm
>> export CROSS_COMPILE=arm-linux-gnuaebi-
>> make CC=clang defconfig
>> make CC=clang drivers/pinctrl/pinctrl-zynq.o
>>
>> and I get
>> clang: error: unsupported argument '-W' to option 'Wa,'
>> scripts/Makefile.build:305: recipe for target 'scripts/mod/empty.o' failed
>> make[2]: *** [scripts/mod/empty.o] Error 1
>> scripts/Makefile.build:546: recipe for target 'scripts/mod' failed
>>
> 
> Ah because Debian's regular Clang is ancient.
> 
> For testing, we use the builds from apt.llvm.org. Commands assuming
> you're using the normal Debian image:
> 
> curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
> echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch main" | tee -a /etc/apt/sources.list
> apt-get update -qq && apt-get install -y clang-8
> 
> Then use `CC=clang-8' instead of 'CC=clang' for all make invocations.
> 

Still I see some issues. Log below.

Thanks,
Michal

root@1e15921e6d15:~/linux# git reset --hard v4.20-rc2
HEAD is now at ccda4af0f4b9 Linux 4.20-rc2
root@1e15921e6d15:~/linux#
root@1e15921e6d15:~/linux#
root@1e15921e6d15:~/linux# export ARCH=arm
root@1e15921e6d15:~/linux# export CROSS_COMPILE=arm-linux-gnuaebi-
root@1e15921e6d15:~/linux# export CC=clang-8
root@1e15921e6d15:~/linux# make CC=clang-8 defconfig
  HOSTCC  scripts/kconfig/conf.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'multi_v7_defconfig'
#
# configuration written to .config
#
root@1e15921e6d15:~/linux# make CC=clang-8
scripts/kconfig/conf  --syncconfig Kconfig
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
  UPD     include/config/kernel.release
  UPD     include/generated/uapi/linux/version.h
  UPD     include/generated/utsrelease.h
  SYSNR   arch/arm/include/generated/asm/unistd-nr.h
  SYSTBL  arch/arm/include/generated/calls-oabi.S
  SYSTBL  arch/arm/include/generated/calls-eabi.S
  CC      kernel/bounds.s
clang: warning: argument unused during compilation: '-Wa,-W'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-Wa,-march=armv7-a'
[-Wunused-command-line-argument]
  UPD     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
clang: warning: argument unused during compilation: '-Wa,-W'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-Wa,-march=armv7-a'
[-Wunused-command-line-argument]
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
clang: warning: argument unused during compilation: '-Wa,-W'
[-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-Wa,-march=armv7-a'
[-Wunused-command-line-argument]
  CC      scripts/mod/empty.o
clang: error: unsupported argument '-W' to option 'Wa,'
scripts/Makefile.build:293: recipe for target 'scripts/mod/empty.o' failed
make[2]: *** [scripts/mod/empty.o] Error 1
scripts/Makefile.build:518: recipe for target 'scripts/mod' failed
make[1]: *** [scripts/mod] Error 2
Makefile:1075: recipe for target 'scripts' failed
make: *** [scripts] Error 2
root@1e15921e6d15:~/linux# clang-8 --version
clang version 8.0.0-svn345496-1~exp1+0~20181029105533.852~1.gbpf10f36
(trunk)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
root@1e15921e6d15:~/linux# arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


