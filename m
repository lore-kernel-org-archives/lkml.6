Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C99521761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nbp86YCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C99521761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeHCQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:20:35 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49034 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729985AbeHCQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:20:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4CACE8EE13D;
        Fri,  3 Aug 2018 07:24:00 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZNyBzWWvPIIn; Fri,  3 Aug 2018 07:24:00 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6455B8EE0C9;
        Fri,  3 Aug 2018 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533306240;
        bh=Qo6QBebh2dcnFsD0eKOmARpH88mH1NA0q5hMwfHP9r4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nbp86YCD1LNBUKCtL8zEsqWUit9FA/9fMLZzRh3R6j7iAfWd8KqUHOtsdiMc/xsnS
         O4G72hAJw/usU84ur41wXXNQwAp4YKuaUGqErpU0sTRgLXaEHi2RpLjVwMwri5/Cdp
         Fwq1Py+N8QZHGR/5FV2HZjMT6LBIKdxffW4inqfA=
Message-ID: <1533306238.4140.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Udit Agarwal <udit.agarwal@nxp.com>
Cc:     zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        denkenz@gmail.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Date:   Fri, 03 Aug 2018 07:23:58 -0700
In-Reply-To: <1533297482.4337.373.camel@linux.ibm.com>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
         <1533297482.4337.373.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 07:58 -0400, Mimi Zohar wrote:
> On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> > Udit Agarwal <udit.agarwal@nxp.com> wrote:
> > 
> > > +==========
> > > +Secure Key
> > > +==========
> > > +
> > > +Secure key is the new type added to kernel key ring service.
> > > +Secure key is a symmetric type key of minimum length 32 bytes
> > > +and with maximum possible length to be 128 bytes. It is produced
> > > +in kernel using the CAAM crypto engine. Userspace can only see
> > > +the blob for the corresponding key. All the blobs are displayed
> > > +or loaded in hex ascii.
> > 
> > To echo Mimi, this sounds suspiciously like it should have a
> > generic interface, not one that's specifically tied to one piece of
> > hardware - particularly if it's named with generic "secure".
> > 
> > Can you convert this into a "symmetric" type and make the backend
> > pluggable?
> 
> TPM 1.2 didn't support symmetric keys.  For this reason, the TPM
> "unseals" the random number, used as a symmetric key, and returns the
> "unsealed" data to the kernel.
> 
> Does anyone know if CAAM or TPM 2.0 have support for symmetric keys?

It depends what you mean by "support".  The answer is technically yes,
it's the TPM2_EncryptDecrypt primitive.  However, the practical answer
is that symmetric keys are mostly used for bulk operations and the TPM
and its bus are way too slow to support that, so the only real,
practical use case is to have the TPM govern the release conditions for
symmetric keys which are later used by a fast bulk encryptor/decryptor
based in software.

>  If they have symmetric key support, there would be no need for the
> symmetric key ever to leave the device in the clear.  The device
> would unseal/decrypt data, such as an encrypted key.
> 
> The "symmetric" key type would be a generic interface for different
> devices.

It's possible, but it would only work for a non-bulk use case; do we
have one of those?

James

