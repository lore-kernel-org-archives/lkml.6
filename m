Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeCMMho (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:37:44 -0400
Received: from smtp-out4.electric.net ([192.162.216.181]:57801 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeCMMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:37:42 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'kieran.bingham@ideasonboard.com'" <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/11] media: vsp1: use kernel __packed for structures
Thread-Topic: [PATCH 02/11] media: vsp1: use kernel __packed for structures
Thread-Index: AQHTt/Mse9aYYpQGtUaBEbKHbOwP7qPOCieAgAAIH4CAAAymQA==
Date: Tue, 13 Mar 2018 12:38:33 +0000
Message-ID: <554b73e9ee2d43b19ac42ee380b7d160@AcuMS.aculab.com>
References: <cover.50cd35ac550b4477f13fb4f3fbd3ffb6bcccfc8a.1520632434.git-series.kieran.bingham+renesas@ideasonboard.com>
 <767c4c9f6aa4799a58f0979b318208f1d3e27860.1520632434.git-series.kieran.bingham+renesas@ideasonboard.com>
 <b58ff7ec7f7246498325e74b31ba3664@AcuMS.aculab.com>
 <8513c264-103f-94c8-cc46-972412d13da5@ideasonboard.com>
In-Reply-To: <8513c264-103f-94c8-cc46-972412d13da5@ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DCbq9H029349

From: Kieran Bingham [mailto:kieran.bingham+renesas@ideasonboard.com]
> On 13/03/18 11:20, David Laight wrote:
> > From: Kieran Bingham
> >> Sent: 09 March 2018 22:04
> >> The kernel provides a __packed definition to abstract away from the
> >> compiler specific attributes tag.
> >>
> >> Convert all packed structures in VSP1 to use it.
> >>
> >> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >> ---
> >>  drivers/media/platform/vsp1/vsp1_dl.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/vsp1/vsp1_dl.c b/drivers/media/platform/vsp1/vsp1_dl.c
> >> index 37e2c984fbf3..382e45c2054e 100644
> >> --- a/drivers/media/platform/vsp1/vsp1_dl.c
> >> +++ b/drivers/media/platform/vsp1/vsp1_dl.c
> >> @@ -29,19 +29,19 @@
> >>  struct vsp1_dl_header_list {
> >>  	u32 num_bytes;
> >>  	u32 addr;
> >> -} __attribute__((__packed__));
> >> +} __packed;
> >>
> >>  struct vsp1_dl_header {
> >>  	u32 num_lists;
> >>  	struct vsp1_dl_header_list lists[8];
> >>  	u32 next_header;
> >>  	u32 flags;
> >> -} __attribute__((__packed__));
> >> +} __packed;
> >>
> >>  struct vsp1_dl_entry {
> >>  	u32 addr;
> >>  	u32 data;
> >> -} __attribute__((__packed__));
> >> +} __packed;
> >
> > Do these structures ever actually appear in misaligned memory?
> > If they don't then they shouldn't be marked 'packed'.
> 
> I believe the declaration is to ensure that the struct definition is not altered
> by the compiler as these structures specifically define the layout of how the
> memory is read by the VSP1 hardware.

The C language and ABI define structure layouts.

> Certainly 2 u32's sequentially stored in a struct are unlikely to be moved or
> rearranged by the compiler (though I believe it would be free to do so if it
> chose without this attribute), but I think the declaration shows the intent of
> the memory structure.

The language requires the fields be in order and the ABI stops the compiler
adding 'random' padding.

> Isn't this a common approach throughout the kernel when dealing with hardware
> defined memory structures ?

Absolutely not.
__packed tells the compiler that the structure might be on any address boundary.
On many architectures this means the compiler must use byte accesses with shifts
and ors for every access.
The most a hardware defined structure will have is a compile-time assert
that it is the correct size (to avoid silly errors from changes).

	David
