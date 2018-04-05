Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDEQ27 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:28:59 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:39773 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:28:57 -0400
X-Google-Smtp-Source: AIpwx4/5CbAZw43lIufHqSCMpkqspWxG/0MXpat5yx8loyJBTHDfoD6eG1kRdXJiGk3JogCaPPLLzeyVWJlmkTRnW60=
MIME-Version: 1.0
In-Reply-To: <20180405105103.21572-1-christian.brauner@ubuntu.com>
References: <20180405105103.21572-1-christian.brauner@ubuntu.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 09:28:56 -0700
X-Google-Sender-Auth: QKXy-w4nx0FK9S7edjtAfRBwrF0
Message-ID: <CA+55aFzb7xzsOb=vfrwDFTX0SToOe1esgj2B1YNMPTDPUa8Nnw@mail.gmail.com>
Subject: Re: [PATCH 0/3 RESEND] namei: add follow_up_bind()
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 3:51 AM, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This series adds:
> - follow_up_bind() to namei.{c,h}
> - switches fs/nfsd/vfs.c:follow_to_parent() to use follow_up_bind()
> - switches fs/devpts/inode.c:devpts_mntget() to use follow_up_bind()

Hmm. Seems fair enough to me, although I wonder how much this really
helps. It does get rid of a duplicate code pattern, but:

 4 files changed, 14 insertions(+), 5 deletions(-)

and while some of that is just the new comment, some of it is just "overhead".

It's also a bit odd how the new helper is marked "inline", but nobody
will inline it because it's not actually in the header file or any of
the isers in the same C file. So instead, it has to be exported. I
wonder if it should just be a trivial inline in <linux/namei.h>? Maybe
it originally was, and that's where the inline came from, and then
Christian decided to make it be by the regular "follow_up()" instead?

But with all that said, I certainly don't *mind* the patch series.

Al, I'm leaving this up to you, and expect to get it from your vfs
tree eventually. Or not.

                      Linus
