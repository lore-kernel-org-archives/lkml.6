Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeEDKQi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:16:38 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52037 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEDKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:16:36 -0400
X-Google-Smtp-Source: AB8JxZqeO+s0MeDzZhfJN7FgtVyCT6X3OIHsD+IUxGkuKGfE0L0oMbVD2mKfoUE2AR8XukXqG8fWKg==
Date: Fri, 4 May 2018 12:16:31 +0200
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v9 0/2] hid-steam driver with user mode client dection
Message-ID: <20180504101631.GA7496@casa>
References: <20180416122703.22306-1-rodrigorivascosta@gmail.com>
 <nycvar.YFH.7.76.1805041008100.27054@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.1805041008100.27054@cbobk.fhfr.pm>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 10:12:51AM +0200, Jiri Kosina wrote:
> On Mon, 16 Apr 2018, Rodrigo Rivas Costa wrote:
> 
> > Hello! This is reroll v9 of the Steam Controller driver.
> > 
> > @Pierre-Loup, @Clément, could you please check if this driver is acceptable by
> > Valve? I think this could be the one ;-).
> > 
> > I've rolled back the synthetic LPAD diagonals. It happens that the actual
> > coordinates of the pads are rotated about 15 degrees to the center, but the
> > marks in the pad are aligned to 0/90 degrees. That, and my poor's man
> > trigonometry, makes clicking the diagonals quite unreliable.
> > Sorry for the noise, but now I think that we are better limiting ourselves to
> > the events emitted by the hardware, as is.
> > 
> > Other than that, I've doing some torture testing, with and without the Steam
> > Client running. I've changed:
> >  1. The way EPIPE is handled when sending a report: I've noticed that Steam
> >     Client retries up to 50 times, with little or no delay between them, so I do
> >     the same.
> >  2. I've added a fallback in case this driver is unable to get the serial number
> >     of the controller. Failures on any other report can be ignored safely. But
> >     failing to get the serial number was preventing the creating of the hidraw
> >     node (wired controller only), and that could prevent Steam Client from
> >     working. 
> >  3. I've received a mail from Valve with a bunch of constants for the
> >     protocol. Most are related to the setting of new mappings (that we do not
> >     need) and a few of the rest are deprecated. Anyway, I've renamed the
> >     constants STEAM_CMD_* to align them with the official names, and added a
> >     few more that were unknown to me, just for future reference. Still, commands
> >     used for enabling/disabling lizard mode are the same.
> 
> If noone has any objections (last chance to raise them), I'll be queuing 
> this for 4.18.

That would be great, thanks!

Now that my distro upgraded to 4.16, without the hid-quirks array, I've been
testing it a bit more. 

It works great, but I've noticed that I've missed a couple of lines when
creating the client hdev.  It doesn't seem to cause any harm, and anyway 'type'
and 'country' are currently both 0 in my controller; only 'version' is visibly
different but who uses that?

Anyway, this would be the change, I don't know if it is worth a whole reroll...

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index af7ebb618867..cb86cc834201 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -651,6 +651,9 @@ static struct hid_device *steam_create_client_hid(struct hid_device *hdev)
        client_hdev->bus = hdev->bus;
        client_hdev->vendor = hdev->vendor;
        client_hdev->product = hdev->product;
+       client_hdev->version = hdev->version;
+       client_hdev->type = hdev->type;
+       client_hdev->country = hdev->country;
        strlcpy(client_hdev->name, hdev->name,
                        sizeof(client_hdev->name));
        strlcpy(client_hdev->phys, hdev->phys,

Best regards,
--
Rodrigo Rivas Costa

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
