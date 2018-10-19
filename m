Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D60ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7254A21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6V+vzHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7254A21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJSUGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:06:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeJSUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WpJ5D07eJ33zRkw9eHZ6OBLrJWSPkwsd/VPUtOLOtKQ=; b=b6V+vzHNTNNiuF+hlKCPvhVLn
        o7Ah1sVWOxXkyRz1AVA2lPrUGE9Wk40CrPoZBzpeVOMj5xnvVbgXyBM/15VWlBNtwBuOOcXHtNngB
        cfvkO3t5LAx06SaAKvn5+PZ1mmNJhrXenJ1as5HejN+ZIMhVbgyDUdNMRa+Z6m8EyZ4SSOt9lGhbp
        rylLy3fQsWVcC1qBRyaT68k4hPUDPy7lHaGvfbgBHvF3k5TCKq5l4dXk9Psc8rsUI27uqNgv/ohzz
        YFzXLxZPVtiB7WMkAua41Fndk5lgCXshzpMPwKtfP3y5PWGjWyxGwS91XYxSBUS73l43qKHI7k1Or
        +NAHxUqKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDTSE-0006yc-6B; Fri, 19 Oct 2018 12:00:34 +0000
Date:   Fri, 19 Oct 2018 05:00:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, Shaohua Li <shli@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] dm: add secdel target
Message-ID: <20181019120033.GA7869@infradead.org>
References: <20181014112439.8119-1-vt@altlinux.org>
 <20181019061945.GA7403@infradead.org>
 <20181019114944.syemvziebwfuruof@sole.flsd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019114944.syemvziebwfuruof@sole.flsd.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:49:44PM +0300, Vitaly Chikunov wrote:
> On Thu, Oct 18, 2018 at 11:19:45PM -0700, Christoph Hellwig wrote:
> > Just as a note:  the name is a complete misowner, a couple overwrite
> > are not in any way secure deletion.  So naming it this way and exposing
> > this as erase is a problem that is going to get back to bite us.
> 
> In what way it's not secure deletion?
> 
> It's secure deletion by overwriting discarded data instead of leaving it
> as is.

Overwriting data does not delete data.  Most certainly not in Flash based
SSDs, but also not in many storage arrays, or for that matter many modern
disks that have sectore remapping and various kinds of non-volatile
caches.  There is a reason why devices tend to have special commands to
perform secure erase - depending on the media they might or might not
overwrite internally, but at least they do it in a way that actually
works for the given media and device configuration.


> dm-erase or dm-wipe? dm-discerase?

dm-overwrite?

> But still provide REQ_OP_SECURE_ERASE
> support?

On the one hand that is highly misleading and would warrant a warning
(see above), on the other hand discard is purely advisory and can
be skipped any time, including by intermediate layers.  So I don't think
you can actually do what you want without major changes to the whole
I/O stack.
