Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeDQPEE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:04:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751187AbeDQPEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:04:02 -0400
Message-ID: <3ee2cc80d1ceeee472fe2f8392585e986620d5d9.camel@redhat.com>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Woody Suwalski <terraluna977@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Date: Tue, 17 Apr 2018 10:03:59 -0500
In-Reply-To: <20180415161604.GG10802@amd>
References: <20180318104023.GA10392@amd>
         <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
         <20180319092106.GA5683@amd> <1521474008.20208.2.camel@redhat.com>
         <20180319173356.GA28462@amd> <1521481549.20208.8.camel@redhat.com>
         <20180320080334.GA31772@amd> <1521551568.16848.5.camel@redhat.com>
         <20180325061927.GA2148@amd>
         <95efbba35c3389015d4919a59f8d01bc2d375a19.camel@redhat.com>
         <20180415161604.GG10802@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-04-15 at 18:16 +0200, Pavel Machek wrote:
> On Mon 2018-03-26 10:33:55, Dan Williams wrote:
> > On Sun, 2018-03-25 at 08:19 +0200, Pavel Machek wrote:
> > > > > > Ok, what does 'nmcli dev' and 'nmcli radio' show?
> > > > > 
> > > > > Broken state.
> > > > > 
> > > > > pavel@amd:~$ nmcli dev
> > > > > DEVICE  TYPE      STATE        CONNECTION
> > > > > eth1    ethernet  unavailable  --
> > > > > lo      loopback  unmanaged    --
> > > > > wlan0   wifi      unmanaged    --
> > > > 
> > > > If the state is "unmanaged" on resume, that would indicate a
> > > > problem
> > > > with sleep/wake and likely not a kernel network device issue.
> > > > 
> > > > We should probably move this discussion to the NM lists to
> > > > debug
> > > > further.  Before you suspend, run "nmcli gen log level trace"
> > > > to
> > > > turn
> > > > on full debug logging, then reproduce the issue, and send a
> > > > pointer
> > > > to
> > > > those logs (scrubbed for anything you consider sensitive) to
> > > > the NM
> > > > mailing list.
> > > 
> > > Hmm :-)
> > > 
> > > root@amd:/data/pavel# nmcli gen log level trace
> > > Error: Unknown log level 'trace'
> > 
> > What NM version?  'trace' is pretty old (since 1.0 from December
> > 2014)
> > so unless you're using a really, really old version of Debian I'd
> > expect you'd have it.  Anyway, debug would do.
> 
> Hmm.
> 
> pavel@duo:~$ /usr/sbin/NetworkManager --version
> You must be root to run NetworkManager!
> pavel@duo:~$ sudo /usr/sbin/NetworkManager --version
> 0.9.10.0
> 
> So I set the log level, but I still don't see much in the log:
> 
> Apr 14 18:14:29 duo dbus[3009]: [system] Successfully activated
> service 'org.freedesktop.nm_dispatcher'
> Apr 14 18:14:29 duo nm-dispatcher: Dispatching action 'down' for
> wlan1
> Apr 14 18:14:29 duo systemd[1]: Started Network Manager Script
> Dispatcher Service.
> Apr 14 18:14:29 duo systemd-sleep[6853]: Suspending system...

I think if systemd really is handling the suspend/resume, you'll need
to make sure NM has systemd suspend/resume handling enabled as well. 
NM 0.9.10 has build-time support for both:

[--with-suspend-resume=upower|systemd]

while later versions also support ConsoleKit2 and elogind.

Any idea what your NM was compiled with?  Though honestly I'm not sure
how all the suspend/resume stuff is supposed to work these days on
different distros that provide the choice between systemd/upower/pm-
utils/CK2/etc.

Dan

> Apr 14 21:27:53 duo systemd[1]: systemd-journald.service watchdog
> timeout (limit 1min)!
> pavel@duo:~$ date
> Sun Apr 15 12:26:32 CEST 2018
> pavel@duo:~$
> 
> Is it possible that time handling accross suspend changed in v4.17?
> 
> I get some weird effects. With display backlight...
> 
> > > Where do I get the logs? I don't see much in the syslog...
> > > And.. It seems that it is "every other suspend". One resume
> > > results
> > > in
> > > broken network, one in working one, one in broken one...
> > 
> > Does your distro use pm-utils, upower, or systemd for
> > suspend/resume
> > handling?
> 
> upower, I guess:
> 
> pavel@duo:/data/l/linux$ ps aux | grep upower
> root      3820  0.0  0.1  42848  7984 ?        Ssl  Apr14   0:01
> /usr/lib/upower/upowerd
> 
> 									
> Pavel
