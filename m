Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3935C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD6F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fdTRBdN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD6F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbeGINOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:14:06 -0400
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com ([104.47.33.66]:51552
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754438AbeGINOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX+cFTPdblHNCFAc5uf54U9unr44JQvFHdwCuZ6O/TE=;
 b=fdTRBdN1XFoCSCI4IudvEFW5RXprc1UBjMN7tKPoKmvPA0JgeBYI/yglBImq94YpZjhArXEVC8n2XwsfUTybvKB19Lulm4BjWQY5zDo0rivMFv5iy2I6Qq82/F+/w9zkOrVk5eiweBNnRM3PZmjm91vfZ8at5AX0vPIDCqyUDfs=
Received: from BN7PR02CA0030.namprd02.prod.outlook.com (2603:10b6:408:20::43)
 by DM6PR02MB4457.namprd02.prod.outlook.com (2603:10b6:5:29::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Mon, 9 Jul
 2018 13:14:02 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN7PR02CA0030.outlook.office365.com
 (2603:10b6:408:20::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.19 via Frontend
 Transport; Mon, 9 Jul 2018 13:14:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Mon, 9 Jul 2018 13:14:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fcVzM-0005JC-Rt; Mon, 09 Jul 2018 06:14:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fcVzH-0003HG-Ou; Mon, 09 Jul 2018 06:13:55 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w69DDjLt032414;
        Mon, 9 Jul 2018 06:13:45 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fcVz7-0003GG-Aa; Mon, 09 Jul 2018 06:13:45 -0700
Subject: Re: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Will Wong <WILLW@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
 <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
 <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0fce3ee6-873e-154f-b61e-546d9da338df@xilinx.com>
Date:   Mon, 9 Jul 2018 15:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(438002)(3190300001)(189003)(199004)(8676002)(2906002)(93886005)(44832011)(356003)(186003)(230700001)(81166006)(81156014)(8936002)(229853002)(36386004)(316002)(426003)(4326008)(39060400002)(58126008)(476003)(126002)(106466001)(31696002)(6246003)(486006)(77096007)(26005)(54906003)(110136005)(336012)(478600001)(64126003)(65826007)(2486003)(23676004)(6666003)(53546011)(106002)(2616005)(446003)(36756003)(76176011)(47776003)(14444005)(65806001)(65956001)(5660300001)(9786002)(11346002)(63266004)(305945005)(31686004)(50466002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT012;1:WXDLDjwwcNT9T0lspK8OweMHAL3TKe1MZ9a1zj5CstAoyJJ8jlqzJJcnpAXThTzqM/xgXE1eOJ42PkrzpL8myvE0zEQscrwP+VmcgpTa9zDG6NUaIIOm0mPDEe1vZsDR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f61ee4-0163-48a0-a5f6-08d5e59dd6b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:wKwBb+xlWIK+imU9QdHI4htU1rVdE2Vu6bBKCv2EtNbLYEA4OmJHT3tBuHGbCbZUufECbzsjHbZzh/+WVDm/CJubqQFRWvKSH+OQA4zj4V9kl+8nvp6lHMUbeSwsbAZjmfeq9kZz8oCCyd0bo64N4BNhZAlLpBiPYz99AkPJSgZ5axcJOvkXBbSry9kWTflqXV8LRPYagmH2GNyMHNDFZ6VyxcdwzNjBtMLrBq+/pBhPxXtR43ZFK/apqNo4Djl8U/AX7nxSE25lIefPFfVnXxnBsetKU85XSIuN1RrLbmIwkrrAAiup6YgVv0l+vVhaaMfP4LLFOSgNJF9w7vbJSJAotLwZW3oPTmI4q5q/w8s=;25:uu02H7j8BCy8v579I1rHjbbXCnpj1bAppCa78OAK3ZEUtGyAgpD4uqJbjhB2wnuX9ia17hGZPE36VJgypwyFNUv4BWY7suVhkVoJJjGKB2VXSO5/Q7WLBwQXzDlTpPRUg4R/GK5fDGzQfcuLyNVu8LxzKz12bdVuHPK6XAUdIK0uHZs3l12RmJFazqxkrn21I1bd+WQRAJo0ebaS4/TuadHn4LoxvBn0nI7PQfakNUeXI3mnuZzflRusaBFloUuyWYHwftm36zxF9j9ytkwoN98Eq8dg5Yi7N9t5IB93ZbYYwSfbDwtxlKKSm1/APuvG/OmcbleJIQxMbM1fT67InA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:VxIJe8A6dn1bGD98Lkxj1tz5mdVhsQ4/Qlhor/4uDSAIG1UeztmPGRyQhJyUVRzCu0yXC9CEGsufry6TH/qfzrLQKIdzOqXZ8jIFRdxJ5dHMFUgLFM42moAWfCNJNr31wsOv6RECrXeqNgIUguCxchc5zuWtO3SAkWut9y9l/XqxVLIL8wTikJjCbzaj63Vf5B/tBkVdp+RdtonJYoYBDnZ1dt7Clx2auDfWFcyXQXo=;20:DskioMQoRpDT6NHgUxhJVJptFooRv8nDzLyYt/5qzMrOmbF6u7mkq4E/k/uiHv2xYga7UBLvFbhFZoBASAg3D8ivJPQVvvswTPKWmwW5QF8V7DRF8ksO27Heh6UW3QF7OYoe02ZWChFVgkdxdzepo7zNA4cuN1hCHhvETFaBu4cYz7JaNs1UkOnjWw+/K5g/57WoeHi1GvAswAPXBua5JKEfiUzI/1ekLBzCFS0dxPn6mXvIpAClcdHo5FZ4BePcmKndlNHhrIGnsDFErfYPFEU8QpazppbEM5NVtHZl195FF6rvFMJSdkPkvavpU7MOPb4SJmVSoE8aJK4Wm/avZHzVAr6nLYBHr4ateWPj7tKEagDJy0nsRQcllSmbe+9gAl8XVgINxJOXWGE0grEO5s4XfWBsR/pvrKhZqElwxbzz1vAgGfFD4csIXkYeUbgpZ0f4JuJmc4gMfC20Zx52hBqspk9GvPO7pTP7ODLmAskme+Zus4Pn1hjib+x2M3Jg
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457A5FB22A49FEFC9ED0F8AC6440@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4457;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:SjaO8SeO9a7Pvsu1FLFtyuzWG8U5Zekgj2J6BTzvjzlPv2u0twO2TkZOlYsyAZWdGrBUbAPF/95rTmkUqyiKUgVhfDuDn0shOIPtpqZl2UZjsbZ/wOht9tB5eFMnz9ss5Ynh3BiJ3p9ea35pSftfU/Aj+sSAYCaQtP7YpijYn7Ywtt7GrWTbCLA8GcgpooaK/x07e0OyKJf7rfDwZ/DIai3IYFsQ9aB3ZvYzVEfI9XURYDu/DoDZ5VpXo+zVm/IqyQS9yXzQ4N3jo+IKiEFpx2k6LJnaCXFvHrpDTFc8HXtM5Ri1ikiFuvFWLC+shkYc
X-Forefront-PRVS: 07283408BE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0NDU3OzIzOmE5U3h6N3B3SVp5RTZDczRQVmVuNzN5YnY5?=
 =?utf-8?B?WU41Q21JbUhYd0xId0EvVjZGN21ISS9GOXhtNDR3aFB3MnE1VEpqTlhOakNF?=
 =?utf-8?B?YmlDY0plOEx0RlpzSEN2OHJ4dFRjVERZNjV5M0lhbDNZMzg4bStGUzZZWnFq?=
 =?utf-8?B?MGJzc3l6N2tEbGtqeG0wWlp1NFlmZEJMRmlEMnJieXcvS0Y0ZUhpaFV2bmp6?=
 =?utf-8?B?R240QnlJTHdQMTRFTjJzOWVDaWEzbzdyWU9OMHowS0liTkthcWd3aXhGVVJC?=
 =?utf-8?B?MEJWODdRUnRLN2hhSHV5Y3VCbkRZd0lJOGdseGZ2VWhpcnMzNytDWHBzNU92?=
 =?utf-8?B?c0s3VFVlZnc1Qi85ZmNJTXF6OVhFN3huRGFuNDN2Z3kyYjdqMDEwbFZsc2NS?=
 =?utf-8?B?RHVQdmNvSkhmd1ExdFJPelF5M2Jjay9ZbVlHT1BvRWdoNlNxd2NBeGpmVmlJ?=
 =?utf-8?B?MkVzNG94bnhESk5MVzdEdzhBb0MyMUZMY3NOUVRYdzZhYnR5Wm44dS9Bb2t3?=
 =?utf-8?B?VGlqVmljSG9sRDA1Nlp5YVRSdFFQSlRQWVRDR2RpL2FORlJ2RXo2MEh4TTZE?=
 =?utf-8?B?STU0K0diYjdJSVBBRU43cVBtMVdEZlJ0SlhHeFY0ZHlMK05MS01pUjVBYVdx?=
 =?utf-8?B?clZDTVR1V2ppQjNQN2pZbWRNdUh2YWcxTkJTUTFyY3ptNU9vQmtxUlNNNFNn?=
 =?utf-8?B?K1RGUm1sZk0rUC8zOHk3Q1lVNlVhZW9sdjJxM3BvWEg2U1dCallOeExackxJ?=
 =?utf-8?B?NUJQVWw4YzFLcWtyenRrUkwzTjNFRk8rQ2dKdXlYQk1wNlhpM2dEcWRpR25p?=
 =?utf-8?B?M0ZTRUNQTTM0VlRSL2tDVUFSeU51MStyMU1IR0VTNEd4bTJsT2U5WDN2bzIr?=
 =?utf-8?B?QitSUDdhdWVZZTdWdnhOQnZSdzlvZi9QdjRmajN0Nnk4TStCelpNaURQT1Z6?=
 =?utf-8?B?cG5HMjJsbVUwSnM3d1laYjlMRkdlNGxSZkI4WXo0bGMrZEQwK2o2U2lqTmRU?=
 =?utf-8?B?WEdEOFVMeGJteVQ2eGd4bUdKQXRQcElXSERkQkZ5U0lrSC9PZjNSaTRlNEQ3?=
 =?utf-8?B?M25sRTNjdWRlRmQ2OUNaWjdma0hKbHJwN2pyWXl0bGFpanFzZ01xdGI5KzJm?=
 =?utf-8?B?d0pjcVlNTnlGZGJpOHJQMngyay9EZnpKNWl4NlVDVnNPSWU5cWtpUHhVT3M4?=
 =?utf-8?B?RnJnNjlwSjJVQVVFc0I5WVEzZnMxRzdOUkozc3N2TkoxcTBlc3JFZ1hCVEhq?=
 =?utf-8?B?dGlDM21LdzBFM2g0QW1hMStrR3JvMVRuQmZKSjJmT0RMWFc3SmZhSHloRks2?=
 =?utf-8?B?cXZYM2s2diswcUVVcHpCTlpDRjBxR2ZKWG9pMjlLYW10Qko2QSs3SWhQdDZu?=
 =?utf-8?B?SDlSaUZ1L0VvTmZQeWdxTE1LcVUzeENPNHpLVkFsY1pHK0N6MGI5aUVhQUFs?=
 =?utf-8?B?OHMxOS9CaUhMQThtRkQxT256STFzeGsxRE5OSlNZRUtiY2g0MitTVy9XRUY0?=
 =?utf-8?B?T1FRTEhwd21HNGJiNXVhZm12bnlBY1R2dm5Ud1hkZ2tLL3lzVU9sQXByYTMv?=
 =?utf-8?B?cWZtV0o1ZDVsR08zMEdrL2drSWE0R3hSOXNiSU1ZVXFRTGVjUTZ1NUE4enpY?=
 =?utf-8?B?UE1RMC9qazZ3Ui9iS2ZhWXIwWGI0Wm1mSUZsSjJFODZ3amZ3S3FjRzU1RlNC?=
 =?utf-8?B?Y3NraUsxL1JKK2hhZWp4N205eDV5UkpYY3FSc2FORG14enEzckU4ZUJ4TFVX?=
 =?utf-8?B?MkcwTFlzS0puZzRGSWdTZTBuQXpqT0FqT3J2eGZ2d0prOE01NGJFYlUxWUpY?=
 =?utf-8?B?UnJ0bFV6Z3ZBcGtWVjhkQnd3RzlhMjMweXBrYzhHKzA5TkdXaTQ3bHRVcmF4?=
 =?utf-8?Q?9Kox5MHvIPg=3D?=
X-Microsoft-Antispam-Message-Info: Gr8iS/E7VEWaxNeroU9m6hqC2l5FDQu1UJVpn8eH6QeRRnNBCQNTeX69JkEw/2DMHV5/r45lndcpVC6D5uf2isFrRcV+VkyQWhEnVJ5y9AE/lgSfo8bfJP7UZWMjMIAS5WP6fDD2ssVxEvXyc9TS1HrA5pf55+vffqzDaKG0WhkMruvvl+1m1sN8yVksbkm+aWXAe8RtkUdyhyrvonW0Cn4XOTV8WVcU+auHgI+36Khi3SaUEuG5t+fbf7LZ1JWRJq4Kx/xEKev4/a0/msEqvqX0qi91RyLU4yZJ5NAw35OCyn/DdexhBDPshpKFqUf6DKMElQa/mNAhD10hfj6XX3/FzLnhbqjN7+mSkFPxUxo=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:Gx5AvvORcqG1h7hmcs9+5F+AtZ1cTrUOO7oekhn70ahkM/5/9tyRPxO9khyB/p30qunl/OO7qWKMznLohTGvcstIWY7nPwzEXvk8ud/cH4+xtDEw98Q3J9G42jpS1IWTdhFN+tjvMPFLuaqd39EQ+HDVybSr5w6GKWKq8cnzhpb2midOo6RderxgvJuOFxYzr1O3+BS8gmxyWUa2Olb9ZL5OPa89ngqR/08aY47Itl597ApRsKZdXRNyZgQYSwQ9uR+Dqco4j28Fvix6lBqFGln9DZd7f7Ypcb8huDDEUJysdvynIVZpBGjnMlInbYCa++4XsO5AOKK/0QB9X2f/koAuC4fLN64EDKFGK7ezm14msWJHQ8Di28otj13lLaI92rEhemXNLYeslw5iew5gjOqse0+fTBoM0t+e8+fODMkrZZ5f55WVfmpH7SxXJqPDtwob7B81RKr9xguRLHHU8g==;5:jxw43J7MoS+prWpKLV2eJXplYrbcwhe2EAobG4NObEza/Z61sBLBGX2X2SEfSsjkp+bA+gLt7DBvzgxVYMJgbcU1olo2ddH3XRon6wZl7R5oGqKCl3ChiE5EuauGZut+uRDwrYx9FA4g4VyrxvVY6L8W8FXfc/QhxpEfBnH1d0g=;24:75G4MgynwJUxH+1rjpdbVeBfrcr1PQDhDhof4MbJ9Z8UfcMASvx5ciZwvuuCd7h+fulAX4+wzlLnMbubWIfHwP+c9cuCAm6+tIkpBCy0BXc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;7:siYZ5kc6BKdoFdgBPrW+K4Z2DGooEoRvv49UrTZ6/d4RH1WRhSshs/01r6XkSPiXL3ed8Yq8uU2b5UeB5c4Y4lR/dtJgtyC8lRb9xZbl3bJOh65rjsgqQvhF8UPqzngUm+sm+Cscrq5G4OLbMjLGWoZsA9tDazLRpKthVnhGKBosWk81BMSP0c54TnoVwOBFxQSJ77xEE3YXwLUkesOg6ZYpu4F/eGWGUw4njUB+CImDMpSQSRxUjTA047eexgOs
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 13:14:01.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f61ee4-0163-48a0-a5f6-08d5e59dd6b1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.7.2018 14:36, Sudeep Holla wrote:
> 
> 
> On 09/07/18 13:17, Michal Simek wrote:
>> Hi Sudeep,
>>
>> On 2.5.2018 12:30, Sudeep Holla wrote:
>>> PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
>>> where the semantics are described by the PSCI specification itself as
>>> well as vendor-specific resets. Currently only system warm reset
>>> semantics is defined as part of architectural resets by the specification.
>>>
>>> This patch implements support for SYSTEM_RESET2 by making using of
>>> reboot_mode passed by the reboot infrastructure in the kernel.
>>>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>  drivers/firmware/psci.c   | 21 +++++++++++++++++++++
>>>  include/uapi/linux/psci.h |  2 ++
>>>  2 files changed, 23 insertions(+)
>>>
>>> v1->v2:
>>> 	- Added mising static anotation to psci_system_reset2_supported
>>> 	- Added missing ')' in the comment
>>>
>>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>>> index c80ec1d03274..91748725534e 100644
>>> --- a/drivers/firmware/psci.c
>>> +++ b/drivers/firmware/psci.c
>>> @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
>>>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>>>
>>>  static u32 psci_cpu_suspend_feature;
>>> +static bool psci_system_reset2_supported;
>>>
>>>  static inline bool psci_has_ext_power_state(void)
>>>  {
>>> @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
>>>
>>>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>>>  {
>>> +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>
>> I am curious about this reboot_mode setup. I have grepped the kernel and
>> reboot_mode is setup via kernel parameters at boot time.
>> Shouldn't user decide what reboot type wants to do?
>>
> 
> I have almost forgotten how I tested this. IIRC and looking quickly @
> kernel/reboot.c and __setup(reboot=,...), I recall passing reboot=w
> while testing this.

I would expect that too. It means static setting at boot time.

> We can do something like what efi_reboot, but not
> sure if we need that yet if users need too decide after boot.


I am checking with colleague about all xilinx use cases but I would be
surprised if static configuration at run time is enough.

Also not quite sure about mixing reboot_warm and reboot_soft cases
together. They shouldn't be the same.

Based on psci 1.0 spec there are more options especially for bit[31]
which should be likely setup via DT(no experience with EFI) with names
and codes which should be passed to firmware but still the same issue
remains how to setup reboot type.

Thanks,
Michal


