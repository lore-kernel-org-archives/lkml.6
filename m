Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518420450; cv=none;
        d=google.com; s=arc-20160816;
        b=wYq17MUClTt1drQq434sr0lHLrvgrdQ3BXJtkeXh3aG8YN1uu4SNHAOgcv6Pp939/G
         +6TdiJz3CUyXYlUPFnd+i8T1l3wCRLUEbKAKQRInx/ajjVpBIdHvap+kg13X0juihAEb
         CFfA9TmA2fywgX0mmoPrJF+pk3ZCQ//2w4ADBrFve9YSH/hiWV2AfsL0Mhqu6CGuT5NT
         9HizOIby2bTE5we6jqXOJDUpHHuggbb+ZMATLfMuq3RhqanvHRQNJye4gUQja+39iLnO
         nGEfct78loY1X5ciTEL1e1R7zcCm7TE6wbXNmyO/l332f8XTsjnyx79UMkR7HYMOQtlz
         tVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=dNat5RzN1qO59zBHnm9pnXRmSDGkOSbQJqm/IfUeNcs=;
        b=ywMSAbm+lDiRrqlnnhG+Zaen9SfxARXdRZ/MBIHTvozy2KpP4btTKwiexL6+9JeXp7
         YDmdO0eyIDsyW2VdUFQoU25fyXMhiDKZokYnySBjXhNGp14sG3qNnlKPOfRojzLcIj+9
         er/eG06dHravf2Liy0fmMvbUX830x0/HEke4aUYkZwP0SW8MkXATVMzoLAeCo5q5dq7w
         br1d7W41VROEoIA6/1XsoCNU7SakXcCDj3luXb+hRVTWeTv72J7uSrDUrdDDWrYruzz0
         itw82VQ3gKDzB8QyLd8mG7IHpR5SuuyCvR0yvLQXoni8gra90pu75/bwMBRN6f20YPdC
         qiow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Pa3QDObN;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Pa3QDObN;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x227MNotbS7nDXlhktrDEKSO8mMOXOzUCJLETPPEhmM9DvQCsQ6tg7/Ed9GOniDn6V/MV1IgPYA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 12 Feb 2018 08:27:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fengguang Wu <fengguang.wu@intel.com>,
	iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org,
	X86 ML <x86@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	virtualization@lists.linux-foundation.org,
	John Johansen <john.johansen@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
Message-ID: <20180212072727.saupl35jvwex6hbe@gmail.com>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592179242136182558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
> reason. It looks like it's only a convenience, so remove kmemleak.h
> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
> that don't already #include it.
> Also remove <linux/kmemleak.h> from source files that do not use it.
> 
> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
> would be good to run it through the 0day bot for other $ARCHes.
> I have neither the horsepower nor the storage space for the other
> $ARCHes.
> 
> [slab.h is the second most used header file after module.h; kernel.h
> is right there with slab.h. There could be some minor error in the
> counting due to some #includes having comments after them and I
> didn't combine all of those.]
> 
> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
> header files).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Nice find:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

I agree that it needs to go through 0-day to find any hidden dependencies we might 
have grown due to this.

Thanks,

	Ingo
