Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0465A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WNg253mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0465A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbeKUWfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:35:53 -0500
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:10304
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728460AbeKUWfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00A2W96nditMo5dpyMAB3aSqunmmkEnL3EHeIK/SCDI=;
 b=WNg253mNUk2p0Q+Gk66By5BIleIzN8kUF23mJqrFSNBXgmBkIUwPT/M2OHmYjp8oumXMIa0aa1uLHpF2z3lAyvlM8GqmN7WhlT4wnsvF1/+2dhPgIbkUdf1oMBXcopihQKzprjlrB2y05WVqIHIDjSTudWGcc2/ZCLasxojLV74=
Received: from MWHPR0201CA0039.namprd02.prod.outlook.com
 (2603:10b6:301:73::16) by BYAPR02MB4456.namprd02.prod.outlook.com
 (2603:10b6:a03:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.26; Wed, 21 Nov
 2018 12:01:43 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR0201CA0039.outlook.office365.com
 (2603:10b6:301:73::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1361.14 via Frontend
 Transport; Wed, 21 Nov 2018 12:01:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; osadl.org; dkim=none (message not signed)
 header.d=none;osadl.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Wed, 21 Nov 2018 12:01:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56828 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gPRCO-0001t0-W3; Wed, 21 Nov 2018 04:01:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gPRCJ-0007nh-S8; Wed, 21 Nov 2018 04:01:35 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wALC1VEQ011334;
        Wed, 21 Nov 2018 04:01:31 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gPRCF-0007mC-4H; Wed, 21 Nov 2018 04:01:31 -0800
Subject: Re: [PATCH] clk: zynq: do not allow kmalloc failure
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1542795390-16221-1-git-send-email-hofrat@osadl.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e5e7b0be-8d45-ec7a-618d-8248a41e2361@xilinx.com>
Date:   Wed, 21 Nov 2018 13:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542795390-16221-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(77096007)(4326008)(229853002)(106466001)(8936002)(186003)(36386004)(6246003)(26005)(305945005)(81166006)(63266004)(31686004)(31696002)(478600001)(8676002)(36756003)(316002)(486006)(9786002)(64126003)(5660300001)(126002)(50466002)(65826007)(81156014)(356004)(6666004)(2616005)(476003)(44832011)(230700001)(54906003)(106002)(110136005)(58126008)(65956001)(65806001)(336012)(47776003)(11346002)(446003)(76176011)(23676004)(2486003)(2906002)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4456;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT016;1:P/sqUcUVERUPOwqcBIwMtilwp6BypHrq3VYXKGxnsE1YQiOTgq8Tcv7wx9OklYqqzj6nDdKqDejJ+SvtZ8FGgMyXZrWoZzTRNlrjpM0qJBwZiM6koIS0OhUEC6Ck9nuA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0489eb46-4dee-4810-ca32-08d64fa919b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;3:u+Vk1fvc5kFNJapi6XW4VZWZT+iSiLLBRDgZIDhWZvIeYcePOsjYGqbuGRcP4DmiaaC04FqdJ+Skj4zgMrV1JQl1ifGBeOvvbKzncnFOa4WohKlFr60EbrdzhE3eFcnL4J5ZiJt+KZcucWmXW8UjgkHUKIyNwj4+IJIIBmqZjneYztWcnz+lE0srchOrpY4Lu7ezJ6SUSOJsljHTE7DlZs7UpwBPQJKD/INHMluwlSaPzVFpRD0iTgoLgVtDdw8UTqYaD0LkuMGC5M9GNCZDTbBQ/dlEW4PUUL+NztsTCOt0Wq5WdJ5DhLuXI6/t6mi+GPjdROIApSJKu04cMIy17K78elODDUTxVbcriPayWBM=;25:fSkPBumqpmiq+/brXfQcHWaYDdTNr2er4e1oJwZfjjP4E/As6EIiLwiKc3mB1PBf15qYrh0BeRsQOVROxstnlYHddTwn4MQ83pyY4sTC2z1CI66POt11R1+3xDr1vQxZQL7TcCXCQk+fSsAYMnS/YiO3+6pgSM6/kIKBTR15qwkMkwjRUEbWNGh5XveBAMlUnrwTIeaQvaiiPMQRGYLfvgA7zfSOX5QMWiMmCpNpWBqfdGzHLteo0G7Wje/WcfR6mtqZnGt2G3D1Xlq/JB9+9qQiw6MTNHx8TKybINRXkOHXxqG/SvHhBT/qZEzFJ42jVdgMTUt4X0vtYtT0qkMHWQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4456:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;31:mO5kv+hoxY2LLWDUxOo2BFJNZrUSVFzKLTdxRt4V8iJfrYA//FSEQgqJIcOYt2ysm3O1mOLK/YvuBCuOaRq02hx2xdjf5am/CykiCnpLvzhS0BrNOsUjKaSmKu30Jh6+VTqUBmqGVfSi6JEYi1XEqIMrPDR3vdCXxgwwpFgGJOO86HjLpZEaJrR+RRRpbUId8uFlxTBB+GZCQ2YK3QHWNrlFCrxrWCUkIjOphSacYV8=;20:iaPNbYzdSevSSBuXkUcS9M+DLzsRCek1K83TxTxjIyLI1hlngKUz4wRk4MF+OPNBPNJHrEHR8FzfOips/HlnBJATp5HzXq+Hp7DHzPmQ+rxvAvXBxWTVlOYxDAhX9HT/GIuYk551kM9cCHIfhS3nISCD3NdBZDycJGwbn8ZoZOqkidltzq+rdsDzNf4mbR7ipzg0aQph4GdkbEKoqiP4rd63qqlLHmyoHDZ/4s68jTPhzd7CM2JeFmAJKUcoTfwJMj3U3H0WyvXih430WijZlSjsg6FQQWvF/iunFwA5dRqHI9G15cYQwTNCmO145gX5D/qYHUo2KhLJGQ/JQMfeF8nuw2w+7olnaLnZ9bQX0YlrjWKZ0N82N6Gs6ahuOdhzDzSgODyf/8UY2+R/E4LrFp7bpQR+4c25a9zehqS1zjLKhL/Brb2c6336dRgZL5aN8hlEL/fUMVerVWP0iUy2NpwIQcKBm92yQSg/o1BYLBiQWkQiABr57aC3Ms/a2MlA
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4456D63D9E7829C1673D9484C6DA0@BYAPR02MB4456.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4456;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;4:SlLUZ81hgEj4g8KLuwu1IBjsj2+EivQZUdOTU/GaldqytitYthVGy0ifNtH7JqoysTa/mSs+iUYZ8zc8V4O4IoGYXf7hVfrv1pUmGAHUCQjtY6LulCK1PG5mmxQfBEppT4NBgVXzDLwP5/X4FrnAh8i4kBRX970zbO9b5M4ofSpOxDPqVnJPUjGf+ZoYsP+17vvpFmqBLTSNBDNiE+hoc9k5oPncmfxFcsud5b/mHrjFoad46wj+keS9+GDxlHkieqNUjIVGBu00y0caXayl8Q==
X-Forefront-PRVS: 08635C03D4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NDU2OzIzOnhDeFBoK0ZhVU84RDUzUDcyRmw4d3JlbmNJ?=
 =?utf-8?B?RDcxU0Uxb00weEU1c0Era1Y1aWp3TzEwak1BaXhZUkcvMU9CS2w5WWpBeHU4?=
 =?utf-8?B?NmlOUm5uMlBqS0ZIKzJScHk0OGxiekllL2tXcTlneUFWdklBZ0pGZ0xGN2J6?=
 =?utf-8?B?RmJHV0dZTVd3ekpST05GeDZjMXNUYm9MUldPbDNSUWVFRkpsSUlzQzNOeGlC?=
 =?utf-8?B?d0JXUUQ2TXZSVkZXZWdta2dLSGRaT2d0bmZMdlFRNXY5VHpSNWQrbjFGUTQ1?=
 =?utf-8?B?SnFkbm1wTjM5ZXlvc1E4UWdvVEdPSUJFUEpvN0RKU1FqSFdKcVd0ZDBVN3Uy?=
 =?utf-8?B?ME54KzBaZGJtYms2NzZIL01zVnlIZmd2bnZaWHUxZ0ZkQkNiRVZHUUtXZUFB?=
 =?utf-8?B?QTJSTU54OS9tWCtpTVpaMjM0SGdpV3BSVmMydXJkdXBnRjkxYytzVkRHY2cv?=
 =?utf-8?B?VHJRaGpJeDR1eUpjVTNkTjdmWjg2RE9aOHpDSVdROWYyNktxNkFDQTJGSDk4?=
 =?utf-8?B?SnhCQ3ZnbXdkMkoybVhkdmZrTndmekVnUzZrU0lKNTdWS3czWUh5WGhXL0RB?=
 =?utf-8?B?c002TG1QQkJjTzNNQVZ6U1Q5TVhDRFBrZXVmMjZaMUZqSUtEZXdLQzBycTlZ?=
 =?utf-8?B?Tnc4T29zb1QzancrUHlHVTlrZENOaDlsckp6cVoxSUdBWVR1WEYwYS9jQy85?=
 =?utf-8?B?NUJKVWJlWS95bVd4a0dydTU0SVh5RGViKzROMzZYaWVXSzcrOUt3Smd6QzRh?=
 =?utf-8?B?S2lkQXhIL2Ric3RLMGoydGlUR05lZUJQS1YraytQdFRhcU9LRXJ2WmJWeUVl?=
 =?utf-8?B?dnpVZkU4T3I1WXNuLzJ2SDZ2WUVVNE5Qb1paSmtZb1lVN3ZLdmpZY1RzdWtv?=
 =?utf-8?B?UjFNMkRPR2tnQjJveGhHMGZzNDV1RDRzeXp1QzZqaDV6OFU2YjJXdDFkZ1Iw?=
 =?utf-8?B?dnREeGxDRmFtSTNQUDA5RTJqZS8ybHZrYlU5MXgzVG5MZWJQQ1ZtVjNtVXFW?=
 =?utf-8?B?N2lQS3B0UVRlQitQbVl1U2VMMlA1YTRBd3MvQkFCU0hiSmJoRzl3UnlPUnls?=
 =?utf-8?B?NUFqWUxXVUhzb3VXSTNML3FOblVKRmtjUVQ5TnZyaXhTWDYxbUxIN2dFVGNX?=
 =?utf-8?B?MlJUV1RsZ0tRbGRTRHpIbVFLVDRNb1VGWW83L2xldjR6QkdJUmtIbzl5VzV5?=
 =?utf-8?B?YWFEZno3YVhORHg3ZG1QYU43L013QUdnajk3S2pIUHNSdklFM3RodjlSL3ZM?=
 =?utf-8?B?cjNqWGVGbVVHQW5DaFJKdnRlWkRJNitnYnh3czJGN2NkOUc2a0NZNnpLWEM1?=
 =?utf-8?B?KzRCUTZhNXR0c0gxK3lINUgwYWtoNmdobVpzMHlsODZCdDJnYWJnc2V1ZWlK?=
 =?utf-8?B?bDg0R2F6MVFWQktabVEySWlIc2taNGVITlBOOGgxYmdDRG1vb1NTRTYvT1FR?=
 =?utf-8?B?YlI1TzFXMDR1WElxWU5xTzVtQlphYTJwVzA0LzNhWkkyaERDS2pNNmhiVEE0?=
 =?utf-8?B?MHRLM3VjdWNhSzRiYzMrOUY2RXVKYmQ3YzkvT2NnMXBMakgrbU9WK2IvRW5i?=
 =?utf-8?B?N2pxYzRjWWw2WlhGOUVjRHlDNFpHUEZIeTloQWtkL0djd0gyS3VRZ2ZtQkJu?=
 =?utf-8?B?TEFleDVuVUpJUVZHUnRmTGx3bUw5WEZ6R0MyQm9BM3ZqWVB2eS80em1Fb1Fr?=
 =?utf-8?B?c1owdU96Tm1FUXdmQm5uRW4vNjgzQkZoVkVXMFVRZzkyZXJZcG5ubnd0ZzNi?=
 =?utf-8?B?VzdaaG84MkVRNGdsTFBpdz09?=
X-Microsoft-Antispam-Message-Info: sDSrR3v8dYkngTy+PqyHeif6mbQvPLbeeOhQd1ApmWUGMufdWg1gvn0ckKebeb3C63xmTTJ5arewF8AV6cASVtgjTZfz/VY2rkwnz2XUrhePdmbi/PDd/p64MkCqnDqjTV4m1J0blV+2UJ11Q7nhPv4c6zbrz2i/FZ8qi6RHx8XY3fMSNoOghuvPi+ywecHiUK9aWPEJOgTnl5UEOgHBdGfoDEzom9xA3e4AATleAJh3KuElhdkwYceayNv1zfgLX82HsI/c0knznfkYk/M6A8JP9E+fKGnHHWBbYzr0uA6xSqzaPg/+C9pGr5q7000YncBV2chWVdcfRkIWv4Ix3E4Il9ayApf2Wjhhin+suXU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;6:k75MbLvxzBm53mqpxZuNTXS9euaQwu5sfDK1nFq85AfodNFGxEhVKkbmb5s09HnBpgoeE51vH6S8HVuC/YTJC6B/u/n2062rf7+lk7TjSEbhPts+2FjQdXJdJ+kZJrYMs+mrBy1mTRPYOAGJ12y24tnl3vHz1rJv/mOH/o47wuHCbVzZoTw7IObHRz6bIYArA6Mrs0wXscT7+Qp5Vrh7+vQp+mk5VmDzUnTo9/BSYL09YYeN0Rb20i29dDc6t7huaJe1aYQK6dLlssHV6fVm2XIsWtw0R9iN+jidWkxSbwlhw0hdJVvmjY1tMnHTntz9P5PsIdzcBbDwPLvVpqdcXHYx3XVG009Tc2BDzRdiyiRtVv/l2vBQ0gSBGBauhHND3qhNO6SzyBHkbmTs2knXhyptK3p4/yBobdD3r9XLPX6+0jL8os/XpDwPvMR/QMJ2VXdIF27wHY3+r+lfXwdTKA==;5:QozJ20inS6IqkYFKkKZKaUzgUnC/DCA5xTASP8ThAe1KaA2pnhtjwkV7thhCb53t2rOFcZSrof/UsMSF2bjJCMwN7aD+YKC62wNF+Eos+YzLLF5qRkCaR6LtRHLpaxuXhBd9Z28Dqp/4a12D9qY0g5WhOp7D+iOFAcB0S7c9vao=;7:IwTEYXlVZ7t3UtooOTTA8craVj0jZmVsO76h1UOO/xJeyR3M6QmY8MXiwDaD3qgZhEzZG0oXjw7qb8B+J82fP1I9ynPl0iTChBikw59qakB/NYFI/9B3gxnhICf9zUmus5lqbwmB3FJ0zwcD992IlQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2018 12:01:41.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0489eb46-4dee-4810-ca32-08d64fa919b6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 11. 18 11:16, Nicholas Mc Guire wrote:
>  The kmalloc here is small (< 16 bytes) and occurs during initialization

no reason for space in front of "The"

> during system startup here (can not be built as module) thus if this
> kmalloc failed it is an indication of something more serious going on
> and it is fine to hang the system here rather than cause some harder
> to understand error by dereferencing NULL.
> 
>  Explicitly checking would not make that much sense here as the only

ditto.

> possible reaction would be would BUG() here anyway.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> 
> Problem located with experimental coccinelle script
> 
> Patch was compile tested with: multi_v7_defconfig (implies
> CONFIG_ARCH_ZYNQ=y)
> 
> Patch is against 4.20-rc3 (localversion-next is next-20181121)

I have no problem with the patch but things below your SoB shouldn't
land in the git history.

When this is fixed feel free to add my
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
