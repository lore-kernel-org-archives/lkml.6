Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C3EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5844F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5844F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeGYBmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:42:12 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:53692 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388441AbeGYBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:42:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6F69818013216;
        Wed, 25 Jul 2018 00:33:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feast04_72d69ace06534
X-Filterd-Recvd-Size: 1813
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 25 Jul 2018 00:33:09 +0000 (UTC)
Message-ID: <612de3c34f4986ac3ee6040af200a0e179acdcbd.camel@perches.com>
Subject: Re: Reminder to review a few patches sent two weeks ago
From:   Joe Perches <joe@perches.com>
To:     pheragu@codeaurora.org, Apw <apw@canonical.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Bryanh <bryanh@codeaurora.org>, Ckadabi <ckadabi@codeaurora.org>,
        Tsoni <tsoni@codeaurora.org>
Date:   Tue, 24 Jul 2018 17:33:07 -0700
In-Reply-To: <e531d3a7a9db2e8d06da01cab2ad090d@codeaurora.org>
References: <e531d3a7a9db2e8d06da01cab2ad090d@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 14:56 -0700, pheragu@codeaurora.org wrote:
> A reminder to review a few patches I had sent last week. Below are the 
> links for the patches.
> 
> https://lkml.org/lkml/2018/7/5/798

I have no fundamental object to this one, but
the 80 column use is unnecessary and should be
coalesced before it can be applied.

Perhaps:

# warn about #if 1
		if ($line =~ /^.\s*\#\s*if\s+1\b/) {
			WARN("IF_1",
			     "Consider removing the #if 1 and its #endif\n" .  $herecurr);
 		}
 
> http://lists-archives.com/linux-kernel/29168320-checkpatch-check-for-invalid-return-codes.html

This one has I think too many existing uses of
things like "return -1;"

$ git grep -P "return\s*\-\d+\s*;" | wc -l
9929

How many of these are actually appropriate?

Also, no space is required between return and -1
by c90 and this should use $Int so it should be:

	if ($line =~ /\breturn\s*\-\$Int\s*;/) {

etc...

