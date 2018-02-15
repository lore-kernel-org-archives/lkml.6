Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224yEfD09gnJRozQyCVlhvWZhMtQkQyjS/q3oLRKi7zpLFvryKa54UD1EtpjK5F1QM7gwG99
ARC-Seal: i=1; a=rsa-sha256; t=1518709360; cv=none;
        d=google.com; s=arc-20160816;
        b=kLJzohlfDucxJG8++QZjenSW/7v8z/nQEpnwW5T6Gb/W6m5iA37rcqki3hEIS2MAkw
         wbVG2cmVXOl0PAbI+KOYsAjpipqBWQTNoPbY2LTMqaTJFI2FsOhlfCnb6xeaYoRr0PHU
         /Z6n8aua+/OVfWyja8NObN4JFHCuiiZpc36avqJIP2d7GR2FeWONaLQx670VOHZ9hC9I
         xqoGYbNzotOX+soOscJgpbzR8dJ3EhFLmxcdD+A3e4Ju2AMjIBS/cswsp7BTWBkXCbf/
         GkpYruTpJa2JTszkFs7C4hGTgeAGvDfn5xbZ+5m1cGfwjqht/5nZebsNJn0ewKLMGzum
         +8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IhS5h/2pJOl4wpPWQ6EWO227xTLkCvGNTvjDjJI3dWY=;
        b=Jm7sZ4TG9bqF6eWCbY2zhjoyT4kkvf39WSGUesMzUWueUbk6utPy1Vx9SnxPIuvMCS
         USBGR4iBs/u5/RKOR5svD2TlZPGzY//yNxGvx2QrmzKTJIOF0yN96rfQG8eSrqXwLfSX
         LNThFkjpMNmXr5sdatk91UrKdmybTNlDi3Acgi+yYl73O9SGu0sh1Odp+LkZ2/Csdc1A
         rtc9SAZnCjOzuNswbC5hCxeDFg5VFzJeO9dt4mTYyg7Nfc8FSlWC5MsbHM2JSLIvdDlJ
         5Sb5ndvNc+LCtj+HyTphPDivTvrE0Nu25e4IwDfOzzikzH8XWaxlpNLxxtmHcoBrPNri
         uulw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 054/202] [Variant 1/Spectre-v1] arm64: uaccess: Prevent speculative use of the current addr_limit
Date: Thu, 15 Feb 2018 16:15:54 +0100
Message-Id: <20180215151716.092760265@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481529299669431?=
X-GMAIL-MSGID: =?utf-8?q?1592482186649834993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit c2f0ad4fc089 upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -42,6 +42,13 @@ static inline void set_fs(mm_segment_t f
 {
 	current_thread_info()->addr_limit = fs;
 
+	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
 	/* On user-mode return, check fs is correct */
 	set_thread_flag(TIF_FSCHECK);
 
