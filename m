Return-Path: <kernel-hardening-return-11870-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227R8ZpWkXXiT6IGCgCINcmrvh4r5BEJDnHjxzVY/C0AaMyPI2hHCpTgZwzVI3Ou15VqjeOu
ARC-Seal: i=1; a=rsa-sha256; t=1519252546; cv=none;
        d=google.com; s=arc-20160816;
        b=OhFp66r0ICn8McfCqDI/Q0rJRBfcF5csBqVcBfAsAte3ryDbHwxRCow96z73ObjCoY
         4OUc+BFgMwMhtq2MLEfdpT3+TL/wjYSbmOQd6KNJASMeDJeZs5b+XM3PUG2hDi28PsKJ
         9Edw7MaEWuJe1j9m3WLF9OG7CQZxU0/wrsIp03+yCbFc+keksJOhVZYVn0JZTnM32Ilf
         r3QZtvuAV19JXWP74cyASaDP1a7dRIh1rloCRvDoy1SED6/sAXeG7gyMHr7AK0XsR4Gx
         Y+M2z/h3X3ZKMjNBqbKTXp6EmX5Mt3+wEifdEkF7vRDIpmeRdn+4wY5g5CYDehFM6oQo
         zLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=MM9XnDBYm0i4xCWZERNIX4RnrUgLNZV4QeNNUESbtRQ=;
        b=y7rqnhQFMfxfwwWEXnok29MKfvT1BJMHB7pH7pi4ZXJJ0t0l0bQkeZLNxXEaF0bkSl
         pFO3FtJ4nxs2Gf4HK7PfboJTxvMv0zg6MD2ghhkmWnEd1SqW6gw4VBE4aqNvG3H4DgXU
         TLGH5Q7OiSjBfYssILLrhPQjVNSFW3qWYyrtHAtUfi3vwuC0Nr76H/hHPxrA1ijAzSJf
         O6wsIJ/jJDBnunkoc/e+ARvi12GQeF75CKONHMALcBda1zeafxhmbMPhr9SYdCDQhhXG
         bG0Dh0Ot/1NJe1fLlwBv2oct/9bHClpuZzMZ+veuPIeT1aavSKhqctGRTJhJIC1njv+G
         g2yQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11870-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11870-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11870-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11870-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 21 Feb 2018 15:35:27 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <keescook@chromium.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, Matthew Wilcox
 <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Michal Hocko
 <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>, Jerome Glisse
 <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, Christoph
 Lameter <cl@linux.com>, linux-security-module
 <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
Message-ID: <20180221153527.12e7d12c@lwn.net>
In-Reply-To: <CAGXu5j+zRQfxRXoSC5G8EjeSkPkpeMxfedJbHEgFyYcyXWmW9w@mail.gmail.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
	<20180212165301.17933-2-igor.stoppa@huawei.com>
	<CAGXu5jJWLdsBr-6mXiFQprT-=h2qhhXAWRLQ+EaKKiubKOQOfw@mail.gmail.com>
	<daaee36a-e6c7-8fbf-b758-ecee5106da9a@huawei.com>
	<CAGXu5j+zRQfxRXoSC5G8EjeSkPkpeMxfedJbHEgFyYcyXWmW9w@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214925267848300?=
X-GMAIL-MSGID: =?utf-8?q?1593051758725220990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Feb 2018 14:29:06 -0800
Kees Cook <keescook@chromium.org> wrote:

> >> I wonder if this might be more readable by splitting the kernel-doc
> >> changes from the bitmap changes? I.e. fix all the kernel-doc in one
> >> patch, and in the following, make the bitmap changes. Maybe it's such
> >> a small part that it doesn't matter, though?  
> >
> > I had the same thought, but then I would have made most of the kerneldoc
> > changes to something that would be altered by the following patch,
> > because it would have made little sense to fix only those parts that
> > would have survived.
> >
> > If it is really a problem to keep them together, I could put these
> > changes in a following patch. Would that be ok?  
> 
> Hmmm... I think keeping it as-is would be better than a trailing
> docs-only patch. Maybe Jon has an opinion?

I would be inclined to agree.  Putting docs changes with the associated
code changes helps to document the patch itself, among other things.  I
wouldn't split them up.

jon
