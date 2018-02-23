Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeBWQke convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:40:34 -0500
Received: from smtp-out6.electric.net ([192.162.217.188]:60429 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeBWQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:40:31 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Arnd Bergmann'" <arnd@arndb.de>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC: Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
Thread-Topic: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
Thread-Index: AQHTrLxWasgki/emY0WMcZzOZHZDm6OyLxeA
Date: Fri, 23 Feb 2018 16:41:21 +0000
Message-ID: <e8e54cb303074abd82048ffa65f26fc9@AcuMS.aculab.com>
References: <20180223153700.2186058-1-arnd@arndb.de>
In-Reply-To: <20180223153700.2186058-1-arnd@arndb.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
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

From: Arnd Bergmann
> Sent: 23 February 2018 15:37
> 
> 32-bit architectures generally cannot use writeq(), so we now get a build
> failure for the lpfc driver:
> 
> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_wq_put':
> drivers/scsi/lpfc/lpfc_sli.c:145:4: error: implicit declaration of function 'writeq'; did you mean
> 'writeb'? [-Werror=implicit-function-declaration]
> 
> Another problem here is that writing out actual data (unlike accessing
> mmio registers) means we must write the data with the same endianess
> that we have read from memory, but writeq() will perform byte swaps
> and add barriers inbetween accesses as we do for registers.
> 
> Using memcpy_toio() should do the right thing here, using register
> sized stores with correct endianess conversion and barriers (i.e. none),
> but on some architectures might fall back to byte-size access.
...

Have you looked at the performance impact of this on x86?
Last time I looked memcpy_toio() aliased directly to memcpy().
memcpy() is run-time patched between several different algorithms.
On recent Intel cpus memcpy() is implemented as 'rep movsb' relying
on the hardware to DTRT.
For uncached accesses (typical for io) the 'RT' has to be byte transfers.
So instead of the 8 byte transfers (on 64 bit) you get single bytes.
This won't be what is intended!
memcpy_toio() should probably use 'rep movsd' for the bulk of the transfer.

	David
