Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F52C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1706520832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1706520832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeK2Ayp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:54:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:48616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbeK2Ayo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:54:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC183AF6F;
        Wed, 28 Nov 2018 13:52:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07243DAC7E; Wed, 28 Nov 2018 14:52:42 +0100 (CET)
Date:   Wed, 28 Nov 2018 14:52:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Yueyi Li <liyueyi@live.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        markus@oberhumer.com
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Message-ID: <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yueyi Li <liyueyi@live.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        markus@oberhumer.com
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Markus to to CC

On Wed, Nov 28, 2018 at 07:31:26AM +0000, Yueyi Li wrote:
> It`s possible ip overrun in lzo1x_1_do_compress() when compressed page is
> point to the end of memory and which virtual address is 0xfffffffffffff000.
> Leading to a NULL pointer access during the get_unaligned_le32(ip).

So this could happen in practice in zram, but unlikely for other users
of lzo (like btrfs). I'm not sure but expect that the last page would
not be returned by allocator.

The fix is adding a few branches to code that's supposed to be as fast
as possible. The branches would be evaluated all the time while
protecting against one signle bad page address. This does not look like
a good performance tradeoff.

> +#define OVERFLOW_ADD_CHECK(a, b)  \
> +		(((a) + (b)) < (a))

I'm not sure if this is generally safe overflow check (never not
optimized out). Here it depends on the types of 'a' and 'b' that are
pointer (ip) and size_t (m_len). GCC has __builtin_add_overflow_p so
that one should be used where possible.
