Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2269flAHl4NLCsNef6KwKfj661EVI6E72M+WuZxXytEr6AsGJgHJqZh4KIT2n7T8x6pl06xj
ARC-Seal: i=1; a=rsa-sha256; t=1519676221; cv=none;
        d=google.com; s=arc-20160816;
        b=VO0oPbROuA8HdC8+LURRKohlQ6emcpTfaTjg8usvdIvrhE8Ez01bYBGeJEas7J8oYY
         zr5UnCSeUtk/DPFk+IlXz84JD6ZjtGOyopOkdhczWRqo0tKN7btbQSr1QlILqfzSBdnM
         Lmz0Cse7Z1sIcBKdLlKfmHCA9MKfLaRJvOmG0BZlV6LalGO+uNbKM3k64j6jeKJMZeNn
         7GpeKdeXOfKh9QRhMG9UKYER4Re6YzaUcb/Bm/W/9rgP0UkA4S3n4gUyB+p568tLucdY
         2ltPsAX2pQmNg5KM8Hax7pow7CsYN3MKrgo1u4rERuh4KFXLVFdNHlNQj1y5swND5k3Q
         aEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J7b9x1yypyxdDwnJeZgZaC7IAI2ChFkLBDCgu5z6puo=;
        b=bgfY8YDcBS0VOjSOZtkRipUVlPi9UZBlZLcjrftmPGnU3NXbmyo6dl6hGPpdByzSRn
         Qv5p5RtaxWJmChHqFLlvuGBaPbQ9mSk3FhQFF32E5nvr3l8I8kaYRLHrNpN4PHkN6GB7
         EiqAT+oq7SbgpwhKmaRSIjW41qrNeJYwDWJAqUPesjbBrd5grv6/kZROI29eMzOZRgwC
         JqF1Vfunkqjy3f4WRhHcWk4jb8IX2BNunTiGuOvwkYx8ERBtjFdif/DMDgjE9yLDxk7X
         P187CA40s/8aDlY2vg061W4Y0/FZqMwT2AMl13yzeV5KEI8MfOsZ11u6mkZAI7+8Lzc6
         XBGw==
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
Subject: [PATCH 4.4 19/22] usb: gadget: f_fs: Process all descriptors during bind
Date: Mon, 26 Feb 2018 21:16:19 +0100
Message-Id: <20180226201559.576997613@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495953448268879?=
X-GMAIL-MSGID: =?utf-8?q?1593496013998997758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2756,10 +2756,8 @@ static int _ffs_func_bind(struct usb_con
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
