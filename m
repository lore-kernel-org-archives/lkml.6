Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2250e1SN+FHB/gaLW7OSz3aQR6m+qBdoqOWxQZ6g/Gk1IxHS4zRM7dEdGlG9+t/koYvTGQ5T
ARC-Seal: i=1; a=rsa-sha256; t=1517855171; cv=none;
        d=google.com; s=arc-20160816;
        b=KIJX7f02cAxNrPdb3NJuTLz1EU9TM63T1rVmgzuhq2h0i6HhNVkf5SaINzbomHhttz
         MX1I48T5kiJnehnv2eantu2AxXixX7zYHDdqpMWKjK7d7K6g+Odw5fYzhZRJRZy7+38g
         jj+sVElzY4x66D9TGp6PulTe5ofTnrXJgj9ub+XOrhj5zqYoJuxZPQel7hqlpf8riJP9
         ELZqBAN4fulxOsu4sVKZ5ZJ9fz0zbgC82cHbJhr/67sWQEMQQqbbZ7yqJMcaZY5DRr0f
         9cJ6gkPJiZKnLQI7R47S7TI52GfLvD3Q7h3s1JKTNjWEtHKvpxDXGvwUBgdjgaKULCog
         xBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Tgr556sEa3w78jb1yunaM5XIxyU+K5Wd6U8bGOUa754=;
        b=BjQ30HwB+P8Wow/1kN5DUGiFOt6FCWsJ5QZALxH7h4cSxBd6j0bVB0z437l1+P/otv
         mWjj4jqhbwns+WqyedcD0lKFw5QT+3YVpK+zHykrQ6H1LEkzRbV6wUBCkjS2Y7dR2A4H
         /2+7ToFSOHzCLTsJg0vKcAV/3rm3rKxO75VtzqluOmoV+ZkyPx3K5lsdZYtRALlCgDIv
         gxtu1PFkGUFkH/bEMzvVPvtqyaPU6vJr75YUwWF89M+/cG0UM2jQy3LHLwlse0LOFBXC
         or7emkjOsOgHWaAnY11vL3gQICOHXF3X1nzPQFO7+c5Ur+iQZeYMMrNPFgnSOCQGnvcL
         cVAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bo Hu <bohu@google.com>
Subject: [PATCH 3.18 01/36] Input: do not emit unneeded EV_SYN when suspending
Date: Mon,  5 Feb 2018 10:23:29 -0800
Message-Id: <20180205182351.842876188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586503946015842?=
X-GMAIL-MSGID: =?utf-8?q?1591586503946015842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 00159f19a5057cb779146afce1cceede692af346 upstream.

Do not emit EV_SYN/SYN_REPORT on suspend if there were no keys that are
still pressed as we are suspending the device (and in all other cases when
input core is forcibly releasing keys via input_dev_release_keys() call).

Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Bo Hu <bohu@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/input.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -668,6 +668,7 @@ EXPORT_SYMBOL(input_close_device);
  */
 static void input_dev_release_keys(struct input_dev *dev)
 {
+	bool need_sync = false;
 	int code;
 
 	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
@@ -675,9 +676,11 @@ static void input_dev_release_keys(struc
 			if (is_event_supported(code, dev->keybit, KEY_MAX) &&
 			    __test_and_clear_bit(code, dev->key)) {
 				input_pass_event(dev, EV_KEY, code, 0);
+				need_sync = true;
 			}
 		}
-		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+		if (need_sync)
+			input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
 	}
 }
 
