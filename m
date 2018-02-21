Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227imAJBfoV5EZXfVw1WbcUJn2e3fJYk/jBCLlIcv+Ep+ZG/u1j8B8m8WQ/znpUfJdcM7ykh
ARC-Seal: i=1; a=rsa-sha256; t=1519218225; cv=none;
        d=google.com; s=arc-20160816;
        b=IWLQOk91D8NeY6gvwHeAfYHf3PuokRNHOKjvIERTtGI5gxNS765B1VAZhsPcQGBbk+
         Tqwm7CcViWkCz2grsV5QrdGYeHK+xubXUjDv8lu2BWugEquLu8QfAM6lXhk+kUNiqTwh
         fPslDMSd2JFv7umigiiLy3JnjrlnaqmV2x5/gsPkkNLvRM43pJxLwauxDjUG0jxx38JY
         pRTL7e9eZ1YKqDVq/K80++OMPUFgMWHmxaW6pnhrclQtqbVtBcEy3oUKYb4hM/axx0+V
         +I18Ui2MV5DsJtAduzVSW2f0t0+ai1GvCdfFFl+Qv74lhUDA7e/uNiAMcet4H6qnrGLH
         G4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nOWAXQaLxaDTaEg/dPlIXJZ5RK3lq/RfCduVZgYflwY=;
        b=sgzbimsNbQE7a3pMZgnbMT71NGN+VwTEzDuKypwvzZt75jHilpvQ05U6BtFnnH99FL
         dyGlNmMgjV55aQ/bo4tc/ZRyeWaBFRXxeU1OJ1LrbytlZNttQMucbRI+w67ow9rvxwuv
         jlINPuFY2aPwXoQ5UkvW4F6Vh4tn+UBATlL5e3EvuTPKRhRS3h5TxoxuyatDNFfhrbA1
         s1NJEUNsXEYnMx7fSGKDoctLIDk1dCaMmyrGJWHuBWr0WBSjI1/rOz/QBX0nXipauvKc
         b+BhwjplCcdsutaAuOPeWhIkizRbAahqCP+keYDZnLsHLFrZZAd0WCC0dMLu4OX55RE+
         4Kug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Markus Elfring <elfring@users.sourceforge.net>,
	David Disseldorp <ddiss@suse.de>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH 4.14 131/167] target/iscsi: avoid NULL dereference in CHAP auth error path
Date: Wed, 21 Feb 2018 13:49:02 +0100
Message-Id: <20180221124531.795249321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015199328743705?=
X-GMAIL-MSGID: =?utf-8?q?1593015769687994364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Disseldorp <ddiss@suse.de>

commit ce512d79d0466a604793addb6b769d12ee326822 upstream.

If chap_server_compute_md5() fails early, e.g. via CHAP_N mismatch, then
crypto_free_shash() is called with a NULL pointer which gets
dereferenced in crypto_shash_tfm().

Fixes: 69110e3cedbb ("iscsi-target: Use shash and ahash")
Suggested-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: David Disseldorp <ddiss@suse.de>
Cc: stable@vger.kernel.org # 4.6+
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target_auth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -421,7 +421,8 @@ static int chap_server_compute_md5(
 	auth_ret = 0;
 out:
 	kzfree(desc);
-	crypto_free_shash(tfm);
+	if (tfm)
+		crypto_free_shash(tfm);
 	kfree(challenge);
 	kfree(challenge_binhex);
 	return auth_ret;
