Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/LbTnfvikbxyhE+u+F/TLx5FDhRaPeAHW7E7xc7jTUd81Y1pADMbLRmVIzqllBKxJ+9mg0
ARC-Seal: i=1; a=rsa-sha256; t=1522168875; cv=none;
        d=google.com; s=arc-20160816;
        b=BgqC+y8wtYwaonKH/SGc6ocM3K2v9zf6m6C94huMcU+UcEpO8+qZSHrPxFAPimKdoy
         ADmwNtyF/Ix0GaBxo0CajncAGSVVwwTq+cyL8g3fPoo8Bl4XUQ9hqogfJQp2QtLB8XhP
         R3a4aMVn6zx2FLtm2SFri7mT1IEth3HeAB6VkpxWU8bDVtzCgHOadcUOvLBD8CK2WLFs
         Z+vVHwFC3VmMy7SX3lew8jV5MBCz5F9c4cZ2mYJQEaw//hMT4sXdnJ+8ZoikDMFHslnF
         BE0ucjKTz7ezyRiVNXpbeUJTqe5V0lEddxxs6yKdjecgirQjzMRXWnGx7hVMrd790NK2
         mapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NJwtfjVcBeeCosBjP7eg+Ezk2dMSpT99P0XvyueRQio=;
        b=f3Lx1xN4xFxhILFm8fT+LcF77MNoV2WQ/BOPDY1ZoGZqA1V/UEYC/SLtcAj7Cyyj2p
         Z3OcW6eMsj3kmu5A0B+DAcgk79aszLoU1x+C5SSvNZw9qRvviROhK6/lCM6TCdS9NFza
         b9grjpBLp6+fuXaejKU1TT41hdmXG+F6UuzM5ylsgtqAicbrnnYbJ3Zz34iKNcPwNYia
         H943SPcRGfFdxeo16xO9KRzNaWs95RNW+fvYqQpOAwpXTA0/sqwhTMS66IcAJOPwyLnb
         qeKeKMApqyiDqNWKYVlMwjE9K3shE4x76cWm5qYn+vZP5ogX4jYr9K2f5UXhTaku/pHB
         5bAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jessica Yu <jeyu@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Leon Yu <chianglungyu@gmail.com>
Subject: [PATCH 4.15 063/105] module: propagate error in modules_open()
Date: Tue, 27 Mar 2018 18:27:43 +0200
Message-Id: <20180327162801.512350533@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109750447975140?=
X-GMAIL-MSGID: =?utf-8?q?1596109750447975140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Yu <chianglungyu@gmail.com>

commit 3f553b308bb004eb730da8e00a28150c157c7724 upstream.

otherwise kernel can oops later in seq_release() due to dereferencing null
file->private_data which is only set if seq_open() succeeds.

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
IP: seq_release+0xc/0x30
Call Trace:
 close_pdeo+0x37/0xd0
 proc_reg_release+0x5d/0x60
 __fput+0x9d/0x1d0
 ____fput+0x9/0x10
 task_work_run+0x75/0x90
 do_exit+0x252/0xa00
 do_group_exit+0x36/0xb0
 SyS_exit_group+0xf/0x10

Fixes: 516fb7f2e73d ("/proc/module: use the same logic as /proc/kallsyms for address exposure")
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Leon Yu <chianglungyu@gmail.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/module.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4223,7 +4223,7 @@ static int modules_open(struct inode *in
 		m->private = kallsyms_show_value() ? NULL : (void *)8ul;
 	}
 
-	return 0;
+	return err;
 }
 
 static const struct file_operations proc_modules_operations = {
