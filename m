Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D947C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544435467;
	bh=+PimPt4Ybz+7zfNsIsxi+E3awJWeJ6wD3SE4WwRPptA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=h2LZLgg4RHdStcI86Z9Ppb4YcA3icoXk2nNN/f040hBgCHpQmKh0YcqNW/8xHz8ej
	 phZgdrSl6n950lqAhpExHWXk721y5fgVP5e8gdoPP4PvWvPX0z3qGcfZBeJ3xprWOK
	 fE2d2OgLa5Hc8//nwumGDcQ8jpN/p6QQ3CPj9FdU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC9B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeLJJvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeLJJvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:51:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4AC72082D;
        Mon, 10 Dec 2018 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544435465;
        bh=+PimPt4Ybz+7zfNsIsxi+E3awJWeJ6wD3SE4WwRPptA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=WZgVQUbgWuKO6IRMeCWx0ovt5GUehlIHXe1rxDaYXbC1XSY0vk17yVCxnK5qq4U5d
         AE8rw8QoBebGcpJ/6WNfWcyDTl6YdhXtf6PWiQV4/YXHVm14IIrPk/4EZX+adLevdu
         v4g0zrbknTqLhH78B0Ivau1hPxkSUNS8kPYdZiqc=
Date:   Mon, 10 Dec 2018 10:51:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Laura Abbott <labbott@redhat.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Process for severe early stable bugs?
Message-ID: <20181210095102.GB27385@kroah.com>
References: <c04ea7b1-23f3-f1e0-4f31-07b62abdee24@redhat.com>
 <20181208115629.GA3288@kroah.com>
 <20181208171853.GA20708@thunk.org>
 <20181209113039.GA10771@kroah.com>
 <20181209164419.GI20708@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209164419.GI20708@thunk.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 11:44:19AM -0500, Theodore Y. Ts'o wrote:
> On Sun, Dec 09, 2018 at 12:30:39PM +0100, Greg KH wrote:
> > > P.P.P.S.  If I were king, I'd be asking for a huge number of kunit
> > > tests for block-mq to be developed, and then running them under a
> > > Thread Sanitizer.
> > 
> > Isn't that what xfs and fio is?  Aren't we running this all the time and
> > reporting those issues?  How did this bug not show up on those tests, is
> > it just because they didn't run long enough?
> > 
> > Because of those test suites, I was thinking that the block and
> > filesystem paths were one of the more well-tested things we had at the
> > moment, is this not true?
> 
> I'm pretty confident about the file system paths, and the "happy
> paths" for the block layer.
> 
> But with Kernel Bugzilla #201685, despite huge amounts both before and
> after 4.19-rc1, nothing picked it up.  It turned out to be very
> configuration specific, *and* only happened when you were under heavy
> memory pressure and/or I/O pressure.
> 
> I'm starting to try to use blktests, but it's not as mature as
> xfstests.  It has portability issues, as it assumes a much newer
> userspace.  So I can't even run it under some environments at all.
> The test coverage just isn't as broad.  Compare:
> 
> ext4/4k: 441 tests, 1 failures, 42 skipped, 4387 seconds
>   Failures: generic/388
> 
> Versus:
> 
> Run: block/001 block/002 block/003 block/004 block/005 block/006
>     block/009 block/010 block/012 block/013 block/014 block/015
>     block/016 block/017 block/018 block/020 block/021 block/023
>     block/024 loop/001 loop/002 loop/003 loop/004 loop/005 loop/006
>     nvme/002 nvme/003 nvme/004 nvme/006 nvme/007 nvme/008 nvme/009
>     nvme/010 nvme/011 nvme/012 nvme/013 nvme/014 nvme/015 nvme/016
>     nvme/017 nvme/019 nvme/020 nvme/021 nvme/022 nvme/023 nvme/024
>     nvme/025 nvme/026 nvme/027 nvme/028 scsi/001 scsi/002 scsi/003
>     scsi/004 scsi/005 scsi/006 srp/001 srp/002 srp/003 srp/004
>     srp/005 srp/006 srp/007 srp/008 srp/009 srp/010 srp/011 srp/012 srp/013
> Failures: block/017 block/024 nvme/002 nvme/003 nvme/008 nvme/009
>     nvme/010 nvme/011 nvme/012 nvme/013 nvme/014 nvme/015 nvme/016
>     nvme/019 nvme/020 nvme/021 nvme/022 nvme/023 nvme/024 nvme/025
>     nvme/026 nvme/027 nvme/028 scsi/006 srp/001 srp/002 srp/003 srp/004
>     srp/005 srp/006 srp/007 srp/008 srp/009 srp/010 srp/011 srp/012 srp/013
> Failed 37 of 69 tests
> 
> (Most of the failures are test portability issues that I still need to
> work through, not real failures.  But just look at the number of
> tests....)

So you are saying quantity rules over quantity?  :)

It's really hard to judge this, given that xfstests are testing a whole
range of other things (POSIX compliance and stressing the vfs api),
while blktests are there to stress the block i/o api/interface.

So both would be best to run as we know xfstests also hits the block
layer...

thanks,

greg k-h
