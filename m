Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E986AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95D7214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWw1qKAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfBUJW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:22:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfBUJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A/k7bLzhrnBjgT6dL0l8NBEApWOmh2MHGEi3b1csrjk=; b=IWw1qKAgnJTCWENPiNp/vDeDJ
        SY1jC1nzMLG6/JvDuMG59++Is+z1Wkd97ua5O2zsOJC9dQBZYscyV6LOrHZre/3NrDUNFWGstgmXp
        txRzuVzh/uGAkwsEvnOCn+2VGtHzfsQq4WS9uKSwMnD8+LEoxmFTD36T/f68IquOpQR/HhtRewwzT
        Y1RHRwuGX9hm7j5k2BKbCTug1i4cEDlXuvyv58U/yBw9v5c9kZpQqOR+RRv9pl+WZfZ5AU+Xkzexn
        tKVYlxRdKMr+WgCC8GWrcuYAH4XbychIwlxxda/1IouQI99mfeuneuMydVQBmAzJf8clNrF1ybgus
        19h4sJm8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwkYY-0001pX-P0; Thu, 21 Feb 2019 09:22:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F53C2139CDFF; Thu, 21 Feb 2019 10:22:13 +0100 (CET)
Date:   Thu, 21 Feb 2019 10:22:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tao Xu <tao3.xu@intel.com>, jingqi.liu@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait instructions
Message-ID: <20190221092213.GA32477@hirez.programming.kicks-ass.net>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-6-git-send-email-fenghua.yu@intel.com>
 <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:37:27PM -0800, Andy Lutomirski wrote:
> On Wed, Feb 20, 2019 at 7:44 PM Tao Xu <tao3.xu@intel.com> wrote:

> > +static ssize_t umwait_enable_c0_2_show(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      char *buf)
> > +{
> > +       return sprintf(buf, "%d\n", umwait_enable_c0_2);
> 
> I realize that it's traditional to totally ignore races in sysfs and
> such, but it's a bad tradition.  Please either READ_ONCE it with a
> comment or take the mutex.

Note that when using READ_ONCE(), the other side must use WRITE_ONCE().
Mixed usage is not valid.
