Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225BOq20tL8PdCYj63MMf3Kbn/g9gor2HqT7K/koPMcooVCS6XE1nwBF8/dkhJ5fwMtSyAY5
ARC-Seal: i=1; a=rsa-sha256; t=1519676898; cv=none;
        d=google.com; s=arc-20160816;
        b=KBH7pfBRb9ctM9KsvVuQQUlU2wCVwByPBBkvIePwdgoa9ARsZgUah+80fwe3G11HaY
         yDS5w3ewWXdBCue7Fbgmnz0IAW4XjZt7Gv7kWPuBLJTLxUfFp5P4DbKrH+ugM4DInDlF
         f2IwSpWVGjtCVT14DQDW1T5Te4E0s34Q0DuVDBq+UonzGSKKaxZkPzzWtb3nL22hZ/2V
         RQfqjNf3jZNhaajEoDpmhY6YrUteS5X9QgRT+RPY6WdT1qgyoD9U/Qk1nGp/muvKbXjq
         6Ep8vaarpOy8VrfkH/rjBEfbUsj360eNft5M48twGSazTLtjZimwQVUNHqoXwZr3J4zT
         prjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fHK4V7XOi1qV87bWvaSVehchrJ5VegbnUXpL0fohENM=;
        b=Kiz/Rt5FIhtQWJPNp7j/+PnH/Tu8UiCagMMFpFmeeNU7w9z29zXDJMWVivNT4Ep9FX
         0v5vwrASBMvK7emQ+O7iSQJqyXUlydBoY3dnXq4TtQAUMtxK/L69ZrYrY6QKNChZ7KfV
         p55gCcZ9AKBBaD5V4BZIO83tiB32l5yrghnC//5vx2Ri2miF5sEORGorwIpeZDE+RiWJ
         envMowXCne6lDr0sqIzBs49dOgYnViuoemsH4WTQi+JmxLDur2V7iajaIHwkMFphxbjP
         Zkz38SlgRPfRI7bLZb63ALqqCyLSYu/HiwmH7nyLk7zEwsltiZxpQsCRXIkwEq3gQxv3
         wc+A==
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
Subject: [PATCH 4.15 50/64] usb: gadget: f_fs: Process all descriptors during bind
Date: Mon, 26 Feb 2018 21:22:27 +0100
Message-Id: <20180226202155.589853324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495953448268879?=
X-GMAIL-MSGID: =?utf-8?q?1593496722938161155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2976,10 +2976,8 @@ static int _ffs_func_bind(struct usb_con
 	struct ffs_data *ffs = func->ffs;
 
 	const int full = !!func->ffs->fs_descs_count;
-	const int high = gadget_is_dualspeed(func->gadget) &&
-		func->ffs->hs_descs_count;
-	const int super = gadget_is_superspeed(func->gadget) &&
-		func->ffs->ss_descs_count;
+	const int high = !!func->ffs->hs_descs_count;
+	const int super = !!func->ffs->ss_descs_count;
 
 	int fs_len, hs_len, ss_len, ret, i;
 	struct ffs_ep *eps_ptr;
