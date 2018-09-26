Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E55C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3574320657
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="D19jEyZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3574320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeIZRNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:13:42 -0400
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:23313
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeIZRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vAbqus/1uXZvOCD5jck2MieUAwvn29St7cmiCepuh0=;
 b=D19jEyZtW6l957TOfDphJrPFVGH8GAJSITIGnnmnqG1BGl6Qdbt0622bxOQYOPmj1TbBvXvwZ6DECSIEIKoDB3K68i4LxyDLn8hc2tkbVHPUPY9WLk5mHKUbDbmAXeLsbxgGs0FRfJwyY080B4gua2h8/GKMVreQOhP6MA2KgCI=
Received: from BN7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:20::26)
 by DM6PR02MB5114.namprd02.prod.outlook.com (2603:10b6:5:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Wed, 26 Sep
 2018 11:01:13 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BN7PR02CA0013.outlook.office365.com
 (2603:10b6:408:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Wed, 26 Sep 2018 11:01:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 26 Sep 2018 11:01:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g57ZA-0000T8-C9; Wed, 26 Sep 2018 04:01:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g57Z5-0005pZ-6b; Wed, 26 Sep 2018 04:01:07 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8QB15AO014912;
        Wed, 26 Sep 2018 04:01:05 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g57Z2-0005kC-Ue; Wed, 26 Sep 2018 04:01:05 -0700
Subject: Re: [RESEND PATCH v3 1/2] of: base: Introduce
 of_alias_get_alias_list() to check alias IDs
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
 <CAMuHMdW5zze-KJhK=diR-WKbhO_vsMV2b7WuLHmcT2FtRD4J7Q@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d27b381e-f091-91dc-cffe-27789583f949@xilinx.com>
Date:   Wed, 26 Sep 2018 13:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW5zze-KJhK=diR-WKbhO_vsMV2b7WuLHmcT2FtRD4J7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(8676002)(305945005)(186003)(81166006)(486006)(81156014)(5660300001)(446003)(336012)(36756003)(356003)(11346002)(53546011)(50466002)(36386004)(65826007)(478600001)(426003)(77096007)(34290500001)(31696002)(9786002)(229853002)(126002)(2616005)(44832011)(476003)(26005)(8936002)(2486003)(76176011)(58126008)(54906003)(316002)(110136005)(230700001)(217873002)(106002)(23676004)(106466001)(14444005)(64126003)(6666003)(65806001)(65956001)(39060400002)(4326008)(63266004)(6246003)(47776003)(31686004)(2906002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5114;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT011;1:EQL7Fjl9Ay8EdJSryzSUFjFJWU6d69j4YcW/8co6ipEClSeUB2pBnHGOzhan3UA1HH82KgeZDr5hogcP/gbGvTVKAs2UP0CJ9vfepMeklWnCAaqpmo4nKfGCX+aGdOY2
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 083bc933-ab8d-4d59-82be-08d6239f5fbd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5114;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5114;3:fvngZJW7R/Xh1dHVSh1QITL15xdPt2rilXgH/3QDfFACPjmSB/K9i1LDMVka+JETFj+I7ZqRO6jwCaRPUX7gfRRaFz2OmgCbN/a0B+z7V7zjUPe7Gosyp84In6sdKXoJIuB0HcLA2bvoWQ/jGlLyU7ITIRLp6Z7biX0w/dPf4rzaWQFIacXd1Ao+yx+qbbajN/ZqZIOFCS0IxjXu7cu0iIsjjSqMjfa7Van5eAAGMKm5UKTGNQ7aaQPNIEMw+XAgdcZe8q+5B3cI7s2IqsoN1HOfVbIZsF7fBJBD+BnK1JqZM83oy6LseeoLGd4XB2qnl+/LzWzNaoKyAUAn9yXeL8X1NiWIpZRw5xksQ14ztes=;25:swhLRmRDbJv/s8cEJ7IGsOAVfMFIF+coz7WGumidwmlJn5FijeG2L9CNirgNPsvWSY4deaSOwPeyYUecdckzssIYRNXh7i1lXO4h8b4mbnvkbgry8f4XplAAvAHHNVuLK54VvS988n277TreQHfZ/8kj2AgM0C46gwEmxG6ONqNgUslom7ju/3yx63rhZSo/JXcHnxWWQWXg1RdFEULwaN6UKAZ1WPrKuatG31aLUMxZC3790NtA+/ZowtzMhiti8Z3KUI4qLwPbMGYW2N6us31CfCH+UKifem6CBLoZwP+p3pKxDczbtz0aBk8MotA9zXyN3dpMnIa5iib/wsaBFQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5114:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5114;31:EVFrPqkzONZ5l0oqkCArcPbi9B92ldFvlMMA9F9UNUlfyOyrLgnlbALyOYEtSqEf8PhcYzh2AMrzyHWMeOyPFkRXH9WdLY1fTAwaatNsAXJcTe112G8M/LaJlVCajalqqep/CgU8zQ9WNH+nYVA0OHDxDuIrey69IwJVNM6A8fth+ulsuCsNtCUL4WmLEczpHETyjgrnL9lqB5aLgnU33EL5XjRq03R8xDdKzKbG+i0=;20:UvKVCff2edBAcgWOBuKhgU7IBrFslgeVrJAbKvsPFRcnWbFJZxoYbFa6w0Sjo6XXYRS5wGHni/C3ogeb0ijJJfNUW/jVNSwLIkfchAitklYHvbPQWAp7w9+V6uK225eQ4CDwsJ1Vh3j2v2Lzsujo6/sBEEZqWpY9Fpe7lmX+uSUXTp3/IsZXo5z+ZyBnszo5UKZ0goHam/ZijZU+kjDAwBvPLTsIVyoXRqyhaABOl/Gi12uEIm4Y188Y4JVSuahYcLX/7vkFF0tdgAijeQrbUQ1zl+z+RtQ6zTbNC77kK2pN+Nsr8QU/rZSQdRrpZK4ivE5KBiVDEkrr5D/EDrQAO+8uTRUnVh1NGN07Io0onmJpmljMwvr/PnZR7TiOBHjguUdCHv5qtX/TeE4kHY+UBlCg0CAqRreBnBd/T3Yd+XhVAYxavRVMeH+6KfrG06GBRDYGeB4KTxOw8Ram6a34zhToaN9Q5qGJgdwx/lmgEedQkXPFPgj6mjKOdPTUqq/R
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5114568B1B25F1BC587587CDC6150@DM6PR02MB5114.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DM6PR02MB5114;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5114;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5114;4:y1ih00aSHVGZCCyHb1Z0udjNm8xpo2egl+WTujY3hTe/q/dnpy2RL6TLH67VyPjkPk07m41cmEtuGkEAno7+FPOmisa+YRnOE+z6IGABA/f/9p++KlF3zBHaNDVBFmEbIhmYNAY2p2PBu19B9ibZrQ6g72f+43zPUuGVUmIiiDXknwhW90SPDyLs8qX39fTRmW4k3ygHqhVl/agXq3G7PLsyzbpaRN+2qn9jcFlh3pxoP/yRFE4MaluRIovsh/YnwnUbO96O+oHPDM2LkM6s8R8Pb1vEZdpIk+0dq3fJCW3cuDlG7Y2bqy7mm7KOhlDQ
X-Forefront-PRVS: 08076ABC99
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MTE0OzIzOkdwOW9WaldUOWZla1pHQ0VQOG5oNm95R2No?=
 =?utf-8?B?TzNtejZQZFhyaVVvRU5ETVJiSmJCS0pST1ZBVUJyQUxobUdZcU1CdTlrUzQ4?=
 =?utf-8?B?TUR1aE5RYklIZFZ0TlhnRjVWM2Y4cHhSaStucGdYcytLTTRNeXlXaW1wWVFO?=
 =?utf-8?B?T2hkOUpSVkc4bEc5b2lOSjZ2b0RGU0xmdFpkUlNCdDIwWDRkeVpRb2ZzUWcw?=
 =?utf-8?B?M1lNNHYvWHozaVpJaTNPUG1BczVsRE1LQkIyNUJLOXRxL2pUWlhVYlBHeXNE?=
 =?utf-8?B?RG15NjJ3QjVrRjl6Nm1MSlFTdWMyanlpL0xaUUU1VnVCOWxYanVMa1VCMTlk?=
 =?utf-8?B?MDJQK3pBd3RHS3ozL2F2dkM4VFo3RFJpT1dWQzNncWFoM1BJWWRUenczZjJh?=
 =?utf-8?B?azdOVk5hUW9RbnRoUG9rTnZ2ZjA4SjgxRjdWcHpHRXFxUFZVQ1FUMWk1TnBH?=
 =?utf-8?B?bHVlaGUzZUU3V0ZySXg3WDhtSWdBb2xGbHFKN1U2L1BEN2NOQU4xRFp1NHAr?=
 =?utf-8?B?MG5wS1BpT1krV3JqTTR0UzZoSzNFck1tcXRGRGo0ZTBLcm82dDNMVTFFZllV?=
 =?utf-8?B?MjlVaVJEOVRHb0JrWER4UHhiSnhlYk15a3NkSzZySTBlTmtnQjRsSVowVVc0?=
 =?utf-8?B?U2xSejdCTUpsNEwrQ2RNVEQzZ3lvZDM4SUNHU00zTWErU0xVd09FQmluTHpT?=
 =?utf-8?B?Z1k0dUtSTm1PekV5NnFYZG9WeVpqTERzUkFxTTA1QzYyL2xQRlNXaDNYYmZY?=
 =?utf-8?B?bE01QUpvUkdxNE1PWThKMFB6Z0UrZ3lYZmRhMEJCc3ZNTmtiNWRnOTBPZlJS?=
 =?utf-8?B?blZrZmNsNHZHMC9tSytMRmFMM1NXWU1IdnFFUnh6VUJaYmtPMTFVR1pqZmNV?=
 =?utf-8?B?VXYyc1QxYzFVcm4zWWE1SDhNdXZpSUZTZ3QvTmpEY2RUUS9UOUgyb0ZpY2tT?=
 =?utf-8?B?WnZXV0xOV2xCYitWZllVbEpDNzFOQWtjRzdZeVdqS0g3TEVIcUdJSUs4WWp2?=
 =?utf-8?B?VzJBemFRTEtZN3NlTzRzSFFPSU4ySjBHMmpIcFVwYzFhdW1SazJLRVE0NFRs?=
 =?utf-8?B?RVJ1Ly9reTg5blh1bkxLMlp2UmlZcmZ2Uk8rZUprd28zT0RPQXZKaDUvdGtF?=
 =?utf-8?B?NzB6UWNxMmk4bzl2dEZqajMzQ0k0eFRCWkZUQktnSzQrSERIZXZiTkk4dUN1?=
 =?utf-8?B?RFRBbk10dEVjY0Jqbi9aUm04amhPZEJDUzdxcktGSGVOUVFVdUVOTDE2TzN2?=
 =?utf-8?B?bTgxWGRIU1YxMEE3SmhKc3hLcmlWbUdWWm4yMC85ZHVUcERrN3h0SkxPOC95?=
 =?utf-8?B?cDZDTUxiOHNJdlNEdGFjTHFTWEQ2eVhKV3N4RFIvYXFqR3RQOXJYOFpKOC9p?=
 =?utf-8?B?K094SHJvd3dxU28zc3o1M3hYMnFGZ3pTUDBoNWZQdHJTc2N3UGE4UUVxMlM1?=
 =?utf-8?B?NVVST2J3VCtNMGZFVUt0Q2wxdW5BN3BhbWx3N1ViTmEwWjRHdHQyNElvVUt2?=
 =?utf-8?B?ZXNLWWk1aCtDa3FIY3QrVUhveG5rUExBcTFEZ3Q4L2lYZWtkU2ZrUk1JVG0r?=
 =?utf-8?B?RVVMNFhUR2lpNmhvYUVpMnZOdkUxZzBSOU4vVEZGL1E0M2ZBVmFTd3pQd1pT?=
 =?utf-8?B?a0RFVWc0S0UrVGNZN1R3eTFHN2NtTFpVRjRFVFRiY0RNRklvSXVMUVdtUXNu?=
 =?utf-8?B?dGYwbGZjZ29sZHE0S3NaL0tvK25EQnlob21ZSnNwTTRoUXRQVTIwU0lMMkt1?=
 =?utf-8?B?bEtPa2s5SDczVGZITTdrZFVsZHBFSlR2RExYZENlbWFBWHdoZlA2VXJYT0M0?=
 =?utf-8?B?WDV2S3g0ZFBPYVQ2WDZ4ZW05Vk9NTHZreEUzdnRERDE2YWNMYzhwWGYycWpQ?=
 =?utf-8?Q?UjtVB8FFrus=3D?=
X-Microsoft-Antispam-Message-Info: 23S/elJ9fBECoIXWAQdn2HTpp6PkCt0shiVeePhdRW0bkQNKrCr05mQ8tNzxgI8se6motCW5keX4d1wX3u/mttEu6S0rogPmpz/78UulFT2fz70U2xAae1h3B/pvWsniZTops6qqCVDQr0zEj3K6ZKtecAcoH+HkD5zgiaUdw4P3tZ5kUSW0sgJ37bjj2KNNfAGF6Zv3uqCHo5uDV45pLj+RMKx8p+CzrhAkabqS2USMW3RplfigMYXVb0Qt0u6AZO4ZSlni8oA0KKFtIfk1+Mr1MA9+QRvAZt+Ye5UNIcnZwP5Hp9QhYXZVwrx3JyscajM5USF4YD+AXYGku8vcSerghTsnULWxr+l/+xTyBB8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5114;6:iGHjexd3eRuvp3a9ne7I7zMx2BINZ+f5yrj1YaZYPxw6zNX3TebK7075DfPj/tWq7OQ5GUQSitXSaqcOdgDak7LZT9S0W0gh8qUJ/rNOxPHehmCiWUXY+8gKQtja2G2/jj+AKqlvQT8hdN/XDY2jLfkGUmLnbEfgNaS/C/2GR5uIWMcvO7lGQsLR+RhYFTQLN3fAjRth2OdlPYidzv2hE3om7ZG0jsE7hw+a10R0WysgFr91hSoIDL7S326KNMJGgyPPw8fvlqsrNSVVfYLGErKGK6LAd4ngWvuky0Bp84ZEyxoj8tP7g6zxuPvIVFhOlBFnFrA6JM61BkNqVGqT0PU76JNEKLdC1tw8TMqqCL/1zDUzLMCb6fhByBGQXPkJQs16O3ywghIlL9ChkAP7RJVUL8U7c1odmoBccqzCfW7lKE9M0vk8MZ8hJ41gzWjgFGYExGUHXQq/ILXS9KLEyA==;5:99CNt+wbYfekOXjPoBcY/qQBdVD7EN72J15cTFz4q0waFmjqPo/Wt1k4BhvM47YzVyceEN/U8nqlD95bShkDh9zbAePJ1UQwt9U7hTWZhmzc6DfWOljCB4qXK51UyxKnwUT6EWUYdMoa9Osc+ioLlgBzfEwztEpqLgkrhHVQ8N4=;7:9nGq0/FnSjvsheJN11ORGcG+E9ZCEUh8cMJ0TtJACql9uhl09GfYN8UgRuuPGJzHJkPkYb5i6pku7YqRGM2l1e9/WdDorfB1dydfsap0szQPqhZrLXHJNRckpU9A/xyiw+ojEFhtrCok2i+Mvt1pHGUxjfvKeP6eclpVnf/eTmv2coyKNENq6Zo70kQg7Sk2ZE+vy6S6NBlJUCi1QxSfHWGpM5uB1ha5PygeYSybN3AStiRnc4m3BkCEESu/HpVK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:01:12.9875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 083bc933-ab8d-4d59-82be-08d6239f5fbd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.9.2018 09:41, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
>> The function travels the lookup table to record alias ids for the given
>> device match structures and alias stem.
>> This function will be used by serial drivers to check if requested alias
>> is allocated or free to use.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I know this has already been applied, it just drew my attention.
> 
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -16,6 +16,7 @@
>>
>>  #define pr_fmt(fmt)    "OF: " fmt
>>
>> +#include <linux/bitmap.h>
>>  #include <linux/console.h>
>>  #include <linux/ctype.h>
>>  #include <linux/cpu.h>
>> @@ -1943,6 +1944,57 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>
>>  /**
>> + * of_alias_get_alias_list - Get alias list for the given device driver
>> + * @matches:   Array of OF device match structures to search in
>> + * @stem:      Alias stem of the given device_node
>> + * @bitmap:    Bitmap field pointer
>> + * @nbits:     Maximum number of alias ID which can be recorded it bitmap
> 
> IDs
> 
>> + *
>> + * The function travels the lookup table to record alias ids for the given
>> + * device match structures and alias stem.
>> + *
>> + * Return:     0 or -ENOSYS when !CONFIG_OF
>> + */
>> +int of_alias_get_alias_list(const struct of_device_id *matches,
>> +                            const char *stem, unsigned long *bitmap,
>> +                            unsigned int nbits)
>> +{
>> +       struct alias_prop *app;
>> +
>> +       /* Zero bitmap field to make sure that all the time it is clean */
>> +       bitmap_zero(bitmap, nbits);
>> +
>> +       mutex_lock(&of_mutex);
>> +       pr_debug("%s: Looking for stem: %s\n", __func__, stem);
>> +       list_for_each_entry(app, &aliases_lookup, link) {
>> +               pr_debug("%s: stem: %s, id: %d\n",
>> +                        __func__, app->stem, app->id);
>> +
>> +               if (strcmp(app->stem, stem) != 0) {
>> +                       pr_debug("%s: stem comparison doesn't passed %s\n",
> 
> didn't pass?
> 
>> +                                __func__, app->stem);
>> +                       continue;
>> +               }
>> +
>> +               if (app->id >= nbits) {
>> +                       pr_debug("%s: ID %d greater then bitmap field %d\n",
> 
> than
> %u for unsigned int

I won't fix this now because this can be done together with one change
described below.

> 
>> +                               __func__, app->id, nbits);
>> +                       continue;
> 
> Shouldn't this return an error, if of_match_node() below would have matched?

IIRC Above check is for "serial" name.
This one is for getting XX number from alias "serialXX".
And below is checking compatible string.

You are calling this function from uartps with 32 lines limit and there
is serial33 alias poiting to uartlite (for example) then you don't want
to break this call for that.

What can be done is that compatible string is checked first and if this
passed then ids are check and error can be returned or bit sets.

Thanks,
Michal
