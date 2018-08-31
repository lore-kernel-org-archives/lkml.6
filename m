Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB7EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B3E2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B3E2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIAAOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:14:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51939 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIAAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:14:36 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1fvpfa-0001L3-Dr; Fri, 31 Aug 2018 22:05:26 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1fvpfZ-0004tU-3o; Fri, 31 Aug 2018 22:05:25 +0200
Message-ID: <1535745923.25742.1.camel@pengutronix.de>
Subject: Re: [RFC PATCH 00/10] fs-verity: filesystem-level integrity
 protection
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Reply-To: jlu@pengutronix.de
To:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Date:   Fri, 31 Aug 2018 22:05:23 +0200
In-Reply-To: <20180824161642.1144-1-ebiggers@kernel.org>
References: <20180824161642.1144-1-ebiggers@kernel.org>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-24 at 09:16 -0700, Eric Biggers wrote:
[...]
> Since fs-verity provides the Merkle tree root hash in constant time and
> verifies data blocks on-demand, it is useful for efficiently verifying
> the authenticity of, or "appraising", large files of which only a small
> portion may be accessed -- such as Android application (APK) files.  It
> can also be useful in "audit" use cases where file hashes are logged.
> fs-verity also provides better protection against malicious disk
> firmware than an ahead-of-time hash, since fs-verity re-verifies data
> each time it's paged in.
[...]
> Feedback on the design and implementation is greatly appreciated.

Hi,

I've looked at the series and the slides linked form the recent lwn.net
article, but I'm not sure how fs-verity intends to protect against
malicious firmware (or offline modification). Similar to IMA/EVM, fs-
verity doesn't seem to include the name/location of the file into it's
verification. So the firmware/an attacker could replace one fs-verity-
protected file with another (maybe a trusted system APK with another
one for which a vulnerability was discovered, or /sbin/init with
/bin/sh).

Is the expected root hash of the file provided from somewhere else, so
this is not a problem on Android? Or is this problem out-of-scope for
fs-verity?

For IMA/EVM, there were patches by Dmitry to address this class of
attacks (they were not merged, though):
https://lwn.net/Articles/574221/

Thanks,
Jan

[1] https://events.linuxfoundation.org/wp-content/uploads/2017/11/fs-ve
rify_Mike-Halcrow_Eric-Biggers.pdf
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
