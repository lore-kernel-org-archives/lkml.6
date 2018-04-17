Return-Path: <James.Bottomley@hansenpartnership.com>
X-Google-Smtp-Source: AIpwx4+WrbalGJHJxrSwZuffUT4bSRbOyoIL5K0APM+dRJybja0NLSAUQBkWm1qxpvhvzmm89OKa
ARC-Seal: i=1; a=rsa-sha256; t=1523957861; cv=none;
        d=google.com; s=arc-20160816;
        b=UWAlbRCUdwO18M1sdSo8GBX0HEWwKsAnYxv3rMj4EQvQRFKGbsMlWmThsF8TJyW7Gm
         FxVTEGKfMaDxmjE1bsuw5ZfDxVf1XvNTLTNtyhHb56Nr00M75LRNniaFZ8HeHjXcbhDP
         KpfRleEJKVYWZ2UcuDxZ9q2Wij5TnAoPV+Y6JgN8svGO8HaA3m5frDQxHhSx2l7BcoE9
         n+j7GlnQZa3+0QwAbrrII99ySSHMKoR+ucouvxKyv8lh8FfSKf8VP6/ZtCejUgqCxtvi
         lkVTf+gUfI02d6fqdCCCShn5jA5sK5SsdD8dSpAkwxVH98wJpHkJqpQgQYAc6xRYNH3k
         fGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=UK5bb8EyfWXjDtATuvP+QjzAPzEV8g9ERey1tU0DL14=;
        b=xU6qfv5UEAMZYAXLpHUjB9X8cGRjnkCpoDt1w/nrZcPOzeAOzmKkE1+MqLvNJoiwT3
         6bIUqFw1h3O9uECOrJVQ+ndRUTjb/wvZIuEKS1F+15JVaGKPY01uxNJOfy/VAeFCZHsg
         M4Utagq4T1T7ZQ+HCKfoOdntB5gq1Sy66VYadTXkG0GYa3jJ8wNrq9sH/ifVP/95F9gZ
         8IrbguZARv7MHGf32inltOsqCvKWxQvkpJc/BSISrXLjI+dt642WnW1LaFh10mxqM/d7
         szMgysSHnj/GXbndpcOAJzZtgAtDRBjFJs9DwJ5dQHGiyO7otS3EwUUcjq1XIOvvMtw/
         dxfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=iKx2ENFV;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@hansenpartnership.com header.s=20151216 header.b=iKx2ENFV;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Message-ID: <1523957852.3250.9.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-parisc@vger.kernel.org,
	arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Helge Deller
	 <deller@gmx.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart
	 <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2018 10:37:32 +0100
In-Reply-To: <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
	 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964966697704374?=
X-GMAIL-MSGID: =?utf-8?q?1597985637958086020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-17 at 00:08 -0400, Sinan Kaya wrote:
> parisc architecture seems to be mapping readX() and readX_relaxed()
> APIs
> to __raw_readX() API.
> 
> __raw_readX() API doesn't provide any kind of ordering guarantees.
> commit 032d59e1cde9 ("io: define stronger ordering for the default
> readX()
> implementation") changed asm-generic implementation to use a more
> conservative approach towards the readX() API.

I don't follow your logic here.  function calls (even inline ones) are
sequence points and the compiler guarantees volatile variables are
stable before sequencing, so these two rules strictly compile order the
raw_read/write because the address is volatile.

> Place a barrier() after the register read so that compiler doesn't
> optimize across the regiter operation.

barrier() provides exactly the same guarantees as the sequence
point/volatile already above, so it seems to be completely unnecessary.

Perhaps if you gave an example of the actual problem you're trying to
fix we could assess if it affects parisc.

James


> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  arch/parisc/include/asm/io.h | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/io.h
> b/arch/parisc/include/asm/io.h
> index 2ec6405..e04c4ef 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -179,19 +179,34 @@ static inline void __raw_writeq(unsigned long
> long b, volatile void __iomem *add
>  
>  static inline unsigned char readb(const volatile void __iomem *addr)
>  {
> -	return __raw_readb(addr);
> +	unsigned char ret;
> +
> +	ret = __raw_readb(addr);
> +	barrier();
> +	return ret;
>  }
>  static inline unsigned short readw(const volatile void __iomem
> *addr)
>  {
> -	return le16_to_cpu((__le16 __force) __raw_readw(addr));
> +	unsigned short ret;
> +
> +	ret = le16_to_cpu((__le16 __force) __raw_readw(addr));
> +	barrier();
> +	return ret;
>  }
>  static inline unsigned int readl(const volatile void __iomem *addr)
>  {
> -	return le32_to_cpu((__le32 __force) __raw_readl(addr));
> +	unsigned int ret;
> +	ret = le32_to_cpu((__le32 __force) __raw_readl(addr));
> +	barrier();
> +	return ret;
>  }
>  static inline unsigned long long readq(const volatile void __iomem
> *addr)
>  {
> -	return le64_to_cpu((__le64 __force) __raw_readq(addr));
> +	unsigned long long ret;
> +
> +	ret = le64_to_cpu((__le64 __force) __raw_readq(addr));
> +	barrier();
> +	return ret;
>  }
>  
>  static inline void writeb(unsigned char b, volatile void __iomem
> *addr)
