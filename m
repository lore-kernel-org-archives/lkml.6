Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs3BkHvkJ355yD6Ho8QSu65OK50CrY9ocg6EFw83Sti9wtDHt9QTQ+VbKtUEAZS0Y2uyA+o
ARC-Seal: i=1; a=rsa-sha256; t=1520641296; cv=none;
        d=google.com; s=arc-20160816;
        b=jMDWrzfPyyGknI8hqtLCwNaoKHcB3jNxAgFQxz4+QrmprK3VugUq8T4KqTX3oMyZks
         TA/HDpcB8ki0BROC2pLSdOm+pRZJiL1WqN34LETW+UEur0gX02U42ADyWCkjlKk8JN02
         HNe/nYxmYLMDoAC7WZf30IHjkz5iaUKWYJwkKGJptZTvbOl0yFbyDf+JbkCi36dPBBQa
         XAcd1EkBBt08xStG5EYkwwDAZlLCZRuPpl2GougRz3pvpi1LNkE10/6dNJnLWTSzNYV3
         SwysiEecOCvPHrBn2gWGsW4V9dgt5BZHYWiGRQBwH/KUtAcAZvrIYP0sjI//cgM+wVlQ
         QNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oz6sJnKmA/7mGe+CQlh3vcm3l0R8Ir9SMofsE1E13/4=;
        b=VP+6RKKqqd/c+jECpV40Dj16Jh6TSPpO1ngdLToqIgIbu8TC6Rz4x/Cif3CNU9MVBO
         Z8TCQQFQn9o1vjJJKhGL/uiGcV/svL4JtCGu0Jie1AeshTrp7hgf20jbN2qoanptIV2b
         ZERJjX2kQot4/iRp/ZZ+TyDQouytdROMqdHeNlXBx8g4jY9PVusJY5uTtLiBn23wsA9X
         pecKEXTTj7ypSrqVupvRwxH074F4ho/Z3rN9cAd+1iZmOl+g92Vx/MB3nXzGyY9lKXkg
         lFZBx2RtzhqYhg323yhNx84AHCgRC54kLBqImh6iFWi/5Q5e9MGok7P4i5DzNU2h5AeI
         ob7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Steffen <Alexander.Steffen@infineon.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.9 07/65] tpm-dev-common: Reject too short writes
Date: Fri,  9 Mar 2018 16:18:07 -0800
Message-Id: <20180310001825.521367469@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507968467819795?=
X-GMAIL-MSGID: =?utf-8?q?1594507968467819795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Steffen <Alexander.Steffen@infineon.com>

commit ee70bc1e7b63ac8023c9ff9475d8741e397316e7 upstream.

tpm_transmit() does not offer an explicit interface to indicate the number
of valid bytes in the communication buffer. Instead, it relies on the
commandSize field in the TPM header that is encoded within the buffer.
Therefore, ensure that a) enough data has been written to the buffer, so
that the commandSize field is present and b) the commandSize field does not
announce more data than has been written to the buffer.

This should have been fixed with CVE-2011-1161 long ago, but apparently
a correct version of that patch never made it into the kernel.

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-dev.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -136,6 +136,12 @@ static ssize_t tpm_write(struct file *fi
 		return -EFAULT;
 	}
 
+	if (in_size < 6 ||
+	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
+		mutex_unlock(&priv->buffer_mutex);
+		return -EINVAL;
+	}
+
 	/* atomic tpm command send and result receive. We only hold the ops
 	 * lock during this period so that the tpm can be unregistered even if
 	 * the char dev is held open.
