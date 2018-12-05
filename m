Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0A5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BD72087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JAum+1P8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BD72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbeLEOrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:47:19 -0500
Received: from mail-eopbgr730069.outbound.protection.outlook.com ([40.107.73.69]:32800
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbeLEOrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az2AxLVae3Wyd0i5p8USM7LiwoGHYw/8EbxfHS3JTZQ=;
 b=JAum+1P8a6vI4vPOYv1VHlNnVhM6sFpnrzmLyZXTkvjCc588m6zYza06LimeS7pgEkaIgheglUMIN4F91IasYCK3AM7QlsuIwI2e8xXQjn3KUqr23NAregjmcpm6M2Ip3nlVqOS3W8R1pv2oj37w/dqzNFOIDuJIhGWqvLpKyVA=
Received: from MWHPR02CA0054.namprd02.prod.outlook.com (2603:10b6:301:60::43)
 by SN4PR0201MB3518.namprd02.prod.outlook.com (2603:10b6:803:44::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22; Wed, 5 Dec
 2018 14:47:11 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by MWHPR02CA0054.outlook.office365.com
 (2603:10b6:301:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17 via Frontend
 Transport; Wed, 5 Dec 2018 14:47:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Wed, 5 Dec 2018 14:47:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50428 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gUYSA-0000yC-C1; Wed, 05 Dec 2018 06:47:06 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gUYS5-0003NK-8W; Wed, 05 Dec 2018 06:47:01 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB5Ekv9X006345;
        Wed, 5 Dec 2018 06:46:58 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gUYS1-0003Mg-O8; Wed, 05 Dec 2018 06:46:57 -0800
Subject: Re: [LINUX PATCH v12 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        <mmayer@broadcom.com>, <f.fainelli@gmail.com>,
        <ladis@linux-mips.org>, <treding@nvidia.com>, <digetx@gmail.com>,
        <d-gerlach@ti.com>
CC:     <linus.walleij@linaro.org>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
References: <1543496278-6524-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e27c9c14-2b2d-3f8b-0371-9c82a0721b8e@xilinx.com>
Date:   Wed, 5 Dec 2018 15:46:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543496278-6524-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(54534003)(189003)(199004)(2906002)(476003)(31696002)(2616005)(36386004)(2870700001)(63266004)(23676004)(2486003)(186003)(31686004)(76176011)(64126003)(4326008)(2201001)(426003)(6306002)(39060400002)(486006)(446003)(5660300001)(65826007)(44832011)(11346002)(36756003)(356004)(478600001)(14444005)(316002)(9786002)(106466001)(65956001)(65806001)(58126008)(217873002)(966005)(110136005)(126002)(6246003)(54906003)(336012)(47776003)(229853002)(8676002)(26005)(106002)(77096007)(50466002)(8936002)(81166006)(305945005)(81156014)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3518;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:9y52JMmcRb+isdL/2DsIXElqMoy1Gs2RFdUwsrfW3aEMxcsJS+qyys85XZlZVUFYle5G9sMR40YxoKP8EoyfClv4caMU+KrG8xkF/Wv/mJvGwoSxz9Yq5L7Ddpk4ngw+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d69fd1e-cae1-482d-cf04-08d65ac08921
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;3:QqZoOEDCcRArzroaiyELdDYYxqj32PVitWuSoEIgZQVX8MQLjTF+xpB9306PWw7F33gWFt9d3yT+Ng13vywjb0reZ6vVy5BVHgk/BtwVVJb9lysM9VSOkKs/SAdWggH9SBLNBUSw0DB+1ljTDBCaAFGOwWgh7EtscF3AK79ViIX5hj2Q78tPLxOLaSW4Yed43Vb/8OM945/yWhc1WgoT1HnXnSo5XKmtRwnaQj6ocUxAi1rRxm59SsnVT9cvMF6vsfoqHd37NW0Uu7VNHrUnM6hz/LzSb7Avh2tM0uLCGQNxwqfAWtkA83eTTAb1lMvus/BQHNfmrmyTKJgMygvfO2j0fdW1sPqZAU6H9JMSEAw=;25:CtLajrOdYQ6yc/ZpPa+rB9NInRC1T85As1CZ3LiOAFHQ8xJFWEDCeRLKeanQM+UsFxV5nW6s7oO6ik6IirJDyanZhLC7NU/0+/FvGbYL8Brm9k/z94pVs3khoXHqpf8qjasD9eVvxU3UFQvKahd7ks2g4cMSa7asNEhPeAX/N8gffE8Gz9YEU+ZFBMSgq7o7X8jnO1wwlokfYLV5Yb0nxN05QdVavvJX/vE8eBchY85kRe4xSiTjI+PfAz7QB9hBlCoV/WQTaf+csQMGcXWv5vtmbnCVAd5eXZTDyreM+32/huPh8ecK3qwhwDsJ8Qgy8kpQfBr36Ag7hqgAiimyOw==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3518:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;31:do/rC4MPfNhrgHBfIeboTssXWYPB8S3SO7Kd0Gsbxk6XztmnzW0Kn+twzbS03Ss3dpirUWCAalVxbGsU/reelOwiayvLMHKphzaofZWfIGDYcv+RzJKQAIgAJLz6TQFa90xtq4dCzq/D6GXyvR03oidzVLO28KJgJa3U1pAbup8dV3FMuJcaoEkqWSbSVZL5Kej9m48I7Wqi4ZB1f1gPFBHR4U1Qaxg3HHxa8uMNbj0=;20:wMfbXN/ru2MxJ8LLdgWmxbOcHFcdN7ICtr7hc+ZGFzgQQBZx1rvPo4c7E8+dwVQ+mnwWY9fFfa19qhw0LNRYynYjIUmliIjucGQPJD19dn8uqAt48bIBb7t491GR6mcHTI7BQInkbz4pYzyGjHkOvICyCqnmvZgA8B9fICd9u5VoIk53kcECVC3Cc8s3ElNs/MdpZyOEqWKo/Xjwy691Rqin0ZRt5iQrFijX/Gh2I61SVm9++HQ4PbbnOd5uwCAKOXWM6J6jqwvRH87Pt7mcq5Z72Qa+UA7gOnMmuNvvTNIw6L0c8QxWN7cXUbEw/HESTK1qoNGlMERAGjqQAE+CwJp8k5+IglXSV+mR+9RfiR/mkqR8Mt02ij6GXm6JJPMUOZEH86KhsdWNAXOy/c72KN3kXcb0qvvsdfrPqXZ7EWS+MEGuWJJ76DrloSCeBLpUvg43BqqjaOxMCgq8nMO2Z2SvAT4+CHmtwxakDIEU9igCWBeisG3KRntM9GqBnEYu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3518030C98CA6962BBE0016FC6A80@SN4PR0201MB3518.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3518;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;4:vZ27lAFz/MM9/pqIm3e+JWasu1fxpSsRA75bQMHhbauMBoUHgJkZ2IYlU5xCA9xOhXxgPdAe6IZQ/HOR7Hhq/tANVeBQX4oeRiDiSu16dvFAcDXzt9vdBqaMLnQ2h0XQNzM0LU/iplexEsmK5z9JRpg+JbtXVbAwhW1wuEFpBqXlLII7LR5IzsJ6PDksRIKGwLirU6BeZGaBY45HPx9lPIjn+UxBGNPym21wT5kJFbgt0jlUjKLFQbWwJjKnSdP8nV0jOAIGxLu3jQuhPptCIQ==
X-Forefront-PRVS: 08770259B4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjRQUjAyMDFNQjM1MTg7MjM6dDA2T3NCQzhvS1BPbnVKVUNrTnAxMDIv?=
 =?utf-8?B?NTdVZlJKTWxQcFN0eGVkT20rbzV6NE9SOXMxMFlUSlV3VWh2MVRSNzZIclQy?=
 =?utf-8?B?alJyZVlwa213SjYrZnpnUTBXVGhuN3J4bTJuYTFWRnJFaVVtL3lCYVZLTlVT?=
 =?utf-8?B?WWxaQzZjM2JpUDYzQTA5dE14K3F2eWZQWldGbWxjTzhqcW9RN3hqeGRuYVdX?=
 =?utf-8?B?UXArb2VQMVMrR2lCRk5ncW53ci9FRnV3azlZdVorZEZCRjduM2pjdkxMQ09N?=
 =?utf-8?B?ZkMxK3VoTmhoTzU5eHN1ZSt0dXFLNmE2YzI4NFlya0NPUno1Q2tMYWR3Rk1w?=
 =?utf-8?B?NEVYRFNUMDlRMzJhSG5tNldnMWpCeUZBaGdXNFZ1WXkyMnlkRVdrQVZHdG1B?=
 =?utf-8?B?MDJ6Kzk0MHVSSlRFODQ3ZysyZWJtQTdSSHpSSUZEeVFGTWxxdXZzUm1oSjV3?=
 =?utf-8?B?U1FWclRwblh6aDYweC9TbGhxVmVSd21YZkhFM0krbXZ2MG52Vy84K1BZanJR?=
 =?utf-8?B?Tzl4dlJvYnhWbEs3S1A2RVFSQzZOb1pzb2ZCMjV2VnZEWTJlcGNGck45SU44?=
 =?utf-8?B?QkRneklXUGo4VVBkc0dzZlY0dmRFaSt1Tm5UNEpwRXduWUpsV3dqWVM1OTJ5?=
 =?utf-8?B?SnluZjduSFBSbFlGcWY3eHBabHJNMVFiVGxGSjlKSW9uVlI4Y0VTWUEwN082?=
 =?utf-8?B?OTBMTmtaZDU5Q3dQZW5FL0x2TWtQMkZOdEJvRE1qL0tJcmRkUjJZWndTdEMx?=
 =?utf-8?B?NGhOOU9GeUVPdWNySVB2SGhzT0luVCs0MFpySkRvZWlXYlFYd3N4ZC9RSklw?=
 =?utf-8?B?NEF6MWozeGpwZzhzU2tPS1h5L0c3OG9LZllrbHZsdTJoNytVbElPc0Zra283?=
 =?utf-8?B?Z0lsdXJyZ0tOcEVoRGxjWGgyZHRzWEFGS0RCQUFwVWNaTmtwWTNwTTZPZU1h?=
 =?utf-8?B?K2JHRStFQ3h4VEdWRlR5b1d2YlZtVURCMXlVczJ2dXJGU3FPRjhFS3dReno4?=
 =?utf-8?B?Nm4yUUptOElDajJpalFLU1ltRU9YOGNvRldpRmpmcmUrTzJqS1ZZZEtKL3BH?=
 =?utf-8?B?ZHM5Wm5IbzdzVXBtY3dBblU2SzZJOEt4b0h4V3dnTzd4V2Vnc3o1aWRGUTBF?=
 =?utf-8?B?QVM2MWJxczlCWlUyWUQ4TlNtS3kvYk1KS0hTR01WaXBBMlVmT3ZweDBBbUR5?=
 =?utf-8?B?NEJGTldzTktHZmZHcWJvakhNWFkxOUhCa3Z4R3VITnBhLzZaVnQwdkNIWjRN?=
 =?utf-8?B?MHJ6bkpoSXdqWVl0YXROWk0xSXVEcFNTOXZ5b1YvUFUvV3hvRHdLc2ZVdW5N?=
 =?utf-8?B?QVhweThOVEZocSt1cS9BZWJheUFCL240YmQrS0xzZ0p4UGRNUGtSWnNvUHRm?=
 =?utf-8?B?a0h6R2poV0d4RVQ0aXpuN3dOd0EvOHB2YWFJVVdFei9kNGFZSERxaURNd2Zk?=
 =?utf-8?B?Ujk5OFVSWDgwaFI4Umk1eGJONUkzZGltaWtJZ1NGQVpBVHgwRWhLSXlaTTI3?=
 =?utf-8?B?WEdLRHA1S3pJaVRLeUcrcXNwQWJEaERPaDhvbXN1N3hzOXdReUhOV2NVM2pm?=
 =?utf-8?B?Rk5GSXBQUDBCUjdOUWdHMTZuSEQ0ZkxTeUtGQ3NlbTVPbjQyT3NmejhFSjk1?=
 =?utf-8?B?TEhLYTlzaTYzYzBaaWlqN1JEbUFhaEtwdVNqUVptMDhzZWZraGtsRDY5UEJR?=
 =?utf-8?B?b0NLQ0hpY0FPamkydGVGeHM4dTlBL2tzcThNT0t1azd6WFZWeGVwZ3oxcTlR?=
 =?utf-8?B?RWZUSHVvT1paTklobU81SEdUZXUvcmV1TXJ2WWhnQXpYV29IMyt0MWE3dEwz?=
 =?utf-8?B?WmFrSGF4ekwvUUlzVHRKcUZNMHNzL1lMcG5KYlp0eXJ4ZlBCTFYrVFBEYlNX?=
 =?utf-8?B?WEd5UTNJRmlkWWdReHd0YzVZTWptU0J0c3dYNjNUaCt0WFVtVEJZSytrNXpu?=
 =?utf-8?B?VVFNMXdvNnVGVVE9PQ==?=
X-Microsoft-Antispam-Message-Info: FEfD8e6Puqw35OVUov9O/vc1RDIij4QN8dRBZA2o1ggAviZzAu9lonfuUy+BPXgZUy6nCrsAcbekbrVq+R/xmSJqxBeaOhu0hS0XtZ2YoypZg/SKTMt07IYWRUk6SXCo9liWLJcSX/5IIBkCWZw4N1GMhRDxLPxNYFycSXlDddVT0pbIhPBn5mUjCiWXwH6cmYV/yTmvOeP0zUcu7QIrPJ51tASjO2uual544aWn5pq3Ioayt9KOkxasYHNffDehvnBPimrTG9EWU1ljdtVT8YUg7X5D3FOegcApNdHhbnQOJ0WwD7xZcmu++WSVGgnV6h3cK8nkpR4i825QpoGtSRQDIZimd4ofBFLs+DDwlC0=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;6:UE856dIhp21uYjDxdhA6yVqujsc9Yx3CVU6bz84L4HimygXrX03JH/KyVB7QS/DIPghULUNCUMUSALZsap7RtaWjB5vILxZpBZK33pGCuSjBZkeMSKZhiE1WMoULAMiLtiGfggI+9TJhUh9HOqpS/hMOCDZ4NIN0AK/9hSNcX3/9zI5I+xAlR/fjVkvVu5bt17g+RwyRp1OGLN+0gcbltl+zxbANyRyy9WsRCucGQIbgCtpwgC7B/RirpaEuN7c4RtXhnskAYSeb8w/PchYlusgS1zRyQnuw/5tzFwuT+ix1yDbi8tnV1457lRPlQGEMJNuT1FOCoNxPNcRvCffcUrfMHpGP4E46Q2/YUUsrmk+tEECSNYEcWMqQCIZoh0JSBiCLPcdJDd8hd3H7Ql4u8jeJKN43jMZn0kfUSXCTfRyiKJdIIiyvAXVme4at/dpNFdtuItV4dl4aNgvYFQM2MA==;5:zA0/t6yfBL1EVGHuoLFKKFd/q7DHyVT/Tb4mFJuPGuhWXK+z9V7Oe2hSEkyY6Ub6yvvgS54ACbxAA5tFlNvo/Rzw8fP26FMko6uAnbL6W1Kw1B7W7Uiw2608n7p4HXp8f1cLXq0Ly1NVUwdOvhzS40zriR3tbv6o56DRNjrLdHA=;7:YhUH/z+y4HxOCAxk8Fs40aZUKmY3JhvZSXXr2zjPYbVUfNajcifzoOrABUmOStigwD6RLdnw8fohZzjviNNRaYqUvTndSYu4sBRnQQDqt4wFWlPolFR1jRZI7fJiHQi1AdGrHi4ptAZ1+d9bRMPe2A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2018 14:47:07.0574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d69fd1e-cae1-482d-cf04-08d65ac08921
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 11. 18 13:57, Naga Sureshkumar Relli wrote:
> Add driver for arm pl353 static memory controller. This controller is used in
> Xilinx Zynq SoC for interfacing the NAND and NOR/SRAM memory devices.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/memory/Kconfig     |   9 +
>  drivers/memory/Makefile    |   1 +
>  drivers/memory/pl353-smc.c | 468 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pl353-smc.h  |  30 +++
>  4 files changed, 508 insertions(+)
>  create mode 100644 drivers/memory/pl353-smc.c
>  create mode 100644 include/linux/pl353-smc.h
> 

Missing changelog which was there in v11
https://lore.kernel.org/patchwork/patch/961604/

> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 63389f0..2d91b00 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -145,6 +145,15 @@ config DA8XX_DDRCTL
>  	  Texas Instruments da8xx SoCs. It's used to tweak various memory
>  	  controller configuration options.
>  
> +config PL353_SMC
> +	tristate "ARM PL35X Static Memory Controller(SMC) driver"
> +	default y
> +	depends on ARM
> +	depends on ARM_AMBA
> +	help
> +	  This driver is for the ARM PL351/PL353 Static Memory
> +	  Controller(SMC) module.
> +
>  source "drivers/memory/samsung/Kconfig"
>  source "drivers/memory/tegra/Kconfig"
>  
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index a01ab3e..90161de 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
>  obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
>  obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
>  obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
> +obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
>  
>  obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
>  obj-$(CONFIG_TEGRA_MC)		+= tegra/
> diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
> new file mode 100644
> index 0000000..6738a84
> --- /dev/null
> +++ b/drivers/memory/pl353-smc.c
> @@ -0,0 +1,468 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 SMC driver
> + *
> + * Copyright (C) 2012 - 2018 Xilinx, Inc
> + * Author: Punnaiah Choudary Kalluri <punnaiah@xilinx.com>
> + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> + *

remove line above.

and then fix these two

CHECK: Please use a blank line after function/struct/union/enum declarations
#359: FILE: drivers/memory/pl353-smc.c:299:
+}
+static struct amba_driver pl353_smc_driver;

CHECK: Alignment should match open parenthesis
#369: FILE: drivers/memory/pl353-smc.c:309:
+void pl353_smc_init_nand_interface(struct amba_device *adev,
+					struct device_node *nand_node)

total: 0 errors, 2 warnings, 2 checks, 520 lines checked

NOTE: For some of the reported defects, checkpatch may be able to

and also
this doesn't right too.

drivers/memory/pl353-smc.c:308:6: warning: symbol
'pl353_smc_init_nand_interface' was not declared. Should it be static?
  CC      drivers/memory/pl353-smc.o
drivers/memory/pl353-smc.c:308:6: warning: no previous prototype for
‘pl353_smc_init_nand_interface’ [-Wmissing-prototypes]
 void pl353_smc_init_nand_interface(struct amba_device *adev,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/memory/pl353-smc.c:439:34: warning: ‘pl353_smc_of_match’ defined
but not used [-Wunused-const-variable=]
 static const struct of_device_id pl353_smc_of_match[] = {

Thanks,
Michal
