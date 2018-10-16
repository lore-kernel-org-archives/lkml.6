Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B0E20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B0E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJQECt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:02:49 -0400
Received: from mail.gnudd.com ([77.43.112.34]:50937 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbeJQECt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:02:49 -0400
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id w9GKASJh003265;
        Tue, 16 Oct 2018 22:10:28 +0200
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id w9GKASVS003264;
        Tue, 16 Oct 2018 22:10:28 +0200
Date:   Tue, 16 Oct 2018 22:10:28 +0200
From:   Alessandro Rubini <rubini@gnudd.com>
To:     u.kleine-koenig@pengutronix.de
Cc:     viro@ZenIV.linux.org.uk, Michal.Vokac@ysoft.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, kernel@pengutronix.de,
        akpm@linux-foundation.org
Subject: Re: [PATCH RFC] err.h: document that PTR_ERR should only be used if
 IS_ERR returns true
Message-ID: <20181016201028.GA3257@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <20181016192928.pinjwxfors4reigh@pengutronix.de>
References: <20181016192928.pinjwxfors4reigh@pengutronix.de>
  <20181014202807.16412-1-uwe@kleine-koenig.org>
  <20181015093708.GA22876@mail.gnudd.com>
  <20181016180650.GZ32577@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Me:
>> > OTOH I admit you can compare any value with -EINVAL, after PTR_ERR.
>> > But in general you first detect the error condition and then split
>> > among error (or print a message according to the exact value.

Al Viro:
>> 
>> 	if (IS_ERR(p) && PTR_ERR(p) == -ENOENT)
>> instead of
>> 	if (p == ERR_PTR(-ENOENT))
>> 
>> is ugly, obfuscating what's going on for no good reason and I'm going
>> to keep killing those every time I run into one...

Sure. I was talking about selecting among errors in the error path,
after you left the fast path jumping away with IS_ERR().

(in short, I agree).

Uwe kleine-koenig

> And what do you do if you see a
> 
> 	p = somefunc(...);
> 	if (PTR_ERR(p) == -ENOENT)
> 
> without first checking for IS_ERR(p)?

I see no problem. The original suggestion (only use if IS_ERR), which
was mine, refers to doing error management in error cases. Sure
if you know the return value is valid or -ENOENT you don't need to verify
it is negative before comparing with -2.

Both PTR_ERR and ERR_PTR are just a cast to prevent a warning
(and tell the reader that you convert from err to ptr or vv), so
I think the two are equivalent. Al's version above is maybe cleaner,
but we are bikeshedding, IMHO.

best
/alessandro
