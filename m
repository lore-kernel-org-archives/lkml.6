Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227DhWFrmJantLu9InWZynPiCPs5/cm87MI41I3CYvBiK6QgYRW59Jsl+b3AKICAQUfIF/2f
ARC-Seal: i=1; a=rsa-sha256; t=1519410829; cv=none;
        d=google.com; s=arc-20160816;
        b=xHUrRgPR3WTTMVAjFXy7uSV47CWEt4swh2a7Eaf4yfuMMByEUhiddeJmogddbKd8dy
         bzbxmsHw44tzVEANyb+f0IgEBid0HNIs1F0U8KR4rtErOkEtxfGuZXEdaPYIICQ6pX0f
         mFQroC3LNUr93c1V1FNSWSJAe+gjBHqajfYIjDVAd++nRaSBko1Ld3lZm4zLZV5OMAOZ
         jwZb32jgg2j257sZvOD7qUcojqi7ooiG2lLLlEqLabHfbVbDNlppvkVhlt7atd11fttR
         oNBQGSKH2sLrbBDquS7ffp2CttVkpOYLU7LZGUw4WSECv1SklQWW37JMN5GZPJYsnO+v
         9HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rfGYLUpsO9GpTb+AtncDoZVdvASqQ9I8aAwbB3TIjiQ=;
        b=yVfGfER15wTAPHXhGAlmPv9p1ExhjUzOWXHKhkQEQ2gXkeQ7bWXsAjQxJlykqBTRcJ
         wbe8RugcyXBVLs1cGaSq27ZaqrczrrGr+hP/OtaHjuP9p33bYBGRsOB1FdvIxAkUNyfU
         ykztwDOqO2+StGhgb9OFapRW4G6+/+XnFAv2pJnkxqoD/KxxuKI8WLqcqU4faxcgKcAk
         CltY4TpGJpMliepLBjmHG/bworQ0FMHanyt00APhZSH9qoCM9+e7ySuQ8yB172Arzf1c
         qhybKE5Bg18P6LdI9RTp8ayzOPkV/f66HNC1v8FboT9BlY7csNy9vofU7fQG1qELP+0S
         3XeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.4 027/193] binder: check for binder_thread allocation failure in binder_poll()
Date: Fri, 23 Feb 2018 19:24:20 +0100
Message-Id: <20180223170330.322805082@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217729843622461?=
X-GMAIL-MSGID: =?utf-8?q?1593217729843622461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit f88982679f54f75daa5b8eff3da72508f1e7422f upstream.

If the kzalloc() in binder_get_thread() fails, binder_poll()
dereferences the resulting NULL pointer.

Fix it by returning POLLERR if the memory allocation failed.

This bug was found by syzkaller using fault injection.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2622,6 +2622,8 @@ static unsigned int binder_poll(struct f
 	binder_lock(__func__);
 
 	thread = binder_get_thread(proc);
+	if (!thread)
+		return POLLERR;
 
 	wait_for_proc_work = thread->transaction_stack == NULL &&
 		list_empty(&thread->todo) && thread->return_error == BR_OK;
