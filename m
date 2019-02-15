Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03345C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3FC2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="HiJxXxmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfBOFA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:00:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38148 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfBOFAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:00:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id 2so9602612qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LQtW9QwTMR1ZY3igaz7j+sEcQKomd0OgYbmle02AZVw=;
        b=HiJxXxmSC3HqR4lUQa8OKiH7A6vm3VM/mSFko+hX53RNHsMWM32G+RjrUVHVdegaHb
         oZkfkD1zg/UImzmXHKGtou6OsEuFA0Fj1Y/3u5lRl0444nAI6frDA+7oGKJmjFiOaqT2
         ZI1JM3DlLckOY08cD3M/MVolVOyQeIZ7bPVAfdSxsZH00EBQ+C+FFat0QiRinygwHeP1
         Z+meFadQmM88MlvpaZ5B0OhxP9VDAEsv7LURX3+vEp8ow/yvL7cpQeUBLxHwALRwYs9m
         NJZrjfvRjfD4TXBcp2QB9eJqeBjtL6J5aTSLwd7Nu6Dr59N05lKan+GMn0CFeYzFajpP
         nIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQtW9QwTMR1ZY3igaz7j+sEcQKomd0OgYbmle02AZVw=;
        b=WTXnmivjeBr8lGLrj9l0JSx2sstVzEKkNKXe3T1LC4xxDPM7JWbJ4ayj3iYKm4oxrP
         OO6LSoJEeGkDNjXyZ+XeoUqPPLdLB3TE8O2Dm56bQruPnKlk1y/r3f1ocBfBRHcqYSli
         Qqvt2FOrsyUk5upH9c82UU1BARr3KFLLrccDnZkrjnbcLEDR2g4rKJ31fzpyIMyqJzde
         Z0VheHyAqXswnlVTwGAURdqPBIgyNZXqnOpJvuET703V9ExSemfY240SYPMxNrRp33hT
         /UAR84w6Lw8OkTQKAsyT64jkljy5fMT1dV2XWxvz9JXLIXUnBJSGMgTm1AKBnft12HAl
         xvxg==
X-Gm-Message-State: AHQUAuY3qyl7IeefIhVCoysEjAN5bPh8JrH20+zdZJFc+dp8oDj8wDkY
        KNecz4JmkcDaCA2jGT0tfo+QPg==
X-Google-Smtp-Source: AHgI3IY9x2TTohLruAira0LIpf5dtXHRSHc84Y3evnYo0LJIU3hF+lMBD1E0oNksn5X/WWNFr4RvCA==
X-Received: by 2002:a0c:8a48:: with SMTP id 8mr5728463qvu.177.1550206854161;
        Thu, 14 Feb 2019 21:00:54 -0800 (PST)
Received: from cisco ([192.241.255.151])
        by smtp.gmail.com with ESMTPSA id 12sm4691073qka.83.2019.02.14.21.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 21:00:53 -0800 (PST)
Date:   Thu, 14 Feb 2019 22:00:49 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com,
        keescook@chromium.org, akpm@linux-foundation.org, jannh@google.com,
        oleg@redhat.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v7 1/2] signal: add pidfd_send_signal() syscall
Message-ID: <20190215050049.GC19258@cisco>
References: <20190102161654.9093-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102161654.9093-1-christian@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 05:16:53PM +0100, Christian Brauner wrote:
> The kill() syscall operates on process identifiers (pid). After a process
> ...

Fashionably late to the party, but feel free to consider these two:

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
