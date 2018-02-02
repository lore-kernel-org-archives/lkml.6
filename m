Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225TBQ48Vfe2AmeTVnGz9vusdKR1kGP9ExSzQMthJAf1pcxnKCDoXKhxq1lYNeZ+jXS9Qm7S
ARC-Seal: i=1; a=rsa-sha256; t=1517591777; cv=none;
        d=google.com; s=arc-20160816;
        b=UxdrJDnD3Eb0p12tod4UtUxoVVYV+WKH7WXvgNufbFjL703nSwZVgwDsQWZHOxOek7
         RnL2hagxWwRglS1n+TXfAK+b6YfhwunKzv2v56OewAJ+5mnXpR49pmMx1tmJfRNwfmXh
         mYIWvQ5zN5RBibH4pdLCP8/FpWGI+VOLC93UNbIuIcJu+zJu/YVCVKE4a3QRbqKx67Qp
         STBeawfL+nxtwYo0zd5mKG0zp6nFE65lI52XmUq1dt54bWYg2HfvJ22T18gHvrNSwqbA
         +KnHAx27Ag41+H+bhQR3K4Ju2c71MgvVsuYESFF+wWUXes9Gvl0iW2ZhS7d12zvkk1/v
         mPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rlDHt6c3vED0/tpuHjvx7bqhkNEemyrr6318DG8omVw=;
        b=q3usUaznlOYgLqpc27ghPMU98F/v9SSv2RdKyrrs+MreVRhKAUO95FDdiKrKSkztDB
         ouszxCTVESz+vEapVH0izTANBZJP2JqZCflQs3mbrTgv6HLOnujzJFQ3In2JgDtmX/YO
         1iX1mjWxgvtsddLgwY8V4GtuDFXGYeRC81IBNAp3HdgxwT8h+9ysrGoM3ytPOktE/Fyf
         bnUQtZEeOtQz+UifiZ3y3el5aNk7AIjDb5dYeywXX7TXxmMXIwQfnmFs/4OKh2L+NC23
         8GTauugOWUKwEiWLlWR76PwJK3b9n8dXpxPSwVtLAsHxYLzjXT4L39HfkM3I0xrD4bIb
         qSIw==
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
Subject: [PATCH 4.15 39/55] usb: f_fs: Prevent gadget unbind if it is already unbound
Date: Fri,  2 Feb 2018 17:58:57 +0100
Message-Id: <20180202140829.995927541@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309452123776224?=
X-GMAIL-MSGID: =?utf-8?q?1591310315326519433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3700,7 +3700,8 @@ static void ffs_closed(struct ffs_data *
 	ci = opts->func_inst.group.cg_item.ci_parent->ci_parent;
 	ffs_dev_unlock();
 
-	unregister_gadget_item(ci);
+	if (test_bit(FFS_FL_BOUND, &ffs->flags))
+		unregister_gadget_item(ci);
 	return;
 done:
 	ffs_dev_unlock();
