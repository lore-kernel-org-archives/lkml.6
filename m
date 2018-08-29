Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3430BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB203205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="q7cubmdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB203205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prevas.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeH2RvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:51:08 -0400
Received: from mail-eopbgr70112.outbound.protection.outlook.com ([40.107.7.112]:61645
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbeH2RvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdLjyuV/KOa0FbmgAnWzDS/HVNQgEP73WxswYYSTVYM=;
 b=q7cubmdcanorkAgCGyLd85fYJaCH//RNe8DwRjRMkK3G/iyLOdhssjYYFDku6PmEhNLaQYHDKU5Ur5QDXCuCTw0BMTNa2hS8zWKCcunQ+xHy6whrY3FCULOIDHIAWd+W7Qkd404RFjBHLXqgl5N2PxNbkJJpmW0zKRvqsELtwyA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [172.16.11.40] (81.216.59.226) by
 VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 13:53:59 +0000
Subject: Re: reboot on wandboard fails with v4.14.67 (bisected to 2059e527a6)
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <Sean.Nyekjaer@prevas.dk>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>
References: <b2ea002f-4fe8-0738-b346-69ed138cecd0@prevas.dk>
 <b2505963-0fdc-81d2-6b8a-315a31eb922e@prevas.dk>
Message-ID: <d8dd8d02-b8ed-91fd-bcc0-87dedc5998ae@prevas.dk>
Date:   Wed, 29 Aug 2018 15:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b2505963-0fdc-81d2-6b8a-315a31eb922e@prevas.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: CWLP265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::31) To VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:e5::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f41f9b4a-90d6-46bb-c885-08d60db6dfa4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR1001MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR1001MB1342;3:cIgZ+SyneBk3l39etVor8ee+AeVlDOx5RMT302AHAXyibMT0pGuBTdM808AfLFqRqzWmYspMWCM7LQNx06PW5bCVs0wQxZAnUTbocLxxlLDGuFRy1cPbUOpGCjS7QNWA4ZDLHRoTpSksU72XKiA7a0cg+RHbNvlfWvrnb+8RNg734/FVp934mqoG46Q39QylQhB8hKkGTdwNPpGVRJg0d5o9g8Sc1mSSegTFdG+1qzuY0JHlA20UOjtTQFtYkNFk;25:KAHRVaR0mfcrV5dP9+bGUWl5bB9Ccy6mHUidrNQv7gvqnMwyqfL3/glV9UBvhlQ72Bs4N4lVZAqx51nEr8KsUI/auLWPIPEAkQFNS6eeo3T8QEvVORCFXPEsu1uJYjWzVLI3M0ss5VxvG428/pyOnZK5xmxkWnUl2rJ+LhN3Zufxg8LdpeVFxIOszQhpnQiDn2xIJnqPyU6zC/+fgeCWjWMQasRWfUEhwLE5I+XZ5jH0KHfvGQVwqNE7zPKPPasru+scA4ltY6blGNJ/tcRBmJT8e2c3d9B81XXzqh6nACzkhpCIB5xviMPv/3GgyviJCtGdn0X9HVUVYjQOZYyYDw==;31:KL49VLds7q51GNpVNceUd3ZnbkvfDFsnlG4h0VCVH+i+BRSHuaTbGsCUO657xNcf8Qw3EebMYsCm+rz+cTuCQqrV0tk7p8aSt5jyW/bqDn42Gf03nhELEAGmE+XgCzoAdJVsFTmTgo8bdvUmnpkDkp6F6A0moUdx9AvDw5IEsWdkrcopUlstzq5RcAG72EIVGALuoYDIqyYxOJsl42XiFUnHTts2qbHC+k/5OOhAGk8=
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1342:
X-Microsoft-Antispam-PRVS: <VI1PR1001MB13429C3115BE8B0F215D21618A090@VI1PR1001MB1342.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR1001MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR1001MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR1001MB1342;4:L8jjZlB/7e7OfUPUvP37ySn7IgDOcoO5U2oaIHodC8Cg28cM96JsRIJruN8M6l9/f73o8C+8fi8V8hEZvg83PhZwjpfyoWTm7x4Ud9J4C4DhJGp0Z6X7wj+Kf81duj7HqCZWu5wdbpuPKgj1g4pZOfDfUwSqCBWQOtOvIqEBsCMX/Hdhlf+y64W1oZ9eOwTAijFHWQcYbxX8Qc8dFSEwJ1egkdkQacJI5VMzWumsM3U1FHHz8LV1C06a30jCU5HTseQerBGsHZp6/1MisW79TQ==
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(76176011)(16576012)(36756003)(14444005)(54906003)(44832011)(16526019)(64126003)(58126008)(446003)(8676002)(53546011)(486006)(386003)(11346002)(26005)(2616005)(42882007)(25786009)(476003)(186003)(77096007)(956004)(316002)(65826007)(6916009)(31686004)(5660300001)(68736007)(305945005)(74482002)(230700001)(3846002)(7736002)(97736004)(6116002)(478600001)(72206003)(52116002)(6246003)(66066001)(229853002)(47776003)(6486002)(65806001)(39060400002)(81166006)(65956001)(23676004)(31696002)(105586002)(4326008)(52146003)(2486003)(50466002)(2906002)(106356001)(81156014)(8976002)(53936002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR1001MB1342;H:[172.16.11.40];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjEwMDFNQjEzNDI7MjM6SEVNaitKQzYyRmE1N0Uyc2JnWGpObjE4?=
 =?utf-8?B?cDIvdldXSVNrb2xoTnVaRDNpNmZPZ2wxTUJxWHV5cjA1SXoxL0xadkVIMXkv?=
 =?utf-8?B?RlJBRXpyTXdYTlZyakhrcjUrYWxMQlNxRVMvWVJCc2F2NXpSTXY5dEN5RENs?=
 =?utf-8?B?di9rNkVjcUoxM2ZFZDNYd25qOCtiVmpMS09WOS9oMm9lSlBIcTBCQUdUZVYv?=
 =?utf-8?B?MDR6TngzQytnV1ZrNUhkamdLenlQY2NWUjJZZVpwaFNVdGxEdUJIUEU5RGo4?=
 =?utf-8?B?NU5ZWFUwWHpmVmVnVEUzdTRXWDRWREd4QzlZL0E3ZU1pZDNzbjdub016TWF3?=
 =?utf-8?B?dWFkampDa2FIZW9yNjE5VEJiNmhrVmh0cUhMbG9CL1ZueUIrQ0hoNEw2RmhT?=
 =?utf-8?B?eEMvZzhHU3M5aWdJeDRGZDUyWnVlUnI0YW1GeDFxdk9mTVBVMDQyYkZPYVBM?=
 =?utf-8?B?TWt4WUp2enR0QkdGL21UYUtjY3FKZ3hxcVRaS1RoTUoyN1NFRWVFZHM3eXhO?=
 =?utf-8?B?NmRjWnhPczdFU0NZOU0vcDRnS29aVkVBWW5sVU9oTEtpQ0lObnRjcDRuMWtM?=
 =?utf-8?B?VTdkY1ljT2VjdnBhU2pIcjlMTFNTb25yc2t1eDNRbjMyQnBBVFZNSEVHTGN1?=
 =?utf-8?B?YUZKVDUyZVlrdHhuMStVQ3hzSXFGVkNoYnM0aExvQytUZExXckdCaHNtV1BY?=
 =?utf-8?B?L1JnMVdMNmpjNjMxVnB4SVZQdERhZURYTzI1QU5YUm93N3dQaWMwNys2RUNl?=
 =?utf-8?B?T3BGdE9kNjVCMXFTWXpBRDR3bUJud0U0VHNGMEVkNFNFWnh2WjMxR2M2ck9J?=
 =?utf-8?B?QXRpNzMyaW4xRm1WWTNLeERxV0dnSUtNNU1xQzJkMEVvbnVWUU9lMTBaUW5i?=
 =?utf-8?B?YkJnZTh4U0Nvd25UMElWc1Z1ZGw2TElzNkNpZWdXQ04zUDhzMlovU2RxL0pV?=
 =?utf-8?B?bTBSMkZVUHlQSStTSlgvSE9HcHhMMUo5RkNhSVd5aGNDckdUekdFNHE5R3Vj?=
 =?utf-8?B?QTUrUk1wS3NzTFJaZWp2ejE1dGVhQ2plUFBnQW5rYlkrWlAyUkxHS2ZnbHl2?=
 =?utf-8?B?YkUvWHN1MWs1dVpaZGdMZUhoT2IvYUdabDJGRGZKZVlVSmRFazhGK1VqeVZn?=
 =?utf-8?B?ckpWWlovbmg0ZFVSaFozamhrRVo5L3lOeDg0MnBIU3YxV1NGUThIZ1Nxem9L?=
 =?utf-8?B?NjVYMU9xR3l2d0xxMjN5aDVWeWFFd3ZXaWtBdG1PTjZPTC9wcFBDeTFTVDA0?=
 =?utf-8?B?NEpaUmdySjdITWdGbU9VZDBvYXZjMUhVVklHQlByWjJqbnlKM01BcTBNYUxM?=
 =?utf-8?B?OFZRYmZRS25udDRJS052b3hPemMwTFgxazRMUENsa0N1d05hbXBudWExQmha?=
 =?utf-8?B?Si9BSVB0RFg2Qlg1akhwaEtJZUdaUC9BUnZEOC9sYzN1UUM0SU1KL3ArWHZT?=
 =?utf-8?B?N29XMlhNTTczRGJtTE0wV21NbWswWW01RmZMSE4vTlNDdUplakFTcy9GYlM2?=
 =?utf-8?B?TFY4TStPS0VlNWh5UnV0dHFIMGEwcEtMcERxQnNTclZjT3c3aml3M2N0ZUoy?=
 =?utf-8?B?aFpvZmk0bkE4MTZOeENsdVNteHBpUUpETEZrTEpxQ010bGh5dWRkbks3elhj?=
 =?utf-8?B?Mko0aHNyMGVHeXVBUTQ5Z3F2Y0dmekpsN2x6cjQ3V1lYSW5vM0NRSFhQN1M1?=
 =?utf-8?B?MStvL09JVHpCZUpvejUwbERqczNqMTVrSjl6VG5KTmlPbUszS0tKVU1UTWR2?=
 =?utf-8?B?c2lieEw2c1ZEOHNqamxjdXFCM2lrVzNwZUhFcTl1QVN6bnhEOU9vZ21uWCs3?=
 =?utf-8?B?SWYrcUxMT2xMa3R4RVI3RktjcHRMclhVVE4raHVGL0EySEVjblE2TEVubWVG?=
 =?utf-8?B?bFJselAvWEUzVFhjOXVhNEZuNWxJZHozZ1RUZ3lMSjlNSnBRcHgrWlpNTmFq?=
 =?utf-8?B?cVp5Q01JaWVHM1VZWG12emo2OFB3eUVYQ29Qci9wYVdraG1ReXNzRVpYMG9L?=
 =?utf-8?B?T0k3V3FBZklabjZER2hzRDAxazV6VUtjWlBVZmdvNUI3aTVZa3IrT09Xb2c3?=
 =?utf-8?Q?HFOW3v0KDBENjk8zMGhAhE6prcl?=
X-Microsoft-Antispam-Message-Info: OKvptgkq+g4vJC/XMIPYD7sVcX8DAkSk256soG8R8rMmJeMolQcwys+jMDIgs62E3dmvsRRqS/gL3nOMZ0r4M+dD2FIz9sRp6q8g6V6T6YeGrO9RN0l5H7OeEjsJfQ6qubjSQht8w83wfX3sXCDQJoK+AIo9yYwWntw1BvHNIj1BC8kbKZNN6Fi+88L/AOgyTXgEFKdHf3TT/EXXsLrg4c3CFDw4OIx5/pzs5PiF/ZvCDZgeUYIFkKJq/RpApc5JnGCraz0bkn9Q7ehNg72JOPhjKFTDfg+rHNHE3JXkLbLe4wixZG+ghne4a5kILiyHTM8eeHc3MpRXqlTsANrzMOLXYX2c8NWflihjlc282nw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR1001MB1342;6:vMPd0x0kj99kjxwUQ3klX9JEhCU8HpCZ7OIkP7RcIr8kzw+XjIv4xhRswDv+cB0urhsRRf1Mil/XvQ7hHX2vEeqv/gJkr7J6Ix9AVCAFDVX+lfO5xA/IVMgtvPO9pyxYcCNBjl0EJexe7MAAH9ec/pOMWIJ3dv8pIEzK1pkHFApYabSeGAWULyI+1XViSQM3xTCX8jnycLbfxeY1nwkTiVtKDCdxWwvcSAUrJzA7n5gsri9LXXLcGSwu6PRjSk2PH1d0JIOfgvaA1GThcS6cgfOt5O6mQ7aI1uyD3DBUF010yjxYUhZxma3QkzYnjB5Wtce7eK8l/6WmjojYTyPD5ui6WxkAEITyHIniX85SgT1ndv9OreJJR+pGaypgUSqI8HSHuKM0wSgFgb7xiALL/XIO7PxsGfkwyyRjvc5HQfZgR9B1vpvaw6BUhbcg8WRJpnVKLmyIAARj8D3zbN+UZQ==;5:qgN3lbKMvJnBkz9KKm2AGrPt+YU76W/+l28JNw7RYYX8OTb0WJpXE6M9SazvOGkIscnUEJ653Mrtw4+zFJWJ18VZ9tP6yZOa+rxeeUQGVSk28WAASecCDFy1Ev+WVqQg2/9xNUIBqSLaVU7jEV0AyaHfnYZ91ULA0pnHHhKsr9g=;7:4raKZYK7dsFDxSQ5NF6oJ85VbAkIkaksSZmnjEbsQAirUb4MLowgNq5mxyLhGZAiyYzsuKULbCW3fACncp0BzZA1tvlgcIz4+k+rThokbl/CESMtOkkzRhCPZ7s3fHhf6DT5lhGH4RdmqofXZ2S+u3mEjtz+iPLLTboOyPDbTX9LNRyOAeDj8oX+Ivxd/lSnYk7Q08pVYaAe5autVPM+OAcm6lJfmoZZNQ9zcmmEZHwQzrc7k5XsLqPmWjtqPoqC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 13:53:59.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f41f9b4a-90d6-46bb-c885-08d60db6dfa4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-29 12:55, Rasmus Villemoes wrote:
> On 2018-08-29 11:55, Rasmus Villemoes wrote:
>> We're using imx_v6_v7_defconfig on our Wandboards. After upgrading to
>> v4.14.67, reboot no longer works (or, well, takes a very long time when
>> the watchdog is configured).
>>
>> v4.14.66 works fine, the breakage bisects to
>> 2059e527a659cf16d6bb709f1c8509f7a7623fc4 (ARM: imx_v6_v7_defconfig:
>> Select ULPI support), and reverting that on top of v4.14.67 again works.
> 
> FWIW, v4.18 (the mainline release containing the upstream commit
> 157bcc0609) works fine, while v4.17.19 which also has that commit
> backported (as df06ca1f56) fails. So I'm guessing there must be some
> other commits in v4.18 that happen to make imx_v6_v7_defconfig work.

OK, so v4.18-rc4 is also broken. Bisecting between that and v4.18 points
to a930d8bd94d (usb: chipidea: Always build ULPI code) introduced in
-rc7. The Makefile/Kconfig parts of that commit should not make any
difference wrt. 2059e527a6, since that commit explicitly set
USB_CHIPIDEA_ULPI, so we compile the same TUs with or without
a930d8bd94d. However, a930d8bd94d also adds this hunk

diff --git a/drivers/usb/chipidea/ulpi.c b/drivers/usb/chipidea/ulpi.c
index 6da42dcd2888..dfec07e8ae1d 100644
--- a/drivers/usb/chipidea/ulpi.c
+++ b/drivers/usb/chipidea/ulpi.c
@@ -95,6 +95,9 @@ int ci_ulpi_resume(struct ci_hdrc *ci)
 {
        int cnt = 100000;

+       if (ci->platdata->phy_mode != USBPHY_INTERFACE_MODE_ULPI)
+               return 0;
+
        while (cnt-- > 0) {
                if (hw_read(ci, OP_ULPI_VIEWPORT, ULPI_SYNC_STATE))
                        return 0;

and indeed just adding that on top of v4.14.67 makes it work again.

I don't know what the best fix for -stable is; the hunk above is the
minimal fix, but does not correspond to a mainline commit. a930d8bd94d
does cherrypick cleanly to v4.14.67, so might be the better option.

Rasmus
