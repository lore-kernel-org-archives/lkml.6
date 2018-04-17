Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+xEEcOeRvHIDODw0xy8PA1gHKCED7qiGMfTzAie0FrSOhfOuqsOyKMifz7C7nRYRsiiHGM
ARC-Seal: i=1; a=rsa-sha256; t=1523980949; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbooFosD47TBG3j3jTd69vnT6VYfLz1f5Z80Blbw9DfX20bbguBCinn1odpJ9c27kK
         orpD/w7w0CYax8DddZpjrMcbvQiinfyqUkctft498tATQkzVUwKOAg1zUqA09y+dTxtq
         cj0fI0IZCIuzO8+oIU84HJkmsL0MR7H+CMChux/sr8equ+1KvlGxFwz10lgPm80n/asO
         0EZE4LS8JoE0PxFD3jwXKZ88NaWpLpUAjIj/syGDoiaqXJGhaX7Gmev4QYJnxb04ZtXm
         bhUDbNb3Uj76iWzJKHpxzrm7imf2cKm/AgazbC3U2n517e+VGGBTkX07Lwpw6ut/Ovmn
         BovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O9cgaknGAJywU5WnFIkLDKrQeoAjIgVqm3HpakqyUPY=;
        b=muyfLMQx6INfJp62TLPf61H+/LKyZz+3alqUlekjtmiwNgFyTtgo/bY5Co2NaPjrWC
         3DkzzcE+9N/CURN7M3cXBqrwuYEhi+kpz/wwVAczhiS7G8VKEiYWNrlqyP9y2XdJ6Wqp
         z/TeX0B3f6bzI47N4moj432cYh61zEgJN4Ib8kHSPWrWyFxPXdtlCk+Ixq1oRnUeYPfJ
         CA01ABy3Tj8QGhhFFbn31GDCXe2wTc5eBRO3pYx/mNlUmh+YUGi/R9+/Ctc80o5LAeQn
         eJNkgvukIv2Rpo5qiYu3YT5WeFiq4jYnCSSymIsA8yzGQnqSWZ3+ha1Da/59Is14xkCo
         Y92g==
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
Subject: [PATCH 4.16 61/68] s390/ipl: ensure loadparm valid flag is set
Date: Tue, 17 Apr 2018 17:58:14 +0200
Message-Id: <20180417155751.817897205@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009848537812841?=
X-GMAIL-MSGID: =?utf-8?q?1598009848537812841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -776,6 +776,7 @@ static ssize_t reipl_generic_loadparm_st
 	/* copy and convert to ebcdic */
 	memcpy(ipb->hdr.loadparm, buf, lp_len);
 	ASCEBC(ipb->hdr.loadparm, LOADPARM_LEN);
+	ipb->hdr.flags |= DIAG308_FLAGS_LP_VALID;
 	return len;
 }
 
