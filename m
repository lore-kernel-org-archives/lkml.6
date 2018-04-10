Return-Path: <kernel-hardening-return-12956-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49xLbjziBduLG4jWI2shkVwsJZn8cSUSHtAowgSkvA6IkPvUov2xi5BDFSZafBoY3eF2tSC
ARC-Seal: i=1; a=rsa-sha256; t=1523374560; cv=none;
        d=google.com; s=arc-20160816;
        b=TeaViKmCkXWLW3AYjJpv4RJndOG49OwqAdu5g1RtLdrs+53KZIEQdzA9sCj06U5EgU
         J2V9xg8jqSeFyJcN9mEkOlsk7WV/iGOpve5SDLGt5JrEuUMnlAbAilSpV69cd+ZhbddJ
         9PdsRRbY1qLdS3BQlS67YedbYbBh2XXlP5/NePSqAfFzGtDNZfK62MUlrGA3BMv7wZfP
         BaVUBfjiY41o3gfROh4Sa9wbWepQjnVtlEG9kJCdRH3Iud0be4EF0v2otGHu0DyCnpc9
         0pAi98mu1c/aZIEfJmx0a6u8HpUWbqvcAW1iP9gVFEcUThrXzvBc4Imkw2NTmrLES0/t
         i5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=3IVGwFnh/g+p472iDndCWir5TiOu8eRmvZSo3vUPkYI=;
        b=bjZgX7nx7C3ZvOy7xQKFO1wSgo1emP0TuloRbg7c6Bp/VEwNQcAONrzASeBAHVcKyf
         GuftSsgPTElyCfHETZ99qOZQsmYIE5Uya1IWJohO/w8frkiyNss/N9AaFPJIuC6lQcFz
         9kJuEnKRdQYLXltLzUMtIOWfIXIv7jfeC43sQxUCJUEJ2EMTn+tUJ6Z0OjyOY/VKL9aT
         WxBvBRAL6EmJYXCACQTiTRPT5yMjv7T82970e1DJgGvW0S7gTOjDD7AVVAynInXRmiIJ
         6FkRoH1S4FNEe0r+ORRnwQYeU+7sfTFuwCE1vuNpAafoppc3eb1pkDzl7kQC9JL/56GU
         I9pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12956-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12956-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12956-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12956-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 10 Apr 2018 10:35:38 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'kpark3469@gmail.com'" <kpark3469@gmail.com>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"keun-o.park@darkmatter.ae" <keun-o.park@darkmatter.ae>,
	"psodagud@codeaurora.org" <psodagud@codeaurora.org>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] x86: usercopy: reimplement
 arch_within_stack_frames with unwinder
Message-ID: <20180410153500.shqpjemlsfp63yu5@treble>
References: <1523275156-29087-1-git-send-email-kpark3469@gmail.com>
 <1523275156-29087-2-git-send-email-kpark3469@gmail.com>
 <1523275156-29087-3-git-send-email-kpark3469@gmail.com>
 <1523275156-29087-4-git-send-email-kpark3469@gmail.com>
 <a59b818d84b74c13a4f25f757eba1f93@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a59b818d84b74c13a4f25f757eba1f93@AcuMS.aculab.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593731067679840173?=
X-GMAIL-MSGID: =?utf-8?q?1597374002648875689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 01:14:58PM +0000, David Laight wrote:
> From: kpark3469@gmail.com
> > Sent: 09 April 2018 12:59
> >
> > The old arch_within_stack_frames which used the frame pointer is
> > now reimplemented to use frame pointer unwinder apis. So the main
> > functionality is same as before.
> 
> How much slower does this make the code?
> Following stack frames using %bp is reasonably quick.
> I can't imagine some of the other unwinder APIs being any where
> near that fast.
> While fine for fault tracebacks, using them during usercopy
> is likely to have measurable performance impact.

Agreed, using the unwind interface is going to be quite a bit slower
than the current manual approach.  So this patch has only drawbacks and
no benefits.

The only benefit would be if you used the unwind API in a generic
manner, such that it also worked for the ORC unwinder.  But even then I
think we'd need to see performance numbers, with both FP and ORC, to see
how bad the impact is on usercopy.

-- 
Josh
