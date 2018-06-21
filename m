Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496EAC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEDC20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEDC20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeFUOsq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:48:46 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:55731 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932514AbeFUOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:48:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CA489180F737D;
        Thu, 21 Jun 2018 14:48:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rule72_4baf34171461e
X-Filterd-Recvd-Size: 2495
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Jun 2018 14:48:39 +0000 (UTC)
Message-ID: <8f9c37fd13abe2596521afb5d2779f644c214a93.camel@perches.com>
Subject: Re: [PATCH v2 2/2] hwmon: npcm750: add NPCM7xx PWM and Fan driver
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomer Maimon <tmaimon77@gmail.com>,
        cocci <cocci@systeme.lip6.fr>, robh+dt@kernel.org,
        mark.rutland@arm.com, jdelvare@suse.com, avifishman70@gmail.com,
        yuenn@google.com, brendanhiggins@google.com, venture@google.com,
        joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Thu, 21 Jun 2018 07:48:38 -0700
In-Reply-To: <alpine.DEB.2.20.1806211515060.3774@hadrien>
References: <20180619105352.97181-1-tmaimon77@gmail.com>
         <20180619105352.97181-3-tmaimon77@gmail.com>
         <20180620164853.GA3459@roeck-us.net>
         <a6a5a21236c37cfc63329e54248d941bf6d49e3c.camel@perches.com>
         <alpine.DEB.2.20.1806211515060.3774@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-21 at 15:17 +0200, Julia Lawall wrote:
> On Wed, 20 Jun 2018, Joe Perches wrote:
> > Also, spatch (1.0.4) seems to have a defect for this
> > when the type is used in operations that change a
> > smaller type to int or unsigned int.
> > 
> > i.e.: (offset is u16, but offset * 2 is int)
> 
> Ah.  The rule is that the result type is always the larger one?

Yes, but not quite, no.

The c90 rules are called "integer promotions" and are
detailed in section 6.3 Conversions

Basically, if any type is smaller than int, all operations
are done as int if possible, or unsigned int if necessary.
If any type is larger than int, then the larger type is used.

If you don't have the c90 standard, this one is close enough.
http://c0x.coding-guidelines.com/6.3.html
(use the next button several times to read the whole section)

Also, section 6.5 details "expressions" where the operands 
of things like bit operations use integer promotions.

> Unfortunately, Coccinelle doesn't know the size of any type.  I could add
> some special cases, but that may be more confusing than helpful.

Maybe, but when I saw the suggested removal, I was surprised.
