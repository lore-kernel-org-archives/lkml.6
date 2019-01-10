Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534FD206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DKKd1BkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfAJIgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:36:25 -0500
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:40800
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727634AbfAJIgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql1/o9EZAUb7bMlbIfttRTw73qv+sBJRa3ogXqYURME=;
 b=DKKd1BkXnRb23Gm3QUIbPyrsAJm8tgvQHNPGiJ0KkdBPOedbpQF1r8T4P80/peiUsRxh21jWxnEyfnIABOwDwHohzcYMh9vYRWgMJhXh/D9cY0o6I5t+qo4bY2IJ1agakMPJKAtmhIS2fJJ1A4xluVKpxqvKURLnu2wYWOIT7s4=
Received: from MWHPR12CA0051.namprd12.prod.outlook.com (2603:10b6:300:103::13)
 by MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.10; Thu, 10 Jan
 2019 08:36:15 +0000
Received: from DM3NAM03FT006.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::205) by MWHPR12CA0051.outlook.office365.com
 (2603:10b6:300:103::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.14 via Frontend
 Transport; Thu, 10 Jan 2019 08:36:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT006.mail.protection.outlook.com (10.152.82.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Thu, 10 Jan 2019 08:36:14 +0000
Received: from [10.237.40.91] (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 10 Jan
 2019 02:36:12 -0600
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <will.deacon@arm.com>,
        <Bernhard.Rosenkranzer@linaro.org>, <Carsten.Haitzler@arm.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
From:   "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>
Message-ID: <95b377d3-6d85-c296-d32e-a6d7f941b5b8@amd.com>
Date:   Thu, 10 Jan 2019 16:36:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(428003)(189003)(199004)(336012)(8676002)(446003)(230700001)(4326008)(77096007)(53546011)(104016004)(16526019)(31696002)(186003)(26005)(65956001)(81166006)(65806001)(97736004)(23676004)(476003)(47776003)(126002)(8936002)(72206003)(81156014)(2616005)(3846002)(6666004)(6116002)(426003)(486006)(2486003)(76176011)(356004)(68736007)(14444005)(11346002)(110136005)(6246003)(31686004)(36756003)(58126008)(106466001)(5660300001)(105586002)(316002)(16576012)(50466002)(64126003)(54906003)(86362001)(65826007)(305945005)(229853002)(2906002)(53936002)(67846002)(7736002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1264;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT006;1:6ir+vSS4t16phS9keTPnCxAOXrD18V+LDDwJfr5ap2oV7qYKCQVxmP/5D7sBiVX4kVpOVsQpf0XGLYV2hFkswFq5Cnd8htFFOosQmL1U+xGQXUVyWdr+7p+b0caI3irD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11abd4e5-ba8f-4ba4-e742-08d676d6aef5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1264;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1264;3:kO5aG75IgbU3vRULdjM245UhHh2a7NiFsARlFoZ7xrCNV7seuz/KCPAi/Aj8ZhZvswaO3dcK8Ex6fhiH0mfZ+w05CLzskxsedCQO8cpjrWTfS7zT44WkNhh+TlDG4BqB9VSYyltBWhWm6sZxpddR6SCcIph12Ld0escn13QnHX0JOoL58uBjbePSrdhdONlFSARhZWWfTSx8KunQlN+VrgmHCCzENkir3soxLrDKKlcXUzeP3zKfIQD+ovDSIqMdRj6qKNWWzlUynaStZgD6w8gbNg6nD0osjhTd6WZSgXMKZHfpRuu4Z7BEzZhuFCu5aP9VnMS42gfMH6jxEFru3edAM99Wqt+uqollchRul1vNdDjN7IQGWovg8EMAt8ED;25:N6+fWlFAp3dgm2tjdr2NW7J4fDbWkFXe/6VqjrCarfU6bUy6iEQEVA4ZbWnyvSO9ufOyeCGLZgBwYSvEfiXhRzkwbER1zaeSxuqThiXBQkLk5r+6Cv/RvlXC+Fgs/bBWRdH0r+sddnAaz2QIXJ5b1FoWTX9ZPCtNv9HkhOkiD/nBBHWXfGkjXCtVXIA7Jae18HJvB1tH32aiokg4ZHnYm0YVUQ8jEpmWHHz/qKkSSHAV9VL6flOy8cYiN53O7bsY6A1luKBLmZc47yk269N1Heasn3FDzDZGpemAwuireMtkALUXjh7Fzc0c3h2W3ch7M+tfC4w3rdMe8qR4mNs2bQ==
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1264;31:gG60nalx5m7iv94Oqrx7ZIJR0cwaLism9cDt/0tLQraK4Nb7kQEuXl5YpB40DGz6+Nz4LzFTzDCXg3psxIr4v4mBtA4PRqPz0yuFh57Wl/hu4eEs+nidcyxsvreqKp79yeyW1s3cj6HrEqvr5ttg4yL6IHyuqc6ueZOv32gX64149oo8kXmazfDq2vDxXYSmdw/jKvkjwW3M6wQB8v2M8+/nmByEUZe+Syt/Y0IOHqI=;20:Gqqj3aJxirYEoagzi0VsA68Qn8wIS84oxFH8laTlLeLkSiu5olk6NgLXdZPjLtZvLD/48ksD/cmoqoUOMufJX/xWAWvu7OcE6PW+QsVPQzOK4jvVX/fFa6rz/A/OMLPj+PCGAGd/BzwrMjAJfuSusBk+sl05+FSX1Gd9WukH3cNTbyf8d4kvDJ0KBOn3kIwGtI4c/dMEVI2UBXvkwQdg/eeOgf3YEWxxaV+LmHcg2hRoysfi98cWEY1Ok5vo4yBCtmReP9T4LNeFmFC9DGZBnJUKEWUGAT/88hnceCFnecmxnMxo2vtnqK77FFVCgsJ1OvdW10exwfCCen1emXWuf84btpPukeb6KBJvABvnohlG1gWoqmBGWEy52TxJP0XOQDLEbXdG0OGYygFJ8NBcfMHFhCr4dQh6dOgXtRSC6lHmYpd2JzwTuBkZc1nnmQJzSH70I99Rki//eeJuXTNA7TefO0bGpTNL+yV2x/7Vf25b7NHBNXxSKcEpwN4a8UPv
X-Microsoft-Antispam-PRVS: <MWHPR12MB1264CCF19B886F79388731B8FF840@MWHPR12MB1264.namprd12.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1264;4:M7qlvWnWbwbLSZFLxIrldnNH9jQbWW5s9wqFAyScfpB9+og5RBGCfseUUQgq5kS+O5hJCatXjbzX+heKrlfz2GDrZjFcx7PnSLW6dWtgP7fDYHEhRqZfbnY0VkMfjsUc56zK5EaIP+MCh15+eressgCY9nLE2276u2HTa/MX+heviCJIu5fN910nYQSzJlowGDtq3y1Nozi5jJmYT01VK/war8cw8F/JrGvPRPlUOlfqFj2gdJNgVmzfwmKgQou1R4EPSymCsxBDyEYBlMk7WEft7hUO1kNplq97m4USmvA7YdVDBCJGAS2BctYmp1PC
X-Forefront-PRVS: 0913EA1D60
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMjY0OzIzOnJXcXBMSGtZMGpKM2F3SjN1dEhxSkJoaTZu?=
 =?utf-8?B?cGExQUJGZ01rMzUrWnZSMDZGVU1xeFBrVEtMMWZnWVM3Zk93SzhGSHZOL2pa?=
 =?utf-8?B?ZXpsL3RqUnRJbjhuZFRwVzJDdlVsYnJCa1VXOXlpMWJXUlFMaWc1T255bTM5?=
 =?utf-8?B?emVhMlkrMlhqTmZIaERxQmZySEFPeGduMDNrWERyempYS29vcWk3MGxPOE1F?=
 =?utf-8?B?S2hJRDJmRDFPWE9TRjU3TE5rL0J6OGxIeXZTNUREUzhhOW1PamV4N1dDRTF4?=
 =?utf-8?B?V1YzeW5XRU9RTTFndWVOTVZmV2MvYml6ME44Qk5pZEtWSDB2WWFNSFRQL0hQ?=
 =?utf-8?B?aVVZRWpPLzdzaDFuRmcrb0FkbTk2V1J0dENGRmNNaUwzZnprVkhBMWtqbjA5?=
 =?utf-8?B?aFJ1eXA3Y09ZZng1U2dralA5VFI1d2x0ZDlGOXArRmVRMnIwWTQ2VlpSVzdy?=
 =?utf-8?B?RHJVcG1uK3dOT3VvbmxsbkppT1N2Z3lLa0VEVElrNGEveFR5L1RJbUFRRVhv?=
 =?utf-8?B?YnBLYzkwUGE5aXIvYzFZRWI2OGJBY0tRelJMditVR25iRWZ4UE9vK2tEYXNr?=
 =?utf-8?B?eFpkOVpGdlZ3ZXpGV0pYZXhxZHFCSzVveG4rNzJKYllpeHZvUE5CNURkT00w?=
 =?utf-8?B?R2RkNG8wU0F5RTVnd2RybzVBK3pVMFZXVTYwQkNyNENVb09sdkVRangrelRG?=
 =?utf-8?B?WFRncXYzMFAwTEpjcnkxS3hwYUZUazFBY3NCTkJEY0JyWTI4K29wb21TbVpv?=
 =?utf-8?B?bmZyamFGVXRZNnFPL0pmVXNUckVuNFpzUjZmWEt0VEFKcGRVK1RtNkRxaS9P?=
 =?utf-8?B?dk45Z3NnYlJJaHRvekxoVlRnbzJKVzJDVlk0dUdvb3QwTjR3ZnFFT0lGcUls?=
 =?utf-8?B?UE1sQ0hLZmJzZmNNcEtDT2N2WEZ1N0EwNEVsL21rNEZCaE1tZXR3SEcwb1M2?=
 =?utf-8?B?THNsUlpFVkJnV3MrcHNjN0dyQk94RFdXeTMxM3RlYjJNbTZwT212aytjWjZO?=
 =?utf-8?B?a0ROZmdDc29Yd3grYlhsbmJhUVRXUlcwYzk5VzVIR0JQUy80MlhhTGhDakpw?=
 =?utf-8?B?VG9YZjdEQVVRRTNwTm1FU3BvRVJ2bXh1U2VvcUUvcGxQbkZOSXo2UFNGbWU2?=
 =?utf-8?B?NlgrVzlVTVJobVBLUnNsa1d2ZFZKei9rYk9NODN4Mko1ZzJuU2x5cHI4NGNh?=
 =?utf-8?B?Q24zQVVPb2JyZmlFT2tKVXd1aVFhQXNRdlM3T1QzaURhSkpWL3FyTnlnU0Jp?=
 =?utf-8?B?WjBhdmZLU1RaMDZnMk5SeGZIWUw0QlZZL2E3Z2loOU52SjVjSjBKblkwQkFy?=
 =?utf-8?B?Ym8wYVg4Wm0ySGY0eWVIYVMzWVBFMWpBNU1IYUVnWVBvQjk4R1hqUUV2SStY?=
 =?utf-8?B?YVE2Z2w4Mm9hQWtPUktiM05GYnl2em8rT0ZkYXBkcUxFT2FTaWU0c0xOMVNx?=
 =?utf-8?B?YktZTVBqY1lRTXBmL2NZZVc2QnlmY2VNYmUzMnEzbGF1RUtXMGFsOUZBenJ4?=
 =?utf-8?B?OThhMXFzODlVNEVEcldOMlBuWUs2N0lwT2hFUGh3amtSR0xQM3RkVFFLVEQ4?=
 =?utf-8?B?UlF0U2U2cGhBZkxmc2IvUnY4ZFN1RHFHNTFqMFZkWEtPZ0xUb2lXQjRVSnh5?=
 =?utf-8?B?LzRxTzhYdURUMGRxM2t3MmJnLzlnVXNXWjVVTzhLMU5xd2x4UmdaUFRyWHIz?=
 =?utf-8?B?NDl1YjBrVTluR2NvZm9wTzN0b3ZhOGl1akk5V0pHNWp0UEUrQWdzZXRicHph?=
 =?utf-8?B?YkoxRHppaGlXWG0rWkdPVUxiNFdudFhXZ1RZT1Z0TzdmWG5SU1JhaWR2aGFV?=
 =?utf-8?B?S0w4QTJYa3M2Y21wMlFtTHYrMHZwRXB0aXhJcThnS2xXVEVVeUtmSW5tM0tt?=
 =?utf-8?B?NlBDOG9EMVVkVGtoSlFhME5GcFhCMzVhejBNSlpEbVBXWkZQMS8yTHRGQTJY?=
 =?utf-8?Q?lTmR4u0HIe4HdyTxDVoL5teAM7mKw4=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hd1XmKy9Kpr0HeoD11Jk51Ovvt/5VnTnW8X00Cy0Jgjp5xcRWBCmVVNWWAHsWRahlesT2BCQOjkNspdpgx85kTd7NVTRrSVRKvi6BZmq0lCmJPdyCLajq6FLMVHpHE23iBA4GF/nopJpWxFakVz6f796FeepAXcbzfRtlWeHU/w6+5zTCTydE1/bU9zhBuwXDm91PpeQmsdJSCfRu8mDH4tKXe4WeOF4LEmjkrO2RgqIRN0N0Hl3vcCs3yl0Q0hdZslGD/Eof/87VvRe9I8yGOurJ9TSOI1Ak1MxF9f+/coVrKwjm0oORcHc92QyMjpa
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1264;6:ncjl2mRQIpXP4HN4Ds26YCzvHFj/QhQnwQkVvOTmbJ/cXH7Um4sgOvkamCNcmahK6WtwJSVq/8CbK7ULgwasc0MEw2kAqBtjkPhOxlKMQXN4HcOCcOofsXruvXNmhxIp9SaYhJNwS9usXmlwO6kxGgNE/slq5WiMtokmu1AtkcN5p6+XCmMLk6siFlBzOyYPIHqxaiqfCCVrxxsSSNp9k1RHX3xhqCqsXIG1+aPuTPFxV/PaB6TexcbTUoXpoXPdgsWPhDUoUXsCodAcM483vfIXpF1n+67JY68WFuaz59x8lhx3SPDNRoe7vqa7iDnIUTL21PRdVY3dYyiRSE46+0SbnG4GGni8gp3yXUgu8QYkXVp7uUHha83/I4n6TOYdER7l5Kk724SdyyJyeL8NoNveHoK6VE8oXXlf0i3Th+/gbxt8xwrIpihHxMceleLlV0aTA3rBBPNyN7ykKFBrow==;5:6I1gUEa0MsGmato2PBn77juLFFx0uJO9hMtNAYqp+wSTjizO4Z0VzPe527oz+E2TGBsqwgVd6rKa6et5C4t/BMXrJU2N3wfz+dzAaJjjjoJGTe/HkAb8UDmW+V3QQ+j8cFYHF/pfsLLt0seB105pWX+zwcSxmcd2SVW27J/QE+JUthL0uHWUko4ZsKF2Q+VydCIeQRrPS7qZEhGGh/yqrQ==;7:0yIjuCSTfjge/VyCc6zyq1Tg1vp7iZuRgauxbxnn1pgNOleZ28iESVLxHFo1bUJvFmQnIuD7ngttLe5GJNAvT2wJeS/CuajDtH93CPI6EzHpNkbV+z0A9+nyHHDXVgmRNfgthRMCTue9m/noygtYIQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1264;20:TVdnSBMTGcqp59kNBIwI+L2QKi6g/pCpGjbz3ZdskM+1XnXB/sAtlZqw3kBcjWNQN41kVdfA9ze6tG9SGRY+8k+0BHAvmFqzHFheDiUSC5O0Rk6B1FOM7HtOc0QL4XyLDEDEeyGcwjstP/Q1XvtP3NeTtlzZ94PuK2sJWXqPMBvDYx4nUSq8E1Mzru5RHpx824UMUTeEIHmrgbdvcS74QZ5buRrtBry9s0J8SVA/XMpPFElEqkaQSnBFM7EMrjyv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2019 08:36:14.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11abd4e5-ba8f-4ba4-e742-08d676d6aef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 3:28 PM, Ard Biesheuvel wrote:
> ARM systems do not permit the use of anything other than cached
> mappings for system memory, since that memory may be mapped in the
> linear region as well, and the architecture does not permit aliases
> with mismatched attributes.
>
> So short-circuit the evaluation in ttm_io_prot() if the flags include
> TTM_PL_SYSTEM when running on ARM or arm64, and just return cached
> attributes immediately.

It sounds a case for ARM system memory access from CPU only?

If that always applies to ARM memory, suppose we should do that for 
TTM_PL_TT as well.
While TTM_PL_TT | TTM_PL_FLAG_WC is likely to work as below mention.

Regards,
Jerry
> This fixes the radeon and amdgpu [TBC] drivers when running on arm64.
> Without this change, amdgpu does not start at all, and radeon only
> produces corrupt display output.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 046a6dda690a..0c1eef5f7ae3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -530,6 +530,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
>   	if (caching_flags & TTM_PL_FLAG_CACHED)
>   		return tmp;
>   
> +#if defined(__arm__) || defined(__aarch64__)
> +	/* ARM only permits cached mappings of system memory */
> +	if (caching_flags & TTM_PL_SYSTEM)
> +		return tmp;
> +#endif
>   #if defined(__i386__) || defined(__x86_64__)
>   	if (caching_flags & TTM_PL_FLAG_WC)
>   		tmp = pgprot_writecombine(tmp);

