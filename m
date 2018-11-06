Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B6CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45722081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Q6TpUgJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45722081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbeKFQMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:12:55 -0500
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com ([104.47.41.70]:33684
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387397AbeKFQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSFzNCMyeQUznMgHgAAtvQhVQ7702wriQJzRfiweF28=;
 b=Q6TpUgJA5QqXG39TWavzNgVVHCKsfv/UkkN63FoxdtKCuJMi3hnywXaWdX4g5vMwHVXgYmLleoP5vQxx1EsZiNBiCiYxp6w8/DZWn/bOwznXw7MJxNKrxQaW6F6UfvxjZ6CTCKvdUNMRgfrCwCbDYE6s+8yasZhUiS+D1H2vCOY=
Received: from MWHPR02CA0059.namprd02.prod.outlook.com (2603:10b6:301:60::48)
 by DM6PR02MB4458.namprd02.prod.outlook.com (2603:10b6:5:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Tue, 6 Nov
 2018 06:47:16 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR02CA0059.outlook.office365.com
 (2603:10b6:301:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21 via Frontend
 Transport; Tue, 6 Nov 2018 06:47:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Tue, 6 Nov 2018 06:47:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44524 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJv8s-00053Y-9M; Mon, 05 Nov 2018 22:47:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJv8n-0002gl-5q; Mon, 05 Nov 2018 22:47:09 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA66kxQo029409;
        Mon, 5 Nov 2018 22:46:59 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gJv8d-0002cx-B9; Mon, 05 Nov 2018 22:46:59 -0800
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
To:     Borislav Petkov <bp@alien8.de>, Olof Johansson <olof@lixom.net>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, <manish.narani@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
 <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
 <20181105194721.GB26868@zn.tnic>
 <CAOesGMjsPWeRZEeBH37uLQFBKwAWNMh5yCvuKNYrOUDfRSSYog@mail.gmail.com>
 <20181105204322.GE26868@zn.tnic>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <38dc38b6-25f4-194c-9ba9-577d35e92700@xilinx.com>
Date:   Tue, 6 Nov 2018 07:46:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105204322.GE26868@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(486006)(476003)(316002)(2616005)(4326008)(2906002)(7416002)(31686004)(54906003)(2486003)(356004)(6666004)(110136005)(58126008)(478600001)(426003)(336012)(93886005)(76176011)(11346002)(44832011)(126002)(446003)(23676004)(31696002)(966005)(47776003)(50466002)(65956001)(65806001)(229853002)(65826007)(81156014)(81166006)(9786002)(6246003)(8676002)(5660300001)(230700001)(106002)(6306002)(8936002)(36756003)(63266004)(36386004)(26005)(77096007)(106466001)(64126003)(186003)(305945005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4458;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT025;1:CuOpdoAlQw3N7bcKxMzxiqj7+sb5m86jZsPWhi7hrz0fJjFluvJuLgu7DOSgwJObeDpeRi8k0bj2sDhf/qRoFJpm0hJOZzoI5eT0QYQzFLqQX7vRrsAMYXP/pS1onik+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8543f367-eb46-4def-fb2f-08d643b3b00b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;3:cChXuoVRcQNTUCGGfYG8LECmn1bHc4luusF1M+JJ7ss0xY4KAN6wEnwVZo7zqpl8R07Kgzu17VUA29xb+i+fpnwlt+RlWnYMnu67ZmvfCGSH1ILCCUaAx1KdBcvrwb/Y4j/rojTWfKTX7KkwxWgoF5cCPTAlt/bC0I7XHxrwONR4otxiliiqibui7+/e85jESVL68m/SjMvK0HsW+QjWWLozmFiVwB9y++oWgOux37hk6n/lhzd9d9NRDXzQm5OchICukX4M8BTvY4iCC5WgPc+pqNdr6IOV3A4caoskOfXuAt83K7VqDsHc5wTmbEbb3WbqB5SGaXNko5sAPJZldN60OX8z17fvmkKOCN5+5QY=;25:AEsB+FPZrU9dTiBio0quFrA/IPILAa/lv/VgC0QrmPHj8q2r0mfnLRGDYl3FSGeO2YvkPz1fdl8NN0htYcWgPG5NEmY0kvPeyNugujXGh5xIlGN1Lhggv5vl2bPVU44Wp57XjggM3WF5fOxXcq5zk1FjfvbK6rXBkzBlpohoLcHi5KLBCs4Ib6gR5pwZqKu/rId/Nro/PM8l0IpOFmREbq3uZMiud57ecIYD6ZogYhDQFAEdxZJ2rH0G1/mmZgygU+rt4H2GaMJebcXSl8lPrMY8GazeTzliqqJQeCjHGehpcVP3gVCQ97I+8GyPJvzAlAZGmBxSJVO/gvZEo7NJSw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;31:JM/5fD1jCrofYZqU4etX41GqLf46he4LI/Xvl3E7oL/5Gc/NPEcxvfJN934hRcDt10I16Uauo49O7IxUV2vkS9N7Dz9RbXQjoMAZVPZU0fACTc5YkzIaslauB7wVQoSnamBgur6hGULVGepf6ZFu3KhmZvL/qZFwdJ5g1R74g/zyLaQGdiNc/YazU3jK6P2Pa/3OYWqvreVbRjge+XNpWXRI5XIRMDo1Xa9geJPMfKU=;20:Cs9zAQNSMJhp3UkB/sN1WJxaIIawcAKO7aUjbB76YI5I8ZztSTqoXE3CCSgVI5Snlk713v3301ZdiEZ4X947wbu2XpwFLf5zcizlXIdgIHx1xunbpyWpV8HdmJU/iWuuhdFzUEuz4gW2Q0M4ldIE1DEjaBdXDmzlGsPwiYNvjPjv8TpfLDQdvrzKSmF55k1uwycyPU7cQuMWxiM2VkzKHxIzBhaAYy1KoQyhq8Kh4O6ixQmZhMujJyMBJ7FDnq0AmXiV5bh9+MsYSnwnZ6CuCtGwUsXAa5pnlGIKd58hVoU8uP9Czz9SjFH0TDg+Gnl2cGaPWy+ZCXyTed+laixBbJ3Q0jAZ2SdDyjo4wp+TDl/5qHvOEvNTfIvxA4EQBWTrvYC5p7k6LouslOjyvB2owfXmIwIJ2w4WanAFuqvZykrHFsq+nBt+d4AqvGisgY0snlT/iczHRY/WC+14zSf9p5XW9kvYhW/Vsbi3qb+GdUu0jQIvJ09kr84PHRNhmrCn
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44581FB7491ED220BE34422FC6CB0@DM6PR02MB4458.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4458;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;4:P9EvN7KLMmoIFzYOiiZCjkEistUhRwkXLnxUgZJ8qq1JRStTgG/uCefLQS8ygFfGHJSx2lfSSgVeWrdi0OU3rrMRt8KKInGnq7/VBJZUIi3TL9nvJiEsYh657XiwuZxM7hyD7CVZbsz6zP+6EcnetgsrX9FZhak7RYuMmkvbX43Hze681qOOnuRJURRNAzsyntxREn0bYmp2FjZ44czWKsOyDx+9FCFaU+XIAiR+poebkf4hU3HfMQ/K32lwWJ8KyDtimiT9tY2D2vzjpJM9HnIGy30r7SrttWdYJY0KzMR1F1LIBdxOO0wpVmxLE3W/ndAOcgXi6FUdBqkg8fzgSOjhXpWGcbBD/wkDt7L97Dk=
X-Forefront-PRVS: 0848C1A6AA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0NDU4OzIzOmpRNHAwS0duc201M1ZUWG5VYXFCYlVwUFZs?=
 =?utf-8?B?L0hFM1RYMEY5dHZrVjhuTDE3QzZleUVXbEZkeFZGbWlZd0x0YVc4Y1BSUVA2?=
 =?utf-8?B?ZDF1RzNUZ1M0N2Z6cVFWSDhNZndrRTZIQmFuTFBrSjdybTZZQTVoSUZYeFRp?=
 =?utf-8?B?U0YvOTZFMWRJU2lsWVFvTytKTk5yMFZYNmpyMXRNYWpsa3M2Y0JZL0loU2VM?=
 =?utf-8?B?MmxIMGpTRGJSazVCK1JaSms3NmpzRDJlRDNwY1ZmM1BYVHFtNWs3UkQxbGVm?=
 =?utf-8?B?bVZwUDZjeTlzTjNJNDZWK0w4b0U2S0RJTnhJZmM3WllmNjVNOVNKbExHSXhH?=
 =?utf-8?B?VkV4cnE3L0cybldCb2VxaHZUdkFYTm0raHhEdEpBcTV4TVBmQ09WQTNPanZs?=
 =?utf-8?B?RlhNRXlVOWRtYU1Vam1TWmc2cDlGRDdMTm83d21mZXNLT3hrKzByMmczUS9N?=
 =?utf-8?B?RWhNLzFhYnQwUHN6bXM0bkMzMHJtQXI4ZnBuN3BSTU0vbFhiRUdYZ1U2VS8y?=
 =?utf-8?B?NC8wZmtHSmV6b1U1L3lKMStjREc1enNIRVJLb0lPbVJ2aDZteDMxZnIvck1o?=
 =?utf-8?B?Q2UrdVBCdHQwUTF0SGR0ZDNuNlJ0NmErd043ZXhtYnN3cThKcU4xMURLbllN?=
 =?utf-8?B?SExPU1FyTVpseDlTaFFJdXlzdGVzMmZNSHF2U3ZodHJabDE4bzc4RStGN1lZ?=
 =?utf-8?B?M3A1aC81VkJxY1pLYWhxU2Vpa3lMc2d6UCtpZzBxSUk2RlFMRFNTY2RtbVdj?=
 =?utf-8?B?dWQ5Q2IzYzEzR0RIdEpQL3lYWVpHc24rSGV6LzRubExIUytnWENFMm1DZThX?=
 =?utf-8?B?a3BFQnF1Uk5kaTVQODU4QWJHZFZSMWYwaVNPSXhWK1FGNW9sL29ad1Z5emlv?=
 =?utf-8?B?WVhIWHBicDNoRVh2SFZBYm01Z2lIYzhjQTJBQkEveHRzdVIvUk1mU1AxM3lK?=
 =?utf-8?B?WVJqMWZORE9mNGVMWm5CakxZeUJiNElEeTgzYy84WW53K045Nmw0OTAxT3lG?=
 =?utf-8?B?NG9hcWZqTVFZTVZETkNFZnVMcldxTzMyZjFJWlV3bFZZSGZ5V0YwMnRSQ1dO?=
 =?utf-8?B?ZkNtQy9LOU9iNGhuSkpkSFVYOVdZSlVjckdRczlqQzVpeWtxZXpQNXJWN0Zx?=
 =?utf-8?B?K3pPNFpIalQzUjB0VW9LWjEzMVFNQkxjd2ovRUZtU2lmcFZWa3V0bWE4bjFI?=
 =?utf-8?B?R0F4K0hDdDV3YjJoVnZHb3Yvb0tUOEhIbEo5N0RWVUJLTXVRL0wvRmVFM2cr?=
 =?utf-8?B?WjlReVh2Q0ZGdVRQd0pqT3ZwOC8vQ2lEaXNrN0VWUjBQZVZsdjFQekZGSEgw?=
 =?utf-8?B?K2lBMjlkYU9xbnloZWw4elRRalVreDM5Wnp1RzhHakpHWXdzYkZHYUppWWQ4?=
 =?utf-8?B?M1NQVWdXNEJtd1Bjd3ArS1FuaUxST0luYnp3QnhyTGV1bTNOZkN0Y3Q1S3FU?=
 =?utf-8?B?bzd4Zi8rV0Z0WDYwWHlSdEY0Mk5YQXpQd0N0OFB0NytrR2xORkh5ZklaMVNq?=
 =?utf-8?B?eVBSL0xyak55clppbDh0OE5JdFdJM3BNdnNiNkxLY2lwWExYMGpUbVVQZ0JR?=
 =?utf-8?B?UHoyNkZHM3FNTWpxeHU2SktRZWFWbkltV2pEc1p4N2piemF4QkFFYkxEN1dJ?=
 =?utf-8?B?K2pGZ0QrV0k0WSswUE12SmdwNUg5NnFzNnhORkRXcmpFUDlKSzhER1FBK1Jn?=
 =?utf-8?B?UXAxSGR1T0plNkl4c0s4c3Q5MHE4cmg0ZkkvNXc0YWVwSDJlREd1dTRQYVo0?=
 =?utf-8?B?TWtZODh4MkFlTjJ4bEp2K0hnQ0l1NEJXMzR0ZUppUzVEVkoza09aNEx4aHYy?=
 =?utf-8?B?eXVHUmgxUG81UWFhdkpyWnFHZHFyKzI1UGdBeXBTdHoyVWc9PQ==?=
X-Microsoft-Antispam-Message-Info: BOF/avFS//AbzwTqXsYl/OeRAHNLrcVcb2PtxZB27k7ZHiQQnGIG6hXNzyhTfRwDk8KmnDMj2iOk7DeQ47wmRo3s3UNTPhSAj4k7/VEvHr5fAWTXkJTOAJvLuv74kfWuGIOc+lQXjXp9HcmhNCOpHS6wv1T54m2+Q6nTGrpPOYmdEuBD+UXnyr1WUlrO71hIQX2Hk6qKkUop2ZrLuo8LtSC1vdJFQfiaKx39x2Ug/SNawST7H69Z6HGiht7YbTOGyBNeC60SC6uv/286OJoe165AeiwuHG1MWtpSavAsjWw/RwVIpbDXAqQE72dEU4IxF3gv03nu80I//Ao8iyQfD7eEUszYYZr5mgE/4DUF9L0=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;6:ujQZ6WatQw2/w88l7Wm2Z31GVHlGsyeZFY1PgA2eX+vjaRb/IVMoYWKQIfwk+/9Linl+M/T8SBUGlF7reyn8z8s5dnf3ktsBsNg+U7Cd3r0sPwfE+845OFSzPPnejHIlq47pm8sWGlUeZdOGHLceNiqr45fDvR9v2WIvbUWJ/EYhyox7zeMlrNQbOTlIGAASX9id1vz3ZjXHTvk1Fw9+oLplFMZJzIo9gPAw8WVUWwTri6LKueE6NZKk/yePu68ZZPNOoY7ZTQfy17a0ZxCI7hYy/MxA+eT4lh4KNEuQ64ruSsZEbtW/D46szE+sNjhaQakXoAy19t11nsegOZbsGKd10DzYtcXpkb6DwgPomganU3X7Ck83kRPkjRG41WPsy5qPpaRhEuyVkiA+yFDIXtAW2GBHUK3+u9a8DgSFiznSaBkoTY2LVtEeWPLRa/XmUQTIVJbPAtzyzurCpAoG5g==;5:szmGCBxhRuiYV/4Msi5BDk2W9NJnS7mqqr7Xzs6SMsVjpcmNFPbLSaOdOwJsp4200MVQ0afB9U1gPXLNiF+d+dF+nivaK6yzoXSFeU46sYEeFR52/jv8aOWlOx39dEZeO/6XVX90VeLAJGu/sAx6+KAPRCMn8OQWo+hAG0E2FhM=;7:C7fF3Y2bcyDQXvLadfXgGhZLsphz7seXom/ZxtzARKhBVyUgbNOIu4Xs9eXkVAJlHPs0S/04AJGdq7tg3id+CJoXH4cGbvqabt+Gm7MXu5i09k2pHvfluuWg+69XL9u+2oyLplLi0QZDhVPoqR57Xw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2018 06:47:14.9567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8543f367-eb46-4def-fb2f-08d643b3b00b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 18 21:43, Borislav Petkov wrote:
> On Mon, Nov 05, 2018 at 12:38:05PM -0800, Olof Johansson wrote:
>> Yeah, that's the way we've been trying to do for various subsystems
>> and it's been working pretty well. Of course, if there's need to
>> coordinate more closely for something in the future we'll be happy to
>> do so.
> 
> Goodie. Let's do that for now and we can always revisit when there's
> real need.

I think Boris should take also this one (dt binding doc change) because
it is aligned with changes in the driver.
https://lkml.kernel.org/r/1538667328-9465-7-git-send-email-manish.narani@xilinx.com

And I will take this one.
https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani@xilinx.com

But not a problem with taking both if you like but this make more sense
to me.

Thanks,
Michal
