Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F16C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954222170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="n4KPrGjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954222170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeI1CMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:12:15 -0400
Received: from mail-eopbgr700132.outbound.protection.outlook.com ([40.107.70.132]:30640
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbeI1CMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLMegx4ByRTa3wHXS4IDHQfLq2UkxmY97Isg8esi0Bk=;
 b=n4KPrGjs8wbjcCmqT1695ZNgE1N0rbwogMmlzHuunl51XqvROtIuSjub6NtfRI2NagWaIsyd1uFg+e8ZWICfqcw1lZqB0J/3WOwTD1UOCYdKqk0FTsJ9/cw86LaQ98dmCpAFHM9SPGMYNIxEaiNVF6oEs18aQrTQoMXQY0coQHM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0630.namprd21.prod.outlook.com (10.175.115.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Thu, 27 Sep 2018 19:52:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 19:52:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.9 20/57] media: sta2x11: Add video_device and
 vb2_queue locks
Thread-Topic: [PATCH AUTOSEL 4.9 20/57] media: sta2x11: Add video_device and
 vb2_queue locks
Thread-Index: AQHUTjMSP5cLDSpT+Ey8e+CjPHNa4aT0XNqAgBA97gA=
Date:   Thu, 27 Sep 2018 19:52:18 +0000
Message-ID: <20180927195216.GB69414@sasha-vm>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
 <20180917030340.378-20-alexander.levin@microsoft.com>
 <e7b48f4f81e249ee0d9b1d558d5285d09a4c9000.camel@collabora.com>
In-Reply-To: <e7b48f4f81e249ee0d9b1d558d5285d09a4c9000.camel@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0630;6:usBt4JCZzzn2XDpyAxBe14pyaZnYWIIrIPf0+4C7nR0OcHGriDYrSAmNV+XrfX25YxG35wpjj058WJmoAhd8NZappuU3dC6jgn9ySMvcSB8w4P/Ckt7+u1uywhApwFOQnBDD0vOhJAxMTGMy2avJ8juojlvi4fvwKaGpyw6M8rnf4Wnn9pUx1CygvH/mcHU8OBsIphgrCzUpXrp5sdPblNhuWZyowFWzKlmBlaHEcBwv4n+13GJqqt9kO1W4IzVUX6XEkOawq1qIVyR9fHelZdH6gkT7kTSe/yGws8loAkAAEn7LAu59tBY1vQkFYKUhb8W8fy9IEcKuFIKWwPiny0um2vjTtpp1Kty4/9VaQWN55I4tp0P5beKX1nQ1Tx88YFMP4AD4+uToL25aFLwNFtv6Pfv4MpiDHxR1S0C1VEyn/0YGOROSr36dQNemKzD80oi9rxacfUiWjrN3o9i7/g==;5:Uk69YlnLhrVDoV04GLqYCGNEJIpdrUG3E6Kxug1G31bhPo+6d+UQdoqyEbVeuUWKPzyydFEAcc/vrON0BJCr+h1pDzeBSLsONb3lCl/+3+3SZdm6CaG1LVwpi0J6IrFS94Dk1lfHz75DpRt7bIk1ig5C76PxxzK0X1HuIo3YJrA=;7:V5Bvc8NEEdCY4BXTRIV1uOD6F0GO92wr9en42l9nOofmIhJWgBBgRrzuM3NyIpcQbld8teBSHMEU0hBPYBwndoESjxYxon0zHXVWYSSnR3ukHlzFmcuO2eTs6yMGl7QIw3oCMXcYoiRdIelicwp5+yXYL8+3L6yQBl+AsnCLoEM+im+Pq8Xfrk54kmOmgi4B6+dpyvRGWONBOxLX8fZ8zy50/lH/kCrmvfR4VCze/amJiFKfzH0Go4wtW9Fa8Az6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3c8a597d-cf87-4492-6893-08d624b2bb4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0630;
x-ms-traffictypediagnostic: CY4PR21MB0630:
x-microsoft-antispam-prvs: <CY4PR21MB063088F453190B09B561D500FB140@CY4PR21MB0630.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0630;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(54906003)(256004)(33656002)(6346003)(33716001)(7736002)(105586002)(106356001)(217873002)(305945005)(99286004)(22452003)(316002)(33896004)(5250100002)(6506007)(76176011)(97736004)(2900100001)(102836004)(6116002)(3846002)(1076002)(4326008)(8676002)(8936002)(81156014)(81166006)(2906002)(10090500001)(6246003)(68736007)(71200400001)(66066001)(5660300001)(10290500003)(508600001)(229853002)(186003)(6916009)(72206003)(9686003)(86612001)(53936002)(14454004)(26005)(6512007)(71190400001)(34290500001)(86362001)(476003)(6486002)(575784001)(6436002)(486006)(11346002)(446003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0630;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EqT8I1Xy+YZYij55Z+fXVxXlxA6CugUwj4FM7g+iA5+3YIumUfHQjg7jhJFXJMWosBNhuY6Y/7cQ+CGeWKkUNAE62gbwQiRCb/3rzdJpwt4SCCn2LKGTB6cdjC3iJf1HOSlwvIWwf3tfmGFa24thxm+8hJXB5q83xY+GsdrJpvnL8K4UE8oifdfuQ2kq21BjPC1U0FQmjNLWgz3NjHKAYIU0JR6/zdDpkzngtLeTtoYDUs8lbmPEDIKDCwJuUo5DHCrNXze2ktkqqUukGJSnVxCjewXKBMb6eUcCk/b5CN0sG0mwE9cNFT/Hp5B1q8+Bt8W/PAZTv7HvD9QBqQebl1FuaTO6wErWzlfBg22ZEO8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD756B8ECEE38C4EAF0469966BF5568E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8a597d-cf87-4492-6893-08d624b2bb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 19:52:18.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:50:27AM -0300, Ezequiel Garcia wrote:
>Hi Sasha,
>
>On Mon, 2018-09-17 at 03:03 +0000, Sasha Levin wrote:
>> From: Ezequiel Garcia <ezequiel@collabora.com>
>>
>> [ Upstream commit cd63c0288fd760ce7de247fba618e2bbcfc0c35c ]
>>
>> Currently, this driver does not serialize its video4linux
>> ioctls, which is a bug, as race conditions might appear.
>>
>> In addition, video_device and vb2_queue locks are now both
>> mandatory. Add them, and implement wait_prepare and
>> wait_finish.
>>
>> To stay on the safe side, this commit uses a single mutex
>> for both locks. Better latency can be obtained by separating
>> these if needed.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>Hm, I am not so sure this patch should go to -stable,
>as it's not fixing a real bug we've seen out there.

You don't really need to wait for a report of this happening if you're
certain that this can happen in the "real world". Having a report is not
a prerequisite of inclusion in stable.

However, if you prefer not to, I can just remove it.=
