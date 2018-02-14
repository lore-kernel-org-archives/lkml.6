Return-Path: <g.schenk@eckelmann.de>
X-Google-Smtp-Source: AH8x226XmOQoRAU4JfTwkV4o9IlNmLG0pYJhJ2I0St7tvJU2UJwaY0dF15fUGlEh2Llmi+JBjPus
ARC-Seal: i=1; a=rsa-sha256; t=1518618316; cv=none;
        d=google.com; s=arc-20160816;
        b=By1nsnLcBa3JwHC6NUGAs+aUFKYn6lFLayF7YBJbl/dFT5fWAZLzq5XJcWkL6VMB7W
         EKoEdtB+LRivhkpFqv5urRWD3VZZvIv8DaYrO+XiGismnTQdkBPgeWdvqPjkXvFSPGOa
         Jhpada9Sws0K7f83AeAAqPv6vBZz1cUn6iF51k25D0Zm/esmAJOVRgk0JrMqo0Q3bRHb
         ariSATd1D7A6n3V+/DG9apmjAmXW10Pz4gch9jKMSi4Dq7KTj4rwS773cZb7UWqvvGe3
         bjR9OWOjmgiWkuPSy0r5Pl07PAlawyY4czR7xW0Fk+Hez6zg6Apk4mzt7UdSXYxp+jPV
         au4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=gPc3L+/cP7jh3uICD60UuFB2fPThhFzornpKwq7hhOY=;
        b=y5z2810APhLiGBmWth0lYuJi16u8nPw+XH5wTw0iRhckEt3EYc4YwGNaSwcNrCgIUe
         7MV5Xpcjp7J5+582dr9bUCpvuTF6/YGZpq+ijjcTYC2BOwwuml3sVtwGWtG5ArgSlCO7
         5eTaPOItLBPbKh6aj2NfUYpso2OrZ7rX50esD1pVMFzyvf0brKpBLTBhCVl9GPrBmNVJ
         4EANa+inCgabSr9RSzukyTLa/2TUZQBkoQdhvleAUeKvqlUQ+24AIuSqcuLe6VtAhbAY
         /THZtZE0XuxpWOz930lodwvxh25fUWbKjF7GcOb6wvFeKCp8d2fdr2VI0xDd22twpofl
         Pjrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of g.schenk@eckelmann.de designates 217.19.183.72 as permitted sender) smtp.mailfrom=g.schenk@eckelmann.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of g.schenk@eckelmann.de designates 217.19.183.72 as permitted sender) smtp.mailfrom=g.schenk@eckelmann.de
From: Gavin Schenk <g.schenk@eckelmann.de>
To: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <kernel@pengutronix.de>, <dcb314@hotmail.com>, Gavin Schenk
	<g.schenk@eckelmann.de>
Subject: [PATCH] siox: fix possible buffer overflow in device_add_store
Date: Wed, 14 Feb 2018 15:25:02 +0100
Message-ID: <20180214142502.20787-1-g.schenk@eckelmann.de>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [2a00:1f08:4007:1c00:e163:b718:85a4:9a90]
X-ClientProxiedBy: EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4)
 To EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4)
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592386720059475890?=
X-GMAIL-MSGID: =?utf-8?q?1592386720059475890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Width 20 given in format string is larger than destination
buffer 'type[20]', use %19s to prevent overflowing it.

Fixes: bbecb07fa0af ("siox: new driver framework for eckelmann SIOX")
Cc: stable <stable@vger.kernel.org>
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index fdfcdea25867..16590dfaafa4 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -594,7 +594,7 @@ static ssize_t device_add_store(struct device *dev,
 	size_t inbytes =3D 0, outbytes =3D 0;
 	u8 statustype =3D 0;
=20
-	ret =3D sscanf(buf, "%20s %zu %zu %hhu", type, &inbytes,
+	ret =3D sscanf(buf, "%19s %zu %zu %hhu", type, &inbytes,
 		     &outbytes, &statustype);
 	if (ret !=3D 3 && ret !=3D 4)
 		return -EINVAL;
--=20
2.15.1


--=20
Eckelmann AG
Vorstand: Dipl.-Ing. Peter Frankenbach (Sprecher) Dipl.-Wi.-Ing. Philipp Ec=
kelmann
Dr.-Ing. Marco M=C3=BCnchhof Dr.-Ing. Frank Uhlemann
Vorsitzender des Aufsichtsrats: Hubertus G. Krossa
Stv. Vorsitzender des Aufsichtsrats: Dr.-Ing. Gerd Eckelmann
Sitz der Gesellschaft: Berliner Str. 161, 65205 Wiesbaden, Amtsgericht Wies=
baden HRB 12636
http://www.eckelmann.de
