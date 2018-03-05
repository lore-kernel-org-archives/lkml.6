Return-Path: <oneukum@suse.com>
X-Google-Smtp-Source: AG47ELvcYRtw2JEGdQRqbd/ZSEL3LilJc6ndryRkms09i9sjlxoxNscCPJ1xk2NQ8R+PpoUwo+2f
ARC-Seal: i=1; a=rsa-sha256; t=1520266207; cv=none;
        d=google.com; s=arc-20160816;
        b=iFkLBDjCZwxaGGCyoqZZfepa28fsevCzWVPHoNfwfikvHWpSFBReXjvMPXWrbIWd6h
         y+fhEaQE60kFPTimSPVZGkfZZjdMNJABFadTaH4mBQaTeF9yFQG4b7GslNVBhz4BjhVO
         4MPIY8auchB440rksfU0/zrp+BBGmVahqC0r1fHSwVdXNeXo+H9h12Ap+RN9IYUlVxXB
         ihm7RThSb0wVgFiImZ9rBfisAQ6DogRJOc42CaYw5YQqiilSsSrfr923PUt01ClNu5XQ
         no8gFAHFrmQatwFLUplgj5NtZk8WOoP8M92xF4ctCzmFxVhwszEaED7n/REud7MzwC/n
         2gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=tEeu/A0hsJ8QeWXDTm47x704mAdBEufp+sv+6Lkumo0=;
        b=rSfvD4I8IY8J7XRw+y9Rt6L8TO0iG9EKKTTAhEJxQ84g/cwBxlTbkZhUY8IwTUsXyP
         yyI9ubsUdBgwUYDSBhYoXJ8Dwr03w9ioNNKAZ5NebKYkuITccLq/bpEOAmSdwDkTKKRe
         6mV565I6MViLu9E0XQ9JskYqFVmt+3ukkgTsuERkbpnc+/OO0xKejZs6LoJcId/pYDjv
         gUOb0IcLf+0YuXtoMi1FkYdNEN13m7CtDd9tASikdJzqGPhCeH3JjMkf6nedpwvuC3GP
         p0BGFSLBKsyWW8snrQuMvUlpomHEQKhCvWFv7pj+FmAbHX+ZrRbQ5txAifyxswLx5645
         Gsmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Message-ID: <1520265871.6256.15.camel@suse.com>
Subject: Re: [RFC PATCH] cdc-acm: do not drop data from fast devices
From: Oliver Neukum <oneukum@suse.com>
To: Romain Izard <romain.izard.pro@gmail.com>, johan@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Date: Mon, 05 Mar 2018 17:04:31 +0100
In-Reply-To: <20180305095539.13698-1-romain.izard.pro@gmail.com>
References: <20180305095539.13698-1-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594091152410964571?=
X-GMAIL-MSGID: =?utf-8?q?1594114658384813921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-05 at 10:55 +0100, Romain Izard wrote:

> The TTY buffer is 4096 bytes large, throttling when there are only 128
> free bytes left, and unthrottling when there are only 128 bytes available.
> But the TTY buffer is filled from an intermediate flip buffer that
> contains up to 64 KiB of data, and each time unthrottle() is called 16
> URBs are scheduled by the driver, sending up to 16 KiB to the flip buffer.
> As the result of tty_insert_flip_string() is not checked in the URB
> reception callback, data can be lost when the flip buffer is filled faster
> than the TTY is emptied.

It seems to me that the problem is in the concept here. If you cannot
take all data, you should tell the lower layer how much data you can
take.

> Moreover, as the URB callbacks are called from a tasklet context, whereas
> throttling is called from the system workqueue, it is possible for the
> throttling to be delayed by high traffic in the tasklet. As a result,
> completed URBs can be resubmitted even if the flip buffer is full, and we
> request more data from the device only to drop it immediately.

That points to a deficiency with how we throttle. Maybe we should poison
URBs upon throttle() being called?

> To prevent this problem, the URBs whose data did not reach the flip buffer
> are placed in a waiting list, which is only processed when the serial port
> is unthrottled.

So we introduce yet another buffer? That does look like we are papering
over a design problem.


> This is working when using the normal line discipline on ttyACM. But
> there is a big hole in this: other line disciplines do not use throttling
> and thus unthrottle is never called. The URBs will never get resubmitted,

Now that is a real problem. This introduces a regression.

> and the port is dead. Unfortunately, there is no notification when the
> flip buffer is ready to receive new data, so the only alternative would
> be to schedule a timer polling the flip buffer. But with an additional
> asynchronous process in the mix, the code starts to be very brittle.

Well, no. This tells us something is broken in the tty layer.

> I believe this issue is not limited to ttyACM. As the TTY layer is not
> performance-oriented, it can be easy to overwhelm devices with a low
> available processing power. In my case, a modem sending a sustained 2 MB/s
> on a debug port (exported as a CDC-ACM port) was enough to trigger the
> issue. The code handling the CDC-ACM class and the generic USB serial port
> is very similar when it comes to URB handling, so all drivers that rely on
> that code have the same issue.
> 
> But in general, it seems to me that there is no code in the kernel that
> checks the return value of tty_insert_flip_string(). This means that we
> are working with the assumption that the kernel will consume the data
> faster than the source can send it, or that the upper layer will be
> able or willing to throttle it fast enough to avoid losing data.

Yes. And if the assumption is false, you need to go for the tty layer.
I am sorry, but NACK.

	Regards
		Oliver
