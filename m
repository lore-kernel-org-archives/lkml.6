Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71809ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF002146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EQtfgD6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF002146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbeITMGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:06:02 -0400
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:51648
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731675AbeITMGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY5H8UppML1+jRvTEu7tzsfr5QvxP4x1uhKe1ZWY0Q4=;
 b=EQtfgD6vG4TKkXQ/ZlSQPuwVJ6J5vRFmrjW56aDn5L1P1LCDZwfKpaa/zD1E/vyAcyQWhs0xZ3o/IbUNgdDPPyTbFWdPTEruBwm/AMq6wStBCORfLP+14bhkiYRMWRtMyNJRWzPlXUBOPOyeRjFFTaMG3bw45RN53WYDV4pxGCk=
Received: from SN4PR0201CA0063.namprd02.prod.outlook.com
 (2603:10b6:803:20::25) by BL0PR02MB4755.namprd02.prod.outlook.com
 (2603:10b6:208:5d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Thu, 20 Sep
 2018 06:24:09 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0063.outlook.office365.com
 (2603:10b6:803:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 06:24:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Thu, 20 Sep 2018 06:24:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2sNj-00088j-Rg; Wed, 19 Sep 2018 23:24:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2sNe-0001sp-NW; Wed, 19 Sep 2018 23:24:02 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g2sNc-0001qe-RA; Wed, 19 Sep 2018 23:24:01 -0700
Subject: Re: [PATCH] net: macb: Clean 64b dma addresses if they are not
 detected
To:     "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgari@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
References: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
 <20180919180806.3tps6yukhm3ry43i@toto>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7e641346-dd4c-4e2a-637f-1b666f13485c@xilinx.com>
Date:   Thu, 20 Sep 2018 08:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919180806.3tps6yukhm3ry43i@toto>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(64126003)(63266004)(26005)(85306007)(6246003)(230700001)(6666003)(2906002)(106466001)(53546011)(186003)(8676002)(478600001)(77096007)(36386004)(65956001)(110136005)(31686004)(11346002)(305945005)(54906003)(426003)(106002)(65826007)(58126008)(81166006)(23676004)(316002)(476003)(44832011)(5660300001)(2486003)(2616005)(486006)(356003)(126002)(76176011)(31696002)(4326008)(8936002)(9786002)(81156014)(65806001)(47776003)(229853002)(50466002)(36756003)(446003)(336012)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4755;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT018;1:H7RdSM/QhsIhuzqSYyQMOKhjfBPTBRAs6pZqQ1uHunGAmfcHHWy/Bgeo7aKbexgPujzA3nqeAdz9mnLnAJhT4yCGL46uriim5C3/9A7cZNXQClCDdREE0KPUXVYekciz
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cdea7bf-634b-496a-e847-08d61ec1ac41
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4755;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;3:qKj6WJlBmCQHkx6fXOGD8RdGDMzp5GfQm3/1U5sReGVr1vhY8GbfCOh3WWbrrCeFcsFBdQQVG32SgRWZ8ibI39mDdItZy3njN5PRW5mXuiVSVNrYcQN4BaaoKAhDqbBsF5n2K2YRDEV2IYbNQRafyz54APVWVhsS0kIAflJCe04kAX8qrna96mZsW6nPtk83JEQSE4X/tjFKhk1uCPYjJDUNDG8w1E05x8ySfROOizQCxGwpYIX7Cyi9w8QN3QlqIZN3ZDlipmIGUfyfh9ar6m04BRaKsjj4JcSsq4vVUGpAMBDQRWcf+IMAfssy28UkCwRocH0AjqzgyyamoBEF29PkhewSFDkAP09HW2vSlCY=;25:4B7J5c0Sr0gRpXEncIah2qdyu+wk0BXd8PFPjdGkv03UjWIrDPp58PYw46A/heaFQClB1gLHlYhtgB9PBsUdf7+GqIMtmOmSQRylZafveWycFmXwQdMErVc09kDfNFP2exb3ld6Dh1o+Azd++V7mcL1idSI5fzKtCqTi6DBu7hkAbdC9SOQ1RJynr45meBh2U4CGX25Q/IER5xX+4Lrxm6KBhWgILZS+ErOqE4Exz6aopghsvf+bEKT1r+MjaPzk6pBqtudekj0XLHEV6H489lOM1EK1LKJeHbo+naCfw8FTA00V6zUwFkxFbmNkeBKVgjPjT9fCf+YqzpUOCkyygw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4755:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;31:THUtwgWOhSUQdQvvul1De71Kxbv+sylOJNi5VX1gLkYj1sSS698bKHuE5GdlWWWjkfQbpFNwf+bc5Awe8CscuImYigrffd6iNfA4i3AiL8Gz+eyCBbPD8M+z+f9zqz/7fbu5ImyXKOtS64Ax2PTyUBeDyauQoNeH7t68BOqcdr2OCRhtEgtI8mvXgSt4RmbsqXY18lTRP01mIuTqj7foKDLUM60IpYmc7cmZ3N0sLPg=;20:hvMkH0rG/tx8znrJH6TputWIzFW4TLPHUKczC5VgDMFcv9Xn0ZJZvJZzn0SFP9eZEOcJkslQCK3KA9CiWUNef8LNU4X9brtoLbit+/Krq5J0q8QWFvDP+9uC87BZPo6+i4tvBKzEcWehySNcCJl+EUHyZVylMjJkSNGqECvoVZruERl6vCfDmsiyghwcgb1NALfBXy5MUnv7i6SitiMHRFFQ5SmotstV7RSnQCBl/Qe/QoGZyHSFBKUPf2Pbkf12xvjvitwVWazZTp/IxHgLpOfcz6t1QTQMNL79LaGVXUIEES7nD9Obm4JHG24hCNREerhr5cBfjLpElSwFcAXYlCkZ6ZSPvly2hVPdd5dXDsSYKPCmnn5WW0FN+HqoFsWt23TWg2mRY/sUTh5T0tiZlK41AkYybxlo29Swxd1dxIT33tdzRfpjyAJ7/d2wET9lSa97nDssZP+rBAQW6h/XI0ow+3psuyQXD3B90Wl9oqYr1G2E0g7WOZCOqabgGisD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB47557778F82992FADF314814C6130@BL0PR02MB4755.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BL0PR02MB4755;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4755;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;4:ij63ij8n5QrVXNW9CCDIti03mV31O4ySJBvvOHt+8I6fA/gJOcueYKtCncCWf/iodpcMkhV2BgnF5PIJzgkmMcCOI6IMc3qXNrU8SmkxYAvMkpcEBocEU44iIH2JIX75zNJckjEcWgdTsdJB5WOFWVekEm2P1uqtsAV5k2fzUZJOzbXvHl2Jr77LnLFW2cMOWck2WZBt9yjYECzllZ8UmOwuKLVBarU1a4QNSK7iV2XwBKSOxII+ODV//d7BQkgKY9m6aOfO2r/lYLp6JdCI251ZDp13H9hZOyIH5bBTp27Pt/fMVD/cVoKnOPPR15sC
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NzU1OzIzOnVIWUFnOUI4dG5QSVMyODEweGJndXllSThx?=
 =?utf-8?B?K0NtWUY5M2R1MXF1TGZWb1d1RjJrM0UyUXpSbS9sWVVybStOdUtiWUo3Sy9x?=
 =?utf-8?B?aVZuT2xNUUVJdjJHOGpGaFY2WjE2QVc3bWZDcTJjMnJXUXhUU2ZvWXNYc3pU?=
 =?utf-8?B?eU9KODYyZ1MxS1NYMUdWNkM2L244ZzU3QUJuSXZJcVNWcW1KRncyejNTSlNw?=
 =?utf-8?B?ais3K2Zrb1EyMmplVXBBWStod21nZjVKRE9CVDVVZmZyZThaUm5zcThGZUxa?=
 =?utf-8?B?dlFSQlN4YVA5YlI0aGdjTTZMYVdhSmlPSnFxdUt0TmFCZ25Na2NWTmRLS3J2?=
 =?utf-8?B?MlRRV3NCZVBWbWNCUXZJOGtlNVVTZjJHck5aQW5SdlJmMVZjNWY4STY4VytQ?=
 =?utf-8?B?WHlsM1FCeWh3eG9CbDY1d25MQkpoYXZrZWpSTTdOaXo1K2dCQ2JITy82T25m?=
 =?utf-8?B?SnprY0pxTitYc0FOK1FIbDR0M3NsNE9JQXhrU2I3N1RRTHBoMENpZzVmVGFr?=
 =?utf-8?B?QllaQWxzS2svSXlQTDlKY3dBZXdRQS9zdmZXYmIrQ3Jrb0ZYbHQzZUkzQVBQ?=
 =?utf-8?B?bE9wUUI5bXdualJRd3NVR3VRNks1Q1B3eE9xUCt6cm52M0hqNjM2aWpjaTRN?=
 =?utf-8?B?Y1hVeVRTcmlQbEZVMW9PTmYrMlQxcWNSaW1vNFdMV1YvcVBtYnVPZkNNaHRt?=
 =?utf-8?B?M2ZDVXd5cHBtS2FBZGdOTDZsbE9JM1FETGFLeFVMQkdncGxEaDJpWDU4Qmpi?=
 =?utf-8?B?S28zajl5dWVXbDM5OFllMytFeFRwbGtCR2JMYkpqbnNmZDB6aUpUQkRwMHRi?=
 =?utf-8?B?b3d3OWJpQUFTdTk5aUVkNUdPN2xYakloSEpqOWE3ZFlVR2QzU2tTVnpyQU56?=
 =?utf-8?B?SVovU2E2OE01NVR6K2NJWENJQSswL3ViaGJOWHkyb0Facno4dVV3OVdHUDdt?=
 =?utf-8?B?c3RuV3Q5aGdaMWxvUEM1NFZDOXZRMmhqUmFubGFneW9SUGN5UkZ0RFFYbFQw?=
 =?utf-8?B?NytlSWUySDZXMGF3NVJ5dFZNSnVYSncyVXgrSStDYlBkZ2dycGpDR1hDZUFE?=
 =?utf-8?B?MTZTaWt1Y1o0aVpRNkpCUGQ0TGVFbk9YaDdRZCtoT3lNYWRTS3o0QXo5SVVH?=
 =?utf-8?B?bzlacTZXb0VlZWNRN2hQOEx4dFRocVp0a2Q5ZDhXMXBRbGJnWlo1N0lHS3VQ?=
 =?utf-8?B?Rk15cncvYXhWaTNpTzc4MU9MRDJoWjVESy9sUjFYN3JLRHVyMUZ2TWZDRjNS?=
 =?utf-8?B?dGtwTXJXQW9zeS85aG5hZm9DZ0xVc1EyZGZSZ05UVFFOcGdpaUJaM3pHdGFX?=
 =?utf-8?B?eDVCOWk3alY0VEpURUN6N25udmZ5RWwvKzZ6ZlcvVUdQYVk1cWdhR0RoYzhm?=
 =?utf-8?B?bWxHUVV1T3dTQzFVOGdSOFg1TXFrWVpxMjJOOUdFTEkxczNiTnhKQjhud1JN?=
 =?utf-8?B?Nm9CazB6aUdsZ2FYODlydEZPT3hCUnVhaFNWM0JsdnExTnkrMWxlZEpPeTR0?=
 =?utf-8?B?UkhUYVQya3FXRFMvaklnTlJjVi9LdEtVNnhwUUxmL1FFSnVaQkNyT2VHdVZX?=
 =?utf-8?B?aGJ3Z2kxZEVmTTBVWmdydWNZZFRjRTQ1ZllBMW5lSVhGaUZxbGpleld3bFVY?=
 =?utf-8?B?M1pjNGo0Vk44WEkxWlp0Z29SRWxBZEdFVUNBSkhQZ2VoaTc3N0tQWG9la0dt?=
 =?utf-8?B?a003QVdId3ZrQ3BIMFJzaG1zYWxVc2xGTHR6K2ZRaEJaRVJEN0RSb3FTem9G?=
 =?utf-8?B?NXJGUGYwazVJclBpYStidz09?=
X-Microsoft-Antispam-Message-Info: 9XD4HA9P40mYvN5zUpOux49NguQ8H+0cIVWBJUXwDLqD90DjqDJoG34rsT2UW/CdOCrpvo+1eDfwrKna9urLwqNtfpb9a6e8NagozPHRH3/abwIqN4RnxygdUogaZ+dssXLFOabMOnhgZRdIhe4JnjhDI/2p7RlEuccldkh0gy8HWEb48NIVCUFDfNk7w4LYtnuahT+e0GKo6TRg+hmYkk2gE+vNO9JpkpI0ALXH+hMzToXjI1i4y0a5Y0EFoVJ+YBDFVbr9+krdizdgi9YKgRDELkROFzfrgg00HVX9420CY0QfAfSkiUBRZTZDPZMBoyywA4iWHu8PO15j+cpB867gwuKrKg42vBmvkB8v7K4=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;6:bgRJ1SmQ1WNBt9Ulcfpm3mAL7XgYVTNzwa/rArgQ9Bc0AsDwnt2ccH3pxDrdCqlWswN3JhbxeYINm98Qxgu1NsgbOTC/VNiOmlb8cMuMOUICYJnLxdm7rp8/fcQHWqK9vHuE3QzS/V3oV+hcCOM0Tdn9Rw+yVCFc1Rwp0R3PHulue2LKT9Qsho9p4kNE96VCxWIuJT2yFJm7CmmKJG93RQsX2nxyhCoKpm94oSDpO8OUyQbGf5spagx9RLEsMEeI9XSnddNmQR3XOBQm1nbqtMATM5yovUJH1mdzkLHGxT5NyMscQR1ibeV2t3lWPm7KRk5Utkb1fT1Opm2Xiyh5Ji+EQ4ts+Tau2fujDFS8WHPsTzCHLUk37Xm2BEsLkq4KCXqmaRm8vb+9qzDf3yfl7KNj7RWQQ64l1BwY1Pg07Fq0pJ2EGL+imYhwjlzS7IM+ejiK08Vgd0FoEtvM6O9r6Q==;5:4Yvx1/u6u9infwusmOFmrXviopLHUZy9fZdYqvXb3RTMJ8MvtDBl19X/TiGgl+VmwvzTdebFvrsnj7AcozgmhxX84q9J9WlBYC7rrH7OzTk6fub8PiwxUFIUNSzVQ3Qvn2wSUwsdO8kioCc682roinD1QiekCqVTaGeoniCZbXE=;7:w1FKHforJHMrOZ1MptgRrewUbnUGfphsAuygGXcTFNwCt6ObgqG1kgtKTCxtUPyPcHTpK7DhpmGpiUw04q3U9rtdnKRhLmMgw6H/8i2656Coge5JeuyGuX14c4Fh+GekL3YWnEkClU1RAiwU0xszXI9EofdGJuq9Pf/Td+WHDfklXbf/jNtBUL7t0a2g2jQ1F0YQHznjQnTLtZU5hvErZtk9HRG7/tZ5umb4Y+wpoFd6q5QNDku3kvSRTgrNvFju
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 06:24:08.4213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdea7bf-634b-496a-e847-08d61ec1ac41
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.9.2018 20:08, Edgar E. Iglesias wrote:
> On Wed, Sep 19, 2018 at 06:08:18PM +0200, Michal Simek wrote:
>> Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B
>> is not detected on 64bit system.
>> The issue was observed when bootloader(u-boot) does not check macb
>> feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
>> by default. Then macb driver is reading DMACFG register back and only
>> adding 64bit dma configuration but not cleaning it out.
>>
>> This is also align with other features which are also cleared if they are not
>> present.
> 
> Hi Michal,
> 
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  drivers/net/ethernet/cadence/macb_main.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 16e4ef7d7185..79707dff3f13 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -2163,6 +2163,8 @@ static void macb_configure_dma(struct macb *bp)
>>  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>  		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>  			dmacfg |= GEM_BIT(ADDR64);
>> +		else
>> +			dmacfg &= ~GEM_BIT(ADDR64);
>>  #endif
> 
> I think you might want to do this clearing outside of the #ifdef.
> If CONFIG_ARCH_DMA_ADDR_T_64BIT is not defined, we'd want to make
> sure the ADDR64 is cleared. E.g something like:
> 
>              dmacfg &= ~GEM_BIT(ADDR64);
> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>              if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>                      dmacfg |= GEM_BIT(ADDR64);
> #endif
> 
> 
> Same thing for the USE_HWSTAMP/PTP flags below.

Origin patch, which introduce this read with mask,
macfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
was done in 2011 and from that time this function was extended a little
bit. I am even not quite sure if make sense to read this reg and apply
setting on the top of it.

Nicolas: Isn't it better simply compose that reg from scratch?

Thanks,
Michal


