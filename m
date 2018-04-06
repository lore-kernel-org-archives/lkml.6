Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49zyKCcuoWwFyr+wwaZz4+PNI+cy47JLZkg9NkIUlP/UwfipzPZalbZuS8B9akFJ6XpgwXx
ARC-Seal: i=1; a=rsa-sha256; t=1523022006; cv=none;
        d=google.com; s=arc-20160816;
        b=B5kBSBF4ZgK6Xw9nRUmAem7ToTlaYkLZyI+LL/EFIjEU6pw+p0PJf63+r+8m5ifh5h
         sj5Q4zhmg7gdzYiCORrJr605h6FviTpYvkWbcdS7NsmTsvfk2VDBPmrwiK1vfky6Xijr
         K/nh3KbWtVfdyxUVNfwXo8iafUlrb2xHf0VUb7vnVm7Uln/7IEGGLIoC8FEzFT+dZpSy
         Zoc8IUqDS+06JzkwCdZop6/Entv7iSZ5T41eAU7MFaBli0F6Rz+zZ4bmtzLDb/rf35uc
         b4I3Nox2rtsCX4FIJ3LiTv8GAVWhFiseRwhp3f6vo+Kbit6/xSQiyRhwQpJDveQ0z4Vj
         csGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H0bacA8JIkUWbsolRiJM7Zch/cwL2romVHcnNP0U4qA=;
        b=tQ3UqWhb/fpeAMA5vN+t6/tirmCoGSQTmK+C3klhRBTMPwBciM+t+RdPnQoZw5FDi7
         SepQApaNCMZk2zcGDkBft4ho7oy+0T/W+R56oVaWkv1tthr8fF2bxID7XJZvdwcQrzG3
         VbvjRjCuOcpIflZl/6xOgGX+kMqL2vJEN0x2FiB9H1s+tkvHz/Zq89L6KVtnzkA/RhiH
         gYIfS+nngJKMX9+HxJAl+uxJmu+AYwrG+XwfZr0PVDJDop9gFN8eq8tizURDuvaAtAmG
         EtLE4UClwoDM/mJ0uQ0rKSY5altolStzFoeCpbYwOGGU3KfH5xaQqrIoKaR2OD6+BmbR
         hFCA==
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
Subject: [PATCH 4.14 35/67] Bluetooth: Fix missing encryption refresh on Security Request
Date: Fri,  6 Apr 2018 15:24:05 +0200
Message-Id: <20180406084346.018312203@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003604240794198?=
X-GMAIL-MSGID: =?utf-8?q?1597004323422754472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2287,8 +2287,14 @@ static u8 smp_cmd_security_req(struct l2
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
