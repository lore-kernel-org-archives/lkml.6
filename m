Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNO06HyfHLsAMGNmvk+YHiynTvViTDL/R286Qbn1eawU5hynf+NMBAa7JFnEbO3lcJAvBi
ARC-Seal: i=1; a=rsa-sha256; t=1519411112; cv=none;
        d=google.com; s=arc-20160816;
        b=RweX/b73LNsKU0/NjNYpGaoEeUnxoejyvJQ+FiqncGwJLTKlf6akjWkf9F13y5wPWu
         hpGoZu36lhc1yis+Gl2b9Grn8UVjou1D58qFKq7RrqWdtgARPE8lHDvpLxasM0SVLja1
         hNwNvQgRpuG7kszbMuA1L6qn032VD4rCz9Oru+14oiHG1r99lfAAYmxx5NulsOuJi8+C
         4vDfOBhKYBCSThr/7BW+p9dqgk72Kc7RoBRKvqQ6I5u2B8t7yMmTNqQejzy3gXbpdQRG
         GBgAx7w1QPw0OfxD8jxtvJ0w0YKcDbt2DtRwhCtSE8Wnca7miThlLOfwdfltb+Ov0az/
         SC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w/yuyNMP3uWQshqMvpOzeTou8MRs7S5TLWSQvYnuchI=;
        b=eC7IGLDp4ChH/m6fRAcNmIC7Dm/6lCBRh95ezDxYpNi+Mmc4s0I/Z/rbcTrZnZHvK3
         aZGMW2wXtvZSP6F0zqQzh4yjkEFhXy01NULbsB9J6ZKUMxQ+AxDCqgTJaKlSSIY+5QKT
         wKW4/sOzy2mGgkxldI7N8XDstVYNUa06P/O0nR1JbEb8kr6FBJPVYG/ACpERsru4APzF
         CwfB7vsCRafI2dYlkJRtprGXrtDCrq4oR9w1ZJMuJIDjmpWAUF/D2XswZs/mjGLEumj8
         mL/LdXfidt2NoTnlZ1tSPNp4Ih5QNv02WnYaEiUZkgvYru0pTArqR0Kimkmaojr1B7Zo
         8CJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Steve Wise <swise@opengridcomputing.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.4 126/193] infiniband: cxgb4: use %pR format string for printing resources
Date: Fri, 23 Feb 2018 19:25:59 +0100
Message-Id: <20180223170345.562864387@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218026363779395?=
X-GMAIL-MSGID: =?utf-8?q?1593218026363779395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3021376d6d12dd1be8a0a13c16dae8badb7766fd upstream.

The cxgb4 prints an MMIO resource using the "0x%x" and "%p" format
strings on the length and start, respective, but that
triggers a compiler warning when using a 64-bit resource_size_t
on a 32-bit architecture:

drivers/infiniband/hw/cxgb4/device.c: In function 'c4iw_rdev_open':
drivers/infiniband/hw/cxgb4/device.c:807:7: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       (void *)pci_resource_start(rdev->lldi.pdev, 2),

This changes the format string to use %pR instead, which pretty-prints
the resource, avoids the warning and is shorter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/cxgb4/device.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -809,10 +809,9 @@ static int c4iw_rdev_open(struct c4iw_rd
 	     rdev->lldi.vr->qp.size,
 	     rdev->lldi.vr->cq.start,
 	     rdev->lldi.vr->cq.size);
-	PDBG("udb len 0x%x udb base %p db_reg %p gts_reg %p "
+	PDBG("udb %pR db_reg %p gts_reg %p "
 	     "qpmask 0x%x cqmask 0x%x\n",
-	     (unsigned)pci_resource_len(rdev->lldi.pdev, 2),
-	     (void *)pci_resource_start(rdev->lldi.pdev, 2),
+		&rdev->lldi.pdev->resource[2],
 	     rdev->lldi.db_reg, rdev->lldi.gts_reg,
 	     rdev->qpmask, rdev->cqmask);
 
