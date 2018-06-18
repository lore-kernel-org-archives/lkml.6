Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3946C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7B020862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acgo0xL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7B020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936778AbeFRKKL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:10:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34107 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934813AbeFRKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:10:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so8762224plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Svk7jBvVBbVNQvJQjDnGET2sJ9knK/GL3lsFO5lkl34=;
        b=acgo0xL+DyVhyajjwJkNKt9uB75/KnxX507ADMakp4/QFeA0HWe4P254x01e7vbsMX
         ak4iXzqCtozooSRsdOycbmsLMltfCnZEPQ7zkgY9u5mADJV3dbl8FNRxavfN5mBHOVJx
         hAnlU/dcSwHZJ5GKwm1JHA2TDFUU1Z/TRS0Y+TPy3FhXaz0PC+76qkZvzixpc65GOimI
         xBSY8izmnmqd55FFOYbrYMXXc3oIqyXzEVdw5/hWFCnMVT+VrewjQF5bslkaj6dQYyhm
         RbIswR510znM6DL3N/f/IuJ/jLz748IiSWXvzUCwNNqUQM+VAXVVkEfOPdK4NyIm4VwS
         Wq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Svk7jBvVBbVNQvJQjDnGET2sJ9knK/GL3lsFO5lkl34=;
        b=QEk9qriCWQwj97h/cs0I61XYA2LaHJ64oaK2csVqJNcPqNMsfIbeRS/TeMbIORroRR
         R2v/MWgSu0lPUDIxYVCAc/HBXuUuI4tR3PCNe7HBV1UEh2a/GrysstH6FSRcApLWXs1g
         D5hZICiO0uoczjqORrB/v8L6BYbypZz2tHBApoj+xdtNvo7c6TF3erpDzr63SBemGrf/
         E6Er9VtYyOw+6md+i3M2qvG4GiZDwiWdmPoBAIXog5YW7UtUfjdzIf1fnjJCaEQBwVSE
         +CdzqmdqUGB0vI41KUc+K/Hd0bpHagfE/HB64Yu79iyJhOubqRcqOR7XWSkZdXGzkfkf
         RkKg==
X-Gm-Message-State: APt69E1v2Comtb1rla4OuCDaAZMRtGTXoAT9fx4NQ+wEb82dyVkPt4bD
        CGk3CU/dKT5zdpqK2DNDVDY=
X-Google-Smtp-Source: ADUXVKKpxT1Raks2ZrmZFPzGtxQ/ag+DXP6ikWCSNe4JlU1PN12yufghVgsn49oCPXCuZ3scEMCP1Q==
X-Received: by 2002:a17:902:422:: with SMTP id 31-v6mr13319140ple.320.1529316608318;
        Mon, 18 Jun 2018 03:10:08 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id k69-v6sm20912841pgc.39.2018.06.18.03.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 03:10:06 -0700 (PDT)
Date:   Mon, 18 Jun 2018 19:10:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not call console drivers from
 printk_safe context
Message-ID: <20180618101003.GB555@jagdpanzerIV>
References: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
 <20180424105104.792d2d80@gandalf.local.home>
 <20180425144813.lfhvuwsf2cebwarm@pathway.suse.cz>
 <20180618063916.GD27996@jagdpanzerIV>
 <20180618095932.pshslpzntgfr7lg4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618095932.pshslpzntgfr7lg4@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/18/18 11:59), Petr Mladek wrote:
> 
> Would you mind to keep it on hold for now?

OK.

	-ss
