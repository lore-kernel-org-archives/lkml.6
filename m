Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/aOqrZfW7iaHWKCD45Fe2dhU+dtZyXcnM8y+J/cYgs38SXn52Lh1ZLzr0KpdW3yOSPljZ9
ARC-Seal: i=1; a=rsa-sha256; t=1523980952; cv=none;
        d=google.com; s=arc-20160816;
        b=t32wdgJAlLmP5TAa17sUMooLLxbEK9F0/SQO+fyVKT5kJbKPpeHx1OIqk+Tk4jN/9R
         RvCW2S8b4I6qdzEZTEqWXQI889uPCY7JvijkdtDqO77/vfGtzA61LBDaVOK32pZugGOv
         uvMC5ES/xhk0Sj/N2l2asUPCWNZ7FU36HqdKXwZMCkbCkXPPDS3hm9IzkcQ7bkh61DD9
         Lvw3sq7ZYpe+VDTTvWmWYE/pfD9qIM+LVO66vMlicAit5YMrB0rqMXkWMkM4MK+pePpB
         1Ss2u97llEbW5rgmHQU+G71ZfTQCeRnXBOHeYSQN4mXQ59oBsjjP58aqT5RsjHvZfZ+z
         s3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tR9dd6KPl0x9CksxWhGSW9dEzOCDDzN0hsOKuRDQmYU=;
        b=qPLkb6rz/FoxZceMum3q46yo9SdrprmImMjl47ECYLrR59z7PRXUQh+ocKapLHvRvv
         dCZQJLPQyuTxv90g2CdyGTMjaaRoZSgdjKOrVWHAT3c0M/eQdnSfGNimRdA3NQpnxLPQ
         ryv6A1dI2ZmXJ4zvM3wy5BcJP+OTqNnmz3hxkkaMkVCFecCI6HQ02gYNiU1zDxURZqYI
         7VuZhGJDsAqwq4tDV6Adno0nJDOyqhjkly/4hIdCJRRtAzp0wulx9/D3r8NskaSflL+P
         PX6lfzejNXeyPjhi/zisFViK1BN5jAVBdebe4kj/NlkGeWPNVynCvnchBKL6P7UiiR2e
         Lm/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 62/68] s390/compat: fix setup_frame32
Date: Tue, 17 Apr 2018 17:58:15 +0200
Message-Id: <20180417155751.859461823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009851419242225?=
X-GMAIL-MSGID: =?utf-8?q?1598009851419242225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit 8b09ca746a643ca452cd41a522046a96ee5a55fd upstream.

Git commit c60a03fee0e5 ("s390: switch to {get,put}_compat_sigset()")
contains a typo and now copies the wrong pointer to user space.
Use the correct pointer instead.

Reported-and-tested-by: Stefan Liebler <stli@linux.vnet.ibm.com>
Fixes: c60a03fee0e5 ("s390: switch to {get,put}_compat_sigset()")
Cc: <stable@vger.kernel.org> # v4.15+
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/compat_signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -279,7 +279,7 @@ static int setup_frame32(struct ksignal
 	if (put_compat_sigset((compat_sigset_t __user *)frame->sc.oldmask,
 			      set, sizeof(compat_sigset_t)))
 		return -EFAULT;
-	if (__put_user(ptr_to_compat(&frame->sc), &frame->sc.sregs))
+	if (__put_user(ptr_to_compat(&frame->sregs), &frame->sc.sregs))
 		return -EFAULT;
 
 	/* Store registers needed to create the signal frame */
