Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7D1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E22220869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E22220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeJQDVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:21:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48859 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeJQDVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:21:32 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gCV21-0006MG-Vv; Tue, 16 Oct 2018 21:29:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gCV20-0002WU-EZ; Tue, 16 Oct 2018 21:29:28 +0200
Date:   Tue, 16 Oct 2018 21:29:28 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Alessandro Rubini <rubini@gnudd.com>, Michal.Vokac@ysoft.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        kernel@pengutronix.de, akpm@linux-foundation.org
Subject: Re: [PATCH RFC] err.h: document that PTR_ERR should only be used if
 IS_ERR returns true
Message-ID: <20181016192928.pinjwxfors4reigh@pengutronix.de>
References: <20181014202807.16412-1-uwe@kleine-koenig.org>
 <20181015093708.GA22876@mail.gnudd.com>
 <20181016180650.GZ32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016180650.GZ32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:06:51PM +0100, Al Viro wrote:
> On Mon, Oct 15, 2018 at 11:37:08AM +0200, Alessandro Rubini wrote:
> 
> > OTOH I admit you can compare any value with -EINVAL, after PTR_ERR.
> > But in general you first detect the error condition and then split
> > among error (or print a message according to the exact value.
> 
> 	if (IS_ERR(p) && PTR_ERR(p) == -ENOENT)
> instead of
> 	if (p == ERR_PTR(-ENOENT))
> 
> is ugly, obfuscating what's going on for no good reason and I'm going
> to keep killing those every time I run into one...

And what do you do if you see a

	p = somefunc(...);
	if (PTR_ERR(p) == -ENOENT)

without first checking for IS_ERR(p)? Another alternative is

	if (PTR_ERR_OR_ZERO(p) == -ENOENT)

? In your eyes, should they all be converted to

	if (p == ERR_PTR(-ENOENT))

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
