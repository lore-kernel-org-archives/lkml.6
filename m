Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A112C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3286C258DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8z/jEYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3286C258DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753112AbeF1CTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:19:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36015 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeF1CTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:19:48 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so1961804plp.3;
        Wed, 27 Jun 2018 19:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6VasC8FkWkHhSlM7ZGBdix1mgMLkau4mGykTp0x+FGU=;
        b=t8z/jEYyvUFkiirJcqzE/Vsnps20JbmLMirzsdaTWf9rpt3bZkprdevD3NZnejeovS
         WThakEStfjTQ+kGb4dZvrJSq3aU986xk4vZwPERQa8o28zuhfyWPo/9GUBLg7/Al+5QA
         G2kdIroDzEzd2kEAw3r1ilqxfn35a2hMJ06/hzyV/kokJ3fZi73Ezz7/v7tdlwZTEXSP
         VjGAx2VWYnH5V0rgLl1uRO2ibpexZq+RJmilWenGloea9xNtX7mVumVvF8YZY87gexBi
         gBbyCFjb+WXDnt1yhsD1DmHcnHGu2gQi0KeYkk2bXoIwj92I+39q10Ya6ZX03liGNBMg
         CrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6VasC8FkWkHhSlM7ZGBdix1mgMLkau4mGykTp0x+FGU=;
        b=E37VefIZJgm1Pb4ddrXvcTBCZcST61agWudf6ent8dgwOSTrzF7OsQJJfPLYI6Tr7w
         WF+JBjTCJbbOLahErjO5XsnOhqSzqmZzXj0SUsBLpNF45GhsbYF/eluNSj5j8CBAouDL
         8W2iteE68Ipg49aSp3+0o5VZYBIkb/N/D3m00PpjCDWZjrxKdXiyOQgyJ2+444pZAPBH
         693y0TQsPCVFCLOTRopevPwfn487Y1qYVceg3kAG7UzQQYlRJIhUsZKLDJDBLq2jGrqH
         rZzJK7WsNkuhtNWYjr440UO1ZwQgwrs9DWiMeSz/e5wbGTZluGL7gA5dq1ASegW0pTQx
         2d3A==
X-Gm-Message-State: APt69E1tHR7W9TCCoBVWhtQXx65SqBT4NHsVL5Dm82jdWLDg/UKvliek
        DrevTIW0OCVwfe7SW+1aCqo=
X-Google-Smtp-Source: ADUXVKLwoKX0cmrfvIPkc9q4WEzRA6aqIGsWpFYlroDtLGzaXUVoIGj/Xu0oTfdLV/oZAmlA1g6Sqg==
X-Received: by 2002:a17:902:1682:: with SMTP id h2-v6mr8546276plh.327.1530152388214;
        Wed, 27 Jun 2018 19:19:48 -0700 (PDT)
Received: from localhost ([110.70.27.221])
        by smtp.gmail.com with ESMTPSA id y2-v6sm12652989pfk.82.2018.06.27.19.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 19:19:46 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:19:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] printk: Create helper function to queue deferred
 console handling
Message-ID: <20180628021944.GC481@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627140817.27764-3-pmladek@suse.com>
 <20180628021603.GB481@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628021603.GB481@jagdpanzerIV>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/28/18 11:16), Sergey Senozhatsky wrote:
> 
> You can just call vprintk_emit(LOGLEVEL_SCHED) from vprintk_func(),
> then you don't need to factor out vprintk_deferred() and vprintk_emit().
> Any reason for that split?

My bad, no you can't. I forgot that for direct_nmi vprintk_func()
logbuf_lock is locked at the upper level - vprintk_func().

	-ss
