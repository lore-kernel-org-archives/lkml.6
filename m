Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05997C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2B922506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="spHKbV/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2B922506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbeKMFUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:20:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D1F224E0;
        Mon, 12 Nov 2018 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542050746;
        bh=Ukokohd912ilOG7C7y94gXll2lQNx2UWRe0u1z5U6lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spHKbV/ZZ3MGgdlP1Hv/bu4cayRtHHdLNyO45+jqIAIRUV5JjlwApWqAg9wI/R1db
         a8aWsQBp1t1QrIg1aMqHCphUctTS4gEeopwhsLiMxzFDYBGRACGAk5d4wHV/oeYBAf
         3lltUFUD2xT727sXfeumg9hi98Acp5Rwk6UI8MxQ=
Date:   Mon, 12 Nov 2018 11:25:46 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4.19 025/361] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Message-ID: <20181112192546.GB2263@kroah.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221623.163909820@linuxfoundation.org>
 <9da1c8e8-d237-11b3-8918-859a4bbdbcc4@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9da1c8e8-d237-11b3-8918-859a4bbdbcc4@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:30:57PM +0100, Holger Hoffstätte wrote:
> On 11/11/18 11:16 PM, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> As probably expected this patch causes problems. In my case one server
> can no longer load the nct6775 hwmon module, which means the fan cannot be
> monitored, and therefore my monitoring system promptly starts spamming me with
> alerts that my fan has failed - which is of course not true.
> 
> --snip--
> Nov 12 18:08:56 tux kernel: nct6775: Found NCT6776D/F or compatible chip at 0x2e:0x290
> Nov 12 18:08:56 tux kernel: ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x
> Nov 12 18:08:56 tux kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> --snip--
> 
> This is certainly caused by my old BIOS and its broken ACPI implementation,
> however since it's working perfectly fine otherwise I see no reason to replace
> it. That being said, I must be able to monitor my fan, so for now reverting
> the patch immediately "fixed" the problem for me - the fan entries appeared
> in sysfs again after successfully loading the module.
> 
> Idea, workarounds or patches welcome.

So Linus's tree is also "broken" for your hardware?

thanks,

greg k-h
