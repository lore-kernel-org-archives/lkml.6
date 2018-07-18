Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E05ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBDE20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBDE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbeGRWWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:22:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeGRWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:22:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54A37C50;
        Wed, 18 Jul 2018 21:42:24 +0000 (UTC)
Date:   Wed, 18 Jul 2018 14:42:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: Only encode UTF-8 quoted printable mail
 headers
Message-Id: <20180718144222.fc567d972447348b419edcd9@linux-foundation.org>
In-Reply-To: <20180718145254.4770-1-geert+renesas@glider.be>
References: <20180718145254.4770-1-geert+renesas@glider.be>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 16:52:54 +0200 Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> As PERL uses its own internal character encoding, always calling
> encode("utf8", ...) on the author name may cause corruption, leading to
> an author signoff mismatch.
> 
> This happens in the following cases:
>   - If a patch is in ISO-8859, and contains a non-ASCII author name in
>     the From: line, it is converted to UTF-8, while the Signed-off-by
>     line will still be in ISO-8859.
>   - If a patch is in UTF-8, and contains a non-ASCII author name in the
>     body (not header) From: line, it is assumed to be encoded in PERL's
>     internal character encoding, and converted to UTF-8 incorrectly,
>     while the Signed-off-by line will be in real UTF-8.
> 
> Fix this by only doing the encode step if the From: line used UTF-8
> quoted printable encoding.

Works for me, thanks.


Relatedly, would it be worth adding a checkpatch warning if a patch
contains anything other than ASCII or UTF-8?

I added this to my little local patch-checking script.

	if ! file $p | grep -q -P "ASCII text|Unicode text"
	then
		echo $p: weird charset
	fi

