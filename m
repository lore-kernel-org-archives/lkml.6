Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ACFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F2D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nhJpdq5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F2D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbeG3OZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:25:59 -0400
Received: from mail-eopbgr720047.outbound.protection.outlook.com ([40.107.72.47]:34304
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbeG3OZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcGccMHJ5iPYt/ZaadKdgbdYQW+ZXuz5ZuAUuJ7106Y=;
 b=nhJpdq5zuTsAFDevx2VeUBXafJydaeA0MjBV4Kto++k8H/7bTfpacbwLFBK5AzKdA1vUQbYYc0uyKV6jDbPfM+MXFs1ivthsHEqplm7QvDj1BH8HUadt68BR8+s5brNxiNssFoeqdXkBMmccorpfVakq/GQQE1MnfjgHrt3UqDE=
Received: from MWHPR0201CA0072.namprd02.prod.outlook.com
 (2603:10b6:301:73::49) by BL0PR02MB4449.namprd02.prod.outlook.com
 (2603:10b6:208:45::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Mon, 30 Jul
 2018 12:51:05 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR0201CA0072.outlook.office365.com
 (2603:10b6:301:73::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.17 via Frontend
 Transport; Mon, 30 Jul 2018 12:51:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Mon, 30 Jul 2018 12:50:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47537 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fk7dZ-0006gT-H0; Mon, 30 Jul 2018 05:50:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fk7dU-00077X-DV; Mon, 30 Jul 2018 05:50:52 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6UColfB027230;
        Mon, 30 Jul 2018 05:50:47 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fk7dO-00075h-TN; Mon, 30 Jul 2018 05:50:47 -0700
Subject: Re: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
 ZynqMP core
To:     Stephen Boyd <sboyd@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
 <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
 <19376df2-fdd4-12e3-da4c-37106fffed19@xilinx.com>
 <153262301567.48062.15432354725863055071@swboyd.mtv.corp.google.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e5448935-770a-5c14-438c-23a652b17822@xilinx.com>
Date:   Mon, 30 Jul 2018 14:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153262301567.48062.15432354725863055071@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(438002)(199004)(189003)(81156014)(356003)(2870700001)(2201001)(5660300001)(65826007)(126002)(106466001)(8676002)(64126003)(6306002)(81166006)(476003)(305945005)(2501003)(93886005)(36756003)(11346002)(966005)(44832011)(63266004)(31686004)(486006)(2906002)(2616005)(229853002)(478600001)(39060400002)(53546011)(2486003)(76176011)(110136005)(106002)(58126008)(186003)(54906003)(77096007)(6666003)(4326008)(426003)(9786002)(336012)(446003)(23676004)(36386004)(8936002)(47776003)(31696002)(65806001)(65956001)(50466002)(7416002)(26005)(6246003)(316002)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT060;1:erKBHLZUt+NpHDyprAqG06ITYYcGyP3KGrF6cuM7e81OzHcn2uyUVZJC7gfMiqR18ii42KajEPwDVwfgMXqt91GGbA4labSyYLdp2PGTu0plSJdsAA0GnkzXGd+iZrAL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ef1b749-39ba-49f0-c8e0-08d5f61b1c7e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:kqqoul0QxhAiN0rQHhmejo48KPqNk+8aAdPm19UV76yfHEhT10jJGI3ujQkKS04ouNChzKYwu2Si4WE+dAmQM029iGrTU72WB3HoLBR2s6EtiS+sb62i79hnCPExweXkVXAPmcS7Nn4XZWxXWBhKYyAI/lhMgRzdmgsyPTZUFeMuyQmWsKUU3qbKO4ZRFG9AJuI9rBRHUpWL6RRSbRs9Bnb1ZwrSw+Vef86pctBRGqCMBlj6Zqv0yNid8jrvubNVTC4TxHFlxh5zw+eBQZ2T5DcAVwmBW0jT6JH3tcEEqRV20LCLPuw7xAV5V3SfAgmYQ/6EGZXc5SfNd3UG3eIx6Wp4RUxgQg3GYEcZ/uaYkn4=;25:rGhbE5Nuyqx8D1KYus7WHmgquhOPkEPgf1GpG5iKYuzILkU9L0iXolF4GNTxI5cwknaaekMJx89Tng09IF14A8VHbGWYxMHwqZqISLRUWQliQRK7tJxM1+Q8/L/9qvA3z3biSVqttuvSV7e0NwWbcbKk+y55aRrfys5/llgDezDC6Js6kL+D6bkr4t+cCoi7r0VkcUEqEAzpINde5duKyIyM0ZUUG41GA/sjrccvHVCZu5NVX8mCD+VIbQZOdz5RrxCm+J8m9EN1iVrEl/qJ1x34C6EHeFg5DcuKYFAZ1/AH8q2Pbtkbjr1uYDyNJLpZGsmLFC/Bv9mpZ5Ka3QxZlw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:30j6rt2gbLViJAk5fW9TfB2+stTn1eHG29NPjjri8O+iUtMSwtmL1jhnqGZskYhm5zfZfzuZnsGI5l5arXyR36uglxP6TcpECz+kb32jZ2WFKNGwYKTxRi5giqi8+nUNDyPmNrsh28FkxO/gZTXaXjuosTCIvaB/kAaM4ffj+Ke8V8b5qcgjP3SenE5PWoo6mu+gWN0HNmUY0Db0vSsBtZWpSgq0famHp3ltU+k5fFw=;20:47jT2SBO2RufMAOcXmcMfVvpf3wBNiNvZrGjEU+eumhh7qWULkuVBwjD1urtvM+CiG0Yy2+VvucoPkASGJMWVnTBh4+rTy3cGbKm7E+2Rf33ePoYiPWkIBp6BWok+LlBsLamv4uURB8GizFuvSJ4CDFfGllBPGwE2MjUXLCilCGethfFKdawNLvuwQsSjE9PQNNxrjj9nnfY9id9BovAqEyvkNqJSfG29DBciuLDvqmn+ArizPEFTBN7pE2Sx/4hBd2jcU1gK4n3VZy8qgiTpslPbsp1SjQlvr27stsgJM9ctSjDCQZ21uHsOOf9AaUI1hdoi1W1yTI1ju3IA4Qx8pXAF76M0/j72YiaP7yhxZkc/aMAaNdMvg+CobgMpRL+uGEmH7xSy+Wyd2t7LomE4RykoQZINQ8JzRYfo0jCYv7m/CNKYa1bKxxpckyuxLKq7+o3c2+qtee3MhBQ8bMklqPV2nkeQeAukk2RrtWqlmcjzNzLQqYJmyZTdbC/zNp9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB444942CF1052D0F4BD8FFEC5C62F0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:X0xAfEG2owrqNK7sxbH/IyrCKi24GO22TD+aJRgXO+0p72pphQO2WrIpqO8EZQ4LRt/y1Qvye2VYDr2x3yJJPlvELtct6jV7bIePKokq05U6a2GVIlDslMICn1I1Xuu/u3EJKk/YY1YtUMkM8R2WO76jS/LlWxZ3Xh1EdpkVe8qhsFjuLNAWEaXU63iWg94327tRrN9crVd4cNavFtrdBi2GecgbUHZGlW7PtbuxSEG7AfHsvapCu4k9FEm7UfBCav7/4Z9pq30xkAOWCRDSWhz30ZAmXZ39L7AHXo900S3VAVvHeIfTqiVLZJlEsB5j
X-Forefront-PRVS: 0749DC2CE6
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NDQ5OzIzOmhURTRTWHlQSUJLdGxKa3UwTXI5Qkh2ZzIw?=
 =?utf-8?B?WkNlZlVxZTBDZXR2b0oyU3pKT3ZmT1NEcEk1YUl0VktxVjJZTnZLSU1zdEU2?=
 =?utf-8?B?ZG5xVHZpaEtjRWtVVnMzeXRkajZXN2c2Mmx0L25CQk1WdnZ1eDc3Y1I2R0FQ?=
 =?utf-8?B?YlZGc1hWZ3ltME5IcnkxaTJXUWpzMC8vVlFoR0lPamtJb3NCRmx4Tit3amZx?=
 =?utf-8?B?c3ZSMTBXSE5wcHJYa3JtYVJyOWtmYVdDMHZMYm9HWlpTQUxoc3BsM29HNkdl?=
 =?utf-8?B?cmtqY1NPY0Vuci9TMnJlQXBmSmJxdXlUbzVsUktQcXYvekc4M2tjaW83c2ZK?=
 =?utf-8?B?TUYxMFU4RlBKcS9ITUM0VWdiUlY1eS9ndzZ1dHg2M2RUcU8vbkxhTzhQMTZr?=
 =?utf-8?B?Ri9xS21ENWFiQnRTdFdkYnNXVVcvYVlKTTQ0NHYrbnZNOFZtRlFaRzg1dS9Y?=
 =?utf-8?B?QWFyMnFzWmRVbWRMZGRCZURPSmJDWXhxazREekp6VW5STW9XMmJVSDlwcHBN?=
 =?utf-8?B?ZncrZ08vM3ZXK1lWUWFWT0E5aVR1ajIvald5QkhJL2Y5VGdUNy8xbkVaQ3hE?=
 =?utf-8?B?WXVlTzZoelllZzlLK2FsdE5tQXJaWmk2eklBU2d2RCtKVVFKVDM0WXlZZ2cw?=
 =?utf-8?B?RHU4Q0lyY2NIRGNuN3V0WmRLcWRFU0kzcGp1d2RqRTQrbjlvRFh0THBLVEVE?=
 =?utf-8?B?QkxyYlFrM3RCekxIQ2xRUjZZMHRXV09nZmJub2VvekUwSWlBTmphWGVoNzRE?=
 =?utf-8?B?U25iUjNDMkxjM2l4QVhDUVEwVzFWWEpLRzR3RE8vZTc5bnVWeWxrN3Y0blNa?=
 =?utf-8?B?SEZrOG04OHA4STBrSWNwYzRFb1RkYVVwN3Jwc1VyeG5tQmZvT1ZRV21ZSTJS?=
 =?utf-8?B?Z1h2bktLL0VyYXhpdmU1OFlJZUdBclErMGEzNnpkU1VBYldGSmo2MmpqVVRz?=
 =?utf-8?B?dDB6cXU2TnZUc2JtbldnRHpINDY3TzNQRjFKalAyS1k3a0IyQ2ZnNjJTVVBa?=
 =?utf-8?B?aGJQZ3RIV3lnV2dkTmNCTWw1eXU4eW1tNjN2MXlkNGJqT3Bvc25wbkdTckp4?=
 =?utf-8?B?b2hWVFlQdlRyOGdVak1MZUNnNUd3MTgvNnovZjQ2YnIrczJzczFwVE5QRXA1?=
 =?utf-8?B?eStCY2R3R1hBaWE4TnlYT29TbUU0eVU5bUJZQU1IQWF3VGNxUFBqT0lHTTlT?=
 =?utf-8?B?dk0xR0xvNTdYdkV0YlB4YXZ3ZEMveStMNVFwWStmempBZkFzTlg3M0xPWE1Q?=
 =?utf-8?B?b2NnVm5WbkZ6azFnVVVIZVlwS2MreFQrbmdlUXB2dmgyQnI5VDVQQUsvWU9Y?=
 =?utf-8?B?UFpzMGs0YVlRRVBSdnVZTjA2OTE0b0JKMFRRcno3MStZQTNjTytGamZ3WVRv?=
 =?utf-8?B?ZlVWRStPL1dwZzkvMTJnOFhoNzhWc205aWtSV0NlMUxKQ3UwZERMOWZ4VTZU?=
 =?utf-8?B?ZDc1NU5Kbm5aOUpCY0ZqZzNzRDVMZjN5MTNrUGoyNVlEb1kwbkMvTlpWZmVK?=
 =?utf-8?B?Z2xOWG1lZzB6UGcwTzRyOW1uc0IrbnVrWStyZDhsTlltTjMwc2RVdXlJQzlx?=
 =?utf-8?B?eHptQXNIRXZjQ1JJQ2d2b2tYdFRDZkVyaTZmU0JYYm9rVzYveGdLSTJCT0c1?=
 =?utf-8?B?VUtmc0JZUE0wTjdsbzg0bTdUdFI5Um94WmZ0ODRnczV5WlpYUjVjM2I2d0tQ?=
 =?utf-8?B?UmowVmxTbkJteWZFeTJFYkEzZWlJalo5WmthTm5hSjg5K2t5TDcvdzVzTFNS?=
 =?utf-8?B?bk8wblZ5UzU5QWE4Tkd6TDBrck1nd0Zxd2JUVUhjV2k1U1BidmlmdVFReERL?=
 =?utf-8?B?MTI1WGtVY3RpNm1Bb0R2eC9iZzZqZFdSWUxVZEhwZUhnQWZqeGhZMlRkaW4x?=
 =?utf-8?B?eFFSdnhXeHdWYWJ0a1BHZUxhVWhNcFhuWEc5KzBJRHdlNHdML2ZrQ1Rjc0xQ?=
 =?utf-8?B?bWVWY1ZMTkJ0L0x1c3lsblVmcHpLU3YxaTNBbzlDcTdIaWVqR2dPUWZuYmlD?=
 =?utf-8?B?Y2V0YkgxTDc5U0tjaHhBZ1R4eC85TDNKYmVndz09?=
X-Microsoft-Antispam-Message-Info: sZDFHS5VUZEZqEBG+9SBqTw5YT7Gei7Fu11vTuD3/ht6ucJiP6XUA4dsy5ADazh/v3S7skfKxsL5vdknfPVzoNystjkZ2DXmMvAcO9yy1oW8t6SrK9JZ09VR5iYSDAQFaeoy9NC+4Bu9L4SiwqTQIhY9xuzvlalE/JfXqXwUWeL/Ta+jA0ss70DVX0twBayaBnc8dDja9vMhRtTXF5JgjxGaY9aXNI+tZT1QugCYlFl1t4ouFWjOYh4lxBagZLG54OdJF/iVew/t6HsJmDLr5JNiNZAgQTXKLyC179KXbu9GWVuEvKD88Cdt2rh151kES86oGSxIrN7sui/8imGtPsnuloGIUeGM7YFMKZIGP+M=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:UBhDLtRgmJWsoGgA3qOLy3GIMQOkYy/JlsQ8ifbBWAbTqBAzByuPVdQXL/CQ/ypr40glLAGiwJor3x916NTU0zYQKgiRcipQt5xmM0gYGmdqAiIdqGWF0wgdBD/EUI2jWdD8xjokJ76dom8Ehl7aNyTVv/rpXElhM2da1BqrCGBLBvGDjsBRIpwg01RRmaFSBpC1SU1x7FBVdRrgXNaOSqRqVJuj/J3OkIhs3w7nJH4Izc5cyUmlKfYU5Rc0S5pFoeWrcBrnP4X3sAnG9EeCYoKuWVBMjl+NZGXH5nOpJxN+aMnOLFOl4NZVpLybmGclW8TblahBPz4gFRVjbHG0BvNzWFdOMVw/XW+HQMIm9vlWkXksJY7d8OW5VNBIFOuOqVRV/46Y9MrXZ1DsGQU44DWqE1slC84oooMpy5ZyuMp1wWhHCC+asyvXhS3n2UH5sDAxcm5gKekcCoUzUE7s9Q==;5:Ai3Kjo2vjOzsZSNl5jRcqTqnT8LAcd5c2hT41QuwKLgVryvrtxhp0eAaLzHRZJZPIzKjUDSxURG3c++fSZwIh7bqXGn28C7UU+bC3E7bgqbgbv1FNytYi/IsYFr6j81DiPDq5C8vxwwoux7bA8jzbcCC8pQfc/ZZ1d4ICS65wcI=;7:lS+AjVrwTTs8zbZk1Z93DpPrbXGwSAXFGgPxoZcuE5zu9DfGKlNhb5uahxEZyeHX99X6AIU9rwnYyLJC3dRv25jxppI6qFr0PyDLT3qYbMFjavtg2B9PbtajW6q9x3iLeWv93kyPjWZkbr6kuoA17x+DY7Tl/u8J7K5KNRzR1CClfrcOTV7nNY28RSpx+vN1MQPJ8HEuzzgp5ECfCadewuEHJp7DRfd9eHCg906aFxc+bShGKsY9YcUifoVrDAsb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 12:50:58.3225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef1b749-39ba-49f0-c8e0-08d5f61b1c7e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.7.2018 18:36, Stephen Boyd wrote:
> Quoting Michal Simek (2018-07-25 02:51:14)
>> On 24.7.2018 20:14, Jolly Shah wrote:
>>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
>>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode
>>>>> 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
>>>>>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
>>>>>
>>>>
>>>> It looks pretty calm over the last several series that's why when I get an answer
>>>> from Stephen or Mike I will take this series via my tree and arm-soc tree.
>>>>
>>>> I have applied 01-08 here
>>>>  https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
>>>>
>>>> Thanks,
>>>> Michal
>>>
>>>
>>> Thanks for merging the patches. 
>>> By mistake I added “Reviewed-by: Stephen Boyd sboyd@kernel.org” for firmware bindings (Patch01).  Stephen had reviewed clock bindings only.  Please suggest if I should send a new version with that fix.
>>
>> I have fixed that in my branch and I have asked Shephen to look at clk
>> over chat.
>>
> 
> I have some unresolved review comments on v9. I'll give reviewed-by when
> that discussion is resolved.

ok. Do you want to take them via clk tree or via arm-soc tree?

Thanks,
Michal


