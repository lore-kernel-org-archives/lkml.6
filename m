Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C88C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863F6206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p6EmAYCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863F6206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeJBNtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:49:35 -0400
Received: from mail-eopbgr690086.outbound.protection.outlook.com ([40.107.69.86]:64576
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726850AbeJBNte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1TjJFR2dYJ/UC1W1m/bD6msfQLu1JZiiVAPngMLgrY=;
 b=p6EmAYCPi+MSJ+crZTbNV9T379L7O7eszSu7QAxzLBSn+UKUsTaYaEy2am6wleIBd6S+l/oA3Ybk4odwwmzkuHgu0cK0uN7x1S1TmieG1Vi9rpTInSB/Xtf2ykPqECeR/Mop0fl4OhafEcKQGcdz5PXAzsnHDnbcwk9uXsRuJvw=
Received: from BL0PR02CA0068.namprd02.prod.outlook.com (2603:10b6:207:3d::45)
 by BN7PR02MB5106.namprd02.prod.outlook.com (2603:10b6:408:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Tue, 2 Oct
 2018 07:07:43 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BL0PR02CA0068.outlook.office365.com
 (2603:10b6:207:3d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Tue, 2 Oct 2018 07:07:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 2 Oct 2018 07:07:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34692 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7EmU-00066z-7r; Tue, 02 Oct 2018 00:07:42 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7EmP-00056K-3x; Tue, 02 Oct 2018 00:07:37 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9277TXd032230;
        Tue, 2 Oct 2018 00:07:29 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g7EmG-000554-Rs; Tue, 02 Oct 2018 00:07:29 -0700
Subject: Re: [PATCH 1/3] microblaze: Replace NR_syscalls macro from
 asm/unistd.h
To:     Firoz Khan <firoz.khan@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        <y2038@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-2-git-send-email-firoz.khan@linaro.org>
 <f1e95c4d-4f02-263d-7f35-cc87bc657fbb@xilinx.com>
 <CALxhOnho6av7nZja_MN4akQuVj1hVq753ZYgRM8fbKkL2rHzQw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <89533601-366f-ebf4-dc31-996bc649bc51@xilinx.com>
Date:   Tue, 2 Oct 2018 09:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALxhOnho6av7nZja_MN4akQuVj1hVq753ZYgRM8fbKkL2rHzQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(438002)(189003)(199004)(2486003)(23676004)(77096007)(36386004)(106002)(476003)(63266004)(478600001)(2616005)(44832011)(5660300001)(53546011)(64126003)(76176011)(486006)(126002)(7416002)(6666003)(2906002)(305945005)(356003)(106466001)(11346002)(58126008)(54906003)(110136005)(336012)(426003)(446003)(186003)(65956001)(47776003)(65806001)(50466002)(65826007)(93886005)(36756003)(316002)(31686004)(6246003)(8676002)(39060400002)(8936002)(81166006)(81156014)(4326008)(26005)(31696002)(230700001)(14444005)(9786002)(229853002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5106;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT031;1:inQOi2EJ4lOXkDaaL9ynOfqdR7Zt7jocgAgx5bRBX9dIwR2sPH/0x7WJdgI6BZ7jDPRz0EUSjD26wXCZ4kERYRvOd/7HdxIongK6FU9tNhMKi9jLKTznvG1CuNV3esdD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b9c79c-ebc3-4e94-3fb9-08d62835bf83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;3:WscnnXAHwxcVY7TtGP+p63JZFUY2nQoT8HsNwdwArYPaLuBNxN2K0R3+MNiUK5imQPnCzLGqPuWP5LBIrkX/LMFlJQ3/td5hmVQAUZZs6uHQR+6AiyxrPnGEY0qQqxIvI4KcEDfmeLgHA41DwmDvA5tSR+zvTFSU11zHMN+M6N2pal+lobA7z9x0e3/6nXr5rOdz2KPsh4VY0OMxeEvQRCPnUyqLZ9IWyBTdEgpffKb3qoWCICygMGnatJ8cdYBsd3BGbxTzc5CWgcLlN/K5W6FOIYkLlLGXTE9g4F50NHPiEpadjBJwACCBsOz4xygKiTF1KEZ1Q8wmyc9N+FtSlnO3YOmoCnWh0sKVonISb1w=;25:DhF4M91G2fqOX1OnJ9BMycu8+O7T2xcIEShn59rgiXiwM82VRwvAJMSEmKTrEJwXaJpuEyg3MdRbzZXKx4IPfMcORDp0K3MhKC3PhJDGQPKlM67ck9Tm86wRlrAl3za+E1UxCb70k4xby19ppizA4Lxo5w/TjUpQmvDK+GRi0F5grg7JUmY0ry843S06le1QgiSKoPetn3h1dsN6OB4YwAIFw7VLzJdQk42ffPUn6RUlE8VTZoRJTdT6IyjIcx8AHw12MXwzf86VndbzfAmXCCrXfJqtccehFGlx2CNp/VhAdPHaIFwBml8XvJpQvPYIrssQA/RXmtLyO58Tyvr44Q==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5106:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;31:UIAWdoZ/xEpeULHpT3VW+OC6gw6NkuRz2wVxNPbt3yPnOY8TLzeyc00cUD3G7Xidm+NBIJ+0Bf3RejRAnFC65arNYiQ6xPKEonAflZJw7vI/kIqtgSLDpxUMVwOOLLaRWz4MqZLll3MWVXPyeI1T8jKOoxIapYL7+ucGtujNpqTFcPhcObCONn+z8egLoFjVZ49tyPHnfVrV3UlxQbSeXw0hKLawb1ezXFvYUr8aZ6Y=;20:g8FlV/TKbx0yvTOZ7rNiX1kSDUlNJS7uP/fiTou6Hli24wGpNaJjExkRqPUM2Wl+JE97T8tbuEX+qNRCw+qZwjGsNQlXUae6Q0UwKBql2eDWrzKSQIIv1rq9Tglcrnq+EuEJ5fbV60VIlE33pMYwFC9AirPtJx2rNPTLYdhr5MUD4Mcdj/5lV8CQKtHkhEB1qXdrVb/xFAiEm/5jBJkBKBt7pPioaljH+PjnhVNruCru+W61cYiHW9TfnaCrS+N4NTrp+mBeK00WbpL1n+HclYE9oiXmkj6GGRZ92DXf88MJ7nQgdBOhfAC7bqscndI7zOHQIh4GRQVj0p7pzPsYtpotsjnhtcChekyCRtYs9r5wHaGn9I/5f7xdAW49Sytj7ZW43EpW2aOewP2XJoX46fc5uaHrU6FVMOdkSbuFhK0ZXJeQDEvur1nQbJ0JGYOJQOLHErY0QkMtx1jMhQgznQd0BzgwaLqaYvk2Tt15Kh2KYpzbOrCAER0DdUh2WVsa
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5106106974D96ED78BF70A63C6E80@BN7PR02MB5106.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN7PR02MB5106;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;4:mHOfemUw4JFDRuR87yjyn8XNDbRcnoldu7rQ4RCvQxd+9pfZ9SNVASu6J7abxEpO29qKHE5s5+fIU24gFeplFNJ9G0C1EDExDtA8TejE0f182WC7IDyLmeTegKtiddVmvSSQLtMXgh09vVL57McD7uPjAyEVJzwFElmbHsNZ8QUHcW943g9yPo/Runepnqe/KkO0/wTmzfXxMH0xRkP7ry84XgjBZJsKHbCkW5qAqwrfxWi3x4p5kd96Du5cR0kauV00mB4Kw/MVdI/8b5+nQJKg5++9+JR4iGZGj8BFGYG6Wa5E4C5ORye4hI/+PUWir21rl7SbbYQGnoxpl7L/p1eDsx3Rs2ihkaDAacnQew0=
X-Forefront-PRVS: 0813C68E65
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjAyTUI1MTA2OzIzOjZ1TXk4cHc5bncwNGNCd3poSThKdUZXcVJP?=
 =?utf-8?B?RXhZWmh4dnVLRG54VWhLa1hOYk54YlVDcVBjVk5yT2pIOGpmakUzemxBVVVi?=
 =?utf-8?B?ZXpCVHhzdTI4M3hvMUsrRSs2N1RuRnV6WWpqTlB6d3k3SHp5b2xKdTRKbEdC?=
 =?utf-8?B?d1ZUUTVaOUdTb3BJdzd1NGUxQ3VVeUxONzJqWkpBeFdIWkloVEJCRVJjWEg1?=
 =?utf-8?B?cnpyejMxZTRURzB6ZjhYdWNmOGpKRmZlaFBtUDNHUlhpY2NQRGNWc0xxNWs0?=
 =?utf-8?B?V3IxbXYrN3R2N1dPeTUvVUEwanhDTGhURmFYUTdTd0oveGUzbUQyRUxNeGFw?=
 =?utf-8?B?Mno1VmZvNVArajBDQTFNUjNOY2VwdnZZK1FZYkxWZFEwQXdla2R6RzNkRWlM?=
 =?utf-8?B?aU1rbkJtaUlwSUw0T2MyWGh1bHppM1dCQ3ZONEM1VHA4YkhiL3NNSmExaGJo?=
 =?utf-8?B?QkRhblZQM3RnMjZNR2Q3OVBIWnR2ZDR6Q28xb0o3RkZwNEY5cFVlOWxBb2M3?=
 =?utf-8?B?TSt2WFY0T09rNDJvVVEzcmQ2Z0ptaTIzY201TkFWTWh6TEhBbkl5dmZsaEJD?=
 =?utf-8?B?b28rVFh3aUpqdE5nVG1IaUhwdDhwajZDWWZOOTB1SFZOR2R6VGRGb3VZdktO?=
 =?utf-8?B?N290djlqKzhoNGkybTBVdHdYcTRSVHZSN2lLdm9vMjFHQ2N6M1U2OHF5VGdO?=
 =?utf-8?B?MFZhM0pSdkVQblRVd0FnZFYxaTBuMk4yMEswYVNQbzZydHJLbTFnZ1BVYmcx?=
 =?utf-8?B?akNYcWFNUHl6dnVldlJwYmsxVXNReUU4T252cFBMUVF1OGorYmttTXdiaFIz?=
 =?utf-8?B?ak03S0hDbkJ4MVNtZTBGL2J1QXVkYlM4ZTJwVlVGWHpTZnp3OVNoUmJkMWZJ?=
 =?utf-8?B?eTZmak1jeEVDcEVRNUV6TWhFODdzSjd2dy9LZzZYeDRWQ00vSzlpU3oxNExx?=
 =?utf-8?B?VDFGK1RsQnJ3ZEdIUXZ3ZmtWQjdsQkZ3Q1NqUCt1cVAvbWg2bFlFTnZhSjht?=
 =?utf-8?B?bmIxT2JIVUdlVFZyanJHY3NWRzNuNW1uNXlIbVNlb2NZNCtoYmprOHBBTktq?=
 =?utf-8?B?bDYzU01NaGpqZnQ3bkpwbUNRMTQrR2lxbW5Oa3RkMDJEL3R2M2QxZWFRSU8y?=
 =?utf-8?B?K3dZcXRCZ2dDWjZYeFhic0hVUnNCdUxrN0dQWW53bnFmVzRVcFRxSFFoU2Zt?=
 =?utf-8?B?MlRnbzc0K0wvamVGUFQ3UUZ0SUZOTURkbEdxd1U0S0docExOOFNmc2VjRGxC?=
 =?utf-8?B?RG9sRDJmYmNNNTMzRWtLamxhWGNKYzhQYlp1dmszYU1lQ2ZzenZYUWgwZ1Fh?=
 =?utf-8?B?a0lxZmRPYVQ1Z3VUSlFneXRzZ1FUeVM0MmNmalRDVDA5T0Jwd0IxcDVvRWF4?=
 =?utf-8?B?TlpxQ2lRelVkeHUrZzh4QlFYZ2dTN0xtSHdrYnlpUlF2YlNyUUltRlQ3WGhk?=
 =?utf-8?B?UGFqMkVtc2xNU0xGclh6dTBoTEg4YmJwUUIrNUtURDM4SXFDdU93L2lIV0F6?=
 =?utf-8?B?NHJhNFFiNVhxdHJHNkV4MlgyN3VKb2NaOUZzMFFqZG9SZW5qQWd4c0JoenZ2?=
 =?utf-8?B?emd2UGNXcVhONm1mMTJrcmZtTHAvNUJ3dkZpaVFtT0ZIYkFBcDJ0dUw4dEZm?=
 =?utf-8?B?d3laVStuN1AyMEt1WUpmR053NHlmN2l5eXVqcXQzSURzMDU5MGZJbldhTWxW?=
 =?utf-8?B?WW1LdXdCWVQzUXZsdjIyZStyTDMzbm84ZGYvTGQ4d2JpVEdCWEVHK1J2Zkoy?=
 =?utf-8?B?elZQY2xjSVdKa01GajV0WklTT1FsK3lMekxOTGRvbUFXc3JPd0dUMlhKeStz?=
 =?utf-8?B?OWFsYTM2M3dSdHNEd1F6OFR0bFMxWTNaby8vanZrSFFXMWpMVVhZZzRPbEJ2?=
 =?utf-8?Q?8vNhqbguUqHsEmkpAtun9/ZDc27TnzcM?=
X-Microsoft-Antispam-Message-Info: HxrRLMv6Kn4mKtcQ/mmLS2OPOQnMJsFm5XXuPW+Czd6WG4kfUgb+gEvUj/UebjMOmlkpf17hJk4dc+SgiP7RxhZk3LdBzDNLgW49lvM9oPR/wUqCf4NhvZ245k/YzPp2zTkxkGgO3aqSF2xWCJXwamzZ0pbgkCF3dWZZARB+8CzeteoHydHpTrNNMGXR2ZR86COfVLdLv0qLddKEVZe0FJaDBS+A3ktxoE2gL0PB3neikPC3lPLO57zoZApBgDaP12z1Vl2MhV3ngRPDN14D2xw41mi4fkGf6RlQADeMcwqkQ537h/x4CmuI4kjgSbaWpNkswcq3AaWWrEZPV2GyQKm2Erc7Mpm2cHtXbIqXGis=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;6:uav2z6nzEZ2cFHjg7ha1Ilg2/SXl+Ep8Ca9SWBvjZe6BBF4D/ERQvJI97viLFFYQJxeaw5ADToy42jUWZkDU2w86TOcGIwJNAO46YxJQhkhOqiAeIdCqC4Hqj1/+pHSzbQv1R2z8QlWE5vnmVV3DhpzOmPjL6aBF3N6jk7E4LAt9QOKaOad9KgB0slAC1fOiOyvTCxGv/M4BjU08wSqnTOONv5mJPGFtya5h/Z3H5wy9i+GqoFmSR3Rv1+K4Z2o4KL+njke88QgFPNfY//oCOnCG14lXGQmH1CUluEHcCPlNLgGwOb/2aHqFvsTg1EXsfcoFlcL7T7916IFciamJfgcqiOWgBv5KXW0QS5c67ph4bY4Qa19UWF8sOG7q5rLxaQy2HP4NpS5z1oyLewImwzK7AThvN5PmPArJeXSrvRvt7KBUwcX0ApeAx+SRN+JAGnST6iKv5DSLdhyEura9sg==;5:tbs3rtZcwfdvV4OrXk+G0Z5XjDgHjq+XdABtz9ScAFRQKhP4qCQBnMKLVBx1EFsapbtPXskF5i2ez/ahsZp/656GXiwDTBRFGb7OlKzChJNXk5vKJskawcTmeKhVGoECGhbkZwucgLFBi1sbmJur9hN6ouzGlRER4unvkq2s6Uk=;7:snNcMN2WyjwBANEit/RkZW/ynv+DYUfxaqTxKTPruofDFzXi/4n0UGcWO2Yu1yNZmPmzD/5dZ06HydszLkafX2tSgOYCgiwLjLHH8s1Cd6pjU992patWzKtLrq+l/L8u/Ak38eCq4whPlWiSMa8bkrDHJrZZqPqR/XCbjxcRjN34g2Re8Sg3ZPlI5CHZUqvEeDsY+PgR0f06GR09E2X7eippTCqDiaDCiQFp6HlghN8STmQ1rq5R6hFaderS/tQ0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2018 07:07:42.8275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b9c79c-ebc3-4e94-3fb9-08d62835bf83
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.9.2018 08:37, Firoz Khan wrote:
> On 9 August 2018 at 12:18, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 9.8.2018 07:27, Firoz Khan wrote:
>>> __NR_syscalls macro holds the number of system call exist in this
>>> architecture. This macro is currently the part of asm/unistd.h file.
>>> We have change the value of __NR_syscalls, if we add or delete a
>>> system call.
>>>
>>> One of the patch in this patch series has a script which will
>>> generate a uapi header based on syscall.tbl file. The syscall.tbl
>>> file contains the number of system call information. So we have
>>> two option to update __NR_syscalls value.
>>>
>>> 1. Update __NR_syscalls in asm/unistd.h manually by counting the
>>>    no.of system calls. No need to update __NR_syscalls untill
>>>    we either add a new system call or delete an existing system
>>>    call.
>>>
>>> 2. We can keep this feature it above mentioned script, that'll
>>>    count the number of syscalls and keep it in a generated file.
>>>    In this case we don't need to explicitly update __NR_syscalls
>>>    in asm/unistd.h file.
>>>
>>> The 2nd option will be the recommended one. For that, I moved the
>>> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
>>> name also changed form NR_syscalls to __NR_syscalls for making the
>>> name convention same across all architecture. While __NR_syscalls
>>> isn't strictly part of the uapi, having it as part of the generated
>>> header to simplifies the implementation.
>>
>> This macro was in unistd.h in past but it was moved out because it was
>> causing problem with strace.
>>
>> commit 40c2702a02b755e0183b702778331b351f3be20c
>> Author:     Michal Simek <michal.simek@xilinx.com>
>> AuthorDate: Mon Jul 8 09:50:24 2013 +0200
>> Commit:     Michal Simek <michal.simek@xilinx.com>
>> CommitDate: Wed Jul 10 07:32:09 2013 +0200
>>
>>     microblaze: Move __NR_syscalls from uapi
>>
>>
>> That's why I don't think this is the right thing to do.
>> I have grepped strace and glibc and none is using this macro that's why
>> I think it shouldn't be exported via uapi.
> 
> 
> Thanks for you reply :)
> Sorry for the delayed response :(
> 
> I would like to keep __NR_syscalls macro to uapi header in order to simplify
> the system call table generation script. Otherwise the __NR_syscalls
> macro need to update manually. That become a problem.
> 
> Please check the below implementation in uapi file make sense?
> It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
> and enclose it in #ifdef __KERNEL__
> 
> ...
> ...
> #define __NR_pkey_free  397
> #define __NR_statx      398
> 
> #ifdef __KERNEL__
> #define __NR_syscalls   399
> #endif
> ...
> ...

This should be fine.

M
