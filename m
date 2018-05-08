Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqNlPS7aC9eDA8HtYGQt5LdA/s7oXcwi7Ks21WoS62tMoeMuXB9XA8sQrllEJtvSG+8h5Zk
ARC-Seal: i=1; a=rsa-sha256; t=1525767178; cv=none;
        d=google.com; s=arc-20160816;
        b=iYX1NJE5ftHcJtcSCg9ll5NSalZeb+sJPA6om8yFsH6eligqNhv1qz4U5PWQTAnV3v
         rvn/u99U7hD5j98bjKEuZr+Ny0uXpOo1zxucLUIXpJtgeYS+0bmB80BB/5dYORwCo3z1
         MpeFYU1N5wAHEuQSksp7T3fse3i7G0ocNevGyz5cA5pvqiX8LHP1DE0tIJj4yHASrQZJ
         e8Aw/g3wZlNDfRVkdkNO180o7BdU0BnjgsfMgyAQOGgUwSofCfRFlZusDKKr4Kz0L3pT
         9/ttez+/I0h5Uw/TiPhuwig6r+VlC6vcd67H4jXi4E22BSerrfUsz5MPIapllLjHfBHG
         W6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sQLyA0C0EocoBCd9TPecAnkUb7YLfvCmblTjf4AMj0g=;
        b=v6QNXWIw+qgoZjqImqmXpa35drJmUmU1YSzN/TOSQOJO5+lE4mhpk7cn6pnOPdeynh
         4gbwhqwLYG9DepnjtC6ZTACnB7zZRVcf/S/i+tZg4Dt/jkzu3wcloxQ16mOEdXNpKrLk
         iBMuDhCg5rhMpfHlZj1uNI3id8ZABGWSg2G3PixzPs0rUVek3YW8lh1Kdo9d6NxEYiRp
         Y2h5H9fcemxbKFygw4/sfOe6CbcR1yFrM7oX618zL5cRLdGOwigx1QngDctJH8o58erq
         HSIADPFU7Yn63ToPQMhdrCm63XEGy4SQ5zDJg2PTLGxBUAZLXgjmqKN7BrtL4diPikOK
         WTKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=J+g9cTTh;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=J+g9cTTh;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roland Dreier <roland@purestorage.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 19/52] RDMA/ucma: Allow resolving address w/o specifying source address
Date: Tue,  8 May 2018 10:10:17 +0200
Message-Id: <20180508073930.616740727@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882845001156210?=
X-GMAIL-MSGID: =?utf-8?q?1599882845001156210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
