Return-Path: <sumit.semwal@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524486297; cv=none;
        d=google.com; s=arc-20160816;
        b=j8jJewFJBnhJfySnNTnhJt29QXzquqqqg1vrCrQN2GC/ZlJ57HAwsp5PAfcatNY4uz
         I25iZyFnw7lM6rPbo3HPfsXWh0bOY6W4R7vmELI+riGvvdS09pnjc7KQy5lEOly/If/R
         I2VQUPfWa8BGgttHAsXKw8zurtwr1QR30+pmK+EDuOr82ObYLoHu6SgKS5bX3zTd/mL2
         O7XBG9lmcLA3hjXYAihC1YzEs8hFvo1Vb4Tt7nUkhNgwXVZ1X5Omy9TA4OdoyyMccIvv
         KheeTE3hEE9PD84lASUd/2Dx/ch8e0k4TeodpkDINXKwQ4hNNfdQQzyE7hQG38yEChFu
         95Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nistJfyYmBAF7ETd3BVfDFlS/wxJPkH7vavrmYMR6gI=;
        b=FNZdBxti7YC6cYjWuzLeIys//46tzREiYXebftJIvErNxryMJaex6RSNr6TLiVIs7V
         UlgQ+cCCooNflym33759JfOnQnPlgrAF6Ucd4yxh+zdO8XQZgR9uCIIsAVAUlDXsvdwI
         5lIcsWJ1i/73k7mceZ2u5SFymmyK0zZ7hvHc/mZBkjj3zDsQxh/WxE9qCejWyvAnXGk/
         tluM8FyUK8ir1o+DVxHdoAvMXQk7UXcA1JgODRHQeSIwu9ZUo9XRtKdmVa2DoxW2U68e
         ZNTewF6l78By8g2YetjmA00h1yWO4zwAiBKgN9rFkiUWnLB6emrg7aTPTTbgOQkV5r18
         6sJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N74GNuqF;
       spf=pass (google.com: domain of sumit.semwal@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=sumit.semwal@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N74GNuqF;
       spf=pass (google.com: domain of sumit.semwal@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=sumit.semwal@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48GBjeHgfV24XWZWEnTvFQSdD4B0X6Y73Y1ghPaNub/yXBmXocTfcMkvpxa4CVY6lxEhC9LQYTwR2cNFhtSLPI=
MIME-Version: 1.0
In-Reply-To: <20180421025629.214879-1-toddpoynor@google.com>
References: <20180421025629.214879-1-toddpoynor@google.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Mon, 23 Apr 2018 17:54:36 +0530
Message-ID: <CAO_48GFyt66PhFw2tXjy9bkHiA_1fKdw7vtqPxeZ49tFPt83ag@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ion: remove duplicate buffer field initializes
To: Todd Poynor <toddpoynor@google.com>
Cc: Laura Abbott <labbott@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598322949283532026?=
X-GMAIL-MSGID: =?utf-8?q?1598539744512121407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Todd,

Thanks for the patch.

On 21 April 2018 at 08:26, Todd Poynor <toddpoynor@google.com> wrote:
> As a result of various previous patches, ion_buffer_create() now
> has two sets of identical statements for initializing two fields of
> the buffer struct, next to each other.  Remove one set.
>
> Move the initialization of these two fields together with the
> statements that initialize the other two fields from the function
> parameters, prior to the heap allocate() call, for consistency.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

> ---
>  drivers/staging/android/ion/ion.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index e74db7902549..269a431646be 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -74,6 +74,8 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
>
>         buffer->heap = heap;
>         buffer->flags = flags;
> +       buffer->dev = dev;
> +       buffer->size = len;
>
>         ret = heap->ops->allocate(heap, buffer, len, flags);
>
> @@ -93,11 +95,7 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
>                 goto err1;
>         }
>
> -       buffer->dev = dev;
> -       buffer->size = len;
>
> -       buffer->dev = dev;
> -       buffer->size = len;
>         INIT_LIST_HEAD(&buffer->attachments);
>         mutex_init(&buffer->lock);
>         mutex_lock(&dev->buffer_lock);
> --
> 2.17.0.484.g0c8726318c-goog
>


Best,
Sumit.
