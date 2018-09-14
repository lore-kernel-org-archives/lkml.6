Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E884FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D8920671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxtEqSux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D8920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeINTfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:35:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39031 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINTfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:35:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id v77-v6so8029797lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oG23FQPhfli3UettGDA/aVXG4kx/SyLP6BXCnZcebcw=;
        b=fxtEqSuxlrcgyDGWxN3ottjLIcqgJRn2IUUvbqgigSvyL5+t9NMYah5n5dXwCO19Jr
         zee4LEqH1vFPZxfNJiB5sTNoh3n3Ec8y4NJqySwZ6/p1wO40k+Q1DEtITyVzx/0cyy2v
         +BrW/d7de+pl7+BDPc4kJiWX1IVQNFPEmb4eEvV6S2Ox0xV0P43vZTiUnbWe3WJVDoe0
         Jn2WZhWNfNjtx5TXRRs9B+xQGx51kj8KchI7sHrCrg8G4/LxulqG3+0T2xG488MruTZk
         TlSdxvX56duSHI733ubTR3JE7YYzqzX+O+Damqy9m28M+5YiL5XwXz5xJsLJFdZTcdi3
         JclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oG23FQPhfli3UettGDA/aVXG4kx/SyLP6BXCnZcebcw=;
        b=Y9v434FI6ptnhT4gGbS0hrJICfusYUEQaTC+VjliIwisI5jVkbAA5QdhTuTIxra1N8
         qiGGDdc8D5Hd6MKp64kn6nvwuLZrdLDZ2IzyRT8ywEBfQ0zodyRZ0xJGpbiXLjG0ADSm
         /7N2URU4RZXsn8hNneqbJl3iVEnYXDKdwtqVJgOI7AqsTZ56Irk4G7VNg1UWhUua6gjY
         4Q5NMDABc1a2TPcmEZYkUXGA8wnWVvythSTDBYjB6CJwazGd5kzxE4dzu5O0gpMK8kii
         F5e5dSk38EL32t3Iq9/pcOdzPUWFNM7xYZkwk1ZVU3fmzQSUnsl0hxp7m5iyQuX60guK
         50PQ==
X-Gm-Message-State: APzg51D7Z063a3kv5+pT5gLMa35X4iI13s1Sd2W4M+bjtzgtq51av7mj
        hka02MhoD1JIthvdvfJdEzY=
X-Google-Smtp-Source: ANB0Vdbao/nTP9sd7RrUpMyB0rEPY1A/whgQVp9y8bCd82ptqqg1nzi8fFwUpWwGXxS5Yt9JZ4PKfw==
X-Received: by 2002:a19:884:: with SMTP id 126-v6mr8936043lfi.23.1536934839238;
        Fri, 14 Sep 2018 07:20:39 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z189-v6sm1287794lfa.14.2018.09.14.07.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:20:38 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oxc-0005vQ-TH; Fri, 14 Sep 2018 16:20:41 +0200
Date:   Fri, 14 Sep 2018 16:20:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/50] complete ->[sg]et_serial() switchover
Message-ID: <20180914142040.GV1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-34-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-34-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:33AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
