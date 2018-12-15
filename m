Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D41C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C972084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544861153;
	bh=AicgLW1FHGqztapxmyjA6qgzOD5LPy7WWlyvvqXXZRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R4HdfohFRkq3zjRRBdWMSLrl4qVsgr0pJsezZEsR0moUI+XkHb0fcAeKYXtPFimi0
	 S4a7JVya9737DTTr+k0rZCU015C0yRrx68lO1SlZdB+Ncwx9XnHrzNe4FMQ1JRrZgW
	 vgD/RWwMLbpj4eqjNOiEBE5osKcDKyC1VVO0bKdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbeLOIFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeLOIFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:05:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA182080F;
        Sat, 15 Dec 2018 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544861150;
        bh=AicgLW1FHGqztapxmyjA6qgzOD5LPy7WWlyvvqXXZRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+U/vesksyIFqJIyb/NsD0hQ2Xbiz7F2xm4yh3Nq6eeYUoSlEZS5boMzM8/F3RGkl
         dRLREnvMZijZ6vWNspNevItM9C53rCbpZZgS70RTfjKd/3OL86XwG5eeFtv6lMhgmN
         wtyLIgaczijbA/wOJojRdzCqUn+CYAxV4QNuz/K8=
Date:   Sat, 15 Dec 2018 09:05:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas =?iso-8859-1?Q?Sch=F6bel-Theuer?= 
        <thomas@schoebel-theuer.de>,
        Thomas Schoebel-Theuer <tst@schoebel-theuer.de>,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Message-ID: <20181215080547.GD10074@kroah.com>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
 <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
 <5ec69dad-7943-343b-5ced-9a962652e14c@schoebel-theuer.de>
 <20181214225428.GL11710@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214225428.GL11710@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:54:28PM +0100, Borislav Petkov wrote:
> On Fri, Dec 14, 2018 at 11:42:01PM +0100, Thomas Schöbel-Theuer wrote:
> > Ah, I overlooked that commit e56c92565dfe2 is already providing a different
> > solution to the same problem in newer kernels _only_, as a _side_ effect
> > (not clear to me from the description, but clear from reading the code).
> 
> Damn, I missed the fact that this is not the upstream kernel:
> 
> CPU: 0 PID: 1 UID: 0 Comm: swapper/0 Not tainted 4.4.0-ui18344.004-uiabi1-infong-amd64 #1
> 
> > So another alternative would be backporting e56c92565dfe2 to the 4.4 LTS
> > series. Also fine for me.
> 
> That looks like the right fix.
> 
> A note for the next time: do not send a fix for a stable kernel which is
> not upstream:
> 
> >From Documentation/process/stable-kernel-rules.rst:
> 
> " - It or an equivalent fix must already exist in Linus' tree (upstream)."
> 
> The stable kernels track upstream so if a stable kernel has a problem,
> the first thing one needs to do is to check whether this has been fixed
> upstream and if so, to backport it. This is the case most of the time.
> In the very seldom cases where a separate fix is needed, it needs to be
> handled by asking Greg what to do. :-)
> 
> Adding stable@ folks to CC to set me straight if I'm missing something.

Nope, you are correct, thanks!

greg k-h
