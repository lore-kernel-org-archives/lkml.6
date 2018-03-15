Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELsFRvpIj4I9N1uRpy8e5RJ7g1tnBuBocqNr1F6ycSPpKa72XSXap46Bq9ptkcJvSb176Ybs
ARC-Seal: i=1; a=rsa-sha256; t=1521127014; cv=none;
        d=google.com; s=arc-20160816;
        b=LTeEAc1GpwphV63I4LLWohWvPtGUgeoWMWyrItQwZ0Q1YletVMN2R/A8yEkFOj3bhE
         JDXBazaMWEzZULy+iO383nkn8UMial4BsvCt85fefyAjkooAcAO5im/TeDpj2h5E77PT
         Lf0gLhJih9edngudUWIdVQsCjcN5ryQyhvkhxbBlMNazn/xJaON2vitI/gIlj3NmIxiG
         b116+IxGH2tB1FcAu8L+EPpedMwT8thiUV5wCKmtYKq1rrYfYK4P9HyxTAUr0pXbzkrB
         DnUdLVzdHnnCM2C24J2zel+x5alcz4oev1SNihlDIbt1u8Y01otmv3TiHVp8xge7jNO8
         muOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=o7ovj11H8aNDWMomcoVi1NabrXd3z3N9H6WaxCKJuro=;
        b=eTCmUkDj9wm9TheNq5Q+qS7xzzQiYF8w8Rl5JcFLGzt+rgehm/hKz8OhCh+/ZfnRIG
         6OB3luo9pzRKAKkzVPnIyyI5bPRLxL//twnohCiqdOHZIUX1YGSVMZr7K2KOlEvTgv2y
         0f4l2XuWOOe+4ICuFZ3NiQhNNDdPYG6Jzo3nrQRJSFU2iECbxe60E2TefiOAuJEKy99B
         B6RWMMs6p6+WzdmClhTHhZdtSWuPwgj8mcAMGtRo2l3WHkObiJlIRE4XmxZ/Fgo1ZBNJ
         0UMvlo/E4xSYS1FkKZAykR7u31ne7Ck5oLJ8v0FsdFx2v/RiIwkRHk38behTpe1rYem9
         ijEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Thu, 15 Mar 2018 15:16:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Message-ID: <20180315151645.fsgcywyawvtiwx52@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
 <20180315131316.fd5ftqwgdb5bf5we@lakrids.cambridge.arm.com>
 <839387ee-e1c2-cc71-c06a-7bc2d0eda73d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839387ee-e1c2-cc71-c06a-7bc2d0eda73d@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595017280279938730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 06:55:32PM +0530, Chintan Pandya wrote:
> On 3/15/2018 6:43 PM, Mark Rutland wrote:
> > On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
> > > Huge mapping changes PMD/PUD which could have
> > > valid previous entries. This requires proper
> > > TLB maintanance on some architectures, like
> > > ARM64.
> > 
> > Just to check, I take it that you mean we could have a valid table
> > entry, but all the entries in that next level table must be invalid,
> > right?
> 
> That was my assumption but my assumption can be wrong if any VA gets
> block mapping for 1G directly (instead of the 2M cases we discussed
> so far), then this would go for a toss.

Ok. Just considering the 4K -> 2M case, is that an assumption, or a
guarantee?

Thanks,
Mark.
