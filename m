Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227MlUdlUCaOzJ7kAcC0WCIUU7uNqZCZbuZKj8vhf3Pmf/+RugjDeABwB1g1Rzudzx9QlGuT
ARC-Seal: i=1; a=rsa-sha256; t=1517591837; cv=none;
        d=google.com; s=arc-20160816;
        b=dEJ+Qm3wen1nevJ6nIZFJzcZrNTCkUcOJv6+t3wPO/XTha+qfN+lOC+xy9EmgqwHXU
         Fc2+4XgJeoNJVPyJWvjvmRMarxdNPyD1kn/vVLh9R7V+KhJntWkSSrXNWbgvLo3QZEY/
         nmwpPY/SAmLh6cca3wFCzUX72FKEvB1m2md4aBFgoTSbxCgtNrotPn1Hu9NyiQpuahrW
         feHy10eBcsaIszkJccL5rfmQBRQJbChFAwpZPAuxdRr3miQ7k/w/uUK9IxHMnytcVI6f
         yr+nEo4MlUmthywb2scbZbgGZRLgxazzn8jnLXVRPtxa20AzoeGaLqfHEj6E8dBFY4cT
         8leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=skOWize4IB4DRwvFrMJfkNRshixAZZKypD75IpoAbGo=;
        b=PnIAnBkmQfVl+0Fh0aftWNjQEeEbekdg0T3yBCIhnZNEmXL52XKHlRcF5jTPIbB5vJ
         0bAPpeXLtAh22iKRLY2dCqvrUAc2uNUS1LtnpvwLY0ju5RdV1i3IL09Mlzjms5QU8JWa
         N1yxTXxlqMCbhxjQRryUMfxfizVXaYBjFDwZkIiEBSYPPVu2HYc5xXBW11efh4caTIRZ
         cN9bOHLq6Ipii02MUXy9DyKxXG6CtJ5sAEYozeBqKgqGyM3sGcR2zgLBc7zoxc+WWtN8
         z/LnEi6iKN6vWtCFaz+qu0CrdztEz9G5UX+2UQfosY4qr/zYNQ/yxzCc7HPRj79007f0
         4BHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH 4.15 52/55] test_firmware: fix missing unlock on error in config_num_requests_store()
Date: Fri,  2 Feb 2018 17:59:10 +0100
Message-Id: <20180202140831.060191210@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310187133534122?=
X-GMAIL-MSGID: =?utf-8?q?1591310378893280379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>

commit a5e1923356505e46476c2fb518559b7a4d9d25b1 upstream.

Add the missing unlock before return from function
config_num_requests_store() in the error handling case.

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_firmware.c |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -371,6 +371,7 @@ static ssize_t config_num_requests_store
 	if (test_fw_config->reqs) {
 		pr_err("Must call release_all_firmware prior to changing config\n");
 		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
 	mutex_unlock(&test_fw_mutex);
