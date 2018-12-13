Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F75C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDEF20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735642;
	bh=Q3fRZSXVt4I6OcAAQVRcbD1m3y+AzuZkcx9Dc/EGRTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hBG5hVTxetdQNnwDp8yva5UMiPeBuRdlcazunjwdaFgMz1mZLtcwRfCm+29Sa3HXT
	 3a4bIK0cwmwl2WfzW8w4oZEuu5SDhlyDSzEXq+xqj1PVsXRP3Rxi3UJA4BRqdrWwE7
	 ULeM01twHSzbRroJQ6rEEpCDV9TT1ClR49gqVDK8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDEF20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeLMVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbeLMVOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:14:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B021420851;
        Thu, 13 Dec 2018 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735640;
        bh=Q3fRZSXVt4I6OcAAQVRcbD1m3y+AzuZkcx9Dc/EGRTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+AlaEFMEGSZNJPqUdAegxQfXzVkEMCHYR4ZAerF6kJ8qCpCom870oroTZYNVhAbb
         S6ITpOqBDqgN3q+awzPQJsdk9MYQ9PZbLtC+I1NBSuAp6geIsFOYZZGkfu+uks8c66
         eZhzjnJOw5emOzwmI71axtYtGZ0pLfeL2RQPoEpc=
Date:   Thu, 13 Dec 2018 22:13:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kilobyte@angband.pl, Todd Kjos <tkjos@android.com>,
        darrick.wong@oracle.com, chouryzhou@tencent.com,
        david@fromorbit.com, LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        joel@joelfernandes.org, Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v1] binder: implement binderfs
Message-ID: <20181213211357.GA16654@kroah.com>
References: <20181207232509.31771-1-christian@brauner.io>
 <CAHRSSEzxR2wRw9UxaKkXTZ7cu989+70-V07PxMm6o+BfLTQ=6w@mail.gmail.com>
 <20181212125126.4lhnjvrvaz5wwpib@brauner.io>
 <20181213175626.GB7218@kroah.com>
 <20181213205201.d4stjhypnseb3ska@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213205201.d4stjhypnseb3ska@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:52:03PM +0100, Christian Brauner wrote:
> On Thu, Dec 13, 2018 at 06:56:26PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 12, 2018 at 01:51:27PM +0100, Christian Brauner wrote:
> > > > > Cc: Martijn Coenen <maco@android.com>
> > > > > Cc: Todd Kjos <tkjos@google.com>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Do we plan to bring this into mergeable shape before Christmas? I'm
> > > happy to do it. :)
> > 
> > I haven't had the chance to give it a good review yet, but you should at
> > least fix up the kbuild warnings that the 0-day bot sent you :)
> 
> __user is what's confusing kbot here. You want me to wait for your
> review or send out a v2 right now? :)

A v2 is good, I'm not going to get to my review today...
