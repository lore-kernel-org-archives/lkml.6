Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25877C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80A9214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ONAeqMHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80A9214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJISqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:46:50 -0400
Received: from mail-sn1nam01on0065.outbound.protection.outlook.com ([104.47.32.65]:13440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbeJISqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UtAb4HWubIUhl45VXmKs5aFYqOFQgF+XUsat9Vfxng=;
 b=ONAeqMHR+m+wk5tQMnGC//iqhEdzcuxDosWT68v+SkcvPs9QYlKXDy6F9gTqvjzJiyyB+uu+5GytZcQ350214qg09P5hqnxZGr7zbbI+JfkHBPWv0VQ2zI2S6TyNxQcRoo1djn1oMRWNoQRBYW/++D2nvpWqdPDplfm2VNxf5cE=
Received: from BYAPR02CA0034.namprd02.prod.outlook.com (2603:10b6:a02:ee::47)
 by CY1PR0201MB1913.namprd02.prod.outlook.com (2a01:111:e400:527e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.26; Tue, 9 Oct
 2018 11:30:14 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BYAPR02CA0034.outlook.office365.com
 (2603:10b6:a02:ee::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.27 via Frontend
 Transport; Tue, 9 Oct 2018 11:30:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lixom.net; dkim=none (message not signed)
 header.d=none;lixom.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Tue, 9 Oct 2018 11:30:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9qDK-0004ks-0q; Tue, 09 Oct 2018 04:30:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9qDE-00076s-3A; Tue, 09 Oct 2018 04:30:04 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w99BTq5S015421;
        Tue, 9 Oct 2018 04:29:52 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g9qD2-00071K-GG; Tue, 09 Oct 2018 04:29:52 -0700
Subject: Re: [PATCH v6 0/4] drivers: clk: Add ZynqMP clock driver support
To:     Jolly Shah <jolly.shah@xilinx.com>, <olof@lixom.net>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <arm@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
References: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <65353e3c-035b-30ee-f93c-041885e112b6@xilinx.com>
Date:   Tue, 9 Oct 2018 13:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(43544003)(189003)(199004)(36386004)(47776003)(106002)(336012)(110136005)(64126003)(305945005)(6666003)(316002)(54906003)(486006)(106466001)(2906002)(230700001)(4326008)(126002)(11346002)(476003)(2616005)(966005)(426003)(44832011)(58126008)(478600001)(14444005)(5660300001)(63266004)(76176011)(446003)(77096007)(186003)(2486003)(26005)(23676004)(8676002)(50466002)(229853002)(31686004)(65826007)(6306002)(31696002)(65956001)(8936002)(356003)(9786002)(6246003)(81156014)(65806001)(2201001)(81166006)(36756003)(53546011)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1913;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT048;1:1c7h6Ay9t302xUjgeHmz9Bkc2GkagFMhf+UnTxpYXCidlbexITjgeFn3VyMX5JA/EFfb5+1qfyoTB2F7qTfF32q7mgBZM+l72y3zgUEnv0cr+po5R21lD75IBMgRbVzp
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5053bc2b-1e03-447f-f4c6-08d62dda9469
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY1PR0201MB1913;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;3:N5EvwZN6wnGGEZp/kO2CtMVVfGGwh4p7fPIvLULF9wp63lnUD2/bkv68nh2Xnk0F5GkosA4cBh56y9aNSDzXyJAWFSMbBhtshmkwbDLVYweNkFkHe9+KsvTv/dLKV+G/RebcFqRQknkrxnC3/wCrMJ8B48xkjE3DkN8NW18mxmEHjrU6SRr+TenKWgX/2sxEow6tdIKXSFFwbA5nvTwPs+qBRodQly9mTPUvpq1UW9Phqfjv03etiNQO4ZyGT6g1Ya+MHVcpnDTV2evwnq6723CdAyE1+/c4Rw+5SykeUidqhE7nnZnGHcwMsDBgrkX3oHmW0EzisPwoM0A7fnq/gbrToKm09wIaUwo7NqyqcJs=;25:sDVBLu/UYtvwIs+jXhqzMkt53kqSSp1Czpobm6+SQuoepm9XiVZlqgYHzk4rXcNALIGSc1eEZRieZB1A3FxIj9p9/fLlVyJi8mqzR8na5jLVcg6QJB8AYNi3nlkBLkcaBD6zEY0tu/lzhwPzdLF7cQCzc7peGdvALeTXJviuuUOyGn+lhmPM6TTp96vsYUJEzVH8z/YA9/5S7rXvDWii5cb3dOmlyzAlEioUFvhCNsqToOJVLHuMz4drmb4rCxI8zb1FtzLK8rgD3ubKWZtukBaE0t+qnnFoYGLq687+fYH33meIlaLD+nT4j1ZaUPiR8EfkzbxC1iIZVhnuPbGCHQ==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1913:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;31:K5aUqdLeG1sEeXFQIgTlelrRwSQi9HQcFp7Mg2dR8VjKEuGw+LAZaFB/xFfW1Br6jI1Mf7tlgSMqnl6fSg+i5cQtNmkdUFXANkf7U+L4jwkjnxIH0uhdfftRkF0CdepuSw6kwVINazkir5TjqPUjepE4kMSXVotqqBTHDG45uH29Ez+wz6l+bZLty/SUM64uSOut1idL9kfQtqPtv/5JHy2fy39WzrxyU35EEkSBQ+w=;20:aaQsxjS3g6rDwAl45kyAy7hEJJ5yRztx1dubHMfqejVkdmQVUIhIe7FOl6L2ooPrBstVffrdR2ow71bjG1WpvPkakjw05YgyZ/sMtA7PxMv95XsZ8hNjC/l0v+ddTW4p+upzeoua/nm0IGAavt1I/GOxnIbyY0ysVlXLDnDv7ATKGii0wmXIaiAA/d8rpBoMj964Ho50JeMDkHxFJuhU5ZfeKVt2pgiLGi8txw4op2AsSI6TVEciAuD3+Cs8BaBpLzOxq7jiM8nGF8weDNZhGkZOTY3V2rMRrl8ziPV3i98WZg+/ywFRYIiT8hKNUA0fzX9BkC7VGPkp+jcGHIBfUBJAUD/M/nIHhMjC1nKRaN4MnQP3NE5vzIflM4uXpRGSaXHolUZquoO/jyzak72+Z03PzwXm0rmThWKHU+JEmVfHxhSvMgOveyuDNQX/uhjDqyYb/b3DOCvrvS2ecGCdFazFptm9vDjKECnuc5PtyJlYimYc3PVa+7B3aO9chHKR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB19131BF62A0BF85CF9CDA740C6E70@CY1PR0201MB1913.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:CY1PR0201MB1913;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1913;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;4:xUFlFGUKxPsSyVi4pT6cdxvOrsOOJC2IFk2vKmqoqNuQ8wcQV2h4SjmE+5BUeAcrp5fW77HMeI0QNRYBXAVtGWX6p4J9+ZaCB0vd+ULVCM0f5c5anypBmSsOJgRt3ngscqcpk7TlFAWnYBWyhyZvZ+XpQmTR5YqH/rqPWJM4P0Q5QJNBRd7d4kVXwgRmqh6F32YxNpcVxW/rgmlljVa8AcQK9ssHKgMQpR71JZMNpqxempiK/ejPXf67i1BgTw7LAs5MJTbPKQDxvtawklvOaXyO5ylRtAGUAflS9t+nUJbzuuc6B1kLe6wXXLw9xxxn
X-Forefront-PRVS: 08200063E9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyMDFNQjE5MTM7MjM6QXBqL0ZkbVZYaWZaZ3E1cXNoK3BPZ2c0?=
 =?utf-8?B?TDVDRWRubFIyUGVFUE5pckJDd3p6QW5BZmt3c3c3S05vbDd5MGxlMTVvK3M2?=
 =?utf-8?B?KzR5U24vK3Z5RVhUdUdmWUVpOG5lMkZxcE01VzBGYkN1aTdSMmtwMFRKcCtP?=
 =?utf-8?B?dUtTV20ybkFXYnVrN3Z0OWlEcFRtclErTkxQN2Vzb2ZTUzZ0Tkp0SlFmSkM5?=
 =?utf-8?B?d1k0OGd1VGlzVi9pWmVmRXhFMWFQQk1aKzIyekJDKzZxU1BSM3h3dW1VVGll?=
 =?utf-8?B?aXczeTYySTUvLzJSRVBrV2lEYmhLUGtydVNEb0tnb1R1eUhSNjh5UTgvMnBE?=
 =?utf-8?B?VU1VRzBwM3FTbDlLMnNrTnlPU1h6N09hZ0FYc1BUbHIxWGN6U203cXJCOFpz?=
 =?utf-8?B?YXpiVHQvaHE0Yng1NUtMZFU3RVlxV05wUHhsVUluZkVCVGkxSFFUOTIvQUtv?=
 =?utf-8?B?ZW8rMU5oS1cxUWVwVjJiMzVMa1IwK2R6RXg0c0svYzZTa1dyQnE4cGoxUWJB?=
 =?utf-8?B?eDVFeS9ET29jMXdwMnArQVMrMG1teTNWY292T3BQeUNIYnJUZi81R2ZJNk1a?=
 =?utf-8?B?R3pjTEZLajM1T0tSUUp3ZmV2RWVWMVBOeFNNam9BMzNCbWZRNDNlM2dPVmMx?=
 =?utf-8?B?cXVJMzEvQUdjNFh0d1BwMlJLaVp6TEg0TXErMUNiK3BmbzhTSHo2WFptUm9i?=
 =?utf-8?B?SjJWUDU1KzFVSDN5ZW9RMENNS3hUbHZYTDRjcE40VFREaGtNeFBnN0YrdTJ0?=
 =?utf-8?B?bEJ3RHBBdlhpWi9raS9HNXZ3QXQvbkRyZ2d1Q1VQVE53SlpHK3hiYktVUEpt?=
 =?utf-8?B?cjlLYjZmZGMxMDRKMjFWaDY1YXNKRGorOVA0MFFWbEFJeHRBYUhjV0VkZ0U5?=
 =?utf-8?B?TFZPOTBHSlhHZjNLUWhsSEFHejZJNlZLaGxNNkVaMmtvdEc4V0FEUWxBaUl5?=
 =?utf-8?B?bEpsd1JDcnN1OW5pL2JSS3pGMFhyZjlQUUROUkRHQXU3eFVRck1qcmN0SytD?=
 =?utf-8?B?OGJmK05yY1RsSXZoSEt6TEhnS1E4UHhsZjQyUG1LQlhYbXZVd2hvMXFmTkJM?=
 =?utf-8?B?UC85MUdTV2FPTDhURjd1OUhJaHF2enlNaDhOT3JmeHBLSE5zTE1xdVp5TXJP?=
 =?utf-8?B?NjMxSjFmVmpXNEhiRkFXbUYwMTlISUN0OGREb01ZWm5iL0hHNkVXTk9hdllQ?=
 =?utf-8?B?MDFxSEZuNTREOHBQcSs2SGs4THRJZXhsOE1ibUNiOXNmYlFLcVZSNGxvdGpa?=
 =?utf-8?B?TllHbm5MWVlSUUNNSUV5bkdNQ0JSTjlwYmczeUJsVjVDV0hUSUNrSUExRkw5?=
 =?utf-8?B?MU5TWDgrbG5PUTg2RHJiMnF1L0l2dUYxVjVINGdsT0xZU2EvYVhJVlA5aG5S?=
 =?utf-8?B?NTU3c3FkM1JGNXBiS0N1czhQOWJGUlB4b1o3ZVNLUWsvWE5wRXl4RXVYT3Zq?=
 =?utf-8?B?eG9CdU8vdGJGMFpDQno1TXhQWVhOOHlPdGlwU0NpMWZXWEdHemhCZW55amVV?=
 =?utf-8?B?QlY0L0FESXNvR1ptSkthY3REWlY2Sks4RnBBUEJqdm93SU9sM01Fa3p4dFpK?=
 =?utf-8?B?RTNyTmtNK2RRNmRaWGM3MnhmUTh5N2lKK2hYVk5YQjFZMEh3a2x2WU5xQXcz?=
 =?utf-8?B?U2s2cGM4eVdLWUU1K29XYzVBSmtXMlJyN3o1ZkcvNkpnYXBJemRTMVBmZnlP?=
 =?utf-8?B?eDJXVm1lQ0c5dXpQUXpRVWt0OUdWOU9rand6K1hQY2Q3RHdOMmZFbWgrSVlv?=
 =?utf-8?B?ampJSzRBY3hRUTZzWXdEcWl1MmxnUTc4SDZjbXgwUHViZTQ3WHhlYkxudFpK?=
 =?utf-8?B?N1cxYUwwU0svNmF6NjlXTmNSL0syd2ovVW9FS2FZZHBhelFlYTNwbXVKdXZa?=
 =?utf-8?Q?LTCktzxegJXVd9pFaJJ0H3me1DW64j8Qgt?=
X-Microsoft-Antispam-Message-Info: gN/57ZExQ2nA6JFrS0nq1KtSlTuE9gkaYWnnNwdStgpwCs4UIH8fmJoxZZ+qWbpNngzqrZnijNoa/MRUk18sPpu9kQYqpNNSDOK8nhg29L5Br9CtInysEkoIdn/iSSlb1SxUtmp86gaFwhKl9CVP8mA9dgpetc/m5m6YFh393xiiMk7j9iJFyZ8OR0JOT+HbF2lP4CxEf6fcIsAjHDGN/DRBz1oAiz33KUi+/Kr5jT+2NqZY+oIct6Cd92ZhFtl+2/QPEuyDBQELt+7Kb45fNsbeUgn2o8vvow2+Q6J0gJfk7c5n4urQOac2qS/6KytxzxFWwHWEpB16aqp2q4qDCc+GLi7xRpyXHbwDHyRIqJM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;6:K74cqCnTiR023umYvo9SMrrGPGATGJ67PgFTZutu13gN/ty1a6TSu1HN57r/4rfOtMZ1U6N4cfQRhSTrYpTQKYI3sS9blDiLIu5g1A9PnMQk4QGV7KmEezROL3xldAjV7LgHeoYkzhTguA945+CuoW1KpG8NwuIudPm/tHtlgMTuapzPzTz6JI7sL7ZNVDDMZArXxsUlaHN94BkX+oXnp+U4NETBitKRSF8YRAIExKahw1q2tRQh9O4kKzyuRKAUQ8bAbyhXa41riwyl6cfX2hqtTg7BIcNC30x31Z4pMXTncDDXUJZcmDPsp6C/u0PofZqarJ/mb/56WbYJuhKJjTdW+UKZqBNMW6YVfOgGRB439qu3XVcYoFSmwaBdMfCCisfaUmYWWcujGTpcpVXRZWnagNAxrZCKw1yZ6IVXBcUs/03XWPJGS4vMuOhkmXmirrjABvYy7UPUBVPj56JQng==;5:eiRviVQ6NGVAOawUKUbcymefFPz9/Ha04HqVy2D34ysh43amd8DaDk88bOUNQfu37/gFYTx24z2hvfImM/ac+M6cFOyFN3O/LBJPplmtSb2w7Le0VT+EFwnN34kbpVNZtjqX+FUDn7HnunI4vcUwj+tg6wqk/FarPcPyTnJSomA=;7:j+KLmoHB+RRvGFlfiUx5GdnKBics2IUJmE8QhozLuQoH1i9Yu7k7/Pb7apzIhHP9OPOpuzXk4j/OW3CA0qvAO+R1yRUy4oJWsZw+B12WjQinLmLijWBYYm1FG0bsdtyt/kaKB0zFJabzUdErRDTjeAF02eaw8zVItTjQeD0wFrsP7Qz38+A/k/3/qncZTP/UNMyof33u+H6AJIZL1Sd4eyrk0VygeLGkoYvHiCSxBop4obaFLD6ugovsuoMACBNq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2018 11:30:10.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5053bc2b-1e03-447f-f4c6-08d62dda9469
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.10.2018 20:21, Jolly Shah wrote:
> This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries 
> supported clock information from firmware and regiters pll and output clocks with CCF.
> 
> This patch series is earlier reveiwed as part of FW patchset (https://patchwork.kernel.org/cover/10555405/). 
> FW driver from that patchset is merged. This patchset contains only clock driver and is based on top of 
> xilinx firmware patch set available in below tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=next/drivers
> 
> v6:
>  - Updated eemi return payload type to be u32 instead of le32 and Eemi ops in FW driver will be updated to take care of endianess
>  - Added Stephen's review tag
>  
> v5:
>  - Added "Acked-by: Olof Johansson <olof@lixom.net>" for patches
>  
> v4:
>  - Fixed minor review comments received for v3 patchset
>  
> v3:
>  - Added check to pass only valid ioctls for ioctl eemi api
>  - Added eemi documentation including ioctl details
> 
> Jolly Shah (1):
>   drivers: clk: Add ZynqMP clock driver
> 
> Rajan Vaja (3):
>   Documentation: xilinx: Add documentation for eemi APIs
>   firmware: xilinx: Add zynqmp IOCTL API for device control
>   dt-bindings: clock: Add bindings for ZynqMP clock driver
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++
>  Documentation/xilinx/eemi.txt                      |  67 ++
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/zynqmp/Kconfig                         |  10 +
>  drivers/clk/zynqmp/Makefile                        |   4 +
>  drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
>  drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
>  drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
>  drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
>  drivers/clk/zynqmp/divider.c                       | 217 +++++++
>  drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
>  drivers/firmware/xilinx/zynqmp.c                   |  42 ++
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
>  include/linux/firmware/xlnx-zynqmp.h               |   5 +-
>  15 files changed, 1919 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/xilinx/eemi.txt
>  create mode 100644 drivers/clk/zynqmp/Kconfig
>  create mode 100644 drivers/clk/zynqmp/Makefile
>  create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
>  create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
>  create mode 100644 drivers/clk/zynqmp/clkc.c
>  create mode 100644 drivers/clk/zynqmp/divider.c
>  create mode 100644 drivers/clk/zynqmp/pll.c
>  create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
> 

Applied all.

Thanks,
Michal
