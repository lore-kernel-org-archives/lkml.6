Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx49xWueM6loOo3yJcHfX+TQNN1YW+Cv1AKQdptOIV3ce3AfNQk2l2a+YBEI1dnWzFJ/JmsNs
ARC-Seal: i=1; a=rsa-sha256; t=1522880260; cv=none;
        d=google.com; s=arc-20160816;
        b=mSWDj4f/rlynotU3dgdPO8yClIg/wV+LfYYZPbJUKHC4Rtv78kYBy2heTRs/qYDXc9
         EPPgvPPnLZpfqkQ72PHcT7w70fuOfORy60gdYDnZhj8Ggxk6ocJYK4VO82VVYxHt2mIZ
         cWKeQT0w8FXZorb//qKQpFCuqNfTAe10FId9EENFgLf5jjNBPB3bW+Z1xWcaDY6GTxMK
         Jxw7cdBHbr0nO/jeoYCHYcY4IbL7nA5a+/w4/HaT1FP3fyjatdVMLZciLGd8Tz09uspb
         bAtWhVUFMrSdBhj1INaOOue6ssB5xzqQ/2ZnS5NGnqaNWipfcipb5uxMTJUHfgCp/R1T
         Udmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=RJUKkvBdshNh+7HNcvSDGQnYzffj0NPPaI8hCS45hnA=;
        b=UKE9IkP0k2iBIrvZjLUqQkqIvj2OUNHkbjueo9SdvNq+j+fDq2weUNrsrWmGPjjGdK
         j/6RKRrX9xztKPZyIsGnqWJ/rD/r66/ArmgcPTg1xhJYTlqCytOqNX70w5E2sk1t+Wgb
         N33rL2dAI4SHpZ+35c0yCbK0tI4hrWu7dV2Y50x+tmn6RaiqTqCfze6mYwKMkn3HWoRo
         jyPjaAf/YUrDuty2J+qJpURvnXTHpibyK00OLejKrT/kF4+Rz0dv+dVKNGAHv31yc2sL
         cTbClh7lsQf3BDgazYpKQKe33H2NeBWWVoxnb8EpIuFolBzNQ1gtSW1j7iZdGLJyQ+jm
         FBaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 5 Apr 2018 00:17:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dexuan Cui <decui@microsoft.com>
cc: 'Greg KH' <gregkh@linuxfoundation.org>,
    "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    KY Srinivasan <kys@microsoft.com>,
    Stephen Hemminger <sthemmin@microsoft.com>,
    Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: Any standard kernel API to dynamically allocate/free per-cpu
 vectors on x86?
In-Reply-To: <KL1P15301MB000638051CC8DC7FD2A2E74BBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.1804050004230.1492@nanos.tec.linutronix.de>
References: <KL1P15301MB000638051CC8DC7FD2A2E74BBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849968280484666?=
X-GMAIL-MSGID: =?utf-8?q?1596855691639955607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dexuan,

On Wed, 4 Apr 2018, Dexuan Cui wrote:

> Hi,
> Recently, two Hyper-V specific vectors were introduced in
> arch/x86/include/asm/irq_vectors.h:
> 
> #if IS_ENABLED(CONFIG_HYPERV)
> #define HYPERV_REENLIGHTENMENT_VECTOR   0xee
> #define HYPERV_STIMER0_VECTOR           0xed
> #endif
> 
> What if we need more such vectors on Hyper-V? This static global reservation
> mechanism doesn't scale, IMO.
> 
> Actually I believe we don't really need to reserve the same vector on all CPUs,
> because the model-specific registers (MSRs) defined for Hyper-V synthetic 
> interrupt controller (SynIC) are per-cpu, meaning each virtual processor has
> its own copy of these registers, so they can be programmed independently.
> 
> That is to say, we can use different vectors for the same Synthetic Interrupt,
> as long as we're able to dynamically get a per-cpu vector for each CPU.
> 
> I'm wondering if there is such a standard kernel API on x86. 
> As I skimmed through the code, I haven't found it yet, if any.
> 
> PS, the background of my question is that: in the future Hyper-V will
> support multiple VMBus drivers running simultaneously in one virtual
> machine, and I think it would be better for the future secondary VMBus
> driver to use a different synthetic interrupt, which I hope can be
> configured with dynamic vectors rather than a new static globally-reserved
> vector.

We don't have a simple way to do such allocations because they involve IDT
entry manipulation.

If there is no hard requirement that this stuff runs through an direct
vector, then we could simply make these interrupts go through the normal
interrupt path. That means you have to request them like regular device
interrupts and the handling path is slightly longer than the direct vector
mode. You'd get virtual interrupt numbers per cpu which also show up in
/proc/interrupts as separate lines.

That needs a very simple and minimal virtual interrupt controller driver
which is mostly a dummy implementation except for the activation function
which would allow you to retrieve the vector number and store it in the
MSR.

There are a few details to be hashed out vs. CPU hotplug, but we have all
the infrastructure in place to deal with that.

Hmm?

Thanks,

	tglx
