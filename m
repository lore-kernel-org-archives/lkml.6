Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2099BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DDD2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfBUM2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:28:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38251 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:28:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so22940975edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9vHTSpHnBzi6qgLUvVeke71SWv+mCw5qcidTaztiKDg=;
        b=Zh9wB2fNJ4jG7VzlvvhZBdzRDNQrvWSngqi3IGy/bxpN/rJE6erij31SMzEfgkd8EX
         g1RSdDzr08jY+G0QPuxsLUQUaTVhZ1/2GcYBHP6poxPC/48TQ5dMQv3dVc+N/s4m8u2E
         n++vLEAiNyFsqJgy8EnsJDuEw8z/cGu7JILSaXsv+k6jUbKApn8MsvNYlOehkYfmwdJC
         wFnwLqBCQb6s+wQ2wZwPLExkFv5GbNGgslMiLmOIGYqgFWRjg5/PC8KeDSk1Hc09lRCS
         9QFwytDCiZ/Bb0yzAbLNNbsMRJrlNmzdLtLPnVn0LbQks4HhpX/mK9BBWSToa3ZkRoJ9
         0qeQ==
X-Gm-Message-State: AHQUAua3wxSfHjzi4dVuyJv+pyGfNDJzyDdx40safN+CYEAZU7uX1zu1
        JgDrGx4eMfjtYxZz7rQmjPotCA==
X-Google-Smtp-Source: AHgI3IYp86uPoJWV/9khYzvysZAGzgJOzlbPC9ZTdjPe5CyvUnf/ijKe1aNYudi6dzXUV3jP3kyGfA==
X-Received: by 2002:a50:ad31:: with SMTP id y46mr30481963edc.97.1550752113339;
        Thu, 21 Feb 2019 04:28:33 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id n60sm6366105edc.90.2019.02.21.04.28.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 04:28:32 -0800 (PST)
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7af4a533-21ad-b2b8-1d71-9390bf9ac564@redhat.com>
Date:   Thu, 21 Feb 2019 13:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-02-19 22:01, Thomas Gleixner wrote:
> Hans,
> 
> On Tue, 19 Feb 2019, Hans de Goede wrote:
> 
> Cc+: ACPI/AMD folks
> 
>> Various people are reporting false positive "do_IRQ: #.55 No irq handler for
>> vector"
>> messages on AMD ryzen based laptops, see e.g.:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1551605
>>
>> Which contains this dmesg snippet:
>>
>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Bringing up secondary CPUsHi,
>> ...
>> Feb 07 20:14:29 localhost.localdomain kernel: x86: Booting SMP configuration:
>> Feb 07 20:14:29 localhost.localdomain kernel: .... node  #0, CPUs:      #1
>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 1.55 No irq handler for
>> vector
>> Feb 07 20:14:29 localhost.localdomain kernel:  #2
>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 2.55 No irq handler for
>> vector
>> Feb 07 20:14:29 localhost.localdomain kernel:  #3
>> Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 3.55 No irq handler for
>> vector
>> Feb 07 20:14:29 localhost.localdomain kernel: smp: Brought up 1 node, 4 CPUs
>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Max logical packages: 1
>> Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Total of 4 processors
>> activated (15968.49 BogoMIPS)
>>
>> It seems that we get an IRQ for each CPU as we bring it online,
>> which feels to me like it is some sorta false-positive.
> 
> Sigh, that looks like BIOS value add again.
> 
> It's not a false positive. Something _IS_ sending a vector 55 to these CPUs
> for whatever reason.
> 
>> I temporarily have access to a loaner laptop for a couple of weeks which shows
>> the same errors and I would like to fix this, but I don't really know how to
>> fix this.
> 
> Can you please enable CONFIG_GENERIC_IRQ_DEBUGFS and dig in the files there
> whether vector 55 is used on CPU0 and which device is associated to that.

ls /sys/kernel/debug/irq/domains gives:

AMD-IR-0        IO-APIC-IR-0  PCI-MSI-3  default
AMD-IR-MSI-0-3  IO-APIC-IR-1  VECTOR

Non of the files under /sys/kernel/debug/irq/domains list 55 under the "vectors"
column of their output. The part with the vectors column is identical for all
of them and looks like this for all of them:

  | CPU | avl | man | mac | act | vectors
      0   195     1     1    6  33-37,48
      1   195     1     1    6  33-38
      2   195     1     1    6  33-38
      3   195     1     1    6  33-38
      4   195     1     1    6  33-38
      5   195     1     1    6  33-38
      6   195     1     1    6  33-38
      7   195     1     1    6  33-38

cat /sys/kernel/debug/irq/irqs/55

Gives:

handler:  handle_fasteoi_irq
device:   (null)
status:   0x00004100
istate:   0x00000000
ddepth:   1
wdepth:   0
dstate:   0x0503a000
             IRQD_LEVEL
             IRQD_IRQ_DISABLED
             IRQD_IRQ_MASKED
             IRQD_SINGLE_TARGET
             IRQD_MOVE_PCNTXT
             IRQD_CAN_RESERVE
node:     -1
affinity: 0-15
effectiv: 0
pending:
domain:  IO-APIC-IR-1
  hwirq:   0x0
  chip:    IR-IO-APIC
   flags:   0x10
              IRQCHIP_SKIP_SET_WAKE
  parent:
     domain:  AMD-IR-0
      hwirq:   0x10000
      chip:    AMD-IR
       flags:   0x0
      parent:
         domain:  VECTOR
          hwirq:   0x37
          chip:    APIC
           flags:   0x0
          Vector:     0
          Target:     0
          move_in_progress: 0
          is_managed:       0
          can_reserve:      1
          has_reserved:     1
          cleanup_pending:  0

cat /proc/interrupt

Gives:

             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
    0:        123          0          0          0          0          0          0          0  IR-IO-APIC    2-edge      timer
    1:          0          0          0          0          0          0        188          0  IR-IO-APIC    1-edge      i8042
    8:          0          0          0          0          0          0          0          1  IR-IO-APIC    8-edge      rtc0
    9:          0       6564          0          0          0          0          0          0  IR-IO-APIC    9-fasteoi   acpi
   12:          0          0          0          0          0        511          0          0  IR-IO-APIC   12-edge      i8042
   25:          0          0          0          0          0          0          0          0   PCI-MSI 4096-edge      AMD-Vi
   26:          0          0          0          0          0          0          0          0  IR-PCI-MSI 18432-edge      PCIe PME, aerdrv
   27:          0          0          0          0          0          0          0          0  IR-PCI-MSI 20480-edge      PCIe PME, aerdrv
   28:          0          0          0          0          0          0          0          0  IR-PCI-MSI 22528-edge      PCIe PME, aerdrv
   29:          0          0          0          0          0          0          0          0  IR-PCI-MSI 24576-edge      PCIe PME, aerdrv
   30:          0          0          0          0          0          0          0          0  IR-PCI-MSI 26624-edge      PCIe PME, aerdrv
   31:          0          0          0          0          0          0          0          0  IR-PCI-MSI 28672-edge      PCIe PME, aerdrv
   32:          0          0          0          0          0          0          0          0  IR-PCI-MSI 133120-edge      PCIe PME
   33:          0          0          0          0          0          0          0          0  IR-PCI-MSI 135168-edge      PCIe PME
   35:          0          0          0          0          0          0          0          0  IR-PCI-MSI 4194304-edge      ahci[0000:08:00.0]
   36:          0          0          0          0          0          0          0          0  IR-IO-APIC   15-fasteoi   ehci_hcd:usb1
   38:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676160-edge      xhci_hcd
   39:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676161-edge      xhci_hcd
   40:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676162-edge      xhci_hcd
   41:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676163-edge      xhci_hcd
   42:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676164-edge      xhci_hcd
   43:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676165-edge      xhci_hcd
   44:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676166-edge      xhci_hcd
   45:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3676167-edge      xhci_hcd
   47:          0          0          0          0          0        623          0          0  IR-PCI-MSI 3678208-edge      xhci_hcd
   48:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3678209-edge      xhci_hcd
   49:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3678210-edge      xhci_hcd
   50:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3678211-edge      xhci_hcd
   51:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3678212-edge      xhci_hcd
   52:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3678213-edge      xhci_hcd
   53:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3678214-edge      xhci_hcd
   54:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3678215-edge      xhci_hcd
   56:         22          0          0          0          0          0          0          0  IR-PCI-MSI 524288-edge      rtsx_pci
   58:          0         37          0          0          0          0          0          0  IR-PCI-MSI 1572864-edge      nvme0q0
   59:       3838          0          0          0          0          0          0          0  IR-PCI-MSI 1572865-edge      nvme0q1
   60:          0       2036          0          0          0          0          0          0  IR-PCI-MSI 1572866-edge      nvme0q2
   61:          0          0       3525          0          0          0          0          0  IR-PCI-MSI 1572867-edge      nvme0q3
   62:          0          0          0       5013          0          0          0          0  IR-PCI-MSI 1572868-edge      nvme0q4
   63:          0          0          0          0       3025          0          0          0  IR-PCI-MSI 1572869-edge      nvme0q5
   64:          0          0          0          0          0       2271          0          0  IR-PCI-MSI 1572870-edge      nvme0q6
   65:          0          0          0          0          0          0       3948          0  IR-PCI-MSI 1572871-edge      nvme0q7
   66:          0          0          0          0          0          0          0       2094  IR-PCI-MSI 1572872-edge      nvme0q8
   67:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572873-edge      nvme0q9
   68:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572874-edge      nvme0q10
   69:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572875-edge      nvme0q11
   70:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572876-edge      nvme0q12
   71:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572877-edge      nvme0q13
   72:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572878-edge      nvme0q14
   73:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572879-edge      nvme0q15
   74:          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572880-edge      nvme0q16
   75:          0          0       7598          0          0          0          0          0  IR-PCI-MSI 3670016-edge      amdgpu
   77:          0          0          0          0          0          0          0          0  IR-PCI-MSI 2097152-edge      enp4s0f0
   79:          0          0          0          0          0          0          0          0  IR-PCI-MSI 3145728-edge      enp6s0
   81:          0          0          0        527          0          0          0          0  IR-PCI-MSI 3672064-edge      snd_hda_intel:card0
   82:          0          0          0          0        930          0          0          0  IR-PCI-MSI 3682304-edge      snd_hda_intel:card1
   84:          0          0          0          0          0      15493          0          0  IR-PCI-MSI 1048576-edge      r8822be
  NMI:          2          1          1          1          1          1          1          1   Non-maskable interrupts
  LOC:      55193      40080      52795      34289      48822      42298      57746      33306   Local timer interrupts
  SPU:          0          0          0          0          0          0          0          0   Spurious interrupts
  PMI:          2          1          1          1          1          1          1          1   Performance monitoring interrupts
  IWI:      15286      10090      14311       9249      13054      23194      13384       9842   IRQ work interrupts
  RTR:          0          0          0          0          0          0          0          0   APIC ICR read retries
  RES:      26829      14012      14311       8544      12130       6480      13649       6414   Rescheduling interrupts
  CAL:      15273      18572      16350      18090      14929      18234      17090      17644   Function call interrupts
  TLB:       5771       5218       5098       5248       5571       3619       8354       5405   TLB shootdowns
  TRM:          0          0          0          0          0          0          0          0   Thermal event interrupts
  THR:          0          0          0          0          0          0          0          0   Threshold APIC interrupts
  DFR:          0          0          0          0          0          0          0          0   Deferred Error APIC interrupts
  MCE:          0          0          0          0          0          0          0          0   Machine check exceptions
  MCP:          5          5          5          5          5          5          5          5   Machine check polls
  HYP:          0          0          0          0          0          0          0          0   Hypervisor callback interrupts
  HRE:          0          0          0          0          0          0          0          0   Hyper-V reenlightenment interrupts
  HVS:          0          0          0          0          0          0          0          0   Hyper-V stimer0 interrupts
  ERR:          0
  MIS:          0
  PIN:          0          0          0          0          0          0          0          0   Posted-interrupt notification event
  NPI:          0          0          0          0          0          0          0          0   Nested posted-interrupt event
  PIW:          0          0          0          0          0          0          0          0   Posted-interrupt wakeup event

> I bet its a legacy IRQ and as that space starts at 48 (IRQ0) this should be
> IRQ9 which is usually - DRUMROLL - the ACPI interrupt.
> 
> The kernel clearly sets that up to be delivered to CPU 0 only, but I've
> seen that before that the BIOS value add thinks that this setup is not
> relevant.
> 
> /me goes off and sings LALALA

Regards,

Hans
