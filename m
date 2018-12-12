Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B3DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93862086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544615442;
	bh=ZA5wbzAz61RK0HfBR5vrlVRZDquKEeW7Itu7MXAXYlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WLxMRhgCWmqnZzc0IgJ2SzuUtelcOdlb5Kpi6KajrR29nZhkYSdBvzUuzGJO8Wvra
	 OWF5v29Qx9iBR0KWYJ/1BN5BIYqLSuHzuHyubSAXmiwUmaLa1Ql26SdhEdqpwnTPna
	 8lt+mK2+r0FNS/zjQtTTPmiRa4UAY1VpUOGxP7JE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93862086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeLLLul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbeLLLuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:50:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3A120849;
        Wed, 12 Dec 2018 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544615439;
        bh=ZA5wbzAz61RK0HfBR5vrlVRZDquKEeW7Itu7MXAXYlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cz+7CWwkeO3ibyNhdwDf1q/JvIer2LCazGJjNBTeOlj5P1dGDrx57A6sLqz5vOMPG
         k7h9fsVKcfaA4qTMIhCOp+5/15bdnieOyIzQP2E5De+jDmTntBB1EkD/KnoROJ3phH
         uys7m+Jzi/YL+FQjNSK3bp2Ze4vmBdS/KoP4yNck=
Date:   Wed, 12 Dec 2018 12:50:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
Subject: Re: [PATCH v2 6/6] misc: fastrpc: Add support for compat ioctls
Message-ID: <20181212115037.GA31075@kroah.com>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-7-srinivas.kandagatla@linaro.org>
 <20181212105932.GA1990@kroah.com>
 <864aaef3-8d60-3beb-ce20-a9f41f78a32f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864aaef3-8d60-3beb-ce20-a9f41f78a32f@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:44:05AM +0000, Srinivas Kandagatla wrote:
> Thanks for the comments,
> 
> On 12/12/18 10:59, Greg KH wrote:
> > > This patch adds support for compat ioctl from 32 bits userland to
> > > Qualcomm fastrpc driver.
> > Ick, why?
> > 
> > Why not just fix up your ioctl structures to not need that at all?  For
> > new code being added to the kernel, there's no excuse to have to have
> > compat structures anymore, just make your api sane and all should be
> > fine.
> 
> Yes, I did try that after comments from Arnd,
> 
> 
> > 
> > What prevents you from doing that and requiring compat support?
> > 
> I removed most of the compat IOCTLS except this one.
> The reason is that this ioctl takes arguments which can vary in number for
> each call.

Then do not do that :)

Remember, you get to design the api, fix the structure size to work
properly everywhere.

> So args are passed as pointer to structure, rather than fixed
> size. I could not find better way to rearrange this to give a fixed size
> data structure. In theory number of arguments can vary from 0-255 for both
> in & out.
> 
> current data structure looks like this:
> 
> struct fastrpc_invoke_args {
> 	__s32 fd;
> 	size_t length;
> 	void *ptr;
> };

Make length and ptr both __u64 and you should be fine, right?  If you do
that, might as well make fd __u64 as well to align things better.

> struct fastrpc_invoke {
> 	__u32 handle;
> 	__u32 sc;
> 	struct fastrpc_invoke_args *args;
> };
> 
> Other option is to split this IOCTL into 3 parts
> SET_INVOKE_METHOD, SET_INVOKE_ARGS and INVOKE
> with some kinda handle to bind these three.
> 
> with below structures:
> struct fastrpc_invoke {
> 	__u32 handle;
> 	__u32 sc;
> };
> 
> struct fastrpc_invoke_arg {
> 	__s32 fd;
> 	__u64 length;
> 	__u64 ptr;
> };
> I can try this and see how this works before I send next version of patch!

No need to have 3 calls, just change your one structure and you should
be fine.

thanks,

greg k-h
