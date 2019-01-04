Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6065C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8097221872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfADHvW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:51:22 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:18909 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADHvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:51:21 -0500
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2019 02:51:21 EST
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id x047UgLF031945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 4 Jan 2019 07:30:44 GMT
Date:   Fri, 4 Jan 2019 07:30:42 +0000 (UTC)
From:   Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Salvatore Bonaccorso <carnil@debian.org>, 918036@bugs.debian.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>
cc:     Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v15 23/26] sched: early boot clock (was Re: Bug#918036:
 linux: uptime after reboot wrong (kvm-clock related?))
In-Reply-To: <20190104053013.GA6519@lorien.valinor.li>
Message-ID: <Pine.BSM.4.64L.1901040722540.14540@herc.mirbsd.org>
References: <154644530361.2390.18185252504260044930.reportbug@ci-busyapps.lan.tarent.de>
 <154644530361.2390.18185252504260044930.reportbug@ci-busyapps.lan.tarent.de>
 <20190102163939.GB13145@eldamar.local>
 <154644530361.2390.18185252504260044930.reportbug@ci-busyapps.lan.tarent.de>
 <20190104053013.GA6519@lorien.valinor.li>
 <CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Salvatore,

>p.s.: my earlier reply to you seem to have been rejected and never
>      reached you, hope this one does now.

if you sent from Googlemail, it may reach me in the next weeks or
never *shrug* they don’t play nice with greylisting. The -submitter
or @d.o works, though. I’m following up from my $dayjob address as
the issue occurred there (which is also Googlemail, unfortunately).

>There was now a followup on this, and if you can I think it's best if
>you can followup there.
>
>https://lore.kernel.org/lkml/CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com/

OK, doing now:


Pavel Tatashin wrote:

>Could you please send the config file and qemu arguments that were
>used to reproduce this problem.

This is from a libvirt-managed system. The arguments as shown by
“ps axwww” are:

qemu-system-x86_64 -enable-kvm -name ci-busyapps -S -machine pc-1.1,accel=kvm,usb=off -m 8192 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 -uuid 09536d92-dd73-8993-78fb-e0c885acf763 -no-user-config -nodefaults -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/ci-busyapps.monitor,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown -boot strict=on -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive file=/dev/vms/ci-busyapps,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 -netdev tap,fd=24,id=hostnet0,vhost=on,vhostfd=25 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:05:6e:fd,bus=pci.0,addr=0x3 -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0 -device usb-tablet,id=input0 -vnc 127.0.0.1:0 -device cirrus-vga,id=video0,bus=pci.0,addr=0x2 -device virtio-balloon-pci,id=b
 alloon0,bus=pci.0,addr=0x5 -msg timestamp=on

I’ve attached the kernel configuration; this is a stock Debian
unstable/amd64 system, just upgraded. After upgrading the guest,
I merely issued a “reboot” in the guest and did not stop/start
qemu.

The host is Debian jessie/amd64 (Linux 3.16.0-7-amd64 / 3.16.59-1)
in case that matters.

Thanks,
//mirabilos
-- 
tarent solutions GmbH
Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
Tel: +49 228 54881-393 • Fax: +49 228 54881-235
HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
