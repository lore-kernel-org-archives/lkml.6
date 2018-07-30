Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2765320890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbRM9oAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2765320890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeG3WNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:13:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3WNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tAcxpn5KO/TPt4Lj3Gy0D0mpZA17y+oPGe8nKuXKG4s=; b=fbRM9oAcjH6pK55CplJV+4mb5
        cV37V6NbGPBjUOVJ8Hr4MVMiQwE9DJ3qGSXTLVowkwom2ecH4CnM2ro1c/sHzEdnXb/lIGoUsHz21
        mYehJw0g5M4lWf2IGXX2u4VSg8d3vdFfFRiXKxcsP4tBpf+vOMnwqrdbXLpm8ae7948FktXmcFLGz
        VnpQs+yjCjiBXwGr7a7tk+ECd/HiLx8fd8wGEUA2JV0QhVpyHivKtUKESaRA4RzNmaqkwidZ7pcXz
        3kWRScgbnQPvVaJupqS1oluDRWRvmPcLWMW1frm8Vl5N/NFm4j5/FD1CVIXKnnqf8Sn7cT/IRJ4Ol
        11N4ixnNw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkEu9-0003F0-98; Mon, 30 Jul 2018 20:36:33 +0000
Date:   Mon, 30 Jul 2018 13:36:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <christian@brauner.io>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk
Subject: Re: [PATCH 1/4] file: export __alloc_fd()
Message-ID: <20180730203633.GC12962@bombadil.infradead.org>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730143710.14413-2-christian@brauner.io>
 <20180730163155.GA27761@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730163155.GA27761@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:31:55AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 30, 2018 at 04:37:07PM +0200, Christian Brauner wrote:
> > The Android binder driver will be turned into a module. Since it uses
> > __alloc_fd() we need to export this function.
> 
> Err, hell no.
> 
> It should be using an anon fd probably.

I'm not entirely sure I understand the binder code (... does anyone?)
but from what I can see, it intends to open a file descriptor in the
process which is the target of the message being sent.  That strikes
me as wrong-headed; it should be allocating a struct file and passing
that file to the other process.  When that process receives the message,
*it* allocates a file descriptor for itself.

But I think the binder user-space API relies on this.  The userspace API
seems to rely on passing fd numbers around ... but I'm having trouble
figuring most of this user API out.  Perhaps Martijn can help here.
