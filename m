Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BDE21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G4izdI+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BDE21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeHBUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:50:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39574 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726580AbeHBUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:50:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B2DC58EE13D;
        Thu,  2 Aug 2018 11:57:42 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qDwqseHYTUiY; Thu,  2 Aug 2018 11:57:42 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EFD288EE0E4;
        Thu,  2 Aug 2018 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533236262;
        bh=PSaO9bHfF1Mde08f5m+3qz1pBukUpDFIkjq77G3NiXY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G4izdI+dN7fRzQNPve9VaO8WUT+u8JISpBPcYhfPoosifh0eK7HOIHN8igyj/8Rk6
         a64qazea+XDF93UIzRQ48/OM4KcaZLIxTvPd8i2g5UESgXD+xX2uePpB5X/10Kt/wg
         zBdopEvcmRcKE5OGDGgF2WTod/BzhcbIHqwkTyss=
Message-ID: <1533236261.12916.5.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Udit Agarwal <udit.agarwal@nxp.com>
Cc:     zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        denkenz@gmail.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Date:   Thu, 02 Aug 2018 11:57:41 -0700
In-Reply-To: <8060.1533226481@warthog.procyon.org.uk>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> Udit Agarwal <udit.agarwal@nxp.com> wrote:
> 
> > +==========
> > +Secure Key
> > +==========
> > +
> > +Secure key is the new type added to kernel key ring service.
> > +Secure key is a symmetric type key of minimum length 32 bytes
> > +and with maximum possible length to be 128 bytes. It is produced
> > +in kernel using the CAAM crypto engine. Userspace can only see
> > +the blob for the corresponding key. All the blobs are displayed
> > +or loaded in hex ascii.
> 
> To echo Mimi, this sounds suspiciously like it should have a generic
> interface, not one that's specifically tied to one piece of hardware
> -
> particularly if it's named with generic "secure".
> 
> Can you convert this into a "symmetric" type and make the backend
> pluggable?

This is a symmetric key backed by a piece of hardware, which is exactly
what trusted keys are, so if we're defining common infrastructure with
callouts, trusted keys should be part of it.

Additionally, when I look at the trusted key code, I have significant
qualms about using the TPM RNG exclusively in the same way CAAM wants
to use its own RNG.  What I think both should be doing is collecting
data from their local RNGs, mixing it into the kernel entropy pool and
using a kernel generated random number (just in case these RNGs
suddenly turn out to be less random than they should be).

James


