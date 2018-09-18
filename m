Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D63C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558E02086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="fxi3UlBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558E02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeIRRCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:02:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42598 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727228AbeIRRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:02:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AD2A18EE23D;
        Tue, 18 Sep 2018 04:30:14 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QZoCQskO_XWl; Tue, 18 Sep 2018 04:30:14 -0700 (PDT)
Received: from [172.20.5.140] (50-235-16-99-static.hfc.comcastbusiness.net [50.235.16.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8D2188EE0ED;
        Tue, 18 Sep 2018 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1537270214;
        bh=swa7oxdKgGZQncA0MLpDAT7vlDqQUQlA3ofzgHSK80A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fxi3UlBGHE84BvtLYZFZwIdj3NZYqWopERA+fmhCLwLH1sTSrFjyaf5Vkmg2xQk3c
         Kg0sL0Mb/DjfqpsnFiV4txnFZfBn+rTouzWY2zZcv4y8P9GQT+BOMswZhw2TNXjCKd
         ATYL4aiOVGAgYAIbClRB6VsqJaX0UPDR7I1eD+2c=
Message-ID: <1537270212.3424.4.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     James Morris <jmorris@namei.org>,
        Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Sep 2018 07:30:12 -0400
In-Reply-To: <1537254055.20009.64.camel@infradead.org>
References: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
         <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
         <alpine.LRH.2.21.1809061007140.23269@namei.org>
         <12101.1536420374@warthog.procyon.org.uk>
         <1537254055.20009.64.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 08:00 +0100, David Woodhouse wrote:
> 
> On Sat, 2018-09-08 at 16:26 +0100, David Howells wrote:
> > Marcel Holtmann <marcel@holtmann.org> wrote:
> > 
> > > 
> > > so I have reviewed and tested this code. In addition, we have
> > > test cases for it in ELL (embedded linux library).
> > 
> > I wonder if there's any practical way to add a test for this to the
> > keyutils test suite.  I'm guessing it's quite tricky, given the
> > extra bits you need to emulate the TPM.
> 
> Right, for a lot of userspace stuff we have the TPM emulator but for
> the kernel you might need to run in qemu, which I believe can emulate
> a TPM now (or at least, can talk to the TPM emulator, which has the
> same effect).

Actually, you don't necessarily.  I use this patch:

https://marc.info/?l=tpmdd-devel&m=148392353230117

Which allows me to make a TCP connection to the software TPM running in
userspace without having to have the TPM components in qemu (or even to
run virtual).  I used it to debug all the in-kernel resource manager
patches.  It's TPM 2.0, but could easily be modified to work with 1.2

James

