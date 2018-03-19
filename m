Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvXw1yei0wuU3qaxNPE9KaDPxyawSrDAc8K/beyJ13IC28f5sIWOwpG5O37SqVrHrHmsibf
ARC-Seal: i=1; a=rsa-sha256; t=1521483626; cv=none;
        d=google.com; s=arc-20160816;
        b=kOZLMna06vnb05+t3H8y1qFJb1QgElVzux1RSqyFmRWaWeYybrohMU1q0W6V7PZmKX
         3bc5ogrFllaa8HF3PMuPpSEcxyDQVwZKAAzbqXicV4p9maH4vgWZNSZaG4jnT+GLa7Aa
         EAVB81gmjxpEsTQrr9p/YZDdPXe430Q/6FnGCi/l+qgeA3us76vJXYEOKbcu+vIDBhNP
         FPwJ39nZeXylcQeG+MRF+sybeg8gFPl+iBUnFe7xReekO4S2eYD5chVgd/B9FJVALZtu
         rEoetb1fOCCRHiH8gYguh6RbT+Ve6pJLKRzapED/rcbm+hUZQP7GC8/grZG+SEo41mwS
         bBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MhTMs+BZTOatV5lFeeP0M1FOcigx0ldD/6zs9aMcVdg=;
        b=WV3PP1GqBispoC0vGdoyudc60J+8+hK2ZDmzJoliQowafOJ2bIBsgk+i9HAkMDQfuH
         4vuVjgZSl7SftRfEIIUm+LExnsPMtpcNq6YpdHmPzNCYpZI4z5/awPuavFzDY90u/LT4
         4sGFvaLksn0iFz8XEBCAedbS42B2TyAKCqc4pgN4cGUTTlua1hhoVin8s/Sigb7ZJ7mv
         SLpTz99x98zUmCP127sD7F+3tm2CagA3lp1K1mwV0njA+rRvSAoJAHlEHi0pY2PfkEDb
         x1akyztqxw+t4MvRyawuIFHe6YDs68D60yBxgQ5TDXgGkETy7a2deJDrpG7gm6GF2yU6
         fiaw==
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
Subject: [PATCH 4.9 056/241] timers, sched_clock: Update timeout for clock wrap
Date: Mon, 19 Mar 2018 19:05:21 +0100
Message-Id: <20180319180753.533220791@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390515179660972?=
X-GMAIL-MSGID: =?utf-8?q?1595391214738092576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
