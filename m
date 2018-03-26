Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCZPeA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:34:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752197AbeCZPd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:33:58 -0400
Message-ID: <95efbba35c3389015d4919a59f8d01bc2d375a19.camel@redhat.com>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Woody Suwalski <terraluna977@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Date: Mon, 26 Mar 2018 10:33:55 -0500
In-Reply-To: <20180325061927.GA2148@amd>
References: <20180318104023.GA10392@amd>
         <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
         <20180319092106.GA5683@amd> <1521474008.20208.2.camel@redhat.com>
         <20180319173356.GA28462@amd> <1521481549.20208.8.camel@redhat.com>
         <20180320080334.GA31772@amd> <1521551568.16848.5.camel@redhat.com>
         <20180325061927.GA2148@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-25 at 08:19 +0200, Pavel Machek wrote:
> > > > Ok, what does 'nmcli dev' and 'nmcli radio' show?
> > > 
> > > Broken state.
> > > 
> > > pavel@amd:~$ nmcli dev
> > > DEVICE  TYPE      STATE        CONNECTION
> > > eth1    ethernet  unavailable  --
> > > lo      loopback  unmanaged    --
> > > wlan0   wifi      unmanaged    --
> > 
> > If the state is "unmanaged" on resume, that would indicate a
> > problem
> > with sleep/wake and likely not a kernel network device issue.
> > 
> > We should probably move this discussion to the NM lists to debug
> > further.  Before you suspend, run "nmcli gen log level trace" to
> > turn
> > on full debug logging, then reproduce the issue, and send a pointer
> > to
> > those logs (scrubbed for anything you consider sensitive) to the NM
> > mailing list.
> 
> Hmm :-)
> 
> root@amd:/data/pavel# nmcli gen log level trace
> Error: Unknown log level 'trace'

What NM version?  'trace' is pretty old (since 1.0 from December 2014)
so unless you're using a really, really old version of Debian I'd
expect you'd have it.  Anyway, debug would do.

> root@amd:/data/pavel# nmcli gen log level help
> Error: Unknown log level 'help'

nmcli gen help

> root@amd:/data/pavel# nmcli gen log level
> Error: value for 'level' argument is required.
> root@amd:/data/pavel# nmcli gen log level debug

This should be OK.

> root@amd:/data/pavel# cat /var/log/sys/log

It routes it to whatever the syslog 'daemon' facility logs to (however
that's configured on your system).  Usually /var/log/messages or
/var/log/daemon.log or sometimes your distro configures it to
/var/log/NetworkManager.log.

Or if you're using a systemd-based distro, it would probably be in the
systemd journal so "journalctl -b -u NetworkManager"

> Where do I get the logs? I don't see much in the syslog...

> And.. It seems that it is "every other suspend". One resume results
> in
> broken network, one in working one, one in broken one...

Does your distro use pm-utils, upower, or systemd for suspend/resume
handling?

Dan
