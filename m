Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB559C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3720672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TFY/DFTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB3720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJ2H4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:56:19 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39652 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeJ2H4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:56:19 -0400
Received: by mail-ed1-f43.google.com with SMTP id e5-v6so5711758eds.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vpKPgllwmuG5+Ujlt0RUdvR8CEviOcBwE+h4ookEKlc=;
        b=TFY/DFTnBO7d0XoPPpVdvlQr4SMY+VMVWgYIYJ28a3+02QuRnSf6SI5Axu7x1orWiz
         uX1B1t7zn3lpPqVyHUcVoOttFW82b8enItF1zST50M86I0fmaqn2mbk9NvM/wLQYv3kR
         gIVxgKZJTIGTKPYV99wd1bsy6PsCRBO+mT+zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vpKPgllwmuG5+Ujlt0RUdvR8CEviOcBwE+h4ookEKlc=;
        b=Rzwobuieat7z4Kl7zfysPNAS2yLnSUPlx6DxxfI00RYj6FmTYTkAnIu0Vun+jMmqgz
         OrUO41i4qvhW571Z1qbrLT4K1csJjZYbz/LGYdqhsl2aD3GRFQ7VUSnfJM1zdNHk3i9a
         ZxlxUxNLufsqLDs5+e19+IkcSQNo/eZ0m8GvvKb4uGHs77pWbOvqvblXLyN+qQ46ryD4
         bcVQiJCDpGt1QhHJOy1IZFEbM0ZEDxG19wteY54ULF/OquVv4Gtk+TjamYcBNJpkCPAN
         Z2hfogXa8gT8m96uGU2YRsHeHGU0qci2mSUfGOKtgXRveUcoObwI0NJnS7zSSVa5sgYw
         53sA==
X-Gm-Message-State: AGRZ1gLNm0ZMUWt7SxP3H1yzTLsoKLOYwyo7TEewcsl0PN+OQMbCDCPP
        Cn3Ukn7G8rrLugT10Zlu3Q2Awg==
X-Google-Smtp-Source: AJdET5eBynFG88vN2bX1+F5bFidNuCj8LuxfiXgb9JlhC8fPNe5eaPKPIcCGznzLMuzzNUbvZlGvgg==
X-Received: by 2002:a50:b3cf:: with SMTP id t15-v6mr11927264edd.181.1540768212429;
        Sun, 28 Oct 2018 16:10:12 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id w14-v6sm5370480eds.16.2018.10.28.16.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 16:10:11 -0700 (PDT)
Date:   Mon, 29 Oct 2018 00:10:03 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFR] Store tearing
Message-ID: <20181028231003.GA4021@andrea>
References: <20181028230627.GA3420@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028230627.GA3420@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully, with Paul's proper email address this time,

  Andrea

On Mon, Oct 29, 2018 at 12:06:27AM +0100, Andrea Parri wrote:
> Hi,
> 
> memory-barriers.txt says:
> 
>   [on "store tearing"]
> 
>   "In fact, a recent bug (since fixed) caused GCC to incorrectly use
>    this optimization in a volatile store.".
> 
> I was wondering if you could help me retrieve some reference/discussions
> about this?
> 
> Thanks,
>   Andrea
