Return-Path: <kernel-hardening-return-13046-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/Dma8w7R1ZqhJaSmHip0I13Hn7vytfVQ8L0MBmogCevr5HELxQqGdMCyxL/c0bO58vdav5
ARC-Seal: i=1; a=rsa-sha256; t=1524081030; cv=none;
        d=google.com; s=arc-20160816;
        b=jKjtsgfATLU9rCyVL+Q9ZdklTkHnOIWdq6bDiE9pDmwYHusbQnUQRbMN7UGDet4c9i
         gA77KvGQKlzu1cyZZemd7pXcXoq86XR5plKvNUFG+INkuK+DDgW/zz4UeNzmcEn1ilAI
         2shJP5qEehnym2g52/3bfzocA0Y9oAUT0Ix1bkPrrkaSUAHK7ljAkJOFAWun/USBASd5
         lt/73UC+t3ZgSuhXqQBftfxUXP9EKcDBYfhT6hu3+xHYgvMdbLfNbKRvk8arj047RUrp
         paX0Miu3YuCDP4G9gXOmFxUEOeTJfGVuny0Riyl9Vj97ujLe3hrbFeR2mdDv1+dmpTtl
         dj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=TT0oAoffY/QgdwF87ie0MQODftxNQDFM281k2xRoB84=;
        b=osDPXSol3w4UZsTYUw6Fcb3CoilNmSN/jG12EI/02iHTtf5wsfloH/In6FduWA9LxF
         SKcaATZPYWmjNagDkGPBUjWSbT5cZlx+U/yyg3vl/fDbeYxe6DMAKyqL6d/cc4q3gkYT
         we+nFa7x83hweJnb3/N4D2cJarkcksKQAx8n+vNYVZCwVr4U1l27UBI99OtQMHXix0Z1
         rBeP2QX+OY8iehGmKhGHoWybkFBsCtw0/L6cwEA4wXC13Uy9LGaRBn0T8b9oUE2jpak8
         jP52WSQQa/plMHpkZCImlW8cEPhNc4bZK9qoRG0N26IhhOspYeYVfVG0C6EWhFMHv7KG
         SBpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13046-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13046-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13046-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13046-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 18 Apr 2018 12:50:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Laura Abbott <labbott@redhat.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, LKML <linux-kernel@vger.kernel.org>, Kernel
 Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v2] fork: Unconditionally clear stack on fork
Message-Id: <20180418125008.203632feeaf0cac4e51c5b79@linux-foundation.org>
In-Reply-To: <CAGXu5j+PmPUg9-gx3769X+kjXJo+markuPA3FwredM7jU8CdXg@mail.gmail.com>
References: <20180221021659.GA37073@beast>
	<20180221102933.GD2231@dhcp22.suse.cz>
	<20180221125914.dc95830eada5fb958c13e36b@linux-foundation.org>
	<CAGXu5j+dc=y+1M=unyvEvCo+QrX3MCW5Hm=2Z+q0a6iC3pgN6g@mail.gmail.com>
	<CAGXu5j+PmPUg9-gx3769X+kjXJo+markuPA3FwredM7jU8CdXg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592975104699087561?=
X-GMAIL-MSGID: =?utf-8?q?1598114790019841577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 18 Apr 2018 09:38:07 -0700 Kees Cook <keescook@chromium.org> wrote:

> >> So some quite careful quantitative testing is needed here, methinks.
> >
> > Well, I did some more with perf and cycle counts on running 100,000
> > execs of /bin/true.
> >
> > before:
> > Cycles: 218858861551 218853036130 214727610969 227656844122 224980542841
> > Mean:  221015379122.60
> > Std Dev: 4662486552.47
> >
> > after:
> > Cycles: 213868945060 213119275204 211820169456 224426673259 225489986348
> > Mean:  217745009865.40
> > Std Dev: 5935559279.99
> >
> > It continues to look like it's faster, though the deviation is rather
> > wide, but I'm not sure what I could do that would be less noisy. I'm
> > open to ideas!
> 
> Friendly ping. Andrew, can you add this to -mm?

I did so on Feb 21 but didn't merge it up because I'd told myself that
careful perf testing is needed.  I guess we've sufficiently ticked that
box.  Kind of.  Maybe.

Oh well, it's easy enough to revert.  I'll add it to the next
batch-for-Linus.
