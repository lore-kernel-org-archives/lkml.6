Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D4621736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zkrdyJWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfBRKMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:12:14 -0500
Received: from mail-eopbgr690087.outbound.protection.outlook.com ([40.107.69.87]:62592
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfBRKMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFqXhlNDT/QnBqNCeY7xR9fb2DRIYnhfJRvF/FeAby0=;
 b=zkrdyJWeW5sJa39Gko/Dk8Th8OsZMD5bpE2kxMW88Cm2vrJjEHePzVBKdyEx3woVxA8sai3RCKqrruswQ/7ORyKisuHjLWIsony1nztX1GclDMjQACtchgw1VbsXb9NV1w5/mjapDzBZSgJqp62E+6QRllBvzb8eHk/bA1aBJXk=
Received: from BYAPR02CA0034.namprd02.prod.outlook.com (2603:10b6:a02:ee::47)
 by BYAPR02MB4630.namprd02.prod.outlook.com (2603:10b6:a03:5f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Mon, 18 Feb
 2019 10:12:09 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BYAPR02CA0034.outlook.office365.com
 (2603:10b6:a02:ee::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Mon, 18 Feb 2019 10:12:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 18 Feb 2019 10:12:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gvfuC-0002ZT-Mi; Mon, 18 Feb 2019 02:12:08 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gvfu7-0008CB-Ht; Mon, 18 Feb 2019 02:12:03 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1IABtaR026781;
        Mon, 18 Feb 2019 02:11:55 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gvfty-00084u-U4; Mon, 18 Feb 2019 02:11:55 -0800
Subject: Re: [PATCH] i2c: cadence: try reset when master receive arbitration
 lost
To:     Shikai Wang <sxauwsk@163.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190218094132.5226-1-sxauwsk@163.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4731eba7-7d85-62b9-2252-24ad55d75a0c@xilinx.com>
Date:   Mon, 18 Feb 2019 11:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218094132.5226-1-sxauwsk@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(106002)(31686004)(4744005)(5660300002)(50466002)(31696002)(63266004)(6246003)(110136005)(2486003)(65956001)(65806001)(4326008)(106466001)(316002)(54906003)(58126008)(230700001)(11346002)(47776003)(44832011)(14444005)(486006)(126002)(229853002)(2616005)(476003)(36386004)(9786002)(36756003)(8676002)(446003)(81166006)(76176011)(23676004)(426003)(478600001)(65826007)(356004)(305945005)(26005)(64126003)(336012)(2906002)(77096007)(186003)(6636002)(81156014)(8936002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4630;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96c46e19-f2d0-4294-7076-08d695898aeb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4630;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4630:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4630;20:M/0UIXnG5jzqkrUMhjvScF4Qlp/H5YVg3xXvRY5hjxbEwlS8Id3zG9Kc1LsKsfn3kBTbQGxCWvwJPN5DcCt2+w77m8nrkxfh5QXQ3oeCTwwZIj8U2eTpFSx6Zj1KwNh0dOvS2HV9TCWtLvjpLJbnj9C+enItC40r3PuAjIG7cCMYIhYZ0sIDDG8P3dKcpepeHnQNWImOMtG2u4u0heT5VvGHfHgj9SqT/0UOVevR2TQYfFN+FKlNZsTqte9O99rPsdZ20cOUTWd0eVMQLd/h+28koFxbOWEBGHcWy/KgJKTNqyKSFQOeZY78gpoFLwGfMD9QD1OwAIN/nGwApBeCgqHP39erYS3H1+fITbmRbt7sSMKSktMk2y/4tKLQCrK5kSyUcOT9YxNu7nyyP0xY1G+9+5ViElMTE3evYrMaq0A1m/a+itfXiiwi9PvrHmT1QwKq+4C9yirs/fZFdsoTJThbCU3HPBmCv0QsJNdtGX0iV/ilh1n0fowcAMw6jgWz
X-Microsoft-Antispam-PRVS: <BYAPR02MB46301982C637748DC052F94CC6630@BYAPR02MB4630.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09525C61DB
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NjMwOzIzOm5aek4zanp1ZWQxUGh1RWtXQXc0UHJOS0JH?=
 =?utf-8?B?c29KdTlQeWNxd0V1OXJJOTY0V2wwSXNTakhzT1NySDd5ZlpXa0F4MXV6dXJ0?=
 =?utf-8?B?cG1EbFN0cGlMamdnTW5PQnMyem5SeGo2eG85akd6YUpCemJVWGVYSmFrWmQ4?=
 =?utf-8?B?OTdxYnVLL2puV0hGRUVjK1VKTHBMTDRtZ0FyS3oxYXg0YkZ2bUpUemI3MkJu?=
 =?utf-8?B?R0I5eUtRdWc5dVNUbGRZRG5QTUkwcXg3dTJrT3NpZUNOQVZjR0tCVWlaZW51?=
 =?utf-8?B?UDJiK05sZ3BMZ3N2MHVmNXMzTFNDcWt5VmNwUGErTEMyYWlDc2RwTUpZTU5t?=
 =?utf-8?B?Y054TXBWNmp6Wm9NWWNOVmYySHRaT0k3TDMvRHBjR1pHNVVtd0h3cXZ6dXBu?=
 =?utf-8?B?ZktXNWd5L1ljTG1YUDd4bVVqcDJSZ0R1cXlIMERoOTJ0SkJpNEt5SUtWeGx6?=
 =?utf-8?B?R01WYWN3YkpnejhPbGpST1Vaa3oyTTFIclZLVCtZMEVDNUJGY3k0akVnRGRY?=
 =?utf-8?B?elM3UDcyLzR0TGVZa2dpaFRCeTJiaWd3bWlYQWNoUWg4TFBRNHFBMVo1aCtK?=
 =?utf-8?B?cnl0VXNlM295TXhUTXBHWWFwRDF6Y0FkallPWnEvYlE1Q3d4VjZnRVFyNmZx?=
 =?utf-8?B?YjRsTGcvMVpaZnJvNVVSOFpSRzZ1M21FREFuTHdaVU1hdkR0eFBqY2pjTHQz?=
 =?utf-8?B?dDV5cUpTbGNsLzJSV0x3OUtDdkhvWTlhTnVSdzJ3VVMxUUthb2MwbkNGbXNa?=
 =?utf-8?B?anZPS0kwUCtYNDJWVU9oYnlHeU40SGdJYjNoRW5pRlArUy9tRXBpTlBubWxO?=
 =?utf-8?B?Qjg2b3M0enNUUU81QUY5SFpDeXpMZ2VjandNR0xEbmNUMG81N3JmSnRHVUNm?=
 =?utf-8?B?bC8xK2F6RDRKMW9pUGJuTnh5eWZKeVFLMCtvQldGMUhVd0ZjazhLRzBmRFJJ?=
 =?utf-8?B?Kzd0QThwS3JrbzZhdEZrSGNZKzRZSnE2aFNaRWRQK1daVGZ1b1Q3WTRYTzd1?=
 =?utf-8?B?clpBTVpnZUZGNzY0UEdDSVJ5b09OcU4wWHNaV2VaL0Z6SmNmZDhVQnd5RlNn?=
 =?utf-8?B?QW5ZbVVTTWx4NDRoRmw4VWhsQjhzZXVVM1BxSUtvSnVGYkVFNUNQQ3RyZzhs?=
 =?utf-8?B?WmpOKzI1Y1o4RkFuWGN2NDdmZWVmWVRtaThPM2EybytSNTdZVVlJdTh5aWhE?=
 =?utf-8?B?MGMyRlVJeS9nK0szTFpLVWdDSEh0MlhrUVk5bXFoYWt1RGRaZFJ5MlVZcEJF?=
 =?utf-8?B?VmRPRnlTQzNhWWtWeGl1eHl5ZEs3NUxjTnM3aU9yRjN4V2I0Z0tScmFja2R5?=
 =?utf-8?B?d1ZVbzQ2aTVDRDV4YmM5bk5LZ0E3NllYYmZDRGhLdVNEcXU3WEpPeHhKOHpV?=
 =?utf-8?B?NS9qbkNwRlVqWEFPZlZOMk9vbHVsWmU5UVBOTUF0VWVzNUM2QjdSRU5TclRm?=
 =?utf-8?B?QkhQaXdPakw2YkpOUTA4OFMwQWc3eWNJcy8xTi8yVkdpcWZFQzZHMW5DV0Ji?=
 =?utf-8?B?eVNHVzU5ZWwxZEloOHlrR0ZVSlkxeDdTMDRxbnBWTzgxa21UK0VJN0thZnBE?=
 =?utf-8?B?N1htU25QRG1vWHJ3MFQrNmdCS0RycHBNMFhURTBPZ01aOTFTZkxkNFR4Q21Y?=
 =?utf-8?B?bTVjKzdNWGlqMEplYnZoeVpwZDdtZmhJSDZnalZUSnFmY2grck1UWXFnZy8z?=
 =?utf-8?Q?2HKAucLnZM+laPsJLdZ96JJdL5MV8wBIeBDlcdD?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QdwkLUz629VzmHN7FfusJN3CVLGg0gMJELmAMvBBfmBboFjm/JMjrto7VfY2s2X5dtCw2VVMQ4LJtHSnRtXW8UHEIzzY8pCReNyRCrGdrbvUBf4K/orKIspGdVlyPWTkI+8oq1SjHGd0JYcjSTD4vDOWcrG6AtND/n+tlBvs99TBj1redzjRtSLbQvCV9LGRYrh+fLLyhi595EPpCfOJTliyIICmhUgAjdhhuqB6UsjMqabdkjcRYqBcb+dch9oun6a+8I44+a8Y/EpcQSJnZ+gR1ORA72/q+8oH1Jw/KJPe6yUurWDma8hFwy1iUre7i4lqL0fK9qKup2TfLCFzP/m62fOhqenZd0xDQ9FasRWKFsXx6YEPy9eAnuy3210KrsBN9H5RlAkLWigREEzJeuZlW+cCx8RIHw6jkNBcZBo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2019 10:12:09.1235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c46e19-f2d0-4294-7076-08d695898aeb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 02. 19 10:41, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
> 
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.
> 
> Signed-off-by: Shikai Wang <sxauwsk@163.com>

ok. This is much better.

> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

I haven't see that Shubhrajyoti gave you this line that he is coauthor
of this.
It means you shouldn't add this SoB line if he didn't work on this.
He reviewed it that's why you should wait what he is going to sent.

Anyway based on email I see that this is 3rd version but I can't see any
version in subject and also description of changes.

That's why please take a look at this
Documentation/process/submitting-patches.rst

And send proper version. I would suggest to use v2 or v3.

Thanks,
Michal
