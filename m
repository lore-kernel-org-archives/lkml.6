Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2274EyqmWW5jw+FMbXF7I5qK9bLaHvYmiZ5QrcVnjRui7iZNa+YBJYbsPSXFO2tRhtLF1QVI
ARC-Seal: i=1; a=rsa-sha256; t=1517855212; cv=none;
        d=google.com; s=arc-20160816;
        b=GXxWauIYn+H/44t4l5pnJNnb6AWe43QdQK3WQ3lBa5eh7rQ6LlCTkg/33GMRQPzxl8
         azciy8I1N+IRH6lZ2wZHDTaQI+Q4sJWVEAMEXAKkPPSCHCwcktoMKroDYkhplqGbSDev
         hh5fgt0vPsEhHclveH56bgcj67rJk/68Lc3xTPbAiU7EkexC8R+sd7nvQvGdqM1zypBz
         2ITIMgsuTmbTpeQzf9QyOWxBqa0lFxF8PbUEld+8dFrEEwG8VPhZbLCAoWEDne06ln+p
         /7HXxneilXXkhWyBqOXICCp5zdhwwtvCvTEqSXTmg1w4AoXFd7c2PM7e1bBD49EiF39n
         8OWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GTdzF2PIf02Ta6YMH1LfDuQKNKNajat+eiRpvC4LqPA=;
        b=Le0/1Yo+0S6Pxxb8RfEJg9m6rBwZwnbW0an0lUJe9fiPsKEdC3wuEwTjgyP16BnKYD
         WrypJtjoPFXf7DUTVEKM4GBUWzHxaGtBXKPZ8KURTWb9R5uTsT+sNhJ8IoYcSIDQOG73
         hEf+BOc2BfVrbrhqLlt5pLp7taYMYjpWLbDceekTshQMNnmhE6rloncL05qiLV9jbNLu
         tycLXynu8l3CCr1zIAkWl0iEibh1pBjAct1E+pkSJf5yp4OnMt0kHuOKVmgQsgbudG36
         rgZ2ofKJdo0lER+xtIdWAEph8XZrxDHdnh88e3RQ/u4No9yzzNDc2JKkx2cdECXuLA63
         /ovA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 3.18 32/36] usb: f_fs: Prevent gadget unbind if it is already unbound
Date: Mon,  5 Feb 2018 10:24:00 -0800
Message-Id: <20180205182353.091072658@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586547387221735?=
X-GMAIL-MSGID: =?utf-8?q?1591586547387221735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3438,7 +3438,8 @@ static void ffs_closed(struct ffs_data *
 	ci = opts->func_inst.group.cg_item.ci_parent->ci_parent;
 	ffs_dev_unlock();
 
-	unregister_gadget_item(ci);
+	if (test_bit(FFS_FL_BOUND, &ffs->flags))
+		unregister_gadget_item(ci);
 	return;
 done:
 	ffs_dev_unlock();
