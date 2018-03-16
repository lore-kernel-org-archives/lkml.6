Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtUJIV8FWcUq82YsMhRo+Gl6os5uBLnVskQBxYKT5mEAIqPjTe7fYa6g6FnJlgXMByuPhbE
ARC-Seal: i=1; a=rsa-sha256; t=1521187004; cv=none;
        d=google.com; s=arc-20160816;
        b=EVgFmH2rOLxADKC87B1UQOh5Sbf0kYKxwZV5ylS3aiPwMrhGK+3tDSAQplPU3EBwIe
         M08YGhfCXw7NsxNreMDh1Hy/Ilmz0QQlOkvbuXhOZlDxv/Oc3fHLe8UNhxWLZ19AddJK
         kluNkx5nPelKzh0ClopS4qshoK0FPxDGaLy+7FHYtbNEEQry8kFm/EQWx8N9y2Pktwsx
         JhXuUvC2ReJ7bP6n67nmXUCKjTGfCsU/dQO5SLi1r+kIz7XICq/iIGtL7mwzegG7Uv+Y
         LCyyRRBaVmV+M10Liu2QL0GpYsjP/nHCkN9IEK9890KOLytOVlyIGCFMqQ3VB7TQAew4
         3/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=6F+Ls5lePzrZl4+n/YK67UQyxbWtvOo1KId6dPpMk08=;
        b=CIik/K/y4dKaIRQCIQMxo4mkLeVhM1MyoPoA63mBmI2fsKC/KzmyqILWpC/9lJl+Jh
         Sy4qMRxQvFL6SG8SCR3h5kf2s9NlMLpq7aeyf8VXDk9PNxvZRzft+Y3qhqanGk8SBVMH
         4IIkFEJSkUrMw8/aD/ehaVa8mopET6fxXzYsifhj6I3VRjjeMkBIKupnBr78mpalCjtK
         q/vLK5WjpHyUZIiP3Cj+YPoC7vi01XW5LVL5oOe+ge/jOsQxB3Gm1TqfvaF+ARz+rwzP
         10+eMikYHZXj+/oRCCyvKZhEXfb8DHeYFSuXUg7M41o8hx7mWV92QYQFhyFqL9r2G975
         J0MA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeCPH4n (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 03:56:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeCPH4n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 03:56:43 -0400
Date: Fri, 16 Mar 2018 08:56:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, qemu-devel@nongnu.org,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK"
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] Add udmabuf misc device
Message-ID: <20180316075642.GB11982@kroah.com>
References: <20180316074650.5415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316074650.5415-1-kraxel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595079572079958094?=
X-GMAIL-MSGID: =?utf-8?q?1595080184286509377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 08:46:49AM +0100, Gerd Hoffmann wrote:
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -0,0 +1,69 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <malloc.h>

No license text at all?  Come on, I already made one commit in the tree
that touched 11k files, I don't want to have to do it again :)

thanks,

greg k-h
