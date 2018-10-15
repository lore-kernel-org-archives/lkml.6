Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C3C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A0320853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mVywAxTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeJOPVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:21:54 -0400
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:48539
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbeJOPVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM3I7yCZvlqwuoQSEQ8c/BwtE9IKHe8q5TdKM7MMeqY=;
 b=mVywAxTY6PjHWRJjVx/ccNCn3V0W9KryBgu7SAhp2cKiqG8mbII7phCgpSFKouK7o0tChjnTxyw9ASAzBoKuf4APMgXV7BCh493VQMrpQScRJWTUTT7nZZB20Y/nOUnbPJWE9rLu4OO7yXkHeO8rJfWYZ2VtgEQ2mujhH7hH0ac=
Received: from CY4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:903:18::11)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.26; Mon, 15 Oct
 2018 07:37:30 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CY4PR02CA0001.outlook.office365.com
 (2603:10b6:903:18::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.21 via Frontend
 Transport; Mon, 15 Oct 2018 07:37:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; efficios.com; dkim=none (message not signed)
 header.d=none;efficios.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 07:37:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gBxRQ-0005Ot-Uz; Mon, 15 Oct 2018 00:37:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gBxRL-0007Yp-Qo; Mon, 15 Oct 2018 00:37:23 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9F7bGVw023660;
        Mon, 15 Oct 2018 00:37:16 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gBxRE-0007Xz-Ar; Mon, 15 Oct 2018 00:37:16 -0700
Subject: Re: rseq system call incompletely wired up in microblaze
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
References: <1913468383.3666.1539535618042.JavaMail.zimbra@efficios.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <65035668-ebce-bd8f-328d-0d3672a4a065@xilinx.com>
Date:   Mon, 15 Oct 2018 09:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1913468383.3666.1539535618042.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(438002)(189003)(199004)(81156014)(31686004)(476003)(2616005)(11346002)(31696002)(575784001)(186003)(106466001)(486006)(63266004)(126002)(54906003)(110136005)(14444005)(76176011)(58126008)(81166006)(8676002)(316002)(2486003)(23676004)(44832011)(305945005)(8936002)(77096007)(26005)(5660300001)(2906002)(9786002)(65826007)(50466002)(53546011)(229853002)(64126003)(426003)(6666004)(39060400002)(106002)(36756003)(478600001)(230700001)(446003)(356004)(4326008)(47776003)(65806001)(6246003)(336012)(36386004)(65956001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT040;1:8QwMARW9ySIihJELIsDyIfOzJeiTs27P1vz6X0oN5TjpvjJRs+mLzDHyozn21dc5RwqC392HNPAmNkw+TGW7RWKwxs2K26whwiCnETXo6oSINslVijsUwir3XGWcUvM8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40cad94-efb0-495c-216a-08d632711002
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:6siVGnReqEA/oriUeO6wnizDt7rYpwGMIsaYMzutChoakSpzAJ/7Wovn1RxdEfbVpqUfRkQNBzn10U6jdpo6Y2DrChYp8VIquguv1gVt8EhIh2m9sW0Lou2Bsru9QuphYsB3FJR8w39ePE35akvbP0+X7jl9cwlFJOLoIK9ICQjeX45PJbcWIE03Kr8ExXbHfOBbKid7r9q1k/5spYcoG+4LwrLX6++sUnhU6HzxXdItfi3W+bxc2PjUU/AjKUNHrtqbO2thHMVlIZOfDjN1kX81gZJnNEaJUIcRjXPX19kAD9qUCzivbp2k4TUalCM9X7ouuu+AVzpI09jY7bkM6UVUp0Ewan6GbFw5ZJ8j3AY=;25:shAZx2ZSs4nWBh+FoZ+auloomvTHsqwbcqOrRtpCY4eIIY3irYleBc49x0zTbVgvzUOzvvXiFNT6Mz0Jopx0Hm8F6feBnfR4+kbeVXZ3iKjUuhT0jZi4GQ/oduEi5sZA1CqkYaz7bEqh1w16gNYbjDBlw4/768YzREKa1vbXcm7coSC8xdryzEM6Io9/y/WMBee77Q11grPkgtjDo1gJwKWfsNhk/hzZiEJ266G32Q6NUpNrq4jw0Mycdr3vIvUJ67psXXHBVfeOf+sgE7X+9mQWAR9ymNzu6Ul1bXvuw+Po+u7UYA0XyHaUK2MarUuThDWbPfJDiNoFu+RwvjCJPQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:sRPyTypGUUg+Sb27cLsyIYR/Vg3DohO2PKGMGPYoyXpytZc0AwmxO9uLSPrhp0vAwACqyQfhryyGEpYohMKMl4GnfxATSI45KQUKx0Q4EJzQFLatrfBUqWCfOvLC+JVKjb4KCwgyBQMO61D1ie1OQHV4w/rfimH0Qw/ew6Moe3DyC2FiMRB9PeZdzkTEy4KspO25Ho95F3I7z9B8dOk0H8BJcBtbtWJj8f8pjQpZODc=;20:BBe1fuh2NEl+gk9iXnqE/EVumYAYl0MrMLgQgo/p08w4qrU9eelaRh+Ht/Gky3CjJetkfqHq8IQ0HmhdrXxGTe1Xk7kKe0lvV4b1o76vr+w7T6liqNouqOuqlwSlgmSk+eSfwx+Eh900euzUx9IELGEAwM8iKI4LXzgXOFm6p3FlPOPzpZcBNKLMIp4XChicSnMYl27EwxAteG6mzq6Wbx6EmBPQ7zx21z5GJHNQDaKzlhh3+gEK+wCsYh4K0h8v3Iulcukjej2sgBRHAAKg6mCIbJF8ELsq3ahKrtdjYgzLpSsH1BeGJCprTqsKSAuIbX2EHPSBFxRBP55bNBy5CAtHtbsAMcvUY1SeIsLn+X40lLw/m7tOntz+3Th0Eld//b+Mf0Q6jTunKWpK3iexhv9L64Nn2ydG1M1wu6p7X16Bf2TrjuGFK1EFP/JSRSuHLLyGrJMSDRovgJyEk0wt0rBVgpHHglHSNipAJ7iZnoTKc9LGKe/yZhVSWfUhkywL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB444968D3953CC931E52CE52DC6FD0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:0K9KF7i23Lw9kEe03USvNnJejIi+2bL1IuP/1/24SJnfn44Qcdhd6YGHoWfxAaMAiuiFxB4zEjib7F45KyPdrgsbiFQ43MkLt2PI/xNPCdWXiNzsH6uk1qI9/10EIAUE9uoSNq6gNJ2C7j+CvbHfsS4n198wzJV76aIEORLv81+/RIqZRmarKLTsQOwTmVoAJxSbHCorhnTS7i0ZSpCwqVgFsyP0MLcjp57ysfJOgeg7KvDMzct+8jAmP+B8VeDcyK+lDIKD2TSxZ95ym+G6JFn9KesTZBRKjgxgEXoCchwUipUMSnL8szMHD5EE3gM/
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NDQ5OzIzOlJJSWplRU52aEdBK1VwK3VGTENqRXJQNCt5?=
 =?utf-8?B?NnVlYksxK1NvZHVDS3hHVm9UU3dITDI3NkdIaGtIbU5ydldCVWYvSytFS3pk?=
 =?utf-8?B?N3FvTmpmaEJzRW9UbENSWTJCZk5wM3lCTzlrOFJxUXdWbjJJRHMvbjgrVTVM?=
 =?utf-8?B?OXpvbFNibjNnUVR5djBYclczbm9aWVVIendCeUNPWks0NysralYrSkx2TWN3?=
 =?utf-8?B?ckVYNTZIYWt6V00zWi8wekNoM1hIV2RKc1NuUzBLMzdCSnc5b3ZRNmJRUitw?=
 =?utf-8?B?cVI3cVNPYVVGVVlYNWR5NWZEZ29lNTN4YlJtdTBtSjV6K1hXVjdadmRtUHM2?=
 =?utf-8?B?M1NvdEZUUVg5U0hUcGpTZ2tkaHBsQWdGa3lQd2hiZkRRdmNRSGtLeEhQenky?=
 =?utf-8?B?Y0kvZG5KbTR3WlFNbmZnc1RpSFJIZ1ZITitTZDZEcGdZYkt2VlBPWExMS0t3?=
 =?utf-8?B?dUUzMmxSWmoyMnFCSU9ZM2FteVhZWWRTeVVjazBHd1lxbi9aUnBoalZFeVNi?=
 =?utf-8?B?N3hadE8vQUcvb1FObTJtWWFzbHNLaTNwWlVUTFhzUksrV1BkYWdyTEwzSmhI?=
 =?utf-8?B?MGJCZnlvb1grM2NJc1hiTVovWkZ0RktnZk5FWi9HUzFRVS9CYXAxNnBQOERN?=
 =?utf-8?B?L2VFTDE2VGVtYXd1ZUs4ZDRoY2hUZklxczJJZTlpV3JtZ0xscGFGcWZwZ0kw?=
 =?utf-8?B?QW9pbCtEeTNSNVVnQlEwT1Q1ektKTkNtSkVMQ1V5aEVpSjArbzFKdXpsbFIw?=
 =?utf-8?B?L0Y1dURpWlh6Y29IdXFVdVNzV0piOGlzZXVacGNmRko5UEFUaFEvNUt2cG1Y?=
 =?utf-8?B?d01mZXNWbWxYNE1IZUNITmZoZW8zMjd3UmhlVVQwMXhQc2o5MGdyaCtHbVBH?=
 =?utf-8?B?Mnd3SFZDVHgzbmlzTWNhN3c2MkplZ0lDSGxZcC9zdkp4QlloNk1kZ0VTbzAz?=
 =?utf-8?B?QnJoTUErbFRTN2MwZTh1VVpDQ1RCdG1lL2RVdUtPS01ZS2grY3ZQWGVmUEVC?=
 =?utf-8?B?YS81YVIrazJxVjVpOVhaemttVEF6bG9hM3NDVzF2TGN6TDg0NTN5bkV2TG4w?=
 =?utf-8?B?QWE5NGR1MkJoZWh4SkVBaklzZ2pwMmxiUExaN0lIWDMwVXpTZHEzeS8rdnNu?=
 =?utf-8?B?bSsvTXJtVnpUMHlSb29hRlFISnFodUdrbEpoT1J5SDdROHRRTGlRVXRZaS80?=
 =?utf-8?B?Z0ZwQmdBWTJaWkVFNmlFUVJCWjhaWko3MW05ODYvZkFqVVRxeVBlbm9Sd3hk?=
 =?utf-8?B?NXh0Qk95dFFPV2tndk5mSnVOL21weU9xMGNNTGs2RHJVYnF4dk4vZzRBVG82?=
 =?utf-8?B?WDVPQjFjaUZQUzZtSnlLK282MjNMTmVzTzBnWUVZQVJpaUhPVnJrUnNJSzBB?=
 =?utf-8?B?NEhtNWZ4UktySmdCSE9xRDBOT2xGWUtnRHoyZWVHcWFzakFtQzRoOTRKekhZ?=
 =?utf-8?B?Zm5tdWdXVmtqRXZ3T0g3WEpEckRxZEdxNkpsMzNQcTdDazVOcFgrYzdtd1Nz?=
 =?utf-8?B?MVBMelJoRDhyRURqa1VtKy9wR1dlT1cyTDFMbWhJQTk5QzZuQUZzSEpwRW9i?=
 =?utf-8?B?Wlg5KzZJd3VIamNhNmZweHhKeDQyajRjTEdrTlQ3eW1pWXVXQkp4bG03ZFY3?=
 =?utf-8?B?d2ZoL3Jpck14NE5Sd2dtRFZIcmhmOFdxaG43a2tTdGlySlZIOHpYcm16WGxs?=
 =?utf-8?B?d0VrQ2VPRkR0SVFkc0U5Zk15UFhLUWhRcE5LbmdObmROYk4xOFQ5VWY2ajFU?=
 =?utf-8?B?ZkFMVFNkTWxwV0p0MVZyUTVmTDhxVmtxUjc4UUF6T1RhZ0dsV0lsemplemZQ?=
 =?utf-8?B?dWxzT3BXamJNaW9uaWpqa01GaDYxUVpqc2tZODBCQXY0bXc9PQ==?=
X-Microsoft-Antispam-Message-Info: 6FXeexjdVsk44dFmTFYlVK7MCMeTgbOaiREnooxzvLph6MWqeZqNVdp/wvQYmCI9M5b+cbJE0+79mEXwQef34wztzwJdgyXLtAWjCsP8bIZQ2Zmlhmj1WKDg0gY1E4pAp9E5Lks2YNvDpkVwrmax2PhFqv05AagQEDd8Vsna7cCE35U0JFXSXu7AfaU3Cw7/anz6HqdWn5A6hG2j8h8n48bAy11rIOq2R71MRkqngcqBiXGBA9Kere2FOGe2qg4SgU/cv2BvhvIxttRpeuX/Kr2g20/39l07Al2smxE97iA1HFtgPoQmd3TyvaOs5vn2OLafBNDYHbwxSlhUZIW8xS6t2uBknjJmDgU7d/wftzg=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:1Zl3z0v4br1E8U1LrJlPT4RQXWlhWi8oXmVVR9KQI2bMa+o4MtKqN8r2MYYwAh7hISu+w2sNZyNqXIYxRW+BvDAhrIogT2yWGDMZPr75hr38eRkDDS83Yw/yhVrtZbR9El+lCk5VLY55vK6zfK10V7wsa2drEplAfIoA7yJE4rayUHZ7PkadGrCgPYGWUSTo5LRaXPhxITFJOuVwDLjtD8Ffv9Jl4rFcoyVuZK1iPnonNe0G3wRZQ26tyIbCjvsUi4D09gHK80/+0ONgrbhfkELpb68nYnj9Qk3zX2XUKQqkPi6F+bfYk2C/vZr7ITcagRn9OVcncCmoI6DVFdJWjv1jX4Ppfp/qRL9rQRI2C8Ul63XgMhnd/azNt/OCqYvAFm4qC+G/tQu+uBUHTO2GOq7RFYdw02FHE6kchBDlxt2VeH66wCIN+M3qBzzBtmdrL8uaXOmxvj3jaDMxDNhf1A==;5:JCxpYLIfJL105hdf/SQQvGNQ8U2XiWG3zQCFGOBeUUmjk6+uyrI2U5EnUUBqZxZT0S9wY5fdS3kh96r+Zk0K5YJyAorimH7dmNbzHxF9PV3UwgWaxcTEsbqkBy2/Y7rKV5xN4Ma1M5acxwv4loDlkOZN58eNVSeHklyIKj/RFWc=;7:MWjdqViwcn8lEXPgmAU0PzaRYPk2isci08KyTzOKXdiWaMskvHkMf67w0OQEZjA/rIzOFkkFl4u2ET/9a8fWfR//7BWxM3mF7ZdzGTG+1MVfQ98B+vPbEu8eunJ9/2fBk4d4Qnn8XG43wtycKcNjhKo48AY+sflsao2OikW/8jAw4qMuC8vl+yPGIBuYR99rui7GXC5PfG8IdMwy+qXidqVzGXrOvIDUQJYhaywwBO8pAx48dA+aF1rdq3VI3FgU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 07:37:29.6240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40cad94-efb0-495c-216a-08d632711002
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 14.10.2018 18:46, Mathieu Desnoyers wrote:
> Hi Michal,
> 
> I notice the following commit went into 4.18:
> 
> commit 54b0a2011dfcd2e3fe2c28062694fbbe3eb377a3
> Author: Michal Simek <michal.simek@xilinx.com>
> Date:   Thu Jun 14 08:24:39 2018 +0200
> 
>     microblaze: Add new syscalls io_pgetevents and rseq
>     
>     Wire up new syscalls io_pgetevents and rseq.
>     
>     Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> It adds the rseq system call to the microblaze syscall list, but
> does not add the required hooks in the architecture code, nor does
> it select HAVE_RSEQ. So effectively, even though sys_rseq is reserved
> on microblaze, it currently always returns ENOSYS.
> 
> Is your intent to simply reserve the system call number, or to
> also get rseq to work on microblaze ?

Yes. my indentation is allocate syscall numbers for all these new
syscalls because it takes some time when new syscalls numbers are
propagated to toolchain builds.
I can't see a problem if ENOSYS is returned because it is proper
reaction when syscall is not implemented.

Thanks,
Michal
