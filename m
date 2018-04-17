Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48z8C+W/s+IzV9TPYRs8+FJpaZuA26zT5lU8pBt4EbrOpq6VbXgmgFWiKvWrqsEW63VEV8k
ARC-Seal: i=1; a=rsa-sha256; t=1523981424; cv=none;
        d=google.com; s=arc-20160816;
        b=z0eaUmNow4uziIADArntv4A9u5HOzIkCaj4JSpVuhym6dvLIEgbb7QrdrbCKaJis/q
         XYAleskd6FN+MylCUwJTLFjOvKqiDPrWucN8aDEcUTcwQdRLmAx1guOidaGV02Bhoa9T
         4YB5ewX58uqiLZD47QxvcQewxx3dMdRfV+XNSPQIjDjrHSkWbTm4ptZdmXHO67mSHpEl
         T1RD+l7twP3JkcJuUHi1lWXoGk+Bw8Jap92KJcVTj/xoLxeoetlU5glEaO4++JyxRa64
         fnwKgZ/nDrOxk4ABjKPE6U52X+RxYy8uVqSoE0KSg2GYZJuYfXrEVkVphVI99pBm4o4F
         eF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U7FdNbmT3Ua19r+CUkbkZp5zqc/mlbr39Yg15cfDROo=;
        b=t0813y3S3ZLm60QANbuSgF0YIOu6eu2mTyDbtqJ4y/6fh07UIXnddlMxye2msTTbB+
         WdYE3Lx46QPZp+BhdoBErosQ6tHYVK9u7RLkGgegUgicKQBW7xCSpAa7zZ6iVrfQaNTr
         LbKdJuyCdB0tQ3hVT2V/FnmpBI/z8u09aZ30qv0qXvbux7tEdEG952vcNAdWi4NHP+H9
         wr8Dl2AjLtYCwpSc0E0kvdtRWpGfX9l3gBgACOvW7v0EZeOl9WAgeCGbyOICRyFsmXr6
         ejEWBZmmk1L1XqQhmrlGpC4riV3ru2Nw2sa+uP2B2TkznpE5IhuUF7rA1QiBy5h9uMsx
         S7JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 57/66] s390/ipl: ensure loadparm valid flag is set
Date: Tue, 17 Apr 2018 17:59:30 +0200
Message-Id: <20180417155648.353033990@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009848537812841?=
X-GMAIL-MSGID: =?utf-8?q?1598010345481307067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit 15deb080a6087b73089139569558965750e69d67 upstream.

When loadparm is set in reipl parm block, the kernel should also set
DIAG308_FLAGS_LP_VALID flag.

This fixes loadparm ignoring during z/VM fcp -> ccw reipl and kvm direct
boot -> ccw reipl.

Cc: <stable@vger.kernel.org>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/ipl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -798,6 +798,7 @@ static ssize_t reipl_generic_loadparm_st
 	/* copy and convert to ebcdic */
 	memcpy(ipb->hdr.loadparm, buf, lp_len);
 	ASCEBC(ipb->hdr.loadparm, LOADPARM_LEN);
+	ipb->hdr.flags |= DIAG308_FLAGS_LP_VALID;
 	return len;
 }
 
