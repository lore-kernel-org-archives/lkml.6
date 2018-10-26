Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A32C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ECD2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BbWXaItm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ECD2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeJZQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:30:55 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:6379
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeJZQay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10NblhggIhMLHaC9jkrQaOwPrTfnkGEnmvZVD/AV+b8=;
 b=BbWXaItmEjV3KizHwVRp7+9Bl1MafV7TfVjS83BbCiSQ/d+QXIaFL5MCg07aD5zhaCFOZ/gvJkxaEACsA7ajwyy10wbl5u+Cc6eaxPARMaY/1FV0oRjzBnn/t/QBWzMlaorK+mSjt6us187znALReMw35IqS4k5G7ycUrsJHtY4=
Received: from BN6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:405:60::22)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.26; Fri, 26 Oct
 2018 07:54:51 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN6PR02CA0081.outlook.office365.com
 (2603:10b6:405:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.18 via Frontend
 Transport; Fri, 26 Oct 2018 07:54:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.197)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.197 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.197; helo=xir-pvapsmtpgw01;
Received: from xir-pvapsmtpgw01 (149.199.80.197) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Fri, 26 Oct 2018 07:54:50 +0000
Received: from xir-smtp1 ([172.21.6.17] helo=xir-smtp1.xilinx.com)
        by xir-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gFwvC-0006zX-Ty; Fri, 26 Oct 2018 08:52:42 +0100
Received: from [127.0.0.1] (helo=xir-smtp-dlp1.xilinx.com)
        by xir-smtp1.xilinx.com with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gFwxA-0000Ys-5Z; Fri, 26 Oct 2018 08:54:44 +0100
Received: from xir-pvapsmtp01 (xir-pvapsmtp01.xilinx.com [172.21.6.17])
        by xir-smtp-dlp1.xilinx.com (8.13.8/8.13.1) with ESMTP id w9Q7rUGY002161;
        Fri, 26 Oct 2018 07:53:30 GMT
Received: from [172.21.103.26] (helo=webmail.xilinx.com)
        by xir-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gFwx8-0000Yo-OS; Fri, 26 Oct 2018 08:54:42 +0100
Received: from XIR-PVEXCAS01.xlnx.xilinx.com (172.21.103.25) by
 XIR-PVEXCAS02.xlnx.xilinx.com (172.21.103.26) with Microsoft SMTP Server
 (TLS) id 14.3.389.1; Fri, 26 Oct 2018 08:54:42 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 XIR-PVEXCAS01.xlnx.xilinx.com (172.21.103.25) with Microsoft SMTP Server id
 14.3.389.1; Fri, 26 Oct 2018 08:54:42 +0100
Received: from [149.199.131.148] (port=52498)   by smtp.xilinx.com with esmtp
 (Exim 4.90)    (envelope-from <michal.simek@xilinx.com>)       id 1gFwx8-0002Un-2J;
 Fri, 26 Oct 2018 08:54:42 +0100
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
To:     Moritz Fischer <mdf@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "atull@kernel.org" <atull@kernel.org>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
 <20181023090119.GA2205@archbook>
 <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
 <20181023110445.GA1371@archbook>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <468b9b34-aa87-9abb-a913-0512a01e9a51@xilinx.com>
Date:   Fri, 26 Oct 2018 09:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023110445.GA1371@archbook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.002
X-TM-AS-User-Approved-Sender: Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.197;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39840400004)(346002)(2980300002)(438002)(189003)(199004)(4326008)(229853002)(336012)(5660300001)(476003)(305945005)(44832011)(2616005)(446003)(93886005)(956004)(58126008)(356004)(65956001)(65806001)(426003)(478600001)(71366001)(81156014)(11346002)(47776003)(486006)(31696002)(6246003)(65826007)(126002)(64126003)(106002)(186003)(53546011)(76176011)(31686004)(36756003)(8936002)(106466001)(26826003)(50466002)(110136005)(2906002)(230700001)(54906003)(316002)(14444005)(8676002)(63266004)(2486003)(26005)(23676004)(93146003)(9786002)(81166006)(50156003)(107986001)(93166003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xir-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-197.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT048;1:rXOd47uFH3zitnGIZelV0ZPSF0E1Y3kdkjcRSTcIaWqBC6V8FrOwyBUX+N63k8Mdop/qvZWx7HpH7QLRILv5pV2Q8EufLu9Ey1e5oMu/If8wH4SA67cSSt1vKUySgWQd
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 855c5656-aecb-4bbd-1e8e-08d63b184f01
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:me1gvifDzzki8vy10SG5qLVZwQGPQThMLKmbZYB3Blo3DvQjJKw5KUQ79lLsUDvSGUyIK0RneuQWSnwFc351z712NcAAnyt/LF9dQLW3Q2a8MOaNzNUt+RCpQ2ba374K6hxbjkm77N3MMH3OAWdrpn4UuyA04s59NsDJwah5P6vUPqmC47LcOGh2Lj/IhqaJ+MhJv5r5w1bQgKRpIZw3AFm0/LNGthgNm3jtC8MyCeKM4M4U4/W0+wCYnFICSOxom9EeHI7KpjRPN8FDRc4v/Oyj0w14H/rUIopUJBQj8xcFDzZeMqQuJzhTPB3wZlKTye4yd8j3BMGwCssbFqRFowu1mnryWEDtZYxC6+RPAVQ=;25:Q+Ap+6GH2fKFbqkrfeiQQHy/kGG33CRBiQbiQ9RDy5O5T4sTKUH5y++cgvNG8IVlWlHBxR3WGm76b1Th0ordoe6sD3Mb7eN7+G6rtI/yuh+Ujpb0pV02bHndddNYNstZqRHCyBTziQOQVYFZ1mpGSpzS7qMTe8SI4h4V2YQ+bzlm5qXDptKY8i4rUT7L0Cu5Do6OT5FspfQg6dcBR6zGSYF5DuT2St0RISSi+bQYsHfjVgZDkr2uGPENd4etyqLm7USiSUysgNbQ2mrnShr2RG37miPoqFUDgH0ZbXK77lq03+oHl+4QXy+UYnmZS7t7qeZBBu3ViHhcpHXk2IaTUg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:z45ncezCgXvyy1oaNcfi7+yruw1UBxWE+F/8wdzLi/U1ez2LOABy4ZyhnE2yUd5cr/PPF44BBLVkIbDe0fFgK5BaRgEKUH4jbdBZpnjaLqHhcq78Zje176rWYa/u6/91ohvdAWeN1D/ZoUjP/EWgjiOF13mPI/wbAURWW5RYW3T1kYUiV1vBczcEvCsRiUi1rPnEwybAQPcFyHDrrn6iqPXm/qsRGMoVBAKfl0zVY24=;20:8gc712pM7bdW+TaaEprBMDiJx6u9OZ8v1ZsL1fRXt2IT0QBEyxT8A0BW7z/yad4qSnhs2FuFZi/i0U9U3aZq1sy8HNdKDDv8h4weB3bt3/0KKHXRxLV4dwLksvC/Gh6bdVAE8ySRnWmgd4CyircBY4xSLKjjEMNAzXsGSXkPfMIwq1oNcG0WuVjT4FK9DCIqG3kmPehNQ3caFVrbn1snB+qdWkC56jG+2VANhb552I54wataUBk4Ogb9UlC3ZSc7alHDE3p/nw1l2xlbUIZNODB81U9mBxnrLQ1nUMV5Nko3uBgrtUGlk6T2O+RW3q83w7G1a/R1d7Od/UnJVfmiqKfAxVq1saWFDsCuhuBhvHqB7Fi47NxnMvmDRW6pH8h809Xmkg9ejr8dxRkEnpQ8Jc3kzlCizkk+OF/7e0SbaIsUAIx8WphxfMjo0SaokILf4EW/m3ib32LdaLktWEcRJiRBWGtdsEZWN06nQDaDpG3SaOlHDPPAjLgvoNWa7X6N
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44498CF9847C466BBCBAE5B0C6F00@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(190756311086443)(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:1U0+f22uEyedaqoPdDi/q+1WYn9Vm9EZMVMSqGs0Ro8pu3avP2IXgT3Xf08mATAGsCnvef1hICOTx/RugLoCPCHtGqjdjKQ15hlpKPhY+k6MZanZzvWBhCE9/PP6spJBD0lHyO4L84ieE6ADi8E6M+a1o7PAbuuyIZFbYkCfm2DwzpHlC08ksmUD494KVUSyP1xCUQ0CFsrYd1AWxBW2UlrH124aEigsZoYIsdIOY2mqRyDGhEhD9PvUba2bqbSQFdlAhazCukONZwOi5QGDHPJPjllqsUB2t38DrITkACbs2bU2xAIyJmKtm5JQJZxixx3fLtn8sVaUZ2DgmM1dW3ooapQaYVIdwYh99+QmRfVVxtoAaob/QVRYQVqOo801
X-Forefront-PRVS: 083751FCA6
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NDQ5OzIzOnpUN0tzU3BmVHdqWlFzYjJ6QVl2YSsyN3By?=
 =?utf-8?B?SmJqRmJNNndhZ0xQSytJVnFEYjJyc2VHRnpaWTB2Rktydy9xSGZNS0NMdnFv?=
 =?utf-8?B?RzBwRHRaR2ZIOUlvaHBhWUozeWhOcUtxV29qdzNscm0vczNJTXJBelhFTmlX?=
 =?utf-8?B?d1FSbVpQYitJTXBWcWs3em54SFpiLzR1R3pIaU1xM0tTRFJFVUdWNkxZdUI0?=
 =?utf-8?B?Tmpsc3VRdlVtVnFGNnAwWUIwUFRtN2Z6VzBEL0VDcGtqd0x4bGpNbFNmYlhN?=
 =?utf-8?B?OXhRNkdxVGRaK3J1OUtMdW1oZFVEUlpkWjJSaGhHVXg4bnNyQ3BNZnFCd1Jj?=
 =?utf-8?B?WDRVTGJFMzlyZHkvK1BuL2VuUGl3d1ZtR3lmM2ZvWTJQWm9COUU0SUFRRVEy?=
 =?utf-8?B?cHo1NEJHQkxqQWlIalJiN1o0TytacktGVzJGZ1IzMVZFanZNMFNuZFZzWi9K?=
 =?utf-8?B?b3FvcnN3S3I3UExLZUNUeU1pNnpWSXIyZmxhTXVDWlp1OGJSS0NjcSt4eHlw?=
 =?utf-8?B?MEkxZ3VjTE5jWStXRk9tMHFkTG05UE9UZWErSWtrVmtnVDNTVCtIUkJaUnl4?=
 =?utf-8?B?ajV0ME8vakNwOW00cklWSFV6L0Z4b1p4Ujh5Zm01Y3VjdzlteW1mZG9sWU00?=
 =?utf-8?B?QndNUC9CUk40VjBWSGdtNkNueFNGc3lLa3BWNHg3cDJ4aEFBR1lYVlV4T2lF?=
 =?utf-8?B?Z1Q5SlhoZTVxbWw3ditKbGw1UTZ3QUw0dTVpRTBQb3NjYnFWUFpXd2xMRFdy?=
 =?utf-8?B?RFFFdi9jVWU3UWdQMThKRHlLTHdWOXhKdmFvaVdUK0pmd0xrUGpueG1iZFgr?=
 =?utf-8?B?N3kydndTS3dSYVQzMUQ0UDFHeVhFV0U5TnVnOXVjUG9MemtRcnBCZEFKcXFR?=
 =?utf-8?B?TDlUUlJFdm9pMFZESlBEOW1WdEwxY2RnRVo2QXo2Z1VtRElDWWZTTzZOcExw?=
 =?utf-8?B?WVRRZDVkVEZtQUlLbHlwdVFBWEM5L2JxVWNHUE5DcWJEWjU4eXIxckl0RFkw?=
 =?utf-8?B?cHpQZ3hCWHQ3TmlUUzcyeGxWY29kYjN6YzJsQmNTS0hSSjhnWEUxQm5aRWlz?=
 =?utf-8?B?Q0w2U0VySUVpVTNJZWswM3psb0ovbmx5WGZLdzhuNmc5Wm42UklJY3EvRExz?=
 =?utf-8?B?cWZZVXovSU5TU3d5TzBzYk5MUkx0dkNxV2JwM0R4VzlMSTl0THhnOXpibWRv?=
 =?utf-8?B?YlJpVDk4cXBiOEFQWEFBRTZ4WitzTzVIOGh1TmdKelE4Q3RrZ3d2bld0aFp0?=
 =?utf-8?B?dDZIbzhocHA5ZENCdUN1U3NFMXZaTGo4SjFqODhDU3JaRDExNmhrUjVBMnow?=
 =?utf-8?B?dFJqbWJBRmFHQ1JtNlAvbGttSVA2NG13cGNwMUYyWFVhY1ZsR3RHM1MrN0Y1?=
 =?utf-8?B?Z3FZVVV0aWpJYTNlRVQrZktpZTh6UlM2NWFZK1phNkc5TkN5WFZLVEdJaG1G?=
 =?utf-8?B?b052NCtJbTNwcy90T0VhSmFZbTdtWFBwWVF0N21pQk5rVEJsQ0I5S3RlRXBV?=
 =?utf-8?B?UzdVZUwwTElWTzU1NGxZYThxcTlTWjUwK3hTMFdzcHh1RnhjUzcvcDJ0cG5S?=
 =?utf-8?B?TG5KT3o3WjV4aVZrSjNGdURWTENUZ2pDalpwdFh4aGJWN0NFZWVyNVdqRDB5?=
 =?utf-8?B?VlU1aFVSV2NsamFkSmZWZDVJdFlsZFQzdFNIam4vOEZQV2NQbUgwcmtlSmJv?=
 =?utf-8?B?MFh5My8weHlMZ2cyZ29RaFhRZUx6TDJlWlc1dVhWM1RvYjNXL1JIQm1xYU9R?=
 =?utf-8?B?VVZEdFNxNVVNaHlrV2lreWtMd2dmTTMzdFB0ejNzd0lSZmZlREFpQnN0dDg3?=
 =?utf-8?B?ZVNFYVM4d0QwbnBFaWNhM3hLZkUzZVBHTWVOc3JXTDRUWHY0Q2ZhNWNteGw1?=
 =?utf-8?Q?dTLP7TKnros=3D?=
X-Microsoft-Antispam-Message-Info: n92OIfEDPJ6R+kXQmLHWersJ2c4P7+x18WaDygSYxmkhfpBi3kL9Ta+pqCah5zoWdUYLIhPvJgFXJsMim1BphPAfXA0DewCg3yGgDkt7i+RrLTkshn5miP1lWdwaPvikCy2Ax6AdHUdV7Vg0GELnt2EzTabaem6JuAbVaIRAjjm1gEwdi/s1Sq1NbGaGBXX+NRr6E8hyoPLOgRTRgAI+mdYlE0t3pUy8D/MBX4OsYyC0/idpHyKC1vmJZwzYujb1/pHKXAOZpDt33lqqdf+epDc/vzh2y5BFokMKe356BWsyCf2/4rtqs/hjLrBpv9oMlTb8axXZZse+nuRfJn7Es3x3qiqdMEYPyaH6HqonMT0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:A/IKah76/7kxzAbASla6QhIxtd8s3KzeW4/5aeAjkZlPAfbPZFMFRw9ZNezKq1OzLTYk00mKMipT9WffnuSvg2rvPa7LPqgtDhv2mYGgbuaGANT+tz6xEQyo52mGcB1pHwLwBN/M7fC7b5YCzNNm/vIkd5o3ndDZ+H/9lZ6heOdLgu2Rs2p1j3ajMrBi8e5fTAfuyKuLK8mhR4y9Nw5Viy5UgGTCW5B2gdS36PR6xeUaIVsET8RFOjI8IBJzqJthILQ5yImK/XAf5mswhxRVx5nl5pXtYTA5SWVkcqHdMuBNCuXhNcGxoyD9Fs/g9jWLElfrCBIdq9hsdoET8t3wtpkO7exlllEoCTB/uQGTevx3pw/l88oB3FRW5KOUumQiow9YB/QBY9PoP86mmLzgGbMykMFyd0cS8SQoM5jKqtmvctHCAMsNajdBC2gD6hcduYek9tTMxcc3alQqW9lf4A==;5:/R9+VLPUET3dtYiBLidNKJU4rOzE3V04vTuVgSbNLmHl1Fw2GqElBNV4D189Plipl8NFDmvPbkTTobNE8zkSi4CagfH2VqwPKGZ0SauRKvoNYrLxck3U3jxrGVezcuNA8UCrOINjnfb6xBzNjQIpCaSmXrciHMGYgVmB3nS7uWw=;7:Ggq4ombaTGFT2SaYz2MvfPBQ+wvYX4PXuY+6/pdCEkDHYHXqimauNc61qdTOzn9XL3I0VSMvEeIgU4024G6kPopedrY3qOxpu/iEjByDkdrcN1Glj2vdr0a5TW7N02Uetn7QeENBFCkmyEuSzjDyjM00Db/gC8Yh6UwR12TXSdjBV6apE7DYuzfXJWchJ91iiPbSLa+Q0LwT/r7J229l9H+nOJySnZAQHaZeWZ/pVuJDSSBgA5w7V9I7OFyck5HM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2018 07:54:50.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855c5656-aecb-4bbd-1e8e-08d63b184f01
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.197];Helo=[xir-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 18 13:04, Moritz Fischer wrote:
> Hi Mike,
> 
> On Tue, Oct 23, 2018 at 10:53:50AM +0000, Mike Looijmans wrote:
>> On 23-10-18 11:01, Moritz Fischer wrote:
>>> Hi Mike,
>>>
>>> seems like a good usecase (though uncommon), question below
>>
>> Usecases for ICAP:
>> - It's considerably faster than PCAP
>> - Self-repairing logic (e.g. single-event upsets)
>> - Being programmed from a remote FPGA
>> - Programming through another bus (e.g. PCIe)
> 
> Yeah, I wasn't saying it's a bad usecase, just not super common :)
> 
>>
>>
>>>
>>> On Tue, Oct 23, 2018 at 08:31:19AM +0200, Mike Looijmans wrote:
>>>> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
>>>> it impossible to use the ICAP interface for partial reconfiguration.
>>>>
>>>> This patch changes the driver to only activate PR over PCAP while the
>>>> device is actively being accessed by the driver for programming.
>>>>
>>>> This allows both PCAP and ICAP interfaces to be used for PR.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>> ---
>>>>   drivers/fpga/zynq-fpga.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>>>> index 3110e00..f6c205a 100644
>>>> --- a/drivers/fpga/zynq-fpga.c
>>>> +++ b/drivers/fpga/zynq-fpga.c
>>>> @@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>>>>   	int err;
>>>>   	u32 intr_status;
>>>>   
>>>> +	/* Release 'PR' control back to the ICAP */
>>>> +	zynq_fpga_write(priv, CTRL_OFFSET,
>>>> +		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
>>>> +
>>>
>>> Shouldn't that be after the below stanza that enables the clock?
>>
>> I'm actually not sure, and I did not encounter any problems while testing 
>> this, but it's easier to just move it than to find out, so I'll go for "yes, 
>> let's enable the clock first".
>> I'll await a bit more feedback and post a v2 for that.
> 
> Ok, I had suspected you tested it and probably didn't run into issues,
> but just wanted to make sure we think about it. If you don't mind, swap
> it around as I suggested just to be safe.
> 
> With that change feel free to add my Reviewed-by: Moritz Fischer
> <mdf@kernel.org> in your v2.

That clock can be used by something else that's why you didn't observe
any issue. Anyway I have no problem with reverting that setting back
that icap can be used.
In general there should be synchronization mechanism for this. And also
driver "feature" not to enable access from icap for security reason. But
that's something what should be done in other patch.

Thanks,
Michal

