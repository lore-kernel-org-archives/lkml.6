Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELswoGPlyMzuI2frbLlAbssqZ86d66i4yhXSMLA74PXszvIkcL9yVSupsyFu44OiTKGNIXf7
ARC-Seal: i=1; a=rsa-sha256; t=1519676528; cv=none;
        d=google.com; s=arc-20160816;
        b=tohevbV7laGg67CJn5yL9GcK4E7QWgoaG3ziknzb1Khgcs7UcMqd1D4hWQ07EN1DkF
         6GdOywMNZbafbZ6GHaAV7N0UBQWUx4ZGVUomWlpTJJdxs/HcNf/qpSulF/wY3aCrQLXF
         6S+iEOcQKJTEH697pjyhl5QIHvXpa7aVVawU8/4agI3aahpNpc2zfrMWRJsdAo+S/YRJ
         gDKaEMUqTdE0vgFSX02mRejzqaAq8vVqhh9nDOzHEFobFGTmzPHAiboLpL+9kR/WZCgU
         xXzLTFn3QIK84IQ77Df/ZqQBzZLs/r/ofR35m3GQP5/vIImUdCZqpt3FMhGTM7qd/pIL
         jO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=82/Tjeq97tGnNJhX3YqAGutBIEaO+nNGzbHQHK/jWuU=;
        b=03Sm12578tMxkl2tgvNc8QBDoQhdzZKc2qz6HZnomJDw5q2OPV7U9LQiGIrzkwBv5E
         GLteNaExIzlalyJsF6GOkq3PHTmYjsMHHpPB7rJ2vBrPDrzisz1v5Si/zsHEuvuR9l2Q
         XkthvPFCqSGZDJ3XYq45RWrczIkWm1gXgIiTkIuouFuh9QcW2DM4BP3c9eFCwqQBde7Y
         aBBTokOBwYypez5HuWBgyanNO4HS4KqxW1SrpZEyF1AL9bh+qFS2cW182u1bSj0nC3Mz
         l3RsGmXYFjNWWoN65XFILrFnso5Gu2CVTPEzghbjToLHlND5cG+vN67pRCemtCkGtoAO
         0hlw==
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
Subject: [PATCH 4.9 21/39] usb: gadget: f_fs: Process all descriptors during bind
Date: Mon, 26 Feb 2018 21:20:42 +0100
Message-Id: <20180226201644.602974011@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495953448268879?=
X-GMAIL-MSGID: =?utf-8?q?1593496335975138130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2956,10 +2956,8 @@ static int _ffs_func_bind(struct usb_con
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
