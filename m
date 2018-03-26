Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCZVIt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:08:49 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:45294 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZVIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:08:47 -0400
X-Google-Smtp-Source: AG47ELun4fspMB70H7a8vdfVnde95pjWnCw/shKRWmiB3B0bJ3A4A0QAuV4tucPWgN/HsykTQq7rDPDqlxnGPk535s4=
MIME-Version: 1.0
From: Timothy Normand Miller <theosib@gmail.com>
Date: Mon, 26 Mar 2018 17:08:46 -0400
Message-ID: <CAK7bmU-P0siz3pD9cHeuKMzK0PHZd4R8XqFDKswVkr4hwZ=-2g@mail.gmail.com>
Subject: HELP PLEASE: Without ugly hacks, no interrupt delivery at all to our
 driver; 3.10.0 kernel (RHEL7.4) on Intel 82X38/X48 chipset, Shuttle
 (SX38/FX38, Core 2 Duo)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Everyone,

I have really been struggling with interrupt delivery from one of our
PCI devices to our kernel driver, and I would really appreciate some
feedback on what we're doing wrong here.  I did manage to get it
working, but I had to do some things that I would expect to be handled
automatically if I were doing all of this correctly.

** Background and previously working drivers

We've had a RHEL6 driver (RHEL 6.5, 2.6.32-431.el6.i686) working for a
long time.  So when we started porting it to RHEL7 (RHEL 7.4,
3.10.0-693.17.1.el7.x86_64) and couldn't get interrupts to work, we
assumed it was that our driver required updates for the newer kernel
version.  However, we installed RHEL 6.5 on hardware more similar to
the machine on which we're running RHEL 7.4, and we're having
interrupt problems there too; in that case interrupts are delivered
intermittently, probably because the driver is designed to work with
level-triggered interrupts, but our device got connected to an
edge-triggered interrupt line.

Of course, one of the first things I did was rewrite the driver so as
to make the hardware interrupt signal more edge-friendly.
Unfortunately, this had no effect on the Shuttle machine we're
developing on.  Before I get into details, if you want info about a
system on which interrupts work fine, please see my stackoverflow post
at "https://stackoverflow.com/questions/49459207/rhel7-4-on-x86-with-intel-82x38-x48-express-chipset-completely-unable-to-get".
There is also a bit more info there about the system we're having
problems with.

** What our device is like

I suspect a large part of the problem is that our device isn't really
a PCIe device.  It's a PCI device retrofitted with a TI
XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge.  Large numbers of this
product are out in the field, and we have to continue to support them
so that air traffic controllers can continue to help pilots safely
land planes.  :)  So when it comes to interrupts, the only option we
have is the "legacy" Assert_INTx and Deassert_INTx MSI messages.

Here is some info about how our card appears in the PCI hierarchy.

"/proc/interrupts" tells us that it's on the APIC interrupt line 10 as
an edge-triggered interrupt.  Line 10 is consistent with what we read
from PCI config space.

# cat /proc/interrupts:
           CPU0       CPU1
...
10:          0          0   IO-APIC-edge      rapafp

# lspci -vvv
...
02:00.0 Display controller: Tech-Source Device 0043
        Subsystem: Tech-Source Device 0043
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+ DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at bfff0000 (32-bit, prefetchable) [size=64K]
        Region 1: Memory at a0000000 (32-bit, prefetchable) [size=256M]
        Region 2: Memory at b8000000 (32-bit, prefetchable) [size=64M]
        Region 4: Memory at bffc0000 (32-bit, prefetchable) [size=128K]
        [virtual] Expansion ROM at fdc00000 [disabled] [size=128K]

"lspci -t" reveals the network topology:

-[0000:00]-+-00.0
           +-01.0-[01-02]----00.0-[02]----00.0
...

And so here is relevant info about each of the bridges along the way:

00:00.0 Host bridge: Intel Corporation 82X38/X48 Express DRAM
Controller (rev 01)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Device 3111
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
...
00:01.0 PCI bridge: Intel Corporation 82X38/X48 Express Host-Primary
PCI Express Bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 24
...
[ This is the PCI-to-PCIe bridge on our graphics board]
01:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200A PCI
Express-to-PCI Bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
...
[ This is our ATC graphics accelerator that has a 32-bit 66Mhz PCI but. ]
02:00.0 Display controller: Tech-Source Device 0043
        Subsystem: Tech-Source Device 0043
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+ DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 10

** Attempted solutions

It took me embarrassingly long to notice that 00:01.0 had legacy
interrupts disabled (DisINTx+).  So the very next thing I did was
write some code to traverse the bridge hierarchy and clear any
DisINTx+ along he way.  (I put that code at the bottom of the email.)

The relevant sequence of API calls leading up to trying to enable the
driver was as follows:

- pci_enable_device (returns no error)
- raptor_enable_intx (succeeds in clearing DisINTx+ on that one bridge)
- irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW).  (probably redundant;
returns no error code but fails to change the APIC interrupt line
trigger)
- request_irq(irq, raptor_interrupt, IRQF_SHARED | IRQF_TRIGGER_LOW,
DRIVER_NAME, pTspci).  (Returns no error code, succeeds in making an
entry for rapafp appear in /proc/interrupts, does not change the
trigger)

When I start X.org, one of the first things that happens after opening
the device is that we enable VSYNC interrupts, and there are also
other interrupts we need from the drawing engine.  Despite this,
/proc/interrupts still reports zero interrupts received.

The next thing I notice is that all of a sudden, the interrupt line
for our chip has changed:

02:00.0 Display controller: Tech-Source Device 0043
        Subsystem: Tech-Source Device 0043
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+ DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 16

Some more debug messages later, and I find out that it was
pci_enable_device that changed the IRQ line:

Mar 26 12:09:32 localhost kernel: After pci_read_config_byte:
irq_byte=10, dev->irq=10
Mar 26 12:09:32 localhost kernel: raptor_attach: pci_enable_device succeeded!
Mar 26 12:09:32 localhost kernel: After pci_enable_device:
irq_byte=10, dev->irq=16

The effects of this make no sense.  This is how I dump that info:

    char irq_byte;
    pci_read_config_byte(handle, PCI_INTERRUPT_LINE, &irq_byte);
    printk( KERN_INFO "After pci_read_config_byte: irq_byte=%d,
dev->irq=%d\n", (int)irq_byte, pTspci->pdev->irq);

So, the pci_dev struct has had irq updated to 16, and lspci reports
that the IRQ line has been updated to 16 in the hardware.  So why is
it that when I read PCI config space directly, I get the old value?
In fact, lspci is apparently LYING about this!  Here's what I get from
a raw dump of PCI config space:

02:00.0 Display controller: Tech-Source Device 0043
00: 27 12 43 00 02 02 a0 02 00 00 80 03 00 00 00 00
10: 08 00 ff bf 08 00 00 a0 08 00 00 b8 00 00 00 00
20: 08 00 fc bf 00 00 00 00 00 00 00 00 27 12 43 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

In that last line, you can clearly see that INTA is still routed to
pin 10.  Apparently, "lspci -vvv" is getting its "interpreted" config
space info from
"/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/",
where the irq node reports 16.

Doesn't it seem like a kernel bug that the IRQ number is changed in
data structures, but PCI config space is not automatically updated
with the correct pin?  And since request_irq doesn't take a pci_dev
pointer as an argument, there is no opportunity for any sanity checks,
no way for request_irq to fix the incorrect setting in PCI config
space, and no way for request_irq to return an error due to the
mismatch.  If there's some call I'm failing to make that would update
the hardware properly, I can't figure out where it is.

I've struggled to find good documentation on what is the proper way to
do all this stuff.  When I google things, I mostly only find really
old stuff, and some of it's from theoretical discussions on LKML (e.g.
https://patchwork.kernel.org/patch/7469831/).  I have tried looking at
lots of in-kernel drivers, but most of them don't seem to make most of
the calls mentioned in posts like that one and don't seem to do
anything about adapting to altered IRQ numbers.

Before just jamming the correct IRQ number into the graphics chip's
config space, I went looking for a proper way of doing this.  I found
pcibios_fixup_irqs, but that seems to want to alter every device in
the system, which is probably not something we should be doing this
long after booting.  There seems to be a global function pointer
pcibios_enable_irq that is called from pcibios_enable_device.  And
this brings me to the question as to what is the difference between
pci_ calls and pcibios_ calls.  One thing I can see is that
pci_enable_device explicitly excludes interrupts from the flags it
passes to __pci_enable_device_flags.  Another thing I notice is that
there is no mention of pcibios_enable_device in the kernel
Documentation directory, while pci_enable_device IS.  In fact, only
two pcibios_ calls are mentioned anywhere in the docs.  When googling
this, I instead find discussions of deprecating pcibios_ calls.  There
are a few places in "arch/x86/pci" that write to PCI_INTERRUPT_LINE,
but the only relevant one is pcibios_update_irq, which I assume is
deprecated.

In the Documention on PCI, it mentions using pci_enable_msi and
pci_enable_msix calls.  That and other text makes it pretty clear that
INTx interrupts are the *default*, and MSI has to be enabled
explicitly.  Looking at do_pci_enable_device, if msi and msix are
disabled, then it will clear PCI_COMMAND_INTX_DISABLE on the device,
but it doesn't ascend the bridge hierarchy fixing those too.  It also
calls pcibios_enable_device.  From what I can see, if both msi_enabled
and msix_enabled are false, then it should fall back to INTx
interrupts.

So before calling pci_enable_device, I first printed out the msi flags
in my pci_dev structure and then just for kicks called pci_disable_msi
and pci_disable_msix.  This had no impact.  It wasn't until after I
had added the code to manually fix the interrupt line in config space
did I start receiving interrupts:

[ 4898.207690] pci_dev->msi_enabled=0 pci_dev->msix_enabled=0
[ 4898.207839] raptor_attach: pci_enable_device succeeded!
[ 4898.207844] After pci_enable_device: irq_byte=10, dev->irq=16
[ 4898.207846] PCI_INTERRUPT_LINE set wrong in hardware -- fixing
[ 4898.207855] raptor_enable_intx: DisINTx already clear for device 0000:02:00.0
[ 4898.207861] raptor_enable_intx: DisINTx already clear for device 0000:01:00.0
[ 4898.207865] raptor_enable_intx: Successfully cleared DisINTx for
device 0000:00:01.0
[ 4898.207867] raptor_attach: configured 1 bridges
[ 4898.207870] After raptor_enable_intx: irq_byte=16, dev->irq=16
[ 4898.207875] raptor_attach: calling request_irq.
[ 4898.207884] raptor_attach: request_irq(16) succeeded!
[ 4898.207990] After request_irq: irq_byte=16, dev->irq=16


So finally, I have managed to get this driver kinda working.  It needs
more testing to verify that it fully behaves properly.  So we have
something we can work with for now.  This driver has a long history,
ported from OS to OS and linux version to linux version.  It can be
built for Tru64, AIX, Solaris, and several other UNIXes, thanks to the
C preprocessor.  And it also able to support various of our graphics
cards going pretty far back.  So it's complicated, and there is a lot
of legacy code in there.

So what I'd really like to do is bring it up to date and use all the
proper API calls with out any iffy hacks that will break with the next
chipset or kernel version.  I'm sure I haven't provided enough info,
so feel free to as questions, and I would really appreciate any
feedback I can get.

Thanks a million!



Here's my code that walks the device tree.

static int raptor_enable_intx(struct pci_dev *dev, TspciPtr pTspci) {
    int num_en = 0;
    int result;
    u16 cmd, old_cmd;

    while (dev) {
        pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
        pci_intx(dev, true);
        pci_read_config_word(dev, PCI_COMMAND, &cmd);
        if (cmd & PCI_COMMAND_INTX_DISABLE) {
            printk (KERN_INFO "raptor_enable_intx: Could not clear
DisINTx for device %s\n", pci_name(dev));
        } else {
            printk (KERN_INFO "raptor_enable_intx: Successfully
cleared DisINTx for device %s\n", pci_name(dev));
            if ((old_cmd & PCI_COMMAND_INTX_DISABLE)) num_en++;
        }

        dev = pci_upstream_bridge(dev);
    }
    return num_en;
}



-- 
Timothy Normand Miller, PhD
Principal Engineer, Eizo Rugged Solutions
