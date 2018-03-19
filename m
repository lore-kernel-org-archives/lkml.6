Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvIerfKnESF4sh7AlUWqErREtwZQNC0CsVkDzHULL/N96twsjcXNDKTZEMSAqZzrei1H20Q
ARC-Seal: i=1; a=rsa-sha256; t=1521483177; cv=none;
        d=google.com; s=arc-20160816;
        b=JPnf6rjyCLuHgavRXbnZF8hSgxX3slMW0Vhv0pBZ47hc7Zoe1rsPz0qEO0M+nXnzlx
         DT6dBpr/hJO2mbBT03inLp+s+yt9geUkI4Q+CxwlKxPqYxHMseRupEiBBXI45CPGL4jo
         +yw/YbGq/GJd4+U7GfEDNFjXlEhHFXvIUOF1+BB3WHzj/isugAQLGKOW0QbKOye+gpx9
         qeiuGJlQpcfGPXrNd0w1IUZ0jRbeV6WSL0uNReJQA3zrmFcTD9OabkE9lmOFKSkG/hds
         t2q7QkVcPDji3y6fzD4feAZCirnHK+on3fHpmIE8dXX3ybd9HlXbuRHSalEH+KAqi66g
         n/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e7p3NVaVXkotste401XA9hDNX6g2vGMy0C4vNa2sAtg=;
        b=c8A19W3gOs1532glx78JOBlLJhnfIGe4e4isb+hRurGM3FN69fBqKLepj6L0N0gaNO
         /sUyQlx6uof3Rm6F0GMY5UoGmK5HaMt6vy8GsOHztpWNRrLuKxL/iVAA21eFObwURVcS
         zEJqpAHLdf/Qi44wNS6dIJ8JWGXmsS3s4HB23G1RHDmTsrrIe5E43ssbr4cx0vRJWNOA
         ptGNxwf1IA7vHdOqD2fmTPS7LbcHnhKQq/OIF/JAgk9nFtKl24nesolxnqXpfYreBrHu
         +WHGl3sbOWKq0+3LwNNi7UIE0q4YaA9z2j4kEUn7saXKPukUbMZ1aSJVYcrM8ybA6kRy
         YIXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Engraf <david.engraf@sysgo.com>,
	John Stultz <john.stultz@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 027/134] timers, sched_clock: Update timeout for clock wrap
Date: Mon, 19 Mar 2018 19:05:10 +0100
Message-Id: <20180319171853.120793258@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390515179660972?=
X-GMAIL-MSGID: =?utf-8?q?1595390744286611813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Engraf <david.engraf@sysgo.com>


[ Upstream commit 1b8955bc5ac575009835e371ae55e7f3af2197a9 ]

The scheduler clock framework may not use the correct timeout for the clock
wrap. This happens when a new clock driver calls sched_clock_register()
after the kernel called sched_clock_postinit(). In this case the clock wrap
timeout is too long thus sched_clock_poll() is called too late and the clock
already wrapped.

On my ARM system the scheduler was no longer scheduling any other task than
the idle task because the sched_clock() wrapped.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/sched_clock.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -205,6 +205,11 @@ sched_clock_register(u64 (*read)(void),
 
 	update_clock_read_data(&rd);
 
+	if (sched_clock_timer.function != NULL) {
+		/* update timeout for clock wrap */
+		hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	}
+
 	r = rate;
 	if (r >= 4000000) {
 		r /= 1000000;
