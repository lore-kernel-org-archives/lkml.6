Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94ECC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99C720835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qOwIqKdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99C720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeJIOex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:34:53 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:2464
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeJIOew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzuXUZ/IJ3vECGOAKgsTiYWAF83aIkgb1cBjixUDwcc=;
 b=qOwIqKdR7J8h+rErimQbVq/KJluV3zPUm2GzLhFgO/g1IJ2ikQjyopjYO8qdD1v1lgtcwILzFny914x6P9WsmbFZ1WbkLCEljWC6u553S18aYZxwuKR6qeG5gb/LgpaXa8fhfBvULGCyzX1St0iECx9I7Vq6HguaeYnlzWFB8aE=
Received: from MWHPR02CA0046.namprd02.prod.outlook.com (2603:10b6:301:60::35)
 by CO1PR02MB096.namprd02.prod.outlook.com (2a01:111:e400:101a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1185.25; Tue, 9
 Oct 2018 07:19:17 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR02CA0046.outlook.office365.com
 (2603:10b6:301:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Tue, 9 Oct 2018 07:19:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Tue, 9 Oct 2018 07:19:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9mIQ-0002Kx-Nv; Tue, 09 Oct 2018 00:19:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9mIL-00034a-IG; Tue, 09 Oct 2018 00:19:05 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w997Iuqf029115;
        Tue, 9 Oct 2018 00:18:56 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g9mIC-00032e-C8; Tue, 09 Oct 2018 00:18:56 -0700
Subject: Re: [PATCH] of: base: Change logic in of_alias_get_alias_list()
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <e879d07e97b7f7fc46543315e9fb1b4bc8b7a352.1539001154.git.michal.simek@xilinx.com>
 <CAL_JsqLNMM6mS1oy1voDAibRk1Srcp7i8e3pESTnM957Rxp4ow@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2bbc70c9-21b0-dfa2-ddea-554afb2c4f89@xilinx.com>
Date:   Tue, 9 Oct 2018 09:18:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLNMM6mS1oy1voDAibRk1Srcp7i8e3pESTnM957Rxp4ow@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(2486003)(229853002)(23676004)(446003)(44832011)(486006)(478600001)(230700001)(6666003)(76176011)(316002)(54906003)(110136005)(58126008)(47776003)(106002)(14444005)(31686004)(53546011)(53936002)(64126003)(4326008)(7416002)(2906002)(39060400002)(31696002)(8676002)(36756003)(81166006)(81156014)(63266004)(305945005)(65826007)(50466002)(97736004)(356003)(8936002)(106466001)(9786002)(5660300001)(36386004)(6246003)(336012)(26005)(65806001)(65956001)(11346002)(126002)(2616005)(426003)(476003)(77096007)(186003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB096;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT063;1:+mkIECbyn3Q1qF6p+f3B5Jc3U3Sbk9yG9x2p6rjFfWmUijviedkeAmUMTip8ys8RngmsyzavDG0Gbtxt3yXxhwtHnSbnF+eosfNyhX8dPuXg5cJQ5ujUktq5OeNoqwvT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adb74eb3-a05c-4402-4b9b-08d62db784fb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CO1PR02MB096;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB096;3:lJKVZuVDMG+x6ztGUHxcm223h9ouvm3nbw+jDmqHbF3EujFapIhqkv3kpzqqCfX9rxceasPLcz3BSjjv+YIyVQmAZ/BXfJIiBvTaaosQZgcn70rCN7BOZk6zmZaiKTeQNW/KblZnnWlMJgFUfzzm8xVuoWwyLK1pJPQt9a0+0gcqzmgODzvcq3cGqym4wiMbqC8K921/K/ruxowiifIRmbQbfulNf9Vrnl0jDkt09KGcqlMtOsDfBtHstUGfZ+dCXFADg2S7nXZ6Er48NbgcNvnH8XjFssjlg25izydXgP6wyc3+Zzcz8whhNshuLmiHPPQ1gLCHB1g6mffW5MpFO4LJ7jvjTZ8abuwNgIF97Po=;25:8SrFfZfxmF6fpammXw2vxVjSNvMLTEHzSJxhDBTOCM2b8f/6vdq6wY3BaDvqtt2tsxM+2tM+q8awL22PT4NpeII5JiiDqQvNTkpXhuNuT1YDHFQw3MyJh1UFyEq2y6vsIHFp2UR3/SRE3irSY2IYd2i6c1ZT5hfZP0bCshIiVyLwXk2ACTx7XwosXv2hX9x2i6+NYSZVZC8Rbkvkn6Pn/3nryb+2bC4nCrJ3Dt8X8K4C4trGMlUc9i/xic3n0IUIc9aEthGSjcYpyNNsWVzLzHhcvfkoYNsGqTFlYgoyXt385Vnjp+oPbyzexBZLv58BRw8aHc+wOyiwkzUfkcPFSQ==
X-MS-TrafficTypeDiagnostic: CO1PR02MB096:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB096;31:RVQ4Mpozez4eZlNpuiBeHyPGfHFiCwFkKg+YDLXQZhnekC6lf3972VadmgfOEUlJ/xtFfxIH0c2Lsmvc41CJhoTlSSxpBaJ+wu7hb/nJBrYpgMtC1ftdeqqkf2iVdwqSnXeBVJgA3pThyxvP7OrPMuk2BFtji9qyxwfNk8iQzbRdnIBuPT1QKhWiZsiV2D2x8m1o6Keio6bchU3w+xwgY5jUjym2WSic1amsS4DDJkQ=;20:fbzCdAxtstZLg2A2+kiVaJwmTRwAUX9oWNxv7p4arrFbNGA4LgNkaTBBtc3LsEEnnYUTLFeftSFdtRHN5wfKCM0kV+99J2QLfgdqwb0XoEIYkTviLbItjWqJBirt3C0L+83XxN2aR5cIJRHqRt1P7//AOcNe1zYwK6tYJjTU5NsEoY71OfBEmZnz2hq1ogwffJVmwVfJboErbSpNIV4TDwXLPJrM2Mcnj6KrZrFTL7ea0pOAeHtcrPERkfMYGiCNqtHatmDxoA3r5/ysitG1VegBtEA6Vo8F4+6Wwv43tgYHxQfFcHZFVUnFg9386+rlgnt7nBdrsH1tWKf4abIU/A7cBBwEB4jf71QnKikRsK56mR6SWtVkCyko0mNgV29og0I7fZHs6W87P6THTMpWMZ2x3I4oNjAeTTYyUvOfM+z+1wRNjtH6mX7TYrJgmsVAc9H8Ya4LogC3/KUxn8oLjyt4hP+1gizhA38vamPKhlLffIAjkFtXZ0CyqSKZDRYh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB0966C62922A5153A99A3E29C6E70@CO1PR02MB096.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:CO1PR02MB096;BCL:0;PCL:0;RULEID:;SRVR:CO1PR02MB096;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB096;4:5HDCp2SoWNs0kEprUywQtScDmzHos6xBWgHzDpjo+x0aoLWy/mXhxHdj61QDo1zhHlm8twqcL6qkBA4QCPDpvdJTV8GseSCWjASwhVio7seN1fcQC38XcvmmX/8JUQNU1XTjVwh8lQp2YqhvKAb2gvhTY7HvVEF6/4L6P2Axmb6ois3G1cxBAi9336InDOAY6VM84OImBfT6yCRogyIU9MhO43GUBLM9VcylHgywa9IJ2W4mIp/vsGenS6g2iFQAR5sRqAXJbj41ElgNGLSSuREtioU+RZjvxGAM3+5Kqbj2CFJK1jnCgax2pvOYpNDW
X-Forefront-PRVS: 08200063E9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzFQUjAyTUIwOTY7MjM6a2xWZFVlWVBvc1NNNC9CVUtjSVhmcDMvaU9C?=
 =?utf-8?B?aCt6YzNpVmRBT0VWWmVNS25MUW1CaDNuYXdBUzRHSXhhNmNVNS8wM1kxUE5S?=
 =?utf-8?B?R0Nzb2IzTklMZElLN3B0RVVNSFJKVE1nQm1XZS9PTmpRUmFORVgvdmprTjNn?=
 =?utf-8?B?YmRuMlpXWWdCeDkvekFtWHMwQUhwMzVXWlcvMUdVMWFmVTVkL2dsYVlhTkZ0?=
 =?utf-8?B?TWYyeEs1Q2diSTdQc3F3SVpsWW42bXhHNFloZGhVd0FBaUh1bmsvTjdONEd4?=
 =?utf-8?B?aUJOd0RZRFVtVFJEQXhmL3B6NzMvUTlIbHVXZzUzVVNiMm5aaDQ3VXg3R3o0?=
 =?utf-8?B?VUNDTm1aNVYvd0FHVUkxZXV5aHR3Yzkrcnl6T1JsVFlVNHk2M1ozSnZaTDRN?=
 =?utf-8?B?TVFKdVRCK2ZCL1BBZklUNStveG1qR0I1SGY5V1pnaXRobUVEdzJVYUJ1cXlT?=
 =?utf-8?B?eklUK2ZwS0NncUtPWlFwSzFpNzZBKzd1c0MzL1ZTUXNsY1pYNlpBTGlma1Vx?=
 =?utf-8?B?QU9BeWRGQVFOK25UeXNiUUxGOGFzRGdQNEVqKzVUYXlxWUVpb043UjdyNHBU?=
 =?utf-8?B?dmYwM2daK0cxb2dkN29PZ1Y0UEdZc0c5QUJBOTJwYXJuUE5CVlJNTkljSnl3?=
 =?utf-8?B?OWZtNXY2U0V3cmFXM1ZhWHYvTmxyQUF4Wk5Ed3hlWVJUV0MzK1ozeTJ5Znk3?=
 =?utf-8?B?RjYyS3U2TXdFY2ZBM0EwSWgrM2t5UmNGUkVmNS8xd2U4OVBFRmc5clJwcG56?=
 =?utf-8?B?aExIalF6aEJQZVJkbTRLd213OFRvREo0U0NiT2FGMUxmUEdyUVlCOFVOZHhh?=
 =?utf-8?B?QTBtNWhibm9oaGdYb2hHUWpSRTZaUWdNWkFycFVkWVB2eUVpN2tVZEp3Mms5?=
 =?utf-8?B?S0ZzT2NjMSsyZXNvZVpwTm1wb21US0ZhMkhXeXE0aGJiQkVGdk1RYUI2ZGhu?=
 =?utf-8?B?TGJ3NzMra2ZQRHRuZ2dETFZubVlscnQwcFdZY21yN3NxamNiQ2ppNU1Ld1BL?=
 =?utf-8?B?T1F6QTduUkdPWHhvbCtGZ21iUDBtRFpiQnRIUWM3RDF0WGgwam43byt3dmQr?=
 =?utf-8?B?dytvdGgwOHExVC9KZEVrL3NCK21LUWJPVVNMaG5TR2VMQUgveU5seko3aW1x?=
 =?utf-8?B?T1FKU29TSlVycFhMOU1reVNMVEp0anV0VzVDcjZtQ3JWaWIrNTk3ZUJ6dHcz?=
 =?utf-8?B?Q0MwSk1iQk5rekxITXM3M211RWgvMjBjdTZIQURDMUxQQWVseGNOblBtb0Fh?=
 =?utf-8?B?L0N2RzJIdjZ2YldoVjJMZ0ZpZytUVTdRdnhFeEwwM09tVVJjM2srMVE3Kys3?=
 =?utf-8?B?MVRhQldOMHlIQkZ3enlqYVF2THExbUN4MEdWN0RQdnRlRzFiS0E2dUlXZDNF?=
 =?utf-8?B?QjVNbXVWNlNGWXMzekNFQzFiTlRBZjI5d3NqaFRxREFuSDR6NjVwSCtRV1ov?=
 =?utf-8?B?MnU2dDhDT3hFN3RPNXhJQ1QxM012enNhNFkzNzJhODZZUEVaazkwbFVzdUFp?=
 =?utf-8?B?REk5K1FwQlYxTTNad1p4ZGlOWll5TzR1ZnowMk9xVS9WQk5uT0VMUmtYV2Y1?=
 =?utf-8?B?RW1FcnY5ZEUzdEJYcFFoVU5tS1Y0Nnp6TGdjTmF2ZXdvZmN2WlhiUFdGKzMy?=
 =?utf-8?B?RXUwVDZsMTBLc3Bsb3VLakNDcnlTeXZ2ZmEycitRd1BsTDR0d2c2VnhiSnJ3?=
 =?utf-8?B?NGNoQTRPNUhBK2theTlJV2xHeGtrd2NJYWRhanFnWDBMeVdvblpGRGZFT1Fn?=
 =?utf-8?B?d1hXdXdLQWZUVks1U09xWGYvY25YMDVIQmF4RnUzOTlkRDZxL21wSGxGSWlw?=
 =?utf-8?B?SkNQS3A5cmlXbi9ENUxGZE5hS1ZZdmp0TGVVWDZTSUlJSXJQMSt4U3RxVGFi?=
 =?utf-8?Q?gjZWDRaAT0=3D?=
X-Microsoft-Antispam-Message-Info: kmHJOCngH1awCbF5BeYpfQHvOPSoISspZRLO9JDFjP9EoP9kIH0AOYaTAZivQ8uRIV74++BJQxvhB2mAhU2UghchfGv9uQM2v+pSFOgypAyqRmf9vJ6MxiUBrEs8pcDJ+ThKfsi/A9STzxE7jdJGMP/8BTGuoy0etcSOaShKF1iE/ezCD7ZmSvuGbXDPvBQrakM/DXwTD43O4i8LSlhg6scmVJ336umCFEYXkEUYHcof/Neos+xOXbxffNIUT/uVW2EgX0sPUb26E0+KcW8Zci5HqN68TYrHGNVCqfJ9e91VVntrC1uf2KUtzAvdxgj66wM+ne+njpASMlD9GnXWKVzMXAgCdyNQtFaHnA1NgIk=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB096;6:OPGQdCr3vmZH/B8vVREiWQq50xc7WEYmsZwaEMeUiWkKc/zk8E7UFhvHFpC7WL/fGXnNQzWcK8CulxxLiQuXiZ0YOvO6Wiz5BaVMsP7Nd/UfZLhRq4OhQwfcPYPWbUQjJlVOjeVW4fYBUjnaRSetwT14stkQ7IgbiT/73dU/KxrfHrZLImIaCokHyXPTpwGyL7r+ilxF2MXM3wCFjV5VADnzcwFeMBZFu5rmKEYa8T1QnKQHAuy1gQL9izzKylkyBdmL6oru2UmWVnMKi68Vg6JktQW6MLxVmuiktzLQc1W4xKXyx3H85GD3IWBQxWlXSWzxYffNcd/XwpePGarlTqaNan5O4EGDYzaglTFoJMtxbN7j6yi7OAJeP5kXHEoBE7mcrImfwNnkkieJBSmTbwGk6+rM32aUaJRSoCuV8CpfdqXDdJD9rU7PakWUA0Yh+Vv3OzFHIg9+m7EbdWjgHA==;5:tP/FhNLay+s+ghbULvwZVhhi4XK3P2VEeJnzKRH3OV+4zkfswubSOYit21/00uxgCqHNWxS+fwgVfdh04cDahE5MoZDLcZX7YiK/qYrMcgHjhctVJaUdSxNHGB8rBe8wfojvWdXcB0eB/asj7rdDKVB0Uu/r0BKvv0ElzofX/vY=;7:ZCyFg7dQ8gAWIHd94SgH7igVJJ2kjcV7DuP1vt6kkmtBSghIuDVU2eb9yyPbz/FY4Or3ji+TzObgS63RByNtQwO/pLilCkUr/i5heRPOChEDkPi0KQ8s4PtXPZWv9Pu0wA2qD6u4k8QdDQto5DzazqHa9YX9co9eM7zPUF6KrEgy0bp/xEAAnOPoS0AFJAK9ENYqi1XBtCKO3C8W2XrFkSTPxNsPJPsI83wDnD64jMJeKP2z4MORrF1VpdudvFHf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2018 07:19:11.5637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb74eb3-a05c-4402-4b9b-08d62db784fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.10.2018 17:07, Rob Herring wrote:
> On Mon, Oct 8, 2018 at 7:19 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Check compatible string first before setting up bit in bitmap to also
>> cover cases that allocated bitfield is not big enough.
>> Show warning about it but let driver to continue to work with allocated
>> bitfield to keep at least some devices (included console which
>> is commonly close to serial0) to work.
>>
>> Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
>> Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> I have looked at it and I don't think there should be necessary to
>> report error immediately back with partially initialized bitfield.
>> The reason is that still there could be a console device which is most
>> likely below that max limit and it is worth to return at least that nbits
>> properly filled.
>> It will also enable cases that you can still continue to use aliases
>> higher then fields prepared for devices without alias.
> 
> Seems reasonable. Plus if you had a new dtb which added an alias
> greater than what the OS version supports, you would break that
> system.

I was checking that with our uart ps driver before I send this patch and
I found out that there is no reason not to support these cases.
Driver will simply find out ids which are free and ready for devices
which don't have alias.

> 
>>
>> To be fixed patches are present in tty-next branch.
>>
>> ---
>>  drivers/of/base.c                  | 22 ++++++++++++----------
>>  drivers/tty/serial/xilinx_uartps.c |  2 +-
>>  2 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 908de45f966b..0b9611e196d1 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1953,13 +1953,15 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>   * The function travels the lookup table to record alias ids for the given
>>   * device match structures and alias stem.
>>   *
>> - * Return:     0 or -ENOSYS when !CONFIG_OF
>> + * Return:     0 or -ENOSYS when !CONFIG_OF or
>> + *             -EINVAL if alias ID is greater then allocated nbits
> 
> I think EOVERFLOW or ERANGE would be better as those are less common
> and I take EINVAL as the caller made an error.

That's a good point I was also thinking if EINVAL is good reaction on
this case. I will use EOVERFLOW if there is no issue with it.

Thanks,
Michal
