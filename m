Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsu8nu9M/8/W2ggg/UsosV73fFmVxEqkOAbA3XY3BDsxxECwdneoLyD2zp6vmpX/XuV5+9Y
ARC-Seal: i=1; a=rsa-sha256; t=1519411599; cv=none;
        d=google.com; s=arc-20160816;
        b=inS5gL/SsFvNZ6dGXq8xdulGcTyNQXKFS+1gvMgtMxZGU6HRl/mAcZY0p1l9fOJ35u
         mqh5MEnONgA2fFY0PvaWs1yEEFsH5igavgt7/VMmf4o6tSQjjnUCgOzrSehqpO7aBF8N
         DthVlSzh5A7Mm7CjzE7vZ1DDNKcEEuQMkTiYwAqgo60OYJS12W+eGt/BXe/gXQbY9BF+
         967Co/oAspWbo+vbjjDkYo8b9mel3JToJcR7SoHVa6iVrNLiMQp/dQh5l3kenu5FEn35
         w5uXR3oR3hrWsihzp1FFTVrDfbMwtvPRJ5RfN7k1ZzrvU8sh2kyR6ihgrsKF8K00HBoZ
         c22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D2zQOl+4vQMO4iz9LnjV5Ky0iPAGQ1KjTWScFFRrSNo=;
        b=EQBPr1VNz6HzLWsQ3LZtrccx2os7dg3cs+77vtniJ5GjC1YSZcGLDViMEcBIrtE6Nh
         a/vA40MrIt8p0MDCPq2jZMtocNe++6H8PNi2fO25ILD/rzB9gs2juFJfeO23S7XHpoIv
         ZwN5Fof25X2YlYD2vnzbknTTM3muKS1x+/v8Tbfb/wgfxuFVJemuTfZKDylrlaSEgQZM
         Kq8LEZpwP+BAU1acU+EZBsMGyM0JOmkIlGDFqnJGFzvDU9+RlJ/vBoeVF3phh6s0fLb9
         patkkxxOyt4bTTFLvKHYcOPn9jdUXKurk0zQliSKxyG962cPbcjnOyl0yxa2AVZ1FQl7
         CYQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 099/145] usb: musb: fix compilation warning on unused function
Date: Fri, 23 Feb 2018 19:26:45 +0100
Message-Id: <20180223170737.634254174@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218537345087042?=
X-GMAIL-MSGID: =?utf-8?q?1593218537345087042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>

commit c8bd2ac3b4c6c84c4a7cdceaed626247db698ab2 upstream.

The function musb_run_resume_work is called only when CONFIG_PM is
enabled. So this function should not be defined when CONFIG_PM is
disabled. Otherwise the compiler issues a warning:

drivers/usb/musb/musb_core.c:2057:12: error: ‘musb_run_resume_work’ defined but
not used [-Werror=unused-function]
 static int musb_run_resume_work(struct musb *musb)
            ^~~~~~~~~~~~~~~~~~~~

Signed-off-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2043,6 +2043,7 @@ struct musb_pending_work {
 	struct list_head node;
 };
 
+#ifdef CONFIG_PM
 /*
  * Called from musb_runtime_resume(), musb_resume(), and
  * musb_queue_resume_work(). Callers must take musb->lock.
@@ -2070,6 +2071,7 @@ static int musb_run_resume_work(struct m
 
 	return error;
 }
+#endif
 
 /*
  * Called to run work if device is active or else queue the work to happen
