Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967062081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="X7HPfJ5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967062081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbeKGSPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:15:53 -0500
Received: from mail-eopbgr740077.outbound.protection.outlook.com ([40.107.74.77]:35584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbeKGSPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI10MeewrOdutCTD+945VNC4//NHq4tDGPCxAJqeW1g=;
 b=X7HPfJ5RmMzgyPTZrhuiaAyv7FtnyAYcKTR9baXA6u1+0PhgzLHssSeabbGEIYNYY6b+zRVyu1wbY1aDFHEc8o+UwUir1gATeab0nxmhSxQoK9oN+eSyog1ifaj9lfcDBa6OtMC5121chhqm2VRLCNFV9/m9XY3usXYapGLKaKg=
Received: from BN7PR02CA0005.namprd02.prod.outlook.com (2603:10b6:408:20::18)
 by BYAPR02MB4326.namprd02.prod.outlook.com (2603:10b6:a03:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Wed, 7 Nov
 2018 08:46:24 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN7PR02CA0005.outlook.office365.com
 (2603:10b6:408:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Wed, 7 Nov 2018 08:46:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 7 Nov 2018 08:46:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57070 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gKJTi-00032s-Da; Wed, 07 Nov 2018 00:46:22 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gKJTd-0007My-A0; Wed, 07 Nov 2018 00:46:17 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA78kEBP025378;
        Wed, 7 Nov 2018 00:46:14 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gKJTa-0007M6-Gd; Wed, 07 Nov 2018 00:46:14 -0800
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
Date:   Wed, 7 Nov 2018 09:46:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101005724.9622-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(2486003)(186003)(229853002)(36756003)(64126003)(336012)(31686004)(478600001)(26005)(77096007)(6246003)(65956001)(11346002)(65806001)(47776003)(44832011)(486006)(446003)(81166006)(81156014)(8676002)(126002)(476003)(8936002)(39060400002)(230700001)(9786002)(106466001)(305945005)(426003)(2906002)(4326008)(2616005)(63266004)(575784001)(36386004)(31696002)(14444005)(316002)(65826007)(356004)(5660300001)(106002)(76176011)(58126008)(110136005)(54906003)(23676004)(50466002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:LOo8F1a3EQ0xgDI95EO4O2Pjd7lN++uxksrpc42O1YxfnG5kf2YwhJFkn/srSztD3qDVkvLsOxQRlkh0WOIb6tDahyeONQOn2t53ubrSFytO+pwytt2/nz9f3UZQXKHa
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85e982c6-14a6-415a-7967-08d6448d7f0b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:DAPGdT0NX33EQIBQjRrPrVS1VQdCicPXPAcqOswBBZ0VOxoQcoAtZwNGSa6tuZCMY2lN82bhPfrYk6ubPjll2AxIrJXx18wFQr3+qCLPuG/yFdeTLiMKUqVoZsHgEz+H0sCJZBEbZB11oaaDabf348OmjlKa5vX85JNFWdikQVF03LGIO4Jvq4RnN1RQ12TBT+t74YO0gNZZBmITk8t0WClcBx1q9cU3wW5rhIAVGT8U28eOTMJwwO1KnhNYuVBOAhVdhGjUh+sE+ptmDrC9aZ1UhfeEzNYH50I9sjeQoaOohZ7FovBqVVSg6PBC/GxeFOLMYLYVsRvykjVMbWWSvoDaMWV/74ptkRP/6WfRiQU=;25:5eoHREloNG6vnzeFuncZqHlgz2/4LriYA0eJZOQyjOzI880/VnF6vuiraOSEVE2DN4ZPurCiobJeRJvYAkRUXeRGBWUCsehae2f8yATAARw26+WRLzWJNwv58mYneSNQr/DeU+pSfyoy29/knhxYSqCQAQNA/tf+y6b3rWWq90mgTSsAI7BH8G5t4YaKq2UDwcZj4o7FueO4I2sOmey3gWlRk29WpROiomq2FsCbvCP4tPwUkeH3HPfF2aajVhLEY/SGunmShAXRcYajji+zlY4KLZ3vnrzjJl5wb4aCQpm5tZzOJn9Bi8zgqUIEqYfBa2OtdLjqm+EygHEeH9sXmw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:i6Wd5riK3A7LrAusymppMl+789IvkpqluHzVdzJkcL16QeTVHwCQ+Rjq5Sk3fkSEiLcL2NKsIrLvcVcehbpnVtvRZ5jHeP7uTSkH4g9VAnvWgOoRmDpyXih7fcW0KZ+D9eHwpUvhYP5/icu++JDJ/RJ1+GXkHLnPII9B3RT1+8F39OHfsNd0ZW9ja77khsZBhUHYii+yNIoc/2Q3LJlZ5ey3pvAbD7ONZAji56iU2/c=;20:eM11H37OcqY4AJVwvwIW0r7ZMGtCWvCuOZ8pRGZyqXHlj7Ovu4Jq0jaAsmHdw/bs4sUigLUsMfZAewH+PUhRusl548MzG36XdbEj54ru0fszA2y2RvpuE00bs6kiYv1FkTFahUNyNoTLKfZ6GpNZOccmT966NfkGx4KOHlTN6nYTljIJ9Q4WaJUV6K62neDa2jl0EIcZH09WXMz9CRCyJl64mqwmT0SA+m6pFW8oSfleh3a+3dH18a8wBfugoBgQxgy4waHw08koSEiAipZiHaY3x1N8o6P16zLF3OrssOdCMMDSglZ94JG9zF17WDxQRyx7BnIwscrNHdaxwbSCzmn6+SdQcY+09QnvQN0dK7gHDmGik3eVUOM44FsOts0sI3wx58tHOh08dZ/NaRIzM4oCYTm62turYaFEJ9R4Gzh9tNe7K23TUIoKdjEnlbv9Sw6jbSFSjiRBA3xH+QtgJADhgKo3HPYfCiFBiITYDKYPU0N2VwonQemC0iEyMH5z
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4326C323D5F1FAB8518717BAC6C40@BYAPR02MB4326.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:IjPF2VAGlZ+Sg2OPevbQq34Pr1Kur5XZHZLlEdVWY7ugg+w6uN+qk7UOQh9GffEb9gfmUWd03NSV0IYoQJ0DSGzjGruEcjfl7pKWnchxf8hUsa/s0YJ+tlQRCe4SoUYfjk+d9x7GjI2ltc/A6o81QA3R7K3ilKmf8+HeB1N+0Y5138+AdsIXKKDqorHqPanc3Zk0jFgF7LmEIRmMe4M5Lv9Cun0NTHefCObivzeyjrXLsqs7lcocPVn3vZc6EWpWcuRPmZ3n8C5tqeltTs4w5bTeCYSW4W9wHc1E3p9w4kc3XCVZPQC6gfsYSb9tuRn8SPdMD1z35BlSYPw0OH3y04U8Q66nOtmNhxKYplOjOYc=
X-Forefront-PRVS: 08497C3D99
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0MzI2OzIzOnBkb1Y0akE5UG9lQUpXK3MrWnlqUkdyR0w5?=
 =?utf-8?B?b0xQWERPVWxMUzJjcjFCanRQeEFrS0d1K1IyckpEQytXVUp3bHRJMUZRWTJm?=
 =?utf-8?B?bjYwbjNhdzQ2WWlBMVdHUXB2U2E5OXFwMUFDdGZyL20zYlZRWnBlTEZvMW1w?=
 =?utf-8?B?MWdXTUJ0R3UyNVNSUVNPRVpFc2pPcDE5WFZESEdJS2cxWGxvMVVmN21QQmZG?=
 =?utf-8?B?a1hiK00wNXA4MDVOUWViRTJCQS9OeXJyWVNZN25ZRnczS3R5dkhHT0RTUThL?=
 =?utf-8?B?Zi9LZjRzUTd6VVdaV2ZWQUhoNFdqb2R1L3hidmdiOXRJMUpmLzZ3SGFpbVVq?=
 =?utf-8?B?ZTJEZXJxUW1yVzlTaVM4NzVmL0lTaHVHd1dhbWthZVVQY3pRekF0OUpFMmZh?=
 =?utf-8?B?NTJHaW5QUkhqUlRIaXM1R1dZQXRpdmdUQWp1WjJRS3pSMmJMazBLempCYStM?=
 =?utf-8?B?YmlVK21FQ1QzVDZoZXJIYkp5QzFVcDhsZFZhWDM5N1pvYUM0RUhDdWFtOFpa?=
 =?utf-8?B?WXhlallsaW9GRk5qKzNQbzE5NmRPb3d1eXB4RGtlR1pPYUlOeXBsUDVldmdv?=
 =?utf-8?B?TTZSUW4vU2ZtWkd3ZDlTM2o2Kzc4bEI3ZXhlMUY2RkxWS2c1cXFGV2hLNytp?=
 =?utf-8?B?aEx0ci9MVE5JcHdtSlRZM21FKzVSZmlYMytCbzgrOStiSEdFUHBGVmNxR3Aw?=
 =?utf-8?B?cmZ3dlh4V1dxdXRoOUJJN20wbE9GT3Z2ekdpcURkaDRmS1czdXIrd1M2YSsv?=
 =?utf-8?B?bHZ6OVJqK0kyV1dBSTdBZDFMRHhCRVFRZWFsckliY1lpNlg4aHo3cWlrZEdI?=
 =?utf-8?B?RUpqeGdoOHRBaGxHYm42Vm9qWUNUSHp6WW83L1U0MDFpd2pKeklZWlliaUJM?=
 =?utf-8?B?L0xoQUJOWnFGc0pjSTVqb3NFQi9KbHgxMUxuVzBCZXR0aVhTRE1PQTI1RjE1?=
 =?utf-8?B?MWJhYlBZVFJtem5Yc0VoYlVtVlZxSEQxUmgweUp5b3k1RWVaRWtSdjVmNFNv?=
 =?utf-8?B?MTNiMUE3YnFtRFdyanlDQWhYemFFQktGQ1dIeUFzRlNubVg1ZkdRSUxPdDhw?=
 =?utf-8?B?NE5NcUhZZmZOWFNUOXpuMHJob0hJVHVWOUhIdVBTdktRM1kzVXRrbTRxd3pm?=
 =?utf-8?B?eTJVenV2cGNSalpua0taSHA5U3RHT3dVOW9uSWFIZ0FtRjIzTFVUZzlScVB2?=
 =?utf-8?B?UmtrbnFIZ1hjc2Q2eE41aWsvMkVaNThEb2RGejNuQkNVUWFKNGtzbHpYcmdI?=
 =?utf-8?B?UVUwR3VJaDB0aWZQUFZsTFl1K2hqVFdwUURtYUhRZFl0MFhRcnp5eFBkRzVu?=
 =?utf-8?B?VXlPRENqN25Ba2lNaERMY3VscXRiWmtBVGhtc1A2ZlZGWTZrWDZTS0NHOUJW?=
 =?utf-8?B?WTh5aEFtd20xTkw1L2lnOWV4UEFUb2kvU2x5WGxnb3JIWC9aRDNqVllpUU5m?=
 =?utf-8?B?VWsxTzZETytLcHE0OUJOdXd6MUtXREM4NkdNMmJHdnJwRlRPUWgwWTVMSXFp?=
 =?utf-8?B?SHBnU0VsSFZXSVVMS0dFbXM5RjdlRzUzNno1aGM2NktXdUZOMzV0NWlJL3Zv?=
 =?utf-8?B?U3cxRnZjay9jMFVuMUdFbjFBNmRkZmlERjBJRmZ0U2NVOWlCTmFDTHYvS2k0?=
 =?utf-8?B?d3ErUHk5Y3FOSnQ3ZE9HbjJvTkRKQmI3TjRTQTIzZEpyM2NiUWhUUjM4UVBu?=
 =?utf-8?B?Vi9KWkhHZ0grME1ZbU1NOGNUTTVjdHJ4YVVmUEJ5Lzc5WHVPNTZmRjN2N0NZ?=
 =?utf-8?B?MWU4UUVESm1IMllOYzhpcWRtVXdKNm9VeEdTSlllUDR1VG44cDJsTkNrNGxm?=
 =?utf-8?Q?K8Tfk5hnUyrgc?=
X-Microsoft-Antispam-Message-Info: KhOBSNydWeoXertkzKrcCuj2qdFJG984oq0yw6eb5DESPlKf1SOwtbIonpxOXGCy6n2Fpo+SlgGcQgrOr6uyVGzmu9ivZxrPk4wGEkUcnHIXJfGutCq08MkpIPYASG7aTLKobT11vo6HWD4A38ymAVCsLHCMJibLpMzpvZVB5NwwzJpBb8/sg1i7t0pOgEPITJsw+RpImcZC3Mk8t0asZM9hfkIZJMEvoYV6qfNt4aOH5Zv+U1E+SfA7pjNXQ8RKsUjzxtzjOtj4/EDtWg9GYaR4EhihHvtUAdzDcI6hOMcQBx60XeH8ZqL42RRbVcJx86RuSWqc5LPu7jWSF4wAak8p+N88raAHrlkw+Iouvwk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:oN93pS9EJrDL6wv7/vrl17h2rUoiyx6LtPy9MsGyO2VyvFdyPKJuPoEAS6YWBZ/uKh/4ZkwPFnb2Zty1VZtY22zwr0N5pwnacpGgTjgegloKK+kHZXNM76/Yn6Z+8qRmGS0Lv2LphfbdHO75aREHWRupPYpIlUoBFNnWBN4VLWIGI3TzSsP0L4MSs+G65emhuzViYDGW/2OtLlSVaQjL9UcgCCFKyM81M/usGZuuNdYOHfSa0Mx5LpnyJwKiwJaueVhGa1J8Oo184ZYkQVUOwwB72mY28FrjgMdTtfDkncXsi89kDboJTH612cPK5s7kSMmfxztYaWPhY3U73d9Wy9yE54CZho7s23OOxNeraNQmJtybStjMeYXHmUs9T5c0prvxIOeLixd4uT/G8eXRFyua9RXbS1v6VfchRZ3K18vyOVzB+KA+wRa+ff2zABUwf+YaPeDF98Zi+W6GD40oAg==;5:lTkqzmOL6KS2Ny21EeX/djImQ+ZEdpvB1wSr+ccQ3rYeSwa88XiAi3McGXHv2AHLnogm7haKzhSfz6CS/0pwTy+AaNOYes5otmsyyol+9lgrJ9uUaNoc0Y828CBNo++ZnoiLWbXLudXlGkyrLccLU37DlvEVcmxOSxaj53Fy9ZI=;7:EX5Rfu+7POOLII9uBs3OygFPmBRHrnPYJu1IRvVSMl6VKAgpc2a6C5lgC63Q7aPNFaaIBf4iMaPs3Yb013qMZ4UlyjXM6Ay51k1eeromBH0oJTQDO0rewi61B5r6Sx6ITdoEGIBpPSmczysIbtAjQA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2018 08:46:22.9696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e982c6-14a6-415a-7967-08d6448d7f0b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 11. 18 1:57, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>         ~               ^~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.

This is interesting. I have never tried to use llvm for building the
kernel. Do you have any description how this can be done?


> 
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-zynq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> index a0daf27042bd..57046c221756 100644
> --- a/drivers/pinctrl/pinctrl-zynq.c
> +++ b/drivers/pinctrl/pinctrl-zynq.c
> @@ -972,14 +972,11 @@ enum zynq_io_standards {
>  };
>  
>  /**
> - * enum zynq_pin_config_param - possible pin configuration parameters

This is wrong. kernel-doc is reporting issue with it.

drivers/pinctrl/pinctrl-zynq.c:975: warning: Cannot understand  *
@PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the
argument to
 on line 975 - I thought it was a doc line
1 warnings


>   * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
>   *	this parameter (on a custom format) tells the driver which alternative
>   *	IO standard to use.
>   */
> -enum zynq_pin_config_param {
> -	PIN_CONFIG_IOSTANDARD = PIN_CONFIG_END + 1,
> -};
> +#define PIN_CONFIG_IOSTANDARD		(PIN_CONFIG_END + 1)
>  
>  static const struct pinconf_generic_params zynq_dt_params[] = {
>  	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> 

This change is fine.

Thanks,
Michal
