Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/kNLq6u0W2sJCAOXPXjEWkgbarZ8p4TnjCcivzZ35/MjIU5wwvc8y/FblBTb+HALmfMFpG
ARC-Seal: i=1; a=rsa-sha256; t=1524406205; cv=none;
        d=google.com; s=arc-20160816;
        b=FLE6CLV44iha2fhnMJyZu+cmtGYKcPMtGvaN0KfmwU8aWstaX5RQYlU9j3lbbcBTPn
         qSBW/wAWnQ91pg8LqEoMjioa7G2qniFFCiKle7f7dC8BNAbmKXZ5UlG0jzNAK4hnKF/2
         o4cDkkN+y0UlkDyhVZAsavusKQIju6EFcki8P8zAdjBye1V09JhJAL36W8inY7exHt3N
         s+YXMCtduigiOdW65y1K1N4/Aj5DMzjlhIUcyJtsu2aPEM314Mxnuqb8eMiAssIoxhWG
         wjWQ+Mr4YnFqdka4EcyqElCVh9D9/4vKL5DwNxxs//3zEvOe2udBAblNOASKehyo/wMF
         F01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jt6rUgTkyI+H72sTO1botcg9pLMvxvauIH1WlpX/NPo=;
        b=wI0/DB/ftoTZqT9Pbm7rf19knUsGij6aX7Wd8qAKLV3q2+6g24bCUdHEf/1yjpZqQS
         yiFsrwLwl5MM3la2xUPNGpVyG4g7P7yhIYr0EYxs2FWNXjW5QTFCEMpfo7M4kGRBhePC
         f/Sb6TSoeZYYkIDl954QojuTJtYLBVkxU/3aI7UFSFmSlq1AWBnWEXuQXhY7ZFQ6R0ge
         X0ovbn+6qHy/chdfGB2smsgwkjBkaxUOHE4bfzMW1ySp9yfd1y3sOagqRVaw30cISvz0
         YHkWVZMg+UTxHgbQ79Z/pozktinKrN0ZJAL8W0bv3pdhAaF2EOFXNkEV3bHBhb94AeMV
         75Rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 4.14 105/164] PCI: Mark Broadcom HT1100 and HT2000 Root Port Extended Tags as broken
Date: Sun, 22 Apr 2018 15:52:52 +0200
Message-Id: <20180422135139.713936276@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455163035819770?=
X-GMAIL-MSGID: =?utf-8?q?1598455760747764324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sinan Kaya <okaya@codeaurora.org>

commit 1b30dfd376e28e7f37eda5e2033f6823cdda222b upstream.

Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
unless its Extended Tag Field Enable is set, but all Receivers/Completers
must handle 8-bit Tags correctly regardless of their Extended Tag Field
Enable.

Some devices do not handle 8-bit Tags as Completers, so add a quirk for
them.  If we find such a device, we disable Extended Tags for the entire
hierarchy to make peer-to-peer DMA possible.

The Broadcom HT1100/HT2000/HT2100 seems to have issues with handling 8-bit
tags.  Mark it as broken.

This fixes Xorg hangs and unresponsive keyboards with errors like this:

  radeon 0000:06:00.0: GPU lockup (current fence id 0x000000000000000e last fence id 0x0000000000000
  [drm:r600_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x8504)=0xCAFEDEAD)
  [drm:r600_resume [radeon]] *ERROR* r600 startup failed on resume

Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196197
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
CC: stable@vger.kernel.org	# v4.11: 62ce94a7a5a5 PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken
CC: stable@vger.kernel.org	# v4.11
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4806,9 +4806,13 @@ static void quirk_no_ext_tags(struct pci
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
 /*
