Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3A3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5C220684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="EnKuW6F7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5C220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeGSUhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:37:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43336 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbeGSUhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:37:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 980298EE1DD;
        Thu, 19 Jul 2018 12:53:01 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lbL539sGRlwC; Thu, 19 Jul 2018 12:53:01 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 099798EE150;
        Thu, 19 Jul 2018 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1532029981;
        bh=8Y4H9nOsbb3DLvavZPV6JPCmIbUaWFM0j0/Bkdb9yLk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EnKuW6F7Nv745eY/IJziJwIgOISdSgd/kPaXFVCpUR8EQ8p5xVv3ha/k3ZX2JfTc9
         9HVCTCB6+czqQQmBjDclfGmwUF+8CvQ+jQ26Yvg8MPOy6paEmIrvK/t0j+enugJTG4
         JU3uDZwD8AnsU1praRcanwLDRHsc+H++MmN19KIA=
Message-ID: <1532029979.3198.4.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add support for partial reads
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Jul 2018 12:52:59 -0700
In-Reply-To: <e8c17a40-7e5e-61e9-7088-32817766b614@intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
         <1532020750.5396.4.camel@HansenPartnership.com>
         <421c4b75-9e9d-7045-adad-797fd112898a@intel.com>
         <1532026030.3198.2.camel@HansenPartnership.com>
         <e8c17a40-7e5e-61e9-7088-32817766b614@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 12:05 -0700, Tadeusz Struk wrote:
> On 07/19/2018 11:47 AM, James Bottomley wrote:
> > On Thu, 2018-07-19 at 10:54 -0700, Tadeusz Struk wrote:
> > > On 07/19/2018 10:19 AM, James Bottomley wrote:
> > > > That's just an implementation, though, what's the use case?
> > > 
> > > Hi James,
> > > The use case is described in the TCTI spec [1] in the
> > > "3.2.5.2 receive" section.
> > 
> > Well, yes, but I think we've all agreed that the /dev/tpm and
> > /dev/tpmrmX aren't TCTI interfaces, although you can layer TCTI on
> > top of them, so why not simply do fragmentation on top if you need
> > it?
> > 
> > The reason for not doing it in the interface is that it alters the
> > ABI.  Before this patch we had a hard packet boundary: one packet
> > per read, one per write and a -EFAULT if you fail to provide a
> > correctly sized buffer.  Now if you provide a buffer too small but
> > don't know about the fragmentation you're going to misprocess a
> > packet (because you think you got a whole reply but you didn't) and
> > then you get a -EBUSY on your next command which you don't know how
> > to handle.  The only way out is to update the applications to
> > handle the new behaviour, which is a no-no in Linux ABI terms.
> 
> Don't all the existing applications that read a response in one go
> do a 4K read now? So nothing will change for them. They will work
> exactly the same with this change as they do without it.
> This doesn't break the ABI.

The ABI break is the error case as I outlined above.  We can't assume
everyone uses the current interface without getting an error and one
error and your hosed is a nasty failure case to change the interface
to.  Plus, if you assume everyone is passing 4k buffers, why would you
even need the fragmentation case?

> > It might be possible to layer the behaviour you want compatibly
> > into the current device structure (say an ioctl to switch to the
> > fragment behaviour) but I've got to ask why we'd go to the
> > complexity without a use case?
> 
> New IOCTL would add extra complexity, which isn't necessary.

So what's wrong with fragmenting in the layer above the device driver
(in userspace) and not actually changing the kernel?

James

