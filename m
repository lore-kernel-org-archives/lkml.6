Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3C22152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cuafWlsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3C22152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbeITR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:26:30 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:31648
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727710AbeITR03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k+tD3nWzE6k2tKbWzDJ2TKgsoaopY405/GL1rkMXls=;
 b=cuafWlsViwpOgXDJHkAAHpG4Tv/4wxj2REPGpHDRXi6VcvXTNz7pJIdki27E0I52PTGjcHc9sHNLY5RO4oa+nOyVnJAqtVWXZAFT+IxYC/PYH0HUtbVp0wCZdM0N2FgVmyRDB8rQeqYtotWhIz8lc12vysiW1lZBGHH9qUjwT6o=
Received: from CY4PR02CA0034.namprd02.prod.outlook.com (2603:10b6:903:117::20)
 by SN6PR02MB4766.namprd02.prod.outlook.com (2603:10b6:805:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Thu, 20 Sep
 2018 11:43:20 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by CY4PR02CA0034.outlook.office365.com
 (2603:10b6:903:117::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 11:43:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Thu, 20 Sep 2018 11:43:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44626 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2xMa-0003tI-KG; Thu, 20 Sep 2018 04:43:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2xMV-00037w-GD; Thu, 20 Sep 2018 04:43:11 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8KBh8Ax027670;
        Thu, 20 Sep 2018 04:43:08 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g2xMR-00037R-Sr; Thu, 20 Sep 2018 04:43:08 -0700
Subject: Re: [PATCH v3 2/2] serial: uartps: Change uart ID port allocation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
 <dcf1c72203baf2629492dce765ce2d555316be0c.1537282676.git.michal.simek@xilinx.com>
 <20180920113225.GA19956@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <cf4e77fe-5ac0-b7f6-4124-90910eca5206@xilinx.com>
Date:   Thu, 20 Sep 2018 13:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920113225.GA19956@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(438002)(189003)(199004)(230700001)(478600001)(9786002)(36386004)(65826007)(4326008)(8676002)(77096007)(76176011)(2906002)(186003)(8936002)(2486003)(106002)(336012)(23676004)(305945005)(26005)(486006)(2616005)(6246003)(229853002)(446003)(356003)(31696002)(5660300001)(426003)(44832011)(316002)(11346002)(54906003)(476003)(6306002)(110136005)(53546011)(126002)(106466001)(63266004)(81166006)(58126008)(966005)(64126003)(81156014)(31686004)(36756003)(6666003)(50466002)(47776003)(65806001)(65956001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4766;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT016;1:R3rqoZKskr6yZp1B7CKHme6HQfAAiWKDL4tfozCoGimjgemyZBCn6aHBJHNRqVn96jLo+1hR/FpwCwxgtzUcsQGB56W18jowmmHI+5e0d6Huxv+/avgiBWQk37Y/1o1o
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819d81d9-6b32-4336-8ba6-08d61eee4386
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4766;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4766;3:pzlZxcY1qDAi1nOqogXhHZRaIt1Kmc4xL85BruFdX9OsLqDCXlUI5+XXsxYsPdLkigNuO985dTEb6IbJ8t6Q6V/gxr6L/b+VsOWImbmW4cQpfqrbmbyOtYNto/vkuRDxqkWggMAMaKSm/t0xiQAFmBbfVgY/PPFo38doxoKD8+GZMAabLSPtBH2VdOCQTVzhrbQGIRnzV48J2DHaZ9gfRPNHXgEVFi7q2S0M+PConzBuYGjjuYS6jqFMTko4Sztt8oxqs3fgsFPqiRS5LbJj+o/h/zfuce+ScJfOK1fnXTBFoiIHLV3zqZ7AtYSD+/xwq8I/ZRUpbfolkO09bp/oPdtl6kmXnSCj3M+Mzvv22hg=;25:boCGunRru4NMEwC6J0mu5zmKGaqBDHlxllRwaqA3MFSmUudU8tPMU/Dw/ZKBo73ZJPq2X5jNq/nLmoD4/8d4VxeP0fSCguKyrxs3Kx6KyVthzNyhYa+f9MVk9WSK0xEO4RxE/K1gkn5RUXnmG9Ml09dmhLtDIr1XIaWKHoYUCsuW2g3gV6iPUiA5J9GdZIVAFXh85khL9Gn8JD+yGlp8YkuOmqR6oG9d/eQvB2PbVZAdijID1O0FL5vr2TKG8dehh9qctQOzcQYDrD3MGMiMqluBB1NetsSYoLf9SbLSEK6ylM7iuIBypaCNQ+j0e8cWm5qNJy7DK2lGwi8Kb3ZxRg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4766:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4766;31:vUy6fg6odu3ulXHspKoNxxT8np7wC78sCEviaNr27l3Gc57/jALLEOZxj05FBFWWw7ZA9mP3keX92JGn7kQF72FhFhB6FFYj4o49wjgNzhpDiz/na2Qg3/rlxTizwDvNDlgm4Ra10/0jpoMLMZsgEOV/R8XhxLhgnYvpwVLzwBVcolXq1xlxrg5/fCBsZXE33M48AjpEf6wPwz+AIxe23MBG+oIjLgjLwmZ/j6ZbVUE=;20:ssZGxQQFRiLTcoVgyScMayl+PsMGc901rOkaYlOuwbz4ZAVQrTrwf7glNwIuRNmaGL0SdLhiomMpnfdb/FIVxWgt4G/xtlcZ81nS4PHQeW3ypgaxVzuQJFVbD18zlnieCBD4O4e3XEzca6bLPVIJiY4qQCNixTKDkoAX1TifI3X39ef6Oi5cwB4UIJKK3l812ulrYtbgyAtVYQuYMW4HMLsQYHH+HaYfZAk7RxQI8w/sOOVD+/S3JSuZ0AbJMAwpYxZVaa/SnX4unjROPNkPXF4mvGpiVHm53H6Cf5xy3BkZaaJHz/qg9pD5jk//OqLEkLfM9xLPbAJC1eEKwkXPjMoN+4FKHQ06ZjIyICcn2GjWcd+sYG87M1TfxVP4rlYVvjmD6Xr9D/peEWMQh+QOWQIU1WtITXNumhjjgKG10FMzlZsJp22Vltuc+uTl6+PjQLzgDXz3eQyZVmmo/HF4zu3UAvkBpVHkGYYm+WTjq3AIch2cZ/KaPDpBB1k09+l2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB476620DAF5EDC6920C0FD976C6130@SN6PR02MB4766.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:SN6PR02MB4766;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4766;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4766;4:Pw0UPL0/jjqO6KVN4fnm5IZoOTDNVWtg/Dv5GH/Xp528MMAXTNR6g1vme99B9h7evlXr11oLoWobfnbKRjQNgMe3hK0riqvI8PcamxmHxy64apSLf9FGPRev6y8vhM8KIILh0MiyU+Heysm89NwqcghTd7TQU7uV7K9MuO+bIbBRzfb3zBTe+GLsmBfNubZ3xds0Q4LsBKyaXyW8YDfiueXSneWdQFj1WH6l8Gh+12VQ7+7OUFH+QPrAA+gBUy8rg0RHLecbOlShlDbFGtpo5NQgNOgrejUzy5mGj2crSXy6+WI35Z5WnU1VU358bb9P
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI0NzY2OzIzOnA0d2xjRkZTcHVHcmhaeWduMjdHWTNjcW5t?=
 =?utf-8?B?Sk41VndOTHl4SW0zMFVYQVplTnJRNWt5TU11U2dsY09aSzBrRkJ4YVpKOWkv?=
 =?utf-8?B?N3hLNWwxTGZxS3ZOMGp4MDdyRWNjaVROdUsrVy9WQURTVGVId0RoZXhMQkZI?=
 =?utf-8?B?TFd1VTYzMjJYWWR4V2t4UHNqc2ZTUHRxcDRyS2p4T0IwRkdYSVQ1M3RhVVhY?=
 =?utf-8?B?MS9qRHJFY0kyUWVHcFJhQkY4ZXpVQUFuS0RqWW8xNXJnMnJhUEgzRjZacHdi?=
 =?utf-8?B?R2xpU0l4WWZJZ28xUUh2cDl1YWFDS09FWmVjSnFRZzlhdEZ3V3Q4YjdrZmsz?=
 =?utf-8?B?djFzc2gvdXVjdE9EQ2ZFZGZLUmplNUhnSjBwcVpOK1VXb3lVZzlKSVdQM25j?=
 =?utf-8?B?QlJJWUpJaFZNQktwRVA1SHZJTHJKTjFKWXFPakFlYzkvYTFJMkVubFJDZThJ?=
 =?utf-8?B?Z3RaZ2xadUg3VGFjT2pnMFYxanVDTjVxelBncXh4dFRuWWlHUmRqOUcvQThB?=
 =?utf-8?B?K0t6Z0lVelE2NzV5ZlFxNXNhL21sUUxmZWdGSS9QSTE3dlFoVGxPTk1rNFBD?=
 =?utf-8?B?RHBhOUN5VHUrNkI5V1ZrQmFIYjlqVDFxY3lqeDBXQ3JjdU9kWGRsNVhIRk9o?=
 =?utf-8?B?ZUV6WWg5SHU1T2NkRlhtWW9vQ1lmb0V4dmFiVmRBUUJpalczNEhFT2VlK0lt?=
 =?utf-8?B?VVNvZkNHNlVSK0QrWDJmUElvMU9xMWRQdSt6UCtYT1habllnRytVUm1DNWlO?=
 =?utf-8?B?YU9RcHpndWhONHJKbXhSeUxFdDE5VmZPRk05em5UaUpkdEl6VENEQnlhS3FI?=
 =?utf-8?B?SXQ5KzB6TEhoSTJIRlo3UmdWRmk4Q3NNc3JVRE9ESHpZZENiUGkxQ0JqejZr?=
 =?utf-8?B?K1lkbkpqMjUvMWlCY3pic0lHNWhRdGJnU2pUOWVzVzVRL1V5amx1YnBIcmxl?=
 =?utf-8?B?SFRodUIvRHd4OENvLzF1TEwrNUhUNmlyVnpSVFlEK1djcDRQMmpsdmIxeHVw?=
 =?utf-8?B?Qmt1c2xoclovRTRGZE8xMXB3dDJBQTJJWFlpeDNFTHh3cThGZENPVTg5R0Na?=
 =?utf-8?B?UGhOcXZPdFZPTVpYejFGb1crVUpleTh1ZW5xZXdZa2pVaktUajN1RjlhYVFo?=
 =?utf-8?B?SGdWbzRYZXhaVHB5Ym1jYUVmSDlOUEJVR2RFQXA1VVVHN0ZyZmJCTVQ3d2pr?=
 =?utf-8?B?dnc3a1E4dHVsOVB3RXBUMmtPRm90dXo5N3Bkek9MV1ZnUytVQnNHeE05SG80?=
 =?utf-8?B?WEwwL3ZCTGpobG85L29DcnlXeHZEVmJMQ1UrTmNmeC9jZUlEY0ZlQWlxVUdq?=
 =?utf-8?B?QUp1ZFJNUHNLT3FiK2kyamw2LzM3M0xkekhSU3c0ZEdhL2NKWjduem4wdmpj?=
 =?utf-8?B?UUdRcERiOXl6cmFISWRodlh5RFA2U2hyTHgzTUlsMGR0SXltdVo3bzgxK3Yy?=
 =?utf-8?B?M0xjS0FhN040bUtBdlA1aUg0RGVZRXYrSmtOZWIxbzFQMHhFdnIvNnpqZ2cr?=
 =?utf-8?B?VXlocDFKV1M5b1pGYTBIVnN2d3FVbEVRT3ZtUkdkSEZuZGRKdjVFSm9RSVZi?=
 =?utf-8?B?ZTFCL2RkYlFTemxDRkdFMkpmRXlkb2NDV1YxVHUrRjlOUnBHN2pPaVNCNnNJ?=
 =?utf-8?B?NnNBY2cyNlBLRU1ySXZMSFE0c1gzek5QaS9oYlkwaVFKcm9lc3pmMUZwYVB4?=
 =?utf-8?B?UkRKVnhLY3pjT2lEaCtzVmtBNjBibTBES3FJR2R0cUYvdkRpZ2V3T3laUkt4?=
 =?utf-8?B?TmJDY3lpYzNoUVRvd0UxSG5sKzNIZDMwdld2cm10alBYNVREWHFEcmkvU2tC?=
 =?utf-8?Q?S1iykxyd4qnS6?=
X-Microsoft-Antispam-Message-Info: CxhfrQkhVYdUgt2OsGrTmuweNBsf1Ez988oBr5PzLLwcwAqEnIY1rk9Du6wzb1yAPI4h8UgMatqKUAPCeRCYR7gZ8WI3Swk9oXi+ppoK3OMsZaOO45JNfYJiP0Ydt9M6nzwo4ssIBnfh2VGeraDj4N56hPCUiVZcBOZbA3kINZ4fhnq3557OaDAUl9F2kHW4zOerZWV5cFXuWN3FJBBf/7lZtZvBlULC1FV5/rsOFVhfZEXwPk1ZQwZIIK1mXNY8I1h/fkNNC4QnsIcag5jm51d1lCncPuoCVzgo7UhLvqr+Y51zhAlwrplemrJ7/v8U/Ujw91Kc/NcDNKv7REGygLobCZR7OKyAhsIdE3N0d6E=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4766;6:DV9WhnVYrEJZsr73mRc/UyIuc1w4KI25cEUYfkwNNjBcPFrds+rrJ3ieRkJ7d+72ZhMd91n87AIqszkfl4bDcIcs/3P/Zl6GpVinwVIyfEMIAHctwk5G48Kp7y7NSTFB641ppVrVgrlksMG6RGMyLki5g/dziJQ/4K9Hm96UnkF4fx91Jm2i/1zRBAr9yyGIlKb4Ip2gFLEbM2DoPEerDKVn0Q6COxAPgP9au1NbXcNtXD4lzQ7xX3DudC5Ta+8Uz9Un78s8ppP0ByDi3lQIujoPDiRWYtvoq9pTXHyoGLS3sSrMKXuweD7XXh6JcJQW2pCT4yZwmpO3MzPiCwzu/n7WZWVviCbCGFupfUYtplPCZT0WGkrQlxB+5P8Dm4eMuFi9ZPvIkQYK3gKDsnMOo1UnyGiZGEge65XXnLFBw1aBAHnyyKhVZBXkTdIQqyq7FSTCF/0Bwi+Io9uHYSVjpw==;5:aXQUJHw5tuMDIJuS5jhOA6yWWBcSr/WzzFPob5sEI/WvJqEd/7Akt9RNRSem8NtDYOkVHvcOeoYiyNmyJpC3mr32cFNOGuJ0H3Q4yq5hrQisu1RQ7HB5VJFl9b+9Xy39E30R0ApQPwhOYpl9F7h7PmHoNvQIEcqwcFbJgBHPvyQ=;7:k5gpfSRzKVu+i8IYV4hJvLTlbLIUsLbkzZVx3Z63a/DysR3Fz6mI3bEPWKwSFfNBxh3ki6HLSa5EGeGmg7HhHwLHtSQzDsucPe5tJruwiDlrCpm1LEb1mX5nfHlaJnBRWZ2t9SEbnkWnEloLzLEOkKylQcn2NKnJPLS72Fe8+op/HZneQrPwdA24Alw3xQXCgbldYSFr0Nl1ENQrVB+fQ6AGQGSJAiKcLpOcqBvDJcjv2ZgKyeDxD5iFhgdimjwy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 11:43:19.9694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819d81d9-6b32-4336-8ba6-08d61eee4386
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.9.2018 13:32, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 04:57:59PM +0200, Michal Simek wrote:
>> For IPs which have alias algorightm all the time using that alias and
>> minor number. It means serial20 alias ends up as ttyPS20.
>>
>> If alias is not setup for probed IP instance the first unused position is
>> used but that needs to be checked if it is really empty because another
>> instance doesn't need to be probed at that time. of_alias_get_alias_list()
>> fills alias bitmap which exactly shows which ID is free.
>> If alias pointing to different not compatible IP, it is free to use.
>>
>> cdns_get_id() call is placed below structure allocation to simplify
>> error path.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2:
>> - Add handle of return value from of_alias_get_alias_list
>>
>> Needs to be applied on the top of
>> https://lkml.org/lkml/2018/9/3/404
>> https://lkml.org/lkml/2018/9/3/400 (minor that's why just in case)
>>
>> Greg: Please apply it with
>> "of: base: Introduce of_alias_get_alias_list() to check alias IDs
>> Rob is ok with that.
> 
> I don't have that patch, can you resend the whole series?

done.
M

