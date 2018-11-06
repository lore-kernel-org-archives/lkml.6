Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D56C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4B220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CQX8SwjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4B220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbeKFVTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:19:15 -0500
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:8224
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730271AbeKFVTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUgMS20YetPc22Ojv9z74pXza3pL+Jex3qhur3ZNXto=;
 b=CQX8SwjAD8qkwa0YOuQwWNsvZ2mq+IGgxPxIiHLs8/HXW9scrEqIX6Q2eZ9p8Komdf0YJQ/stIvDI4MU+ubcTVxAJg24kR6mOwmy32wNpaGIRJ/BTPhx1QTCYEZJmauD6UFjtLdbkz4dSAZrHkR2bAfcD15c1IBIJRfvfQYLibI=
Received: from DM6PR02CA0007.namprd02.prod.outlook.com (2603:10b6:5:1c::20) by
 SN6PR02MB4464.namprd02.prod.outlook.com (2603:10b6:805:a8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 6 Nov 2018 11:54:19 +0000
Received: from CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR02CA0007.outlook.office365.com
 (2603:10b6:5:1c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Tue, 6 Nov 2018 11:54:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT026.mail.protection.outlook.com (10.152.75.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Tue, 6 Nov 2018 11:54:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60389 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJzw1-00032E-Se; Tue, 06 Nov 2018 03:54:17 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJzvw-0002Q5-OP; Tue, 06 Nov 2018 03:54:12 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA6BsBGg006451;
        Tue, 6 Nov 2018 03:54:11 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gJzvu-0002P2-Ry; Tue, 06 Nov 2018 03:54:11 -0800
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
To:     Manish Narani <manish.narani@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2da1ff15-1064-3fac-750e-3b0f006ee1af@xilinx.com>
Date:   Tue, 6 Nov 2018 12:54:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(2906002)(36386004)(65826007)(5660300001)(316002)(8676002)(81156014)(9786002)(81166006)(77096007)(8936002)(14444005)(110136005)(58126008)(54906003)(229853002)(47776003)(478600001)(65956001)(65806001)(230700001)(36756003)(64126003)(26005)(6246003)(4326008)(31686004)(575784001)(2486003)(50466002)(63266004)(11346002)(446003)(426003)(126002)(476003)(2616005)(186003)(336012)(31696002)(486006)(106002)(7416002)(106466001)(44832011)(6666004)(356004)(23676004)(2201001)(76176011)(305945005)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT026;1:NHaux+VWG76elETKAMEtCfAqqQAYqw3VNCdvkBW+u/uEXo4X/IXXbbClFljcE8AuIOinViv1sXgWkke0CkuFMV5ADXgOxFrv1oPwpOEoMFIOVnwkw1K2/VLewumlIURM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fbd3d7d-db4b-4b02-de48-08d643de9583
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:Gk3fS4MsPrOMFXj2MFHXKCihAOdNQSFvch8/V1EHJkl4/3ipOAlHM8VpBdeHd+KvQMQZs7nxUk8P4DHj3gQhvuOx27UYiEqpGRfdvAFuASedoG0vN+gxbCYdIZlx9mWXD2bjFrYGSBHnOMlV6aT4spxWF0jfXPLvlyT7IPfp6qIu9Mn341u7Iw033lEjLFe3BcEPeyWvd/8mjcx1G7pyOAYRidHBa0Ovo7mItGD/6Gkj7o/TNdY/+L/Zdb//bSrLYkmYmyVxDaAfgBFkxpS/a4fEXyPMjTIVSREOgb1aDzX5DAFZxuXZdgmXBEG18uTa+v7N7SVo0DgMroTRHlTC3FKjyn0sGX3eAn1Gr0fbzhc=;25:yTddtEEej7ybBFemOkKCGnlsJdFRZnqSD5eO0on5E11GjtZxLcpEqp/tZK0qGbWiur9kYby5zyxhJkM5UtHc/FvO6IYwduLD9R9RJImZEc74mBJom2U+61aZEQZa6ZYRQpenC+ez1c9Pd5dQdm1AQ2P1oDFR2aR7htWDVKUuTcOfmeVXJ7nzba4ElvQZ/02Qk2tmj7IN4nNDo5x2CBQthzHbR6BTPYE8qc/FdXW+U51RZMJkUYJxG+VPplUCzZ+hsER8d4av50Ru+0uu2Hk+pvUSwJq5gVoJLMonVLxSKxXpGj335oJ5tpaeTgHCD48gaN37m6YIk39OOtVjeCSa8Q==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:GZ+Ua11LALw72l/TNXtVSNj5RvwAwEcyiLGABQowmtbKu/dwjDblU/7Zb08FSS1k18YIDy82CTlkpr8rHPHskuQXdBELPUUtk8IvEbFWbwwaApxD3OieCwTvq/nOADcS7lI8x2tZSwpuy761rOk9M0wPQVhwU5ZjrtYOCLJdNTv2FCQohtvTxChuAS0nbwQgNFBTEEPDR0dT8ZbNeZUj44Ng3mNv8+jIgVpy7pAgUBs=;20:Pfs/hU4qkoim1+j7UaYy/0eVtXFdedfK39zcBEe2MZ4TZ9VaOd1MHf7dmzPlENguxei1YA2eZMVyzv9HlMtkextC3uk44+qVzPAsKuNIl5HhzhW1kUppMewgy8OqhwYOhizKxJ833cf95Yi+JZ15HFQu4Un2f/59ITlFn/414KQXSrKdngOZluTYrD1dgRZlG8vFXOwYJyq5IKiqXWYaJUXEDPStJT12toyQ9eY0gPjVJ64rivtDnY1mZhKL4HvGpwCeTuweIF806ouTCU2ubV4SaPRnIpRhFFf1fMbm0yt+fyiUjEYm2vPcBpRLX+ln9Y0cEDzv7jLUIcfgg+4tbsN4KcPxypeQaOqLQNmIpSG7fXKa5d8xaN4Kw01GbGSjImaj6r3QXjD8tt0oG97BQYs9/19INiXxoQBQ7lLTJq5RNudPkG/zSJYLHupgpM9awY+4WEf8bD/CtuGgHh2it907MPLX9A47JtWR60kjh0jNHC0KtWm1pLNvD6NnrXpe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB44644EBF74E41D4D0074819EC6CB0@SN6PR02MB4464.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4464;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:xrLgLIQC+RXTXmcO48Ds9/fYyjFSGm09G3gKZU2bDtFOTy2plAMrysTjC+ClacUIek6aA1aeY+x8Brd1uZUp4ADBbZbBptVjChVKWIDqqZqaI99yLoB7vm0RXCfI6jMYowCpIz6SOVtqQm1z31ia3VbdQ1R9obW9Rw+fE80LnnZUbbZL1RGvcUgp8XM96f5ijYrd8sBkwxhLTqW7hWY6FeND2HPECU8yFRFWVA9VX8txUDTlEYsiRDCMEAdHSUFEa1a6D6KOUanT0w6Pf2y1a7duUYtjUnr3XXH57hX7UNiSpJJd1Pt8s4W+6Zy0z81L
X-Forefront-PRVS: 0848C1A6AA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI0NDY0OzIzOnZnNDdBY1NvdW4wMlRyZXB3ZlFUQ09Kc2Yw?=
 =?utf-8?B?QkJyaSt3MElnNEprcStLRWhmS3pGV1VpNExFcXZuSldHQU1wRi81azIyRW9L?=
 =?utf-8?B?bUhCT0dwWlFTcFU4SlZKcFFXeWJxQ1p0eG5EU0kvb2ZQa29jZzhnS3kvRHRZ?=
 =?utf-8?B?NU04L2puMGVteXVwb0cyZ28zTGxSbzBZVFBMZ09qREdHOGxHa3VlT1krY01R?=
 =?utf-8?B?SmVDbkIxUW4yOW4yUU9nL1BncUtERGI3TXFxeFRZak1ySWZYQlIrSzY4N3Zk?=
 =?utf-8?B?WW16NTlKRmJKcWdvYlFUbkJXUVMxS3JFaXFpQU9uTWlhRUlSQ1lWdmNnd0Qv?=
 =?utf-8?B?TXdkSkpLSFFQbGxhMUd6eThzNDFyait2TUxndnltcWFQckhuai9UQUY5Y1ZU?=
 =?utf-8?B?T2l4WlN3VlNPa2ZWd2pxUkF6V0Z1MTFEeGJQWTFSOE5QdURaU0VwMjFkNGh4?=
 =?utf-8?B?emQvYVV0SmlnRjdqUEZhT1FNaFhFODJWcTc2YjRaUWYxbGNucktqOEpJelBM?=
 =?utf-8?B?S0pRbTFsWERtWmxnL1A0V2x3WFZSSVFnQ3A4UlNPVjlDNG43cW1PMEE5dWNK?=
 =?utf-8?B?SittZzlBYk52Qm1wSzN5V1pzVllmRHMzRW50WSs3VDhPY2pzUSt5TXNhdkp2?=
 =?utf-8?B?eEtMYUJUM2FkaXdSSlVlZkNyK09rd1lqUEZmWDZzdnBhZlVnTmMxS3daWUo1?=
 =?utf-8?B?Sng2RExmbVlONXRYN1h1ZVRiT0twT1Z5T0hYMFJXZEVVckR0NGVjVmw3RDBs?=
 =?utf-8?B?VHlEUkFWRUJZU2xoeXg2U3R4Mzd4MXFvSkhLUDZ6TVVrWXFTM05ZcjM4RW1M?=
 =?utf-8?B?NlhkdG1jZjhTSTJMRm9DMjNua0NCbFV2bTM4NCtVUHhiSHRPRVlIY1FLbmxU?=
 =?utf-8?B?T2xwdjh0SmN6TFkrUi9DUVo4S1NiNzc3YXEydEYxVmxxaW5GK2hmZVhnSWdG?=
 =?utf-8?B?V3dtdXV4NEZQeWZZQmNyZnJIeVNSdnh1V2F0RERwSVJCbStqb3UrNDFSaW5W?=
 =?utf-8?B?NElLTWNQZHNHbzljQkEyTlVEcThFMEFyS0RNYi95NjVFblp5aE5QUnREOXhx?=
 =?utf-8?B?enJxZkdSbVE2QlRwTU9FT2tCYjcycXlFOFJZY20wNURkdWorM2VqcFovTWc4?=
 =?utf-8?B?QjVIZ3JIVG9uemxUUi90Yy9WNzFORUJlTEFmc0FJZGJwT1RuL3c1eW5YOUZ6?=
 =?utf-8?B?b1Z4TVVBUVVQU0YxRjU0R2VBWndpN1VkNlNXdHBEVUhZZldoTjljL2M3cHRk?=
 =?utf-8?B?V2NwRm9hQTFKcXZsRHR0NHI4cTVXMHZ1RnZwcUJrOWpPTU9lb2ZOZnk3ZE41?=
 =?utf-8?B?cW1aNWNTcnIrMGRvbmlZL0JLeXN2ZTBWVWZUK29UcXZZQ2F6Z1dlQlk0MFo0?=
 =?utf-8?B?ZWVwTytCZkFSRzdHUldRVlJEbiswUmVwM2NsUGh4bEN0dGFtc05LYUdOcHBM?=
 =?utf-8?B?TzhoUDVlVWE3NXBNclppSm9UNko0c0RHVXk5UEp2aURzM2lJZ1M0aVJ3YlpO?=
 =?utf-8?B?bWJHQ0cvNHJ5KzA4M255Z0lqMFJ2ckpTc3VVL2Y0d3hTd0JqMmtZcEpMelhC?=
 =?utf-8?B?d0wxc29hZnd3Z3AxM1c2QzAvSDFpVzdMd3RVS1UvMHRxNENWM1pCOElPVTBl?=
 =?utf-8?B?UysxcW1OT3FKSnVRUkxUcEk4Mi9FQW5kUWJhNmRzQ1BTemFCVFBYbnp0ODBa?=
 =?utf-8?B?OXlya1NrcGJsUWNvNWJWcHFEU1Q0R1ZXUk5LemlBa2hsYVYvOXFpOUxHMVgv?=
 =?utf-8?B?VjhMOVBlclI0WkJNNXJrbDdjem96YkZvUkJpZ3p6Ui82ZzB0QzJsQVVvRG1X?=
 =?utf-8?B?QmxSZlkrbllja1ZuRURvSUZuM014dndrY0gyNFdlSDFSVXNXWmFLVG5CRGVN?=
 =?utf-8?Q?EdDMuieS93E=3D?=
X-Microsoft-Antispam-Message-Info: Omk2HxkL65zFJ3xtaPiyEL7jRPOt38hSB6gvY8IDyt/QSqAsX7MpnymNlZkkDiPobUuwQknIVR94erd0R7Cggwgyutbk5cFooiX4O1gpZRbu8BQPwEQ3GBuu8UkoSFFZvHHMS9pu8pN5DnwxQZ42YvQkgzcHS/oKg1Vt159Z6rB2NM/XmNf3YTfcx0Zh3lcIsvvYqG/aA9ZDWHEQB2X54xy6jFj6sZRgLhuCA9Ho2PcV2Auyvovn9TJGKe/ZK2M+CIEmg4rPfco4Afe6/wFl7zMV5WCQc/1vNKYvgvaCeQJ9VNLlPxHDLpaGekOMc7fgOtWeWPQt19f6RnQCb29CGwIE5EeU8+mCpCfe93eDU1E=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:sjfeGrGKoVavxbnGBFYy88ZYavDJ9usgJUps9RkmDzKeW/F9xLUAd7gqmfceacWxGyKCnqVXI8K2O9k6Agt+OS6Kz1PJ7lHbo1K2cT3FYpBK3G3zO8EKgmOuhYm2ZM5JZT21S9yoge+AQGjv4MI0bI7cejU2lD5Cr+AyvBt/rJx+fxt9jthHys6Zp69Dbiz3tyArJdld9WkRO0+GBA2i89B7QJS1PM/Eps5aw24pOm6ZMLTLC6jyhB9s9tnAOMygvL2JY/CAml9qNDI+LbgCcjiuw5XxhZZYCda+OGru0ZTIq6TI2sEn5aL36qzJMpS9wlV/PIQYhFhET6WrXxXb4SwZNZzKc4CUB/HCSTyIjy+0Y2uhlrAICPufVc67engvRRww1NfKvrB+B7zAMvBsqLyimYKQCB0n0FtrcFE8BSbyGgh1qbZ+4csIude2kRq5HMDDVGf7VRUQHBCmxP6bpQ==;5:iMy0kv3eerLb6wZ9HxcF1EtV0Wo5Pdc0C+vy0EngmXzZs479ghXYbFyj/CiInu4CcPZjWKMwW+JGq8ulPtPUKPbgRFdvkl6dA1E0qw2dePPDwbQh1Wf2c3jkLaPZwjc6wnT7zCrpOEq1ayNQ8YtEwBy02zgkxoXZaAlIGXuQjNo=;7:atZZMYmiUuMDrplpXfNQmaYfBTrxBj50RgdIucy/+0mD09w394qRbtmdc08ZNW3JZTYLfBs/X/8PDf6a2j8DOMSa78uVmbwyAFJ7sVQnFPVS+NjvrCjrRZYOtyPYArNYiqH+jdYLIqkPNZRGka8pkw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2018 11:54:18.3033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbd3d7d-db4b-4b02-de48-08d643de9583
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 10. 18 8:07, Manish Narani wrote:
> Add ddrc memory controller node in dts. The size mentioned in dts is
> 0x30000, because we need to access DDR_QOS INTR registers located at
> 0xFD090208 from this driver.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 29ce234..a81d3b16 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -355,6 +355,13 @@
>  			xlnx,bus-width = <64>;
>  		};
>  
> +		mc: memory-controller@fd070000 {
> +			compatible = "xlnx,zynqmp-ddrc-2.40a";
> +			reg = <0x0 0xfd070000 0x0 0x30000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 112 4>;
> +		};
> +
>  		gem0: ethernet@ff0b0000 {
>  			compatible = "cdns,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
> 

Applied with changed subject "arm64: dts: zynqmp: Add DDRC node"
to zynqmp/dt branch.

Thanks,
Michal
