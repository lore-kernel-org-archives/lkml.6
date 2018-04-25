Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx491/lkOPTVSaq48/40dq5swcZ6n7ae+mxg1rUBH6Nq43PALFTKSLm7HNl+/9Ks3pLS9+QC3
ARC-Seal: i=1; a=rsa-sha256; t=1524652674; cv=none;
        d=google.com; s=arc-20160816;
        b=D+P4egpscK9GWe1L5uvKuvAfX23AAIQ2ymoSizLRhhF9bKl9NaKFKvITsjZ8j2+2uf
         w3EwwKd4XNYI5YXmryvS4PjGlgVYtZdH5R/zLOgNMLqzSXHKKFyD185RqWYR9cr+80ss
         yy6HNagEsBZGpbZjYgks5qcbjBR0GoHMTIYenKGC6cUZzxRRtvnozoW3iHZ8KnC+K1VO
         2odF0byoVX3A5SQ+O4F3n3C9pxrCba/1bc/Qkv+yhDBI84RlazDNt0gWN6Iz8AMtbAG2
         CY2CmzBZdW+lRYY7sMJsR/wBX69auYtGgUjbj8c8hZuhg8fEXAXzwl4MJ3+FnRwR7sKK
         yg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QP6JOS8b+KAJj9cpuajv9ngrqLOUYllyEpRkpWebD/w=;
        b=tLOuaXkdXqR0q4SuC4wYVijj+VhF3MQt0nrLvdQYy9QtBrz13RQ2FxyOj9ZFIRY4Ja
         S27mQvoK+PE4+nEzCHr7gNcS6//A9By1UJmWyHreh8s8//JWRRlQZy4clbkygDvhUS8X
         GVZLj7XYjntOMJUB4RVn67h++0DUbnUgoScPjoEW7/BK0kZ3CzH5sBozer1KeXLg4xCw
         SQxsKymEJClgKb38jRJO2gYT8wYiVPXeNfJmiHXuab9H+TunPKGZlsYPsZ+nJOeLyGWj
         aGfmX8gZ8MxVa268On65526UCBykmKJeOGroeZbvf38zNqAQLc99vDZwkSBKdEhW2tap
         NZ8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anson Huang <Anson.Huang@nxp.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dong Aisheng <Aisheng.dong@nxp.com>,
	daniel.lezcano@linaro.org,
	Linux-imx@nxp.com
Subject: [PATCH 4.14 004/183] clocksource/imx-tpm: Correct -ETIME return condition check
Date: Wed, 25 Apr 2018 12:33:44 +0200
Message-Id: <20180425103242.784677410@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714011461585054?=
X-GMAIL-MSGID: =?utf-8?q?1598714202488646140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anson Huang <Anson.Huang@nxp.com>

commit 7407188489c62a7b5694bc75a6db2b82af94c9a5 upstream.

The additional brakects added to tpm_set_next_event's return value
computation causes (int) forced type conversion NOT taking effect, and the
incorrect value return will cause various system timer issue, like RCU
stall etc..

Remove the additional brackets to make sure tpm_set_next_event always
returns correct value.

Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>
Cc: stable@vger.kernel.org
Cc: daniel.lezcano@linaro.org
Cc: Linux-imx@nxp.com
Link: https://lkml.kernel.org/r/1524117883-2484-1-git-send-email-Anson.Huang@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/timer-imx-tpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -105,7 +105,7 @@ static int tpm_set_next_event(unsigned l
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)((next - now) <= 0) ? -ETIME : 0;
+	return (int)(next - now) <= 0 ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
