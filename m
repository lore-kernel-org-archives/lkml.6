Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4277EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC432214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nQS0wmM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC432214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeIQPXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:23:09 -0400
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:11072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbeIQPXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ERNdLAaIKTPYiMymcGlUM+C07tzdEFpaTWmyYEzO9A=;
 b=nQS0wmM9tJ/CiGsPlWP790lZa+LBAmBXH2cDcL7M3Ym3LB0ZjHuyPI8r7nFzejjcfsF4fZMsJfaKH3jI7ahawVCh8TYim+R+dQOO9o/urpFVTtnq3/0te3OkFjjNt4IGR8tKPxKB5gcl4gRopOAN9ROxvqvycB7d4dksPjp7E1Y=
Received: from MWHPR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:301:74::24) by DM6PR02MB4475.namprd02.prod.outlook.com
 (2603:10b6:5:20::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.14; Mon, 17 Sep
 2018 09:56:23 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR0201CA0011.outlook.office365.com
 (2603:10b6:301:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.18 via Frontend
 Transport; Mon, 17 Sep 2018 09:56:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 09:56:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g1qGT-0002ey-Iu; Mon, 17 Sep 2018 02:56:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g1qGO-0004Q5-En; Mon, 17 Sep 2018 02:56:16 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8H9uEnY019879;
        Mon, 17 Sep 2018 02:56:14 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g1qGL-0004Oq-Vn; Mon, 17 Sep 2018 02:56:14 -0700
Subject: Re: [PATCH v2 2/4] iio: Documentation: Add Xilinx AMS sysfs
 documentation
To:     Jonathan Cameron <jic23@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>, <sgoud@xilinx.com>,
        <anirudh@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
 <20180916111242.73af71ed@archlinux>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <cf2acc8a-ed2d-27f4-ca58-3e2132e17d2a@xilinx.com>
Date:   Mon, 17 Sep 2018 11:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180916111242.73af71ed@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(65826007)(54906003)(305945005)(229853002)(5660300001)(47776003)(336012)(6666003)(476003)(106002)(65806001)(81156014)(8936002)(356003)(7416002)(44832011)(106466001)(11346002)(4326008)(65956001)(81166006)(6246003)(2616005)(2486003)(316002)(126002)(486006)(63266004)(8676002)(446003)(110136005)(426003)(58126008)(6636002)(76176011)(9786002)(39060400002)(230700001)(50466002)(478600001)(53546011)(36756003)(31686004)(2906002)(186003)(31696002)(36386004)(64126003)(77096007)(23676004)(26005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4475;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT015;1:9vbJSQlJmZeYkcItEOJUdBTY4xnikK/+oxKTdaKHS+05tZtwAfH1EwyHqpX68Cg33fn+rOwPe+CmfgoqE36ZIHOnmgOC3KKEyOhpAW62qkPN0mH3FwvV8uQlFTHLRmHD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0365e581-1b72-443a-570a-08d61c83d2eb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4475;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;3:1pdybGXT0iROKc0wT2ewpKCnGjUjvN6ZMAgiFdZN/cVs8BW1U4chN760cFlD6XCnYOGF16H0/aWtKbDNepw1mIqRWVP4EyWgKN5Fm/+EhZRVLyc9Dr8KV64HeWCsc+D5sqAtKYWO2uTcFFwkRHEJm4piDUhqA364tyc5J1TGF3klhIyflewGgIbvega1H8ZpRA9lCwXY8WuKcOYEAkPxzauH4DEtw3ZSuHcJxqXeXnbWyhcvD7Vh3Ve0WggGQFrC2z5QhTe3nIdL84el+qnO174jb6NHZiNXw9bbaOxFsBfogUB8qgIZpGISzlg22Koh3VGodUYcl2a+QUR3hMj+IQWzje/9Re/+3/3XxXbT2dE=;25:1STNf+uA1u6bU0KbH1KkR1aAu3uH4nmhcCQcbnhWe9D+W/8ZoXF35TJnK5LOluVFVlEp379w/WozuHkj2D58RqN6uerldfjXwC/qyS0MxoGzXvH7X9Ba4NvCKNooj98orOxVRQrbjbgDPbdiN1iJeOm3MvHt1a+/0yStTcxTYsrxf+z7+fc0fNS6kZBXlJX1u3IYuW4Xk+i911pURF9eFp4ArmyXkNAbl5BAEMJ+yzQ+SygqJjCxXNRoVBY89e/Xp1Outz/OCjXMT00NZvuBg4VE8L9Y1dMpdC2pgcAuDAz/4I68CPn+0EkoBlaLDUdRbTVrB/B+qUJReUJ/vsGC9Q==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4475:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;31:QvhIotAbVXWQe1VCMPDGyLP4j1b3Qy0UA0gyDGpkRn8lFSumfVz6OpBn+bF0TNUpgeZmH6/D3Z7EcSSExhmOLMTduKFyLI5WEzN8OK1gq8v6/QucdHYiYuKuqkVaFbotqUUmWkDXeVZbsD8QznF3URyhc8HdhqioeRk3nb5CnmJlMWxuOkzstNz6ms/NMjLmNPUB6PrPHp+cn1c4Op5O3o3qJst0QByHjRfFv5QOcxA=;20:4aEcbLfvcsbXX6afIV0DdJ+EAcSjfvA4dHjZm6wpPVmWVgxrTuTzdCQNvI1K3sfSBIPRZ2ENqH1RC2pB99Gm6zGIS2g5QmZhULpuCDqussp1MXwhaMczh4tmLnnCKB2lqmv8YqEwbIPIRu3l62zfrgtclRSDddfBmP86DGtppp4A+9uCMWwlYRRcTynODvH2OExPlAwkWdUHEjPYFVG3uH/gA6shWjEEULEn2xaRoIi0YZZX6TUloz5UAqhMPWNUuYer5EVAgAcqPO4snivH+AmBgFejmlAZlRHNZ20KvQGK7Wji1DRrnXUcIPUECfPyNq5G49mi+3znw60kfAkwj1NCbUjeAitZL/p4ayS9SjFOBq7ogYxC9oTziaMkZRigNa/nQlYoaEiSm/aKBczoK8kIkL3ltwP9sSHoV17pjvnwirEM+ITi4i8tsxPn5QsklwucIY76E5HWOAYHHsYeyYsQBwatr41lkYtsGgy3IQe983Ce5sj38esSHqDlcP2X
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4475C5580BD15175608DBC27C61E0@DM6PR02MB4475.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DM6PR02MB4475;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4475;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;4:OrrJ5OhQeKY1R9J141c+h9ey592Exaxp3eunV1wnCHVhWCXV7apP4pbR1/OBwJWS6dmvjs9lN2Cryn7Ade1u/5zKT5UjEORaKvg/xVS4e59+WgBRMJ4Dk6KFVfVnbeD6/tiWAoRGAkMcSvtaujApouXc3tWp1WyKl93R+BL4cBJd5cGS40xH7LFpDvoBnGSruoXrXZCqCxr+KLk22Yz5z5d+3RCVZNlLgKzRQEbr0vfCwIoHjY+unKHgTd3oRrl3iLxyMmbHEBjvy7JsEvaLTcBv6vz8ly+yUcZa/RYbPgxFkiw5IMV2lausmd7o2oVdFzQl4c9xh23wiDGPZ8eymEeT0QFYzz0J0vt82UIr6wM=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0NDc1OzIzOmozbDNEWWRSZk1HWGNXRkFkWVdGZTJZd2wv?=
 =?utf-8?B?cXRVMno3eU1hTEpUOElFNzlVYldnYmcrVlVsUnplQ2RMMWFjWEJGQ2hCV0FC?=
 =?utf-8?B?M0J6emJXbGxZU1pVMEZCYnEyTG5VZUdkZkRxdVdqa25VeGVZS1B3RjFvNXgz?=
 =?utf-8?B?eDFVVWRzbXlSc2xDdmJpak8rNGNXeDZjN3dEK1prSEtDMmg5NWw1TzFwRUox?=
 =?utf-8?B?K3FvY3ZneXhLZWliWXY0TE9KcU9iWFBFUVBLcmdwOXFQRG90ZnltOVZXYXlh?=
 =?utf-8?B?OTF2QzBBOEhxNnEzSWpySG1JY25HaEZPcnlnYjliM0tCTGI4dGxZMzk3NGg0?=
 =?utf-8?B?N0Q3TVlrN09GTU5RRFM0czJ4WVM2L0t4WUs5bFdQTGJnL01idHpkdHc0YUxT?=
 =?utf-8?B?alR0N2hRQ1dPTDlMUkZaWFNzYVZ6SWQzNGRkdXVQbFl2NFp2WUhyTFNibm9P?=
 =?utf-8?B?cmhQVDZMaXlNcnJjaVF2VHc3VmIvOEJJdzdDMmI3WVltRENLQUhuOWMvMEtn?=
 =?utf-8?B?UkxmRUYwSkI0NG9nOGlsK29vbVFEZlp6WVcvWWliM3NmLzhRTUhKYi9MRzBm?=
 =?utf-8?B?YnptaFRscFZqMnJxMlpMRjU2MXFOekVGVkFqS2c0enR6Vyt6MkpheVA1bC9U?=
 =?utf-8?B?SzlTd0Y5SlNXUVM1RUlIaVZCOXBPZFA0eEQyb044d1JjYjhFcW1Lb2RJVDZh?=
 =?utf-8?B?ck1BUS9ZeWRWK1BZUzl2OU5FRDVpTTlVbTRNcWt1ZWhVR2xuQk1RbCtPako5?=
 =?utf-8?B?NjNVdGNDVkFIUUVPQWdQYWhtVW1XTHcxOVI2ckt5Sy9wVnVLTmwvc0dmN0hY?=
 =?utf-8?B?MU5KUkVQUFFaZHUvd2lCTGhmWUtFRjdkVFdnWS9PZ3JaaGw3ZzNzb2JKdGtR?=
 =?utf-8?B?VS9SdERXRnF4MVIxUmJxOFBkckhsdnhXbFdLVFRyQUdIcExGdFNJS3YwKzJi?=
 =?utf-8?B?VHdFbE12OXlYT01zakVlVVNsRWxLb0VPQkJwRXlieEVYT1FNb2dCeDVWcVpP?=
 =?utf-8?B?cWVHbHVmWjN5bm14Vnk3d2lGM004RXJ6VjZZbHNEQTdNejlkT05tcGh5WFpx?=
 =?utf-8?B?Syt1MWl5OXdYTXd2c0l6MXRjaFgvWnhQZEtqYUM2UlBBd3Y1VnZaNEdVaTJa?=
 =?utf-8?B?amI5bUJrb3NRN1VtSDQwM05kU1k1Vlp2QTVZamZHQWo2cGRNK3hXY1c2ODdJ?=
 =?utf-8?B?TzZOdS95U2ZDencyeUYwNXpaalpuUlFNZWlJcGpkYlp1MFlmc3FQSWpqMUJm?=
 =?utf-8?B?QXBlVlNrTXltTnVqazNLaCs4NWEzK1hTalN4Nk1xb3RZc2xVbkNDaU84Tmcr?=
 =?utf-8?B?LzhmUTVJSmIwTGJqQXNWSUxVYWlkSysxV29WUSsvT1R5d3dkY2gwRHZWdkF1?=
 =?utf-8?B?ellnK2dHUjk2VHpSNSs1WXZPNktuV3V1R0FUOWlyYjMrOUQvRjcwMGhFMlk3?=
 =?utf-8?B?OVRZVnBsV1U3Z25VVitiakFSdnpPKytoTjNRMWs4dklCWVFrcnErdEgzZWFO?=
 =?utf-8?B?MTY0NS8zMjJvdnFHM1BPWjRaZzRnajVqcExSamNKcE9mM0lWLytjK0JNVmhn?=
 =?utf-8?B?UlRoTzRIdHNWMUFvY0ZLTW1qaTVHSUVtZE9Ba1k1WWJFYTVMcjY0aUZyeXhR?=
 =?utf-8?B?S1h2SS9ab3NWbG9HRGJtb1pZL3pvYkJIRll1WnRuR21vbE9GQldramVSTGZy?=
 =?utf-8?B?ZHJEeXdxZnllSXhHemtFVnE3d21tUnE3V21FMVFMU29jeGJVL0hjcjB2aUND?=
 =?utf-8?B?WmlvYlNxRHI4NWlBRjduUTZROGx6VnNUNHBvVWFoU1hXSk1NOXVmaGtIZnkz?=
 =?utf-8?B?anpIdENqSGdCT296YUFuQkVsUDhmeTBwQmtGVmF0MlR6YUE9PQ==?=
X-Microsoft-Antispam-Message-Info: OS9wRf1u9S+bygCXzUKjt2jRDSsqntCw9KrBDpehj9prFyaYq04YSxcVFdz+P/ER0OSq0EX/e8SeGtjYkDa27O0YahBUv+MhGjLsI3KL6049qMMuPtF08e39AZ/5KzmAIW+C5451JBIYfjaGUxn03lDdaWWzvvR4xgqboi+CPKs5md89Gffvql3A+utZFWU94btwNM9PTFnWXMNTeOmPh02BZagb13e99hZEZz8rthSfaRJmrLciRPKLOaERH2xVPAb9xSAcK/5V3eNNA4BRl/WFgGEyRb5+Q53xB2+/2nQ7Ba+1jlamewY4n4Ie8apOFwRbsR4HYxY0c7yqWtb79XQtZ13G1xirP1AZ+VScnJg=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;6:FwDVo1uqYhsee8j0dD2UsItvyg7xnQTA9IMCjZbiC8AmzcVZs+bFh7y5G8PIcqNtRe3fdVFUU0jna1095YfT62dMd6dGi1BAeWc8phNrTCa3/kqSR89C9z5xK+mKBZ2Jt5dRN0FYrhqZRSIi0alKuBPcDlxscaTruTstG92dkcel3AYTSioYOc+imThbUZvg+hcKBI3W37trmjU5zx8Cuc4rC3eA5vmEC1AtFsNOJsDewAceZ9BUZBS5b58pnD5iijTqC7oVHwMDfhZc8ek/thgoCqZOW1LW6oE8r+Rls2sKiVH8R1xFvOQjQYImttkILBvMsar9ecNapg04LJpNI6dxxIaZllBKg2iDGC5PgApXo4yRq3Hx1VsmNJHqgTx/KFKLyr1jAmS50U5tfxOVWCkyeDCs8LxbuE0uVgU4iRUZMpnHPh+tPUR+T5kWoZ3Nmg04udtqyGDDdPFQQf6p+A==;5:hlUdCgKJq+fii2iI+LyaBrZ0zjIlFrk9y3Bwc44y9/NWGjpQpWdWO/krx67kDgilbb9P9dKDi8aF7mOhcrBpGH0ciEPeUn9l/uAOL+5ECGB46T5H2RzunD5haXcl3EHCNwkwE6p9kXsS1WDg83tuSm7kVyndX07H7pJp5ePm49U=;7:5VwGHRiGOZfgUUbS0qSl90BePEDB0dXqT7zIMT0yOi83iG7I3jl6t/2LS6avZ993MR0rTQ+M99AVvF38RSkU0Gsv2XHfIzopzZZPRU7pT2GPnZ7lrEaAN2IJfV1AiBGYfor6JazkoeIHHCwBkNAsWOBpgv+bWJMQEo/3wiVtP6W5ZSX2QFSye+HIyyPgtwfHJNLiAbNrjr8/JjWLEgMvD0rk5TuIiIVfskHY6jFFe8FqpNC0InZr/22uVpxZXTNy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 09:56:22.2560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0365e581-1b72-443a-570a-08d61c83d2eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.9.2018 12:12, Jonathan Cameron wrote:
> On Fri, 14 Sep 2018 12:48:28 +0530
> Manish Narani <manish.narani@xilinx.com> wrote:
> 
>> Add documentation for xilinx-ams driver. This contains information about
>> various voltages and temperatures on PS (Processing System), PL
>> (Programmable Logic) and AMS Control Block.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> The more I look at this device the more I'm convinced it is very much a dedicated
> hardware monitoring function, not a generic ADC sensing unit at all.
> 
> Hmm.  It is still fine to have it in IIO but you need to think in detail
> about how you are going to interface this to hwmon via the iio-hwmon bridge.
> 
> Some of the interface complexity should only really be apparent when we hit
> hwmon perhaps rather than having so many different custom interfaces in IIO.
> 
> Please also loop in the maintainers and lists for hwmon in the next
> version so we can get their input.

Isn't there iio-hwmon driver for this?

Thanks,
Michal
