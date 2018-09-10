Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D37C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD25920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="V2cjtqfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD25920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeIJR2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:28:54 -0400
Received: from mail-co1nam03on0077.outbound.protection.outlook.com ([104.47.40.77]:48832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728087AbeIJR2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBMQX3Zzumwbo6EA6U0rPPjuQ6KG5ZbEYCh3Jy80W1Q=;
 b=V2cjtqfBkwSs+fuWe9RUAcdsx+PFVAXRz5UGcff/javsoHP7QZusuHuu2jYkRm1orR+aU3ll7ugA2UwaHbVCDcaojaMfxa0PJfixXZAASDK3rXztAGG7Mqs2IVsje3HAXqXdLRiOduucc3J6SR4TFRNuL2v5PnvbEVZiMWk4WH4=
Received: from CY4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:903:18::28)
 by DM5PR02MB2683.namprd02.prod.outlook.com (2603:10b6:3:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Mon, 10 Sep
 2018 12:34:54 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by CY4PR02CA0018.outlook.office365.com
 (2603:10b6:903:18::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16 via Frontend
 Transport; Mon, 10 Sep 2018 12:34:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lixom.net; dkim=none (message not signed)
 header.d=none;lixom.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Mon, 10 Sep 2018 12:34:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37415 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzLP2-0002JK-F7; Mon, 10 Sep 2018 05:34:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzLOx-0004tH-BQ; Mon, 10 Sep 2018 05:34:47 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8ACYekJ015801;
        Mon, 10 Sep 2018 05:34:40 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fzLOq-0004re-AJ; Mon, 10 Sep 2018 05:34:40 -0700
Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To:     Olof Johansson <olof@lixom.net>, Jolly Shah <jolly.shah@xilinx.com>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <matt@codeblueprint.co.uk>, Sudeep Holla <sudeep.holla@arm.com>,
        <hkallweit1@gmail.com>, Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>, <rajanv@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <89a81241-e2c3-9fdf-7436-3d50025cec4d@xilinx.com>
Date:   Mon, 10 Sep 2018 14:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(9786002)(81156014)(58126008)(2906002)(446003)(11346002)(44832011)(476003)(426003)(126002)(486006)(2616005)(26005)(230700001)(53546011)(186003)(77096007)(36756003)(8936002)(106466001)(316002)(81166006)(54906003)(110136005)(336012)(65956001)(63266004)(31686004)(65806001)(47776003)(39060400002)(107886003)(6246003)(4326008)(36386004)(217873002)(65826007)(5660300001)(50466002)(23676004)(2486003)(76176011)(229853002)(305945005)(356003)(6306002)(8676002)(14444005)(64126003)(966005)(478600001)(106002)(6666003)(6636002)(7416002)(31696002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2683;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT055;1:LJLPRXhRZ40Ve+lHt+QSiEUrrDDI3021lDjpuFMsADEtQCWURdF8yxpZbDp9S2JF7hXZLOBSvkoXEmIlslB6T82QnphhrqKKeW7u8wcJAyo3F6mPjFbWdjTdBTzVDJPn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ce8993-8ad4-4254-dc33-08d61719cf11
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2683;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2683;3:7GfV9WYsAq5x37Y3VAfK3yWi6zRoY4TZthDEDlQK6+U6Zars6naGDvuxi8KhnzgBRwk0FtOnJTCyakx7CZnZg/5U++zJ2+n+sjZeox6VA5HXeP+GEmFaa1GneKpNJN6d6PKNJ1vG8vOjU75gcWaQWapzkXuBNYCAkuuidCFjFUXkXmkRJCLuq4lbU/tEygBs2AtlqwMrZTjxaz2xRUrSR2Zjwp1jPLYButYGvN6AZ5FlkO1KF6ZwU8rtUwEg38Hvk9tbi+mHBP9A199i67u9JOvlIC8og/jcBO2feyc/skdPnnttlFY/HZlv1ptsleYa9PZJ11UpBY0XPnV3Ee3wxhJjD3L+dODBCxTw79qHgj4=;25:X/x8CUN+k93+RBzQ6aNCP8CpzjdUuIggQlz40tJSC8UBcLFhD8YAwPaRXyslhrVPiGE6yg+iFojX3ns2gSF51sewzW0NpPGIo5OaGf6M+74mVAEHzXM/bS98l1LRrwfu3LAfezC7jgdfJSFSR6Rx2A99RVjH2YoMQgSeSOLzpDV4/oetnHpKt6ofHsAD67viIGh1CFzWM08TSP+pm4IPL0CgKTN5Ycw9Ty1YjHpG1mtBu/5abWGOD5kkKfqpIjocwhuyImiIzEZ3UBAgIVkp0v0qT8VFCLh6XJPmAAd24Ng/QdxqFQQF9vjkYTG2ZD5UxeyOQyEpGQqoHatjKm2beQ==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2683:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2683;31:nI3Ezy2eEl0oysS0K/7xdkhh7qBTn8CfjAp/U5XOZXzevEyTLyxpNEHbbPv0UqcNKPNF/VjrRx/W8GqthhEahZEUMByqzqGlSA5w5wr4H4VQYZEZF4vhPOXpT30/zj1n7sGZ331gEYTvDv50pebkYtFKw7NzeFKc7clomsGlb6c1m+gi0e2llBrrhbMAFgNOXgUuQHCHfQSdi2qxsSNE/hpUj2NZ5OS7IlIbqQkcIEc=;20:wwL6uKO4Bp6LCmhnGeQ5lOvKk128e0PioltIEpLovUajcM9Gb+c7lrXQxBLyiXDsNlxpPFun/0y544Z2iDfu0qsJQukLJZK5VxwMkakM/fGs0cv22LBY56dAgriZG6PIDa0CWgL31P5spAh5NZxEUZvxRDmtfm7VN9Tko9Th3SSW46wAi9CuJT6rAjOtCMmJJ6jXzRfP9AYjK6kag8w4gDJ73K4Oo0VcEAwmA38SoOiDDdrofez51UXdQe4cWaep3VYBwvZrll4cMkASpcdYG3yWX2K2PMWiCKkBBLMrFuiL3RT96tuT3ypn2STVcatnK0mUJ1obDoEi7UcqPt/w33c55VfphHVsEkKDJqvH/wKnCwt7JhLwvLlbyw/eigyVxBKs+rUvYY2weaK/y0LbM6tQvQPyYORP4h75pHSQFyjmy6jdfGyUGjk/aBhMvUYe/1uzv1/tENVh5OevuEIb0zmMUbcFGtLWPVBUBEMorz/3a52cuiErQ/U7bnlI8Lab
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2683FC8DDE1E0CD957DF4F12C6050@DM5PR02MB2683.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM5PR02MB2683;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2683;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2683;4:E2yZs8xjkQ72epBj/GLLAuww+Wjo49wFq1xRIMinFOvc7f4AxMplm73rTgvViVlhy80vMUuFZG+LJ2xs/IoJX6IEDHmS3QlIemuaqW5quwH5GE6MbVzYbdks8a6O1UoziEqG24jj5dAZvfqDwgkMX8T4v5EX07TIgj/1MR560f8DGLvo6zG/cuSdSYtDJfl4RD3t4/GspoZwby33f2V86Ct/QwNA9vOgtkE51JMl/d1g/RXqao2GS/Oxel2XSC4k1iNM4/WBGrLc8AtKrRwHmiAnxoZTMYVtrc7w0JFFxMQ03UAc6mIA4uiGrvSctrS6XhSwHAC3ouyRpEHJHeL4dVw+n1u5BFank+Zk1ypBXQ/ZsR9fWH4BiNjHtjGZoRQH
X-Forefront-PRVS: 07915F544A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyTUIyNjgzOzIzOnZpRUdDUWZPNzBsRy9jNXgvK3FLK2YrT2Ft?=
 =?utf-8?B?eHM2K1VEelhOTHZxSFphVEl5RDlnTkt6WHZPYkx2ZFZublc2R1JvR2NUamNO?=
 =?utf-8?B?ZGVaWWJEUzdPNkZVYWxyS3pKTTRsRlMreUwyNCtvamhuZlVpYm1nRVRrZmhI?=
 =?utf-8?B?S1V0M0xUK3ZlUzJ2VlllcmdwZWZMZ3dqVkxTYmtmN1JVbjFWeEl0c0UyQTB0?=
 =?utf-8?B?M2JadmlYbnJnZE13MTVqSHpFNkIzWWc0L1VNcisrTDRmem1xQTlicm53NDFK?=
 =?utf-8?B?L3ZabTV4VTU4Y2xOZmxoWUh6amJMbGtvRm9lWW5LTlk2RmVyQmRTOWVZTDc2?=
 =?utf-8?B?VFkrMGZBNHREZEVrbkNuTEdhcUpIdXNxYzM5a3VIbmZXdS9pRE5ZdnoyczRF?=
 =?utf-8?B?eFBQUlJsdnB3enBkSUQzTnZlTUo0VUtFNjlrbGlhckZpODhZT0FqQzRIQXZT?=
 =?utf-8?B?ZkJDeVBxZ3R2SDlkdnNmYUMweWV1NzNEMzV0NFNNZE0veUhJM3ZDWTczSC9v?=
 =?utf-8?B?QWdROWMrTU12Q1pqVjB2UXJzVXNEc2VPcDAyUkpFUnY1T2hEY0FJSEVoWXNW?=
 =?utf-8?B?TDdCSFY3bE83bHJSWW5EZjZ3b2sxZUQxK25YZCtyVFZTbmZjUXd6NFFjRjFt?=
 =?utf-8?B?RlJXNzJqdU9zdENMMk1ZMk00NU12a2RxYUp3TFZWczkyaFlCTWRzVVc2S3FW?=
 =?utf-8?B?bGdEMlpTdFJURUpibXZBa3VJdktMYzBveUVmbWIzV0M1d2R3bUNrRXVPUk5U?=
 =?utf-8?B?UUx6QjBZNzVlSERYbVovUEV6T0JyRDZnU3cxY3Z1R2crOVdOOTR1RVlyQzhw?=
 =?utf-8?B?M0Z5TTc0TnB4dmpnZjZ5YWpUQ0pkK2JJeWtZbGxWSjZTNE80WTNHZG1kcUVq?=
 =?utf-8?B?QkdEYUFxVjJxa0dkUTNEc0VYTi9idVF5N3UzNXk2ek0vbW5GVFZHTGxOVWJM?=
 =?utf-8?B?SVd4UTFGOGVQK1dLMldTT2NjV0NIMnA0Y0U3Qm00Z1hLdVdDUWg4bitFMkRU?=
 =?utf-8?B?U0pHMUwvZTkyNzZ1WitWa2QrZUFmdmZPV0FRV2dNWVJZTXJiOTJ1RUZzVk8r?=
 =?utf-8?B?VThLK2xUZjZ2ZjY5bVk5M0hTckFtek1WVzJ3N0dVR0RQYUhvcC91WlRoK0xq?=
 =?utf-8?B?MDVzbVFBTE9IanJSdlpHbUF1YzdmdDMxVU9EdWRwZnFwdVBWMXNMWVBVNGUv?=
 =?utf-8?B?UUk2NmxxUUZWbWpLb0pTUzZjeFA1cU81ZnFncVlLelNNbEt0UGI4aTNtc2Mw?=
 =?utf-8?B?ZVZTTlJ4UFArdFU1Skc4WmU2bTNncG9SSGF1a2lwaXlDL3J2ZE53NUhMVGdX?=
 =?utf-8?B?bkZaTjZpNnd6TlNTT2JmZFpENEx3N1Y3dUcwVzQ0UEozUXZHNXlrVzduMTRv?=
 =?utf-8?B?QlBUWWd4OGU3eW5tb2RncFd4UXNUVmNnSHN6Z28xUVZZS20xRThIM251Q3Js?=
 =?utf-8?B?bEsvZncrSG8rNGRQNlhTRGYrbjY1d0RGemp0QWN0Z1UwbG9oQlQxdit5c2ZL?=
 =?utf-8?B?UlBCRjJtRXpDdGVlSGVvdFV3eDl5dXYxR2RGTm9JUSs2Zk8zV1d2ckJEdVMw?=
 =?utf-8?B?VmU0UXRhdEs0bXlKSnNiajE0dzlBUHdFVFpuZ0ozRmxKTEdsZ25ML0IvZEFz?=
 =?utf-8?B?Yyt1THI3aU8vTlVJd1Fib3Q4Sy9UYk1HRFBjQ2VvVVkwdWltRFp6cXFhTCsy?=
 =?utf-8?B?ZXQ5TU1meDhESFhWY2dLYWk0VWJqNG4rRkFLQUZRNWZCOGdhU2pjalJoaGNT?=
 =?utf-8?B?emZUaVFqUlVLS2R2QURaV0tOV2lMWkhtUDd0blZBSzZXUkZNdzAwNG96R1VY?=
 =?utf-8?B?aU1NSU5wUzBleHlmTWVIaHd5TVE5MkJOTWtmMVNuK1pKc2luNzZNWjdYRUNm?=
 =?utf-8?B?U1pmTXYwcGJCVTZCYlRFMFpLNzg2LzdLTnErakttSHArd2R5RkFOcXRzb3R2?=
 =?utf-8?B?Sms5clNxcStkVEZZeVJjSFNTeFNVNHowcEFqR2huMUJPQk1ocTV4Z0w0aFEx?=
 =?utf-8?Q?hROO1/?=
X-Microsoft-Antispam-Message-Info: Yvojc3DHT3RDE0D/aaoMxmd9dPvboYnLA5mqSXPMVM+IofcR6pYFKlSeY/KwuhnQFQJqA12vHOu//Mz3NZk8sJPVAYxoxjp70V9bilN412mqMPSjHPvEvI7P07ZxFXG1DDBSxmy0qlDZPq536OxkcrhT9cXjhXqfYmdyufOkMb75mXsHyTt5SmYe7xNoMTumo2Cx/ApjHi/qtj/BgONBzHdZ1hQzRLudcOPMqlaIrDeUsLQIstPtHQW6QyshpzbgXnyd2iNARkRLjDIL3xv/SNb8iBkVqoY1NQwKB/kkKvd2dKhlT2wZe+e/gBwkDyWzHUUSU5naHEeI5eT8BOKQO5MIhgC68p/9SybdXf7jEBk=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2683;6:qv+AiVJX8i6DR7m5ffOaGTgL2JiEHgmEeLIgf9ING7TuedsCtiVSOyKCQqMJ/jC/6XFWbHjhzSm5IBAUi7xF615SkKNAxVdCuz0+IAFzwUuSOIPLqATVk9BVgNVLYsHMnUovjE1AeGD/9PgjPwfGiF74RsxyzCoxFF6uilEwFIsA1hoE/P12XZju4RMH6vRmqbERuzUjFXqnXmCn/nRU3RKM5+zGRiEgAgBO2Dg/j7t4+75fwMDYGxmb24HcbqYoHTm1hI6fQKpuVkEDdrML/yFhhPEs3xsqeNVMNMRI1mdEv7D5O7gyYAC6IW3BGh6NQrdcFMXJDkv7IX9QlSw2rZblZCk85t9AJ4xewS5KvslV8Sok7vyOh7DXpArAQObF9hSSPh3OHdoLkqXVLarUB7pPnaGwHCMgW4YzmRgVYr+nAOzgB7ZfqXEdnIC9KfK5QYLYFRgyaaZAzLQJXznMLQ==;5:xGtsHaNXNdFgGeTOhG7fIaESbf4OvNSmGUNevxgkLHG0ltSsJITFrClZc/wqEH/AlqC/KEqU5ZdUc8jhpzlhGPaZwid2uVcF5mL6bbCFMSDe1ZVu9vYl6hvH2NdcWnulEamOVfOZexht2sAECA7xDbTnkZUZyOMy3O9rYkOkwmI=;7:tXvpL699kaaVXl8C9xP1SluggopLOrs7vpVCywd3xqwg7SZ8IsaGEzXUikLJNxElqRi1vNMs2puSzIEzlPlCWWBJlJpZHZyeDGDRctVHKTlaxy5jjwCjWuwmF22eiQYMsmHmaAsHdC4+mpaZLfJV6er0sDOAYnWIy9P53Z6qsw3pC1mweQ1TDr9cKbLs5qsGw0EJMZZVhQfgm2B/dvqE5bBejvObJWN0GWNmyyDfHakKBIj9GL6tX9Bk0GOA+5+N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 12:34:52.8772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ce8993-8ad4-4254-dc33-08d61719cf11
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.9.2018 03:18, Olof Johansson wrote:
> Hi,
> 
> On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
>> From: Rajan Vaja <rajanv@xilinx.com>
>>
>> Add ZynqMP firmware IOCTL API to control and configure
>> devices like PLLs, SD, Gem, etc.
>>
>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> 
> This patch worries me somewhat. It's a transparent pass-through ioctl
> driver. Is there a spec available for what the implemented IOCTLs are?

https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

> 
> Should some of them be proper drivers instead of an opaque
> pass-through like this? Could some of them have stability impact on
> the platform such that there are security concerns and the list of
> arguments should somehow be sanitized?

You can look at for example reset driver which is using this eemi interface.
https://lkml.org/lkml/2018/9/5/144

> What's the intended usecase anyway? Just a debug tool during
> development, or something that you expect heavy use of by some
> userspace middleware?

I am not an author of this interface but there is no intention to enable
this interface for userspace as far as I see. All functions should be
used by kernel drivers only.

Jolly: Please answer all others concern in connection to this patchset.

Thanks,
Michal

