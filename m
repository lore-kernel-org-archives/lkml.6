Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49bSRWH0ZjxON77Ciwax54EIJWtj01IUadFMULjF0f/q8qKP7N+A1P0kCogYgbZoCr904ad
ARC-Seal: i=1; a=rsa-sha256; t=1523399286; cv=none;
        d=google.com; s=arc-20160816;
        b=GMj6ekDMPKUQRtM4hCpC8bJySJuz3TGKrqtMN88yM9dqXZtm79Ah98+6NXmO8ZrKD9
         myAlj2ZyJcyqulUzva3kSbTQnL0A91TjG4KwKfl3uYIZM9AaP/VFKgaQchpC4f19Asdb
         ItVELDZG/xUu57fs//nyCrM0UkUhHQxI62XshnMa9go5H3ZB0A8vRcd3Td+OxZ4PU0Yo
         H4ATKsTQnMub4/d+XVA+lPVLoizSNnLYh6TW+TEjDt9reOjqAl1cPiBEN05zMISm0zGF
         I/lWqsNGWFilHjhm1RRAkV+va+ARNhAwFawvc1OlKXZk+vaHQoUWZd+ePN4vvkFLR/dS
         J/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KdsW4cnWW9j6nWi2YVamJSgFA+eP0J+s8XGq+VaL0RY=;
        b=ZgsZEsF5RSo5ID9jUL+F4/Ig0ak0wOuJsmGPToIOQDGOYpksjvYo/GJVNV0QZxeYpd
         se6ePlwXtPZJxfKoeHphz7hvQNVwxKh3qvVzZbpGykhJDvMN2Byk0YgDxPY4OhNHqr7y
         /n5mrDeDLxmEZ5EwyVrIZx3+z7rqsCDr7Qv4K93YK1QsZIp6pkTuSFmDg73LZ9qevodx
         27vrI8oIQNLjtriMtDQrIVFiX3eHKOxq8d+iFHqsD7siTSgad1yTUfncr8kFX/xIzHYO
         9blRNLC7LZv7Nh2icstd2uqmHa+2eZaAfcP4ZD7KpoG+E7B5Lgiw2bnqCjvv91oTAWL1
         Lu0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Sanchez <sebastian.sanchez@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 051/168] IB/rdmavt: Allocate CQ memory on the correct node
Date: Wed, 11 Apr 2018 00:23:13 +0200
Message-Id: <20180410212802.374545405@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399930853720496?=
X-GMAIL-MSGID: =?utf-8?q?1597399930853720496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>


[ Upstream commit db9a2c6f9b6196b889b98e961cb9a37617b11ccf ]

CQ allocation does not ensure that completion queue entries
and the completion queue structure are allocated on the correct
numa node.

Fix by allocating the rvt_cq and kernel CQ entries on the device node,
leaving the user CQ entries on the default local node.  Also ensure
CQ resizes use the correct allocator when extending a CQ.

Reviewed-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rdmavt/cq.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -198,7 +198,7 @@ struct ib_cq *rvt_create_cq(struct ib_de
 		return ERR_PTR(-EINVAL);
 
 	/* Allocate the completion queue structure. */
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
+	cq = kzalloc_node(sizeof(*cq), GFP_KERNEL, rdi->dparms.node);
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
 
@@ -214,7 +214,9 @@ struct ib_cq *rvt_create_cq(struct ib_de
 		sz += sizeof(struct ib_uverbs_wc) * (entries + 1);
 	else
 		sz += sizeof(struct ib_wc) * (entries + 1);
-	wc = vmalloc_user(sz);
+	wc = udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc) {
 		ret = ERR_PTR(-ENOMEM);
 		goto bail_cq;
@@ -369,7 +371,9 @@ int rvt_resize_cq(struct ib_cq *ibcq, in
 		sz += sizeof(struct ib_uverbs_wc) * (cqe + 1);
 	else
 		sz += sizeof(struct ib_wc) * (cqe + 1);
-	wc = vmalloc_user(sz);
+	wc = udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc)
 		return -ENOMEM;
 
