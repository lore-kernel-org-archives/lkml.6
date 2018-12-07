Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A6C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06C920868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544184088;
	bh=g5buTnVo65HFrDtdy85/SuL0Gf1ng+oGrHDcRxNuqlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iox/HyzALQW8k5XW8Kq1dh+WefZ/V4mxfhURa3zoZKYF3mXMIc+skW4SJ6XOGJBGA
	 cW8AnvKycz8PDtZMMtJh2U1Zco11ElyzVMcBFd5sskkKxgE6+0CvklY4P86ikMeGVD
	 ynvhm4HcBwsTpBtnBmlDqwuyPVoAd0DypGrLl4lU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06C920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLGMB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeLGMB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:01:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D1320868;
        Fri,  7 Dec 2018 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544184086;
        bh=g5buTnVo65HFrDtdy85/SuL0Gf1ng+oGrHDcRxNuqlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngkbxYEufr8jfFsfwuGxpX/rIGU2bn26w08JY6bxOmDWiXlGmBx4yi7/4cxf1KK7g
         RfEaj9FCUHn9NXf1Qxcd1h2GQmJwPdAz0LSJQj3sm90nO9fXdr7R61+Tf1/QeMYKHY
         CyiChTSxJVw3U1XEwREG49OJfhqSEBDAfTuGpi9A=
Date:   Fri, 7 Dec 2018 13:01:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Rajnoha <prajnoha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, msekleta@redhat.com
Subject: Re: [PATCH v2] kobject: add kernel/uevent_features sysfs file
Message-ID: <20181207120123.GB15336@kroah.com>
References: <20181207114607.26981-1-prajnoha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207114607.26981-1-prajnoha@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 12:46:07PM +0100, Peter Rajnoha wrote:
> We can use extended format when writing /sys/.../uevent files to
> generate synthetic uevents, introduced with commit f36776fafbaa
> ("kobject: support passing in variables for synthetic uevents").
> 
> Before using this extended format, we need to know if it's supported
> and kernel version check may not be appropriate in all cases - there
> are possible differences from upstream kernel in distributions with
> backports.
> 
> This patch adds /sys/kernel/uevent_features file which currently lists
> 'synthargs' string to denote that the kernel is able to recognize the
> extended synthetic uevent arguments. Userspace can easily check for
> the feature then.

So this is just to try to have userspace detect what type of feature the
kernel has?  Why can't you just go off of the other sysfs file itself?
You shouldn't need a "this is a feature list" for the kernel, otherwise
we would be on a huge slippery slope trying to document everything.

Who is going to use this thing?  And what else would go into it?

Isn't there some other way you can detect this from userspace (like
writing to the file and it fails?)

thanks,

greg k-h
