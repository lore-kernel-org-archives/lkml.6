Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt862tIruSH4pOMAHMouaPArWdg8rHHFB9iqcadPQ3KaEmkiL04bdXodipmhlXNuuW0fEXl
ARC-Seal: i=1; a=rsa-sha256; t=1519411009; cv=none;
        d=google.com; s=arc-20160816;
        b=U8AwXriDhNWq0ChXNfTtG7JoKmEhPs5At9UYz1nTCzQjnaETFhabqvU/TYaRvfmpQB
         JQG/ZvfeJpWLo6+fLAJqksU2OPz/1kH3cTeLbjDgbIh9yfkOlzyJKe+90IiRr5AnQ7Ls
         0fvFIaUv7MUPpF5mCQ48emm+KCiOikwVcWactEpXYfBcFiXaKoXRU9WPqikO/ZkZCLts
         hSUX+WsChmtbBN3U2fRuqwofSJn/tA8o5lYXAnHjntx/Y8+OpisqTLsXOBmJYcxr1bTo
         QJLDv/XuPpFyJGDY92R+4fXUFoyJEqNHLKjMufZe5M8cjUVwIem6bvvHEUlZJFnKmq5Q
         ka9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SmBwSo++TQgsTqVk98Yr5jYDJKwWKU9blWEDjbgLACo=;
        b=LwNOwQEi1pZq1abG1Mr/DUaurC7djYzsVMdtd/QwV0rYPINGQBrN8ua8TOJVTIxuMz
         HmXcqNCkSDAfGpxVQt0KaP8HJyGXb5i5aRLbTK8jdLv6dJND+Ym3AIh/Rrw9rndeMFC1
         pAxCGLCEWHCXr9r8DcGGP+rX9qMHgr23OcjUhKhYXCINqR24O3q8rRyGW/2vXp/kkEy+
         QK3l/K4wwWFTZcEUrZ12KqXPT2J3jQ0eAvdal09yEIUL78ZP/69tPQy6F3FYsfkCteKd
         YimzLvBUWC5P/EtyIcmlbz2hURrZY8HkT7AkOzWC/6lsiTaiA6vcA9xklrYFCwY9LntU
         q4Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 4.4 090/193] mtd: maps: add __init attribute
Date: Fri, 23 Feb 2018 19:25:23 +0100
Message-Id: <20180223170340.118210702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217919100331243?=
X-GMAIL-MSGID: =?utf-8?q?1593217919100331243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <julia.lawall@lip6.fr>

commit e4106a7c8236eb7b91686d36f3bf33ee43db94b4 upstream.

Add __init attribute on functions that are only called from other __init
functions and that are not inlined, at least with gcc version 4.8.4 on an
x86 machine with allyesconfig.  Currently, the functions are put in the
.text.unlikely segment.  Declaring them as __init will cause them to be
put in the .init.text and to disappear after initialization.

The result of objdump -x on the functions before the change is as follows:

00000000000001bc l     F .text.unlikely 00000000000006a2 ck804xrom_init_one.isra.1
00000000000001aa l     F .text.unlikely 0000000000000764 esb2rom_init_one.isra.1
00000000000001db l     F .text.unlikely 0000000000000716 ichxrom_init_one.isra.1

And after the change it is as follows:

0000000000000000 l     F .init.text	000000000000069d ck804xrom_init_one.isra.1
0000000000000000 l     F .init.text	000000000000075f esb2rom_init_one.isra.1
0000000000000000 l     F .init.text	0000000000000711 ichxrom_init_one.isra.1

Done with the help of Coccinelle.  The semantic patch checks for local
static non-init functions that are called from an __init function and are
not called from any other function.

Note that in each case, the function is stored in the probe field of a
pci_driver structure, but this code is under an #if 0.  The #if 0s have
been unchanged since 2009 at the latest.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/maps/ck804xrom.c |    4 ++--
 drivers/mtd/maps/esb2rom.c   |    4 ++--
 drivers/mtd/maps/ichxrom.c   |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/mtd/maps/ck804xrom.c
+++ b/drivers/mtd/maps/ck804xrom.c
@@ -112,8 +112,8 @@ static void ck804xrom_cleanup(struct ck8
 }
 
 
-static int ck804xrom_init_one(struct pci_dev *pdev,
-			      const struct pci_device_id *ent)
+static int __init ck804xrom_init_one(struct pci_dev *pdev,
+				     const struct pci_device_id *ent)
 {
 	static char *rom_probe_types[] = { "cfi_probe", "jedec_probe", NULL };
 	u8 byte;
--- a/drivers/mtd/maps/esb2rom.c
+++ b/drivers/mtd/maps/esb2rom.c
@@ -144,8 +144,8 @@ static void esb2rom_cleanup(struct esb2r
 	pci_dev_put(window->pdev);
 }
 
-static int esb2rom_init_one(struct pci_dev *pdev,
-			    const struct pci_device_id *ent)
+static int __init esb2rom_init_one(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
 	static char *rom_probe_types[] = { "cfi_probe", "jedec_probe", NULL };
 	struct esb2rom_window *window = &esb2rom_window;
--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -86,8 +86,8 @@ static void ichxrom_cleanup(struct ichxr
 }
 
 
-static int ichxrom_init_one(struct pci_dev *pdev,
-			    const struct pci_device_id *ent)
+static int __init ichxrom_init_one(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
 	static char *rom_probe_types[] = { "cfi_probe", "jedec_probe", NULL };
 	struct ichxrom_window *window = &ichxrom_window;
