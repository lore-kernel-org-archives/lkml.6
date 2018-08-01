Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9784E20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs5oMPYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9784E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbeHAUXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:23:39 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33383 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732878AbeHAUXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:23:39 -0400
Received: by mail-pg1-f182.google.com with SMTP id r5-v6so11242560pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xizb0a9z96+agddiSCaFJC89kOdfUDqfSyHP/B0nzLI=;
        b=fs5oMPYL/y5gby8cMvCPDYvKe+afJ6iNhQ9KQ3T50BMnGERbgY4pvXejJFQwHYFXxG
         yr5gZiWrgcOEbS9qmK5pKpWmnRki0MHFLhyyLc9KP5fSUlu3uWdsBfKSibgHiDzBr4SU
         QC+UehepUqD+CCtBIlAhHVbDFGeg9P6WmzuqDEF7Y/WBU0gaOIu7YBkj4Nbprl7X5O1K
         ou0mGAU9OJ+M7d86T8BORKz7jP8+W3XEneYC2dMLOVIwOw78FNPEcZbrJUAVGT3F8Gjw
         Q5PO/fs3t2mM3xUWNCLX7r+3G+0fIDxfq31wp4CD6MoObhHkikjLpAZBvjogIkldXp67
         4AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xizb0a9z96+agddiSCaFJC89kOdfUDqfSyHP/B0nzLI=;
        b=TumrQ+TQM1I4wu1jrKu6UuAy7ag/kNI82+5y3TjrFCVUlUFbJYLDyMhSS6aIHrw0t0
         lNzEQQbcyRXIOunFmsUfLIUdvK+fYrmv5nfjIcJVlFOsE0DNpRyIyOaDvoMsTi2PyQVl
         +yEv1jME11ssxW+HM3AWP5PBMZYuF4nvJeIvwjZVr27pklkIdU+9h3q4lEOO7RH94+dk
         EWEx4k1BP0PAl3uc5yAAZrjDy6ItUlEEzVyIbAGJ3NtfZId5sCBsibrdELnOq1werXNB
         vGgj5xBohBraJk9QFXctioROgSN3FobutfWyJKdAay8YH46eTZ/GpwkBQYkmSOhYCU9e
         VQ+g==
X-Gm-Message-State: AOUpUlFnAoKksqkk1L55B0UrwaG6FE/75CgmA47qHBnro3q9ZS1qQsVj
        uX/gupdv79XfOaJhvvWh12ObL/ej09UTwIadEpv71LVkP6w=
X-Google-Smtp-Source: AAOMgpdPvRPwSlMUcSOUG+Y8wKthx+KZio2ztegN2xnFJaoUP4pnhBdttqdp5qt8xBfoQxs1SvjigodbhbXjceQyAuw=
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr25350922pge.75.1533148594971;
 Wed, 01 Aug 2018 11:36:34 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Aug 2018 11:36:23 -0700
Message-ID: <CAKwvOdmuXvM0qF0zy15Q9yfCUNr+Kd4jDTcERWg1R-R2zDNuTA@mail.gmail.com>
Subject: get_maintainer.pl and change of email
To:     joe@perches.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that get_maintainer.pl will make recommendations based on
commit history to a file, but over time, people change emails that
they commit from, then get_maintainer.pl recommends the possibly now
invalid email address.

I feel like we should have a look up table / file like MAINTAINERS
that tracks previous and new email addresses, which get_maintainer.pl
would parse, that way we have a record of movement between committer
email addresses allowing get_maintainer.pl to make more accurate
recommendations.  Thoughts?
-- 
Thanks,
~Nick Desaulniers
