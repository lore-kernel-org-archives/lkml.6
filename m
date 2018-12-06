Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD185C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01E5214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544059051;
	bh=MspFuguXfofW1tCpXNBy2+Evn2PD+MaQszkWQB/huwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pCs0yXkUuosbQiyEu79RyGSUmLaEc159XCxWc3sKOnLm6v7wbrL1vp9Bl7rDGoNeA
	 FBwrhcj5Q2Df1VfOfbtarpt6DA+GnfxNmiqRa/S8TC86XsurPoGQkdG8hMPd0whZdJ
	 tLW0bQRFdd6VYA1emx4XpoxoDcNt6BGrUF8lxYoc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01E5214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeLFBRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLFBRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:17:30 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B19D213A2;
        Thu,  6 Dec 2018 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544059049;
        bh=MspFuguXfofW1tCpXNBy2+Evn2PD+MaQszkWQB/huwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mR6ePTSr9GsSyYGdOTk+Rz9kSNSoIHUyswhPn9d5dBk5ylG6tdga+qHQz3PMedZLW
         TvWsm1+Aik1+uxiwNQle28f4TOnQzQ7gtujepZkiyorGQ7iBXQxfCo2tZJ4lPyqZJX
         AowkGSG36QDRsHJHztJ9uvj9UV6NSPIwWCj9LpBE=
Date:   Thu, 6 Dec 2018 09:16:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] bus: imx-weim: support multiple address ranges
 per child node
Message-ID: <20181206011647.GS3987@dragon>
References: <20181130205624.16227-1-TheSven73@googlemail.com>
 <20181130205624.16227-2-TheSven73@googlemail.com>
 <20181205075145.GN3987@dragon>
 <CAGngYiUvYHTRMvsS_4s8PVyPg5_sg4DhZZU4_k8US871oAWSvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUvYHTRMvsS_4s8PVyPg5_sg4DhZZU4_k8US871oAWSvQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:08:16AM -0500, Sven Van Asbroeck wrote:
> Hello Shawn, many thanks for the patch review, I really appreciate it !
> 
> On Wed, Dec 5, 2018 at 2:52 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Fri, Nov 30, 2018 at 03:56:23PM -0500, thesven73@gmail.com wrote:
> > > From: Sven Van Asbroeck <TheSven73@googlemail.com>
> > >
> > > Ensure that timing values for the child node are applied to
> > > all chip selects in the child's address ranges.
> > >
> >
> > I'm not sure about that.  Shouldn't we have another child node for
> > different chip select, something like below?
> >
> > &weim {
> >         acme@0,0 {
> >                 compatible = "acme,whatever";
> >                 reg = <0 0 0x100>, <0 0x400000 0x800>;
> >                 fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> >                                       0x00000000 0xa0000240 0x00000000>;
> >         };
> >
> >         acme@1,400000 {
> >                 compatible = "acme,whatever";
> >                 reg = <1 0x400000 0x800>;
> >                 fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> >                                       0x00000000 0xa0000240 0x00000000>;
> >         };
> >
> > Shawn
> 
> I am submitting patches for a device that spans chip selects :(
> And such a device needs multiple address changes with different chip selects.
> 
> Imagine we have an acme device, which contains a control and a fifo region,
> on different chip selects:
> 
> &weim {
>         acme@0 {
>                 compatible = "acme";
>                 reg = <0 0x0 0x100>, <1 0x0 0x100>;
>         };
> };
> 
> Now in probe we can access both regions:
> int acme_probe(struct platform_device *pdev)
> {
>         control_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         fifo_res =    platform_get_resource(pdev, IORESOURCE_MEM, 1);
>         /* all ok */
> }
> 
> But, if we have two separate child nodes, we also get two calls to probe(),
> which assumes two devices on the bus, and that is incorrect:
> 
> &weim {
>         acme@0 {
>                 compatible = "acme";
>                 reg = <0 0x0 0x100>;
>         };
>         acme@1 {
>                 compatible = "acme";
>                 reg = <1 0x0 0x100>;
>         };
> };
> 
> int acme_probe(struct platform_device *pdev)
> {
>         control_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         /* next call always fails */
>         fifo_res =    platform_get_resource(pdev, IORESOURCE_MEM, 1);
> }
> 
> For my patchset, Rob Herring suggested I made changes to the imx-weim driver
> to accommodate multi-chipselect devices.
> 
> See the conversation below between Rob Herring and myself:
> https://lkml.org/lkml/2018/11/30/390

Sorry, I wasn't aware of the discussion.  Now I understand the
background of the changes.  But can you please patch imx-weim bindings
doc (Documentation/devicetree/bindings/bus/imx-weim.txt) to accommodate
this new use scenario?

Shawn
