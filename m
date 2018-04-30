Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqMv9vu5nY45IrF16AOmaBCpsUkKlPXOyeLe6QroMOtgfov3Eq4MOuoEtpSWKTe69eaStwg
ARC-Seal: i=1; a=rsa-sha256; t=1525116239; cv=none;
        d=google.com; s=arc-20160816;
        b=UgslM49Mucoh62xwQxtr+HXEBF0GJ6DiPtaeFAymszxleAc+MUW3C+ouxi5EKI8QcE
         /uBi3SxpLsNiCDPBklQe2E2vFhmkV/lHqr8p7Uw9LQc4bt/ZCZubf6/XMFgBROuMpmCd
         yawfjLaftjNCQTcXyHaOgU67FOhwCUPR66Lf9vb5bEkop67gHEU4TKx5zJzBWaJJw27M
         zUb45Lo9KLhZ+nbhx54fQMRZAD9hq7LDQ5l1F51qG5aQeawlKi/4vdSN58iTeB8+mxgI
         H4Mz7gOSCuLN+iblYVRAFfDjA5paqoRhKufuoW//hIFXgyVVN1b8zbRIaWvxNEqp7Jg4
         /ZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=txPEvKYGBDlXMqTs/VG/d5Lzvw6tFEfA+M76a0oGsBg=;
        b=z224peFHjNlk/sJXfoPlKEJDHePSJFYQ+BglNpMxm3FI36BHfSHzn257vFcWGBIrUG
         idgcauN4DWpqKRkXQSBrYP4l4F72tvNLMarc9qeTYW0PxQ3i0L5t4t5eqwIYLtmKV61G
         uSjFuMfP4tH9P9F7kpkztooEuHw2hpOrL8eLq6g+FLk8reC86Pr3p7j0S8AKVDmEbY7x
         A8D51OB9PvNvUkafdh9h8CqHwsixG5HoscZf4X8WuMa6LBpT/NssAV8BA8VZzPrzc15s
         pbcSiAhvgss+SVBcI0SU+hxKXjUObz8ixWqUMI6ACgftvhLXbyUeIu6x3HHP81DVZPyB
         8ZQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B042A22DBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com,
	syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com,
	syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com,
	syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Subject: [PATCH 3.18 21/25] kobject: dont use WARN for registration failures
Date: Mon, 30 Apr 2018 12:23:28 -0700
Message-Id: <20180430183911.685047353@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285796531709?=
X-GMAIL-MSGID: =?utf-8?q?1599200285796531709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 3e14c6abbfb5c94506edda9d8e2c145d79375798 upstream.

This WARNING proved to be noisy. The function still returns an error
and callers should handle it. That's how most of kernel code works.
Downgrade the WARNING to pr_err() and leave WARNINGs for kernel bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com
Reported-by: syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com
Reported-by: syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com
Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/kobject.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -234,14 +234,12 @@ static int kobject_add_internal(struct k
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			WARN(1, "%s failed for %s with "
-			     "-EEXIST, don't try to register things with "
-			     "the same name in the same directory.\n",
-			     __func__, kobject_name(kobj));
+			pr_err("%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
+			       __func__, kobject_name(kobj));
 		else
-			WARN(1, "%s failed for %s (error: %d parent: %s)\n",
-			     __func__, kobject_name(kobj), error,
-			     parent ? kobject_name(parent) : "'none'");
+			pr_err("%s failed for %s (error: %d parent: %s)\n",
+			       __func__, kobject_name(kobj), error,
+			       parent ? kobject_name(parent) : "'none'");
 	} else
 		kobj->state_in_sysfs = 1;
 
