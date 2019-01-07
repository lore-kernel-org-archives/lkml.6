Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F44C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE7120881
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="T/iycMYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfAGIbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:31:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:29065 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1546849903;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=56myjuoaa8StoNqKDk3T2POnWWYj2+YoHYFnvAqrzdw=;
        b=T/iycMYOB+79CoefhzKzE0S5xe9bMqh8wRJ0a00o0tosL04ACyrJ080wfTJRuLXn5X
        oydpes0nR4mdXLLpVUYMO6lGy2eemoX9DL2niMmUe4RKDKQl3vk4HoWnfn/Pns6yIdxx
        D0knue8CeiS/Nm7aiGH/Ikjnh6DbY455DziKf1yn6ac1YP+3daNzhNE2komv/fHGnUDG
        om657FN1rZOejn6znKbRcPReIYWL+I4jMJhnaAtltL7kN0e5JMN8TEMOQE09go9JmK7T
        RcCZH5Asx1OZh6hr9ji14Hqm6iYFtcdz2sZOTOO6QMkDHx94O2yV11DB0H/daOTRdi7a
        w2Tg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJ/SfQIux"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv078VfBD9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Jan 2019 09:31:41 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] crypto: Add EC-RDSA algorithm
Date:   Mon, 07 Jan 2019 09:31:40 +0100
Message-ID: <1714084.mfT8VG1pOj@tauon.chronox.de>
In-Reply-To: <20190107080710.r4bh7gkqdysxmlnn@sole.flsd.net>
References: <20190106133608.820-1-vt@altlinux.org> <1893001.R2IGJoHzOM@positron.chronox.de> <20190107080710.r4bh7gkqdysxmlnn@sole.flsd.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 7. Januar 2019, 09:07:10 CET schrieb Vitaly Chikunov:

Hi Vitaly,

> > Why do you manually parse the ASN.1 structure instead of using the ASN.1
> > parser?
> 
> I am not sure this worth effort and will not be most degenerate use of
> asn1_ber_decoder, since 1) I only need to parse one type in each case:
> OCTET STRING string above code, and OIDs in below code; 2) this data is
> said to be in DER format, which asn1_ber_decoder can not enforce. Surely
> this will also produce more code and files.

RSA public keys also only contain n and e in the ASN.1 structure for which the 
ASN.1 parser is used (see linux/crypto/rsapubkey.asn1). As ASN.1 parsing is 
always having security issues, I would rather suggest to have this parsing 
implemented in one spot and not here and there.

Regarding your comment (2), I am not sure I understand. Why do you say that 
the DER format cannot be parsed by the kernel's ASN.1 parser? For example, 
when you generate RSA keys in DER format with, say, openssl, the kernel ASN.1 
parser will happily use them. Also, when I created my (not accepted) patch to 
load PQG domain parameters for DH using the ASN.1 parser, the PQG domain 
parameters created by openssl in DER format were processed well.

Ciao
Stephan


