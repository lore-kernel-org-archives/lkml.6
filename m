Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86FDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C8B26824
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="p2ypzCZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C8B26824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935193AbeFZMZ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:25:57 -0400
Received: from mail-eopbgr30107.outbound.protection.outlook.com ([40.107.3.107]:39875
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933509AbeFZMZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqyT0xAj6YSnahmGpqB58xmA0XhNcJS3LSdzEPKdhkU=;
 b=p2ypzCZtzH2ZwTPHHdWfrooajgLbXqgS350Uo+lcR2V5TfPCXHxHKO9qawVR72jZDy3+vhyPef65KrU6wp8SlP8l/qR65qqEMFmdzjJn+OH+MEkNp5BmqS1P0eqO7ref77cnbnM1li5l4WgKYYs8ld8suE13goZhf8au2HIsRA8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from [10.145.177.144] (131.228.32.176) by
 DB6PR07MB3143.eurprd07.prod.outlook.com (2603:10a6:6:20::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.10; Tue, 26 Jun 2018 12:25:51 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: perf trace --no-syscalls -e rcu:* -- garbage in output
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <a67d93f2-ea36-b399-0843-8cd8fc190bfd@nokia.com>
Date:   Tue, 26 Jun 2018 15:25:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.176]
X-ClientProxiedBy: HE1PR09CA0068.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::12) To DB6PR07MB3143.eurprd07.prod.outlook.com
 (2603:10a6:6:20::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ee0e456-acfa-4c0c-a67b-08d5db5ff534
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DB6PR07MB3143;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3143;3:rb2dpZAlmhxb7fhqrVGJPsuC2XZF+T9WMyFDFSZeiCLog8odZqQIzA0Ws9PrLuDCKuaKSooQwmYkbVaZFG8tnoIOh1w0lVIMyzMCK5S6wkJFNoo56yTwtzxtMFlf05543cfGGk5LHLVxZ7W/8zGl0zLy4gIfUWQShqAZiH3FzZ0+5kh6Tgx0jKOIHdKivTWtlUTAmx0CsC5JaGjYDSKpPRzrHxYhT+vBYwNByaIgp1M0TA9ZTsWy4FlrPDzFvGiU;25:AAu1plzT9L6p588fsLCWupR8pXLhRsAxi3aR/iREKRfTLWHTH4Mo7SYnuGanhZLGwcucapFUwdwOOVKlnwmo1n/EprDJ+wsXgRpo66bQH9n5AocyUw4C0L3ktv0eWDP3IYzALfEn6DgB+qwgqrm8S4PYGcvKVqcpDz4UA8RgBZKcoyh9aCD0SeysRW41FcY5Bi+8LeqK43YPIVX2lk1B6TNOahcGkgs+7NtnPP3HnyqiZRkBDOOyh7Zd0FgQiFOdFOrxcDRyWncGjVMnraKU8UUb6d1LFPULdTRAgQmfpI/VaC20N35lZx5zGJ56kDuH4GpGnXMKmmxfSDQYAefx+Q==;31:Ple1HwmLi4kmc9uc6f6ERYO9hcJGfgUBas1KkPPM6PmCZTjFnBJc29r4U5WR95BROwSKkKm1gGWXKTpoCnX0Ia3bOW5IrxIN8yDz9nOMcRoOJtaw2vXNnWviE6R9S3TQ80X7QAMr6cE1DmlbbCdYcoH3BjgHwWyZfIGREd+3UIQqHjmB6L5fLg9H3/BTqW8fwsBQbMbdqNhHvaAwX0Gt6MwNQaYRidmNPtIRShKABgM=
X-MS-TrafficTypeDiagnostic: DB6PR07MB3143:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3143;20:ih9QSspetjQunqZ/icRjkGYlsoCqkrcJmxNVCAt15Jvg2AKGn4goNrtuiN+ujRAaS8x2J61eFk1OhL7nKPlwuvIC6coPK6hHp6djsAvn4jA071i4we74eI7bl6JtTVf86tRnN27IPbabn7ZlBs7hucpBDgzmLltMIUrS5VAJ66IqBPct6X18jmhALIE5PDFEp5cTWnDRaY5dpIo7b/owrSyXeHIlZ1YXayBgy2UpLRdHxSZjf+XpTecllhokG+IdTG3VKVXcMKFE0vhC9AVeazSbPzoTIrV1B0/4+KuFVVi1JvvWECHGSpO9pb5xQpzySNAu2RJJJfCVrBdm5VPeHAWlJhd98mOiJZS+H+dQ8RyiXYtTbAg3J9rXN+GKgeDVOSUI0nfa7PhkezeQjAWEEfozfpYHFD29WHsPWnPbKoBJQMSNUJ9bv3RrHgHhv4g/bkEQt+2AIMfulHgaz2F9zBld/X+a/y+xrZk2MsV0tKaCEXj5kbvtdro78agI7mox;4:NnvsAqLRLvyWVj8+qe1VLn0XN2vtNHweVn2LufNRHuU1nQZWcSQE+WD+fu9wF00B7w6l3+U1Jjqsvc7sfBi77aoYHsrtl0uziYeCAXxM7hJZYn9pQ7ZvuwqpBAJsSI9lPBeeX1dgTr0HJJsVII2HJ2tpiq+HMiqtRs6pE/TrZa4zVTuECneg8Jn1/vLHuRvzgkxC0r+9gNwrYYmWivfDEIt1+Cc9EQrNO2n4NYUiMs6Qw/SxwtlmxelaNPh02Ua0+9ZVcMuXF+lMUNTwSFQzvw==
X-Microsoft-Antispam-PRVS: <DB6PR07MB3143E342B2B27A318E7522CBB4490@DB6PR07MB3143.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR07MB3143;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3143;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(136003)(396003)(39860400002)(346002)(199004)(189003)(6486002)(2906002)(105586002)(31686004)(106356001)(65826007)(5660300001)(67846002)(230700001)(68736007)(6116002)(3846002)(16576012)(58126008)(110136005)(316002)(50466002)(386003)(26005)(25786009)(16526019)(186003)(77096007)(2486003)(66066001)(52146003)(4326008)(47776003)(486006)(476003)(956004)(65956001)(2616005)(36756003)(65806001)(64126003)(86362001)(478600001)(7736002)(8936002)(8676002)(6666003)(81156014)(81166006)(31696002)(97736004)(305945005)(53936002)(23676004)(52116002)(139154003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3143;H:[10.145.177.144];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUIzMTQzOzIzOnNpT2tNTTA3QVFZYTZ2QnRCT2J2VFVicHk2?=
 =?utf-8?B?ZTdDdG15VldDRC9IWlNBdkxENm9RTjl6NGtvakI3RElkN0xiYlpSRGEvU2N5?=
 =?utf-8?B?b3N5SW5FQjFXQ3FPeXFINUVQMm56cmlTMk44aklkcDVSVlVKSVhyQ05MWjda?=
 =?utf-8?B?SEVPUm5QYmFST05wVUhaWHdwZEc0Q0hOUU95b3RoaTU3RTRJRXRYNHZ2Qmlm?=
 =?utf-8?B?N1cyZTREOGhnTlNVUVl0djc3SFN4bmNGL1o5cFp4ZGVjR2VlNFI3VG4rK0RG?=
 =?utf-8?B?RVBQeXJnRmJjOUFyaitWOER5SSs5bFI5ZmcwQU4yUUZmbEl2VlhKV3dmSjZa?=
 =?utf-8?B?MmdTY2xWbE9hNFZlMG1TZ0RGYVNLMVFoQU9vRjJTR0lXdktsQmtSK3pGdWs1?=
 =?utf-8?B?N1NZVTVGZjROUStTdjZuU0lkRGtIOFZqK3RIdDVaVVFGU1MxVWx0eDBERC96?=
 =?utf-8?B?WFBZdTZDWnFaY1pNcVRFckFJUi9aNTBNZFFiSGFXcWgyQk1sQ3RReHRTQmxL?=
 =?utf-8?B?SEhodm5kdmt1Wm1RMXhqM2loR2ZRRmVibHNBbXduOXpDb0pvRnc3Nks0L3BT?=
 =?utf-8?B?alEyYVR2VHZNWnB0c3pydjlKaEVvQzJpRkdvbGZpRlA3cTFyZUxKMG1TUTVt?=
 =?utf-8?B?eWRyUCs5L1AyNHZBOHlOUnIyd0hPMmdldGR2YUZqb1pwQUJUaE9iYkJBbWs4?=
 =?utf-8?B?MkpMb0M0YnpRQnA2UE5hamlhVDZNSlNXSFdMbkhpbWZVUmVXU0N2QVBUMHhz?=
 =?utf-8?B?MXlibUdKa2tvdDRoWHRtUytDUHI5SG9rWWdLc3ExNG9xWGJiT0pMTTdHYjlQ?=
 =?utf-8?B?UUlDNVhZVVo5Y01oNisxZitWZEVSZFcwOTAydFJiZ1g4RmtrMkhHZE1YTTJI?=
 =?utf-8?B?WlQzSWwwWjJSR25pNEJqNUtFUmNDek43WHM5Mk9HREZsOTRTYUk1MFlDclhw?=
 =?utf-8?B?SVlya1Nob1EybEE0cjFUaDk4OTVWNUtGNFMwVEtKUCttVENuSnpVSjE5OEJ2?=
 =?utf-8?B?em9YY0pONU56VjUwdnMxSldkUDRwZTFPaVh2czFlYjFpUkZtaHJoTGhTaWU3?=
 =?utf-8?B?MDVNRGF5Q3dHUVpsbFhlRzRWS0JXZy9lTUpSWWF6U3FNZFZKUTdUdGhGU0RY?=
 =?utf-8?B?MHNjWmhwWHFUdFcxR2FJcEMxRmF5aEFjekx3RlN3ZFlYRjNYOUJXMzBXeExI?=
 =?utf-8?B?VWRZNzNtbHJyK0FJN2lVUytHRTJLV0VNZDh3di9nc0lSN1lDU2Y1b2JNZW1M?=
 =?utf-8?B?a2htYnFzdXlpVHBZendUTUhYQjNmODdkT1lBUjBjcDduNDVrWm12UTJTSVZ0?=
 =?utf-8?B?bWNHZTVtN3dCc0NjelhZNGs0OTFUZ3RNQmxnT0VoejRsM01UdHdLTWJlT0JI?=
 =?utf-8?B?ZUNDT1E2WVIwUG5laDZ0VEdLVGNaQzNSSHJ6cUNWTUFPcTduOFFOZzdwMjN0?=
 =?utf-8?B?R3BwcjQwQXdqTlhXZTI3bGNpaytlSk5QR2tGMklTSStLeWNPN2FOSkI5aGJa?=
 =?utf-8?B?Lzl6ZlgyVVZUb2p6Mk1HN3BJTjVNU0NRbVB3UGt1eXo2VmlFTldWeXliUDlU?=
 =?utf-8?B?YncvN2Y1Qlo5ZzdOeGVvcE5IV1gxeUp1TVMrWkpWUWw0L0lsWEJLMk5VK201?=
 =?utf-8?B?OEs4cDk2K2dDd3dXVHNQbzYyTExiMVhDTDE0bkRDY2dsSmNTZmVXYUVtNEpQ?=
 =?utf-8?B?REp5Z2dNbFZkWVRWRGZkKzNvdjhGZ0pTckVUSnNVV0RmU3J5NnJ2aXZiSUNi?=
 =?utf-8?B?am5BdENtb1AvVjNscVluNHhUMlh4NU9ERk1KK1RweVVMWVFUN012UDNhVmpG?=
 =?utf-8?Q?25OusEWdweO2c?=
X-Microsoft-Antispam-Message-Info: 4npf074OqRk9ijH3J4lUvgf0RCMvGljEJeuJZOqOv+d9MlQogIRe15m36dA6OFaPyVfYivOUFmAznjx29t4EuLt9dwOSq52O4j2vzCfRd33H0Nc71XBNJYjaS8iJgXc7ZenJT2PD8bv7n7gP3eiGWP5gUmVeJy9pIoAynlEjMHRsnr7kpJrc3lld1BulTcwfYdarsAJ6VWChGM3GIwDvx4BgY8d9jV05Jt0aL0TlR+j4oOkfsh1yYI/uAztPS7Ywl5+YrcrrISdXlcHUeRcN59nNhHsD3Q6ukYmWYSSwo0qbBdhsL8uLGfhBqbG0E5W1Va9FDI/HDNL3o0ZcC1KcJIyZMDM8ItWf0RpR9chAWGMXwxUmC+y4A+jbg3HsLWPD6YcUuLxBQ0XqqAaw2veSSg==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3143;6:UHhjpSqtySfnTQGERPn5U7KF4Q+JgIIsDmxlM5Ywl0YkNNFfeitBhwHU5wDbZUe+KYramJVv8ssgMH4OkFJPbQSMmZ/639tUt7LzVWkA65ZKQOfXcF+uowcU0X/ZNSrEqSPaqqnKbV0Ddu/xFNc7SfG1X0k30QlBlGOiRHAf53okIJntrU6RL6CML15z1L/Wtuw/HMTZDuljmbJjyEqaDo2DKQU0aK/V/cScg+MmcvYKjCLYSnGZwLLCq1y6YZ0goJYy4v0KtuKeq+5gocuhlhcvTEp92NDiaczQONwRh6FxcrMtmpo5jzbhahAHZQ3ph6dC+Hc5EScn/3IGZHjtkGyY5RSPlDg64L1TOYyeM2+Jg7Wr8dvUebfG+IyOaDp0cpvwbfLjpL6XapmIO8OUGQT5YCS4b+lBR/tXixGJ+iSsZLi0dgiih1BwgATywfvBVZw36V4eZANgBkRA+T7yGw==;5:LXwU+W9otE438F+XxgcBnWWob8DK6x8SxipPVgpBuVJg/010/2IfyXOZ2hrAUChsiuYu9RgNCiduYK+VLAsOeN3Tj8zWlvJGZ1zpMEmkYk4ueffHFGfgMLE6lHNU0FvkA05F0sDAYVWG9nYttredCoGfRdVvYVqvuWu/YFLmnHk=;24:2forSskLQSa1/1JBNLj7FS8Mh+2TdgPDfFD0LH+xb2slOxZcayssCPHb0mRpKTGmGjHRkgqGff8Vbh+4VM/FWQO3R2M2IDJ+ajIHYWyOkGU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3143;7:BTh4aCg0cmqLSRHxwC9WXuj+AMGjmUqdvQL1+xHMnY4pgfBnhCYIGVhpM5tZnNbkhZq3Yyc2wP7x2Lvn8dpCEhHLIG5z2tgZGpZRRslZ5uWZMF22IOYEe+ICDvT6PYQ6RiU58LKvXve+mOqV3rS0Z8CyIPT/5gn/HSps7Pui8cJTD218a3ohpnCLgjqiV4n9jzWL3/ka2gODnPDUQ8CGhVv1Xq8DkeAXiS52MJg54Z8ibNaEArIUS547kmwaBKlJ
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 12:25:51.0194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee0e456-acfa-4c0c-a67b-08d5db5ff534
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There some garbage in perf trace output, when tracing some rcu 
tracepoints (kernel is configured with CONFIG_RCU_TRACE=y).

For example in rcu:rcu_callback, instead of getting proper rcuname in 
the first "%s" here, there's garbage:

$ tail -1 /sys/kernel/debug/tracing/events/rcu/rcu_callback/format
print fmt: "%s rhp=%p func=%pf %ld/%ld", REC->rcuname, REC->rhp, 
REC->func, REC->qlen_lazy, REC->qlen

$ ./perf trace --no-syscalls -e 'rcu:*' -- sleep 1 2>&1 | od -t c

0000000                       0   .   0   0   0       r   c   u   :   r
0000020   c   u   _   c   a   l   l   b   a   c   k   : 200 351 345 215
0000040 377 377 377 377       r   h   p   =   0   x   f   f   f   f   8
0000060   d   5   5   8   f   5   b   0   1   0   0       f   u   n   c
0000100   =   f   i   l   e   _   f   r   e   e   _   r   c   u       0
0000120   /   1  \n                       0   .   0   0   8       r   c
0000140   u   :   r   c   u   _   d   y   n   t   i   c   k   : 373 217
0000160 276 215 377 377 377 377       4   0   0   0   0   0   0   0   0
0000200   0   0   0   0   0   0   0       4   0   0   0   0   0   0   0
0000220   0   0   0   0   0   0   0   2       0   x   1   d   2  \n
0000240                   0   .   0   2   3       r   c   u   :   r   c
0000260   u   _   d   y   n   t   i   c   k   : 023 220 276 215 377 377
0000300 377 377       4   0   0   0   0   0   0   0   0   0   0   0   0
0000320   0   0   2       4   0   0   0   0   0   0   0   0   0   0   0
0000340   0   0   0   0       0   x   1   d   2  \n
0000360   0   .   0   2   8       r   c   u   :   r   c   u   _   d   y
0000400   n   t   i   c   k   : 373 217 276 215 377 377 377 377       4
0000420   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
0000440   4   0   0   0   0   0   0   0   0   0   0   0   0   0   0   2
0000460       0   x   1   d   2  \n                       0   .   0   3
[...]


If I got it right, "pevent" in print_str_arg() is zero-initialized 
(pevent->long_size is zero...), causing "%s" format to produce garbage 
bytes instead of the proper string.

-Tommi
