Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032116AbeEZQBQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 12:01:16 -0400
Received: from spacedout.fries.net ([47.47.3.166]:56388 "EHLO
        SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031989AbeEZQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 12:01:14 -0400
Date: Sat, 26 May 2018 10:50:41 -0500
From: David Fries <David@Fries.net>
To: linux-kernel@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        stable@vger.kernel.org
Subject: [PATCH 0/1] media: uvc_driver: fix USB Camera ref leak denial of
 service
Message-ID: <20180526155041.GA4126@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch in the following e-mail fixes a reference count bug, it
seems to me that uvc_unregister_video is a good location to release
the final reference, I find it is called once.  It may sound like a
lot to plug and unplug the USB camera 250 some times, but in my case
"disabled by hub (EMI?), re-enabling..." kept unplugging and plugging
in the device until days later it ran out of minors and I lost the
video security feed.

With this patch, now that the device is actually being removed other
problems are showing up.  Specifically the following if the camera is
removed or `rmmod ehci_pci` while an application is getting video from
it.  It doesn't happen if the camera is not in use.  How do I track
that down?

sysfs group 'power' not found for kobject 'event10'
sysfs group 'power' not found for kobject 'input32'
sysfs group 'id' not found for kobject 'input32'
sysfs group 'capabilities' not found for kobject 'input32'
sysfs group 'power' not found for kobject 'media0'

-- 
David Fries <david@fries.net>
