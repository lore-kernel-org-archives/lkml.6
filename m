Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20747C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25F320842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550740345;
	bh=s/954L2aQeWhqqTy/ASpFoNRHbw6AkggxUV6DEIKRhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BcOmV/g0Wn3/Zs0aZgFu2CRnZquVzYrgXNiQslMzX9uPZwJPAaYkV8+06kYYlsqoI
	 l3zBoBi2VudCTvczSdjAtf8L21q3YCcL3uDbxoTSnYk1q97LUuJv0AjemtkZ5xuHLZ
	 zB/sonbjLGU4oB8C1Ilwe7EIK86HC04bP48hIQb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBUJMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfBUJMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:12:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12C220842;
        Thu, 21 Feb 2019 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550740341;
        bh=s/954L2aQeWhqqTy/ASpFoNRHbw6AkggxUV6DEIKRhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgDrPMDKQ4f7yJvJYqmNavcwtV2JJ+4LeVPiNUeH0d55tNI5bWUwzEHOS1iwGbtrz
         uAPFpXTk3M8rlHSBaH28Vh+2tnkDWBDqLuZtvvp8fw+L6Tc6+B40l1/5kMAZPqDfFl
         tqSbyYPVt0Ja+m0FYpdMTY0JsnP1xr/incAWYN2A=
Date:   Thu, 21 Feb 2019 10:12:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [driver core] 570d020012: will-it-scale.per_thread_ops
 -12.2% regression
Message-ID: <20190221091217.GA18701@kroah.com>
References: <20190218075442.GI29177@shao2-debian>
 <20190219005945.GA16734@richard>
 <20190219121904.GA24103@kroah.com>
 <20190221031049.GE28258@shao2-debian>
 <20190221071023.GA28637@kroah.com>
 <8736oh1uf5.fsf@yhuang-dev.intel.com>
 <20190221073510.GA17369@kroah.com>
 <87va1dzgpj.fsf@yhuang-dev.intel.com>
 <20190221083926.GA7834@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221083926.GA7834@richard>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:39:27PM +0800, Wei Yang wrote:
> >>> I don't think this is an issues of struct device.  As you said, struct
> >>> device isn't access much during test.  Struct device may share slab page
> >>> with some other data structures (signal related, or fd related (as in
> >>> some other test cases)), so that the alignment of these data structures
> >>> are affected, so caused the performance regression.
> >>
> >> But allocation of a structure should always be "properly" aligned, no
> >> matter what something else did in the system as that is what kmalloc
> >> ensures.  If not, then we have problems in our memory allocator :)
> >>
> >> So something is odd here, but I don't think that is it...
> >
> >If all these data structure are allocated with kmalloc() instead of
> >kmem_cache_alloc(), then my guessing above seems incorrect ...
> >
> 
> Seems we don't have special kmem_cache for device and device_private.

Nor do we need one :)

Remember, 'struct device' is included inside lots of other structures
already, it is not very often created "on its own."

thanks,

greg k-h
