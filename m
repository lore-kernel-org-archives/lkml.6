Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B18FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E1F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SAY+p1Ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E1F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeIZLL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:11:57 -0400
Received: from ozlabs.org ([203.11.71.1]:44175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbeIZLL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:11:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Km3l6Llsz9s8T;
        Wed, 26 Sep 2018 15:00:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537938052;
        bh=s0a5azWhfTun5SznrJpoQP49NzM4fjojofjRkosUMqs=;
        h=Date:From:To:Cc:Subject:From;
        b=SAY+p1Ny5SV5Yi9+lAiCQYbSehdg0lyFv7OqOWtZhAx4Ug8nklMK0kVJnxV64Q+z5
         Wu9xMcZXVo2vAqDiQ80bJ1tRaiyQW6U+6MbhS52czZWlEKrlzLVr+HNsJuZSbaY2Oq
         21Rwh9KzKVPSgYuaR4XLpJGB/mUw0lki7SiytSoElqSUJa3LOvGxv/F3/wNGuBNOMT
         PC6MpiwVSFhDW5XM3IwTXstc/vHwlSZp/0iNnoHHrNvLgrUDEhWZOGClUIiNApXDJ/
         y+856tGdIVvNaxbDWa4IyMeh5Hebm66KfLiZHniNpAWu5QtA/mF3qgXOVVvTuExw7T
         gZgmC1Zxbz7EQ==
Date:   Wed, 26 Sep 2018 15:00:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: linux-next: build failure after merge of the pci tree
Message-ID: <20180926150051.6ee97aae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+jzMUBKjnSCp_/9ZfBA4qFi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+jzMUBKjnSCp_/9ZfBA4qFi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

After merging the pci tree, today's linux-next build (powerpc allnoconfig)
failed like this:

ld: drivers/pci/pci.o: in function `pci_bus_error_reset':
pci.c:(.text+0x5fba): undefined reference to `pci_slot_mutex'
ld: pci.c:(.text+0x5fc2): undefined reference to `pci_slot_mutex'

Caused by commit

  131b0ca2c7b2 ("PCI/ERR: Use slot reset if available")

I have applied the following hack for today (there is probably a better
way):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 26 Sep 2018 14:55:37 +1000
Subject: [PATCH] pci: move pci_slot_mutex so it is available where needed

Fixes: 131b0ca2c7b2 ("PCI/ERR: Use slot reset if available")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pci/pci.c  | 2 ++
 drivers/pci/slot.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8c1e99a637d8..1fa67db6b21e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5190,6 +5190,8 @@ static int pci_bus_reset(struct pci_bus *bus, int pro=
be)
 	return ret;
 }
=20
+DEFINE_MUTEX(pci_slot_mutex);
+
 /**
  * pci_bus_error_reset - reset the bridge's subordinate bus
  * @bridge: The parent device that connects to the bus to reset
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 3da03fcc6fbf..c46d5e1ff536 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -14,7 +14,6 @@
=20
 struct kset *pci_slots_kset;
 EXPORT_SYMBOL_GPL(pci_slots_kset);
-DEFINE_MUTEX(pci_slot_mutex);
=20
 static ssize_t pci_slot_attr_show(struct kobject *kobj,
 					struct attribute *attr, char *buf)
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/+jzMUBKjnSCp_/9ZfBA4qFi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlurEoMACgkQAVBC80lX
0GyJSwf/UtataI4stNRabjHRqCTU/sMvp+cj4DxIMeXYBTg6XKybASEomglGqKUk
EbzeuymNPpg7fbmCFlxQm9AdGDUKVAe5JC7BwLPbkdVGqAId82xzmXAenLn1bTBu
CUXoUBrGVmRNFW9sRa4tYife4lEuQfriNQavme/1JOGLUnwNZrqZbLvT/G5VR6z2
56D2CZt72GcEPCsZ1m9AXPY4XzXaQgWON+7Vd5LFf3mvuI/wHsXXsTv1S6OGCM3f
0JwAEKu41aVIqq6RPwmSCkXVnWL8w/X3oqHk/ld6aHkCSu4IRH6l669a/x8OLpKU
CHI1soIBdaYJCp3PnA7lwkxKF0W1jA==
=j3Zq
-----END PGP SIGNATURE-----

--Sig_/+jzMUBKjnSCp_/9ZfBA4qFi--
