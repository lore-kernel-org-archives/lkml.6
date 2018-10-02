Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F97C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ABD2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VQJ1zHOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ABD2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeJBUuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:50:50 -0400
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:57953
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728319AbeJBUut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/JH5cfTWMBEdbUbB8/I4Acf4kKHzvapOBqqP5pZ/j0=;
 b=VQJ1zHOKXfANT+iWH4hyz3xuOVEUkDPokdkSsgh2FFIYawoj4BySQbkPo00v/Je1pLHoZ6A7xTtYZp2yRNRk6vKWvJHAjdG/eRfkck3g28ScAYcnbfhiQAoPl5T+Zm9EENJkSGehXc+VvEBi2elmYx42cvNVOsB08fllHGgdOS0=
Received: from CY4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:903:117::13)
 by DM6PR02MB5113.namprd02.prod.outlook.com (2603:10b6:5:51::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.18; Tue, 2 Oct
 2018 14:07:11 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR02CA0027.outlook.office365.com
 (2603:10b6:903:117::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.22 via Frontend
 Transport; Tue, 2 Oct 2018 14:07:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 2 Oct 2018 14:07:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7LKL-0005oi-HH; Tue, 02 Oct 2018 07:07:05 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7LKG-0001uf-CU; Tue, 02 Oct 2018 07:07:00 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w92E6xbH022036;
        Tue, 2 Oct 2018 07:06:59 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g7LKF-0001uU-37; Tue, 02 Oct 2018 07:06:59 -0700
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file
 generation
To:     Firoz Khan <firoz.khan@linaro.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     <y2038@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <arnd@arndb.de>,
        <deepa.kernel@gmail.com>, <marcin.juszkiewicz@linaro.org>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
Date:   Tue, 2 Oct 2018 16:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538397784-4214-4-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39850400004)(136003)(396003)(346002)(2980300002)(438002)(189003)(199004)(65956001)(5660300001)(65806001)(65826007)(9786002)(23676004)(2486003)(63266004)(31686004)(47776003)(106002)(356003)(305945005)(316002)(53546011)(64126003)(76176011)(7416002)(478600001)(106466001)(6666003)(110136005)(54906003)(36756003)(8936002)(58126008)(81156014)(81166006)(8676002)(11346002)(2616005)(476003)(446003)(426003)(126002)(486006)(44832011)(186003)(77096007)(229853002)(336012)(230700001)(2906002)(26005)(6246003)(4326008)(39060400002)(50466002)(31696002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5113;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT060;1:kDNMHsSQKQ35PBtEID0+/PHXaQOM4BXqyTQMhyLotyr7330ukceNTPCKF18sbi2J39mylrdMz0GRB5pst6s7FsHvGO+SDZiGN5yUOb0dW04Nh4eQOQGhB/2w46ZlPyGi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bec84471-ff80-42bf-aec0-08d6287058b1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5113;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;3:OARMDO2Q7wneQ75MNwyfUqisVo+o5cQKc1d+8xsMIZcmSlQTtzxuH8NwLEjRjDqYksvi9r/Ls1DaNJtsLJ75utbrYJRE84SLeHM5qimE+Nw2lZl/zitTqCwb7bHqDc0XqVBlwTwdTKBmJPVFj8NgsaaTyCu2I8xB4WYNGX60Lp68G9L4I35IGgRUROH9IhzDsjqgU8a4JstQaNrznigpjhAHgEVqkpl2zfN1AOOK0ZzbuRR9hQ02vsNuEw/FfwtmkLvU0LP17G0MeZ+zdPKK/UcbYydw7Iug7OnRlXarTYET5OBm3TfpO04a0Rvh8GWAAcaJippI8JfeTGrJpntrWuutyVDmTB3SEiMBiAidreI=;25:y1gYdcOXAM1U7p3SrRyjUpU1/1XBiTFGv9UVUJUCSDUp+/ikqbESO7Ru3rJa7M1GbImPCTJXWaPzP0zLxdjyuZo/XEs1EeYD75TiTAxaz6+HxRI0dd0HV2KIvuk4OASZZJNp0OZvWLKntTXTp8uD+RDZNcgFLWHftjZin0OHnZYXUSm1SM9v7DuaaBjtkpLV36pM+7F/zaw1Nl9s8jPX/5bnhYmUdVfGbtt3UOu52eZXqtMsndUuXdMjgbp+42bNhaVN/4BwQjSJyRGOcN7cUUDAd6T0J1c9++mTMaDoBOv/qD5RNd9SpYC7NUuRwwWkhZdCSc3bBT/TopyAi393/w==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5113:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;31:SfhViHe4Gygz1l5QCvhU9pZMbhLpECoTPdt8El+MW8i3Uro1xdEuUVj3tnZ6StxkEHvlhykvz/vus/PdSsSFoxhsyMZgEbVnCVPIcOEsPahFYHq+aUBptqEaTe/895ZUKc8qah+8gxcZjgemMUPbV9WCDMiX+MkuBai/2ro8cZhDmqhEEoI9VMDbrMWBWdOcZafvw4x4r2T8+AodxaIRa+QCA5a6IQzOROhVLawmhpw=;20:IM877QMBSk24jvO7pQasJw2A6KSXLf6oUa2MiUnL1LBGOAEKyvGUryj7EipkrjXbsJr3kBgy+50MeeUQFlXYQjaJ+mVODBkoik6l9E5jVS5WCAO2vNux9kRKcdHgk6rKtWpEVYekqnpU2A/sXWPL/fnmeJkdHwOXVfCILjimby8jaKcd5lC0tY7jUdwHf6UsxF9DEFbFxzsWn71IcbKL6H4/Duc2uCNYvo1xzeU8EdnWcEAq/OaPvF5Ena4qLe91FqFrJdARRMgOa7BfxYBZz9RIZS68tfTDN/LdUSM0TO4DBujEohMy3+xBrrt5reOMNPR2LYbHZGM+ZLoltfEJDltvoK8sqpM3V0CBj+LtA8O2soX2k7LmfLAYZ1iArogtYG5fU1MIjDf442OOGb7+UJfoJPikCJdKjN5j2SdJU+IHdIAyaNFUfxMEFTUV1bB5e8WA0ksDqIVhrzUfpLPqL/jtbv6AIQMdKU4s0+Y+2HXZXdWixRoasFTynPo84pSO
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB51132A5D90866ADE4CB265EFC6E80@DM6PR02MB5113.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DM6PR02MB5113;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5113;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;4:szZs9Jv9+DKdeubF7bB8kla8MF52eES8Hw/qVkqwX5FMWW7KE2Kjtegbf1hk46Y8afMvNbm4YhNOiNW/JmDwooZDTPH6CL9a5o3eI6FoOKsL7FmdJdqa7s3ykkc/NvjZpd6X/ZVLTTjBLpZhS3+mcckUx04EYeHbDNFV4wTZd5IWhdTcWZVdIlVc0knB82tnAABjKOPfpMthbvaKfWwUAln0mAmIwu79+gFckpXl38BtyR+HnbmSwr8/6YJvnDfcp5GKOc5GHihv8So8as5Hkw==
X-Forefront-PRVS: 0813C68E65
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MTEzOzIzOktDbE05Z2w4R1pzTmdFbHhGVkZtK2RxbEZP?=
 =?utf-8?B?c0p0TVhWYXNxTm15dnpCdkgzaFJrQnpYTGpxRllObHVZcFFHTG5lRFpiU0dU?=
 =?utf-8?B?STFRUmg1c3l6WmRHdWpXY3p6NldEb2dhN0Y0L2l2Q2FoMEt5K0xpV21XL3ZE?=
 =?utf-8?B?dXJ5K3EvdUNhc1BvZDl4LzFqSmJwZ0V5SFpQNmRCMFlUdHBDdElWOGlGcUYv?=
 =?utf-8?B?enhoNnBZdmFGb1ltd1MrMlhBMjl6YlJHTVA3Q2twbnRadGtJamdsMXk4NmIx?=
 =?utf-8?B?Z2dQSDJlSE1BbzVsaHdMbnNXUnlxckpHbHErUThoNEdxNUNJMTlUb09jblBT?=
 =?utf-8?B?NWp4UFFEV25GaEtnbFhERDhQOVR6dHNtKzNtRWJFVlFTdHI2cHl1Wk9MT21y?=
 =?utf-8?B?eHhNNlF4bmNqODBHTm1FS0kyNkQxbUpiTml6TjFVM0tuSU04VDdkVzc2OFA3?=
 =?utf-8?B?cHBuL0s4NzgvQWQrSUErT0lnNmlRS1M5Rm9MK3psY2d1VUdOdmJ4QkpiZUNp?=
 =?utf-8?B?Z0ZUYi9uS0FWcUY1NWp6QU1WUlhLVzY5eHRqa2JFeXliWFFsZ1gvWkE0d0Yx?=
 =?utf-8?B?c3d1TXljazIrdG9sd2NUdjlOUTlzUTBRYXQ3TGtyOFF3dHJENUVnVTBFVUJB?=
 =?utf-8?B?VDFTQ0tOMithY2JjbFFZNVg1T3ZoV20rZEw0WVBtR0g5R05PUi9hNXN4Smtk?=
 =?utf-8?B?QWF3Syt5UktyWUlWYTVpMHhTbitIeVM5UmhzaHZQazdPOE0xTEthSVNMdTJT?=
 =?utf-8?B?Sk15bkIxNEwwbzcwWXVyR2UxMlJZdXM4Sk1FbkdyVFl4c2RmT2xwOThXSGZa?=
 =?utf-8?B?dDB3QWVkMEtsUXlUQ1JSRFFpQ25BdU9obC80eEdleEE2dmNWMkt0eTNTeXhl?=
 =?utf-8?B?ekJGYk14OHJkVFl0cVVhcEJRR2haZ1FJWFJqZVZWMkxxRGFMRUV0eGZRb3hW?=
 =?utf-8?B?TFM0WGVWRytTb0N5SWVWSlVTZWxheW1xcnY4d0JKUnZTaHd2dkx3ajh3ak5z?=
 =?utf-8?B?bFViMXFtUlpoNzFLSGMwOXdnekxITldoUHk2a1lRTmt6UGdVOCtUSzJGckQv?=
 =?utf-8?B?V3ErNzBKa2ZqNHQ1b202cHJnaExkZGdoMm5lMklCTFNkVGlZQjdaZ3g5b0hw?=
 =?utf-8?B?bWhwR3NxSStpdG51WEhQaDZRY3U0RFZEbWM4WEtiYy96NGxjTEtBUGUrNlk0?=
 =?utf-8?B?MnhVVkd1WUVMVi9IcHZVRUw4aFZWaG5kdnFiVzE4ZE5tam9rdExpMGJDOXV3?=
 =?utf-8?B?WWdQWUpFWlVOTzBNM21WMExNLzhvbkVlNlRWZmZ2bnFjQ2lmOVhCUFJjYXEx?=
 =?utf-8?B?aS81NTBNd1l2VEFCcjdyQU16NHowYmg5Y0VQWUtNaGFhRzU1ZWJhT2NuNTZL?=
 =?utf-8?B?L3QwcjlHYWRSSnR1cXh6cXRUbW0rUjZRdDNRNGl0azVMcEl6dGJhdFBqS1Nj?=
 =?utf-8?B?VUpZamk2b0JkR0JXTFc2UFN5WDJ1dkVuU3BEazV5UkVlT09POEpZS1JHSEx3?=
 =?utf-8?B?SFV6aHF2S2huSmhZQXdXVmZ1YlJhQ3dKRnpITC96N1NtRk5ERW83U2IvdWdR?=
 =?utf-8?B?anpLdVhSbXI4WUEwcWNYN2w3dzBwSWx5UE0wc0k5SjNOeGFvNkI1dDlkUjRi?=
 =?utf-8?B?d0RTbjdIdlpjY0l4STR1S25GNU1hN2ZNVEJnRkJzQTFQcXR3WlZiMVIyYjE5?=
 =?utf-8?B?QkJHZVpLdDArN3dNUFgranRqK2FGRUFVcElTeDNiTkJEWW05cFhFSklYWFQr?=
 =?utf-8?B?TVdxSlQyLzliRXFVUklLUT09?=
X-Microsoft-Antispam-Message-Info: 8FhoQNSTQYnXTgs/m8pHlBCKyjBzu+bs85YziAKxgFMMX5TcsfTcSsQuuKmQ/S8lIo+b6TWyGXWJ08c0ZP1gMBPtIFQY6hR37wXs84b5Z7Rt+a+3ddPBXCEShBewvHlpVFFftrEwzhEL7i0k7mz7IxewnNIhpIFNubA3u96k6m15qlIZP9aFsHQQsEAS0uD78t3aqhIH/qXET0Jn2TcLu7G0bURNEh9nPPgeOCLxvQFGhqkzePdvJ6de1mrSNwMbE0KrGkGlqKMijh36jUaZKpSkoMFYsmwcHGcksubShEjssYv55AxXXHO9hJePZxLcLhBa0Zrc2NfIosJZy41QfGDpVo4r2aOiG6SX1yCWD9k=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;6:R3E0bI0ogspTkwTiSTOftqOOkjZfoGbw8x0ksWguknPCCnEOZOs4h2FfNOmWE5s8YcqOscGF4idx9Jflo6HtbhBN3IdBG8H6VmQoHmAFCRmWIrxKrSycnM1L7jLH4baRjl1cD/tVH2jZn4dsd9ONvvP1DhdkqAzSrB6YrKyXeWp0FceVe/FFApj12Ons96vDiVSGmcKJYgJ2Q4+1pEUzQtJLMqXSm3l+qcvAIkpTu2sK+OorFGORPZCygzyVKu2awy6IYdMy0Rop/W7ZHbxPNMndxCqRG/lWNXR5vLBtJePwRNaJgKHAYQgkH2FgVt7wDEdtTTq5z/99yvQHTW4GGe6w72J8MPT/qZXxZsBdQkZtJd1mj66d/l8j6m9sB6qrPjvmNF6HfNfQwaoqC0VOyWEUWw6/RN+lh79NfjhwBKGYMrhcx968Si2rwrG1W1YmOsKxG41GUi8cva8TzQ3k+g==;5:gQO2JiQ383u4eMmrBerz3CmLUWqnxPpfSpZe1fgL3P4XTssqjBeXBK7AFa+fJYzjCa/sF2yMZghc8TanOiOrl8djasTgg2YhltVN/rzN2Eh79Ih+3wiriEs+8vRvVQ24pawAxHW3eHDyF2mW2cqLnBrUSFnefmx17/tA5n3V5CM=;7:qH5VVWsndLQzg8HyQDay537wG122isdMplQIJmrN7WfAYI9h0plpWqhXPRocIiQdckDYx/9tgnh8qKMr+90+5/jEIdpvUQ3nsKLIGNktvo6nrUkTvrHuibO4qPfF3XL5SkHf7u8KK1bXW4G/qwi27Fru15z2FFQ0c2lHHaicvQhnVvC7cIdH9Z6KVPJql60LHbfaEEx4dQha6VPIBhXfZDiSlX3QivuKyTec+W8X843Lw/yIgSbNez00WvEOC6D2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2018 14:07:06.2739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec84471-ff80-42bf-aec0-08d6287058b1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.10.2018 14:43, Firoz Khan wrote:
> System call table generation script must be run to generate
> unistd_32.h and syscall_table.h files. This patch will have
> changes which will invokes the script.
> 
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> arch/microblaze/Makefile and the generated files against the
> removed files will be identical.
> 
> The generated uapi header file will be included in
> uapi/asm/unistd.h and generated system call table support
> file will be included by kernel/syscall_table.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/microblaze/Makefile                  |   3 +
>  arch/microblaze/include/asm/Kbuild        |   1 +
>  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
>  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>  5 files changed, 10 insertions(+), 812 deletions(-)
> 
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 4f3ab57..cda5e03 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -81,6 +81,9 @@ all: linux.bin
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
>  
> +archheaders:
> +	$(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
> +
>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>  
> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> index 569ba9e..d64f5e7 100644
> --- a/arch/microblaze/include/asm/Kbuild
> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -31,3 +31,4 @@ generic-y += trace_clock.h
>  generic-y += vga.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +generic-y += syscall_table.h
> \ No newline at end of file

Still the problem with "No newline at end of file"

> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> index 2c6a6bf..3a40659 100644
> --- a/arch/microblaze/include/uapi/asm/Kbuild
> +++ b/arch/microblaze/include/uapi/asm/Kbuild
> @@ -28,3 +28,4 @@ generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += types.h
>  generic-y += ucontext.h
> +generic-y += unistd_32.h
> \ No newline at end of file

and here too.

M
