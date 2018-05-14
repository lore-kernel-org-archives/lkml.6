Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoVhwaLqUzDuILb1WcvODzmD0jNU4dbt4zBasCePLtSRMPvqfnpyRLDFczvYDSlra1GdYHu
ARC-Seal: i=1; a=rsa-sha256; t=1526281028; cv=none;
        d=google.com; s=arc-20160816;
        b=0ogSJaSaQmT1Bk3k9+WuKbe0k/Vw3LgT1YvptKmWAMlYkqraQLz7nN5j6sNopijFVK
         kt+pfd+5/itntE8NO1FKsPLB9mu0kdhJkYBNUtos0Sf3uU7wXv0Az/+orC4p8w+Pc+fB
         lvc/u1wvUThJbNsMtXDjZcP/uEBqtD4AUhnBPvmllFcZsgb0gosYx3GDpSNeNUqEcHG/
         kE3ZDSF2Quz3xLgYDemrHfZYNXUKdYo5sohDS4YxsT3mG7PxZKwqBIZG2J+N96Z5L3Ax
         Myxva8IAHCoJ2LDkKnI9AsiGQ53dhKvPDImAb2nyqGt8boxUjyBAWFa2vAo4EohRnRHZ
         BfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=deoTjP/dIci2kmkjOJOaV26UU90KZyaOKTuiv1JU6O0=;
        b=MPY0+Lk+LO1OQCpHyyXNF+OAREbVoCwpzbNp6WYnaUKsXfP5VY/iiNRU4fkpdzw9pn
         aeXsk0rPflaD30JLoH2iWvmnHRkpi8LG0UIsN/Dj8bV/YWF2SAhPJjqAHzMenYTpMYOO
         swJra3gaqOpHH6q5GbIpCE/YG5FFG/QC+9gCZWoq0vh9GI5rANk8J48fVlXB3O7N5FUg
         t3unK24yrE2xfT01SXZ4SVxw7N8AT7ojnUTfqySS/vhDIlyCc10kffWBwJTrWlY3zZFK
         0km43Qcds2D4MSkH4lhRPcFiZWk2GDhSHNxKTTpV/9QBWIx8N/p+X/rIcL1ptOxUASUR
         H4fg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uTu4VHBD;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uTu4VHBD;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.14 52/62] nvme: add quirk to force medium priority for SQ creation
Date: Mon, 14 May 2018 08:49:08 +0200
Message-Id: <20180514064819.371599594@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421655845291506?=
X-GMAIL-MSGID: =?utf-8?q?1600421655845291506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 9abd68ef454c824bfd18629033367b4382b5f390 upstream.

Some P3100 drives have a bug where they think WRRU (weighted round robin)
is always enabled, even though the host doesn't set it. Since they think
it's enabled, they also look at the submission queue creation priority. We
used to set that to MEDIUM by default, but that was removed in commit
81c1cd98351b. This causes various issues on that drive. Add a quirk to
still set MEDIUM priority for that controller.

Fixes: 81c1cd98351b ("nvme/pci: Don't set reserved SQ create flags")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/nvme.h |    5 +++++
 drivers/nvme/host/pci.c  |   12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -80,6 +80,11 @@ enum nvme_quirks {
 	 * Supports the LighNVM command set if indicated in vs[1].
 	 */
 	NVME_QUIRK_LIGHTNVM			= (1 << 6),
+
+	/*
+	 * Set MEDIUM priority on SQ creation
+	 */
+	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
 };
 
 /*
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -947,10 +947,19 @@ static int adapter_alloc_cq(struct nvme_
 static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 						struct nvme_queue *nvmeq)
 {
+	struct nvme_ctrl *ctrl = &dev->ctrl;
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
 	/*
+	 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't
+	 * set. Since URGENT priority is zeroes, it makes all queues
+	 * URGENT.
+	 */
+	if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)
+		flags |= NVME_SQ_PRIO_MEDIUM;
+
+	/*
 	 * Note: we (ab)use the fact the the prp fields survive if no data
 	 * is attached to the request.
 	 */
@@ -2523,7 +2532,8 @@ static const struct pci_device_id nvme_i
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
-		.driver_data = NVME_QUIRK_NO_DEEPEST_PS },
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_MEDIUM_PRIO_SQ },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
