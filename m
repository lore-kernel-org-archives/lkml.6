Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Tu48QdyLzglLKmKEAwJp2Uk9LXE7hL9OPXXKWE46E2NAXjMePKf7lgB4bo/FSmfVIXZ2l
ARC-Seal: i=1; a=rsa-sha256; t=1519411006; cv=none;
        d=google.com; s=arc-20160816;
        b=qlUnRjrg20YNWEwpMnD8u0CZ5aZBhrVn0Dc0dyhmijv+/NBLDD6FsPWrZve7lxPtAS
         PuUMj7Gh+34xAKFGbe4mGoeJ2DwjUmSLTOVfc9m8L0ZtyZp0ZA925ZNhav0RlFs+0FEL
         Cf3huBIrVIbWQjLgjyexf5LztIA4otdqATC7+bLaDVDUIDgPAcvhOD7EWJt7oDbqHmvO
         5RQajjWbtMreWFv4pr7y5gwHCJzBfVbDvDn2SN+t1jMSgOWxS5Ad2jJcLHl+RHFRosEJ
         aqxbCylcQKwATJrDWxJKj8Tq4Uv6c+s/ZZfsM3w/q93jA5stG6ao0NJ/PtKywdW+kkG/
         RaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NtzqWvF3F/8k2b5dE4TOmiZ8DrGvCIxu8BzWXMqEcLE=;
        b=kHYQc53XL/mixsLMzKJoexaNw7GLFYSXexoJyr7RVbmrMK8yZRVnK94MQR7psKFcY0
         +SeobcsFqxMzF4XnceQ8p2kX+iJJI0wpqWt13CCTRaAQpxGMa2VY4s1eKstrdYZbGcsZ
         RGD1LyG03nkuCHsvEt4aRm8TSKTjh/FTgK57pUAYD5telRM5R78Vvdpkl4mlK1Dr6seH
         032KTayJw/c0ZpVrp9za/zAuqIrMjwkDVaZen0L8/M9Ndoxqk4qE4X1S81Xt7B1J49x0
         kNSeV1CzeAnLoY9L/KJaOdqwo2PUP3c7cxN4DU5/UlXs3ShH2VuQ6RewF87Ce5XSXoaV
         aAsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marex@denx.de>,
	Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 4.4 089/193] mtd: ichxrom: maybe-uninitialized with gcc-4.9
Date: Fri, 23 Feb 2018 19:25:22 +0100
Message-Id: <20180223170339.979260529@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217915631987086?=
X-GMAIL-MSGID: =?utf-8?q?1593217915631987086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit e70dda0868fad0f74c46df21f7f45fec24f29879 upstream.

pci_read_config_word() might fail and not initialize its output,
as pointed out by older versions of gcc when using the -Wmaybe-unintialized
flag:

drivers/mtd/maps/ichxrom.c: In function ‘ichxrom_cleanup’:
drivers/mtd/maps/ichxrom.c:63:2: error: ‘word’ is used uninitialized in this function [-Werror=uninitialized]

This is apparently a correct warning, though it does not show up
with newer compilers. Changing the code to not attempt to write
back uninitialized data into PCI config space is a correct
fix for the problem and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/maps/ichxrom.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -57,10 +57,12 @@ static void ichxrom_cleanup(struct ichxr
 {
 	struct ichxrom_map_info *map, *scratch;
 	u16 word;
+	int ret;
 
 	/* Disable writes through the rom window */
-	pci_read_config_word(window->pdev, BIOS_CNTL, &word);
-	pci_write_config_word(window->pdev, BIOS_CNTL, word & ~1);
+	ret = pci_read_config_word(window->pdev, BIOS_CNTL, &word);
+	if (!ret)
+		pci_write_config_word(window->pdev, BIOS_CNTL, word & ~1);
 	pci_dev_put(window->pdev);
 
 	/* Free all of the mtd devices */
