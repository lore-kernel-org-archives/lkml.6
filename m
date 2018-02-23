Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeBWRos (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:44:48 -0500
Received: from smtp-out4.electric.net ([192.162.216.195]:55497 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeBWRoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:44:46 -0500
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
Thread-Index: AQHTrLxWasgki/emY0WMcZzOZHZDm6OyLxeAgAAEdICAAAIfQIAAA+YAgAADu3A=
Date: Fri, 23 Feb 2018 17:45:33 +0000
Message-ID: <7a5345132c02476cbd92dba2e2ca9e72@AcuMS.aculab.com>
References: <20180223153700.2186058-1-arnd@arndb.de>
 <e8e54cb303074abd82048ffa65f26fc9@AcuMS.aculab.com>
 <CAHp75VfNKVjAmgEor2veC6sDnuLacxK1BVgKbqdZ-mxOX=9CSw@mail.gmail.com>
 <04b6c673208b4680b7d6cf41ccdfd3f0@AcuMS.aculab.com>
 <CAHp75VcGM=2Tg3Qw-ywC=_Sofgg7Wppf=f=Jhs18n4U1tbTTGA@mail.gmail.com>
In-Reply-To: <CAHp75VcGM=2Tg3Qw-ywC=_Sofgg7Wppf=f=Jhs18n4U1tbTTGA@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1NHirq1029569

From: Andy Shevchenko
> Sent: 23 February 2018 17:13
> To: David Laight
> Cc: Arnd Bergmann; James Smart; Dick Kennedy; James E.J. Bottomley; Martin K. Petersen; Hannes
> Reinecke; Johannes Thumshirn; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
> 
> On Fri, Feb 23, 2018 at 7:09 PM, David Laight <David.Laight@aculab.com> wrote:
> > From: Andy Shevchenko
> >> Sent: 23 February 2018 16:51
> >> On Fri, Feb 23, 2018 at 6:41 PM, David Laight <David.Laight@aculab.com> wrote:
> 
> 
> >> The side-effect I referred previously is about tails, i.e. unaligned
> >> bytes are transferred in portions
> >> like
> >>   7 on 64-bit will be  4 + 2 + 1,
> >>   5 = 4 + 1
> >
> > on 64bit memcpy() is allowed to do:
> >         (long *)(tgt+len)[-1] = (long *)(src+len)[-1];
> >         rep_movsq(tgt, src, len >> 3);
> > provided the length is at least 8.
> >
> > The misaligned PCIe transfer generates a single TLP covering 12 bytes with the
> > relevant byte enables set for the first and last 32bit words.
> 
> But is it guaranteed on any type of bus?
> memcpy_toio() is a generic helper, so, first of all we need to be sure
> what CPU on its side does, this is I think is pretty straight forward
> since it's all written in asm for 64-bit case.

I've just done a compile test, on x86-64 memcpy_toio() generates a
call to memcpy() (checked with objdump -dr).
That is on a system running a 4.14 kernel, so is probably using the system
headers from that release.
I'd need to do a run-time test on a newer system verify what the PCIe slave
sees - but I changed our driver to do its own copy loops in order to avoid
byte transfers some time ago.

FWIW I was originally doing copy_to/from_user() directly to PCIe memory addresses!

On x86 'memory' on devices can always be accesses by simple instructions.
Hardware 'IO' addresses are not valid for memcpy_to/fromio().

	David
