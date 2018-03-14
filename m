Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeCNOlQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:41:16 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52464 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752009AbeCNOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:41:14 -0400
Message-ID: <1521038471.4508.25.camel@HansenPartnership.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-ima-devel@lists.sourceforge.net"
        <linux-ima-devel@lists.sourceforge.net>,
        "linux-ima-user@lists.sourceforge.net"
        <linux-ima-user@lists.sourceforge.net>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 14 Mar 2018 07:41:11 -0700
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C002367FEF@ALPMBAPA12.e2k.ad.ge.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
         <1520893847.4522.62.camel@HansenPartnership.com>
         <1520897400.3547.253.camel@linux.vnet.ibm.com>
         <1520899605.4522.67.camel@HansenPartnership.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C002367FEF@ALPMBAPA12.e2k.ad.ge.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 12:57 +0000, Safford, David (GE Global Research,
US) wrote:
> > 
> > -----Original Message-----
> > From: James Bottomley [mailto:James.Bottomley@HansenPartnership.com
> > ]
> > Sent: Monday, March 12, 2018 8:07 PM
> > To: Mimi Zohar <zohar@linux.vnet.ibm.com>; Jiandi An
[...]
> > > > The key question is not whether the component could
> > > > theoretically
> > > > access the files but whether it actually does so.
> > > 
> > > As much as you might think you know what is included in the
> > > initramfs, IMA-measurement is your safety net, including
> > > everything accessed in the TCB.
> > 
> > The initrd *is* part of the Trusted Computing Base because it's
> > part of the boot custody chain.  That's really my point.  If I
> > don't know what's in my initrd, I've broken the chain there and IMA
> > can't fix it.
> > 
> > James
> 
> That's exactly the point - how do you know what's in your initrd?
> The initrd is normally built on the possibly compromised system in
> question.

The point of deploying security measures is to make sure my system
isn't compromised.  I realise the institutional view is "we didn't
build the initrd" and my individual view is well, I built my own kernel
as well, so what's the difference?  But the initrd in both models is
still part of the chain.

> It's not signed as a whole by someone trusted. How can the
> attestation server say a given hash of the initrd as a whole is good?

I trust myself.  I can get the hash at build time.  In the same way as
I sign my own kernel at build time for secure boot.

> If IMA is running from the very start, it can at least measure (and
> eventually appraise) every individual file in the initrd. Given this
> more detailed measurement list, the attestation server can verify all
> the components in the initrd, even when it is assembled on the
> untrusted system.
> 
> On many embedded systems, there is no initrd, and IMA has to start
> measuring and appraising immediately, anyway.
> 
> Perhaps there is a use case where there is a known set of initrd
> images, and so the bootloader's measurement of the initrd is
> sufficient for verification. I've not run into that situation yet. If
> you want an option for this use case,  that's fine, (I'm all for
> choice) but it should not be the default for IMA.

Actually, we seem to have wandered away from the main concern which was
trying to select built in TPM drivers.  What about a compromise: we
already get the boot loader to do measurements and PCR extensions using
the BIOS TPM driver, there's no reason why we can't do the same in the
early kernel until a real TPM driver is found.  That way IMA would have
no dependency on any built in TPM driver ... is that an acceptable
compromise to everyone?

James
