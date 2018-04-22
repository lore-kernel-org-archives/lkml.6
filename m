Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Cjs7DRipzPyhx0UXIX422bI4m8jQGrDmA2QODTPgaC345CRvoOJNAX5tG0zYLXC/PFveb
ARC-Seal: i=1; a=rsa-sha256; t=1524405293; cv=none;
        d=google.com; s=arc-20160816;
        b=Hrs4C3wMOWqH9o+BJu693p4t+mQQX2KKoAN4xEr8gOx30GJw+BIHMDQWUaMT89V12E
         MisQNMo7PbR631R48Elv2Tc3bkKIK+fzRSfR4i39sRnVtsh0SLV6Czh46hoRDSGHZyVf
         SrAmAVsylH8OGnOOzX/KGLYXGpPJuxdbQA5tXHdVCnVdagCp8kLUDsaFWEg0x95j6Wrp
         A0vR5yPLEbXZe/VxYBbIzXIbAOaf+j+hlT/Tc6Sc848pXFI05wJ74hJdmc7K1SKHZCAD
         GdwP71NJ2GTfAIMk3GqrPFgw2QmLiw3MedhQEDwar7dGCtMcIqZH3WpSuIKG7w85g6Uj
         2cqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S5+S7F3OufoO9zCUUkwfuI4fZOf219xHfRY4hfBahEw=;
        b=WRvH+MLd1JNmtLTPrT6oQifDL8iVeAHfEkR2URNjFHtRy/tHAMWCWz9oRuy3Filv73
         +M7vNFX7kiDUc58smaUBc/2yKBxjDzVNoYlwmDbIKZku4wyp0cASbFMJq0rQ7ueUCQlx
         jG2DnRFS1kwg5+SrFogKrXb0WD6O1tcb2F8sKizTWnciUnqmABW5jO7YK19Anqlq0S8V
         a749ivC2QX51yQO+cP1faeuJsYka97IYYAEKYY63Pe8QmHU7wAnaFNlytBPUAvqFz8lJ
         MqI2LiHyxNgr1Fgtke/zOoHJXAFqdPL6rOd1ReixBy0PHk3rrRPPEMaZEhtUQCSZX75Z
         RcGg==
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
Subject: [PATCH 4.16 006/196] ubi: Fix error for write access
Date: Sun, 22 Apr 2018 15:50:26 +0200
Message-Id: <20180422135104.557782509@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454805116980751?=
X-GMAIL-MSGID: =?utf-8?q?1598454805116980751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
