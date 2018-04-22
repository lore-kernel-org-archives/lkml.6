Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48yTpKfCUDaoaMHyx8Vheher+T1vPkKfEPFM/B7+NW/2WnyNPRBBWoFMGCcfNgJkMdEOLbQ
ARC-Seal: i=1; a=rsa-sha256; t=1524406710; cv=none;
        d=google.com; s=arc-20160816;
        b=BzjA0AAll/Pd+kiXkZl1oFwQFDRb++FzaxRb5V/k5tBHxtPkup84jVZOrdivpzoqce
         nh5PVy0eIy0+pCEdmtLnSMrph9RKfaAwR7d2QitKxglWTKnwOdXQSB//pC8FtGPuqyjt
         pfy6e0X21Uo3UVn7Kf9Cf5dP88EcBv9uz62USL+hLGVNPn+EGrbQG/N/Zxh4CVjH4Zu2
         3wkeuGdh2CYO3G+rwbNcc+qb+eZUK9Rw4liuodFMMEFIcKnAXPbm+K20pZ2zqdcHhV6+
         t9xQOVOTw7o1ZWyR9FiOmsb49aZ3j0ZF0pDHRkZpyUIShkzAFW85UCo/AVEHFLwnNbjn
         BDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oNGkQmgzkdOmRjeGnr7HvCxbvxodQXGRmUjdHrKjsio=;
        b=Vf76Nd7G1rae8wbjQ7/nAmVYl6+LB8ZLidnbpLghqUggAjuAIwP9qpxy8ji78Ect6P
         JWMjy8vrQBUKQA9ebM5VUiwBkflB26SjMWudmWonVajPW7/B8oEDVXifs07OzpICj98D
         s4FYqtyF/19WxGzjcI4W0XOx7mdI7ofv7BzV0KsA8TWkYN2jU8IsP5ao2XTu2lNIijm0
         5phij0XAqtUiuWkPE20zAx7uxznd/RF7INpuT7R+A1cgMjlrNQOFxX48x2iAXm8Ya7EK
         kn5L/PuZ74qm1CUUK2o0+dMXlu/zV0m8QEWk0hWR2zdv2w7JbtdsN7Icq39nwgauJgsJ
         HnWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
	Stewart Smith <stewart@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 40/97] powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
Date: Sun, 22 Apr 2018 15:53:18 +0200
Message-Id: <20180422135307.561031543@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454937101435263?=
X-GMAIL-MSGID: =?utf-8?q?1598456291445483243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 741de617661794246f84a21a02fc5e327bffc9ad upstream.

opal_nvram_write currently just assumes success if it encounters an
error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
on other errors instead.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -59,6 +59,10 @@ static ssize_t opal_nvram_write(char *bu
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 	}
+
+	if (rc)
+		return -EIO;
+
 	*index += count;
 	return count;
 }
