Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrbK618JkCg2gjnDMVvurmvokEe9M6p2BowDcaFTNNTWkjRXW0ilYK/2c+qtdkJYJ91KBWf
ARC-Seal: i=1; a=rsa-sha256; t=1525767411; cv=none;
        d=google.com; s=arc-20160816;
        b=0/Ev6jnNoSQEIgg+bReEw39Yvz1I3VqMJoC3MKOSKFCnrlScaERCsydpXD7WesgxLg
         Q7CE2Ya85uLdmJPlDnWpV9iqYY2/BZX4l774xXvBL/yMI8e3onchjC6Q87IoaC/vZv2T
         /58BICZl+VGssGRxeaZQdmiVEPl2lTJuFCkicCPDN0/eLalP0QkSCvy8hNtrxxjJBc9u
         7HJU1rcX2D3g+sqJIIiEtcCNBCDPb91SG/4FBgsnn/q0jnbWlRqb0VlNh11Jns/aGbtF
         +q2m57O/dX57Xw1ehig6KgB49MjbHKr7SEignSWJb6r5ycQIdT37fNDop9qu+PMdhA0h
         KSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wPnCCVi0H9+7Fg2KSVXoVfTsJVDBNYFmT0w8ue3QwXU=;
        b=VfLWA/cffZMdUVwELh6+3Gf4AxYinLhroamJkiAlwOsOdc3xRLsOrDu0AmZBqY8vo/
         Ge/OsB8ZUCSY9aBuFKuUzR5j9Z/3ak+24LYe4IJQ7u/XLb1hFcdNxkPp5q5OZvtP10PR
         SvfEBdHqtc2HZnPkeUCLD0dIbTyWWo+DuuJg0xjp3jdHXdy3lfOeMBFMvHWFB7pTSls+
         Fmp58K9IfTFA7ZEOHbklw1TWrJshRB9fnOCW/BFNpS+IVMQMGFuZRk5Vl0O3+gWUJFjl
         qOEbC7N9ZvHNsV7K+h9FUY5dyXFfbUAfGD3BH//ZklSv9Wn7Z0bn0YziFzFVPJHUTvq2
         5sBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eiVrBioQ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eiVrBioQ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roland Dreier <roland@purestorage.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 17/32] RDMA/ucma: Allow resolving address w/o specifying source address
Date: Tue,  8 May 2018 10:10:57 +0200
Message-Id: <20180508074011.616314295@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882845001156210?=
X-GMAIL-MSGID: =?utf-8?q?1599883089047609292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roland Dreier <roland@purestorage.com>

commit 09abfe7b5b2f442a85f4c4d59ecf582ad76088d7 upstream.

The RDMA CM will select a source device and address by consulting
the routing table if no source address is passed into
rdma_resolve_address().  Userspace will ask for this by passing an
all-zero source address in the RESOLVE_IP command.  Unfortunately
the new check for non-zero address size rejects this with EINVAL,
which breaks valid userspace applications.

Fix this by explicitly allowing a zero address family for the source.

Fixes: 2975d5de6428 ("RDMA/ucma: Check AF family prior resolving address")
Cc: <stable@vger.kernel.org>
Signed-off-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -676,7 +676,7 @@ static ssize_t ucma_resolve_ip(struct uc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	if (!rdma_addr_size_in6(&cmd.src_addr) ||
+	if ((cmd.src_addr.sin6_family && !rdma_addr_size_in6(&cmd.src_addr)) ||
 	    !rdma_addr_size_in6(&cmd.dst_addr))
 		return -EINVAL;
 
