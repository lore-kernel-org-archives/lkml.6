Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E4ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 03:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B7F21523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 03:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQcvy627"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B7F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeIVJDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 05:03:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45523 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeIVJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 05:03:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so6724853pll.12;
        Fri, 21 Sep 2018 20:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dTtzRyKB9N8CQ5pIX8BUnlHkuLW8UfEOKSK09ArpKy8=;
        b=LQcvy627+O9yDmvuNt6ccfsxCPl0MJnf/aMwv/JFeEvtesDVCh1YGhM2Z9ZjCVUyIp
         Co40HPQMU36dWpCPSQGB/hDIUmQHxy9FnnZmJsr+DIAzKeFpXrn2UABxHl+eZVxRWYSA
         cUBdzfOuNYC70OUVGlQeE3vIZp6c/K7wx6KBL5Vn2RE65FPAgGJQ1Spk3eyBDfM2ncul
         IidWoDT5Usww7mZicz11MzZs4l1LCrNiw/Vudw+sp9RC+VROwRV3xZ++kWbQcbD9WK0b
         OL8tl/vEKzNHLNZSFvaKYCzr3O4RCjW4hOyDJg7e2jDpO8sljp59pRjtVIAebJkfAM3m
         DEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTtzRyKB9N8CQ5pIX8BUnlHkuLW8UfEOKSK09ArpKy8=;
        b=LE4ki6YXyIhjkN1EDZMJP2fOEUQapB51P+giw5HMDtgTzs3hpUN6/FLiLZJMDz4ukd
         q3IB5jp/LWGANmrKV6tGiufMza5lCM525YuI7CAbkvdL98Xm3KRLzRfV2J7UvFzmIGeL
         WN67L10L6C9KzmCUMH4qmpR8uy8HF5MWp8TM3yr8UZF6BF6iukGCQaKS6Ln0TimZa+Ix
         j3YbbgS7np5MegLtKjbYheLG1NxYtCM9iVp4mCmdSrwyQiOCO7cpGpnBGbfctYt+kuiM
         jI63ZlTNpKr328ZkeHLk8EFH/V+ItTMjp6jZi1DIdP6bwttVAIkaLr5Dazg6NKs2yorN
         uKlw==
X-Gm-Message-State: ABuFfojud2S6TMzs7zJgQNvgcj1SRBJrv6r/NLXGPka6KdYWbE9sInH2
        I4fP+y9L3v/y15gVqvdZUDo=
X-Google-Smtp-Source: ACcGV63exHw8u50LFWPzJjqULQ6l51SrpynXEHHEWAVD8bvckOTZfBwFftL+Qie52SeX7nTE7nHxYg==
X-Received: by 2002:a17:902:76c1:: with SMTP id j1-v6mr522790plt.278.1537585873952;
        Fri, 21 Sep 2018 20:11:13 -0700 (PDT)
Received: from rodete-laptop-imager.corp.google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id g66-v6sm41909526pfk.39.2018.09.21.20.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 20:11:12 -0700 (PDT)
Date:   Sat, 22 Sep 2018 12:11:07 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix missing zero pages for memory tracking
Message-ID: <20180922031107.GA131541@rodete-laptop-imager.corp.google.com>
References: <20180919051846.234615-1-minchan@kernel.org>
 <20180919072916.GA1180@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919072916.GA1180@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 04:29:16PM +0900, Sergey Senozhatsky wrote:
> On (09/19/18 14:18), Minchan Kim wrote:
> > We need to count zero filled pages as well as other pages in zram.
> 
> A nit,
> 
> 	'ZRAM_FLAG_SHIFT + 1' covers all ZRAM_SAME pages, not only
> zero filled pages.

Ah, now I got your point. I was brainfart.
I will drop this patch and find other reason I have missed.

Thanks, Sergey.
