Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E88C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D77218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549015636;
	bh=E8m3uBy/hQdjHgLbF0UoPtgezVaW3/RKd3HyFWS9Ilg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pn/AHuGQe2sJ3Gr0aJLj/FqCjiSwTP49TDX0QZwZYe4pZyHl0KVcdk+spTzyHQFK+
	 wDzt6LtInQWU9IUBx0Qc49QjQ0d9VNUMGQNdYC2hctoqgcRAPTfHE6rJpjWd0dZCtQ
	 4Ijsc0NTWTkgcZ0j+TWBjEPO+VzH0dFMTliQSky0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfBAKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfBAKHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:07:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C11021872;
        Fri,  1 Feb 2019 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549015634;
        bh=E8m3uBy/hQdjHgLbF0UoPtgezVaW3/RKd3HyFWS9Ilg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsW845G/Qjbcvm4VhZOnlZf2W6GYIT8fJa2DxZlOLu3ssgqyhxHpfifq71RS+ZWhi
         lZQEcHlfT4bv8lWGwu2PbPS1Dfs2EHVQQon+8JrG21sCbkjaRv0PL48sLmBmTPxsfe
         75XYkfgWW6vXjI0rzAXiITH3P18QM91qKTLfozig=
Date:   Fri, 1 Feb 2019 11:07:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kenneth Lee <liguozhu@hisilicon.com>
Cc:     Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai, jglisse@redhat.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>, airlied@redhat.com,
        linux-accelerators@lists.ozlabs.org, nek.in.cn@gmail.com
Subject: Re: [PATCH/RFC 0/5] HW accel subsystem
Message-ID: <20190201100711.GB17779@kroah.com>
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
 <20190201091040.GA159470@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201091040.GA159470@Turing-Arch-b>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 05:10:40PM +0800, Kenneth Lee wrote:
> After the RFCv2 was sent to the lkml, we do not get much feedback. But the
> Infini-band guys said they did not like it. They think the solution is
> re-invention of ib-verbs.

No one needs to re-invent a monstrosity that is ib-verbs.  If anything,
that is a model that should never be recreated again, showing that we
can learn from past mistakes :)

> But we do not think so. ib-verbs maintains semantics of "REMOTE memory". But
> UACCE maintains semantics of "LOCAL memory". We don't need to send, or sync
> memory with other parties. We share those memory with all processes who share
> the local bus.

I agree, don't try to duplicate the mess that people moved away from
(hint, everyone sane wraps ib-verbs in another model that can actually
be used and understood...)

> But we know we need more "complete" solution to let people understand and accept
> our idea. So now we are working on it with our Compression and RSA accelerator
> on Hi1620 Server SoC. We are also planning to port our AI framework on it.
> 
> Do you think we can cooperate to create an framework in Linux together? Please
> feel free to ask for more information. We are happy to answer it.

Sure, that sounds like a great goal!

thanks,

greg k-h
