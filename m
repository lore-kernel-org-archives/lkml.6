Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbeCITrr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:47:47 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:32845 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbeCITro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:47:44 -0500
X-Google-Smtp-Source: AG47ELtI+4sp7gD2qEqb+9s/zyQZwQ1essj++8pMlP7dT0O9WXLE5gxvxX3Ekqyv9MfKvt6yy/UIuC3MDi4HuvrSJAs=
MIME-Version: 1.0
In-Reply-To: <20180309193020.GA5149@beast>
References: <20180309193020.GA5149@beast>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 11:47:43 -0800
X-Google-Sender-Auth: 1L1s7qshL6RHBxDma6iS1bN5OEI
Message-ID: <CA+55aFyp4Lvz8QVckBr+zp4OfB1VaFNb2J1s0-xEMA9h44c0UA@mail.gmail.com>
Subject: Re: [PATCH v2] exec: Set file unwritable before LSM check
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 11:30 AM, Kees Cook <keescook@chromium.org> wrote:
> The LSM check should happen after the file has been confirmed to be
> unchanging. Without this, we could have a race between the Time of Check
> (the call to security_kernel_read_file() which could read the file and
> make access policy decisions) and the Time of Use (starting with
> kernel_read_file()'s reading of the file contents). In theory, file
> contents could change between the two.

I'm going to assume I get this for 4.17 from the security tree.

Because I'm guessing there are actually no existing users that care?
selinux seems to just look at file state, not actually at contents or
anything that write access denial would care about.

And the only other security module that even registers this is
loadpin, and again it just seems to check things like "on the right
filesystem" that aren't actually impacted by write access (in fact,
the documented reason is to check that it's a read-only filesystem so
that write access is simply _irrelevant_).

So this issue seems to be mainly a cleanliness thing, not an actual bug.

             Linus
