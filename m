Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1CFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087C6218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cs1ROxeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfBEX3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:29:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfBEX3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I0VnCRP5jiFduQj8D/MbOP8ep/SRYuZGku4WskzpxtU=; b=Cs1ROxeHj8syb2GDBPqv2AqBm
        vdYd8KDnYJz4OG56cfEVrS0VyITza77z/M1M+zZvB1u1WEKK4mVXlkN0R+XjJ464gAc7GvkKrBy3X
        7ZVWo3o2nZo7TjDe3F8suUnOA++rjceXEZvAeFnlkmUJHea61fRaDb565cFxQzSoVO0o+FAViHAkk
        9RSHaEGpqJAMtNG13hmqmja6KPnpZhzKgyM0JE3KdS7BB11ASZ8VScDYkrJep04hN5NEvcnAg1MYu
        jxj74FaU3Xw4A9Bj5S2spfP8icKMbKtYyT7zZEhZw00+DOBJDk21Fiwd1gGXQm7oTvRwUwM0wQZFz
        nqP7DhgGg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grA9o-0002Yd-22; Tue, 05 Feb 2019 23:29:36 +0000
Date:   Tue, 5 Feb 2019 15:29:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v10 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
Message-ID: <20190205232935.GL21860@bombadil.infradead.org>
References: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190205140415.544ae2876ee44e6edb8ca743@linux-foundation.org>
 <CAGXu5jJJQq358_H=xAcf=17WixnFx-P6HqTuv8uQn2zGgNg3Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJJQq358_H=xAcf=17WixnFx-P6HqTuv8uQn2zGgNg3Fw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:11:06PM +0000, Kees Cook wrote:
> FWIW, distros have enabled it by default for a while. Here's Ubuntu,
> for example:
> 
> and Fedora too:

Also Debian:

$ grep SLAB_FREELIST /boot/config-4.19.0-1-amd64
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y

linux (4.15.4-1) unstable; urgency=medium
  * Switch to SLUB as kernel allocator. (Closes: #862718)
    - Enable SLUB_DEBUG, SLAB_FREELIST_HARDENED except on armel/marvell.
      (Closes: #883069)

