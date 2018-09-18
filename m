Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9DBECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543AD214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543AD214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeIRUfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:35:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbeIRUfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:35:12 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7292A3001C5D;
        Tue, 18 Sep 2018 15:02:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC0487502;
        Tue, 18 Sep 2018 15:02:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1537253993.20009.62.camel@infradead.org>
References: <1537253993.20009.62.camel@infradead.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     dhowells@redhat.com, jmorris@namei.org, denkenz@gmail.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20341.1537282931.1@warthog.procyon.org.uk>
Date:   Tue, 18 Sep 2018 16:02:11 +0100
Message-ID: <20342.1537282931@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 18 Sep 2018 15:02:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> Those examples aren't equivalent

No one said that they are.

But if you really can't figure it out, I can add:

	openssl genrsa -out private_key.pem 2048

at the front of the PKCS#8 example;-)

I can even change the examples to have the same private key name.

> For the PKCS#8 blob you are first using openssl to convert from an encrypted
> PKCS#8 PEM to unencrypted DER, presumably because you haven't added
> decryption support (or base64 decode) to keyctl yet.

It would probably be done in the kernel rather than keyctl.  If it's done in
userspace, there's no need to do it in keyctl.  The PKCS#8 parser is primarily
a test port - especially as it doesn't need anything like a TPM.

It's of limited real utility, I think, because even if the blob is encrypted
and you can pass the decryption password to the kernel, the password still has
to be present in userspace, however briefly.

> For the TPM example though, you are also showing the *generation* of
> the key, and importing it into the TPM. And then I'm confused by the
> 'openssl asn1parse' line there... what is that actually doing?

It's meant to be stripping off the PEM wrapper and outputting the DER, but see
below.

> If I run it on a '-----BEGIN TSS KEY BLOB-----' file I have lying around, I
> get no output at all.

I lost a bit from the cover note.  It needs "-out -" attaching.

	openssl asn1parse -inform pem -in modulekey1.priv -noout -out - | wc -c

David
