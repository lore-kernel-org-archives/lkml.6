Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C1520645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="d/bYPJKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C1520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeIFSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:40:05 -0400
Received: from imap.thunk.org ([74.207.234.97]:58612 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeIFSkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=v4i0W8Eit1QWtpbTMTQOwrKERR8aCN+1JGBuOsipjVY=; b=d/bYPJKM0ELLa+UA1PdcrT8F2J
        QAV9W1GFDQSx0SBBWFMkgu8lHhKPa04sZ658WyWYOAaOeXaEBNU4DWBSdH52dwMnwbrpT2YBGbCZx
        02MolgSi3eW1cxnxGbu6B/G6EbLgUUyCEbVsQkH+ykM+iiR3azDORVOLmlRNcVxUP8Sk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fxutK-0003tn-OW; Thu, 06 Sep 2018 14:04:14 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AE6717A5670; Thu,  6 Sep 2018 10:04:13 -0400 (EDT)
Date:   Thu, 6 Sep 2018 10:04:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Widespread crashes in next-20180906
Message-ID: <20180906140413.GA5098@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:45:15AM -0700, Guenter Roeck wrote:
> Build results:
> 	total: 134 pass: 133 fail: 1
> Failed builds:
> 	sparc32:allmodconfig
> Qemu test results:
> 	total: 311 pass: 76 fail: 235
> Failed builds:
> 	<pretty much everything trying to boot from disk>
> 
> Error message is always something like
> 
> Filesystem requires source device
> VFS: Cannot open root device "hda" or unknown-block(3,0): error -2
> 
> The only variance is the boot device. Logs in full glory are available
> at https://kerneltests.org/builders/, in the "next" column.
> 
> I did not run bisect, but the recent filesystem changes are a definite suspect.

Yes, this is the vm_fault_t changes.  See the other thread on LKML.
The guilty commit was: 83c0adddcc6e: fs: convert return type int to
vm_fault_t

This is the *second* time vm_fault_t patches have broken things.  The
first time it went through the ext4 tree, and I NACK'ed it after
running a 60 second smoke test showed it was broken.  The seocnd time
the problem was supposedly fixed, but it went through the mm tree, and
so I didn't have a chance regression test or stop it...

      		       		  	      	     - Ted
