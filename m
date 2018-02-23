Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeBWRIY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:08:24 -0500
Received: from smtp-out4.electric.net ([192.162.216.181]:64961 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBWRIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:08:23 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Andy Shevchenko'" <andy.shevchenko@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
Thread-Topic: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
Thread-Index: AQHTrLxWasgki/emY0WMcZzOZHZDm6OyLxeAgAAEdICAAAIfQA==
Date: Fri, 23 Feb 2018 17:09:09 +0000
Message-ID: <04b6c673208b4680b7d6cf41ccdfd3f0@AcuMS.aculab.com>
References: <20180223153700.2186058-1-arnd@arndb.de>
 <e8e54cb303074abd82048ffa65f26fc9@AcuMS.aculab.com>
 <CAHp75VfNKVjAmgEor2veC6sDnuLacxK1BVgKbqdZ-mxOX=9CSw@mail.gmail.com>
In-Reply-To: <CAHp75VfNKVjAmgEor2veC6sDnuLacxK1BVgKbqdZ-mxOX=9CSw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1NH8SII016576

From: Andy Shevchenko
> Sent: 23 February 2018 16:51
> On Fri, Feb 23, 2018 at 6:41 PM, David Laight <David.Laight@aculab.com> wrote:
> > From: Arnd Bergmann
> >> Sent: 23 February 2018 15:37
> >>
> >> 32-bit architectures generally cannot use writeq(), so we now get a build
> >> failure for the lpfc driver:
> >>
> >> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_wq_put':
> >> drivers/scsi/lpfc/lpfc_sli.c:145:4: error: implicit declaration of function 'writeq'; did you mean
> >> 'writeb'? [-Werror=implicit-function-declaration]
> >>
> >> Another problem here is that writing out actual data (unlike accessing
> >> mmio registers) means we must write the data with the same endianess
> >> that we have read from memory, but writeq() will perform byte swaps
> >> and add barriers inbetween accesses as we do for registers.
> >>
> >> Using memcpy_toio() should do the right thing here, using register
> >> sized stores with correct endianess conversion and barriers (i.e. none),
> >> but on some architectures might fall back to byte-size access.
> > ...
> >
> > Have you looked at the performance impact of this on x86?
> > Last time I looked memcpy_toio() aliased directly to memcpy().
> > memcpy() is run-time patched between several different algorithms.
> > On recent Intel cpus memcpy() is implemented as 'rep movsb' relying
> > on the hardware to DTRT.
> > For uncached accesses (typical for io) the 'RT' has to be byte transfers.
> > So instead of the 8 byte transfers (on 64 bit) you get single bytes.
> > This won't be what is intended!
> > memcpy_toio() should probably use 'rep movsd' for the bulk of the transfer.
> 
> Maybe I'm wrong but it uses movsq on 64-bit and movsl on 32-bit.

(Let's not argue about the instruction mnemonic). 

You might expect that, but last time I looked at the bus cycles on a PCIe slave
that wasn't what I saw.

> The side-effect I referred previously is about tails, i.e. unaligned
> bytes are transferred in portions
> like
>   7 on 64-bit will be  4 + 2 + 1,
>   5 = 4 + 1

on 64bit memcpy() is allowed to do:
	(long *)(tgt+len)[-1] = (long *)(src+len)[-1];
	rep_movsq(tgt, src, len >> 3);
provided the length is at least 8.

The misaligned PCIe transfer generates a single TLP covering 12 bytes with the
relevant byte enables set for the first and last 32bit words.

	David
