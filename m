Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrqe8uBnh9Uh/Ew+DLPWiWhNDGWwWuUg8sfv5nQza41FTlPMaO3ArGDiPNHidi74r3DQEuq
ARC-Seal: i=1; a=rsa-sha256; t=1526280690; cv=none;
        d=google.com; s=arc-20160816;
        b=J083ilFXcbWVg3SLaRduMAm52eOZsuBhN4UuPIiTIlR2l+OKhX5XOFYSYGwy8AvjjX
         L46L/P78bMk9eitiNKQRwCZBKpAy+k/5cG9ThyHDFYEQnPvkj/hMvvlI8SZ3O59SuG7g
         4INq59C9lkvmMm4Uh+qfNAxTsPA24V6tmf6sBYzoh5uqJEE/NRQ5FULpSbCx+GSi6ZFT
         vJ1Kt88u6FRQZl9CA/AWpKwbJxOjynyKXOPwwXjbVAptZptdjWvDpuZfz6C7Nq4sT7hf
         ZJxR9N1QMP3U7HIUG0nRRQJWd8CDDyWCZoFY6C3EduSqU/8KmxND+kuQZH8QdGDrEutX
         hYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qlAvMWsMv/ZjyXT8ggSALPoHtAqicikMWsNLRBgEA7U=;
        b=tQnGvtllTEkBBDkecG7zHnvDlBYqYOxdXCRj+hHLIw1mf40trSxTLbCiW8gpenVFHp
         gLzTrJQjXTh0Y+9GjbSrR7+MMSCBwHb1nAsKxRXDITWsiaVRW8ENAjwcy1GBixnaEqzG
         6dEXjKopqjxExAaQ1xA5eccNOYmnIBd9zBhxiANxpJojFhZgXZFYSJnGFXbctyWqTvkT
         SmU7W7cdLNRtTwj/ZrBGq+PWvA9GtX2yNBgHJOCMUG5sp/grjMQnSbWPH1822BrmAmRq
         xHGfUcStx1jhW0bR5jM0/lMa1pAJbDQPcpvLc1z1iU741xeizrUYjpAdNg1WwQSQG+Yq
         SKlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nuPQZObe;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nuPQZObe;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roland Dreier <roland@purestorage.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.4 20/56] RDMA/ucma: Allow resolving address w/o specifying source address
Date: Mon, 14 May 2018 08:48:25 +0200
Message-Id: <20180514064756.869083830@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421301209174699?=
X-GMAIL-MSGID: =?utf-8?q?1600421301209174699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -675,7 +675,7 @@ static ssize_t ucma_resolve_ip(struct uc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	if (!rdma_addr_size_in6(&cmd.src_addr) ||
+	if ((cmd.src_addr.sin6_family && !rdma_addr_size_in6(&cmd.src_addr)) ||
 	    !rdma_addr_size_in6(&cmd.dst_addr))
 		return -EINVAL;
 
