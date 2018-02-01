Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbeBAT36 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:29:58 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:46877 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbeBAT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:29:49 -0500
X-Google-Smtp-Source: AH8x2257hhPPO6pkCtm4c2y46VKuz3eh6p9ZXPjgNLicgydIGJcSsIddy7F5pzTQFCnn9FpXeCrbJA==
Date: Thu, 1 Feb 2018 11:29:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Mario.Limonciello@dell.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devices
Message-ID: <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180124104121.7g3zfay5smc5v2tc@pali>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

On Wed, Jan 24, 2018 at 11:41:21AM +0100, Pali Rohár wrote:
> Hi Dmitry!
> 
> I'm observing a problem with internal touchpad (handled by psmouse.ko)
> on Dell laptops connected to Dell E docking station. When I connect
> external PS/2 keyboard to docking station then internal laptop touchpad
> switch from multitouch absolute mode to relative bare PS/2 mode.
> 
> And because ALPS driver in psmouse.ko is capable to process interleaved
> bare 3-byte PS/2 packets with 6-byte ALPS packets (which handles
> trackstick data on some ALPS models), ALPS driver does not show any
> message about this "downgrade" from multitouch to bare mode. And
> continue working in bare mode.
> 
> When I rmmod psmouse and modprobe it again, then touchpad switch back to
> multitouch mode.
> 
> Mario told me that Dell Embedded Controller, which handle internal
> keyboard, internal touchpad and external PS/2 keyboard, automatically
> send RESET command to *all* those devices when external PS/2 keyboard is
> connected. Therefore this is reason why touchpad downgrade to to bare
> mode. And according to Mario, host system should issue vendor specific
> PS/2 commands to re-initialize all PS/2 devices when this situation
> happen. Mario also told me that Windows is doing this action.

Yeah, I remember fun with Inspiron 8100 - when you dock it it woudl
silently switch Synaptics touchpad into standard mode and it would not
come back as Synaptics until you disconnect. And there was no
notification to the kernel as far as I could tell.

It could be that we need to monitor dock events and then kick reconnect
of serio port, either from userspace via udev (I think that would be
preferred), or in kernel.

> 
> Every time when I connect external PS/2 keyboard to dock I see this
> message in dmesg:
> 
> Spurious ACK... Some program might be trying to access hardware directly.
> 
> I see it also every time when I dock laptop into docking station (to
> which is keyboard already connected). And it happens also when I connect
> external PS/2 mouse to dock.
> 
> Dmitry, how to handle this situation to re-initialize psmouse.ko when
> external PS/2 device is connected to Dell E docking station? According
> to Mario, this is how Dell Embedded Controller is designed and suppose
> how OS should work with it.
> 
> Manually rmmoding and modprobing for every docking/undocking laptop is
> not ideal solution.
> 
> Could it be possible to use that Spurious ATKBD_RET_ACK from atkbd.c be
> handled on Dell systems (probably via DMI) as an event to reset and
> reinitialize all PS/2 devices?

So we need to figure out what exactly we are getting from the docking
station in this case. We do try to handle the new device 0xaa 0x00
announcements:

	/* Check if this is a new device announcement (0xAA 0x00) */
	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse->pktcnt <= 2)) {
		if (psmouse->pktcnt == 1) {
			psmouse->last = jiffies;
			goto out;
		}

		if (psmouse->packet[1] == PSMOUSE_RET_ID ||
		    (psmouse->protocol->type == PSMOUSE_HGPK &&
		     psmouse->packet[1] == PSMOUSE_RET_BAT)) {
			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
			serio_reconnect(serio);
			goto out;
		}

...

I am not sure where the "spurious ACK comes from". Can you enable i8042
debug before trying to dock and capture the data stream from the mouse?

Thanks.

-- 
Dmitry
