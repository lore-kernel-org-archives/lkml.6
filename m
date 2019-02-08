Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6020C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9286E2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549635085;
	bh=MER7eVkRNi1dIxnAlEqHi060EUS9lKSJj9pU/vFY79c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EqjYSvre/IaSVqbG5vDBbD4XdEvkok6ETqpMYD6sAuqh5KDWTNXWmIn+SD6GuGzMe
	 mY0RLPr4qr8SBsU0jvHNWtI9YLbZMZbSPpc9obsT7NCmAYhgVWseKgugSECxfATGSb
	 eMsOjDpvHMB7GXLFNDdW4JDOGb5H8BhsI4Ugw4HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfBHOLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfBHOLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:11:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFBA2075C;
        Fri,  8 Feb 2019 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549635082;
        bh=MER7eVkRNi1dIxnAlEqHi060EUS9lKSJj9pU/vFY79c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0RlWcssOYTZCJ8TZdqKbh5iWakubpPrBIU+bXIk6x7S3E7XtssyMKhkcA4/fUbkpj
         gEFdvp0+TsDbYJggDDpgBYqDBBkmjFw/01JJnjYtaW+dtEhaIarQd4v+qs5lUz6/IK
         15rrIp+b0/BRcB6wrd7FT4iQqibaRvZAfvKTBH1U=
Date:   Fri, 8 Feb 2019 15:11:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH v6 3/5] misc: fastrpc: Add support for context Invoke
 method
Message-ID: <20190208141120.GA9516@kroah.com>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
 <20190208132306.12571-4-srinivas.kandagatla@linaro.org>
 <20190208135514.GA23406@kroah.com>
 <b60a0c35-6e5a-4166-9dd8-3891fce1cd0b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60a0c35-6e5a-4166-9dd8-3891fce1cd0b@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:01:33PM +0000, Srinivas Kandagatla wrote:
> Thanks for the review,
> 
> On 08/02/2019 13:55, Greg KH wrote:
> > > +
> > > +		/* Make sure reserved field is set to 0 */
> > > +		if (args->reserved) {
> > > +			kfree(args);
> > > +			return -EINVAL;
> > Am I wrong in that you are only checking the first reserved field in
> > this array of args?  Don't you have a whole bunch of them here (nscalars
> > of them)?  Don't you need to check them all and not just the first one?
> My Bad, there should be a loop here!
> I will fix this in next version!

No, you don't need to loop it here, check it in the call that evaluates
the individual args, which will catch the issue when people send
"internal" commands.

Which reminds me, what happens if a sequence has problems half way
through the list of args?  Do you "roll back" to the beginning, or just
abort?  What happens to the internal device state then?

thanks,

greg k-h
