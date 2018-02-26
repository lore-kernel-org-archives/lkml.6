Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv99/uTEaSDrxQUrBjJi++U5fj0ZC43wOugYpS6GHLQVKwL3GxDr02+eENmlap5qDj5oOuC
ARC-Seal: i=1; a=rsa-sha256; t=1519676675; cv=none;
        d=google.com; s=arc-20160816;
        b=B46hgTltqf/v/bnPWoEaRRG5wX1ObaEIhj9W2gByb3nYvRmW/rN0mwXk3m+UtmYegO
         NohZoUjLXikq0F6/XUGzi+JbndQ/BZfZOpxtiwFL7czc2StYUoV2kDeRiP8hK/igzEYG
         +DS465baqq+dquI7oNnqdznCpS8YjNVr9H2T9JMKX7Pw0QlOTapfysxuRJsLX5Dr9vWf
         OMlfhbhZZ1xN0weJcGhlBGP6M5YJzW+XJzrfxOc3eYKAnNB9kTc2jZHRCRCK6+NKb9fl
         khncnTfUso/kvnlvd6rXpeQ2McUrvKZJGEV0R7uVfy2CIfQW5nmPGaHMKNlhrcod5Ax2
         whZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/VvjL1CR8fYSJKNgwusDLHpQSqJkzAAFrK5PnLQL1rc=;
        b=1KuCyc0VRhEiY6oncasbhY43ITfnvAZrpDzxlin4YtH5UTusYznSYbB42XjeI4Dx+5
         y8sAHIHUlQ67xJX1NjtFOhFE5neibuOSgEZFZAKjSZlp7jTtEo1TVNW46b9wPix5z1gt
         jzArnuA5XXHNO7+83maRhKOKa8QpI0Rhd0UbaU9IZkiHvcxgdDPRDsrT2g0Iu5n6rmOg
         x/uanzgzbCGCVx5j4IQgLz4MfFm0Gg/7RO4wQndWIHL0RuLkjhwF747nw4OFJPqrfG63
         liRAnr8XhAt1ajdUwtx1u4gzFs3ZtGbvnD5pUDhG1uxxMKL9weCivf3m4Nhj9wsdqpWg
         BYOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>
Subject: [PATCH 4.14 33/54] arm64: Remove unimplemented syscall log message
Date: Mon, 26 Feb 2018 21:22:10 +0100
Message-Id: <20180226202146.045950031@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496489575231525?=
X-GMAIL-MSGID: =?utf-8?q?1593496489575231525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Weiser <michael.weiser@gmx.de>

commit 1962682d2b2fbe6cfa995a85c53c069fadda473e upstream.

Stop printing a (ratelimited) kernel message for each instance of an
unimplemented syscall being called. Userland making an unimplemented
syscall is not necessarily misbehaviour and to be expected with a
current userland running on an older kernel. Also, the current message
looks scary to users but does not actually indicate a real problem nor
help them narrow down the cause. Just rely on sys_ni_syscall() to return
-ENOSYS.

Cc: <stable@vger.kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/traps.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -573,14 +573,6 @@ asmlinkage long do_ni_syscall(struct pt_
 	}
 #endif
 
-	if (show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: syscall %d\n", current->comm,
-			task_pid_nr(current), regs->syscallno);
-		dump_instr("", regs);
-		if (user_mode(regs))
-			__show_regs(regs);
-	}
-
 	return sys_ni_syscall();
 }
 
