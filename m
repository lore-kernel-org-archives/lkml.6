Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDEOec (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:34:32 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:50646 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeDEOe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:34:28 -0400
Date: Thu, 5 Apr 2018 15:34:06 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Paul Menzel <pmenzel+linux-ide@molgen.mpg.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Decrease boot time with AHCI drives?
Message-ID: <20180405153343.7962a1f0@alans-desktop>
In-Reply-To: <b0843e21-3e8d-0c00-b69b-16567dd3ee2a@molgen.mpg.de>
References: <b0843e21-3e8d-0c00-b69b-16567dd3ee2a@molgen.mpg.de>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But more importantly, it takes roughly half a second to set up the 
> device. I understand, that the probing is part of AHCI(?), and in this 
> case the Crucial m4 SSD drive/firmware is especially slow. So, I assume 
> it will be hard to improve anything in the code to decrease the time.

Probably. The OS basically waits for the device to flag read. It's not
that slow (spinning rust can take several seconds, and historically up to
30)

> So, is there a way to avoid doing the probing twice or at all? That 

You have to do it once. It's not probing that is slow. Your SSD is
basically a single board computer pretending to be a disk. It's go to
boot and load in and work out what the hell it's doing, what happened
before it died and so on. Spinning rust is similar - in fact with a
modern ATA disk plugged into a really old machine it's not uncommon that
the disk has the most CPU power 8)

Once you have completed the boot for that channel (so for SATA pretty
much for that device) you could in theory pass the OS a flag saying 'is
initialized, is present' and you'd be able to avoid a repeat reset/probe
and just go on to re-issue identify and similar commands in order to
re-obtain the configuration data of the drive. Those commands are fast on
any hardware I've seen.

This is known to work for straigt ATA - it's sort of what we do in the
corner cases where we find an ATA class controller we don't support. AHCI
is a bit more complex but the theory should hold.

Alan
