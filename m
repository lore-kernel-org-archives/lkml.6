Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AG47ELs4+L56OjxveuK7/5/OpA2D32Zfy1q3lJdgqdkpfcGeyeuH1HfhJxh7BmAtpK3MYagFIdHG
ARC-Seal: i=1; a=rsa-sha256; t=1520376506; cv=none;
        d=google.com; s=arc-20160816;
        b=jZPABUCpO93vruNcSmh0mfL90wuqwekITfFxXYirgfLN97rA7Llj2yejXJDSdS50ar
         H8lqr5+RF1Bg5m06j847PVzSoZqi0SoVQgNN2XLVf9eZlUJICRTPIpK533nzB9ZUryu1
         ewT8zqEGz4kS5s5WbMyaI2waWZ0x2Mi4Z7JDCcqVz7g2Acaifj3y6q9gv74GYMz/uQ/D
         PV20iYpU0VPq5LlQ8q0S/67ArLc3MDtrr7GgCVImMMazBRyRKfjswDSDj9DN9/B+pzIV
         ykxwydrwJIMxyefzwy6ihoofUt3OpFZGZUv7LXErF6Q3Z05FoC96VcDo2z467nnAxaHk
         jrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=rZ+MWbcusjcb4byTvpxy+8cp+dix0uRbm1S8PhOTVL8=;
        b=Kw1aMq1g9l39Kb6hw+69UaKcZzu/kDxO8qqewG75/pTxVR24MMgygkoV7mXqbqVoiS
         tk6TWyqeXUwCSzKJrXJ0I3Udkh9M5nw9vygsm6Lz6ADRwYrqoaxKZ8vAcIxPdA83ScPy
         VzHAqFiVsUL/IHQQ96qU2wazA/QeQ+03UOAqs1GJf52Cggdhqz6O6c3DFzJPVBtZX4mh
         4uHUV6iaer/hoZY/GzHdaWujVzBz19+IXSU0yWm9uGFFU+b7H2hYTdharU6mq5j2bQcP
         P2Ny4fBlOl3Vo5JhWDF9I5C8rQG3E+YoCJ9jZ7WetBY2XzrNtHO9PB+0Dvkf0BeZaExT
         hH/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Tue, 6 Mar 2018 14:48:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 anthony.yznaga@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v12 09/11] mm: Allow arch code to override
 copy_highpage()
Message-Id: <20180306144819.53e794acc83309fd8b401e92@linux-foundation.org>
In-Reply-To: <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
	<ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031715838543761?=
X-GMAIL-MSGID: =?utf-8?q?1594230315402308593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Feb 2018 10:15:51 -0700 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> Some architectures can support metadata for memory pages and when a
> page is copied, its metadata must also be copied. Sparc processors
> from M7 onwards support metadata for memory pages. This metadata
> provides tag based protection for access to memory pages. To maintain
> this protection, the tag data must be copied to the new page when a
> page is migrated across NUMA nodes. This patch allows arch specific
> code to override default copy_highpage() and copy metadata along
> with page data upon migration.
> 
> ...
>
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -237,6 +237,8 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
>  
>  #endif
>  
> +#ifndef __HAVE_ARCH_COPY_HIGHPAGE
> +
>  static inline void copy_highpage(struct page *to, struct page *from)
>  {
>  	char *vfrom, *vto;
> @@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
>  	kunmap_atomic(vfrom);
>  }
>  
> +#endif
> +
>  #endif /* _LINUX_HIGHMEM_H */

It would be more consistent and conventional here to do

#ifndef copy_highpage
static inline void copy_highpage(struct page *to, struct page *from)
{
	...
}
#define copy_highpage copy_highpage

As is happening in [patch 07/11].

And a similar change could be made to [patch 02/11], actually.


Either way,

Acked-by: Andrew Morton <akpm@linux-foundation.org>
