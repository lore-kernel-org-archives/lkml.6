Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750923AbeEUE24 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:28:56 -0400
Received: from gherkin.frus.com ([192.158.254.49]:39846 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeEUE2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:28:55 -0400
Date: Sun, 20 May 2018 23:28:54 -0500
From: Bob Tracy <rct@gherkin.frus.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 4.17-rcX delays during boot and memory mapping errors
Message-ID: <20180521042854.GA1147@gherkin.frus.com>
References: <20180519003259.GA1114@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519003259.GA1114@gherkin.frus.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 07:32:59PM -0500, Bob Tracy wrote:
> Every one of the 4.17-rcX series has hung during boot at the point where
> "acpid" starts up.  Beginning with -rc5, the boot actually proceeds to
> completion after an "uncomfortably" long delay.
> 
> Attempting to run the X11 server results in the following diagnostic
> output in "/var/log/Xorg.0.log":

v4.17-rc6 took care of the X11 server startup issue.  The
"uncomfortably" long delay issue persists.  An observation as far as
differences between 4.16 and 4.17-rc6 during startup...

In v4.16 and earlier kernels, I wouldn't see the "random: crng init done"
message until moments after the system was done transitioning to multi-
user mode ("login" prompt on the console).  In the v4.17-rcX series, I
don't see a login prompt until all the events represented in the "dmesg"
output below have occurred:

(...)
[    7.314001] NET: Registered protocol family 10
[    7.315781] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    7.317359] Segment Routing with IPv6
[    8.667444] NET: Registered protocol family 17
[    9.130872] e1000e: eth0 NIC Link is Up 10 Mbps Half Duplex, Flow
Control: None
[    9.131839] e1000e 0000:00:19.0 eth0: 10/100 speed: disabling TSO
[    9.136947] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   78.567150] random: crng init done
[  102.974609] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[  102.982063] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[  102.983716] r8152 2-1.5:1.0 eth1: carrier on
(end of dmesg output)

As far as what I see on the console during bootup, I see the
"IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready" message, then
the system "hangs" until the "random: crng init done" message appears.
Then "acpid" startup and other events proceed normally.

Any idea what's going on here?

--Bob
