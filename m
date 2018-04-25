Return-Path: <threeearcat@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524661345; cv=none;
        d=google.com; s=arc-20160816;
        b=bsgjkGcrMA8AGFoYGFR1Jx2PuNxudXEpM/d0QnAg0Yghnhnk1u+QK1uucCO6Zpw3jD
         i0X1f+1et1UfYDIvaHbcchJxQLDVP2XoiOuE3dIMGPzHQBsSH9gkWkjQ9G6IZ6FistBC
         Ijz9EEksvz//MiCmlJwLm189+ZNrPB1+MHW7AgIm+ZJdxNH5270MkLjpKwO+2svw12+G
         LX73CamsF9qD1ug//yln94RSc07zbxPE7XBTf7aIkX8JDIa4wmxCU3onC8wNUaWa9ZAz
         FCVU7FpfSj0lIJtRk0WiGt3yunFPfSicnRa9oSN5SSFczAqz4KNYmJr1e+F3EVqjI0v4
         9F4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=I7P4lS9R+w56q9IZ6pfIIaZGiAmxvSVE5b66j64lyQI=;
        b=m0c8Z3qDVWuTRigqwKLA7T5N/FPQyv0kTjLttTfuW9+S019m/XYMHHXYBbzNXkXMV2
         /WDZFB5wqRKo4Q3+AhieUylpJ2HJa6ZuXkHuPRsusqVU4bsEHbXd6wb9GYeWPqTeCtfC
         2MlleqUXFiqbCgKPkqDqT/N66WWw78BYqq/91A6KFRlpvB5vh+FOmDkOI2/bBMiQ+OjM
         yVjnzpZIF/dpErObDL98c6rwGQwnd3vNNmnU1+DCyWqdCnTcxYU4thDX0PcjIwC4eVmp
         JMDhnaeq2EOzBDtEPM61Gs7tAeSgyw+oZGtOU3nUEks+Qoxg8CXSHGvDD1IHIJdSb4Rj
         vTrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QaHJ6v51;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QaHJ6v51;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48g0PuMXTX6ELaIsaNq2nhxzwBtIHb5C2YMn2hCDwBMLNuvFIpTnFBDR9aWF6SYa+GUu3WAzfLUnpaBW9IPKXY=
MIME-Version: 1.0
In-Reply-To: <20180425125308.GB30021@kroah.com>
References: <CACsK=jfSRSLYvPJKzFrRQgNa10DsF8xLLKGYfqqE_hF9ucX-yw@mail.gmail.com>
 <20180419081735.GA28287@kroah.com> <CACsK=jfmwcLA9bsPAPEgvg72C2Cpc-U1oGhi+fO-rN543RKUbQ@mail.gmail.com>
 <20180425125308.GB30021@kroah.com>
From: DaeRyong Jeong <threeearcat@gmail.com>
Date: Wed, 25 Apr 2018 22:02:24 +0900
Message-ID: <CACsK=jdKhTQRgNOzQNm66osEvOWE2Beynod8WtUKYFdvEsBhHg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in tty_insert_flip_string_fixed_flag
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byoungyoung Lee <byoungyoung@purdue.edu>, Kyungtae Kim <kt0755@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, basavesh@purdue.edu
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598161270730760907?=
X-GMAIL-MSGID: =?utf-8?q?1598723295646862831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm really sorry for you to wait.
Since I made a few mistakes previously, I really don't want to make a
mistake again.
Therefore I have been reading documents more carefully and learning
the approved email client (i.e., mutt).
It is almost done. I will send a patch very soon.

Again, I'm really sorry.

Best regards,
Daeryong Jeong.

On Wed, Apr 25, 2018 at 9:53 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 19, 2018 at 09:25:08PM +0900, DaeRyong Jeong wrote:
>> The patch is attached at the end of this email and can be downloaded from here.
>> https://kiwi.cs.purdue.edu/static/race-fuzzer/tty_insert_flip_string_fixed_flag.patch
>>
>> We applied the patch to v4.16 and tested our reproducer. we can't see the
>> crash any longer.
>>
>> Our rationale is
>>   - Since tty_wakeup() called by __start_tty() sends frames, call
>>     tty_write_lock() before __start_tty().
>>   - Since tty_write_lock() might sleep, locate tty_write_lock() before
>>     spin_lock_irq(&tty->flow_lock).
>>   - Since wake_up_interruptible_poll() is called by both tty_write_unlock()
>>     and __start_tty(), Prevent calling wake_up_interruptible_poll() twice by
>>     adding the wakeup flag to tty_write_unlock()
>>
>> If there is something that we are missing or we are wrong, please let us know.
>>
>>
>> Thank you.
>>
>> Best regards,
>> Daeryong Jeong
>>
>>
>>
>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>> index 63114ea..09c76d3 100644
>> --- a/drivers/tty/tty_io.c
>> +++ b/drivers/tty/tty_io.c
>> @@ -873,13 +873,15 @@ static ssize_t tty_read(struct file *file, char
>> __user *buf, size_t count,
>>   return i;
>>  }
>>
>> -static void tty_write_unlock(struct tty_struct *tty)
>> +void tty_write_unlock(struct tty_struct *tty, int wakeup)
>>  {
>>   mutex_unlock(&tty->atomic_write_lock);
>> - wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
>> + if (wakeup) {
>> + wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
>> + }
>>  }
>>
>
> <snip>
>
> What ever happened to this patch, did you end up resending it in a
> non-corrupted way?
>
> thanks,
>
> greg k-h
