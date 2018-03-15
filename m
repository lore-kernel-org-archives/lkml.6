Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeCOAJS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:09:18 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35708 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCOAJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:09:16 -0400
X-Google-Smtp-Source: AG47ELt2eF8bupoGgsXgZBMODzt0QG++mnvYmb4fHxFQ8a2j7ZiLqc5TBcxKNyuckJCJVRMY4JSBZjfV/ZAnGq5nYl0=
MIME-Version: 1.0
In-Reply-To: <1521070116.4508.94.camel@HansenPartnership.com>
References: <1521070116.4508.94.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Mar 2018 17:09:14 -0700
X-Google-Sender-Auth: KydR_Gb-aYfcpnwg1dEGSsJykKA
Message-ID: <CA+55aFzRss7BfRbLW8fsO5mRhj5obX9sg2ebkNSp5G68VmpWvg@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.16-rc5
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 4:28 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> -       vfree(ha->optrom_buffer);
> -       kfree(ha->nvram);
> -       kfree(ha->npiv_info);
> -       kfree(ha->swl);
> -       kfree(ha->loop_id_map);
> +
> +       if (ha->optrom_buffer)
> +               vfree(ha->optrom_buffer);
> +       if (ha->nvram)
> +               kfree(ha->nvram);
> +       if (ha->npiv_info)
> +               kfree(ha->npiv_info);
> +       if (ha->swl)
> +               kfree(ha->swl);
> +       if (ha->loop_id_map)
> +               kfree(ha->loop_id_map);

Why? This part is just garbage.

I've pulled it, but I don't see why (and how) this kind of garbage got
reviewed and acked by multiple people.

Both vfree and kfree are perfectly happy with NULL pointers, and there
doesn't seem to be any structural reason to have the test.

There *can* be valid reasons to do those kinds of things, if NULL is
the common fast-path case, and you have profiles that show that the
cost of just the call is noticeable. Then you probably also should
have an "unlikely()" there to document that fact.

But this is not one of those cases. This is just garbage and generates
less legible code.

                          Linus
