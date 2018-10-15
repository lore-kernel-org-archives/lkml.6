Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9794C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE8920652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE8920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOR2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:28:06 -0400
Received: from mail.gnudd.com ([77.43.112.34]:49773 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOR2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:28:05 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2018 13:28:05 EDT
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id w9F9b9mj022885;
        Mon, 15 Oct 2018 11:37:09 +0200
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id w9F9b8mG022883;
        Mon, 15 Oct 2018 11:37:08 +0200
Date:   Mon, 15 Oct 2018 11:37:08 +0200
From:   Alessandro Rubini <rubini@gnudd.com>
To:     uwe@kleine-koenig.org
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        Michal.Vokac@ysoft.com, akpm@linux-foundation.org,
        kernel@pengutronix.de
Subject: Re: [PATCH RFC] err.h: document that PTR_ERR should only be used if
 IS_ERR returns true
Message-ID: <20181015093708.GA22876@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <20181014202807.16412-1-uwe@kleine-koenig.org>
References: <20181014202807.16412-1-uwe@kleine-koenig.org> 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> during a review I claimed that PTR_ERR should only be used if IS_ERR was
> already checked. The rationale isn't obvious though and Thierry
> suggested to keep the code as is and not introduce an IS_ERR check.

The rationale is the same ch11 you linked to: "any other value
is a valid pointer".  It isn't usefult to convert to long sth that
your are not using as a long.  You should not pass it to strerror(-err)
for example.

OTOH I admit you can compare any value with -EINVAL, after PTR_ERR.
But in general you first detect the error condition and then split
among error (or print a message according to the exact value.

> maybe something like "On an Alpha it is important because
> not doing it results in a bus error there."

No, nothing that exotic.

You said:

> Thierry suggested to keep the code as is and not introduce an IS_ERR check.

I wonder where. Sure no extra check in the header, that would be
extra wasted time in every caller. If it's a specific caller place,
it may make sense to avoid the check, I don't know the details.

As for the specific patch you propose, I'm unsure it's useful.  Maybe
we should remember that "this returns the equivalent of "-errno" if
IS_ERR() is true", but I'm personally not much for overcommenting:
It's a simple cast and there are a zillion users to see how exactly
this works if anyone is uncertain.

Regards
/alessandro
