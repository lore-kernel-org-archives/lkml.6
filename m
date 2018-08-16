Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C21BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217A20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I9s5mNBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F217A20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeHPVCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:02:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34638 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHPVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:02:22 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so4617846ioj.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPeUFRW/VdXSXW8yK74dLbs4SyNl0OXwUUXDsB2cd1o=;
        b=I9s5mNBxN6VgBLEuUimAbOepYvwPPzrFS2OjiBRiy8YL7yMUo+z9HixLEaWn9tpO9+
         aItvX1asJzNNpYNDXSVYtOTso80KFy5Fscf81BFx56HLpPnuK5nA6AOnU2h3QK/b077t
         BLdta2FLRaaBGdwJdB0oCIjCe/0nX3zrnSGQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPeUFRW/VdXSXW8yK74dLbs4SyNl0OXwUUXDsB2cd1o=;
        b=RHw4Tao7KQtyCxTt62ZlryyPuvuNj5beYvaalsY9GUfeYLNNngtIHQjtpM3OfY/a0s
         sRsjZL4bGbHc+EBzxcB9BC+YmF5kjeU1QOHbA25beUP8PKmdAjPikxXZH+rARh1laQ0f
         E+RjabuHRjsXBL5dnXkwXA+QNLvuqmuYgcbZZhtXqwQL1HABAbXs2HUqtWZcYucug1zC
         NmOgGjp+GO5JCBOQpozTNkgEIEkybRjM+P6WAB3uVaZtSFLJW7kPgMf+O/WOU+gDVyCw
         MAFAOoq+AfKfTleT1jLbKYT/jt3qQtE6Yy5VVA9UmVFevNantLBJe5m4LRgDrUJCB9xk
         z+Sw==
X-Gm-Message-State: AOUpUlG1a9I+V6IM1JByd8rvQzEniRJBag9aXyDRh/anrvicdnqjghge
        JBQta59/iP2lZzNbuzxlQhn8B5PN182olKfScDs=
X-Google-Smtp-Source: AA+uWPzXAgyy0CGqvbJ+rY50FsDGPbNooS9dORIDlMCziRGRUeHal34lXN8P0gvjuAMoPFBjhbfs4SVZtt2ufZD50dE=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr22609787iom.238.1534442545363;
 Thu, 16 Aug 2018 11:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
 <20180815194244.29564-1-yannik@sembritzki.me>
In-Reply-To: <20180815194244.29564-1-yannik@sembritzki.me>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Aug 2018 11:02:14 -0700
Message-ID: <CA+55aFxTzYDbMPFKSG25A=fO7-nzp6hwJRaeu45fzyh0JMYoiQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix kexec forbidding kernels signed with keys in the
 secondary keyring to boot
To:     yannik@sembritzki.me
Cc:     David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:42 PM Yannik Sembritzki <yannik@sembritzki.me> wrote:
>
> I've written two patches for (a) the logical change of allowing kernels
> signed with keys in the secondary keyring to be kexec'd (b) the refactoring
> of the magic 1UL Linus requested.

Just coming back to this original submission: I've applied the
slightly modified version of this series from David Howells, so it's
upstream and marked for stable now.

                  Linus
