Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D3FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F074721019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRhiYMwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F074721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbeK3CGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:06:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbeK3CGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:06:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCCAF2082F;
        Thu, 29 Nov 2018 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543503677;
        bh=JZu2qQw8pyIQlJzQ7Vn5WJE/gGqiyY81NLQ7v0if0fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRhiYMwKP1ef2to7CTmIoSMVNQAUCf9RHTq21RmeuMGl+LY4aIlOXY73INu/+7bgq
         CdipIY2YsRQ/IPj/eU+gKuXZGJ+X5XjJcoCB3Xipu0R/67V1Q/mJDF0UZK9wxmhgDs
         fVm2QhtcsTvKcsFK5WvOLZQDDE3paQkwTHRdu2oo=
Date:   Thu, 29 Nov 2018 16:01:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Message-ID: <20181129150115.GA22451@kroah.com>
References: <20181129140058.768942700@linuxfoundation.org>
 <20181129140102.870510957@linuxfoundation.org>
 <1543502726.10991.13.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543502726.10991.13.camel@suse.de>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:45:26PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> On Thu, 2018-11-29 at 15:12 +0100, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Erik Schmauss <erik.schmauss@intel.com>
> > 
> > commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.
> > 
> > The table load process omitted adding the operation region address
> > range to the global list. This omission is problematic because the OS
> > queries the global list to check for address range conflicts before
> > deciding which drivers to load. This commit may result in warning
> > messages that look like the following:
> > 
> > [    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
> > [    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> > 
> > However, these messages do not signify regressions. It is a result of
> > properly adding address ranges within the global address list.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
> > Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
> > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Jean Delvare <jdelvare@suse.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I'm confused. While we were discussing the regression, Erik said that
> this is fixing commit 5a8361f7ecceaed64b4064000d16cb703462be49, which
> went upstream in v4.17. So how can the fix be needed in any kernel
> older than v4.17? Erik, did I understand you incorrectly?

The patch says "All applicable", and I assumed that meant, "as long as
it applies."

Erik, should I drop this from 4.14.y?

thanks,

greg k-h
