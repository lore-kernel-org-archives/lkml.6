Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt/RWgoc6Bl95M67lZAntEQRqPaBQpIyvUCjctYpWBSdw/aWM58//oe0PpEuxBj2zubqIsI
ARC-Seal: i=1; a=rsa-sha256; t=1519980986; cv=none;
        d=google.com; s=arc-20160816;
        b=EmGq+UQbiOZpZ1ioKwEUSvr/rzn5Gp2ON4uiScxKme9iqZ4ZlEcHVlz5pY54kURWHB
         XMmDvUz3mVhnOU0fTFtWuAL4iZY4ZWpxSLaUJ2xGPp6ukg43tuUKA/jcpE76/U++Nili
         gA9/Zxl9RcVGjP48vizjq4CVGYbI4Oj34cjY3X6GT/DIVQ2jAR0Z2DcZeywmvGIjiMHk
         faKCmBtiOik/eZd/rs5cmU7o1DX19JE97okVmuu35UQ8xufJRTdqsEDrZ7j2Qal4K0Q2
         K/VR0r0CNruEZnfHM6t1DsU7OqZrGvIODxOqw5PVwVPXqIMILousJknOxBHDMljOJo44
         aDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N5qwh6ZuK4p0iDkKEMS0dyIQEtthg42CrTby3jKkNqU=;
        b=MXywrhsyOasTe9Sbk1CB6kYnxUVI7dmCsgifibffSzfbS5e5nKV1uxAfm1pB4N+5ta
         2yjbd9i1oImggRygCjaRDxEuSuqEicZzMNT8qQUCddLpPI661+gE6zllQe38wKamN/Dl
         2a0IvQ4btPiTYE+Z9pFAPlWdRvpXApdxvQJSPbmZr1X/CVpaJsPIwHiFRJ+TJTX5/W4Y
         leKZuwezG/Y/OogX5ygaNyZNOGD7GV8wT0BgOtVb8OfoZANHyPAHgNJ8z+sBC1Xm18ML
         ShGjcasFNyCmA0QZ/uoaxePKz7HsdyD3AQdB4O7vBkC1uzqQjrKPTlFG+NFmU2qdFsiM
         zgNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Albert Hsieh <wen.hsieh@broadcom.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 08/56] mtd: nand: brcmnand: Zero bitflip is not an error
Date: Fri,  2 Mar 2018 09:50:54 +0100
Message-Id: <20180302084450.053785624@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815582710886048?=
X-GMAIL-MSGID: =?utf-8?q?1593815582710886048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Albert Hsieh <wen.hsieh@broadcom.com>


[ Upstream commit e44b9a9c135727f3410e029910275f40681dc8bc ]

A negative return value of brcmstb_nand_verify_erased_page() indicates a
real bitflip error of an erased page, and other return values (>= 0) show
the corrected bitflip number. Zero return value means no bitflip, but the
current driver code treats it as an error, and eventually leads to
falsely reported ECC error.

Fixes: 02b88eea9f9c ("mtd: brcmnand: Add check for erased page bitflip")
Signed-off-by: Albert Hsieh <wen.hsieh@broadcom.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/brcmnand/brcmnand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1763,7 +1763,7 @@ try_dmaread:
 			err = brcmstb_nand_verify_erased_page(mtd, chip, buf,
 							      addr);
 			/* erased page bitflips corrected */
-			if (err > 0)
+			if (err >= 0)
 				return err;
 		}
 
