Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC5CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD73217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548171616;
	bh=PB1fL6KDrsRkxRlHOBh1qd7oAZp1sKgLa+t0c/mqbJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R3Yvs8F1IjMCgFIOHS32MgcBQgGMNe8/NmECqJu1aBYFaGdSZHQol/mtXXH7Q//3F
	 JMGUENFmhUoDKzPHkI1EPff7H4gxC5kalk1z2/6DX0D0lS0ZTStrlvQDj/ycgbuCls
	 +HoFW9E2ulzYOcI1O9af6XsUHZwDlShYA0Yfslc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfAVPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbfAVPkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:40:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4AF7217F4;
        Tue, 22 Jan 2019 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548171613;
        bh=PB1fL6KDrsRkxRlHOBh1qd7oAZp1sKgLa+t0c/mqbJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1T5iSIHOGgr46GjUuwe1iCsYenwzxuhPtyMR8ux+cQ4tVo3KIiPIBB0rgQ1nr/ra
         42o+qEZySXukmF7sGY0G6QIV/XJjLKzvxgRKUtfhnNG/tf3mWiBJ3PfFIEUr74ISaG
         MKCv8wBZ6uZxlwqLewXYdVPPUmkXUHpl8ZHCXXrs=
Date:   Tue, 22 Jan 2019 16:40:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Yangtao Li <tiny.windzz@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi: no need to check return value of debugfs_create
 functions
Message-ID: <20190122154010.GA19652@kroah.com>
References: <20190122152151.16139-4-gregkh@linuxfoundation.org>
 <CAJZ5v0jWvk+07vUx4=KOzw4mkz7yYjmoS+Uy8qixqmpW3o2mig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jWvk+07vUx4=KOzw4mkz7yYjmoS+Uy8qixqmpW3o2mig@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:28:42PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 22, 2019 at 4:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Yangtao Li <tiny.windzz@gmail.com>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Or do you want me to take this?

It's up to you, I can take it, or you can, either is fine with me :)

greg k-h
