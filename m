Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D820AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984CD2152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984CD2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeI0Aiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:38:52 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:52740 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeI0Aiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:38:51 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8QIOR4l031575;
        Wed, 26 Sep 2018 19:24:27 +0100
Date:   Wed, 26 Sep 2018 19:24:26 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     TongZhang <ztong@vt.edu>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20180926192426.472360ea@alans-desktop>
In-Reply-To: <20180926013329.GD31060@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
        <20180926013329.GD31060@dastard>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 11:33:29 +1000
Dave Chinner <david@fromorbit.com> wrote:

> On Tue, Sep 25, 2018 at 08:51:50PM -0400, TongZhang wrote:
> > Hi,
> > 
> > I'm bringing up this issue again to let of LSM developers know the situation, and would like to know your thoughts.
> > Several weeks ago I sent an email to the security list to discuss the issue where
> > XFS's ioctl interface can do things like vfs_readlink without asking LSM's
> > permission, which we think is kind of weird and this kind of operation should be
> > audited by LSM.  
> 
> These aren't user interfaces. They are filesystem maintenance and
> extension interfaces.  They are intended for low level filesystem
> utilities that require complete, unrestricted access to the
> underlying filesystem via holding CAP_SYSADMIN in the initns.

CAP_SYS_ADMIN is meaningless in an environment using a strong LSM set up.
So what if I have CAP_SYS_ADMIN ? In a secure environment low level
complete unrestricted access to the file system is most definitely
something that should be mediated.

CAP_SYS_ADMIN is also a bit weird because low level access usually
implies you can bypass access controls so you should also check
CAP_SYS_DAC ?

Alan
