Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DF520819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qjNtaBfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DF520819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbeKEW0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:26:18 -0500
Received: from mail-by2nam03on0066.outbound.protection.outlook.com ([104.47.42.66]:11040
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728870AbeKEW0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=floZONVztLBxxBmWzo6SAuQC/hhNbnTucMOuGTScehs=;
 b=qjNtaBfGKr90p+WYLk+hIyAT0Q8/0ApdI+Wg6LN6f0dlGJmoigEIAaWN2jC7vYtJV7o53YVMSyhYLUoPLkGsqFWIUvAjdjCi1cxEjkLYDq5Lhhqt7d4UaSObkvaQ9ThhNFialYWhXyw/O/8qbudc8jjGIcVkpN02vS1pKL7mr+g=
Received: from SN4PR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:803:20::14) by DM5PR0201MB3511.namprd02.prod.outlook.com
 (2603:10b6:4:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.23; Mon, 5 Nov
 2018 13:06:30 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by SN4PR0201CA0052.outlook.office365.com
 (2603:10b6:803:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Mon, 5 Nov 2018 13:06:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 5 Nov 2018 13:06:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJeaJ-0002zL-DR; Mon, 05 Nov 2018 05:06:27 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJeaE-0004dR-8v; Mon, 05 Nov 2018 05:06:22 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA5D6EBQ002671;
        Mon, 5 Nov 2018 05:06:15 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gJea6-0004bz-Jz; Mon, 05 Nov 2018 05:06:14 -0800
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
To:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
CC:     Manish Narani <manish.narani@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <mchehab@kernel.org>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
Date:   Mon, 5 Nov 2018 14:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105125644.GA7937@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(438002)(189003)(199004)(14444005)(4326008)(6246003)(31686004)(65826007)(186003)(26005)(77096007)(76176011)(336012)(2486003)(23676004)(2616005)(426003)(36386004)(476003)(126002)(63266004)(446003)(11346002)(36756003)(229853002)(305945005)(575784001)(106002)(356004)(31696002)(6666004)(47776003)(65956001)(65806001)(106466001)(7416002)(44832011)(486006)(8936002)(5660300001)(9786002)(54906003)(110136005)(58126008)(230700001)(2906002)(478600001)(50466002)(81166006)(81156014)(64126003)(316002)(8676002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT029;1:7NKAXyrtO8eyuNA014l9/sMnzzXaVXln7/Mi3VHMBCNlBmjRSG8ZnDmOvE8zOC5I2p2svke2etm13sppXzJbTZzF6PXKNaDnqrIshs2XY97zg2esmtlkm9tCHzwYrREB
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 263a6193-2960-48a3-b836-08d6431f7fd3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:PGGYGLKeqRn//u/hkAfp15KEtlW+hRUKSu4NfUHp+Ys2o983W2uOUQ889p5YD+ORik76x3IOk3OWaJJcrseZCM2TsF/a8HoMgMMpGcRED7UnARoENpj0AhiO96oUYolY503ln4uoKPkurord7+WpBepcuvGQCRcVswQLmvC/+DBldijZXPa+crxmEgH5WWmTC9A/eCSVv88ZHsD7lK29uqK1evvXSpH65+Q6ACKKEmRmzJYrGzvDN6OekHNjKfp5IFteao9yN145nNSCgTrVB/Ud33N+GRJgddYv0f0R/FnFKNcfLCSdB1cnIUEBk4wR6h7t9sMYSPCRUfwjC7Ysq3bfb59T4yxOmhPfnSTWWX8=;25:kSe8UWoaSyjnIdSCew9oeMOdQlx6hZ6Cb2kh/pYOd2CjChLA9D/LOxN1ySf5PzvYL6XfWBlOC9JsEVBmqPXKBvuYwGIYCWA9aZb0W1goF9S8xgIdsKuU94nk/BDIke7Rtd9yrob4YGI3QQLyAC9RV06suE6up73glIvmpiOqM0rudqDTo6fSCDkxiZwBraoBw1fsx+gpfx/nxK5bL+vjN82hmw07dEoj3NL/61lSYGVVacnDwipc4czXf15zpUIELrwjiU8ISO78WD7ewzioACsh8A+8F0NNektSksxBa5eLj/y+4TdicNs/TZp87L3PSK3rpsvkqqe9mwkwxo2PAA==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:Bj8nett/ukg2OlfaTK9Th6MLNvAoCZBSrjbm3exMBIaiU3mXvmDA0DcAiKdAFCBfoiw+B3kxxt51a8Av8+NwY2wwg+kT1vt4dQTdjLELKQru5bC5AQsRqOf91E1ffvbtibqB1YU10tbGTgyMnLJCjeueutVvoopAM/lE0OaV6FU+vso5y46D9LRgtz5Q5QchY4UKPBbPRnP+aqLnjBMAZUVIekc8M6hg/14mJFJU1aY=;20:sYIVP/6lstuWxrKYW//diFK6gqTyZCavq2wi/vobLvJ8Li5rp6zN80SJ3rHOUHU0J/sd6Zq2Juju5vCh4mfJ33tEz0uCll3NwYztrNrCslosAaUiHp3jfewSwta6XYZLXojaE0NWq1vbZx4175SDAJukgOlJkOtWOyKDCdAiW/VpgBn1QzwgJjrGv0TZJCXDGpG/36A7g+Nuwky6mRy8Ng6LuT+fnpIZdVzOFdVBqPeqZsAMLUy9gZx1+1W18eGpBK4Rg6ICU5GyYfeza5nCOlsRAfQIpVROZ3q1qNra60HTXNixp8xmLE1jNhp2RakSqD2VmwQ+KF8qvRyKTnohXYS2wkSfI9Gl9MFZfyCMyQf4GCDkgx3Vn5EoBH4BqcIGTrS8h/NsXoE1epMetHx2v/nQA3+3qZT6BOr58Pz9RN1terYMcaJ0OS5QLmrqODTl0MWoILfUyw3TUj1zolzsTMWlq55l6UWkkBZqNK/oeQ5/Sov1HYa94vkMSxmH/UME
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3511F55528167C043D588256C6CA0@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:+zJUGRaSwSuPG64frozpfxUbVFaXn/7UQUiPsRRKRfXf0M8aqYLP+zxGw9ZTd4C1QIBM6IChWQRTTmEzvUG2mKNQSXGwlUY5LBO3rEsumwe91Irs+NcpurW03N21K2B3ESOmC8GyD7oK/slXo2Y+OMCj4+h8QM/QZXZrzdJ0H0moSgrbQFFy2hty3bQ2U5VgBYCuUerM0W/RTJK+aBiK9pj4O4vfT1o3ZIV3EK4R47C/Cpz++vRHSugdv10yy80eVxU/DWYqWdSqqYvrVBq3GqdecWcGF2XBI2DKOESyJKG3BX/khB+m/rK4kEIs54Mq
X-Forefront-PRVS: 08476BC6EF
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyMDFNQjM1MTE7MjM6cnluV3gxYi9PU1JIUS9WSW9PakEwdklP?=
 =?utf-8?B?R1dYWm95QU9qcUI0N2JVMmRDV0hEQVl1TWU0TzlvSTAvWjlYRUExZHJwQXMr?=
 =?utf-8?B?UWdsS01wcWFRZzZHQVYrYXlUdCtOd0VjS0RwTlVubWw3cWpmNEU0SS85OFRO?=
 =?utf-8?B?Yml6TElOd2lPeTNWajczbWszbkpxaVVVSWdkcTFqZVp0VVJCRXFQVm9tNUpH?=
 =?utf-8?B?eGRLU1BJRDNNZUZGbzlpWlB4UE50VjV5cmxMNWtiV05KS1R5eHFqdmNCYXUx?=
 =?utf-8?B?Tm5PSjU1RWxRUUlSeEl3UE9wemZiVGZtVm45cGxsZkZGMFdCNGd6TnNTK1pa?=
 =?utf-8?B?emdyM3JYbXZ2ZXdESTNTdklSc3hDMllObzZwN2dUYkE4bllzMFVOZElsNGJt?=
 =?utf-8?B?TVNMcHA3dHhoK0dlVmxycE5OZllmSFlDRXViRGh1cmpFN3Q1NXdxY3BLVlFG?=
 =?utf-8?B?VFFHOVJsNEVjRnhNeDk2bmJEanZEVFoxemgyWWZMWENQZjFFK2d3aUVqZWdu?=
 =?utf-8?B?ZTB6MStaeU1MMnlvcHBXTW1ud0Y0L3RPQWVoWStlUlZOZFlrUXdvZytURTJv?=
 =?utf-8?B?OC9WemtuenFnRkpJV3ppRHVQYVZxTFVKK1N3aXBwZ1l3S211ZEM4ci9BWkVI?=
 =?utf-8?B?Z0dLbjFNN0g2ekxtTWRCY1N1U0NxbHVVb3JEY0E0QnpuWU1tTE1kLzVJVXJD?=
 =?utf-8?B?WG84cG9QVkNHSVNFUVhWeUg1T0hHOE9RVlVqRVlTQ3hRaUwyVTJzTm5PTTRk?=
 =?utf-8?B?aU9xMXp0OHhTa2NiemdnUG5HbDVoenRxalQ1NmVvbitWZGNleVQyNGlkLzBL?=
 =?utf-8?B?eEYzcmlTQlE4SFozR1Z3MGpRUTdSRnVQQXZ1MzQ4S0ZjWFJNZ2h2NGN1TUlj?=
 =?utf-8?B?TnhybTM2VXJkZklYdzZqWlplY1J4UTFFeEdFVmJtMzVzU3ZoYjBsaTFiWmIz?=
 =?utf-8?B?dzRjQTBwdzEzeDZ5N3BNSEw4bXJOUzFzLzFUZ2YvMW9oYmt6QnFaOTQ0ZEtk?=
 =?utf-8?B?RHVsUnBlekROQlMyaFFYYzJGWU5YOUNycXlMZVdnNW9HakVMMVFzZkhObEhy?=
 =?utf-8?B?UzhKU3dvR3JNUXhXNjNUS2ZhM3huTFZhZVlLeTJYekM3YVB6am5KU2R0a1ZD?=
 =?utf-8?B?VkJCZEJmRWJqK21DdUl3NTlhb2xKR1ZaZlNRYWtuRHF1eVVuRVdIZGFoZ2E0?=
 =?utf-8?B?SnBiWmEycEFLRnJqRHVyZVVKWjZSZkJMT1Znc3FKV1RQNlRDVmhPWW91bXBV?=
 =?utf-8?B?SkFoL1ptMGJheEp4L3pIQUU3ZDgrUU5RWENSRWtmR0E0YmdQQnUyWWxPZDRB?=
 =?utf-8?B?UnMwYno2UFZQOGxCVTZrTHBKYmFTZHQyVUwyaHlzM0pjaThzTXZiM3FpM1Uw?=
 =?utf-8?B?ZS9YaWwrVjBIT25XbVI5NjlPUk16UXJQL1RqYm93V1pUKytRNlYzbm9WZ21W?=
 =?utf-8?B?QklwUW1qcWRHZVI0a1d1MjRudTBSYXlEMjRKM3RtdkZyVDVuc1BHM1RLNWts?=
 =?utf-8?B?ZEVndGNZRERnTWF4TUY5akZEUWlFaEJZYUQ1QzZhcGVPc0hDUEtFWnMxZmhm?=
 =?utf-8?B?TUUwQzMxMjBrdU9tOCtpM0JNdU40aGpINDZwd1EvWnRlekRlMzZUM0xQRGtE?=
 =?utf-8?B?NnA3NXY2eG1sM2EwaXBUeDRJM1RjWlV1citPN2RHd1lQTGNWRnhsZ2dpWkd5?=
 =?utf-8?B?emhwc0NGRmF5WUR4WG5uOHgzT2pITnZjTC9lUCsxMUd6UjhLZUFUdUpjS0VT?=
 =?utf-8?Q?+uLjbcoNPNXuxx2u2bQj+pGCrdo6cDPCkyC+nyY=3D?=
X-Microsoft-Antispam-Message-Info: 4B/SaMjUqgK1WdD9XBctla3Rup3zTDjXCJI12zgVkXJ2S5g6xdcVXqTZyNz5hfXb08iyYp5+DwJq7q9fFHTI6FXw3aY6xSGUrQ9JlNXgDkY2tJWLXbooS30M0xfDB10N0u9ACGHtUkwbwB8OV6BN7QQxAnnhL/CVVzfSXti6VvniTXGQS0sMDBOyf4aoq1267qFUC0mmoF+WU6ILd+3+ORJc23aE2OlG6a2xq0XorHKE47TjQHNYSBCJ0HMajHx0cVrELSYH5FG8MiUitVrKLb/LSJtL/ZE3BYdgozv17PK8eJmKMBy6etKWJNP7JlqMrjK0BfNDg6ve54Upvkmyv0Kz3vijHv9/I9xnAY85epk=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:avrWqXdBg0D3XnCSIha7mDgHr0Q84+ReAvMfJK7o7ESmOo3akzAPaI/EKrNp9cSdFL1wqfSrKkf9kRNpc0PGojE3/1q2b/Dvo6n4FplRM4WRsQ4+rK27voXzY5plI1wGeEsQNq4sMeTxLKMD27gWxVYskJRhNe4oAPFyiNudO2cGHzEO/sWMhQDk368LmVWAoLT8IXum+PXf0EPx2w1UEbnqj9kIAA+qiS1ISpdGbKEcodIGayVSIjlC4LZ01+LgeZ6QiLD4wYScm2ckepfxIo3DilaHvR1ZVpSoe8VNEibJG2nqvmgOfZDWjBBymd9AsHoFmqk+ouFweWWbJ6Bm69DH24sGQ7x5dvr93omSXtJEsFlYHkfS1xm9srEHurwvI7EvReeqoILUyczjupo0/oviSLDpdOy49FCH+Lpd7ePmUztOcfVZ75oFP7DBMjn/euKympi6VatWmg4iCLBnJQ==;5:BmvnNbSR7JNr2eUKhZFgtqvgePjz3HeN+v9HozSDbkthD1lul9bYL3DwO3MembksRf19UL20l1O403sL/kUXZO9PGBHF+TkNpF8RqoBlmNfWG5JMOIwraceefPD/TQ46MVXAb7++j9Jz/tPsR82GLQNxGyERQLEHEX8PBz0BNwE=;7:BjwJII915UEdk1g/jxIS/pXTFdg8hMui2fJERDC4MUc3K3chERcn+6TZ2mnSHzNP0ZUzCBXb8ojsp4DZoM1L3M2993blcxIaDgHjJxqIFjIinCy4ApJxBIboACct7oOiLhzvTeI7NW+4na2d/Aw1Tw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2018 13:06:27.8382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263a6193-2960-48a3-b836-08d6431f7fd3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 05. 11. 18 13:56, Borislav Petkov wrote:
> On Thu, Oct 25, 2018 at 11:37:00AM +0530, Manish Narani wrote:
>> Add ddrc memory controller node in dts. The size mentioned in dts is
>> 0x30000, because we need to access DDR_QOS INTR registers located at
>> 0xFD090208 from this driver.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> ---
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 29ce234..a81d3b16 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -355,6 +355,13 @@
>>  			xlnx,bus-width = <64>;
>>  		};
>>  
>> +		mc: memory-controller@fd070000 {
>> +			compatible = "xlnx,zynqmp-ddrc-2.40a";
>> +			reg = <0x0 0xfd070000 0x0 0x30000>;
>> +			interrupt-parent = <&gic>;
>> +			interrupts = <0 112 4>;
>> +		};
>> +
>>  		gem0: ethernet@ff0b0000 {
>>  			compatible = "cdns,zynqmp-gem", "cdns,gem";
>>  			status = "disabled";
>> -- 
> 
> Ok, talking to Mark on IRC, he says those DT changes normally go through
> the arm-soc tree.
> 
> And I'm fine with that except if we do that, then the EDAC changes
> go through my tree and those drivers could end up temporarily broken
> depending on the merge order and timing.

I don't think that driver will be broken. You can build them, use them
on out of tree HW. And when this patch is merged to mainline it will be
enabled for xilinx soc.

> 
> So should we perhaps make an arm-soc shared, immutable branch which you
> guys export for me with those DT changes applied, which I can merge into
> my tree and apply the EDAC changes ontop.
> 
> This is what we've been doing with the tip tree until now and it has
> proven successful.
> 
> Thoughts?

Normally driver is merged via appropriate subsystem with DT binding doc
and enabled for the soc/platform later.
Also in connection to process which you have described above.
DT node should match binding which is in your tree and should go first
and then enabling for certain SoC on the top.

TBH I can't see any reason to do merges but if you want to do that way
we can also do it.

Thanks,
Michal


