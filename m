Return-Path: <kernel-hardening-return-11659-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2276x9A0XiaZotPNPr+meARcP1izQPOj+6GlbvKbOP5d4DaKowrstkwY4eiSDxE4NWZx202M
ARC-Seal: i=1; a=rsa-sha256; t=1518116228; cv=none;
        d=google.com; s=arc-20160816;
        b=CQeZYPg5biyxpE9WuDcQ3yUrtLAkauPFPM95CPn4ICCJcy9qhtywo/UsIOSRRhDDet
         haWBEknSjItHr6rlsj5rolwv7brNtPA4wz9ou9qUF90tGlR3wMmU6NlKc884fq+QoXwT
         mdHeLn4wOO529Eem1Jko6OCdUp13n7QhpRqP1QvcaOY+iARTfJVebN1K2T90BTJH/FkG
         xKhk+UhKKJrvXqNcsi0pFRqkCoaa2ss3FGItt1pbE1xMsOxvo7xlnO71DG1iG71eAnYn
         oPBBUmxba23FlGRN88UU97mOi2nvMOFyrB26W4RobOdLcvVcBWufhx3AglkAnNDqY6wW
         ffcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=OlkJZVjpDeH1Hf5BXpdyeihEvGqD4Evd2PxBNXmoqws=;
        b=XGDio2J6NPCE91IiXvlDuEO7xMw+BKpgBuJ9dj+vSE1c64NWIAXAwwulCF/q/YPjZZ
         PmZTpZDeyr5bW9wx3D/LFFe9tV5tzCiylcsZSgM7bDVjExKitw49BcOOmmVo7wM8f6Hl
         EML6CACRsgwE1+McDnUlP1vIG6ctuDkPqrlK5bWE4Sra05riCjonP8sCdWQNL4GwJIpr
         3Mi9JF1y1oiXEN9iDUQuAEcHKhMU9OqsWS26e9+L7En4rBHVud2UBxRG0qul2mM7pekt
         NgTVWIqMUXfpyx6RhZuXgFZgWLn8BH74569lAKPmRH1wZpXS8eSNAN3fjZQ/kkr25D2e
         WLYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=QVlNzU94;
       spf=pass (google.com: domain of kernel-hardening-return-11659-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11659-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=QVlNzU94;
       spf=pass (google.com: domain of kernel-hardening-return-11659-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11659-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Feb 2018 10:56:48 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Micay <danielmicay@gmail.com>
Cc: Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
Message-ID: <20180208185648.GB9524@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591860242798898886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 01:05:33PM -0500, Daniel Micay wrote:
> The standard map_max_count / pid_max are very low and there are many
> situations where either or both need to be raised.

[snip good reasons]

> I do think the default value in the documentation should be fixed but
> if there's a clear problem with raising these it really needs to be
> fixed. Google either of the sysctl names and look at all the people
> running into issues and needing to raise them. It's only going to
> become more common to raise these with people trying to use lots of
> fine-grained sandboxing. Process-per-request is back in style.

So we should make the count saturate instead, then?  That's going to
be interesting.
