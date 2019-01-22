Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE25C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E477217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182421;
	bh=Lk+uqYnWhBwaSoLVBpwO7Y60vIJTXz/KDZiTm/v+KnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fKkyGemPMWjd0caef0SfC9NOg5Qhqlw0wn3Is2uJDRcLgKKuiQ7GD/R4mBc0X5hZp
	 xmOSmqYn1nOd08ixQro4OC7YCfpPxAacwsoE4aNyUqpXhdMXj2XMi9a8YeEYuv6QeV
	 0u6RHQvLnyz+O2bM1saHWgkmwZuCHYohLPhuSMJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfAVSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfAVSkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:40:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F5721726;
        Tue, 22 Jan 2019 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548182418;
        bh=Lk+uqYnWhBwaSoLVBpwO7Y60vIJTXz/KDZiTm/v+KnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fw1jNDBvThpgp2F6xryANs6X7NIgIAlF/Bj0Xyu1AEIj4vjp9A6HgFhG4q8aqj3Yi
         MQmUJ6eSFOSXktQcXVGHE2Z3q/f1q1E8QHZSdPBZaVUwA5ED9GWg2C3t6jfB6yUaja
         PqnO/Y5SyWE2YdO+cttOkcWA9EGSUdLF2kLacsIs=
Date:   Tue, 22 Jan 2019 19:40:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: no need to check return value of debugfs_create
 functions
Message-ID: <20190122184015.GC31777@kroah.com>
References: <20190122152151.16139-51-gregkh@linuxfoundation.org>
 <20190122172102.GE28513@linux.intel.com>
 <20190122172907.GF28513@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122172907.GF28513@linux.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:29:07AM -0800, Sean Christopherson wrote:
> On Tue, Jan 22, 2019 at 09:21:02AM -0800, Sean Christopherson wrote:
> > On Tue, Jan 22, 2019 at 04:21:50PM +0100, Greg Kroah-Hartman wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > 
> > What about wanting to make the debugfs all-or-nothing?  That seems like
> > a legitimate usage of checking the return value.
> > 
> > E.g. KVM removes the debugfs if kvm_arch_create_vcpu_debugfs() fails, and
> > the arch/x86/kvm/debugfs.c implementation of kvm_arch_create_vcpu_debugfs()
> > returns an error if any of its debugfs_create_file() calls fail.
> > 
> > If you're adamant about removing all debugfs create return value checks,
> > the aforementioned debugfs_create_file() calls should also be removed.
> > And at that point kvm_create_vcpu_debugfs() should have a 'void' return
> > value.
> 
> Belatedly saw the other series.  It'll require a bit more coordination,
> but folding this into the x86 series would allow for converting the KVM
> call stack to have 'void' returns.

Oh, nice, want me to tack this onto the end of there, or just do some
follow-on patches after this gets merged?

thanks,

greg k-h
