Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ZMze9AmLkIcd08odhn9x18g1AWZQoxNMlxtAx7hDGxFWiIMg5vhSZWecOUfoQsh4hHA5k
ARC-Seal: i=1; a=rsa-sha256; t=1523021926; cv=none;
        d=google.com; s=arc-20160816;
        b=RYu6MhpLU/2gNDi2CSho0HrSuT1mvSXP7F+52Uwo16Dt5PN+B5R+9YztYY8AXsZhet
         QNjgMA0CNeTJTlIDrjQck+Y5WKk59+SJMMS6J1meBPJbKa3PyFvW7e8vZnWAe5MJ35Wz
         1xyoA0iAi/NwENqQRAB4LClvf8dkBGH5RJB/NGpIUASj0oIeohjYfBind7m4UNnLpIBz
         h+E8aqXxi6+J48dH+DJz/Kfsfotzq9PLffgyCyTtJINutai+y+uCvJs/6vFN/xW93OJG
         PKgCHldXef4P3tVY1qE6Y/MXaYcs9Fm/QFPjjJg4+3noQmQtWLShsR17YlJUcnLYD5FD
         982Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tDqpD6h/VN/nWO3gQVXhBynU6K6w2O4UR+xfd/a/kOc=;
        b=mCa55h8Z2NOEvsvZHUviINpyai0dj1P4pDIoLEM+zagv9aCEpgi2ZX8U2sfY8UPFHN
         P8LanEkx1UHbG4MDqd7CuodPKGa4CzIqfKk2Aa8WoZKNzvEF825nmOEaURxPB8dO0va8
         VFLE1xHZRwENe61LnpKLciWWnL4YsDnCoJRgNGkHbmcIdte+0YIfYEKW2R358sdtv21n
         8v8icduUeJGK5dGkWRfT1IFKlFffV/gDQAzP3l12SWU/+CNygw66y33Nu1z0Ko5oYSaY
         DD+EMzJTSyvci9V+EnohaQkOn0BPwRZ/ZziCND9vWIIz0eUqaMt/vvmy/qVzIB/xGD0J
         yKJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Olivier Schonken <olivier.schonken@gmail.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 4.14 06/67] mtd: nand: atmel: Fix get_sectorsize() function
Date: Fri,  6 Apr 2018 15:23:36 +0200
Message-Id: <20180406084342.105772056@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004239503869181?=
X-GMAIL-MSGID: =?utf-8?q?1597004239503869181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 2b1b1b4ac716fd929a2d221bd4ade62263bed915 upstream.

get_sectorsize() was not using the appropriate macro to extract the
ECC sector size from the config cache, which led to buggy ECC when
using 1024 byte sectors.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Cc: <stable@vger.kernel.org>
Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Olivier Schonken <olivier.schonken@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/atmel/pmecc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/atmel/pmecc.c
+++ b/drivers/mtd/nand/atmel/pmecc.c
@@ -426,7 +426,7 @@ static int get_strength(struct atmel_pme
 
 static int get_sectorsize(struct atmel_pmecc_user *user)
 {
-	return user->cache.cfg & PMECC_LOOKUP_TABLE_SIZE_1024 ? 1024 : 512;
+	return user->cache.cfg & PMECC_CFG_SECTOR1024 ? 1024 : 512;
 }
 
 static void atmel_pmecc_gen_syndrome(struct atmel_pmecc_user *user, int sector)
