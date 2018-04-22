Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Vg05VF2oqkq7ZQzXkbv1x+b1AwxMq8HTCQveFbd4saywywB4e8BqPzgGiIzvM+ex9JjJA
ARC-Seal: i=1; a=rsa-sha256; t=1524406842; cv=none;
        d=google.com; s=arc-20160816;
        b=wydB77BdtMvVdKpqD6jhE+IxCBQ8CSU/g6JImp/wihVQWUdR5UK/K8MRFSMPMW4qX1
         ddZF2r/fVI6NdN3UwqcuqiQElDa/5NMy+e+VbLW7xZ+owFF46CqR7/YcUg/jyLrFN/iy
         fKAoiGcxo+ouFOysrg486JQiPQsmaA5MglTz9NFCVulYRWpAlkwUu4avCJE6bVeTv8NG
         AGOGacRomr9RWn2k4Bp++Xp8gtiDBr1l/pSzPwpM36EoyXtG9wP47T011JRZhNSstZmH
         ZA62a++b4BRSk+RoWQjWsAhkKZ82yUW5h2ptfoqlgnhPY2j847hShkcPlJDMG/RJ9HdQ
         lA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=swPc03rza7RNiJfAyiaf28WgC79OSTCjOnRvZ34+MCA=;
        b=Cc6VEXXJgP0Fl5aZm2SI3J2Q2iQPCerWdcJi2o5HtYjloRq6xbM+lHlZc8XWpDjxiZ
         JweEuSNHD8v6t6wPKuQRoh8MuQsW3i8yyl+dOMeUZxIwrAUWoOFt9iOHA01Uk8x65rcX
         z8NqDeSAHbt8tjl47o3Pq3KMkce2N89CRbdIpKazi7egbp2dztpC0mpHcVWwTWJkZoZV
         6ONMa4YExv9CSJHecXSHqgqtorNNJIBnTrJwPy9g/ezsePwVWEGk9X03L/gOumOf/C4g
         BlgRczpC4NFoxitHt3nnzHGm5XQ+pcYdgTNpz/cmJ0ck7iHrOeYy6yZ3aho4OGpwS1Fr
         x/4g==
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
Subject: [PATCH 3.18 08/52] ubi: Fix error for write access
Date: Sun, 22 Apr 2018 15:53:41 +0200
Message-Id: <20180422135315.627466410@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454805116980751?=
X-GMAIL-MSGID: =?utf-8?q?1598456429381956558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -322,7 +322,7 @@ static int ubiblock_open(struct block_de
 	 * in any case.
 	 */
 	if (mode & FMODE_WRITE) {
-		ret = -EPERM;
+		ret = -EROFS;
 		goto out_unlock;
 	}
 
