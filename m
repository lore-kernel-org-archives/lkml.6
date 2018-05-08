Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZogon9by7mUxsr1XRQQOl0m5oylCfUjoo9ZEmMeuDT5A+UYVyx7pNVnsZVst8+fSd35aK9Z
ARC-Seal: i=1; a=rsa-sha256; t=1525767166; cv=none;
        d=google.com; s=arc-20160816;
        b=Lz3Z4VnImjK9FJIvMwjGfhkbptk4bqwHqL83mJkcamAxWWQytbtuLy0Y2u+g7tgb5C
         kfurcdeKNKNsiAbL7sMeVagqDSdEqMVzoeJ6S7+Jbu5ltiaswheqiUhcDfma4VxPHewS
         I2y7QqsvNFvLw0RKk2PElQ+ABApgEafDqcFi2MEL3OeD43rH4qXU+Arhwppq7sXIdMth
         5bZw3orS7awUShnKAc08JTDNOA0DjmiIpxuFh4smW0qafksq5mWNYjm0R5v3qupaqCRG
         YrtR01vD6T6Cwujt1I1DD4U+fiCQd5R+FXaj54dnYfWCQXQv3RHe/sDnXK1wFurJwIj6
         Xs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cUFmGJC6DwC+XXLDC66onzLUfTE/XmnBRCYeiX9pKmk=;
        b=ZeIHxfqSuknMPsiUHRDofRbmp8Vi/xnJ40Xv9vOPx+CuN/hVvEp3urWLS+rlQr7gxT
         tgA6UQdQ9Q8D1gqBDoqJIIn8Ap973aJE1yc0Y5XBKVtkcoCSUfWRgfJXFZ69dFQGraEy
         CCMLWaUCUqyPoK9ugh2IMPSAghG8FdeGa96tB4JdpTowvLCXhcdVvZjsaQjRwfRVY9yk
         byE2GpRDTfZo+Egl1gzaGsKhZJFEMub7f/a7vqIG7KuvUZPmBMe1O4H7dj6+fUOHDhIM
         V13yKdbquEv9ROlNZ3JnKccTW3aT5Q+KLWlOb1xCYzUx/FoX4+ntD2qDStCgf8xn0g/l
         V6oA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fIcYR/+I;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fIcYR/+I;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Deepak Rawat <drawat@vmware.com>,
	Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.16 32/52] drm/vmwgfx: Fix a buffer object leak
Date: Tue,  8 May 2018 10:10:30 +0200
Message-Id: <20180508073932.557428118@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882831936000482?=
X-GMAIL-MSGID: =?utf-8?q?1599882831936000482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 13f149d47392782baafd96d54d4e65f3b5ca342f upstream.

A buffer object leak was introduced when fixing a premature buffer
object release. Fix this.

Cc: <stable@vger.kernel.org>
Fixes: 73a88250b709 ("Fix a destoy-while-held mutex problem.")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2598,6 +2598,7 @@ void vmw_kms_helper_resource_finish(stru
 		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, ctx->buf,
 					     out_fence, NULL);
 
+	vmw_dmabuf_unreference(&ctx->buf);
 	vmw_resource_unreserve(res, false, NULL, 0);
 	mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 }
