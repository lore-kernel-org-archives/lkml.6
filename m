Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeCIDO1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 22:14:27 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:38189
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750898AbeCIDOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 22:14:24 -0500
X-ASG-Debug-ID: 1520565259-093b7e4ca91d8e0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "cdall@kernel.org" <cdall@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: Re: [RFC PATCH] KVM: arm/arm64: vgic: change condition for
 level interrupt resampling
Thread-Topic: Re: [RFC PATCH] KVM: arm/arm64: vgic: change condition for
 level interrupt resampling
X-ASG-Orig-Subj: Re: Re: [RFC PATCH] KVM: arm/arm64: vgic: change condition for
 level interrupt resampling
Thread-Index: AQHTt1S2/epsDNVPFEaU85CMGhRVDQ==
Date: Fri, 9 Mar 2018 03:14:18 +0000
Message-ID: <1520565257.2583.57.camel@hxt-semitech.com>
References: <1520492490-7943-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <9ad47673-068e-f732-d2ca-9c76a8fbdfbc@arm.com>
         <0a15633d-8944-cb9b-3e6b-b08ee5ec42b9@arm.com> <20180308161900.GC1917@lvm>
         <86r2oubho3.wl-marc.zyngier@arm.com>
         <cf815673-e20e-c1e1-2d79-2f47261b2412@redhat.com>
In-Reply-To: <cf815673-e20e-c1e1-2d79-2f47261b2412@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C22A773ACBDC2A4FB97028A163D53A62@hxt-semitech.com>
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1520565259
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8366 1.0000 2.5739
X-Barracuda-Spam-Score: 2.57
X-Barracuda-Spam-Status: No, SCORE=2.57 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.48751
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w293EXQE028787

Hi, Eric, Marc and Christoffer,

On Thu, 2018-03-08 at 19:12 +0100, Auger Eric wrote:
> Hi Marc, Christoffer,
> 
> On 08/03/18 18:28, Marc Zyngier wrote:
> > 
> > On Thu, 08 Mar 2018 16:19:00 +0000,
> > Christoffer Dall wrote:
> > > 
> > > 
> > > On Thu, Mar 08, 2018 at 11:54:27AM +0000, Marc Zyngier wrote:
> > > > 
> > > > On 08/03/18 09:49, Marc Zyngier wrote:
> > > > > 
> > > > > [updated Christoffer's email address]
> > > > > 
> > > > > Hi Shunyong,
> > > > > 
> > > > > On 08/03/18 07:01, Shunyong Yang wrote:
> > > > > > 
> > > > > > When resampling irqfds is enabled, level interrupt should
> > > > > > be
> > > > > > de-asserted when resampling happens. On page 4-47 of GIC v3
> > > > > > specification IHI0069D, it said,
> > > > > > "When the PE acknowledges an SGI, a PPI, or an SPI at the
> > > > > > CPU
> > > > > > interface, the IRI changes the status of the interrupt to
> > > > > > active
> > > > > > and pending if:
> > > > > > • It is an edge-triggered interrupt, and another edge has
> > > > > > been
> > > > > > detected since the interrupt was acknowledged.
> > > > > > • It is a level-sensitive interrupt, and the level has not
> > > > > > been
> > > > > > deasserted since the interrupt was acknowledged."
> > > > > > 
> > > > > > GIC v2 specification IHI0048B.b has similar description on
> > > > > > page
> > > > > > 3-42 for state machine transition.
> > > > > > 
> > > > > > When some VFIO device, like mtty(8250 VFIO mdev emulation
> > > > > > driver
> > > > > > in samples/vfio-mdev) triggers a level interrupt, the
> > > > > > status
> > > > > > transition in LR is pending-->active-->active and pending.
> > > > > > Then it will wait resampling to de-assert the interrupt.
> > > > > > 
> > > > > > Current design of lr_signals_eoi_mi() will return false if
> > > > > > state
> > > > > > in LR is not invalid(Inactive). It causes resampling will
> > > > > > not happen
> > > > > > in mtty case.
> > > > > Let me rephrase this, and tell me if I understood it
> > > > > correctly:
> > > > > 
> > > > > - A level interrupt is injected, activated by the guest (LR
> > > > > state=active)
> > > > > - guest exits, re-enters, (LR state=pending+active)
> > > > > - guest EOIs the interrupt (LR state=pending)
> > > > > - maintenance interrupt
> > > > > - we don't signal the resampling because we're not in an
> > > > > invalid state
> > > > > 
> > > > > Is that correct?
> > > > > 
> > > > > That's an interesting case, because it seems to invalidate
> > > > > some of the 
> > > > > optimization that went in over a year ago.
> > > > > 
> > > > > 096f31c4360f KVM: arm/arm64: vgic: Get rid of MISR and EISR
> > > > > fields
> > > > > b6095b084d87 KVM: arm/arm64: vgic: Get rid of unnecessary
> > > > > save_maint_int_state
> > > > > af0614991ab6 KVM: arm/arm64: vgic: Get rid of unnecessary
> > > > > process_maintenance operation
> > > > > 
> > > > > We could compare the value of the LR before the guest entry
> > > > > with
> > > > > the value at exit time, but we still could miss it if we have
> > > > > a
> > > > > transition such as P+A -> P -> A and assume a long enough
> > > > > propagation
> > > > > delay for the maintenance interrupt (which is very likely).
> > > > > 
> > > > > In essence, we have lost the benefit of EISR, which was to
> > > > > give us a
> > > > > way to deal with asynchronous signalling.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > This will cause interrupt fired continuously to guest even
> > > > > > 8250 IIR
> > > > > > has no interrupt. When 8250's interrupt is configured in
> > > > > > shared mode,
> > > > > > it will pass interrupt to other drivers to handle. However,
> > > > > > there
> > > > > > is no other driver involved. Then, a "nobody cared" kernel
> > > > > > complaint
> > > > > > occurs.
> > > > > > 
> > > > > > / # cat /dev/ttyS0
> > > > > > [    4.826836] random: crng init done
> > > > > > [    6.373620] irq 41: nobody cared (try booting with the
> > > > > > "irqpoll"
> > > > > > option)
> > > > > > [    6.376414] CPU: 0 PID: 1307 Comm: cat Not tainted
> > > > > > 4.16.0-rc4 #4
> > > > > > [    6.378927] Hardware name: linux,dummy-virt (DT)
> > > > > > [    6.380876] Call trace:
> > > > > > [    6.381937]  dump_backtrace+0x0/0x180
> > > > > > [    6.383495]  show_stack+0x14/0x1c
> > > > > > [    6.384902]  dump_stack+0x90/0xb4
> > > > > > [    6.386312]  __report_bad_irq+0x38/0xe0
> > > > > > [    6.387944]  note_interrupt+0x1f4/0x2b8
> > > > > > [    6.389568]  handle_irq_event_percpu+0x54/0x7c
> > > > > > [    6.391433]  handle_irq_event+0x44/0x74
> > > > > > [    6.393056]  handle_fasteoi_irq+0x9c/0x154
> > > > > > [    6.394784]  generic_handle_irq+0x24/0x38
> > > > > > [    6.396483]  __handle_domain_irq+0x60/0xb4
> > > > > > [    6.398207]  gic_handle_irq+0x98/0x1b0
> > > > > > [    6.399796]  el1_irq+0xb0/0x128
> > > > > > [    6.401138]  _raw_spin_unlock_irqrestore+0x18/0x40
> > > > > > [    6.403149]  __setup_irq+0x41c/0x678
> > > > > > [    6.404669]  request_threaded_irq+0xe0/0x190
> > > > > > [    6.406474]  univ8250_setup_irq+0x208/0x234
> > > > > > [    6.408250]  serial8250_do_startup+0x1b4/0x754
> > > > > > [    6.410123]  serial8250_startup+0x20/0x28
> > > > > > [    6.411826]  uart_startup.part.21+0x78/0x144
> > > > > > [    6.413633]  uart_port_activate+0x50/0x68
> > > > > > [    6.415328]  tty_port_open+0x84/0xd4
> > > > > > [    6.416851]  uart_open+0x34/0x44
> > > > > > [    6.418229]  tty_open+0xec/0x3c8
> > > > > > [    6.419610]  chrdev_open+0xb0/0x198
> > > > > > [    6.421093]  do_dentry_open+0x200/0x310
> > > > > > [    6.422714]  vfs_open+0x54/0x84
> > > > > > [    6.424054]  path_openat+0x2dc/0xf04
> > > > > > [    6.425569]  do_filp_open+0x68/0xd8
> > > > > > [    6.427044]  do_sys_open+0x16c/0x224
> > > > > > [    6.428563]  SyS_openat+0x10/0x18
> > > > > > [    6.429972]  el0_svc_naked+0x30/0x34
> > > > > > [    6.431494] handlers:
> > > > > > [    6.432479] [<000000000e9fb4bb>] serial8250_interrupt
> > > > > > [    6.434597] Disabling IRQ #41
> > > > > > 
> > > > > > This patch changes the lr state condition in
> > > > > > lr_signals_eoi_mi() from
> > > > > > invalid(Inactive) to active and pending to avoid this.
> > > > > > 
> > > > > > I am not sure about the original design of the condition of
> > > > > > invalid(active). So, This RFC is sent out for comments.
> > > > > > 
> > > > > > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > > > > > Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.co
> > > > > > m>
> > > > > > ---
> > > > > >  virt/kvm/arm/vgic/vgic-v2.c | 4 ++--
> > > > > >  virt/kvm/arm/vgic/vgic-v3.c | 4 ++--
> > > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/virt/kvm/arm/vgic/vgic-v2.c
> > > > > > b/virt/kvm/arm/vgic/vgic-v2.c
> > > > > > index e9d840a75e7b..740ee9a5f551 100644
> > > > > > --- a/virt/kvm/arm/vgic/vgic-v2.c
> > > > > > +++ b/virt/kvm/arm/vgic/vgic-v2.c
> > > > > > @@ -46,8 +46,8 @@ void vgic_v2_set_underflow(struct
> > > > > > kvm_vcpu *vcpu)
> > > > > >  
> > > > > >  static bool lr_signals_eoi_mi(u32 lr_val)
> > > > > >  {
> > > > > > -	return !(lr_val & GICH_LR_STATE) && (lr_val &
> > > > > > GICH_LR_EOI) &&
> > > > > > -	       !(lr_val & GICH_LR_HW);
> > > > > > +	return !((lr_val & GICH_LR_STATE) ^ GICH_LR_STATE)
> > > > > > &&
> > > > > That feels very wrong. You're now signalling the resampling
> > > > > in both
> > > > > invalid and pending+active, and the latter state doesn't mean
> > > > > you've
> > > > > EOIed anything. You're now over-signalling, and signalling
> > > > > the
> > > > > wrong event.

I am using XOR GICH_LR_STATE(0b'11), so only 0b'11(P&A) will be
signaled. Other state will be false.
And I am curious why the EOI bit in LR indicate the end of interrupt
regardless of the state? Please bear with me as I am a newbie in this
part.

> > > > > 
> > > > > > 
> > > > > > +	       (lr_val & GICH_LR_EOI) && !(lr_val &
> > > > > > GICH_LR_HW);
> > > > > >  }
> > > > > >  
> > > > > >  /*
> > > > > > diff --git a/virt/kvm/arm/vgic/vgic-v3.c
> > > > > > b/virt/kvm/arm/vgic/vgic-v3.c
> > > > > > index 6b329414e57a..43111bba7af9 100644
> > > > > > --- a/virt/kvm/arm/vgic/vgic-v3.c
> > > > > > +++ b/virt/kvm/arm/vgic/vgic-v3.c
> > > > > > @@ -35,8 +35,8 @@ void vgic_v3_set_underflow(struct
> > > > > > kvm_vcpu *vcpu)
> > > > > >  
> > > > > >  static bool lr_signals_eoi_mi(u64 lr_val)
> > > > > >  {
> > > > > > -	return !(lr_val & ICH_LR_STATE) && (lr_val &
> > > > > > ICH_LR_EOI) &&
> > > > > > -	       !(lr_val & ICH_LR_HW);
> > > > > > +	return !((lr_val & ICH_LR_STATE) ^ ICH_LR_STATE)
> > > > > > &&
> > > > > > +	       (lr_val & ICH_LR_EOI) && !(lr_val &
> > > > > > ICH_LR_HW);
> > > > > >  }
> > > > > >  
> > > > > >  void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
> > > > > > 
> > > > > Assuming I understand the issue correctly, I cannot really
> > > > > see how
> > > > > to solve this without reintroducing EISR, which sucks
> > > > > majorly.
> > > > > 
> > > > > I'll try to cook something shortly and we can all have a good
> > > > > fight about how crap this is.
> > > > Here's what I came up with. I don't really like it, but that's
> > > > the least invasive this I could come up with. Please let me
> > > > know if that helps with your test case. Note that I have only
> > > > boot-tested this on a sample of 1 machine, so I don't expect
> > > > this
> > > > to be perfect.
> > > > 
> > > > Also, any guideline on how to reproduce this would be much
> > > > appreciated.
> > > > I never used this mdev/mtty thing, so please bear with me.
> > > > 
> > > > Thanks,
> > > > 
> > > > 	M.

The mdev/mtty documentation is at Documentation/vfio-mediated-
device.txt. It docmented how to enable mtty device.
And support for "vfio-pci,sysfsdev" should be availabe in your qemu
version (I compiled the latest version).
Following is my commond to run qemu with mdev support,
"qemu-system-aarch64 -m 1024 -cpu host -M virt,gic_version=3 -nographic
\
-kernel /home/yangsy/up-kvm/arch/arm64/boot/Image.gz \
-initrd /home/yangsy/kvm/ramdisk/initrd.img \
-netdev user,id=eth0 -device virtio-net-device,netdev=eth0 -enable-kvm
\
-append "root=/dev/ram rdinit=/sbin/init" \
-device vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-
3c1e-e6bfe0fa1001
"
For just test this vgic case, type "cat /dev/ttyS0" in guest. But if
test read/write multiple bytes, please apply following patch also
https://patchwork.kernel.org/patch/10267039/

> > > > 
> > > > From 66a7c4cfc1029b0169dd771e196e2876ba3f17b1 Mon Sep 17
> > > > 00:00:00 2001
> > > > From: Marc Zyngier <marc.zyngier@arm.com>
> > > > Date: Thu, 8 Mar 2018 11:14:06 +0000
> > > > Subject: [PATCH] KVM: arm/arm64: Do not rely on LR state to
> > > > guess EOI MI
> > > >  status
> > > > 
> > > > We so far rely on the LR state to decide whether the guest has
> > > > EOI'd a level interrupt or not. While this looks like a good
> > > > idea on the surface, it leads to a couple of annoying corner
> > > > cases:
> > > > 
> > > > Example 1: (P = Pending, A = Active, MI = Maintenance
> > > > Interrupt)
> > > > P -> guest IAR -> A -> exit/entry -> P+A -> guest EOI -> P ->
> > > > MI
> > > Do we really get an EOI maintenance interrupt here?  Reading the
> > > MISR
> > > and EISR descriptions make me thing this is not the case...
> Hum yes in EISR it is said that ICH_LR.State = 0b00!
> > 
> > 
> > Yeah, it looks like I always want EISR to do what I want, and not
> > to
> > do what it does. Man, this thing is such a piece of crap.
> > 
> > OK, scratch that. We need to do it without the help of the HW.

If convenient, maybe we can get something from HW gus. :-)

Hi, Marc,

Do you need me to test the patch you posted for EISR? As it seems there
are some things need more discussion.

> > 
> > > 
> > > > 
> > > > The state is now pending, we've really EOI'd the interrupt, and
> > > > yet lr_signals_eoi_mi() returns false, since the state is not
> > > > 0.
> > > > The result is that we won't signal anything on the
> > > > corresponding
> > > > irqfd, which people complain about. Meh.
> > > So the core of the problem is that when we've entered the guest
> > > with
> > > PENDING+ACTIVE and when we exit (for some reason) we don't signal
> > > the
> > > resamplefd, right?  The solution seems to me that we don't ever
> > > do
> > > PENDING+ACTIVE if you need to resample after each
> > > deactivate.  What
> > > would be the point of appending a pending state that you only
> > > know to be
> > > valid after a resample anyway?
> > The question is then to identify that a given source needs to be
> > signalled back to VFIO. Calling into the eventfd code on the hot
> > path
> > is pretty horrid (I'm not sure if we can really call into this with
> > interrupts disabled, for example).
> > 
> > > 
> > > 
> > > > 
> > > > 
> > > > Example 2:
> > > > P+A -> guest EOI -> P -> delayed MI -> guest IAR -> A -> MI
> > > > fires
> > > We could be more clever and do the following calculation on every
> > > exit:
> > > 
> > > If you enter with P, and exit with either A or 0, then signal.
> > > 
> > > If you enter with P+A, and you exit with either P, A, or 0, then
> > > signal.
> > > 
> > > Wouldn't that also solve it?  (Although I have a feeling you'd
> > > miss some
> > > exits in this case).
> > I'd be more confident if we did forbid P+A for such interrupts
> > altogether, as they really feel like another kind of HW interrupt.
> the LR P+A looks strange to me too. all the more so it may cause the
> same IRQ to be acked twice?
> 
> P -> A -> 0 (resample). Doesn't our issue come from the fact we
> reinject
> the P in LR until the line level is deasserted?
> > 
> > 
> > Eric: Is there any way to get a callback from the eventfd code to
> > flag
> > a given irq as requiring a notification on EOI?
> bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned
> pin) was used in the past. I think it does what you want.
> 
> Thanks
> 
> Eric
> > 
> > 
> > Thanks,
> > 
> > 	M.
> > 

I have added some logs to compare level interrupt between pl011(hwirq =
33) and mtty (hwirq = 36). In mtty case, vgic_queue_irq_unlock() is
called twice. But only called once in pl011.

following is the log,
===Without my patch===
###PL011###

<4>[  180.598266] kvm_vgic_inject_irq 453 irq:33 enabled:1 config:1
latch:0 level:1
<4>[  180.604460] ##vgic_queue_irq_unlock 388 irq->intid:33 enable:1
level:1
<4>[  180.604540] ==>90a0020000000021(active)
<4>[  180.614878] ==>d0a0020000000021(P&A)
<4>[  180.618415] kvm_vgic_inject_irq 453 irq:33 enabled:1 config:1
latch:0 level:0
<4>[  180.625508] ==>90a0020000000021(active)
<4>[  180.629343] ==>10a0020000000021(inactive)

###mtty-vfio###
<4>[  223.123329] kvm_vgic_inject_irq 453 irq:36 enabled:0 config:1
latch:0 level:1
<4>[  223.129736] ##vgic_queue_irq_unlock 388 irq->intid:36 enable:1
level:1
<4>[  223.136027] ==>50a0020000000024(pending)
<4>[  223.139954] ##vgic_queue_irq_unlock 388 irq->intid:36 enable:1
level:1
<4>[  223.146460] ==>90a0020000000024(active)
<4>[  223.150273] ==>d0a0020000000024(P&A)
<4>[  223.153827] ==>90a0020000000024(active)
<4>[  223.157668] ==>d0a0020000000024(P&A)
...........cyclic...

I rembered in some tests the state change is cyclic P->A->P&A. But it
seems I cannot reproduce it. Is output LR state
in kvm_vgic_inject_irq() reliable?

===With my patch===
###PL011###
<4>[  114.798528] kvm_vgic_inject_irq 453 irq:33 enabled:1 config:1
latch:0 level:1
<4>[  114.804743] ##vgic_queue_irq_unlock 388 irq->intid:33 enable:1
level:1
<4>[  114.804796] ==>90a0020000000021(active)
<4>[  114.815077] ==>d0a0020000000021(P&A)
<4>[  114.818628] kvm_vgic_inject_irq 453 irq:33 enabled:1 config:1
latch:0 level:0
<4>[  114.825726] ==>90a0020000000021(active)
<4>[  114.829560] ==>10a0020000000021(inactive)

###mtty-vfio###

<4>[  161.579083] kvm_vgic_inject_irq 453 irq:36 enabled:0 config:1
latch:0 level:1
<4>[  161.585419] ##vgic_queue_irq_unlock 388 irq->intid:36 enable:1
level:1
<4>[  161.591780] ==>50a0020000000024(pending)
<4>[  161.595708] ##vgic_queue_irq_unlock 388 irq->intid:36 enable:1
level:1
<4>[  161.602204] ==>90a0020000000024(active)
<4>[  161.606023] ==>d0a0020000000024(P&A)
<4>[  161.609561] kvm_vgic_inject_irq 453 irq:36 enabled:1 config:1
latch:0 level:0
<4>[  161.616693] ==>10a0020000000024(inactive)
<4>[  161.620745] kvm_vgic_inject_irq 453 irq:36 enabled:1 config:1
latch:0 level:1
<4>[  161.627800] ##vgic_queue_irq_unlock 388 irq->intid:36 enable:1
level:1
<4>[  161.627849] ==>90a0020000000024(active)
<4>[  161.640076] ==>d0a0020000000024(P&A)
<4>[  161.642689] kvm_vgic_inject_irq 453 irq:36 enabled:1 config:1
latch:0 level:0
<4>[  161.649822] ==>10a0020000000024(inactive)


Following is the test patch,

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
old mode 100644
new mode 100755
index 6b329414e57a..00fb83b11f43
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -26,6 +26,9 @@
 static bool common_trap;
 static bool gicv4_enable;
 
+int monitor_irq = 36;
+module_param(monitor_irq, int, S_IRUGO | S_IWUSR);
+
 void vgic_v3_set_underflow(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpuif = &vcpu->arch.vgic_cpu.vgic_v3;
@@ -39,6 +42,8 @@ static bool lr_signals_eoi_mi(u64 lr_val)
 	       !(lr_val & ICH_LR_HW);
 }
 
+u64 last_val = 0;
+
 void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
@@ -46,6 +51,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 	u32 model = vcpu->kvm->arch.vgic.vgic_model;
 	int lr;
 	unsigned long flags;
+	char *str[]={"inactive", "pending", "active", "P&A"};
 
 	cpuif->vgic_hcr &= ~ICH_HCR_UIE;
 
@@ -60,6 +66,13 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 			intid = val & GICH_LR_VIRTUALID;
 
 		/* Notify fds when the guest EOI'ed a level-triggered
IRQ */
+		if (intid == monitor_irq) {
+			if (last_val != val) {
+				printk("==>%llx(%s)\n", val, str[(val
>> 62) & 0x03 ]);
+				last_val = val;
+			}
+		}
+
 		if (lr_signals_eoi_mi(val) && vgic_valid_spi(vcpu-
>kvm, intid))
 			kvm_notify_acked_irq(vcpu->kvm, 0,
 					     intid - VGIC
_NR_PRIVATE_IRQS);
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
old mode 100644
new mode 100755
index 07126a3b1908..9c284623ea23
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -31,6 +31,8 @@
 #define DEBUG_SPINLOCK_BUG_ON(p)
 #endif
 
+extern int monitor_irq;
+
 struct vgic_global kvm_vgic_global_state __ro_after_init = {
 	.gicv3_cpuif = STATIC_KEY_FALSE_INIT,
 };
@@ -381,6 +383,12 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct
vgic_irq *irq,
 	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 	kvm_vcpu_kick(vcpu);
 
+	if (irq->intid == monitor_irq) {
+		printk("##%s %d irq->intid:%d enable:%d level:%d\n",
+			__func__, __LINE__, irq->intid,
+			irq->enabled, irq->line_level);
+		//dump_stack();
+	}
 	return true;
 }
 
@@ -401,6 +409,9 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct
vgic_irq *irq,
  * level-sensitive interrupts.  You can think of the level parameter
as 1
  * being HIGH and 0 being LOW and all devices being active-HIGH.
  */
+
+bool monitor_vm_entry_start = false;
+
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int
intid,
 			bool level, void *owner)
 {
@@ -437,6 +448,13 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int
cpuid, unsigned int intid,
 	else
 		irq->pending_latch = true;
 
+	if (irq->intid == monitor_irq) {
+		printk("%s %d irq:%d enabled:%d config:%d latch:%d
level:%d\n",
+			__func__, __LINE__, irq->intid, irq->enabled,
irq->config,
+			irq->pending_latch, irq->line_level);
+		monitor_vm_entry_start = true;
+	}
+
 	vgic_queue_irq_unlock(kvm, irq, flags);
 	vgic_put_irq(kvm, irq);

Thanks.
Shunyong.
