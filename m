Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B242C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4354E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtDNN2hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4354E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJHXgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:36:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42048 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeJHXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:36:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so8453433pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+GE5EQyYPulWX4UbfdJGXuAQGzapTUeuq3TcN4JYZ8=;
        b=NtDNN2hcUf0K0hleAMQekT6K0jEi6wkY3Bq09CY8rFAqrxBF5BTW26A+tB8y7aK7Bs
         Vow0VFyUE1BZFJ1lOkK//pgRC9QEG2WfY2NdNhGu7FGLMBkmFJvtt02g4gpOyfDH7h+d
         A/2W7HFWttBIKSO6lcODx5mbhNEZkRR7vvccA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+GE5EQyYPulWX4UbfdJGXuAQGzapTUeuq3TcN4JYZ8=;
        b=l3v7kY8YKB/2UujHjCcqydnSG6ZUuRiY3CwA6adetJlZx5Bez0ai6N5+pfNUiG9ezh
         G/KxX1MnzKqk4jujNOM92hBzt4NUO0NHUS0OUcJXr7NpwNHSZzTpA/0Ud/hujoSPX+Fg
         W6mX1JQCcFrNsMrw1ylfup7YuObGXlMP8rTjbZQ6eTsrZ69lJHOBiiMc6MNSd5GvPvQk
         Dc8+VblO66fPp6eq42lXKCwF20A0I5ICbZ7XIeM7ca6PTXHWR67D+tDVKvUcJiamy1TB
         5SkBu8H2bVUiXeV26pNlEGy+Kpa11YUJnVI9v3WKQiAIKxDLT6gQAZ778MluzQDbrOep
         UyVw==
X-Gm-Message-State: ABuFfogls5Dy22Kk/R3q5TfM5MzTNnsBpMkXzwkIYsRK6F0pzrACuU3H
        TJaLCTvSjyfu9j44Rfwl0jmCZw==
X-Google-Smtp-Source: ACcGV63k6nZVSAXfAumI1AOvaw62Jp+O6Cyjc4nzYNZd3OsEwuwlVLjwmpn6VuXUw1pMA4KxlA1sBQ==
X-Received: by 2002:a65:43cd:: with SMTP id n13-v6mr21681316pgp.185.1539015809334;
        Mon, 08 Oct 2018 09:23:29 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o9-v6sm29192239pgn.30.2018.10.08.09.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 09:23:28 -0700 (PDT)
Date:   Mon, 8 Oct 2018 09:23:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>, ohad@wizery.com,
        clew@codeaurora.org, sricharan@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/4] Add TIOCM Signals support for RPMSG char devices
Message-ID: <20181008162325.GA1331@tuxbook-pro>
References: <1538980699-21516-1-git-send-email-aneela@codeaurora.org>
 <a64808ba-3c67-3ee9-9c13-3787e5ce7ab1@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64808ba-3c67-3ee9-9c13-3787e5ce7ab1@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Oct 06:08 PDT 2018, Arnaud Pouliquen wrote:

> Hi Arun, Bjorn,
> 
> On 10/08/2018 08:38 AM, Arun Kumar Neelakantam wrote:
> > Glink transport support signals to exchange state notification between
> > local and remote side clients. Adding support to send/receive the signal
> > command and notify the clients through callback and POLL notification.
> 
> Please correct me if i'm wrong...My concern here is that this patchset
> implements a rpmsg service in the rpmsg core. I would separate this from
> the rpmsg core, as this is not part of the rpmsg protocol but seems
> linked to the serial protocol itself.
> Could it be implemented in rpmsg_char, using a dedicated channel...?
> 

rpmsg_char does expose a rpmsg channel (be it virtio, smd or glink) to
user space. This patch series add support for invoking TIOCMGET and
TIOCMSET on these channels.

In addition to adding the client side of this to rpmsg_char it provides
this support for glink, but the same mechanism exists in smd - while
this is not supported (today) by the virtio rpmsg.


I'm uncertain of how we could implement this mechanism for virtio rpmsg,
given that it as a transport doesn't really have a concept of
channels/flows - but it's really useful to have!

PS. rpmsg_set_signals() can be called from any rpmsg device to perform
flow control of the communication channel.

Regards,
Bjorn

> Regards
> Arnaud
> 
> > 
> > Changes since v1:
> > - Split the patches as per functional areas like core, char, glink
> > - Add set, clear mask for TIOCMSET
> > - Merge the char signal callback and POLLPRI patches
> > 
> > Changes since v2:
> > - Modify the rpmsg_get_signals function prototype
> > 
> > Changes since v3:
> > - Correct the TICOMGET case handling as per new rpmsg_get_signals prototype
> > - Update the rpmsg_get_signals function header
> > 
> > Arun Kumar Neelakantam (4):
> >   rpmsg: core: Add signal API support
> >   rpmsg: glink: Add support to handle signals command
> >   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> >   rpmsg: char: Add signal callback and POLLPRI support
> > 
> >  drivers/rpmsg/qcom_glink_native.c | 126 ++++++++++++++++++++++++++++++++++++++
> >  drivers/rpmsg/rpmsg_char.c        |  74 +++++++++++++++++++++-
> >  drivers/rpmsg/rpmsg_core.c        |  41 +++++++++++++
> >  drivers/rpmsg/rpmsg_internal.h    |   5 ++
> >  include/linux/rpmsg.h             |  26 ++++++++
> >  5 files changed, 269 insertions(+), 3 deletions(-)
> > 
