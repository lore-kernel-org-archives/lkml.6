Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32819C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0290214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K2cwcv4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0290214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKVHJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:09:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40693 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKVHJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:09:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so6014819lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQUyLosFc/cUF/ZtjuPJH0R+q97KSyYSIRBaBbpS6Hs=;
        b=K2cwcv4RC4r8RI6AUsAwmA1WAY2dfEReG4WDaT8AVqxYYSmeSTL7g4IhakaiXeOUeY
         xuaCO8PKK2gNRj0fRqsRFMDpw9FJnOTrJ6hsCQC9CdBl79P14Ul6bhF+jzneUkzqWUZK
         BRhA+7CpCQHQ2x7QSgu/bdAEWuTQgeVXvDcpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQUyLosFc/cUF/ZtjuPJH0R+q97KSyYSIRBaBbpS6Hs=;
        b=NhRuEvOrBfOYsAeF30wlKPQx5ApNQV0rduiv+p6iJXC8OOE1CWbVXWa9ffRhT1v0WT
         SB6HLmcloFzWqJNDGpo5XjSgdbj2lXkf9njfJF+wZFt3eWBWGf2CAgRS6E0VB9ckpd+m
         UYQQ+6ihlp+/SYNsju/ZL56wzpYAcb4owNtIkMuJJEh5ECaIkwDTUeZ+fJiuvQb/G6ta
         xoMkT5JdDc/M5iN5h+s2QE9g2kBUT74LDmm3/yG2U/MAosibw6DSHzTWrbOkYlIhQaSK
         fQKGi1H55ugtVUZhNRKV8ff2vACp6QLA+O2jYLQzcdo0CsIJTZhW9C3QjN+iT9/OPiCk
         4eWQ==
X-Gm-Message-State: AA+aEWbwyfhE0emIi/QJNAATh3xyR9AicDQSYht89LvdiCt0qljH7b5I
        Nc+F6sHRkcmEJ4b+aCg04VjSEQl9LC8O4A==
X-Google-Smtp-Source: AJdET5cGb+hj5y4odBX/IImrrI9Y2QnKSeLdITkBOTeYHq8ug6SDK0WXZ5BcnvMX9mhXCcZPd5a2QQ==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr5483279ljj.158.1542832420046;
        Wed, 21 Nov 2018 12:33:40 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s3-v6sm7054390lje.73.2018.11.21.12.33.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:33:39 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id e5-v6so6015379lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:33:38 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr5596337ljk.80.1542832418178;
 Wed, 21 Nov 2018 12:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20181121201430.559770965@linutronix.de> <20181121201722.337599561@linutronix.de>
 <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
In-Reply-To: <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 12:33:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
Message-ID: <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
Subject: Re: [patch 01/24] x86/speculation: Update the TIF_SSBD comment
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ugh. Now you're using the broken quilt thing that makes a mush of emails for me.

Reading the series in alpine makes it look fine. No testing, but each
patch seems sensible.

And yes, triggering on seccomp makes more sense than dumpable to me.

               Linus
