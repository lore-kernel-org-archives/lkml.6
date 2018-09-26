Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F82C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C17C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ORm1BwtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C17C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIZQzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:55:51 -0400
Received: from mail-eopbgr730044.outbound.protection.outlook.com ([40.107.73.44]:18464
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbeIZQzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpjhWoL4sYyP/URDgmmSQ40dAXX+iBKf4XVMCPjd1X0=;
 b=ORm1BwtSZGspqiK/Qqcs6ZBVm211fkPtlgpVWt7r/jvnC3bEqEugsGnwXK5RX6CclAL8nesn0FNJvDodiwlTgPZRG0LC4wojoz14kSJDdf2Ap0R3SfuoGcMTNWEM98u49eEaTYRM0wIhIqAGzbNKo/EIUsdngA+VzhPde1djayw=
Received: from CY4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:903:117::16)
 by BL0PR02MB4754.namprd02.prod.outlook.com (2603:10b6:208:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Wed, 26 Sep
 2018 10:43:22 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR02CA0030.outlook.office365.com
 (2603:10b6:903:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22 via Frontend
 Transport; Wed, 26 Sep 2018 10:43:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 26 Sep 2018 10:43:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45294 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g57Ht-0005gy-MC; Wed, 26 Sep 2018 03:43:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g57Ho-0000f1-E1; Wed, 26 Sep 2018 03:43:16 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8QAh781026997;
        Wed, 26 Sep 2018 03:43:07 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g57Hf-0000da-Bk; Wed, 26 Sep 2018 03:43:07 -0700
Subject: Re: [RESEND PATCH v3 2/2] serial: uartps: Change uart ID port
 allocation
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
 <39e840d1f727fe6338ea14b882ca9bf831f53e32.1537443710.git.michal.simek@xilinx.com>
 <CAMuHMdWQcc+ZD238e13fBcVW77304u2nqq2K9A9-wsDVAPEa4A@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c92386bf-ccdc-5c38-faed-75ff5e9718a6@xilinx.com>
Date:   Wed, 26 Sep 2018 12:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWQcc+ZD238e13fBcVW77304u2nqq2K9A9-wsDVAPEa4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(229853002)(230700001)(23676004)(2486003)(81156014)(9786002)(8936002)(2906002)(44832011)(316002)(58126008)(110136005)(6246003)(65826007)(4326008)(31696002)(81166006)(8676002)(76176011)(54906003)(186003)(36756003)(106002)(356003)(478600001)(47776003)(14444005)(426003)(217873002)(63266004)(5660300001)(336012)(53546011)(31686004)(486006)(36386004)(446003)(77096007)(106466001)(50466002)(11346002)(26005)(64126003)(476003)(126002)(2616005)(305945005)(65956001)(65806001)(34290500001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4754;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:fXfxgyfJ0SBdDbBhN0UUyZII8U8fjFQ7vKiVfDGSWIFyaORKgKLtTJzlP/5BhygvRGzYtSESzOIVXBwM2O65B0rBI+wvZRsE3SEk3S/NppPVnmF0PC6o3UFH/TXV9sJP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5335ade5-b3f7-4801-cb61-08d6239ce16d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;3:ClNL5wU6SaLkmoYC/JHnHIV61j9xbA0rUtKJmldzxaRece/sxMU6iIyi5pxtk4KePGSGC3KSYgf9Jd+TbP96KeXIqUXWXzBFSRnni4eWpJKJ4Fb9S7f6I4C5AFT70kqjRCT/CUvSV3Z/JdLyfSdF3ygddj1lj3T++3ekRlDTWp6IuiVToeWdEDkZ9S34Vzqhd8pJqB0V0h/DvT51ja8pDObH/EGU1IJKTuDyWC8McZijvQ9LTVGTIxmF2pAYsQU0l6U8tEje4bO0rnaG+c1FnwGQMOd2ToyZZn+yf9ppDwEQS1Rv1J8S1bNiODnuTP5dfLOaN/hsMQZjYywDKBwrBPn6EG+F9tAUJb/XKdwcKw4=;25:JdXo5yl4mu+91mKPQWxYqK5LEmoYVtNkQJlrM4nYb1+YxjLLPSqJMuHQaLnt0vcIUF+oWQkO/0XbgN4DHw1f/+rUFfu6Ch/7WkKRcb8lDsxm4RbZODAnZCCiux34r167HJk3OzTONomp/kQrW04w7tmS66wRHtYkMX9RLom+YX2xF0lcqfoPk5Ah98MuVXp/jzESCF02A0NzXGQdGyfKbgklWFVfTNHA9zS/gzCjmUpk1r7v9rDcrTp3+rCHZ27mKID401Drfj3XAB9FtZicwIjyRky7VyvZ3tRc2VHnVcci1FFnFTF9zNkukIPBnX2uKNZja6O9zY/XMv6pNCrCMA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4754:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;31:IFB1lAbtA9aXZTcCSXaBidG+tlE3aU19zDtr4uiCpzQZuJbazATEjJGsSsSllONsC/j7aRCmJRCvZ1gOdYT7N4ciCWhrUhmFy0KVWf/q9tMk249PfrUZqdbCwGu3uCoP0G9/e8IrPG8q+8/yFKeFnTyCO7v5YCoJm1qYMo/t/cXTA3Qp6zUh/P1oMVnXTSg6r/5070JUX91zvAyo0qwvwHrdU1dO/Xn6GiHKSMNjRNE=;20:rVYzdJwDbFOzPjYfpGdbbW9TdDcAWe+b0eDEf5pmh6qRQ1dBDOrojEAypTuGfNQ34RmxKGGlt1ZDk+yl8s9n1vvKzN7O7Oftjt1pLHpFcewGLVXKLWv4oP//hmNG+148lTheLPfheuaC9XydH7JTXdjWsdEORhJcLz4YH8difoouGpcJhkRwknCqdMbmaU/UAG5e6muYmpjDMrM9eTXA0DoXR32ZOEyeYd/LJ07/BPXG/IdAn0ReZGbv5xWbyQOi+CdlNOIlh6b6Uo27aY87mh9VptVP5bjIGmBBj65aU7jjXp73Vga3aT9Z4+fNwK/2mVyxAuG7A18oaDE04Ef3ulbxM+7tWYv3A5l598P4xr+wcu4ej1uA2fFv8oYbjstsk7bV2ekTZB6qgiOI1ZwJcwp/Z7wbaXM03aj/Tk4UDH33jYS72s3/Iws42rPQpwukJMA5+0Ws9/Xp5fCFfGvaeVhrq2bYCn0DLgPDXEAuwy2Y1/OPajPccJ5Srq7iJJxN
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB47548AA0D664AE95E8DEDF79C6150@BL0PR02MB4754.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BL0PR02MB4754;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;4:PqLYrNo0zczRoULZXC9wpCu7ykHHQ0ldxTmg72Q/qSQIixW20WjbG9qD4AYxhQWihECQMZeAXhZ/g7XcNcQET6lhE/vUjkBZVtWrf96fiiDnLQKjRcCSWMrgKOqPOXjqKmPBD3j2mgcf5oK9XekS/ZDPe4eEp21WexmGhouhQVq9LWhuYBLjLZSlG0K60IMqzmSai5Dj+AYrQI4rSRbqY/vZeeVSfDHoLDuWBOz8TVBujgvA2avAenr2aRM8IGXky1puQ5ALSEN3yirb2+aMfFrfg+H8cNpmIEbsclNSI0o8MSrijixex652CK7XQotT
X-Forefront-PRVS: 08076ABC99
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NzU0OzIzOkVsOGo3OWorL0JzOW83ZUFpWVBuMGhGZFBK?=
 =?utf-8?B?R0JWMkJlU0ttdEZWeTJhOUErR1BrNTJ0a1FMNFl4SFowRnMrUFdGZ3pqZVVQ?=
 =?utf-8?B?bmFWakxUQ2NCMlFKak1hTzFTSFJMcUdHbTJhQlMzNnRkZGp4TC9GUCtCYzht?=
 =?utf-8?B?ZlRZeUp3NGJLS3EyM3RhWDF3bVQ0dFVSNlBFZjd3WElnK2IydEpUckkyclcw?=
 =?utf-8?B?b3Q0VHVyblpOMDd6MlU3cE44b2FLMTdVYXRDMWVKM3FKRFlEd0tRTHNxS0Ju?=
 =?utf-8?B?MUVBZytWSkdQRklGN0lJUFVoMjlRUm1ZaFJlV2JqK2dMYWZZVkNLRDYwSitK?=
 =?utf-8?B?eFpjRE1HdjNjMGQwRUdPNkhxbGNOU1Q5Nzd4Q1ZzK3QrcS81aXJnaVREVEcv?=
 =?utf-8?B?K2FzVi9pUVlLQTdHVlpvUlhrN1liY0JsNXZDUzVhTW1sMSt0Q1I5eEdtTkt0?=
 =?utf-8?B?MUZIM25hYVU2ZGVQTnZkWlBJL284eVYrQVdhY3p2K3Q5b0E2dVUxM0Uvc3dN?=
 =?utf-8?B?VjN2bS9yOW11V1dFc2diZXRrRm1QQW1FK3NtVnV6bTgvTk9WQTFCSmIrMkpq?=
 =?utf-8?B?L0hJM3hrNXBTRzlIS3Q3dHVFd0pVbjZNZ0k3WFFVSk1RejBjOHhRZHI2Uysw?=
 =?utf-8?B?OWVaendLdkcvL0xZNGxyUExXVklGZ0ZydWcwd043aCtoa2dScVpuR1REcVFU?=
 =?utf-8?B?Q0hKWkl6WlYxRHp6TCtpZTZ1Y3dhcGdrbVhJVHBFc3V0WU56a2tpc1FFZVdr?=
 =?utf-8?B?UTFBckVrVlJtNlgvek9GM1I4ekI1K2NZR3I1TVhKYkU3RytTL3htTG1KbGdz?=
 =?utf-8?B?SUhHQ0I2SEIxaGZhUm5QR09YMEgwTXNPeUpNVXgyc1BxQXN1NEtWL0tvaVF4?=
 =?utf-8?B?WE02dmp4djlHL0ZDYzBKYVpuQXd1QTV5V1NvYnRCdEJQQW9vcHdPTzhCUmg4?=
 =?utf-8?B?VXNkSXFUR0ZIN205aDdLZWVVK3FBc0Jnc1BxbXl6c2hHNkNsUFlqYkx2eTlW?=
 =?utf-8?B?RmQ1QU16dTRiN2E4aXJ6eFZ3eU1IT0xEd0lFbkREeWNkTkd2c0Yra2hBbGpF?=
 =?utf-8?B?UFNkQ1N6bnBwYURkditOUjlzYWxZL2Q0L0dEOTFDdDlOYktkd29Sc0lDcG5G?=
 =?utf-8?B?UUE5NkZLSHVtZmdJUEQ4akxiLzVtK0htdlJMcmZhRlJWNjlUZHBMUXRTSjFL?=
 =?utf-8?B?dDRNV3Y1WENkRkg2Tkx0eSsyRGxFY1c1SmdPOFVPem1WUU1qM0hBUUhZWVlr?=
 =?utf-8?B?VDRYd2RmWW9XMStIbFVUQXZ1UUtkWitaS2NHVzUzc1RpZ1ZCRytlK20vRjJX?=
 =?utf-8?B?aGlNTGo0TVQraG9QTG9SWDFKWkZRTHAwUTRnd2F3WkxiN2hhdDhEZUpmaE82?=
 =?utf-8?B?RzRvd3dXK0ljVVNNdkk1Nm1rRW56T3EvaDE4TXhZZ2s3L2tINUdtOGpBZjlk?=
 =?utf-8?B?b0hVVDk1VFlqYzVGeXR6bG5uODV6N1J5aTdoanQvTTNCZGJUL3I0VXN4SFJy?=
 =?utf-8?B?WHRZNWJRQ0tjQ0owSGFnaXFyMzRFNWt3cFBkazI1T1hJbFJrT004dW9TcXU5?=
 =?utf-8?B?cStsb0ppcVVRR0lKZmllMDZKa0JOZGdNTkp6Rk9FL0FXQ1puYVJCRG4wZU9G?=
 =?utf-8?B?Sit3YUtkeDcxWkgvQ0NjZ0lSRkZJWFo0RUx5QitVaWltSEdZNGcwcnd2NEVu?=
 =?utf-8?B?Mjh3dmZUZ3ZLQVZJbVB2MmlCUHhOc2tEejg4b2NUbkU3dGFZNE9tSzN0WWEz?=
 =?utf-8?B?eElPYUg3dGxDZDU1NDFuZUd5NzlXR2ZHM2liNUVndW1BTi8wU0ZtOUtnMDc4?=
 =?utf-8?B?a2x0OWNVdFE0THZZQTdFdGxPWWJjT1BsUENoTmUvOVBVblE9PQ==?=
X-Microsoft-Antispam-Message-Info: flMCzCf706OQ+h0dA4II+lQ/H5OP87UGEIy+s8W5Tb0ITRdclmVFCqHlj6nMdibNIdabvh06J3h8iwfxF2p5M7p6wmN6Q363t6KNJ0Vz8t4ZtQW2Vmn8EW0X5zQhfi/Rciro/Fb7sLe3M9WbeH9yLfm74o0cIeQUlmlBEteC0Sa9BVh54NoZUT6NBFBktfht3uOLO7ib860YA1tMXywzWQBW2EBEeuwvbAvc729I6Au9xDDBrecPbzeuQpg03iRB+MC7Aw8cvZeJ/Gn3CFLHMyrb2v55M97I1Mqv9ZylpUH0Aq+GUiN5yfhSJcsvoxfe7n7lzIjjdPGYggKGPCf3lqw5BQMSPItKTOtZix6OcBA=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;6:7eWNbHjJWC60u959wIzAYEcCanRq1aoSU1RPZiYk/x7Hzel9hONpxToruPsyTOXaXv5aGqcoh3Jauqz2onbJgUysbro4gIm86DUskZjSwrIaTsmrjI/K42+BLn8iEYnDUSXduGbz1+m7mrL3oPdidICOXXX3yhroY8uPzLmPU8/mfZXFuK4e9JcX09gryk5Ym2gPxynvJTQNSaH8VzE6RVRrX0kI5rubcSsClkf9uSJJVoSws2RPSmGkhb3iwWsXKpGysnviRaME35iFgjaLr7o2LsQyYm5JFgqnD0HziJoAYjVvFB3gMx7yAi/mVUaut6cQw2dCueFwJphWMGmFIWbTCfA4rKxf2ljrI+rM2UurE9yEMqmnEXUER8Qw0Kga5sftYtPVuYT6EIqHLt4yOHe9ZsXRzvP5ag53jbziaMfKNYNscmy4o+jE6VJ6ZmmWOhX4WfJWLhLh1rvtblXhHw==;5:dZ8CGjExRDTGbXzxtqwW+g+N8OwYzAuzpkw47/q6kTNL9Agep3SZNmgU/D8NRpMVis36ofDMF+jfE+6oxovIDOBVomnEONP29Ux5GKQGrTHFRstXVQxIo0xwbjbuIeYVQRwn7EtonDym1jm40fUnbNVzgwT+eaJD+ZHO5DOYdrA=;7:xkvQf0ULWZQGN8hZSDq0o6FQDjMllHyJV8socZySTE5SJUZoe+JM6LXDCsXdWdjwS5INjrV8V0gNbVCnUCaAHHl7EffBGQiJQ1nP+y43aLJUNTcHQxhbY20cLfQ6w3QNoUXVtxSx26OMaBYKab/Qals6/h7v41h4sxYTPb7YWB91XH7jhdTE1Rtffe4SB8ZQ3nAfXk9Z2ze9at+piih3uEb4XgqwW29aJReehSwsOie1VMLdTgXDwI1m7BzkQlOf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 10:43:22.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5335ade5-b3f7-4801-cb61-08d6239ce16d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 24.9.2018 09:37, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
>> For IPs which have alias algorightm all the time using that alias and
>> minor number. It means serial20 alias ends up as ttyPS20.
>>
>> If alias is not setup for probed IP instance the first unused position is
>> used but that needs to be checked if it is really empty because another
>> instance doesn't need to be probed at that time. of_alias_get_alias_list()
>> fills alias bitmap which exactly shows which ID is free.
>> If alias pointing to different not compatible IP, it is free to use.
>>
>> cdns_get_id() call is placed below structure allocation to simplify
>> error path.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> JFTR, for sh-sci, I used a different approach, as all ports in the static DTB
> can have an alias (if aliases are needed at all), and only DT overlays cannot
> have them. Cfr. commit 7678f4c20fa7670f ("serial: sh-sci: Add support for
> dynamic instances").

if you look at all patches I have done for uartps you can find out that
I am creating uart_driver for every instance separately.
It means that there is still a limit for number of consoles exactly as
yours CONFIG_SERIAL_SH_SCI_NR_UARTS but every instance is separated.

Thanks,
Michal
