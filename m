Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtsNwu2GNOlVlI9rdtlgHcYDhMUPavlFHuOVal13nTzEV1lTmwqaU70+gMejee5kl1KZGQi
ARC-Seal: i=1; a=rsa-sha256; t=1521800123; cv=none;
        d=google.com; s=arc-20160816;
        b=xeMP6fbZmJGotiOrHzA8IF4qa9UfH8w6NdQGjQ6uRtINmHjkvvD3yhhnBEGH5AxVPS
         UGRefx1gYwsRG+tjuqluV6Ea3oZpu5BZhcgPWql792h+DTMly0BG7nGI4EABkp8yk/pB
         5iJBOkduoRHr/gPp0e3zWbfYKUcjZhq6aOjlq290CXH5CP6UA+wxQzVsGgPiIG9K6XJU
         0ppSQlG9XDyptByjtBIxKccvulTugFJ/nfRfoeQCeu4kcLF++gzj1OaGik35AmZuHZ1z
         Nr/orLV0ycsmtJPa3awg+tye/8bMUIixYl7jKOJiWlbHnp28W8f23r/Z016pobdJ6JiJ
         YoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SHquMumQ9GXe0RqCKUPM1aoV+4yN50NkyLrqv7tTRFU=;
        b=Itp0zQW7HnApUMMQbM5pwZJnxcnL8cmg15M+CWwVfVUcEFPRawIvMFPTr9lAq8lBgu
         ZOwYtc0/rN540+BiJv7fZ8cTjK/Bu1aBcCO7rpeVgieUJniD+c6+w9Wp7DeuNnM4eWnD
         RIOxwKqVbywsI2Kzkj+gBCn9g279FgFYs8hfE3mswByv5rj54mQ4oyQxzL6IyZCn1z2T
         QrvulQSpwNA9mPYEdvIXKwOQ8n7F4WN5fCTbt7hcEU6QfstYxmsL54khky43z0hi1ghx
         sd52sBLXlUU0WmZbeaTytviNyKVN80qw1K7nNFiImUq5yJyZPEh6rkhoawqK9bAKnndw
         UfpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Feras Daoud <ferasda@mellanox.com>,
	Erez Shitrit <erezsh@mellanox.com>,
	Alex Vesker <valex@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 32/97] IB/ipoib: Update broadcast object if PKey value was changed in index 0
Date: Fri, 23 Mar 2018 10:54:19 +0100
Message-Id: <20180323094159.466111317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722532065984207?=
X-GMAIL-MSGID: =?utf-8?q?1595723087181292044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feras Daoud <ferasda@mellanox.com>


[ Upstream commit 9a9b8112699d78e7f317019b37f377e90023f3ed ]

Update the broadcast address in the priv->broadcast object when the
Pkey value changes in index 0, otherwise the multicast GID value will
keep the previous value of the PKey, and will not be updated.
This leads to interface state down because the interface will keep the
old PKey value.

For example, in SR-IOV environment, if the PF changes the value of PKey
index 0 for one of the VFs, then the VF receives PKey change event that
triggers heavy flush. This flush calls update_parent_pkey that update the
broadcast object and its relevant members. If in this case the multicast
GID will not be updated, the interface state will be down.

Fixes: c2904141696e ("IPoIB: Fix pkey change flow for virtualization environments")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -945,6 +945,19 @@ static inline int update_parent_pkey(str
 		 */
 		priv->dev->broadcast[8] = priv->pkey >> 8;
 		priv->dev->broadcast[9] = priv->pkey & 0xff;
+
+		/*
+		 * Update the broadcast address in the priv->broadcast object,
+		 * in case it already exists, otherwise no one will do that.
+		 */
+		if (priv->broadcast) {
+			spin_lock_irq(&priv->lock);
+			memcpy(priv->broadcast->mcmember.mgid.raw,
+			       priv->dev->broadcast + 4,
+			sizeof(union ib_gid));
+			spin_unlock_irq(&priv->lock);
+		}
+
 		return 0;
 	}
 
