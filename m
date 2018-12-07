Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A782C20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aF1VKYJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A782C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLGPUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:20:10 -0500
Received: from mail-eopbgr790044.outbound.protection.outlook.com ([40.107.79.44]:15280
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbeLGPUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+2jUgac3sjXd0Ijupc42XRmz4KtR9XnznhFGxeH2tc=;
 b=aF1VKYJuE/PzHqI6a42I2Cj41RLgqFc8QCqFCUdONC9dJv9MIkGwspmu9ABL2BpVAa5kP2sCat5PG8wnqk1BXmkXVQEGebAzA5NUkVuLMnwKw/WF973Z7HXXTBobAqhl5QEqLKYDPCUvj012I+yXi6XZ9t6nNdZBiKOONSYSGb0=
Received: from MWHPR02CA0003.namprd02.prod.outlook.com (2603:10b6:300:4b::13)
 by CY4PR0201MB3507.namprd02.prod.outlook.com (2603:10b6:910:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.18; Fri, 7 Dec
 2018 15:20:02 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR02CA0003.outlook.office365.com
 (2603:10b6:300:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.19 via Frontend
 Transport; Fri, 7 Dec 2018 15:20:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Fri, 7 Dec 2018 15:19:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48295 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gVHv3-00044E-Az; Fri, 07 Dec 2018 07:19:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gVHuy-0001X2-7p; Fri, 07 Dec 2018 07:19:52 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB7FJil6008345;
        Fri, 7 Dec 2018 07:19:44 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gVHuq-0001W2-6T; Fri, 07 Dec 2018 07:19:44 -0800
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot
 images
From:   Michal Simek <michal.simek@xilinx.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <monstr@monstr.eu>
CC:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <19c7bdab-8df8-f7c6-7921-9a4d43dbca64@monstr.eu>
 <CAK7LNATWSNqZ8uE+teMW+uvDCLXfq6zMTqh_7=ssrPquCLJz8A@mail.gmail.com>
 <938f1368-5e07-0178-5b99-d8331ce216f8@xilinx.com>
Message-ID: <18fb7c8b-2b47-eb39-d80b-7137e7db466b@xilinx.com>
Date:   Fri, 7 Dec 2018 16:19:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <938f1368-5e07-0178-5b99-d8331ce216f8@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(189003)(199004)(64126003)(186003)(26005)(77096007)(65956001)(50466002)(356004)(6666004)(93886005)(9786002)(478600001)(316002)(65806001)(54906003)(8676002)(8936002)(81156014)(81166006)(110136005)(305945005)(36756003)(58126008)(229853002)(63266004)(31696002)(106002)(53546011)(44832011)(5660300001)(31686004)(106466001)(476003)(126002)(336012)(426003)(486006)(4326008)(6246003)(47776003)(65826007)(107886003)(76176011)(36386004)(446003)(2616005)(230700001)(2906002)(11346002)(2486003)(23676004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3507;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT011;1:UVxpVSrjOkLOvtrEp/GFXCSGydtiix/x/hFV2nJI8KtzePr+AjmuO2MgdQzQPRWAQU8pOOEQbfrX45lNUo9QnXZRtEqptPN2iuFy8AHEryOrc1ghzmZTlIr5lmVcQDVX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0915dc9-3b85-4df7-f434-08d65c5774c3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;3:3lESShpB5gwhoxQ0nJmlHfDXdbm7dospVpcWP00ffZtQPcoT4JrAToFH8vrHMfOEZAgo6XWiIhhY2UFOhAys2wAXiLYvW3cZzswJi7pdgs4gmT+tHe1PFitIfAWPBJSi4ezg16v0fjZzE6Rt0dFIvIiJhgB8FqBiWajlGbmd15HDzemEUDIr7XqCJOlP/dK0jmpLvWX/HtrRxyLiWXM3pVW9W5k2bgEzXAZ2eqYTx7CClDryqxiK88D3SffYFOhtvJjH+zv7UY50uGQBp8gE8XYUzkYk8pubBEZI3JLSL/gZjKUjHm7QsLWspwK5guNxWbprmLqv3vu0JUPbXdmug5/PvU2CLs6F8s5nC4FZSIU=;25:YvBoD16jELnJQ+UbX9RjZ/ypbKE4FyZrggd6oQztq4MkhSgO9zmqQcA8A91lTZgv6f2zkPFR3IH21VXFKcgg13lfEUuEdDO8Rbtb0o7NmGIu5sCIFmlAP4k5jKAjR6P+txLbhiD1xWYpyOHZG8a4c0DRHDMre+88H0BZXND9QNWBH2QxGO4LYelnUE+JMy9t6m1ubg0RFitR9kHlFKdc9bkUKnXPJyN1ETehXFef8QvVECWM5V3a5yS2hN0ZH7ZaKFdnsYRuFM0Vu9VD2feZP7fTNVsfIHU0asXoyMp3qVcG8Xfr7L/YWtsfLPtNwzp5hisoOlUNx1mR0U8NBeMZ9A==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3507:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;31:AT4t696Fh5Pm1dovGGzsNb/M0szc+ux4h3sMdqvhz4yx6vHLxvondkaAk9ichzwhbXVCuZe+yi5xAUp3FaO7KZOkW1pSFO10mmx+0OtycmVJHAM70AJa5tVZxaA/QwZhLb+aC+RpZt3l2dtCLDOs/4jX8KzoyvO99J0egTNLYxVZoZVcKhS296pfjSuFNdH3ufX+lk/7p2qnYZ/2Mklq85gw/3FYSl8YiRElKaee7XQ=;20:gdHLfQH0Vgd5U77B8BqHiivEmSTKtSfqOIHep2h2lQcTe3HP+6aIyPMhrewmGYAmqoKMGEmfc8FzQB9c0TeTNiQ+OhX4sqBqr64uDL4b2fh/+4yS24HG94kbVEJao4B7uK8sMjfHw7LPtm6lnkfRNHP9rJs0I10pCtpLYt4goKepmPer9YcA+xfAvUyX9rHkJeQ88657mYOjfexQfCc/MA2mPok1WP71bm7Qi6lODjtfCx5/DCWV6w8XxXa6aYJZEo+gQJF+qc65fAKKX5CHT3tciEKGVAKbaLW3tpxvYNcZsCi7LWAJxvyzcDZtYJqklKYQxM/0H7o6rQXit1uhCDkNAWqMDQQp7f0cmGYQFzAMtLSVzUJkQfT6Z5ADtYu6RTH4PVa3PxKMrKFQQBqJ9gDwBiznZbRZjp7aP1L6rTmQRKcJPp3HmkI1f1/dmPiFQolCdY+73XiM7phXWIqAxBKqXo6Td4wYaJ6IdmIu2UiwtqzuP2W8nOHPL7wr4qDz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3507E2FFEA95764D919C2A2DC6AA0@CY4PR0201MB3507.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3507;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;4:D9J9QgQX4o3K0Kt0wj+XToVhk/9Mt8nc0CNdmCLQTa3+ooWboVLl2owhU93CRE8nIItUTSyTwwzyKyF51S2cskhMeZklE6x3iD1J+bgq+RVPgWVRrhQDx0+IlDGVS72RKzu6jFo+oX4/8n3kK8haaOzJuDy7VMhN7ZvAvx72LP6l3O52Ul0JFHJTzO5g3G02znKQYKW79REtetda9gPMebolzoh05P+1X16rjBreNVgwDgg3QsGh2VKNU5MX08FGi6Ak5Te5FpNkOkk4175oYA==
X-Forefront-PRVS: 0879599414
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyMDFNQjM1MDc7MjM6ZlZKN0FOcTNDMC8zUGtQME1rbEplSVZo?=
 =?utf-8?B?Z29SRzhpQ1dkTXVEaGVldGczbmVTNFR1amRxakxRc0xoelFIalhIbXNlYkhk?=
 =?utf-8?B?S0doeHlYb0lQRVl3ZUNpSVkvTm1rR2VnaTZIRWhTNnFIQmk2TXdSdTl2Qm02?=
 =?utf-8?B?MGRyRmtORUkzNWxZeDdmaG1VL0FaZkNLN1QvY0V0aDFzdE9ldGg3SGt5TDZW?=
 =?utf-8?B?WXNqOWZZcUpwdDVNUmZzVUdBeFRTUEVteE9BTFVFd01xbXJEeTZUZ3F2M21n?=
 =?utf-8?B?dDNWRllHTGZ1V3pyYU13akd0WGxHQzYzdTBEQlZUaExuaGZDQ3Jsbk1NUktK?=
 =?utf-8?B?NzI0dExBOXpMNHNlYjI5YTJFOUZiU1lVakxFTitqZWl1bGE0cjlNSS9DdWFj?=
 =?utf-8?B?VXRGUE5zSGc2d25OUlE0N0xjazJYNitFM0I2dTluNnBzVDlDNHVEakcvY2xi?=
 =?utf-8?B?NGpVR0NGWFJseGpIZ0tQSVpOVk00K2pJVG9aK3dxSWxWRW83UXozU0drWHFS?=
 =?utf-8?B?Szh4bTdvbXZDSmRDZlV5a2Y5amZ0b2ZHRk5UMk01aml3aTRoK29VdHpONlR4?=
 =?utf-8?B?Z1JjNFVXbkFnRGVvS1JhRlJQNDBmR0lxUitNTU5ndXd1UmNFV1hRMjdsZGZE?=
 =?utf-8?B?MkJXQmpmc3p2QTlzY2wxOWUyNU9QYWxiVzhST0FvOThOMm1kK0xwOGh0ZDRi?=
 =?utf-8?B?ZU50eWpacGd2SVMrVTA2ZnhRcDFCK0FQdElPeDhDTjNNS3p6T0h4a2dXb3Nt?=
 =?utf-8?B?Ukpib1B3emhBV2tjM1g4Sk9Za2dITnpuc1lHV0I1YW00aWJ4TjVGb0RzZ010?=
 =?utf-8?B?RUlFbHFRNlY1VC9NNkswMW5iK2tZczZQdWgva2lFdFNReDNUeW5Gc0l5TktM?=
 =?utf-8?B?dkMxMnMycEhSR2tVSmxnQ2JyODc0Q2UyZ3A3RzJxUi9UN0pxRUVqOVJxYTZn?=
 =?utf-8?B?T0txZWN3S0t1aE5kOG1nY3hJWjZOWHlheWEvMzlFWXZSN29xS21xUzJSR1dY?=
 =?utf-8?B?Ylg3VlRTcVQvWm4wNEwzQkxvYS9sYTJNL0RRSEpDRnZaMzdubllMRmpCZXQw?=
 =?utf-8?B?RVNpem9hekVCZlJBcERHdTNqNWlCcGpRdHloMFhZRFpseHo1S2ZSZ2FWNzJC?=
 =?utf-8?B?N1Z2TWpaMEc2Vjh5MEh4M1pJK1hOVFd6SUtnS0JkRytKM3UwWExlQTlzWWJZ?=
 =?utf-8?B?bFZSemZoMDMvYlgzNFFkbEZkWERuRGFYeFptS0RKdmU2aGYxS2FURis3MjlF?=
 =?utf-8?B?ZmpWYTNzUm9naVNMTThQbEdvVWxSaDNTS0RvcUxOemd1NmY3MVh2M1A0RU9y?=
 =?utf-8?B?RExCZjJaRERHM2FQNHdkcDhqL25rQjFTUjY0UFFTMXlvUHNxT3ZYSlhvc3hP?=
 =?utf-8?B?SFcwRW1vWGNjcGFTd2Eyc3VnaFFYUDVIRTNKcWpGeHZTY2doa2RRYWV0cW9T?=
 =?utf-8?B?REJVbzRVVGtDaGp4N1orNlhTWGFWMmRoMHZ1bE42Q3NqTUhpNSt2UmlCbVd2?=
 =?utf-8?B?aHZJQjE5aUVjazRLVHdQS1hpbUVpZmpoMU5iSXFQTkwwT3dTYUhnYTY1YXVj?=
 =?utf-8?B?aEpsazBMZE0wc1ZVWVQzWU13U0VhelpWRitHRnk1QXg3UmhjODBwK3RwQmp1?=
 =?utf-8?B?V2lQcm5YTk81TVdqYTBvdCt4N3NQaG53eXZIQ0ExZHVzclBKSUtwU1RKb1RM?=
 =?utf-8?B?MHNuZFl2dW1yejhYbzNjcHFUMnhUOG5pdkV4a0Z0TzYxRjF1cm0vUkx4UWhq?=
 =?utf-8?B?aTdWNlZYclZMdXczVElYa0xybWhSd05BbUJkQWhsSzFOSEx5Vm9HT0lHK3Y4?=
 =?utf-8?Q?P6yUEprEpHhGfgL?=
X-Microsoft-Antispam-Message-Info: dWCkxtTL/a/1elD1cuplfZholnzppJYPHGk2NhC2nI5s6Bek6ZTE0OU9t+GX+Tg4WLWWK2b1FMw5syROGoQKG9bikXuym+qgxOR/2X01z6Tn8rfKBjlRx3GrJhvir7JCSWf4XuotOMnlszsOqGcm3Md8kXbxvklswgHctuJQWiKdeB9WihyzVtMRZwmHF+Qyi3tgibuYfIq3kjgOqph7H6fBlVlhqAkxXZvHeVtvZF8ZPLSMDOGdaU6Ol0litp773BOnnNHk6rPqSDPS9P2pjfCuVSRgyPHr4fGT4XWovRs9pidTlMkFRzUTbywoNTH1W4cToylfkM6LsrNmQDLxlAN9rFKdEhzzKa8Mdw1thdA=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;6:16J2xy4LssltTwoxooXRQcPcISf6TxLEIlPsbtGDDIUtfDtPE7xn8HHYkmH+4PCZKKWp7NeARTA1mhrvwqSdvaTkn0wQfUSybf1yyic6HgXcgEm9I+mL5JQcVFB8JQhSF1ccx3iyoP6VsckihXHfA/fo5RLIqGwZstpZXbnd1REU1oD5r/SwaBT3o6q6UEtnIoUd7oqTKy6tlkOc1jsbNyLfEoXnWkFMXq61nwSviVWObcBZsetEBhTdBunc/fNIeyxFgMW/Qwe/KSgwpFx2H4Z717k/P16SO/FtB4Fs0YNoq/f4kK6SwcFDnjLhNLLoXd0yqt4EJ/b+sowKr+iEW6Fv9bp6H94V9qBSzkE2Tw+HnyeVmHEeAC0ooXHwlnCYNiD5bQqaTBKCUD9icmIfWin//3zuW45tqhBu/ADTDvTfH9Lv8vODcOsRoGHyxlX+btHqRPxuKOS7cnfm0taXLA==;5:505nskExYWuh0slg90zlNxNjdt51VYG34qTkm/SwWqdXUTitKs5nZ/iOfzs0LeAZ0HNtHqlHD93pjEc9ccVW0xvfvaHbVwAdQAU0T3P/jh03k4t8vjyx0qr8HYx0h6rWcsJ5aRKuP2Ozvgrpj7zRxQlJqM6MWw6959pr8Fl127Q=;7:apqNFO3NsVoaSY7Jv2nDB3fcoLZFveFU4jIohelrUKafEPyO+XMnDiRkuirOm0nlOndfrIGreIspG5A8X2lZMDF3/40tf055icTG+FJgWpOEwBx7HkvTOySDOMm9OMMfoMj+ksxGEqmG+MoG90GEdg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2018 15:19:58.2599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0915dc9-3b85-4df7-f434-08d65c5774c3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 12. 18 14:29, Michal Simek wrote:
> On 07. 12. 18 12:29, Masahiro Yamada wrote:
>> On Thu, Dec 6, 2018 at 11:55 PM Michal Simek <monstr@monstr.eu> wrote:
>>>
>>> On 03. 12. 18 8:50, Masahiro Yamada wrote:
>>>> This patch set fixes various issues in microblaze Makefiles.
>>>>
>>>> BTW, "simpleImage.<dt>" works like a phony target to generate the
>>>> following four images, where the first three are just aliases.
>>>>
>>>>  - arch/microblaze/boot/simpleImage.<dt>:
>>>>          identical to arch/microblaze/boot/linux.bin
>>>>
>>>>  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
>>>>          identical to vmlinux
>>>>
>>>>  - arch/microblaze/boot/simpleImage.<dt>.ub:
>>>>          identical to arch/microblaze/boot/linux.bin.ub
>>>>
>>>>  - arch/microblaze/boot/simpleImage.<dt>.strip:
>>>>          stripped vmlinux
>>>>
>>>> I am not sure how much useful those copies are,
>>>> but, I tried my best to keep the same behavior.
>>>>
>>>> IMHO, I guess DTB=<dt> would be more sensible,
>>>> but it is up to Michal.
>>>>
>>>>
>>>>
>>>> Masahiro Yamada (7):
>>>>   microblaze: fix cleaning of boot images
>>>>   microblaze: adjust the help to the real behavior
>>>>   microblaze: move "... is ready" message to arch/microblaze/Makefile
>>>>   microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
>>>>   microblaze: add linux.bin* and simpleImage.* to PHONY
>>>>   microblaze: fix race condition in building boot images
>>>>   microblaze: remove the unneeded code just in case file copy fails
>>>>
>>>>  arch/microblaze/Makefile          | 14 +++++++++-----
>>>>  arch/microblaze/boot/Makefile     | 33 +++++++++++++++++----------------
>>>>  arch/microblaze/boot/dts/Makefile |  5 +----
>>>>  3 files changed, 27 insertions(+), 25 deletions(-)
>>>>
>>>
>>> One more thing I have in my mind for a while is that will be good to
>>> configure kernel build flags from DT and completely get rid of these
>>> symbols.
>>>
>>> XILINX_MICROBLAZE0_USE_MSR_INSTR
>>> XILINX_MICROBLAZE0_USE_PCMP_INSTR
>>> XILINX_MICROBLAZE0_USE_BARREL
>>> XILINX_MICROBLAZE0_USE_DIV
>>> XILINX_MICROBLAZE0_USE_HW_MUL
>>> XILINX_MICROBLAZE0_USE_FPU
>>>
>>> It means setup CPUFLAGS based on extracting that values from DT that it
>>> all the time match the hardware.
>>> It will also simplify all the CPUFLAGS logic which is in
>>> arch/microblaze/Makefile.
>>>
>>> Do you have any idea how this can be done?
>>
>>
>> I have no idea.
>>
>> Parsing DTS with sed or something would be possible, but ugly.
>>
>> In my opinion, the kernel should be multi platform image,
>> in other words, it is the least common denominator
>> of supported platforms.
>>
>> So, the kernel should enable all features that may or may not be used
>> depending on platform.
>>
>> I do not know if this works for MB.
> 
> Microblaze is soft core CPU where you can select if you want to have it
> with multiplier, divider, barrel shifter, etc.
> You can of course say that you don't have them and you have "universal"
> kernel but very slow.
> That's why user has to setup these configs which are converted to cflags
> to say GCC what can be used.
> And these configs can be simply parsed from dt.
> 
> For example like this based on dtb (quick hack)
> 
> for i in `echo use-msr-instr use-pcmp-instr use-barrel use-div
> use-hw-mul use-fpu`; do
> 	UPPER=`echo $i | tr '-' '_' | tr '[a-z]' '[A-Z}'`
> 	echo $i $UPPER;
> 
> 	VAR=`fdtget -t i $FILE/arch/microblaze/boot/dts/system.dtb /cpus/cpu@0/
> xlnx,$i`
> 	FLAGS+="CONFIG_XILINX_MICROBLAZE0_${UPPER}=${VAR} "
> done
> 
> make $FLAGS
> 
> 
> When simpleImage is requested dt could be parsed to setup proper build
> flags.

One more thing I found is that I have done these changes

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index bbd6968ce55b..dc6a6fee3ae2 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -153,11 +153,13 @@ void __init machine_early_init(const char
*cmdline, unsigned int ram,
 #endif

 #if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
+#error MSR is enabled
        if (msr) {
                pr_info("!!!Your kernel has setup MSR instruction but ");
                pr_cont("CPU don't have it %x\n", msr);
        }
 #else
+#error MSR is not enabled
        if (!msr) {
                pr_info("!!!Your kernel not setup MSR instruction but ");
                pr_cont("CPU have it %x\n", msr);

and run MSR with 1
make defconfig && make CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1
arch/microblaze/kernel/setup.o
it errors #error MSR is enabled
and all is good.

And when I run MSR with 0
make defconfig && make CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=0
arch/microblaze/kernel/setup.o
also getting #error MSR is enabled
which is wrong.

Is there any rule what can be setup at compilation time?

Thanks,
Michal



