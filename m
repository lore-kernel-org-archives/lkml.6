Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96CA20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bky7YCVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96CA20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeJXDzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:55:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33891 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:55:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id f10-v6so1107494plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WLjxc2nhnTAlCyfJdheSE9tMYooC2GCoOwWqKqRKxt4=;
        b=bky7YCVrCL8HMBWZmLfu2SJfK4uo/2afqHV5v2fWjbGw7Qkajxzq+jmQQTohdhxjB9
         FH2mD8Zmg2rS4LOeU/CemJAO7FdtAkos4c5RosyqQamDWVtXMmTwB0TpMtrk8t4ENvms
         /EfSH4LJi9RVp2ilXAMHClKwQJt2fkouW8snQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WLjxc2nhnTAlCyfJdheSE9tMYooC2GCoOwWqKqRKxt4=;
        b=jxS76lYeZdS3wn60PS5SSwZyu4ikXBztHex5tw7eUhX+bVY5N4jl2WwDXatw1c9OKF
         DNFDa7arQlNlQTwLwFUCMQvidaHG/qvsOje18YN18RnemhzVDIPF0HW0hTmC51T5n23+
         hw4g8+8ZEbg+ORaAAW/f+Y+1Kp2HdAvap/2raddai7a8x8HpeCab7s5xlOhG6BLl0N/t
         ePrH03A4v8XL/kamfSMOW7rrcy+6quYXPtqBUUqIm3zWsjV8yFM8H1O48V+tDHE/vQir
         C2F4tXvjTnLzB5L3sPPLRtRBdHw43VCP+/cMe/thTSthXGpqPBr3G093cnxXQCsQ9ZOm
         9m2w==
X-Gm-Message-State: ABuFfogGMvYCf/XWXCfm/9L4ZW71cYwXDEqHQ1MIqX3CiJpnpM74GHQx
        QBkXS5KrWYv0xtGdbKmH7vyarA==
X-Google-Smtp-Source: ACcGV62LQmEik2rXsOFRdXTL/FSE+dPZLObYaN2cj209jMVLCKE8nM3BpCGdU/K513EhDeHJMnQo/A==
X-Received: by 2002:a17:902:6843:: with SMTP id f3-v6mr49777475pln.64.1540323047845;
        Tue, 23 Oct 2018 12:30:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a79-v6sm3252562pfa.124.2018.10.23.12.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 12:30:45 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:30:44 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        maco@android.com
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181023193044.GA139403@joelaf.mtv.corp.google.com>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
 <20181023152640.GD20085@bombadil.infradead.org>
 <20181023170532.GW18839@dhcp22.suse.cz>
 <98842edb-d462-96b1-311f-27c6ebfc108a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98842edb-d462-96b1-311f-27c6ebfc108a@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:13:36AM -0600, Shuah Khan wrote:
> On 10/23/2018 11:05 AM, Michal Hocko wrote:
> > On Tue 23-10-18 08:26:40, Matthew Wilcox wrote:
> >> On Tue, Oct 23, 2018 at 09:02:56AM -0600, Shuah Khan wrote:
> > [...]
> >>> The way it can be handled is by adding a test module under lib. test_kmod,
> >>> test_sysctl, test_user_copy etc.
> >>
> >> The problem is that said module can only invoke functions which are
> >> exported using EXPORT_SYMBOL.  And there's a cost to exporting them,
> >> which I don't think we're willing to pay, purely to get test coverage.
> > 
> > Yes, I think we do not want to export internal functionality which might
> > be still interesting for the testing coverage. Maybe we want something
> > like EXPORT_SYMBOL_KSELFTEST which would allow to link within the
> > kselftest machinery but it wouldn't allow the same for general modules
> > and will not give any API promisses.
> > 
> 
> I like this proposal. I think we will open up lot of test opportunities with
> this approach.
> 
> Maybe we can use this stress test as a pilot and see where it takes us.

I am a bit worried that such an EXPORT_SYMBOL_KSELFTEST mechanism can be abused by
out-of-tree module writers to call internal functionality.

How would you prevent that?

thanks,

 - Joel
