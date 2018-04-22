Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48px1CKkaGjeTkPjOfp5E+/1axQq/z4vo8rtYWYIqwL1KhHQgbRgM5LMXGZIE86AP+0xjvO
ARC-Seal: i=1; a=rsa-sha256; t=1524406571; cv=none;
        d=google.com; s=arc-20160816;
        b=NqjS7XqOHWfAnmI1yRENEy3ZKde5UllIt1xtRsEx5e2PkD9RBTlMNRHWqcU7JUqI23
         lrZlkNlGRWwSv1Ymk3lD90p7ziyCF36qDGpslyU3qWKIxeP7Q0RzQDb/UMHKi7lKKFSB
         q0mPaBH0blWu3+PhuA2iqQgv9Ey9UBkIbyAtT08xIMxUnJzoEFxN6CUpdJgIclKI14GO
         V8rjR4v5mBard/yWRlxpdy2rPl67o48qpRVPfdfw8D9rCl03KsTuhn7ESKdbA8rZIpXX
         m4FNCRzHkcmeiKI1+hfZrSwdhruY1mjF9JVX1welyw7+pac59CWrwtt0X4hSj4wwKQfo
         cj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XRdIZNSF4BbMuyqNeiZx2vKwkieNkFXHSRmSuHll2DU=;
        b=dQ3K2tBKdsmeO6AglZA1T+7Ctuc8qrl+ksQbh45Rw7X4EWVhylJhI9tHVW9xovOZAo
         e0Y0v/o2GzjvNpl0dNYqdXJ8O6pac3IEDY0rZaOYPFaU8u3dcXUIE9tWSi9C/PDXgiro
         xIUCBvU7F+CBK8bodQLuGHKxrVhJaStlzkHoWRYAHuD7zjqfkxBk8wlY2r8w8ouTJ3oN
         tUD0xUFkJXNf+6MIhRslXCw6ZnrpQDbF/k7Hs8nLYrJLi+o0juU8SXYMILNausm8aTxT
         2ftbS1l53dtcU99HEQ9K1oqOKI4jSYyco8wum7Upj9AboZCE0b4CAA+Yr+iMIU6XoKmV
         rf8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Romain Izard <romain.izard.pro@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 24/97] ubi: Fix error for write access
Date: Sun, 22 Apr 2018 15:53:02 +0200
Message-Id: <20180422135306.394815210@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454805116980751?=
X-GMAIL-MSGID: =?utf-8?q?1598456145300256283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Romain Izard <romain.izard.pro@gmail.com>

commit 78a8dfbabbece22bee58ac4cb26cab10e7a19c5d upstream.

When opening a device with write access, ubiblock_open returns an error
code. Currently, this error code is -EPERM, but this is not the right
value.

The open function for other block devices returns -EROFS when opening
read-only devices with FMODE_WRITE set. When used with dm-verity, the
veritysetup userspace tool is expecting EROFS, and refuses to use the
ubiblock device.

Use -EROFS for ubiblock as well. As a result, veritysetup accepts the
ubiblock device as valid.

Cc: stable@vger.kernel.org
Fixes: 9d54c8a33eec (UBI: R/O block driver on top of UBI volumes)
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/block.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -244,7 +244,7 @@ static int ubiblock_open(struct block_de
 	 * in any case.
 	 */
 	if (mode & FMODE_WRITE) {
-		ret = -EPERM;
+		ret = -EROFS;
 		goto out_unlock;
 	}
 
