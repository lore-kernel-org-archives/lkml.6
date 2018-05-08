Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqBqomIUCA/t2zmhpQE/97IBWgyXw4TCvM8cps+BwKHH1V6az4TkIUk92/SNNKE2pdTVXDA
ARC-Seal: i=1; a=rsa-sha256; t=1525767295; cv=none;
        d=google.com; s=arc-20160816;
        b=Hf8VE8ywb+NZYxh5JaK2hwbDfTNitvBNO6G1DyAwYH7FJk2IbU/GQJsGyMnZzE0tck
         7gcB4i1F7FJa4h9y9nI5PQCu3enJlVr2vOvIQ8IJ/vkzzL+k3vF//Nlyr8R2gFtMrVLM
         YEq3SKAguI+rW9Ss7Xdi+IAuzdRT8XTTO5WR93y0450svMEdRXfmOUT6kGm8Z4/LDrP4
         RP9tU/uShk04KZxI7fzGOTW8jPX0Jk+dgSFhVw68M8fv++Sm90gqCJx0s0Revp4J1lSG
         ofOirZetVy9BupEsKXHrUTN6Y0Hy7BSxWCeFekFY6Qm08Yn6cJN9jLzfI0gbu88UBXTF
         elTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sQiLrpP1/MUqOrrWKfH/AEvrAsHe6sauCNbCNQCXlH4=;
        b=itVq5/XfPz9N50P8gQs9hvRfZw/phrcX++AogLPTaEZ+mSTfNsI9uYh9Tl5UlL1UhF
         OAAXI1vyAY2LQx7CMedwHfaoum9PwyOu9TY+8prEuWsVaYq+SKqIIcBZ6LpnmOy/6klg
         Rcl+bJeeGBMLl09KILCTFQRyEzIsM+kqyQUaDaXisbzWtw5DdpzOkbAiZxBDVfzXeDrP
         IuuAp4k9iqjusN7ufTot88v8raBvIrRKZWXsUXBzv4mehVyWXgb1/iDfEQljiTTKTGf5
         G0R5A+GFDWkOGzoOrfZXxh7Jbd7oIxQ4cDVVt4LmzJrAuDPDTlyVM/HYClllfiPGdcZ6
         aFHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qAGGDrdC;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qAGGDrdC;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roland Dreier <roland@purestorage.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 21/43] RDMA/ucma: Allow resolving address w/o specifying source address
Date: Tue,  8 May 2018 10:10:40 +0200
Message-Id: <20180508074007.433264873@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882845001156210?=
X-GMAIL-MSGID: =?utf-8?q?1599882967390394410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -678,7 +678,7 @@ static ssize_t ucma_resolve_ip(struct uc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	if (!rdma_addr_size_in6(&cmd.src_addr) ||
+	if ((cmd.src_addr.sin6_family && !rdma_addr_size_in6(&cmd.src_addr)) ||
 	    !rdma_addr_size_in6(&cmd.dst_addr))
 		return -EINVAL;
 
