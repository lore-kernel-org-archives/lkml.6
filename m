Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B523C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B0220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544614759;
	bh=Q3gIpLnDq06ukydB5kjlUNe4LuVqTv3eOP77njkEZrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UNCpX2VJUjPkOm6erqDLBpNR2BP0dfRd7QpDnjmHRQg++t1/brrniXMCmgHILFDI3
	 nF34OtS4nhE0cUaI/nWsCEI5T6IlCap1dOOCNwIPLkXBWYHzDzxizAibUXQUHjCjP0
	 6+Y26f4Ay6LeR0Qw54ojL4w9w7/7IdWMbASZO1cA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B0220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeLLLjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeLLLjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:39:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3608720873;
        Wed, 12 Dec 2018 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544614756;
        bh=Q3gIpLnDq06ukydB5kjlUNe4LuVqTv3eOP77njkEZrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYgT7+J5mo7+9Z9zHHupVui1b65uE21bd2H8K8AxsZ2hIifO7ruT8FTfLYFFGlDTh
         xXOcsPr0oku3byyrPWDqk4mtbkXDjN1DgojET8lZlJuaySXngcAkO2OjMGaVxC6mdb
         dnFATXc2FZRKJ2woQewLiAN60QJgXeXELYYPaRdc=
Date:   Wed, 12 Dec 2018 12:37:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kyle Williams <kdgwill@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Harry Pan <harry.pan@intel.com>,
        Emmanuel Pescosta <emmanuelpescosta099@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Dmitry Fleytman Dmitry Fleytman <dmitry.fleytman@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/2] USB: quirks: Disable LPM for Logitech UVC devices
Message-ID: <20181212113735.GB20058@kroah.com>
References: <20181205093902.GA18633@kroah.com>
 <20181208014724.951-1-kdgwill@google.com>
 <20181208014724.951-3-kdgwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208014724.951-3-kdgwill@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 08:47:22PM -0500, Kyle Williams wrote:
> From: Kyle Williams <kdgwill@chromium.org>
> 
> Description: Some USB device / host controller combinations seem to have
> problems with Link Power management. In particular it is described that
> the combination of certain Logitech uvc devices and other powered media
> devices such causes 'not enough bandwidth for new device state' error.

Same thing with "Description:" :(

