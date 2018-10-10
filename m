Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848182086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848182086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJKA5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:57:07 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:35411 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbeJKA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:57:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 39444100E86C2;
        Wed, 10 Oct 2018 17:33:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: door09_796789a7ce00d
X-Filterd-Recvd-Size: 1893
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Oct 2018 17:33:54 +0000 (UTC)
Message-ID: <40fd3d963820bf96547fa9b5e8c171c6a339674e.camel@perches.com>
Subject: Re: Question on FIELD_PREP() for static array
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, johannes@sipsolutions.net,
        jakub.kicinski@netronome.com, yamada.masahiro@socionext.com,
        Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Oct 2018 10:33:53 -0700
In-Reply-To: <c8594a75-964b-01b0-382e-88bcb5b462f2@huawei.com>
References: <c8594a75-964b-01b0-382e-88bcb5b462f2@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-10 at 18:16 +0100, John Garry wrote:
> (to: get_maintainers -f include/linux/bitfield.h)
> 
> Hi,
> 
> I would like to use FIELD_PREP() macro for assigning a static array, 
> like this:
> function()
> {
> 	static u32 val[2] = {FIELD_PREP(GENMASK_ULL(10, 0), 5), 0};
> 
> }
> 
> However the compiler complains of non-const expression:
> ./include/linux/bitfield.h:88:2: error: initializer element is not constant
>     ({        \
> 
> Specifically it doesn't like the __BF_FIELD_CHECK() in FIELD_PREP().
> 
> Any ideas on compiler trickery we could do with the FIELD_PREP() 
> definition to avoid this issue (i.e. enforce the check but only use the 
> constant value)?

Perhaps __bf_shf should not use __builtin_ffsll.

As mask is known constant, maybe expand the test
in-place with some switch/case.


