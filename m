Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1F7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2172083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2172083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJZA3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:29:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45954 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZA3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:29:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id o19-v6so4051372pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 08:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llbNe0hxAXv/15krlGQwJchISXs2r4Uv8+MRPxEtyLI=;
        b=jo3O+FUzCzrkCzNlAdS8p43PdVUgmWOdwQo5OgDGNzJ3LwSLnojtwnVbDxmRGzpnGW
         pe5tzJp7Y5zgKleXnay8DTcNuoZfgYIHUFLlQuSHscYofXF5VbJSMwoubVbs0O95FxoV
         fdNkExxpMB4IYTt9LQir6WjAoe/mhwlwcVgir8lIDs6h+ZCZKfkPHu9jcFYZO+ZX9Jdf
         G0PhdTRGHQlcS8p5VhSyNwK88Tmd0LmAYebzd9/3gKgxVNldeCTmtLXx+SfiWr3+9eb5
         Lf0sgVpGekAzsaC3IQEiRQL5hweKe+Lu8nYMHTGCz4II/0ZzDmMwpvM5wK6Cme30+qUw
         LlWg==
X-Gm-Message-State: AGRZ1gICA0/vjaxES6DOm6EXGfaec6ebiPjWv0EO64NcDYCYn8btPeAC
        yr2js8GZDiPOs0lec8pEF8idwL2hhHA=
X-Google-Smtp-Source: AJdET5cthizXHBIIKgzBqR0++CdTdE069D2/tN5k9ut9bhx+UIxlMxvizibeBW2Rq9niwGeasm6urA==
X-Received: by 2002:a17:902:2fc3:: with SMTP id t61-v6mr2034026plb.37.1540482950479;
        Thu, 25 Oct 2018 08:55:50 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id y10-v6sm12468960pgi.85.2018.10.25.08.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 08:55:49 -0700 (PDT)
Message-ID: <1540482948.66186.21.camel@acm.org>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 08:55:48 -0700
In-Reply-To: <f7e631f3957f8e4d00b1b2dbf5b660d62d9e45e3.camel@sipsolutions.net>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
         <f7e631f3957f8e4d00b1b2dbf5b660d62d9e45e3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 17:34 +-0200, Johannes Berg wrote:
+AD4 On Thu, 2018-10-25 at 15:05 +-0000, Bart Van Assche wrote:
+AD4 
+AD4 +AD4 +AEAAQA -2889,7 +-2893,7 +AEAAQA static bool start+AF8-flush+AF8-work(struct work+AF8-struct +ACo-work, struct wq+AF8-barrier +ACo-barr,
+AD4 +AD4  	 +ACo workqueues the deadlock happens when the rescuer stalls, blocking
+AD4 +AD4  	 +ACo forward progress.
+AD4 +AD4  	 +ACo-/
+AD4 +AD4 -	if (+ACE-from+AF8-cancel +ACYAJg
+AD4 +AD4 +-	if (+ACE-from+AF8-cancel +ACYAJg (pwq-+AD4-wq-+AD4-flags +ACY +AF8AXw-WQ+AF8-HAS+AF8-BEEN+AF8-USED) +ACYAJg
+AD4 +AD4  	    (pwq-+AD4-wq-+AD4-saved+AF8-max+AF8-active +AD0APQ 1 +AHwAfA pwq-+AD4-wq-+AD4-rescuer)) +AHs
+AD4 +AD4  		lock+AF8-acquire+AF8-exclusive(+ACY-pwq-+AD4-wq-+AD4-lockdep+AF8-map, 0, 0, NULL,
+AD4 +AD4  				       +AF8-THIS+AF8-IP+AF8)+ADs
+AD4 
+AD4 This also doesn't seem right to me. You shouldn't really care whether or
+AD4 not the workqueue has been used at this point, lockdep also doesn't do
+AD4 this for locks.
+AD4 
+AD4 Any dependency you cause at some point can - at a future time - be taken
+AD4 into account when checking dependency cycles. Removing one arbitrarily
+AD4 just because you haven't actually executed anything +ACo-yet+ACo just removes
+AD4 knowledge from lockdep. In the general case, this isn't right. Just
+AD4 because you haven't executd anything here doesn't mean that it's
+AD4 +ACo-impossible+ACo to have executed something, right?

Please have a look at the call trace in the description of this patch and also
at the direct I/O code. The lockdep complaint in the description of this patch
really is a false positive. What I think needs further discussion is on how to
address this false positive - track whether or not a work queue has been used
or follow Tejun's proposal that I became aware of after I posted this patch,
namely introduce a new function for destroying a work queue that skips draining,
e.g. destroy+AF8-workqueue+AF8-skip+AF8-drain() (https://lkml.org/lkml/2018/10/24/2).

Thanks,

Bart.
