Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90F626F95
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B/ixXtK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90F626F95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeF1GhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:37:07 -0400
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:51851
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751815AbeF1GhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrIk80/adq26UIH/dkV3X6BsMwROSa9CucowGHcXf+Y=;
 b=B/ixXtK6sU7qxk/KIxNKhY7m8Ctpp75LcD9Po3eLhl1+8Wm8aVt7hiP8rFrgZlp3V67W1dzskdlQhl13eburll7DHldcjI1DnjLiguqqYXoh8QPQnaxVFH03G41pi+a64beiLfUaEgn/YN9MXtimBpNU/rd84Z45wpG0xhWTgu8=
Received: from CY4PR02CA0040.namprd02.prod.outlook.com (2603:10b6:903:117::26)
 by MWHPR02MB2655.namprd02.prod.outlook.com (2603:10b6:300:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.24; Thu, 28 Jun
 2018 06:37:02 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0040.outlook.office365.com
 (2603:10b6:903:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Thu, 28 Jun 2018 06:37:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 06:37:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQY9-0003BV-JM; Wed, 27 Jun 2018 23:37:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQY4-00034W-GR; Wed, 27 Jun 2018 23:36:56 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S6atMA014723;
        Wed, 27 Jun 2018 23:36:55 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fYQY3-000348-4P; Wed, 27 Jun 2018 23:36:55 -0700
Subject: Re: [RFC PATCH 1/5] arm: dts: zynq: Set correct manufacturer for
 ZedBoard and MicroZed boards
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-2-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d43b1758-cc0c-3a19-0d7d-f4773fe5caac@xilinx.com>
Date:   Thu, 28 Jun 2018 08:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628054205.17737-2-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(11346002)(47776003)(50466002)(126002)(446003)(575784001)(31696002)(36386004)(110136005)(8676002)(2616005)(44832011)(106002)(486006)(230700001)(54906003)(2906002)(81166006)(58126008)(65806001)(6666003)(65956001)(81156014)(9786002)(476003)(336012)(316002)(8936002)(478600001)(356003)(5660300001)(106466001)(65826007)(39060400002)(77096007)(6246003)(229853002)(4326008)(31686004)(53546011)(63266004)(23676004)(26005)(186003)(2486003)(426003)(76176011)(305945005)(64126003)(36756003)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2655;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT051;1:AnOC3TLSKqyt0i8U4IUhrGink0qIfy+Llqm/Vp0U54wtWrjncJnFLChFs29JxGJLN5fWebMzukHxSnMc+3EfFjrThCa4eVWWVLI8SeMpKc+7ym2OzBUEYp14hi8Ppoe1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fdb9e83-3e56-40c9-e8e0-08d5dcc18ebf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2655;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;3:xpLwkLYgxkzfGGxu8QLxOmzFfI5Fh5Byy9oZn/UVHAbw28pQYqzQrCAYQaTyJfIVx/rdF2JWO+8YRq7cULlkFXxUZWDf6zB2o+wHOBZHCOnA7Tqnypyq3jqm/Qed6+V9tIMbPfxThyg0//fV7+B1FqhjVBE72CMZ9Le5DNlYcZtH296Fcv8+D5L1BjMafj5vz0oIkr4D5A5zpSOrh7GUou/6jyeFTUCTzPDjEksRe/7WsNOwl2d+pCsPXL7pV0F2LbvLBqmn6lhGYyx9apgjXpZZeXIM4YcNxLVf0L9YVV9n1U5iZms/pei5UUMEIpMChpANuHjv5x25p1RsISzDyGYWLtX/6QzJpVExYce3Kws=;25:DceKJpt/H1k0LxNcDJMmiTYcP1SuZXONmnfbLBmhooOVV6shQG19jkNSbUP9d+RvQEe87Dz8oVtnfVGFqZIRlhVOOMOvwA1Iza23651GQdMntcN4atIYypDO2/WFRtELut3SMCWfRyyfAhJx26K7YH/Gnzu+9wg+WBnTYjxrfrfyPB6dGJSbY+Ni+pquxkiBbj9Ytonc+VicTPgHFL2X4fTKqnka1cPUxrVrWRWtqnekBR19Cs91E0l9ODjN0CwRI5QAXKTl/kR9MTiFR36Ts1veaLtj4fE8iFfLesES8nRjqkmj7f9DFLnGXkId+cMT4SYkrrcpKd/21btL3rwJzQ==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2655:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;31:mrycYBOp4WHg4VVcEYJUNxkcGhkR41Jy3RgUa6BdYzALdWVkgLPnF6MdW5bHJiejpD7SSrjBmPw3NZmx9dfeGhiLm6FCNnlZ0JQ9IYoHp6UwbQHkZAXxAIv5maWgvBnGjjkXqBuhZRns5ciLeXwQrBzlvhK8lmqKv8Il4tFPjMiYXuLukjkXbhIAPHhxFlKT2T5rOr5ApsdY7XKw8f06Ak/ykMHCdDFYtAz2qkBn80g=;20:f5M0GY0Z5euF16QQVvUGo909ock+uRQcpFbeM4mq55MKzG3xz9bx/FGDqK0ouQjN35SRwQkrgrV/FjiiRTC2iGnlSKbyETVQEiO4RmR6AiWymSDA5PvL60MRjzJ8tX5U+Ticy5XC4BGGrIghjApb722kbpODFFNuvI5SkBHYEjqJgXTHPjVvHT1m/0RJmnVkbvBS6H1F8qZNJ3ex5D9F49Zi8IWlGWwpbTYFwhHvlaNvlOMaPKV6zTTHCqh+M61Psze/sPBe1HMU+RdCMl+g+OPjFgrKmJzVq5+hO2/nCEoxNl44NhampiAt35cIoSuY6xlc6vhrZkURwUr7hkFa1Dxv+sNQE5AhQvmNuU22r/p9fD0hSpMDwR8zzF+kvnmZR3hyIeSQsktYyzSGiFt+aTtO34FIhM1gmR8puG8xlLF+5gXkOM5vZ40GhBScPFjnxEd83zAylnKk+DpJbkm+5SpcdCMYFxF+X5P7AmHNOpSTIai5bLkGLKmVJptEFArq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2655E80CE6CDD3853090CA3AC64F0@MWHPR02MB2655.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2655;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2655;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;4:JalCfUsdRASvytgv6cRK4d7fA5pkaOOa6COZVntNr+9t+lngZ4E3cf60Wb+M4X5srGlQ93LLCblcyxKfX8tsjXlR7/Uwmd65wP9A9LqFI3PDzXxma1IAVICTj+22Mg+Ryryg56N/qpDDV4rjSTyFxkt0etSVle6AslQ6f0HD5j86vmlnmpTD3dBPApYQFmi770jy2H1VCu9A5IJcToOCYu2Akr3n/DNgP/4bgJjSkJLJ4/mq7od3MRt66V29fyGCIj1JVZsoFr+Xoo5faqRXmqIHFGVGmpJTxl0pY3EHkF31WS6V0197x4gnNlPwaFYf
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyTUIyNjU1OzIzOm9Wek9aNUZXaGdGdUh4TTNGeFNnWElRaEJV?=
 =?utf-8?B?Q3Z1Rm1mMndGRGVjNW90dTZEbVhFU2JEVE83SFdXenVWVWlyN3ViWU9jUGRr?=
 =?utf-8?B?UHloeWYwMGkxN0EwYzQwcVVJRDlTOGlNcWJOM2k2VjlTWmptQm5HdjdMME1Q?=
 =?utf-8?B?cXJEQ3hiQmxCRy9JY3VsMDAyUnpURU5DMXF3TFZmbWhycG03ci9NaEpheTkx?=
 =?utf-8?B?TjdlanpTRElZM0I3MFdlYUV3VytBR0xPOUxBZC8yOGRhRzJOb2YzNzE1bENO?=
 =?utf-8?B?WUhXcGNtaXg4dlIrc1JoSXNhT0xsdXlSeVhLTGJ1alpjQUlTVU5pcWczMW1F?=
 =?utf-8?B?V1BxbUNSZWZnZ0pzSVhidmhxT2hJWENiTjhOZHFaempxOGRCM1IrQk14VkZa?=
 =?utf-8?B?ZG9FbFh4cTVsUmdHODdNait2NjFqWjMzSTcxVlo0b2FmUWZEcDJPeDJtNS9D?=
 =?utf-8?B?YzI1c2ZkNVNtNkJ4c1RSb1BHNkdlU1puRjdqZEpyL1VsbVkrdlByM2Jrenlu?=
 =?utf-8?B?NlNoc0hqT3NESnpodDNTams0TWFuQXQxQkFDakt6L0gzWGY1bVZIK3JacnZ4?=
 =?utf-8?B?M2VvT0hyRWxpU3luVHRXWjZaNkkxRjJRRytuUzBOWU05RHVQb2NEZUJDanNL?=
 =?utf-8?B?V2VTQnZ0aXJBbkdPZzBxajBqNXlBcUVDWkpBekhxczNOSlRKekhzTm44NE9O?=
 =?utf-8?B?ajdGVHU3SGFxWm5vYjlhUEl4dG1yUE5OWm9seXNtTDNGelNyekR0TVFlSHlp?=
 =?utf-8?B?NTRnYytCMm8raUNla0ZkZkRjNXJKaVo2b1gzaVcxd2xNNjdwTXF5RXpyN016?=
 =?utf-8?B?UW5heGkvNmlUVU1YTkRLVzQ1TFI5RWFkMDFpUzZEamp1L0pOZmFBYTc1MHBz?=
 =?utf-8?B?OXdqOFBjZlJsVGJYRGFwYzFZTVJhZ3RnWDR2cGR6RWhMNU5WRkhCakpEQlVY?=
 =?utf-8?B?SkNlOGIrMzZ0Wm1hL25mVkRMRndZd01OSGQ1TTRLT3N1NkE3anNJUSsxK0Y0?=
 =?utf-8?B?ZjJpMGQ2aDNpMFRxYjhXRlN4TjlOYjNnUVNMbmRmbkNQZDE0YTltRWtoQmlz?=
 =?utf-8?B?aENTV3RxS052OFFrdnY1dzIxT3hpYUJkODcreklXZ2FvanR0VTkvMVBSaTRK?=
 =?utf-8?B?OVlMeklzRWJhMXgvS2IwZStWcUtwVUNKUnNLd1h1cTJZTUwvV1ZOc0dnaGNJ?=
 =?utf-8?B?STV5Ulg1YlpNNk0vTE8rN2Fkb0V6cHdLczZLUUtSQlN2cE1qNHNFU0ZPaWRl?=
 =?utf-8?B?eldvKzdrTTFZdFVLTEhhbEpRdTg0YlpSRjJYOVJwODhVK3hPd3hvSGVYZnMx?=
 =?utf-8?B?OWticzRMTUFBNWo5R1ZUaVhwKzV2SS83ZVdOcHN4UUNUSEJKNWdORDBvVW9E?=
 =?utf-8?B?NnVzU2N1OElzMURCM3VITVZtMUpVbG9WWWJESGpJS1NMaHRtaC80MFRYQ3lq?=
 =?utf-8?B?MVU3aDMrenFlcHgxOXVDT25RcjFxU2JuaWVncFNzVk9aYVYvTzJUWERmNDJm?=
 =?utf-8?B?R3NIY0V0QlZwSHpYSklVeC9sT1BtYWFqbmtUY2ZRMVlZUnc5ZlVyaFprMSt1?=
 =?utf-8?B?LzNxdTFLeitzakIxUGsrMXhoYUoveUFmNkp4K0IvVmFEbGF3b2FsQVIycVVV?=
 =?utf-8?B?T3NpYndIOHJVZGxsWFVVOER4a0JMMHlLTy9Hb2R1cFZCdUFlajY2dGc4U3Fx?=
 =?utf-8?B?U2UrNm1sOEczckVkZ0JEdkFGK2NIeDJsUmtTNXdscjlwVFVvRlozakZMSnN5?=
 =?utf-8?B?d3l6Tm9RUUpCMlZBSzd0NDk2M25WRmNWb3ZBTkFEdEJ2THo5MTBER1ZWOW5o?=
 =?utf-8?B?ZTl4ckkvZkMrNDJPNjNRbERIQ0dCdXpuanVwcno0V0s1cXc9PQ==?=
X-Microsoft-Antispam-Message-Info: T+IdAAr6rxw3HEhg7iba25G4zRwAjB/ou0SAgDU8ZWHXebnXcp7E6vBCVzrC6Ov3LFuTCrvT/HriEY/VYmFDdeLILqUYrrAUCksvolFFbTHoz4Bqe+m9YipLKhR8cKZsv3gPh/GiHHN/9b9KW48DCN1pLy+Z/dG5zkJY3WG3gL3RnyeF5iZZpE1P2Ty7cdCPwu/RsKf59PVRAYFCBUrJEr/P4Ej6cVFD+6VbeNdkKMs6ZbBDy7tYwTYxKOMhOXFxaLqFBNKaKOo/VBAhrlDJxBOwnoYLbNFOgXQACsXJiJsqAAXhqVhQyNE51eWcZtb4NsN+frwSjzeGksByU1f9s1Vxe2EywGBBIaKvCLOB7Pw=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;6:nbyQns601q+82IE7y34aCQ9at931MMnTkQ/pFS0EUuZuWo7hbSDA/Tp0Y+Qh4vuQQuTNYRfmm5Ij55vQc4MoyPRIgKEaPPBjpml8hgYAtuUUcR2RlheeJg2cwJJHq3cj8Y0ru6bPf9UbnxiiBJbSqQSRZNhBNUcODmyied/q2jUFHh1bGGniq0XJdu1ucpmR+4DTaNyNT4RFiP+xF5eX8wA04nA6HavSvF64v13p9SsUlXvt7bHp9P0jrplRUGYhVJ4OUtaVA6dFqEPYcUiW84fPNdqtInKKXbSyAY2R1zXIU7so1z9FnrjgHrj5+PTxkl6ukdYXBCdJhWxNyElyOBespHUTdYhYvrhtt7+pPBv1E7qiVZbvfvGyB1495QdMSMuzlySDgXmgisl+5P7Zvo9qmDjITdJyCADMJH5hPlDTKXRPFQyHq9b/74g+Tiu9uVMDc7zj+lH0v2on/uBNWg==;5:ZPqhHSTmJ2c2QkTbKWG1bc3lMXjICACzxEYq3Abv88Q3kq5p8IaaJupNyEGClPMhqVx1AfpPLHCGSw50sVZHZ2irZutI0qpm3dgqiZqssM1fw3+FceaG3fQgAD9rXHIKnUd34NTMh2AZuGAVSN0NiVh56NRfD0zLGo6E3Dck9Yw=;24:X9rxq2QHlSLL7R4tJvDBWPhztVHs93jNudHnNw0I0YGjyoroyLQgevUT7UFRReZAVEdj5E/ygeFlP0UpH1fZXQPG+LzJ3hEjUXmUSUoLZn8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;7:4Qog3eQzlXxA/JBlu8qjjZffc8HDE9rgmVh2HroS1FgFTCpw1zew5rTzNIJc0LEkwbj52TL4VlObCdru1hczWDycIA+q/gBiDfIcK6yIwdT+NyQd5P6zi1wCpJrPq6HHXvT1qwCu4a+Mz3d6JCOnfBjNts4hxtM1lSxahZ6Dk5+enuIVd1PkLxCzkbAJ/s8h2BhxObjVr87Mm+g0GQaDr7fbaRZ+2zaUHMaE7S5e3ELK7lxo9tTWf1Fu0zbFAM2p
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 06:37:02.0783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdb9e83-3e56-40c9-e8e0-08d5dcc18ebf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2018 07:42, Luis Araneda wrote:
> Both boards are made by Avnet, Inc.
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  arch/arm/boot/dts/zynq-microzed.dts | 2 +-
>  arch/arm/boot/dts/zynq-zed.dts      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
> index aa4a0b6de..e40f40a7f 100644
> --- a/arch/arm/boot/dts/zynq-microzed.dts
> +++ b/arch/arm/boot/dts/zynq-microzed.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Zynq MicroZED Development Board";
> -	compatible = "xlnx,zynq-microzed", "xlnx,zynq-7000";
> +	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
> index 53c6883ce..98381cc85 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zed.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Zynq Zed Development Board";
> -	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
> +	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> 

Unfortunately we don't know who is parsing this string. It means please
keep that origin compatible string there.

I have no problem with this.
compatible = "avnet,zynq-zed", "xlnx,zynq-zed", "xlnx,zynq-7000";

Thanks,
Michal
