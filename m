Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519220615; cv=none;
        d=google.com; s=arc-20160816;
        b=ltUyfWqjsbOKxROQuwWqIElJZ22loEye7T+TFoOUu9/BW2io719AG/gCyE6Ur5Sg31
         H2PrZi383dhPtn2jzBBcizM0roo2K+Uk9jz1hn27vX9AWfttyCtXd8SibMAg3TNwLVpW
         PDAk1+Yry6mbZ+ZERli540DYc6X9SHS+ATIzF+OeIY7i/Yr3e74LLMwuWOEYHD9SwW76
         EiT2EuEHBvDzGS/qTyKYhGke7STmBmJFt8z/NU0BuK4ukwREIjrC2bNuDr3LsRko2VM/
         m3MshGd3Km6YhTYjoKHbu8Vzcs/l59O2PhQPtMN4QhtyIdQS+wR1je7LgXittekx1pOD
         GzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gZClVP/EKTZBZzybAy3AM1xUgAr2DcqOpb8DdPTBcqo=;
        b=OBLXmltI6Fd5L8a9x9Ybf3W5siQddOTBMRlmyyK3KO/B12whusgduEtmQPVlBmTUHN
         6waGbXsgVu/vUtxdjOln8KHwijqtvlkmqYMiMiCBRT52WdQo6bexK5+RYwBAr5Kc2z0j
         s6b5ljNA+NJXZ5W+pPyzf60O2m8iP5Qal/NLAIGisZtfOjFa3SiALtqannjOjYLtOZUd
         oHPnt3QczVAWxADeqrqxt7obP63ezB1UsbECcVQpDLsliAZLUpKe9KhMXk8c2wQyb7XG
         nRih42U8K8KPJbaGgDEr5UDnfvCSbYMOwX/ZyfWdi4FawcH0tpFcAPk0FgkNT5KfQvpx
         3++g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kfnOopo/;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kfnOopo/;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225LuyJiFZiiy9hs0KyUpyIbYIfT2aHn86ynj1felP7as6fv+YawCCbXMAegMObFgJwoiIb+KFvlCS7pcaGIYdo=
MIME-Version: 1.0
In-Reply-To: <20180221125340.GA15211@kroah.com>
References: <20180209134811.GB11309@arm.com> <20180221125340.GA15211@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 21 Feb 2018 13:43:34 +0000
Message-ID: <CAKv+Gu_J_DxAferEYG7r+OQVSymdWmfxOA-NHBP9JU8AKFeouw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for -stable
To: Greg KH <gregkh@linuxfoundation.org>, Mark Brown <broonie@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931397541704400?=
X-GMAIL-MSGID: =?utf-8?q?1593018276527914632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21 February 2018 at 12:53, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 09, 2018 at 01:48:11PM +0000, Will Deacon wrote:
>> Hi Greg,
>>
>> I've put together a tag which includes all of the upstream arm64 spectre and
>> meltdown mitigations based on v4.15. Please could you consider taking this
>> into the 4.15 stable tree?
>>
>> I understand that Ard (cc'd) is using this stack to create a version for 4.14
>> too.
>
> Do you know of anyone working on backporting this patch series to older
> stable trees (i.e. 4.9.y and 4.4.y and possibly 3.18.y?)
>
>
> I had some requests by some chip manufacturers who were wondering about
> this, as they seem to be stuck on older kernels (of their own doing, not
> our fault at all...)
>
> If not, no big deal, I'll just tell them they need to do the work
> themselves if they care about those old kernel trees :)
>

I had a stab at applying this series to v4.9 LTS as well as our own
v4.9 LTS based stable tree (which has backports of lots of arch/arm64
features applied on top), but there are just too many conflicts.
Functionally, I don't think there are any real impediments, but the
interaction with things like PAN emulation and the
feature/errata/alternatives framework make backporting rather tedious.
Combined with the fact that the Meltdown threat is rather theoretical
for most things already deployed, I am not convinced that we are
likely to end up with something that is more secure than what we
started with.

In any case, I don't think this series should serve as the basis for a
backport to v4.9 and earlier, and instead, it should probably focus on
Spectre mitigation only (which is less intrusive AFAICT). We have
someone in Linaro who is in charge of our stable kernel trees, but he
will need help from someone who intimately understands the code. My
focus was v4.14 primarily because of the significance to my team (the
enterprise group in Linaro), and I cannot justify spending a
disproportionate amount of time on kernel versions our members don't
care about.
