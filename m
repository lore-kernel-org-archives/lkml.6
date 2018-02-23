Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Pnp28YI5Z/7HYqXB8mm+dLP7DkvUuETHhao7+/Odqm3jbzfKWWx9k5q8Tz3p1MilebXO7
ARC-Seal: i=1; a=rsa-sha256; t=1519412296; cv=none;
        d=google.com; s=arc-20160816;
        b=F69ypgOuBxUebq3YycXxFc9HjHLLHJhYzfkEy0ghfVqhzvvVNLjAixdPVN+MVFZFB9
         WJuXoYfBSOKcqiYkb0GHUVAixeLNSwdIxCkZ/LC27WOES515Mz41Q17j3/SzwyGe/Hed
         ijdwnJpQqbzwHrB6XMESdMLoGfgH1N4lbZQ7e7Xr+N+KCMGonNAFDkoVK+g6pzKmSfZu
         8V+AbLN8li3ePEb9faS6zjq5aHFwyP7eh7mVmy7cRM/1mQOnMgHyQvueqG7ZLj8nEVF/
         OYqVJueSraY0dB/e6ljnDsurBNPHJVdBPvRydvfCQCj9GdziuiewW3tsN+5ivntQpBPn
         UCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dLj1A7+phXVtey8MA9D/tAwi9T3GlK2SMzt9cHAT8FI=;
        b=o/iOhVtusYonWAhPAoHcrPjJHqPFWNKTE1PB/JddzfR+jpT/hKKEOVo19GXm5SUwwJ
         HIPh3g8dc2zPp0h7Jgl2SKKyqIMSMVRp6V1edMH1M18jBE3S7+CzsfWTaVe4SPhu8dbl
         s0+PMN5314IZnuRPjjFex/VSnP+fbS1hwzntabqCceL/3jfkyQqqqog7ODUIq8TNVwXw
         EVw88WvXcbaMoDEexcFp74RtNWi8k/nPrttMdMeRKvGxVzNIGs/FJaBnyIqF+S6nlxHu
         UJ6ofYeSixSXtO1VUUo4QWw+Cq6HiOvAsz95lLxWD7qfiSOTL8r0MYfvFhZkY07ugBIa
         L+eQ==
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
Subject: [PATCH 4.15 09/45] staging: android: ion: Switch from WARN to pr_warn
Date: Fri, 23 Feb 2018 19:28:48 +0100
Message-Id: <20180223170716.786315194@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218290440212705?=
X-GMAIL-MSGID: =?utf-8?q?1593219268193762836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -70,8 +70,10 @@ long ion_ioctl(struct file *filp, unsign
 		return -EFAULT;
 
 	ret = validate_ioctl_arg(cmd, &data);
-	if (WARN_ON_ONCE(ret))
+	if (ret) {
+		pr_warn_once("%s: ioctl validate failed\n", __func__);
 		return ret;
+	}
 
 	if (!(dir & _IOC_WRITE))
 		memset(&data, 0, sizeof(data));
