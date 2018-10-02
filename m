Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69FA206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69FA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJBVFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:05:43 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:32491 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:05:43 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 722C16191C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:22:05 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id C83A685;
        Tue,  2 Oct 2018 14:22:03 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 2 Oct 2018 14:22:03 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 2 Oct 2018 14:22:03 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mike.travis@hpe.com; 
Received: from [192.168.2.157] (73.222.225.80) by
 CS1PR8401MB1125.NAMPRD84.PROD.OUTLOOK.COM (2a01:111:e400:7512::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Tue, 2 Oct
 2018 14:21:57 +0000
Subject: Re: [PATCH 2/2] x86/tsc: Fix UV TSC initialization
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi@sgi.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Hedi Berriche <hedi.berriche@hpe.com>
References: <20181002012204.297193336@stormcage.americas.sgi.com>
 <20181002012204.568382740@stormcage.americas.sgi.com>
 <alpine.DEB.2.21.1810020820430.32062@nanos.tec.linutronix.de>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <5caf531c-cc73-57d9-931d-c433ec1baddc@hpe.com>
Date:   Tue, 2 Oct 2018 07:21:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810020820430.32062@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [73.222.225.80]
X-ClientProxiedBy: YQBPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::20) To CS1PR8401MB1125.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14537906-8c93-4cb9-f408-08d628726bc6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CS1PR8401MB1125;
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1125;3:B9ErZF6QWuazEUnSmReiAEc9yHs3fCLhPhvRKWWgduAx6vkKy4acfokU5X0F1gyipK/T58vZvuh7nOjdx9fqlVvZEaYmXDt9T0LyfxlD47GanUFuZMOEAhyDeZpzWnQxWQgM/IWRKr2HfI9yFO8pHBJFU4L2KQw9IUzIwvdsTh4+8Z6a5n1IcUYXe8rSVxw2bydxpdicqJFZ/EXzl6cdASSFfdmIP2GXqjyPu2Zv8JP1lceF/5ovWvNIQCGDdfuz;25:TZ1vYNhfxEG1T930bFZeFfyuuuJMy4YUcOUQd60Xbe5Jw83ZvFSFD7+mZJq3wqd1gZGOtvKTQTN0Vk+KUJWCqx58aKEM8jzr/5PkxO7v7WK7I3qCgjYVTJo/GHRDIEvFB8KXmLv6v/RIH2QHDZiSZCxxt24S9fkUTSuWKzI3v8a0yiRAHhMM/r4VgkqC//OGe7TF6RJO4gxQ51AZQ6LFxgzLXuFqKD3hSURnfVJ/DI5FULRJFrJqalq2CV8V7G3EnVFg7QLL9hKUxQFMh7hGkpXeHB2hsltD2cqYBQYwxo7v3v36XQ3IrW7n4jS3dLGUTttkS5voEg7Lyt+ZW6pnoQ==;31:ut9bboVvNzWf/GKW0cFC0vngCNcQYMsd18w0E0nWigcagUv5m1LuFXllJkif4N0eHUA68f2jpybhAiQRd9KleUbQQ9L0ITG/3G5lGDDYioE+EjLZ6fRaCQ6lYpPBE//JQk49UKW4mkOM9h9KbxX+NkPtlJx1hv+NaNLQrFqc1aCnhOpqza5K7VGNIw04vyPRNzDy2JMYbc9hVJDmEHWFNCAOSDT37TZDlZYOLyl7ODI=
X-MS-TrafficTypeDiagnostic: CS1PR8401MB1125:
X-LD-Processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1125;20:yrvymuwfOwhqhXFJO2qptH7dtGv49StJZ8BwDMH94K6VuhOmwoTvMe7znCUDhdAI7btKOCzlfiBjLbYoI25h9qw6sf+tVKt0M+q0uRnBRNArmA5jj97UGscWPeRcCrYbJ8iiGQbdp7OAPfyVC3opxVKy00mwNActeblhshPjgtiRplD8lJ6sRz9KsrGMSjNCzrkjmJ2o80zeQmm1RwknAX1NUdvrjV2eVpkZwiTVddndotFG6QZbOib3gRcZn/4sJCjc+h75hwf1+ILpeLL0t8UmVH0bWmY4f1tvhxCNkx+9sc6v8vQ3mMDldW+gFD03JemJIE19lfLxfSJp1ZYT7ww34mQBIBfA6RfXOQZ7nG/oi4Hpfz6QehbIUtPslaMnqip0T+DwyNIrh0Q3+wOMkLN+zZ0qm2cJnx5B5aNSxvX3zHPdW3O2AiyT0sTzynqzG9tUAOAUa4rvutyIURRSc3jt+krk1jBpjV8lQt5eM6M8ervHm41tod0Y8jLvHAuI;4:cGOSDuu8f7GooNtLLcFhtEsqtlW8TYRKnJYMdwrFSKFPlKRvqTXBqtggBidtQloRPYnYPObZvmVpETaaI5sX4p8b0eWd123N/s/3i4RJiS5q+zMzvtvRtK5B7kkiyJWv72SmCmz1gzupM0fpUFXji/6Mdv7i3CPjIdYh1bzn6ff8XYc6JOA8dS5+RAPKiINxyGtsnZwkvyrWs2vcC5FgVAMfpp4gNlGwkGp61hxbl92kfFM95eXdHM8uNrPjs1zA2y+wGY4GYJDRogTLUQPhjdbiAr0a4ebttalss/CehAu03S6g473Ujpo1dP31cfLEQoI2AdB78v+5NzGJITf6K4Oq/i1YyCE4g9zPeTpEtBI=
X-Microsoft-Antispam-PRVS: <CS1PR8401MB1125573F6196B4E43DBF3858E7E80@CS1PR8401MB1125.NAMPRD84.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(222181515654134)(227479698468861);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:CS1PR8401MB1125;BCL:0;PCL:0;RULEID:;SRVR:CS1PR8401MB1125;
X-Forefront-PRVS: 0813C68E65
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(53936002)(486006)(478600001)(956004)(11346002)(229853002)(230700001)(446003)(44832011)(2616005)(36756003)(23746002)(106356001)(25786009)(4326008)(77096007)(50466002)(3260700006)(6486002)(31686004)(16526019)(476003)(52116002)(76176011)(6116002)(3846002)(117156002)(7416002)(16576012)(386003)(305945005)(316002)(7736002)(65956001)(65806001)(81156014)(14444005)(81166006)(5660300001)(8676002)(65826007)(47776003)(97736004)(53546011)(54906003)(26005)(64126003)(86362001)(8936002)(6916009)(66066001)(105586002)(6666003)(67846002)(6246003)(31696002)(2906002)(58126008)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB1125;H:[192.168.2.157];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CS1PR8401MB1125;23:Kzzq/QdAInsWn3tIxnLdvTxUmtze+zm4PpN?=
 =?Windows-1252?Q?X9f1A8g4nUwOvnUCSF10xj8zEeGmCfvDzI7PGvsgOnpt13FxmnmM0+U/?=
 =?Windows-1252?Q?XFLPLK7t14U4caJpuI+MNWpjbVp5lE+f+otQJLAY7SuFug0ooPngxNo2?=
 =?Windows-1252?Q?V+v9EFgsg7Sb50IHxVXM/CSdhjFmNpLqByyZAIUeq7NKsLkSJvrb0H83?=
 =?Windows-1252?Q?GW5jjaeN9Z9KhJcvoh6w2FSNGv5VGnFA28pmEERqmTtlN7wQ2OkRPIAt?=
 =?Windows-1252?Q?06AQk+zOVWSSQ5bRjKRlDBSSYLdwcuJKY8S22kYNu+VKY1kmlnOR7/kW?=
 =?Windows-1252?Q?uIDueLgOsJ40uK7nKpKS2udfSCnHgmD7xM2GLcqQXEETbWMzuZfq42tZ?=
 =?Windows-1252?Q?ewWtUv7ea8g9GoJfvkLQq29hpFpTTj1TP5TXakYwWckM9wXEVkNjEoKJ?=
 =?Windows-1252?Q?UWadr95qWtJO2oTXwLAYRa1qx8z+agY4rfmJN2rHpf4/2CVtqL7bBqGb?=
 =?Windows-1252?Q?R9tULr5lFdEzMNHhjtTDEBErM2YLFrvgctcpBmKaM2DCZ/ZosaoFzdI1?=
 =?Windows-1252?Q?0puoA7HFJ/QK1obDBgXEc1suC7ls/mdkWrgFaK1ZMBsxPeUuJfiHcEPG?=
 =?Windows-1252?Q?jiQYcp1y5zSZ2DUdYYnRW49VsWkp50jGmzIiUCyn/fLVqoKOvxHAYikX?=
 =?Windows-1252?Q?DqwSnsEWINiN5WZPC65YX8rZiwQSXGFxH4v81S31VbQaoW+BWlkIe4BO?=
 =?Windows-1252?Q?edB61S21zjsiGv5En1WajD+3qOijjglGJIFlztfoloo+Rnno9YHFqMIA?=
 =?Windows-1252?Q?uIa9Xq0KJlJXUUV9zXzgXYey15Vh+Qj6UJyBCWIIwwMNNbxsi7pGnUvU?=
 =?Windows-1252?Q?nFSwJP08g9SMxcH7Y4AKw7DmcMhbZy9O4QELrsYrJCBN7rVYDqMDAE3V?=
 =?Windows-1252?Q?rQNTmlxjsm0jDu/Xz+8knrdwD8QlJIAh80YPNqeOcXX6dvOs7vTcBVmL?=
 =?Windows-1252?Q?BRy0bUlxkhTpOzHSSsoCTLTq5Oaudcy+da+zBibsjhSZzp4LE1gUeZ3u?=
 =?Windows-1252?Q?Lgqk3X8Tip5e9EQiOTbkTe1SHBx7yT6QU/eGd3mptChBVJ+wxSYuHGx5?=
 =?Windows-1252?Q?sXd2By5rTqu0t/ZK8lZJfjfJ8C9cFlQ5QGYCwDrF5CvAK66kNMIjiKAP?=
 =?Windows-1252?Q?OfNNWBNaVTjllhAU1LOqBLfdVRbDYq4+j8Ub3tMIy0E2FnU24qO5K9D1?=
 =?Windows-1252?Q?H8DcWXTBzHjfuyQuHyMcu2LUHCIBeF76fEw+UpNJqHtDekF2OmrJYONO?=
 =?Windows-1252?Q?e8BiUZWUDhiZlJBKNZasCrhXjk6VmDzmNEgCG7SmpzwFWGhfntzHGOXu?=
 =?Windows-1252?Q?5afhB1qolgxRsRo10yWIKsM1BPzYBVjJdrlzvrOVeaHFGykARQnQSIUU?=
 =?Windows-1252?Q?+I+CTmqNftMUOH7zQObh3krdWumsgPhE6G58MYXlixOa08iVWE8Vmr9O?=
 =?Windows-1252?Q?WyC6XUVVNagYz0oM4/cufcg7IJg67AIe7OjLc0deOE5uWA1xQaBtysVT?=
 =?Windows-1252?Q?4f4zCv0RAyxvxlP3hnzu4GukB2cHdcLpJIpyqvzkkaAch5Xam/W+4w2x?=
 =?Windows-1252?Q?ukg=3D=3D?=
X-Microsoft-Antispam-Message-Info: uEQUTGBiYQG4r/TXzMJTOMfjBNDWzaXTsN+ZufUl9YqtSKasZzw003u3gzRw4/4KTojzq7HPUt60bbc59Q9km6/Uto0IfSsqGjEgNblyby+kKNp9Ggce8qu3P6ejQ70F2ZzKnzXijM9PQfZLuZe5yXEYqN27dkcRtBiDCX1YwMrjyrRwPVpxIl3h1TyRGJzjugeK41eBB+N8YOf65V1ZO1RlkyChWdpnlPfRmU3XycO5SG2Xyg1hGzhFrdmz5Vu+9rCThQ/zqBxbMhXqqscH2ppfbSBCfytAnhOsQYFD3iSRHEkxJuP3pRaNRfBH57F5KEeTpoC6uMb2L/6R5h5tIha+5Mos8XAqFnL8tSrmyjs=
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1125;6:r7+lSIRm9Rw6ckAdYy+EFyt1UfqhmfW+3413BkXVn6j3UQkMS+5saauIQzBM85R+bUcQsM0cVhhxU+EF3T2/AWI4hJSFsxtICAskDr2WcuvAhnG9pbCawZ3RNVhDcWWK+KROANlXLUeuhdSKe23Uc9/IpKowttj+g1z3jhWsB/v1/CV2WdkqHlMH+XpX3QWIQh5BmWjuzOeEfeuCkd5qle17xH+XV1uhumJ4LX+1UWNjqdk+ZTedviu/lC0R7iMk2R1spf5r8gwm8Jgi8H7kxCXCcEoKl2vNdyhoaQ8YbV7cyqgPTJu+YFydcqmAr3veo+resCUYo2mBigl4Ac88Z+h9OClzG1bGg7AZxi1lMKG88it02bg6O4VFX1dL0jxa7yDC7HJYqutqmfiAVcXxzL93HL/4qzyhME6iI20U1m10quBSzqlj8RPqO4ZNJSMFpQr0gckGew5bYHXegE82Gw==;5:d4GxX7fA7Icp3J2HzFY+I0hLwrYOcDEwDMAENwPqf1bj/pzcY8szMZ1GO/WcJo0OiBlf/lC8IjkhFpFqeR9tSxNOpwycA7cYMdswEg4J3Q3e7H3k+nx45yQimMPiKu52KpJbkv8sjH7786K80VsZ97l8i8uz7NSHXuss7K0kY30=;7:3/eZudx8W1Py8fg5KEq4v9uW6/DjOGK6jWnsysPwW8BmK9YuJhJQvEZYvRqWiBvxIaM4laWv2hIjI+VmcyZV5UE5RgLYB+e1Wmm5XLJwkCldtwqOE829RFow7P5vjlagMRQf26a76RGJopOwmhY1wJLuBymN7p62N1DJcdNAbWSqGjgm5pk1ws86fo9SrJDlNep2oecPBWKcEtTXDhJl/jahBU2Pli0YkweYTpuZ4+5RpAOz/l2Ecp0aAlmMuILi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2018 14:21:57.5963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14537906-8c93-4cb9-f408-08d628726bc6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1125
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2018 11:22 PM, Thomas Gleixner wrote:
> On Mon, 1 Oct 2018, Mike Travis wrote:
> 
>> Fix regression introduced by
>>
>> commit cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")
>>
>> as it changed setup_arch() so that it now calls tsc_early_init() before
>> acpi_boot_table_init() which is a necessary step, in the case of UV
>> systems, to inform tsc_sanitize_first_cpu() that we're on a platform
>> with async TSC resets as documented in
>>
>> commit 341102c3ef29 ("x86/tsc: Add option that TSC on Socket 0 being non-zero is valid")
>>
>> Fix by skipping tsc_early_init() on UV systems and let TSC initialization
>> take place later in tsc_init().
>>
>> Fixes: cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")
>> Signed-off-by: Mike Travis <mike.travis@hpe.com>
>> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> 
> See previous mail.
> 
>> Reviewed-by: Russ Anderson <rja@hpe.com>
>> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
>> ---
>>   arch/x86/kernel/setup.c |    6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> --- linux.orig/arch/x86/kernel/setup.c
>> +++ linux/arch/x86/kernel/setup.c
>> @@ -117,6 +117,7 @@
>>   #include <asm/microcode.h>
>>   #include <asm/kaslr.h>
>>   #include <asm/unwind.h>
>> +#include <asm/uv/uv.h>
>>   
>>   /*
>>    * max_low_pfn_mapped: highest direct mapped pfn under 4GB
>> @@ -1015,7 +1016,10 @@ void __init setup_arch(char **cmdline_p)
>>   	 */
>>   	init_hypervisor_platform();
>>   
>> -	tsc_early_init();
>> +	/* UV TSC multi-chassis synchronization already set, don't change it */
>> +	if (!is_early_uv_system())
>> +		tsc_early_init();
> 
> tsc_early_init() has already a check which makes it not invoke the
> calibration code, so please put your uv check into that.

Will do, thanks.

> 
> Thanks,
> 
> 	tglx
> 
