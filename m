Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226gVM5a2xLU2vyppjTD146ANz4YPOEY0zjCMjgoNJuWJReUYCVQ29mG2GUQY5nxsEqg3G1u
ARC-Seal: i=1; a=rsa-sha256; t=1517591614; cv=none;
        d=google.com; s=arc-20160816;
        b=SfXdKJuWvDP9IAtqGXbaTgAzC8k4MGUQiS5GzLcH0BYvW5Z5uC04Pt+77xcyEy894r
         z3GOHibah+x4caoo7xf8tXCfPvXygSSu9JSCMYDCzd0yxegmyQlWgGiCSe4WCAxLEa9N
         f5qoZuAOXmjC9fQ1uzM/aTleGvs/bbUgGv2wzdJ2awPgFiLVR6vC3TuybKyRC+jYJva7
         g2VmT5DkwnfY+kq4Bkf3+6RJbydW6NBSz4UuD2E7kvyUBrqLjtE6lSSRZddogJ1sr06i
         /wfmuDNjwGfAQj8BL0Frr50GdCboWCd0nggMxScB/gTCxgsrazIp1s/1ZDWCiVVkbbtW
         Dx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oVQaQ9FCUXFBY56lDJHrvEU1P8WYWRLykaYoWS56DUM=;
        b=LxG0b0b9hQa1FpURuwAdpFHN5bYNwOMcXVYwfyvOvPr3RmiYXpAKH2IkJvalSvGckZ
         9jqtOnMTV9Eguzh5AxMcm6lOjiTGxiDPtblVtyrNP6SPN6l4BJPx95rSi3tQaTq9Xjs1
         SKsIW1NmL4oHQd2USwrcIclAP0DW1SmJXfUsaqjlixpV3p0KAzvqL+anT90n6s5uJJ4q
         EZA73YihKFWylAncEu4U61472OZ0A+Bs6f6egPXr8oLqdJ1muCecw7nV77iwpHZSqJVx
         rR0KwOyuzVyWXYxntIU5KBW275K6JnOsna6i4SYMIpvkSHs1/KXTDMBy4SnZHnJQUJdh
         0SMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felipe Balbi <balbi@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Badhri <badhri@google.com>,
	Android Kernel Team <kernel-team@android.com>,
	Hemant Kumar <hemantk@codeaurora.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Greg KH <gregkh@linux-foundation.org>
Subject: [PATCH 4.14 141/156] usb: f_fs: Prevent gadget unbind if it is already unbound
Date: Fri,  2 Feb 2018 17:58:42 +0100
Message-Id: <20180202140846.752294613@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309452123776224?=
X-GMAIL-MSGID: =?utf-8?q?1591310144894412542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hemant Kumar <hemantk@codeaurora.org>

commit ce5bf9a50daf2d9078b505aca1cea22e88ecb94a upstream.

Upon usb composition switch there is possibility of ep0 file
release happening after gadget driver bind. In case of composition
switch from adb to a non-adb composition gadget will never gets
bound again resulting into failure of usb device enumeration. Fix
this issue by checking FFS_FL_BOUND flag and avoid extra
gadget driver unbind if it is already done as part of composition
switch.

This fixes adb reconnection error reported on Android running
v4.4 and above kernel versions. Verified on Hikey running vanilla
v4.15-rc7 + few out of tree Mali patches.

Reviewed-at: https://android-review.googlesource.com/#/c/582632/

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linux-foundation.org>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Badhri <badhri@google.com>
Cc: Android Kernel Team <kernel-team@android.com>
Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
[AmitP: Cherry-picked it from android-4.14 and updated the commit log]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3704,7 +3704,8 @@ static void ffs_closed(struct ffs_data *
 	ci = opts->func_inst.group.cg_item.ci_parent->ci_parent;
 	ffs_dev_unlock();
 
-	unregister_gadget_item(ci);
+	if (test_bit(FFS_FL_BOUND, &ffs->flags))
+		unregister_gadget_item(ci);
 	return;
 done:
 	ffs_dev_unlock();
