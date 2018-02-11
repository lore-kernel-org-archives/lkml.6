Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeBKNUD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 08:20:03 -0500
Received: from namei.org ([65.99.196.166]:48558 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752597AbeBKNUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 08:20:02 -0500
Date: Mon, 12 Feb 2018 00:19:55 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Integrity: IMA FUSE fixes
In-Reply-To: <1518324116.5491.132.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1802112339270.20189@namei.org>
References: <alpine.LRH.2.21.1802101718330.4382@namei.org>  <CA+55aFzX+=WRaVi51gaqCdnrxwXC3kqxk8LZyXQY=yn5XigE4Q@mail.gmail.com> <1518324116.5491.132.camel@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-339538886-1518354090=:20189"
Content-ID: <alpine.LRH.2.21.1802120001450.20189@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-339538886-1518354090=:20189
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.1802120001451.20189@namei.org>

On Sat, 10 Feb 2018, Mimi Zohar wrote:

> > Which seems *worse* than what we do now, in that it wastes time and
> > effort on re-creating those pointless measurements because it disables
> > the caching of them.
> > 
> > So honestly, the only sane thing seems to be to disable IMA on fuse,
> > not to force it to do even _more_ pointless work.
> > 
> > What am I missing?
> 
> No, you're right.  The file could change at any time, making the
> measurement(s) and by extension signature verification meaningless. 

Really?  I thought the whole idea of IMA was that it only detects offline 
tampering and it specifically does not protect against runtime attacks.

Any file could change after measurement on a compromised or misconfigured 
system.  e.g. via direct write to the block device.

> Custom policy rules could be defined to disable measurement,
> appraisal, and audit for files on fuse.  However, I don't think we
> want to automatically disable measurement, even meaningless
> measurements.  Some indication needs to be included for remote
> attestation, security analytics, or forensics.  For systems with
> policies that require file signatures even on fuse, the safest thing
> would seem to be to fail the signature verification.

I don't understand this -- if a file passes signature verification, it 
passes.  If it was modified and still passes, the problem is elsewhere.

I don't think the FUSE measurements are inherently useless, or more 
useless than any others, at least.  You can misconfigure all kinds of 
things on a system which would undermine IMA, and I would count allowing 
unprivileged use of FUSE with critical files as such.

The point of the patches, IIUC, was that FUSE had no useful way to notify 
IMA that a file had changed, so, always measure.  IMA assumes that changes 
to a running system are made under the control of a correctly enforced 
security policy.  If you're using FUSE and IMA, then you should understand 
the security implications of that.  Or am I missing something?


- James
-- 
James Morris
<jmorris@namei.org>
--1665246916-339538886-1518354090=:20189--
