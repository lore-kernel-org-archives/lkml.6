Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrYPN5mtFhta5P0huVKryYJ+TOVzKlv8qXZtzdNrRyN2DXPVGxiM846lqkc4WFzRAnY70Yw
ARC-Seal: i=1; a=rsa-sha256; t=1525116508; cv=none;
        d=google.com; s=arc-20160816;
        b=uklMfTg8jl2cfNFoOtVSyk8IjZs+ZtOSrHIu67Ukg6rbybIVdYVvsKN0ftULPZ+QKS
         h6LF5G90aWOOD3w0J7ZbPkW4oAMSAv9v/XK/owlwvABsDap8ejISo5AdbWoimKIQfe/R
         a2Z9owDUUzh7K83+emVibSS41z9Lt5D407x6DLZBBPj6B3H4N8BqVUpOP/i48BUayC8O
         mGZw9X189rS2o8t0k2AP2WprzXCqi/58xqh1FKHT+Pl63JMRIo65SoYb0Kt18JkZYNgs
         iIAhfJJ007s5eXnE3KNjNjiE2VfYv/wjq6e0TUDoYZAIWKw1TDeV2qpTaM6pLynRrnXa
         eR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=eCbS8Jgpv+Ngp60Ee/oygW4nnTMJnymqAYuaIqTYjoo=;
        b=jAmHutYi61B77/Kiu9UXpCozEgpnaCHnwgAIs8wSkQmujDiFfbQPWJ9My610Tg+/Lg
         QItkT4sn8kHa32t+hxw0YPDawAQ4PRAhHQOHaEbrQFVcsefWSHCiStTIlcbk7UTObBhQ
         malkxcTPTl+gB/mC34VyMKg9sZAInI7p8FZzH8KpI//l6xeY9vBO55hxMHyYs6SFP5Io
         JUhUtKlvz6b/eGxjZgsUuxqTZrp9AQnJRCkV2145m6z98h5E2UUqOBgm2ixEbwGqHqc8
         geNI1yME7De0eljvY/CUQJiUYU33bRaCcvHgOyrN2b3bNe4Yb2Sax1wCWXd4vfyGOHf4
         BOUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A7A22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 064/113] bfq-iosched: ensure to clear bic/bfqq pointers when preparing request
Date: Mon, 30 Apr 2018 12:24:35 -0700
Message-Id: <20180430184017.930270070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200567169556340?=
X-GMAIL-MSGID: =?utf-8?q?1599200567169556340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 72961c4e6082be79825265d9193272b8a1634dec upstream.

Even if we don't have an IO context attached to a request, we still
need to clear the priv[0..1] pointers, as they could be pointing
to previously used bic/bfqq structures. If we don't do so, we'll
either corrupt memory on dispatching a request, or cause an
imbalance in counters.

Inspired by a fix from Kees.

Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reported-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bfq-iosched.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4911,8 +4911,16 @@ static void bfq_prepare_request(struct r
 	bool new_queue = false;
 	bool bfqq_already_existing = false, split = false;
 
-	if (!rq->elv.icq)
+	/*
+	 * Even if we don't have an icq attached, we should still clear
+	 * the scheduler pointers, as they might point to previously
+	 * allocated bic/bfqq structs.
+	 */
+	if (!rq->elv.icq) {
+		rq->elv.priv[0] = rq->elv.priv[1] = NULL;
 		return;
+	}
+
 	bic = icq_to_bic(rq->elv.icq);
 
 	spin_lock_irq(&bfqd->lock);
