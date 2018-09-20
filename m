Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E683421523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E683421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeITNIY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:08:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45616 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeITNIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:08:24 -0400
Received: from marcel-macbook.fritz.box (p4FF9F8A9.dip0.t-ipconnect.de [79.249.248.169])
        by mail.holtmann.org (Postfix) with ESMTPSA id 555E3CF27B;
        Thu, 20 Sep 2018 09:33:33 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20622.1537291117@warthog.procyon.org.uk>
Date:   Thu, 20 Sep 2018 09:26:18 +0200
Cc:     Denis Kenzior <denkenz@gmail.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <58F37819-78E2-45C8-8F04-4F21DDFB640E@holtmann.org>
References: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
 <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
 <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
 <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
 <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <1537253993.20009.62.camel@infradead.org>
 <14067.1537285833@warthog.procyon.org.uk>
 <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
 <19247.1537288419@warthog.procyon.org.uk>
 <23698.1537289705@warthog.procyon.org.uk>
 <20622.1537291117@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

>>> Yes.  It shouldn't be much code, either.  You still have to check for X.509
>>> DER since the kernel currently supports that.
>> 
>> For reasons of backward compatibility, correct?  The kernel also has
>> mscode.asn1 which we would need to support as well.  Since we can't break
>> compatibility then perhaps this doesn't buy us a whole lot in the end.
> 
> Don't worry about mscode - that's not an asymmetric key parser.  That's only
> ever used directly from verify_pefile_signature().
> 
> Currently, we have to retain support for DER-encoded X.509.
> 
> But there's no reason we can't have a PEM parser that decodes the PEM and
> selects X.509, PKCS#8 or TPM based on the ascii header in that.  PKCS#8 and
> TPM don't need to take DER directly.

since we have to support DER-encoded anyway, can we get the current patches merged (with fixes to the commit messages for the openssl examples if needed) and then work on PEM support inside the kernel. For me these seems to be two independent features. And in the current form the patches have been tested and used.

Or let me ask this differently, are there any objections to merging these patches with just DER support?

For example in ELL we have implemented the PEM to DER conversion before calling keyctl. This can be surely added to keyutils (if calling openssl is too much to ask) or even the kernel itself. However this doesn’t change the actual functionality of handling asymmetric key operations. And I would rather see that merged and established instead of worrying to much about the multitudes of possible encoding forms of keys.

Regards

Marcel

