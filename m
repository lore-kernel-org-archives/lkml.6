Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BC+b+oLAJ3Pa98ZQCrQj4TC6sJie8C3W0ziLmzbr98BYSekNA+x8b1AzT1MeF9BnXqCNA
ARC-Seal: i=1; a=rsa-sha256; t=1524405881; cv=none;
        d=google.com; s=arc-20160816;
        b=bJTNz5F2kFoEZbJGmRzGuKxvE/HkRsk2d7y3hIcslTqqcTY0rQQ2HqPn21MuYq/rbM
         xYeadOc1tZDcFwhVU1goqjpB1X0XmSvoW7LjS1BMKl1rlSRwocu6kCBnW2JY9T4bWNmw
         Ts0BeO4lAW8s6nnIx8Yys5951cB7TwqZfLwFIiYmEtCdGbChSStZNtWydCT0ID9XLp+z
         PmRwi693GwzuWNO6VJn2WipPXZb21Pddh4VTPXf/Vaq82rhQIYtBwRFtyE25qI7DkVgp
         tJ3NxbVV89uE7ZaVtvv6ynPJyPq3v1j8aiIsX6xSr22sqUYLtSi6jsvd1QY2rH6RRBTr
         elTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dH6sOJpgzrOdkP3KzvxicAD+aF8G368JNmxdBk8cbxM=;
        b=03bGBCsFVad7JCz9KoGcIRYBn9dkaa7IIPfNYrlN4f8oXZ0UxPKjUZlyiy1ZJ6R6tA
         DQzKr12Qkr005kTLtwdK77KWwWYdrqzDTVI8qdJAux4NIFiAcaAONQUtG84M0zLoAemN
         SFy55jUx/9DbhtJ5YLKF3Sn0t3khVxSA9ZNfLutDc6GSymUGQLaM/BDVntFp249qAaC5
         nQhsI+5YBbhQmE0UPlL30U4CrVckzWS1nY0sXU8Nxyx1HfcNGbjOxYSlPrlSRdSCSEId
         69U1s46d0jTXirpfcjJV/1hGVWZhrDtLccK6JKZEQEV34wu8IzwBhaIjZ/AMt3vlpku9
         EYyQ==
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
Subject: [PATCH 4.14 005/164] ubi: Fix error for write access
Date: Sun, 22 Apr 2018 15:51:12 +0200
Message-Id: <20180422135135.624637878@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454805116980751?=
X-GMAIL-MSGID: =?utf-8?q?1598455421958099215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
