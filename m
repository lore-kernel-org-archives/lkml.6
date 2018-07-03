Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5302C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4A2464F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AYJBavWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C4A2464F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeGCUuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:50:52 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:29771
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752706AbeGCUur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMrSwacSn5hTjUwPsMHEdonkirw1ybuw0H2mhnVR7YY=;
 b=AYJBavWvsfQBhKVv9ej/2zqq7HdI/lRzalIQuIl/UO24kXrvQpCjvGri9LXxpqp0vpibGvEokk69M7d50pT/du2VqWz/DBcbKue49k6aAzNTX5CqFg6QGRJmtmKXDMk6dR0t2Nf1ibLxLLk3zcky6+X2tzOHJnCumdVy1S/qd8M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 DM2PR12MB0169.namprd12.prod.outlook.com (2a01:111:e400:50ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 20:50:43 +0000
Subject: Re: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is
 active
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        kvm@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "# 4 . 15 . x" <stable@vger.kernel.org>
References: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <ec20e072-2162-2555-758d-38c98276f4fa@amd.com>
Date:   Tue, 3 Jul 2018 15:50:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To DM2PR12MB0169.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c262b8a3-dd9c-469f-331a-08d5e126a530
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0169;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;3:67mXWa+j885W5aUtotUMaz+4LJnQMJvyb0nJJUVxDA4TlHQiQUT7rXc+3wbKWbGYpGhgAOmKGVMYkm3hbDXWolx+OOgqNcSJi/L8I7W6S2PkVav3mFYUMvjIBl9kuyLN0swNuQ0vPd0OQVkP5Em4E437ORW9rjLkdqwaYvHjq69gBvfMhRrOHOw8TXXWTKtNcO0jl9tSSUq4nz6jRVzBjkQ6W3zBUX1Vx0odFcxDT+7eUANgVwcxNjlgNrqq3A8R;25:/xXDptf0rhBWu5AWaFj9UyYGSjCFVk1Gz2I+zmrCis1zIK8CI60S7d3ivQQKExGvPaLiClCciIR/SLVrez1BmVLl99zla7Tzhs3bqDHkM5usNuUB4M6Nwxx/NhXhmmH2DrPErfoB/Zcy2L7iKCg7BOdJTm9excmSZy0cxDeyU0BO9WDX2zztGjfjEYyPCXchc+ege0GG/IAD4Hnpv3IyyU1ECF6rPIUztZklURQwHTe6U/ylSVaxmVeaSm4J1gWkqrlEyDwWtHgAIgqm4TLUbCxJus0AQT48poznDfn2slX7HrfKiIuookGPV/oEbHB/oq0zV6gF0bZy1d1a4Xk9Jg==;31:cWyqhy8Vi0wIs+TuJMqDl4jL45ShjZQ9I4+8yKDNY5ekmpmB2duqb7NnB0oEegC/3vh+OVKxkrANj1X9PhMP2PsrjnYrevZGqRToyQqZ9gmnrvW+0PXeUQApbhnUjrYuSh3QMbJqvIFe/VtN2cycW0rhd2dkN9Dq1VanhcAUfLeVNVEgHgzhi73NPSi4PU9+2SrhqDKFJVXLgCXc+5Y4xzR0T4p1vLcvFGOHJQlbQWg=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0169:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;20:4tExI72mZE3SYnTlbt13Zd9gsNgdzb8oBc6pPePBAIOZ4HgYs35P0a0oTfqnOjCUD6Z/aesVcS47CWzta6BTgpIeWAw/3wSg0BmDTvvQQm6DasEx4NzkQ74LMe3q9z6ykCOS/4Blq+b0alYVXG8KA405dIMI0d/hs74uY6P8qfyTZfIAf9VK7paamY8ToYvLTFJG9Mv0nnc3r7ToUzQM2WTlt/6v8lUeLUU9d5a0Zxqu/yLtRFH90/tZK9fLK6ajrL83EtOEPVsNlfZpdJDwQwnAeanMcK635+9jD3X0Kxvyax8dYjdgZCmXeTPdpkOLU+2Ssy8gSyeRXPAD6gZhbf6FqcwUI2TyFwWBq1jXTxKpXKrLwNRrKiS85omjMyTsw2v4RK/2vXvu177tB9xOdHEbyJ3fTGrmYKA2FNhjO7fae7yqRv5gGtbUHsjS4/N6gaZvpeNcZf23/DKxXkmzOtkct7ngr1Fxqk0icz95b/equLUcRVnWa1XVGAaPg/1h;4:QVAnelcXxE00bqFP+QwtHVJa/KgZqXueEb3MiUiUmYVuWGixRQtsDK8OAe79JNubwKB1gyiDU3gPlphZqas8+Ekhd8ucqiQmCsSlTePaQhkdHy4yzpxk4/2+f/VmCrdzXxPFOAW5D5hGuuj2c/GDPosImRMq17ow3WWQl3j/jEHXVqtxTeOhPI8YU3CxaWcpE86WXTrp0gKO6CFCzE5Uh2NbWGiZ/ARCW0S66CMNV6Cip7YC+hpqHoi4Ng9YtF/GHdIKPNFLjfoY8DHDWm1setEtpGgqPFg8KDSoSE1gCEz+e9XYtBsKcCLftCQKGpzew+AxiWuBgJBY1A/m4KPVyQ==
X-Microsoft-Antispam-PRVS: <DM2PR12MB0169CD8813530B0FF8B88C8AEC420@DM2PR12MB0169.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0169;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0169;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(8676002)(26005)(31696002)(47776003)(68736007)(7736002)(81166006)(81156014)(53546011)(4326008)(486006)(106356001)(86362001)(54906003)(386003)(8936002)(305945005)(65956001)(65806001)(66066001)(53936002)(6246003)(97736004)(31686004)(476003)(105586002)(2906002)(2616005)(14444005)(956004)(3846002)(16526019)(23676004)(2486003)(52146003)(316002)(11346002)(77096007)(186003)(3260700006)(6486002)(446003)(25786009)(6666003)(6116002)(36756003)(230700001)(65826007)(16576012)(58126008)(64126003)(478600001)(52116002)(229853002)(76176011)(7416002)(72206003)(5660300001)(50466002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0169;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTY5OzIzOnBmZHVxUTNSUExxdWx5Q1Z1SnZJSUlqa013?=
 =?utf-8?B?SXQ2anZBWkFkSGlrSjNCL3B1SjlCUVJDL3k3WWZNQmFDSXB2VzNib2RkQlFv?=
 =?utf-8?B?S1JTaVlYVUtEaUhSbFpLRHN1TlFlR2lZYkNETVA1NWJZSGEzWG91VEtZNWxu?=
 =?utf-8?B?NDV0bEVoR1Z1bm8xMU0wa2dUVTlTMUxtN2hnbEpWeldqbnFRb2gvK29MQS9L?=
 =?utf-8?B?Yy9ya0tPMktSdmFNOUZndkNiQWwxeXJLNEtJeWJhU2xXdWU4SGxxMmFxVTNu?=
 =?utf-8?B?ZjhUbDRZTlRHZU1XL2pSb0NIc0hzemdiYzkvSHZlYzJNc0l0cVZVTVAwMDUz?=
 =?utf-8?B?SC9ZY2dxK2pXMmY1Q2grRnNyeDlJNFA1dHlHRWZWb0xUL2Q5ZXEyMEhuRmw3?=
 =?utf-8?B?ZUtpM1h4TE4vOEZYbHN5V1ZQTXFBZkcwRE1uUTdkaGoyTHNoWFRoeHpBYmJT?=
 =?utf-8?B?eVlyNEpwUWdNazRUUkEwRmdtZDNRYXBGSVRBZWxtSEd1ZHdwVVJlWlZJeXBz?=
 =?utf-8?B?Sm1lUGNETG9KRC9obXV6aEg1M2JvZ25TRHJlT1hObFUzL3NDRU1qQVJLUXRK?=
 =?utf-8?B?QlIrc1JXNTJ4UGZNTTZUN3JmT2p6a0ZNS2QzZy90bzMwbEFnTmVNQnl3THhI?=
 =?utf-8?B?TG0vZzNRWGFOc2wwN3lxQ1RNb2NBR3NtRHA0MjFacDZjUjQ3TzQ0b3lIL2o2?=
 =?utf-8?B?a05TY2xCZmpyZHpVM01JeGJ1bUVaempGRmNYMW5HTWhSR0VJLzZmODZWM29j?=
 =?utf-8?B?TGNUY1NjTnlLZ2k3bTd6ZDh0N3FuVUJQb3NhQWV1cGx0dnVNcXRySVUrUmtn?=
 =?utf-8?B?Y3o2NXpkc0hubXBpMTM1dmlmYjNlYldFYmRVY3lxbitCQnBsemc3aVoreFM3?=
 =?utf-8?B?akNJM2RYR216aEFRVGk5UFFPUTF4dEROLzNRaU1vNCtSdU1JYWNoL2YrcUZa?=
 =?utf-8?B?Z3pEOFptTktKb0wxMWExdzJYNlBqUWNBNkxFTVZCSjlyWi83M0V2RFBnQkZw?=
 =?utf-8?B?YldndkZDQXZ5aDh1VjZHSUNDMy8rcnE3ZnlsWG9Sd2ZOY2ZMMHV6eFhhZVh5?=
 =?utf-8?B?Q21la2tjY0NBWHhjR3djVVpwUWNBdWNNZ2tlWm9Sc05jLzRVZ3VXdmRsVERY?=
 =?utf-8?B?SFpOVDJ5TW0rUnVjWFlubGZLS29PWnZPbE1jaHluZytOL0ErNnpNbzB4K0Iy?=
 =?utf-8?B?TU5YbkxPcFZPYXF2Z1lZN0FRaEp1RlNGQmpsUHlXVUVDdC9wdTlJeFByVFFF?=
 =?utf-8?B?WXZpVmRGZkIyWTJ2ajQxak1pVUdUS0lUMnZmV2tGSisxdDJDL2ZIeE8rcEl6?=
 =?utf-8?B?R2JxZXNORThkaXJwRFd2cm9KTm84b2sxWFRSdUJ3bXpOKzB6UHYzdS9Rello?=
 =?utf-8?B?TndMbktxRnRVUUc4WDVyTkZraW9OS2VURCtVQWNvdFY1KzhmQ3F4Nm5hTnYz?=
 =?utf-8?B?M0dyWmNRb2hJYmdhRnBiZjBwbC9pL1V1Y1A0MFo5bzdySFNRdUlmb0tmbUQz?=
 =?utf-8?B?NWpRaUdkY2VpaUhSY25MK2plcnhQaTdKd0Vpb3hEaVF3cjFoTlp1MHpIVjVn?=
 =?utf-8?B?dzNBS3BQb2VWNWd0TzNSVmZrend6UjMxSEtVb3F2SjdkZkJSb3paaDV5a2xE?=
 =?utf-8?B?SEkxNjNIbTZ4OTZhTGUyMndlQlUwcVlrbWYzZ2xRb0pkT3lXVzNqT3V4QWk5?=
 =?utf-8?B?MGFsL2VSSkVpYWNYVTdSWStNSHFxL0ZSS2JydWc1dXhQK1QreXVpTnhyTHpJ?=
 =?utf-8?B?bk94RjgyTHdFb2dwN3VMYktjeVFndTBuWDQ0ejlOcmFMZ20xU2x2K0VPVzh0?=
 =?utf-8?B?K3hsV0NVTlE4NCs2YW4xWFZMMXRKZTI4a1A5Q2UzY3JQaGk0ZHJXaXUzcE1o?=
 =?utf-8?B?UW14aFNzY3FmTnQ1UUJVVjdKcDQzNzRaYjBpYlJyUDlJN3hHajRUTUNYZ3ZC?=
 =?utf-8?B?LzZKVDRpMXloSi9tazBOUEszcDI2TWI0MUdkZ1lZM0RSUzZYdjVFWFJXeThP?=
 =?utf-8?B?REJLNGJkTnpoTDY1cEh1cnR0Z0R6S3dsMzlsVFMwRzhLZURBd1dQYnF4aVdu?=
 =?utf-8?Q?9U40=3D?=
X-Microsoft-Antispam-Message-Info: 5u+kuMqcSEKnV51MznrbBC0o3FyrlOMgMWXqeqg3XvMpMeiKPykBkw0ZsREF57+e55TZWRtTNpHHgWKcow0i+n6xfUOP4vBhec7y5ZWf1jc5IzlKbekmfFco3RPS7nTi+q9Wrzfvm0geeCXwxfHbeZNd/s18yKzmQSxPnXKbMR2ndC36pOi+X/UaoVhucqjS4IvDwxqfBqwgmv1j2Qd3quR9KmjVPs1BH9v+wmi4zhXM0DXf6C86nM9nd+ZM64ZIR+Ysss7jTrOoWjbFH0SAJTSeahWfff3P8Whh4iEw8ezKCuCvEDiKBk1Bs/ckoHxcBpFYxRdhxqF7I93rXYWOctynj4DZub95NvM7Kr7AXME=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;6:mm4EORBgNJVtkhTsfwnzottdNsA2nmy7ihCm+uOBgSj6QiVXbf4ZFeD8Bq34RUDrjpt9T2kM8IYXLrajLiQxubT7l+L52AAv4J98Q35K+0B5GnM62wMfh0uc/+tMLQABSYEegdccls1e4CebExMvnnhCzDiWG5yiDyH+sRfDRo9VOwF6hkX4RLiWn22eDpg/rPIjyaF6d/P+Ox/FLBhW5238eSYToQKUYe/m9ZFpARrks5fI4fw2lGdHxnoSYEVymyX9oAqS1RjeeJdXKr31rl/sPwVmv5OQq8XSkMSZB+H8EttTxwNDS/Hql/FzqdWpZyy5eJbXcld7DLrtYOrJWu0GMmMxuyo9khnqlzcjT9iXSNrNcrvqLj9nyyCuDtMhqFgSshfH/rH3hjTS010A9zFuc5SGOwtUyUHOThqdLjD8yMsUUMdQx0Kg/SzEoTJ5fFOB4Q/UoG/Cc9Usz5xwmA==;5:ki/YDV3gJB39Jf5z6KEDdzlXuqVz8YqhVvE3CX6mC/7Tnp3brbmdHfb7+dsT2yfb06kx92sVZ8fV66kYxMiI2M1epijFwXir18q0OUo75vyLed0zSwijLHvrUxBAmZh1V0AbfnH9IQ1qDWjUbIJoix56CQjEbDvRAE5Wi3QTQ8k=;24:/9cxWiLrdBf1l9zIwCKEz8+yl6UhlsLrzEMR9mZTeTrUDS6vWIoBdGWvvGAkrFytk3hpYo+jcEiEAjjEoGKPEIwDCcnG0JlX7YEW0ByPQag=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;7:0KjILcP/IFsJs8ou50V/Ri0XV+KDvyRFut3IHWn6jg7DzM3rvtcqNTV0AQuC2UnBH2S7mQMP24g/nbmPa5BsBvrEE5Tj0zwbMxua1FN2GzflpQDr3noOe/WH4ncuPoa+ZH7qGf6QbJPRhCeAJUOnmHgkyFeQVJYVm2rm4T++9glER0g0Yrfl7MhwfJLQkvNJiz/sDFvtUhQDqDwqaRC9DpuOk0DngdWLdEVLNp6MdJwapv/9MFC2ZdqB07mSRmw+;20:+i/Y3lWNDaGGGEsX5Ug2+mMpv4JdhtqBzSfqu86jvs1LG5Cs5CfuVjFH549qDqnDc9dPHNV4cUshDogCDr41svVzo+nNMWC/m8pmWdFqExvYB+qS/540+MLUnxTb3nceDG5+y+5RSvNXTqljwnDhjAcQBqPgg6cu885dVKOLzOt1Wvm8rScU86jFBjK1yLmSJKbdFI4nVfkRhuZXbyd1FMtZavp8J8K7yx7rsUG1aFyZMXoSzG3w2diuadkPyecL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 20:50:43.2394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c262b8a3-dd9c-469f-331a-08d5e126a530
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 8:32 AM, Brijesh Singh wrote:
> SEV guest fails to update the UEFI runtime variables stored in the
> flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
> when SEV is active") unconditionally maps all the UEFI runtime data
> as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
> as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
> guest and hypervisor can access the data.
> 
> Fixes: 1379edd59673 (x86/efi: Access EFI data as encrypted ...)
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: linux-efi@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: <stable@vger.kernel.org> # 4.15.x
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/platform/efi/efi_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 77873ce..5f2eb32 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
>  	if (!(md->attribute & EFI_MEMORY_WB))
>  		flags |= _PAGE_PCD;
>  
> -	if (sev_active())
> +	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
>  		flags |= _PAGE_ENC;
>  
>  	pfn = md->phys_addr >> PAGE_SHIFT;
> 
