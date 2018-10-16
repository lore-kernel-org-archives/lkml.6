Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDB9C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8712089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8712089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigma-star.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJPSGG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:06:06 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:54228 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbeJPSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:06:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 4ED27180230B6;
        Tue, 16 Oct 2018 12:16:20 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   David Gstir <david@sigma-star.at>
In-Reply-To: <1533320921.4337.479.camel@linux.ibm.com>
Date:   Tue, 16 Oct 2018 12:16:15 +0200
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Howells <dhowells@redhat.com>,
        Udit Agarwal <udit.agarwal@nxp.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, Horia Geanta <horia.geanta@nxp.com>,
        aymen.sghaier@nxp.com, Richard Weinberger <richard@sigma-star.at>
Content-Transfer-Encoding: 8BIT
Message-Id: <F6B8DD08-A54A-4792-AC36-BF0335B1750A@sigma-star.at>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
 <8060.1533226481@warthog.procyon.org.uk>
 <1533297482.4337.373.camel@linux.ibm.com>
 <1533306238.4140.1.camel@HansenPartnership.com>
 <1533307535.4337.415.camel@linux.ibm.com>
 <1533311338.4140.3.camel@HansenPartnership.com>
 <1533320921.4337.479.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On 03.08.2018, at 20:28, Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
>>>>> If they have symmetric key support, there would be no need for
>>>>> the
>>>>> symmetric key ever to leave the device in the clear. The device
>>>>> would unseal/decrypt data, such as an encrypted key.
>>>>> 
>>>>> The "symmetric" key type would be a generic interface for
>>>>> different
>>>>> devices.
>>>> 
>>>> It's possible, but it would only work for a non-bulk use case; do
>>>> we
>>>> have one of those?
>>> 
>>> "trusted" keys are currently being used to decrypt other keys (eg.
>>> encrypted, ecryptfs, ...).
>> 
>> Yes, but that's just double encryption: it serves no real security
>> purpose because at the end of the chain, the symmetric key is released
>> into kernel memory to use in software crypto.  Unless you're using a
>> high speed (and high cost) crypto accelerator with HSA, this will
>> always be the case for bulk crypto.
>> 
>> The other slight problem with this chain of crypto is that I can impose
>> conditions on the key release from the TPM (well TPM2, since TPM1.2 has
>> a very weak policy engine) but if we use intermediate steps, those
>> conditions might not be preserved, so I think the ideal would be a
>> trusted key being released directly to LUKS or ecryptfs because the TPM
>> can then verify the policy at actual unseal time.  I get that for the
>> ecryptfs case you might want one key per file for sharding and sharing,
>> and that's more like a bulk case because the TPM isn't going to keep up
>> with the number of unseal operations required.
> 
> Agreed.  Yet there are a couple of reasons for having this sort of
> indirection. By having the "encrypted" key encrypted/decrypted by a
> "trusted" key, the "trusted" key could be updated without impacting
> the "encrypted" key.  This could be used, for example, for key
> migration.  Another reason would be to define a single "trusted" key
> sealed to a set of PCRs, which could be used to encrypt/decrypt
> multiple symmetric keys.
> 
> Nothing is preventing these subsystems from directly using a "trusted"
> key.
> 
> This discussion is the result of Udit Agarwal's posting a "secure" key
> patch. Before defining a new key type, whether it is called "secure"
> or "symmetric", we need to understand how the this new key type is
> going to be used.  Will it have a similar ability to impose conditions
> on the key release as the TPM?  Will it have symmetric key support, so
> that the symmetric key never needs to be released from the HW?


I'm looking into mainline support for CAAM-protected keys. I currently have
hacky patches that duplicate trusted keys, and use CAAM instead of TPM to
seal/unseal keys and make them available to other kernel features like fscrypt.
This patch by Udit Agarwal looks like an interesting base for my code.
However, AFAICT there has been no progress for some time now. 

Is anybody still working on this? If not, I'm happy to help out! :)

Regarding the new key type:
In addition to unsealing a key/data into kernel memory, CAAM also supports
unsealing a symmetric key directly into a key register of CAAM's crypto
acceleration engine. This is something I'd like to have, but it will surely
require changes the the CAAM crypto driver as well. Jan Lübbe already mentioned
he is interested in this too: https://www.spinics.net/lists/keyrings/msg03919.html

AFAIK, CAAM does not have fine-grained key release restrictions like TPM.
IMHO such a new key type should provide a generic interface with backends for
CAAM, TPM and possibly others to seal/unseal arbitrary data. As for supporting
keys that only reside in the HW, I'm not yet sure what the best approach would be.
It should probably tie into the crypto API to be usable throughout the kernel...

Thanks!
David


