Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1023AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E36214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AOKjwyI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E36214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJJPBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:01:51 -0400
Received: from mail-eopbgr700045.outbound.protection.outlook.com ([40.107.70.45]:50712
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbeJJPBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb9bzpm2JeuWuJIQ7NsB1qgGGaTlTGovu4AmKs0Ez8Y=;
 b=AOKjwyI+dg8ksGtKQ5Kho3N9chAv76ti3JiQmxG8zh1scEXB8uIQmJrbr2+HFeMXP8RayA0tN/kMXm5RvzeXnatRkQaQ5Omankt9ZqoMTdlStcN4E7/olkpu5eub+nrLZ68yDdhRb6GvtpCTJARmdcoACtPUzAv2zCBT2MNLPtU=
Received: from BN7PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:20::49)
 by BYAPR02MB5223.namprd02.prod.outlook.com (2603:10b6:a03:68::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.18; Wed, 10 Oct
 2018 07:25:49 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN7PR02CA0036.outlook.office365.com
 (2603:10b6:408:20::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Wed, 10 Oct 2018 07:25:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Wed, 10 Oct 2018 07:25:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53727 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gA8sI-0003c3-VO; Wed, 10 Oct 2018 00:25:42 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gA8sD-0003Jj-RV; Wed, 10 Oct 2018 00:25:37 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9A7PRZp002232;
        Wed, 10 Oct 2018 00:25:27 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gA8s3-0003Ht-AE; Wed, 10 Oct 2018 00:25:27 -0700
Subject: Re: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <robh+dt@kernel.org>, <heiko@sntech.de>, <ezequiel@collabora.com>,
        <xuwei5@hisilicon.com>, <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <daniel.thompson@linaro.org>,
        <amit.kucheria@linaro.org>, <linus.walleij@linaro.org>,
        <koen.kooi@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
Date:   Wed, 10 Oct 2018 09:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(54906003)(110136005)(50466002)(14444005)(9786002)(106002)(63266004)(31686004)(44832011)(2486003)(23676004)(4326008)(76176011)(6246003)(356003)(65806001)(65956001)(305945005)(106466001)(8676002)(81156014)(81166006)(26005)(7416002)(8936002)(2906002)(230700001)(64126003)(575784001)(36386004)(478600001)(229853002)(2201001)(65826007)(186003)(316002)(31696002)(5660300001)(2616005)(476003)(53546011)(126002)(77096007)(6666003)(47776003)(446003)(426003)(11346002)(486006)(36756003)(336012)(58126008)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5223;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT004;1:62SxSGlL0hGWSSVdbwpvFjvHZvZrXrzyW/sZA9yP1PKHYtPMeHMNsQ/gyWW3RaNl38U6f7XKLrFSzrL9L4/bROz+qsRJrBwOBT5Cat/L7HpvdKDSMH1Cn1bhmfCLOh9q
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccc0e3f1-508c-42f1-4417-08d62e8199b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5223;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5223;3:dKNk5vQMGfrhRsqclBaFkJ3X32TsnU31D6UV5Zckjb7EzrkSTOqsxjpYMyj5M3lSHVSax/cPZeNEZ60UeEUlNgRXXEjGEYiK9Hc/lA2inWQvIIEweIdZtHnje7JBD23eiQxf6b16XwNfmpWmcW/mtsTvyZsNFja3qbHXUZJc0b7ee/wmKBSugrFQVMVIboEmt2O5bOeuHRq036GEciGg7WLZ3nLTBOLst1rhFwGO8UXcJ0SMDRoxcG/+USVDOGkh9ptu+tyYQWoPJ/Ybo+jm0ThyYSWD16HR49lVWFf69Rp7LpBDI6ZaYqTyi0SRE/BRz3PtpsP0Tgb2feP6ftuK7wM+HL2mliJrpqGwrUty5kE=;25:XxsfmQFGUn+niIoiBHovQzvsyJKPVOgHkvdDIU0nBVmqvDc06HJ6pQWETTZsa/eDGoBeYBIvzns4Cp1RuWRPd0o328SYUY3m6uMKVmNGp73hJ8cjJrNW4ZbyU/aGjwOdn+CkyxQwJ4srkU90lWpB6otTtHwkxS9eB7Wf4PLr9bswCMae0uuhD5DXdJ13uPnNFWdCdqJvrRpJn69mc7ahuXTsJidkMgK1fqm7HuBuaI2LUvEMGXbPAo+z/cwV1tT0hSTjNXP6UwaMf6xK6qXDgGpzZyTT93I/S666pAdu/KKTxdV6AqZbBWEPLNrlQT0kt/zC8mn7/VxkQWvMd6ypVQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5223:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5223;31:Us9mdkwK7Se7n7JiPn7I85bIoOQbU2hOQELZMMOw9LRs8bWDiI/Zi1T2e7J05QgXinVjrROYNH+7/UdS4+pcEE2E4s7agz3IflfuBMAQ3aer1XTC5Pt0QVx69vsRtBWtzBIIl5EQ3zj4Va8mkChZo0c5uFJiAtZfjWbHereuDuTMHJgWSQ9YMCX2af4IrtMC/M9UB/ny+RYRcrpWt3Fjttd4ocwk6R7qAMkQG1uP1aQ=;20:Nzto0y6EWls8Ltz8q5LiTnRX5M9ipzNA7eKEzkdajF1Xw1Qpft/Kztjc+Z3y8FeM2gG2ArQ4fc5OtHOduokfN+HeXzgico6lIFrnlR/0rCGcmSNbsje4wwk61wfjAwLYTzQPxgaad+2CqDnFrAuITxfM149NbtnoVEe9XnIm+OREQXqT9lG/rFGK9i3r8Ivh0H53GLhq5Q8gNacGnXqXprAd1cC87rWhWg4uicKDjDuwJRx9nMdcp064UuD/qDq1aynaMoqNYvfzz3Z/e7XfYBBQw05aulmGGUDoD1bOIS1qi1G/MH2SP7TcirkP2QpWBQ3SZ1z0za1Vt0snSmUWRIpUxu3htah4T4mv+oVs3Cbd4VhVcnj+0gfQsvLvxGm9NNmmoe46XZRyBIIojK3sEXy4dZ1DAnPfuPYBSrho6T4UymMIMDhcHBpZUaxqGM92nULL0kPufY65T1rjesD9VEes9ULyRmAnYATe96/8GeanXf/VAxKCPch3Ka1W/QwD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB52239AE31D022765B2A966CCC6E00@BYAPR02MB5223.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR02MB5223;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5223;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5223;4:JxkzpkRotAekdZ425lIctJJn6KXxfQbAHw3aOSXfv6vk9pbOHo/PIMZX6j6zA24PvqQT7PuFDRpS9iHHW43/+MzH9f1p3VMvWRxvoKLZ4JAgQesnG3nhupg69O/fG9GQ4EHNNn35vWb297/v6BryWbENgxObA+O1/+nRrpckPoHhieJsC6PNtwY9Ttv4FrZfndyrkJtZp1Q79loVSsjVmFkxlpU5L6ULmYaz0j7ykRAs674KDp/HSgbtG3MkYdBQuwvBtHrAZjfmmIKiqLpIhg==
X-Forefront-PRVS: 08213D42D3
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI1MjIzOzIzOiswL0hLZ2xWY2RRWVlrQmh4cTZ2TmVyM1BO?=
 =?utf-8?B?bmYxNGRWY3hKTFlFb2p4TFMvOFAyZ2VqY2d5ZmNFUXFnZ2lVSGx0TUN5elND?=
 =?utf-8?B?UytRdnVXN3BkTDJVSmhwK21xejRwTkxPbHNVdUMwVzcyampDejZHTjNHVWVB?=
 =?utf-8?B?WFdYN0lTZHdwckxjVXlIRi9LWEpsTGVUbzZlbENWd1pMU2MyNDA0ajVLTnlC?=
 =?utf-8?B?WnUzM1dNU3Q0QjZlaVJJYkJuSUFXbmhpaGY4TjMvNkd1WUFhYXMrbysrZjhE?=
 =?utf-8?B?SERFeVludmI4V3ZqMWhSN3JoVkJlcy9IdXJYaWVOY201ZzJQRzVZdEcxNjhz?=
 =?utf-8?B?YStRZGRWVHpmeHNpTkZjSThFd1Vqa0kwSFZTNXlCMDJzN1dscWxWcnFva0ZQ?=
 =?utf-8?B?TEhwZXBYNFgrT0VGZ0VYZks5WDhxNDQvbEZjZk04dUsxc1d4dmFGT21CNkVP?=
 =?utf-8?B?ditud05NdllwM2dSK0xoZDRJUXlMaS90V2FOcUZXNVRLWVpHaEFYYjNQRDNs?=
 =?utf-8?B?VW9JQ1VESjY5Zkx1TUNyVVhnLzZ2UjdyZVQrWDRFUVQvejZBWGs2WjM4bUd4?=
 =?utf-8?B?cEdDL3hWMVlFYnYwUkhtZS9IZmtQajlLNDd1SGNtQUIwTFpOeGxlWUZpUmZ4?=
 =?utf-8?B?S3g2Vll4THB4Nncyd0R3OFIrYkFLZTBFQytDRXVxUjVMKzZFY3RpaGR3YkhM?=
 =?utf-8?B?RmlaMmpseFpJM2tHWndhaXQ1VFh4TS9weUYrTmpGbGNXWjVuZzdwdmR0S0pX?=
 =?utf-8?B?UCsvY1kvZVR2ODE4TVJoTXJUem5GK3loL0xKNStNZG1rOTh6OWxYRVI3MUw4?=
 =?utf-8?B?dVhmek5nc3VqcGsvQmplczFEK0NGVUlWVnNUNzBDQlpLM3BlL1hkNndwQlZw?=
 =?utf-8?B?czFKVzhPQmJtN2FqcXdSVnBWVEM1NHIremhpeG5YUjl5R1FmRzk4dkdxcGFF?=
 =?utf-8?B?RXlaNnZPTnJFNjF5c2s3SnV3enNUdHZkM1N6UFVPSmV1aFREZzhyNVRzUU9h?=
 =?utf-8?B?ZVpSZHczMXd4c0NSN1BxVTFpMWNIRFFJUkJhRk1jTDNYWEw3eG5IckFBQ2xy?=
 =?utf-8?B?blZPK1FYR1FiYzdHZThwMVU3bnhuRkErR3I3L3lOb05pbkxCdmQ5OFhjNUQ3?=
 =?utf-8?B?aXZ3Mk9qamwxcUk5QXoyUzNpNnorS1JqRXlJQUZZSHNMOFJRN0xxbzM3WTNU?=
 =?utf-8?B?WWFWKzlqWDVocTliSHFyT3IyVEtaSG9XQ0hpRkk2YXR3a1c3UDdGdEpnaGN3?=
 =?utf-8?B?Q1hBOWZrTE5EdzBQOXZiRDM4ZlFDT2JxRWk0WUVUWjUxZ3pFWlRucTJleG03?=
 =?utf-8?B?eVFTRFRGMysvT3BKZ0hlUWEvaG4yOHhIcHFXcFdVRm9GM1dtaWFMSzVBWE13?=
 =?utf-8?B?RGUzZmhQYkllbkJ1TExTZkU5U0xOWmk2VFBDeWtwZEFjTi9HdFF4V3NoS0NQ?=
 =?utf-8?B?TyswaXR1WkpHMS9jbkplWlZDTkg1T0RnaUt6OE0xdzlvNk9TN2R2VDN2MVh2?=
 =?utf-8?B?OTlocitpWXFNL3NzTVNQVzBxQUxLdmlSRlhkZDV3MklwT2NkdUhrSWdyM0Zh?=
 =?utf-8?B?ZHg0WHc2S0NRdmVqUU9zN1FQa3BWdm5FUU9qdU92djNxSVBmQkpYbEVBWHBB?=
 =?utf-8?B?ZWg4UU4xVFlhRHZaSUJPMGdXV0ZZODl0MjMxdGRYRmw2SVU2VlhxZGtQaGxt?=
 =?utf-8?B?cjdzb3dNcTdoUkRCUC92M0owNWZIWnh3Syt3RE0vb251eFBMK3hVMzdyQ1kx?=
 =?utf-8?B?dzRWN2NybGVmUDByRmhtVzI1TzJpdFNicnJvV1hQeVI2RmZVUmhTenpZZU1s?=
 =?utf-8?B?aVpMaTdWOEsyaWp2UFJpMFJROTJKNGNkQTBBeU14YzRpUUtlWk84WUZQb0Mw?=
 =?utf-8?Q?ui04zx4e0SsMpiSd+ZFbeUkjW/AW735f?=
X-Microsoft-Antispam-Message-Info: pYz7JrSai4l3VDXUZpge5kKwiJaqbX6IWiKvE028c3Z54poq+l0EheJe82IWcxKhDah6VjE4j+YH0hVWZmQ6nDHm/jTc/Ok04GALjJ6IG81QN4iVexrVNZ7QlH7ncFkyY4lbWgQ0+x/5gFy24ITA9qraYqTBq4ig8ToSWZMCVLelk/kXoa0Qv9wBciFfD8uOXcV70y7W+KYmEaTHWti49HtoqDof0+rnHYo0Q0Znzs1Sbm0GpH5n6SakbiO7+eYIBS6JUduBUt/Wt1CyhB6a24UhnZgsimQASouYxxnp10Gfb7+ao0f/B3ik6SEkZGtwoUYypvdcacI892ux1UUEstfEKh9U7xdQrrRb80tFeTY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5223;6:SYqJUf3Fn+zHAXdk9T69M3uSjXp5NYERQjEs/HdfwwabFZr7AGW4LlmhyH+PAG23dEsC/TuD5Z+Wgmg6jyFYSMawd4dA8/JKWoxEpYXP/LbFGf3dQtKWEcMB806a/NlfmZOuMvLE6CXyJK0xoDvdXlZcBDg2oUHw1Z5AdAxdnv8VyvSw1vrOpP8d4WaL7MJ0FM9v12EeP5sW0CDq2xPMWlhGiQmFUmaCTRF+9jJTd5meyPAmCBL6DvOgSKJ20fFuf0WRZ7zsjrzRlCIqpMzh1UkDgKNIQL3YyaNHCBZpTa/iIzi7vQzyE5DL5c5oPAnCvn93zCsotc1VEoCUikKR1qbIO+SO9fZ/5kGK3y/LBPMnuu4zDFWO0/I75cgcEP6pcZ5Zclj7MDyOQqG5oIOHmTqewL2zOIwS7fDgohlRcIrvLcUkzswJjYrcYOeavxh8T33ztGeJd/Rc6QDo2IyuhQ==;5:x4CPC+K9P+7PD8x2jFQsBWx/Cf01y7sez/tW0cvDHplj9NIeBfnbTkbRM2yVvI5bjMahxf1GsdFYt7UF9sDDGh/gcuguah8gACRSNqcEodLl5jCMnEYmiax+ULpXYQFfaU4JsqxkObPCWbYTH5b1446x+HSW+pPvIkoYj+Fwo/o=;7:eXoah/l6SAq1DvjEFuLBd9cZead81eWmBMdK1Xu7Gas9ufF8sJNgM1XIDzdYhB7PUY1+7Wt78b4QdiF88wxkOFQ8OozzwFxnhQZudj/1Zr5yZ5UfiDzoakSS7qvkKgTC5HylF9ToYjUQmtqWc9nnPkMqaieGIC6ij6FXHRpB7fhLRsjYbwy/XCaADBR2eE3VC83rDD3jdDVomY9XtjJF064tG2KZthHekm22zcXvDRAUUo5ofq8Gpnb83UPw8LpL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:25:43.6444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc0e3f1-508c-42f1-4417-08d62e8199b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
> For all 96Boards, the following standard is used for onboard LEDs.
> 
> device-name:green:user1  default-trigger: heartbeat
> device-name:green:user2  default-trigger: mmc0/disk-activity
>                                           (onboard-storage)
> device-name:green:user3  default-trigger: mmc1 (SD-card)
> device-name:green:user4  default-trigger: none, panic-indicator
> device-name:yellow:wlan  default-trigger: phy0tx
> device-name:blue:bt      default-trigger: hci0-power
> 
> So lets adopt the same for Ultra96, which is one of the 96Boards
> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
> consolidate only User LEDs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index eb5e8bddb610..565ceb390f99 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -57,29 +57,30 @@
>  	leds {
>  		compatible = "gpio-leds";
>  		ds2 {
> -			label = "ds2";
> +			label = "zynqmp-zcu100-revC:green:user1";

The purpose of this series should be standardize Led labels that's why I
would expect that leds will be called in the same way on all these
boards that's why I am not getting why there is board name.

green:user1 or just user1 should be enough.

Thanks,
Michal
