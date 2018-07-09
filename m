Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EEBC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3FD20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NG2DK4nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3FD20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeGIMSX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:18:23 -0400
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:39136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932755AbeGIMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czxIn9BDsk5Po3ILV86keVcdTl2dBycAbEHyW/4Sbfs=;
 b=NG2DK4nIgPqZQdsd7g9Um5G08X1uOrwGVcuehwtvbUDQyDlBWcwakyYyptOvr43EritybRvfgKqNNk8RkBaAEz+zU0h6nGqCPuXm8HGTUcW/Zaq68zPzbi30MqVAWrjpApsHDXKFyeRYhN48yCRqQrDhRR+YXykgvmkLF05L6c8=
Received: from MWHPR02CA0005.namprd02.prod.outlook.com (2603:10b6:300:4b::15)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 12:18:12 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR02CA0005.outlook.office365.com
 (2603:10b6:300:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.20 via Frontend
 Transport; Mon, 9 Jul 2018 12:18:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Mon, 9 Jul 2018 12:18:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42527 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fcV7K-0001gF-HX; Mon, 09 Jul 2018 05:18:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fcV7F-0008Oi-Eh; Mon, 09 Jul 2018 05:18:05 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w69CI3AC004721;
        Mon, 9 Jul 2018 05:18:03 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fcV7D-0008Ma-7t; Mon, 09 Jul 2018 05:18:03 -0700
Subject: Re: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
To:     Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Will Wong <WILLW@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
Date:   Mon, 9 Jul 2018 14:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39850400004)(2980300002)(438002)(3190300001)(189003)(199004)(65956001)(65806001)(6666003)(50466002)(65826007)(5660300001)(9786002)(106466001)(31696002)(47776003)(31686004)(63266004)(64126003)(36386004)(81156014)(6246003)(39060400002)(229853002)(2906002)(486006)(44832011)(54906003)(110136005)(58126008)(186003)(26005)(4326008)(336012)(81166006)(426003)(316002)(77096007)(126002)(36756003)(2616005)(476003)(356003)(8936002)(8676002)(11346002)(446003)(76176011)(305945005)(230700001)(478600001)(53546011)(106002)(2486003)(14444005)(23676004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:RVmJBQIWfAjXKOGHXABAHAbNtPUkeRWzIRMSU/PDH+mZXr9JcB8SN2pZWwkrtgDU6uhQyyCkcvAvi2+DGFUVWJ6YISR4pkauWya4eVuHnm5j7dsgQInp+EAMRYBvzeNa
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52551d7-48e8-4e3b-d27a-08d5e5960995
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:HDQP3dSdxUwj9zISe28iUxIjO7wU25eVjyKuX84A6tmU7MIKrN3Bbm1RZ1NosKNyj7BqbTDzNwHH9wXOmFrBLSThbm1KppvkCj+sHZsixjlG4YVwziOVTRz5X6xUj5n1R4sZbHMW+gyG7COQumO4MN7lKqcdQkqGEWjiXjpKflKZB0gYttuJBw47ew/fQNGcMYxgY+aW/C4Hbbqi+qBe8Fl0JJekOlqqguEoKZnZW653MW+iQzOOf6fLumuDAOn/ef3Za31bws0lMOR9iMB88xKi3AGe8iUOFoLsev4QMlhmeb8E6yG1pRmbiB3CUvxlHKIHpCi9Hf5n6V3jh1j2gu9dQlEu0h/HHiMPY9THQ5w=;25:etPt2RXWlnA3KlByXC1dM4vg2UUYXaSkCpI0v34VyY66Ej5JrsmHz2ztOVj9mF8VlLi6c+IbiRBK8GXnpBgNWY+Qxap8Ym6jAtYysw/yQlSuNVImEZOCgQ9PCRq1mYBvXS4sAZEf9hGmHBgtuLI6nGX1STMaP0OPq5mmPVg+jBtJoRJfdPvzDUecnVt/Dcs5mRQEQ+GynOX1c9MHj3fYEHS0KMwr0qokV8VCU6lDnkiyS1pCDsO6Zw2C4XzV097OOU8p/B6y9laYLvvH8+DHyYS34TTJkpnV5TKnjzObf9WhPhycvdSThrnu64aW0EjWh8okfwSMTT+hbMxj710oMw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:IcOojBXVAj78Xpy9kFc5VP7NM30eqFQCcD/V4BeIZj6WZ1IEdsovPk2Jnq9p8HytESKuID30Uux1VXhKDBGDeome+krFFXl2Ve8UUhpjjqiCLryjd0WSzZzivIAyZyJUmo/cVctK8tShTgpo7+aYpO1dU33jUBPITrgNllfiUDfZVfHTmn+Sv7u01XHV6tth/gnFDCWk1obfOSc59Wq5ikXvGtzdAYhRjXjkSJTtUPI=;20:Fkk+noG30WtiTZVg6MGphzvjdLLQJR0jZ3/kdvI97FEw9cBlLD194VoxT7+ZJjJtGq+caDHViszBA/7W4kKUJ3NMsr3Z5HN1G0qM0xSe6JSIXZ0oaTK5w8xfmLygtmZGRIULVhBIfj7d4jKTjRBI0gMM4EkjD8qaRvgPH+AxYrBQFxbiJAY97eE+OE/AnBlfucoH3inTU8Xcyo2CfMzk/4X3FIsNOkOsZxGlgdLyIURSMpgQs1g9+7fDSIBF8PiFsgudGa+jIKZ4UuHzTSjZ/eVQrJvp/C95TJip7fPi484esPio9rEHM3MYr+87ivw44OfXbFs8Ew9s3PcxUIlaSRa66A9WBa4+RqDKP7lUjsuieFVOPjZ5b9R/TCWLp85xePpk+vEcwGgYNr5hraNETRFyTUvJ3gf8T+xLc/Rh8j9GMKvDeKFK5WTGVqkod5eu//MQJyyNDBI/95h/5Ohqo/6cFlQwZiLQj23ah0e1HGXdMFfV46TyxrdSWtKhHErI
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4449254011329C51A67359E2C6440@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:/McExQGQSPRnUVBDY+HGC+1XARkTk1B5vXvNuwccPZOwZ+nfOCS7Zc19zXuujsx4dSrLR66pAD6781x+9BiGV8j+utv+gzITP8fnTk0fkitc0PgZCMVszbEAAEgcwLi+1XdeJvrzR1p3mK6T+8YtxSqmKzjWWnNM0vFM1oXyrs9oeSwUWevffeqWtoTVLVnOzotoTftpaOPSyXAjsaM34CUaW8Nf/CuHiwhWpFZ0/12eqXN9u3YQ+vWh3ndetXtDgb5hFI+wvNBda0n4O2Hhhzn5Mi60NttHoncxdl1qVbesYXqMIO7z5karKH+/sV/S
X-Forefront-PRVS: 07283408BE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NDQ5OzIzOmVyTmFqVjlzWnU1T29hVzJSV2hTbjdLMXBO?=
 =?utf-8?B?VFpsRGxOY0V0S0I2ZXE1NXoyTnlBcVNzbGRZQlJhd3Nib0VuN0k5L1VGRjZQ?=
 =?utf-8?B?dlVVT1Q5OHVrOEVXVnVnbDg1cERZL044N3BWU0dXdUlyMmV4c1ZnUjVaakpS?=
 =?utf-8?B?UjFvWENMR1U3QWt2aGlackE0anVkYXJaZE9BdlNaWEZ6UmgvVHNNa3F5Y3FB?=
 =?utf-8?B?Z3BPRVVzM2hrdUE0SHFSNWpGWE9oWnpNUDV1di9sS1RPZTlOYjFVS21TWlA0?=
 =?utf-8?B?a0pKcStvQ055YmNaS0V4Q1pidlNUMVhSeUVsK2VROTZvS0JSMllTUktHdFA4?=
 =?utf-8?B?K1h3a1lxYzJlb2NwdVp3aFdOL2krWkhhYkV0aXJiK1E3N0xUbXJsUVlOWld0?=
 =?utf-8?B?WEgxc25lbWhKS0VScGdlNmdKbzBNWTM4UmRySHhOVkNZOGVLdnJRMkN5MGhG?=
 =?utf-8?B?SWxwa1Z2QktWSFp6RzJ5ZjFlelBIb3ZQZFZVRkZMVTB6Qk5KS1FTUUxZS1JL?=
 =?utf-8?B?UEdkTDZxc0o4UkhzM25JYW93MzI2dFlQVGRQMFNwRGQ4RGFvZlFtOFVuYTYz?=
 =?utf-8?B?eFJubEdUMjQzVm9QaHBWL2tFOFMwMnJoK3RVZVpiTmRIT2VxdVlUbmwrOVhS?=
 =?utf-8?B?OFBBYk5BTVpsU0hRL2FzQUhpV1QyK2c1endBeDdrNHloNU1XLzVVck1nRmtm?=
 =?utf-8?B?dzk5UnNlZGE5dXpSNTlsemt6aysvYUZtYWxXZjZTSlIzRE5rN0YxRHQ4ekZn?=
 =?utf-8?B?UHFmWFdPbkN6aStLWHVoSllBL3UwV2hWbVhWWW1oVDN3YWZEYnJHNjl3WHRp?=
 =?utf-8?B?VkxEV3RUUnk2MmVxK0R3aXlkbjZlWmVRNEg5U09UWlNlM1QrVjdQQnJXbVVZ?=
 =?utf-8?B?amJOb0ZIekE5YTkyUVVGYWhxZzhPdm0zK1hYVG9MS2VJTWljTEVmV0pjVEhz?=
 =?utf-8?B?QW5MdUNtR2Z5cXVQQXdxYlE3aVpXVjNvOXptVTRPQTZBcWdKYTc3ZUI1cXcx?=
 =?utf-8?B?dWx4NWUxWExMOXQ4eVg0VG5iV1RWVWVTSHJ4NGQ1Zi81TnZCbXBHNDZZNmZI?=
 =?utf-8?B?djZwMUFnSE5LQUkxM1h1MWpMb3ltMVBaWlAyYXN6dUhBOFJZVUpmTFBqMTM2?=
 =?utf-8?B?Q2RCSmFYVzVsMnRkY3p1bEpJYmFNTG0rYmU3WXZiS3ozOTVFNDVpd3NtT0pD?=
 =?utf-8?B?L1ZvZW51elp1NmpuTWRZZHc3OS96Q3lwN1krYXZNN29ZUXlkVERrWVMrbFAz?=
 =?utf-8?B?Y2FVUC9rSkFTMWYzamwxelp2R0QwZHFZTGRMWUJpTlFRMnhpYm5lY2lGZ045?=
 =?utf-8?B?NjNhdWRmeHZLcW1iNFNIaXJLTTMrU1lua2dGTU41V1VtSkRGTldPUGd1bEJJ?=
 =?utf-8?B?a3JFTC9HRFA5L0JwQ2dQK1BBVlRlQ3NNT0Q1d0wwL2VZdFpjV0ZyMng0Z1Y5?=
 =?utf-8?B?M0J5V1Jjb3NtS2FyR1o5R1JWYzFTdzNkcTU4TTZRZUVidFhPUEU3MUpqYmEr?=
 =?utf-8?B?a2pvN2xCQ1kzQWZSeDc0Mkk0cXg4SzZiZlpCREdBcG4vVktDejlNbmhPZWpw?=
 =?utf-8?B?dVdTZDdLeTdQdURuZ0xXTUp4djhmK0JtejIyNG9TZmVKNllaSE5PL05NbGNK?=
 =?utf-8?B?VzlIYURTclk3TTBPc0xFODBKUnhHNUNNcU5tOCsvTk1jYkFSUjVWdVR6UlFt?=
 =?utf-8?B?azlLNk94ejdmNkNVdTJZUkxpeTRsQ1lnQzlxbUdrRjNTRUFJQnVQY3Faa3lO?=
 =?utf-8?B?ZjNzd2VicGhTWnlScU40TGhzbXA4NDhsbSt5bnhDbVZ6M0hkejdTWnJwenRp?=
 =?utf-8?B?U3QxbWtZT0RzZG5iQWp6SnN0aUFyU3Vva2tDbG5JM2tOR1U4OUhER3VRU1B3?=
 =?utf-8?Q?QM5dKPN03Yk=3D?=
X-Microsoft-Antispam-Message-Info: rxiPmKCJIWRD3rvXHFQRZnZV2MvSfL3VF7Fbj71Co1eeSo78xsJNcMdYQJETFStwJdTYGpaAo+YeI9pr/rTkbCEKSUUb4XGj28QcmRbYebtv1OlQYuV+SoTAdBhhl8W27ihLc6do8TchoafPfmpr+iogjMMtDJ/gBiaeKvvf1nptXwNrRnyWVfrX2/C8UnHVuGVDOIofLLcRfAJCpvYJUdUdkLgVYPgbw08ZX/TVe2CQ/cxlSPpxni7JTbYa5fGTNN1toATXraPyuv5XlWxHyn+L5ToLQWonPbIjwhG8nJxCcPXo2DbpucWpgZ6n3hsH4Mjqfc3SM7hfxzYl6/tfl9Yhij+/v6839zuG293G8dQ=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:mAuEByr3PyYGnSPYgp71FpiiFTsFA7zjlVEEmlIYIWPtHKKTP4njX2lyGVrguRRf3sVSG9sMx+3chYl4rphTzTEUj81tilcQ2HqqwAkKehcs0W72H7HRziR8EiLGmMJh8mkV/lD6d+F3AtIe6jobdmzNVeB9kQrrwNbNHQDoSR8PWhj8FdqRCzNkjFlcbnjAavUcADtvjHqh1K2t4Qm5jt9RfQ+JW+uITA3Cr4sxl8BCLd9JBXejiBLVc5Ea10noO5K+3efyHQh5Zamv4/M51yCj/opIr/VIfC0sa0Cin1j2D4pwvQQ0teENEkw3bCMtWUGpbZNoyG62Zh55tpzVkmOHtOiG6PG4gzCdvH1pfZlWMSG3bFsPZPeI1bjkWTY7Dl4yoeoHilNC13G6R68RvJGVQwA8SBoZWbtAc4gp3qgkZhDBKqMl3dGHprlXViXTanNPxEjoPNb85V98JQzSaw==;5:6pK4wHWqiyk0xMQysBHkG86GIqMXyxTj8cCBy3dHvOlw4HuSX0az1X4qflEz1iuztZn74aeqhqbw3nMDiKXSSySFyAcNoV2wxFRKYip3ocUIUHtDly7MI4P9d7lE/m/tOLYJ1AzeWiPIOt/C0PHKOe7fLWzqykrRbcDGfC/MLB8=;24:zHMLyPiaBOk5iD9/zVfTjUAQ76f8gFla02YAu0z1OIq6jJGtu1J7IcYq/A/OnfDl2V7oECc23C2/GWeFNaegZ/CBHQ+WHBD5OovuPiWWYR0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;7:BqGfKGPUnkLnpG80Qk1kQCnrVvyln1lpU77KFgQsQTztZ/tWXrlzOetVczV9dxCus9cx8lfr0k8FF0ajgyBfephqN7+tx0kK833eHxEo0lXVE8iK33f0w0ewmRIswUDaKiwcdBUt7HebVXOHgtk27XiKfEmNkaQYqzROx9opa/p2HuX2cbl5mNpOq8bmXTE06F7kX6c6iv1n0FY9Zd5YES9CyaiM2Sk3crn7EDDugDlJvC+aB7cDRJKo6a+8K6S+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 12:18:10.9118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52551d7-48e8-4e3b-d27a-08d5e5960995
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 2.5.2018 12:30, Sudeep Holla wrote:
> PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
> where the semantics are described by the PSCI specification itself as
> well as vendor-specific resets. Currently only system warm reset
> semantics is defined as part of architectural resets by the specification.
> 
> This patch implements support for SYSTEM_RESET2 by making using of
> reboot_mode passed by the reboot infrastructure in the kernel.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/psci.c   | 21 +++++++++++++++++++++
>  include/uapi/linux/psci.h |  2 ++
>  2 files changed, 23 insertions(+)
> 
> v1->v2:
> 	- Added mising static anotation to psci_system_reset2_supported
> 	- Added missing ')' in the comment
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c80ec1d03274..91748725534e 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
> 
>  static u32 psci_cpu_suspend_feature;
> +static bool psci_system_reset2_supported;
> 
>  static inline bool psci_has_ext_power_state(void)
>  {
> @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
> 
>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>  {
> +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&

I am curious about this reboot_mode setup. I have grepped the kernel and
reboot_mode is setup via kernel parameters at boot time.
Shouldn't user decide what reboot type wants to do?

Thanks,
Michal
