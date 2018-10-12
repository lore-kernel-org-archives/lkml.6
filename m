Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3DF2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Fmip7gx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3DF2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeJLQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:26:48 -0400
Received: from mail-eopbgr690040.outbound.protection.outlook.com ([40.107.69.40]:63611
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbeJLQ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L93aL3m+gZ+CQ3BgiCX45NETn3Y5HKYnKITRWLGKsrE=;
 b=Fmip7gx0RgC5fBE9X1J98BVol+zeQbSHnCTEkOCjQCcjc3Fto45HD7B/vxdu93XRpf4HD/E4UUVidy23YuNrVtwhW5CcKqpbXNSFnftODZ0BqEf8wV2bxP2uggIKcHjAdmsIt3ps3hgOdKakil9ET0/bfz+vpA1W8mQldU6doTU=
Received: from BN7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:20::30)
 by BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:57::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21; Fri, 12 Oct
 2018 08:55:19 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN7PR02CA0017.outlook.office365.com
 (2603:10b6:408:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Fri, 12 Oct 2018 08:55:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 12 Oct 2018 08:55:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gAtE2-0002So-RO; Fri, 12 Oct 2018 01:55:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gAtDx-0000lW-Nr; Fri, 12 Oct 2018 01:55:09 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9C8t0Wl030508;
        Fri, 12 Oct 2018 01:55:00 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gAtDn-0000aB-Qg; Fri, 12 Oct 2018 01:55:00 -0700
Subject: Re: Bug introduced in the of_get_named_gpiod_flags function.
To:     Linus Walleij <linus.walleij@linaro.org>, <wzab@ise.pw.edu.pl>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
 <CACRpkdYQBxvHh-AfODddzc5G+BMBhUBSRXUdLVO8_99yniUYPQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5d33d03a-5d62-c8c8-c9cc-2ccbe1b464f2@xilinx.com>
Date:   Fri, 12 Oct 2018 10:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdYQBxvHh-AfODddzc5G+BMBhUBSRXUdLVO8_99yniUYPQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(229853002)(8676002)(966005)(4326008)(6306002)(126002)(31696002)(64126003)(110136005)(47776003)(106466001)(2171002)(478600001)(476003)(58126008)(486006)(11346002)(426003)(336012)(36386004)(2616005)(356004)(106002)(31686004)(63266004)(446003)(6246003)(6666004)(230700001)(305945005)(77096007)(5660300001)(316002)(14444005)(36756003)(26005)(53546011)(2486003)(50466002)(81166006)(65826007)(186003)(8936002)(9786002)(81156014)(65956001)(44832011)(76176011)(65806001)(23676004)(2906002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4454;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT063;1:bS0n6Ree0xl2n0uqZRRO47pslbz/H0GX4YLKu1VFnMYnEibE8i6fWaUHQXWUCP9O7M1ob0E3hS+GDEcI8ZNQtGO30j73mlAu4OkxnpjhfVsI+FSRtUHQB1/VS3q2C9fi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed9a657-1ad4-400f-5c63-08d630206f0c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;3:MBBuu/DkYdwUp88QKyl08UP41gx+u/3dKEdxGZNuihAE6VxV3CbwXEoxYbHQJFQHCQkI/k5IiSUZGOzh6D3cw2umErxlv0CfnatCcBXr/iE7fxFpNmIWkNGC5MxpnYGz40J/OeM/LhM+Xjx5S8msMbO4+SOJIS4RknSCCP6vSI/oFcwluzTzL2f05Nt9jvjek3wOo3Xk64OsbY5RXqBO4MWJWCVYRh7RRMd5winDP9nMe7Bdcjcgz5fUSZj9rC6o3CPRTv2J7sSP5ULyJvgnpGIsG6Oo/WxhYigcwc2IKeWlK9NEw0mV7c8J4BC39xSA1O1aLbbdEzztnZFwdZq1b+Vjfo7e0MiolzDuqdgadY4=;25:lPF3gz+lWBaoUR6+o8Eo7U+Xn/XPJVW+xCnMnYAalE0xV/87+yfytSlfMG1yFaapZfgVKB8fd3XqY0PYoOZ/tHW8zEThSJcEui0LeBr62Ccs5SdFQYFH0uDPmxymKY1OFkChCUNjaFsyg3tpWLF2gtNXiU/oLtnZoK7CBPRoiO4ZvHn9YSoY6g4qcakjLF6JhLelq1bypnK8BGdLont3cIuyugiRhGVv3PhLywfCeAtv3DKkqNlL2O2PNwOQ3M3n/hfMwORKxaBXgnaSc5iMlhlGcw5Xg6ZwMJ08W8/0zq9JiZBiDEuHDHXvF9Bn5xTArVcKijkzhRu3wxq3D6+WvA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4454:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;31:mAalKKgF4KyJL889NorNEuPwAGJLgRUlLtkh0+UMWajaviKXhqbo11FqHFwlNGOjypbNjshey6FYgVGaYb9WUs4GNij8kH8nBvGYu+d4TC5y2dZZkLTs/iVnglkhhJzzauEFMqUiSTg7k/cPGSo/swuKYV4ARhtxc3rQZgMN00U722Vsm1bjGQU05sNA+Tyce3yrRgQDgZ4X1xZ7keCGZfJyCZ1dEwh9oMrkc3xY1MI=;20:xuLn/7j//KxpCS+CbyIMzHc10RLKdHM/IycNvBcfVtuMBo+yniIDv8Wl8s2DDLRtEYht98S5n3lMzgN+2r5aUnzjnN4VzNC0Hj+da5Tu8cZVEE7TlCWEcp7uQ3li1vtr2HIUSWFd59yX5qyOGnNBdVTS0l6LjnYw/+oRDqd5w3KUHBUrP5UTjX5bC+QPDrMgIPdl4KuG+ROKp6etmJ1T8uy2V002R6cdpqo4q2oOIWz3Vh+jtqSx3UXuzWn+wyfSuiUv82Dcr1UlssuKDvg2eAe84z9+xd29YY/mySL2KzSOVu4v2v9s63o9ojUiIAv6Myo2lYoWaghxUkkuxUOsQvmhgXTWvqZVPFsX6o36DiQk4l/3B/ZJ3DaVADOUILYU80nrPPsALLKZpAd45wCxB4h66+q/sa07kXlOM9ro79c1T+714fsY6pABNnferDBcIGYj07FYdEhyJBFv798b3QibdhFDTxot3yBcWBhLIzrVcIBFLrb8+0vSy14CfSEs
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB445435BE9CEEDAAFBD96B537C6E20@BYAPR02MB4454.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(70909801108024)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:BYAPR02MB4454;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;4:Rr2HA7+1ctlpf4qinlT63vL8dLz0IugAAi9+hgsqlHbYD8pxL4X1S6zM2NMAFJXJzIIbWHR3GHwE80OA/GB3FgEUcAd9bYQc6IUBdvsW4KgbuL0wean4oPfRttButwcMcc3yOJ6uV/3irjXKFitwrIXtXUEurrGRE9p32yHiZCWm/ewn4j2Rg7IeKaZTAETfo9vMiwhso4mfRfCqrWzlpQd0yAmStlTf3heLpFwq7NExM4WbEGaX3iBCC4KIZ3A3xPFbunON8+FPr2Kw8xM4xyJtuZYt0ASHhi0g9WHBl6u6CuTkepUWz3vvT86zLoP1uIdqAK6UIWXz+AP20MvKEL77lOYu5GxvMagc2rB3CzrUkfz/piTN0NKIqpiIIVUn
X-Forefront-PRVS: 0823A5777B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NDU0OzIzOm03bWQ0VUtqRnNWdVo5dWVLczFYVGp1TzVr?=
 =?utf-8?B?Q3dzK2pSeUN6aXBnbG1WQm04ZGpDTnVhaGh3bVIxOW1yUDM0N3FKU080MTFn?=
 =?utf-8?B?cVFmdGtzNnZoVUhkZTZRNGlQZElpZ25aQ2RhU25Ra0xkM2cxME5oR01OZmhi?=
 =?utf-8?B?QnZjTXNpbmllTHpBTWtEZmhWZ1puNFFkd1J5cjcyWWI2MTN0S1RVakNlUmVz?=
 =?utf-8?B?S2l3SlEzSENteGM4K0FVU1gxNGpDaThjcEFtTkRrL2Q4SUJKU3ZlZHlLaVVY?=
 =?utf-8?B?cWFicy8weFFOMHhNNUN6WWlxdmlUbmFvWjUyQTVnVEgwY3RkZUNYU2tJdE1B?=
 =?utf-8?B?ZllSS0NFeDVTNU9HK2VUcFlmcWdmSlFlZ1lHc0tINDBaN1BCVGZ1S094NFRa?=
 =?utf-8?B?eFRFLzhvSjY3R0lCUmVCeTZqSnVYekpkdDF2T3Jzem9nUEV2SWJ4VFYyYlZB?=
 =?utf-8?B?ckZNeXFqNW9NUEpqWEpsblQySGxkUmUxT1BJcTFnSlV1YTF5cS84N2djeG9F?=
 =?utf-8?B?VDdoeFJDeGdnTDJ6elh6bngvZEtQdU9DREJIQjNjYmRzOWxVN2lEVkh6cW16?=
 =?utf-8?B?Y3AyWDZwRUZQZHp4MGNlYW83dzlxcC9FZlQrWE5FdGY3ZzVWVWkxNWxjZ1Rq?=
 =?utf-8?B?dGp2UFluMzQ3Qm5GSTI5QktmNVdkbmVwQXFYdlFsMGZxczhweWhqWVh0M2xG?=
 =?utf-8?B?TUFtbDRPSXBmL1hIb2dac3JtZnI4andoVG5BaDBNR1VQaUZSWHJ1Qk9lNEtU?=
 =?utf-8?B?NFNoUmxzZ2w1QlU4L1k5RmduUE1Eek0rSFhmcEMzK3RmNnFhWUljOWJQT2tT?=
 =?utf-8?B?ZzNHU2lhMzg4OE9xSGxEeWUyMHNqdmRyNVBENzVQQWhZWTZKOFlhbTN2enBY?=
 =?utf-8?B?M251Sk5tajFwc3ZoTmxUQm1xeldFbmxTR3pHN1Fyc3lkb0xpOXFHNHd3OWFZ?=
 =?utf-8?B?bDZ0aWkyK3g0SlhGYjhyZUhpZmFHYVlYeWU5NWxOZUxYc3pqaXcwL1l4U0ZE?=
 =?utf-8?B?QkVzM1d2WklNcGF0Q1ZqWi9oTDJxdVlxendDaG5FekZkSTNub2U1WDFNUEx2?=
 =?utf-8?B?Rk1kcWhoRktVMlk5L3I1S2liS1Nza0tsY09WbjA2MG4reGZENExFMVQ2WXNX?=
 =?utf-8?B?bWZIUHNEVW1HQVJuajQySzFyTWgwTEVyS0J4WU8yZjNUbHZCbkU2MlJ2ZXQz?=
 =?utf-8?B?Tys2S3o4K0c2T0t2eWRoU1gxcEVROHA2K3FXajRzaldkNXZUYnBLUVhDSjdO?=
 =?utf-8?B?NG54ZmlpUnVKL1I5aEo0NFJQQ0NGODYzcEQrWm02MDZmUSt5clpCdXBJb25x?=
 =?utf-8?B?d2JVYjVoNFR6OWlkd2NaMHFEWGxsSzcvb0x4K3RTZmRoZVZNdU90V2tRUm1H?=
 =?utf-8?B?dzlZS2pDVHBHUXppQTJyQXp4aDltbmF5V0FaclA5NlhTckdxSmc2ckw1azBM?=
 =?utf-8?B?c3dlY3czSDNPRUllNTZLS3c4TExvSGkwV251RFdWOW9kRWRTdkxpMDhXZEhz?=
 =?utf-8?B?UmFOdS9xdFZvS29QOExoZ3NIQTJvZlRuSkw3cDFkc2FsMW1Ka2UyeG12ZU5I?=
 =?utf-8?B?c2V1dHJFdEpPcGx3ME52cEh0c3VLaGtsbmRoWS9mY0Nvc3lNbWZJZXVadnlN?=
 =?utf-8?B?L2pxNnF1QllBQk55enAxeXNZQittZ0ozbnJia3dEMU5KUXV6VDg4a2oxdjlo?=
 =?utf-8?B?QlBLV1VEenV0bUVZTmREYzZTRDZVT1A4ZkZBK0hzWHEvN1l4K0NhTmVyWGN1?=
 =?utf-8?B?N2p2UzJxMjU3a2gxMmNxZkMzK204RU5Db2Q5WjdNcXEyZnl4d0c5SHJxaXFO?=
 =?utf-8?Q?CYPO+pBBc7oA6?=
X-Microsoft-Antispam-Message-Info: M6ljFeMrU7KCXOM5ID9LEuHk55+G8UhwjXdzCtEfqu1URdZW3PACoBE6CvG3BeDnJ0YLiOe2pQNaMwbGW9GNsxU9kEFSlb2mEL1tw7ZnxTvN9ctWWI5Qdn7Cs0iBv1sdyWLd7PxiboXI6REUvhc1+mv1yi914nlekx1ejKHdMw+1no0+KdmceaRjtiPCWSrW/U0eAe2bhNfiuK9P5l28RzjEntfFO3uaJBbZQuv+vJPXH9tAoBD4B6+rbXo745RnTbsJWBd0ifI7O5tLk2DlfHwezbU4AEMZaIiv98mUG8Mrkisse7UodZFJGxJx4hj0UqRoHvO+7wy6APIWtNmrxly2OZdu2MMBJoAtZEByNIQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;6:1h1H6lac2TY8+Q0/VemtWQqdebKzFiThQl6cA7zuXX2vWQy0oYIyBBeB3Yzsor5XPjCZJZFCH2VP9FwzK5rBKyMxWRdTz3/TIA1DhkeCZWRhbP4RAALhdgDNqiHsGddYu5+J4B0ayxxUVmoExU9WWa2VaGyoujOt2CjYmMhF3s7VH839YSCb/d7HeHjMUe9mnimAAu89RZs934ZhrwanmitLmE0amCdtUjKKvY9dP7/V17UW7Dx/3FZz8t/0NcHutkAaG1LQU2rE9EY/Jpf4cY4BAttxOy6mVvzC3NYtxs+ORqNxRqs8KrGopgvlt2h/SZywZg3mA7cUT0mYDROKOLHvRiPqkYZ2bFMeGgovUnOlzFZeEae02dxYiFesbwOVc+KhBCCi0+J+4p8qv+C7oJs08SOOicpxCYguspKwYTUUcvTiCyOfqPW9J1I5nwBv2ioTiFyoc+7nQEYhpjo2RQ==;5:qBeOgIM/VmlgJG50XIfR94FDUjFg+BGGa9OyInT/eZnC5QrnYGIVSrlitVekxLRH/QOED+M4BM2Wepaw3JkD+yrQOJ7OwT6bMUIkCb88CLKPCLt7K9fN6VGgMvtPMTf3rADDP/UweDXJKOUsmv9Sj6QVMi8QohJ6cvMhCAOPua8=;7:F8tufJ7BUdLNtK+qx2A3/Kl59YOYUkf+N19qUNLqqdFqfPtsCuaUnxs6NZc7Qefa6FL2yih4Jz38HgvzweOd5mZ2nkWNUBUaCkJAOS5LHBiy4NWndc0WlvovFxo4zphWdTU6Ov4v05L0LyV7cVk5rw/irXkvaEBPCnmZ8tR9m5oUy/vjQzCS2F7SUZJ9b5RyqCVR1InIkl9eTywBIDHPCQYMkl2KzemJJtKaK39ie2ge9hSxjzJUZOCXDFak24WW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2018 08:55:15.7327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed9a657-1ad4-400f-5c63-08d630206f0c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11.10.2018 10:27, Linus Walleij wrote:
> Hi Wojciech,
> 
> (Thanks also Randy for forwarding this!)
> 
> On Wed, Oct 10, 2018 at 6:32 PM wzab <wzab@ise.pw.edu.pl> wrote:
> 
>> The function of_get_named_gpiod_flags in older versions of the kernel
>> (up to 4.7.10 - https://elixir.bootlin.com/linux/v4.7.10/source/drivers/gpio/gpiolib-of.c#L75 )
>> contained an important workaround:
>>
>> /* .of_xlate might decide to not fill in the flags, so clear it. */if (flags)
>>    *flags = 0; Unfortunately, newer kernels do not contain it. Therefore if the
>> "xlat" function in the gpiochip driver does not set flags, (like e.g.
>> the Xilinx AXI GPIO driver: https://github.com/Xilinx/linux-xlnx/blob/c2ba891326bb472da59b6a2da29aca218d337687/drivers/gpio/gpio-xilinx.c#L262 )
>> the random, unitialized value from the stack in of_find_gpio
>> ( https://elixir.bootlin.com/linux/v4.18.13/source/drivers/gpio/gpiolib-of.c#L228 )
>> is used, which results in random settings of e.g., OPEN DRAIN or OPEN SOURCE mode.
>>
>> I have also reported the problem in the Xilinx forum:
>> https://forums.xilinx.com/t5/Embedded-Linux/Bug-in-of-get-named-gpiod-flags-function-in-the-kernel-random/td-p/897695
> 
> It seems the commit removing this is:
> 
> commit 762c2e46c0591d207289105c8718e4adf29b2b34
> "gpio: of: remove of_gpiochip_and_xlate() and struct gg_data"
> 
> But I honestly don't see a problem with it.
> 
> You are referencing an out-of-tree driver. Use the in-tree gpio-xilinx.c
> that does not do any custom xlate and you will be fine.
> 
> I looked over the driver doing custom flag translation in the kernel tree,
> and they all set flags, so this is not a problem in the upstream kernel.

There was an attempt to sync up xilinx internal gpio driver with
mainline by someone else but not sure what's the status.
If you have issue with xilinx internal patch please talk to us.
If the problem is with mainline please use this mailing list.

Thanks,
Michal
