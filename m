Return-Path: <benh@kernel.crashing.org>
X-Google-Smtp-Source: AIpwx4877wuwFhHRG4QmUt8s2qXv4i0XLbUZ+82eI0Z/wcppEetQlh82b28CjLQaLPa+YyWeJpjD
ARC-Seal: i=1; a=rsa-sha256; t=1523351870; cv=none;
        d=google.com; s=arc-20160816;
        b=M8FTEx5Ded1mpSV8ivY8Zj3tCorr7JXZP4RGjwyVD4Uy7SAMU/P6gz54HOOccEqZdB
         QyT/TGYQ03HdHZ9PYWTVFhX/m6WbWpsKQasq6Mfxg9VM2btsmG2kp6UsRKg7T3DARzuU
         verd8BPyV8u3UI+8ZqkN/WiDfct9eNBz0be0sM6hZmIavD48U8wFELx5kisc6CGTQBL7
         +Ed6TEr3IIaBu0VAgAjl1IDMp98dHwHEBKa9m6tLusUpagx6EupFq9fzdw87GQAVnSir
         nkCaMLYwfI3Huf4TZ4cbfmlUQ/JFxQhi7mZIL+e6tLttdJx1isbegBOUlMfEKYi6qJgN
         5mBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:date:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=DkwjiTuW0b5+zlGlhXnqGMhrrg0v3sEdiPgd3MX3gp0=;
        b=wGXnwLHvuSpj6XMeZyUMrQBjdcejggN6i2O9oX6KrgqhVCF6izsOHwq6+DmSNK9VEN
         mr+nLUgpJK4er5POjwe2KRn+aMP+ZpJPtEQ1nsZWTJmLOZks9uT8N7U0+BOv7tZle7E2
         A3Xxjz/gEUBqhfK1rHI0lmXavhiw0/dlC+nDB3sAzdvaDjmNuu/XGsxOdS33RzlD4jh+
         ntzy5tPRoH4ToI/PhaWXwSA8Cv2m+Qs1apaJ7THImEs4GmRBTFOicMv3UrkmiAUzDXDc
         bmtLcLufn2ya0MGC8bh0RymHkS4R8yyqQMEgl2lngFIHxqKC+MBCEaYBF3VzPYbVAstH
         zt4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of benh@kernel.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=benh@kernel.crashing.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of benh@kernel.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=benh@kernel.crashing.org
Message-ID: <1523351850.11062.80.camel@kernel.crashing.org>
Subject: How to expose various BMC chip controls ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann
	 <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew
 Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel.stanley@au1.ibm.com>,
        Jeremy
 Kerr <jeremy.kerr@au1.ibm.com>
Date: Tue, 10 Apr 2018 19:17:30 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597350209516531918?=
X-GMAIL-MSGID: =?utf-8?q?1597350209516531918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Folks !

I would like to discuss something we need to solve for BMC chips before
we start implementing a solution that you'll reject upstream :-)

So quick recap: the BMC chip is the management controller of your
server, typically some kind of specialized ARM SoC which controls a
variety of things ranging from power supply, fans, inventory, flash, to
having even a built-in GPU connected to the main server processor via
PCIe etc...

As part of the OpenBMC project, we have been contributing (along with
others from Google etc...) a bunch of upstream drivers to support the
BMC chips from Aspeed which are quite popular. There's work in progress
to also upstream other vendor(s) chip support.

For most things, we can write appropriate drivers.

However, there's a range of things for which there is no good fit for
dedicated per-function kernel drivers in the BMC:

The BMC chips have a variety of control bits and pieces (registers)
that affect the host in all sorts of ways. A few semi-random examples:

 - Scratch registers that the host BIOS can read via LPC that contain
system specific details of interest to the BIOS itself. The
content/format is specific to a given BIOS <-> BMC userspace pair.

 - Similar ones related to the built-in VGA (the one the host sees on
PCIe, it doesn't appear as a device on the BMC side). Used to pass some
wiring information to the VGA BIOS and the Linux driver among others.

 - Bits controlling which parts of the BMC the host can access remotely
via either LPC or PCIe. (Visibility of the VGA to the host, of the BMC
PCIe system-controller device, opening of various windows from the host
into the BMC address space etc...)

 - ... and a few more

Those things tend to be fairly system specific. Meaning that what's
written in them (or read from them) and when it's written in these
registers should be under userspace control on the BMC. There isn't
necessarily many registers that need to be exposed that way, here too,
which specific ones is rather system specific.

But /dev/mem isn't a solution :-)

So one simple idea I had, you tell me if it can fly, is to have some
driver for the SoC as a whole (thinking of syscon here...) expose a
selection of these things via sysfs.

The list being potentially system specific, it would be provided to
the kernel via the device-tree (binding tbd) where we would effectively
provide a list of names, register offset, start bit, bitfield size.

Any better idea ? It's a fairly simple problem, and the above solution
would be very little code, but I just don't want us to go down a rabbit
hole if some of you have religious objections to some of it :)

Cheers,
Ben.
