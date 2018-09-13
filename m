Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5812BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E790E20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sw8QPIwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E790E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeIMO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:56:24 -0400
Received: from mail-eopbgr50119.outbound.protection.outlook.com ([40.107.5.119]:37931
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbeIMO4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTLb3rdv8CXPiZqTk/BYkab9AZcIdD2vMX+hCGjx698=;
 b=Sw8QPIwQUSlihCIiRwgAXm6Yf7kxC9CumlHokQwhVelCAedVDWnut/vqmciVmRtXpd0oLpABHAC19IaxdRJGZahY7bureopLXpQZoCO4eTeOzRDw/GXZzITnB8LweggdewH7VrsQ8TcyyvVrM1SW26nBhFLQNVvWSf2Idc0gA0s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 13 Sep 2018 09:47:35 +0000
Subject: [PATCH] scripts/tags: Add DECLARE_HASHTABLE()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        const@MakeLinux.com, arend.vanspriel@broadcom.com,
        daniel@iogearbox.net, joeypabalinas@gmail.com,
        mawilcox@microsoft.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 12:47:33 +0300
Message-ID: <153683203215.13678.11468076350083405643.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:205::41)
 To HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 239ed43c-a8cf-400c-9eb4-08d6195defee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:GMPv4qmMPdlkreqU32o1HqF1gABexKtGkBBXefguAqcB8EdgzIXO62YVJ9ojUolfJv6ssVNMwyuVb/FRLe8sRJEb48rVExEu/TWD9Rxg8mFiF7Nt1ZAkSqMoEBx7IxwKDRCIEX02iCQgiAzQYZ60lNyQs4aEK95WE5Aa2e/wCOJracQgXeKutatB3ViXkxv1Kt6QUJ38nkFzixozxXQvOJlWBUnbsphKN+UFoo1MAXq9y+nvB3OYObNQa5xJU499;25:lTtgfwiJD7N7gEwPLI590yMVt2cci2u+pa/4/wqibjtLLpaDZKIn6F1kUvG06gPQun1f6YTdx8j6v+83QkVHmALD0kafYHY4HAgFPki6mnwTeETZ/QUTvGBOu1CpFMJEBWHXHze7yMfuKhed7azUai3zIFkThD82/ewwsbM3Pzf/yOGT3KFtEk13e0sdVofsiJR8tpuBapcgEEHC9hWbW6kPQAw3zvcn1g8Qi4ZxuBuD+SF2IJ/F2PlnPxl12HY/rquIfTEjL2SR0XjScOaXqiDi6rc7/8cFrZP/YXLb3nVzEww7SQ8KJOYiFMDPVL8aOuy5BuMwvhkID9nWJMLgEw==;31:S6n5Gn7z9mMdTL2ijxiAP6Z/vLo/FFeZ0aIZaGm03M0COHz+Dikb4ZpfeUMS2+jYKFG1XmTR/O5u4/vPkATCqxhDeD6nyM5S/CmzeOez95qQJGkxWMqaAbx9lL1CroOdXQjKTem1rIPHZ6C6iwKjCysu8povHC9vY8kduWlk8oZsaBUedBl3u8Da+vwioo/5yCJmjg1AWmT6/cgxAFM66KOLab22Qn3NBB7PyWYfPYI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:f1XXLZhk2LnrfqUpQUOVhAcu8LkEjz7LeItOTSdVPtxEXMHALK6MWPjKsFJhxpFv6UahlqB0ETjRbxLGeCENzMfVPXg3RHa+adk2KPFtlIllymjl4Dxz2DNbs3LcpZquOgQuzlEDaUmb0vZxJXKZ3HAK0+mkERBdCVZZ7S6ysOX6fN0wrEBSI2RC2ci7wpp8CPqSN9YSV7pCwD5+Gd3ubS+95ICn96/4mRwcOqrF542yt6dauNjQ3zuBEaNhDj9s4NPEem0uawp8559za1kpF6H1bVuROeTBhk7gPm31+gWumY/NNmra2F7nJSVlld7pAFx7+DUwmeL3QijRSPWJAa2VLQsgLqxtkTkMkXm7+tBXH+u+pxr4UBOMyfZwumyNyW1KicpTUjkkl4axU44kzhCnX1tS1YwTbD4LrTd/ljH0k5G9XyoqBceRKf7BKIBhvoek2DgAaPho7BF0kiHNTW6fnDg13XEZ2IfMMLvX5cnNHyunws8Ywz3Nvdte5OEi;4:gFSrTYOPPt9fAbWpFdlMJfYLzqUrDWgTR4KdxRZWpDvq5bQ9o5tnAfv8KuRriFqlz5HiEDCqtS4LeVBJ0bTPltMwekh/XU1Wd/IV8wzfDUolgMTT3S2BNtNmTmqS8X/kaae2zVlaeAK0NWMvZY/0ExWA+okkMWbrFa/dlo0CY+amlT6M91VJjuOBXaeg7l4tJCdZSnnLoXSPkuZy4M3Y3CYoMGHmOxsw4TIvkW1i7baM0t122Zy24YYwzjn8o8UShCIkwIBVi9t6Cq6OBedyEg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB202662A373439B108C54FAA4CD1A0@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(136003)(346002)(396003)(39850400004)(366004)(189003)(199004)(7736002)(305945005)(1511001)(55016002)(66066001)(86362001)(53936002)(6506007)(386003)(68736007)(33896004)(9686003)(61506002)(230700001)(47776003)(50466002)(3846002)(316002)(6116002)(81156014)(58126008)(956004)(8936002)(8676002)(476003)(23676004)(39060400002)(97736004)(81166006)(25786009)(16526019)(186003)(1857600001)(478600001)(14444005)(52116002)(105586002)(7696005)(2486003)(2906002)(103116003)(106356001)(26005)(486006)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6WVM0UlpLMHJiQlppdGUvQk5iSVdidUtV?=
 =?utf-8?B?UXYwYmNJZXdaWlNwVGxZaFZJSS9ubThmc3lYR1FMRmpOSFUzcnpvaEEwaGpP?=
 =?utf-8?B?VlgwRFl5UUtlSDIyR2ZLc1crdGhlTjhxYi9WbnZESE5ZYlFrS3MwRVhHRXFV?=
 =?utf-8?B?UzBodkRiRDE5ZjhmWlVnbWp2RXRUam5OSEZkWXVFSGV6d0xiazZYaGpVMTFI?=
 =?utf-8?B?amZtZDRRdXM3c3pHc2hRZTJza1NSRTdmMmtjTXdpSXFCL0R1dEgybnVOOGRY?=
 =?utf-8?B?d3YvSytDWTAxVUVTV3J3bDl2cDVTQTVwM2QyMkJvVWpQbkY0amRITzlHY1Fy?=
 =?utf-8?B?bW5EK1E4MUFMQmFld09pRXYrSTJ2a3BYSjFPdklOck5jMThHNU5LTng1b0FL?=
 =?utf-8?B?MkxuSUVrTXE5dTJ5S29KQ2JYMjVobWpEeFJneG53OW5PUE96cHJhV3VvNmRB?=
 =?utf-8?B?ZVZnbjdRNzhTelVnRDlKRE9mNVovcGpDNDcrV0ZWMTVvNVBUdFBBMlVURkp6?=
 =?utf-8?B?ekhuRkw2MjNMaGFHWnA3ZlFybjUvbDJmZ0xNaCtBemt1bE9uSmtpOVYxL3R1?=
 =?utf-8?B?NWplSVc3RVIzRWRPcEtObTgxbW1BVTRQUng5NGdPSTc0ak0zRldWeHN2Q2V1?=
 =?utf-8?B?a3BaeXVjRTBIQW5wUGlwdStHRXJTTktIa2pnMFF6RUk4b21NQzYwK0xkNkJP?=
 =?utf-8?B?YVBVZFhOdkZoVWZ2cFJlRlE0d3QrZjdJYkkyQ2p2RUZPUWQ4RWg0RGdOWHhH?=
 =?utf-8?B?eVRseVRXUkFsbCtyQ3BaLzdlTWJjOFBTdWhKOTh0dGNGakY4SlRESDFCWXFE?=
 =?utf-8?B?NUtQTFBPVm5jMzJtK2dvNldLMlZNWUhPTHVrYUJWYzFvdjJKVXk1SnZwYnJj?=
 =?utf-8?B?MzFDRFprSENLZFZ6V29FZHJSN2d1Y2hDQTl0aEFYN2NLRVFXcWRIS0NLOS8v?=
 =?utf-8?B?czA0MFc1Z2EvQ3lzUWFFVnM5M3hVWmhNbXRpUDEzdGNaMktVVFBCTzF6bnBo?=
 =?utf-8?B?K2NQN0JHbzVtc1BaZSt0UUlCSEFGZTllS0JVMVNXNGRhSElYUG94a1lLS01D?=
 =?utf-8?B?dEJxZFV6Sk4xTllRRjJLS1dJVnIvTmUzZ0t5WWFzRm5SM1JPRzZHWWlDR0d3?=
 =?utf-8?B?dEFaZ3BpTU5DaklBaUpRZWF6YmJUalFINUxPVXJva0xBNmkyY0xOQTJ6MEpP?=
 =?utf-8?B?Q01SMEE4WkwzQnB2S3FTSmZCeUV1TnVNd1ZicTQyUzFZbW5mU0hKNG04K1hS?=
 =?utf-8?B?VHdsSVJNSWdMS1loa2ZQMkF5T0pXaGhKb3hwei8relBXOG1jS3kwc3V6RmVz?=
 =?utf-8?B?SHRqUU5wU0xDVG9HVjZ3V0F2eHdicVJXSWhTZDBpOHdneWlFaVYzLzZDOTNG?=
 =?utf-8?B?Y2xmd0YvbnpPc3FDeklQelBiZTZEUmttaGJjSUFteXR5UFpScGNoUGdzaWtE?=
 =?utf-8?B?YlREaEFlZGx2UmRROHRBdWR3NmZ0K2tRNnpDaHBwMU54WnFGck5WSVJTY0k0?=
 =?utf-8?B?U3ora1ZJK2lqTzVRVGw3V2htc0R3YmVsNHpBQlBTQkpzMVJzclYxM0k0Vk9X?=
 =?utf-8?B?cUJMa01QWTI1dzBjS3hCMnpoWjVBQWJNVVdjUm1hZmdhdmxyNmxmTG00cXZk?=
 =?utf-8?Q?rmgEOy6GigYWbIfhwHWej9?=
X-Microsoft-Antispam-Message-Info: a5p842b6MX7vX0p2eXt3Yyd0tmqQaQEf1r3Szw6OcXTTGmEEEXmvZd/zfJZdkNHRO5Sx8wMp/GFaVaiZY9Cv1HgngeSIXKTJNINaQ1NE2OWhFXjW0ad0x0SjywoXTkUdIMpvNvZjg60wWB9XKK1LzS8usI2xZ6F/lXbRo/z7l+hts3FdHVmz+mfnccU3EW4nUQqaHYCykJb2M6IiBEeqwcx563+VTQ8e7ItOlNxUzGpaDBCiGlOJiJ+ufDjSUygHYoMDWN5r7JVFuyaTw3vhq8ahu3DXsLUdermTH/dURMZG/VznpWuhiKLY7OMdXcAyEO1czK6Geraqdo4mPJFu4wiyCny51qY50IRG+Mu8Otc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:cyyV21C8hELfmE3H7e7wEiDJkqoyrA+VKiu2Oh+xuiySn9DUHQYYSgYLl1qm91Gz1xuHUHCRjb6XMGuPoZmB9OsfNKox6x9H0nmo+dadfGLN6tFVvkUvNBLaLuwCTKjclW1/RSNwNzfC2BTPFtOuQmIb/abrn0RqVavXZKJWKDZJ8xH0nz2d0uh7KFho5N2rKmRC8tNFNI61PJABc1cHSXT6fz2pVcDEoIV8D8T0lMgMy1CuxIQH/h7SsNupJNUSdIMZZQ/gahMWWajbKCpEQsi1bx2X4Jvs3Eno6PrTQaCGcdI1AAV0CoimEs4sxbI8gqWUtdIxPgQpkC0r1xQnf8EssK8JObZf8GeiuQKBrNLHhE1HJDvYJwpUWwXYKsf+crNERsu7OgWf5Pr71LWVfk1JpSZ41XDiwWk54Y0CtPCm3ATCpGbmJOEm00ICRojMDrBx6AZJ/oIqFq49gKU6sQ==;5:8a0hdrb/ayloikBqA6ooE4pgM6+oC87ttL0Zxdt/nuhbjQx2O/n0Iqu/xCaMopG6kn8UH+mA82g74VojyATtHD+pznV3zSoVK6Ul7sCgbV434OGR8edFeymoFMSDGt20NJcTWMC5pt95bP6JLfPMlEaw8dbb/fn5Pp171lOtzd8=;7:PHA6TBElQOmeUTgoTkdmAeX2KoijFRbVjs9E0b8iVwGXdasv8wg6FpNBHEO+eANaDGzi0dF12/Oa5oa+Jl2VNBdiPg/9IqsNReQTKX0i0cxfkZPv9FLRlSGEqo8j+qqMCOczCw9EKQ/+MV7j2lYrpWJUEHGodvPcBANfD71I/301ghRX9ka6UglZBG+C6XtUnUuli0yG8UY0VbzAxhi8oHBobt0v2RzTR80lmcfw9d15fNva6AdSWVqUkUMF3RiS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:3RWNVw78ZpVogtrVwdnj6KOVf7DTToBAql7wiWzTsbXZ2zvqKNwyFUBCoiMUP7kYUbcnmZr35dUwhKyG+2NpTrqD11yR6I9vCzV4nPgQfLNRhTV4W9UB1ZwZuRYmVA0M2d90Xv2rTxM/TNSvPgdMtR5Km6S3ZkWJKs1IIjPsRyY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 09:47:35.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239ed43c-a8cf-400c-9eb4-08d6195defee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to DEFINE_HASHTABLE() add DECLARE_ variant.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 scripts/tags.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 26de7d5aa5c8..4fa070f9231a 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -203,7 +203,7 @@ regex_c=(
 	'/\<DECLARE_\(TASKLET\|WORK\|DELAYED_WORK\)(\([[:alnum:]_]*\)/\2/v/'
 	'/\(^\s\)OFFSET(\([[:alnum:]_]*\)/\2/v/'
 	'/\(^\s\)DEFINE(\([[:alnum:]_]*\)/\2/v/'
-	'/\<DEFINE_HASHTABLE(\([[:alnum:]_]*\)/\1/v/'
+	'/\<\(DEFINE\|DECLARE\)_HASHTABLE(\([[:alnum:]_]*\)/\2/v/'
 )
 regex_kconfig=(
 	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'

