Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF34C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9079C20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LqZn1tLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9079C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeKIS3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:29:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33061 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeKIS3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:29:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id w22-v6so658053plk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/hrbUm35PJ6nZfWdm8oo3/XINMe68XP0KMb7dR8xDI=;
        b=LqZn1tLpeg5592FM9YEnqXtA3xZpTqiB6IcNGqAAsyadn83l2+VfaQu4sdVeBJpKtz
         kCwN5wAQEGRI1Xrl7hLcShwVOMG3l23FQTyf7fHWc0Ab/YZPdyRFO4QxXHJ5SWIbqNnq
         DKpFIYTngk8clLF3D+vMZTHf4S/dPj89jZS/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/hrbUm35PJ6nZfWdm8oo3/XINMe68XP0KMb7dR8xDI=;
        b=LoUEpvZkZt6gWsnJ4iEv6ckNjXsJp9kLgiRsBLNQHoFvltCMx5JocVFQ/E09w6XykM
         JSRA0Zetja4QLuECjBBsGthzDdx37QBBbilVAWwf6y4PcmwAjy9F2H7mtQtRmDb0LKI7
         2pvr/qxQe36713iKp2ymmdscQQatQjcgpCk/WPG7veoB4XME91+7hLFo3O1elCRwAE2Y
         PwIUurY5Q4EvH1/vnjDmcwpi++RDhbR0gWc1zZyedDafwKDcjUm55xl6t756p1qv7ORn
         mZrqadCBHds+M9Lp1mUWffzRJ53k2K52UTgHtvxR01PiCpb53tABaA3OfDTbbhds7nd+
         0qAw==
X-Gm-Message-State: AGRZ1gK6LsGFJaK+5OqF0MJY7dd43rnlDjcavYvjhXh9tOCwjSp5LFTM
        zVKtlkJsfbPxf44UIvJwlPoVJlvQ2xU=
X-Google-Smtp-Source: AJdET5dhfSVnqjXLCi7EwC3vUhic4PX4u/fKZvBhOfrnGK/Gm10ovPHGKwgJC60x38Aey1was4wcNQ==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7-v6mr5078510plk.86.1541753370499;
        Fri, 09 Nov 2018 00:49:30 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id b5-v6sm5754812pfe.60.2018.11.09.00.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 00:49:29 -0800 (PST)
Date:   Fri, 9 Nov 2018 00:49:28 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, hch@infradead.org
Cc:     jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Lei Yang <Lei.Yang@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to
 memfd
Message-ID: <20181109084928.GA37614@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108041537.39694-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 08:15:36PM -0800, Joel Fernandes (Google) wrote:
> Android uses ashmem for sharing memory regions. We are looking forward
> to migrating all usecases of ashmem to memfd so that we can possibly
> remove the ashmem driver in the future from staging while also
> benefiting from using memfd and contributing to it. Note staging drivers
> are also not ABI and generally can be removed at anytime.
> 
> One of the main usecases Android has is the ability to create a region
> and mmap it as writeable, then add protection against making any
> "future" writes while keeping the existing already mmap'ed
> writeable-region active.  This allows us to implement a usecase where
> receivers of the shared memory buffer can get a read-only view, while
> the sender continues to write to the buffer.
> See CursorWindow documentation in Android for more details:
> https://developer.android.com/reference/android/database/CursorWindow
> 
> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> which prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active. The following program shows the seal
> working in action:
> 
[...] 
> The output of running this program is as follows:
> ret=3
> map 0 passed
> write passed
> map 1 prot-write passed as expected
> future-write seal now active
> write failed as expected due to future-write seal
> map 2 prot-write failed as expected due to seal
> : Permission denied
> map 3 prot-read passed as expected
> 
> Cc: jreck@google.com
> Cc: john.stultz@linaro.org
> Cc: tkjos@google.com
> Cc: gregkh@linuxfoundation.org
> Cc: hch@infradead.org
> Reviewed-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2: No change, just added selftests to the series. manpages are
> ready and I'll submit them once the patches are accepted.
> 
> v2->v3: Updated commit message to have more support code (John Stultz)
>  	Renamed seal from F_SEAL_FS_WRITE to F_SEAL_FUTURE_WRITE
> 						(Christoph Hellwig)
> 	Allow for this seal only if grow/shrink seals are also
> 	either previous set, or are requested along with this seal.
> 						(Christoph Hellwig)
> 	Added locking to synchronize access to file->f_mode.
> 						(Christoph Hellwig)


Christoph, do the patches look Ok to you now? If so, then could you give an
Acked-by or Reviewed-by tag?

Thanks a lot,

 - Joel


>  include/uapi/linux/fcntl.h |  1 +
>  mm/memfd.c                 | 22 +++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 6448cdd9a350..a2f8658f1c55 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -41,6 +41,7 @@
>  #define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
> +#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>  /* (1U << 31) is reserved for signed error codes */
>  
>  /*
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 2bb5e257080e..5ba9804e9515 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -150,7 +150,8 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
>  #define F_ALL_SEALS (F_SEAL_SEAL | \
>  		     F_SEAL_SHRINK | \
>  		     F_SEAL_GROW | \
> -		     F_SEAL_WRITE)
> +		     F_SEAL_WRITE | \
> +		     F_SEAL_FUTURE_WRITE)
>  
>  static int memfd_add_seals(struct file *file, unsigned int seals)
>  {
> @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
>  		}
>  	}
>  
> +	if ((seals & F_SEAL_FUTURE_WRITE) &&
> +	    !(*file_seals & F_SEAL_FUTURE_WRITE)) {
> +		/*
> +		 * The FUTURE_WRITE seal also prevents growing and shrinking
> +		 * so we need them to be already set, or requested now.
> +		 */
> +		int test_seals = (seals | *file_seals) &
> +				 (F_SEAL_GROW | F_SEAL_SHRINK);
> +
> +		if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
> +			error = -EINVAL;
> +			goto unlock;
> +		}
> +
> +		spin_lock(&file->f_lock);
> +		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> +		spin_unlock(&file->f_lock);
> +	}
> +
>  	*file_seals |= seals;
>  	error = 0;
>  
> -- 
> 2.19.1.930.g4563a0d9d0-goog
