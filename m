Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/DK7+o3GOakGvvD91UJXjXNylMlnRxJf3Sro2Wij2c8IrSjH/Nu6r+gwqXYoCQr0no4QJV
ARC-Seal: i=1; a=rsa-sha256; t=1524406305; cv=none;
        d=google.com; s=arc-20160816;
        b=qwVjPzVvMJ+i2QDJAAHm9Ez7d+nemobpZz/PTgi+Jv5iEI2HmokOOEuwp6avCO/y0x
         G3JPZl3htN7R/UZY9E1B6ldb+xTr+L8Q8d2vwYE6EQbGRnVOV/m8kj+9U1uy3TLtOH21
         Qk5ko/VBswWk79nKK38bOCYIgaiZQdGzxK9mz2ltZeM3OsiGQbX/h7HkgUAvbhWgbkPm
         qFGpYDX99s6uYGfMWf05XvAu3N9ZbMnawKp8o1ivPAKuINiV4FFc/W3KA9IV5QX6DsVx
         WkHoANSS5ASfB/YHvkAwj0ibdKH6w5NGnc2IEFoSP/NgnVA0IH4LtFSXQ09FcCvMAJKv
         Sutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UsSYM4DNds6yAXWz3w1bl4uDtMnPPebnAEm16rlz6r0=;
        b=aI9Qsw7PCB1XWfRv26GzynAW7Csy+IGd01lt6euaFZW7fX+C36ZbNdLTYWaiJGx6HN
         P3u+oxG56TTwJV54hgWO2cWUAQhIlbgq0EXhHqiDnHI4JLGHWd7qnSHgbyr/SZ2sSoIh
         RLEa6K9TTgTelu8e9Nvgfh+vwcD0K3Y5piq8gqPK0MeBPXF+FSZgsoIft8gFfkG6JRp7
         WyWcclMuu2m6DVx1YqsxL1aMRq7b/gD3EfXQ5l+6xVB2I4GPaTD6XFonVqIKABVsS8DR
         Vu1qTIyv9KW+VAL6RbUdljjjOzxDR4nxN5W3WJlEfjz9iQGKNEzMr/FMvwwtd3NMTWao
         Qqcw==
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
Subject: [PATCH 4.9 04/95] ubi: Fix error for write access
Date: Sun, 22 Apr 2018 15:52:33 +0200
Message-Id: <20180422135210.616401298@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454805116980751?=
X-GMAIL-MSGID: =?utf-8?q?1598455866402655013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
