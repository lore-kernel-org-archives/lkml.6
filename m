Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93346C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C052084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="d8PZ+qqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C052084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJHTbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:31:47 -0400
Received: from mail-sn1nam01on0086.outbound.protection.outlook.com ([104.47.32.86]:16363
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbeJHTbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9B+VtxoV0dKpcXuHd0Uo0aV5nyU+Zm0tdfw25MTB+w=;
 b=d8PZ+qqWz1ufRUuL1idYNZV7IWQDyx9MWKHs5DPjB6GovHw0hkz9wfWwpdvbZLFQZq4OHuI2N9KyAGmeK4eDDkRk0vg4EhFrvCV/ThIJqx1vKb8f7qbbqMV8/EkmQ9HaRz3+Afrgewa3MhtBpmtlPzQBqX8yLQUb9fmr2ullzBg=
Received: from MWHPR0201CA0089.namprd02.prod.outlook.com
 (2603:10b6:301:75::30) by BLUPR02MB082.namprd02.prod.outlook.com
 (2a01:111:e400:811::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1185.25; Mon, 8
 Oct 2018 12:20:16 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0089.outlook.office365.com
 (2603:10b6:301:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Mon, 8 Oct 2018 12:20:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Mon, 8 Oct 2018 12:20:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35737 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9UWA-0003Ja-8V; Mon, 08 Oct 2018 05:20:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9UW5-0002Gm-2j; Mon, 08 Oct 2018 05:20:05 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w98CJt3V006889;
        Mon, 8 Oct 2018 05:19:56 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g9UVv-00028D-NJ; Mon, 08 Oct 2018 05:19:55 -0700
Subject: Re: [RESEND PATCH v3 1/2] of: base: Introduce
 of_alias_get_alias_list() to check alias IDs
To:     Michal Simek <michal.simek@xilinx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
 <CAMuHMdW5zze-KJhK=diR-WKbhO_vsMV2b7WuLHmcT2FtRD4J7Q@mail.gmail.com>
 <d27b381e-f091-91dc-cffe-27789583f949@xilinx.com>
 <CAMuHMdW4H6pjpijU2SX1Z=1Ld7CbBnTtFVwp3gac9toQc4iGpg@mail.gmail.com>
 <56c81d1a-e2f8-067e-4908-686cd83d478c@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <1520923c-2e16-cee3-7281-13082f90954c@xilinx.com>
Date:   Mon, 8 Oct 2018 14:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <56c81d1a-e2f8-067e-4908-686cd83d478c@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(39060400002)(97736004)(476003)(14444005)(11346002)(65826007)(126002)(77096007)(106466001)(446003)(36386004)(486006)(2616005)(31686004)(36756003)(53936002)(356003)(2906002)(478600001)(58126008)(217873002)(186003)(44832011)(26005)(426003)(54906003)(106002)(305945005)(76176011)(2486003)(336012)(229853002)(53546011)(5660300001)(31696002)(23676004)(316002)(65956001)(230700001)(9786002)(8936002)(81156014)(6246003)(93886005)(47776003)(4326008)(63266004)(65806001)(110136005)(64126003)(50466002)(81166006)(8676002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB082;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT012;1:VbmFfCkXoV5EeeAYXn60efzdvpfrJp5zAGzPT4GU2+iv+brQsS82jnG8B69dzUXE5sfQ+EnOAP5+yEKIdKzAO77V+KwBUocO0Lst74Ac4nSDkhCEqLMvCnPNDvNfJICD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d44ac6d-f046-450a-c6be-08d62d18666f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB082;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;3:o7+vmq633x8SglSiGrTXLdKszCfqBL/k4pqV+YlTee7/4t1CSTQC2YoIKy73lotkP9eTckbOBGau/zs7shpbaKUOfMHpNAaJEbzN2ZMty3FHjikcdceBcpr2e8Hl4HvT7vxgXwmDxePKu1FgwmqAidOfpk2J/hqSQ0Gb6LbB+TlkDs9DMPU7THGsKjCQKX6xnt7qLuAgjp+Q25ueRSMQdfBV9iFuN5JW8haY9w7kLDLj3DpMWcCOgkD7cCkMw41aJAw25MI5QBSP0dqJGGv/xagiF2FSsLj2O5rcRTPAtSXWflnc4gnxxPPWGX2GlzZXvKfe9W9ZGGGz1Eqvq9jKIyGSRx1eDnGZKbZ2D6WKwhM=;25:M9TWJZcBpjOWYuueIHqtE+ufegbCHTAyNjJniEUInVvuBx8/DFwV7vi/gC5/71YKOf15fnXxMvRjRx9KBPBnAA03p2/bUx4dO1BEMiAyH+QYxp9TKsq88xtydZGqmgJWzvkCK9b1f+nlEe3q5RTa3lOGcfO3HlOyCSy821Y4LmxJRrszJf3upaPZXOh0mU//KxFWnYPSfTey1glcLhRw75FbNWvWIODamsl0U/DUsyqtxxkl3c26b6FDF6Y1+3aX+6FVrBl+RSeYbFxEGFwPiygaphGcw4P8u5qFJ8Jhd++REkef95XrcwQFnQs6n8+QLBZJaFnKerTVWL5/y6t16JwOfoChq1mNbO8+9jL29IY=
X-MS-TrafficTypeDiagnostic: BLUPR02MB082:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;31:QpPPTH2s8aTRtKtYDNpSWVPvCbhRIoeEHNlIx3MXrHkp5kFnWGQFYuqcyhQCUqx0znPYZOVFyIHFjGrJgY7B6wqcI7AWR1fjp6UJW8y6pvPqvkwjriyjaPseEgckGh7qJbwI5j8/6ulOHW3OAQPe4irIt0uITx/5SQCw0ZhXK7TMPEfgfgJitG+S/V3xK2JW5qNLXRx+NO3QhJoD4YaBugvSi5Hj6W3B/nQ24LcNdV8=;20:bLRtL38hHza8l867H3DknPJggYUw7/i6A7RJ71XJxz/FQqC4pOw0hAWmV4zO4vXBd3eVXclrzFq++52ozHL3ChNa4Yav+NjzXpM+1nFp2zeqGQ/O/swDok/+sB6/8u1NdcD0/t5IcTlxDnJseFsgmWx/g9SIMHajQ/WWP/9esg4wswXaP5iGTzK0KXgYIgeVMQN8au/kcm1tm9iKFkcnPuFEOwZeIEHnBKVxWT5qVoaViBVuir++dZiRJEujDiK886kH+aimnukOwuJgR0vIlN9ACdGf6LrW54tpptA8fd7+lJVmdUT8JWhtUzgOsyaCEmAx6CIy2FdGDFWYDT6phdUiVwCVL5DW3w6yvFMQOVf7ULauhvi8WIj3RrshkEDXZ3w2YdX8RMJORJFdc/+rWfdYhvzbiy5g0LDufpSSFIi8PQAUWDt0R+LZZ8n85iH3p+rFs36wG0yohcSy4HL8iQQAVvU9or6LM77YzGxdpgGxmzA5XGrS66D79xuLJYIw
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB0821C81FEC1836F5723C9A9C6E60@BLUPR02MB082.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BLUPR02MB082;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB082;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;4:oj0OplYlbv2JeyLKWwTh/Gb4hOJX6PF4Kfo7fgmfMLM2IMPRq4PvxBwg0pqb1I38qSXcD3MAHGWwgzRJCCGvwdfJ5rVMQzS3GSkIO0Hae7yDLoIbK4y1txN40/PTqIZ40OH3s+hhICGgtAkqBJE5rrQ+AH37KjnzyAbGw0iUAGPFVN0Vs1O3SfN387dprpMbUPPvh0YTY9bKG9R6nJXb9fZZrpCdhPb7wViccAR9UBlfB6WOrh+MA9Qy8Hpeu1itgm0YkAVxKAsyks5wGPYWWobM/HBkeBAOzTZvqzUkbtrYkLcdq8OqAB6NqhSgupzX
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAyTUIwODI7MjM6alBWNURKV1p1dTVCT2ZSb2pDOXhMOXhLcWxt?=
 =?utf-8?B?VFlqUjhQQXMybXI3eG5hZVppeVRUaDJYYWxZNVc0VkJuVGdSajE3VFR0SGcv?=
 =?utf-8?B?L3BXU2xxcnRzWlc4NFRqaXRLbm9VRGZMTmx1eURwcFFGQm8rbTlQRWJTSUhp?=
 =?utf-8?B?alJKQWJxaFVEQm9XenpOdHkxeWFTbGZ0TGFtWUpCL1E0dVRvdEloSW1ZSVRs?=
 =?utf-8?B?TW5uc3JqZEhMSS9YUFQwV01vZUlFYThJbWwxRmo5ekh5Rm1zV3RQU293Vzhz?=
 =?utf-8?B?Sng4cCtkSy9ZRkp4NEd0RmFEQThxY29EM2w1QTlXaExRSjZVT3NaVXNHbUpk?=
 =?utf-8?B?Ly9qQXdHaXlYNUFHZlM5Ynh1R3BBNE5lOExXZ0ptWTRqSEEvc2RWa1JCc1Q1?=
 =?utf-8?B?TDlTQzBDUnZXaVdrNkc5b3JtTWVlc250Uko5RTE3TmNXK29LREpMZTBOVWFm?=
 =?utf-8?B?UVVNRWRoMmJTNGIyQ1BIaG16K3d5QytXa0I5OGdwT0R6YUI2d2kzV0h2Rlkr?=
 =?utf-8?B?eFFMNWJiVnM1dmJtdEY5dW1mWXpZTTQyVnpvNDBBcFF2NTVDcWN6V2JBa2NM?=
 =?utf-8?B?V1I3bmRUencvanFEcmVZK3IzeHExekVZc3VSSnVzYlB3dXlGNGFESWVXdkxz?=
 =?utf-8?B?QkQrNXNuYlZxdlpuTkhyUjhnRWhBaDZxUis1TDN0cExOamUvNlo5VFY2b0x3?=
 =?utf-8?B?VGE4RVZ1d1RsNGFla01UM0NuKy9vUjgzSWdBclBJcHlTZ0VZRGhxeW5MZ2ps?=
 =?utf-8?B?VDJRaTlraWs2V1grYktRd2dicmFZS2dIbkk5MlFVQ3ZnTS8vQ0R2dS8vbnVr?=
 =?utf-8?B?bWtjcVFkZlFWSU9xR0JmMHcwb2NCRHNGa3JZdGsyRGszYXFtMmhBTFVkZStJ?=
 =?utf-8?B?Mk94V2prWEVOTTFFK3lSaXBaWG9aWXVPczFQUlNXWG5BWExMTTdINmtoYWMr?=
 =?utf-8?B?MmUyM0hYa0Z6Z0ljN3RUcmlvR3dKUVZ4V1hhOGFkZHVWVHIxOGVXTkxRYVYr?=
 =?utf-8?B?WldHaU92UWdGeGtxSGt4S0F2b2dqaGZCZWROQU9CMWk0d01FRmdONFJtWFpG?=
 =?utf-8?B?N09KMm56ZFFRUWppWm5RdkxJVXh6VkZDUkpPL1RuQVR2bElERlN5dDI1eXZk?=
 =?utf-8?B?M2g1RitYdEVSaVhFNnViU2hXeEdVczJFSDhXaDNJSTcrY2FIZ2k0QkxKRWl6?=
 =?utf-8?B?bHYrYktabXVVQlJkemVobjdtRStLRFIySHpGT2poUE5QcUFZa1pMNTJWVzhn?=
 =?utf-8?B?SW5tbzgvdSs4YUNSVGZCWmY2ZlpiZ2VTZXlKRDFiTktoQWRNQldieElrcW1H?=
 =?utf-8?B?OHYvaDVkN0xZemQ3emZWQVNOSGFpQnhpRDB5VEoyZWRrelV2anNSVmhFLzFX?=
 =?utf-8?B?NFVDbFVXdDM0U3BiV1FCbDltM2VjYkNUckdualVsY0U0cHU4aXdFU2VjUlZX?=
 =?utf-8?B?cG0wbGtPSlh4cG9CYjVXVFl1WE0zK0IwZjJxUENHZTA5aC83RFNhNFZrZTY3?=
 =?utf-8?B?ZHFaNVJWMDliaDdUWXlwY0JxL3VzRFBrZ09QNHpvSGl0RzZpOHdUS3ZoSFdO?=
 =?utf-8?B?SHJwVUJBTUMyU3poYUpNYWpaY2VuSlBQTEhLVWwyQTNvT2hreS9lcUlwTGh6?=
 =?utf-8?B?MHBTSmsrTlZKbXBMazJPMHBWQUhEMm5UVVFtdDA1akI5cHd3SHFUNTdEenk1?=
 =?utf-8?B?eEpOd01OL3dtTjZ5dzJrZ1kweXBER21GMy85NzdUdGdUY3V2RTNWbkdtMGdX?=
 =?utf-8?B?d0VvL3dpL2JVRjNDK01sSktxK0JBaGhic29McHdqaTlYdDFxTmVxYlkvUFhp?=
 =?utf-8?B?SDMzU0RXSGwxQnVuaWNsajczYXRNOXdsKzZPVW9EVVM3SVNnMHFZRVNRdk9D?=
 =?utf-8?Q?RWK0GY8vHoY+jAE+VWhtG57VOk36GNa?=
X-Microsoft-Antispam-Message-Info: D4gUQOJ24exzIqo+9bOgvlohEA1OVBY13EvAKFnk+5C7iirVckf06wfqQJKkmPY2Y+ZADO/doFI9Q2SXALFfQqnYvzy/BdrHTn6rfcZ8U1uqt1EPGab4yh4/3qT7UOrbBWhlUtf5ZiaQiwO7vlOCj9P9Xp9U2VTPItbx3Gs4LVsV7HXFvlFYmZsqSqmfSWIICskpFuarDni0x41VSUBFz6FmOt8Ha3oM7jHLXl/rXBLGOK691SsPNZ9+9PTJ8r1MkLVwn7h89QBgxiA8OptCPY6w/EfjtiXHvWq/NnGfGwBsrYF+sMsohYEYC4BqoUF3XVox+OJ1I83zIvCNfsG4HRgxA9ChNrvD7Ym9YKdjECU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;6:8woKCLeEJ01fipiNpIpoRvc1h0Pww7lwLIQzweEpIYTatph2PH728fyQmew89Z1Z3o3b4v9wrrGFYWGzMIc/ni+eZiV9M5hswtbmsVCNVCBd/7fbc5o9Z45eN2Y8zHZgTZUWlBHM0DW/xoAM4IJg3Z7Gk1yvVs68Cay1C/ppkS0+D3wAtasBFKeH5gDR0Yuyb7CnQgfRDnS5pqc+fmFzoRmcuFk8N2uzly2nwYgdA5vH6XR9CGuJT76LXUE1B4KQBh57R73vxRbfY0sI54K7Cl/Sdy+NfG3s68dcZSJHyEqN/lVi8qw/WNRUp/9g7o2ZJWsvENzovHIBw0DFdgDaTh4KlVZebnEbC0owjM/bT2QLccKHy7UQKWgXApjmlxSpOYXQPFWiBe4jwTv5+rqzAStLjI4VIp0jAYPvrktQ2S7s4BukCd+GBgacZrKgq4C0TFUeyqH6wZipINvafc+gcA==;5:MUsGx0Z7SmYrMEbJqkSPRSNa4wg7N7RdpqtcRC/IQ6c7LhfW7kaaVJM+cl1h15FkFKHiPC925T3nVtSzKxZR47n4X4NdBeK1Tjayns3YHmeu9dwAq6bsYa5cCc7jX2fy3JoXBG7+4IFW1Lsddj3ExLSpbbXlssmnWALxx76EL+A=;7:uLE7Ir3IJoXMBKkp0byOhkjp+c6fFpsJOMrLPNb8/fhYcWqXtVLz6UaeFb3dU0Kmvsf4j2FA+7ATP/bx+ifnIYRliRqsaKMmzsxhgT8W9nJUbQH3r0aFBo1kX3sAlaFIwy4LF0rF5wLqFPWjzNOyv5NL9SsPm6INcLv+zI5Q+eINlpckn3bq9LjVMaRsRoJcwOMiea20qgfVRNDGa/f5CTQZA3iWkgZ+n+n1ebOInuSf3gIfuz9WBw3yTiZBgQnT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 12:20:11.3948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d44ac6d-f046-450a-c6be-08d62d18666f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 27.9.2018 09:22, Michal Simek wrote:
> On 27.9.2018 09:19, Geert Uytterhoeven wrote:
>> Hi Michal,
>>
>> On Wed, Sep 26, 2018 at 1:01 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>> On 24.9.2018 09:41, Geert Uytterhoeven wrote:
>>>> On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>> The function travels the lookup table to record alias ids for the given
>>>>> device match structures and alias stem.
>>>>> This function will be used by serial drivers to check if requested alias
>>>>> is allocated or free to use.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>
>>>> I know this has already been applied, it just drew my attention.
>>>>
>>>>> --- a/drivers/of/base.c
>>>>> +++ b/drivers/of/base.c
>>>>> @@ -16,6 +16,7 @@
>>>>>
>>>>>  #define pr_fmt(fmt)    "OF: " fmt
>>>>>
>>>>> +#include <linux/bitmap.h>
>>>>>  #include <linux/console.h>
>>>>>  #include <linux/ctype.h>
>>>>>  #include <linux/cpu.h>
>>>>> @@ -1943,6 +1944,57 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>>>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>>>>
>>>>>  /**
>>>>> + * of_alias_get_alias_list - Get alias list for the given device driver
>>>>> + * @matches:   Array of OF device match structures to search in
>>>>> + * @stem:      Alias stem of the given device_node
>>>>> + * @bitmap:    Bitmap field pointer
>>>>> + * @nbits:     Maximum number of alias ID which can be recorded it bitmap
>>>>
>>>> IDs
>>>>
>>>>> + *
>>>>> + * The function travels the lookup table to record alias ids for the given
>>>>> + * device match structures and alias stem.
>>>>> + *
>>>>> + * Return:     0 or -ENOSYS when !CONFIG_OF
>>>>> + */
>>>>> +int of_alias_get_alias_list(const struct of_device_id *matches,
>>>>> +                            const char *stem, unsigned long *bitmap,
>>>>> +                            unsigned int nbits)
>>>>> +{
>>>>> +       struct alias_prop *app;
>>>>> +
>>>>> +       /* Zero bitmap field to make sure that all the time it is clean */
>>>>> +       bitmap_zero(bitmap, nbits);
>>>>> +
>>>>> +       mutex_lock(&of_mutex);
>>>>> +       pr_debug("%s: Looking for stem: %s\n", __func__, stem);
>>>>> +       list_for_each_entry(app, &aliases_lookup, link) {
>>>>> +               pr_debug("%s: stem: %s, id: %d\n",
>>>>> +                        __func__, app->stem, app->id);
>>>>> +
>>>>> +               if (strcmp(app->stem, stem) != 0) {
>>>>> +                       pr_debug("%s: stem comparison doesn't passed %s\n",
>>>>
>>>> didn't pass?
>>>>
>>>>> +                                __func__, app->stem);
>>>>> +                       continue;
>>>>> +               }
>>>>> +
>>>>> +               if (app->id >= nbits) {
>>>>> +                       pr_debug("%s: ID %d greater then bitmap field %d\n",
>>>>
>>>> than
>>>> %u for unsigned int
>>>
>>> I won't fix this now because this can be done together with one change
>>> described below.
>>>
>>>>
>>>>> +                               __func__, app->id, nbits);
>>>>> +                       continue;
>>>>
>>>> Shouldn't this return an error, if of_match_node() below would have matched?
>>>
>>> IIRC Above check is for "serial" name.
>>> This one is for getting XX number from alias "serialXX".
>>> And below is checking compatible string.
>>>
>>> You are calling this function from uartps with 32 lines limit and there
>>> is serial33 alias poiting to uartlite (for example) then you don't want
>>> to break this call for that.
>>>
>>> What can be done is that compatible string is checked first and if this
>>> passed then ids are check and error can be returned or bit sets.
>>
>> That's what I meant: currently any serialN with N >= nbits is ignored, even
>> if the alias applies to the driver that called the function.
> 
> ok. Let me create a patch and check compatible string first and then
> setup bit or fail if N >= nbits.

I have sent a patch with this change. Let's have discussion in that new
thread.

Thanks,
Michal

