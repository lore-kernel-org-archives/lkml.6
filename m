Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELstJQtXDZrp1Rw4zsTdP0IaOt2ixksJJBpvfFRlIB1kB7Ewy/WSMfuMfZUtxP6kX92yMHKh
ARC-Seal: i=1; a=rsa-sha256; t=1519411833; cv=none;
        d=google.com; s=arc-20160816;
        b=Op0GeeR+VghrPoru7TG6T86ZZNCTo8tG9P40Seu3HBnL8N7V8nae0Ybaceg2VtG85F
         oIa4Zmva1J2vu3fa0YiM24k5rkaz1IqSfvb/4ozbWMeFs6kwDuHTlXQ7ePXJJiOc8cL1
         YZlUR2AoLxApiajIYCG52Y1Z3pTMVnFHj5+emnusblppuCcMN9MCAd3klPS6mRoOFFbr
         84QJnvDZ9ukrUadWZyQl+gjpnR26ZxUlswilGxVMpLDy8bWo9+mb0JzDqBdBq3bpqXip
         Z/7LBe/yjYaXMAQG9Cw6Ha9sv+QUfLBtgEp5o1AlUQvCV8sLQpZxCqvqQvsNLObBMpuE
         CtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bSrWn7mNvLChBN5Nlq4cCDoPyP0iP5+pgnsnTvQNzso=;
        b=lCCULNFHKNriEBXUDHTLU1S4V8LF+N9aYYllkFemZR+zQRT4f5PpMwdgWywSdNgzmU
         /Q4S/ro1k2fsQT+nLQTQ3bryhZpEAcKInJpvesK5DpQWTVedWMDeNKFq2SrYyKjQFzpS
         OVB88m/6d6tJaGzgXCioHr0jMA181JWYfuI7BhEnlEn//0y3rwsYGJaEWUdgSIMxYFZf
         LGKvkC63fWhS5u2l+YAxoQ0CIDpU23skpqSKOMpSFRG68xdlPGzqhyeNt4H8l0hbez0B
         hpkwvJ1GXoLYyKyfFG1hZ5ksch74WigY0HSAohrCLqu0QBVtf9jjjO4N/OFZbVHt03YU
         Zjlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+fa2d5f63ee5904a0115a@syzkaller.appspotmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.14 031/159] staging: android: ion: Switch from WARN to pr_warn
Date: Fri, 23 Feb 2018 19:25:39 +0100
Message-Id: <20180223170747.053071254@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218290440212705?=
X-GMAIL-MSGID: =?utf-8?q?1593218782562908717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

commit e4e179a844f52e907e550f887d0a2171f1508af1 upstream.

Syzbot reported a warning with Ion:

WARNING: CPU: 0 PID: 3502 at drivers/staging/android/ion/ion-ioctl.c:73 ion_ioctl+0x2db/0x380 drivers/staging/android/ion/ion-ioctl.c:73
Kernel panic - not syncing: panic_on_warn set ...

This is a warning that validation of the ioctl fields failed. This was
deliberately added as a warning to make it very obvious to developers that
something needed to be fixed. In reality, this is overkill and disturbs
fuzzing. Switch to pr_warn for a message instead.

Reported-by: syzbot+fa2d5f63ee5904a0115a@syzkaller.appspotmail.com
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion-ioctl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -71,8 +71,10 @@ long ion_ioctl(struct file *filp, unsign
 		return -EFAULT;
 
 	ret = validate_ioctl_arg(cmd, &data);
-	if (WARN_ON_ONCE(ret))
+	if (ret) {
+		pr_warn_once("%s: ioctl validate failed\n", __func__);
 		return ret;
+	}
 
 	if (!(dir & _IOC_WRITE))
 		memset(&data, 0, sizeof(data));
