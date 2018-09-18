Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B14ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95E20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE95E20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbeIRWHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbeIRWHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:07:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46ECE1B7B;
        Tue, 18 Sep 2018 16:33:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E699616BF8;
        Tue, 18 Sep 2018 16:33:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
References: <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org> <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <1537253993.20009.62.camel@infradead.org> <14067.1537285833@warthog.procyon.org.uk> <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     dhowells@redhat.com, Denis Kenzior <denkenz@gmail.com>,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19246.1537288419.1@warthog.procyon.org.uk>
Date:   Tue, 18 Sep 2018 17:33:39 +0100
Message-ID: <19247.1537288419@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 18 Sep 2018 16:33:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> You are passing the raw DER to the kernel in both cases, right?

I haven't put a PEM stripper and base64 decoder into the kernel, though we
certainly could do that.  We could even do the decode in-place in the same
buffer since the resulting data would be smaller than the original.

> And the kernel just happens to know that if it receives a bare OCTET-STRING
> it's supposed to treat it as a TPMv1.2 key?

It passes it to each parser in turn till one says it can parse it.  It's not
ideal, but it seems to work - so far.  Better would be to annotate it in some
way.  I have considered annotating the type field so that the payload doesn't
have to have it added:

	keyctl padd asymmetric.x509 "" @s </tmp/foo.x509
	keyctl padd asymmetric.pkcs#8 ...
	keyctl padd asymmetric.tpm ...

However, this doesn't work with "keyctl update" or "keyctl instantiate".

David
