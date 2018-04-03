Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AIpwx4/Y8iB+vN+FmMmm3SeK1zi2FzqsMSrtl0DvTwmSRri6GC9KULBYFADiPv6f30+xuRQnuzu8
ARC-Seal: i=1; a=rsa-sha256; t=1522785308; cv=none;
        d=google.com; s=arc-20160816;
        b=qEEriwp9hPR3LS0kAV9eLTqvgA0LHiBt/LcuJKRV9fpDO0vSoBYKamgYtLZl0g2PcO
         mtI7rwHCr2pcyqATdGKWdomIfxfV9hb+7JCGobYHtP0n41g0mXNqeMuKCDhS1NdCvUfp
         A/OV9UdYOZLXGnrXKw7r3v/nTiQnrrBPlSCuUA9Kf6rSUTg4lhJuncFGwjffW/+KYWnG
         cdgHvsh7gl9O81gp4a/cjZg1Yo1lpj5QRLR0yOhkk1QBSXk3mptOw58vgU2XOkiRYaOq
         ih1pnQ3iTb6W2R/ljFT4BDu+FGUCRyrpl6Pysq/Vu1YCXpA/T4QtFaBJwALxmfZMoHKa
         KKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=DS/9oQxu7CN1pzezgm94w0nwRRmk3ZVCkDuCDjkFO/s=;
        b=Z0/r++NXe55Ja2sO1TLjOn/NoTNR0SAVJQ8RyKoOngvb4UVj3SuBchfVIOj+BjUhNQ
         eiABEd7IDFALRW5Z4NVuN91yZPrvI/EQz3ibcsOO76+miNsZpwErM/T7xJK6+WUrJxim
         TXnHxbWRwJwsWOladZfLJrXT4lOjsnP+hNRdPiKAVSLNW/4HfXSsZIoLVCK9b38cM9jL
         PPzXvcyRERuKfzdPWWbGAO8quHJ0IQBzFK8UIj2gritIF3IU58jw+gl3CNnJfO8sVIoe
         uD3nrZIaR6wHE3yNJ/Wo68Z+ecc7MrsIkYYE2IQEnL1ysDpmwdiYPLCUx75FWfGhEBKu
         h8Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7163520CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180403194849.csgzr3jllt4f2qb7@xylophone.i.decadent.org.uk>
References: <20180403194849.csgzr3jllt4f2qb7@xylophone.i.decadent.org.uk>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Tue, 3 Apr 2018 12:54:46 -0700
X-Gmail-Original-Message-ID: <CAB=NE6VD7mqEE3TUpBdYm424dQPTD+np_KmT9R6JQEcBuTMkPA@mail.gmail.com>
Message-ID: <CAB=NE6VD7mqEE3TUpBdYm424dQPTD+np_KmT9R6JQEcBuTMkPA@mail.gmail.com>
Subject: Re: [PATCH] test_firmware: fix setting old custom fw path back on
 exit, second try
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596755734470886904?=
X-GMAIL-MSGID: =?utf-8?q?1596756127902594995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 12:48 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> Commit 65c79230576 tried to clear the custom firmware path on exit by
> writing a single space to the firmware_class.path parameter.  This
> doesn't work because nothing strips this space from the value stored
> and fw_get_filesystem_firmware() only ignores zero-length paths.
>
> Instead, write a null byte.
>
> Fixes: 0a8adf58475 ("test: add firmware_class loader test")
> Fixes: 65c79230576 ("test_firmware: fix setting old custom fw path back on exit")
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Thanks for the patch! Also can you re-send and address Greg and
linux-kernel ? There's significant changes to the firmware API on its
way to Linus to I think if we want to merge this it should go through
Greg at this point as he also merged some new changes I made to these
scripts.

> ---
>  tools/testing/selftests/firmware/fw_filesystem.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
> index f9508e1a4058..6b63b6bf2661 100755
> --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> @@ -46,9 +46,11 @@ test_finish()
>                 echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
>         fi
>         if [ "$OLD_FWPATH" = "" ]; then
> -               OLD_FWPATH=" "
> +               # A zero-length write won't work; write a null byte
> +               printf '\000' >/sys/module/firmware_class/parameters/path
> +       else
> +               echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path

Odd I am pretty sure I tested this and it worked for me. Wonder what
it could have been... What shell are you using? I used bash.

  Luis

>         fi
> -       echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
>         rm -f "$FW"
>         rmdir "$FWPATH"
>  }
> --
> 2.16.2
>
