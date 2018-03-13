Return-Path: <kernel-hardening-return-12522-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuFLddTE+bNr8HzFWEckAiBc1+r+VkuH+tldIaQEkNHXG7cB6Hnov8Y6wVo6ZSiAtWSYdms
ARC-Seal: i=1; a=rsa-sha256; t=1520972305; cv=none;
        d=google.com; s=arc-20160816;
        b=KA3qrJBCL8+HSK2eHPMUdHfXllBydJBabBUxSZDDuvNO9e9nhmVRBcPtkyTa3N63GM
         oadeJAWW+wTXI+q7CW/7sa7vw25ta1O1kN8OG0ytfjOy8UDsKKtgkwnMznjBoXL/kqmq
         yuSqnZjElwe33o98cQ+9OQ4t1SzmI6+6jXLTE3/sq9KrCgTenuZ73PfcgEWMshOQESSR
         m58gV+Zcoxfm4zfSKWyAUHk245C4Rx9GkQm5QPMnpY447E5hdrGtbz1Anh/LcLOf8loE
         nlHDNmW2zqFS8crXspggTwpCx4pU3tky8vRctUXz5rN0s1JBmFzGVQF4lZGRX8+JODAb
         jIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=4oeYmc9s2YmgBjyhu1dm+Ow0FY+wvJYgsXQ7G3DPIhE=;
        b=T9AgXWnxkD+5FVYbGEnFK+xqKeA3tfDykpVzNjPBnaP1kmcMvAAuxs5KwM0iq6ans5
         a/TB7OJTNv93cq1nGaLzrz4dw8naOmJogxLp/uxdQNo8p5xpb4CtRiP5a8crkg+7ORHN
         4zpE1bz+30TlLNr3z25+e4h+0WdbvpyNiVUFA1suqY5r90z2N566QPHAY9F7g6aaaIs8
         zyDqq1xB8WkgbyNEPY5Stu2K5wDQ1xjRDHl/d/epNfQ0+gXByoKFEeFaZah5gDfe9Fi4
         jZuodN+BafMRFYGIwgVGrIz8QVLWlwr5TC6iVR/j7TNGwHGru2EgJiVe8OxqbhRgpZ4C
         RHkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=AH6m2Cge;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Ol98tSjq;
       spf=pass (google.com: domain of kernel-hardening-return-12522-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12522-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=AH6m2Cge;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Ol98tSjq;
       spf=pass (google.com: domain of kernel-hardening-return-12522-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12522-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:-DGoWj8A7GolosH_deSna7m-Q30QWzztR7gb-AD9mzrNkXK4fhs0OQ>
Date: Wed, 14 Mar 2018 07:17:57 +1100
From: tcharding <me@tobin.cc>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
Message-ID: <20180313201757.GK8631@eros>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
 <20180312094606.8192B6081A@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312094606.8192B6081A@smtp.codeaurora.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594855055906961220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
> tcharding <me@tobin.cc> wrote:
> 
> > The kernel would like to have all stack VLA usage removed[1].  rsi uses
> > a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> > is defined using a magic number.  We can use a pre-processor defined
> > constant and declare the array to maximum size.  We add a check before
> > accessing the array in case of programmer error.
> > 
> > [1]: https://lkml.org/lkml/2018/3/7/621
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> 
> Tobin, your name in patchwork.kernel.org is just "tcharding" then it should be
> "Tobin C. Harding". Patchwork is braindead in a way as it takes the name from
> it's database instead of the From header of the patch in question.
> 
> I can fix that manually but it would be helpful if you could register to
> patchwork and fix your name during registration. You have only one chance to
> fix your name (another braindead feature!) so be careful :)

Hi Kalle,

I logged into my patchwork account but I don't see any way to set the
name.  Within 'profile' there is only 'change password' and 'link
email'.  I thought I could unregister then re-register but I can't see
how to do that either.  Is there a maintainer of patchwork.kernel.org
who I can email to manually remove me from the system?

thanks,
Tobin.
