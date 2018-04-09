Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeDIQwR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:52:17 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:40845 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeDIQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:52:15 -0400
X-Google-Smtp-Source: AIpwx48FahEzM0OXMy3NUakOn+LEMzBC5wtZ44LB0wJDiEDktbJBn/sj6VZ4B3UNlnXVJvQm0eXcvv19vwFrgZDeEO4=
MIME-Version: 1.0
In-Reply-To: <20180409131021.5132-1-stefanha@redhat.com>
References: <20180409131021.5132-1-stefanha@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 09:52:13 -0700
X-Google-Sender-Auth: _1Tw3hgvuTV6BmskJ5P9d7zVCkE
Message-ID: <CA+55aFzJ_JPtU5SjAHHv--p3ZcAw4gVidxvrLLZF7w+kbHCNdg@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix vhost_vq_access_ok() log check
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>, KVM list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 6:10 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> @@ -1246,7 +1246,7 @@ int vhost_vq_access_ok(struct vhost_virtqueue *vq)
>  {
>         int ret = vq_log_access_ok(vq, vq->log_base);
>
> -       if (ret || vq->iotlb)
> +       if (!ret || vq->iotlb)
>                 return ret;

That logic is still very non-obvious.

This code already had one bug because of an odd illegible test
sequence. Let's not keep the crazy code.

Why not just do the *obvious* thing, and get rid of "ret" entirely,
and make the damn thing return a boolean, and then just write it all
as

    /* Caller should have vq mutex and device mutex */
    bool vhost_vq_access_ok(struct vhost_virtqueue *vq)
    {
            if (!vq_log_access_ok(vq, vq->log_base))
                    return false;

            if (vq->iotlb || vq_access_ok(vq, vq->num, vq->desc,
vq->avail, vq->used);
    }

which makes the logic obvious: if vq_log_access_ok() fails, then then
vhost_vq_access_ok() fails unconditionally.

Otherwise, we need to have an iotlb, or a successful vq_access_ok() check.

Doesn't that all make more sense, and avoid the insane "ret" value use
that is really quite subtle?

                    Linus
