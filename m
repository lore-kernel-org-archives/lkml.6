Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/gCx9HO92Mg3PJXyvg/cU2s2YN1mvzR4gd8rJvfvCDsq/WkaQexsKYYPQPPwWnLgDWrau5
ARC-Seal: i=1; a=rsa-sha256; t=1524406308; cv=none;
        d=google.com; s=arc-20160816;
        b=rt8yMwymgSBcCbQrUebiSxDcUO+7Zl0di/MviflvdbXOE1IFQ0pgSyz+DwldY86vAX
         kEpurVbX3IUQF15KGDgQxsNa1hY/StwEulP2xnIxLb24nHvLq+knVKP48s1J7UshVnBx
         XUgCJ9tKY9MN3iWPAcaANNghA68wIiWjYKL9ksjRm3Xjs4pMv9DbzJzuM1zojcWJwgoO
         Tg/zkSPDi+OL5qJ2kwbi2u0LhIO5h/IwXirJteGeXmajMg1y/jXbsTGy30xs3kwz8NvX
         0MNrXNA4dH3fWBzreemvI7MDNdwpyne+mUj3MRXs5dgCMd6tUh4Y+eQTqswyo584kvuz
         vvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/jEM1d7GenbDLGq1RVkmmam6kp+9UmxPQM9t6uQMQso=;
        b=dfa6rzOOyACC5VmG0MAcKrG29vtNn+LLg53SkH+O4hbOoVepVmPWBPLSuuP6EmE40C
         CgSqof84r9fNwQZFkSjmZzNEHcLbjZOoyjAgelq9SehSCkHQiRDe+S6Zoav6IwQZ/eR2
         XitZHUgO+Plh/0Yhbe4kHexPYL/xtzBMFCgTmMeOAQb+Amoyv6ZbKP1DTkuHFWvxSXIW
         BsDwCgM0FgtZSliIHFxtFmcqUt/aLwK2uCnmyJqNGaqgBgOW3ELnEi1lJ7DxxoHYsMMN
         IaXxZuVOXIMyqTedtR6lypVosae3kvcjQergH3HePqRbH3dQtk8NDVIkSkahkDg0WfnV
         2Rvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 4.9 05/95] ubi: Reject MLC NAND
Date: Sun, 22 Apr 2018 15:52:34 +0200
Message-Id: <20180422135210.654568274@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454837068211980?=
X-GMAIL-MSGID: =?utf-8?q?1598455869515820150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit b5094b7f135be34630e3ea8a98fa215715d0f29d upstream.

While UBI and UBIFS seem to work at first sight with MLC NAND, you will
most likely lose all your data upon a power-cut or due to read/write
disturb.
In order to protect users from bad surprises, refuse to attach to MLC
NAND.

Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Artem Bityutskiy <dedekind1@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/build.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -894,6 +894,17 @@ int ubi_attach_mtd_dev(struct mtd_info *
 		return -EINVAL;
 	}
 
+	/*
+	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
+	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
+	 * will die soon and you will lose all your data.
+	 */
+	if (mtd->type == MTD_MLCNANDFLASH) {
+		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
