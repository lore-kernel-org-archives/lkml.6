Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00F4C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F19E20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="33knP4GP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F19E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGN3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:29:40 -0500
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:4992
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeLGN3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoTUTvlnlSxORwA/WN6jBPN8BVYNGnh2CroKwmT8pvo=;
 b=33knP4GPd0uZbixqJ69wkI2lczuIQLFl/eSFJoAIdtEpwTm+zJii574dZB3Z57caOZ/DPwob1Si2ZQNJrG6Mz13prA3aEMuSC0Swp7IEUbYYfma91VKHDbzeTxsR6o9AtP7SpVSWlnSlLAmkITxzztPH9Kq8baJjGhTfyo2s8to=
Received: from SN6PR02CA0020.namprd02.prod.outlook.com (2603:10b6:805:a2::33)
 by DM6PR02MB4329.namprd02.prod.outlook.com (2603:10b6:5:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.22; Fri, 7 Dec
 2018 13:29:35 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by SN6PR02CA0020.outlook.office365.com
 (2603:10b6:805:a2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.20 via Frontend
 Transport; Fri, 7 Dec 2018 13:29:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Fri, 7 Dec 2018 13:29:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53823 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gVGCB-0003BY-I7; Fri, 07 Dec 2018 05:29:31 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gVGC6-0004MP-Eb; Fri, 07 Dec 2018 05:29:26 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB7DTHNl012142;
        Fri, 7 Dec 2018 05:29:17 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gVGBx-0004L5-12; Fri, 07 Dec 2018 05:29:17 -0800
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot
 images
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <monstr@monstr.eu>
CC:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <19c7bdab-8df8-f7c6-7921-9a4d43dbca64@monstr.eu>
 <CAK7LNATWSNqZ8uE+teMW+uvDCLXfq6zMTqh_7=ssrPquCLJz8A@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <938f1368-5e07-0178-5b99-d8331ce216f8@xilinx.com>
Date:   Fri, 7 Dec 2018 14:29:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATWSNqZ8uE+teMW+uvDCLXfq6zMTqh_7=ssrPquCLJz8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(189003)(199004)(8676002)(106466001)(305945005)(64126003)(9786002)(65806001)(47776003)(356004)(31686004)(65956001)(6666004)(110136005)(77096007)(81156014)(8936002)(54906003)(230700001)(50466002)(186003)(2486003)(23676004)(478600001)(81166006)(36756003)(6246003)(26005)(76176011)(31696002)(126002)(2906002)(36386004)(316002)(229853002)(426003)(53546011)(446003)(5660300001)(63266004)(58126008)(336012)(44832011)(106002)(107886003)(65826007)(4326008)(2616005)(486006)(476003)(11346002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4329;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT053;1:PMcVwF2uPJcd38DWklNXEhFT0gzWNv8qj+pqSrZqDOjwRVVDIk9ELU81EnSKWP2y/2hFtd4hp7FAug9ODU7DFauwLLsWNLiPR/AEjeZviDM46F5dAZ79bc48BmzcYkkH
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b758c8d-ef94-4ffb-cedb-08d65c480749
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;3:S4Emoa+73QlYlz1w46rnqSXvJIXquj5/mm+kdk7A1dRDGOpCS9ToJtjEWx3fMgselKj6lBB0QaxxByPJQCnAeoiVF76AXqpZpemVA82avAAsx0ssk3YTWNLmFgPbo+mzIbrkARsskh8OHk7uvhAn9N8s/wc4KGRKi3ImUVkYTM6ZtOcCsY/jB97HbpksXYmLfOOcTIriysVJxbqK2Z/vNUlfIxbAOXKDllmkQKqFevlKxml7krbkZ5beh3hdXZew8VpOekJMQrgtn6q7QWA/oEuMHjWk7jysRcjKs+r+ndiEuQLEYfwv12pZGV0qxAH+H62DthZq/86bn966DmgJZvTDxWZLvPBZ+h5sKrrtc/o=;25:BWmBj+fNX/fKyG0ypZYsP09aftEJeeVWwfl80Hl+n12ssuG6Epbm5zigGzN7tNNHwBy88hbibZ5xwCuYSbB4QenlnyNRuvnGWZ0QJD846I3bYKTCE+47wnYGb7OBUzPEzp4KRsIJGJlvmuHIvsAnHWgOIsJe6Rnm9WQBovS/I9lIROgClMHgWbe44jEDYe7ByJ2bHDjhTCnfQmfl96DnnusjOlA7AE47AD6lEpXMI4h6RfVNoctrLWbCuOlZS1BuWaG8ZyHBr68ihHibNccgT8lVYGCcq7gS1KMXtWGqunmcmv+tkUnVHPDb1xp4jBgAMA5o4igtAx/y/zvHiHtiaQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4329:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;31:aZyKyRx4fV+6jHfozSa9EohM3DYbL9mMVIt64h2wo70Hc8is+N5+9LJqcUgYmmb5aifDahaRzlwZLQ34Uy+taMUHTIwXwFzgR0Fxrla4vSz0daUxL5jYbzduj3ygQOYnq9IVBa/UP7ue26/wSYZYEHy96CdMhdQjnynFiV1sYV0kj/C22e2wqMwKSDFTchYP3jMXJ6+eIrN7clsOsU+OmrBW6eAdA0WRebhowhHWN5I=;20:t+crQlnDJbs/3PHI7kveUHcATGZr0RQUY5E/vLzwAeM7F1URoJKVwKuPlvzTNpJUsVpdnWqICkFNIZOC7twXu4/nqOLLiPh4EldN6Ft7tnHWeUgS390UoYgJRtDdRddaYAfA+TbOfVLa2MsllcRjlwSfgIQEN6CBc2PfnkgahkRBzjGXDHkUveV5ZWpHQGZ6SX2hOWrBVD350PkZSemHKuEM9rPlD3O5w+KswqahEXn5xTda2jZOHYIB/kSFfVrN5NM78qKy6VxP87zROWVGgTRzGQ75xL55HoctWfyOz+OQr43h/+odQ+BSuErJr3AGqgHeaW1e+ekbJGj2Nwbjd1fGSLk9sU8dXCyyCz2g1y4EGTVvwF1QnFaByjCTfeHfdbTh0Yaz24KDtVJdPF4yz5qYs68Y5PYY6xPZ1ds8oKaJwWW5zo1HL1lDWtaYpGPlszKEzQZMMad7DyPgSbgar8OR+lPaDOIeMYAw3BpDQe5sdGHihRSLvncXtDYlZoa9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB432974ADC456E37F9DCA0F58C6AA0@DM6PR02MB4329.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4329;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;4:buvtkN8jQoJ8ZPv/japWy6GGufhTGT/TJY2Jvlkcndbc3aqRNLk+PKITixnlIomjgr6xtL4DPLGtXSKlkELwh1BJL6Ob/HMkuLOoF9XVB9FtbTlXVf29ZVoShayOYTZedhbRSXhFSjm+RAYqWI4WyttD+Xo47jEKNAylCtRa6zKfmqL3a8Esg36oyE7gK1k8wQckehOCSJNf89qbOUt8133d90X+91aM2Nsa/zhlcNTNspANhCJXY36FnPrUhYLMEydAmv2ff80kBB5dY2/DpA==
X-Forefront-PRVS: 0879599414
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0MzI5OzIzOlduazREMzlVb1hZU1hna1dDKzVtbDRKQlBB?=
 =?utf-8?B?cTNBRXlzUTlYWkFKcytwSWpJTjZtQUc1WEFmS25kZDZxRmZLSy96QURhYjlu?=
 =?utf-8?B?RlVQaDkvV2E2RTZoNGcxbW42aStoT1BTYWI2bHBjOGFNOHJZMWJLbHE0MWli?=
 =?utf-8?B?UDYzWjRjeGQ2Q2FSbk56emJlMFovOFlXTzBaTjBqMUhvTytUWXdPWU5QMTQ4?=
 =?utf-8?B?NURXV21yOHlveDhBclNEMzN4VXoySVBaRUd5Qkpuc1pQeEgrSWFXbTdzKytI?=
 =?utf-8?B?VXJBNUNtKy9TVTRuMFh5UXVuNHlSYnRiMS8xd2hNK0dYT0dzUm53MHBXNVFo?=
 =?utf-8?B?RGUyT0lsNGI1K1VRclUyc2pHRlFwTmR1dXduWkE3YXhGOEw0UGRtNmU1eWEr?=
 =?utf-8?B?d215LzRkcHBDQU1IdDFvUFpVQjJiVWNnKzVIVlp6bmZEbUlROUN3ZGNFK2xa?=
 =?utf-8?B?TW1sOEpOSS9ZaGJxUEFpZGY2UFRlQVBsdnJOVWRIKzgrWnJVSmFaMWJuajF5?=
 =?utf-8?B?UysvN0YzZ0VwS1pkNFdKVHY4cHVJWEdNSkpjdThEdmNTSjdORWh5cDdYT0lV?=
 =?utf-8?B?c25RT1kwaHJIV1EwZFhmeU5WWFZwRTdxV2VWSkVONXpmcWtEaFJLb3gxWXFk?=
 =?utf-8?B?VDNlNGpOTlVUUGhHamE0dFpIZFpuRk5EYjBveEFDc3Q1ZlV4eVYvZXlUUHo1?=
 =?utf-8?B?R20xdkZDSE9DWEY0VzUzaFo0d2kwTEtGVnNBMW5MVjB6dm1TdUhJWjNuR0hq?=
 =?utf-8?B?SlRiR3RvQ29jWXZEdWV1VWtCNy9PcTNzaFM4NzAzTzVYMC9OUUZpZmU2Mi84?=
 =?utf-8?B?Rk91K01NY0xzampNRjN4NXplWVA2L1pnLzdmODRuU2xpSkMrS0dRQ3JyVEgw?=
 =?utf-8?B?anRGRkxXUjBuMm54OVpFMEtmeG9pLzhaOXByczFyZnZ1d0Zkdll2VytKZkg2?=
 =?utf-8?B?L2RCL3BrUXFOVG5FaEw5VWJKME1CMEFiUzRVZzcrMXB5dk91MmVhM0FTYVRC?=
 =?utf-8?B?V2hjc3BVeUc3L1o0UlBiWjhsRVBOdk1xQnM1cmxUNjQ4YWRZTmVSeVlnNk9x?=
 =?utf-8?B?SEJOamJzK003N0ZYR2paQmwwaTJzU2FhWFBobnA1Uis5QVhMS2ZSZkxUdHZW?=
 =?utf-8?B?dXZYU3dyOUE1bllUY2w3dGw1dFlOUWNZMXhvTHdZTy9OVjIvWjJId25LWHdC?=
 =?utf-8?B?K3VTRkhPK0RsMUdDZ3NJWE9IV2pjNmNCRk50ZFhJUmpna0xUTUhOMnE1Qlky?=
 =?utf-8?B?NWNvL1lib3kwWmQyZ3ZGcXg1NVYzMkw1dHUvYXpnMkJUNGNaUUd6TC9KTk5X?=
 =?utf-8?B?NFJxcFU4aEpmalB0bmV2NUVqWG5QRjBWdXBzeHJ1d20xYmxXc0VIR21ZY2xP?=
 =?utf-8?B?cUVDNGE1aVBOWXBtZnMrWFhEQzloZ3lNdUErdkpDbjBXc3V6RllvWXE5dVEy?=
 =?utf-8?B?M0lxV1NpMmIyM0IxUFh6K00wV1NPTTZQL2ZNWk9kRkpYa0xjOTdZTTUyRktj?=
 =?utf-8?B?c2hRMWJyTHUvZzhGUDQ3QTZ2V3IrMjhBYjhSNldpM2JkUEhnL2hJSEdFdnBL?=
 =?utf-8?B?cU1lTmMxQXQyWjdWYlVUblBYWlRvQ1BwRUhsS04wcjdLckxWUW5lVXBIWE5H?=
 =?utf-8?B?aUV4WEczZTRWbGNXRUMxT2F1Q0hFNDhlSEh5elFMcDNXZTFyMnR2RFFoSFRi?=
 =?utf-8?B?R3ZBdXl5b2d6MkoxeWxqV090NStJNlcweW9kT1c2TWlWdVdQaUovbWF6V2l3?=
 =?utf-8?Q?sfykomwciSpIlYvZ2mYKlwj9qXwp35O/Wi1K8=3D?=
X-Microsoft-Antispam-Message-Info: x+HV+hkMiewMk9x2MUhm92uNN12duoVZwP6Oh4bPH8PigAbit9PFuP//vO3zkyBBgoKeQuSpJbfRIa/eRPefCcPav0nkF4lWhC9nhRruxQUS6vgEva5CB4e3QEveYGttgknjwnS9DPEYoE5YJghkAK5GxaMzESNGgSUsL2EXjfhvkrqMqvHUf023CoDY90fH1mC2R9vpOUlxjVQBXPmPEhIbm1YuL8m3nOhDWl9ZpBe0D4kEtjUb/d/f9XZpsjr09RCwyuAvPKBfRul8z7FdYiptyLtqqx64T1h1RF/wRQzEDl1N9umTXJkvJEmqW4AvEwzxFKwkngIVyL33JfcIKQ2XbrsotcOKold6ziBlDlA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;6:Fxw6VF3gocoXOIELdy1ENsfkwJXPAbIzkjpJgoFlG7gU7xbh+GBXYbw7LqkoHteh2PaYtRgi54IcjLrVf+zViN8Ka1bN2yWqmnH/jkIwthgwtGzXenpBwygsAgA/wIGlW1QR8jMqiAHyHHMrjn+ysNOi7oNsPl8dbsROsSkhzcuKknLQpnQoDnHgawIQol7OOqlRKAXBp5g8evQ4wg5zYuO6W0zZzzIJdQg/7XfuvD+ZPGHBUWHb+kvbQEhPU3thSnjJSEsMlBn3jvxGyXmY5rCTmmFIvy0WSUH3BBqskVOFiIU/CjeOAsUVj5WHEmsj5+Fs75qkSrO+Wqz8yWkOCTj+ZXt+CJTrGiqa1m6Hp5GedGcj5GpEURhgpsg0Zy0N5XkFI3/r1RouZQNvKnLtowRXdy8WCrNJI+zpB/XZ3rOzXjrAze1ZdfodZnYmLzZbLzsFIa6GmOm8QEC1efS3UQ==;5:9WKZDlvYxsCAKDpVKGjSSDzC3fi5XzlWnkngSFDzTKMa6Ia/qphB74BciiFSAlAGuM1vW/BVyk9Yoi3purfEA5zjGuao4GtyDItrXrCB/lxUut0RhjEBnKYJCFwaY0CJNH1eUUbeUK2WJq68E1XGwx/Evdxoy9LWdI3l3j6Rgrc=;7:c6+yTuEDWSemI6S3lbMxXMgpxmE1GeDIfGmJRkl5IAkskqVBdbUAs/Vbqz5+Fn/F54bIt1YeDxCuxD2lVS+drl6Y4Flr+gciz1TnjOlFDU50EhD8LRyYIR3lIPgGqNhN9MFd72s1yRPuU+sJorr9cg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2018 13:29:32.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b758c8d-ef94-4ffb-cedb-08d65c480749
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 12. 18 12:29, Masahiro Yamada wrote:
> On Thu, Dec 6, 2018 at 11:55 PM Michal Simek <monstr@monstr.eu> wrote:
>>
>> On 03. 12. 18 8:50, Masahiro Yamada wrote:
>>> This patch set fixes various issues in microblaze Makefiles.
>>>
>>> BTW, "simpleImage.<dt>" works like a phony target to generate the
>>> following four images, where the first three are just aliases.
>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>:
>>>          identical to arch/microblaze/boot/linux.bin
>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
>>>          identical to vmlinux
>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>.ub:
>>>          identical to arch/microblaze/boot/linux.bin.ub
>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>.strip:
>>>          stripped vmlinux
>>>
>>> I am not sure how much useful those copies are,
>>> but, I tried my best to keep the same behavior.
>>>
>>> IMHO, I guess DTB=<dt> would be more sensible,
>>> but it is up to Michal.
>>>
>>>
>>>
>>> Masahiro Yamada (7):
>>>   microblaze: fix cleaning of boot images
>>>   microblaze: adjust the help to the real behavior
>>>   microblaze: move "... is ready" message to arch/microblaze/Makefile
>>>   microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
>>>   microblaze: add linux.bin* and simpleImage.* to PHONY
>>>   microblaze: fix race condition in building boot images
>>>   microblaze: remove the unneeded code just in case file copy fails
>>>
>>>  arch/microblaze/Makefile          | 14 +++++++++-----
>>>  arch/microblaze/boot/Makefile     | 33 +++++++++++++++++----------------
>>>  arch/microblaze/boot/dts/Makefile |  5 +----
>>>  3 files changed, 27 insertions(+), 25 deletions(-)
>>>
>>
>> One more thing I have in my mind for a while is that will be good to
>> configure kernel build flags from DT and completely get rid of these
>> symbols.
>>
>> XILINX_MICROBLAZE0_USE_MSR_INSTR
>> XILINX_MICROBLAZE0_USE_PCMP_INSTR
>> XILINX_MICROBLAZE0_USE_BARREL
>> XILINX_MICROBLAZE0_USE_DIV
>> XILINX_MICROBLAZE0_USE_HW_MUL
>> XILINX_MICROBLAZE0_USE_FPU
>>
>> It means setup CPUFLAGS based on extracting that values from DT that it
>> all the time match the hardware.
>> It will also simplify all the CPUFLAGS logic which is in
>> arch/microblaze/Makefile.
>>
>> Do you have any idea how this can be done?
> 
> 
> I have no idea.
> 
> Parsing DTS with sed or something would be possible, but ugly.
> 
> In my opinion, the kernel should be multi platform image,
> in other words, it is the least common denominator
> of supported platforms.
> 
> So, the kernel should enable all features that may or may not be used
> depending on platform.
> 
> I do not know if this works for MB.

Microblaze is soft core CPU where you can select if you want to have it
with multiplier, divider, barrel shifter, etc.
You can of course say that you don't have them and you have "universal"
kernel but very slow.
That's why user has to setup these configs which are converted to cflags
to say GCC what can be used.
And these configs can be simply parsed from dt.

For example like this based on dtb (quick hack)

for i in `echo use-msr-instr use-pcmp-instr use-barrel use-div
use-hw-mul use-fpu`; do
	UPPER=`echo $i | tr '-' '_' | tr '[a-z]' '[A-Z}'`
	echo $i $UPPER;

	VAR=`fdtget -t i $FILE/arch/microblaze/boot/dts/system.dtb /cpus/cpu@0/
xlnx,$i`
	FLAGS+="CONFIG_XILINX_MICROBLAZE0_${UPPER}=${VAR} "
done

make $FLAGS


When simpleImage is requested dt could be parsed to setup proper build
flags.

Thanks,
Michal
