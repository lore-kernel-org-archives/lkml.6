Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E215BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90103208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWg55sEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90103208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbeFNN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:29:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755092AbeFNN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D3M0+L7De5Rde1cWkG3InPvn6WoDJpf7xOqvxEmkc2g=; b=HWg55sEP9sVRlKsKAiAlcfGTE
        a1GdHyCnfPcMqPyHyPQb0lsCP7X6k1IYTZ2Y2HxzNnw2nJjWX34B+ecPwJooQHdQyYy5v420Wx4Q/
        U4w145BWbwQhk1sqzmn32TLQRsvW4t0gGHd4oiiWp+na0ImN8nXt3R8Yf1Uv43CRbd52cC2pAa3fz
        mpMyQSiRPRo499UOi3PpCgadKBGWUG/88GdpBRz1/UThuwpZUUCqgtYbwrpiNbY0YUTE17hAJFVS4
        3v5pY8vu44u0c/p8d0PLSkdmXX/eSXEgUn2P0TFw7fW35JMVVyMIwn2+iwrzMhunuSyd5zLolmU4o
        F5LaQo1rA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTSJF-00047h-Vg; Thu, 14 Jun 2018 13:29:05 +0000
Date:   Thu, 14 Jun 2018 06:29:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
Message-ID: <20180614132905.GA7841@bombadil.infradead.org>
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com>
 <20180614113604.GZ12198@hirez.programming.kicks-ass.net>
 <7eb10c22-57b3-1472-0a77-7f787f612217@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb10c22-57b3-1472-0a77-7f787f612217@vmware.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 01:54:15PM +0200, Thomas Hellstrom wrote:
> On 06/14/2018 01:36 PM, Peter Zijlstra wrote:
> > Currently you don't allow mixing WD and WW contexts (which is not
> > immediately obvious from the above code), and the above hard relies on
> > that. Are there sensible use cases for mixing them? IOW will your
> > current restriction stand without hassle?
> 
> Contexts _must_ agree on the algorithm used to resolve deadlocks. With
> Wait-Die, for example, older transactions will wait if a lock is held by a
> younger transaction and with Wound-Wait, younger transactions will wait if a
> lock is held by an older transaction so there is no way of mixing them.

Maybe the compiler should be enforcing that; ie make it a different type?
