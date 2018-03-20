Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbeCTNMx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:12:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753019AbeCTNMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:12:51 -0400
Message-ID: <1521551568.16848.5.camel@redhat.com>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Woody Suwalski <terraluna977@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Date: Tue, 20 Mar 2018 08:12:48 -0500
In-Reply-To: <20180320080334.GA31772@amd>
References: <20180318104023.GA10392@amd>
         <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
         <20180319092106.GA5683@amd> <1521474008.20208.2.camel@redhat.com>
         <20180319173356.GA28462@amd> <1521481549.20208.8.camel@redhat.com>
         <20180320080334.GA31772@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-20 at 09:03 +0100, Pavel Machek wrote:
> On Mon 2018-03-19 12:45:49, Dan Williams wrote:
> > On Mon, 2018-03-19 at 18:33 +0100, Pavel Machek wrote:
> > > On Mon 2018-03-19 10:40:08, Dan Williams wrote:
> > > > On Mon, 2018-03-19 at 10:21 +0100, Pavel Machek wrote:
> > > > > On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
> > > > > > Pavel Machek wrote:
> > > > > > > Hi!
> > > > > > > 
> > > > > > > With recent linux-next, after resume networkmanager often
> > > > > > > claims
> > > > > > > that
> > > > > > > "network is disabled". Sometimes suspend/resume clears
> > > > > > > that.
> > > > > > > 
> > > > > > > Any ideas? Does it work for you?
> > > > > > > 								
> > > > > > > 	
> > > > > > > Pavel
> > > > > > 
> > > > > > Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
> > > > > 
> > > > > Thanks for testing... but yes, 4.16 should be ok. If not
> > > > > fixed,
> > > > > problem will appear in 4.17-rc1.
> > > > 
> > > > Where does the complaint occur?  In the GUI, or with nmcli, or
> > > > somewhere else?  Also, what's the output of "nmcli dev" after
> > > > resume?
> > > 
> > > In the GUI. I click in place where I'd select access point, and
> > > menu
> > > does not show up, telling me that "network is disabled".
> > 
> > Ok, what does 'nmcli dev' and 'nmcli radio' show?
> 
> Broken state.
> 
> pavel@amd:~$ nmcli dev
> DEVICE  TYPE      STATE        CONNECTION
> eth1    ethernet  unavailable  --
> lo      loopback  unmanaged    --
> wlan0   wifi      unmanaged    --

If the state is "unmanaged" on resume, that would indicate a problem
with sleep/wake and likely not a kernel network device issue.

We should probably move this discussion to the NM lists to debug
further.  Before you suspend, run "nmcli gen log level trace" to turn
on full debug logging, then reproduce the issue, and send a pointer to
those logs (scrubbed for anything you consider sensitive) to the NM
mailing list.

Dan

> pavel@amd:~$ nmcli radio
> WIFI-HW  WIFI     WWAN-HW  WWAN
> enabled  enabled  enabled  enabled
> pavel@amd:~$ uname -a
> Linux amd 4.16.0-rc5-next-20180314+ #31 SMP Thu Mar 15 14:27:19 CET
> 2018 i686 GNU/Linux
> 
> Let me suspend/resume. I was lucky and got it into working state:
> 
> pavel@amd:~$ nmcli dev
> DEVICE  TYPE      STATE        CONNECTION
> wlan0   wifi      connected    openwireless.org
> eth1    ethernet  unavailable  --
> lo      loopback  unmanaged    --
> pavel@amd:~$ nmcli radio
> WIFI-HW  WIFI     WWAN-HW  WWAN
> enabled  enabled  enabled  enabled
> paveamd:~$
> 
> Best regards,
> 									
> Pavel
> 
