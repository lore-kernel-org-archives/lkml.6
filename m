Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82182ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A3521470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Pehw5mzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A3521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJTDjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:39:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39400 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJTDjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:39:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id e67-v6so7293022plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Te2xcDjP2AI1m4qQ1Kf1q0A8KLC0u4osR3z/f5hltaE=;
        b=Pehw5mzF3JGpD2gy+62/zEf6gKRP5zqgiaXRAJATzJWPjwlIW2XrVfildiWYLQUZwf
         Q+DZcDBeczGtlCupoJI4AHJJ9eJbLqgJVbJ2Ru+bgNvY9eEeaBHAAkFT1D2mw5d5x/1Y
         8v42b04IsTLrKhyENn8SDzUp4AYXmLciN654M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Te2xcDjP2AI1m4qQ1Kf1q0A8KLC0u4osR3z/f5hltaE=;
        b=ua/R6Ug/R90XcOZNnPfa7DBDGVCMEnecwZgyBYzQfW0JDkeq4o4TxAPi5gn/I1EShc
         PGTlecv0COINuNIMlP8PKhhvGabHd4jmz0tOmqbcGoyAFaAdKGJ6OrGE+PcyJVtIXGD7
         2+BtaHJlslzmgl6DxbUIwvsXbyEUEMIlNkflhQpN2uP4AD8CzMF+wuLQuxHyy2AglFkx
         cxNMnEq114QftyGGUETqc28nwDDX4gMIpTUxYAQuAywAxFDy31btFrdcO+GL4E+lLKl/
         KNosKr6Et/uAaYTwkZUHWGvk5N7BmLVKYW/5XOqPNjPkRkUFf2YwI3n7GVTk2MJCWJPW
         hXfA==
X-Gm-Message-State: ABuFfohzMxWtfpoiLeBQ336vmlS8JXeAwwiufyZ1A+zHNoNMjs8OK+Ir
        h1juTA7EyTMXz8s6Sb7c5N+dgw==
X-Google-Smtp-Source: ACcGV619M4BNWUewSsgG7IRPfZo07i8xEYOxYAcRuRtvw855iuJp1h4EJOeDRzkOLVcIA8vPpRldzQ==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr35016617plq.77.1539977539643;
        Fri, 19 Oct 2018 12:32:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p17-v6sm41955176pfk.186.2018.10.19.12.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 12:32:18 -0700 (PDT)
Date:   Fri, 19 Oct 2018 12:32:17 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     valdis.kletnieks@vt.edu
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
Message-ID: <20181019193217.GA181176@joelaf.mtv.corp.google.com>
References: <20181018065908.254389-1-joel@joelfernandes.org>
 <42922.1539970322@turing-police.cc.vt.edu>
 <CAEXW_YTS2n2tOpXs3eVQZhYu7tmM_at0ZBA-04qYkHw4UE80nw@mail.gmail.com>
 <118792.1539974951@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118792.1539974951@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:49:11PM -0400, valdis.kletnieks@vt.edu wrote:
> On Fri, 19 Oct 2018 10:57:31 -0700, Joel Fernandes said:
> > On Fri, Oct 19, 2018 at 10:32 AM,  <valdis.kletnieks@vt.edu> wrote:
> > > What is supposed to happen if some other process has an already existing R/W
> > > mmap of the region?  (For that matter, the test program doesn't seem to
> > > actually test that the existing mmap region remains writable?)
> 
> > Why would it not remain writable? We don't change anything in the
> > mapping that prevents it from being writable, in the patch.
> 
> OK, if the meaning here is "if another process races and gets its own R/W mmap
> before we seal our mmap, it's OK".  Seems like somewhat shaky security-wise - a
> possibly malicious process can fail to get a R/W map because we just sealed it,
> but if it had done the attempt a few milliseconds earlier it would have its own
> R/W mmap to do as it pleases...
> 
> On the other hand, decades of trying have proven that trying to do any sort
> of revoke() is a lot harder to do than it looks...
> 

No it is not a security issue. The issue you bring up can happen even with
the existing F_SEAL_WRITE where someone else races to mmap it.

And if someone else could race and do an mmap on the memfd, then they somehow
goes the fd at which point that is a security issue anyway. That is the whole
point of memfd, that it can be securely sent over IPC to another process.
Also, before sending it to the receiving/racing process, the memfd would have
already been sealed with the F_SEAL_FUTURE_WRITE so there is no question of a
race on the receiving side.

- Joel

