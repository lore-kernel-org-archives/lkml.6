Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225viO2YrudDOsFYt3hzQXjEqcMyB8BOoo7R2BQQCIa1H/ljluwTXZc/6xGuHcPvnVJW7IuL
ARC-Seal: i=1; a=rsa-sha256; t=1519676164; cv=none;
        d=google.com; s=arc-20160816;
        b=OyQGOuoD0j+3sgFumWTBunuf5T3rxZb7ROKbwGcFxfaBBR1i5mAgzsIuRhFERusPi6
         dzoc8YfJ2oRSTbTO1A1gGG9JdGtWglWA9VvXMwKojsTKMk6aHtM2H9L6kSudJv07vY31
         iJsDqWSLhu7d2sAz3vqQFkYsFLbFg2a24bMWu/C8JTsP84GsCPB3GBjH2F/srA1Wpk28
         NjqhKWEoLtPJRMK2Tq25cMaVIZZjCQ+k3tsDwyiAxBKQwRU/f/GNtVN94LKueJLvl25k
         gscllFaPDf79oqRqrGvuiqfj1euvusADohKmhIz4sXMEKx3AnddIkbaDoMEgqqy5bATQ
         mMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wwsy1ZeEAxaIDOs/VAfzegrlZ4mIzI0OK7o4bdsqnzc=;
        b=YwQcG2+KdyWv4KalvupPxNBK54AlWovlu6dV0XlM/Mhx7wDs6m+AHBPSY9fbWft4ba
         jDqX6AWSAx+OcKrOAgmZjc819Gr9J8vbc1nyFb2RLuNsj62tcN9hw1qoYjOi8Sly4OJS
         Pcx+72f8Fb6iBFGye5hl+riK9dzd34Q30A+UlhzL03+4m7/rwTDGzFU9pS5zRS/K5v8X
         zWY1w3pgjCb/VKsO6ww7b+23hogvIO4eRsZ1PQhEohNj57YpnoIgnnRwj4qhA/Yha1q8
         /U2Ih67D1VTlL7WmnBMM8Obz/c78zsOzAvGfUlwJAL7EKwiy0m6K84r2Xc/++9Z1Li55
         U/Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mayank Rana <mrana@codeaurora.org>,
	Jack Pham <jackp@codeaurora.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 3.18 12/13] usb: gadget: f_fs: Process all descriptors during bind
Date: Mon, 26 Feb 2018 21:15:40 +0100
Message-Id: <20180226201527.771288503@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495953448268879?=
X-GMAIL-MSGID: =?utf-8?q?1593495953448268879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Pham <jackp@codeaurora.org>

commit 6cf439e0d37463e42784271179c8a308fd7493c6 upstream.

During _ffs_func_bind(), the received descriptors are evaluated
to prepare for binding with the gadget in order to allocate
endpoints and optionally set up OS descriptors. However, the
high- and super-speed descriptors are only parsed based on
whether the gadget_is_dualspeed() and gadget_is_superspeed()
calls are true, respectively.

This is a problem in case a userspace program always provides
all of the {full,high,super,OS} descriptors when configuring a
function. Then, for example if a gadget device is not capable
of SuperSpeed, the call to ffs_do_descs() for the SS descriptors
is skipped, resulting in an incorrect offset calculation for
the vla_ptr when moving on to the OS descriptors that follow.
This causes ffs_do_os_descs() to fail as it is now looking at
the SS descriptors' offset within the raw_descs buffer instead.

_ffs_func_bind() should evaluate the descriptors unconditionally,
so remove the checks for gadget speed.

Fixes: f0175ab51993 ("usb: gadget: f_fs: OS descriptors support")
Cc: stable@vger.kernel.org
Co-Developed-by: Mayank Rana <mrana@codeaurora.org>
Signed-off-by: Mayank Rana <mrana@codeaurora.org>
Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2727,10 +2727,8 @@ static int _ffs_func_bind(struct usb_con
 	struct ffs_data *ffs = func->ffs;
 
 	const int full = !!func->ffs->fs_descs_count;
-	const int high = gadget_is_dualspeed(func->gadget) &&
-		func->ffs->hs_descs_count;
-	const int super = gadget_is_superspeed(func->gadget) &&
-		func->ffs->ss_descs_count;
+	const int high = !!func->ffs->hs_descs_count;
+	const int super = !!func->ffs->ss_descs_count;
 
 	int fs_len, hs_len, ss_len, ret, i;
 
