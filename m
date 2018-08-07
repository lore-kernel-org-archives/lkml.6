Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E7CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4E621655
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4E621655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwaak.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbeHGLkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:40:02 -0400
Received: from gw-fsck-sorbs.kwaak.net ([84.245.27.153]:53161 "EHLO
        mail.kwaak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHGLkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:40:01 -0400
Received: from [192.168.0.44] (port=36557 helo=shell3.kwaak.net)
        by mail.kwaak.net with esmtp (Exim 4.50)
        id 1fmyFy-0002GY-N8; Tue, 07 Aug 2018 11:26:24 +0200
Received: from ard by shell3.kwaak.net with local (Exim 4.80)
        (envelope-from <ard@kwaak.net>)
        id 1fmyFw-0002GT-5J; Tue, 07 Aug 2018 11:26:20 +0200
Date:   Tue, 7 Aug 2018 11:26:20 +0200
From:   ard <ard@kwaak.net>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180807092619.GC23827@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
 <20180806132234.GA23827@kwaak.net>
 <20180806132725.ihbi5rxvkuuppajr@linux-x5ow.site>
 <20180806142414.GB23827@kwaak.net>
 <20180807065400.nxpndw4kf6jdd55i@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807065400.nxpndw4kf6jdd55i@linux-x5ow.site>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.168.0.44 (failed)
X-Kwaak-Spam-Score: -2.6
X-kwaak-MailScanner: Found to be clean
X-kwaak-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.304,
        required 5, autolearn=not spam, BAYES_00 -2.60,
        DNS_FROM_AHBL_RHSBL 0.29)
X-MailScanner-From: ard@kwaak.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 07, 2018 at 08:54:00AM +0200, Johannes Thumshirn wrote:
> OK, now this is wired. Are you seeing this on the initiator or on the
> target side? Also on x86_64 or just the odroid? I could reproduce your
> reports in my Virtualized Environment [1][2] by issuing deletes from the
> initiator side..
Yes it is weird, and it is even more weird when I looked at the
collectd statistics:
The memory leak was almost none existent on my test odroid with
the PC turned off. When I turn it back on, it rises to 150MB/day
So it seems you need at least some party.
The most important thing to realise: this is pure vn2vn chatter.
There is no traffic going from or to the test odroid (to the test
pc there is some).
If I disable the FCoE vlan on the switch port, the chatter *and*
the memory leaks vanishes.
Meeh, this reports needs a better place than just e-mail, I got a
few nice graphs to show.

But here is an overview of my FCoE vlan:
(Sorted by hand)
(GS724Tv4) #show mac-addr-table vlan 11

Address Entries Currently in Use............... 89

   MAC Address     Interface     Status
-----------------  ---------  ------------
00:1E:06:30:05:50  g4         odroid4 Xu4/exynos 5422/4.4.0-rc6    stable (330 days up)
0E:FD:00:00:05:50  g4         Learned
00:1E:06:30:04:E0  g6         odroid6 Xu4/exynos 5422/4.9.28       stable (330 days up)
0E:FD:00:00:04:E0  g6         Learned
00:1E:06:30:05:52  g7         odroid7 Xu4/exynos 5422/4.14.55      leaking (150MB leak/day)
0E:FD:00:00:05:52  g7         Learned
00:0E:0C:B0:68:37  g14        storage SS4000E/Xscale 80219/3.7.1   stable (295 days up)
0E:FD:00:00:68:37  g14        Learned
00:14:FD:16:DD:50  g15        thecus1 n4200eco/D525/4.3.0          stable (295 days up)
0E:FD:00:00:DD:50  g15        Learned
00:24:1D:7F:40:88  g17        antec   PC/i7-920/4.14.59            leaking
0E:FD:00:00:40:88  g17        Learned


The system on G14 and G15 are both long time targets.
G4,6 and 7 (my production server is on 5 with FCoE and kmemleak, but with the
FCoE vlan removed) are odroids doing nothing more with FCoE but being there.
(Waiting for experiments for bcache on eMMC, I used to be able to
crash the FCoE *target* using btrfs on bcache on eMMC and FCoE.
(Target was running 4.0.0 back then).
Generic config (PC and odroid):
root@odroid6:~# cat /etc/network/interfaces.d/20-fcoe 
auto fcoe
iface fcoe inet manual
        pre-up modprobe fcoe || true
        pre-up ip link add link eth0 name fcoe type vlan id 11
        pre-up sysctl -w net.ipv6.conf.fcoe.disable_ipv6=1
        up ip link set up dev fcoe
        up sh -c 'echo fcoe > /sys/module/libfcoe/parameters/create_vn2vn'
        #up /root/mountfcoe
        #pre-down /root/stop-bcaches
        pre-down sh -c 'echo fcoe > /sys/module/libfcoe/parameters/destroy'
        down ip link set down dev fcoe
        down ip link del fcoe           

The targets are configured with some version of targetcli (so a
big echo shell script).

This is on the 4.14 systems:
root@antec:~# grep .  /sys/class/fc_*/*/port_*
/sys/class/fc_host/host10/port_id:0x004088
/sys/class/fc_host/host10/port_name:0x200000241d7f4088
/sys/class/fc_host/host10/port_state:Online
/sys/class/fc_host/host10/port_type:NPort (fabric via point-to-point)
/sys/class/fc_remote_ports/rport-10:0-0/port_id:0x00dd50
/sys/class/fc_remote_ports/rport-10:0-0/port_name:0x20000014fd16dd50
/sys/class/fc_remote_ports/rport-10:0-0/port_state:Online
/sys/class/fc_remote_ports/rport-10:0-1/port_id:0x006837
/sys/class/fc_remote_ports/rport-10:0-1/port_name:0x2000000e0cb06837
/sys/class/fc_remote_ports/rport-10:0-1/port_state:Online
/sys/class/fc_remote_ports/rport-10:0-2/port_id:0x000550
/sys/class/fc_remote_ports/rport-10:0-2/port_name:0x2000001e06300550
/sys/class/fc_remote_ports/rport-10:0-2/port_state:Online
/sys/class/fc_remote_ports/rport-10:0-3/port_id:0x0004e0
/sys/class/fc_remote_ports/rport-10:0-3/port_name:0x2000001e063004e0
/sys/class/fc_remote_ports/rport-10:0-3/port_state:Online
/sys/class/fc_transport/target10:0:0/port_id:0x00dd50
/sys/class/fc_transport/target10:0:0/port_name:0x20000014fd16dd50

None of the other systems have an fc_transport, as they do not
have targets assigned to them (currently).
Notice that antec (PC) does not see odroid7.
The same is true vice versa.
All other systems see both antec and odroid7.

So they all can see eachother except for the 4.14 systems that
can't see eachother.

Now when I noticed that it only happened when my PC starts, I
wondered why it also happened when my PC is turned off, as I turn
it on once every few months and sometimes in the winter, it's
power usage is the same as the remaining systems combined.

And my next thing is: why did my production server seemed to die
less fast since a few kernel upgrades (in the 4.14 line).
I got it figured out now:
Before the heatwave, I had odroid5 turned on, my steam machine
(also with FCoE as an active initiator and 4.14 kernel) and the
PC turned off.  So that still makes 6 FCoE ports on the network.
When the summer came I needed to turn off the steam machine as
much as possible. This resulted in my main production server only
needing a reboot once ever week instead of every 2 days. I
attributed that to kernel fixes (as I knew there was a memory
leak, just didn't know where yet).

Thinking about that some more: do I need 4.14 systems to trigger
a bug within eachother, or is it pure the number of fc hosts
that should be bigger than 5 to trigger a bug in 4.14?

So a conclusion of my rambling:
1) you either need 6 vn2vn hosts *or* you need more than one 4.14
kernel in a network to trigger. One of the two. I need to think
about this. The fact that the 4.14 systems can't see eachother is
an indicator.  I can turn off the FCoE on some other system to
see if the memleak stops.
2) kernels up to 4.9.28 do not have a memoryleak. 4.14.28+ do
have the memory leak.
3) I need a place for graphs, I will see if I can abuse the
github ticket some more 8-D.
4) Just having FCoE enabled on an interface and
*receiving*/interacting with FCoE vn2vn chatter triggers the bug.
So that's only setting up the rports, maintaining ownership of
your port id.
5) The memleak itself is architecture independent and NIC
independent.


-- 
.signature not found
