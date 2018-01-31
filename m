Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeAaQrX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:47:23 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:34726 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753782AbeAaQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:47:20 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HvAAC28nFahz+a6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYMVgQOBBSgKg1aYT4ICggGHEZBLCoU7AhqCNVgUAQEBAQEBAQE?=
 =?us-ascii?q?CAQIQAQEBCgsJCCgvgjgigkoBAQEEIxFFDAQCAQgRBAEBAQICIwMCAgIfJQEIC?=
 =?us-ascii?q?AIEAQ0FCIoVAxWnIIInhzgNgx0BAQEBAQEBAQEBAQEBAQEBAQEBAQEdgQ+DTII?=
 =?us-ascii?q?Vgz+DLoJrRASBdhAGHYJdgmUFkkORHT6QZoR9lDaOLok7gTw2gXNwgnyCVRAMG?=
 =?us-ascii?q?XEBAnl4iw+BFwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HvAAC28nFahz+a6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?VgQOBBSgKg1aYT4ICggGHEZBLCoU7AhqCNVgUAQEBAQEBAQECAQIQAQEBCgsJC?=
 =?us-ascii?q?CgvgjgigkoBAQEEIxFFDAQCAQgRBAEBAQICIwMCAgIfJQEICAIEAQ0FCIoVAxW?=
 =?us-ascii?q?nIIInhzgNgx0BAQEBAQEBAQEBAQEBAQEBAQEBAQEdgQ+DTIIVgz+DLoJrRASBd?=
 =?us-ascii?q?hAGHYJdgmUFkkORHT6QZoR9lDaOLok7gTw2gXNwgnyCVRAMGXEBAnl4iw+BFwE?=
 =?us-ascii?q?BAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.46,440,1511848800";
   d="scan'208";a="122627404"
X-DLP: DLP_GlobalPCIDSS
To: <pali.rohar@gmail.com>, <andy.shevchenko@gmail.com>
CC: <dvhart@infradead.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap rather
 than globally
Thread-Topic: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Thread-Index: AQHTme5ImxMrC69/skeqoMXZgynY36ONHQsAgAD5pgCAABshQA==
Date: Wed, 31 Jan 2018 16:46:58 +0000
Message-ID: <bb29662337484ad8bd2350e6b68133d3@ausx13mpc120.AMER.DELL.COM>
References: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com>
 <20180130171745.i5wwcwr4qdbcoxhm@pali>
 <CAHp75VcqCdEQjUCoSGz87Mb3HFomfOwKWxC7S2CjtqSAZQEpsA@mail.gmail.com>
 <20180131090758.v6eyj35gymlfyzhk@pali>
In-Reply-To: <20180131090758.v6eyj35gymlfyzhk@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0VGlRNP016712

> -----Original Message-----
> From: Pali Rohár [mailto:pali.rohar@gmail.com]
> Sent: Wednesday, January 31, 2018 3:08 AM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Darren Hart
> <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Platform Driver
> <platform-driver-x86@vger.kernel.org>
> Subject: Re: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap rather than
> globally
> 
> On Tuesday 30 January 2018 20:14:26 Andy Shevchenko wrote:
> > >> -static void dell_set_arguments(u32 arg0, u32 arg1, u32 arg2, u32 arg3)
> > >> +static void dell_set_arguments(struct calling_interface_buffer *buffer,
> > >> +                            u32 arg0, u32 arg1, u32 arg2, u32 arg3)
> > >
> > > Hm... this function has too many parameters :-(
> > >
> > > What about following API?
> > >
> > > static struct calling_interface_buffer dell_set_arguments(u32 arg0, u32 arg1,
> u32 arg2, u32 arg3);
> > >
> > > It would return filled structure (not a pointer !)
> >
> > I do not think it's a good idea. Either we allocate request on a heap
> > and return a pointer, or we fill the struct with some data on spot.
> >
> > To naming:
> >
> > for allocation: ..._alloc_request()
> > for filling: _fill_request() / _prepare_request()
> >
> > or alike.
> >
> > _set_arguments() not good enough to me.
> 
> Ok. Then we need to stick with 5 arguments... What about name
> dell_fill_request()? E.g.
> 
>   struct calling_interface_buffer buffer;
>   dell_fill_request(&buffer, 0x2, 0, 0, 0);
>   ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
> 

The other alternative is to just define the input of the structure immediately with
an initializer, no multi argument filler function.  Like this:

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index ab58373..e7a971b 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -469,13 +469,15 @@ static int dell_rfkill_set(void *data, bool blocked)
        int disable = blocked ? 1 : 0;
        unsigned long radio = (unsigned long)data;
        int hwswitch_bit = (unsigned long)data - 1;
-       struct calling_interface_buffer buffer;
+       struct calling_interface_buffer buffer = {CLASS_INFO,
+                                                 SELECT_RFKILL,
+                                                 {0, 0, 0, 0},
+                                                 {0, 0, 0, 0}};
        int hwswitch;
        int status;
        int ret;
 
-       dell_set_arguments(&buffer, 0, 0, 0, 0);
-       ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
+       ret = dell_send_request(&buffer);
        if (ret)
                return ret;
        status = buffer.output[1];
