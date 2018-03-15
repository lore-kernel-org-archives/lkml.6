Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AG47ELve15oXBgkysvL+gZRIzfrmk9rpH5Uk98oDJH9kruYa5I++m2pyTfqS/10TSRzaLadaDOiC
ARC-Seal: i=1; a=rsa-sha256; t=1521119105; cv=none;
        d=google.com; s=arc-20160816;
        b=RqvFQ0dq7AWF8WjzsDuCWUg2uQSKYec/2s+Vl9uAlxwepHCZprYAiMxJCinBAmc29+
         USb/u1Mv8FAPKhzDMKTAPCilKVKVKpdp+1rJ/cWCKc4Dr17PSIeXrWmAChtTaq2W48aI
         YncYl7v1BTO0Sgyz31izBkg7hHkFIZW7k8/9TbSGcqNIKtqPDfSF73TdwuRYmcOvbow4
         8W1VAcG3JSsHgqAdQCFFVex3DOiOqghXLm+qNG+uw+1dgu+JYGeUMm+x4+NlGoEXS2yK
         +G6IWp9oVcAztlXHPY7d2jETgCQdeAq8oAmmoUix80xjLuV1V6cEElM6v9Z+hPS2NLru
         iChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=h5ZfXodXpFvirbeON7/QXBeaTULv+ZQvXhN7VgNxsN4=;
        b=jqUBqQv0zdzRQIFBXwEPe2ELONGDStDKxJBlpVOjrWktgvG7GbftjElqYueFWEKKRT
         N1ICIy+XQbFnemtDi8VIzmJDuqK5enLoXhlHZKHYAh1LbfiP0dbfFj0axO8wOpyc5DLh
         OkZE28NnCA28vcqw8pSQttnOGaeBigH1j+aoKKnHcOo8NhfKTIZZkdNXVW6yN4HRzYHi
         MUP3j/hjHGfgEv0ooqd8ukcOGew+wUMYBvNhGn9Hap3KhBTR4LLPGl6CiQc0WQjmaDq3
         9XM2mYGLtNqT9CBOAMql9iFXVfDBceA6lBdh2X1/xjAfbsa/IDyq+9UGI8RKN8Mjr7fr
         tUlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="211815975"
Message-ID: <1521119068.10722.661.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] serial: core: Allow skipping old serial port
 initialization
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Kurtz <djkurtz@chromium.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Slaby
 <jslaby@suse.com>,  Kees Cook <keescook@chromium.org>, Matthias Brugger
 <mbrugger@suse.com>, David Howells <dhowells@redhat.com>, Allen Pais
 <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Douglas Anderson
 <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy Chen
 <jeffy.chen@rock-chips.com>, Marc Gonzalez
 <marc_gonzalez@sigmadesigns.com>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,  "open list:SERIAL DRIVERS"
 <linux-serial@vger.kernel.org>
Date: Thu, 15 Mar 2018 15:04:28 +0200
In-Reply-To: <20180315020445.150604-4-djkurtz@chromium.org>
References: <20180315020445.150604-1-djkurtz@chromium.org>
	 <20180315020445.150604-4-djkurtz@chromium.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594871331983338334?=
X-GMAIL-MSGID: =?utf-8?q?1595008986894225895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-14 at 20:04 -0600, Daniel Kurtz wrote:
> The old_serial_port global array in 8250_core is supposed to hold an
> entry
> for each serial port on the system that cannot be discovered via a
> standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is
> populated
> at compile-time from the value specified in the SERIAL_PORT_DFNS
> macro.
> This macro is defined in arch/serial.h.
> 
> For x86, this macro is currently unconditionally initialized to supply
> four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).
> 
> However, not all x86 CPUs have these four ioport UARTs.  For example,
> the
> UARTs on AMD Carrizo and later are separate memory mapped Designware
> IP
> blocks.
> 
> Fairly early in boot the console_initcall univ8250_console_init
> iterates
> over this array and installs these old UARTs into the global array
> serial8250_ports.  Further, it attempts to register them for use as
> the console.  In other words, if, for example, the kernel commandline
> has
> console=ttyS0, the console will be switched over to one of these
> non-existent UARTs.  Only later, when the real UART drivers are probed
> and their devices are instantiated will the console switch back over
> to
> the proper UART.
> 
> This is noticeable when using earlycon, since part of the serial
> console
> log will appear to disappear (when the bogus old takes over) and then
> re-appear (when the real UART finally gets registered for the
> console).
> 
> The problem is even more noticable when *not* using earlycon, since in
> this case the entire console output is missing, having been
> incorrectly
> played back to the non-existing serial port.
> 
> Create a global variable to allow skipping old serial port
> initialization
> and wire it up to the AMDCZ ACPI SPCR quirk and the special amdcz
> earlycon
> setup handler.

I don't like this approach at all.
But unfortunately I have nothing to propose.
Just felt like I have to share my opinion on this.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
