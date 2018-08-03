Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE642172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4Dkn0AcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE642172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeHCIJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:09:37 -0400
Received: from mail-by2nam03on0042.outbound.protection.outlook.com ([104.47.42.42]:27189
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbeHCIJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3xhneE+4OUvkjDi948LLgZEjsTX5bqVATwl2AJSWx8=;
 b=4Dkn0AcYQMRErygfbXzwv2nuoEzzehyvaaOqcI6irUhPjA0Tu317phO3bysxRRANPOtWoX6AqLrBE5lX4KeI22ThXx7j+rNw8cICTdWipYUN3K7A9rAPEHQ1rA4xXt/DRRiojWPfUhiS051zRG1O8WqxmmT6rbplI4eDjXj8BLQ=
Received: from SN4PR0201CA0038.namprd02.prod.outlook.com
 (2603:10b6:803:2e::24) by BL0PR02MB4324.namprd02.prod.outlook.com
 (2603:10b6:208:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 06:14:49 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0038.outlook.office365.com
 (2603:10b6:803:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 06:14:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 06:14:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49155 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1flTMH-0007tD-K6; Thu, 02 Aug 2018 23:14:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1flTMC-0001pH-Gf; Thu, 02 Aug 2018 23:14:36 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1flTM8-0001o9-Bm; Thu, 02 Aug 2018 23:14:32 -0700
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
 <e5448935-770a-5c14-438c-23a652b17822@xilinx.com>
 <153324358299.10763.8724416723915219268@swboyd.mtv.corp.google.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d153598d-8d09-fb32-f68e-6fc4975eb9ce@xilinx.com>
Date:   Fri, 3 Aug 2018 08:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153324358299.10763.8724416723915219268@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(9786002)(39060400002)(53546011)(6246003)(316002)(8936002)(106002)(7416002)(23676004)(54906003)(110136005)(65826007)(58126008)(5660300001)(36756003)(2486003)(76176011)(64126003)(6666003)(31686004)(336012)(426003)(2870700001)(305945005)(2906002)(65956001)(65806001)(63266004)(106466001)(966005)(50466002)(478600001)(6306002)(356003)(2616005)(476003)(11346002)(446003)(486006)(126002)(44832011)(2201001)(2501003)(4326008)(26005)(77096007)(47776003)(93886005)(186003)(81156014)(81166006)(8676002)(31696002)(229853002)(36386004)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT006;1:CxpWg7bwTCTteGzAyWE7FB8seL4B1CRJWn/6m/+wy7oN0FMddfCR156TMn1h0EZSehha3SkkebGigyoMIeWd0DDqvpEjNUhYR02/tDU9WxApp3eg88mgwfkVKwmL8SEP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d709149-6b1b-46a5-81e4-08d5f9086aa1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:erUl1tuxonT3qYyMUMeve/wFS00tOdsz+YZ3PLtEnQrAPhSQTijGT3m1pB2QiGFc9QN/E15s0h/NFEwbwN2v8U83rpYrR3Ol2DW1VMFaPUoCOGDriofg32yLehq4in8XKOiMZhPEVRS4J6UXhM5zENoRQBRMhV7hMDEM6OYf+9uihbziNZrKS+EQjX+1B5AFJYqIPjFa9EuyizJZ0u0TRGHVrdQ422jmfCBRBJKPh/fyS6jrRpGe80FfRwWwMM1uBu3PNF/fo4FH25kzF0ymL2nbp4G3JE2iAumCqy2RQ+91jJKZXis4gmnLq7WKBdEuKBl5ecGTXr9eLTO8yNiD5FmmBtDSbmEcIjx0ugBD4KQ=;25:ENet8w/wHU0EzNFbs7D+CyYZeZq6IrOt74ovz2f9Cm915FoSCw095zLcTtMa65k05G3zRO/g/8MiJ3uyiCjlEtcFT0aau8M70EX5BhUgWOpHJT9XN1V1IhOVVY5q8r6I3ZLKEyG1Uj35u1J2pAZAunTkCNq7ySyXlRDgVsESNsdHGo03iQdnEMLYQQ1NpZAyrgo0VLY6VSTY7p6Jj78rDx/7MFFm9gqQz+crOrjgkFW8saSu6aDcORnRzAA+lSm89XUyyxMcSJ0mpcKqAq/PRvo0M5TJRUbnC52Mzasn+XFUD/5ZBkFArBJ3oPLLCDIhSwmaonWD3UkO3ByYgPLwiA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:xO+iwU8WyCRY/y226/UzQrFsY5p+Gm8b4TuDboILQZu0PM7Pg2bbMkC8peRjwE38bV51YXB+ImKDSu+f+yGMaSJD0OHeNjGXsBLEdB+7DRdgYTeCKNI4Fw51mKtSVF48/yKV5y86VDGVhbyozrFt/rjkUXppyDEs7XqsGbwI5n0UzLxqfFAn8zzQU+a5BWDLOGDfssq2aXwE/ykOhzoha1L20gUK2u/JoQUlm7SSTtg=;20:BfGyiSWrPky134QFN7RZXct9nWJs/I44H9IftyZOH7F1iJxR57tIMQdBDUYpo7dre01cH+V6jTOMipPJYXN7RBaPbEuWx4eWjNdNUy7yKpIf6BmPP1IbEj5uodN+OHpE+T5hUhVTR2kRWQvOYz7NyWtBuHStkqbKeQDg6GRY1BulQ2SBWQHzQRVFqPjxof9dW2hMTHBCGT6Fj542vwL+sRN2XgZVwEWOAgQel1tSgZdpzD83j5xh8acl1O2oYzas9lhJg1T2OMP5q7q5yEzjBsEpQvjGgw3tXXO0AxtT4X02CqsE++4/q9odLA5e0XTYX5qyLclcM3aO3sV01cwCVZBeWgIu8yE3BnLrJT7Ndk67Pl/j5yFSrNydQPmDj4fhCdGjw9sD0IMytwpFszOp/QQLktjq+eRhTwOKJpVQ4wD5iikBdDzTyw0ekwtqRApszAywr9uhGArP3IYjrLfb0arQYkMRxpZ7TPx0hA2iG7/G4Hd7xipmWJeqtwTb+Pvh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4324AA7A474CC7A5907C6D65C6230@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:1HolWz9tQi98MRamWIFLmhmrkOBHIYP6uulPyoPxo7OXsMcpTiqA1mZz4xJe8LsrS97RFL6et3i2B9Ag8rbQHQBMcfd+TZIsTfCYnbYuqJfTggPqACi98O4FwjQErNlvB9uUFfWDFI00vHSOkCUw65nbqjK0Sm1I9lnzONytN5fkYckO5p/MSntNhzgsyWx+cbx6Qa7U8AtlEtMgX5RCZwqVfcgD8lf5trTNOEKhSY4BTRmAig5Sf30SUeZhvJLOdykVUw1Uj2oaxg7q89mTUXywCBQ14u2MMEN/peFCfiGyd82cJCJfwIwwf2e3E4Kq
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0MzI0OzIzOnJFNFVZeFI5dUVnMEtuNUE5YTBJSjdpWURj?=
 =?utf-8?B?VmoxT3Z2ZmNFOFFueGxXS0crSVByTUNtWXJ4MHBKRk04bTd0b3RYNHJ1Ym9s?=
 =?utf-8?B?cVMvOHhsU2hWaFIvVHVsODd0OUcrR1lkQkRBU0QzZjdNcHdZbHFhRnRHMVlH?=
 =?utf-8?B?WG1vS3lnTFRFWWM0N1hqdzVnRlVWdEJPNFlkYkErNzRPNURKaGxhWWliR0pQ?=
 =?utf-8?B?OU9LS1hndEVqbm1IdnR5OGtyTDRSNGZwVGFsSjVjTWtqZGROWlpId0hPRVJ5?=
 =?utf-8?B?TlMxdEZsZVBnVUNQbVQ5NTBsckhIaExFZ1V1WlJQVVZNUmRoSlNJM29Ecmhl?=
 =?utf-8?B?aHQyWDV1cGlkTVdFMHRJQWZVS1lkMWJXRExtYWlNM0Nub21JWVM2Z2xmZzYx?=
 =?utf-8?B?Ukl0WkRtc1VhYW1LMy9qNXdrd044c3YrbGJGTTMveTA2NGpjK0I5M1pFck5v?=
 =?utf-8?B?SDNyRDdlTDQ5a2RKMkR5S2ZzeU1oZEc4TktOM0Qzdk5wQnN2Q29iR3JqQ0Jl?=
 =?utf-8?B?alphYkZESlZLUFhmYTF3aFlTRnVJWHMwa2lxTGJqY3hMc29vVG5waVVVMFZq?=
 =?utf-8?B?b3IvTDIxR0ZsNkpHVUovTEhNOXBITGRhd2xLbVNpY1RJL2JjcVI5dFViQkVR?=
 =?utf-8?B?WlJUa0JpMjN5dWZsbDVOSjJXd1Z6TWM1eURGZllrL1dDeEFSbUFKY3ZGWUlP?=
 =?utf-8?B?R1NnYTdMWWlvYlpuN25TeWgySUdmVklIbTNYdXRoVHU2NUk0c1pjU3paeUhy?=
 =?utf-8?B?S2dLNnIzNGJvbHNvd2gvdFRNcHlyVmk2alIycnV2cDVWZjhWb096dmFsdnlj?=
 =?utf-8?B?ekk4azVWV2tXS2JCZmZGZGhycnVCOGlZTnI5UXl6VndYV0hFVzV1bXFSOGdD?=
 =?utf-8?B?V1dIQmNuUVVvb1gyckdoZUYxdzlNdFdDNGl3QUpYeThQVFB0bmNhSmZDbXFl?=
 =?utf-8?B?RXJYVDFEcDA0TXRlZE5nYzZyS3g2NVY3YS91WnExS2loUG8yNkxEN2I4dkE4?=
 =?utf-8?B?YTVONEhBNE52VzM4SnlMN2tTaVl5dDhnQ2djb0xXYjNIMHlIdSs3MGM5azVl?=
 =?utf-8?B?K3R4dE5MbTk4MEk0R05ESGJ5c0pUWjNPMGxMb3MvNUxNMTMwTi8rdXVQbFJ0?=
 =?utf-8?B?S2xNZ3Y0MTZIbVVyTjJlNkloMHowcnMrSXlsRHFRVjlvSTdVTk5nYk8xQmV6?=
 =?utf-8?B?dWJJU2lSc216a1EyUG5yOGt3UEZJUW1CemVnQWhvcSs0V3VqQk01eW5XOUQ5?=
 =?utf-8?B?NzBGYnRlOUQxcmlydlZ3ZXpuSllLcCtiQjczV3pRUHZ0dFFUQUlnenQyYzFZ?=
 =?utf-8?B?dlgxTnhuZE00YW02OWR1Nm1pV1dVd2FPT2JUZmttQWUvbVU5VGRiVkNrbWFj?=
 =?utf-8?B?UmdqRG52djNxRU54bmZIQ3VLZDVrcEM5bDB3MStmUUo1elB1aThDTjlxQUVH?=
 =?utf-8?B?MVFZS3JzV2w0ak80UlM0VGlrVnAyeE5Gc3NVYktVKzJZY1NsU21EQVYwdEV3?=
 =?utf-8?B?ajdUQkJ1ZjhFTVdscEM3b0pZWXUyQm9lMVBiTnFlU2FyNW9janQxcmtUb2lU?=
 =?utf-8?B?YjhpN2lVS1dQSlgxQ2lzcHFrdDVWcnFPem8raHRxMXNmczI4WkxqZ1JnWXlJ?=
 =?utf-8?B?dHVDT003QVM2bWNkcmVtRS9nay95azdCZW1tUDdCMU01MUZWNldRdktXd1Vr?=
 =?utf-8?B?SUlxaGxCWk1GRytaU1NEU3hxYkhGVi9QVEJVUzlhKzRxbjgyMG9ZYkRkTzAx?=
 =?utf-8?B?Zk9lMDNlOVpjVDdVeDFEVm1jK1hkR0NOWitXaHRhN1lpdVNxRnJEZTBTeDJG?=
 =?utf-8?B?Nzk3MTNRMVVvdDdCU2lodVAxQzN6STNaOTNxTjlWaGloYnNqVjRlOTJZTFJa?=
 =?utf-8?B?aDZMeFB3Y0RVR2pMMFZKN2RyeFltcVdQNVFSQ1V5ZGk2YTZUajZxLzE1dlNC?=
 =?utf-8?B?VzNyRXhEakRJUlNuT3h4U0x1cG5VcHZnZ0hUb0UwbUQ1MHRkQlV0TkNab1VW?=
 =?utf-8?B?MkdhcWNZNGZJUzRTK3hJdytONWxwa0xCNnVoQT09?=
X-Microsoft-Antispam-Message-Info: YxPYTmB1fRrXtowZ8USOdR0v2andhdh4bmnkS0QvJVzrboCeyADnqw3j1cFKJGz1bNVfMscpSqwdD2eVWm1ORbT5nShTfDAwuo6DAIWQCRwR+5IK8UBus4CZO6gkmSiXkLBI2TGgck3olZQ3EUuS+mk/wd6kyNT3+6Fk4kIkbl8+0VEJvRbc5e5jWfmj4MZwVA58zb40Zc1HTrswDBIPeF3JKt3QMLEowS/Pyr2QZZ5B5zInmR9NATqORxdEtlGruWi9qeXZ9YXIXonfArm/4AMdiid+X8233fxe4BmoHjBQkQic40TfNB1RsWOWwY/GgJmvP5tXEi1fg11tKwB23XIJM//XGFtX8PZCPwzFU2I=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:a9k8qBlSlEhi3B+X2ZTuA4+VunHJM4SIRxeN7053/Ou+1nW+LzKhPjLCMcuitkJJmYBVnrgGzlFe67wlrQvmIdDwnxWP7N2yikC2z8O3uGjecNFUEUokJCvzhSh5MzCn32IFoptQZTjZXCVbpRd3IDYetYf2/xoDtem8nfThEKMUqJrsLPulq44UQfVwh52CHShvVEMlpJBeUObgiq2JJBlT7bSU9c0wXMRJ2rVAxOmmGJshFVHaOBDLxNCnx1rkvGES2W9g6w0vtA5hrPJA7sLo2xRIxqdFyCBE8/w8YQdNAmKDr7WnhP4a84HvQLhnYlIjKZc8OY3uJCTqnbC7YyEdZJyPMJLMWBWgQJJ5/T6aIBr8zwzN2aZiiadiHZUZ8DJx3seYi7fK7ZuQukvMCksJkHSVK8dieZwmdxAHeIWJWEzB9nrAOjmjYDLWGhnAvzKrLw/pbDikNDybhOgunA==;5:5ViQTAsTUEw88k4m2a1NWj1nBiMdiJozksg1CPdiKD9pVUWuSps7pSQmjBz6EcDC12ZRZwPwmVXI4R48H6cceb1wjUKMlJOPA9eFSwp6vpIs9Tu9WF3VV9m6tkmrvkcSelbldM3/40JsME918+XBDVnyI7sx0SIlt7UYiJJrYpI=;7:uZ+QiORJ44QMabk2uxOS71oJeuklIAT/BgNYKjM6zym94aBW/d6gnAGj/pflyCq/KCX0v4zCop1wMDr5bQZFIxe/u9sALjsrxK8R7paj2tqfO/maMZERBYs3lGOVQ6VfemZ/Jdv9ycTE4Weygtsl9Qtf0bPUssZ7drQinT3fSodMgUAPekWmChyytHoYGugzBom01CmyId2kgeHPYOBnec4T1CtvDnvBQAL4qZJvPozDoJgSfEWP4aAlhzNK+9mQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 06:14:42.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d709149-6b1b-46a5-81e4-08d5f9086aa1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.8.2018 22:59, Stephen Boyd wrote:
> Quoting Michal Simek (2018-07-30 05:50:42)
>> On 26.7.2018 18:36, Stephen Boyd wrote:
>>> Quoting Michal Simek (2018-07-25 02:51:14)
>>>> On 24.7.2018 20:14, Jolly Shah wrote:
>>>>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
>>>>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode
>>>>>>> 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
>>>>>>>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
>>>>>>>
>>>>>>
>>>>>> It looks pretty calm over the last several series that's why when I get an answer
>>>>>> from Stephen or Mike I will take this series via my tree and arm-soc tree.
>>>>>>
>>>>>> I have applied 01-08 here
>>>>>>  https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
>>>>>>
>>>>>> Thanks,
>>>>>> Michal
>>>>>
>>>>>
>>>>> Thanks for merging the patches. 
>>>>> By mistake I added “Reviewed-by: Stephen Boyd sboyd@kernel.org” for firmware bindings (Patch01).  Stephen had reviewed clock bindings only.  Please suggest if I should send a new version with that fix.
>>>>
>>>> I have fixed that in my branch and I have asked Shephen to look at clk
>>>> over chat.
>>>>
>>>
>>> I have some unresolved review comments on v9. I'll give reviewed-by when
>>> that discussion is resolved.
>>
>> ok. Do you want to take them via clk tree or via arm-soc tree?
>>
> 
> I'm fine for the clk patch to go via arm-soc if that makes it easier.
> 

ok. Great.
Jolly: Please address all Stephen's comments that we can move.

Thanks,
Michal
