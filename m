Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49DZpzifgHf8nFr/rBV8IdlW0cyO8OHaY9dM6NlLtDDjpElSzKdqttJksxUJWiZjm2lIzmC
ARC-Seal: i=1; a=rsa-sha256; t=1523021663; cv=none;
        d=google.com; s=arc-20160816;
        b=pNvZq9RuZPTIROylp1YtmTfM+29q2U8yFtPvISeSpUKyxQAwzTRolEJDHECor9t5p/
         r2xGnbaM7Dj07bLl478SjPJvJOiqvo5HjWOqEn25SgtnhyeLLukSnzaukr2V/ClAhoow
         RKNsoeKWeKpzO77fx5Ws/YuOA9JUH2YxmaQsbqvcEl2RI04fHehiITUYOvrC1UYomSEZ
         6ZBufmj+XDML1TZBTjX/IjN7/D4ebGjemroYZPex0lyzBJevocksFjoQxu4Na2ihmvG0
         HaVrw+aEY/LZ0jvURlLdQJVtbxTIjagK/wKmof+ms2hMw4VC2PcNYzQryJ8MFnGnHffu
         +a3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4de4PvGWpefIvPkgW9AwDUSybFFdHorXqgpnzSGRbkg=;
        b=m2pHEWGkA6tgU8UsbMKONFg/fMO/kWpOi/1E6/LQmGKpU/GBQlB8VTMrr7Bw3lBGlC
         fqwnMNNMlALhk2ts2Rxt7LS0SSoZZrb7itn3r9Dlh3/Khug4v882zKwNBQTYupEAkVZF
         EPdm5RiIYzz/BR6UjufWXpn0SMg084EcvYo8xF7dGmyvHe+h6pSZAMORchqLa7Rpc9dh
         +tn42T3QYn2kPPQFrNlFvO2nR0WIE+W/SNCpp6E8W/bO4ACpnmw151xQQM3kR9su089h
         qktgAeIZdFIlCfJY9G7TlGFuWqTKDTnRT9v/Q3QGE5VSdtEVUrJ2KGIIbfUc0rcmdg02
         n3zA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Szymon Janc <szymon.janc@codecoup.pl>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 046/102] Bluetooth: Fix missing encryption refresh on Security Request
Date: Fri,  6 Apr 2018 15:23:27 +0200
Message-Id: <20180406084338.118675485@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003604240794198?=
X-GMAIL-MSGID: =?utf-8?q?1597003963140382314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Szymon Janc <szymon.janc@codecoup.pl>

commit 64e759f58f128730b97a3c3a26d283c075ad7c86 upstream.

If Security Request is received on connection that is already encrypted
with sufficient security master should perform encryption key refresh
procedure instead of just ignoring Slave Security Request
(Core Spec 5.0 Vol 3 Part H 2.4.6).

> ACL Data RX: Handle 3585 flags 0x02 dlen 6
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
        Handle: 3585
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: 44264272a5c426a9e868f034cf0e69f3
> HCI Event: Command Status (0x0f) plen 4
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Key Refresh Complete (0x30) plen 3
        Status: Success (0x00)
        Handle: 3585

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/smp.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2233,8 +2233,14 @@ static u8 smp_cmd_security_req(struct l2
 	else
 		sec_level = authreq_to_seclevel(auth);
 
-	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
+	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK)) {
+		/* If link is already encrypted with sufficient security we
+		 * still need refresh encryption as per Core Spec 5.0 Vol 3,
+		 * Part H 2.4.6
+		 */
+		smp_ltk_encrypt(conn, hcon->sec_level);
 		return 0;
+	}
 
 	if (sec_level > hcon->pending_sec_level)
 		hcon->pending_sec_level = sec_level;
