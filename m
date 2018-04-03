Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4/kKm98X6KPgFPLpBoGkz9paaMI9m3WsTI2JxGc31rMzGtFXkqk+LcHre8wwflJmGxMAN5x
ARC-Seal: i=1; a=rsa-sha256; t=1522786232; cv=none;
        d=google.com; s=arc-20160816;
        b=Dost7KNgRiIF3nDbxkMOk5RhdWSodwA0Ys4vbyEYnKeDXC+aQV4HqGjvaqsez7P6Fb
         HT+HdCgZ1swduXJ8ahql3vypvNVc/D5dEtxAz9t96qXrkMeTKA7k9LwvrK8401HBK3EP
         yvI32bF7DxUpxINZFxrL0U08vF39r1d36HXEjRchlWlAkn4NDVp3bMkXkjstRadzN/8K
         CpwuzTqg2KSjI7UQa9DiyR8jtnY47Kqw3Qq+PsCPKj2+rTnCF9u0/RGn+Ulma2LMLaY2
         lg//KqZOyf1qDTPgvVTPoN4vpJQ4uHUVUrtw09NZbKLbZoP+WC3s276GI7HcoRxSfZ1I
         77KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=R0e473vrmlTasCi6ht6myBM4/565ZAhnMl/DOA/8vYU=;
        b=oBqO8oWODIS9mRDCUFRq9RaS2zd86ginfcPkL8LQjyxj63fMhA7gQbm6quzOB2bfyU
         PZ+zo1EyOI10R/ZLhPQmKl5vQ3eRMTfiWBjXBpifVTsFOd+fJdx7DVsWEfHzwEF4OVuZ
         i1VGTrhJBJpFKxRjKk1zACPpWdl7yfZKk6ueCj0xBsz9GOZAYnKXyouAcDd3Cas1gvJw
         L8DQ5L/7IssAHg8M4zt66BVjCzbNdXrlAxf5RJmY+IoiGs6D8CjUAPtZrxOjZuk74gzg
         MNEYfLvteO868BJls2ooW+yjhYMJKyBjaOGvo8pvf0BA7bxuqyV0gBWlDj9kzFa+M7f0
         9IQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1522786230.2654.124.camel@codethink.co.uk>
Subject: Re: [PATCH] test_firmware: fix setting old custom fw path back on
 exit, second try
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Tue, 03 Apr 2018 21:10:30 +0100
In-Reply-To: <CAB=NE6VD7mqEE3TUpBdYm424dQPTD+np_KmT9R6JQEcBuTMkPA@mail.gmail.com>
References: <20180403194849.csgzr3jllt4f2qb7@xylophone.i.decadent.org.uk>
	 <CAB=NE6VD7mqEE3TUpBdYm424dQPTD+np_KmT9R6JQEcBuTMkPA@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596755734470886904?=
X-GMAIL-MSGID: =?utf-8?q?1596757096095569582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-03 at 12:54 -0700, Luis R. Rodriguez wrote:
> On Tue, Apr 3, 2018 at 12:48 PM, Ben Hutchings
> > <ben.hutchings@codethink.co.uk> wrote:
> > Commit 65c79230576 tried to clear the custom firmware path on exit by
> > writing a single space to the firmware_class.path parameter.  This
> > doesn't work because nothing strips this space from the value stored
> > and fw_get_filesystem_firmware() only ignores zero-length paths.
> > 
> > Instead, write a null byte.
> > 
> > Fixes: 0a8adf58475 ("test: add firmware_class loader test")
> > Fixes: 65c79230576 ("test_firmware: fix setting old custom fw path back on exit")
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> Thanks for the patch! Also can you re-send and address Greg and
> linux-kernel ? There's significant changes to the firmware API on its
> way to Linus to I think if we want to merge this it should go through
> Greg at this point as he also merged some new changes I made to these
> scripts.

OK.

> > ---
> >  tools/testing/selftests/firmware/fw_filesystem.sh | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
> > index f9508e1a4058..6b63b6bf2661 100755
> > --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> > +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> > @@ -46,9 +46,11 @@ test_finish()
> >                 echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
> >         fi
> >         if [ "$OLD_FWPATH" = "" ]; then
> > -               OLD_FWPATH=" "
> > +               # A zero-length write won't work; write a null byte
> > +               printf '\000' >/sys/module/firmware_class/parameters/path
> > +       else
> > +               echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
> 
> Odd I am pretty sure I tested this and it worked for me. Wonder what
> it could have been... What shell are you using? I used bash.

Seems to work the same way for me whether I use bash (interactive) or
dash (script interpreter, /bin/sh).  But there's no visual difference
between " \n" and "\n"; that's why I used od to show a hex dump in my
previous mail.

Ben.

>   Luis
> 
> >         fi
> > -       echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
> >         rm -f "$FW"
> >         rmdir "$FWPATH"
> >  }
> > --
> > 2.16.2
> > 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
