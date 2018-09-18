Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E494CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D79F21526
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D79F21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeIRWwN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:52:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbeIRWwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:52:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7E34308ED56;
        Tue, 18 Sep 2018 17:18:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72F995C6C1;
        Tue, 18 Sep 2018 17:18:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
References: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com> <14f91823-474e-1b46-d305-12229dac8967@gmail.com> <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org> <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <1537253993.20009.62.camel@infradead.org> <14067.1537285833@warthog.procyon.org.uk> <745318a0-51bd-be8f-2251-44701ad75830@gmail.com> <19247.1537288419@warthog.procyon.org.uk> <23698.1537289705@warthog.procyon.org.uk>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20621.1537291117.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 18 Sep 2018 18:18:37 +0100
Message-ID: <20622.1537291117@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 18 Sep 2018 17:18:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

> > Yes.  It shouldn't be much code, either.  You still have to check for X.509
> > DER since the kernel currently supports that.
> 
> For reasons of backward compatibility, correct?  The kernel also has
> mscode.asn1 which we would need to support as well.  Since we can't break
> compatibility then perhaps this doesn't buy us a whole lot in the end.

Don't worry about mscode - that's not an asymmetric key parser.  That's only
ever used directly from verify_pefile_signature().

Currently, we have to retain support for DER-encoded X.509.

But there's no reason we can't have a PEM parser that decodes the PEM and
selects X.509, PKCS#8 or TPM based on the ascii header in that.  PKCS#8 and
TPM don't need to take DER directly.

David

