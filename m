Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F7EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FD920671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="b8RamXei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FD920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJXF1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:27:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38085 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJXF1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:27:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id p7-v6so1198610plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4FMNdBUY2JIhPzCQXL/Z3eiqadkxTMsq0q0z4hPidU=;
        b=b8RamXeiIAulFDaK/Ra11q92Q2Kqx89nKa8pCsPZ+AthXq2dYYfr/mAZZYgxQzitbW
         IGU4rc2o/j8f84QhhaaB56ldjp98sdFUapkMnhxM1qL64ZwrCKrXui7T0EkBCyTh2SBg
         x6zuGCqYQM41MWfdpovemA/VhaOAKYZsYlIbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4FMNdBUY2JIhPzCQXL/Z3eiqadkxTMsq0q0z4hPidU=;
        b=pPZk9Zf4BD1z55lvOptrbQFkayPS41ozpNhjIm+L4IVmS57j+UrsbleMglu4uH8c2J
         Kg2xaGsEnzW0NwY/VuDxcMbi4jVfer6lQIbPkSbi3hUfRrDa9N7by+u7YWSDMAns+n5R
         nE9p+bV7VNBK4t5YeA1r4E95NiQMAaHMY76s9r4e1KaXwPYW47k0Gi94hAIzdP0v33v6
         63jNpUFKWi2I9vweAY5DQNukriXDDkOgY3jEOwMSFkjT4TWIu9e2u/yFnfdm5drAhTc9
         q+yTPls/bzr7QAQ8ycKwNleR9n6ErvgYrGeWXu91FKmwKm5kiHPD4pHOAGpMZSVMXfbY
         qUZg==
X-Gm-Message-State: ABuFfojFJ3ojY0tr1cJFABqn2EMzItJ7rnd/1xJIoxQVIbvtJDmduuaZ
        DrKmrdAMb1w+4o0CNfo8svAOL6EXkw0=
X-Google-Smtp-Source: ACcGV62D3gldGIjcU7ddc4A/XCvT+x/BnFAS+O8FKsmdDEKf9VQ/2HP1gBraVP14Y8KznV6Wcj0K+A==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr49445624pli.220.1540328520738;
        Tue, 23 Oct 2018 14:02:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p24-v6sm8198019pgm.70.2018.10.23.14.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 14:01:59 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:01:58 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20181023210158.GA229730@joelaf.mtv.corp.google.com>
References: <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
 <20181023152640.GD20085@bombadil.infradead.org>
 <20181023170532.GW18839@dhcp22.suse.cz>
 <98842edb-d462-96b1-311f-27c6ebfc108a@kernel.org>
 <20181023193044.GA139403@joelaf.mtv.corp.google.com>
 <024af44a-77e1-1c61-c9b2-64ffbe4f7c49@kernel.org>
 <20181023200923.GB25444@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023200923.GB25444@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 01:09:23PM -0700, Matthew Wilcox wrote:
> On Tue, Oct 23, 2018 at 01:48:32PM -0600, Shuah Khan wrote:
> > On 10/23/2018 01:30 PM, Joel Fernandes wrote:
> > > On Tue, Oct 23, 2018 at 11:13:36AM -0600, Shuah Khan wrote:
> > >> I like this proposal. I think we will open up lot of test opportunities with
> > >> this approach.
> > >>
> > >> Maybe we can use this stress test as a pilot and see where it takes us.
> > > 
> > > I am a bit worried that such an EXPORT_SYMBOL_KSELFTEST mechanism can be abused by
> > > out-of-tree module writers to call internal functionality.
> > 
> > That is  valid concern to consider before we go forward with the proposal.
> > 
> > We could wrap EXPORT_SYMBOL_KSELFTEST this in an existing debug option. This could
> > be fine grained for each sub-system for its debug option. We do have a few of these
> > now
> 
> This all seems far more complicated than my proposed solution.

Matthew's solution seems Ok to me where it works. A problem could be that it
will not always work.

As an example, recently I wanted to directly set the sysctl_sched_rt_runtime
variable from the rcutorture test, just for forcing some conditions. This
symbol is internal and inaccessible from modules. This can also be done by
calling the internal sched_rt_handler with some parameters.  However I don't
think including an internal source file in a test source file can achieve the
objective of setting it since access to the internal symbol is not possible
without exporting it somehow. This could be a "special" case too but is an
example where the include trick may fall apart.

I do think its a cool trick though ;-)

 - Joel

