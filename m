Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64C92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64C92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeLJQ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:58:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbeLJQ6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:58:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4415280F7A;
        Mon, 10 Dec 2018 16:58:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33BE1608E6;
        Mon, 10 Dec 2018 16:58:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e55a9f80-d2ea-f28f-06ab-3d99786096c4@huawei.com>
References: <e55a9f80-d2ea-f28f-06ab-3d99786096c4@huawei.com> <20181112102423.30415-9-roberto.sassu@huawei.com> <20181112102423.30415-1-roberto.sassu@huawei.com> <19985.1542026635@warthog.procyon.org.uk>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Subject: Re: [RFC][PATCH 08/12] KEYS: PGP-based public key signature verification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17487.1544461088.1@warthog.procyon.org.uk>
Date:   Mon, 10 Dec 2018 16:58:08 +0000
Message-ID: <17488.1544461088@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 16:58:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Sassu <roberto.sassu@huawei.com> wrote:

> > You need to consider what it is that the patch trying to achieve.
> 
> I understood that the purpose is to check PGP signatures with built-in
> keys or keys provided by the user. Since using the session keyring
> caused the issue I reported, I thought it was ok to use the user
> keyring.
> 
> Just a note: the original patches were relying on KEY_FLAG_TRUSTED to
> determine if a key is trusted; now the trustworthiness depends on the
> type of keyring passed to pgp_verify_sig(). I removed the additional key
> search in the user (session) keyring to prevent that signature
> verification is done with a key provided by the user even when the
> caller of pgp_verify_sig() expects that a trusted key is used. The
> search in the session keyring is done if the caller of pgp_verify_sig()
> sets the keyring pointer to NULL.

Thinking about these patches further, as you point out, the way that trust is
computed has changed.  There is no no KEY_FLAG_TRUSTED; rather, a key is
assumed to be trusted if it's on a trusted keyring.

*Getting* it onto that trusted keyring is then the trick.  There are two ways:

 (1) A key can be loaded from a trusted source during boot (say a compiled in
     set of keys).

 (2) A key can be added to that keyring later, provided that the key is
     verified by a key already in the ring and the ring hasn't been closed.

What do we need to check PGP signatures?  Blobs or keys as well?

Why does the user keyring need to be a fallback?  (I know the session keyring
used to be a fallback when I first did these, but things have changed since
then).

Should we have a separate built-in keyring for PGP keys?  Actually, I suspect
we should probably mark keys in some way with what they're permitted to be
used for.

David
