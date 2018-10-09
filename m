Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC1C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D7F21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpY2qqZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D7F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJIQhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeJIQhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:37:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2622086D;
        Tue,  9 Oct 2018 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539076916;
        bh=VqRSdKTKFLxKhUYwXkkFVCyax7maRNAnqffuJxRpsVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpY2qqZ2cFq9qhvRNgXHTi1EoUPHglCY13ktKebYbaS+mWUMZNbWY27rV+aPc237n
         o1m1JLeknMKNHN5y91fr1e7hpfrN9lgLkBVuFHeTfnCy5B9WRG7SCpC83pLsrOD9aK
         JBTb4ggW6lCkbXm0VN4QQkJVc+uRcw2dBhVxrdqc=
Date:   Tue, 9 Oct 2018 11:21:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andre Tomt <andre@tomt.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/168] 4.18.13-stable review
Message-ID: <20181009092154.GC19241@kroah.com>
References: <20181008175620.043587728@linuxfoundation.org>
 <966cae81-c3f6-1d38-5721-97dc317a3fde@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <966cae81-c3f6-1d38-5721-97dc317a3fde@tomt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 05:21:31AM +0200, Andre Tomt wrote:
> On 08. okt. 2018 20:29, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.13 release.
> > There are 168 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
>   CC [M]  net/ipv4/netfilter/nf_conntrack_proto_icmp.o
> net/ipv4/netfilter/nf_conntrack_proto_icmp.c:373:3: error: ‘const struct
> nf_conntrack_l4proto’ has no member named ‘ctnl_timeout’; did you mean
> ‘get_timeouts’?
>   .ctnl_timeout  = {
>    ^~~~~~~~~~~~
>    get_timeouts
> 
> The problematic patch is:> netfilter-conntrack-timeout-interface-depend-on-config_nf_conntrack_timeout.patch
> 
> The stuff the commit message talks about seems like it was added in
> 4.19-rc1, so this should not go into stable.
> 
> Kernel builds fine with this one patch reverted.

So you have CONFIG_NF_CT_NETLINK_TIMEOUT enabled but not
CONFIG_NF_NETLINK_TIMEOUT?  Looks like we just need to modify the .h
file to fix this up properly, right?

This isn't showing up in my build tests as that configuration seems a
bit odd to me.

thanks,

greg k-h
