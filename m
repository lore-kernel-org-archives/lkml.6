Return-Path: <rob@landley.net>
ARC-Seal: i=1; a=rsa-sha256; t=1523881153; cv=none;
        d=google.com; s=arc-20160816;
        b=0Ix+Tki3ZlQppaXyub7pTvvMmIRLM2FU3LpLhgUi9OEgc4cBvnaHUbgK1PdxJXhLhS
         Vd/AvKTQSrQAbCq9TFCpQKGZhW/TUqcgXs+vH8W74ey6m/K4LmE1Yj0cxRZLeyR/I+xz
         fL/sfoowz9wxVGBtPSKWzvDbkG/yrMlQ30Xlw9R+6Pe7TH2wpU/UfotF5Ui2icIGtXBE
         vxBd4ZP6DUuJV+PeM5OA1BSey8R/2sOqUTMG4A8Ax7e8mPh9WlyH4Tv8+Vm4fbfEkA6L
         Lzv9dm5tBFgGEgvUVnUSsZxkvjNfHVvTSDJI7KKzULdfjFd6EKf1C7Z5c0XsZ7GpSEvO
         kEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=1OK4DKXH7X7hIT9vTQmBqgbBL5G2DkeaVm87XoKcBKo=;
        b=QkY1xathsAyx5AyyBgPsUNfmVtfipdrnZ0H/ZOnkkKz7U+JaLIKGarp9ibXr0P9OqX
         VA94Eb0k4PTl+6T0nUWSIYI3d8TukruQ8fJQdX9GPOO983oZ2/Sd07tEhOTdQijysuxL
         Mc1Sh1TMOFIA/PMh9yjT/JZsTrxkC25VJPrFgdNjH/0UYc3SRuhchIecG4UQ8KFdhbVf
         uSUF9hdyTA4Yx7tFJJ3g1c4EX3RELfqCAcFy7QHISo0OWL2rcIj5b7G7qIADuO1eZ+q9
         QYxnQzK/3ZrJEMxfvefSo4UZ1HfmesksBxfHzOmw6qsaAhoARDRGsSJoll1kIlHimlmP
         DzAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=eR162VqR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=eR162VqR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
X-Google-Smtp-Source: AIpwx48PxIw9GSd0kYfx3kD49wVfq1foi9m9xSlaO4jK/+NicRml6SP6/mj1ZrVJClq1BWazDCtPkA==
Subject: Re: [PATCH] Replace unnecessary perl with sed, printf, and the shell
 $(( )) operator.
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
 Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
References: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
 <20180416120930.GS16141@n2100.armlinux.org.uk>
From: Rob Landley <rob@landley.net>
Message-ID: <70d3e6cb-2ea3-1006-9af8-126cd3ea7fbb@landley.net>
Date: Mon, 16 Apr 2018 07:19:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416120930.GS16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597502519965840402?=
X-GMAIL-MSGID: =?utf-8?q?1597905204953904972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/16/2018 07:09 AM, Russell King - ARM Linux wrote:
> On Wed, Apr 11, 2018 at 08:38:37PM -0500, Rob Landley wrote:
>> You can build a kernel in a cross compiling environment that doesn't have perl
>> in the $PATH. Commit 429f7a062e3b broke that for 32 bit arm. Fix it.
...
> This looks more complicated than necessary, and therefore less readable.
> What's wrong with:
> 
> KBSS_SZ := $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> 		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
> 		       -e 's/^\([^ ]*\) B __bss_stop$$/+0x\1/p') ))
> 
> The sed command produces output such as:
> 
> -0xc0955e58
> +0xc10b0f9c
> 
> which the shell is then able to evaluate and produce a decimal number.
> This seems to work fine with both bash and dash.

Yes, that is better.

Acked-by: Rob Landley <rob@landley.net>

Thanks,

Rob
