Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AIpwx4/RuSDHxnBYk7Mf7zX34TCq6VvfZ3Vkg5schFmzjaI8Nbao0nVwd3cqX/ybjJVHioV782Gg
ARC-Seal: i=1; a=rsa-sha256; t=1522786397; cv=none;
        d=google.com; s=arc-20160816;
        b=pDQ5SRucORlWiQhFkycNiwhk/SXy+eLuzFY2EmeEFHlZkS17NXcwYLXBhDmQ7ctdhc
         jVAS3U5VV01ENEVUkzWCGQ2i8b7Hn46EH9XpG82H70BM1TBh6HD0kp5dPqXx8onM6Yhp
         1W+SwQ3QPE5Shg5u9eyf/O6daZ7CvLWRav66WZr7ahyxa2bVChEgREYGw9V7QZRYvHS3
         ScuSTjLO2ei5eOevcRDWvRObqdBO9zFjHP0jJ5/IAV++gA+kp3NoRuFYSdu9LnkMFVe/
         DPhRQxoemSOtyw2A7d58uT6MZCq9/7KeEE4Tn4xqkZFJabkPYGjA7xu9022DyZqf1RAY
         q1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=R021Zj3InW6bSvEhWKRWZYAIA9Nza5UmZ+GfLR8yiqY=;
        b=V6xF3xjfLlhZNRmGIjK1jfGivmR8vs32tgFhpKBagz2G70RP8JeQItQ8joiTCEKW8F
         qk1NZ1W2nND5qDw2KnsCJdm4Y/GK5moWvZW1BFeR/IQWG+Xw+xHHq/w6Fv4P98wAYaRs
         XlC2eW4+vUNBxqSnn7Nc94fRv5KiDrV/OxyEDEafyOcm05BmfdtMRFdFJjSv7UEeyZby
         bbBqG0hPHKbLnDa7U4luXsjy9FlQjyX6f4RWN8Q4jewv6Skpc4aLGaolGwBwMcC7U1y/
         0+NIwlt2/DzfqT3mVgBJm8k5qCI/KPDS+8S5Qp5LY1yLD6nAxwYBXErpOwR/LV5FoQtT
         UCdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C97C217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
MIME-Version: 1.0
In-Reply-To: <1522786230.2654.124.camel@codethink.co.uk>
References: <20180403194849.csgzr3jllt4f2qb7@xylophone.i.decadent.org.uk>
 <CAB=NE6VD7mqEE3TUpBdYm424dQPTD+np_KmT9R6JQEcBuTMkPA@mail.gmail.com> <1522786230.2654.124.camel@codethink.co.uk>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Tue, 3 Apr 2018 13:12:55 -0700
X-Gmail-Original-Message-ID: <CAB=NE6VODNJ=vbNDnKtNPntWK=EEkStfayM+jE0mTc=GpmqCiw@mail.gmail.com>
Message-ID: <CAB=NE6VODNJ=vbNDnKtNPntWK=EEkStfayM+jE0mTc=GpmqCiw@mail.gmail.com>
Subject: Re: [PATCH] test_firmware: fix setting old custom fw path back on
 exit, second try
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596755734470886904?=
X-GMAIL-MSGID: =?utf-8?q?1596757269804925859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 1:10 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Tue, 2018-04-03 at 12:54 -0700, Luis R. Rodriguez wrote:
>> On Tue, Apr 3, 2018 at 12:48 PM, Ben Hutchings
>> > <ben.hutchings@codethink.co.uk> wrote:
>> > Commit 65c79230576 tried to clear the custom firmware path on exit by
>> > writing a single space to the firmware_class.path parameter.  This
>> > doesn't work because nothing strips this space from the value stored
>> > and fw_get_filesystem_firmware() only ignores zero-length paths.
>> >
>> > Instead, write a null byte.
>> >
>> > Fixes: 0a8adf58475 ("test: add firmware_class loader test")
>> > Fixes: 65c79230576 ("test_firmware: fix setting old custom fw path back on exit")
>> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
>>
>> Thanks for the patch! Also can you re-send and address Greg and
>> linux-kernel ? There's significant changes to the firmware API on its
>> way to Linus to I think if we want to merge this it should go through
>> Greg at this point as he also merged some new changes I made to these
>> scripts.
>
> OK.

Oh and if you can then base it also on Greg's driver-core tree on the
driver-core-next branch

>> > ---
>> >  tools/testing/selftests/firmware/fw_filesystem.sh | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
>> > index f9508e1a4058..6b63b6bf2661 100755
>> > --- a/tools/testing/selftests/firmware/fw_filesystem.sh
>> > +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
>> > @@ -46,9 +46,11 @@ test_finish()
>> >                 echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
>> >         fi
>> >         if [ "$OLD_FWPATH" = "" ]; then
>> > -               OLD_FWPATH=" "
>> > +               # A zero-length write won't work; write a null byte
>> > +               printf '\000' >/sys/module/firmware_class/parameters/path
>> > +       else
>> > +               echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
>>
>> Odd I am pretty sure I tested this and it worked for me. Wonder what
>> it could have been... What shell are you using? I used bash.
>
> Seems to work the same way for me whether I use bash (interactive) or
> dash (script interpreter, /bin/sh).  But there's no visual difference
> between " \n" and "\n"; that's why I used od to show a hex dump in my
> previous mail.

So odd, I'll test again with my qemu setup to verify again.

 Luis
