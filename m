Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773295; cv=none;
        d=google.com; s=arc-20160816;
        b=IbQV1NYJGIbCt0ZRDOw0g1ddSxFm6h835qfbWhuIxce+BrHVOiB/ocW6aFC7VBtKGf
         TMwvFyFD0JS6S0LBhJGYwEu+Yb9E/0J37qEmfavcpVAxTi3pcI4oJG9YhttdWYrgU3/I
         aKpI/JofBraw0Yn3IYiV6rXu07FXxN/vHcMusJ9qiQ+h7eVYr/EXBF9doTW9CS79SH7k
         SRh0C401c8/FdRG5tGyN0Zx5a9Bm09tLWhs71fB8yNVEIVlVaylIFpSyhybW3gnV7S2d
         Xlq0q4VLj8FmrBeXXXnGhjm0ovURz7Ol7hmDYWX3QHIg+PQMHrIt5Y2ntL+vvUw7PDj2
         lI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=cMlrpI0dJi5lrpMGURmsEAyLWruwLTK+0UHX7i+edfo=;
        b=n7T/dgGFkgrj7rpL++syySUg1k2TbvMQQZZBHqjvI0F31Q6U//ytutSBG+mBrwXYwV
         SHZcNhwl8M2FrI+bMQTOE9ASEtq4OS9Cxorx5XYestVGpLoCjea2VYEePLfml+R4rjqr
         8yxqnQImhOLMuZSY2nNhQLGN9e2XL6bbwUxPmB9cU7DflOSRwxUfjiLBipxhXgJj9igj
         CpRN0O8rpzpbA+ze/mFPZVkkKouu9LZNAZPxc7Lgo2uowJGDNdqMDnFFIW1uVmXmd00M
         2DXyGykMGYc3BzG6w2oHdEM5IDyJuyMcRuaKwLv79j5m8rSEa4HI9s68U7HKxRleKKFw
         kGag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=g04HrWsy;
       dkim=pass header.i=@chromium.org header.s=google header.b=RmHuTeit;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=g04HrWsy;
       dkim=pass header.i=@chromium.org header.s=google header.b=RmHuTeit;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELue/WH4qMRDfVcDFkDNEiioDIOfcxqiIRoh+rshYkadZg1VTxgQ6wvbU+ZIdQiN6iISWPSKruocRQfPtg2Ppok=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-8-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-8-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:14:53 -0800
X-Google-Sender-Auth: U4faNyP4tQxMJZkgyrr1ugerxTU
Message-ID: <CAGXu5jKoRsXm00=dQePgrjF+EauphKnPQXVgL=rv_d579eNE7g@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] firmware: split firmware fallback functionality
 into its own file
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, nbroeking@me.com,
	Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248720090748696?=
X-GMAIL-MSGID: =?utf-8?q?1593597803115777127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> The firmware fallback code is optional. Split that code out to help
> distinguish the fallback functionlity from othere core firmware loader
> features. This should make it easier to maintain and review code
> changes.
>
> The reason for keeping the configuration onto a table which is built-in
> if you enable firmware loading is so that we can later enable the kernel
> after subsequent patches to tweak this configuration, even if the
> firmware loader is modular.
>
> This introduces no functional changes.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  drivers/base/Makefile                  |   4 +-
>  drivers/base/firmware_fallback.c       | 661 +++++++++++++++++++++++++++
>  drivers/base/firmware_fallback.h       |  61 +++
>  drivers/base/firmware_fallback_table.c |  29 ++
>  drivers/base/firmware_loader.c         | 803 +--------------------------------
>  drivers/base/firmware_loader.h         | 115 +++++
>  6 files changed, 874 insertions(+), 799 deletions(-)
>  create mode 100644 drivers/base/firmware_fallback.c
>  create mode 100644 drivers/base/firmware_fallback.h
>  create mode 100644 drivers/base/firmware_fallback_table.c
>  create mode 100644 drivers/base/firmware_loader.h

Does it make sense to have a separate subdirectory for firmware
instead? I did this _ stuff with lkdtm and have regretted it. (I'm
likely going to make a subdirectory for it this cycle...)

-Kees

-- 
Kees Cook
Pixel Security
