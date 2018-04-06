Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49DBCXrIUZ6taEfZk5WXbuipVtKUKaKFMzIgsd4FK18dpf0Z+XQbQ6sZERTgqibDKF7cKDM
ARC-Seal: i=1; a=rsa-sha256; t=1523021594; cv=none;
        d=google.com; s=arc-20160816;
        b=HQdEetOs2OYEm5cyK5Nzok7kdvhNn6uFGEImqGoTOxoLDC2Ksvncbzz43XhB798WAK
         buGqxEWgMWFUB/Ob6bwlvmCr9p2eaCO60lLKoFvYO92mRVi40h2P4ppei3WZ/2/8vjOQ
         Amc/Xrs7klgT4lTDUmhK7muDA8LF4xwgEeaOGxDDs/6IBj9wZnLyl/sA05bl/pYRaqXc
         0mxjPDp1JkQBiBPSES5rAErJOGfM1yKs5CrvOmPi+pDpgOigUCqeGCnxateNymhYfCKf
         bu4lGQD+JEP5xv2lBqrONOZrwLiN+sKy1kWYqViHe+kAQKLG2mhizWryL3OXOQheYAbO
         aTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HsH4ttOoWhD1id+RBZfljWV1GsDkrEUjZ6teO23jIKA=;
        b=H+0Eud1saKYxI+d7s8V8CXoe3EYcIbn2GGvMd8OKqPZYSpAOhC4bEeyxHGEoYottNq
         jqZZLa4hJpTP5Aeb9at9Hf7ivLe3vZWenZOVSmnW/FHZStS8ejuKHJlqsSN69l559B2K
         mGjHtiYE2QCdkNNgbxM6LkL/zAmyiI/6zyFP00HxicXo1xmr+5ob6kelQyMcLO7BCXfK
         c8XkHwgi4+Z4V1VnQrBW5u4A+SlyDoJKXQyoAAZQbgHqyXXZwTV5uF8EaXtf3EwfuRzd
         Bh0jAcPO+6jTo7oBcn63WBv3wTw52Pt07kOBMj/NZDOpFmFLGyY8TkS3aVusDtzSqSUx
         Ptkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Charlebois <charlebm@gmail.com>,
	Behan Webster <behanw@converseincode.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 020/102] fs: compat: Remove warning from COMPATIBLE_IOCTL
Date: Fri,  6 Apr 2018 15:23:01 +0200
Message-Id: <20180406084334.454436492@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003681793972685?=
X-GMAIL-MSGID: =?utf-8?q?1597003892118812809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Charlebois <charlebm@gmail.com>

commit 9280cdd6fe5b8287a726d24cc1d558b96c8491d7 upstream.

cmd in COMPATIBLE_IOCTL is always a u32, so cast it so there isn't a
warning about an overflow in XFORM.

From: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/compat_ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -833,7 +833,7 @@ static int compat_ioctl_preallocate(stru
  */
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
 
-#define COMPATIBLE_IOCTL(cmd) XFORM(cmd),
+#define COMPATIBLE_IOCTL(cmd) XFORM((u32)cmd),
 /* ioctl should not be warned about even if it's not implemented.
    Valid reasons to use this:
    - It is implemented with ->compat_ioctl on some device, but programs
