Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELvnSwNDxJMP0zJHRIjdOUoixmks1Pw8dvYyVIp4ugXsnESO0nCLHPbIeFKW8NGXaa0Gj5Cq
ARC-Seal: i=1; a=rsa-sha256; t=1519751489; cv=none;
        d=google.com; s=arc-20160816;
        b=Lr6lAm1r+HD9Dv74wezo9JunNeFegJvfAsTy9K/tPVLC68t78OZqSxxuCoz4afa8b8
         NfpZwJxnvy0nuvgLEsc+zl0TzpNGTJvDCh2u2s/PqlwmBEWpQzFmc5LT7mQdV45+xyB6
         8MWH8tAVhru5AHasY3EmCcpD8XZKkjoVGwEAXlDhg6nUnlSM+uLBXS2r8BwdEWMlSGAA
         hHOKJeejvyYsMkX6nNoYHzHc3bJ3ICbWin7SLP/nxKwsIoKymRIQ+kTV5c8v+TNZI77U
         /pymkrr01XJV7V/WlZgl0XlXrDICdRXHwiKjlWrFXpz2qA14gpxlSqvE5K6Vozlme3AW
         lndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0zUkMrt37qD87CTSCW5uXtnG8C5CnZwfNXF9QP40O/0=;
        b=YyC4JxSaseeDVXruoinXG8E/5yUksBWTZ2ZkKQ9ph9cmUqBHvQ+ENp9bnLr/hLY0G4
         Y2gYIMnCnor5i1c/OTl2H2sluM9BLEfdZKDZwjdXdsXZ3CVX8HRv0/M+YeqBnD28XCW7
         NGw4CwYjVZklq1IHhwn2U5Efb79ToFgGivvHnxraIX+qFeuYlGkA+zLgva4GsnCJ+Mwe
         WNE1bqkGK4A8dhgHUIQIDutqL6gE6jf1EI+rBuOt7L0LxIIN7cXyFP+Ai/SVjlP9h15N
         qaaQYvRZGvfWsa2mcI467PQP+F0FJITSo5CZjMNxwP5K7/v3brJeB3CVay2GQnhOdHov
         tKbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Tue, 27 Feb 2018 17:11:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 0/3] STM32 Extended TrustZone Protection driver
Message-ID: <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227140926.22996-1-benjamin.gaignard@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563499941739218?=
X-GMAIL-MSGID: =?utf-8?q?1593574938268090577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:09:23PM +0100, Benjamin Gaignard wrote:
> On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
> to a secure OS running in TrustZone.
> We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
> because read/write access will all be discarded.
> 
> Extended TrustZone Protection driver register itself as listener of
> BUS_NOTIFY_BIND_DRIVER and check, given the device address, if the hardware block
> could be used in a Linux context. If not it returns NOTIFY_BAD to driver core
> to stop driver probing.

Huh?

If these devices are not usable from the non-secure side, why are they
not removed form the DT (or marked disabled)?

In other cases, where resources are carved out for the secure side (e.g.
DRAM carveouts), that's how we handle things.

Mark.

> 
> NOTE: patches 2 and 3 should be applied only on
> git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
> but until this patch: https://lkml.org/lkml/2018/2/26/386
> find it way to mailine KBuild will complain about them.
> 
> Benjamin Gaignard (3):
>   driver core: check notifier_call_chain return value
>   dt-bindings: stm32: Add bindings for Extended TrustZone Protection
>   ARM: mach-stm32: Add Extended TrustZone Protection driver
> 
>  .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       |  13 ++
>  arch/arm/mach-stm32/Kconfig                        |   7 +
>  arch/arm/mach-stm32/Makefile                       |   1 +
>  arch/arm/mach-stm32/stm32-etzpc.c                  | 252 +++++++++++++++++++++
>  drivers/base/dd.c                                  |   9 +-
>  5 files changed, 279 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
>  create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c
> 
> -- 
> 2.15.0
> 
