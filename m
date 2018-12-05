Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB459C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770FE20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cYrelua2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770FE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeLEOnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:43:10 -0500
Received: from mail-eopbgr740081.outbound.protection.outlook.com ([40.107.74.81]:3670
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeLEOnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwFj6fUi3jMIeu92FdHFjuWyzJ8yB1ZAjdmwl9NuteQ=;
 b=cYrelua2dag2TJ8BVq3U4sFQTfYXX4mAv+l1fyezfYouUEZ4Se5j1zFlKoTGGW7aedk1oAWe9S6ymUtclSad2+8yitY2Ahn+pvyfhn1CxKzvtrP5BUeoCxQfZ/8OoZnRDeP/OKJcjDiAgwF83poDopHqRc9ohH7bfzoLfcSIYtA=
Received: from CY4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:903:18::32)
 by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:2a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Wed, 5 Dec
 2018 14:43:00 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by CY4PR02CA0022.outlook.office365.com
 (2603:10b6:903:18::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.17 via Frontend
 Transport; Wed, 5 Dec 2018 14:42:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Wed, 5 Dec 2018 14:42:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45996 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gUYO7-0000wM-Ib; Wed, 05 Dec 2018 06:42:55 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gUYO2-0002TY-F3; Wed, 05 Dec 2018 06:42:50 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB5EgjmW005097;
        Wed, 5 Dec 2018 06:42:45 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gUYNx-0002SM-81; Wed, 05 Dec 2018 06:42:45 -0800
Subject: Re: [LINUX PATCH v12 1/2] dt-bindings: memory: Add pl353 smc
 controller devicetree binding information
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        <mmayer@broadcom.com>, <f.fainelli@gmail.com>,
        <ladis@linux-mips.org>, <treding@nvidia.com>, <digetx@gmail.com>,
        <d-gerlach@ti.com>
CC:     <linus.walleij@linaro.org>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
References: <1543496257-5396-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <52d598c9-8e72-c30b-edc8-bb16e29b425a@xilinx.com>
Date:   Wed, 5 Dec 2018 15:42:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543496257-5396-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(189003)(199004)(54534003)(8676002)(81166006)(81156014)(186003)(26005)(8936002)(58126008)(478600001)(54906003)(110136005)(77096007)(106002)(356004)(6666004)(2486003)(217873002)(23676004)(47776003)(4326008)(65956001)(65806001)(2201001)(44832011)(39060400002)(76176011)(31686004)(966005)(9786002)(50466002)(64126003)(316002)(305945005)(230700001)(36756003)(2616005)(6246003)(36386004)(11346002)(486006)(31696002)(426003)(476003)(126002)(65826007)(336012)(446003)(2906002)(6306002)(5660300001)(106466001)(229853002)(63266004)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4332;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT023;1:jyIqYONIjh2zZ6h8HmDDgtdVZzyLAVkSB/A9FEc9tysrHkME8qTtkYXrSYrFf/llygkGSbVmzihWqRMANhTWPSZvEh1mhYtXkCMO/stIU+aqT3LZBq7zDZDCb85S69o0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6428cec-2754-46be-1eda-08d65abff3ad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;3:CQdYD6dIIfj+jHvoFGdtYtACGbZAwuRFaa45/Ht0qpyRBTLQr+mlrMuB4yU8u/XlcRCuGcaFx+0EW7emVLn0BQa3mRJ27DWvWsy5VKlMKMV1Tx2xptMxQ5YA7NcdNpARF5Fs+wsRP5miJw0T5Mn7korVVXdX6qGFoy1IW3VNMuP6SEjkV/nCDWEaX03j13khxsqBUYnHtP8ZtJALpQBhgIDhB7oOldeHpLcpnPN635u50pD9lVhZMKAhkKJGJQSXuAmz+7ZLDxVhcFg6MWOeD4dwEBgAb/8i5uO5jMnQIYFwSX7xb+9R0uqiTWwV3+x4iLNV5iFJJgKYcXyVO6M5oP2IW6DrTw3y3DD5cCpIMcY=;25:J0TdoBLuqYGIB06UwfCwGLIKoFgi78QOJvUz49D4sFEVt/oF+HZdfBMHKN5bF6f+3VtJaEqmxUN6i4SRmScTbObZ9Q+5ATJtVpqN1P58VHp2Emx78rTGutvQhAP6ykt50o+iSrMtkCP6DUjfI7edw4G4CkoCnYE3qOu3FspduIO4CYzY4Ld86MtTeWeFAlBXq/nxP3renD+fofvsHrJgJyUKk5/ANuF/mJJJjl1koYlPNmLPtmw0XNBrDOf2bYKTKD43uqzvvPRIPutq1eOLnJHwcr9llLF9BilNu0edL8CzEqF6sV5Fg1zXRGuTXHuR8GvbhdRpfrPjIio+XOtm3A==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;31:XMIGI0pBuDL6SOi+F4wSy1OVjRcjfOoDxFJkqfUZxH5A636xS3KDGEHWyasjNaLDAmL/Uq7qsDiDugMCAaiIzCyO/d54HxvGW8AdSd6G01uNRuCsePTjtt3qkys9m0B/ya3Bth4rcFshs9FQStU/WbC9HCjlLc4JFdJiNiEmqcm4FI4J6uTzZrff0O8G1IOx8lJmzbdtTNX8h1XgJlKOcMp0z4Q68YNI8qBNmrdBsUo=;20:sMdIZDZ4Km8PiU+sDA4L3vKFnTnT3i2mcxrAfOF4To9EV8+xQWBkGo8Xn7VhsvRfP6JSHalkxXKBWYBY5QmOk9L1pr71hunG18bkIRBPYbT0arpkdlnWcYS/o+yOeLVIWgnsLB+e/QyI33xo1B25Xk4bJq07EDIwlturQ6trrJE0tQ0fzkEN95d9IJVzVTJNcCRBrpvELjPt9bAzE4Ds4DcNWK5fF39XEQFjcJkQ/AMj6b80i6aaTxJERoEkJorcdO6YJHDQql+7MXNOF60feQEbaNIu2xluyL1u+Xu/Vf8SIBvb0oUEARLMW/bdhYOub7pq3ytKoLtiZuYDTja4HsJ+zcJx2O8vBhSshn0DUh6eoCbrzw+FZIYB6YaBebxSiHxXMgarNg9YMFaJmBYlacLBrH6HPFB0nv4h4/JP0WkX2j6pf+wlO+7aGaFEzLzWiwMmM4PSnECay/drgVfedN0jghspA12A0CY1DpKugAnFVQ4Lc8RaxIA8OKE9Hw99
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43324A8EA69F582D8645C5DDC6A80@DM6PR02MB4332.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93004095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4332;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;4:WZBxBO9j4qVWS5Ik1hKNP8nArhdl+mS8wNeH/ZjqmlsQzrArmxw02zfHj8Q1Gg5Qa4Yv/yb9iGTM53FLPW5K9TSN7veHZTrl084H/FtJU++ya3UP4SBBV7Yjtk5hmGuuf0bIJJt0Ld5+ZSfaILol3UBd2IAHtQv8sN9DxWvz4O6RJi51e9U3DHKWnHjODvheNErC87ufzgWzaGJfIfudOhnEZhZukWybzCuP/dqTPLiIKgmNLpUR06qPjc+3+aP0YvVYEg9RNgNXetPuSicVDQ==
X-Forefront-PRVS: 08770259B4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0MzMyOzIzOk5rN09kdm1vdmViK1g4bUN0MEVnWFc1ZUNL?=
 =?utf-8?B?amVkTU0vSmhmR216ajZ5ZWE4Q3hLU2VDb2ZWMzFCYzVkeUhUd1lybDlsdjNJ?=
 =?utf-8?B?RWJMbWdlRGIzanFFczcrVEpVZzVFU0dzbzRIamVmc0V1SjJDYVRBRXJwRld5?=
 =?utf-8?B?R1NjTlJrTHVNSU92VXB2a0ZIdEtvNWs0aWdxRDMvMEFzQ01wNXJXSithV3ky?=
 =?utf-8?B?ZlJpdmloY2dQb291K1R6WFU2Y2lXOVA0czYxdXZpUzB1WGsrUEloMFNnR3JT?=
 =?utf-8?B?OUh5NW0xZVlUNTdMbGM2eGNNSEtBVEFqcTlxdFQ3OUJ6UENGRm1PbDd6RU1w?=
 =?utf-8?B?QWE0cUV2eUIvVzNDVUVyS1VCckFwL3hZWUtOc1JWNUpFd2pTQUNGV0JPWjlR?=
 =?utf-8?B?Z1pOQnFFdmRETmkxZ29SYkpKWTdUSFdPTmNDWUJkcDZjTUpWZisxck1nc0lE?=
 =?utf-8?B?Q3RJemtUZDVOWWU3d3ZmZDZCMm1ndXJKWkhmN0svOXVnV0dlS3E2Z05EZ2JP?=
 =?utf-8?B?ekdoVFZPK1FHSE0rZ1h4NTI0OXY5YUQ0MHErNnZNQi80YXA2OFY5RWZRWmxQ?=
 =?utf-8?B?b2lKVFZNeElnMTkzb04yYUR1REE1dmNqUlNLaWYwbzY0bW1xb21zd0ZoYkJH?=
 =?utf-8?B?bkJocWg0UHd3WUZxQVg1QVE3VXRUZzVQNTFXNHVPTDB4QXRxbWNZTWNqUWd5?=
 =?utf-8?B?bms3SVNXMTE4UmRTOU13TXl1anNsdlI2c2g4STVYUVUralZ6N0MzOWd3dHdQ?=
 =?utf-8?B?czFiM1UwZTZtamhBVGxPcFliN3ovOXpNcThNYXVtOVMyMEE2TWYrc0NNQzV6?=
 =?utf-8?B?QXh5MzVhcHhMSnczbFY0T3FFTWZCcGM5OHg4TmZzbXlGNWN4ME13TFFPNmhl?=
 =?utf-8?B?WFVocnErYkovRXZiTmIvakVJTXhMelZ6SUpUeWJFS1h1UG1xTVRFeEVxOWZ0?=
 =?utf-8?B?VitUSlJsdHk4SzRmc2t2bWM2ckVaYUtQNHF4OVFtTk5LQ2JFUCtta1FnN3dB?=
 =?utf-8?B?Y2ZOOWVmVHJTeFZDekxRUllmNjFseHAwUHBaMzU3QnJ3Nm50N2xPT3doN1lB?=
 =?utf-8?B?bG9RN09iT1AvUThaMUFpdDdJU3lTYmh1S01tYStoM3pUK3pNQW12cFZ3a21x?=
 =?utf-8?B?NVhhRk1GWlZ1OVMvU0RldlFBUmlhSW4zMTNMOE50SkpySHd6NmpjYUlRbGZB?=
 =?utf-8?B?aFdMa0x6dFNBeTRKSWl0cXFuMXlKY211eFQzZ2pmcHJ5ZVFDS0VtaGNwSG1I?=
 =?utf-8?B?TEkxSFM3emhVbFVpQmU4YjVwK0lrdWdlWEo0UXh0Q2ZMOTk3RGVyNTZqOXNG?=
 =?utf-8?B?dFcyM2xSWTluaVN3amczclV6ZzY0Wjh0KzlSSHVSdjZmY09ZbWpmUW83MW53?=
 =?utf-8?B?ejlFU1ZoMFROMHBPdDRRWHRoYjNJK1hodG9tTXNtWnNjQ3JTVFptRDJxaWFT?=
 =?utf-8?B?TDJBTktTa3dQVVB0TnAzWG5SYUdaSG5FZUxtbFp4NE9hSmFwd00yN1JTeHJv?=
 =?utf-8?B?MnF0cXMwVmhNWjRmVmJwWWlIR2lreC9KQ2I2RmhoMWg2cStnMkJEL3AxNjZC?=
 =?utf-8?B?Tmo2NDRGT211WkpxZ1N3R0lkOEpuZUg3eEphVDY2YUJ4Rkd3R3ltTFdxMFpL?=
 =?utf-8?B?bWRRMzNxTXdLN2draC9nTGFHOW4zTFlVRDZ4NTVoUkFwZndscTdjMU45cDJm?=
 =?utf-8?B?OU1JYU9zeFRaVjZ1Z05YWmpITktQZHdaK01nTE9yL1g4Qitid0pmVW9yZVF5?=
 =?utf-8?B?Zk83SkROYUF2MGs5cUhSRmVuV2VoL2ljc0RjV0FGQm5wMm54RUVFRXZpdnUy?=
 =?utf-8?B?RTJjaGtJbHIxT0R6NjVwajhXM0p6MUtqVWE5OXNTbVJzczhhb3J4YWdmbUpQ?=
 =?utf-8?B?L0tIRWNHSGlRSEI2MHUyQjdJUnAzNjdsU2l2UG1jK0ZpSzVOczRUZTV5SXZ4?=
 =?utf-8?B?eHhNZzk0TlVRPT0=?=
X-Microsoft-Antispam-Message-Info: wTD5CXmI8fB+72MExQn13v9RlXpZbgVFVV5mBPP/UnlT2N1FGhapplgq6zBsZXLTOkn8LJA9EC+NgbL5oUWPlS+ausdib0McF5eP7+liymf8hheeSNaDQ70D57xQ0Km7SyUV3FQVwJYejKRIAcKf0GSVfggWp+CfyrapfxfqQuAyVDbVEhtKeIsvVo/d6UMMAlg0u+20bP5uvVLhAO9orfv+InSqUUSNc6CCUohh56A9PIxhKVd5p14suW2jYzCTLtzea2Bi56IiyJnUoIlLYqnZM/oLZk1yPOFv/Srn43cQTZa5pfZpR9Si2bxQmOKPzcQ7HdyLqeBDRFCdIpMymPAektMRiLMAgVDp36Kmo60=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;6:NOIg1jeWs5pO/gQ9JPRrozsAQ/HJNuaKZG42L3GZm318dOm5pCkJkdbQHPm0BtJRoPBGtUqviT6RJ3BQ1WceAMFTNUrh351KVfBjl8bu31FEAl7SF1vakGKZTED6m16KNj/ixFcM8oZr7OBW72OteEuA1O6a323GHcSqu1MXT7rPoTL27DPRq4wjb4iZY7UXBaf3qHAFutbXcIFI9awF7rYhdtCwTAN6m9vEckZEa7DyruEAhhV1bfsETF1plFLnnDmmgyRuSWzMKslP+2cHj/DxbAtFzjoJUdTE17OnjNX+uprlIE7kCivM7VYorb1mLm8936/lKuv75TDqAtvuPpcyqhfilxyaIluB23LBNXybZmw+Nt2ggfDtyH8CeA1/MCq7+NBxS2dN20hK1VcNEiHNgfTW5+U9nHLYTQCrRLcg7g10Pzo/9KnjHsGevKtXLl0lRY9D3+DSZD5E1rJohQ==;5:jdQLSYozWZCu1hyeLXebgdVWAf5/ZcGyVcPTXMeT0PzypFGfvRvu3D4aV2pehiFTN3tGHR72wi4or+4XwPh4h6CJcNmk9T58npXDZoS2Zw6LqK4U97jWgPPt8mTRdUuFMjwTctqK0JAN7quQqLwp7qVbBPiHutT6ysZ6BkgdOQs=;7:0zo5nCc34mGh12R/nljfHFeTGk04IpZLHH99w5VdmCY43VZEK2g5/S6HVeHDVG58osMO8XX+WDeTXztghkY8xh8uz/MiLTMQHN/lCa99eeCeWw/CMlMH512gyA2VB2ubPaNof6dZd09U1cLRclnDRQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2018 14:42:56.3121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6428cec-2754-46be-1eda-08d65abff3ad
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 11. 18 13:57, Naga Sureshkumar Relli wrote:
> Add pl353 static memory controller devicetree binding information.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/memory-controllers/pl353-smc.txt      | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> new file mode 100644
> index 0000000..d56615f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> @@ -0,0 +1,47 @@
> +Device tree bindings for ARM PL353 static memory controller
> +
> +PL353 static memory controller supports two kinds of memory
> +interfaces.i.e NAND and SRAM/NOR interfaces.
> +The actual devices are instantiated from the child nodes of pl353 smc node.
> +
> +Required properties:
> +- compatible		: Should be "arm,pl353-smc-r2p1", "arm,primecell".
> +- reg			: Controller registers map and length.
> +- clock-names		: List of input clock names - "memclk", "apb_pclk"
> +			  (See clock bindings for details).
> +- clocks		: Clock phandles (see clock bindings for details).
> +- address-cells		: Must be 2.
> +- size-cells		: Must be 1.
> +
> +Child nodes:
> + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
> +supported as child nodes.
> +
> +for NAND partition information please refer the below file
> +Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example:
> +	smcc: memory-controller@e000e000
> +			compatible = "arm,pl353-smc-r2p1", "arm,primecell";
> +			clock-names = "memclk", "apb_pclk";
> +			clocks = <&clkc 11>, <&clkc 44>;
> +			reg = <0xe000e000 0x1000>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0xe1000000 0x1000000 //Nand CS Region
> +				  0x1 0x0 0xe2000000 0x2000000 //SRAM/NOR CS Region
> +				  0x2 0x0 0xe4000000 0x2000000>; //SRAM/NOR CS Region
> +			nand_0: flash@e1000000 {
> +				compatible = "arm,pl353-nand-r2p1"
> +				reg = <0 0 0x1000000>;
> +				(...)
> +			};
> +			nor0: flash@e2000000 {
> +				compatible = "cfi-flash";
> +				reg = <1 0 0x2000000>;
> +			};
> +			nor1: flash@e4000000 {
> +				compatible = "cfi-flash";
> +				reg = <2 0 0x2000000>;
> +			};
> +	};
> 

v11 was sent long time ago and also reviewed by Linus here
https://lore.kernel.org/patchwork/patch/961603/

I can't see changelog which you have in v11. And also recorded changes
if any.
Then this driver will go through arm-soc tree via me.

Thanks,
Michal

