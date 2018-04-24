Return-Path: <mst@redhat.com>
X-Google-Smtp-Source: AB8JxZo27P+FnvIv/7n8c2IeiZP3FotLiuVl68ZqKPK8zPOjLyAqYvGT4oZo4dun/Lm0EZJaek2K
ARC-Seal: i=1; a=rsa-sha256; t=1524595290; cv=none;
        d=google.com; s=arc-20160816;
        b=qwl5xh2/ZbiwYFJ4O9qecrEwpiOtnXNfSOzGsNqlYpgJ9oaO6SjuUXIuknLrth40Xo
         mBFN81WwhUxQIW2fLAnWg9xmOVp2FX4eJBdpVXiuX5SSe70uyBe/fxm63Z4W9CdETOlh
         ryqO4GKTR1hfWVFioe3BnmyoOJgacsp+MCKNe3lpGiWpOMXVT5fSo7IQWoOfxKaLS15K
         kBwF5XlwRwQD3u6CR1z1geJdaURVdC05TPA6t7VQg0pJXJe/GOUWcrTpuXL5IUsjNlsS
         UjiBzAEjXLLA3hNCVrJLuJqRCoK8ySw5TNWYkTsskl0vgfEMoaK0hlDs2LG2EKkXo6W+
         uBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=15ZfaUiucTR+c8Oddf52N2P819/vJO3A6WZb/6XgZB8=;
        b=ab2u3Vvh6eL63ZqAodXm/PiAOwQM7c+sMx6Wyz/jFciNiRAQ8ORAKQIxzu+TI3nM+l
         PblCDbKu71Ey/i1QkMhgy6j+aooTOhPza2xbwmJiBC7fMbxKbItXVx/+ees8n2vKx4mW
         cem6LzkfIcHKsu0g1sXvzJJUm4E7YS9FKLMrtxEvp4lKeQDHeljFSYOmIn/jLcUrKo+a
         nV36sP+IE3x8oUh4ChcTlHxFnBt5lRHZJJJDcSnu9neXMp3J+gFbGgBL0nBz9c+GJX1W
         LnJe66ABHt/81wSrENs2RSpXETcNPeLO6z1mEvwHC0bWrL+gfvOvNoTu7I7huTNpj1At
         +zOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 24 Apr 2018 21:41:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <20180424214104-mutt-send-email-mst@kernel.org>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290166308217501?=
X-GMAIL-MSGID: =?utf-8?q?1598654030967462898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> Turns out virtio console tries to take a buffer out of an active vq.
> Works by sheer luck, and is explicitly forbidden by spec.  And while
> going over it I saw that error handling is also broken -
> failure is easy to trigger if I force allocations to fail.
> 
> Lightly tested.

Amit - any feedback before I push these patches?

> Michael S. Tsirkin (6):
>   virtio_console: don't tie bufs to a vq
>   virtio: add ability to iterate over vqs
>   virtio_console: free buffers after reset
>   virtio_console: drop custom control queue cleanup
>   virtio_console: move removal code
>   virtio_console: reset on out of memory
> 
>  drivers/char/virtio_console.c | 155 ++++++++++++++++++++----------------------
>  include/linux/virtio.h        |   3 +
>  2 files changed, 75 insertions(+), 83 deletions(-)
> 
> -- 
> MST
> 
