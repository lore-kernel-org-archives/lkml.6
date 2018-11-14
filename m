Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759CA22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPhRU+0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759CA22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeKOJCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:02:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38155 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:02:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4-v6so8484859plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEwluYf5pVrZlULZb0WFZKAULNUUAy9+cpDSbTq/IvA=;
        b=QPhRU+0jlJIIFTqBhmiQ4RltqUDGf/poEMjC88w9W08571y9GnY6BOaCH6vl7e/baM
         lKG6dsxqEq04fhNZ7mzf1JCveq0CkdZkNDzN9eE7f1QQ5ihHm4SgztjE1/f9aSJ/Ktyh
         Q9JM279+e0rpbErhLjnQtQzBRBkdab4L9WjC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEwluYf5pVrZlULZb0WFZKAULNUUAy9+cpDSbTq/IvA=;
        b=INpN/zktDcWJK++BlIPjJhdlknVWikTXaVXgZWtLIbAG/+V2K1r9VYKKZhks7MknfR
         brzVDsrvdz1/eacIf5oy+X/tRR32UInSCgrxv13OeRPfcXJiYMvGBN20Or/k4+sLm40J
         fkliM2d+oOGazUQipryON5b+Lbg6x6TWMrRQxrBPUJnR9u+5+uBgPep1Ku8q07QVDIyf
         AX5/ug2s8luHQnFfo8atoxMXrXX12HluSBtOE+m7xXXidXLvyX78vDEHufmgEMM7AdTI
         hB2PtywxrOkQPt86DWE4LL74nyNHLF+4ilhW1sKQ2yl09wviXQWSyMjOkhKjAbb4NRZN
         ThPg==
X-Gm-Message-State: AGRZ1gLgElX5LNnU+eknyFrmct3LKGwwuHGy+pieoFm7HQ1aYkC03evW
        nKcvSLm5R2hAwzBg1nLG0e2O/w==
X-Google-Smtp-Source: AJdET5cNk6jGsn+1uq57Hz3N6+QNlfVNhWBtexXipQS9/RNT2P4ef+2khixW8WUkKfWa7FKbLKYY8w==
X-Received: by 2002:a17:902:784d:: with SMTP id e13mr3856493pln.188.1542236239783;
        Wed, 14 Nov 2018 14:57:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id i72sm231732pfe.181.2018.11.14.14.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 14:57:19 -0800 (PST)
Date:   Wed, 14 Nov 2018 14:57:18 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] sysrq: Use panic() to force a crash
Message-ID: <20181114225718.GN22824@google.com>
References: <20180920171253.115372-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180920171253.115372-1-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:12:53AM -0700, Matthias Kaehlcke wrote:
> sysrq_handle_crash() currently forces a crash by dereferencing a
> NULL pointer, which is undefined behavior in C. Just call panic()
> instead, which is simpler and doesn't depend on compiler specific
> handling of the undefined behavior.
> 
> Remove the comment on why the RCU lock needs to be released, it isn't
> accurate anymore since the crash now isn't handled by the page fault
> handler (for reference: the comment was added by commit 984cf355aeaa
> ("sysrq: Fix warning in sysrq generated crash.")). Releasing the lock
> is still good practice though.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/tty/sysrq.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 06ed20dd01ba..d779a51499a0 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -134,17 +134,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
>  
>  static void sysrq_handle_crash(int key)
>  {
> -	char *killer = NULL;
> -
> -	/* we need to release the RCU read lock here,
> -	 * otherwise we get an annoying
> -	 * 'BUG: sleeping function called from invalid context'
> -	 * complaint from the kernel before the panic.
> -	 */
> +	/* release the RCU read lock before crashing */
>  	rcu_read_unlock();
> -	panic_on_oops = 1;	/* force panic */
> -	wmb();
> -	*killer = 1;
> +
> +	panic("sysrq triggered crash\n");
>  }
>  static struct sysrq_key_op sysrq_crash_op = {
>  	.handler	= sysrq_handle_crash,

Does this need further changes or is it ready to land?
