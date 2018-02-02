Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225rzclggsY+2rHj9CsB6OsNzfoGgxzAfVXoDZgJqKCwmkOt/5U4u83/OrJTPw94IGFw/qtS
ARC-Seal: i=1; a=rsa-sha256; t=1517591426; cv=none;
        d=google.com; s=arc-20160816;
        b=TMOvFBNwXSPK5yIfYCzyMN4as8YpFU5FZBxDL2avvdsb7zkjstxmejMUoYhRnKkfzi
         jTu1U/4MFFyZStvHY2zZJ/WPpUI5JjYtv3eKKwGrGAbDUAcPykM30iHHbMQgyYPDhWWh
         MbwGrY2gJged4HSdrhUtBELXSWZiBqF9+/MC/93kCXWzPGGYna/gPrneRxVleDSubrfR
         5eNPbSM6t/Y1nGjcNVMAHhV1rVX/dLi649zN5z3ZjyIBetIuWpih6qnKCwkY4fLCqamy
         /CrG1stAcjXW4DwDjnEL8g1wWvEdjA8tObH+WD/zrpL/g1Wgn1eSsakzYidI9+xt074J
         9ZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r+nZ2vg6jl+BpyKaUTxIMKLdDzkLFtI+MxF81dh01uo=;
        b=tDydXodz38vQ8pSbfIxwMH0hEdra5Ya5Q5BMGKRQDEanj/Q1bm4eLHcZgVElrg27hL
         Mk5HprvG+3+1h/2PwOApvXbIUPoymQ4hytRt4g+OATUL6IbA5oO9o1g2XfUcqJhwi24J
         jen5HlM1yR5NjqdOraYf4LSdKL1QQnaEmrq2zZ4VcYX/lhjwtCGiZ1SxvBSEyEaWLgZH
         KnRK2xn5n0EFE9/N7p8SIE8ZJRgan+DPICbCXr+SVwdg3pcv4vfzQyGEEEuS4l0WUEMM
         VOLxTmo3oc8eIRynAsaePuelhsOJ8LM8lhAaY2zjOasbcCFgYnbRTPEBHJOJ/uZIjFey
         Pbzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Czerner <lczerner@redhat.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH 4.14 030/156] VFS: Handle lazytime in do_mount()
Date: Fri,  2 Feb 2018 17:56:51 +0100
Message-Id: <20180202140841.699392832@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309946654972500?=
X-GMAIL-MSGID: =?utf-8?q?1591309946654972500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Trippelsdorf <markus@trippelsdorf.de>

commit d7ee946942bdd12394809305e3df05aa4c8b7b8f upstream.

Since commit e462ec50cb5fa ("VFS: Differentiate mount flags (MS_*) from
internal superblock flags") the lazytime mount option doesn't get passed
on anymore.

Fix the issue by handling the option in do_mount().

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Holger Hoffstätte <holger@applied-asynchrony.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2826,6 +2826,7 @@ long do_mount(const char *dev_name, cons
 			    SB_DIRSYNC |
 			    SB_SILENT |
 			    SB_POSIXACL |
+			    SB_LAZYTIME |
 			    SB_I_VERSION);
 
 	if (flags & MS_REMOUNT)
